Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59EFC79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D0AA4046D;
	Mon,  7 Sep 2026 08:39:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m9h1icDcFgoi; Mon,  7 Sep 2026 08:39:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A877E4050E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788770393;
	b=r5Hn5BqlWHjt91qX5RFLPilTtvNR/Dj8bgl9yBSu1VrP4HD2RWytRKFqQzEQ+8m3c95Z
	 EyQgQS2FlKlqoA9iMuxsRcmtczLRc69jM6tKKZ+Y7mBDr59k9QsJ40rB7W9mRZUXZFdaA
	 cORoNPnPS9yCdnTx2tfnh+Qn/3AHEKAktO8FsJWZOi/7xxT3AJFSnDk0krUxUjxjFGvaM
	 a3cJP6GVwcCVjN7eh9gH6R//Qal2uwYsI73FRDo7k9MlyUsX66MnsaEDzO2XAJAI3Ld9V
	 67DGb0OE0X65nVZYxloxCXlplkN76UwNDB1nhPuTSqaY+cdzjX5+A0iVNA3fcD5qsGA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788770393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fkX56LuGSY1o+Hdu1eNeEaS02DqkeewIgfi0g/UqkSs=;
	b=iO3eoeW+AaXAAvJgokpS/5wAW8Z2UF1rekmAq693B7TQLy3oJ4RfERRQXifVBiV1Hf/L
	 m88SBaB7GTwKdmLEBoUyWptzbSE2d42SfM8GwEyuRLv8ZLaalbZL21CCacJ7Hkp704ceC
	 1/YDCEEVLCGf9hjjoAHRPB8GgBoegbxTVqS1TaX4/BMbrn/pPsORPi6UFxV270rPgfx8Y
	 uWcPqmeUdJiIAmvlcYxJd5QQ5c5I1LxuYcivJ0H/L1DrDDhdgz6Ulsnph4BUDFayWkm/t
	 HhbKTbjTR4a6T6uQE4AM5Bxw7MfcYAysayUMh4r/OgyghOnsaxEEOOyKzws3sty/BTA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788770393;
	bh=fkX56LuGSY1o+Hdu1eNeEaS02DqkeewIgfi0g/UqkSs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=to18sFXbqbUxMHrhslg1tOQPaA2DzhZYsyD0LeB/5aK+W2++nHVieAnmpIp0QLiC0
	 MpqqeABqCVfDa9jNeO8gE1bWiTKDEnVB3Xq4Ve/C9S+XZ+EZjhs6UyHZ1RVbAGCdXv
	 STQsk4GsD6ykcBu5b3eTXAqKBDZBGNS569ICHFvSHptumkrhXIVHTgwa/Eo2wB8G9S
	 AE2mf1m10pnXWHcnuepN6/lKb8u6nzBFaNShfaRi5aP0uJVPKNcJuueDoHS7NvjbIT
	 UbOXkW3YePYJPcgOuR5MMvbx88PA6BQi6WIvaJGe7O1A1FGRY/qsmYdZ4k4RnOtvnR
	 8LOdujdnmAMAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A877E4050E;
	Mon,  7 Sep 2026 08:39:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CF0772C
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6283060634
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LLooUfjts-2U for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:39:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D81C760631
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788770391;
 b=CyKDqGgyZwaHA1lqL4XQHod73ycwLLuTFwFw5sdEYd6kY12FVUERIo/MDCi7L8f2FSLf
 R2Em1lni14p2Osp7GzWGORGZEC766i5b6pb6rc5/mlqT3oW9DE8IdThSlU0olHIQanXNz
 Q1sFsj47kPOV8woH052FYLNMO5IEmG56tcXLw/MEQeWm4P/6Cze1RdaqWalEyuDQUpCOA
 9jmmkZYeZYMoTc2F7l/Jxa9O/Xgn7ds9wnS1ZaquCkg1W/JpX8LyHlKc1JZYIOhqZJ0O1
 vjJQ8z0xFbghQpidumpGsbXW8G8XGVumoUiHYc8ySzXgV0sYoUy+71G90QdRwU5qLGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788770391;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=fkX56LuGSY1o+Hdu1eNeEaS02DqkeewIgfi0g/UqkSs=;
 b=iudmIxvpk/e8yCmfAm/VykylGZfUo3FnuB0ad7Px2SL2rEIhYptnh79ohOycWXx7oHEU
 SFXqHjUt00mQ5tLSZ+u1bbu6hCsaz6NWn6f6EgOFTJ1zqneEE4Y9PnH9S9lxj3clW04cf
 MSuE1hQOC7SjH3hXoSIkrmNB7e42ZCEoy9dXZNC9Sh+ndTbihMrm4oHgCZyfR/boEBLQU
 1VuWHNSvaCZ/c8RjY+7CPUjtJQWP242ZUn/bcr07fCS19m4KVbdiULst5cSxiw+Zwe9dy
 5cdoAPVd4VUUW5KVmLfyl+G71jTiLVdT93j6esgxMCkOH0spTi1n+DoaIUhDsYjv61g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=dj5YGYMU; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=oTLdA+IR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=dj5YGYMU; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=oTLdA+IR
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D81C760631
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:39:47 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687767qn2415372; Mon, 7 Sep 2026 03:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=fkX56LuGSY1o+Hdu1eNeEaS02DqkeewIgfi0g/Uqk
 Ss=; b=dj5YGYMU4rTJkIuHwnAnHL4CBigaD3E6YqFr3rqxKty8lvk6yaeuMngy0
 NDOGfzDS9ygSSbE8r2E8jiiVrkf0CSS1X1aqDrufct3sMOniU9wsaeX0wkVhnZ5o
 XtEv10pcwVTvhUQMj0o2v6S/amJHD7hBkcLZqaVy/pwtHC8G5q71oWNIm+YP1wFy
 WH8ws9Z0a9z9Rbgg4wNS27uxlTrgi5n4JRWxQnfhxPK3qa9kKii6rYp8w/lts5fb
 weVBK9Alw8Tv5xLVHXriap+bUWADe7cu7U0dilb6zCTca8uU9zkeWKQt6+3JjjU6
 gsvQlbF42j/Z//pbir94BmZWUcNEw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gh27q4vxc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:39:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rM3WS9VcOrRv/z3EbCr6J7/A0qcA3A8+JxievHDVUiZJtYgRX7aIbCqd5w39/t7yAt4iDEH1Jptt2QJ3OyP+/fTpzMx3iY6u00W8cyE9IEJQIkPHRsmFbGmC817WRwyjL1oUEbw/0/aHrc2wKJyjXeAYLwBX/m25aecWdHdtjrQCczWVMkoSyltSQTmYtCB+TzGBHGdIlh1lW2Le672xoKHDJJHI8gcGHxZ3xSydPwjQnKPvGmHBlbaGRiFO4crrqOCUTdLnJz/C4OnZSEsZbmDCChAuhPjIcLSbZ582vA5Hb7XghzZe23vw1HDVl1vXGFgArXlXXdcmMQvmVF/ZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkX56LuGSY1o+Hdu1eNeEaS02DqkeewIgfi0g/UqkSs=;
 b=XVUY9Z9ml/5vFf/HMrIXL5rlVW5gGpJAPFzJAq5jzrU4sHHujaLfVORqAJsW/WfZd8UMauWOtKCV9XGaqKiIS2cjbKKzjP6dfn28PcAc4f7Y5Ccam95/SvUnOyybAltz3lhXY66ivhLbiY3e5sE3y2lrQ/SHle2DFHm6DYS9NC/JkgWXQZABs7V0cIcdclAuuubjSPWaUa0l5LD1hQ1CFNsUjy5kvUeP8VwiDB0/Cy04pkHgO7xBRWQjO+ivhV+TQ+/Sui9mfc0j1z2LQPZUnLg1V3tsQhn+z52AeDlImJtK0GsVAZ9cOCeOYM69X+C10yvN5PJHKoeKFjOyTUqIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkX56LuGSY1o+Hdu1eNeEaS02DqkeewIgfi0g/UqkSs=;
 b=oTLdA+IRL1bKMPYDHTI4qqrJYJsVVbbbYhUl+OK/NzknLLWZeAQ9gDXMnhBEvRirwK9fsHam4VmjHeHB1OBnK0N19VAoZlBRj6BmWsEUmyni3fzUkayhClJeo696Wt8M+nxzq3vMszzIm80QX/JxQ1il7iNuZ8sGVKQRya9Em4c=
Received: from CY8PR22CA0018.namprd22.prod.outlook.com (2603:10b6:930:45::24)
 by CO1PR10MB4498.namprd10.prod.outlook.com (2603:10b6:303:6c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 08:39:39 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:45:cafe::1d) by CY8PR22CA0018.outlook.office365.com
 (2603:10b6:930:45::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:39:37 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:38:59 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:38:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:38:59 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6878cs3l176435;
 Mon, 7 Sep 2026 03:38:55 -0500
Message-ID: <989dd99c-c988-46bc-8833-8a6f3d651684@ti.com>
Date: Mon, 7 Sep 2026 14:08:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/21] arm: mach-k3: j721e: Enable LPM resume flow for
 J7200/J721e SOC
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Kendall Willis
 <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.u-boot-project.org>, <u-kumar1@ti.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-16-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-16-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|CO1PR10MB4498:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2c58b8-3af1-4d0c-35ac-08df0cbb8d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uJOKLs1c3fEZ33AM09023AnluaU5RvDPl7ac4zn6PN5dJNqFrMCmYyrymelvVxzNqfJScx1CNO8hZQG3BWhNQ1FwiSNc2e5HIv4vVEvrFapus/56PN31rDSs8gopIw+aOR5m0WSMvH/TJLR9NXT40me4f8fCKIKtTP2qkQlSzcul9her9xk9Ie3V3uhJs05JSHiVxOJtw0aUvLdz7CXHabxwGs6oQzmxO5feaxOAnUGsQdTmOAu+nsdJDNsv8/5VEkU1OyY2I7+Zt7vxLaAD2sjutmEXU0VEA5P71cAyN3OdnXV3XG5ywssZax3ISi871O5KCQmpSPUe8N+xvC+IFnh3rJvfa9qTUBnlWQ8asuGGnfSeFMF7d44U7b5sXqNETDyCSIdNMUJJQzuk1ZTzNmZWJ5yTfO5BLFRHWusYV63TWMismY+VgYXK1t0BbpvN9Xnimp0epbkIilQOATAPvg5vh65oDj8nPS0pUvku9/rs8zeYpTZizZ/aTN0yT5yVjkF7OicyRgQxxyz/hoiwtVeXI0nP53V0vxncrLrzJiC6pkgrdbW5FtrmKnkCTfV0kLPALVfA8l/UxSfu2bm9VJW9QJVzefPZTrsChv3FglfshPkFvdH9EtztFqIeS1LDLPRcxhV9b0lcpZdTFflI8GCydm/pnBJW1u1MXourw28ZGtaHBTEr4luc5JVtpk+Cr9MwKKRRs57F1ID7W45CNA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fjrofmfB45RnJP20P6kE4YuHdqeg/M+A1nq4TfC59iZLPk3d4/AXYWRXzNobGWOjWqRccy6HQpbY7dLY29pbgvbfe/qijClLH2opicdc/WPzxU/hf614Nih8CABKXRSlPtjzil2eSumCFIA4362T5EuAL6h60ttDC/om370z4znLAZ3G4k4jWuZ7Ga60UFvpsrqzTKPzWu+LKxN0eSBKbflwNNSQMunw+ElJ+opRk+DiWbxcWI8inN3qR0pTEG+LgBw2mG7S/GguAEnF7XIJFeMJ+yWtcVs/3/UyNqiLnc2uv8Ai6bdnVbrS4EOGIrNdKg5n/SZmbUowZ9/bzeCx9CFFMqV21Ajm0+pDDJT+8SIh5YMsxPM8j6Oqpgyd2VIsR5cGAm4l8YDVhYT1UNzBMlUHMY17LY1CfD3TSBiRgqICsdnMOy69H2xXzmGi1uHV
X-Exchange-RoutingPolicyChecked: sT5Bv+HB5WXr04ZP+CWG+/NH+KACcWg7g5w2paah4qIx7CBFZNhht+DYJLOHTtGvgsx1Fxg5FzXT2v2oLhGbPCaELhXoOw5c6S4hkHrPXDYsvvZTwb7tkanMJOM8qbh6G8bpVkwHRaNYWdcKbfjlfbBkYs+rDYCDUnYp5nqoaUee3JKLLG2P3i67fxfAj35D10pycfUUOq2BHnKiYnjgCDRN4whcYAZOMIASveyLaMCfOaEx+yjykTWgU+9TSE+B7lsxTNZFV+DBPPxOJ5AHBC5jIWo1uaj+bpOQ5BntGocN3XlQXJAsL4NLlPs7ctXyJWS4MsYAN9Y2tDYLn40D6g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:39:37.5096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2c58b8-3af1-4d0c-35ac-08df0cbb8d1f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4498
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfX14CchDZVXhdd
 Dob/Gq9D2g0b4B00hBPp/Sk92ecGwt+oIIuZlblLiYYG0rjgK6PFjJytHwS+kWrtyjUwNuCoe8L
 imTHD5JMtAMRKzp04NtDGB0Uf24o+Bnq8agA/wzhi0HQEBv0dLqzN921fQ9DGU9pIay69lPx/st
 YKcG6p/Ba4BwsYNgdgj6h8X+sPkJVTiOhcrlhRFdokeBVL4ot7aZV3/IsBq7gcWwLXEvG8NSUAQ
 qAY+1NZfFL11fNu/AjKPt82oUY/uxDt3VJA2EjGnCneFMeiS7/PUehgO1+TWr+5fhyXS4TM3WqS
 G8hMH4HxD1sbbnaJ6NXoi8No7BA+rxaFRNO6ekAy00pUHyoDux5iHt23/0Lzta2GU6lPIxbRsUO
 uJsXRz/v0U/xupSKFbLGNZ1XgjSl0McCrJRFU2Erajazw19233OKD2xsoo4N6pBbX/YPshrOtPF
 sfkjwmo6YeB4xauBk9Q==
X-Proofpoint-GUID: -FckuG65a-xus-_fLyUo2Qrk_VWrIE46
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfX6H5VO+xBGBGc
 V3SalVI+2FKBrDc1va02zNn1+Z1jx2HpELXEdS7nMugIOjVIzxsX9yKL9kJ+gjA2lNjeEA0JqcM
 hvzkF63HFXdH+NyxH4paisqXXCxz3P0=
X-Authority-Analysis: v=2.4 cv=e/82j6p/ c=1 sm=1 tr=0 ts=6a9e784f cx=c_pps
 a=FHNT3LFbDro5wzOX4rYsGQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=sfDZ-x5BP4BCYavCZk8A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: -FckuG65a-xus-_fLyUo2Qrk_VWrIE46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070094
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



On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
> From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
> 
> Add support for resuming from suspend in board_init_f.
> The resume state of the SOC is identified and lpm resume
> sequence is followed accordingly.
> 
> First, add the board specific part of the exit retention sequence for
> k3-ddrss following the DDR resume sequence:
>    - exit DDR from retention
>    - de-assert the DDR_RET pin
>    - restore DDR max frequency
>    - exit DDR from low power
> 
> Then:
>    - Extract context address from devicetree and send to TIFS.
>    - Power on the rproc cluster.
>    - Replay the certificates attached to saved images of ATF and OPTEE.
>    - Resume sequence for context restore and rproc resume.
>    - Image entry to DM firmware.
> (All those steps are done in do_resume())
> 
> The context address area is firewalled by TIFS to protect it from
> other hosts.
> 
> Co-developed-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
> Signed-off-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
> Co-developed-by: Prasanth Babu Mantena <p-mantena@ti.com>
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/mach-k3/j721e/j721e_init.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
> index f9af0288cf66..fce6702be687 100644
> --- a/arch/arm/mach-k3/j721e/j721e_init.c
> +++ b/arch/arm/mach-k3/j721e/j721e_init.c
> @@ -20,9 +20,12 @@
>  #include <mmc.h>
>  #include <remoteproc.h>
>  #include <k3-avs.h>
> +#include <power/pmic.h>
> +#include <mach/k3-ddr.h>
>  
>  #include "../sysfw-loader.h"
>  #include "../common.h"
> +#include "../lpm-common.h"
>  
>  /* NAVSS North Bridge (NB) registers */
>  #define NAVSS0_NBSS_NB0_CFG_MMRS		0x03802000
> @@ -46,6 +49,10 @@
>  #define DEV_A72SS0_CORE0_ID 4
>  #define DEV_A72SS0_CORE0_MSMC_CLK_ID 1
>  
> +/* DDR retention bits */
> +#define DDR_RET_VAL BIT(1)
> +#define DDR_RET_CLK BIT(2)
> +
>  #ifdef CONFIG_K3_LOAD_SYSFW
>  struct fwl_data cbass_hc_cfg0_fwls[] = {
>  #if defined(CONFIG_SOC_K3_J721E)
> @@ -298,6 +305,7 @@ void board_init_f(ulong dummy)
>  {
>  	int ret;
>  #if defined(CONFIG_K3_J721E_DDRSS) || defined(CONFIG_K3_LOAD_SYSFW)
> +	struct k3_ddrss_regs regs;
>  	struct udevice *dev;
>  #endif
>  	/*
> @@ -410,6 +418,22 @@ void board_init_f(ulong dummy)
>  	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>  	if (ret)
>  		panic("DRAM init failed: %d\n", ret);
> +
> +	if (j7xx_board_is_resuming()) {
> +		/*
> +		 * The DDR resume sequence is:
> +		 * - exit DDR from retention
> +		 * - de-assert the DDR_RET pin
> +		 * - restore DDR max frequency
> +		 * - exit DDR from low power
> +		 */
> +		k3_ddrss_lpddr4_exit_retention(dev, &regs);
> +		k3_deassert_ddr_ret("pmic@4c", DDR_RET_VAL, DDR_RET_CLK, true);
> +		k3_ddrss_lpddr4_change_freq(dev);
> +		k3_ddrss_lpddr4_exit_low_power(dev, &regs);
> +
> +		do_resume();

could you check, if caches can be enabled before do_resume() call

> +	}
>  #endif
>  	spl_enable_cache();



>  

