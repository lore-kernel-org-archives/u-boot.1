Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06C6CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 11:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7548340367;
	Tue,  6 Oct 2026 11:14:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qv0Sxr3e5Qzu; Tue,  6 Oct 2026 11:14:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B70DD40557
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791285257;
	b=jRBw57V+lKkQhCqZvKgGmm3my4uTV1+vdEjznmwjldqELuslqCVk6VS7zSEcs4LFe5Wo
	 2xMVfP0X3QLaC6bzXZ58//n0q0YbTo/z+q6SQc4WRGwA+JYy6m7TGbQ5HL8fjVAibsO/L
	 Qk5Cr4uJvVR6SURbmcYpYJZoPUHfmPhcJm1NpX2F8lD6pj0p935X1tFX+eBKoU0cWjE9Z
	 WcXYJxy3CLPUwGGvY88fVgyg07xcFikdnxHnIT6Bb2jZni2TNXC/XbQwtQtPrhFHGkUac
	 3/k/zvobxOCNqTSARtzrcPeFvdFAcC4Mu3briai55ap5NyyVR1IvfGa/jWEThQmC8aQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791285257;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	bh=lx6EBaa85f/Ty3w7GRowcBHoVFfTTCXxqU87m76rmjI=;
	b=fak6BHuCPGOuD2QSi0QB18YU3aTDmAK0zhiGWiQO7gUor9zMtWhnsBnAER8Xl1tYyNjY
	 DtYSZK3LkyKkk9+T4rQDJHNKvMkhtRBLNK6Z/4CmaLTH2jKYvUZbhL/+fs9KPss2G5CVQ
	 nJ6VEtJUTSXknI9QARBdWqf3m1hgvJ1EgC2TtcsrLlQ8smA4mx7fD3BEILaFNhAlVW8+x
	 mtNfwMzTXCtobLItY+UMZ76C7oGQel/w8tjztSkoTCpKdAY5g9eznkbAFFcZP6nEh0t5Y
	 57Wmz+mODnmqi8Bu16IV7gdIK+WNS+tCx1z4O6jvUF/mBa4ttqBSgoE+wWxACHbd8GQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791285257;
	bh=lx6EBaa85f/Ty3w7GRowcBHoVFfTTCXxqU87m76rmjI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wo9cWi+0kxTtXC9E/32pxwmE9u5tMF+4gG3LZn8C6Vv9/UmgyAwonziN36iW8iBDS
	 3Ye3qbnT0jM46gZm6fb8njG6s6Xd30K7o68W2/hpZO+hlCX+vjiSXeHNuM2vY3BCZv
	 pdb6aGAbtWoJelDKmHkN5uZWpQNDuA8FfprFrMIVifwdG3RN18RCm6vlN78NoM5RT7
	 1jOHc1g7HICTD+GSTB0bA2k4Z1hzmEU/crD2ey5BIg15NkwhDQ+yUUMFe7ZzcXF3+g
	 MdLpPq3bUVVNYMc8gODGPdKgg3j6S+5rKgkDQlTsGkQ/ln08DjxuU3j3RA3p40GUoH
	 f2i50wC/1bHUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B70DD40557;
	Tue,  6 Oct 2026 11:14:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AB460341
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 910E260779
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:10:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 06vDN9qZLc5q for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 11:10:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 07D0060739
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c111::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791285055;
 b=K3nI3QTvFiOMtzEvF5XryHDhC9tcv1LudqBu8iAaQ6oTeqchFejdG3kzb63JSXrVWqqA
 upua/0SkbqYmjGvn4wRMHlhiBHzOFeEm+zqCk13BrYP8+3weUrfx464Fzrys+j6ARKQMj
 /tZVvn03luiAHgrHuIj5kbFmbYTkWZUmkG01mf4htzelzt0lDQogT4YWnlu5TclgmCi5r
 3JxciLFo64khGIc4E7MTRbK21YIBy/NpNUFi3OlQ7Pl58eZdfDr1XKEMSkVXLcUqzlbo+
 SkqT2D+fI48+Wi4u2S7UenZQ2b1vbIg8y9hf4E0Sc02KPJw3nMKVWfit85H2ocjUTFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791285055;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=lx6EBaa85f/Ty3w7GRowcBHoVFfTTCXxqU87m76rmjI=;
 b=a7jMoNSr9cVmzivlNaZi6QCqreYN+W2gSE3jSdIeGUyc//ZQrF5TM7mJ7Tytimyohdv9
 muMNom5krl2Cf2If2gFZykEKwdGncFcdPmuSe7g4ErovNse2r/yBed+v/2RGf1G/7g0PD
 zNiHIfK6mt8VadhFLh1Te8r4Eh/M+A3gLVkFo3QhcrgR7gWofj7f1uDWLNfjYGV3g6fHU
 d2ja6Y//0Oc1LnAX1WobciBazkZ+/gurYQq0svd6uey5fRSidGJGHDv/eFEC8CXuxP/QQ
 eXnm4a3P+bnHPEBkZtvPRuuBS2kM7TigHftF8dMcV21vQ8d2WVZtPaQIaoLQ1+plnWQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=lB21yclK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c111::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::5;
 helo=dm1pr04cu001.outbound.protection.outlook.com;
 envelope-from=prasad.kummari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=lB21yclK
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07D0060739
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZnHq+gEDJbGXnGAYQCwK5+k9T/ybJZjUd5oWZZyNvvp43t6iZpdlPzue6zV5k+jZQT1XaczIqsfN4EjnQaYpPdjPn1ELAvllf1qjRd5S8j4t2YAJrInb9kHoqpFP5/BDQFU0ZCO1Ym9Nrs0f4fHYNKoFKA1gAgifhYxJku0pXpfMrOYCXdhUH4S00KD14QgssBuaZ8taIzeuUt3Oe+9VN9VNcXRq+IJ4dU/5MjCSWf4oHH43gYdS8F9edigQh4jsImXrMxbvASA6/0dOQEnFAldjbSEqj3H85th8oKEA0KASM8NkoDiyI0NIzLeKp+GEbyFM9p6CeWCRaIkMLCZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx6EBaa85f/Ty3w7GRowcBHoVFfTTCXxqU87m76rmjI=;
 b=JdSWH8mu4jOtqgQNjVFKb84shkjcNx9l9JSxsiulywBKYqO/vCq1sXrzbK1xtC4zEE8lRKIVsfiobl7KrTPiAPnIlSR0VhH+PRQ8VY+O4d1tO219J3+NCD83GPmxULxtonssjzHkP1tT/agEG77W2yobA8hiayVrNeisw/XNoJ0TaHlTyar556k9KsNxHYU7UyuBVr4iWbaZ4oYxRQY+NBvuu5LtiClfBCDPtVYq1gy8GsY6K3tw0dNLK8+x9G1N+Y4yK8n8LFON+lfkhfrEVTr/ERCSu1BX5n4SzITbtcFon51uN6ri2AZelGPKrgh4rVwx+n9xlhgQZFvnZxMZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx6EBaa85f/Ty3w7GRowcBHoVFfTTCXxqU87m76rmjI=;
 b=lB21yclKWJIKILYYk1fJgy7vO+HZQ0LBu5/XcHQPHFZXPiHAeVZq+v44xJdSA9BbGmPJiyOyzKSFVoDhotX0jWZsjFgsLKm3Cuv58yus5GGrMbfSln7RKOaAfIHrad6mpCM9rngj8D8h46LI4j2REbiXjyf6maeQK0HcTkmwQSM=
Received: from CH5P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::19)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 11:09:48 +0000
Received: from CH01EPF000BE946.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::2b) by CH5P220CA0021.outlook.office365.com
 (2603:10b6:610:1ef::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 11:09:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE946.mail.protection.outlook.com (10.167.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 11:09:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 06:09:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 06:09:45 -0500
Received: from xhdkummari50x.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 06:09:43 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, <trini@konsulko.com>,
 <sjg@chromium.org>
CC: <michal.simek@amd.com>, <padmarao.begari@amd.com>,
 <akshay.belsare@amd.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH v2 2/2] rsa: reject zero-bit modulus in rsa_gen_key_prop()
Date: Tue, 6 Oct 2026 16:39:19 +0530
Message-ID: <20261006110919.396293-3-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006110919.396293-1-prasad.kummari@amd.com>
References: <20261006110919.396293-1-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE946:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: cae43e76-1bc3-4928-44c6-08df239a5597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 5E2DafIdlEX/RFYKVr0YRwDegQdxC+lJEM60tRl+/A7iAEGTnzKi1sx4KoYA9WJh1nEyw0/PY+hiNeobr71sGZLzcQKNYJ8pTsaGhs0CK9Rvak286lCupTGBRpmYqUvaTbU4jyJFRo9KuWbSR01Mb7yXYcni0Ta3c9C1teHDqg5Jktt2ynxLYaVJ1EWfAeZazVpHqPN0PRLDNmmJFw2zCIxbbMzrfjyOZtg0q9JUf6CW9il60f6/X1RkKrCcBujVLaJLWEDYGRTh3RJHvkzj5X5dTEmiV3KUj1aPkw9VNdD2cN6vCaKlXP2bamn2YIzJpNls06I0FFJmHCpKxunXVldlR1GuXBgPWCUHcLxMzNNESngKQqS90i1cLEFKnXXTndYbib4vP3IRZl4G/pM/SFy2KNvALApVdAMrN/9f7K3Xkf+CX3ucbs+7MEP+n05Sa6MR+2q3dMBrttMnzt2MhIkVikVr6QqFvzE08axxDcPc4VolT7AUodIi1lagXss7dof3Fb9eec/xvymxPXtZYrn9SgflTO3lUf+A5x1eyEboVHdpeE5IPHBNjLpX03jX9oWWZ0ZCymB6XmabOBVze9eAkfyUh+Kmi/Qpcxft0yxdFSHHV/ocyHa7gU4WMQ90yJvyAB6J/GkqOp5kl68YeNfroWZ/gX9qSbyf53wec2JP/zogUEiqzrR2+Bb4tFhtaa8j3rQ1m32QDDv2e6gBjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Geto2q9TCXM3dTts9rAjdKIUQQwNMZhIQwtlSwtAtaHpIprbP0VRC1Qco4KeW+9wxm0px57icACjBmxUxvB4S/xhkhcQiOMsG8I7EY3+OBJwi+VAOfOKWupc4JTf/nLGut7szJI/zHPE6RJCuM7uYKOBYhwBLVXWwt05IRULCieOLCL5zh1pnSOSXMESTiilO6QlNHh1Lfq8aXvnPbJR9gwzh503kem/GsQ+z0WwqQlr31pisCYJC9Un7vgrFEyMbT/YNMO1AYCGZME+CK7/MNie4jzm3+HzXRVbsI41jr7ZZ9f9wofD2eYt6eV2RE3S6rQyJ+ouedRmoIKv2zmZ3M8gh6WsAD+rjBQ6ZFvvkwRUhKSHi8bgaBKAA06Z0yO9tn2SSwm6TUBIQlH+O8hg+tfFUS+HkMwPK5MWXoMq+HUziPpe6Hu+ChrNS9su/Fx4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 11:09:47.7269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cae43e76-1bc3-4928-44c6-08df239a5597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE946.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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

rsa_get_n() only rejects a zero-length INTEGER, so an all-zero
modulus (e.g. a single 0x00 byte) is accepted and leaves num_bits
at 0 after the leading-zero-stripping loop. With num_bits == 0, n
is allocated as a single header word, so br_i32_ninv32(n[1]) reads
one word past the end of n, and modulus is allocated via malloc(0).

Reject num_bits == 0 with -EINVAL right after stripping the leading
zeroes, before any of the buffers sized from it are allocated.

Fixes: e0d310b098b1 ("lib: rsa: generate additional parameters for public key")
Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 lib/rsa/rsa-keyprop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/rsa/rsa-keyprop.c b/lib/rsa/rsa-keyprop.c
index ca186a1440c..e74eea18977 100644
--- a/lib/rsa/rsa-keyprop.c
+++ b/lib/rsa/rsa-keyprop.c
@@ -681,6 +681,10 @@ int rsa_gen_key_prop(const void *key, uint32_t keylen, struct key_prop **prop)
 	for (i = 0; i < rsa_key.n_sz && !rsa_key.n[i]; i++)
 		;
 	(*prop)->num_bits = (rsa_key.n_sz - i) * 8;
+	if (!(*prop)->num_bits) {
+		ret = -EINVAL;
+		goto out;
+	}
 	(*prop)->modulus = malloc(rsa_key.n_sz - i);
 	if (!(*prop)->modulus) {
 		ret = -ENOMEM;
-- 
2.43.0

