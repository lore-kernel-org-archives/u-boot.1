Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90060C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 18:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47F0F80D8A;
	Mon, 21 Sep 2026 18:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jpqmuKTpUltu; Mon, 21 Sep 2026 18:58:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 64C2B80D6F
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790017130;
	b=GLe4NgpWA0bOiNMI3S5aOG0OxvSDjcNMKQNhujcXHNnWN+f3UVcG7el5byF18qCA2dEE
	 oVC/HTwiuFbRsHoUDtu29h+MI+Sb5Q3zaQp7gLlETrj2YqCdpd0vn4uiBFALEdJtXE5M6
	 +hzHCkpKWmVs+uVU2LCZrqOLUyGl2YzDKCU/fMep3XfC98oFxwQ69AklVz808Obpjwxnt
	 LmU39o9/W92ofoUDqhcuM4OfCHXqevCUThRcIs5WQbfkeLOqxbk2iYljLXCvrbewd3Dpv
	 m0ByUKxXObEW/HTsDhHwD+eptGvhL2xJQKooDg5P+sL/SQ54z/YqOfNWGpSFUnsfdeg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790017130;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=I/IhL34BtfbS9RIKNgXNBJWpoRFagSFgmoTiqxvPY+U=;
	b=UNQ/wQeCnJp51uc3pntuGQfm8n9VUMMygQbF3vSkmAdVrFt5yyg8PO7OwDZFTgNJs+RF
	 +r2UXk+PyxcUakz1OFqHuI2orzbjBoS8N83HAXHKyrkYfmHGBZYd47L6Jmd82gzIx+nbb
	 XDZvSKMRDVb7M56qeBeXW1yAhVk0bsEIRUsXciAbKrp53dyWklzQa9yPQYYYaaoaA9yxa
	 2Au6dwx/Iy8ZRdsyxKyTdNFJzTHYhx/2qUV/hYPaVC4PsHzWGDfhprR+HLb5MebHXqWoe
	 Q6I2KoQRuDcg7nMXUq0XWPJPcUCnCXqn6Y0ehnWb4GBKo3OJ6Vx+IQLbg8ncLv5qqtA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790017130;
	bh=I/IhL34BtfbS9RIKNgXNBJWpoRFagSFgmoTiqxvPY+U=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T6qTYIK6QkRdohi3HL4mt/WuFNJlBVJDotbAptZT9c5x3Aq61OlzhyRlnIOcqWwld
	 A30fuYP0nk+7Fv6m/epM9tHyzCwIN/m9du71w5hud720jtOH+IulO5BTo0Z8nFeuSn
	 h81/z/rJaGtTj139Q0Df17Y7PLWsZblGTEibnM/Efqy9Jubrl7SrWsKn8mdvyaIWI1
	 kEcgCr7ZTLiHnGu/jdZADOJYZbUTmBqcraOWN44ztv4NvPfMVGf6woPTG0MMHhbLqo
	 8GzWoGwxFtcjun7Z5EOGOUOUHXuhxa4C18OXVOiPp+VyEm0OK/FOznyFRSPfoWOdgu
	 A1VATEuY4TSyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64C2B80D6F;
	Mon, 21 Sep 2026 18:58:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C4A3224
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E32660738
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:58:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zCw4px32fDtq for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 18:58:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B1DD160736
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790017127;
 b=VVLbeRCKXMkHdbN83IrKM0sHoVtWucx0yUmk5U/nAQUXb6ZReyI6+40WeCq9QdobKqa7
 jfFfEyjNwICgyBBchwyu9OTn31r11iDmJTN1DWvSeIJNeJD5EDkH/1K3MTxOMzFx4YJzL
 NHsBDY5gHKH99tNnaFgKvIEflwtTndGytRAPdZr0yjXiFZUOIp6thGhVVt2Rm6npV7wZV
 UxQwuIevZjOYiovdckbuxh59+ybkCyRId2qcdf9TmU6DqnC2y/RmOY2J949g8jj9dk+WW
 vuQf54Gbw1vAdY+CaF4oZ1unvbYk1ZUdaLg/WZP/VPCXwCkpnDKtw+HhfiiTcLtVKXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790017127;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:Content-Type:
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
 bh=I/IhL34BtfbS9RIKNgXNBJWpoRFagSFgmoTiqxvPY+U=;
 b=CXxvtUYXDQbCv5d27wQGRAtFd3zYHoAnW+JcXZDLIuJpPKzmLRzOsTc6FkjVu8635NGC
 flmn8RLbb4FQ9AVqfSquqCHDBLd6jmb7w1ZHm7rWftNOb6Sjmjol62XxMGoTAYUjggsUk
 BkZtmHLzWMRXz2tNVzbROvBH3nXTWmGsBTUmvLp2qkGEH+UbWPXa8WYnPOOmaIJBBmACx
 rR4c6LYBAiMQiuzjDDgfLEG3ISMg/hsDuWE5wb/4fshe5E63P8ET+6SPLbnjdgFWySAJD
 F4g1DmZ/+0wFebE26rpOAqsdejctexYzeq59/aER1FdfYTM6YZB5gK9C7D3KGvAf3vQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=NbOIhUe9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=NbOIhUe9
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B1DD160736
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:58:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9ABO6acpzZRpFFasleECGvDDbZ7N7kolUjJwlcQ+teTADYo1onSNWHV1X5jYhOswxl/iAmE2P6ST0JMKt9tQoyObZH/IZmrV3G9CNaoJyZTQExzzD+ifBaGacSvT+KzR+EQY7xuXq3YOIcGGoAHcQNkhPBuG61oPsBJXjMxBg3zUtWzl1vKiSZuZ05/dw+5P2OOXJTteYkSpG8zFLGdo0rPB3pm77mgZSiNOghyI/WmDTjbOW23lNlDnTGADhkc+Sjm2QjyhLarirVl1VlWyvwoEJf1aT9SLc+FT1P4JdZsxI/2tFff2bkt2u2KpJokZKnS6rYgkGyfuBMhIn2Eaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/IhL34BtfbS9RIKNgXNBJWpoRFagSFgmoTiqxvPY+U=;
 b=Ah95Hc+S5ll+s2SF4VBPav6qI1CJzIorpCz2yspNN+O8jFc0eGqK2zEJxCRO1yVNs0v5sUwb00bYSE4btjUISfXNL0a3+zH9ji8Ac2ZpFsAqo9apq58HZpEttt4tav0AyQT1M8UDe7QzCXeKXH9eFxMLI7PMIV3k15OGCKk1AtKde2fRD1K7x0YJ9vqsqwjg+DoEYXIFwM0ydiIjdboG/p3w7sMIlYsa1ZC9To1udx9C0gjeqc9LQnEtoMgnWtKOLDL12PQiuaShAioUVpGF4XJTvbeyxbzHiLwInbz2XSmh5LJg0xPjDBP80oMblIyGgRZVma7OfOA4eHHPCfgwGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/IhL34BtfbS9RIKNgXNBJWpoRFagSFgmoTiqxvPY+U=;
 b=NbOIhUe96rB0XMUF9Zlg2VFuKOAsKaxZH3SWla6Gnflk42feJ6z5OEJe3NmbrMfP9Kf322lyEsutQmDy4YyE6WKNH/FFfFEi22SVbs8yL0DdCZ1ilxDi6XoIU11QKFUxeNZsVQqWwifgRmQ1RrNG+QYSEJpM4dnLxJm6J3nKsNM=
Received: from BL1PR13CA0190.namprd13.prod.outlook.com (2603:10b6:208:2be::15)
 by PH6PR12MB944609.namprd12.prod.outlook.com (2603:10b6:510:3de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 18:58:38 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:2be::4) by BL1PR13CA0190.outlook.office365.com
 (2603:10b6:208:2be::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 21
 Sep 2026 18:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 18:58:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:58:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:58:36 -0500
Received: from xhdamitn40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 13:58:29 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <Padmarao.Begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>, Padmarao Begari
 <padmarao.begari@amd.com>
Subject: [PATCH] fpga: versalpl: move PDI load operation into firmware helper
Date: Tue, 22 Sep 2026 00:28:05 +0530
Message-ID: <20260921185822.3493122-1-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH6PR12MB944609:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6fe501-cd30-417d-90ae-08df18125855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: x0ygS45CMWXVv+7RQcBheD7jNGDF+rzuS5WKpbmH0vUQeMFmLJQet+7Iw96rxMxh0TGioe1QMqGdPwmclaRElGamWbDO5QGTq12aDbe5zAXkHKtImzjzFbsCB/KlCzzwS2QDFD7WEb11OnUivLV1+HEPxHdFDcP73qggA5SXgFSSzpCLn7p9/f5TSp7JsYWT72aTnsUpfrIdtgJdON8a5w3CcNE4S/q9FZp1NGT/H1t41WH6NPzn2SrJx9DzeAJaogA0b2qvphGHFBClp2gjjwBxgzHbOoEWcQIe+KY8kbzHiN9LivmLMhiDqGs/Ywk0jWhd93aoX97E2gIowXf8Q/q74ZU1lTS1no1aUkYvtNKD1McHbtAORlfOXHSZfc8cSO/sh0iIPpFonjyaWcK7EqqhJTknJDCTbDsm4mGPAku4amorx8FDCzLhgHOMu7ozVVIq+O071b/OH0jvOhEQm2Qssq3b45QfiFVur33z3xD0nRHt6/lQff0c2VRFtk86kc58LphH/FhSTpLrnFp9Yk7vlExlogMxHImg9dHFR7PSXI7KB8C+YjFWjpn3x5+w1vWNsaXNzmL1ouA/v4NARJxTDwzi2a/KsrvChIH8snvPztTUC4zuZxgnlJ7r5Lv28yXEHz7dyr6L+qg+H4GPzVIoL6SvhVwUXLNwkUfABn4J7YhgtFpT3Z6xymotzPKYI0Goa0BwefkjBXboscsZzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KVVJqo5xJUwapdqiXNojjek2wuq55C3FlZk2/BahiP9S7BGUsfUa/5tLGBRYKv4PyRtquENUg+uJpUTt0woiotUyHbWrn2j/Wh2KzjtTNLJ1rh1Bi2aImHNm309ebAsqFPJMYNizjCZ+rzOpUd0CNVSCh45WlS2mpo0VnigvphUbi3Qtjl4cgSLLH2vgcPRXZ+nTgpdrKY2QE1oNjsB2V/kla6SnVJJiVtEwC/o6qWk9V4N7Jh83rBzKpUe40FU5wfaP8LmaYYeW5pqfEu6m5K86dFG2bMOIUbovgNFFP8iey8kQdlJK9Sjr/5VtJXdenZFRS9qkQ4u2rvN7iyPmD+d0A+Unfl2L0a4y9ZaGYpRAUoteeVDrJhxv7JLHeclRGdVI2HMwUEqd23wLy+56OkEdVDbD0hd+8hhcTsGkLXi7a7GNnHbPsleknBHzmg+Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:58:37.9949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6fe501-cd30-417d-90ae-08df18125855
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB944609
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

versal_load() calls xilinx_pm_request() directly for the PDI load
IOCTL, including Versal Gen 2-specific buffer address handling.

Move it into zynqmp_pm_fpga_load() in firmware-zynqmp.c. The Gen 2
buffer ordering now uses IS_ENABLED(CONFIG_ARCH_VERSAL2) instead of a
runtime desc->family check, which is equivalent since U-Boot builds
one board per image.

Also add a weak no-op default in versalpl.c so the driver still links
when CONFIG_ZYNQMP_FIRMWARE is disabled.

Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
---
 drivers/firmware/firmware-zynqmp.c | 15 +++++++++++++++
 drivers/fpga/versalpl.c            | 20 +++++++-------------
 include/zynqmp_firmware.h          |  1 +
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index fae66ccb3d8..ddfdb0cb195 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -14,6 +14,7 @@
 #include <dm/device_compat.h>
 #include <dm/lists.h>
 #include <log.h>
+#include <versalpl.h>
 #include <zynqmp_firmware.h>
 #include <asm/cache.h>
 #include <asm/ptrace.h>
@@ -175,6 +176,20 @@ unsigned int zynqmp_firmware_version(void)
 	return pm_api_version;
 };
 
+int zynqmp_pm_fpga_load(u64 address)
+{
+	u32 buf_lo = lower_32_bits(address);
+	u32 buf_hi = upper_32_bits(address);
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	if (IS_ENABLED(CONFIG_ARCH_VERSAL2))
+		return xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE,
+					 buf_hi, buf_lo, 0, 0, 0, ret_payload);
+
+	return xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE,
+				 buf_lo, buf_hi, 0, 0, 0, ret_payload);
+}
+
 #if defined(CONFIG_ARCH_VERSAL2)
 /*
  * Poll the M-PHY TX/RX config-ready status until it settles or @timeout_us
diff --git a/drivers/fpga/versalpl.c b/drivers/fpga/versalpl.c
index 3cb56cc0dc9..29d2a389fd9 100644
--- a/drivers/fpga/versalpl.c
+++ b/drivers/fpga/versalpl.c
@@ -10,6 +10,7 @@
 #include <versalpl.h>
 #include <zynqmp_firmware.h>
 #include <asm/cache.h>
+#include <linux/errno.h>
 
 static ulong versal_align_dma_buffer(ulong *buf, u32 len)
 {
@@ -24,30 +25,23 @@ static ulong versal_align_dma_buffer(ulong *buf, u32 len)
 	return (ulong)buf;
 }
 
+__weak int zynqmp_pm_fpga_load(u64 address)
+{
+	return -ENOSYS;
+}
+
 static int versal_load(xilinx_desc *desc, const void *buf, size_t bsize,
 		       bitstream_type bstype, int flags)
 {
 	ulong bin_buf;
 	int ret;
-	u32 buf_lo, buf_hi;
-	u32 ret_payload[PAYLOAD_ARG_CNT];
 
 	bin_buf = versal_align_dma_buffer((ulong *)buf, bsize);
 
 	debug("%s called!\n", __func__);
 	flush_dcache_range(bin_buf, bin_buf + bsize);
 
-	buf_lo = lower_32_bits(bin_buf);
-	buf_hi = upper_32_bits(bin_buf);
-
-	if (desc->family == xilinx_versal2) {
-		ret = xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE, buf_hi,
-					buf_lo, 0, 0, 0, ret_payload);
-	} else {
-		ret = xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE, buf_lo,
-					buf_hi, 0, 0, 0, ret_payload);
-	}
-
+	ret = zynqmp_pm_fpga_load(bin_buf);
 	if (ret)
 		printf("PL FPGA LOAD failed with err: 0x%08x\n", ret);
 
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index f753a67ac27..e0759359846 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -467,6 +467,7 @@ int zynqmp_pm_feature(const u32 api_id);
 u32 zynqmp_pm_get_bootmode_reg(void);
 u32 zynqmp_pm_get_pmc_multi_boot_reg(void);
 u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr);
+int zynqmp_pm_fpga_load(u64 address);
 
 /* Type of Config Object */
 #define PM_CONFIG_OBJECT_TYPE_BASE	0x1U
-- 
2.25.1

