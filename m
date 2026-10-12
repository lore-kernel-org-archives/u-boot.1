Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D7ACA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 10:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FB9C605E0;
	Mon, 12 Oct 2026 10:48:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XaluQjJ4AL5U; Mon, 12 Oct 2026 10:48:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C800E605DE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791802100;
	b=W+KMLdBHRBwb0Q24SuUuvQ+bCK2OhpeCJtAp6p2PyaRhQ20Uwj6BwwtvQEoc3lHLAr3G
	 II6Fe2O4/uA6ejwhguMi4nb5cbERRKMlD91gGfU75xgGHh1G5BtyzmdTWS6xo558cskuk
	 iVU/2OzVU8OJxByX309qdOmnRCWrXpEbtAHgrQNuCfBFZBlm8G0VGOCoJ8pS6oQ9QWRhQ
	 F6GGhkCyvdOjho970Cz8v0QTuSKusH1n9EIS1Ja3+hZTIt0MQF/2lhAPmMCVDkCw1XVQT
	 TyRx2NOxN9M18GEkpWxpqYHeQxkdsBsBciLIhrV4BvgKyGO96WKUzSCc1MCCOPp4iHQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791802100;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PlbN06Mln+cf5Q2YwUR+rZ4NnMWqG+am9KdzszPCiVI=;
	b=gUNDjLtLHf75yKpmbn2gfDvYbeX+/KVR7aAsRZqzPKM+mUgAoVY1iCZnt3cKj2hUK4zw
	 ypWrHWgrZkO8f43aMTRY1Scz8+efC9Swx108p8HzrMZOJmakOvHTHJu6xpI+763mi91ke
	 /AN4LuHSSCkR31RLRWBQqznW3orw1UlIpUn+cEDXW9RF+l48AMfk2R/TvsKrs65TEvEry
	 JxSkLhX5crOAmD5HGIDze9i+/jvfSdWF8QcYY1iQiTAGUTl2CWtiFRO0YFYlwloyC/WIZ
	 +WMJRQcvFeY9p1bWq7BQp1oMiUpZ7xXvlYcAwUlnu53AxLie9C5d6IUC8P0tetbHWRA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791802100;
	bh=PlbN06Mln+cf5Q2YwUR+rZ4NnMWqG+am9KdzszPCiVI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UL3oJq1Oh2a1wKCgS1fGRqYUQhykQRyPgfnDZn+lfJiiVmnMi+eDoDGcXAD5ZJOkY
	 QNe+6O0wYnYVx4au3gAysNHlnx6edb/Ckpo5yLNr4hORiUq3y4jRJNzapC8WDJ3h0+
	 DVf0cVOLW9wgKPqma0QNPNp5RUSiODlx/+44TU3SPBhI3SdG2I8fU26LQC0DsFwvS5
	 64izto5ndzBxnzCZlQaB/tGhcysY8Tl22VakOqy0kNokJMhO9ItPsFqlyJHpl3COYV
	 WNm4NUlXGpUL1u40asAKUo74agMLsPVdSgmHw+3cabq6x7kSYUdWd4Ezkx62CjSz5l
	 GKiInGcWwHZKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C800E605DE;
	Mon, 12 Oct 2026 10:48:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 50FB3380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E4A880C66
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6oyNdL8QSudN for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 10:48:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A60E80C5D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791802098;
 b=DKg9ame2rFx3ohnM482cXehrJ51kRcqQKyrBK7dp1KTUoZuU/3MfVaY9Zy4cVvFYlup+
 A9jy5XkEkSgkbD047Tri/Isqi6gEMFweD1TYAV+huEB4L2HBf4AKKU2ATr/hkRvVDQlts
 u+2s6DWGKoTnkkpGdND/NZbXctw2VjYfln/ujpAd95cnyvFa9ldpojDHwtQR+q/FiL75K
 F83XRSVswfmhXSS69IDMVJGCGubEx8TFK+JdRFTJzKe+/HfdZ8EmyOgBi2v/kKlbqJzXS
 nGn1JStVrPU0i5cmXyIyeF10rePDVin/jMkSx2YmqlXYwn7vOO43a53Nt7AoQr0K2tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791802098;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=PlbN06Mln+cf5Q2YwUR+rZ4NnMWqG+am9KdzszPCiVI=;
 b=L5A3EJ0twvHAC24ybeqKyaZnahXwYLiAEV1SUzY4E13oNiwL4S66ljBubbPkESOeQdaj
 r8AVAc1pSR567qxd1xwlHTP0gjDJc3EHNXsPzlXH2okeB0+W2pOVayRWd06W2bapvbiDT
 6rdGMTdLli6s6E4cxBqr0zVERv0V8w/9NbvMJG3jPSdbuZaG64MTj2HrBXgpGRstyXraZ
 bsT3qRSA+kJH/aDTDcMZzeis3kQ8fPq5aOWMdyKj/zhqfLixntONbWIo4jJ3KKY+7jy0X
 nf0XKftONUVtE04Q0dlNjWwoZ2YDp0aIAI1vx3eSdsAlB6ueoHdBGI4HNEU2oZpRcNQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=YuPEtFFE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c20a::;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=YuPEtFFE
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A60E80C5D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBMuk2C+G7Jr6fp73iCKZDZiND+dx6Fp/SMivw6uHXWt6McE77K0/kxAqpUabd85mCnxk4yunDc7AzyZNP+IdskPMxgxosN31vXcMRw+HPlHHMDzy1KklBSGlFcQRIw9MXCxk97CfOJr5egbo8J1qV/anw5SWy7afU6hccoAurSZrcIiZAT1fGam8jirrqgQ5rgTaRgFTAVJpz45ZtCTcaoh44rDQxEgCm80dVqXuJvILLpt/EccjPYNurHUVT1Qf+AdK8X8JFaOJ5xUyx8XBDTjShDbdco54w++Wz88YZhoCo56q1T2YCypz7NhHQTTN7mARJodR6SY3KklysiHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlbN06Mln+cf5Q2YwUR+rZ4NnMWqG+am9KdzszPCiVI=;
 b=Zf+ECxomuyvME4Vy71fLucDyH8gheinB9Fb7gxsicytiNGWAh6My3Aqz7nk5Vqp2vaZj0V8et3WRjvuVoBjwYTy+MOe0o2CfTCi6i7wvIhl8WApit7u8LoWlNHDDV0Cn0oC5pGej1CEsM7TMf0lYPB0wq2X8beKA6dwICPVEtzG8u2whJ3ZvwpI+gAocHOxUF4V/KhKo2MEVpdo5+8rsi5wfatSbhtbC7OSmE2GCQ/uPykYgWBoLA2bx6YFXiLHdM51TgHbS3RXcjColXThUR2i+XtPonN+4YzbcUkFEiCmloFKFk1Nzw/lWFTYTrGoTWLjpFDrqx4xAXHZ/A8fHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlbN06Mln+cf5Q2YwUR+rZ4NnMWqG+am9KdzszPCiVI=;
 b=YuPEtFFERUmxXmOHLdu7jx+zl84L9TBGzvfsoma3yTeo4T85zFcd7+kG2a4apDy4/qVybj3l79OLfXDknZwcpN/r2n9XVPNlmoopPDNPIpvOUALdU+hMaADXx2kiohKFkWb5pom5JUzSg9Y2KpV0K+rUYXhhbc9BEapsCd2km5Jqr6HMdhMJtN89C2sbVBAPXtc+L7EFZAei/H+ZzDtmewDayrH5R1eqbLVWditadGGlkXevpWKiA/9W5F1fKaMfW6P1mN4tJ8PPDLWssNytpzshvLSXwa8lSJy+8VdQ5qKknpdaSyQxl57EOk1NcBsfVxE1mw4Oe16w+XSvk+JqrA==
Received: from PR1P264CA0077.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cc::13)
 by PATP264MB4722.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:427::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 10:48:12 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc:cafe::26) by PR1P264CA0077.outlook.office365.com
 (2603:10a6:102:2cc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 10:48:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not
 signed) header.d=none;dmarc=bestguesspass action=none
 header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 12 Oct 2026 10:48:12 +0000
Received: from localhost.localdomain (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 3759C20064;
 Mon, 12 Oct 2026 12:48:12 +0200 (CEST)
From: Yan WANG <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com, marex+nodisclaimer@nabladev.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot@lists.u-boot-project.org, Yan WANG <yan.wang@softathome.com>
Subject: [PATCH 0/5] binman: Add HSM signing support to pre-load entry type
Date: Mon, 12 Oct 2026 12:47:59 +0200
Message-ID: <20261012104805.17297-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|PATP264MB4722:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6bb14656-e6a1-4804-f11e-08df284e4ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: jKsElRoNoMd92zl5Sjt/F7Xu7YtBPlzq0IGKf+sWTr+WKNs1jSYvIORVCKe2j5vTvDFt029yLXi7BAUWRl9xrqZNsPLRGIiGRXoSPCPl7tMOoLoyZt/F2Br5slDQCz9EHv6P5Y1c9aQ9kcKX7A4oRkTzhjp5tCc4C3ooY+CPScjcW83vS2qiFIE8Do+5OL+jjV0aOwAQdd/+yANxGL9gIvRYgvwaw1AC+BsH1mfmAN9DcMz0CN4wAHgCCJtyEJyHUGUXH2IXkDITzwrBl0Xz/obuo1/JWwIyaXtjY/bRAfO+KIFDM4QsM2241knsf01CN1DxSJdaz1uWGfABmgbq/QfKIJ+gaxBXIh8qgEXa8lfP1pOiX2rsrbXfqi0X0nGTxA4P/c4fK8renDyE2jvxlz84Ih0CpjlkSjbxHtHI6AkD4acIOe9kp6rDifPAZIJJZQPwpM8sxNdT6Y9orhtBaMm5UjkrfRHKg6MxWTVJwIbBHp2NigBCclanJhPiqFMeV+u+kAP7EPmBYGliCT/oCz5LX0Rkaljx2YF18ym61OVmPeUggaZ27F0S+WILVi2Nhv4U4EOWGQ/OivuTaOwqpP2VAU0nhqOizocoigtmrfq2xrcUg35PDMVd34esZcN4A6Y3GchWw0oMiBgOmbeBKukxdUsAoGFubx3Jt6EP/1BmCk51iIaB+8Zr88jHXQddKZFqz8wniwWApiDCMB6rIA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nHdv0TJ99ivxO4GQe/HRE77Xr3IUdALZu4ktpKBN9OZyUtjMl9NXFmSb8VH7q+6Sw15PARWzJJuXr+5OwUe0isTwV1+7c7rHEOxwOuAkO5nIDxY8Ws5jKafa9YTBSTr+0fKp0n/09y95fMr3TpSLg9r8bg4bb7k/Kn73ssEPZIgU6ww5ux9sudIv3Ai44l5+Dnz9s4s44HvCkugoIQpXDyh2lQ/YFVM+2uk4Da2F7Pn4xIt3dHyLCTAWs4GlWKGvx/0viZ8nrOOQnRsQ+ZTS+WcuLIq5ZxW+mNRJ/z+EfbadSdsSj0fPHE/HkeYS/Yf35HDxFExmvsxrkcYBE61TBjTpOaxlDE4r3GEOFrGWhsWekMu6Evz7qsHQ+h0OPZdPA0Qn10JvvfJoErl8JBfgoMjG4j5AOM3SrSXUebHVKeOYbGczZjhcF17oM7C246mQ
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:48:12.3689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb14656-e6a1-4804-f11e-08df284e4ff8
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4722
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

The pre-load entry type currently only supports signing via RSA key
files on disk.  This series extends it to support Hardware Security
Modules (HSM) through the PKCS#11 standard.

The implementation builds on the existing pkcs11_tool btool: a sign()
method is added that drives pkcs11-tool to perform the actual
cryptographic operation.

The pre-load entry gains a set of hsm-* device-tree properties:
  hsm-support        - boolean flag to enable HSM path
  hsm-library        - path to the PKCS#11 shared library (.so)
  hsm-token-label    - token label (alternative to serial)
  hsm-token-serial   - token serial number
  hsm-slot-index     - direct slot index (alternative to label/serial)
  hsm-key-label      - private key label (alternative to key-id)
  hsm-key-id         - private key ID
  hsm-pin            - user PIN

Yan WANG (5):
  binman: Add PKCS#11 signing support to pkcs11_tool
  binman: Add test for pkcs11_tool sign method
  binman: Add HSM signing support to pre-load entry type
  binman: test: Add SoftHSM functional test for pre-load HSM signing
  binman: Add functional test for pre-load HSM signing

 tools/binman/bintool_test.py                  | 374 ++++++++++++++++++
 tools/binman/btool/pkcs11_tool.py             | 275 +++++++++++++
 tools/binman/etype/pre_load.py                | 285 +++++++++----
 tools/binman/ftest.py                         | 140 +++++++
 .../security/pre_load_default_padding.dts     |  23 ++
 .../security/pre_load_hsm_invalid_padding.dts |  27 ++
 .../security/pre_load_hsm_missing_library.dts |  27 ++
 .../security/pre_load_hsm_missing_tool.dts    |  27 ++
 .../test/security/pre_load_hsm_sign.dts       |  68 ++++
 .../security/pre_load_missing_key_name.dts    |  23 ++
 10 files changed, 1198 insertions(+), 71 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_default_padding.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_padding.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_missing_library.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_missing_tool.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_sign.dts
 create mode 100644 tools/binman/test/security/pre_load_missing_key_name.dts

-- 
2.43.0

