Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A0606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i8AIyim3;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=i0/9zRhs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F05186070C;
	Wed, 21 Oct 2026 07:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jRCNoQ7Xuqd4; Wed, 21 Oct 2026 07:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A26056074D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792566808;
	b=oyRkbIUsBE6tHIhTwXPDmDHB7ujjwere6t4yf2oVNIWbPb0V9WpOTzMN6SVes3W+mMyT
	 aZcHEZHcCT/WJ9AaXHA28rGhC0tOUjzIjPtoF3vICCCQ+JlDTbThvdEMso8vCMKk4PEcJ
	 86rreoF+mfCMD0zB1G5ab2vpr7cDTnleWZ8wJanNu6LuuJNuRR3yl5hJMq3ulWFo2bFB7
	 EAHbbkHtzt5voQ+ij9TzQo+xQG4ESjPw/4jmbclKVONoUbqwsiRglWbS3HflwzfuBg1WW
	 JD6U0SIx99TbcsrVHR9C+pLpx+cL2d4isuKVdDhXAJPxxm2Wb81jnBeBzUy7t+/KpvA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792566808;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wJB+AlYKGbXmhm7koRqtppIXSu9i1PdlDxwOQobSbEo=;
	b=LEpN9a71hFrtD7rgSQVKk1C65651nQfCm4583JQgjhnWxNq4T5xj9krYwZNroCyFf9CH
	 X9qam0IWrnwWL1fZrOLytUW1RT6yv8OBdBOzUfUKeUoEPETaWjdRL51d5yKtFxu15BNQw
	 afOD3hTIe0ilZjB54Wl+0CssFsNkD1lEkNQMDX0f78rZQVs45A7twCoWX6V9kqL+DBZ7o
	 tb7NT1mdLoc3zE/FyXsRbqyBbWsi70M6cw7sfSMknCg/U+8Ycp9nU+DssNcfS0Wiyv4CG
	 0VaRMWZj19geNp4fxzldApT/SuDdmyed6a2x5eNdgUPTfR4TSeStLpiCpQ+A+klG01A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=altera.com;
	spf=fail smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b="i0/9zRhs";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792566808;
	bh=wJB+AlYKGbXmhm7koRqtppIXSu9i1PdlDxwOQobSbEo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i8AIyim3gCpfNCXsmBrd+Ad31no672qPvDeM9mt2fG/ogQrmp5I3gSHMKicjXV3/I
	 54af1tRFbHmTNx9B0iDdtE+DgsjG1/svWqix6iREKkuGkFw/cKzm4bN83ZvSAgeig9
	 oc7kkmtNE+iuEg2a8h7IVXpJRXstL3HA7WEbGEp92bLaz7BF3E1NcBkQM4gB+w7eEx
	 nk63AXFm+ajHHtcqtioivD72jxbS6eD+8oBevsa8CE6+HEMb7O5KDOWYTbVbP+nkyz
	 w0aI/JjN+i5asDnri8Pf0/Xmbbun5M818WiRuS6Nk2YF2+zL7SxmjPmVvYmlIj+CkD
	 SrOGJAUiHEX+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A26056074D;
	Wed, 21 Oct 2026 07:13:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 640223A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55A806074D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Loa7sld6lGAA for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 07:13:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D48F36070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792566806;
 b=qSwCRxEwnM8xT6XCvNupvGl+5f7UpiG1ifOKQGMtyGMQ0YihX4El/OW+q/MbiiO9Zpin
 zXDx7Fgs+uM7sUAFdHyQVw9vVSd9IsEV2102V9XDtM7IW+nE86SZCRa34kbRYxW6z3Jhd
 pUDZTL6gf57hZ8Pb2Rooh2Co4Tunzvadi5M9TFYv8nranSWfUesCT2Q120iKnc92EDjKW
 lWa/ASDlM4WSTN8jRO4P16YiI8GZg1anNvm3gOZsqwYGdWCByQfx0CRHKAXiSVzRxkxJk
 MZ6OSXTxBa15Q285Sw8CC/QZNetDaBod31Mhlg8Xpw5ah1nbPzeVEy6JJJGI2I1MjKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792566806;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=wJB+AlYKGbXmhm7koRqtppIXSu9i1PdlDxwOQobSbEo=;
 b=ZR5O3zSMCm/tk64KRs16rsE63yZcp32r5YGVOz+ZPVxgnVtH1gEMaevqMupkJIfTUs/v
 B9YrMkgIU8jkC/8wX5Zj8V5o/dCUCLBZl+Ws7cmHdunu5qUvjo3o1gj/NYD/Z41x1fX7G
 g8db2BQ3YNaZmhEzOTmOE8MRrmbj57pxrPeusMZ2nZUKEAbypoacTmyv2Ozishs3D2ZpG
 d+b9CfkDA9REVP/GVL77yofj7JykqCPPJz7lxsZDQLgf+9zvuHF/p+jsHaOI9RMaZbp9w
 voVyMoSVtpxBGPHHKyrkJaqBjlzD5jK7rJ7xBchs84rD1qLz14RG92tJ3GmrvnvAV+w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b="i0/9zRhs"; 
 arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=i0/9zRhs
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D48F36070C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:13:24 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17340844F6; Wed, 21 Oct 2026 09:13:22 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67FD08056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 09:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iILGhQ53i86pIDdUlj2xDll9hS/Zxr5Ev84yUln6iLmG4/h8HzEw/kE4TAN91DckbAPFagMhsu2XdyihRb+jEojabAbwavl9uE7eDccaTGS8Nev+4cz6htuXbwIpwZQQ7oLs8AddfG1y+Z7nnn/DNgZF8VB1kiBD1PTmmxPWypc+7BqNGFdovIFvDUcCXmr1MjCvzrNlxGWw3VIWssVZI3n1+pKwlAoOwJgcZVKUXDGunhRSg1lvXW+1EJb/S8BTTNOUSSvHuQviBc1VECK5p1UaaErFzSNROix4p/rY69HE7+XYv+KLOHa53mbjw6n+VGExfzlHmuIMwvHAk/ANKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJB+AlYKGbXmhm7koRqtppIXSu9i1PdlDxwOQobSbEo=;
 b=nYsv6+gRPju4xM/3iXEsBpAJw5zFaUF3gxKu8VWJcSlWJF4W1jCZbghqshtoVDC0366l3MXjDuRGYmlSirH1s7FWgknkj4u9Dxkruidj2iXMYc7Hd26AL06bvWYd0VW3G9xEeb9xOWprowzQml/QaWaVQC+CqNYIzey4UQ+mCKn8EAXlIleuWSDc9jF3pOGAjPVzwIy5bkj94ypAaOd9skkhXsAsV+AOinCw2YguEyOMj2nIXQwhMVoKkAOdpR0qSgjVd+CwMUghazYaxS9r3BUels2eC3ClQ+bPqTHTVnnogOAN81Bg82JAByuETHHjEvgxUbAZdAzVebuYA+aWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJB+AlYKGbXmhm7koRqtppIXSu9i1PdlDxwOQobSbEo=;
 b=i0/9zRhsEU42+usRV0PjU39vJRjA4d8IcApdS9JFKB18CBZOvUO4IFrW/52bEFB5Ml2qXz173J3oGaijlBdFuyhOosP7b/uDyuxFHhuTAAHY+JCZ14Jk9FJQjLCWtXOaJKjVOiPSuBdUYvb/twsjsBtci/slB9X7LdLBzSFGwuymVX4bR62OY5XuUZgv5Ki69uhLVQX7AKv6NMtPRw/IZ7NwgmLgMJs+grVaWgakswO8swJwWmX8mjsWvRkwJTgPq2V3Iyou9W730nRAChMiZpQokVc7mh5E1fphfmybVg1Lv0CDNaQzRErIHrBTP0CcsVmjqW/QGD8kLKHXd/uFHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSM1PFD0404AE3C.namprd03.prod.outlook.com (2603:10b6:f:fc02::558)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 07:13:11 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0522.013; Wed, 21 Oct 2026
 07:13:11 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Johan Jonker <jbx6244@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v3] arm: socfpga: agilex3: Add Agilex3 SoCFPGA support
Date: Wed, 21 Oct 2026 15:12:58 +0800
Message-ID: <20261021071258.5095-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSM1PFD0404AE3C:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f0b34f-87a0-489a-f79d-08df2f42c3fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|261009223327099003|261009221227099003|261009220027099003|261009223027099003|261009221727099003|18002099003|55112099003|10067099003|6133799003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: cy81w08b97bTZtGA/J57b05WuCsAMmgpMVI2nrz+GEFneZeqgpceYFON3pBHJesy2nqbvVtBqcu1Yps9bA+tp+jsi40AgzDKoPFev/mdNd4VkL4x4ElZVwFoKs5ZKth8p/I9qf1eJ6ezFM0wSOHnCvNN4OTxkBI/+Hu2gw7JgkmsbP/mH3fmb86zETvdc2ZSjjX0zCapq/bQLmEJFCYtZfFwCinkcelOstuVrDuwbx9Z/RydLqubdNTRADcRVMRUhDyZ4dcFT2JBwMjTiNKn/mVQHC14+QnX5IH8pB1SoaKt+iHkd6+O7cQASWSQ9Au4mZ7ZFp1B/jvUDktgLjFeRPIn0u1cZfM1Nmj/u+h39sabqmYSCFv4DITzOqPzmCd0RuYJVYb7uo2Wc66h0/3P6OSSwl4H003ECznSSh3P35FbkpClbt9TKEzpZEpiRjtu7sW6AdAM6nXa+cMZJZuwT5MK0qjZagyAHpTCSWddmDaZeW52hEF92x68fHkuSsNdhbFPJ0uLOfN7Q0ZHTU5JWp8TcPF2cqcucM7DIbseG1F0n9wWYwTw2kNIQ695YCQOpa4M7WC6LYHeag+X1+WAWJyn+OSSFp3sw5hZbZ1kz6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(261009223327099003)(261009221227099003)(261009220027099003)(261009223027099003)(261009221727099003)(18002099003)(55112099003)(10067099003)(6133799003)(3023799007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aDhubOkjAR3rQxpBlPrwgaklQgi9CkHAP9JDLc9L/WrKvkUnzqEfKQf+LCjN?=
 =?us-ascii?Q?YF2jFP5QgyUjBGOnTdO+HaPWmV+rPSwIPl6iLO+Zxxk/FQmveVRqiSOfULAn?=
 =?us-ascii?Q?QTzcGYuduGNJ1bkNKK3XDmaMafE8OzKmy7iBbqJStkFcUjxTumijPAyccWon?=
 =?us-ascii?Q?jOso/+zJ85TV99a1WJ/ce3JKWJChkQuri3vc5f24HSS+OgfqVQHKRVJ+xMmU?=
 =?us-ascii?Q?2r4RAk6k569W8ZbFM80hevAE/63ws43OZG3HXRrFdUITRLQqkTqwVo2pxvpD?=
 =?us-ascii?Q?Cb+CKlXdx5n/ML/hUFjjYmtsJAC/6d5Fl9gzehJFX9bO3PPNIgBGgaohV5Qf?=
 =?us-ascii?Q?7L7dXVIVJ5P2PBwqRKwK0Gh3Vl3XDOaux7WMVS47/Vrdn+T874yfz+sfpUld?=
 =?us-ascii?Q?V9ZOfP3W85qDI0Lo4ELpT0qr24hMixOUUQx/tuRhCyLCzMAV0XxBbZf/UCWz?=
 =?us-ascii?Q?bnJgw3/H37sMg4x2wIuatgRydeyurpe8SSC2mzudguyq0yJKBE3IxiwfVqq8?=
 =?us-ascii?Q?/ZE35hU+X66miCxtTjT1316mkxVnCwJ2VD65rOKs2NRxlMX2AJ/MExQa36Fe?=
 =?us-ascii?Q?1n/xBKLVoKVUU9RziLlCVxe7heq5YEgYc7ZiP2seNwjZLvW1v0iQEfwEcBwS?=
 =?us-ascii?Q?X7y40WhZFHaYJAPVLrlpVtP+56XhCzQFzCDRgvhMx++z5W3nY4dwgDhk1TO1?=
 =?us-ascii?Q?7ZjzCGAd07e8B1v6R+bVJJ9yfs2p0GLph/VFu/r8Jvay6rhZKw7sBwY5M971?=
 =?us-ascii?Q?E69b3ctBFprw3Wl6JpMFAAD7rCaJFmBMIvQ7zwflHegRj3F2GSbfDbmQHYhL?=
 =?us-ascii?Q?hEeVEGGi+QfrURr6allnTapJg2/9pFNXASoOwYJ3gf3VJoXqjFjPE0Q5ojVP?=
 =?us-ascii?Q?sOo5TF2HreuE50npt6vrF5ZuvnKtfTVoljYmd7TpMaso/ISpu7a8ZLiVPBQO?=
 =?us-ascii?Q?c6qsyTMH5Z9g5wTpy6dwSpWefwP7dVFFujKii1IP9l6gnXYIyTCExyh/mNBY?=
 =?us-ascii?Q?4z6mXjkzYFP8d1j4pHc8c2jE2IJK2u/PwaDvhGz6xXDjJUEUUqc1A4lPFIXR?=
 =?us-ascii?Q?kCnlBa9pEQ085nv5ZqFXxmCDHItruwMfxc3RPIsJADH1KpxHLwj6itkWtTvx?=
 =?us-ascii?Q?v26MvL+PPtAF613a8TLmDm3KHSMJwhqGLa1RLJ4qzS7Nj4y5l5dB3Feb0K9e?=
 =?us-ascii?Q?dFvayGagls5KLDL54hQxnPFKIjpOyB8OMgZl/dQ5skPHm5wQ4bkfxokAucdd?=
 =?us-ascii?Q?VCCGtHyFGX5USKsKromFtOf75LUH72iV2Oz/b9dZcyPKQbgOIFU30HC94W/Z?=
 =?us-ascii?Q?5+uGV90Ny0rVj4pEXL7IxsPFFxCK6DFjGAIBHgy/jN2m+AVAO69OmvXeqOSx?=
 =?us-ascii?Q?8uF2te/AOmYT2A3QK6+Z+/JeXChuyEJLRWbZNWVXUwn7g2awHeCsrNeRYnW4?=
 =?us-ascii?Q?9ftppNQbW8YNP44azVbv9DQyl7TvazkRsNVJN0pMrvQcp6ALTEuq9b+zz9co?=
 =?us-ascii?Q?3wC2aI7XyjYDcxH2vDbkKV4WcUAEVp3kWv0K/zGAHum4keJQD6j/AOa2LoI9?=
 =?us-ascii?Q?bsc6maG9K9UGgdLHM0VPglupUT1U8gdjcr7mFMjwhKszBOvbE5D9WjCoc/5w?=
 =?us-ascii?Q?5mSHAvlaQkpQXJBRdklHz3TxBazx6mAIU0nGbXpdlgqI9OA8PWg5CAYCfuZL?=
 =?us-ascii?Q?4eB3X0Ztdchm7logdPuHDZJzzFOnRVY2HuqxzqXCeQp/atAWRq1KQMtkTSz2?=
 =?us-ascii?Q?XfY9vJJ+rVmJCY7SZzgEyaP5hUT8iCw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f0b34f-87a0-489a-f79d-08df2f42c3fa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 07:13:11.5317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2/tExC0dWKEJKloi6RS8vRLnTSlvoqP6gUmJKbDmzb2UiZ22ueH8RbS9OM0XJUY4GN5KeaRCBlMK1EfM9LtPGMExYRlY0tGsBNVQ/L4q+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PFD0404AE3C
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Add initial Agilex3 SoCDK board support based on the Agilex5 platform.
Agilex3 reuses the Agilex5 SoC DTSI, U-Boot DTSI, and defconfig, with
these board-level differences:

- Ethernet uses GMAC2 only with a Micrel KSZ90X1 PHY. Agilex5 enables
  GMAC0 and GMAC2 with a Marvell PHY
- QSPI map is 12 MiB u-boot + 52 MiB root with U-Boot offset 0xa00000.
  Agilex5 uses 66 MiB + 190 MiB and offset 0x4000000
- TARGET_SOCFPGA_AGILEX3_SOCDK is added with an Agilex3-only config
  header that uses the 12m/52m QSPI layout
- MMC enables SDR104 (sdhci-caps-mask) in the board DT

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

Changes in v3:
- Move Series-version / Series-changes / Series-links out of the commit
  body; place history as Changes in vN below --- so git am discards it

Changes in v2:
- Move Agilex3 QSPI bootcmd to board config; restore shared SoC64
  BOOTENV_DEV_QSPI 66m/190m path
- Add TARGET_SOCFPGA_AGILEX3_SOCDK with an Agilex3-only config header
  that uses the 12m/52m QSPI layout
- Use rgmii-id instead of rgmii
- Restore LPDDR Inline ECC memory examples

 arch/arm/dts/Makefile                         |   1 +
 .../arm/dts/socfpga_agilex3_socdk-u-boot.dtsi | 185 +++++++++++++++
 arch/arm/dts/socfpga_agilex3_socdk.dts        | 222 ++++++++++++++++++
 arch/arm/mach-socfpga/Kconfig                 |  11 +
 configs/socfpga_agilex3_defconfig             |  10 +
 include/configs/socfpga_agilex3_socdk.h       |  33 +++
 include/configs/socfpga_soc64_common.h        |   2 +
 7 files changed, 464 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_agilex3_socdk-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex3_socdk.dts
 create mode 100644 configs/socfpga_agilex3_defconfig
 create mode 100644 include/configs/socfpga_agilex3_socdk.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 099e3f082b6..9a8ce0bbf7e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -416,6 +416,7 @@ dtb-$(CONFIG_AM43XX) += am437x-gp-evm.dtb am437x-sk-evm.dtb	\
 dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
+	socfpga_agilex3_socdk.dtb			\
 	socfpga_agilex5_socdk.dtb			\
 	socfpga_agilex5_socdk_emmc.dtb		\
 	socfpga_arria5_secu1.dtb			\
diff --git a/arch/arm/dts/socfpga_agilex3_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex3_socdk-u-boot.dtsi
new file mode 100644
index 00000000000..0e624db5fa0
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex3_socdk-u-boot.dtsi
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5-u-boot.dtsi"
+
+/{
+	aliases {
+		spi0 = &qspi;
+		freeze_br0 = &freeze_controller;
+	};
+
+	soc {
+		freeze_controller: freeze_controller@0x20000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0x20000450 0x00000010>;
+			status = "disabled";
+		};
+	};
+
+	/*
+	 * Both Memory base address and size default info is retrieved from HW setting.
+	 * Reconfiguration / Overwrite these info can be done with examples below.
+	 *
+	 * When LPDDR ECC is enabled, the last 1/8 of the memory region must
+	 * be reserved for the Inline ECC buffer.
+	 *
+	 * Example for memory size with 2GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 32GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 512GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>,
+	 *	      <0x88 0x00000000 0x78 0x00000000>;
+	 * };
+	 *
+	 * Example for memory size with 2GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x70000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x40000000>;
+	 * };
+	 */
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,&nand,"/memory";
+	};
+};
+
+&service_reserved {
+	reg = <0x0 0x80000000 0x0 0x2000000>;
+};
+
+&flash0 {
+	compatible = "jedec,spi-nor";
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&flash1 {
+	bootph-all;
+};
+
+&i3c0 {
+	bootph-all;
+};
+
+&i3c1 {
+	bootph-all;
+};
+
+&gpio1 {
+	portb: gpio-controller@0 {
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&sd_io_1v8_reg {
+	gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&mmc {
+	status = "okay";
+
+	no-mmc;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+
+	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
+	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
+
+	/* SD card high speed and UHS-I SDR25 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
+	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
+
+	/* SD card UHS-I SDR50 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x80a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x4000004>;
+	cdns,phy-dq-timing-delay-emmc-sdr = <0x38000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0xf1c1800c>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x20000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
+
+	/* SD card UHS-I SDR104 mode timing configuration */
+	cdns,phy-dq-timing-delay-emmc-hs200 = <0x11000001>;
+	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
+	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
+
+	bootph-all;
+};
+
+&qspi {
+	status = "okay";
+};
+
+&nand {
+	bootph-all;
+};
+
+&timer0 {
+	bootph-all;
+};
+
+&timer1 {
+	bootph-all;
+};
+
+&timer2 {
+	bootph-all;
+};
+
+&timer3 {
+	bootph-all;
+};
+
+&watchdog0 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/socfpga_agilex3_socdk.dts b/arch/arm/dts/socfpga_agilex3_socdk.dts
new file mode 100644
index 00000000000..26e55a41f94
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex3_socdk.dts
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex3 SoCDK";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet2 = &gmac2;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		hps0 {
+			label = "hps_led0";
+			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps1 {
+			label = "hps_led1";
+			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps2 {
+			label = "hps_led2";
+			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <25000000>;
+			};
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i3c0 {
+	status = "okay";
+};
+
+&i3c1 {
+	status = "okay";
+};
+
+&mmc {
+	sd-uhs-sdr104;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&usb31 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
+
+&watchdog1 {
+	status = "okay";
+};
+
+&watchdog2 {
+	status = "okay";
+};
+
+&watchdog3 {
+	status = "okay";
+};
+
+&watchdog4 {
+	status = "okay";
+};
+
+&timer0 {
+	status = "okay";
+};
+
+&timer1 {
+	status = "okay";
+};
+
+&timer2 {
+	status = "okay";
+};
+
+&timer3 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&nand {
+	status = "okay";
+
+	flash1: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0 0x200000>;
+		};
+		partition@200000 {
+			label = "root";
+			reg = <0x200000 0x3fe00000>;
+		};
+	};
+};
+
+&qspi {
+	flash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mt25qu02g";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <1>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x00c00000>;
+			};
+
+			root: partition@c00000 {
+				label = "root";
+				reg = <0x00c00000 0x03400000>;
+			};
+		};
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+			rxc-skew-ps = <0>;
+			rxdv-skew-ps = <0>;
+			rxd0-skew-ps = <0>;
+			rxd1-skew-ps = <0>;
+			rxd2-skew-ps = <0>;
+			rxd3-skew-ps = <0>;
+			txc-skew-ps = <0>;
+			txen-skew-ps = <60>;
+			txd0-skew-ps = <60>;
+			txd1-skew-ps = <60>;
+			txd2-skew-ps = <60>;
+			txd3-skew-ps = <60>;
+		};
+	};
+};
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index cfb66aa1305..a9b7f056b49 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -197,6 +197,14 @@ config TARGET_SOCFPGA_AGILEX5_SOCDK
 	bool "Intel SOCFPGA SoCDK (Agilex5)"
 	select ARCH_SOCFPGA_AGILEX5
 
+config TARGET_SOCFPGA_AGILEX3_SOCDK
+	bool "Intel SOCFPGA SoCDK (Agilex3)"
+	select ARCH_SOCFPGA_AGILEX5
+	help
+	  Support for the Intel Agilex3 SoCDK board. Agilex3 reuses the
+	  Agilex5 architecture select and board code, with an Agilex3-only
+	  config header that uses the 12 MiB / 52 MiB QSPI flash layout.
+
 config TARGET_SOCFPGA_ARIES_MCVEVK
 	bool "Aries MCVEVK (Cyclone V)"
 	select ARCH_SOCFPGA_CYCLONE5
@@ -280,6 +288,7 @@ endchoice
 config SYS_BOARD
 	default "agilex7m-socdk" if TARGET_SOCFPGA_AGILEX7M_SOCDK
 	default "agilex5-socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
+	default "agilex5-socdk" if TARGET_SOCFPGA_AGILEX3_SOCDK
 	default "agilex-socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "arria5-socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
 	default "arria10-socdk" if TARGET_SOCFPGA_ARRIA10_SOCDK
@@ -305,6 +314,7 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "intel" if TARGET_SOCFPGA_AGILEX7M_SOCDK
 	default "intel" if TARGET_SOCFPGA_AGILEX5_SOCDK
+	default "intel" if TARGET_SOCFPGA_AGILEX3_SOCDK
 	default "intel" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "intel" if TARGET_SOCFPGA_N5X_SOCDK
 	default "altera" if TARGET_SOCFPGA_ARRIA5_SOCDK
@@ -331,6 +341,7 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "socfpga_agilex7m_socdk" if TARGET_SOCFPGA_AGILEX7M_SOCDK
 	default "socfpga_agilex5_socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
+	default "socfpga_agilex3_socdk" if TARGET_SOCFPGA_AGILEX3_SOCDK
 	default "socfpga_agilex_socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "socfpga_arria5_secu1" if TARGET_SOCFPGA_ARRIA5_SECU1
 	default "socfpga_arria5_socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
diff --git a/configs/socfpga_agilex3_defconfig b/configs/socfpga_agilex3_defconfig
new file mode 100644
index 00000000000..f4963967f7b
--- /dev/null
+++ b/configs/socfpga_agilex3_defconfig
@@ -0,0 +1,10 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+# CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK is not set
+CONFIG_TARGET_SOCFPGA_AGILEX3_SOCDK=y
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex3_socdk"
+CONFIG_IDENT_STRING="socfpga_agilex3"
+CONFIG_SYS_PROMPT="SOCFPGA_AGILEX3 # "
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x0a00000
diff --git a/include/configs/socfpga_agilex3_socdk.h b/include/configs/socfpga_agilex3_socdk.h
new file mode 100644
index 00000000000..ec9878355b0
--- /dev/null
+++ b/include/configs/socfpga_agilex3_socdk.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ *
+ */
+
+#ifndef __CONFIG_SOCFPGA_AGILEX3_H__
+#define __CONFIG_SOCFPGA_AGILEX3_H__
+
+/*
+ * Agilex3 QSPI layout is 12 MiB u-boot + 52 MiB root. Override the shared
+ * SoC64 66m/190m bootcmd so other boards keep the default path.
+ */
+#define AGILEX3_BOOTENV_UNUSED(...)
+#define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
+	AGILEX3_BOOTENV_UNUSED(devtypeu, instance) \
+	"bootcmd_" #devtypel "=ubi detach; sf probe && " \
+	"setenv mtdids 'nor0=nor0,nand0=nand.0' && " \
+	"setenv mtdparts 'mtdparts=nor0:12m(u-boot),52m(root); " \
+	"nand.0:2m(nand_uboot),500m(nand_root)' && " \
+	"env select UBI; saveenv && " \
+	"ubi part root && " \
+	"if ubi part root && ubi readvol ${scriptaddr} script; " \
+	"then echo QSPI: Running script from UBIFS; " \
+	"elif sf read ${scriptaddr} ${qspiscriptaddr} ${scriptsize}; " \
+	"then echo QSPI: Running script from JFFS2; fi; " \
+	"echo QSPI: Trying to boot script at ${scriptaddr} && " \
+	"source ${scriptaddr}; " \
+	"echo QSPI: SCRIPT FAILED: continuing...; ubi detach;\0"
+
+#include <configs/socfpga_soc64_common.h>
+
+#endif	/* __CONFIG_SOCFPGA_AGILEX3_H__ */
diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index 4d333c63ad9..86fbdbccd39 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -72,6 +72,7 @@
 #define BOOT_TARGET_DEVICES_QSPI(func)
 #endif
 
+#ifndef BOOTENV_DEV_QSPI
 #define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
 	"bootcmd_qspi=ubi detach; sf probe && " \
 	"setenv mtdids 'nor0=nor0,nand0=nand.0' && " \
@@ -86,6 +87,7 @@
 	"echo QSPI: Trying to boot script at ${scriptaddr} && " \
 	"source ${scriptaddr}; " \
 	"echo QSPI: SCRIPT FAILED: continuing...; ubi detach;\0"
+#endif
 
 #define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
 	"qspi "
-- 
2.43.7

