Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A85C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 773E180FE2;
	Wed,  5 Mar 2025 14:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bIWr7l0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4362D807B1; Wed,  5 Mar 2025 14:29:51 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B445C81658
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWpS+UMyTCU5DYeTB+QvO1FQ96NeudZkQDcAOJwt7i/HjjWEsUWG/qPaSwzD8wiBvZhVgFoSOxLYewB+ToWCdkR/azxMSoV68h1emPg2V5wAHG4WTegF4MqsroGmgG8GVZx5iYkMK0FhsdjMZ6aj8ApedWnIipd3Dj5azP53gFu3QL9vMpmzmXdVGDr1vLC4Aecdu2XBEnKMjd4jLQs29jGqt6v3x/cJ+UGV+NheQWCG+tWSDbum+T38Ve7uVp5fBgaCY2S/mL3DksCDA8e+yZ5Aii8UwL1lUNmVbqGV09dGMViA2dXe6C5p+s+KIP9oNN7US3qLDdW+8p0V6wi2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYqGAftW9Llk2yInfDDJm/PSj2YTwHglkH2DaVfXqLg=;
 b=Qimkwv0HNpFrIJ5yzaxUlfpz5kOhZ+y+nwjQkoaV1M1EK2KD7i6e4efUzt5rEhJLCYLF0sAh8egZan6Z7sMoQdzKjpTwrFTvUHo4CtN8ofQz/Zn+B9vnfn025aDW6SbSgGn7VlUvsmkiPWzFHQe+5nRXT6e5zAreeBguNI2qthb7QUfJQ3EcUmnW60/EdCoqatqFsmZOF6hZ0P3URM9F4tnoeVJg0DsYT/V3Ex0kBKuyVRZk4YRe4iwksAKsDC7KLjl8ACzg5qLlQArR0aeLDFgzpMTbeB+w2GhLi5sZOwFGIw/ExlXiZu67Qsh9n2r/LGa1LQUytI4SC1jjXRui3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYqGAftW9Llk2yInfDDJm/PSj2YTwHglkH2DaVfXqLg=;
 b=bIWr7l0aTOlLbhEHfNLB61X5i3Hn8ZSBCHnQZqLWj+zxuZl5+V8PuIcmzKGvZAaQUVjCMMdHQdL6Wz/x49RagC7LNK/97CV24jt8Scs+hb/Rs6ossUSyhhkVs2+vaH+/4Tx/S4SBLDec3tvRCJINYmJ3oQQRsS9ek2k+hCUwAvOxoE7hJh89gp6l8cOJlvlp5Hov0HgIWg6Lcug72X1o8UyzOfHX6K5z3KG5FD6Uu4bNDwkobxlkdDa+9CqcguxB+uyA/BkXqpcHUuXcFPzARzw4RnEM8j4ZF+dGn6e4mfaZgzRPwCED4fv7l6GpxjaP1MssA/6TrHLUTFVwVeZsKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 13:29:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:29:47 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:24 +0800
Subject: [PATCH v7 12/19] imx9: add i.MX95 Kconfig and Makefile
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-12-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fc4fc3-5549-47e9-403b-08dd5be9cc34
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2ZDSTJqTVRNUmg0ajN2RjZHTnNCSGQxVmQ2UW9jWVFqWlYrVVBlaGlVOEZv?=
 =?utf-8?B?TjFHRWhnYUZjTTFjZGVYMnVIWFp5WUdKL015TU9uN1FheCsyeHFOMWJ5eTlh?=
 =?utf-8?B?a2xIUmFycjN2dmtPeWZaYU5xZEVUZWUxQVl2UmhCV3o2bVRuMlZubnUyR3hk?=
 =?utf-8?B?VW5CWmh6WFpKcDJRVnN4TDlYUVBTYnpIMHMxMnlKRXBtWWZIRU9Cd3J3NWxP?=
 =?utf-8?B?NnhINDhGQ3F0d1VsVDhPVWVxcldRemFFay9wb0dFSUVBcW52SG5xZ2x0dlZu?=
 =?utf-8?B?dzA5eTJJdmNsc1N6V1BOWnFNdS9uTVp2REk5Uy9wNzAyWURNWW1XUXVkQ0sx?=
 =?utf-8?B?b3JhZWdkcmdERkFDM1lyZ2VyWGdXeDh0OERPL29UU1FrR1djNGh3RnlZTDYv?=
 =?utf-8?B?bFlnNDhKeGxLRkNuU0lSeGdmaEVZOUVVZ1RkaGZOZnJHSjdsK29leGxQUUp2?=
 =?utf-8?B?K3djTFJNck1VcWpuSHA5Z3lEN2dSLyttNDA1YnVYVDVhc0JNODd4eDdBM3pT?=
 =?utf-8?B?b2x4Z3JYczM0Z0wyYm9hNkg3V1VHQU8rMmM1VjBIZHo5TnovOS9tUnpWSDZK?=
 =?utf-8?B?UG02UXdPc01oS3VlUXJIQkgzcTcrNnp5U0FBQ25GUUZZNzRiaVNrTHo5S1M4?=
 =?utf-8?B?UGpGTWxvd0dBVURER3NXbDJFK0xCdHNFOTJHSUlZeXQ1RHh0R2RrTHNkSURD?=
 =?utf-8?B?TXZKL3grVDlmTjdmclhNdmc0NFExZzVGTlVsUE5yYmtpOUYvTmh0WEhsQlRv?=
 =?utf-8?B?blpmRXZVcjQ2YmV2S1ByRnZPRHl1WmltSERibWl3YUF6dmJQallFYjYxNkdW?=
 =?utf-8?B?R0I2WVhUK1U3TlpUcjRsV0FGZlNGR2Rka1R6NDAvOXBOQ0FpRHhHVllCNXRx?=
 =?utf-8?B?c1NpOXBja2ROdHBHL1RyWXYzelZKRDVZMXJJbGtUMFQzTHhtVUd2UkcxSFR5?=
 =?utf-8?B?NXZyQ3JtTjcrZWJZYmhiaHNNT3hoemZNenBla1J1M3ZRV054RXJEbXZQTVVH?=
 =?utf-8?B?QytlNUlBaXYwVmUxb2FQUDJFNERZR3E1OTdzcDVJTUJRc3BHM05IMWU1ZHhu?=
 =?utf-8?B?em9rU1p3NGhLb2lWQkY0ektTaTBqRnptd2FFOCtENkNZdHhqSlhIY2lGM1Rh?=
 =?utf-8?B?U1lsYm8vK2llajJsbnQzZW45cUFvMUpQQ0JtcjhKbkhYcytJM2xxR0J6bUlF?=
 =?utf-8?B?dWJzVXZYZmx1a21RYXd6K240d2JoU2Y5eTZ4OU5jVUpyQnVidXlMd2ZqMFd1?=
 =?utf-8?B?WVYxZ2l3M2YvcU5MZEhzQzByREFpZjJVWHFpbC9ZZFRYUnRKWm9HN1dtc3lN?=
 =?utf-8?B?U3paRDliUXVQbGhFMGNVQkwxTS9BdTM3VmY2N3piWHZSMjFYZkxnd2IzcUlp?=
 =?utf-8?B?YzRzNVkvSEt5MHdHd09CUFV1bDloWWVFWk1lUFJTeEtqYkNVRWwrYXdjVm5C?=
 =?utf-8?B?UXpXSGEyWFNiUHdMRlNXWWNKbDlXNHl6WndUL3oyQnc5OU1seVAzNUQ1T3l1?=
 =?utf-8?B?OWwvMFFzby83dCt3ZU5aMmFmQ3ZFVjBEVGxxRzA5d0thSW5GMFpIaEpTU0sv?=
 =?utf-8?B?L3c1cVFQNnhQRElJSFNNand2TG5xZ3NIRk9sbmQzNG5SU1Z6WGxlWHVUYUVw?=
 =?utf-8?B?cGNNTy9ZcCt6SFFxZFBDNEhsY0hiL1cweGZibGlaMmI3QWtDOVRWRnF5REd4?=
 =?utf-8?B?Q0NNYnRTL1RJWjIrczFOUFA5NUNlaTI5eTZXenFqMmpHVXVIZUFMd1I5ckpD?=
 =?utf-8?B?K0hFWlllTWlMSG0zQml1S21SenR6RzkycFIwUXI2dnVnTXJLR2Jqc3JMbW5K?=
 =?utf-8?B?S1piNWZMdzVMT0tOUllodFRST1BiUTMxL2FHZUVHS1l3NGtyZlFWekFxMmF0?=
 =?utf-8?B?SXp1RU9reUNQeE5OZEVJcDl5Tit4MVg0cG9IMVZDbzdFTzRpN0pVMkw0Y1ZT?=
 =?utf-8?B?cmdqQ2VQc05OZit1eGNwTnR4WHRtUUd3YkE2dEw5MjhteXA1Z1N6enk0K1Rq?=
 =?utf-8?B?UWpFYitWZk93PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkxLK1UvNXlRSklhbHR2b0V1ZFl1MTZJdjBMZUJ2ckFMSDUzalh4NW90a0JK?=
 =?utf-8?B?SUxVdm1KdTZOeld6bHFtQ003M1JsZG8xSFZjYTF5N3VGK2owWmdUaEgwenEw?=
 =?utf-8?B?Q1RJRjVKdHNSUnMwM0NJUitFck5WVU1NdzFtakd3V01GaGJ5Rmt4di9xeHlL?=
 =?utf-8?B?UWZMeW9qaG55UGYxb3FBakhuTmRyM3NDbUdmV0c3UTFJZnFPVmt2T0p1STM5?=
 =?utf-8?B?S2ZRcDJZRkVEeHJ6WldMOE5nc0VpUnE5TGNlR0dwU0FuSnpXa3NBN3dPOEJF?=
 =?utf-8?B?NDdTVDlHZzdTOE1zZjBibVJXNWxWSVBFb3hCa0h6SVp1WU51TFV4dmh4TXU1?=
 =?utf-8?B?R29PZU95U3BOZ1QwRW9zaGtTeE8vcVhRNjc2WUpqM0hiVC9GMlgzNUQweEVT?=
 =?utf-8?B?SHZyT3NuRFVsZG1LNHI4eVRtdUtNZmpBcHNSY1JRWUtkTWlWcUJRYk9ib1Rw?=
 =?utf-8?B?OHFJQndWRzJoMjZ2U2NPbkhCZzZaL3V5N1hMQUVCd2VNbXorTmY5Y255bTlo?=
 =?utf-8?B?NTNTTzk1eFQraGxCOExXbWwwbE4ydWlDazkwZjRFVnZBK2ZKSW1SQ3FyWG9m?=
 =?utf-8?B?N0lQUjlRSGpKR2hORjhlQ0ZOQ0FNbHNveWZXUkQra1dWbDhpd0hRaGRXZWVC?=
 =?utf-8?B?T1hMR2RSWjdVOXBkYzd5OTdWeVBiZHNMeElCZ2NQVEJ5bjdUY2pKdE5QR2xw?=
 =?utf-8?B?dHNEb2FEUjhRNFkrd1gxektGN01TdHRjbGI4c1pNZVpUdjZQSUsrcDJPRVZn?=
 =?utf-8?B?aUxjTHNqYWtIWlpTZUIvMFN4QlNab1l3VnJwMHZJR3pLdEVncFhIRnZkZW52?=
 =?utf-8?B?Uk9JZUd2YnRFRU40L3ZuYjB4eTZPQzRPcmtlYm1vVEs2V29LUUVhYUVTdjlM?=
 =?utf-8?B?Yk1YSXNTZ2FsVTFqUWkzZHB2S3VLNzZ4ZThwYUJzRi9sYlNBN05qd1hTbWoz?=
 =?utf-8?B?TUF0TFY0NEY1QTZFeFNDQ1NPdlhVSmlZZGs3bkszcCt0c1lBMnprZk9URHR1?=
 =?utf-8?B?dGtTZXNyc3RjSG5lc25LbDh6QW96dzBwTllzK1J6czlzb2xZb0p0OHE0WmNE?=
 =?utf-8?B?ZlhuUW5YL0U5YmZobytETTBzRjRUbmM4cVdPbFI1UWd3eHZ5V1dmaCticGdp?=
 =?utf-8?B?OFFkS2pUT1d1V0VzOTgzaElFbW85Ym5NYWtGOTR1bmtKaEZVYUlNamo5d2ww?=
 =?utf-8?B?c3RsY3JaYUpVa3oyUmFzUXNyUlpPOFdiNHhxVHh5M1RlWGVwd2pVRWJ2Kzg3?=
 =?utf-8?B?RnhTS0JvUUNqMzhDUXlORkYvZHFHQmdQejcxZ3dMZDRpbFZhcjFHZ20xb3hj?=
 =?utf-8?B?SGR4TStheGN3dFZudG5qSlFEMGN6RTNQVEdCYmpaU2kwdlBXczdiOEdXZEtx?=
 =?utf-8?B?aDlncllHNUZMdVgxS0xGSVhmWGZLQm9YdEhrbjJNaHM0SUc1WWJQM2RkWHVp?=
 =?utf-8?B?d3EzckJMbGpvUm1CRHJjcnNyOGdFZjhPYmtFcWM4Ry9EVjVkMUp3UzVUUXli?=
 =?utf-8?B?OXdIcEhjZTVwWlUrK0UwbUk3R2RIR0xKNGJlOTZpdTVBdVpMSm9mYUhFdG5G?=
 =?utf-8?B?VUNiU1h5UWs0aVQ1cndZbGZuQWVMMjh2YUttejByNThmK2Z6R1c4T2RiRHdR?=
 =?utf-8?B?dS9HdDRubXdyYnQwWjIyakdacjVQWm1FQlRMUXpkM3h1Qk1OTW9RL0x3cDRO?=
 =?utf-8?B?S1Z0TXR6MGFjTnBwY21CcWxqcmhRaEJvZWtycTljd3hsOFRXQ01RZDVycS83?=
 =?utf-8?B?UEJBNG5xL3pjZk1CS3Mza1pJRnVRd1JTRXdIYmQ2MElkdlRyTWsxc1JDTHBx?=
 =?utf-8?B?STBVaWF2TUE0RVE4ejBkNjdpOGRvc1lLcVJFdSs0Y3BPRkxsSThyYU5aT0xr?=
 =?utf-8?B?ZlBXSUs4dEJCUU02QjFiZGRSMU84ZzhnNmJYTjU0NWsxNmxZdXFFU0tPZEFJ?=
 =?utf-8?B?dFFRQ01LNVBPQmM2ZTBqUnljcGpDWU5UazM3ZnlFa0FCT0w2R01qUlM2NjNO?=
 =?utf-8?B?cXJDTjRySW96dkxoSkZPejRNN3hYVzhQZ2dzT2lDK3JPWnhLeVRoRXpmODVD?=
 =?utf-8?B?VW9mQVg5VzljWmhYc0o2eFhyTjBkMEhKNWFRZ01wRllXMnREdHM0Sm9LRitE?=
 =?utf-8?Q?P9iyJiOts4dFQrWdv/bNtjB4G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fc4fc3-5549-47e9-403b-08dd5be9cc34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:29:46.9538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ANgyGxX0p0TSn/FO4mvdvPoX1qCcfHuHXbCeOk2aIa6RARa8CzU89IpXsOpMwT79G2Yya1Tbl5uoWTjbl3nRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037
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

From: Ye Li <ye.li@nxp.com>

This patch adds i.MX95 Kconfig and Makefile. i.MX95 uses SCMI.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig  | 8 ++++++++
 arch/arm/mach-imx/imx9/Makefile | 9 +++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 49220c0955..ef364ca1a2 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -21,6 +21,14 @@ config IMX91
 	select IMX9
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95
+	bool
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select IMX9
+	select DM_MAILBOX
+	select SCMI_FIRMWARE
+	select SCMI_TRANSPORT_SMT_INTR
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 45a9105a75..53cc97c6b4 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -3,8 +3,13 @@
 # Copyright 2022 NXP
 
 obj-y += lowlevel_init.o
+
+ifeq ($(CONFIG_SCMI_FIRMWARE),y)
+obj-y += scmi/
+else
 obj-y += soc.o clock.o clock_root.o trdc.o
+endif
 
-#ifndef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
-#endif
+endif
\ No newline at end of file

-- 
2.43.0

