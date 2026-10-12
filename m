Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70CFCA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 10:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 253FB80D2B;
	Mon, 12 Oct 2026 10:48:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lnp-BQ1nAJXZ; Mon, 12 Oct 2026 10:48:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7C6CF80C66
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791802105;
	b=XFtnpsMJai5Zb5VUThQrlg/KwSekgz6tYJ4MiW6sl7ZkVokYPr0O6h5S8VJ2A5AjaTp9
	 hEbulHieVY0iKYJRVTSP+oPI8Wr1pys35EUWpZ6kTfhIJFfUyX9FVGaI7DpMBXx28OQa5
	 P7X8aqG13LI3AExl6SiPDfZjoYttJFaeRg+iXut8V2p8GmZSAWXHWjGdKnlRL+Nv62ooW
	 AMWVDGGSghTkl5JqH8/UJo7uec01khyYTIXPbAZneE3Zo61lJFwly8iVxXsJRL501GyIB
	 zgk9C2DKViIXPH6hTtF9rm7HIRGyef74Wm4nylbM1OJgw7VLELsq4/lj9Fsl8nljqdQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791802105;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=YMclKi2xBuUa92z2mVCd/3LZYWFXk3IU/igywJDYgBY=;
	b=ROGxMDPUde9qig7eWefrxdBiZVpoWCAICeYcRY3PEF8VngdKiewMXUhB5W5fBgGMo8p8
	 S3tvDV1Z++/0V+8vXJDtMZua5WZoF4QHRzMdoqyycL/MMfNHRIPVNOlSMbT0tOnKPwe6b
	 vmktBAjou0asfSYfZHKAD1aRSjNe/zwymlYaq/oqUclmn5bvn4PgrDaA/WyMyTcEz+f9Z
	 j2m0nrsFx1efGIfs7Rs43aZHKF4/qkwPICm6E9CAb7KJgtvzu8R+jxpOAfdm4jEWvXBBG
	 +XPHoRfRqXTYAI6Mtc+fA0MVKPTMJV6c+0gwSl4w5R4JgzOsgdcn+xdQVH+Eft+fpYQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791802105;
	bh=YMclKi2xBuUa92z2mVCd/3LZYWFXk3IU/igywJDYgBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t7vkY1RSAw+rXbiI/+l9SznO0shC65vK3R8+/+lz2hlHUeTXVBYQPoeVL/reMyidM
	 EJTQQ8Z/iQJ8pSFm85++LMfEJT+3sDaMhbt9cEFlsMIPu0xgM5n/maYlgzlBr5qVSU
	 NJMIuSNnFcT4y7Jnk508J1kxqqEiWQ5uJEvbMCjYLrsWNHyoy1YwxuzQ9k5N9UhsSj
	 GZuXVo/EFxbqds3rL9cUBxasz6K2WayleRCLAU+9W++jNCcqDdwaSKrPgrVZY/ynNf
	 IdLP9dUSqtSEq+vM2Eg3i7p3Nana/KV5/q3zk4aJEGkvNvvPENhkZtKOB07V8MwAjZ
	 RJs8peFImQILA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C6CF80C66;
	Mon, 12 Oct 2026 10:48:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AAB91380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D575400E9
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IiPjy3PezGBl for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 10:48:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1D797400D0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791802102;
 b=SVc6WMmAJRQD0bOrVM3lkUwWA6VHropjdzAkTSFvCGmUbTsS5la9Otmm3Gz/+HOIzmPA
 +pOs7WCejiY8/L06NaeGxOe3d9SzumZ+2aij5xmqZDavOD6PgZSNiT9y/m8HgyONGmun8
 vrtw3gyzFwoqbh/6uf3Up7thWTWjb+DhcGaVSlIPmY5vU8AT/u+Wfxm+M05F0sChgGHRO
 pR9j88X705qjqKHmW+tS/0kBQEIov+tPsFdif0b40frdQw57ncIhXc7gndZrvtf/eTT1t
 8BZW9c/Kc9h/gd9Bg3G4SkMFc7yTJUsoe0VN+9ejOOl3bKNRinAu48E/5z9WNqn0T2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791802102;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=YMclKi2xBuUa92z2mVCd/3LZYWFXk3IU/igywJDYgBY=;
 b=mA4sjP3jtCtPuTkzp22iaC5ap6zBGxLSrgweoXrl5QO5isdfP2+S301hJ5TcbAVBdfZ9
 QW55WQZCuPgRGokCNql4WmEFAs9//U1rOLDKRmB7g7wo28MtufkGDRw8Eep2AT81FHxOL
 taPoT3F978DDCvLTMd4al2PuTEN2eOkrIgwy1h/Tg42304izDoAwlXVYjpiCbKPoklTYq
 u1hsIogeY+ShFsHZaEZIS5ggmLOBSVNcCCYLMFWXSM5Guz1IfR8Z6QT7YgGiQRfI/nUhU
 dXeFui8RxG7k017OtE+eGVRSdiMlS2IzznbkVZgaz4KtF+zYhHuAqZ1b1GsnmD1gM0g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=XKPnJl72; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=XKPnJl72
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D797400D0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gC7oMdaO33ztk1oRv6tHkGiauqi+K9bhiyPvHZ6ZQZxeAXPNqF5pPVYyknsd7kF0E+phHJVzzAPUqDO9pC+UCTsJOnJ4mQjyKXEnyfgX+Dr9yZ7jTWaGdclVSRd7es/6xbuqsXm77bTt7RaR35SBcRo1/K2wwTkz78OVXxGBh40OJpRE4mUYRjx5K8Pckl7/glWL/mtNYoY5uApRU7qdufUi2ToVFKkmceJBtjeCpiFuWMb+T1q4alXA3AwWwjVW+ATYqAiREbjlzgcFg0I9unTIPX2XkpI1A1/nFNPYzRWaB0PyV6U3vPGpZCJlw+SMVoCeYrPAwq1hWRsjXaa2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMclKi2xBuUa92z2mVCd/3LZYWFXk3IU/igywJDYgBY=;
 b=tickxlmg2TUCb3kc0LQ+NG8YZ4h+Z0jvjaiBMoPUobSrIFf3qHpDTD4D7hvqdLVtCN9mScSAXDghedaEbpqjTjOMl7DMZXc1bRTCdS0WaaD+EJ/EToLlqxs30eHlpJOQ49rQ1RKIrJvCS2J7vv57o1N9jCNQq8zUKcbdzd5WHqFi/J57IPjkyIzm3mdjFkFZ8/3zHvA1yOZV5PLNrjqgeXVwyP++JTVjSzvWrtRHe8kzEGBmctUG2T1Mf1Nmyh8rZxOjMuuLy7oEUbNGPxIWt8PorN5VeiKAaiHZQIia0KPk/IkaLuSLU3+PZq+JJ7zdgqrO4ZFefJO5PuMePjAJZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMclKi2xBuUa92z2mVCd/3LZYWFXk3IU/igywJDYgBY=;
 b=XKPnJl724lS6sk6OZZESRA/69fsldz7/NXV+/NBPosWOEm35cNxoYrRUYMC5iRVVIp2rg4twzemrocWU8aDljxKzPzggn6tzZorWLugXI492I3+kM4JyUa8ZTysmsVck5iNdQ+QCz2yOgGnsGAha/5dLoC0OzoI66ymrc7/bjWzArsI8HxYJQQImQGIkHD2MsI2QXWylbVc9JUKlBoH54S4HvL1UbcxC6Onf6mLOqoF2SD3XalhD7sU+JvVpnYCjfAaPH8vQ3suJO/M0BAg3y1J+V1dJtNydTohG1ae1x+fm0ita3rKMSxQJADYfNtrvlZvjgeGx4sUZIbkvyl1uJA==
Received: from PR1P264CA0088.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:345::15)
 by PR0P264MB3484.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:163::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 10:48:14 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345:cafe::21) by PR1P264CA0088.outlook.office365.com
 (2603:10a6:102:345::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 10:48:14 +0000
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
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 12 Oct 2026 10:48:14 +0000
Received: from localhost.localdomain (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 730E820061;
 Mon, 12 Oct 2026 12:48:14 +0200 (CEST)
From: Yan WANG <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com, marex+nodisclaimer@nabladev.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot@lists.u-boot-project.org, Yan WANG <yan.wang@softathome.com>
Subject: [PATCH 2/5] binman: Add test for pkcs11_tool sign method
Date: Mon, 12 Oct 2026 12:48:01 +0200
Message-ID: <20261012104805.17297-3-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012104805.17297-1-yan.wang@softathome.com>
References: <20261012104805.17297-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|PR0P264MB3484:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a08ff57-c8ac-43a4-614f-08df284e514c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|261009223027099003|10067099003|17002099007|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: P5MCbADE4rU9f0/Rpw2XXUJAqU7Cy+g9wQ2PqqAjYvluelwDgJiYsNxCsQrFM1auvf481xfMeBkLpo9upmJ3VotC92mKk6LskFgl1sd1gu8CMRYsOBdLOE7uY0y1sONTmGRybYjcQnjdOl6+XnUhHeLp8oV25aRYvrjhXfNvchfmymxa0uQWloM3PHUB2IiGiBMb4xtub8KACtZ+5XKNDSZOf8KF57t6sundVVdC3hlMMhITN6xdCjtAkaFRNqHPPC/Cy/a+rg/GO4W3ejdk/vkRMXgJksJrAwOB+662hwAcbN6C9StvswLjuZ+xWr5ca+wjkKgZRNFW7lNAkXVbbWplc0IJ5G3ha2+StS3gqEL+Kv9nw4/gvDB0Sbw3IkTYRH1Pv6P+g5SoH0qY43OrgXPWheCFCpQEg2oCl22Kp2XS2WE0EBSv0HoCMiqVnr4zEbb43MY1KHmy0y4jAMNeF6yM8SLMWjQkW8gIXC+OeuDfeCERls0sqhIAiR0gvACqk+GbXHJMl3xlJnfS15YhXYoQ9YVxAVS/vTr6GdPX/ZJ2dsfjJKPQfIl36XZkyKFdL7UYQIsAc42NS+ldZ4baqs5FvR9lWI8gSKXDavzDKzqJGBAN0KmCk657WKfeZrG/MF3SNg75O7PZ80E8R/mhu4dKs4c/b+gi28lsUddd4ILpfKD9OcPYSWvScS5xqsQNQOX5Qr6apG+Th0eQSLqp7g==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(261009223027099003)(10067099003)(17002099007)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z9aQ/qSWQ/yZQUp0GZB2drZRrffiNcT4eH8+EbCWR15HlN5NK0lZxhDDiPEGgZQM18BsYUsYZvq8CTW1/gYS36fDjYlVGSC25/opRf8sMPIMfr/5LCQSdJ6eNt4j49hCghAyW1wrReWDYhnrzduOkNnOfAq4YhpbGWSPN2HC47/mXDQ+mCte0ZYe0gAEI8bsfS0VSjwnKPzCc7JFbRBe0FLYsnVXHvANXyFOTCR/OySNbLUpTfkqbqX+Py4HxHevCKSSH46Io7FsSZ9YoWqaaDAS4I0cAn2Lsokc+LCDaYLUpxyM1dyMHVmq3T1XFfsNhHwex8gpCNJ948BboYkE2+GX8gAhmzCJZMpyegNF2lcUH+WMJvMP2XhKSrLymZSVvvMtNlwKzpgsIkE6R0Q/xkmn/2cKwGojsncb0k6YmMl2HB5RHS6cL1uqS1qSfRo6
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:48:14.5926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a08ff57-c8ac-43a4-614f-08df284e514c
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3484
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

Exercise the three new methods added to the pkcs11_tool btool:
sign(), _build_mechanism() and _verify_mechanism().

Signed-off-by: Yan WANG <yan.wang@softathome.com>
---
 tools/binman/bintool_test.py | 374 +++++++++++++++++++++++++++++++++++
 1 file changed, 374 insertions(+)

diff --git a/tools/binman/bintool_test.py b/tools/binman/bintool_test.py
index 7e8dafea94e..a3c8fb70422 100644
--- a/tools/binman/bintool_test.py
+++ b/tools/binman/bintool_test.py
@@ -21,6 +21,10 @@ from u_boot_pylib import terminal
 from u_boot_pylib import test_util
 from u_boot_pylib import tools
 
+# Shared namedtuple for mocking run_cmd_result() return values
+_CmdResult = collections.namedtuple(
+    '_CmdResult', ['return_code', 'stdout', 'stderr'])
+
 # pylint: disable=R0904
 class TestBintool(unittest.TestCase):
     """Tests for the Bintool class"""
@@ -38,6 +42,12 @@ class TestBintool(unittest.TestCase):
             shutil.rmtree(self._indir)
         self._indir = None
 
+    def _make_module_path(self):
+        """Create and return a path to a fake PKCS#11 module file"""
+        path = os.path.join(self._indir, 'fake_module.so')
+        tools.write_file(path, b'')
+        return path
+
     def test_missing_btype(self):
         """Test that unknown bintool types are detected"""
         with self.assertRaises(ValueError) as exc:
@@ -354,6 +364,370 @@ class TestBintool(unittest.TestCase):
             result = btool.run_cmd_result('fred')
         self.assertIsNone(result)
 
+    def test_pkcs11_tool_sign_errors(self):
+        """Test error handling in pkcs11-tool sign method"""
+        btool = Bintool.create('pkcs11_tool')
+        data = b'test data'
+
+        # Test unsupported signing algorithm family (dsa cannot be mapped)
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(data, '/fake/module.so', token_label='test',
+                      key_label='test', hash_algo='sha256',
+                      sign_algo='dsa2048', padding='pkcs1v15')
+        self.assertIn('Unsupported signing algorithm', str(exc.exception))
+
+        # Test missing token identification
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(data, '/fake/module.so', key_label='test')
+        self.assertIn('Must specify either token_label or token_serial',
+                     str(exc.exception))
+
+        # Test missing key identification
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(data, '/fake/module.so', token_label='test')
+        self.assertIn('Must specify either key_label or key_id',
+                     str(exc.exception))
+
+        # Test missing module path
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(data, None, token_label='test', key_label='test')
+        self.assertIn('PKCS#11 module path is required',
+                     str(exc.exception))
+
+        # Test module not found
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(data, '/nonexistent/module.so', token_label='test',
+                      key_label='test')
+        self.assertIn('PKCS#11 module not found', str(exc.exception))
+
+    def test_pkcs11_tool_sign_failures(self):
+        """Test pkcs11-tool sign method failure cases"""
+        btool = Bintool.create('pkcs11_tool')
+        btool.present = True
+        data = b'test data'
+
+        module_path = self._make_module_path()
+
+        # Test tool not available
+        def fake_run_none(*args, **kwargs):
+            return None
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                       side_effect=fake_run_none):
+            with self.assertRaises(RuntimeError) as exc:
+                btool.sign(data, module_path, token_label='test',
+                          key_label='test')
+            self.assertIn('pkcs11-tool not available', str(exc.exception))
+
+        # Test signing failure (non-zero return code)
+        def fake_run_error(*args, **kwargs):
+            return _CmdResult(1, b'', b'Error: PIN incorrect')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                       side_effect=fake_run_error):
+            with self.assertRaises(RuntimeError) as exc:
+                btool.sign(data, module_path, token_label='test',
+                          key_label='test')
+            self.assertIn('pkcs11-tool signing failed', str(exc.exception))
+            self.assertIn('PIN incorrect', str(exc.exception))
+
+        # Test no signature output
+        def fake_run_no_output(*args, **kwargs):
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                       side_effect=fake_run_no_output):
+            with self.assertRaises(RuntimeError) as exc:
+                btool.sign(data, module_path, token_label='test',
+                          key_label='test')
+            self.assertIn('no signature output', str(exc.exception))
+
+    def test_pkcs11_tool_cleanup_error(self):
+        """Test that cleanup errors in pkcs11-tool are handled gracefully"""
+        btool = Bintool.create('pkcs11_tool')
+        btool.present = True
+        data = b'test data'
+
+        module_path = self._make_module_path()
+
+        fake_sig = b'\x00' * 256
+
+        def fake_run_result(*args, **kwargs):
+            """Mock successful signing"""
+            return _CmdResult(0, fake_sig, b'')
+
+        # Mock os.unlink to raise OSError
+        original_unlink = os.unlink
+
+        def fake_unlink(path):
+            if 'binman_sign_' in path:
+                raise OSError("Permission denied")
+            return original_unlink(path)
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                       side_effect=fake_run_result):
+            with unittest.mock.patch('os.unlink', side_effect=fake_unlink):
+                # Should not raise exception, cleanup error is silently ignored
+                sig = btool.sign(data, module_path, token_label='test',
+                               key_label='test')
+                self.assertEqual(fake_sig, sig)
+
+    def test_pkcs11_tool_find_slot_by_serial(self):
+        """Test find_slot_by_serial method"""
+        btool = Bintool.create('pkcs11_tool')
+        btool.present = True
+
+        # Test finding a slot with matching serial
+        slot_output = """Available slots:
+Slot 0 (0x123): SoftHSM slot ID 0x123
+  token label        : test-token
+  token manufacturer : SoftHSM project
+  token model        : SoftHSM v2
+  token flags        : login required, rng, token initialized, PIN initialized
+  hardware version   : 2.6
+  firmware version   : 2.6
+  Token serial num   : abc123xyz
+
+Slot 1 (0x456): SoftHSM slot ID 0x456
+  token label        : another-token
+  token manufacturer : SoftHSM project
+  token model        : SoftHSM v2
+  token flags        : login required, rng, token initialized, PIN initialized
+  hardware version   : 2.6
+  firmware version   : 2.6
+  TOKEN SERIAL NUM   : def456uvw
+"""
+        def fake_run_cmd(*args, **kwargs):
+            result = collections.namedtuple('Result', ['stdout', 'stderr'])
+            return result(slot_output, '')
+
+        with unittest.mock.patch.object(btool, 'run_cmd',
+                                       side_effect=fake_run_cmd):
+            # Test finding first slot
+            slot_idx = btool.find_slot_by_serial('/fake/module.so', 'abc123xyz')
+            self.assertEqual('0', slot_idx)
+
+            # Test finding second slot
+            slot_idx = btool.find_slot_by_serial('/fake/module.so', 'def456uvw')
+            self.assertEqual('1', slot_idx)
+
+            # Test not finding a slot
+            slot_idx = btool.find_slot_by_serial('/fake/module.so', 'nonexistent')
+            self.assertIsNone(slot_idx)
+
+    def test_pkcs11_tool_sign_success_slot_index(self):
+        """Test successful signing with slot_index"""
+        btool = Bintool.create('pkcs11_tool')
+        btool.present = True
+        data = b'test data to sign'
+
+        module_path = self._make_module_path()
+
+        fake_sig = b'\x01\x02\x03\x04' * 64
+
+        def fake_run_result(*args, **kwargs):
+            if '--sign' in args:
+                self.assertIn('--slot-index', args)
+                self.assertIn('0', args)
+            return _CmdResult(0, fake_sig, b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                       side_effect=fake_run_result):
+            sig = btool.sign(data, module_path, slot_index='0',
+                           key_label='test-key')
+            self.assertEqual(fake_sig, sig)
+
+    def test_pkcs11_tool_sign_success_key_id(self):
+        """Test successful signing with key_id instead of key_label"""
+        btool = Bintool.create('pkcs11_tool')
+        btool.present = True
+        data = b'test data to sign'
+
+        module_path = self._make_module_path()
+
+        fake_sig = b'\x05\x06\x07\x08' * 64
+
+        def fake_run_result(*args, **kwargs):
+            if '--sign' in args:
+                self.assertIn('--id', args)
+                self.assertIn('01', args)
+            return _CmdResult(0, fake_sig, b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                       side_effect=fake_run_result):
+            sig = btool.sign(data, module_path, token_label='test-token',
+                           key_id='01')
+            self.assertEqual(fake_sig, sig)
+
+    def test_pkcs11_tool_sign_success_with_pin(self):
+        """Test successful signing with PIN provided"""
+        btool = Bintool.create('pkcs11_tool')
+        btool.present = True
+        data = b'test data to sign'
+
+        module_path = self._make_module_path()
+
+        fake_sig = b'\x09\x0a\x0b\x0c' * 64
+
+        def fake_run_result(*args, **kwargs):
+            # Verify PIN is in the sign command args (not the mechanism check)
+            if '--sign' in args:
+                self.assertIn('--pin', args)
+                self.assertIn('1234', args)
+            return _CmdResult(0, fake_sig, b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                       side_effect=fake_run_result):
+            sig = btool.sign(data, module_path, token_label='test-token',
+                           key_label='test-key', pin='1234')
+            self.assertEqual(fake_sig, sig)
+
+    def test_pkcs11_tool_sign_token_serial_not_found(self):
+        """Test signing with token_serial when token is not found"""
+        btool = Bintool.create('pkcs11_tool')
+        btool.present = True
+        data = b'test data to sign'
+
+        module_path = self._make_module_path()
+
+        def fake_find_slot(module, serial):
+            return None
+
+        with unittest.mock.patch.object(btool, 'find_slot_by_serial',
+                                       side_effect=fake_find_slot):
+            with self.assertRaises(ValueError) as exc:
+                btool.sign(data, module_path, token_serial='nonexistent',
+                         key_label='test-key')
+            self.assertIn('Token with serial nonexistent not found',
+                         str(exc.exception))
+
+    def test_pkcs11_tool_sign_token_serial_found(self):
+        """Test that a resolved serial is forwarded as slot-index to the sign command"""
+        btool = Bintool.create('pkcs11_tool')
+        btool.present = True
+        data = b'test data to sign'
+        module_path = self._make_module_path()
+        fake_sig = b'\x01\x02\x03\x04' * 64
+
+        def fake_run_result(*args, **kwargs):
+            if '--sign' in args:
+                self.assertIn('--slot-index', args)
+                self.assertIn('0', args)
+            return _CmdResult(0, fake_sig, b'')
+
+        with unittest.mock.patch.object(btool, 'find_slot_by_serial',
+                                        return_value='0'):
+            with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                            side_effect=fake_run_result):
+                sig = btool.sign(data, module_path, token_serial='SN12345',
+                                 key_label='test-key')
+                self.assertEqual(fake_sig, sig)
+
+    def test_pkcs11_tool_build_mechanism(self):
+        """Test dynamic PKCS#11 mechanism name construction"""
+        btool = Bintool.create('pkcs11_tool')
+
+        # RSA PKCS#1 v1.5 combinations — key-size suffix is stripped
+        self.assertEqual('SHA256-RSA-PKCS',
+                         btool._build_mechanism('sha256', 'rsa2048', 'pkcs1v15'))
+        self.assertEqual('SHA384-RSA-PKCS',
+                         btool._build_mechanism('sha384', 'rsa3072', 'pkcs1v15'))
+        self.assertEqual('SHA512-RSA-PKCS',
+                         btool._build_mechanism('sha512', 'rsa4096', 'pkcs1v15'))
+
+        # RSA PSS combinations
+        self.assertEqual('SHA256-RSA-PKCS-PSS',
+                         btool._build_mechanism('sha256', 'rsa2048', 'pss'))
+        self.assertEqual('SHA512-RSA-PKCS-PSS',
+                         btool._build_mechanism('sha512', 'rsa4096', 'pss'))
+
+        # 'pkcs-1.5' alias is normalized to 'pkcs1v15'
+        self.assertEqual('SHA256-RSA-PKCS',
+                         btool._build_mechanism('sha256', 'rsa2048', 'pkcs-1.5'))
+
+        # EC / ECDSA families
+        self.assertEqual('ECDSA-SHA256',
+                         btool._build_mechanism('sha256', 'ec256', 'pkcs1v15'))
+        self.assertEqual('ECDSA-SHA384',
+                         btool._build_mechanism('sha384', 'ecdsa384', 'pkcs1v15'))
+
+        # Previously hard-coded combinations still resolve correctly
+        self.assertEqual('SHA384-RSA-PKCS',
+                         btool._build_mechanism('sha384', 'rsa4096', 'pkcs1v15'))
+
+        # Novel (non-table) combination: any hash works with RSA
+        self.assertEqual('SHA224-RSA-PKCS',
+                         btool._build_mechanism('sha224', 'rsa2048', 'pkcs1v15'))
+
+        # Unknown algorithm family raises ValueError
+        with self.assertRaises(ValueError) as exc:
+            btool._build_mechanism('sha256', 'dsa2048', 'pkcs1v15')
+        self.assertIn('Unsupported signing algorithm', str(exc.exception))
+
+        # sign_algo with no leading letters cannot be parsed by the regex
+        with self.assertRaises(ValueError) as exc:
+            btool._build_mechanism('sha256', '2048rsa', 'pkcs1v15')
+        self.assertIn('Cannot parse signing algorithm', str(exc.exception))
+
+    def test_pkcs11_tool_verify_mechanism(self):
+        """Test mechanism verification against token's allowed mechanisms list"""
+        btool = Bintool.create('pkcs11_tool')
+
+        mechanisms_output = (
+            'Using slot 0 with a present token (0x1)\n'
+            'Supported mechanisms:\n'
+            'SHA256-RSA-PKCS, keySize={512,4096}, hw, sign, verify\n'
+            'SHA384-RSA-PKCS, keySize={512,4096}, hw, sign, verify\n'
+            'SHA256-RSA-PKCS-PSS, keySize={512,4096}, hw, sign, verify\n'
+        )
+
+        def fake_run_ok(*args, **kwargs):
+            return _CmdResult(0, mechanisms_output.encode(), b'')
+
+        # Mechanism present in the list — no error
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                       side_effect=fake_run_ok):
+            btool._verify_mechanism('SHA256-RSA-PKCS', '/fake/module.so')
+
+        # Mechanism absent from the list — raises ValueError
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                       side_effect=fake_run_ok):
+            with self.assertRaises(ValueError) as exc:
+                btool._verify_mechanism('SHA512-RSA-PKCS', '/fake/module.so')
+            self.assertIn("not in the token's allowed mechanisms",
+                         str(exc.exception))
+            self.assertIn('SHA512-RSA-PKCS', str(exc.exception))
+
+        # Tool unavailable (returns None) — verification is skipped silently
+        def fake_run_none(*args, **kwargs):
+            return None
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                       side_effect=fake_run_none):
+            btool._verify_mechanism('SHA512-RSA-PKCS', '/fake/module.so')
+
+        # Non-zero exit code — verification is skipped silently
+        def fake_run_error(*args, **kwargs):
+            return _CmdResult(1, b'', b'error')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                       side_effect=fake_run_error):
+            btool._verify_mechanism('SHA512-RSA-PKCS', '/fake/module.so')
+
+        # Slot index is forwarded to --list-mechanisms
+        received_args = []
+
+        def fake_run_capture(*args, **kwargs):
+            received_args.extend(args)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                       side_effect=fake_run_capture):
+            btool._verify_mechanism('SHA256-RSA-PKCS', '/fake/module.so',
+                                   slot_index='2')
+        self.assertIn('--slot-index', received_args)
+        self.assertIn('2', received_args)
+
 
 if __name__ == "__main__":
     unittest.main()
-- 
2.43.0

