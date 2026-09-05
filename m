Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2E9C624D3
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 12:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 192DC40C89;
	Sat,  5 Sep 2026 12:49:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c06nqYPPmKOn; Sat,  5 Sep 2026 12:49:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6283140C9B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788612542;
	b=URN2jeIpoWgMKkaAGZCecm1RthuLpvikB6izj2jabQ78/1kSOKhUshA4RYn+rHJslY2I
	 4Z/ck7agZeoD2QKQr/6uYciLLG4f/t+S726GMFRK2UZ1gM1VvLwU+Q66oSpIoMFx8iOes
	 KLvohHfcoYRcfVWSvoNBXN0FBa32MpCExm/duPAc9lNGhhrmpB/mkbO1w5fZBSnzTWZfP
	 AtxuhjtMrRyp6Gs3rQyY6RRGnyKJEmDdVcx10ENBi9+A4w0ihqJnmwawAJ+1ElKG9RRGc
	 AzBUdOFgQktFfUcsrR5hNxDNBkRw7nmI3Oz8ZGG01CKBcdiUNvEIwig43cUhOuEi0Sw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788612542;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gjzSDrK3B2psAFv40UwPEVIrSs8UBvDJ5TfrIx2Q77s=;
	b=DKUW+XOWP/3SPmcfpFOMT6HzUSgGsS0PlwWKBPvEYqhcH+4DBMk4ANCbQzK1nWxDbbWu
	 QFbM+XKetwM5bgcN0s+dowCX5de0lsSR6u980Bn6ipf6AkhZi61dTZQVR7t+vOzyED2b9
	 sa8hG66cNZQZ0DH0k+j9P/c6QiW5GLcTphghDqlwxhLNTc0iqG5RfGVG6trOuYWInCS+w
	 ZIIxx6HyK5d2vMOEFYSKVYE4sEC9s2gpQtExKXY5A1mvvMCZXki+SbYsux54MDTMYdIUA
	 yMNccTwXBXnRO5220qFxe0QvzVzrt7uuOMe+nnBHE4FIWN4rzKJExLnISNJKOcL9U3A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788612542;
	bh=gjzSDrK3B2psAFv40UwPEVIrSs8UBvDJ5TfrIx2Q77s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CRJZ1YXUs0w50uYiy6nk6h7csBAKHEY65jq8cvHi0UmpF6vn4++Eyh4A4mpi9yXLP
	 Lpzt2fJoVpk0I2fH+Bvva/3VzS8VOqaVqEE2YztGDRhZP6JIRSrr9SLPq9q9Hdu0ib
	 pNl5RljlTIGWvf2b/f1cms7dfLzGv36psxKzqAW9qfwByUYmKLJBx0eZHTwFkEy0Em
	 LUuL9HZ4GJngh0iEimUITAx81o0tnHpwycKy+wZFXMUMA24f6mAG5KbdQvfszMymE4
	 K6E2G6c3nhFIl9CEIALlK0pO38WnUJBbSTNpERQowU8NlAfcUA+jQ917J/5BCQh8vG
	 TDFYPpj9lVdQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6283140C9B;
	Sat,  5 Sep 2026 12:49:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 91B1949D
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 12:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76D5D810C3
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 12:49:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dn0SmR_frbfV for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 12:48:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4C680810C0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788612539;
 b=YHrVNY1Qw32Dsr4DEFxbY5+SpGvua2LSCcTlaVxsfphk3jwvE1oDhiTAnuc/8OFe0Cke
 X8weAt+P+eLz+Ysy35WhzZZ7aVkAsVI8XRryiI0uLv/wMUAmE8kqlT56fVNKQnTwmKGV+
 PiboNqDeMp3if3tY8KyFqn9cqtJc2jNyV/hAQK8CrWS7Q1OSf704wkwYBtmXh+KIFdHN4
 pZfnDYt+HGOz5fCDpTe7ARmzv/sK16FAbL1Id3GYQn1zpmdo7GB+GWV1GetOGcOF+raHJ
 QsS4pYT4RCbDHUh+qvFSOdHINAJDlnVl5FsMBU53r3Ge+BLPSzzk2Ygc/DEb/IkUpxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788612539;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=gjzSDrK3B2psAFv40UwPEVIrSs8UBvDJ5TfrIx2Q77s=;
 b=r3HlOI9c+mYJx8BlUaF/qt0tqlqfvXnCsDeQtfcctIpXI2nZJ+4s6kl16GalOtLDzJmB
 ELo6/qxXAp28dyFeY4bD1ziun5QFhh+Pc7SDditOeX4ebL44YYdTGIGRI8ijkXVqAv6su
 /OrxKn3nVwxlsl1XfHSBSjIaZvjoEFdmxlMSqZ5Qz5iayy3zQQTHv84BaMLzpgRVKhKMg
 +F6SdrrpCRI2RoUUdSaDBzD1XI7494VBwc2tIOEx6nloRhD0Iv9vaZxC/ygatmb5VH+KZ
 iv0PUBAHtMHP8a0ErxouIFhNrglGsKDdiHuXNZj1xqnc8rjul+4PyqdhKhsumsSJIFA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=O+xOC9SK;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=O+xOC9SK
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C680810C0
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 12:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7rqsBMil4QFTCtBzkw2+r1A45e3huS+NGrQRk76ZTgdYrivmLtwIGZimkWUwKYpYevNU77MQ8WxvQihqHD4kMZBZS+qXHhQCsrEv7AeXjdBSK1Ih//Mk16dYOi2q11hxYTMWGacZQRCpbJ7X2vk4lz+ZwkilT8JhrBR0+3Bjr7uAuEeAn6e2xWVnp9J35TNQ8boq/a8E6d6n6IFxS+ztfVJxZBbhxQVVNZkbc5n/a6XDEi6FoVmjDDLHPn5hPgb5WEJeUaE3Bm/HktlkXgZOLNS6Gv3VWFlKBW337ok/ecl+J1HDaTW+s6IyUJU5ch3Qmn+LYfEzmmP7yx28dessg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjzSDrK3B2psAFv40UwPEVIrSs8UBvDJ5TfrIx2Q77s=;
 b=rY3pZJ7EpuNoGpSVLRmeFTQu/o2ez+CfugEgi1COLbBzoVDcGc2Cw7yIsl1iqogYu3rJ631Kukj9DsVERWWh5dxDEHrcQd6x8yPbrVhV83xZwzTnj5b8HGsrkvSJOK0Ot7kHbqePLUPd52HH6cukjtgEmM7GdI31KanaQQ5A7nQlecyI3+RmKXa0eHOvEW6sJ6tl5a8RcIv3mYsW2Q/0aCZhN6hP22kg+ur3GRYxMCSDj8Rbd6QKRAAWbhEnaShXuJFSmP/3YbRO3c5smrEg9YdPIDTX79jgTjAB84CeQr1SdBrUzAQSrlJoAr+GLvkWbkBDkL1WLemlrVsGlQu3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjzSDrK3B2psAFv40UwPEVIrSs8UBvDJ5TfrIx2Q77s=;
 b=O+xOC9SKK+wbzLZq53G2vOZ5lpyjBWMvGRMweNMf6aqhOeoKO+NtIoxLoQRGaDWh8vt5IRgseAGMslv4snzMgAlNzmTkrYIQQOHSvYBsq3WuFw0drERfT9gOhgVCC8HNeQSHdZrKZ7JIZUXULHJPC6dZpIiz7xsCv9fLlKSU/mWAK4E0HYdCTTUuO2dg0RZIJfnsxGCLY4rsRf/dFGn/bkJswB63arx4HvC8bL1MBPftjJBjE/wbIZAlEJVeoThONeW+j7CgomtWjcw6ATDv9t5N9jxTTWOKybXPrFkdir9A39vohMwid0grhbCm9OWlHpeOcDtW3EYQfH8xy8IWCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB11693.eurprd04.prod.outlook.com (2603:10a6:10:60b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 12:48:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0382.007; Sat, 5 Sep 2026
 12:48:54 +0000
Date: Sat, 5 Sep 2026 20:46:07 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Torsten Rupp <torsten.rupp@8tronix.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.u-boot-project.org,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Eric Chung <eric.chung@riscstar.com>, Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH] fix 32bit silent truncation of 64bit offset in
 mmc_get_env_addr()
Message-ID: <apwPD0rMKoxENO-W@nxa18884-linux-1.ap.freescale.net>
References: <20260903-mmc-fixes-v1-1-946242839347@8tronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-mmc-fixes-v1-1-946242839347@8tronix.de>
X-ClientProxiedBy: SI3PR03CA0005.apcprd03.prod.outlook.com
 (2603:1096:4:297::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB11693:EE_
X-MS-Office365-Filtering-Correlation-Id: c55dcd04-5fb8-436c-0932-08df0b4c0aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|23010399003|376014|3023799007|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: +rnRcgJMAGhJp2lMnBnzEO3yLISwKhTh5L02/sPDvjHc0eTYj1mpdTdxIH5TeWqRXqjLh1r65NPHCw2Bgy0kqKx2lrRj39gmmi2N6blQ5LHamF7KLvt/TD6Wo+E36kYq3gz3fhZqpaYzwuXxgDevIbLBcROkiWvbygBI7dTGI3na+4uhdG4Uilztd52IJ0vhrBFkicD+zHOoyk/+NmpJm+q4IHAyff1jb6nrEoPlWkH/MzD/1DVaMtpxGxUGQHb/UjtK1np3tfSUBVLMkH93NS908eQY70LTrTCVe0Y5Ozeu9fXqF0IaXulwr8fxXeKobM/kJXL6sp8FUNgiVznFb3bGGRnpO5DSrjK6T6SB//h4TOw6Tl09ImF8cMJauv+uErHqUuhiIGMA2Wo3u8yK0Ky+v5TfNNawpVh4u9v9I81vBbnUeebELCIRRi3VX0ImIDio4/RFIUuh36q11QCof8qI5cqY4YMkqSU785DBcEfGAtxExwTE425qKnWgdr9CXeybOYqeMrQK91dSMxjDUk4t3EFpIKRyUjs4MLsUb9FzDSAlyepMh32JOxBcSNwQ825iFsY/iDIsnCvpRo3OGF2BgP3t89eTTpY+NTDZyzxVY6XNF97HHpXn/h2xMuRITeIj9zlf5Fo2yc4ENQLv0HkktQLU63E5ni5HsxYnjsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZUVgRpuO8RoNzenwZnv+sLT1Y0sxsNFZYI3oydIERObLGvHWzTektqUGtOX?=
 =?us-ascii?Q?QtiM8DhOIY1NwHNW7bf8NqpCgPJnrZ64nxS2B/lyozJYSuZ0QkDc6TrZKgbl?=
 =?us-ascii?Q?MwgJMjFIkefaZx0CH+gGBqiJslYPHQZRpQXPFHtyosrqugzMpt0hxYAqTeRT?=
 =?us-ascii?Q?s/C9mF5AoAYqCrp/IyqeAmzFMa4Ufgt5PkS3DNqY08+Wg8R4F66il5oh8/+B?=
 =?us-ascii?Q?WvY2owbmmf2g4M8wqEhA+RRaoG180+sNqSsLOeC3V9HumuKYwVGInrKVF93x?=
 =?us-ascii?Q?1zDzWqCWvwTMN4yE8ogzfNIW+f6H3bAfbiJ+mJr8f9ZdP5Pjz9SS5MF4Pl4v?=
 =?us-ascii?Q?J9RvU2F9kkOyx0v6nesk/mpx86KQyaleafpvNjLxK0jnuroMMqf9mBaRgw6y?=
 =?us-ascii?Q?yL8G6BVqpFc/jMx9FPHKm9wOXlWlqMTHCf4fHOQtQT7bTXQe7iVsbjwQDYpd?=
 =?us-ascii?Q?xgTmqxWDTqjBuhH6yPLVQ6ns2dZViQy2v0jxtFjZDsKM1JGXA49YBaW7hs1S?=
 =?us-ascii?Q?MyDwe4S4O8PRqaXsH1/3rQQr7z3UvVm3jvZ6mwK6J41KAuLcS8mRq7JAfrlG?=
 =?us-ascii?Q?0YuzJy2RkLzcbkLXdSrjP9yix0vqEXPNO2hg1UW+Iig3ozRCIUKl5YF/VWDJ?=
 =?us-ascii?Q?oNQ5dFiYUp2wvdouDbZpa31HKs8wavYKacbLOiTR22UcXyuGGSp4e3dOOMuy?=
 =?us-ascii?Q?d5MKvAmGj1AzrZ7PzeUrtS5hcpM8vMV8pQEN3AqnN2ZikuijIWst85j7kAaS?=
 =?us-ascii?Q?ebDtzZ3w6l8GE9IQCD5zpLqwHElFsjvhfDUPqyeDIqVKPIDfY7apr6AqdGAN?=
 =?us-ascii?Q?zpI7vWLgHoa9yF1TheawQSW/+fTaR0gKffnE6DcduVw4IZG6kwcw8tetHNFo?=
 =?us-ascii?Q?EkX95yQeCXAkolL0uTyJmciOzH6roY9X/TIA6mtbO0lP9GuISC9JHb7x1lgQ?=
 =?us-ascii?Q?d/0yrbJ1bodS7d+KmlaZJlh4MbCqXZW3A44w0WQZ6QBJ9SYSF9V5+WN2X1Q8?=
 =?us-ascii?Q?iKiAzq6rRj8QYbEM2cSx8NfNvDJ9OSRKxXN3IHYKogsDGCVwvnQEjMRGfa/k?=
 =?us-ascii?Q?Nq37+2I69sWH2ffw8BjsavqwxWSMaiOBWPyEd8xWVRSli2CsFIYmHqcwzHmD?=
 =?us-ascii?Q?4crJUVHuA6eJePB7t8Swv7fA+rk/Pg6682SAwsQJi22F1etXDf8tfPx23ZoE?=
 =?us-ascii?Q?V4fjqb2uRV3Xknoe+g56/0y4QEkucHmq/orpiYnRPQu5IEG1aeBwk2O2as2t?=
 =?us-ascii?Q?rq9amYJEEwp9HzgizjF60za0LgEKFt/iOjH23REzM9UE2Y/spCr/e8Xz4Y+n?=
 =?us-ascii?Q?N+tBoM7i2v41qsuqykkD+lJzAEdcBo+dge09swsc9TtmTwBDhak6lUDX36TZ?=
 =?us-ascii?Q?5qpotK/lznEq8a9JRUIzYllQEkJRPuPY09ggkGyCosvQfL/VCW2sQujgT+Ms?=
 =?us-ascii?Q?GfZEyag/6kAs6CUKmqL2VzikJ9gLNl8q/+3xTZQ/mfCwwCgRFK73Qw/LK4NX?=
 =?us-ascii?Q?JUcVQDxT8RndyDp9qsuQnPS8e8BuQauYrbLNiYAE1aK5TXgYgDkFiaRrPUaE?=
 =?us-ascii?Q?xYnugnaSMwMGVKVCSmCCUDrkAu/aN94ccIYdyras+BmN8FGr5A06/NCIe2Jj?=
 =?us-ascii?Q?2ml3r0h1LXBNm60REoH6XWqg/kPaUNzJR1AbFnG6kt9u3ePQabAXqPC8ZyFv?=
 =?us-ascii?Q?ByTIPCYw/TxEVAbOiK+hf6MewzQYu+OIODrU+PnnfXzKIPV3qv9uauCZ7C+y?=
 =?us-ascii?Q?zVNXdGNORdCMTJXhahGTOOXUavoIcodXmpMZMmz+LTBsS1gIDzZe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55dcd04-5fb8-436c-0932-08df0b4c0aff
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 12:48:54.1668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERCZfgPvaA+6bw293GZVSgGpUJLRQbx7kNkJyjpta2lUujylxyAYAVna8GREPAueR3G0w0GCSey8uwazbl3IsBryfz7yEp78BX9iSc8lpLxday7UJ/pxRKbx32bwvasT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11693
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

On Thu, Sep 03, 2026 at 09:20:42AM +0200, Torsten Rupp wrote:
>The function mmc_get_env_addr() return the address (offset) of the
>enviroment variables. Internally it calculates a 64bit value, but
>the value is silently truncated by the provided 32bit return value.
>For offsets greater than 4GB the environment is read from and written
>to the wrong place in e. g. the flash memory and may override
>arbitrary data.
>
>Signed-off-by: Torsten Rupp <torsten.rupp@8tronix.de>

LGTM: 

Reviewed-by: Peng Fan <peng.fan@nxp.com>
