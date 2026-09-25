Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B59C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 11:08:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81F52607E4;
	Fri, 25 Sep 2026 11:08:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmCp_VN2Ewqp; Fri, 25 Sep 2026 11:08:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DD34D608A3
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790334537;
	b=G74XDWsHtAzjS9BkgvYcryXJH6yKVn9urlFbXmzRtXIJmNUxVAVWeC3OrYTkVTwTvshi
	 gVElTX9Eg5Q8fVo5likvTZKJDESFHEd30hWk2slTAmZCzB0xRdIzBAAH/PWmHN6YHZU+K
	 uPSuoqLeSevTtW6PZDph1WqQCl7Czb83Z13PX6JpiZ4txx8YXbqMnYuWo4AfONsYyjcjg
	 KxpY29zRY7qqb4AWIQrvslpkrh7DeIDB1WucWZTbkoIDqvbV7aPgchVPtbozIVao6XRWH
	 z6Iig+++MpmVPqa1oklInmr5i4E2T6Oz94z1GBWI3u5CnLFNoB2CKIRgLJ5rvVTWpQA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790334537;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/y2EM1WD+BhDs/GyxcIntsB5DmNxX3bNLSEH4bvIkd8=;
	b=mp0C2ugK5N91rqu6weld1xKGDTQa60vYzw/bkdEeNTI87SVSlxi/oyGi57mTt5dXcxTG
	 8POi2YMb8nJvGOORopuNeS6MBMH30/VWHrBoSI9zEq2fjCkNzSMw6P4y+qOQ2wCde2Dy4
	 i0J+z2kWXFd2H5cJIg3u19o9Ms0Zs/Ra+midPYNeXm2VLt8yCW0SQxVIM0+EWkYM+E0DP
	 5UIGuil+v4dP/uX+KwIjrLJ4DACbeUHi16AagowgBCV6o4WVw8wUd6EUjnd8nuCfVYZ1Q
	 rjLg9Uro2/Gj/IoJpGQZ8gHw2RVUnghxu/fQNiCtKIXFOEn6ZFDDjLXUyBir9Esb8Hw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790334537;
	bh=/y2EM1WD+BhDs/GyxcIntsB5DmNxX3bNLSEH4bvIkd8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xo8PcDXtXKQGj9nwMI3EAkvssZf+ujlck3L5U/APFFkJK2SLWOj6GsaqRWHqVhdbn
	 psE5jD8FYa08psl/+WcMuIIjp1MX8HHS9EYVwwv1GQhstt3lxX4swtyBbtL1OUqGmJ
	 moZcUsDsDVewlxbPBwJn1phHxP0gv4/1cF87mrjgi5lsfs7XRLw8CrpA/qso533zGz
	 YvRDGT5Fs/gX/fbdMEJmN1H9Ds3UyN7O/NdY/hwFBlq4Wj4bvLCQ5e2mLmIQj79kWQ
	 dY8bIuwx2DSpVF86umSQyzA/bupzRmrsjcolL+uLogngmEJN1td2ZuAbCQY6X+wqW5
	 ElWTx1PcFjA+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD34D608A3;
	Fri, 25 Sep 2026 11:08:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0698B32F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0939400D7
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:08:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ACEdUTF9ZXq0 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 11:08:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2550D4009F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790334534;
 b=iWklE1XgncvGQlj6Rv6b4rm4TIBWnqjQrxc/RaYWzUVDmx1c8HKNSSZJYi/bP3TW2Meu
 lOu/p4sooW39Y4l/Mq5rVyfbL5W94pMoedc8PNhURgttk4AokV3wmWin+SOvsz3IsdOr+
 dWjH5o7+YHrpelaDX/rQ+PC6g74fa7EJ0OiU+MsvoN0P6MKB0NbPXBjgxch3BQ27/iJje
 W3Wm1cFKSY88Onb9jgxG2UiHvwwpoLm12WV/GgiCuHR6vShdX5FgP2/2IiZQIvphCxvat
 Xs0lyhV14sAeivfFHCwFxpN3VS8CPwiy8LWPuPevjwiu287poUEPpR8ZUSoHGsOIAKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790334534;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=/y2EM1WD+BhDs/GyxcIntsB5DmNxX3bNLSEH4bvIkd8=;
 b=Ar0opylU2Z2gTxqHf4k+2QOi+IVo6Gnc/tIgUn2IjOPrgAeqTIMwZsPExfIWC2S1o+Ow
 fJcZ6zNBsqF+kD81yYW7v7M0uJnXWSv4SUOmBtoKeE1KFRQ4fjhB5VnfMCTLLRlEzFk7R
 SH1bG/quw0YZswQ8zXn8eXo40K8rkddGTupgrDlxgcduFH35iblDJTjGpasf/OQ72XjA1
 WfB0Zof04qd06a7uwjXbAd3c4VRqQrHwm+8TEyqebE1qz6I9qaiOyld4sviD3MW7kOZb9
 LowXXxT923Wb0m3cSNft4y2myYw07jEC2HhMd8UCm0QSBqhzFPy/0kPmrXcCwc+sJhQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=qenCLzx5; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=KxMZSkcS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=c-vankar@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=qenCLzx5; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=KxMZSkcS
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2550D4009F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:08:53 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68P922XK1889116;
 Fri, 25 Sep 2026 06:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=/y2EM1WD+BhDs/GyxcIntsB5DmNxX3bNLSEH4bvIk
 d8=; b=qenCLzx5GYfpH9fEfNWLbtUNu//zIDH98GGolh3fhgXQ7+nBd1G2MuaJV
 pXjqoWwTL0gsN9VfEAM16cc0OeBdORQjm6RIE3X44UlFwg0L5vpg7+wqbe4A/dli
 fg4naDRy0gY8IquUZv1FsVXLWAOerExv+//uqBXWEyCZGnPj3rldWIekq6/BZweW
 ii5QI7TryrIzHxwnoaWuZxMHShQPTh0URxVndLC91Ml21/2CUnRRXbco4dru3wmi
 38z7w9UxtWWu5LIouQxHPOH4y6HQ/x/EtXy8T80I/MzZSN5ex9bZ7qLnXfnPTkPV
 EnRfXj6rOtkUfZHwBSn9LU5CQ0kWg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gwnyfrg27-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 06:08:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYM0HfStxJOo8XI/bjDts/mKu3ZyvsszMO0dJbklIAtIv/STA9w9O28eVzdl5t0G5p92pSg6cxwrLy/PN14/Tm4yHeCLbYRc4YIf+BR/qWurwvN3xOYbiUu+M/RRHeXZzqSt/8p8eh6+wSvhtLXqTf9YqhiWoact+80sjDWPkiPC4ny4VhNm46Y4MTlBhfiBbFQXyV95sgK6cfbS7lZ05RzpcQUsqvqEVPywhkc56n5tMK8hdgj5SaSCcMQpfVanpyzc04Z0qpDgA3Lz5DHurrOlltrjZFsrVrVUSPQRmM9lfHbGf9dLZcBsf3Cin2ysR0F6Wnka8fm9W/MWkt5Ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y2EM1WD+BhDs/GyxcIntsB5DmNxX3bNLSEH4bvIkd8=;
 b=nTN8JeuP2EqQTxtlGau1EgqN3vt51oriPsD2jvq4TZOF/rPowZAvviIX6aiT4fk4dmhJRIeF7RqSRRAOX8O8K8jxcRLrq8UsKoAmMQQbLOPFuv1z3WGiRmMhUdxEmnYDp6qx1SlPqYUwdIRoravJHgKVZP7i8AGRdcJmb46KewaMTEklonmpeOSyH2s8s9o0dqUg71FORJDHo8q8Z+iMxnbXZsOup53IoICE45daUnkxuYQQmGU7HrFrYc7xKJB13cHCBcDZ19qV6+/gMtm7NNIFYu3CTaJT5xuvt78wfUNuYbPj1k0pQzyhYjNQJv3fjZf8UG4CcjoCxcaiiECULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y2EM1WD+BhDs/GyxcIntsB5DmNxX3bNLSEH4bvIkd8=;
 b=KxMZSkcSllbbFXaS8f49HdBvs8GN8oTiGG5tAYVskksZfgl2H51ZvUYEbbNl7dAmnT8gqt90FENpHT1H2SD68I6xPQOc6oNQsJhLLc4CyXs7RyfkJ3w6rw//tptlOBqguwVYS6adwtLu47jwxAv8+Da8GVfNsfaTp44I9Kbjd4k=
Received: from BN9PR03CA0208.namprd03.prod.outlook.com (2603:10b6:408:f9::33)
 by CH0PR10MB5130.namprd10.prod.outlook.com (2603:10b6:610:cb::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Fri, 25 Sep
 2026 11:08:48 +0000
Received: from BN3PEPF00022BCD.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::f) by BN9PR03CA0208.outlook.office365.com
 (2603:10b6:408:f9::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Fri,
 25 Sep 2026 11:08:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF00022BCD.mail.protection.outlook.com (10.167.248.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:08:46 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 06:08:04 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 06:08:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 06:08:04 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68PB83aC2648479;
 Fri, 25 Sep 2026 06:08:03 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>, Tom Rini <trini@konsulko.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>
CC: <danishanwar@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH 1/2] configs: am64x_evm_r5_defconfig: Enable
 NET_RANDOM_ETHADDR config option
Date: Fri, 25 Sep 2026 16:37:57 +0530
Message-ID: <20260925110758.843871-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925110758.843871-1-c-vankar@ti.com>
References: <20260925110758.843871-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCD:EE_|CH0PR10MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: a41d7f27-e539-40e9-623f-08df1af55eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: zwpzwZ848UsVSCd5wZelJU4XLCAw/UhylCZdJCfNPOPG+C3YC22K4dAu8agzRPhQPeGaNt3iiE5RA3FHe/3ei/e1a4v6lOjSo/XL8T5EXRUptdoHkZbdPaXYFAakatY8UFpt5eR3IbOsiA1Mayaj56aDIXcUQXFzZ8aa0oFPFnqFPCc87t2lJWyBLU71lo8jayWIKv79GKwb7RkROInIxhGFuH8HV4PdoO1smUuv5PnXvaj6YwIxMMrF10UGITLr2rPRu0XwTpL0l2ZJjupJdihgM6oIGQ24QvkBpfl2zoE+KmeLmcbGgRPYR2wF8WQwDuK0qtJW142d40tiDdFwjfAWODvWRhrfsUboAqQfgsjbcqGip9/Y9cUrJs5aivoFBLIpbSjc75nYqIyCwesYwY+NqX2zjKkmfZO2dVc4JvfmW5L6vtWhIG1+CGo0qPdbOFrIlU397hwIxLBrLxve5o1Y6+4FvMTETveUpyvpMz63Gt5JY5CBCGsfVWDupn5+4HfT9KKihkRs+WpGAzv8vH6uy7KrUHOOe4Ie1AHfiI0dbrIZXU5pMayrXb7ZoXkmZnRS60NVILfYdVdM2NWle+IaXM99XsY6bcovtk+XomThnp3zHJEBse8lbDExfuxQlG57scrvPU7PNdP8gsdJVi0jpt+6eA29RweiMd4rAh+AojxBJ8oUmm5CJaT+Hujw
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2lN0mJq7Oh2vCY24vPwQm/DBP2k4lx/36SrFuVOD+gPw98jZm+XQj40RqKIzCrl5Y1Lpqlw8V8DIPMM90PFzfgHgh41td+5c/NphQqnKFGB9/j3zcbsh0MP2YG1GmFNNLtyrnVlOd5swqNwGhvjE+HaqOcIaQwshVr/EcetHtDEAiWFeVW+RbqYXnppWRAdoEVfafqHWpxEi0cO8eqGDrEo+U8xXj6LMpC6YlaVdy8ZPSxBWNavmN6HjnzCjr3mJlAbto5LCPt99dM5kBi/LbjFd5RHll0y8fGR1kyNdIc1kAlvprcZ+eZHu+45n1Jeuj/zx0qFBsKebCa4yQE1byZ2w9cmJS/vbYfVE1RH5D1dfKLdIsHOA1GqDfm4TO+ar+AntOIQviKPt5zhcgUh+Co48Pd1mbF0O6E4uHPQRsS8opzq93NbE3WkXwMmZpLU0
X-Exchange-RoutingPolicyChecked: UpwxdHRVBL3Ik80CgE4iYsr38yRUIklVkaF41Pmm/J+C/FQrAHf6PE77t7ZFp8QvZn2jg52OKcXE7Wr/1L1eSmwOrF0536a2L6AHOzMrVmhxhxSVix2e66bOMu7lpDqeaHRa+kJo/04PWXrW5WoJasTupKBl+1XtDZmWtuWEnCBpoiPqThUU/UOotbYXlMC0xdk+o7UpoC5E9vrorWmFPDpAWm4d5rP4mf7x90koxdunNDyMEtRxRmQQcADqEmRiMYfwkXdaqOqZlEY1OUoaxSIce4WtKmI1/D9zZL6fx69OdfzGhwO84B5ys9CQ+Xfast/YJywehz6pkmYkYJyPHw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:08:46.8403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41d7f27-e539-40e9-623f-08df1af55eca
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BCD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfX3K9chVbwXP+/
 iIbqyY+BBbAXmnvr9En3qxtt5lg7d2+Ssq7KE83wq8ShKfkHgeMRUmwsCqRMrqv9hWYsIi+ScBO
 O0WtCFP8EtGejQ8+Bnx/rzY4l5yrB3XYGeblFk3bFmD3E42tPjYMOr2d/yLiCzH/5MRBmPYoDn+
 N00rTVvAz/jhErxkR1VLW460fb+zC5jgk6gl2VETTapJhTUZaLD2UEhKidC4/bm8/7aA80F6OCq
 4sNuGFpjDtonMPWfzSXvZMzLoVZnpX0NAwTqFpvw33kdQ2/LTyk0EEEvOu/K2JncKyc+gS8JYs5
 f2oiUNq+0EqV4RvkQ1/392W2DRauJtjd5uC67bJ/xQLZ9356s5HCvbjfthYcKkDAg21F2o5jRcD
 Ofw4zAqglS+Fk7HEOrJMdd7A3KG7zicguGk7lj8XAkLLvchaLXe8Yj/zURfU1TZobFbcsyAjjaV
 Uc6fOmCJz0CKtxnoKKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfX1obv9ysfVAnU
 Iz0CGiPPa86zIBfJIT+hjPC5TCzx56yU331Ct6TyYwkLB/syX+EPKaewgeip/73R8xN2LUUXzNU
 Xu7bjRlQj3v2bGqgdO+kKTUdLwt20l8=
X-Authority-Analysis: v=2.4 cv=aeL0Dhot c=1 sm=1 tr=0 ts=6ab65643 cx=c_pps
 a=zZ5onIKbzmoLkk/LR1Usmw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=0m9ccfZYggVZ_ySxg2wA:9
X-Proofpoint-GUID: YiPOjuw-o3z9yvn94L-4wC0L0SmfORcv
X-Proofpoint-ORIG-GUID: YiPOjuw-o3z9yvn94L-4wC0L0SmfORcv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250044
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

Enable NET_RANDOM_ETHADDR config options which provides random MAC address
to proceed with the Ethernet boot.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 configs/am64x_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index 0ed15f5d553..0bd8bf27e6d 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -162,3 +162,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_NET_RANDOM_ETHADDR=y
-- 
2.34.1

