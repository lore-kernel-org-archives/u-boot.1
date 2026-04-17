Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4113F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26637842E0;
	Fri, 17 Apr 2026 14:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="VdTXI5NI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D3FD84246; Fri, 17 Apr 2026 14:15:57 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D38A83EEF
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/uTOQZMDlkbFFHyXunQ3YujfbOKPPjNqFoCB0488bLHtACrA2+ouFGOX5BbBWliy4J/U59mLlt1z47Y0aZwYb5My9ZnFap4j4K7+We9XpT4/i2Uu/70hmm7bqNjXpqYBLe3dPq6MKNJtI1z5BE7jh5AfQSuWmovYaysfZ+3VLg2M4rxg5gp1U6cP3D5hzsuZBUTmSNb4A+KQIg7hw1Wh7D+K0uhtkwvarjTGfz144rlRefoB1XnZj20gDZ2VPeyPX1mjvDrMIZ0x43xQV9/jh/vJsfdTFKeK+ZBSjuDNIe4FciFRSOdXrv9yFIIJzJO1PNSNKB64D2iVpxBxcafnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrOuQsLNwWBk63d8v1z3hyb7/wCGY8DksVTOM+91l1E=;
 b=PqWr02F2LkhwpVrglA6f/5RUXpKTR8Ev5f/e9uS3HQBZ1tsKpwn05qkc05WVncmotEF4IlHHRCXysb84dCPrecZEjEpHtxh3X71lEanQZKJylQ+iVweEOA0T4Uvad4AoSUXlNKeIVVAIA8j8C+ZDTepMPck33OVMqqy03MrnPnV9p/QUmPvBnSjZ01JYQFY5lw1plSWbUZQ9P0i4RgOAqhgqfbReqXBQ4RPtDvRM0tVTf52SlzxHJiYdCTuX4EPmWFD+lTgPxTPSLMF9Ap4p+nOz1vwzfhE9NiNi/5fq3m7LYVjB+I+lehHUdh/tdoLr60K73geKHcSNcBjd1Yal+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrOuQsLNwWBk63d8v1z3hyb7/wCGY8DksVTOM+91l1E=;
 b=VdTXI5NI2I7bpMIflgAW3pvZydoDlUdjmUst3i0GydUtNdIIeRizGQRG1M3br81PEPC4yxEbE4bi8UuRN9CyMO7K/gCqET/5A1JuyxPUh+5Bk1luNGOrNEO/WFcKtx8Gjogw3S0KlzSEv+BWb0IMSnVaSCmaZZ++Gv5osn2N9s6KjjR3utpcOO0dazwiU0bsIT2vZPP0BAK9Ott4midT0abay9Y87TzhCgdCpQJq+IKH9SOpZ327y6U0AHs9Bz631/e2eAvWoQuk3njpMFo65m4wBL83gPIWwDIRjE7/CC5t5JJFQdquz0kAr8FzC+8USuzA9QRVzB1KhY8x04aNaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9182.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:15:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:15:50 +0000
Message-ID: <d786d7a7-0601-4680-aa73-96334ccad320@siemens.com>
Date: Fri, 17 Apr 2026 14:15:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Add FIT multi-DTB selection for Qualcomm platforms
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mchitale@ventanamicro.com, maximmosk4@gmail.com, jonas@kwiboo.se,
 marek.vasut@mailbox.org, quentin.schulz@cherry.de, peng.fan@nxp.com,
 sajattack@postmarketos.org, balaji.selvanathan@oss.qualcomm.com,
 wolfgang.wallner@at.abb.com, e@freeshell.de, yangshiji66@outlook.com,
 funderscore@postmarketos.org, hs@nabladev.com, kory.maincent@bootlin.com,
 jj251510319013@gmail.com, carlos.lopezr4096@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: a675a4f3-179f-46ce-b18a-08de9c7b108e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: BYSvjWvarBM/JQ3eNT8qu56pIImKqOLZLF/XqWnE9LaAlXNj6PL4Rb73XDUU07+pCKcvQ3yUY5VOY0XGPzotEmMkw5/AWU89GGX1yyhcUotFT1RjikEsRnIMZxnPXRkAM9F8M47d2mP5P/2s0f26jvxFB8GcywEeBcUrLShMpYCuG3ZyhZ9y1OpFi9PcK40skUdoDHs+VrIO/J/2jY38H5imscaV9rlCb1nI5b4mpdxruVAsTcr03k7BR8M9Uox7vU3HDujupV6YK6fMD+jRS+rjsQpu8+0XfeLAK2MGWA1AnHXwKC0y/rslooMju+go7T6CVzo0cS+kQPycUtxJm31SNGybIs2ja5cgk87JMCxXoByHwHm+2ZHI/eIu31/gSpiWWu/CHdHxosR8V4j/wYDqm6qHr1N8v9iq1nVD+7K7nJrOp4iic5rt6zWmUIABp2nqu4v2ybb5GZABPZQGp+wURpfvBMeeG7YbHZjSgG3/GxTPAYKwRU2M3/QMHzJRmixLn+S5Strdu1Sj8rhLNTXngvlZ9n+4D1tGyYq185J6gUPkkfLryENlA1Br1qD3mSpP/nYvM0796IDh+ypIUWekOEVG0S3dw9TI2Nclpv0S/8HNkop8sicUfeXZIUBPPs3AtURNWm/yl+OEioXk2NtEUIeZWL4xC6KdsPFWHHUtTB5Jq2gGoREkQ2DVpXoYZtEmopnH7xOUZbVs7Bmz08U9+dR3Xx5PQ9s0EokVz1MIZB5p3MhIlieYVqI4q8/2bL/b1LIJBkFHLs4Fn8/JaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGpKMXlIL3p2QVNkM1hsNS8vL2dKN0RXdlV1UTlSb1R1a0VDdFJUZ21CNjRJ?=
 =?utf-8?B?SFpoVHZzeWxMN1VFTUxQK0VzN3hZcklXZjdiRGhibDc3SVF5YkFWR0JDZm9P?=
 =?utf-8?B?RzJMQjJhYkc3TmVjbzc3QmpKMzZsT0ZvdlZudzlyZGpXbmhkWmI3RGZEWTZM?=
 =?utf-8?B?TTc0Vm1IT0Z6dXJTYlBrMFVFQXVRVFVDNy9FNkQ2NHBkazhCZUxJdnJpcFNF?=
 =?utf-8?B?RWJKSjJZZFlFK2psS0ttNStMSmVYRm1JTjQrZnRUVjBjNHBaOWxGODgySU9D?=
 =?utf-8?B?SHlHanhkMVJjNmtVV2NQRFBRTWpralhua3A2NXlsa0cwVzJkdW1RTlY3cXFo?=
 =?utf-8?B?L2VVWTFkQjE3anlCSGxpckNPdk9jOC8wV0EzVkx5VXdpU0hJTURDSW1YcU1v?=
 =?utf-8?B?WDBrNk1FZ2VxVGo0UmJuSlBXYktkMVhGNllKUW1lRVltcGpwcUc0U3lLK1FR?=
 =?utf-8?B?MU9Jbno0RzRsYWZlVjFNQ0R1blQrOEtQYTJtT0NlRS9kejlJOG9VZU1vczVZ?=
 =?utf-8?B?ek5QeGJEQUpYUk80UXBJT2w0eTc1ay9aYklFUzk4WHZZeU5Eb0pIbXZ6SlE4?=
 =?utf-8?B?b2VPaVFTWXhjRk9haStUdHRwWnhRaldldjlrQjJnTERFVC9JUndoM2F1aGhj?=
 =?utf-8?B?Y0dTMk1WSndyVW9CV2JLNDY4OWR0T2MwSVdoYXNoVVNJZWltUEV6Q2g4blp2?=
 =?utf-8?B?enFyVHNVT0xwVHMrNnNMZFVESmVqVmZqUk93RUxxbnJ0NG9Rd1pDNjkxQ2xi?=
 =?utf-8?B?cVY3bFhnaExVQnBWK254S2pPK05ha0thcitvRVhwNEE1Umh2VzA1NnJOQXhY?=
 =?utf-8?B?cjNTaHFPZk0xdWpJSkh5MUVjbVFzaVNiVW1IQ3BpeTBnUTErZU9yeVJXd2Nv?=
 =?utf-8?B?OEdLb3pQcUJ5ek1iMUIyN3hjRlRSOTlUM3VRRnluSVlvWEdmZVVXS3djbFlB?=
 =?utf-8?B?bXFBOE8rMC82N2JVTjZnclRGcW4yVGszWVBhZ0FNYlFXVEpoNjdIN1NvMDdm?=
 =?utf-8?B?SkhHNmxBR0REa2VUYUFMamxoWlZQYmFwbFYrL1IrYStIN0wwSEZiR3ZkMy9K?=
 =?utf-8?B?blNxYTBNc1lmR1FRam9zYWZySk03THV2Z0Z3UnBuYXBKdVRUNmVvdjJyQWZz?=
 =?utf-8?B?bFN3L0ZCREsrQll3bW5hcjMvczZIQnlyRkNXTUFrRDZjck9RQ0ttcmhkWVZp?=
 =?utf-8?B?S3RHZzVacmY2c3liSVduKzNkMnZsamR6MlFJNjl4alVXNmVURnpuQWJvQzlm?=
 =?utf-8?B?MjIvQWk3TDlRaldlc1BxcVB6S2ZRWXRhQ2xnVndyMHRJb3dFZ2dyNEZGQm5m?=
 =?utf-8?B?QUtDYjZlcm9UdHp2akVjT0lhQ0NtUzV6NnlsZmVxOVpzWmNpbitFZ21LY05B?=
 =?utf-8?B?UTRJcnRSMUY0STFEQkE1ZTFuUWFBWEg4TGxkSFIvMkFwQmd1VUlLZ3JXT1R5?=
 =?utf-8?B?SzY4VzlLMkNhd2M4NUdqcGpuR205OFg0UnBWZHpCNldGSHdrWkpJUEVrQTR1?=
 =?utf-8?B?Y3lZdlUrdVVhMklRVTJubDB3NzBmbEVlSXN5RWJtRmxiS3F4L3JkVWJ0eHh5?=
 =?utf-8?B?TktWL2REN2QzTy9lR2NrMHVEZE8wSTlYbW5ycGI0YWNpM0dVaFp5NE9sekwz?=
 =?utf-8?B?NmhYemtaQ2ZwUXlSRDNRQkVtRm43UG9UdEhxcFVST0JORFpNWXFFUmpCelpS?=
 =?utf-8?B?ajRUd3piRE1IQjJIZVoraFV6cG82ZXY2U1JrSzB4RktodWd1dTl2YUxOcTdV?=
 =?utf-8?B?WENDUkJnVmlNcjlJeDJ6WGZPUm92NXlwQk11aW1CYkllMFhxR29XaDRFeWFF?=
 =?utf-8?B?Ymwrb0Y5ZnBEUXplcjc1Q0p5c0RzWkszaGdNUjBZM2lQTTVab2Q2Sjk2ei9Y?=
 =?utf-8?B?OFZNRUVpYU9rNU9mYzdHcTk5a1dsMlNSYUxyUHpwRDJ5OVB2TDhDN3V6bHlI?=
 =?utf-8?B?RmxaUmlCQno4UklKVjEyMXo0cllFVm9vcW5jTWZIVjFEMDBvaFhHbjM1TmxL?=
 =?utf-8?B?aFBIVTNKMWtmYlF4UjQzUFFFQnA2N1FwNUs0MEhzQ0hRSnZGUVA3VFVSTFZs?=
 =?utf-8?B?N2c3Wm1ZOGZyWWxZRTZEeU9udjVsd2NRU2psOUZpN3Q2YVlWeWdEWjJFeHRk?=
 =?utf-8?B?eG53TDlXdDhWWE1UcDFLUXRad3RGMFZ4M2lrMXZXMnhZUDNWMkpDUWxIdFpa?=
 =?utf-8?B?YXR3VHB2ZjRlQmVwcG12NUxsWU5zWGdKaUgyU2M2eDhXZnJmVStKRG5Rb2c1?=
 =?utf-8?B?dytlbkZ6V0t2RlZPWDRmZmNWNWdKbmRtNzVjRExrWkpyVUhkSW11ci8ybUhr?=
 =?utf-8?B?TlNiSXJCTnRVTStvWjlzSWtUaGp0ekNjZVl5RlRhaExkaEdoeXJKZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a675a4f3-179f-46ce-b18a-08de9c7b108e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 12:15:50.7484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZNXsfHYOREaNpjkK4BKS3a5n0bgY+Qt7av0psP30u1q4n6/AHD6eYqskN4S+YlOq5oyGPaPqlXnZkEqSr0yYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9182
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

On 17.04.26 14:09, Aswin Murugan wrote:
> This series adds dynamic device tree selection from FIT images for
> Qualcomm Snapdragon platforms, enabling U-Boot to select the
> appropriate DTB based on hardware parameters detected from SMEM.
> 
> Qualcomm fit based DTB format is documented in [1]
> The fit image contains only DTB, while the kernel will be part of UKI image.
> 

I suppose you know that UKIs (systemd-boot, EFI Boot Guard) provide DTB
selection as well. However, that is a fix-up for the case the firmware
does not provide a fitting DTB. This here is supposed to support the
firmware DTB delivery, correct?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
