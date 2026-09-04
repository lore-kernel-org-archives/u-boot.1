Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D421C61DD6
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 10:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93D1540B52;
	Fri,  4 Sep 2026 10:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WK9DnOH_OlGh; Fri,  4 Sep 2026 10:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 62DAC40B6B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788517142;
	b=BxFecvIg05ISx/qdRpuYXuoEyaqG9xkY37Vwt8csF47FgdUb4V4DAtWaE4IZcBVfA+1l
	 Kf5muUw0rbNhIqbxV23e+r6Wnw3omZjhm/HlU+upiixapO6UivKQgY4WFytgoVJBEfVPQ
	 G0JO18gdpaNljgj6qR19Ebse2cPMvCCNdtGY6Zh4gZvc3mLvcH+Vm1o3dPQgVO+cY2rNt
	 kncyOg7nuY018+lNl3fl8ZZh843fnBfQ039cFbS3Jn+qIU3rhkHZcEt/4c+dYOWoexYNm
	 zyk5JxTS0CUb+qc1dSqVomUJ6MzChGEMtarMlp+ZiGe0l8xeTBBXfhLXTe/AZs75t1w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788517142;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=lwabRWMehwzzI/YDVSyhkt262001sIivX2Nz41jQtKo=;
	b=HFnOshPBLh5Sq0PnZkDoHZ2e9JAHmZ88BxHaBGn4M6EUz1DicFFEmSqrX1x3NZTmfEy7
	 JF9171lizZHxY1JkmqNHEeEAGoI3gfk6No3Ja+SWb61PUo+k5MplL8k1Rr9FJ9uzzZJAG
	 J2gNykRce8WpOtb6P05h2B0rKhFuBHrTmSm1R3ptLmM5oKL3gngSmDnyh/RUxSed5wMaq
	 AHV4i0PSMDdH5vT8MoM7aKS/zWpUp0/ZuRWSNSMqd8oMkj6D8IQdfR/sADYjNw6DVP3E7
	 svBnkZfdkaU/8jgg9cVg0Nt0R3Gw0mAETxRS3gteBRtr8MCiYwy8KJxMxFr1+WASh+A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788517142;
	bh=lwabRWMehwzzI/YDVSyhkt262001sIivX2Nz41jQtKo=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mfP/z1Z+z6vwTAKotnndY3VtuWg4gx51qGirNfqj8yjLW+BLEUMetNERTeYPwY9aB
	 IozJVH78362CaYEau7WVEzhzf2JnvA4T2a1WVC1qg0bctajXCm7YXhd47x+1MT7oSJ
	 Cs6DeQ9xqb9nUGjfGv1bBh25zdd1NMMrOG5HpL96la0tEQyIRcLi9zVZSmUz5KOrPh
	 7r10/sNFFb0aQbF4XLSevukjwI+GZhdEtdepMJvNbohOaw1Dhk29yEDaG73LRUSy01
	 wm0AdiKkZ7bcVYJO7azsKtNA5FWJjPHR8p7i/uSu1fK40AFJG1Z6ZeKNpuN2JsQx0r
	 Bpol+XbzpS+Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62DAC40B6B;
	Fri,  4 Sep 2026 10:19:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C377C10E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A957A60816
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xDKXjMFextEc for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 10:19:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D494D606F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788517140;
 b=YaLkV8QGyLztsQ2qpOnBUqjkFw+3m1kv/Fh0ftNxD20SR9VfIbq/OqYXwE5sweiB3/AK
 zSUrkD+KXOk/03+YObKxsZ7oIVo6MHsG/QCYq3q7wbMhM2DKlXl988XYX72XblpGZMXsm
 dyN7qnJnS2PsAeTg3t3X732BnbjsJWNxwQSsdQWUxcauEuVoMPJgn/7f0ORfIwO4DxvvC
 5kFAY1a0DCSm/J/1Xt/1yUgiB/f072kO8LAWtT81/RVJbEX1PnBgvND6PP4xt+YnwEkwp
 FrnkS70G6hN6BfRd4AJszGLRxxXsi5FV+UOLD0/lCl2ojlc/P1PlAO351vTjl8uVAmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788517140;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
 bh=lwabRWMehwzzI/YDVSyhkt262001sIivX2Nz41jQtKo=;
 b=W2/Wm0CmksPX9JX7xW9K81MBOthoGxrjyo5UaCBx0CBi9ryhnYKiFdGZZO678lcx2ANK
 9SVzXMbnsB0VMpR+LtJl45yRpn7187ob01haChwPx+PqRYbaR+UhTS/M0P5k2WBlSbd8c
 ggNYJ6MnTHbFg37lBJed9nbwdwm+Q0brLn+WdxPFesRPcHOBD7pn2MIjbzyM7bSC1HEhT
 J38u32HdxqlQy5dWNEEhCkT57j6bm9QDlPdS8aqaIM+mpia8ipqJgM99erPSN0dqk0ISx
 Ni5+P0s813pxBl1TX26Xiiwbakyjd6pBaGfzHBNzNsdv9jUgHPvS8Or3+M4B/JrMNCQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=fXHcdNkF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=fXHcdNkF
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D494D606F1
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uatQIaR4Kh9zQKgVX3FBaMLvZgVlsXUuei9VFA2Xk68d2hLylXQsvpERh1KWdijVvqNx45ZFblkW1RwqENyrJu6gjzdYaMB/j5QOi1SDx0rAufOZEJDirn64fSNkhASoFHus+BUjEy6y6fDVMWDYSZWNN12kpxBUh7gabWDT+wdn+fZR4Dif+2m+2z+nXNPvCCug23FSF6npGx6Q8hkSYSHnZshnU/K2GIl6vr6Q2TWkjmYbydsf51wZ7BPKHvAJiKdSHsucA+w8B+gCpxaYmBouje7Wvt/QaLfL/2jO1pqJmBk3daHlFr5xmaRiykKJe3dQnAPmJT8p0VI64aiM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwabRWMehwzzI/YDVSyhkt262001sIivX2Nz41jQtKo=;
 b=QoBiBYIRXgmisHOc1+URG/YWIWg2aD4Gg9D4zRnPARnYmJrGV3W15Vmyds+sisxuYJ9tdH53wyPHThAXdXxFKUlIDU/qeL54hVB+bYctdV5IYOmU/o2u/GhR/wHN7/7TVd328WzslnOm+7V9O8t/cmYn5NAjDp8FfHqPnHhkYGaY9kE8eGc5188okOhFxHAVVm/W26Cs/ovkELWgPmYhKwH8kX3aqhgmpQZh3KvPZiHvYvoeQRec36pU9GK4F0d2sHF0lNKd4ZNHXE5uQd8IWFtXMRwlxQAN/S6PXQ3SsIu1YFt/rXps/rjwnmvzPQM5pf3qUKL/cM/vtC07YCDjyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.88) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwabRWMehwzzI/YDVSyhkt262001sIivX2Nz41jQtKo=;
 b=fXHcdNkFUaMApcJENg4jm/0spINyH/GKP+vtnBtIWC0sTHH19PkNz/rZBsOqcxZQkz6LsDu4FctEultuuQBaV8ueEG06tBkekFKl5BUMWuQZ8XLTomuuRrUKjIt37X/mfWPLB9tcHyN3JgWJcM00QEFxc2nRiG3F+OBx7QrPljBK67S8U79lgDm6w+ss02cUR59jFD3TcrYgTVmfn7jqDIiYb3YKEk1qkUMZWq9yyZKqiHhrTQaFwDEZVZxrilkmcRTtyv7/sCozRM1ZoUXSyfVu527DykXQDAXNgKlpoCxjX9ksyxLE9+pwLhwOJfMwkrnEomU17Arb39F0t8gsVQ==
Received: from AS8P250CA0022.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::27)
 by PAVPR10MB7330.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 10:18:52 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:20b:330:cafe::5a) by AS8P250CA0022.outlook.office365.com
 (2603:10a6:20b:330::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 10:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.88)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.88 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.88; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.88) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 10:18:52 +0000
Received: from ENXDAG1NODE3.st.com (10.75.129.196) by smtpo365.st.com
 (10.250.44.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:16:09 +0200
Received: from localhost (10.252.0.201) by ENXDAG1NODE3.st.com (10.75.129.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:18:51 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 4 Sep 2026 12:18:40 +0200
Subject: [PATCH 1/3] configs: stm32mp25: Enable CMD_BDINFO_EXTRA flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-upstream_update_mp2_defconfig-v1-1-695c0abaac73@foss.st.com>
References: <20260904-upstream_update_mp2_defconfig-v1-0-695c0abaac73@foss.st.com>
In-Reply-To: <20260904-upstream_update_mp2_defconfig-v1-0-695c0abaac73@foss.st.com>
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.252.0.201]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To ENXDAG1NODE3.st.com
 (10.75.129.196)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|PAVPR10MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b9533e-693c-497b-c966-08df0a6deb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LM7p7kLC+hB0x+0jm6LS/lBtSny2Fr1nyCAu2QBL7bYjD0UQvlig9dypPsa1hfBZgIbCzBVLRhnMAcJQUcC1HhPEPdoQ33wqij4F0u9A41zPYl3Bsx0hElXawU7kQwxnM5Ux2x3vRk/W+9BDAJFP5a1KPc6l2YRaXEkgeXxb514fTjgvDXsb3IJZw7kpdMENTPVznDp4FCWYl/CWJu5P0UVhtjweUq5SRLY/0xV/DoY9n6SxBIl5yLPHEWx1/aP9bx9IX/GspToMkCl7wmaJ/9rQ/f7hjEVYNPU/UGPVM/w/34vgLIDNHfuzfwi6jnM7pUVZSJn+6zmlbqWQkj/9Bx9Axj0lpaSVlg/m3sv1gLoJI4IkGmhXBc6dvKUezzHW7T5dRCkLFj/zvJRf3uA/49InpkhmvNP574arrRQSkK8Jn2KBdEVjv/ZG1NhMeoqN/6835PWCFxHjU70l+WkA12v/4L/ZNGLezCEu1L3tconjLmVIheeCt/ax93FoIBYOZMa1Ywyy+x9ziRF/zUApzPcgSck/3pfTtar7LWi86MrgYoSykECugg1iGS6qYcXojGTTYtsDZJW9woiHPmTDZJ1kD5JJ3lY5z74k2FFGVVIBs9jx3A+OdphS+KOsUmPIZikBW3QzXIjqdhzHAuohafLbQ3lUp0ak7UQfdJ76uV0=
X-Forefront-Antispam-Report: CIP:164.130.1.88; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XS7s6VAakKnpqpYq04kyCIE7SCDeL8unf0NrZ4bQ78S1MFLS3/OnfG3AV49tIk7uNNE+aTZWjjoOsDcvfBE0wWFmAhWGJFut4POQTSxBYZCKatK++VxJEQkuputI5IQpGck/kn4mk9MtN3DlMScxCwAAe0Up2HcUKQoWi4WoaDEfiTIFyrVGJSdK40jfCPigY6USwwuM+nqQ3XNOFJWmZBsX/LLYrbsUsPBftlGiCPhD0J7bzjlL0JDfBL2MDH2f2YlvM93AFPi/Cb3dw3wFLZOv+vPyRWgvt2dGIsYkh9M6mFGlmoZbVMz2L6hcQ74POx1HB+xm5/I+8PxCLyNKvo97iqPXskhR3br2JkrE2oj03c/jmXCRy45I1UNcNB4HNQV7hqddAtZtZxTlxY+u2V8Q3z63RhoLWuXMncPB45RMFnu4413ntRbs1Sa83RwG
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 10:18:52.4126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b9533e-693c-497b-c966-08df0a6deb48
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.88];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7330
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

Enable CMD_BDINFO_EXTRA flag for stm32mp25_defconfig

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 configs/stm32mp25_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index 42335aafeaf..e55ca2e3f0f 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -22,7 +22,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 CONFIG_SYS_PROMPT="STM32MP> "
-# CONFIG_CMD_BDI is not set
+CONFIG_CMD_BDINFO_EXTRA=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_ADTIMG=y
 # CONFIG_CMD_ELF is not set

-- 
2.43.0

