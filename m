Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A9AC624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:37:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4760081176;
	Fri,  4 Sep 2026 08:37:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V8C2fjZv5lNW; Fri,  4 Sep 2026 08:37:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 082C78118E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511078;
	b=FBkhYMYrlbZ02Ox5c4uUuuuF6xtN2k6qgHArfrT05y3i8gxnnjetwvvFsudxy23+9K86
	 DsGyVUNWcFaf9yE/Istpc+JU78iND2eFKeFYc1Bm3akNxfu7yub8S6D+aUGheEjh2Ucgk
	 w2mc7qgkqMzMQWutS8IyU7whkl05bYAL0qUecdb9lpyq//bA1CzXVmSiKprCYQqjj25Lh
	 LzxoVPPigKLoWzMWQ5NXWtAdQJLb9mgl4389OwtTXF/7Vzt+qUOvZRP4zQlO/uWiomr8S
	 pjThNCFu+zgoH3nKBbBLdbq863C7yzqD4MHHVgavymoMkCz4NNXyyjsbyjp6N9gl/bA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511078;
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
	bh=iJop89DrqEJ521O9dYXWTJ20Ef6/5O3wCXxC7Ij/biY=;
	b=fnaRUY6BF6AxV349RYe6uzFRktCjXCUbNuMOlRbYZ6dtyn7pZcNNdefC1u0p7FlFPLXb
	 5FPeBxbbWaI5dSXVKZsVtKuHvXdODgaa5egtxSX/5FoQMaBAYQMIdaO1s2Px8S73PGgiH
	 Qvh56MgYS+WAPA7arU7Tr4BSnA6y1BKSDuOUaZdCwtJ85L0BiDFbDO6qGWblmmdE9dYm1
	 +5qVK5ohr25yB5hG8BCp4FeY//B7V2PYDRCY0vxwwrE2S5Mrp6r2s6tgywfcJ+TDB+LSK
	 //XpJ0PSJcI9/vZUiUTnr24Q7kCVLj6zp0QJ6BxlJh08Y2NTK6Sato8ZOtejimI8ghQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511078;
	bh=iJop89DrqEJ521O9dYXWTJ20Ef6/5O3wCXxC7Ij/biY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EtnxSM1iC0KgwAQFnQBpQDcZdBmhU2LtMPGSr/jq+Dj7cDTcAHTYkBUM5YtXt718W
	 rYwFbtiRZyMeYl/MpYkEHTyN+A0XLNaiUyEgsX64LX66+YTc2mGVEPB5WpnKyke3g+
	 BrLBKmaXZ6jcu1gi/vAopscfdVnx9WMgz7uWd8MVJwCLHtYAzelHb7a/FrYKTSI7tB
	 qWsl7ni0il9vUeD0qdBNeFlfO2BzYCNNo6jKUmQ3EwRNoM/HBXS6t93eu03Hkwvk9j
	 IaUeKIylbEAxcrvsyZDpBAcRCN7FT0bLbsARSe1I9wabE1+dY1WUkDkjUC+TtiIGze
	 kcBfHQw4uvijA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 082C78118E;
	Fri,  4 Sep 2026 08:37:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 49D963AF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35C3A60BB6
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QCEWQrnq8UFQ for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7DD8E6070F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511049;
 b=pbj/z0V92IcXKOG/eytS22qN3C8REgLdhwVpZ91g3VdWMir/uZcXsrbyOC78kRS1URSI
 5k2RsRaKVciz1DShQA2dxJrI+nLSITTlwQ/M2FV434Tc4skFsOyZYLuxWBXbsJ81Zt91L
 gKsy/laGRt/SsHmRTs5wjK3HgT6pz6vLQbGa1oj2II09rLP3QPY5JLTr4DMMpKbtNvwU7
 0zc6tHXiugn4wpQLEVXAWosco7CDxA/XYRhR3It76EgnEyBVXBJ3GDANwGnE+dk5u4URi
 iinN9we68guVDm/+9BVmcfECelndci/CUMWq2FxAV2enO4ZNuJ/KWTtmWflcVKjUR4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788511049;
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
 bh=iJop89DrqEJ521O9dYXWTJ20Ef6/5O3wCXxC7Ij/biY=;
 b=a4/JfNkupP7lzO+SNedy6+ZIFZjg29570+BxeufVMI0XYgsQO8EMPWMBonvY/t0lpezh
 Zq1UJJV4DJ5ttpBJmfc4IaauNFwOEuQQQCUeTZcRafEBvCbG5nwYHuSFNbVg8vVLoQnJ/
 dpP9lRsHHhx+83LtWXm/e9A0JKSmYvKuZ3P/RbaoVlXS5SHR+FcLBFQJ0+LtZRw6mYfJ/
 3aAcX4isS9NRh1Ak+TatCsPQUS3I2w8T/OxPoCgXlDDbGuVx0vYXq6p/NkvRYk5Pbs9jB
 FY6zPFQzrPYCPd4fvUIDdPpDEHrfy2h9WtkdIRYTV0z8y725P8Ui/KRe7u4fWBsZprA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=tSB1giZt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::1;
 helo=mrzp264cu002.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=tSB1giZt
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DD8E6070F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvzDwM8TfyrjBubbx5DSGv8tJfAUJ4SwoHH6qxPKWMvEQ3xhq3bQdjXgcBRZCI5wLmRpKjpHidpb0SIDAdmXt5NI6kBj/k5OLwbFiCWIAwgw1+kVlzSa5o8Si6JrTX7lAtWqNdGVnjCM8U14kwFjCl2Y0UNmAq2c/FXZijEQE/dHo/xh8YnkFXeOgPNdDuJUcn9rrN2GPus6mL9x9l94AhiWXHwbPwzbEr/QE3HFcgYrN/rniI131Aq2lKWJQ+CsC5vSX7tBSQfMso4l7dDmJ6HpqyPCIQXX1mp3v7baUBzeKX722wNEGGth89sZW8mA5jhTR6t/xyeujU1L2F3PFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJop89DrqEJ521O9dYXWTJ20Ef6/5O3wCXxC7Ij/biY=;
 b=MdeabPng1XbOqsxv2nESHmJYLCoamueav3NxLVAPJw+FzLZtEo10CODSushhL7Qme4CBMS+uNADvAwWdKTdF0xm1dGPfzHR6er5sFyi8hMaVcJexR1/elWUnouu/cGQzRkG5QPY98uv4xead4JW4dDmxyPqQcv6U6bOG+L2FsPtAH81YeCEXb8yXOBBYWvlqSDZ0s9sohoQ6+2U510GjVRtbP/EhB6oQ81XeOpjUqSfZIv1egjbDg8fCTaXvclrzzeKQUp5j1Lh8ExUmivNgWqFAAZ2EwGhTHaAAwmrNFNXbrWOF8Fw2r6f462jlXxu0ynEdlsDVXQqAJg7r4ojnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJop89DrqEJ521O9dYXWTJ20Ef6/5O3wCXxC7Ij/biY=;
 b=tSB1giZt5bLFQCfUJ7uGhJEm61fVJNBpR8sWWvAToS70iQcs7Yya30DrG1/uSzQM3Sord/n1sFy0jUMh1ZYZa+c+SeqSPrCoOrA8g3fXyP7BBYOm92KF2xcuq+tmJHAfeGFbef/1hLMNgsa/8IJNfyjov9cRF9KXIuksDS2lIpIvJ8i9+bSKMm9T0P/kll5JTasD4uXBJyqhLx+T15F3z/TSVSc38eLdXdVVzJigsGxXpRkovkLudRPm6Ak+RXy/h9lUflPDeawg8XhJjWcFp5Y5sN254AOG4H+4rXrt2cnCpdip7iYrCQX6GXGxc7E/kDh0qpBRDmUftnoxrOj0pQ==
Received: from PA7P264CA0211.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:374::7)
 by PATP264MB4641.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:37:22 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374:cafe::67) by PA7P264CA0211.outlook.office365.com
 (2603:10a6:102:374::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 08:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 08:37:22 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 79F5E2044F;
 Fri,  4 Sep 2026 10:37:22 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v10 08/15] test: vboot: add test for ecdsa
Date: Fri,  4 Sep 2026 10:37:12 +0200
Message-ID: <20260904083719.53132-9-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|PATP264MB4641:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8cc8cd1a-ff00-40dd-1831-08df0a5fbd79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: zsdNM+g5D+u9suF8/9jU90SphJuOEmB5xo2yPjFINmcpCNv9EjpSGlOUpyuLmpHwPghVIutbouUUv4mC47qIwcWvIoWQlkPgSnZAQCRURsQpA50tfDDKQxdC0Dx3v+mLUyZvGZb/uzskdeEGDU4aNhB3HU8DBGxd3Cgjtv5HLTz2faOdX4qrQyf8TROig0bj7UwSq+AJ95MCvKNUeFGxxsGsErGz5kLvWl76jhxJ2VgpZPDN3WTKmnX3NySaiqU7gsRF0UPTzed2y1epePkxQOCL6v14EUA/hu7xN6BKPwBk5Kq/26IbQ/Ev8M8G9Z3lYAQ0TsYrtczX+zkumIJ55+6rLzbBgiTxaJ//fuUWx5b3D9+t7CGkQs4scqtpx+6cijP52MVoJnslNwAM4K0HcUJFSpU/TMmK4TCiYdk48Tk3fA5A5TBPGJ3aElVqPAjM/7L9WMLyuLGnK8OQDRT/iyK/OH5r1korg5jOm2UNearxsCRVqs4CxR12+QgHpjrn9d1A9dDxB/efH9I0eunzDC4HO03RYZEghZYnVwN4NFjty8i2sWwzIrfabGzZ0Jpq+tuwchH+8tDlCT3Zh10wLLn51Lp9yMP5e+WXReupCxHDH2rGglqDssJrLEvKFdDhvEVLsGSCoCZaR0j+P23lq0LSkqkkrNybeBfIQgMbz9Cv3tKWqJM+Gun3SUS6ppvPW5ckFXb5BG7hsIxtTvnbhg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j1mKrJ2M/cqaqRpissMM6JpAIzEgcCElek8+Urq5mR6ew1J6UTIFvJhdCLo3dbxKJzUiFCS44qicxsEVqd6gl3xaTPX7eMZ/cx8v4B8YpMLuYm1eqeRdePVizQdyzSsiOy3TmSO89v8NWBzyXJru6Dn30e0MtHLIHo3SCSs614S8Hhq6z4sB50KvYHZEOEniL2m1f0qWTgHrbmXH0gpvmtlBXP8nrkm45QQe1BHq1lF113g61w8jAikq7rAcor9TRQbbqMEPD0/LhWNNt/DIKfNWzE6XXb33DW2rI6d0SqkbBdqA2+S+6RpblJ0/x2u6SCsKhFlC62ud+U6wlqzloh57PqV4bJCR4WWdYTvBneNHP3NscbPRSav4hEqoWw/dAIO9IGmUoclmvi4R34GyfMqlnxpCeJiutuV+WR1ubVPLMVoaAZvYnvp9C9vY+V0r
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:22.6430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc8cd1a-ff00-40dd-1831-08df0a5fbd79
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4641
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

This commit adds test case for ecdsa on fit, but not (yet) for
the global image signature (preload).

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- initial version
v3:
- no change
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
- some minor changes to fix rebase on next
v10:
- no change

 test/py/tests/test_vboot.py                   | 29 ++++++++++++
 .../vboot/sign-configs-sha256-ecdsa256.its    | 44 +++++++++++++++++++
 .../vboot/sign-configs-sha256-ecdsa384.its    | 44 +++++++++++++++++++
 .../vboot/sign-configs-sha256-ecdsa521.its    | 44 +++++++++++++++++++
 .../vboot/sign-images-sha256-ecdsa256.its     | 42 ++++++++++++++++++
 .../vboot/sign-images-sha256-ecdsa384.its     | 42 ++++++++++++++++++
 .../vboot/sign-images-sha256-ecdsa521.its     | 42 ++++++++++++++++++
 7 files changed, 287 insertions(+)
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa521.its

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 33cbcea5c24..89876ff030a 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -94,6 +94,9 @@ TESTDATA_IN = [
     ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
     ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, False, False, False],
     ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', True, True, False, False],
+    ['sha256-basic-ecdsa256', 'sha256', '-ecdsa256', '', None, False, False, False, False],
+    ['sha256-basic-ecdsa384', 'sha256', '-ecdsa384', '', None, False, False, False, False],
+    ['sha256-basic-ecdsa521', 'sha256', '-ecdsa521', '', None, False, False, False, False],
     ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False, False],
     ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, False, False, False],
     ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, True, False],
@@ -287,6 +290,29 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
         utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.key '
                           '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
 
+    def create_ecdsa_pair(name):
+        """Generate a new ECDSA key pair
+
+        Args:
+            name: Name of the key (e.g. 'dev')
+        """
+
+        if sig_algo == "-ecdsa256":
+            curve_name = "secp256r1"
+        elif sig_algo == "-ecdsa384":
+            curve_name = "secp384r1"
+        elif sig_algo == "-ecdsa521":
+            curve_name = "secp521r1"
+        else:
+            curve_name = "unknownCurve"
+
+        utils.run_and_log(ubman, 'openssl ecparam -name %s -genkey -noout -out %s%s.pem' %
+                     (curve_name, tmpdir, name))
+
+        # Create a certificate containing the public key
+        utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.pem '
+                          '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
+
     def test_with_algo(sha_algo, sig_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
 
@@ -570,6 +596,9 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
     if sig_algo == "-rsa2048" or sig_algo == "-rsa3072" or sig_algo == "":
         create_rsa_pair('dev')
         create_rsa_pair('prod')
+    elif sig_algo == "-ecdsa256" or sig_algo == "-ecdsa384" or sig_algo == "-ecdsa521":
+        create_ecdsa_pair('dev')
+        create_ecdsa_pair('prod')
 
     # Create a number kernel image with zeroes
     with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its b/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
new file mode 100644
index 00000000000..6bd291a40c2
--- /dev/null
+++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
@@ -0,0 +1,44 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+			signature {
+				algo = "sha256,ecdsa256";
+				key-name-hint = "dev";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its b/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
new file mode 100644
index 00000000000..68c482acff2
--- /dev/null
+++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
@@ -0,0 +1,44 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+			signature {
+				algo = "sha256,ecdsa384";
+				key-name-hint = "dev";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its b/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
new file mode 100644
index 00000000000..f673accd39a
--- /dev/null
+++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
@@ -0,0 +1,44 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+			signature {
+				algo = "sha256,ecdsa521";
+				key-name-hint = "dev";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa256.its b/test/py/tests/vboot/sign-images-sha256-ecdsa256.its
new file mode 100644
index 00000000000..009003bb601
--- /dev/null
+++ b/test/py/tests/vboot/sign-images-sha256-ecdsa256.its
@@ -0,0 +1,42 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			signature {
+				algo = "sha256,ecdsa256";
+				key-name-hint = "dev";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			signature {
+				algo = "sha256,ecdsa256";
+				key-name-hint = "dev";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa384.its b/test/py/tests/vboot/sign-images-sha256-ecdsa384.its
new file mode 100644
index 00000000000..567de687a06
--- /dev/null
+++ b/test/py/tests/vboot/sign-images-sha256-ecdsa384.its
@@ -0,0 +1,42 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			signature {
+				algo = "sha256,ecdsa384";
+				key-name-hint = "dev";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			signature {
+				algo = "sha256,ecdsa384";
+				key-name-hint = "dev";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa521.its b/test/py/tests/vboot/sign-images-sha256-ecdsa521.its
new file mode 100644
index 00000000000..74ed45b21b8
--- /dev/null
+++ b/test/py/tests/vboot/sign-images-sha256-ecdsa521.its
@@ -0,0 +1,42 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			signature {
+				algo = "sha256,ecdsa521";
+				key-name-hint = "dev";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			signature {
+				algo = "sha256,ecdsa521";
+				key-name-hint = "dev";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+		};
+	};
+};
-- 
2.43.0

