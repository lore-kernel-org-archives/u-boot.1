Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB61D606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XYnyK4IP;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=smchoBsp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE6BF40659;
	Wed, 28 Oct 2026 08:56:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kA6UHdFOyNhH; Wed, 28 Oct 2026 08:56:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C5E74055E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793177795;
	b=WLUwNs4Vd2HMYaBv0nP+KACDt2P3/zDLkxdjjzffvm5Lj/ocds021p+RNcvXFGeXEzj6
	 nLtLoBO7oaCRRHlzlimN/81KDRsw4eb78w3RcX8IBBecIRUT8QUFSYsY/3dbKgvj4Az81
	 xIKuik+Py/cOEy4yd3foyQ8IYfgQUQJX/UfWZjhX8ZxD8FsZJgjDiMvDs+bmjHiNDeUeN
	 pfJZ1bSPu8+ZTo2NLSsvIrLaf2wjpZf4mKCKX3VDdYFNbInA7SSeRO8ZP4ebcwkIXGD8O
	 X7l8eWKfxO8u0PRRteYTA5gjUzGu2rY7gbEMZ94KqBQx3Kw6heaoYAl6Kvyy8bZMpng==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793177795;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-Id:
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
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m0Iih+UWqOgkMtBwxK3tGgCWo+lIU14+XLIsQEK9K/I=;
	b=SSdvjRzc9V9/crxcnM2MZ/yp/1sqfMr/N6OO1Xew7DarexSQN9Sq2JpGhOZnDZpzozNR
	 DQ3gdHAvOCq7vfbN6/8Xw8TpmLjR8V+RYkFedWYMCU7S3EHvLm2XP3z7dAooviHkDVaJF
	 HpBo12/wUd4aKB/jTMCDPO1D+/q2bB7FK3lv9lkdUEDDn0wfnLFe/Rx+n7t1xFPBoh4wP
	 UHJWLocT1ElB/Ege1216cNVRqifCO+NxT/IQ8cm7Y8UkKNSXj+rFn3sCzdICYeOp7pSKX
	 28jpuLPlEkfa9DHIVSB0GhfX4SmJsSAL73q6LdHSRTMdujeP6rEyS2/61PQtNZC/yuQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793177795;
	bh=m0Iih+UWqOgkMtBwxK3tGgCWo+lIU14+XLIsQEK9K/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XYnyK4IPmk5jITCgOsgkxPxtbv6C9M61bm/41hD572NArEEUo5aESuubD/WTf5VNF
	 NHHS08yxVkfIDpOTMZ+Ct+pJavPtzvAaUeZVM3nzdgSReEYcFha4lc7g4s+S1wKY2p
	 xwk4xFULkCcz07/ohtlA1SK24NQ2iRFBnuH2yaGcyqSxOkUhagqou0XNy63G+5Rz0i
	 FLcFkNjZwrUAg+RE1V2PEr2NCIPQGIa8M6NGxY8DLuBgDKf2+F3djrlWYHVyiuc9JH
	 RmGdO4xBNkPfcgYEejvR/Qtvz8tG+drfvNWeprdRS4Kz228GNV2LSc7vnf7yD0dQUe
	 osE11YnNGxeMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C5E74055E;
	Wed, 28 Oct 2026 08:56:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C7444D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D7DE605EC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gieltxEtlbfE for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:56:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7469960658
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177788;
 b=p/FpiQ4DvJ3+IpX54yGmMcY5S4nS3dKh8T0b/9hqp+fGngroJTnXkmi7rtIwakwixjfQ
 g+guF0U8FJVAX05gVI6CU2dvAltthT2wpJOrt0kkNX1TNjSY+cXPJVWqJw2FD3ybILX6I
 aTkUsxcRUzMRe63LAnMgyHdbH6MN+x3wG+7ijnCOA2XlZivpvocJQMKqIx49KG+y4vKqT
 bTjTXSqstYGfkkyy24tGnMD4uDU/bOHDGMPbxqdVuIQHz4WWu26Q0yZMh80qhXVqIduIr
 Y+VKlWFXwNrBfXiaUhJRCSx8Ds/mTcIpfejBzEgtBIq4WxEeE/eabts2AEUJDFmaYiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177788;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
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
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=m0Iih+UWqOgkMtBwxK3tGgCWo+lIU14+XLIsQEK9K/I=;
 b=RESixyhiONzxoVSdDFVN3nNXuhIs1aMV2Dqs0/Zo0nw1zzD3NTU+wt1MgQKzM85lRXZJ
 kjRzesgmPIZABeStjcU9kGpFhvVOhgFWji01IA8KLw+I5Xmeb1Rw0MydPQDE1OBcfmQtW
 Nt0V/Lah/LvqCp6AJeiz4aZAjci5sSnXaIQ2atSlzYVfU70iE9l3fwnFyp/Kw4hITJXdB
 6BvC3BS7ChpRnJJ15DfWdn2sOkNlqo1TfuH+6p/ctm/zhwiFVJwAVQnHSOdlZoSMcKdVc
 H+TDBYjI3LjUFWuSlteIcntDrYDptSDFxYGqS55EoMVzLTQ8N25CYlsvV2ExuZ+VAVQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=nokia.com;
 dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=smchoBsp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=smchoBsp
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7469960658
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjbZjD0WxtyoTV31r9JF0sCWJXdvW4nxAzfF8jfD4eBha1FvRyOCxpJHeKWlCJOkAMXqcW5ok23TVAPXuWD4MAAq2wVPFfxagUU0Pag4P81kyhgpjtsswM72SJn7ZrIHn23XTdnXUcdCnsZLuoryGM6Dxu2GjsPkuKekpNymea38pbioJbX5GRe16SlleD2+lBJnM4dEorizz2UrrNNObDFU4DSt2SLsLPmPo1DFZYveS/GD5kZevIFqG8pSLlaAYp3O9D3vCx+Z4p7qyl7Fo+UzA+O8Lbjcr2w5LNfsWIndUY0WjpabLlG0XsM/7vwY38P5v4hwBcabUqyj/lVikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0Iih+UWqOgkMtBwxK3tGgCWo+lIU14+XLIsQEK9K/I=;
 b=u0Bve4UnfwUrYWg5XD4AdJyngaEj062jkZxdxaTvg3tzIYu8XBm0klVprVqZnY3eJG4hrGzjWZTX8D8o/pU9dL9GUuK/x0UugZpQAuW/zrEryFU8UrId4mfnESgnTBhP267Ckq9EdwT9bK7PkK39CEAVSX1fxWb63BpOZ0YrGLU7gkYmAXtg7+FvBxV2vVr1QORxEi0rZ2P9EiAP3zCUPIjYqOpXXhfcpgm269MIxRazJtdKFjhdRdmYqhrjxFYjnDvBVk83g4u5Q/no9Y0aWZtDz9m3YZTg/iO+ek4sojmH0Nwhlv3oTAhq7JUT5bAmivNi+osVAAT4GVFrfJKLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.26) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0Iih+UWqOgkMtBwxK3tGgCWo+lIU14+XLIsQEK9K/I=;
 b=smchoBspKCLplHRpcyICLUX65mJAC01ofmEqFb2OX8R0LhO8HMh4pPyV0PUuGt578UwhYTuJjokAhWLQa4DJ0Oh4SLHR1tlN6Tf5u4VJhRA6bPX4i1c1MX30EBWXeiFzoP9w4eP8SvFU7nIjVr8ZRhelOPIFdSNzE9rfzOati8IKgVkR4t5jmvfBAtkxFeX0u9k2TLZYdFbeVrET1QG8YeGe/3xfmcnZdxs1K9C+b4S8nfpIw6M+LJZriBjnnh3YnU19tiJSg+yPeXtdOxIJExjO66dND0BZfdYzMRMVl+YAaFSE41kt2H6HjJCBMFUY8jeum02TIs4/TtQbqyRqZA==
Received: from DU7P251CA0015.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::6) by
 VI1PR07MB9470.eurprd07.prod.outlook.com (2603:10a6:800:1c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:56:19 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::a0) by DU7P251CA0015.outlook.office365.com
 (2603:10a6:10:551::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 08:56:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.26) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.26 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.26; helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.2.26) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 28 Oct 2026 08:56:19 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id B9ACE1C003A;
 Wed, 28 Oct 2026 10:56:18 +0200 (EET)
From: juuso.rinta@nokia.com
To: sjg@chromium.org
Cc: jonas@kwiboo.se, jonathan@joggee.fr, juuso.rinta@nokia.com,
 stefan.roese@mailbox.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, yuriz@vodafonemail.de
Subject: Re: [PATCH 5/7] watchdog: max6370_wdt: add get_timeout operation
Date: Wed, 28 Oct 2026 10:55:55 +0200
Message-Id: <20261028085555.2369135-1-juuso.rinta@nokia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAFLszTgYVqecfgvEbuBvq+Vtoa3pOd1mf0JnA9Y6T1QhWKJEmQ@mail.gmail.com>
References: <CAFLszTgYVqecfgvEbuBvq+Vtoa3pOd1mf0JnA9Y6T1QhWKJEmQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FE:EE_|VI1PR07MB9470:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c30c3d0a-5681-41c6-4d2e-08df34d15558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|261026140227099003|10067099003|11063799006|56012099006|261022105027099003|18002099003|261026121527099003|22082099003;
X-Microsoft-Antispam-Message-Info: KstGVvfbWh6U5U4aTema7O75IvBooqGsMG4/aBiXZ/28ZFEKzF+w+9y8DrWDqLI26pOTKVLnTitktJQYLxtjUlE9uV96oVjsRpYjc9AoR3B1Rp1w9ESok68G3CcmlrroibwjB20nmkSsu03aVULJ3njAJnwq5a/XDTdFCSF0suX1qMfOpE6LUsh1iCWDQLY1uZRPj/4tccM0qY56xkmyW3QToFxnyGEG22bezJuIxYLVcLueoN+F99HYJ/7dx4eS6fuXLUUkdjowps5/FNIAJuPVNbHH23l+HCL6dMEfV+zRNlqmGw+xgW/27DsHKzUxyhGMHjloAipo0PCXJMMAyb3R9bSvFUzEKKo8mbmEuji44c2b0S18JW9BKdwnz3Sr+Z1bZaU2h+vVNqCsMDpCvvQV4V+EgvORAspDyAGv7S0Zg1xlJ3VjTjMMOyMRKxNrqcaQid5whk1/VJMeFOJSAdefRLby0wmmhJvZj4vokuHu/T1AQGVP0Z4VID0EzQJ4qtb/3MmKND2kco0Oc94Kub1mscG8DPc0qJS7bPlZUVkQjLPXif/Dkj4NiNzR7ec0obhecIJV9S+BCpy1pW0V7RGk8FiZZwwTvc01Io1+fqHKzBJM/1O1J30ikstBvj1cK+MrlhEIy7dSi2t3ht5hHgDmi86lzLO8fgW6OjSItiKZHkuESMuwo9iZBFKBlRNbzQp9iV8iFXzJ6YRjpD+kkw==
X-Forefront-Antispam-Report: CIP:131.228.2.26; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fr712usmtp1.zeu.alcatel-lucent.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(261026140227099003)(10067099003)(11063799006)(56012099006)(261022105027099003)(18002099003)(261026121527099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w1emZbm0YGpsnM5p0j77mqZJfxySTpkuPuQUZ08pj2HrVJj+AANLCerRrEcjWYCeIunPs1IQGfFtDO26PM0qTtqvtzuaSnh1GgohM2iLACmVzh27XnQWU9EAle1qW1HU6MGcZehD2k0/tKGa1RwG+SEd0IAxC7ko+Q01SXuR2p2g9VRqRnu7aggnm5GQQ97VuF3+1ioixhOwZGa9fSLZEvMohSLEJC9IucuwNaVtUu4fMSPkEY71B19361mMOPrXFJSurWgPtQBUh8mEh5Dxq0fMZdULyqqsshYSLEZCdiN93mJpcIlSvYZgySKVxlXJuy+m7GW2JchWwJeO+UruDi42+W8F3wUmtUXBJ+idWvzTPTX154M85WPG+txkHGQqClH3Tsu2LkLVMbkea1JjIp8mfJLtxDdUnpbi3i//+p0c8alvZwfcwj6uBQI40pub
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:56:19.3435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30c3d0a-5681-41c6-4d2e-08df34d15558
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.26];
 Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9470
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Juuso Rinta <juuso.rinta@nokia.com>

> max6370_wdt_start() could then use the same table instead of its
> if-else chain, so the two cannot drift apart. What do you think?

Agreed, I'll do the lookup table approach for v2 and have max6370_wdt_start()
also use the table.

BR,
Juuso
