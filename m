Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CE4C982FD
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 02:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ED6C80DDA;
	Tue, 22 Sep 2026 02:57:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tYD0zaBOjIbF; Tue, 22 Sep 2026 02:57:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5E00F80D92
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790045829;
	b=sooKsx0L3cHY5RnRjP54w1F1NpnvF9ORbcuBWKdq41y7zlHC1PpdioyXYye0XNxHYqde
	 vAGn4f5y6AeH4xOZ8vKdTtQQ3x86zdv4UhlW1Y3aeWWda1cu1JdhURn2yPHph1mh0Vafc
	 AD2Tu0aDUJRXCY0Dbg5BKPY1Z6v4tTjhZ5hzjcVvoY7jirNagLWFZ6MOlguD+vk4aM0mh
	 NQrjwpHATkujl7zerTCphf4PiGjm3VJ+66DOxBxKR1sGG6rdx/yYHanxJVkYUrMpwBDM6
	 QuTB4WKqh++yI9WXNDfM2SNpFm0Y0W3kk0mODmcObTAtScgZ20c4wdlJjmUALff1Uqw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790045829;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=Q7FsPa2yoASNup+lNnKFdlqTiovO7QxXU0ACwxeMWxU=;
	b=QNX6moHoVMSE5+ongvbNnaeMPUKpzb7WHh3GArIwMbsfGAcqWvrGxMINBO3aXXidplrX
	 P2jfoNLxenyMh62UE80SlGCW1KmA4fZh8DajnBKgcKBwibGLkWKlxurCyWrYNJ50W1pGl
	 E3OS03MoIFL5q5Hg76R25Qf3ElMR7s6cEopgNQNFUBtoXorsKksxP9emkxxaCMS/Gftue
	 pXISzIksJVCBKCCjBHcYUyN0hpn8asI/3WKxT2lokHIw+sFQ/l8YYGzVxhHYneJbBl8cq
	 YQXPlnxBXCclJ0nJgG23rQlvgbpCZ0U5EvqSB3wV6tXut3/PXAGjb/4BM+x1DXw6o/w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790045829;
	bh=Q7FsPa2yoASNup+lNnKFdlqTiovO7QxXU0ACwxeMWxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HDnlldhHZWxRDdz9RJ6Sp06VwTb8QWAQQX2MJgWq1R7Sz6jXYutBAt5H7yQZo6c9w
	 MRPX9BPo7DgzVmsP4RzKlAWBsFxzw9UY+alKALzmGLQN1kPfH6OKqgdRZqRd1uZv+d
	 czv/PP9Wi/uQaFXKLl9OjWWGgTyHVpWi1giTCF9em1FYyA5zASt4NQpti5s9f30fcb
	 0JlWIc6FoCxYZTZlZkca+wbq7VlBUAWCYJEbJ9SPDEOEyyWqWy3lzi+aNonkvyavcY
	 cbiZWxL267ZuBst1AObY1GJ7c3MPoM6BK9CkRR5vbIQpBlMjXq1yNgv+AKiu2nVeCA
	 G1v+71P1eT9nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E00F80D92;
	Tue, 22 Sep 2026 02:57:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A404EA20
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9642460644
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:57:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pYf1BKM7prIm for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 02:57:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CBADA60642
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790045827;
 b=H8tSfye9kZeamfd+anSvmhVyKjUG4skKW9tZof2WR4yCHv1huMEVID8uwbmpVP3iCFS6
 srDlUqvpmf2dQMBWI+DH848GzTZJMq+dL8sk2jTejD0I4OQVbJbSOd43LGqc5ZTNpW2gn
 nONpylrkkzTe1BwC9RI0mayT2XbxP3/wnk6A/sOev9w7Xit4NfE+g94NDzpY0LM/84Mhd
 5cxwBvL0GQB9Es7u5zvs0lCj91raL+XsAPRuvqGtU2+aQi+OcUpnir7VrWmCYSyUOaTb8
 Kv92nY6Q44Fpfvg1VMA3K2s8slOvXy0Z0sVxera8pCtV1DSklnn+TuQK5Lx87eDRURA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790045827;
 h=Received-SPF:DKIM-Signature:Received:Received:From:Date:Subject:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=Q7FsPa2yoASNup+lNnKFdlqTiovO7QxXU0ACwxeMWxU=;
 b=OS+bC2ZM1wVj/wVGnGrCHtk4DjS+x4/E4EEKYnekMQsdYRkrXgtv27Gc4AW3q1A4LDil
 9D8DRDkBeq3c/0sPxUPZ9B6iz8dKvHuwQBJDwZdnUHmcuiWrUkmnae1Px5VBdfHmnxk3X
 30R5NLBEXeOREWEmEyewKHwbVf6nBuEJQEiMK7wNa+hKlgyOZskDZh7r0f2Fh7eWhoTlS
 dXQ+Wc37CMLP7zEn9e2zEyRQ8PCNggnM3yD2U9faAMDVRf505TT3hIEbu7KE8Lns6wewN
 VpDAAbtkhbgDpCuzlZ3Paou8HZka1IXhxG3u/6JmnFoq0bNSM3yQlCn40B5ybrvGtBg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EzfrZM3Z;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=EzfrZM3Z
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBADA60642
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEZCVJuksZezKKN1I4BPSyBfl4Z8wLqWKSQI0YryYS/OidoOTfH8Dx9f79sInFFPfEdxa5WYGvtKo908mPrF/UqJs0NWnrXATk7//kPw0M2HRSQ+fBYeheOwWYcZe15iKYj/Sx739UziZtnNG53PWuCiSd/8eaL2OryBMmM+CsniAFhni7ZPm2jWlr/sfTDsGQ8414F4/6G6Nmmow1DyJtWCWubMQ2RwIsF1i9YD+P/KCo8D6m/zCpJlNzC3sT6JBsm2SubsAXP7q6m9gGWm7DCzrFO5K1Po4KRcxmo1UkJGAQ22a+qlwe7RVPVt3uErekMySsKunLiwhW6u0aSAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7FsPa2yoASNup+lNnKFdlqTiovO7QxXU0ACwxeMWxU=;
 b=Z6rvzP/PAVhgBxWIGHWfW470P7quAFv4FkNmnO/8q8uCYebBQPLOq9v2y4YjsallARHd+2UD/Ob7wc6Bi6hrX0f4mD0OuvS3nhgXD22Ew1xRKXToxiz0+OEzBW3anmGOms0f4BCXs2tG+cZhc3/IMbqPMhhI6mU/Ud9rtxpgMm7Bg/TG3j/c52SDW3zxqRNm0tBQB9vtQImnqfqYDl15zFWrDc8kSIsX7QvCa2gBsRrq9A9dCNxG2vGpmdR11+3voKES4FyGkCc/L9jPvNVP7mfKLGB1GHzYstoKfZdw41tresUfYqKHM5EiElIdJUf6nELLy5FX+zxBIi5yMMMrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7FsPa2yoASNup+lNnKFdlqTiovO7QxXU0ACwxeMWxU=;
 b=EzfrZM3Zr/Vl97H0YIThI/x4Y3O5n7SZzfj/J8PswRCVInNLRJpHHtCi6aOsHZENxfwFd8Xvroh0HTAEQb7CUexrf1jJ2xkLwL2ZNE3aTfWzwgIbK+PMlQIaGTgodycjT9+sy/iN/RiuASJ9ZEyw0pWx4QftwdhCEoxoo+tNfk7Grc0Pp7jehjHIJpiquUDWF1fI5er85G7Sa/2fB5iIDPKBzqCuZdRLFaO392YRoxn3Pbf63SwzoNZvYJdEVF2iWvJuPYC5FpyrIPivmiSOeuSW+Hts0cxCxMCg8cAPDAZrpijAWZI03Tw0eGOcP2U99EnVkECwRjHORYP+yssh/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by AM9PR04MB7555.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 02:57:02 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 02:57:01 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 22 Sep 2026 11:01:14 +0800
Subject: [PATCH v1 1/2] arm: dts: imx91-9x9-qsb: add U-Boot specific dtsi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-imx91qsb-v1-1-8f8b0ae23af4@nxp.com>
References: <20260922-imx91qsb-v1-0-8f8b0ae23af4@nxp.com>
In-Reply-To: <20260922-imx91qsb-v1-0-8f8b0ae23af4@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Joy Zou <joy.zou@nxp.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Johan Jonker <jbx6244@gmail.com>, 
 Ye Li <ye.li@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0351.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::9) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|AM9PR04MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6cb03b-0931-496f-c9e7-08df18552d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|19092799006|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: IupcCchShDI7IWj5eJDx7QYTfBgh4MQst2AqhwcHXYZCqLCN6RRKCeq1nDLDUtJ9uhkRPL3V9DIwLFo8kAwyJ4tL3Y9aSQcjHbXXtToajB0UHhRVM28RQlS6/S1jlrRd8LkNmE0qnDkz1rl7RHxPq5Pu2At4tazjCcShWPbch0iBgTlgkmlBFE7FYJyMrVVBKxwOStXV0foXKxxoaB2QHLBJ8EJ5eK0OjzMCqTnIyZtRC9qmjyhE0P78IB1os8IpLLBVN2U8o2DcGRsDkEg8pwlF3JzFW0gzkZXkkEyG3hANxlo0cobJ4yyajs6128IX9IBlrRCFfnbnn3PZGoeutq0bO11UH4nMLV3MNaBQQSZTxBArYX66t5yJIFeZoL4l+1eHLSIT7qumO6pLw1BBsdAYtSTrxuZWtFA/TkALcgLd+bwaQpMBOu0hutAoI0zU1aXNp+mzAlZEJkzyjbXO3kfgTVv1TB7gevZjVw+FPCF/K61DN6uoxTuZRWBpPp/QE25gezlsmFLr0uN4s1+AibOs3FKpshcgezZm9aESJJXmmRIcoFlC0ncAjLqoOJlGVuEcDH3a8m4uUJ5Bual8WynuPSy599V6YbTO7z+3A0DqVhe7ClgYJBzsbNtNSDZ2E4/QNSnTon9YDB1LjsMAtBCnB4LdUSyadcrqezNb1Lk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(19092799006)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SThCN1Y1S1ZoYzExS1kyM0dVbExUVEQ2N09LaWFPeGtmVE80T05kTkxoOWFo?=
 =?utf-8?B?WGlqYVQwM0hrRU9KajNHQUoyNSt5TWdabHFhSk9hNU40NVQ1YUFJdStnbzNm?=
 =?utf-8?B?U1hyWmwrTTZicGtwK3VjdkZFM3k2eklXcmpWVnpwaDByTGJvenpwRThDMDhU?=
 =?utf-8?B?OERHRDMrWDF3S0Z1RFU3bE83cUM2bEtTVC9EKytZMTJUazI3OURmMWFtUHFr?=
 =?utf-8?B?c1JnWU9iQnVNcitibGlMT3d0MmtPMnlnMVpETmwxSG0wd0x5enFiM3dFRFNT?=
 =?utf-8?B?OUZBTmpOZFdyenJUenlsSlA5WUVMa2hVWWtZcmxqb2Z5bHFoRHRLVVFXMW9u?=
 =?utf-8?B?dHV5MjduUTJSRm5BaU1yUTArY3ZWalZkWUYyN2EwSVlKMFBqR2UwYndzYTBz?=
 =?utf-8?B?TlExZTNaN0VVUHlRc2M2eG8vYXVKMHEvM1hsZWZjT0JGRzg5TDFOVGwwaS9Z?=
 =?utf-8?B?cUxGL3U5aXQ3Q3JFelR5R2R5UDNDMVJCeGxncG9XSVdydHZWMzhKTTdyTHVP?=
 =?utf-8?B?RlloS1pRdEgyc05NWTVGdTdkMGFndExKQmFDNG5scEdKS2hGSnE5eW9BZGRM?=
 =?utf-8?B?Vkc3b0Z6b2tGSDhsL0h5YkVMUCtKQWFGNHBFZGFodXhxVmpPa3p1dmxFWVlr?=
 =?utf-8?B?VXNqNC90bFM4eGNtbFJjbjE2ZmpRWmJ2dGg1MThkWHBHV1c5aEozZGN6RUhM?=
 =?utf-8?B?R1MxQVhZbVZ1cGlNcUNqU1NzekJDSW1yYmFjdERjVytrbWxVRUlrUFlkMngy?=
 =?utf-8?B?Z3hhOVB6VmNYUXlmejF2TXQrMkpOU3llc0UvTFNyRTByOFZkeHVFTnZNRWJt?=
 =?utf-8?B?eFdvTXZscHRGdDVIL0R6bXNmUGhyVHBYR3J4TTZCWUFOMmRaaEJYdGpUcERu?=
 =?utf-8?B?VGZUQTNobWlsYUYyS1NqUHlnLzlOcXc0Sk1GcDROcEFRZWRiMnNCeUxNRnd3?=
 =?utf-8?B?SlZpdjVmcjgzUkRVYUpnTlU1RzNvdzZLd1dYV3hZakdUTjJOZnYwM0hVd3J1?=
 =?utf-8?B?NEl4ZFFhMVlrTlI2alBGN05OSXZKaWFRNGRPL0dLblF4QWJSTXB3Z0J0MU92?=
 =?utf-8?B?ZlhjckVPNlYvNXVOQTUySGxTQW5lTEgxcEN1OG1Kd2k5cGcrYThTTUN1TFRM?=
 =?utf-8?B?MW1iK0ZlMVR6c0lzWXE0amNLOWNoZmpPK2lQb21nZi9uT1JjcHo3SEk0M3cz?=
 =?utf-8?B?SEViV2pjNFlpdUhqUExndUZJbU5vK1d1S09IL09DOHN4Z2lPa0RxRG9IUUIv?=
 =?utf-8?B?UHQzbGUyWlJNNkNmMm8vUzJXTlpnaUR0Vk1aWTBTR2lJTGxyYnVtMjlBc21u?=
 =?utf-8?B?NzROakNRaFB4ZGV0WWFHVkpMRko2T1hTdytmd1BJbGl5N2xJclFsZmdEbzhD?=
 =?utf-8?B?SkoyNmVicXRISlFtSE0rbjZPbHltTVlzak9xUXZWL0w2aXU5RGhNYW15Mk55?=
 =?utf-8?B?RUkrWHBsZWlWMnJCd2hYVEVCVStzRXRpdzVsUEgzU3RmRzVISjRWY3F6SUEz?=
 =?utf-8?B?UTQzSGhTMmVHbFBtQ3NoUENVTzM5NWI5N3BxSVFHT0lQN1MwS3FRU1lTcTRZ?=
 =?utf-8?B?cTE5N09yTTFRTU0rUndZVFQ0RlZoeG54VEptMTZGemdUdG1mRHptU2E5eUZn?=
 =?utf-8?B?WGRJZHJuRS8yNUx1UGZ6TG5tQ0QvNlJKNzJ5d1ZDbE84RzZFOWlGczlVK1lB?=
 =?utf-8?B?RHh3Y1JPUzRxcXhVb05LNVZqZEFHdlB3MXFxc2FSUHZZaHpXRkVacnNhRlpx?=
 =?utf-8?B?aklNdkpoOFJOc0tYSFU5VGpwc0M1UzFJeElkUUp2ZWFNaENMcU4vZlBaTnBB?=
 =?utf-8?B?TFdpZkwwcWFIS2c4TFk5ODFNbG83cURzUEFaMGltdXFSOEZTeW9EWUE1SkZq?=
 =?utf-8?B?U2l1bVRlR1d1RGdyNmNpeGtjbVEvUk14ai94OTMxZ2dxa0oyWTA1Y0ZrcWEr?=
 =?utf-8?B?a21ta053dVBhUGFpSFpaVndLSUdDMWFMZ2sva01FSVp5VU9MdzRvTklub2ZT?=
 =?utf-8?B?b0F1eTdzQkFkNkRuOTRPa0V1UHJFRFBHYVZkamhmaStnRncyaUhCYktnN044?=
 =?utf-8?B?TitDdkVGS3Nqc2NQN05GajRzRVJnZ0Rvb2l4a0dpR2djckwzNnJ4U3hEZ1Iz?=
 =?utf-8?B?THVqaFZFcHVQbzZxNTZxdkNOQ2wrVHRySEN2NlFOZW83M3g2Qzc5dEN2eG5s?=
 =?utf-8?B?d3M3bGl5R21Vbm53b2d2UDVhaExMVlZmSmsrWXNndm1QYWpFdmU0NWpPZHdw?=
 =?utf-8?B?TkhQc0RDeU5kNmhSZTJxUVFBZmRiMXJrVnBJdVBKVWZVdmE0QmVuRXE1YnVt?=
 =?utf-8?B?WVJrVGN3NExnckM4NXhTVXUrSEJDMTBYZHFzd3B1M2NGdDFuUlZ6MDduTGNh?=
 =?utf-8?Q?B0zSzaoRlXO0T1dGE7df+R55GCcq0X82S0adK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6cb03b-0931-496f-c9e7-08df18552d00
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 02:57:01.7934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYdOkAZHyH4pozDQXy8Z07CpuUU9P06V+CXYR2tsFi7GM0lgsPANkXK8ROmivKXCX7gR5vqhdRfOTfuZHOxnFNQgZvnuk1qSKPz5lKKdkqso5a3TWktKPVwts4G7oTUc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7555
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

From: Joy Zou <joy.zou@nxp.com>

Add the U-Boot specific device tree overlay for the i.MX91 9x9 Quick Start
Board.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx91-9x9-qsb-u-boot.dtsi | 184 +++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/arch/arm/dts/imx91-9x9-qsb-u-boot.dtsi b/arch/arm/dts/imx91-9x9-qsb-u-boot.dtsi
new file mode 100644
index 00000000000..d5b837d43d0
--- /dev/null
+++ b/arch/arm/dts/imx91-9x9-qsb-u-boot.dtsi
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024, 2026 NXP
+ */
+
+#include "imx91-u-boot.dtsi"
+
+/ {
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog3>;
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+
+	aliases {
+		usb_gadget0 = &usbg1;
+	};
+
+	usbg1: usbg1 {
+		compatible = "fsl,imx27-usb-gadget";
+		dr_mode = "peripheral";
+		chipidea,usb = <&usbotg1>;
+		status = "okay";
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+};
+
+&A55_0 {
+	clocks = <&clk IMX93_CLK_A55_SEL>;
+};
+
+&{/soc@0} {
+	bootph-all;
+};
+
+&aips1 {
+	bootph-all;
+};
+
+&aips2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&aips3 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&iomuxc {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&reg_usdhc2_vmmc {
+	u-boot,off-on-delay-us = <20000>;
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&gpio1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio3 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio4 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+	fsl,signal-voltage-switch-extra-delay-ms = <8>;
+};
+
+&lpi2c1 {
+	bootph-pre-ram;
+};
+
+&lpi2c2 {
+	bootph-pre-ram;
+};
+
+&lpi2c3 {
+	bootph-pre-ram;
+};
+
+&{/soc@0/bus@44000000/i2c@44350000/pmic@32} {
+	bootph-pre-ram;
+};
+
+&{/soc@0/bus@44000000/i2c@44350000/pmic@32/regulators} {
+	bootph-pre-ram;
+};
+
+&pinctrl_lpi2c1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_lpi2c2 {
+	bootph-pre-ram;
+};
+
+&ethphy1 {
+	reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
+	reset-assert-us = <15000>;
+	reset-deassert-us = <100000>;
+};
+
+&usbotg1 {
+	status = "okay";
+	extcon = <&ptn5110>;
+};
+
+&s4muap {
+	bootph-pre-ram;
+	bootph-some-ram;
+	status = "okay";
+};
+
+&clk {
+	bootph-all;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-rates;
+	/delete-property/ assigned-clock-parents;
+};
+
+&osc_32k {
+	bootph-all;
+};
+
+&osc_24m {
+	bootph-all;
+};
+
+&clk_ext1 {
+	bootph-all;
+};

-- 
2.34.1

