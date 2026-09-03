Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45131C624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 064F58111C;
	Thu,  3 Sep 2026 08:17:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vutRgvR29Yb8; Thu,  3 Sep 2026 08:17:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0B3E7810D9
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423470;
	b=XWcl+Y1r+o5gyKr+LIRx9al78/L3fyXG/Z2sSEmbFyRN5+39kjlNz39rAZhzG2QNJwpz
	 gF2TlarAaTRYy7EQojf3MEKCRppx8hzAv27THrFsw1s3c/s1YTZ/kRaVnplyb7gXb1lW3
	 GkxyJhYiS3/dagB3FSDdZ2lR8r/s6Tjo487TSxRmRkaWYp2zDEPgcryXlGq77fP0kqoHX
	 dvGU+2HHLL9qSQ5FmAfFMv1biSnSR468BuGsSnba+hrYi74YPhPfTynQG/t9ecB03i2Qw
	 NVzd7Y9xD3t3TgFpeTdIJ1i/1m5NTpD4VrwmwtR35/kmjqHbSp4cRlrRr0bjgUuS3uQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HZXYxpDqlMS+kJfxORrYV2+iK/OnLUluxRaUCtMpNE0=;
	b=j5IK6BKlycQE92j8KoTbxhhtdHC8XjkyI9cPvJYL+nV40W0caQDRgynZzmtiCZ/8dVvX
	 E7KvAU1azkvXkBwNxb0f60cNW+qhcvMgb5+lNV7vI1q4gn6Pr1EaRLZ/oknRQqwNRr1PY
	 u4pSqVw/yk01THmSXyS7CwCIKpX1OJP4pLAPTV8VtLVN0zj/XNDei6zsLz2oOmX0g3Az6
	 CJyUbQyy2omdFrLbtM5/2lVhtKYLKqTQIsc8Yag3llHTVe5i+h5SsagDNn3L0fWKp+MIe
	 +wn9MVy+Eu8tbBE8thxp6R2HcxaCZjQp3my5Y3EbpCCC1v/+dMSjun6mok1WGYkNvnA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423470;
	bh=HZXYxpDqlMS+kJfxORrYV2+iK/OnLUluxRaUCtMpNE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uFCqiHg6MFb+Vhmd3zrutJEqzk14RdNrSu2+a9WUWW27fD+8SqTpTZGtsQ0PLW6op
	 OjFl0bmzIzkNdwYEK/EPT0aqQ/ytqHzL9yFbJM/PWm19f4OlXchMUIR0DhtFe8V0mE
	 ONe4HKiofHTnp7vWwwgPSJ4UWRkQAw8ySehU94thXYdtONbYM/k5Z1VZYk+3+ggaCp
	 jTV3udGoyWJzRv5ivPrOIM23axmSg0/0qtw006ppE6B6XYjWRCRYFYXrMA67snLCTq
	 4c1Qwf2Vs6GI0p8jc7UZ5tpCO05/0VERlmDCCYNC0BTVPmAvHAgygkdYOeSvctD1Ox
	 xPD7lh3lxxlig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B3E7810D9;
	Thu,  3 Sep 2026 08:17:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DD4582FD
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF083608A5
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jxiWTOSJ3tZq for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E1C636081D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423445;
 b=GCam3ug2TSbhUELZPaHuPMwGOAcNvcbYewC/Up2/6ANjSdkduzt3VjsXZ5lmL9o0H4bm
 3PV6KRl9nvYBcVq6RFD9TTJ8JkMBcELQmbQ2eR0/9BXvcokIANmZjm8Po2qjaE1+GdyDQ
 Sz295mOQgMo736Ce834F1Dp2sV+w6kRmfwMy8SKsauLpNa2oW08JmGkEPRCZHp+dnB8KO
 g/PPBY/vXbUhaVZQXpikirJCwjEQHpau6SSTi5D4bFtAPn7W8wZj0ixK8zm/ZvRkve09I
 sHZAmeFWBWgzMjesP2Vj62YC3zoanTrqmuDnONUALuQMXziruRYezf4N/4/akGtZImA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423445;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
 bh=HZXYxpDqlMS+kJfxORrYV2+iK/OnLUluxRaUCtMpNE0=;
 b=lQ+cKOoKoYXbbOwb/62MLDLkT9CdpBzEZAjBxYzAQpQpEgAihhTCEeykzOaymMylPhQx
 sm47IUuM60N9l/C4p47b1VCfhvfkYTXqYelEMK3wsJtQ8ar4UXg5ACFIcvbH4Fy6wOvxy
 FJY12EiDhgaGAdJoJOT/nNmS1Z98hwP/LsNAgel3UdLI60OAOtd4BK/xFWAJmLH2RbTf0
 uSLhGzfut+cTstNGsYqYbyx43+/QHxs+ChKlMXd0fXAEEhgSEghNdzKZG1vgbjt8nh6BK
 2IjsNlNq2rJIm6hKBNSXXIgb7DT53w5X2BEN+Y4PHFRe69G/xhnvuLIACLuAfCvuBtQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=ovl1Nqma; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=ovl1Nqma
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1C636081D
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFA0ssPao4ZbOgn1mKHX1EOm4aOrL67GHWFI5Wj5+4wHloEBI0r+h+kAZz843+iTNzTEosqhJS8dcpHA78kz9pqoHBdrA6Eu4a3yQEJg5KSeaLvkboDTDdR6eXC84wAxg4sB/zjfcE4nfd4NJKWMwA8m8AqvVxJNkVh/56XtftmfJhJAmxhyGJ6qIgUPHFcm1OtjzP4OkDgfsElKwafByixtJJupuHe8ps4Nb7/10lN0TNCpThYvuttigaB3PiHQy9FpRiRWHIYofdVrmFcOL9YGVTF4bx2Yj8fQes6+mOWkyUkJcdhi3N3Sd2Txa7iKGPwqO5FbowXl8O96qEh1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZXYxpDqlMS+kJfxORrYV2+iK/OnLUluxRaUCtMpNE0=;
 b=i8dC3vb6CkZUgGcU7YKlVSkZpgmkRUBw4aywiDIBhZCmrXZRPIWY/hRE3YFCmf5/dFCq4GvUWMsQQxJJ1WhvXAfy/ms83L9jEa9b6KhOFbzp9QI+QMY4WBQHEmIDjaxva1OHLPWQyVnS84cdrbdw6TpYf3AaFZ54XS/aunGdCfn3kAvlsPag1bQlitH7XEHx33n5eJr4ns+WML+MPHVn1HHdZPcYnhbp6YZo55Wr6VfbQh9XD94BN7srHjzBXJPYhhyak4418Jw2U6AP+jkArRlCFytrS93wL4xRLdJso7Qsq5MyPjfCUQAmSUyWVMBhm0n79hE8+VTdPCZX0niV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZXYxpDqlMS+kJfxORrYV2+iK/OnLUluxRaUCtMpNE0=;
 b=ovl1NqmaB78wMdQy3ZAT7HLGVnzL4CQxRgSJA8EfHB4qspZBUAbKkpKlJDO9OEe/Wy7b2OedSrd4AMkMdBg1ucfviI1qpdWN3B/Nv6B7TV1JqW1aZ//wn4kSIS9BUearUwJO5WWAoEr0wYleRZxdbtukC1H56QCYeUj52xfoAPdFLDRyASSTgKjl5sgaLfHJPWgtC0tJAOeASNNeIeOeDaR/veLAYLvhFSnYygs0nZiRL1iID2bKEJuKROSdEUwPJ6O41mRZ4BkpiJJt6+HRFS2ndSj3fXp6hLkqSOD+13oFzsM+wEsdpgIe74dqJVmL6Cf5J4YeSOlUKseDEECi9w==
Received: from PAZP264CA0143.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f8::14)
 by MRZP264MB2907.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:18::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:17:17 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f8:cafe::59) by PAZP264CA0143.outlook.office365.com
 (2603:10a6:102:1f8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 08:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:17 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 67DEB2010C;
 Thu,  3 Sep 2026 10:17:17 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 14/15] test: py: vboot: prepare test for global signature
 with ecdsa
Date: Thu,  3 Sep 2026 10:17:04 +0200
Message-ID: <20260903081705.12894-15-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|MRZP264MB2907:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8998925a-20fb-44cc-2b4b-08df0993c4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MSSrFnGufi4ck6sH6kfuQMfs7DPp3+PHgBIQiXzaOZtpKF6FC/OzJZcujNVZa2mNJudsahkBYIEi6/WU0Xnz+Vvq/98LTPf9jNvRk0b8Y5dfsW9i7N7RKU+75psm2jrlwb3Ls9hpwos7lUHBeEb6lHRDM0nfix9qUlNAGS5DiTijGt8SNYKU4trCGzB+HQDrAtoVD6tpp/gA8+HXLjiSCwympVR85Y9kb99eDPRecqG3PeSu5122qihxaH2FysF4VgYfpZIm6BX7iLuZMNErjwddcVBcKeuK+XDpkzhZeTqNboNCmH2GZ6xaLJ23634D+5oCCsVuAEg3/zfSIIeCR/ogu8GLpJcfXPG6NgA9Sv9OwHFXOBnJ9yoNHBSZSybQwsc4dX52NWwJNaPMOnKe9pAicvwdA1EbaMKwezrXBLKnBWV1PRYpQP072kP+e2CHVvQ6QqP3vUzlGAEAYe79Xj5q7XFzj40+6YpMbHQMh9VNAwyQqd6CRrB37SugWk+xKh4l/TJQ2jlggASTPdef/JDeo9MwEAXtJsQYxbe4Au15MxXeu8SvZ3yd0ljD0ygMvLYPfZWAeVwBf3V0yFMr0/2TcrCuvUqGe+heUHlphdqakAxuMZq6qpHkg0sjpOgC0zWAOjMbc4LxBxC2PTRhuntVPxZ+2ZyZ7RsMPJGxcAb/OIdc+0i37NkNt35nL0ZJFS5G3tmwvCq3YlFYD5W2kg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fMwgwdDbcK9LyMRKDU8WPOPHGYJU9PNCa7diHkQglFIU7J/vgaIC7/8NKe4GFQ0hztmZpywBjPiFrRwir42/vDUPYTxUkj+ehrIpSYJNTR4LAQsU3qGR0ljPAaHScUUJTmO4oV4tMawQf7oFqfg1HD8ulfnsn9UUj+flleBUutW4gVg+IbPY7Z1Tfg5gR8U/XhCNtsuxj8WE/FU32MYB2WccBZJMyBknFZpkEbIG+ZBBExFZ5oP2RVwXHjTZneOygE1nnERgJttG81SbVm8FkMa9yXAnjkcP9cE5EFuQ3F1UWY5/f1WdY8NI4IbZpopIaqsbkyUyBZMtcwbpaTDdu3bvZxtLsQvIAmmuYZ5+6N2cn33qTIV8AWa3BhCiYLsam0/1jUnNgDg4fH233fe0VvxInJDYsrzn95R7CoBomUnSOLUncid2LtyaM0+p6spx
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:17.5535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8998925a-20fb-44cc-2b4b-08df0993c4c6
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2907
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

The vboot tests only consider rsa for test with global signature.
To prepare the integration of test with ecdsa test, the signature
algo is now explicit.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- no change
v5:
- no change
v6:
- no change
v7:
- no change
v8:
- no change
v9:
- no change

 test/py/tests/test_vboot.py                          | 12 ++++++------
 ...binman-pss.dts => sandbox-binman-rsa2048-pss.dts} |  0
 ...sandbox-binman.dts => sandbox-binman-rsa2048.dts} |  0
 ...pss.dts => sandbox-u-boot-global-rsa2048-pss.dts} |  0
 ...-global.dts => sandbox-u-boot-global-rsa2048.dts} |  0
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename test/py/tests/vboot/{sandbox-binman-pss.dts => sandbox-binman-rsa2048-pss.dts} (100%)
 rename test/py/tests/vboot/{sandbox-binman.dts => sandbox-binman-rsa2048.dts} (100%)
 rename test/py/tests/vboot/{sandbox-u-boot-global-pss.dts => sandbox-u-boot-global-rsa2048-pss.dts} (100%)
 rename test/py/tests/vboot/{sandbox-u-boot-global.dts => sandbox-u-boot-global-rsa2048.dts} (100%)

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 89876ff030a..e3996486ab6 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -536,7 +536,7 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
                           dtb)
         run_bootm(sha_algo, 'multi required key', '', False)
 
-    def test_global_sign(sha_algo, padding, sign_options):
+    def test_global_sign(sha_algo, sig_algo, padding, sign_options):
         """Test global image signature with the given hash algorithm and padding.
 
         Args:
@@ -545,14 +545,14 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
                     rsa signature algorithm.
         """
 
-        dtb = '%ssandbox-u-boot-global%s.dtb' % (tmpdir, padding)
+        dtb = '%ssandbox-u-boot-global%s%s.dtb' % (tmpdir, sig_algo, padding)
         ubman.config.dtb = dtb
 
         # Compile our device tree files for kernel and U-Boot. These are
         # regenerated here since mkimage will modify them (by adding a
         # public key) below.
         dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
-        dtc_options('sandbox-u-boot-global%s.dts' % padding, '-p 1024')
+        dtc_options('sandbox-u-boot-global%s%s.dts' % (sig_algo, padding), '-p 1024')
 
         # Build the FIT with dev key (keys NOT required). This adds the
         # signature into sandbox-u-boot.dtb, NOT marked 'required'.
@@ -561,11 +561,11 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
 
         # Build the dtb for binman that define the pre-load header
         # with the global sigature.
-        dtc('sandbox-binman%s.dts' % padding, ubman, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-binman%s%s.dts' % (sig_algo, padding), ubman, dtc_args, datadir, tmpdir, dtb)
 
         # Run binman to create the final image with the not signed fit
         # and the pre-load header that contains the global signature.
-        run_binman('sandbox-binman%s.dtb' % padding)
+        run_binman('sandbox-binman%s%s.dtb' % (sig_algo, padding))
 
         # Check that the signature is correctly verified by u-boot
         run_bootm(sha_algo, 'global image signature',
@@ -615,7 +615,7 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
     try:
         ubman.config.dtb = dtb
         if global_sign:
-            test_global_sign(sha_algo, padding, sign_options)
+            test_global_sign(sha_algo, sig_algo, padding, sign_options)
         elif required:
             test_required_key(sha_algo, sig_algo, padding, sign_options)
         else:
diff --git a/test/py/tests/vboot/sandbox-binman-pss.dts b/test/py/tests/vboot/sandbox-binman-rsa2048-pss.dts
similarity index 100%
rename from test/py/tests/vboot/sandbox-binman-pss.dts
rename to test/py/tests/vboot/sandbox-binman-rsa2048-pss.dts
diff --git a/test/py/tests/vboot/sandbox-binman.dts b/test/py/tests/vboot/sandbox-binman-rsa2048.dts
similarity index 100%
rename from test/py/tests/vboot/sandbox-binman.dts
rename to test/py/tests/vboot/sandbox-binman-rsa2048.dts
diff --git a/test/py/tests/vboot/sandbox-u-boot-global-pss.dts b/test/py/tests/vboot/sandbox-u-boot-global-rsa2048-pss.dts
similarity index 100%
rename from test/py/tests/vboot/sandbox-u-boot-global-pss.dts
rename to test/py/tests/vboot/sandbox-u-boot-global-rsa2048-pss.dts
diff --git a/test/py/tests/vboot/sandbox-u-boot-global.dts b/test/py/tests/vboot/sandbox-u-boot-global-rsa2048.dts
similarity index 100%
rename from test/py/tests/vboot/sandbox-u-boot-global.dts
rename to test/py/tests/vboot/sandbox-u-boot-global-rsa2048.dts
-- 
2.43.0

