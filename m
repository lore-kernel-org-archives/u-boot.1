Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5399ACA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 11:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF8BD605F0;
	Wed,  7 Oct 2026 11:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nYZIgm3QG6GA; Wed,  7 Oct 2026 11:02:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B84776060A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791370921;
	b=sh7seEX5Z29inF90xVAZt4LYR0rDqA/of/CJ+PVq/zf3FRMj1VFYkliit822IGDnrF62
	 iTvtATrndc/61gH9oLYYmC4trQ87LTfKUa8XMH03u/a0zO45rAGejY8kXpqy+YvXJAkc1
	 JHmryvy4eKa83cUfXJip0ASpPNCRm8aQAEFuhY/BU3S0lk8TZS8TWvtBEowHV8H7WKSmo
	 g3jeGQ/XLjixLJ9qYgvGzcec/jmG+0UbZDOm4jOE46RACTXvnY+7lbwGhfVIgNSZPUlNm
	 uB5L8MU0Pnd8GTlnFxz5MaY9kd++t/KlXdKOONUpPQGzO0TOOoHzoGfWVB1tWU109xQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791370921;
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
	bh=SjKT9DpfL6YjHjS9KwJQP6KJojDPQEjOqiMGEXJ1eL8=;
	b=T+Ljd3yJs6kZ8nSXcnw63kxgewDkTtexmh1wjI6hRpGq10mafgTQdjqsyEuhoTkJPuj5
	 BJCUgN+a7UP5dDD7mBZB0CmT9MBNVxFOKDn1eR2EFJv9IKN1zRXGzvEUWZTdu2htIUtO4
	 jIVd2ryVV6KZ2NmqccMJBwkUkHANCwWt667PBpfPrMPqVTg/zFzexLMi4ut0njfAVbm+k
	 mTQck/3mdVzFi8FHLxnkhSUHKhLXNiTWq5LY3nAAjlgsNMaiSiOU/VH1ZiuAJc+tTcE6f
	 yhjCJFR1hILAZR52okRJB58Ui7P1qPWyKRa6frZ+VO06EpR31sA7GQBNC/4lbQFl7cw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791370921;
	bh=SjKT9DpfL6YjHjS9KwJQP6KJojDPQEjOqiMGEXJ1eL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0n2Xust+59Vnfj5ytHQorW+tgpszBjHDlItKmnW5aCIfCKsbS3IOc8Z951jbRcpdi
	 o2BxaxUhfZBxedVF69kDXkwqW8zEU74LwlAg8Zd9I2ccmGi5N0WNWtjO0H4Nlo8hY8
	 hoCeWuJUDqa90Az0enpsDhqR98mmI2XGdB4ZtKylmZTZPLr+H6rNmjEZfKMWnUW6ZM
	 kRlqCSoerHES55aolqKrzRLeomseYtGS13Ns8cHEy4ynCJzzYoLOK4eqird/9w6sPg
	 b5wPSaE7cLLXiCNOpjTlLt0Xv4hPl7IFhRZ0HiAK5TfFd8JJHF+kF5UEIqXaIUsz6n
	 pX9PkXueYKQYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B84776060A;
	Wed,  7 Oct 2026 11:02:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 23AC6317
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 10:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15133405C3
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 10:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GAwSK-xLtuGx for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 10:47:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 99403405A5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791370075;
 b=ds0n/PlZzoI2navdAm0aqD4P7PJbQ93l0+uz7BCj5BDwTcNyanePYXr3xUt3/P6xl81p
 GjQ+kRSwQ+L4F73UDNP1dq9i+m8vQ/oEuhIamwtZXN1Y/7wew6CfRLtQJuEN/ac3r6Kw2
 gynjRUtyUUdB0seziTuhEfdEm4yQboxB+3CBzrObE6T7E/leGwE3I6WMwWUN1mpwbqbWH
 J7THxRmdYkgzVC3oYEaQggma241Pk/yK3MZwGVhCEwvaeP3fMnJ0WYT/SQn19aAOJHX3M
 MTXXM/z+aXwBoUUK2isQkEtQLQw7ibsmp/vOZ2sgohdz/b5vyw9OgBPxUHn33QE++TA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791370075;
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
 bh=SjKT9DpfL6YjHjS9KwJQP6KJojDPQEjOqiMGEXJ1eL8=;
 b=Q3fOoYZdCPSgOAe5q1ns2Be5Jp08PHGqUnZCgC3IIyUz+Yx779dlUZV6QCvBAmIoftkd
 E2bfLGrxQmLzK3kTJjHE6K+x2Oo7M0wYb50/w3wENfCtSalR2F1coQnhVm5Qj+3x3/bUN
 k59i8opqXtoQUIenNgDYcw0jpM1YPPBDm1xU/8KuxqrN+02a5dv3aAC7ZUheCk9gJIbtR
 /T/ZkPC6CUIogUOyIBJr86E1+7tfbBdJEqINfJwxzP7HMJ9vShH+EO92/gdubb052Pdtq
 QE1nMcQvDnDLvYs20vUst/Wh2KTSO2nwSciIiFFCV3rv4T9hxkRKQ/mCjCFpzBXAugg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=OoCGipPG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=OoCGipPG
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99403405A5
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 10:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKTUEoLpqBnBUGvjHaWqM5WZbbojxg6qF7EcALu+DSo5llOOQIfKhL+py5dhBoSHpeNrt24XBvZU1gcgtvPKdqQBicJILJeQOSKrseY4lCaMMM3fN324n/SokBv6+z19kOLegWWxcbj/O3escupOGvJqiog9sJzPhFoQQ509I4vJ1OlGHBLImZGk82K5etXVF3QdTl1QybmfSmdRqRr9SnmTi4G/ZHj+A26WNLeaQHahIlZSB8aevfOyC+xN1GldTnSuts4AjNIR0ctt6pm7oS3VAMardHVu0JW3RJF/xSKt8lNu9yt0QU2CtLtWcmIvrjGrc9SQQO1SV4AnOB/bDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjKT9DpfL6YjHjS9KwJQP6KJojDPQEjOqiMGEXJ1eL8=;
 b=DRS6Pi71omIAUUEdtSpuQSdO7c7L4GoBUmjTmOToRKpL+46wfZJjfCMEbGJM8BrV/4zl05h0VcoQ3x2FxtZEzO2GFfx3fuQg8ZIU5e7snovnlKf1XV6X4+2qf5X5i2ou7DLkAihC6JFqnSSjrpv6rSJOxtMxtw+seKkm2WD7KQCjQ92loFDsCTlW3GhsEJB0kmG19B0dMhYMS47nWHr76UXqpToiUXPXfwCKVdCSmfqmr5zDVR02uP8xOP9eyTL4V3fJqyodeSCL9T8iploWl3yrZLgg640IOR2KBPWF8jieqQcij0ylj09+eJYd5QTgYtqPz1f254RyAHtl9un8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjKT9DpfL6YjHjS9KwJQP6KJojDPQEjOqiMGEXJ1eL8=;
 b=OoCGipPGwmM1preOUvarMnlljPwihclqKXVqK3hZsCKUZprxrggoaAj5ydrAgtW8zVM7tB29QtDWCby08xTRMDH+Fzr2QDYLzDakICSSeNuWnG+eRLQwl+aqidwa+S9cf2K3lc4JPzW7vgV6no+Zc5bB253lIGvAlfymhosPTlrld/pTefspfo4qSsdC4ZS/bMlAELdYy0jNP/vSY7fFIU3eG+WRO5J2ZfPtyNtcJicM+VnDiMFU8Sg77cRR3OgfatS1LjUEUc2kBCIf5pVlLs3woxoDCgPZ8I7zZIFWGsNhKDDsvDAdfZNUHX/ArKCyLt1moxRPV4rdXi4m0qo2tw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 10:47:40 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 10:47:40 +0000
Date: Wed, 7 Oct 2026 13:47:37 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: Re: [PATCH v6 12/13] doc: lx2160a: document the sd1 hwconfig option
Message-ID: <20261007104737.siyopctt5alyeehz@skbuf>
References: <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-13-vjardin@free.fr>
 <20261001204731.1774613-13-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001204731.1774613-13-vjardin@free.fr>
 <20261001204731.1774613-13-vjardin@free.fr>
X-ClientProxiedBy: WA2P291CA0025.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::6) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB10613:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1ea8da-f171-4e3a-acb0-08df246068d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|19092799006|10070799003|6133799003|22082099003|3023799007|18002099003|4143699003|260925022911599003|56012099006|260925021311599003|10067099003|11063799006|5023799004|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: yHgRSTfJ+snGRRe/PYwsOkvdlExVFejGJolmnByITCBZRE8Kku1rLQ2WuPq0QfJdeS7IuJ82Bd0MwQb+55VvFb4h8L0tGHAhoKCI6vGep/fRoBpL0ndQJRdXDFSL+ee6SdhTqSD/VCgrWPrAaQZdMPc1Xpv7Yv3tYSD8nwlEd3fyOYUeRA4pcvDxM59M9iRnYCMI3z/IgqWgFbp0jxo7vnNc8UCquVYQYTVpjkVW3C/bhreRhrMwwJy5We/mVGCaTnmHoOoIXF9CnHbtVXRUw4FrVCGy56TfjF8PkLC2jhXenEn/bOTzWNDwA7vCepQTr6FBj/N8++GfuVmCqJllxzBWQHYuxJZL41Vzxxzstq0exNLHV90gkfRUn3nVGVZMbmDWbLv54q3PS4t8QHLkMJJieWmrIJTrH9QUYrwPCe/JOtf9LZRQ7uVH5nu4UylFnG0PNGfse3aLZPQBcqO6FtNYWDSLTo1vsK+fgRvxjB1fOZUya/ok7/H8JrlveTdlgcDm+58MUJXxvjAh79c7K97wqW3WSihuxusQw/sU5PCwklOrfdNJd+FrWv8ksbvowpeV5zI0Xqsk4Bdg7S3sGWFoeeaoc/IdOBYFPBY/j3X/7ZtpUCgxUcpw4vHozNh07jv9Nf94t73nJxTJ2eXIGVMZDM6OKbEpmfdASyIkgbFTlEJom4hR/Bt4aY2Td9p/1GpVSv91aBnrOkRK7ecqk/VTACmz7xDVUsaNQs8BF2DqHGG5ye2B1G9b5tid0GDy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(19092799006)(10070799003)(6133799003)(22082099003)(3023799007)(18002099003)(4143699003)(260925022911599003)(56012099006)(260925021311599003)(10067099003)(11063799006)(5023799004)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jQkaTcMe7g6GcX69YKMNv5XM6IcKshZH/S/S6sEku0V09aQM3ZUraLYtQOpc?=
 =?us-ascii?Q?kINyGjOkStJ/+mr/dWZnyk44znYI0Egwwxs0EWR8FMcmOC3fV091xjKr+7dd?=
 =?us-ascii?Q?UnbZe7V+DtQnp5/vl9/gbS1NLPcv5ip4A1NELw3IWawNlz8XQXCUGEaxGgCj?=
 =?us-ascii?Q?2XDVOhBqQWDvjerGGHzmazDQ22YNszgCGxbePHybl2u8tiYCyLRFA/pYidfu?=
 =?us-ascii?Q?/Ga7JakNhsFKGob+xRcNFjtGVzY+Nzxl4Fef+IJmm3y97HcRdKEtQKC+/gI7?=
 =?us-ascii?Q?YXgmkKo6KOpDHfHkB4/14RjAQu7jZnEmkZi/mCQcut9JvvUGFu637ql19t0M?=
 =?us-ascii?Q?hc4kmN+g+B5CY9xF1ZuqoVY+z9FiVmOlzh4ej5XFUjkcehmJm6FIuLyYvEGz?=
 =?us-ascii?Q?rWKD9yEbxCoVx7yBMMqQSuDy3csP9hMwI0c2l4cnyLDpTVY35OeFtbdV4gBZ?=
 =?us-ascii?Q?uetXdOCx5POwKxJkEVFL5qYyyGFnWFA7Dip5gJ4G2M0MelIZvNDEzwaegn+d?=
 =?us-ascii?Q?MRL5REPG611Dg3LHeEODKVq/RlYlak3P10cWdxGdoAth01cE5c+XHNZFNy+/?=
 =?us-ascii?Q?5KGHAEb2DGsG8ba87JhefHIqYv9ZlfDW5Hz4sTNi0mZANlnuDgsxYw3uL9gh?=
 =?us-ascii?Q?T7SGmvk/rtU7FS7oiPOGJ6R9kzQQ9EfiNcpOVYV1+1HUoyEWI6TU4A52s5vO?=
 =?us-ascii?Q?olliBwN0QN2b1GW/qqBFjxRcuxeISQ/sLZRzBXXfbm7zs/pvbZnKLOV3MXgT?=
 =?us-ascii?Q?2BcXvy+5/PwSfdT+mVnhR+1V0R/Mhh/hAUeLgl9gygmBJnZkqu7PWDxgvmae?=
 =?us-ascii?Q?AyPMJMFuaCh0c9SbgB/JRPklwpbqVouP2f8H3m0uVQ+Ot8F2JC3eprSM5/9G?=
 =?us-ascii?Q?M2Hea3LEb2pgiPbPS0ZWyrQhy7V7EEPzJYjCnhDGVB7ItMpcAIBGdpuqrfXi?=
 =?us-ascii?Q?lVO9KRWZrg38FuWYCl1hKcX5pUoXqgi+CPKU8exRmJU1wxGEtfrzqj8UgMww?=
 =?us-ascii?Q?mhCCddWDd5+Pt90JC7itBEG1U0f01OtrRvnU5PWHP3STBBTDwq7gzYu3tsod?=
 =?us-ascii?Q?3kvbO3+J78F/zUIow0h1erSeEEb+nF9CN3FjgeI7tXQV3ERCQ0y8f0TxvYjF?=
 =?us-ascii?Q?iw8v1aWnQfJxbY7CFs3ZhztSRjzUJX4b+xeqC3Ho8774eick7hR62roJLwrD?=
 =?us-ascii?Q?0INtBLIPSdzfvas/zwIu0ltXUBl03UWXSWEGO6RZSthAVY5I4fcILJQ91zy1?=
 =?us-ascii?Q?/w1HJxPCSX7kkXUWslvwMn4d4su3oUTHp+fXpw5HvVfQaAACtBJ5Wk9Gs9g6?=
 =?us-ascii?Q?VR9yKpIpL1vrsDcrYBqTSmsdkV97ifrKWxrSvitDhPQ0nsrMi52wdpP2zqcp?=
 =?us-ascii?Q?R96OGMvTs+1HGH1eDoUbHi4hFAbgwh/LzXCI2e0q7vkBRdjfJ01Z1o6FUiIU?=
 =?us-ascii?Q?AAgsjahAh0y0KJ4UWlzx7sX+YUe6GT6xImeEpP6zAXDdKRKtAJF1RgK2ednp?=
 =?us-ascii?Q?b+Ml0qnM4WjouMVou5GJySHmOPBiJWMXhFU50yfbzo408XgS1QUK0N28yp+a?=
 =?us-ascii?Q?wNvIFrEAPUqb3FxMQMsQH9iQVw1RvIycV0lEuWcPmIDg5rroEVPHTbeH9W+C?=
 =?us-ascii?Q?ki6CTN2NQ6xvmmXKA4JFDENYlwAnZBsGOm8AP5wcBGMvrlzNSgm5HI4BHuuE?=
 =?us-ascii?Q?rNM/k1eF2c13gBqopLbEDTSbbIousG4cvi3AYmt3U73D5vsTn67cwIMkWLmB?=
 =?us-ascii?Q?vGXFwEULBZKVHE786pWZShdxAJZjq6BuXd+6JmCUJl5jWa8tU4YxmkiurKt9?=
X-MS-Exchange-AntiSpam-MessageData-1: jgM+G8X8eq7KFQJ7Q+3LHIKqxZgjs1mt6AM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1ea8da-f171-4e3a-acb0-08df246068d0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 10:47:40.5900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPJFcN4pI4Xo3+IKkI6TdZtylCZbWBrn6KKfI/L3w3zrrdK42q8rsgJatlRXVamjq5P/R7jH/LMQgjKz6JPYng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613
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

On Thu, Oct 01, 2026 at 10:47:29PM +0200, Vincent Jardin wrote:
> Enrich README.fsl-hwconfig with this sd1 reconfiguration scenarios.
> Add a reference to the Layerscape README.soc.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---
> 
> Changes in v6:
> - Only 161.1328125 MHz PLLS reference clock is supported,
>   from the PLLS input or through SRDS_INTRA_REF_CLK_S1 (Vladimir)
> 
> Changes in v5:
> - Reword the grouping sentence, suggested by Vladimir
> - PLLS reference clock as an initial condition
> - Drop the MC bullet, and the list of boards
> 
> Changes in v4:
> - was v3 5/5, rewritten using a table
> 
>  .../cpu/armv8/fsl-layerscape/doc/README.soc   |  7 ++
>  doc/README.fsl-hwconfig                       | 64 +++++++++++++++++++
>  2 files changed, 71 insertions(+)
> 
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
> index f2efd4cc1d7..a641e4978aa 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
> @@ -331,6 +331,13 @@ LX2160A SoC has 2 more similar SoC personalities
>  2)LX2080A, few difference w.r.t. LX2160A:
>         a) Eight 64-bit ARM v8 Cortex-A72 CPUs
>  
> +SerDes 1 lane grouping
> +  SRDS_PRTCL_S1 is latched at reset. U-Boot can still configure SD1 before
> +  the MC starts:
> +  1x100GE + 4x25G, 2x40GE, 1x40GE + 4x10G or 1x100GE + 4x10G.
> +  See 'serdes1' in doc/README.fsl-hwconfig, and the 'lx2160_serdes status'
> +  command.
> +
>  
>  LS1028A
>  --------
> diff --git a/doc/README.fsl-hwconfig b/doc/README.fsl-hwconfig
> index e752505da49..91bc39d7238 100644
> --- a/doc/README.fsl-hwconfig
> +++ b/doc/README.fsl-hwconfig
> @@ -44,3 +44,67 @@ usb
>  		usb1:dr_mode=host;usb2:dr_mode=peripheral'
>  
>  		usb1:dr_mode=host,phy_type=utmi;usb2:dr_mode=host'
> +
> +serdes1
> +	Specific to the LX2160A boards whose reset_phy() calls
> +	lx2160a_serdes_apply_hwconfig() before mc_env_boot().
> +
> +	SRDS_PRTCL_S1 is latched at reset, but the eight SD1 (SerDes) lanes
> +	can still be configured before the DPAA2 management complex (MC) starts.
> +	This option alters the Ethernet MAC-to-lane grouping after the fact
> +	(RCWSR29 keeps reporting the initial protocol).
> +
> +	'serdes1:2x100g'
> +		2x 100GE (CAUI-4), what protocol 13 builds: nothing to do
> +
> +	'serdes1:100g4x25g'
> +		1x 100GE + 4x 25G
> +
> +	'serdes1:2x40g'
> +		2x 40GE (XLAUI-4)
> +
> +	'serdes1:40g4x10g'
> +		1x 40GE + 4x 10G (XFI)
> +
> +	'serdes1:100g4x10g'
> +		1x 100GE + 4x 10G (XFI)
> +
> +	Each mode starts from the one in the 'from' column, which is
> +	entered first when SD1 is not in it yet, and so on down to what
> +	SRDS_PRTCL_S1 built:
> +
> +		mode        from      SRDS_PRTCL_S1   lanes run on
> +		2x100g      -         13              PLLF
> +		100g4x25g   2x100g    13              PLLF
> +		2x40g       2x100g    13              PLLS

2x40g should have the "SRDS_PRTCL_S1" field as "13 or 20" as well, no?
Because protocol 20 is literally 2x40g.

> +		40g4x10g    2x40g     13 or 20        PLLS
> +		100g4x10g   2x100g    13              PLLF and PLLS
> +
> +	What each mode makes of the two four-lane ports of protocol 13:

Why "of protocol 13"? You could simply say "Active DPMACs for each mode:"

> +
> +		mode        dpmac.2 port   dpmac.1 port
> +		2x100g      100GE          100GE
> +		100g4x25g   100GE          4x 25G: dpmac.3 to dpmac.6
> +		2x40g       40GE           40GE
> +		40g4x10g    40GE           4x XFI: dpmac.3 to dpmac.6
> +		100g4x10g   100GE          4x XFI: dpmac.3 to dpmac.6

For clarity, I would recommend one more column

		mode        dpmac.1     dpmac.2  dpmac.3 ... dpmac.6
		2x100g      100GE       100GE    -
		100g4x25g   -           100GE    4x 25G
		2x40g       40GE        40GE     -
		40g4x10g    -           40GE     4x XFI
		100g4x10g   -           100GE    4x XFI

Also, I think a clarification is in order, that your SerDes1 protocol
naming convention needs to be read from right to left, compared to the
SRDS_PRTCL_S1 table from the hardware RM.

> +
> +	Initial conditions:
> +
> +	- PLLS needs a 161.1328125 MHz reference clock, for which 2x40g,
> +	  40g4x10g and 100g4x10g program it. It can come from the SD1
> +	  PLLS reference clock input, or from the PLLF one with
> +	  SRDS_INTRA_REF_CLK_S1=1. A 156.25 MHz PLLS reference clock is
> +	  not supported. With protocol 13 PLLS is not in use, so nothing
> +	  checks that clock before these modes start it.
> +	- The MC DPC must set follow_hw_pssr in board_info/serdes, for the
> +	  MC to read the lanes rather than look at protocol, and the DPL
> +	  must use the dpmacs of the new grouping.
> +
> +	'lx2160_serdes status 1' shows the resulting lane grouping and
> +	protocol converters.
> +
> +	Example:
> +		setenv hwconfig serdes1:100g4x25g
> +		saveenv
> +		reset
> -- 
> 2.43.0
>
