Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C43C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 17:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8120640B93;
	Fri, 24 Jul 2026 17:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pk6Hblp-bR3Z; Fri, 24 Jul 2026 17:53:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 817F140B8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784915589;
	bh=dpp8H/Jca7wGP6475rG7322HekZGN+YqascxXWYOxFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sZ7QR3WCY98E6vl/7Pq2RiNaGdnp+Xi7nYYXgR+JrqFUmVi+hwgk3gk0pC+qz7Q3I
	 tvHKYnlEnw3qgN07b2a+7v/qjOs2obO+dLIjyj4fT/afsj8jfql8N4ANucxAL0dVyT
	 /agHJCYF3e6R6PxpYwaPao+FBW9ndladyiWeS82NZwZ2Q999BaIdILOfp8ucGAbGQG
	 +LXnQDuGSF82OWFMdw4wNn+UDZ2RHqg3vmyAVGq7J6EFMxZSB1pe770YsKFbxcXTob
	 haLcOofaUj6M/2w8Ww89yuerQG5tMhBQ+KvCUU1ivla4HRCljY1WzHuyVpDQxedJq9
	 oG3lAEjBFXn9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 817F140B8E;
	Fri, 24 Jul 2026 17:53:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 672503B0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 17:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5860A40B8E
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 17:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-baFlQXe6PH for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 17:53:07 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3BE5640308
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BE5640308
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BE5640308
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 17:53:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EAA1846A4; Fri, 24 Jul 2026 19:53:04 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1C52800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 19:53:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbAcJBlmQWtCQbNmpeWZ8+MaAdlxM78a82QrNNDeSY7jI8ikNeuue8L3XDML0lGJVVRp9okg3rqimlpj88x9wNAYrpd+NXjTa6Muu1eXSqCqGlVS7QP1HGFnM63gm31i81Iw+opb9YzD7ZhXfCj1of4XthtHjpsXtKGlbi3JYLyt4azQE8A8X3mB/XEgVv0DNz4SzawQ0U/7SXha8WRwbIqIY6j+mvuC6Gzx+ywJwWKAucjUgK1iaWaYctOUqFSkHzrcpRGklhD0hWf/8I5bcVpJRmA1UyYU6KGpQw/i/xRY7yzIu707t/pNZbVKmmz11ymQfiMMj3cTdzrb2/RjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpp8H/Jca7wGP6475rG7322HekZGN+YqascxXWYOxFY=;
 b=UqYpNLhWM2kwm8XdKqLgDuw6t4tQWTdbS0bvLQPVs1laWISjHkpt0oFfplASCEsi33BRvoK0IvOT7w6sykhpnkpNs3GhkZewIINwarYQZKsujkOleeDsPzUWX+Iqfi7A77lXebth0R5+i48QFB+6G2Bcg5F0Ox0MAUnQNNV7l6TpCP6u/OjanAYO2wNbQbdOG35e+DGJPmL24bGVry1LpA/4T3WO4rZuld8kyNZiLlvJ75KsiXN9whWdiJhpZXaey9IKHiIaeeVI23pQKAbjT6lmr11BhsEc44GiLyDjD6m+Api4YiJl4d2hOYSjzWTiCz1ndyOpkUW5EhsDZ3UP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 17:52:58 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Fri, 24 Jul 2026
 17:52:57 +0000
Message-ID: <b18efc9e-05da-4dc3-adef-9e39d58d0687@cherry.de>
Date: Fri, 24 Jul 2026 19:52:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Coordinated Vulnerability Disclosure - U-Boot Multiple
 Vulnerabilities (3)
To: Wade Sparks <wsparks@vulncheck.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 Disclosures <disclosure@vulncheck.com>
References: <CAA1v+SgpU6iU_WZFWN4ft1NveJHM47zSk+KPLApy9hogOKDe9A@mail.gmail.com>
 <2062cf5c-31da-4ccc-8ef6-3dadc5a799a4@cherry.de>
 <CAA1v+SizE76J1gU2osz8xC_7Uq=Mx6W0omr5C+3ph-8G4Ar6dQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAA1v+SizE76J1gU2osz8xC_7Uq=Mx6W0omr5C+3ph-8G4Ar6dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::14) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA4PR04MB9365:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e216a58-09a9-4106-1816-08dee9ac652f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: DGjeDEkhWh+YzWyv03M9aheIHpO2sJJ9mz+VDPLOG2ATbpgasKFQnfuOzSKvXin9fmS7Zg8jIlgHMKaReVGlazRestH4KPchWL+F1i1eSUGY9+nea+OcPGUCJY4jPCV+W2uUGJ702I86dxtm1TaorgmVGJ/GgXBPFYozMjtZwC9Yd/PXMzPWovQn5gC51ikXHnkU68s96xdcqTIqC470Gy5YwRm6tkgta8H+S3FrE7MBdhEQooANcn/Lebnbdo0nveD+9K2cUbfqo4M/bRZggykztbPQUmpu2h9XYEsdZFesYvqCiwevdUnXRnVvCnzcDKZWo/r8ksZEYJ0jZ0WZ20oK7EU2CTxTGL9BOxAHB6JMGgDp1NKaDazefOKZWViaBg9W9ahZue9YlGkZu5ntv+3+gdMHhIbncO7MKLQKV0KgULal6ZwnsWCRxUn1FV1T9dnUzLSXnVBfcsBi8kjEvaxLZk9DLmUPFbfpUsJ1y95SIKsuFbtyt39ueSL2LJkPn3sq9Z1GXlY4jlLR7U+XSUuNEzITnIuUEmXsYuGsNDJyP7gpcUjy769UxrxEfOJQdP4mwhfJyJmQOKarLlbFlJHgiRW+yB4J9BkR0dLdSZvr6mE24P7qjBngPjKcQHb+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckxmMmFRSGUzZzB3d2NrblYzekorN1ZKc2N4SXM5STBBTm43UldhL0ZPSEY1?=
 =?utf-8?B?a3REWmdnM2FxSGhlYjByMldNTzlKNGNXcmhNUEtCbUQwNWd2cVpwelU0NVFx?=
 =?utf-8?B?ZHRhMzJSOEJnaTRXalpXSmdKcXNOcUFtamRKT3dqczJwYzM5bEVBb2JQZmhW?=
 =?utf-8?B?VkFXVHBEN3ZRQW5IVEI4dEtwWnB1MEZ2bTJhRmtoclVaRSt5blJlcEQxcWxl?=
 =?utf-8?B?S3hRVHgxQStmQlEyUWZkRUxKTWNlRUFWSUpjUTBPcnVMUXNCQnV4azU0SEUr?=
 =?utf-8?B?c3ZuNnFxZzFOaUMyKzN5aEdxTDA2SUtvdVVRQU4vSlg2UExic2drVnBhUjkv?=
 =?utf-8?B?dXlGVENVNGNORXZsN0R5M2VkMTJtaDhQWWx4RGUxMG9WNGNsbnZPeDc1WWRF?=
 =?utf-8?B?MEhxcGlPb1ZrL2g2NDZVRzVWTFBSbktUTEdoRTlCTE1OMjJhbTU1U1UwbThu?=
 =?utf-8?B?VWVaQk0rdVFtWUtOdUVjc1ZFWGdRQnFTNVFmRmpZSi9PaUM3bG9GUnBLeWQ1?=
 =?utf-8?B?R0lsUUpJbTNRNGRMUVduM3Jpc2pxUDRsUjNnL3UvUGFsalVaTHVteWZCS29E?=
 =?utf-8?B?dDhrNVZzSXo5emxSVlAzMUtEWnNMNmVyUUcyMVlGa2ZVWFYrZ2hWaHpsMHhK?=
 =?utf-8?B?clJQMmNkejFsbEFFSWM1UmtzZURQQ1Nxb2ZoWHVqemQ3NTRzb2gzVVFNbGFz?=
 =?utf-8?B?L05UZ2Q1U3YxWUR0cnFXeEhMd0xlY0hLV2J6R2JabGlUZTBIVlAxV21VQjFK?=
 =?utf-8?B?Y1BBL3pWQVBNWTRtbHBRNFlZSnpaSk1xK1NYR2RTcCs3V2c5VzluUDRGYWNF?=
 =?utf-8?B?ajUwSXJxVVJSQUZNVjdCQ2I0OGVhaHhwS3hoYkZRYWo3a09YOVVsQUpucTk4?=
 =?utf-8?B?WjYvZ1l4WDVBNEx3Q2dXbUtLZ0tzaGZGcHFIMlc2cjNTMlZYakd5VWhIcnU3?=
 =?utf-8?B?U1QvelJ5d1dHZmRydTc3NmhDNmJzK0FiakVXVUtMTW5XZTdWa0ZMQjNSczBl?=
 =?utf-8?B?T0w1dzlkbmVIK2pFcFNhYkhrYWh4ZGp6d29hejdmNXRWT0hFY2Z1YVpiODcz?=
 =?utf-8?B?VDl6TkN5YitaN0l1NFpCUGZ3cW83R1lZd3ZlQlZJTUtmUENCK1hadFpiWDFo?=
 =?utf-8?B?OEZRdWp4WGVyMVc3NDdIYmxQdjdyUHNOc0ptNGtlT25XSHBjTlJoZTJNM3dR?=
 =?utf-8?B?TEtYSW9RbGZFaUJoTURzTDEyWURpeHNLUW1zYnVnTm9UNDMxbzZKUjZ2VGhk?=
 =?utf-8?B?UHZ4OWZON3haeTlscTdiU2VzaXJWVDJNUW90eVlycWswOEJNS0xIcXNLa0ZW?=
 =?utf-8?B?YXR3TlRHVjMwK1g0cE4yeWlFNXRyUTZ1RjZjeDNIc2ExZGhLdU1NOEFwWmpl?=
 =?utf-8?B?NmhCb1Qzc0FvWHE2MlRLdHh5eDJGLzRIZ1NhMSthQktBTWVBWkx3WWNRalhj?=
 =?utf-8?B?bW96MFlreXdFQk5vZXpSelBkdEI0OFYrSTFXVWNKTm85MzJPd0VleEFZeHZw?=
 =?utf-8?B?Y0s5YXhXREZsVWo1dUJIdmRUOFJGQmQ0U3BsV2J0ck1IV2ZjWkR0dGJDejZC?=
 =?utf-8?B?VThJSFIxazdGZjREVjZpVHhsVDkydGVYdHZ5Z3cvZDV0emtmNHhLNFNpV2Yw?=
 =?utf-8?B?cFdZaGlnV1U5anNFSWFXb1VqRUI1YWozWnpZUUYrTEhOaDh4WTFVczhIMnZr?=
 =?utf-8?B?VGJjbXFmUTA1NnFBbWtDSG8xMUtIMUovQzJVcUkvYTlsSWdwTUlhN2U5V0dx?=
 =?utf-8?B?YTlnZERWL0lQa0hrenBoaHlsQm1zY3g1bGNIZnRudlk2Z2FMcEJ6TDArWDRF?=
 =?utf-8?B?T3NNSWVvWnBoTnFvT2owZ0ZCVk5GZVF0ZzcwNnN5ZDVSemJDSFRHcndYTmF0?=
 =?utf-8?B?Ujg2aDdQUjV3NGhyRkN2MWVlNVMzck94RXFHc3NyNkw2WkZBUi9PYjMrZkZ3?=
 =?utf-8?B?cCtuQlEwTDZ2ZUdCMkMxYzd2dDZ2ckNyM1M3Q200cDN1c3FNWDlGZ2FGNVNP?=
 =?utf-8?B?ZDdEYlVDakM5UjY3OVkrZVNVcDZTZVFETWZRc3JBejNZVC95QlNFQ0N0Nzdv?=
 =?utf-8?B?eUtDRDFSMGNPeGF0cEYvcENDNXNqWEdWMnFVTEFJVWNhbFhpQi96alBVNUVO?=
 =?utf-8?B?WG83c3lzZ3VzcTlSLzdHVEhVZWxTSGdDaTRlVGFqaUlxZWVrQm9IR0Z1cVhw?=
 =?utf-8?B?N0F2ZXNodFNSMUdoMjZ2dnYzeHhKQm9ycUFMYkZqZCsyUlVwM2t1TUFIcW9l?=
 =?utf-8?B?M3RvakJZNmMrbDZQVzFjeS9pa2dqWGJ0UGp3Uko3TWNnOUdMcktwbWQwV2Rx?=
 =?utf-8?B?Y1hTSTljVWU4bHVNMzEvTVZVT1BMTStseFUxK1UzUmx5djcydENGQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e216a58-09a9-4106-1816-08dee9ac652f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 17:52:57.5730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mj3ckTV+bsNkz/evg9ud1xHA+4jJ3K3rDhrzGz1rlyRryOCSuve+Jd+W8C4IJjPjR9/+fP/qBNYcE9Pk8NkwiynZ8TFjJolq9ENJy11v1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpp8H/Jca7wGP6475rG7322HekZGN+YqascxXWYOxFY=;
 b=Xw37OEZVSIaumTDB2wEk6sn1Rsn4gk6Ky1ZU/w/e1w+IwdzlJPke+12c538dj9oi01hYd78YT1XCf9FqrtJYKjwMHMgM1S669w0TVipdhj3bAepkpbQjsy9r7cwOsInlQD1c6Wma8wnZpFnvO1jkX7ivEEgatDf5SU7NBiYwPrM=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Xw37OEZV
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="Xw37OEZV"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Wade,

On 7/24/26 7:37 PM, Wade Sparks wrote:
> You don't often get email from wsparks@vulncheck.com. Learn why this is important<https://aka.ms/LearnAboutSenderIdentification>
> Hello Quentin,
> 
> Thanks for reaching out.
> 
> For some context, the vulnerabilities were originally privately disclosed to the U-Boot maintainers where VulnCheck was then requested to disclose to the public mailing list: https://lists.denx.de/pipermail/u-boot/2026-May/617853.html.
> 

I don't see how anything I've said in the previous mail would have been 
impacted by a private disclosure, so not sure what this added context is 
helping with?

> U-Boot <= 2026.04-rc3 was the release last tested by the external researcher that discovered the vulnerabilities.
> 

Yes, but the wording is poor. The result is that this misleads users 
into thinking they are not impacted by the CVE if they have a U-Boot > 
2026.04-rc3.

The description on your website says "U-Boot through 2026.04-rc3" which 
implies it's been fixed since. Something that NVD seems to agree with 
since they also list this is applicable only before 2026.04-rc3, c.f. 
https://nvd.nist.gov/vuln/detail/CVE-2026-29007, 
https://nvd.nist.gov/vuln/detail/CVE-2026-29008 and 
https://nvd.nist.gov/vuln/detail/CVE-2026-29009.

> Thanks for letting us know that CVE-2026-29009 was addressed in commit d669401 - the CVE record and VC advisory have been updated.
> 

Well, I don't know. It's just that the suggested change in the report 
has been implemented in that commit. The report smells like it was at 
least partially written with/by an LLM so I wouldn't know if we should 
trust the suggested changes (nor the report). I haven't checked it 
actually fixes it. Just had a cursory look because my CVE checker now 
complained about these CVEs (and I don't care about them for this 
product since we don't have network enabled in U-Boot).

Quentin
