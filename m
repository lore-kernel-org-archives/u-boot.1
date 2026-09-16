Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFFFC982C1
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 17:12:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08D37607BE;
	Wed, 16 Sep 2026 17:12:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j4LUKp2G6iPA; Wed, 16 Sep 2026 17:12:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 260FB60705
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789578744;
	b=ipLA+K7BcWd2V6NhXzyjdwlIWychnGnhvUHjeI+sES4E/uRgKcg2rVnSko1wVcixAF0z
	 76LO/YDxMN/usXYdLnp1Dka24wCmZ1UtkbdGpmqIpVikm5w0dPFTjllaZaq+yD3lCaw3V
	 ylVpfZZwVZVFBEXwthwgQ3s7iouEES9ce0cfcWvKMvSuQH+yh0IsRpNTLx7Egil0KPXs6
	 cvjJmpkGY7g7h2g44SdzQVGheeYEk1y2p+IJZNQLQPVr1lAfIkz6SrBpWwEWd+VQG9F0u
	 U04/O14GoIqFk2lGZRhP46lePXqLLFUvQKxG3GxuY86FfCpNvlE4aZbyYV7esoLmkRg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789578744;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HPZ2iDKhP92LUbXumjoGsACgFcB6FyRutkgPaAm7lTA=;
	b=F5PlKwBHanFU9QJVKr5my40TioiFf6effUTH6J0SGT6yOcVX1y/ezTOq1VHB9G30RwR0
	 BQ+IuUYELgKTOOa0QnnTk+yfZXh5liwblg11zqERFXtSo2nH8GW6bm8IfhZ2FLv64fyXJ
	 wi819ZdQCB1zcW6CEQGTUdCPaj+6FuoTQ2JXdJcnKCN9whBt9U1blVv1J3kAcgIYhsgWk
	 ZfOANi0PM0HJo13sr+H7nv16/QAcM8CM6tUcV1n+Vk3R6W2FsI57tYTQWC9VW+jo0T5Kv
	 wSUNi9FmR07/J0hwUQJ6wpLEIau5kE5vgYJxMHT57JJVKd59zRebh1F0b4brX5u7hrQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dLlhW9OG;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789578744;
	bh=HPZ2iDKhP92LUbXumjoGsACgFcB6FyRutkgPaAm7lTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ik+0qVDDYKPN7ubEaNZLuXOam6hVvFglwXjh72kUrSrPE/0mNx3gKqSnYRSNKxGIv
	 4HyT92E5wE60/0g+O6i30XY2eF8Dp1uSncVvNHynMmu+H74jAkkladSdxD/Il1KZfE
	 3jFCw2nuBh2ah2YpkM0fU/sKD89qNe0Fr4lU84z5TlPGmBt592e2Xlvgw68++kbrFz
	 BZofpJ6GmDukUNl0+gj6zCB037JjV9XZYunIP6pVBAIYU1knriONVzsl+t8SRKZEa4
	 6DVbJbw0WC+aLZ3Xa5AFt1N/5A2lIv07mbDw5504a5N8+uLOVE2c4UotsckzK6Powv
	 1IBkm0qK/YnYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 260FB60705;
	Wed, 16 Sep 2026 17:12:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E99109C3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D863460705
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:12:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sS0jozjbvucE for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 17:12:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1513E605B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789578739;
 b=ropgS7LGuQUNwUGr0kSAn8LsVHrCxf2DTObH2K6D/Z4lM0Cr1UmF1gYIxCnn/D1qqCGQ
 4IiEbRNSjg3GlheHI3mGHD7Q+Nq6z9Ag1PxOzr9XMUT/DPBx9VgoOBtctSEweHJPf29oF
 wD42BZfhrh/uNSS+FmJWtEdYhk40vbBeZ2tRH8goW8R687AMK1MmsUMyFI7V9SlJVUbdn
 ZVwv3hgHqaUbbuyLac0hzzlrGIYfHZo1PIUOD09nit3tJySVGcHMX75IbBah5/pDYo9LI
 9ZaP5a4EpkUR3UcUunwl0a540/pb35uLzemHw0zK6Ar7b4eBVX6ND7r/1Ebv8bP6hEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789578739;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=HPZ2iDKhP92LUbXumjoGsACgFcB6FyRutkgPaAm7lTA=;
 b=IW8pNM5A8jXMRMNIjKKj2OWF+GAZZvZPxloDI2HLaRSRDR9LEW05Vr49J7HBkmR0AIIy
 O6/mo3rX9DNLGkegoChgGmQJxUhD2z/U8mifWwVv6ViAXWEE1glA/Imn3DuhfZSXCmlzp
 /Ww25pTzZI9Pm5IxCE6wwpyAri9F0HahXcSBES+yponiiGUB/6sDio52hsnm9TWr6yOkd
 /njbdsmgtd/LErHqs7soZxMIyCPBXMjcxTTDzsXKa/SdHKAUpBBeED7Gga7UHzGhIn2DT
 eYdlgeEDjP+R+TuGbtth9FFkvHHQRtTD2md4YNOK7Zcokb4xP2DCLjPeYIulG1Qx1YQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=dLlhW9OG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=dLlhW9OG
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1513E605B0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nb+lI3vL00gHNUkLCbfeOOW0nGqMF5z1LnzE4hkr550qVSNd4zGIn/h7hZLY+W2zO89mCy9N1YwPu7/2iA2O4MlGBrngmz8CkiFIoKPKT+VJENiOg1QFwMS8gO1YWFcU7er5mE5yPt8Md0uuGBo+88y0yCHR7PnarYFqRHnlHnQ1kyeA+Z9j2uM99kjhpgVKrZkNJWxgsBPCB/EQ/SjiY0aqpOOEVrQx9jg1LWTHj5egS5t4CgVV9ls9iLKXhwzyUCJGffc3THJXiAIqIHDjRwhs485ke1LlwQaxorKxvDxQz3Q1R0yPa8vAdIC4kjjNDR6qx2L2PZsQYlMADX6ggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPZ2iDKhP92LUbXumjoGsACgFcB6FyRutkgPaAm7lTA=;
 b=yuUP8ftnPHDO+R9RvPvHHPFhDE5vW64mKYkCTQGnbQF1mUwjookH+QeqWNXbT7l+YrksoVphGPkBxlqXvQouWd0R8FGDvS+mNK7B2ENfyKzVc1iLwnzM/dXifkr6QfdM9vdVsVHidQJK1C44+vvQtiTa6K8Bsr31B4No6Lv9o/DzwqFfI0R04aCVzl7H6sjm94s0YkoWOEQOrwAX88nEDFcwBRwZ+Qz3gDWjIaIOJ9I3gnWB4HhoRIp3kZ4n/KaA13951w64TL1+bAPndbw/RbFnDM1/DACGBebq70Efx2cihruN2CP0BcShXEeVXwlzQAFxzXKqJGcHs+RipLmGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPZ2iDKhP92LUbXumjoGsACgFcB6FyRutkgPaAm7lTA=;
 b=dLlhW9OGlJif2GSDk93dK6DWpMAIzW24hMxacJFHyksDGcXLESZY3Im3uiuLRX0lN0dCP9Kx5EcyUHB5fQ9reJeAJGQsZmfZb+dJU4f3EQxPV2EfcbwOobVtJQsqIPN49Ad+FoV2DD7F9di2TXyQJoUyqboFk7Cu2fp0F8vKRyYUVkDB4EWo76fw2mZ/uchMvu3D8X5ijFSwiBmscvWFJ9xunHaLNqaHIS7sJsMACTtLWwmtd/3vFk2AKMmy6DH8VC9MJF8oO01KGg6xBLfs9xKsrR25hAZSnDOcVQtJrHdvqQgmdtgQDPr9iSLh0C8TogYc10jAfwQpJHfse9xmqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DB9PR04MB9891.eurprd04.prod.outlook.com (2603:10a6:10:4c3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:12:12 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 17:12:12 +0000
Date: Wed, 16 Sep 2026 20:12:08 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v2 0/5] board: lx2160a: runtime SerDes 1 lane grouping
 for LX2160A boards
Message-ID: <20260916171208.iygunxmqpy335wl3@skbuf>
References: <20260914170417.3052423-1-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914170417.3052423-1-vjardin@free.fr>
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DB9PR04MB9891:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f70706-e74f-4611-4b3b-08df1415a5e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|19092799006|376014|1800799024|23010399003|366016|18002099003|22082099003|56012099006|11063799006|10067099003|3023799007|41080700001;
X-Microsoft-Antispam-Message-Info: wN19Bykwao/RJFfHvpuPHznu28zh88WxgyvS2jU1OOEEgb8oRL8HIUSFKckqDTgxqNYiNYdKexrYro250Fw77JzxG4Hq9FurZYBs2ZMk1vARE/vNz+Hq3lkt2Paj2phJ0BZECCw+TtqOrdC50fy09207bWghhlqzL7nMLT1YV6cQ8LzZx7yGI+1x+87BQiNTkA+COE9/u0LXYrV/3Y0gwpSV2RGEObDPQKoeQ5cjFNInKwi7ccNwB9ZFD0anLiHrm139GfOvH+WR4r5J0hOMbZcP7zVg79jztyZ/VVrDRO4IPaXWlcnng9fNpF34Zeqtph4Ik2X4ge4k3VWq/dbTmx1MN3ryArERWdaMsEV/u+rFwU5BNwICTWYGR6vQPijAmw8W2jIuVM1lph6kAoz/UnCDCbR+8RQWEHcB3C54T2y7kpoXaQXsMB5CgVxlfwVHd4bf9xaLDAhoXlPPCI46REpJGbxoBnTi9j2oSFTeV4y5K0kMKKYzTq6YXr71xODD60dp04W9902+q5YE5lpnoc3eRqr6BhiTdiSFIRuCer2nWc7LxFanfi4OL3kldWh39zyoh+MY3byqYZQW2/rr4O4Bq/x/beGgGY/W34Oaam+vEzU7p9IzowDpcXkW0rOy2qW5BpX03ptXZ9X9LRxg5ZFH/otLViJ3cIxWPB+BLP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(19092799006)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(3023799007)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VgraBRECaHVtsVYaDuymaSNRm+tmqlT4GoBeQUsqgIQNgN5zqFuw0lLWOR6k?=
 =?us-ascii?Q?nZLmKNjmI+D/G/iejEnzmVlM0Tp+FjuZfpDe48OgBpkCVMPQiH30edKIpro7?=
 =?us-ascii?Q?pg4mJeR8KyQrZnxDKI2g02eWhMYUzFi5JL4ok/t/s3lkK03BGgSEVRfeKQX5?=
 =?us-ascii?Q?IlgK035OBPqkGA8Ld50SdN+k2aoqF6MYyeeZoyUe6U5Pay1ScFCEnmKRfRjb?=
 =?us-ascii?Q?CI481tfYRfPqHMQGRPIByFjb0UDSvXP8luZitgUA08vIw+UMz4pdE7Wav7Jf?=
 =?us-ascii?Q?Xnn2OgPn7spIzazrEHsQiNqL9YWRI8UTPzTlFydBZNeW7CHVRamcBs091pyB?=
 =?us-ascii?Q?KwBIfbm8lcWyMsg3nywJ1UwAZeC5BtFI/QnO39iPvpkXel+4ayrQe15fMuFh?=
 =?us-ascii?Q?88X9PtBj4YGF/QbSRPcsHTXv02LeJQt6DKylvniy354wmrgU7HlEprnsPRi/?=
 =?us-ascii?Q?gTF8rQA8qOg3EGL6JoYndBICmfIBBuJNfRGqyB7/JnohnSkAJqk+XjTdq8j/?=
 =?us-ascii?Q?Nt7CNKuDlMV8sLeSVgqo4JSKXyViVibRKZrRiJgXn3JPS3BxzgBL70FyV3Sn?=
 =?us-ascii?Q?qsvo8RdwgFBpo5Odrjy1dtZmtDH/QAAziLIuctIYr2tzTcp0BL/RkScvfTBK?=
 =?us-ascii?Q?FXDjxitmU1FKX9b/0sz6Od7+I2pygJG5phl7gxrBQ3Fl99c+L8vkknfF50wF?=
 =?us-ascii?Q?JmcEOHHB+n/d2s8FC0HnTVTwT9b4PPJkBTesg7vc5Wm1Y5v1/tFFuRKdLLAP?=
 =?us-ascii?Q?3Uj8dj9XoGnjx6Y79yOxJ4uVc2F5Be52n+5nsuPgFlbI8rpzPp5d6K/JX3NZ?=
 =?us-ascii?Q?w3wlbKVTctAhU4QI5pbxDzatK9fG6fAu836AVhnm/uWgP9h0OgBpmUDhhUYB?=
 =?us-ascii?Q?9jpzb+qDHarBdRko44Vi/E/LJG3rzB6n+zuTjWrCZbOvjY+gmuqa7tyaLyQJ?=
 =?us-ascii?Q?rzn8F939zcj863MLGXKy0KuEvI9fKMrjIAC7A8qQR0/PsvJonk4VU+WGGyze?=
 =?us-ascii?Q?CBtqf+9KbOyKvKBEK+yWuBWEsRMsSCIL5e0SVnsPWR7CXCaGyVVtLzQvzEQa?=
 =?us-ascii?Q?OSHzgK8Q1fBZe4zCLKOVA5jlatj2y0786W1VF2HOXkS92iUGf73kD1wl9vaC?=
 =?us-ascii?Q?kRM5QqNwrp5aEHsloe50wBMA2vZZqQD86gjQFJXajidorXMlzroNVrm0vh3s?=
 =?us-ascii?Q?c6r3qqghK793uVAn8zGJr32/G5MflAf+cLE6MX8Fhy5URwx8SuJKzT+FJAJ+?=
 =?us-ascii?Q?B+PhT7eIc5pWl94OnKOLvp2QW827n7Qrhc6txkmSCl5XvmP1Nvlpdwea15g1?=
 =?us-ascii?Q?W1peBuzsks35i+9Ldz3Aq00iazBD2Q1xWgXz5M7vAeyHCF4xZiZ8Mv7gqJ1/?=
 =?us-ascii?Q?cqag0/gxZObtE9GWGoSJH0S09DlWwYuxHAoRu1q+6ZShbkGLfT7NBnSse26j?=
 =?us-ascii?Q?ECG9nNfb6KQ1jNadMXqM5tb5cXn6V8IeUHnj+uqpBF3Wehen7B8cJiVcSOTI?=
 =?us-ascii?Q?5P03n6oM9YvmlvCEtggxWf6J1zpHqXCaFZ5q3/ryEQkmUFNzPqrFeFxGpqqH?=
 =?us-ascii?Q?UI85ptcbYthvo5go8tJZFVSkfwco0eK/mvbGHHi1CZNZpAJNuDNApF4rt7cB?=
 =?us-ascii?Q?+a3kusRQRkBPNvIkmHM9HxwUfE8dOKlL8jerxm4h+1dWtUlWileQo5YISZqV?=
 =?us-ascii?Q?xEyxu4yKFB/kJTUlMqPzHvbw27F3wvp0txANoA7akQz5S5CbT1nLhdLyobwQ?=
 =?us-ascii?Q?a85Dn0ElqqqGLtB2KMli6gMTC/hUQBWHasf1983AgS3H9S8S4YQ70YcV9QGU?=
X-MS-Exchange-AntiSpam-MessageData-1: d/gB1R4Xp1dDV3kEcPJji+8vBDBsAfHZV8Q=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f70706-e74f-4611-4b3b-08df1415a5e0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:12:12.1694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w499rrAMcf9wCoq2uUHuTFKzJqvSbx+gE264k8hqFL7ZCUP2IEjPB/n/yozNSLSh2L99T8nYLtGtxVSEg43slw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9891
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

Hi Vincent,

On Mon, Sep 14, 2026 at 07:04:12PM +0200, Vincent Jardin wrote:
> 
> SRDS_PRTCL_S1 is latched at POR and read-only, so the RCW fixes the
> SerDes 1 protocol. These patches let U-Boot re-bundle SD1's
> 8 lanes at runtime, before the MC latches the converter setup,
> without changing the protocol number the RCW advertises:
> 
>   lx2160_sd1 100g4x25g   1x 100G + 4x 25G split (patch 1), both PLLF
>   lx2160_sd1 2x40g       2x 100G -> 2x 40G, no split (patch 2), both PLLS
>   lx2160_sd1 40g4x10g    40G port + 4x 10G split (patch 3), both PLLS
>   lx2160_sd1 100g4x10g   1x 100G + 4x 10G split (patch 4), mixed PLLF + PLLS
>   lx2160_serdes status   read-only view of any SerDes (patch 1)
> 
> Each mode is also reachable from hwconfig=serdes1:<mode> for the
> boot path.
> 
> Changes in v2:
> - The mode-changing command is lx2160_sd1, lx2160_serdes only reads
>   (v1 had both behind one lx2160_serdes command)
> - New patches 2-4: the runtime SD1 conversions for many cases of
>   split (2x 100GE -> 2x 40GE, second 40GE port -> 4x 10G,
>   1x 100GE + 4x 10G)
> - New patch 5: hwconfig and README.soc documentation
> - Mode names say what they produce: 100g4x25g (v1: split), 2x40g
>   (was 40g), 40g4x10g (was 4x10g); 100g4x10g unchanged; same for the
>   hwconfig serdes1: keys
> - Rebased onto main

I'm confused. Did you send a v2 when v1 was already merged?
https://git.u-boot-project.org/u-boot/u-boot/-/commit/035d68fc36b55e3d180d73209beab15a5b988215

If so, I think you should submit incremental updates.
