Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D657E64AB5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D6DD89688;
	Tue,  3 Dec 2024 15:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aaQalPU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE1A89671; Tue,  3 Dec 2024 15:38:13 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93FC89688
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWvk/3QUFdJIJa8noM34eUpoGBP0P2b34XDixW5V3jUUsZAUjSMmU02AsE7hxZxVXrZ5d6DJFHpdWM1aQkrAt/LE6Xj4Q1Jz8b41LmT56eeIsg6tnPXW2rr66bbcjvJq/OPhRZGgRerAi/vFihnvkQX39TjlhmAtCQoc+L6RYl/E2JyyeKm3ZKAlvxO9qT0fg+wNxBRLBL1B1R5QhxSAMPrrIgs3QFYD2a4r3eTJ6HQt8R70I50hK4jWtFTizWkLU+FEh4Ko6HYfy0Z8Ij+bqVsz42flLCFqEWlIe2rJwndn8qp0LG97LvMbmQIveirXbNhjfbguXCUKFZyxbbVJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0LP1toHjDVg8bwWgyiVtcLQfjUlB4WxTNKOBou+l8o=;
 b=kYIIhh6U0t1GJW4WzXE1W2AxzbCBVihQAxNO9XvPy4rKlchfXzgJDj2fUcb2w6mjo36bQuz3XnrCCo3tjGeKzLvztkMTayEHNLQqKtZO1ZZ4N15LTULa2x788DMPd/BFmBY3ldC3viOOPsomczaBX2SOapltqNh3Hd3nEflXPjiq5CCEfep4aTikqH470iw/gqEpK7AqChm54bW3G/AbBEH+Upiw/YjI4uib0HK1oH1+iO4PstnT3MnlgLoMBKyIj754LW7gn9gLoMA6F2XvNfef3dObAXI+1sBlRrwPmLiOckPq40j8cVKdR7GZ1W6yF/i42AkhQYhK1mHtQnXclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0LP1toHjDVg8bwWgyiVtcLQfjUlB4WxTNKOBou+l8o=;
 b=aaQalPU3IRbv6xU/QvcNQIeZ/jGW7a7TlD/XgGmbeowZ3dcAwLCnmC7iGYKdGu4XUc4oFBWAg582ohJfo1d/NhmoNW3c8Atvzygu3oDX2TgoWUaN6TE4oi9hNUtW4uwZ9QB8+MRNM1GvyftuvjR68FIUGplZSMG37sfRpNURWs4OA0w9pB0J4zE7oMz2CEm6tbgMc5ABlzG3ELqPf1xglN7VB3r5aok7rLOfJiN+Vd1L/hAvdlHZRfcgJFcOnkxMD16K0xnDKzPvXjrx86toK0O+TLGGM2ZZFJb6qgTARwWuWlcpbDt0GsvTXDNrPaxxGemmR77PLqCZ2GJ/J1BUwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8741.eurprd04.prod.outlook.com (2603:10a6:10:2df::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:38:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:38:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Dec 2024 23:42:52 +0800
Subject: [PATCH 09/11] pinctrl: imx93: support i.MX91
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-imx91-v1-9-48d2eaa4519e@nxp.com>
References: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
In-Reply-To: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: JH0PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 079b29a4-5cc7-4eb7-2c17-08dd13a819df
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlA5YkRQMERkSjArUjd3dVR0Vng2cG45S2xMRDJTYUhtaUN5VWFwaFV3aEp3?=
 =?utf-8?B?bVpjQzlrNm9rVWdrWDFLNDhXYVp2NVhuNXhRSFM4TnVZRTRLNjFVVWo4Z3ZF?=
 =?utf-8?B?RHpiQUZyLzB1aEoyYUdDZ3hCZ0c2K1V3TXl0RkIzZzNFVzB4czl6REEvajlV?=
 =?utf-8?B?REdBNWRvMzJoeUtXNy9BaVBxMzMwUEU4QThqVk5KWjg0Y1JmMG92WkRpTlpC?=
 =?utf-8?B?R3R3dVN2eDhSTyt6R1JUYjFLd3AvM0kyK3pRQkNrV1JQQk9SRmxha2pETWJp?=
 =?utf-8?B?bGZjZFNVMXovajA2alRhVG9oWTZGTWVkWGF6UytScUVYcnoxL1hUNVI1N1Fl?=
 =?utf-8?B?dUorR3djY25qdXd3cmlpTmFEVnplUDY5all2d1B2RG0xVWxOc0JkSGRFbFFH?=
 =?utf-8?B?MXQ2Yk5hQWlleGNzOEFodlZRZHVuM2tiVjNJdGhDdUw1QnRlei8rcGdUL1Qy?=
 =?utf-8?B?S0NmVmtabHBjWGx2VkZBZ1F5Wk1TWVBmL0puYjBIRGtwVjZ2blR5K0RWYktX?=
 =?utf-8?B?U2tSdVlFdFI4Mks4VW1VNDYzVFNuR1VIVjJXVDNYekcyNllLRllKZjZ6S3VN?=
 =?utf-8?B?eXU0KzJDc2JnWHU0Qm9nQ1NjS0VxL01lU0JOV2t4Ry92aDBZYmlyNElpTytP?=
 =?utf-8?B?OVFGaC9DYlBMcDh3UjQxSlRnS3RBdWpkalI4R1JMZ0JBSlBaSWxES1lHeFFk?=
 =?utf-8?B?L2lYSk0yMEFwaEFRVDl2SGxSMEFQYkhlMGdKTnZMaEtHdkdCSkp6Ym5JRFI1?=
 =?utf-8?B?TVBvQlVGY3o3cDZBbktGbTk4OVdmR0NDeVRQMlBTTGtJMytzYmFwRVZyeStp?=
 =?utf-8?B?SmYrOVA2UUdoT3Z1L2NVQnNHOHFNNlFQYXZ3TVhBSWNvRFE2bnRXaUVPWTVR?=
 =?utf-8?B?YTdNY1FPeVJkcDVsR05Eb040NGxpbjIxUmZNMjNOeXFEZE91VUNvTmQwWm4v?=
 =?utf-8?B?TWZiL2RyN2FRWEJLZnhBZ3BORVh1NHlrZ3RkK0dHL2xUSTVxdFlCWi9iMHYv?=
 =?utf-8?B?cm02dG8vWUdRb2x4SXMwejB4Qkkrd2JTU01tdm14VmV3ZGhRMkhrVHFwWCs4?=
 =?utf-8?B?WFl5SEVmL3p2dFlXRzhka3V6MWJza3JnWHlXSnZCbW1ETWtGalJmVEFldGVE?=
 =?utf-8?B?NFgwa3FHdER1cm9Uak96bUtPOVQrTTNpTWF6cFJpSERqNElvS2o1TG5DSVov?=
 =?utf-8?B?MjVtMzZLZHNCVEpzenpkL1RTU0VqYjJuTjdzS2tmN3M1amlIT21haGI1aSsx?=
 =?utf-8?B?dGs1VGNEWExQa0tRSTRYMTRxRktDVGxGMGhDT2dQR0w3ZzN5TkdUeG1CajZk?=
 =?utf-8?B?emk1Nm0rS2RiU3hHRWpDUDNrRCs3Mzl4ajUycmdIV3hiZ3l1b0dyTG1mK3k0?=
 =?utf-8?B?SXV5bWM3dTZ2VWhWdnZCUHR3VVdOWDlacUVUTjhVMDh5Mm5LcStHdHZydWlG?=
 =?utf-8?B?NVYxVlUyTzRXR3oyQlljczlWNU8vMzNxOEtqOGdZdGxXK0Q0TUVLTnIzeXBL?=
 =?utf-8?B?cDRvT3RkUFNkaHc2NS9wMFUwdnlwbzA0ekllRGpDMDhIL1VWODdSNkhhNnZx?=
 =?utf-8?B?ZW1oaENYSnFmTEZCaVhuU0RLOUtTcS9lTVduS05QVml4TnRxVUtpTTJJL2k3?=
 =?utf-8?B?VjNVb29sNURHZmtMbHBGNDR3UDBnVFZJUVJCT1lJTWZ2U3NRVzNyb3pwOEl2?=
 =?utf-8?B?ZFhMYkJ2RkVLS2crMEkzREdnZE54U3k1TUNiR3EyZTQ0QWVRMW84eFRURFlT?=
 =?utf-8?B?N0hlZWhIZ2VnWVFwdzVCOWd3L1NTNVpNSDFLYXBLcTg1Ni9YbWxodnVQNHpl?=
 =?utf-8?B?VUIwMUpFZW5rRTlqVzdBVWNWZlhNL2VtVStVQ1Rrd1l0SW40ZDdENUlLY0NB?=
 =?utf-8?B?cDA5RWJvT0ZFcW1na1pkZzN5QWNvaUNHUlVZTXo3Y1loT2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dCtHdWgwdFpaVEQwaUM3M0Q2RUpSNU9OeHYvSmxQcXNXMlN1OFY2azVGb0xP?=
 =?utf-8?B?VXp6QVlHMjdvRi9hQVZQeUhSN0I0RmZUTE9iWHZOVGduK1h4TytJMmE3MS9F?=
 =?utf-8?B?d0ZiZjJHOVNSQlI1Unp3cTNNSXdQZWd6R293OHJPM3MxZldDaUliNjcwMzJ5?=
 =?utf-8?B?d0h2MGZxMGF2cDU3OVBsaDJ5U3dUU2Eyck1WKzBWRHIwbXliaXlXcGFOQ1B6?=
 =?utf-8?B?T1c3UVVRVG12RDVaTTVMekVON0wxNk5tSzdQZlk1QUd6TDV2Y0g5Z3BLei85?=
 =?utf-8?B?WjlTYm9JYUdWN1J2QWdqcERIVG1odG5YcXdVbnhRVW1Da2duZWNhSUwvSFVO?=
 =?utf-8?B?N2s2MFlSaWcyczFXbmJJdDBaU1RVbHQvekh6bG55SWoyelpLYTZ5ZkRCQkV6?=
 =?utf-8?B?eUxmM0FzNllyOUxVenJpY1A3MEhHb1l3NENobUszNnFhM1ErZDMyWTQzcUdK?=
 =?utf-8?B?S2tFbEEzczRpajIzN3p4b0lBdnhFUGtHaWQ5RWF3OFkwVTFFY2djL3dMZzFS?=
 =?utf-8?B?V0ZvQ3lHVk5VUzRLcEZXUjllSHlZMklkemtCb2dBMTZDckg4dFdNZGdKMUZa?=
 =?utf-8?B?ZmlUaVIzbmphZlptaW9vL3VmWUlUeExpMDFVKzlYaEZwblVkU1lNdG5SYldJ?=
 =?utf-8?B?SE5HbTcwYzRnL2ZVa3pqSE91dSttNUY4MityWk94Z1R3SVk5bVhUT1BDTjZa?=
 =?utf-8?B?RUg1ZVdsOVdqaGNONmp0SVk3MlNlak9CSFN6OEpEOUdJdFRVZjRDOGNCQ3Uv?=
 =?utf-8?B?VXRRZDFwUzE5Q0RYZmlwYmRkOFAzSnN5czRHVFI5NHVwdXh2azJHRm9CTzRI?=
 =?utf-8?B?VnVLOTM2M25hL3NrOHR1TEh6N1o1OVkrUkNuZjRqZ1k3TjdyTnBtdzlKbU91?=
 =?utf-8?B?bzBqUGZBbDdaOGlRRFZPODcyWmxvdkwwblhjRjZzZHAzZzhSUVJmdUJHMm1G?=
 =?utf-8?B?VlBJQ1lMN2MxUHJKbmlzU3VvVS9BdCtHRENXU3p4ek1ZNjNBcThuV0lBd0pi?=
 =?utf-8?B?NVBuSi9DbERYSGtZQ1paV2I4bEdJNHNkNll1RkhodndLMXRmeHdCVFRxZndN?=
 =?utf-8?B?bkZmdDNmWXNhUmZaL2g4OUxLQ0hLZC9wbXlMTjZFRXFya0crcm84ZXNHLy9j?=
 =?utf-8?B?L2p3Y2F6TXFSZUdxRTQyUmxRUnREMGp2bkI1QzdnT3ZuelFjTzJXY1JkMGdi?=
 =?utf-8?B?SGJnTU5CdEdYdTR4SVZEL2xKcVhsclhyWndaenNCVjBJUkh1NXhFU1Q5WEJI?=
 =?utf-8?B?ZlhabWd2ZjlBZ1A1ODYwdDdlQ0ZndGNSclRUQ0h0bk9rUGdqZy9wQWpXMlpT?=
 =?utf-8?B?MzNqOXQrQThqN0xIMmczSmFjVlZ2b0JTaFl6OHRUQXhLMElHLzZPVjMzdDFP?=
 =?utf-8?B?TkMwWW1BeGdmYS9ySHViVy9SV2JJY0Z1aHFnZDZEczZqL1dacVR5bXk5VVMy?=
 =?utf-8?B?Z2JUSzladk10UURicUhkRmNYb1QwNEFwQ25PSGZTZEl1SHdlVzdnMjVldGZS?=
 =?utf-8?B?cnl5U05qSFc0U3lDMzBuQWdDZ3QrUTZUV2NqemhaY2tGVGkzNWZSajYxMnhP?=
 =?utf-8?B?YTBlMXpNSkxaWFc5YzhLMGJlbFRYRDJzUVBwMUdTUXpIME9uVTRIWklzOHR5?=
 =?utf-8?B?aFc2cjNmcXY0VTEyVmJwK0w0SXVLNXFvMittOU5ZUW1ZampVcENJQ1JZNG45?=
 =?utf-8?B?OFViS2U2UTBFcGRkWVBST0l2bnk5KzNqSmRlQWhFMzNoTUhpWUhOTEtnRUtQ?=
 =?utf-8?B?bG1Dd1hkcGxJb1JiclNYMzVQaGJTaDd1aW11TDE2aEU1MnRua0RXNGRUVDdy?=
 =?utf-8?B?b1NuRDJ0R1VYV0MzTGJYZjdjTGJ1bXZheEVHNE56VWxrVjdnT0pkWWlWSXhY?=
 =?utf-8?B?MFFQQ3RyOXYyMHRubnUwa0JDK0g0ZG02VVM0Ym11WEk0VDlVL3JtWFhEdnFk?=
 =?utf-8?B?Tm9iSzdsMHV1dXM4RnZBaWdQMU1IcUxQUjdWZ1pubEFWR2laTFhjd0plWjFj?=
 =?utf-8?B?SVREWnJ6alRNZDBjZnU0bHlZZWhjaU5pOWdtMWhjNXRFOE83T2UxSXNWbmh3?=
 =?utf-8?B?TEdQbFZxNDJiWVptSSt5aDhFa3ViVWdnMm9xRU0wVk4vdm4wS0ExeStUSnRG?=
 =?utf-8?Q?OD7RfZyT7Y1XGyUqQ6LHHq1sp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079b29a4-5cc7-4eb7-2c17-08dd13a819df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:38:06.7353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PxyjqGxsd0w6Juj+7kTL4gMkwONjV+DSMZ/PoVKbMm6zX67dPm+sMI/jnaPyg6SS6RLlncUMFA9K0l/wPsX4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8741
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

From: Peng Fan <peng.fan@nxp.com>

Reuse i.MX93 pinctrl driver for i.MX91, because i.MX91 follows same
design as i.MX93 in IOMUXC controller.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx93.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx93.c b/drivers/pinctrl/nxp/pinctrl-imx93.c
index 9a5b9de6d756130b34fee1d5c5b50598851a486a..8d8ffec6d9ad0ffb908b628fc95ca68a372b653a 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx93.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx93.c
@@ -22,6 +22,7 @@ static int imx93_pinctrl_probe(struct udevice *dev)
 
 static const struct udevice_id imx93_pinctrl_match[] = {
 	{ .compatible = "fsl,imx93-iomuxc", .data = (ulong)&imx93_pinctrl_soc_info },
+	{ .compatible = "fsl,imx91-iomuxc", .data = (ulong)&imx93_pinctrl_soc_info },
 	{ /* sentinel */ }
 };
 

-- 
2.35.3

