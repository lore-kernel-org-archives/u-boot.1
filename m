Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE556C88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 20:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BB2B605FD;
	Sat, 12 Sep 2026 20:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cf-rkizd0Xve; Sat, 12 Sep 2026 20:27:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B053C6060A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789244820;
	b=pNoLnGUU1J39fSrm4XCOmS0wxSEcMi+At4uuXanZ+UdZxWcL1s+wofLlhUhxBRN8/yOi
	 gtwW/ba8VEMBdp0+jaieIipBmfsdKSAsh5kjFSre0Bb/x3zBg/HhkagakJTGfjxlqQOnD
	 FcAOGOlHF01ytwPb8sbtCYwwq6SqBy20CNUkd8u1F6Qv0fOCwIW0YEsOSh9rXx2+4yRMJ
	 FyBdeWwxjkoBTnC7wzEcenVKXI4J2IQnZ/CyR7Pjm8A+xWJLL55aHFI1swcdnr4PSbTf9
	 DzEfI6osPkSI8fOZlIQ4kMp32OjH7v7zq5rhhPPKarRdLh98LpihQuLOjwsl7ofSENw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789244820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8dUk4BaabNEOpgYqMBx+IYFSwMzJ9JdxXxER4Es24II=;
	b=IdAO8Wg/DoZEzNsixumx/S8jX1T+1Qpi4ap8pnOUbu8Ji0wurShteXowT6UWVPdQWHch
	 Af+MilLe92pCq6UdfsSNgs9RkiIT1/ory6nTBlGTfEu/imnXe5l+8R85JRB5WF5my9/7q
	 khrfLKD0rGF+XuU9Na0mbPy04FNwkT8bAnrIM/ncz89mTA2SqUmmWUbE/zrbWdj5b6BPD
	 dgOr1/HOLzE+uPnhvNsVGAxzoQTE9fztR/4rLU+wLwRsiD4OBvoh08LP4RSdR0JRXeN4A
	 QsFOh8mKhRRvcDULWlSzuZTEhA47piifMm5R4cGwXCVK1ZDKsKtdhd7pZ8PNcBNN9vQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789244820;
	bh=8dUk4BaabNEOpgYqMBx+IYFSwMzJ9JdxXxER4Es24II=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wdHTYTPL+Kdp4QlD0OjuuB4pl0E/C+HO+M8zwlVrwCFtrvrjCPC4b4VOYZ/46ESrA
	 bCHNq/tvHjcSj8lpJYAxfzLJCs/3e6wKQGkKTc9fz+tvwf0Q9NHyR38m//HiNgWWuj
	 JgZtrCFHNorzE7H1VzFGEdLnVxh8BW0oMT2LgcVFu2IwJ1myC48qr4lkuwEeHxh1R+
	 +NPnONGQLUXL4CGPYx/aryeW0475bEgHpzSEQkipSRoI6xt5uCfyy0v06PTPoiL/Yw
	 7YruvHHDjeFQDvjOC1Mzw2D52RQhArolYMU50ZYowaqPkknDCVSnoA9UR/GN0GMHCe
	 r+0DlOIK1qYag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B053C6060A;
	Sat, 12 Sep 2026 20:27:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 539A232F
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 20:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38A9D80E57
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 20:26:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EhYMM7fkyDyG for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 20:26:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 389B480E55
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789244818;
 b=W3hOaEyZ4VmL0s6vgeWGd8lmAHO4UrzPYL28MRKSYS/e8Oyj9mZ9zBP46d35agkH1ulR
 nw+EzZ1uIi5M3antqfTqOwC11A2PdHBwFURTwAX8tFwKu7dM2QiqRnpQ0Y1mv7GDJ1BW1
 7RXtvVOspRoiiZSlwfSzRc2yC00d7cjAB10wmG1/Aq32tNKEJEZfrXZCbBOcYa6dMJTDt
 I+PgYxNIwDJio0vPVTVuN+t5lrf7amyz2xsfxIlcesq88Ktl+0KmvDa4+BOWn0QJUS30K
 /9T26Vnr1fEUJIcqb5Zp5/kYv0xqaABc+AnQeAoscQ5qr3DHGlcI2YIPBI87zLn9EPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789244818;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=8dUk4BaabNEOpgYqMBx+IYFSwMzJ9JdxXxER4Es24II=;
 b=Qbo79z4Ay67+NkghVEsw0UIjw0NNLdPNR3igrXz4vPSxbKkMbKrpyCuNq5VMwck2p+hm
 J5+nFMtT+zY4lXZ7q5SuVIl2dSgngmfsZs4m45eBfzx5yQJmhFGmsfib3+WR9RPQCylCL
 VYoAQo1qufpskpgi4x07Q0hR40J1aslWp6cruPI8w1cnWtWAGqaS1bnV64aUCsEnUYNJz
 BJJXL4eZjW9oAHZhRF9pBDz3mEeYdOIsvBG69Pdn0TCy0sgoN5vqL/NmUd3SdJioB2/gv
 f1nvG6n9cAmO0TudmP1v0CERDErZiXpPZ3k57GuUsDlV4FeAJXqwcQXXWRhApS0oM7g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=fjS4urQr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=fjS4urQr
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 389B480E55
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 20:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsiOhtURvju67FL8cAwsZ31/r3MxSKn3bVq+EzOqrfMyPXhq/Rh1szXxtEruogqtGcswfMYewU/dU3uhjdDl2cthy/aludSSv+agUTGNsXFDXxUgGt+ALDwxPxCPpoj932/nHlM9ANU+I5AbrvOcz34mM2LjXezLxHQArPWKAe0un1fJ8GTBwiwH22Tz/ie0KL76DxzQhBR7wwyRQw96xnrJpGv4hbZiDeTuXlC6TQaWXmfx2u01DfQGh2fRj3q5GsFg5VZSK32JQG9kLomy1pvo/VGep52PNd7cDppc1D6WYUMGjVMf+7T5+/YWiGa/l3BIiBHu8s7mdFNQtRcfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dUk4BaabNEOpgYqMBx+IYFSwMzJ9JdxXxER4Es24II=;
 b=uKWmKdjbqSzDJwpu2BKvZl+i/cNk43q9eLTS7LKppI3YHuDiC8rz9d0caV/Kbc8tvTaDzQzrdj3nf80XVnka0jRAMHLJ+rgpqgVb/y/r9cvyBXT/ri7KHRev81zSQDTmwkIJeRA39/kZVw63U+NRsBocewrsP2ZR/j6DwQIesUf3yXNM8VpCKlTWsR6PONE6GLO7yXdE2ObOPUx2ynLzsPZJwAvF66IzhcABJyTELieF9YFJcp4O+Ve/fhpHZTzLXoUmzw1nBimdGiavyRYoRcpq9Fmd1lHEGE2HblwRx8h8aOZ7qaQvCsol4ZXwQUJ+uRBdAUWHlOYdcEpX3Om2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dUk4BaabNEOpgYqMBx+IYFSwMzJ9JdxXxER4Es24II=;
 b=fjS4urQrMydfKwa4pmS+Ut1y1Wg/Wjq/5VrrM0EZ5cmfQmg8kv8l6lCMIXuoz0oWOpLEiZfGTDLk4nQarQzBGwwNCnmBHBgniuXUOHhPALVlaIvZXJdLpe9u7MwoKLS0gBwxGK/jy343kkRyReGIhvrSKUE7dpIVRtGLN0qCAPtr1FtYq+OGAPXabXs8X31dWUSr7hORSpfcLVPJ33L5yW9wB+dEV14dBZ61XBdD/nQfkplVb0Hj8RmVGixH+p0xwuUy6+wpAYA74ZrQO/eW4GHHmwqtieHEe3AKCgr3pDB8FjaWP9DIkMYKrbt+7QeyDJWQnCtYYT32th1aogepuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN2PR03MB5055.namprd03.prod.outlook.com (2603:10b6:208:1aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Sat, 12 Sep
 2026 20:26:52 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 20:26:52 +0000
Message-ID: <36b56284-0b29-4830-9eaf-9b594cedf8d8@altera.com>
Date: Sun, 13 Sep 2026 01:56:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mmc: sdhci-cadence6: use const PHY config tables with
 per-call overrides
To: tze.yee.ng@altera.com, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <cover.1787710268.git.tze.yee.ng@altera.com>
 <7431866da9cda49057125df1b28986f04d63e168.1787710268.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <7431866da9cda49057125df1b28986f04d63e168.1787710268.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::20) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN2PR03MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8eed38-e912-4e80-1027-08df110c2da1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|4143699003|11063799006|6133799003|56012099006|3023799007|10067099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: eztrRhq41r7HDhccN52UduOwVMM9vIrpfxTVSx/nB+SPersg+/D1iqP/FJEcjdsjeusom+AkiJQwsOI6lB139akMYAhsCYhCPmIrivuIpO7humh6oqr7T4iSY2ZdU2m8WU3wIDs4FzhzS7dP8rm5G6LljNGtZE34u5A4XV+eShZUQyx2E0+evzSbndOSFouInvNiUeEotEf+tqX4THiV+KaBxuHJEvmymNCzxM/rtcpJ4McWQhIa7/fP68hfPDKnh/yc97oMgmoIB97DDzSLlxRceKwSC9UiRGv90vlxJeOYTVUMS0Bzce3rFMJcjEtWmACbAVMgCz4/zPIq2f2e9t9PnzG6hP0zhTnTvsK7okRrm4JzEv7McCF81bFKySJzFQpzOjUCROf3eEr6OjBJPZDPSQIOShvKdmhAWZOz6DpwiCZZsQKUMUsuOqm6Fzc01MXNmq1I9P8g1KFX1qis36NYCClaxDWGcyksQTClYgsmTZvJtmcQ66rLtS16Zl4AsLkBg/Z7IbQBIFP4rp1/kKobfhAdQS7ARlgaEFV/Kwr/HCr4J/jSLUM132MUEKC8/7OP0pNNSOHjOe1divzBnbT5kFOlkflrO7OXEzsqtMhMxUEo6CvaaCqi8nrVfVltXQnmyGU34tkBoK6EOQqoU9WhjCEtT1LsPHM3ec4qfJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(11063799006)(6133799003)(56012099006)(3023799007)(10067099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1UySGZ1amNObisyb084YWVGTStDZy9wZjVibzBOdDJmbG50UElRQUYyNzls?=
 =?utf-8?B?VmV1RHlQeUpraktTbzBxSFNwRWJrZGw4OVZJSzBlTnVTdWJ0MWRrdm95cnFO?=
 =?utf-8?B?TkxNS3JKOHpYbldSbjJlWDVpUmhlbUNXQUhJeDQxR2NWWmhKbnFlZTBxVk1R?=
 =?utf-8?B?SjVCVUI4TWY4UGFnc09iNUVSZWlHcEZzRm5iTDVMd0RaR0pUbDZVSFUzeUp5?=
 =?utf-8?B?ZmhQWndwOXk4VW9TVEY3dFNIYWxSalpEbXVOS3JrRXpNejJQYldOUmMxTjBs?=
 =?utf-8?B?TGoxcnZWa1RHaDRvOW9mOWpCVmR5MnFXSFdIdDYrV3lrcnk5ZEsxQ1BxTWow?=
 =?utf-8?B?dFFjZk1XNnlOSjhBcS9lYVE3MjE0SEsySjBZaGRHVG9OZXpocVVZRGc0YllJ?=
 =?utf-8?B?UzEzamY0VUNhUXhCcHZlWVI2T1FrTTVRUlp0Y25EbTFnZndHTjRBS3gzTzNq?=
 =?utf-8?B?TE9mTTNLa1drZ0M4R2RFUmpZYXhKUFNtd1VoOUhMSi9abWdRK1draitzTCs2?=
 =?utf-8?B?YURqVTVxVXpQbUR1dXJFbTdsZ1QyY3Z5NC9kZEs0ajJ6SlpsYTdjeXh3WHFa?=
 =?utf-8?B?aGx2cWQ3d0lOMEpjaURjNUpGbUFrYk0wamRqVDRPS2hFWTQyZTBYSGlRWUda?=
 =?utf-8?B?eU5aVFQxcEZEME9WSDhFQ1UzT1kwUVY2QVFPNlB1NlNSajBRZk8wQS92Mkh0?=
 =?utf-8?B?eTNVa2hXMWkzd21DSEFMcC9CbUFkYVA2SXJBZitWTThHVEphZC9PU2Q0aStF?=
 =?utf-8?B?RFkxN1l2anNqdTlnNHhHaTd1KzNpUkZDMElrN29sMXpraWRnWVpqVWUwNUVn?=
 =?utf-8?B?NUNSQTlYTzJzV1NjSk9xdTZRVUV1Y2dadm1WSytuWlNIalBkc2tRSXJIaWt6?=
 =?utf-8?B?T2xXbHA2cytUNXM2VUdsS0JQd2VlV0h5YnUzVXl3MEdDRHl6aFFhMHM3NXpm?=
 =?utf-8?B?eFErOVRwb1dXWGxBUkJENi81R3JJbGZhNjVlVVdWNHBCelFib2FYTHdzeEdy?=
 =?utf-8?B?STc1Snc1SDV1aXVwbVI4Ry9SR3h2VEdoRVNUcTg5cWMxZkVRWUdXQ1AxTkFS?=
 =?utf-8?B?NGpnOU9xUlQvQjcxZ21VSjhrSjBqc2lNWHR6MXZvSERYSFlrRlRzTDRlYitk?=
 =?utf-8?B?clBsSUJScFZpcEsxcGV5S3Fxbm9HUUtRWkNIYmI2STRWZ1JGMDN6Z2VIS3dQ?=
 =?utf-8?B?dlo2WEIrZmVRdENqUjRSaXBRQSt4TXJ3TWdvS1I2REpFSVErdDR3NGdWK3g1?=
 =?utf-8?B?SFRnUWlBMHFuYjFLU0p6c1V3djdmdjE3TE1UMjdPOTR3UHNtdThST3YzamJq?=
 =?utf-8?B?WmlXQkVveHFBdWhKZkZvOVlwb1c1bW5jV3E0ajJCZ2t0UjhKT0NTS2hCMFRt?=
 =?utf-8?B?MTJNcVFXZkJiTW5ncTI5anRIcHdxQ1dFbFJaRVV2WHRsek5YZHdWVHM4UVRU?=
 =?utf-8?B?dktBYmRvZG9Zc3hZOVlkTWhaU2wyZnJlUzhtdytaODJvMGdsNkVZRURINEMr?=
 =?utf-8?B?WCs2cGFqbFErN0ZtVDFWanR3WU5hZUNlSEVJajNwMFcyZWx1aUtZcis3QnVh?=
 =?utf-8?B?NThjaVVLbHlvQm9jT3RFQ0FsVCtTVWxkdUpaclRtQ2ZOamg0M2ViUzl6RTFx?=
 =?utf-8?B?bUVJbnkyelBzdW5Kc3ZrenlsR1JIWW1acldFUHA5ZlZTUUZrNnBTMFY4cXZG?=
 =?utf-8?B?bVFEN0FBRWdMeTNZcldsQmxaMUprU0dqWnkvK09mTTV3dVVaZk9SYWdJVEhi?=
 =?utf-8?B?TU8rY1NLVXFRK04vODJ5Z0kzeUduOEFpdnk0MENReThVbTRxTUxYR21vNGJV?=
 =?utf-8?B?enlLS3A5YmRhNVRGUWtBbGRZQkpvQlUwU29qdkxIM0JiQnM4SVZsSjlNREhx?=
 =?utf-8?B?RUFkZWdMQnZpeG1lblVzV3J2bXZ0Tmxqcm9JOUNsajVUQ2tSeS9BZHhwK0ls?=
 =?utf-8?B?SFdEcXY5ZWFGWUVqcjdKejIrK25lbWphcG5USGhjcnRJbjN0SG43QzErcFFJ?=
 =?utf-8?B?djVrS2ZHaS9abm5YVlFwUHdNckFPYVFnemNMbmZxQjM2dFlrNlNXQ3pZTzNm?=
 =?utf-8?B?djVMMjRoSjFtV3lwR0xnV0NVcDFVRGFqTjV4dERvemVsMG1GV0hhdGtVN0R4?=
 =?utf-8?B?aVlWOXc3cVR2TSsrZjkzWGIrdXVGOWtlZDJXTzEzd21UZ0prSnNwYitYMUdI?=
 =?utf-8?B?TXBKUWJEY2VOVTI3ZS93aVdSdklIUnczYUFEcHc0ejFYM0U4L0J3elI2M21U?=
 =?utf-8?B?N2gzVDF5dTlIN0FnbnJiV1VwZVZMMmd2N2lyZy9sOTdHaStmd0N1cUx4anlp?=
 =?utf-8?B?Sm11c1lqRHV6aE4xb0pXMTk4K1FocWxMUG93dDF1QzB2YW9MVXRhR3hIVWlv?=
 =?utf-8?Q?he+X4WgwddVMmEsY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8eed38-e912-4e80-1027-08df110c2da1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 20:26:52.2320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h91bjZdDCCRGidwzZIMY12g1jTH/SNk2YPrNMjfI6IpEK2bEMBO9+XnNMUwnVD+MUbNb8lRolDbxNSFenH8vqdt/TxdFlen8Ouy7gVVHufE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5055
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


On 26-08-2026 08:23, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
>
> The per-mode PHY and controller configuration arrays are static globals
> shared across all SD6HC instances. sdhci_cdns6_phy_adj() read device
> tree overrides directly into these tables, so DT-derived values could
> leak between controllers, and a missing DT property on one controller
> would silently reuse a value programmed for another.
>
> Mark the configuration tables const and copy the selected defaults into
> per-call local storage before applying any device tree overrides, so the
> shared defaults are never mutated
>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
This patch does not apply on current main. Please rebase and resend.

