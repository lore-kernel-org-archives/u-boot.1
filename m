Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8D7E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805988043F;
	Fri, 20 Dec 2024 03:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lmmQSRlI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4EA280433; Fri, 20 Dec 2024 03:56:08 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F486803E0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkhBhQyIHk9K7eUD1Z4xU9fmt1rTxHa1L9nGU1dQgu25fY76o8X9CwPOQ5+tBrq9Q96+/HsEEYCLb5h7EbwaxT7mM8eRosnmQEZDyD9CQKLnrehc4At0f1FJPzN50HhPnwJvyLtfaSy1aeK9XM5XL7Gn9WojMETMqXsSiTWrYHiBoj+qvsutYrgHO2NwkXo9sbXa+YvIVVL7Mxn8GP7GrCBbkptJs0n336+kdJjLOgF9bpj2PfL2pGIr/64edmFrC6k2Zj6Tsv786GfrKTBsjnR9IYEnnot/D2moZmDkga9jdry/3JWR4c5JquKaaNUbwyxbidmbpSalnM9reRi9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn+2A8A6tSZsxhRB8JhYRxUiKFLr1m4Zq7OjJRZaIuI=;
 b=be3EUtxuwyvdtd7SbtMCgg/QuVGcKq1tnEaZO2gxmaW962xPDsOk4eKYsu6Oui+97jJ1DAhz1jIIx1Z+vjCPGvArcZo/idLQoEfS3vJlFdKk3P8irVoL7EI7FaxH+5G4yep4MXQGjy4k663YvJHnNUDJ+GBo0hPFhte/hN6tZbdPwqpk8ukut/J6XX7m/mWgxXcW5M2Vqe0ZLM10iYEtRnposmgZIBOijqMToIs4YfjfN/gajBQ38oNSrU5AShoY1Cd6nhK2B+aQTIP13rww6gFCiOWAXErSY5SkSVez+f1Yad2zKY+HKn6WGqU4aFrJ91ivEGLciqRJCvGsxR+A2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn+2A8A6tSZsxhRB8JhYRxUiKFLr1m4Zq7OjJRZaIuI=;
 b=lmmQSRlIo5mTa5szd4s4hCqd2alL0a/NXIREF3OCXP0Mg1Yt0ZFhJqzzH7MyouFW88EBr0HlMoREfeoLN4u+NzsJ/qXhFZrtBxTGLDdhBFeRGxxHKOGKjhX8YcxSd8+sDKcW1gxS25ibIht/67qcrmWqX8ygJFRglWh0Uz3pGLWNq057ZOjgukY4fxzJ1zQ8OrXaOgUl0xNNr0A+OsYlPsGf++Rj19SFzIYGCHNRwvolsv8zJ6uOaAHktcotGPlZ/R65B4OVqpPUeqfIfRXif9rxobbVjZjeB89FWSRmQws/hqua7bIk7jYyZHTR4ZxDTqhRDjfo+P6roG+lw7+hHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB7005.eurprd04.prod.outlook.com (2603:10a6:803:136::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 02:56:03 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:56:03 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:13 +0800
Subject: [PATCH v2 15/17] tools: imx8image: add i.MX95 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-15-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=14002;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=xhkblYy1wooA+ZTk6q0mNExXdDeVT6nZqZfDPmvUv0E=;
 b=oRuiD8WJmNxVCMsMb8kj2gtpTBL2gmhYQHtmI0c7uoco6nMkt/nOGFStE3DwelAfVV81UWGCf
 N1RuKs4NxItDbS8XMh2zkGdRwIS3Y2nwYNjW3sUiF+VioZq91NPJBkz
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: ce384831-1a4d-4056-90ae-08dd20a1d77e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkxPZzlpV0p4UXl0cDY0N1JqSjBsVkYzN1lXNVRpMmRYbWJmSUZTRnRCTkNS?=
 =?utf-8?B?NGMwcXNySy80QmdqOCt3dFdtSnQrckFaVHpNV3VabkdyTTNib3ptZ2xrV3RS?=
 =?utf-8?B?eDkwQ0ZBSWREWmV4UmFVUXIya29lOFpRaEtLWEhra1c4NnIvRjZWWXpCa1l1?=
 =?utf-8?B?UEhVUktQNHN1Z2tBR2ZSQ0R5cXNJWG1mczRuSVAxZU5WYjdqa3dYeUJPYUYw?=
 =?utf-8?B?emw0WkgrUUVDaEJ2NEkrUWFZZHJhQkNZYTZaVWkzUFBxNFdYYkRLRTFyWjFq?=
 =?utf-8?B?dFN1YnlCU3ZibFZRQVRzbHJoL3J2eG00ajFxVndoYlFuc1ZRcmkxZGx0NUMy?=
 =?utf-8?B?bG13amRTWElobG5vV3RMdm94ZFZPSmIxRUdyTXNRM0Q2TjlIMlFkSjdUdzBW?=
 =?utf-8?B?cVJWK1J1RW9aaE9lSm01d1A4bWpqSElGZzBZdGF6THhEMFVjd09JUlBHWHBD?=
 =?utf-8?B?aW95WDlsREY2Z3ZYQ0R4VjhtWGFCUjRUdTZYWnJ6aGZ2cmFTMzkrT0N4d2JU?=
 =?utf-8?B?MlZnQmZuZHhRb2x0QkMvY1dhUlZFQ1FxazVRaGVTZXhka3VIVitVdVhlbnJl?=
 =?utf-8?B?OEFkRWg0OUdEbUtybkZIaWd6M25YWCtjakYwcGVkTkVpZ1g2NnlJUTBwRTdh?=
 =?utf-8?B?RzhiVGlxRHdBSEE2RUNMSU1kaDMxQTFTeW8yeTlzazVpSkF6clhudCtkYXJD?=
 =?utf-8?B?dWdNWE1lWWhiYWZGZWZmMytvQXhlTHEvMEpOR1dtcjdHSENtVWFYWk5jQUxh?=
 =?utf-8?B?YmtLaDBZOXpxNWV3WHFHVVpMWjFZSEs0a0pVT2NaVEZ5TzVHVnNUSGtNWCt2?=
 =?utf-8?B?dkhrN0VtS25SSytiOUcvUnFHSlBXSDd6NlVOcWNzcmVPblo4dFBiOS9aYldD?=
 =?utf-8?B?dkRuUFlqbGJmOEoxMDJhTVhlSWx5aDZSSGdSSWxxamVmWktYVlo5WU43Z2xX?=
 =?utf-8?B?SVdsdUJRTThoeHE3YmREWTZsT2czc1g3dXlDWUhrdmN2S1k2TTFKT09TV1Jr?=
 =?utf-8?B?dDkzOWswQm1wNmVXdGJOSk9sL1VUQ2lPMEU5cUFRUGdRTUtYOURRWUFBaElK?=
 =?utf-8?B?NS9lc29Mc0FkajJubUVVdVgrakQvN3AwMnVZRnhDK2EvUGNBdkZsQ1VVNHRP?=
 =?utf-8?B?Q1BHN1JuaG5NU1QwWm5FVnhidldydTQxL0ZxVllydFdhVldkTk1yYmpZb3lO?=
 =?utf-8?B?WGx1aUJtdUd5K2Q5WFp6ZmptdTBnVG9qUGtQd2cyUnVnTlJ4am8xWW5lVm90?=
 =?utf-8?B?RHlUNHlWMmNteXRScjZraXE1TlpOY3pZbVFEQjRrS1RIZUN1YnBoWFhJT2tL?=
 =?utf-8?B?R0V1Wi9ZN2E5NmJoSUw5R3Bxayt4SUt0czlucEZHZHlwdmtCSjRVYmZaaTdl?=
 =?utf-8?B?TFF4RmRCcVB5Q2FDb2hHZ21XM2thV2hKMDZyT0xQaWtnVW1OTjZzci9KM3d2?=
 =?utf-8?B?L1FXY1htclJhN1VydFYxWVNOVUdacWZCWFpWN0UwR2ExdlJrU1lUeDlwRHhC?=
 =?utf-8?B?c3k2cmpUajgvTVRJcHloNlFXb2ZEb3c4M2w2MnRhdVFpdTJtcUs5b1dtQ24v?=
 =?utf-8?B?QXVUMXBvejVOdlFmWXZ6OFFmZ0k0L1ZVdHlRTFVqanl2bzJLbmI5YTJSWDZv?=
 =?utf-8?B?aTd2anJWblpjL1NVK1E3S2pLRTh3RzRjY1VnNFR4bzNwZVVsYlNCWWJ2UW9I?=
 =?utf-8?B?R2NLRHUxVldET2FvUkExMlRXTE5iSkhpNlNZMzVaNlM1ajZSQnhrMmNHc25r?=
 =?utf-8?B?WjBvZ1FpNFZjRkx3VlIyUDNtOWE1VVIrMVhJa2x1RmpWRnh1OFdoYUNnZndV?=
 =?utf-8?B?SFhhbVlDdHZyamQ5TEVIM284TEkybzVyWGRRbVFxNEZzSEc5K3p0bGZYWE5C?=
 =?utf-8?B?MTlGQ0pNWVZhOEU5UkFQcGgyYXprZUozQ3ZnbzIwZitsVU44WnduMFl2a0dn?=
 =?utf-8?Q?EB+ZLW4fMX+R9vfe9AKgkcHjgaAwjGIM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG05emRKazlyUUprcUpSbllRU3o0WnFyeU8zZ0I0QjlxWEdjN2h0MndidDZD?=
 =?utf-8?B?am9YZldwNmNOdkxjUDJjVEh6V1dzWmo4QzJUV3hDWi9qOUtFU1N6OVVFSDBI?=
 =?utf-8?B?RjRnQ0JtTTNJRU1vSlVqV2ZVMVhaTktpazV4WkhQU0FPa0hiREo0M1ZicDdV?=
 =?utf-8?B?QmlaZ2dLWTFKTE5kcXNhWk83blVlTkkxeXFmZmJzRUI1am1HZVhyVGY1eFp4?=
 =?utf-8?B?REZrYVJaaDlqUUFBVVRFYTlYdzk4MWdreUM2L3BOQldqSXlrenNwNDRwU0FD?=
 =?utf-8?B?RCsvNmhkQ2JWOW91d3l1QmVDZmpERHpXL3pIY0t0VERLdmtGdTNDZm01a1R2?=
 =?utf-8?B?bHgzR0lndWJpaHBWbXZ3U2ptWUNoVXVyNlZiL2daaDVLaS9zTWtKMC9HZW84?=
 =?utf-8?B?ZC93cmN6dVFJWnZNRDRiSHBWUnhwYXlZY2lJM00rRlppM05Pdm9aYmJHVWFW?=
 =?utf-8?B?a2VXbEJPSGJhWlUrRU50SGpkVFNjRHNBc2xqMi9zQ1lLU2FEclRHZ0ZHeVdZ?=
 =?utf-8?B?NEhvZDhPZ0FQWHV3b3RqcWFoZDd4QXp4bEhXVjlDZlJadUE2MnU1S0RTekZM?=
 =?utf-8?B?SVRLVlBsSllDVG90cXlVMFVJUGcvd2oyNTJBb3FGT0xMUm1HZk9pa3U1S3E5?=
 =?utf-8?B?Sk5tRCtMUFhDUERjbGJETzhlM2Vodjc1TnBzU3VIc3FrcUR0QjZoeUpGenkv?=
 =?utf-8?B?MzNYTjRsOTdXZHNLSDNXTG9aclZ6L2VwbnJZeFRwaWN1a1BzNGVILzRjNFVU?=
 =?utf-8?B?UGZQUk52a0dlYWZEWkw3WkdnUjNyZFJQWlYrdXhES0VEc0dIVEpzSkF1My9E?=
 =?utf-8?B?bVJZWDNzZkRkQTNSdDRuVjFYMkpTMitZMTdaaDdWYU9lV1c3LzYxbXNNSXho?=
 =?utf-8?B?eG94L1ZRZ3hsQ3dsajVvNG1DWHo2eTl5UDIrRmtkMU85dDJGRkx1TnhPTU5G?=
 =?utf-8?B?QVpybTlLeDFjNXNqOVdRSVFQSFZIbjUzNHhjV1pJRjBRMDdRVC84RVFkYUNR?=
 =?utf-8?B?alZTNy9yMDc2U3pid1E2N0swVmdxQXdzRFJHR1B3dW5XRmtPZXMxdXRNZ1d5?=
 =?utf-8?B?VFdEUVAxMWQ4YjkraC9WUlZEMUFYM3NTai9JZDA5Q0V0WjY0cXg0MDI0U1V1?=
 =?utf-8?B?SnJhOXkvVjFBWHVsN3U0Vnl1KzA1MWhmM3NwQjE2N0crU2UvZ2NFWS9jbXlD?=
 =?utf-8?B?ZzFLOXJPdVhDUjhUYkJnL1ZTRVRzeFdwNTJvL2NBc1lMOURHei9UTy9ZYnF2?=
 =?utf-8?B?TGVSWEx2a0FtNGR5emIrZVU1MXdVSU0weGJrelFSMVcwNndZTUc1S2I0VUo2?=
 =?utf-8?B?N2dzRWNJcmtaaXM1ODI0bGlIWVNBL2F5V1JaeVNxSkpsWWJmWG1UbktCcDQ2?=
 =?utf-8?B?eFlpOWZzLzFnWHJrR3lzWldPeXVkRURGSnZKM1FHMnMwckZmTGFDNWp4M29P?=
 =?utf-8?B?SS9nU2dEejJtdUp3OThUZ2ZDdU04aWpNbDRibTJscy80enJMUk9LQzNqT0dN?=
 =?utf-8?B?ek40enlMRUY2bEFwQlQ2ckpYcUJ2Y0NjOXRIaVZxck5xZGxDNFhtNi9mbmxm?=
 =?utf-8?B?RDhXUWNwdXY0VHA4NEM1SCs4NzRuOWw5R1pYdFYvVjUxdzc3WXZjaHhPKzhZ?=
 =?utf-8?B?dHJBWWx1dFdKUGp1alA3Tzd3cEd5ZlRzZC9yaTg4OVN5NEZRWEoydGNTUFA1?=
 =?utf-8?B?bVVvUkpBbGl3ZmlsWnVkcmlXWlZVUTdUYWl5elJaTDdwNkN5QVErTjhsVDhD?=
 =?utf-8?B?V3pXZWxYbGlDNFU4bEtDSDdITUs4a3YvNXdBUEoxajVLbzdmVU4yc0RnS01M?=
 =?utf-8?B?WkV4c1hHTExIWnF4UTBiNFFvK21RTWhUNFdaUHJUc2JpT2F5aVczN1BSU3Fi?=
 =?utf-8?B?OWZFVEZuaWw5MjJROEpqdFpaVE9yUUdVZFZucGxwZlNMWkk3bi9WMHJGTXU3?=
 =?utf-8?B?SWJzQW1QMGpDd0l1N3Rwd1dONlRTRzhQL0ZxdjFtckZCaHM1UHppd21CWTBn?=
 =?utf-8?B?dkMwT09LeDJaMlI0aDdRRXJXVEVFMVRLVW44bTZHVGVuR2ZXeitneE9pYzVJ?=
 =?utf-8?B?cFlyUU9oYyt6cFUrbWtWaGdZdksxVGpwY2xKY1k5YmZZTExPYkEwMVJYbzJX?=
 =?utf-8?Q?zrzHWr4DkQoeT8xp24YiK367h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce384831-1a4d-4056-90ae-08dd20a1d77e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:56:03.4826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+lcVNmDmpf+i3YJ5828N6CrCvoNUMmdKNBmodjP+ADyOpHjNadjBwnI0ONfkhEGvPgaa3xdH5qOT0m42MKd7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7005
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Alice Guo <alice.guo@nxp.com>

i.MX95 uses binman to invoke mkimage to create image container. 2 image
containers are needed currently. The first one is composed of
ahab-container.img, LPDDR firmware images, OEI images, System Manager
image and u-boot-spl.bin. The second one is comsisted of ARM Trusted
firmware and u-boot.bin.

Because DDR OEI image and LPDDR firmware images have to be packaged
together and named as m33-oei-ddrfw.bin, so imx9_image.sh does not check
if m33-oei-ddrfw.bin exists.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/imx8image.h |  19 +++++--
 tools/imx8image.c   | 143 +++++++++++++++++++++++++++++++++++++++++++++++-----
 tools/imx9_image.sh |   4 ++
 3 files changed, 149 insertions(+), 17 deletions(-)

diff --git a/include/imx8image.h b/include/imx8image.h
index 6b95e93fb50980f9e86099b3103142dcbe38764a..233c28aa501f1e78c4160bdf5ca69d2b474217ea 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -157,7 +157,9 @@ enum imx8image_cmd {
 	CMD_SOC_TYPE,
 	CMD_CONTAINER,
 	CMD_IMAGE,
-	CMD_DATA
+	CMD_DATA,
+	CMD_DUMMY_V2X,
+	CMD_HOLD
 };
 
 enum imx8image_core_type {
@@ -169,7 +171,9 @@ enum imx8image_core_type {
 	CFG_A35,
 	CFG_A55,
 	CFG_A53,
-	CFG_A72
+	CFG_A72,
+	CFG_M33,
+	CFG_OEI
 };
 
 enum imx8image_fld_types {
@@ -208,7 +212,10 @@ typedef enum option_type {
 	FILEOFF,
 	MSG_BLOCK,
 	SENTINEL,
-	UPOWER
+	UPOWER,
+	OEI,
+	DUMMY_V2X,
+	HOLD
 } option_type_t;
 
 typedef struct {
@@ -227,12 +234,16 @@ typedef struct {
 #define CORE_CA35       4
 #define CORE_CA72       5
 #define CORE_SECO       6
+#define CORE_M33        7
 
 #define CORE_ULP_CM33		0x1
 #define CORE_ULP_CA35		0x2
 #define CORE_ULP_UPOWER 	0x4
 #define CORE_ULP_SENTINEL 	0x6
 
+#define CORE_IMX95_M33P        0U
+#define CORE_IMX95_A55C0       2U
+
 #define SC_R_OTP	357U
 #define SC_R_DEBUG	354U
 #define SC_R_ROM_0	236U
@@ -246,10 +257,12 @@ typedef struct {
 #define IMG_TYPE_EXEC    0x03   /* Executable image type */
 #define IMG_TYPE_DATA    0x04   /* Data image type */
 #define IMG_TYPE_DCD_DDR 0x05   /* DCD/DDR image type */
+#define IMG_TYPE_OEI     0x05   /* Optional Executable image type */
 #define IMG_TYPE_SECO    0x06   /* SECO image type */
 #define IMG_TYPE_SENTINEL 0x06	/* SENTINEL image type */
 #define IMG_TYPE_PROV    0x07   /* Provisioning image type */
 #define IMG_TYPE_DEK     0x08   /* DEK validation type */
+#define IMG_TYPE_V2X_DUMMY 0x0E /* V2X Dummy image */
 
 #define IMG_TYPE_SHIFT   0
 #define IMG_TYPE_MASK    0x1f
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 15510d3e712495c3508e130fcb2b4df42b07136b..9c4b43174558ec669f9a196c08756bcc6522b752 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -7,6 +7,7 @@
 
 #include "imx8image.h"
 #include <image.h>
+#include <linux/sizes.h>
 
 static int p_idx;
 static int sector_size;
@@ -54,6 +55,8 @@ static table_entry_t imx8image_cmds[] = {
 	{CMD_CONTAINER,         "CONTAINER",            "new container",      },
 	{CMD_IMAGE,             "IMAGE",                "new image",          },
 	{CMD_DATA,              "DATA",                 "new data",           },
+	{CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",                },
+	{CMD_HOLD,              "HOLD",                 "hold",               },
 	{-1,                    "",                     "",	              },
 };
 
@@ -66,6 +69,8 @@ static table_entry_t imx8image_core_entries[] = {
 	{CFG_A55,	"A55",			"A55 core",	},
 	{CFG_A53,	"A53",			"A53 core",	},
 	{CFG_A72,	"A72",			"A72 core",	},
+	{CFG_OEI,	"OEI",			"OEI", },
+	{CFG_M33,	"M33",			"M33 core", },
 	{-1,		"",			"",		},
 };
 
@@ -144,6 +149,14 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 			exit(EXIT_FAILURE);
 		}
 		break;
+	case CMD_DUMMY_V2X:
+		param_stack[p_idx].option = DUMMY_V2X;
+		param_stack[p_idx++].entry = (uint32_t)strtoll(token, NULL, 0);
+		break;
+	case CMD_HOLD:
+		param_stack[p_idx].option = HOLD;
+		param_stack[p_idx].entry = (uint32_t)strtoll(token, NULL, 0);
+		param_stack[p_idx++].filename = NULL;
 	default:
 		break;
 	}
@@ -221,6 +234,16 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 				(*cmd == CMD_DATA) ? DATA : AP;
 			param_stack[p_idx].filename = token;
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].option = OEI;
+			param_stack[p_idx].filename = token;
+			param_stack[p_idx].ext = CORE_CM4_0;
+			break;
+		case CFG_M33:
+			param_stack[p_idx].option = M40;
+			param_stack[p_idx].ext = 0;
+			param_stack[p_idx].filename = token;
+			break;
 		}
 		break;
 	case CFG_LOAD_ADDR:
@@ -238,9 +261,15 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 		case CFG_A53:
 		case CFG_A55:
 		case CFG_A72:
+		case CFG_M33:
 			param_stack[p_idx++].entry =
 				(uint32_t)strtoll(token, NULL, 0);
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].dst = (uint32_t)strtoll(token, NULL, 0);
+			param_stack[p_idx].entry = param_stack[p_idx].dst + 1;
+			p_idx++;
+			break;
 		}
 	default:
 		break;
@@ -548,6 +577,7 @@ static void set_image_array_entry(flash_header_v3_t *container,
 				  char *tmp_filename, bool dcd_skip)
 {
 	uint64_t entry = image_stack->entry;
+	uint64_t dst = image_stack->dst;
 	uint64_t core = image_stack->ext;
 	uint32_t meta;
 	char *tmp_name = "";
@@ -557,7 +587,9 @@ static void set_image_array_entry(flash_header_v3_t *container,
 	img->offset = offset;  /* Is re-adjusted later */
 	img->size = size;
 
-	set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	if (type != DUMMY_V2X) {
+		set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	}
 
 	switch (type) {
 	case SECO:
@@ -579,6 +611,27 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->dst = 0xe4000000; /* S400 IRAM base */
 		img->entry = 0xe4000000;
 		break;
+	case OEI:
+		if (soc != IMX9) {
+			fprintf(stderr, "Error: invalid core id: %" PRIi64 "\n", core);
+			exit(EXIT_FAILURE);
+		}
+
+		img->hab_flags |= IMG_TYPE_OEI;
+		if (core == CORE_CM4_0) {
+			img->hab_flags |= CORE_ULP_CM33 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_M33P;
+
+		} else {
+			img->hab_flags |= CORE_ULP_CA35 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_A55C0;
+		}
+		tmp_name = "OEI";
+		img->dst = (dst ? dst : entry);
+		img->entry = entry;
+		img->meta = meta;
+		custom_partition = 0;
+		break;
 	case AP:
 		if (soc == QX && core == CORE_CA35) {
 			meta = IMAGE_A35_DEFAULT_META(custom_partition);
@@ -586,8 +639,10 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			meta = IMAGE_A53_DEFAULT_META(custom_partition);
 		} else if (soc == QM && core == CORE_CA72) {
 			meta = IMAGE_A72_DEFAULT_META(custom_partition);
-		} else if (((soc == ULP) || (soc == IMX9)) && core == CORE_CA35) {
+		} else if ((soc == ULP) && core == CORE_CA35) {
 			meta = 0;
+		} else if ((soc == IMX9) && core == CORE_CA35) {
+			meta = CORE_IMX95_A55C0;
 		} else {
 			fprintf(stderr,
 				"Error: invalid AP core id: %" PRIu64 "\n",
@@ -686,6 +741,15 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			img->entry = 0x28300200;
 		}
 		break;
+	case DUMMY_V2X:
+		img->hab_flags |= IMG_TYPE_V2X_DUMMY;
+		img->hab_flags |= CORE_SC << BOOT_IMG_FLAGS_CORE_SHIFT;
+		tmp_name = "V2X Dummy";
+		set_image_hash(img, "/dev/null", IMAGE_HASH_ALGO_DEFAULT);
+		img->dst = entry;
+		img->entry = entry;
+		img->size = 0; /* dummy image has no size */
+		break;
 	default:
 		fprintf(stderr, "unrecognized image type (%d)\n", type);
 		exit(EXIT_FAILURE);
@@ -708,15 +772,26 @@ void set_container(flash_header_v3_t *container,  uint16_t sw_version,
 	fprintf(stdout, "container flags: 0x%x\n", container->flags);
 }
 
-static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
+static int get_container_image_start_pos(image_t *image_stack, uint32_t align, uint32_t *v2x)
 {
 	image_t *img_sp = image_stack;
 	/*8K total container header*/
 	int file_off = CONTAINER_IMAGE_ARRAY_START_OFFSET;
 	FILE *fd = NULL;
-	flash_header_v3_t header;
+	flash_header_v3_t *header;
+	flash_header_v3_t *header2;
+	void *p;
 	int ret;
 
+	p = calloc(1, SZ_4K);
+	if (!p) {
+		fprintf(stderr, "Fail to alloc 4K memory\n");
+		exit(EXIT_FAILURE);
+	}
+
+	header = p;
+	header2 = p + FIRST_CONTAINER_HEADER_LENGTH;
+
 	while (img_sp->option != NO_IMG) {
 		if (img_sp->option == APPEND) {
 			fd = fopen(img_sp->filename, "r");
@@ -725,7 +800,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 				exit(EXIT_FAILURE);
 			}
 
-			ret = fread(&header, sizeof(header), 1, fd);
+			ret = fread(header, SZ_4K, 1, fd);
 			if (ret != 1) {
 				printf("Failure Read header %d\n", ret);
 				exit(EXIT_FAILURE);
@@ -733,19 +808,27 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 
 			fclose(fd);
 
-			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
+			if (header->tag != IVT_HEADER_TAG_B0) {
+				fprintf(stderr, "header tag mismatched \n");
 				exit(EXIT_FAILURE);
 			} else {
-				file_off +=
-					header.img[header.num_images - 1].size;
-				file_off = ALIGN(file_off, align);
+				if (header2->tag != IVT_HEADER_TAG_B0) {
+					file_off += header->img[header->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+				} else {
+					file_off = header2->img[header2->num_images - 1].offset + FIRST_CONTAINER_HEADER_LENGTH;
+					file_off += header2->img[header2->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+					fprintf(stderr, "Has 2nd container %x\n", file_off);
+					*v2x = true;
+				}
 			}
 		}
 
 		img_sp++;
 	}
 
+	free(p);
 	return file_off;
 }
 
@@ -837,6 +920,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	char *tmp_filename = NULL;
 	uint32_t size = 0;
 	uint32_t file_padding = 0;
+	uint32_t v2x = false;
 	int ret;
 
 	int container = -1;
@@ -860,7 +944,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	set_imx_hdr_v3(&imx_header, 0);
 	set_imx_hdr_v3(&imx_header, 1);
 
-	file_off = get_container_image_start_pos(image_stack, sector_size);
+	file_off = get_container_image_start_pos(image_stack, sector_size, &v2x);
 	fprintf(stdout, "container image offset (aligned):%x\n", file_off);
 
 	/* step through image stack and generate the header */
@@ -869,6 +953,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	/* stop once we reach null terminator */
 	while (img_sp->option != NO_IMG) {
 		switch (img_sp->option) {
+		case OEI:
 		case AP:
 		case M40:
 		case M41:
@@ -891,6 +976,30 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 			file_off += ALIGN(sbuf.st_size, sector_size);
 			break;
 
+		case DUMMY_V2X:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			tmp_filename = "dummy";
+			set_image_array_entry(&imx_header.fhdr[container],
+						soc,
+						img_sp,
+						file_off,
+						0,
+						tmp_filename,
+						dcd_skip);
+			img_sp->src = file_off;
+			break;
+
+		case HOLD:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			file_off += ALIGN(img_sp->entry, sector_size);
+			break;
+
 		case SECO:
 		case SENTINEL:
 			if (container < 0) {
@@ -962,11 +1071,15 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	do {
 		if (img_sp->option == APPEND) {
 			copy_file(ofd, img_sp->filename, 0, 0);
-			file_padding += FIRST_CONTAINER_HEADER_LENGTH;
+			if (v2x)
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH * 2;
+			else
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH;
 		}
 		img_sp++;
 	} while (img_sp->option != NO_IMG);
 
+	fprintf(stderr, "%s: %x %d\n", __func__, file_padding, v2x);
 	/* Add padding or skip appended container */
 	ret = lseek(ofd, file_padding, SEEK_SET);
 	if (ret < 0) {
@@ -979,6 +1092,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		/* Note: Image offset are not contained in the image */
 		tmp = flatten_container_header(&imx_header, container + 1,
 					       &size, file_padding);
+		fprintf(stderr, "error writing image hdr %x\n", size);
 		/* Write image header */
 		if (write(ofd, tmp, size) != size) {
 			fprintf(stderr, "error writing image hdr\n");
@@ -999,7 +1113,8 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		    img_sp->option == AP || img_sp->option == DATA ||
 		    img_sp->option == SCD || img_sp->option == SCFW ||
 		    img_sp->option == SECO || img_sp->option == MSG_BLOCK ||
-		    img_sp->option == UPOWER || img_sp->option == SENTINEL) {
+		    img_sp->option == UPOWER || img_sp->option == SENTINEL ||
+		    img_sp->option == OEI) {
 			copy_file_aligned(ofd, img_sp->filename, img_sp->src,
 					  sector_size);
 		}
@@ -1030,7 +1145,7 @@ int imx8image_copy_image(int outfd, struct image_tool_params *mparams)
 	fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
 
 	build_container(soc, sector_size, emmc_fastboot,
-			img_sp, dcd_skip, fuse_version, sw_version, outfd);
+			img_sp, false, fuse_version, sw_version, outfd);
 
 	return 0;
 }
diff --git a/tools/imx9_image.sh b/tools/imx9_image.sh
index ca78a57a19a06ade4792da6d2435cbc4fa07de62..76db4e8eff4018ea4eba43477c8122a08bfa92cf 100755
--- a/tools/imx9_image.sh
+++ b/tools/imx9_image.sh
@@ -18,6 +18,10 @@ for f in $blobs; do
 		continue
 	fi
 
+	if [ $f = "m33-oei-ddrfw.bin" ]; then
+		continue
+	fi
+
 	if [ ! -f $tmp ]; then
 		echo "WARNING '$tmp' not found, resulting binary may be not-functional" >&2
 

-- 
2.34.1

