Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515D1C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9BA380FF2;
	Fri, 28 Feb 2025 11:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nTI/3qdx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C7580FF0; Fri, 28 Feb 2025 11:54:37 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81DE6807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRXhDJ0BfunihwWfRr9hd4Y2ex9u/tXSGkkbHDERDthVZTM4oQURwbCVTKbboy1UurPazshebBDNcR8ZmeTcOcNezLJLRSju6SkOEZ+5z//kbHrP9Ct2+CytCigY+5H/QkWBDUZwbdZhTtYU/GSfXcEn/5QhmUi60YaibFv+Oljl8bhsVwh1k+ES9fEgc1IIuohenD4QcfFePY+3XQjNyEtiGrmiL14iSg9vvzacotYHKiDaytToarCnd1Q1GnxAhjDCDPQ8wH+556CvW2DxasS/akNF5y4a06QiJ7bH4YkZd7KtAxSrPjea+dzjaLatomDp/fmOgN3ri32acke3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdJwJmXi+W3SRXClag4XMz9FZR1zxabnm2Xle8CaNF4=;
 b=ni5vDz6W5IlBJ5Jx14S0r2Ru0o/3ASH4Mw37fM2FpkXdm4wl8RWOGq82/8x2mOGRIgtfIX7dm/S5A48LHJIXmRVjXlExBCznONZZtQTlxVwNG1Anu2yEwkzgAFTyg4q6nBGE7QrYwjvOUJniLMAYb2A8MRtMXH4JYcdd40pbQK4LZYNOQY0EVPFIqH5iLNdJHl+DJ5HERoYIDHBn+iKcoqSdn7MNUv9sjo6aN3lUH3UvIx7T4WZiD00NdzfR+ASDAlmLtTC2Ihxo784WEP2fwQhglrEanPiEaeHThiHCjLA98OWPXi5Sye04id18w8QfvgAT81u5uo0pKxATrWH9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdJwJmXi+W3SRXClag4XMz9FZR1zxabnm2Xle8CaNF4=;
 b=nTI/3qdx2Rq1elDxW+NjZJBVwFmgcuftzRxXkw7FU/iNetVVlIfmgs8UI/2RHyTsWstYJAI9wXg7swnXzRQohMr8sCpRdMCZ1E3zFz+QXkt6OVvz8xyR/O0Bn2gHOPhI1id1Co+OHBR1Blz3qbOJmO8gns62Frv/qtjl/iLj/N+UJzME20a9EqpC4am4g+83qogg4tAUqupu6Mwk4JYqP01GkWsAD5ACqV0oh5KlcopOlKtqZHnmHHxFInJ5fY9S2WHmgFIs98QRjUZuLwjt75MOKGbinVDmeLzgNiB/CdTbnNmuSmyIZDQViZKjcDRtgrwpO0eNDzlgxpmFBa8OuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7116.eurprd04.prod.outlook.com (2603:10a6:10:127::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 10:54:31 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:54:31 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH v6 00/20] imx: add i.MX95 support
Date: Fri, 28 Feb 2025 18:53:51 +0800
Message-Id: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL+VwWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNz3czcCktTXSPDRGODNNMkQ0tLEyWg2oKi1LTMCrA50UplZkqxtbU
 AjZvWcFsAAAA=
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Teo Hall <teo.hall@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: b58a22dd-7421-4d57-3a13-08dd57e647ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3ZkSk9Lb1ZWQm90enhuUW5WQlhlWXl0MFdtT2gzM3AzN2FEbnZnaGdLUGto?=
 =?utf-8?B?ejN2Z2szNW1waEl6aU1YNGVqWjJzUEZCVjdsZmNNWnBZbjJ3NmdwNk16QktP?=
 =?utf-8?B?U3lrTlg5bW5xRFEwdDU4MG40eW1qdXZlTjlzMktacFlSRk5PbWhIZEdUZkVM?=
 =?utf-8?B?K2JXWS9mMXZNTE1ZeFVzYTBUaExMblI1ajQxSUgwYm9iWDlJN2pMcGhEeXNW?=
 =?utf-8?B?TWd2QS9zR3RsNVNvMHZlNE9keEtleG11YkY1MVdMOVdqM2pWOXFMYU5mZUxI?=
 =?utf-8?B?MFNOc0dIMDNwUjI1ZVZua2ZFdnZQRDRQSUxQMCs4cGVTM3VpRVdqT0FzQzZF?=
 =?utf-8?B?aE9ZRkNvbUJZNG9qUFBGS3dMZC9OT3BPMkdHVFhxeGlXQktYZ0NOVmwwS01B?=
 =?utf-8?B?b1E5dzBCclY5L2JZblZJNTlzQ1hzc0poK2UvZENDN1F5TDd6c1VncnIzUU9G?=
 =?utf-8?B?bXBLeFVIZUhvMXFERzlpMkRWeWQ4cjN1NzUyWStpZUhVNWVaa3BadFJ0dTJr?=
 =?utf-8?B?N3hkLzd6dlZqcFJHK2FhWDZLRDI5NEhhR3hidmhMbTJTbVRjemR2V2kzajdi?=
 =?utf-8?B?R28rQXo3VktkYkF5RmxVQ0VxajlpdWY2ODI0cWJ6Rmp2dFBjWXJGdlJVVXpV?=
 =?utf-8?B?aUFDMTRwMzlwRzVzb3hJUEQrc2dLTDhGK3RMN081WGhXejV6c21BVXBoNDk4?=
 =?utf-8?B?ajhFdFdMTU9OVjhHQ2Fac1BUVERPZTk1bXJDd2dWWmViMWdXMXB0RTByeGdS?=
 =?utf-8?B?OWJQZHlSMnJnTU1wTksxMlJ5bDJDTmtzaDgxZGtSdEhNd2ZCWlYwbEEyK1Va?=
 =?utf-8?B?dkRPYlZZcUpQSXg0c3VjMUJLQm9ndjJab3N6NUttemZiSlh2ZEVuZ2dCZSta?=
 =?utf-8?B?UVpZd2FJWDhuaW03b2VPWHJqU2tGZVg5YlRpVlhHeUM0SCtZS3V5SkdmM0tE?=
 =?utf-8?B?dW90SDBQUEJoSDlPUEk1aWZDQTYzbEY0WUhod2c1ZVVrdFhTQzkzQXdhQW4z?=
 =?utf-8?B?WHdVa3F0amF5a3B2OWZ3MzRGQSt1TEV4WnZiMWxkZ0IwWTRSNVJTL05vSFFW?=
 =?utf-8?B?QzZ6MTdNSU1LbkEvTHl4Z1grdnVNRS81U0dlRm5hZzEwL0VLK3VLakFTb0Zh?=
 =?utf-8?B?b0ZETTRnNzZybzBnMExLLzVtaVJDQ3F1LzkzYkdxTXEyWFVia05INDBHL1JG?=
 =?utf-8?B?alVSTDRGZ3d2MFR2ODBCRlY4RGU2RW5ZbS9wRWhhb1Z2QTUyd0tsdXVWS3do?=
 =?utf-8?B?Vm9WNFNXRUJlc0tNMHZYRG5na254WkJidUwxdktWT3hvemtXeUZhK0lKN0FI?=
 =?utf-8?B?YXBoMjNYeGtlVytkMmNFOXR1MGp1WFNjWDF3UEsxK0FaVWYzOW1iSDR0Nk5J?=
 =?utf-8?B?L09TZHdISEVXR1g4UnFrTllpUHdDZzZuV3o2RGo2Rm1wM0FxTS9RcnprTzRr?=
 =?utf-8?B?Y01qNjBnVmYyUlVibWZSbVRVb3JZZU5GK3M1U3VuRDlFVkpwWWFiQmlpelhx?=
 =?utf-8?B?MWNESTkxaVpyK2dYQm1QellCemhtcVptVVlnejhLbWVEM2tNVm5mQ1ZMRGo3?=
 =?utf-8?B?ZWF2UkxUSFZ4eW5FRzNqeW54ODRaUkdhOGlLVmZUQk9lZGgyM2NCdkRCQ2RH?=
 =?utf-8?B?K2ljY3FLRUphV044TUZmenE2dklWclozS0JEVU5nbkkyZWs0QjVTYWFscXRZ?=
 =?utf-8?B?ZjNDVnhTQzBBSFdON0hWTzFsVTVmUEYzU2MxdEc1ejJFSjZUenVES0g4ZjZZ?=
 =?utf-8?B?Q2dwWjh5TGc3dXo2R2tlMDhlaUIvN2ZmN0JnMkFWelZ4RTczMm5Fc0pVdGp4?=
 =?utf-8?B?M1QxL1FSTDhEVEY1SGJiejBiY3lwMjVwNDU4QTRPdUgyMzJsSENkclhXVjBR?=
 =?utf-8?B?ei9vM2p6WTQ2Z3A5SlFmcmt6Nm1uZnpuTjBUVGxMb0VXQ1VoNlhSUTdOTmU3?=
 =?utf-8?B?YWFxUG84L2dPUGJlQ245ME1UNXRpWFBLNitKZEpCZjNROUdjdFRPUmI2Rm5C?=
 =?utf-8?B?UDhEaUxSVXdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3lyT2M4emFoajZMTk1tQ2tCeUIwZnFaOVNTak9nR2cvcWNpeDl1M3BtY3ZP?=
 =?utf-8?B?Z1NQZ3Z3YjBFaEVnVjk5SVgzZjJLQTlERzlNYmJlWE1Ib2ZyMWZ6bURlUjVG?=
 =?utf-8?B?akFrTGsxYVdjTXg4S1JFeUg1MzAwU2lEOHU0Ull6LzJmUE5aREFxclFtQlB2?=
 =?utf-8?B?bWttSDA4VEc0Zm1obnQ3eDdncTNhMUpsdDZQZC9KQXkyOTAvM1NlTXVTdGNo?=
 =?utf-8?B?VEVjTEx4c1JIQXQ3SlFHcTlmSFBsbDY1RXlIYlM0YThyS3NYZyszQnFTSlFM?=
 =?utf-8?B?MG92bWsxcElNeFZtWTNLZ1liRU43ZjlMZ3RRMS9leEJyQld6eGU4Z2REa2s1?=
 =?utf-8?B?MmNudVAwcVBKcTVHZDdlUlBlM2NJTUtvWHV6K3BKZTA4ODlhaHVpWnZQNXpw?=
 =?utf-8?B?cG0xQmc5TEIwVmxvNHZxdGhldThLdnYrU1NFODJxMndZbnFINVZ2bTNOdUZJ?=
 =?utf-8?B?clVBR2FVOU1nVnZIMjZDVjhxdHJCaXFXdEx0VW00MkpXZWRQcTV0cmZQMlRt?=
 =?utf-8?B?cVBRSU8rSTNsdHdQcGlNQUgzOVlvZWU1WFlvbDZza1dUNTdkQzNQVlpITG0x?=
 =?utf-8?B?RmpIaWx3b3lHVzVNR2FYeHk5Yi80Rld2RlJyQXN0LytKY0lISEVUQUdJMkpM?=
 =?utf-8?B?RzBOYTBobWNUa3JNMjdoSDNQT2QrWHBXdE9yQTFLTDZ4aEw1ZXByeFBJcHZr?=
 =?utf-8?B?S00vb1N2Y1FBZ0psUW12RWt6MWVneklSVVhNV2RqSG13eGFFQ3k2YmFmTUxX?=
 =?utf-8?B?dTdsYmJNRitGTWxzdnRscXMzZThMUU1FYXRxZnprelhUcCtFU3dhL21JVkRw?=
 =?utf-8?B?MTUvdmtOUE5MWXdsQTlDM1YxR1VuUmhzdDdMQXFzblpyZ28zMzNUeXI5ZkVC?=
 =?utf-8?B?Um41RXpWeURoeEtIbUU0RFR6UE4yNi8vMVYwcjlaSzg5OEFzc2NFMWt0N1U1?=
 =?utf-8?B?V21FTndYWGxKV1RtYllIMXpBS0cycklwWTd1S1FSMmZNaDlndjZOQm43LzZG?=
 =?utf-8?B?Y0gyODYxRnhTUkJHUVA1L1JvUXJCQjgwSURRNHI1azh0ZGVCS21KWXF1SUxW?=
 =?utf-8?B?TCtrVWhmeDV6MmxKc2tSNWM2M3I4dzdPYU12N3dtRlRFSXVnNk5NNW5HWTRC?=
 =?utf-8?B?ek5HRHcyRFpVOUdhN3ZlN2gzSmM5TWVZSEUweHpJRVdWYW9EU0JXOVl5bWVX?=
 =?utf-8?B?NE00cXdvcytiV1NmdTNRQ3JUaWNDMGJ2VXRJczdHUFlUSkZVU3o5QmU4elN3?=
 =?utf-8?B?bGtVYTlwazNOSlpjSThjL0ZaVkQyUHU5RmY0TzRMbWhxUEZjWkdsc0V5L1Mr?=
 =?utf-8?B?eDNCaWV5RmtEbnZudEprRTFmUFB3T3g0QzJEanhJVjhqZm8yYS8ySDJ1aC9W?=
 =?utf-8?B?YU5ERGUrc3JRbjMxR3duOVoxWWwrVTByOFEvYzdHUkE1d2EvcHRER0lEMzdG?=
 =?utf-8?B?RmFhNGtuSXV6WlU4RjdqWjNwOEtCUVJVK1dFeFJiQ09Lek45bTlPYlA5M0hQ?=
 =?utf-8?B?UTE0bjJPd1VOcVV2Zm4zSk5TUjlZbWJkai82Ykx6U1RoK1YwU0hwb0I5V0xO?=
 =?utf-8?B?NC9aS0VKU1VjbHZWNGdtWmFpRE9ZZ2ppeXdTV1MycXMwR1JNNXJ0OEc5Y2s1?=
 =?utf-8?B?TFIzRGtVQjI3a1owckgzbTBnbmpFTlVWQjVCeDAweTZFdS9EWDVGd2RmRmNJ?=
 =?utf-8?B?N1NTM3hSZXpxSlF5OFgyQjk3RE4ycllPcEhabzQzMG5ncmlhbmtIMHNjRVNE?=
 =?utf-8?B?Tk1acktVTlhxR1psTlVNVEpKOXd0MTJEZVNUNmdvbFI5QnQ1QVo0M21qbFBX?=
 =?utf-8?B?WGpNdVdWeThiZS9pQUd2U3VPOGZ4bE9ySWFWbEZoVWxHN1V0c21zWEJWeTVO?=
 =?utf-8?B?cFlrRnlFQ1dCN002VWdobml5dGtXNzZtblFmOElvcjQ1dExFcU5aTjNWa1dt?=
 =?utf-8?B?bG9pZ0dCRy9PckxsSFA0cU5aV1RneHdMRU1CTFVZV1pYWGZ3SFVCbjF0RHpy?=
 =?utf-8?B?Zk9hbW9haitDSWk5MGFZeEJNb1NobVYyam1aYktSdFc0c0FjVHBiTDR5ZXlO?=
 =?utf-8?B?KzhnOWR2SXFveFBpSnQyb0NMNktaUDJVU01DYjdML3lieDNacEUzZFlPZEJV?=
 =?utf-8?Q?s7HQ7ZlP99qVehEgvPh0uqSa6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58a22dd-7421-4d57-3a13-08dd57e647ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:54:31.6242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWjTPniyWskM3fkfH2m6AKM7mQ5qjH/rOe2b3TML9gPUY01I3BSg+mtOW1ugbu2MAms0vNjtG/72C75qrmYrWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7116
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

Changes in v6:
- add BOOTSTD
- add an explanation in the commit log that i.MX specific protoc6:
- remove unused code from etype nxp_header_ddrfw to make code coverage
  100%

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (9):
      pinctrl: nxp: add a pin controller driver based on SCMI pin control protocol
      firmware: scmi: add pin control protocol support to SCMI agent
      clk: scmi: check the clock state/parent/rate control permissions
      sandbox: add SCMI clock control permissions to sandbox
      imx: Kconfig: IMX8_ROMAPI is not configured for i.MX95
      binman: add a new entry type for packing DDR PHY firmware images
      tools: imx8image: add i.MX95 support
      doc: imx: add document for i.MX95 Image Container Format
      Makefile: add some files to CLEAN_FILES

Peng Fan (5):
      mailbox: add i.MX Messaging Unit (MU) driver
      scmi_protocols: add SCMI misc protocol protocol_id and message_id for getting the ROM passover data
      scmi_protocols: add SCMI Performance domain management protocol message IDs
      clk: scmi: add the command CLOCK_PARENT_SET
      imx9: scmi: add i.MX95 SoC and clock related code

Teo Hall (1):
      imx: add V2X container support on i.MX95

Viorel Suman (1):
      firmware: scmi: smt: Interrupt communication enable

Ye Li (4):
      scmi_protocols: update struct scmi_base_discover_list_protocols_out
      spl: imx: use trampoline buffer to load images to secure region
      imx9: add i.MX95 Kconfig and Makefile
      imx95_evk: add i.MX95 19x19 EVK board basic support

 MAINTAINERS                                   |   1 +
 Makefile                                      |   3 +-
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  62 ++
 arch/arm/dts/imx95-u-boot.dtsi                | 157 +++++
 arch/arm/include/asm/arch-imx/cpu.h           |   2 +
 arch/arm/include/asm/arch-imx9/clock.h        |  10 +
 arch/arm/include/asm/arch-imx9/imx-regs.h     |   5 +
 arch/arm/include/asm/arch-imx9/sys_proto.h    |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h     |  39 ++
 arch/arm/mach-imx/Kconfig                     |   2 +-
 arch/arm/mach-imx/image-container.c           |  63 +-
 arch/arm/mach-imx/imx9/Kconfig                |  16 +
 arch/arm/mach-imx/imx9/Makefile               |   9 +-
 arch/arm/mach-imx/imx9/scmi/Makefile          |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c           | 105 ++++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c      | 133 +++++
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +
 arch/arm/mach-imx/imx9/scmi/soc.c             | 806 ++++++++++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h          |   4 +-
 board/freescale/imx95_evk/Kconfig             |  12 +
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 +
 board/freescale/imx95_evk/imx95_19x19_evk.env |  91 +++
 board/freescale/imx95_evk/imx95_evk.c         |  36 ++
 board/freescale/imx95_evk/spl.c               |  72 +++
 common/spl/Kconfig                            |   6 +
 common/spl/spl_imx_container.c                |  41 +-
 configs/imx95_19x19_evk_defconfig             | 152 +++++
 doc/board/nxp/imx95_evk.rst                   | 114 ++++
 doc/board/nxp/index.rst                       |   1 +
 doc/imx/imx95_container.txt                   | 136 +++++
 drivers/clk/clk_scmi.c                        | 190 +++++-
 drivers/firmware/scmi/Kconfig                 |   6 +
 drivers/firmware/scmi/sandbox-scmi_agent.c    |  56 +-
 drivers/firmware/scmi/scmi_agent-uclass.c     |  11 +
 drivers/firmware/scmi/smt.c                   |  13 +
 drivers/mailbox/Kconfig                       |   7 +
 drivers/mailbox/Makefile                      |   1 +
 drivers/mailbox/imx-mailbox.c                 | 430 ++++++++++++++
 drivers/pinctrl/nxp/Kconfig                   |  13 +
 drivers/pinctrl/nxp/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-scmi.c            | 143 +++++
 include/configs/imx95_evk.h                   |  24 +
 include/imx8image.h                           |  19 +-
 include/scmi_agent-uclass.h                   |   2 +
 include/scmi_protocols.h                      | 107 +++-
 tools/binman/entries.rst                      |  10 +
 tools/binman/etype/nxp_header_ddrfw.py        |  29 +
 tools/binman/ftest.py                         |  11 +
 tools/binman/test/346_nxp_ddrfw_imx95.dts     |  24 +
 tools/imx8image.c                             | 143 ++++-
 tools/imx9_image.sh                           |   8 +
 53 files changed, 3311 insertions(+), 64 deletions(-)
---
base-commit: 8dd7186ca7821446c6f46b6cccefab502912f2e0
change-id: 20250227-imx95-21a30f5b1994

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

