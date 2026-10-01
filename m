Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC5DCA5FA5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 09:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E2BA812EE;
	Thu,  1 Oct 2026 09:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 21CX5IGS2qnQ; Thu,  1 Oct 2026 09:56:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CA660812F6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790848619;
	b=OfZJPlamNrEeRa7YcaeittRNCJbJpghAdk+s0qQgJEmDt9NeGyoPtcOm2/cstIAtrio/
	 slbDoPyo8MWT0It4/QqmgoZO3L3rqoYVaFIG3LZKeXS27STxNY40u0pSzxSYS7NDYrerX
	 N4iVVnrnpLo7MkCkkgFYmUO3er4I+dl3LKTNvnQQUUwfDDlwujGcnBNZLJm/vR0yqkF/6
	 MIWfh8jtNiZ4FGcidsDrYNjYhnL4yf1gasYy8SQr2iqDkHr/aT+xUNah+ZzyQ1MBLrDlF
	 qyh0M4IIfD8WxpgZf02nP+QNts7VU431bSc8hUI+5YtL0UdLlujMWkyw/8IheRaAcFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790848619;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
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
	bh=1mNcEzsAXFGeS4e/30ZaE7QloBmxycuFlVp5cYOywqQ=;
	b=RVgG2MuDvwXChP3SJa02Nm6vd3dyB+XfLRCIJl9vkH+87pevzxHT9FmeadWBxSwlXYpD
	 oZhMEG7PY5iTWMgxTQOk361apWLFwtznfTykCL4Mm9Wk77kGpV1QxRgBsiWrtp3IP6nsJ
	 rnzs1snnwzSHG2jYha3iJ/MhEPuRMyWxjTJZdpIRIYltcnfI5lU7gpe9MWzUWE1kdhWJw
	 NCJsfGeB8vQQsyROb062HC48FJzAaTs7yjaWlFFAu/xYGZLHJXUxBQBy53eLhDBMkp4L/
	 deY8nTNk6vHLjAWd+aM7IXWqOmmiLxO8536mQuHQO4A/rh4Q5x2mr7gUYe/LOGt/ZiA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790848618;
	bh=1mNcEzsAXFGeS4e/30ZaE7QloBmxycuFlVp5cYOywqQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PGS+wqF+MJGXPAFGaq1v5yv5vLqPjPeQVmrvIye0SkSyPVVp/JrElf2yeBrYH2Dxp
	 21Yv3B2XttoMeShKmGVAQjvO2dGAA+Wm02htuywTCxcVxLeUWcfrU5VzCXZHKAPxxW
	 FpBLnfUP1x2AhrGvuQl7O7QUtvjs5xHW4VelSXOm/P1ehBRTXCy4GglDeM/vy3YesE
	 TbQx1tmkBpJrV7JjAMpkO85ayRZEDobLi4PiaLsV9tm6ah+6+tWSVYhL+8ojGjaYzW
	 rUeqKRXcjQ6uzQc8uft2lYy1K9fPQvUR2kc3MU6QSz6m0nKmHv5XHqGB3xGsrCJF+W
	 zSz/a/vCqPqIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA660812F6;
	Thu,  1 Oct 2026 09:56:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 819E322B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66F1B40D70
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xV_QlpjlJOPE for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 09:56:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CE27C40D66
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790848614;
 b=sCW7qQirJ71kr8evvpQv3OKSsnlWjM5+1mWOvp3pQIXCxhZ+hTM6NyN87bTls3LGfSr4
 wOOolI+QY7NhULfR14xvTxUgvU7kkqMsmOZUkTjGQNJsBG6Y3CpUoEVWZAHDm6DURJKBc
 DyFA7EvNtx330TGuBTma9u+lF8tkkgUljkpsZ6FJ6/77vNUyZsww/MJqeYLY+YnxzR5a8
 xlet39KhdaLooZLrMepZ4d9eQ5oeWGRlWQpZ0BXqIDXuc2FnAH0EItOhnnzcAvTeLpLjI
 X5GMY2dTgaJlrpfLX25F9iED+ZpAu2z5Dq3/Wsm7hyW5LBqbYQmMa/9y+U83HNZtD+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790848614;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=1mNcEzsAXFGeS4e/30ZaE7QloBmxycuFlVp5cYOywqQ=;
 b=B+erlS67MZ1HEpJE6xUBzr1ZDMeXi11dpF8D8Pilb+ynH8JJP551YIxWnn0bS3cGCKkg
 40pyKQRbM6lvOUSNRZHxPwDTWVg1zWQXcJK3K2aUWi3sbVV2EjL3iCmgGZlXbmROVkaKU
 R2c4Q4xAjJ3XPaQuPIu+TATCw9eM4+zonF+lIA4tI+I5wkJipbsyCd676nCCE00c4Ro5v
 K0n3AyBCY84sARz77Al37Eqnner5FVz3inGfwLvOiHgLTBpJlQkRx/ytdjM8cuWqeireQ
 cFWjNPLM+KD8y8gNAXW5U6SLyxk+/YsmHTxfJ9hwRWjJK2CSicoar96aMimGNwEQ+sg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fL843QdY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=pranav.vinaytilak@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fL843QdY
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE27C40D66
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvqREa/U6DbDfrvVDYwZ3PZBtEuorngBxx+pCEwyp23rmUiqtCEyAVGpf/+/PBmg9tP34y/E4QTjPp+44kn80+bIzHCXpIS8NoP8Qq6t15kfW8JrbRnLVPQvbFE2KdVxJ8WJhlHBYq3/XR+02BmnWCxHgTOaBszAyhEm9x4xpqhBKF3oIZeh+IQetH+7W3nY82qE4lnG7Ruma983b4NzohTXRiRvcXjok1H0M5faE9AyZTI3t+dIG1yFHbwI/EZF6D2CcLjIzXN92SUlBDLSTPLkowH1vzuKWIoFLdHaV7rl2ramCGHzhE6LaUWFMNkg9u1gaQ/E3yvrHw/ttdzg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mNcEzsAXFGeS4e/30ZaE7QloBmxycuFlVp5cYOywqQ=;
 b=MN0b2edAbMPDraYl8JnvV71r5LN+TTeWa/LSVDQD668s+trZR1KpP4IYdprcZjZT6nqNjPlp6XkgvQIA2ti/DGdM+t0HQayddwXUq+f0C0G/IWFbYwrQKsNdX9RexfNBhbK1HS2N003LdyOyQDn+eKyJCgevwNEqw4UdAAOvWEAWEYHW59Ny2U7luriTUKyQivF/4d+gaNDehi4HSfa8bQCq3PSeNk3HTAjUc7mNNAe0hH0Fi1OH14p9Mpdwjc2Vq8fsE00CghBDWOprFHf9vvOfnw9JBG5vV7elRLelJoRpGPv+X6xYL88FD9KWk6q/hb/z/H9sVTYlAp/JfhYRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mNcEzsAXFGeS4e/30ZaE7QloBmxycuFlVp5cYOywqQ=;
 b=fL843QdYC1E6MvbWBR7dcBpoIge6RUkHaXlxY5M7CsrF4M8eAR/BlNkqryp9lh5A78ehGG8U7zTDHFcwhSOqCaRR5n6wMopBe5b6szA9osMYw6v1MBXcUGipUopm1D/DMOmt19NRCR+EfOYxdTWVTjRVdhDgWUQNGzC3ebYbSIA=
Received: from BN9PR03CA0633.namprd03.prod.outlook.com (2603:10b6:408:13b::8)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:56:48 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::3b) by BN9PR03CA0633.outlook.office365.com
 (2603:10b6:408:13b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 09:56:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Thu, 1 Oct 2026 09:56:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 04:56:46 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 04:56:44 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <akshay.belsare@amd.com>, <padmarao.begari@amd.com>,
 "Pranav Tilak" <pranav.vinaytilak@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: phy: prioritize GMII2RGMII bridge over DM-bound PHY
 lookup
Date: Thu, 1 Oct 2026 15:19:44 +0530
Message-ID: <20261001095555.647330-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f212ae0-b3ca-44ef-889d-08df1fa24ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: aKhF3iHZbMyd72Gxc0E/IfmauMAkYR0ExFewQ7OiuwSIgVHALy17fxKHs/QLPueE11oHAu3TkUDQeIloUGj6xhQT9mViU8y2l1UOwXEYjnObqOx90iXhAWFM9mSsvatgGOSD3HNZBpznXfzGRAhY1Bzf1d3DXs20eq5TVgWWa4KgwjbmXGtBetQgfskj2BvgE5Q3uv7y4oNvLDm67nn4nTqXW6TzgLDotuZH1WHx8CI8GKpAdwKAhNgi20LlclWEOW+yqZZHgqoTWR3C6cis5m4A4mkQLagT8G46j65JCDhFoXGPvnRKC1Lg93v975YEkEN6TuNU95FCI9IDhE3byiLAgdHHpINHfTmfv7vpoId8MRhqi//xbpGhnbtPcyl56ka3J4Z5nBhzlRDNig6znR3dNJmpXXgeTP+LWgcyGlCS9wPt3lfHYa/d3ifM0BLN4BtFKVdXPRb38er9+cQOVLLpnc68KLPHX/45K8jjle/J8PmvasNQKoBBwQZTg/DyLRG34e86VQtsfyNajNm63KKQ37Hx0Y6M5dClY81yibzIkmpthajvI/mSJp6oc9TOgzGz+00sG59uIn4KPqxmtdOpRXElC2UClxAkHfiMTrvwddGeUro/lGAnIZ/vbAsmBq8Ke3B1X1zQoMvoYJ+JznDWkkt8WZjzK/9B2ffm91QBLaYoMYUU+doYNa8UbbkG0uWzr+RdHUcCM075I4xaMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Iu69MeT8exiNBRn6yOqan58h2I4bNds3Lry7rv/LZ/TRGgRUVlwYHoy9yymk1KLlU69/bL93EtaA5ZNdaVeF+4mnzU64DhsapB5Kay92ISpYM/6Qh/n0DJ3BVyG6OmtptxjSWaLCyEUHtJBltmpcOcUexR+HwFeWn6/CGAveiivCiDOo/h67m4ip5a7ht5gq6Kzxt5a1P1M1lZFHtgYhfA7ghYaMzj8uClKy/kzlEhwkDxyk7NP925Z/iHxhC9knOOCR3EzRLVFy1JLDLHX1Wbmxw0tMmR42gYEBTbDddc4Mx+rEKclGdRQrbKWeSkDKaTTMdAyqyJviYPOa0RuTrd4MiKNfQZufQhp5ziGY/2BBywoj7kmGB1OUn6Kz4aNsst/iisaGEH2eJ5HtC1jVCK/uXm0ruaOFQzbMRkD4dP0X6SR//vJq0BZzZGlagz2/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:56:47.9550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f212ae0-b3ca-44ef-889d-08df1fa24ef8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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

phy_connect() currently checks for a DM-bound PHY before attempting
GMII-to-RGMII bridge discovery. On boards using a GMII-to-RGMII bridge,
the external PHY node is already DM-bound, so phy_connect_dm_bound()
returns it first and the bridge is never selected. This skips
xilinxgmiitorgmii_startup(), preventing the GMII-to-RGMII converter
from being configured for the negotiated link parameters and leaving
the GEM's MAC-side phydev pointing at the external PHY instead of the
bridge.

Check for the gmii2rgmii bridge first and fall back to the DM-bound
lookup only when no bridge device is found, restoring the bridge as
the MAC-side phydev on boards that have one.

Fixes: 2671bd1d77ab ("net: phy: fix duplicate eth_phy binding")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/net/phy/phy.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index f2e9b2a9820..cb4fba93391 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -950,8 +950,13 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
 	struct phy_device *phydev = NULL;
 	uint mask = (addr >= 0) ? (1 << addr) : 0xffffffff;
 
+#ifdef CONFIG_PHY_XILINX_GMII2RGMII
+	phydev = phy_connect_gmii2rgmii(bus, dev);
+#endif
+
 #ifdef CONFIG_DM_ETH_PHY
-	phydev = phy_connect_dm_bound(bus, dev, mask);
+	if (!phydev)
+		phydev = phy_connect_dm_bound(bus, dev, mask);
 #endif
 
 #ifdef CONFIG_PHY_FIXED
@@ -969,11 +974,6 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
 		phydev = phy_connect_phy_id(bus, dev, addr);
 #endif
 
-#ifdef CONFIG_PHY_XILINX_GMII2RGMII
-	if (!phydev)
-		phydev = phy_connect_gmii2rgmii(bus, dev);
-#endif
-
 	if (!phydev)
 		phydev = phy_find_by_mask(bus, mask);
 
-- 
2.43.0

