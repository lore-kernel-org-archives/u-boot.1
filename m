Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7BFC982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 02:20:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AEF360662;
	Tue, 22 Sep 2026 02:20:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RsUZtRHk4mjA; Tue, 22 Sep 2026 02:20:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 83FE26066E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790043602;
	b=JjtRSpHxtCCBYli2SPNY98Xm+b2PQM4mkxLshV5gvHYSu87fAdHxZM9dH7aUXp3LdClb
	 aEMHyXSMLjegqgWwaQO3XMfBXfdUw4pEjguyL74bb0ylQRpV0RZ1L1BXHHlaMwwsFq6pr
	 LUdP2ZE20V4Li/NJhPB3bz154PVHn7TerfJFBm3i6tbd0EIBaMeOehUAKGXDuEpuX4s8Q
	 7ocDu5qL5nrqwqJ7VxeUgGFPorZVPoWqsmPoHNTNbnzhZuDNaZtJoZeLgDbjac3Y/IstE
	 jr1Qp42Xu4GNe0VB/D0k2ZGIzana2SRyrZSBTt31gYTreBPi5GVcJI+J9MT8Zqs6OfA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790043602;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=F1FW0VOnjMb/mn2awgqMKCgsOefRT4h/BNxZygAZwCE=;
	b=kpn7iGGYAmZ3RL01nTwjKcM3Tk7McN/KYzcewLZDuT9tJ6WFm/16n0dxCOiwknjMTuHE
	 ZCTv5CGTnpmg5xa9DhBR4fljU7TcLQCfmpexm7o63PlL1DyNLDJPhjWT/x3gXmN/I1iQk
	 LkLXLVn4N9E9PVEa3f9dKJpB+qKsHpQ7sM2YJrpJpz6rOxsErXDEH55uMzU9pxA3x0gN5
	 YJtLufeS3lyBALQ8iCIIexfxoK7Lb9AMEYZdin+X3QvmAU4eZKFieivP2OgF7RYaZXQa5
	 kjRRbvjgaj6WTlK8P8+7gfnf5CudHR55dEhCh75rA+YE2bxtt9eDjqHvSQtC4CURufA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=fail header.from=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=E9CrjZBp;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790043602;
	bh=F1FW0VOnjMb/mn2awgqMKCgsOefRT4h/BNxZygAZwCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e3/rnRyUyGMs6++0aKR3jU7SYCvWn7PRM/H+tXQ/KaOzB0Df8AHHOrJvmCHnTVApv
	 F3aWL8B43Sdlu9KCquusIQi40i91iJenVc3jKZsnObxaAwEG4tvBsutyzmRLi5/pnm
	 0NH4PXmEejsoS3BdNW3763m2qRXSfVV1SmMzQtILydy932G/OxLZf3eWvmurg5DrOU
	 qh0rHQxo4PJOtPU2u/VW/Va/awSQ2RN8WM8euA7LcCsu2a3G1BgGtNDk0e1Ewuctep
	 Carcdc0VIBv4JMgfIyoWEMpn20HRJyMqAU4BxmSdkasiUIr+F+NjwtjxJNkRtNWeRq
	 aXweXkSffRFNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83FE26066E;
	Tue, 22 Sep 2026 02:20:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FE1313B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FCF960714
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:20:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RyACg40rD9IB for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 02:20:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E5CDF60685
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790043600;
 b=FPztKqVdZtFsQFGgs92m4Fxx6PXqTpOUPxR6MSRdPCGSbVUwPuBuHROkaeubVZJPmItA
 WU1iwwFaEVqMV1fLwvbvgOAhmQdRveXqBg3c5Nf181424GruBpv/wDlm6xk0L0S70XvGQ
 eO9SNyiRxXmabJbS9Oht/5rHX7iTZTufWthJwig/fPtRdnAt9sFmujkQs6HHQC2i38ysh
 CQ0SnZzvzhjXRMEVi5KIYosRuVLWdRnbLqydwx5Mm7EGreHeWzckC84S/YV2jZjKIv8Qj
 EcqZKh7N04C0yRTu3b5z3TPazy+/QCoxPc1LhTddpivt3kSE3MZO+Dgc4CcVilwwF8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790043600;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=F1FW0VOnjMb/mn2awgqMKCgsOefRT4h/BNxZygAZwCE=;
 b=Zs39MY0Sw7AUs55Mk2V6GhSSFWdhyIdGYmAx0eBLVjzP7kXISF4+xKpJRB2hhO19EQKs
 8DJ00pvNtL5tTwt9oeoiP3nkUjIjinshc+gPjhlEO2QjrQAefArWhlu+7f4QE8cw4+4uJ
 PS0+rq0RahzVpgUVC/Ar4GN2u7Nov1n4OdhRjZf04gWoUbgw32R1QhS2jsk5KPMOY5i0X
 0qwdtjU4TakD+myPmj1WtcVFmvwx01cEMFRgB+wm+O/SShsMeTGaHPVz0VQzLSyy1Teb6
 4g3WFaT/omk5u5QktcPs/a2ggp2RSqlscYfknZveg8YPrsnrbamdTLSGHAxLXOnoPqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=E9CrjZBp;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=ye.li@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=E9CrjZBp
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E5CDF60685
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbs01b/ZmroDhGHKqowRDGBAz3KpkJehji9IPEQCVo8YqsPMYlpSqYa4SM9XTuZ+CeRlYQ3FR9W1fp9k2EOkXBmZEFlKF9JQ3mo6k/fh4yTE5uBKy6NdetELSDiqzmSGyaHJYJ4XYibqG7HdtyGV4wv4WIzQWbpoj9vmAB7QXkHFkmrVv61sPa4tSqxdVne6K7RNQZZ8GkyQJs6oQh7dWhdREeKKyrzE9KGYrSdW8noys3In9mpzAzKGqJtooLFVef2Zc+R9xoRlfNjVQyOsCgMP01PdAunAc4A8woVDFIYYuJ7YkkAZavK0P6jG3zkTBw9QfA9tDVztjKi9daDlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1FW0VOnjMb/mn2awgqMKCgsOefRT4h/BNxZygAZwCE=;
 b=u0iZpIjCln8wkJ/tnrISjOT0Hp66c8TEfQ8390AxMz+qs2aEyTgYXWG8QOep44YCpRjfORgAuAEi+tahESVVHBbDU3hzaS7TWG6JBr3V1UoeK72K8Fynl0+4VXM/3orHXKDMdDxwB0dmzsS5f82Y+h4Ux7VCVnj6yR3YAcfLhNYK8d0l4NfH8etgsdFQV15o8B5M/Xym08bQJ+BIsV9HtXBUYPLhgv7SJZGBtyKE+S3i/OZh3cY5W/Nam1IfUppks7yd8z1pkmo7RW8HhlWUc+eqVeqkl19RM7wplnWADDFmd+q1vEYOmDIcxHw5m8cQgT28Rnk/tAeymoJN8hnU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1FW0VOnjMb/mn2awgqMKCgsOefRT4h/BNxZygAZwCE=;
 b=E9CrjZBp2ALankUdEKDux/WK/qGRlmiM5GLQLMAysL+O9AAZqN1NsrTKWVUz8SDird1b7Mlg5HHL1Qj4F3tha8ylaAOU2RZ3iKRJE8jpcmvXSEtA4PIh8zyqhSRVUxBjIXOcc1t/beg89o79dnxKXKAgga6yDfQx1Je4hz29UFF3SjqOSPnhjaUzVdg3J9bdJ7M9WJrBKCRkWYVgL+pos0LJOcTw8UmZ2cNB1j1kLWSt+frIlSwb0VmRMxcm8k23160zr+F8/ru2Gz5q71UJPYpu/JElvFGQWRt6U++ZwdATJAOXWuScOq5W4hTFxvrsFMTB7C1tZtpLJydWyxUiVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB5130.eurprd04.prod.outlook.com (2603:10a6:10:14::32)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 02:19:56 +0000
Received: from DB7PR04MB5130.eurprd04.prod.outlook.com
 ([fe80::299:61d2:8995:f85b]) by DB7PR04MB5130.eurprd04.prod.outlook.com
 ([fe80::299:61d2:8995:f85b%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 02:19:56 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.u-boot-project.org,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com, qijian.guo@nxp.com,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Subject: [PATCH 1/4] imx9: scmi: Move WDOG and GPIO init out of arch_cpu_init
Date: Tue, 22 Sep 2026 10:24:03 +0800
Message-Id: <20260922022406.1838737-2-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922022406.1838737-1-ye.li@oss.nxp.com>
References: <20260922022406.1838737-1-ye.li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To DB7PR04MB5130.eurprd04.prod.outlook.com
 (2603:10a6:10:14::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5130:EE_|AM0PR04MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: fe617144-dd23-4c53-0ad8-08df184ffe6b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UxTru1aIuiocs523vz8vDcm6kMbRRxtltMyyWV9S7zwQu8o5SgnBLakmWr1l4izNEEHgxbPyICuk+J0NjmJGzYJZyP6No6MvJm3HFMkaEfhmWCW87k0rWFt5hnkN8ojo41Zq/SK0sfPvjC/0XcGDunMk7Udpt6v4vIrHFJPPAtoiDWBrhBAygQGvI/Hq9xcwU68GG6FESBlfpYwT2oYqFbRmXxblBXFNIw+uAqH2fVLGwjIRizF2yjg7wkDI+IVibaLQnsEnjapPQjgBRdB3CVR6kc0xzybofjB1dP5OVf7DhGLzi/JLay5CMjF7GG/I/1jz3ngEaf2rbsjJoc2dqEUh1K+ugrlm6sOf9TROhpT67PICifC6QLmfN0BadpILVtMGT9ItYFRA0fgAKrDdN98M07u2HDitBJu9OjKwEFGwwLZ0jcraXJXDZZy8yg624bfQVlWOCLv9ikm555zHUykMGkt89vsVmdGlJxXy+0o9Ghm0kSOWLJsRHmTYh+kyzkPtvFdU1UWfYY80kLiKlsyqfzh+v2L1nFNhma7gGYqUWQe6clnRMG3SF3lQsq00uiIiQTuyFAKF4u45FcVvE1AH4l8PSLJ5ddyVG6l3XHscAlmEXYIq+4IaK00hfr8cWUTqYNQ2H7IhlWBF3z7BPXGdtnFpMZCY4JgDihU5AHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB5130.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PkyJJng92YAfv9FoSdck1LEjnk7XxXuYhX/Olsg8prcW6jClhb0nwPQ6ROvQ?=
 =?us-ascii?Q?7otEP++GLfgLKa4GnfpKNDTCrkaOfmm0oIF4ay0/3rvUNCLvy7fEHAtCJ+Zt?=
 =?us-ascii?Q?AtboDTiTxn+D/ee6ZjGM406stS79sjpvGCE0vf6Qlqp1d5gvw589GP7Do9fh?=
 =?us-ascii?Q?7ngykEztJHf6/N4UReEjY+ShlA3cfzJ/VQhSrhlyW5VJ72362L+uQ3nrqmVa?=
 =?us-ascii?Q?7KO3JUKKrvgguCwnHEjR0BEmhnL9n9PDKI7WkQSY3kfDkp5xRBeNZ3zJzezC?=
 =?us-ascii?Q?VgbOgWtRRJvZCQMXJdi4nGR1SVf9hx+LOHtY5ursCY3SfzYCb0Qnzgt7fE30?=
 =?us-ascii?Q?ibDBH1FKRb2t/LN7Uio5N7RBSegbp9+qZG0YEoiS5tiwdXMWFkLk7EmJMP5q?=
 =?us-ascii?Q?PF0h6+oQ7uc/p5rMo//ad4SU4ShDGRE1DgurMKpgbMcy0balqdsjx7VTf5n/?=
 =?us-ascii?Q?htJS0nwGs//yM+OcNW7nIkdKoYhjWs4Jj7aKXXKnWX024ZQa0etFq0/HAKRd?=
 =?us-ascii?Q?GqffafM56/ku9nNWEFQAZRM2XuMXfAPyOM/Hr7X1aQzkdUHGX602176ptFzL?=
 =?us-ascii?Q?FGRTwzCJyKEnn4FpIQUaRriHqR7PI8BKKYi5mtWPiSYKMtfUAeyZA3Uz4PTR?=
 =?us-ascii?Q?DoDjzYvVDV4JPDKzYZlAK2l86f72cNJAg9ajgncWPH3aUywh4q3TOS+LQgID?=
 =?us-ascii?Q?xYgyWE4SZpHNDVwc7X5VIQ+WXAGban+c7QJGK/2Fpj1Vehz32bEsBI7NLhqN?=
 =?us-ascii?Q?oXupRtautKPfntF+5jpXqhU6UAkJcVle5vsJvph4b+Fz0GZUJJzutt6cKZzd?=
 =?us-ascii?Q?sYh6QkIVyxdzYuIPUoHXBcT3Ppb9JQQyxlPkWRGA3nONU8g1fj5YCm7/yNFp?=
 =?us-ascii?Q?1DHgU6J4MdblSdsDwoDeBQmBGSefYu5ZAJ7vsl3JfgtA5CDtk7/i+StwMRt3?=
 =?us-ascii?Q?Q546orCX6SHvBDt2oklEJSwSgJ6wxX872z3BtUBkneXjswI0f8o5GBQjg/Db?=
 =?us-ascii?Q?g1Jbg06K3xkSfyP+r9CvlVm1y3k8ffXYl8eboNeMR+rkrJ62DBOI4uL04etx?=
 =?us-ascii?Q?9dZLuGcsj6FdWVon3UyCk6ZBHG2zCM0LbSGMMdeJ2BqRS2savNG0+j9M2ye7?=
 =?us-ascii?Q?JdTWlEqfxEDhq/IjOSg1da26mbrBAdFM5lzWhXiCptEuhr3qAvjbD+7LNIWH?=
 =?us-ascii?Q?EV3uYyhHw4EQgC77IOhW9dpTWl7Ri/fws1MTsyCRdi3/15/+9kQM2jxkrhEV?=
 =?us-ascii?Q?NwZ1SStmt3kRID/eaLXRaT8fXA+Fh4B+PMA/73rtx58WAkuBMZuINf2gPa3o?=
 =?us-ascii?Q?uVAkK8qaus2pMMIxj59VJscWNolM9NCF1NZ9ln1RYlKYJHyr/hgTosOok0lH?=
 =?us-ascii?Q?+mWhuvnKTkB8XJ9j5ENaVYVPcx/QOC+4FP6NCTRHNByrNWBoin3KqKiPSacm?=
 =?us-ascii?Q?TN6bTM2alteh84fNkXxhDErJN/oZgBXHC3gFGL38Vhma1UjdW/4CdIJH49wy?=
 =?us-ascii?Q?6xUG33/gzZ3t8qSPWjn/iMLMSi1mXdiPcTYoVMknJcLY49kWnBpNYDBaXxZ9?=
 =?us-ascii?Q?1E7Ujcz5LLNHdXLKLduRnvMKNRDozc1pnVlKPrPNXXX/eKIvdbHOrqjYUDFr?=
 =?us-ascii?Q?q8DidKiuC7ZBDKwvSmEPtpBsWjzz8Koh7TprU9b2zYVITjoji/Cbquat9k9s?=
 =?us-ascii?Q?HVimriJXhA+TdHq8hm5Plo0vLPjE9cBQkFoQ83PuWV4xn3E23tprMB2lFqOh?=
 =?us-ascii?Q?eiKlD2q4PPQAtyWwv5gQJMIYBd+Buik=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe617144-dd23-4c53-0ad8-08df184ffe6b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5130.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 02:19:56.4487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keIqF+iQFwGmQN6e15mm/t1WZwO2GMBoEma/s9yx2fbM//m3lxLRi2Dtoik4C/rbQaOHMhwLTcEEbY/qeZqaSa2x1o5C20mVv3lJun2YYN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803
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

From: Ye Li <ye.li@nxp.com>

Latest WDOG and GPIO init depends on DT ready in SPL. However,
in common board_f framework, arch_cpu_init is called before DM init.
So WDOG and GPIO init is not proper in arch_cpu_init. Move them to new
function arch_init_post_dm_f which is called after DM init.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 8bb3ce5cad9..00fb13ad65d 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -1077,6 +1077,12 @@ static int gpio_available(const char *nodes_path)
 }
 
 int arch_cpu_init(void)
+{
+	return 0;
+}
+
+/* arch init which depends on DM init completion */
+static void arch_init_post_dm_f(void)
 {
 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
 		ofnode node;
@@ -1102,8 +1108,6 @@ int arch_cpu_init(void)
 		gpio_reset(GPIO7_BASE_ADDR);
 #endif
 	}
-
-	return 0;
 }
 
 int imx9_probe_mu(void)
@@ -1146,6 +1150,8 @@ int imx9_probe_mu(void)
 
 	set_cpu_info(&info);
 
+	arch_init_post_dm_f();
+
 	return 0;
 }
 
-- 
2.50.1

