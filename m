Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8014CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 11:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4214E835D0;
	Tue, 23 Sep 2025 13:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PqrOiUan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4368C833ED; Tue, 23 Sep 2025 13:12:54 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FA65835D0
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 13:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqjHdbCMzU90T8qzZ1DF6rmsCa87/sm6PpuobWi3522OLKnNJSpAGTo9lOv/gUs2g0MqVOYg4ue17AJWh/yMfIZqUQF7M2jIfcKVn4TPtwnurnORW/u2X/CXTPirRqD9BwTmeJ8/nRM/AKREAuKmNSk30yxaHJ6Cz+OUcRTerdKpllF1D1o30CkZlgLviPY6LZTxJZdKa2Ep7WCTpjSfxnLSo4WA1S+zTubJmUyh0IIb2ym1MEulAKTIHoi2ul76HISnzuCSsLai1l7nTj811kT/CNu/7WpUN/m3oK0JSLCdl8tmsagW9KNE99Ko+qPjHcXfNQDDeIPWlUzkclpLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxx/yXgr/0tVLQm/NgNnBZLu1mP6HEkRile7cpPTlxg=;
 b=BpgRJ0A/HBjGUdEicPBeT93PVX45HI7RZLJTw8GHeObmrmQtX2J24a9IPk5RjNRefegzEjirotUtf/auun/5LrASdtVmQtOMYrWfIJesdzXpOnH1AIU6n2vNP5/WXhX7boX0kQHGrggCTIWZPIhR3VPL5CzHMtTkdBuYjf15bYs8SOkX7fpTMXdvtTn0VSoi84MDcdZPpFQ0p48KCUobw9/tm/AIyVxEMHppVyNVzDDyhO1Z8CnYuyu2uBNd6yNbspkdcGF3H6DFI5PwqtvnwK9zRXacOZ3yZFwNVSoe5LSUkJfEXhLGJvo6GxlIUslIR5oYk5jOtczZDknaod+7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxx/yXgr/0tVLQm/NgNnBZLu1mP6HEkRile7cpPTlxg=;
 b=PqrOiUan1Ebv0JJdY7GNe0Go9uZnZmtaHaFpHYD3F/3Y3Fn1NsBGTHOL7kaiqLAwA0dK+JZ33FGNqRNiicJnCJ3xdtCxwJ/634iTCtbE5QDWXVQqDS1o9dhoCGhSmV6BcOuNHHtqTxDIjwSICUvX/MC7BVOYy7kmkZWmld8MKxSms7iJWksH+OK2YB+r5+nrF1oyuTZy1o+W359mL93I/ENyO9ro0dCFsa2uRT0t9VlgKu/apGIhRGFAqQ204p6hVIpaEe9HUzh26jrLR8D7NQu2W+92wZ29p/v0rluBXKst/2IMQ8+eYKd7xpG+wdY15+DUvnn7rfmkgrEQZlzRgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 11:12:49 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 11:12:49 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 19:11:54 +0800
Subject: [PATCH 10/10] imx943_evk: Enable ENETC1 and ENETC2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-usbnetc-v1-10-507cddbe7214@oss.nxp.com>
References: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
In-Reply-To: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: d7dfccf0-bd7a-436d-8353-08ddfa92217b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uytrc1g4SURZdStnSnBSYld6STBUWkk4ZWxOMmdraGdrR1pRWGp5Zk9MUjNk?=
 =?utf-8?B?RHZkaDJSdGZnSGJEN3pjSmZ4aWwvRFlFSDc5T0pQR0J2N1VvUnhldjFmYlZu?=
 =?utf-8?B?U0x6S3lHeVcvaEc0c0tlUnRlUjBXYy92L01hRTdNYldRRUcyTlc0UWFwbExq?=
 =?utf-8?B?S1ZTZ3FWcEVlK29qMmtMNDlXa1B3ODBnNTBDb05ybjkyR05QS2tYVFBBVEJG?=
 =?utf-8?B?eCtyWS93KzB3TnQ4cmxqWGkxeXJkTmJ5Sy9PQTFGNWU3WUVKZ0xvdXVPYmVw?=
 =?utf-8?B?a2FJeVprS1NIc1hPaGpJbG9yM3RqaWxIRWxVTEtwbk1ScUEwc0JuekNpMjJh?=
 =?utf-8?B?QU51Rnp3YXZLU2ttWUpNVFBqdDdEOHFyZFBoaFdYcGVsRDdhTDN4dUlkSzdN?=
 =?utf-8?B?QkM5N2hVSGFReWRrSnJva1dIMlVnaGxFb3FHQWJMOFJsaXdiZW9xbWpEQVpi?=
 =?utf-8?B?RWQrSHB3REVXUWp0Rm9MZDd4U3VRQUVIUEtRTmRrclQ2RGNTeUx3NHhwQzVp?=
 =?utf-8?B?LzNsQmJwTm5icUlzZ0p3alZ1VTJzUkVMN0V0eXdua3pZNHRCdThkNzd6dGht?=
 =?utf-8?B?ZVRpblp3TFc1VkpIdDB6alFmTUh3OWJ6Nm9QZlc3MytOMFFwNjRQVksyc3d6?=
 =?utf-8?B?Q0p3S1l0dEhibHNJVVFHWUlaaHBoZlpRSVhhdm55cVB1WnFaRDNjRHN3amZT?=
 =?utf-8?B?bGEwdlVRRmNGL2hQL1B4ek9OTUwrdlJPOU1Qc0Fyb2dXckFWb2s1SGt0UVFX?=
 =?utf-8?B?SnlndnBSaVRsb2lIZFJCaFB1azFjRXBRb2hlaU5nbTk0MUdTVUwxa3BoR0RI?=
 =?utf-8?B?M1Y0N3d0d0xtOEROcGZEd0p0OHQxbkhHdWFwSndDdHhsdC90L0REMSt3YlpQ?=
 =?utf-8?B?cmJDME9TMitmVXovMDNHT01iV0l1Y2FkL3hrZjRxOFd1QXE1Uk5FZkltazFN?=
 =?utf-8?B?QkdMemJGckVYenA2NmxUak94dFJuOU5hTzBQUEVzNkViUFdJWmJpcjFKRUZ5?=
 =?utf-8?B?Q2pCOXJGaStzR1JpU3BxN01DczM0UkZjT3o4VUNaM2JwUS9yQno0WHBkUTYy?=
 =?utf-8?B?em5ZZHNid3l3RE9RWTlheVlNU2pMTWFMbnRMQklEWVZmbys1U3JkTE5wUFpa?=
 =?utf-8?B?WURpZnEwTEhMY0RIMjdrLzg2NHVkaVZZTWcvckdmMVlHNjBPMXd5NzVMbXQz?=
 =?utf-8?B?N1Y0TDd0Wm5MenJjTnN1ekFqSHc3c2tUYUd3Z2hxRDdzSEtPMElia1V4cFZj?=
 =?utf-8?B?dTNwcWlHMngraXQwNWN4aU1wWU1od3BZVmdXR2IzZkg4SDB1QnJLOTFITW40?=
 =?utf-8?B?dDlwS1VVVUVkRG1IY08ram9QbkovM1JVSnNaVVhTTEdPUzZjbkQ2d29OMGdu?=
 =?utf-8?B?UnhyVVo0YkJoa3hRb1ExUEQvRFN3Vkh0Wm9LL2diYlY0MU1UWjFteVZVaGtr?=
 =?utf-8?B?ZjNkNG1GV3JqdHRGVWN5YXc2ZVd3Y0d6Sno2MHJ5aVlVZHF4QjFuY3JUVjRM?=
 =?utf-8?B?VUtkK2dZT1BIY05yRUxrNXZQaVpIcDhkQkplMjJjRGRvL1JrK0RvaStGNTZM?=
 =?utf-8?B?Vi9MaXBZNktwQVY1NFZpVWpwaWlwZDA0Vno1RkNObjRpZ1FIaDFtSytJcm1E?=
 =?utf-8?B?LzlEKy9WSlcxcVQwd09LeVVZRUF1aHlvRUEwYnVoNDUzVk1kMllNR1ZiVFAr?=
 =?utf-8?B?K0xzYjByYjR1alFXSGtLekxZQkZTRFVvWWVtN3I5bThLY3dpWVJBU0ovWUly?=
 =?utf-8?B?cDREWFZqQkx2dEVOakxpVlBBd0JidXBtc0w1bGUvbFVtSEZTbndxTXQzM2xF?=
 =?utf-8?B?M002M3ErVHZLQTlvSlhXQ2JNS3BsZ2phcm82bXpNNER4bzNoWlFtYmdVcXNQ?=
 =?utf-8?B?MGVjS1A3QXFncUdwcDI1R08zUzZ0QWhTaFZXQnNQVmxsd1pxd2lRck1UcTdY?=
 =?utf-8?B?OEFSNHRqdFU4Y2F2T0dFbUFXbDEwZmtreStwSmdvQWJocHpJWHZyWitURmlJ?=
 =?utf-8?Q?VAfT39JlqHE6JUdN3C4scuhZw6+RAU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU8vdGFudjZYYVVnZC9mN2JxZ3pUU3VrN3hZTENiUGtnRHY3cklFWmdsSkdM?=
 =?utf-8?B?UjQwWnNka3N6V3VBMlhJQ1hSa1JXem5vMFM4U2IrdFQ5RWV6bHhvd0JkenQ4?=
 =?utf-8?B?Zk1RVFY2SWtGU3U5YzZKRmtVQlI5ZkJrV1pCTXAyWHM4VnRwaGZTSkYydkZv?=
 =?utf-8?B?R1dxOWFyUG43RFJ5QTc2L0V2SkJoWDVCS0M0MThWQTdrRkN0dW9VUTdaZ1Bw?=
 =?utf-8?B?SU9lc2JaQVBFL2JxbjM5MDFlVmNwNnFBTnpRcW1RL1J3ZjUyTldQM2ZYc1Q1?=
 =?utf-8?B?ZHJoMmVLNnRNVVRVS1hmSEY5OHBab3lhYkRvZ0tUeW14RUUyZ1BZeVZhb2Vl?=
 =?utf-8?B?aWRBU1lpYVhZYlR0cElna24zTnZ3Z0g2Z1dBU0JpblJ6dUFTQi81ckt4THJy?=
 =?utf-8?B?NlNwQksra3U0a2lZOXJXR0ZySlBJTUZMRG5rY2p4SzZvUW1YZlZhMy9sYytZ?=
 =?utf-8?B?a005dDdTUmxGNktnVUVQcVB6VWV3dXYxR042empVenZoQXgxZFU0TUNVYmZs?=
 =?utf-8?B?c0FzaDBQRVhmbEpQSDdNaWtTa2U5bWdSSy9pZ1p6d2pHcVl3QzR0ZHllTXZZ?=
 =?utf-8?B?cnZmMU5FYUJhaTdubnowU0tOa2dTNjMvK0tEYndONXltWnlhMnVGK2hSR1JC?=
 =?utf-8?B?T1NwbkEyTExoTThXckhtQ0IzalAyelhuclE3dDZWZWk0VHlOOG1jK1pFSkJT?=
 =?utf-8?B?SVpOazN2Q01hNTJFMVJmQTlhZysxVmFEM0hBemVTUnJaTkM0dE9tUE04eC9j?=
 =?utf-8?B?Ris2ZGhlQWlUNlFXcWhDMmwvRG5pR0x5NDBpKzBYY09mTzh2R2JsSzNvVUxj?=
 =?utf-8?B?SVBETVBLc0wxMDZDOG4zVEcrWHVLMjZzdXdXMkl6OWduUFh1bStsbmpGSmFY?=
 =?utf-8?B?dno0eHlEMzVXMGtvWGt2YlpSU21IUGJEL3g5aHdNS2tnY0ZyVi9FYjFWaXZW?=
 =?utf-8?B?cTBHMm1hN2FFcW1RdnFEVDdKOVc1TjhhWVBWVm5td0J0VDA0SkZQdmtWMG9L?=
 =?utf-8?B?L0ZOc0hJOGI0TE54UU1NVE9uRUU3bmxxY1V5ZXR6TXhXUis0OTFvYnBEZFcz?=
 =?utf-8?B?ZW1aT2xrOVU5Ny8zeUJIZ2FZdFRwNVdQUDFsdkFsdlBld2tkdmliRlJ6cnBu?=
 =?utf-8?B?cmdsUmFFbU8rZkNaTFZQQzdadWtDLzJKSm1tY3B5QmMxTXU4eGloVGNwQXY2?=
 =?utf-8?B?U0tGb3h6dGYvMS81UEk5VjRWbWswbHRFaXk1L2EzUjBINzZpQStYNFJyaW1U?=
 =?utf-8?B?WE9XdU9GSXUrd3VoRE0xc3QzcUVpeEwzODk2a1o5Vm1NT0JHZ0FPWmxRa09W?=
 =?utf-8?B?ck5BdXEwdHpLaEUzT0RvM3F6S2RJTXRNTy84MGY2YkRIZmk5OE9iVFRoWmRK?=
 =?utf-8?B?M3ZBeDQyU3NUSjc0c24zdEs2YWtuMzMrNUlrbWpvWWc5d3M1N3RZUFprbjhl?=
 =?utf-8?B?WjlRUURnbVB6cVFwaCtLTUNmMVNoK2NFM2N3anR6aW9yWUZzYmNqS1VqV1RI?=
 =?utf-8?B?NHZ2TkNmL0Jyb1M5V0wrVzE3SzBpRnY1c0dxV1h0OXhidWpkdFpYWnByWjlE?=
 =?utf-8?B?Mk12Qk1iTmgwU1g1U0RuUW5OYjVTSU5OUGxZc3krOHV4RXZ1Z1dvY05QMjY2?=
 =?utf-8?B?Rjl2MElFL1lVVmFtRnMzVVhrcW1zWXJwNkJEL1RtV0VUSTl4bUVseWZzOXg0?=
 =?utf-8?B?Zk5FNWc4QjJDZ0dpLzI1UmdaVTdxV2dOR052S3oyWm54TVZoR2dVcTFkeVJ1?=
 =?utf-8?B?SmxTZXlHNDd6aUI0TWJReWZ0T0pmenhQUFV5N01jVnJqWWdTWlovQktIRFJi?=
 =?utf-8?B?Q294ZXQ3bGJST3Noa1NMajBKMGdJRlY0cXIzYjZLTFp2Tk9ieDd4WGl0T3dE?=
 =?utf-8?B?L3gxbjJXdm5iSE5IdFlPNUQzbTFUcVptVmdXSHFLL3ErQmZsNXlLUU9sWURv?=
 =?utf-8?B?UVE3VnF0RWJpOFZtV0YyWTVXeVBWRVJTZVovMjZOSXl4V2UyZVVaT1Z4ekhz?=
 =?utf-8?B?MFJqTmp1dGFQOVE1ZmxnWmxlck5ZVjU2VS85ZWRZd2Z2eE9uYmphaytscGRu?=
 =?utf-8?B?a2Q1MVZ3cFRYMkxuQWhucGNlUlFMZFdmUGs3T0l6amlZNG1mYnAwdFNsQmtC?=
 =?utf-8?Q?EjSEOopPuMKJWHWP1gp6BXqZJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dfccf0-bd7a-436d-8353-08ddfa92217b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:12:49.3105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeOxynTUEu4UXNQ00VN9lxkYhATVAQl9jrQgS/rflpjX1i66PYOhcaXZFPupJ3BIvqUVk0nh91bfuUc5tUxbCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7919
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

With this patch, both ENETC1 and ENETC2 are functional on the i.MX943
EVK board and can be used for networking.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 149 ++++++++++++++++++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 166 ++++++++++++++++++++++++++++++++++++
 configs/imx943_evk_defconfig        |  13 +++
 3 files changed, 328 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 3995176f090..528b3b02a3f 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -5,10 +5,109 @@
 
 #include "imx943-u-boot.dtsi"
 
+&enetc1 {
+	clocks = <&scmi_clk IMX94_CLK_MAC4>;
+	clock-names = "enet_ref_clk";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eth3>;
+	phy-handle = <&ethphy5>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&enetc2 {
+	clocks = <&scmi_clk IMX94_CLK_MAC5>;
+	clock-names = "enet_ref_clk";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eth4>;
+	phy-handle = <&ethphy6>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	pca9548_i2c3: i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x77>;
+
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			pcal6416_i2c3_u171: gpio@21 {
+				compatible = "nxp,pcal6416";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				ethphy2-on-hog {
+					gpio-hog;
+					gpios = <2 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+
+				ethphy3-on-hog {
+					gpio-hog;
+					gpios = <3 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+
+				ethphy4-on-hog {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+
+				lvds-en-hog {
+					gpio-hog;
+					gpios = <9 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+			};
+		};
+	};
+};
+
 &lpuart1 {
 	bootph-pre-ram;
 };
 
+&netc_blk_ctrl {
+	assigned-clocks = <&scmi_clk IMX94_CLK_MAC2>,
+			  <&scmi_clk IMX94_CLK_MAC4>,
+			  <&scmi_clk IMX94_CLK_MAC5>;
+	assigned-clock-parents = <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>,
+				 <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>,
+				 <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>;
+	assigned-clock-rates = <250000000>, <250000000>, <250000000>;
+	status = "okay";
+};
+
+&netc_emdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_emdio>;
+	phy-supply = <&reg_gpy_en>;
+	status = "okay";
+
+	ethphy5: ethernet-phy@6 {
+		reg = <0x6>;
+		realtek,clkout-disable;
+	};
+
+	ethphy6: ethernet-phy@7 {
+		reg = <0x7>;
+		realtek,clkout-disable;
+	};
+};
+
 &reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };
@@ -58,6 +157,56 @@
 	status = "disabled";
 };
 
+&scmi_iomuxc {
+	pinctrl_emdio: emdiogrp {
+		fsl,pins = <
+			IMX94_PAD_ETH4_MDC_GPIO1__NETC_EMDC		0x57e
+			IMX94_PAD_ETH4_MDIO_GPIO2__NETC_EMDIO		0x97e
+		>;
+	};
+
+	pinctrl_eth3: eth3grp {
+		fsl,pins = <
+			IMX94_PAD_ETH3_TXD3__NETC_PINMUX_ETH3_TXD3		0x57e
+			IMX94_PAD_ETH3_TXD2__NETC_PINMUX_ETH3_TXD2		0x57e
+			IMX94_PAD_ETH3_TXD1__NETC_PINMUX_ETH3_TXD1		0x57e
+			IMX94_PAD_ETH3_TXD0__NETC_PINMUX_ETH3_TXD0		0x57e
+			IMX94_PAD_ETH3_TX_CTL__NETC_PINMUX_ETH3_TX_CTL		0x57e
+			IMX94_PAD_ETH3_TX_CLK__NETC_PINMUX_ETH3_TX_CLK		0x5fe
+			IMX94_PAD_ETH3_RX_CTL__NETC_PINMUX_ETH3_RX_CTL		0x57e
+			IMX94_PAD_ETH3_RX_CLK__NETC_PINMUX_ETH3_RX_CLK		0x5fe
+			IMX94_PAD_ETH3_RXD0__NETC_PINMUX_ETH3_RXD0		0x57e
+			IMX94_PAD_ETH3_RXD1__NETC_PINMUX_ETH3_RXD1		0x57e
+			IMX94_PAD_ETH3_RXD2__NETC_PINMUX_ETH3_RXD2		0x57e
+			IMX94_PAD_ETH3_RXD3__NETC_PINMUX_ETH3_RXD3		0x57e
+		>;
+	};
+
+	pinctrl_eth4: eth4grp {
+		fsl,pins = <
+			IMX94_PAD_ETH4_TXD3__NETC_PINMUX_ETH4_TXD3		0x57e
+			IMX94_PAD_ETH4_TXD2__NETC_PINMUX_ETH4_TXD2		0x57e
+			IMX94_PAD_ETH4_TXD1__NETC_PINMUX_ETH4_TXD1		0x57e
+			IMX94_PAD_ETH4_TXD0__NETC_PINMUX_ETH4_TXD0		0x57e
+			IMX94_PAD_ETH4_TX_CTL__NETC_PINMUX_ETH4_TX_CTL		0x57e
+			IMX94_PAD_ETH4_TX_CLK__NETC_PINMUX_ETH4_TX_CLK		0x5fe
+			IMX94_PAD_ETH4_RX_CTL__NETC_PINMUX_ETH4_RX_CTL		0x57e
+			IMX94_PAD_ETH4_RX_CLK__NETC_PINMUX_ETH4_RX_CLK		0x5fe
+			IMX94_PAD_ETH4_RXD0__NETC_PINMUX_ETH4_RXD0		0x57e
+			IMX94_PAD_ETH4_RXD1__NETC_PINMUX_ETH4_RXD1		0x57e
+			IMX94_PAD_ETH4_RXD2__NETC_PINMUX_ETH4_RXD2		0x57e
+			IMX94_PAD_ETH4_RXD3__NETC_PINMUX_ETH4_RXD3		0x57e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			IMX94_PAD_GPIO_IO16__LPI2C3_SDA		0x40000b9e
+			IMX94_PAD_GPIO_IO17__LPI2C3_SCL		0x40000b9e
+		>;
+	};
+};
+
 &pinctrl_reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 8c89b8be04b..2b93ba9a38b 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -84,6 +84,25 @@
 		};
 	};
 
+	reg_gpy_stby: regulator-gpy-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "gpy-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6416_i2c3_u171 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_gpy_en: regulator-gpy-en {
+		compatible = "regulator-fixed";
+		regulator-name = "gpy-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_gpy_stby>;
+		gpio = <&pcal6416_i2c3_u171 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	usbphynop: usbphynop {
 		compatible = "usb-nop-xceiv";
 		clocks = <&scmi_clk IMX94_CLK_HSIO>;
@@ -260,6 +279,153 @@
 		#index-cells = <1>;
 	};
 
+	netc_blk_ctrl: system-controller@4ceb0000 {
+		compatible = "nxp,imx94-netc-blk-ctrl";
+		reg = <0x0 0x4ceb0000 0x0 0x10000>,
+		      <0x0 0x4cec0000 0x0 0x10000>,
+		      <0x0 0x4c810000 0x0 0x7C>;
+		reg-names = "ierb", "prb", "netcmix";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		power-domains = <&scmi_devpd IMX94_PD_NETC>;
+		status = "disabled";
+
+		netc_bus0: pcie@4ca00000 {
+			compatible = "pci-host-ecam-generic";
+			reg = <0x0 0x4ca00000 0x0 0x100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x0 0x0>;
+				/* Switch BAR0 - non-prefetchable memory */
+			ranges = <0x02000000 0x0 0x4cc00000  0x0 0x4cc00000  0x0 0x80000
+				/* ENETC 3 and Timer 0 BAR0 - non-prefetchable memory */
+				0x02000000 0x0 0x4cd40000  0x0 0x4cd40000  0x0 0x60000
+				/* Switch and Timer 0 BAR2 - prefetchable memory */
+				0x42000000 0x0 0x4ce00000  0x0 0x4ce00000  0x0 0x20000
+				/* ENETC 3 VF0-2 BAR0 - non-prefetchable memory */
+				0x02000000 0x0 0x4ce50000  0x0 0x4ce50000  0x0 0x30000
+				/* ENETC 3 VF0-2 BAR2 - prefetchable memory */
+				0x42000000 0x0 0x4ce80000  0x0 0x4ce80000  0x0 0x30000>;
+
+			enetc3: ethernet@0,0 {
+				compatible = "pci1131,e110";
+				reg = <0x0 0 0 0 0>;
+				phy-mode = "internal";
+				status = "disabled";
+
+				fixed-link {
+					speed = <2500>;
+					full-duplex;
+					pause;
+				};
+			};
+
+			netc_timer0: ethernet@0,1 {
+				compatible = "pci1131,ee02";
+				reg = <0x100 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_switch: ethernet-switch@0,2 {
+				compatible = "pci1131,eef2", "nxp,imx943-netc-switch";
+				reg = <0x200 0 0 0 0>;
+				status = "disabled";
+
+				netc_switch_ports: ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					/* External ports */
+					netc_switch_port0: port@0 {
+						reg = <0>;
+						status = "disabled";
+					};
+
+					netc_switch_port1: port@1 {
+						reg = <1>;
+						status = "disabled";
+					};
+
+					netc_switch_port2: port@2 {
+						reg = <2>;
+						status = "disabled";
+					};
+
+					/* Internal port, a.k.a management port */
+					netc_switch_port3: port@3 {
+						reg = <3>;
+						phy-mode = "internal";
+						ethernet = <&enetc3>;
+						status = "disabled";
+
+						fixed-link {
+							speed = <2500>;
+							full-duplex;
+							pause;
+						};
+					};
+				};
+			};
+		};
+
+		netc_bus1: pcie@4cb00000 {
+			compatible = "pci-host-ecam-generic";
+			reg = <0x0 0x4cb00000 0x0 0x100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x1 0x1>;
+				/* ENETC 0-2 BAR0 - non-prefetchable memory */
+			ranges = <0x02000000 0x0 0x4cC80000  0x0 0x4cc80000  0x0 0xc0000
+				/* Timer 1-2 and EMDIO BAR0 - non-prefetchable memory */
+				0x02000000 0x0 0x4cda0000  0x0 0x4cda0000  0x0 0x60000
+				/* Timer 1-2 and EMDIO BAR2 - prefetchable memory */
+				0x42000000 0x0 0x4ce20000  0x0 0x4ce20000  0x0 0x30000>;
+
+			enetc0: ethernet@0,0 {
+				compatible = "pci1131,e101";
+				reg = <0x10000 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_timer1: ethernet@0,1 {
+				compatible = "pci1131,ee02";
+				reg = <0x10100 0 0 0 0>;
+				status = "disabled";
+			};
+
+			enetc1: ethernet@8,0 {
+				compatible = "pci1131,e101";
+				reg = <0x14000 0 0 0 0>;
+				status = "disabled";
+			};
+
+			enetc2: ethernet@10,0 {
+				compatible = "pci1131,e101";
+				reg = <0x18000 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_timer2: ethernet@10,1 {
+				compatible = "pci1131,ee02";
+				reg = <0x18100 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_emdio: mdio@18,0 {
+				compatible = "pci1131,ee00";
+				reg = <0x1c000 0 0 0 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
 	elemu1: mailbox@47530000 {
 		compatible = "fsl,imx93-mu-s4";
 		reg = <0x0 0x47530000 0x0 0x10000>;
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index e4fcf2eb576..39b616e266e 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -39,6 +39,7 @@ CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x30000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
@@ -83,6 +84,8 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
@@ -97,9 +100,19 @@ CONFIG_SPL_CLK_SCMI=y
 CONFIG_SPL_FIRMWARE=y
 # CONFIG_SCMI_AGENT_SMCCC is not set
 CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_IMX_MU_MBOX=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
 CONFIG_SPL_PHY=y
 CONFIG_SPL_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y

-- 
2.43.0

