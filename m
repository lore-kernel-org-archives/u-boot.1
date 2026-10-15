Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F240CC6B2E
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 04:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B82360904;
	Thu, 15 Oct 2026 04:49:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d0Peia2hQEd7; Thu, 15 Oct 2026 04:49:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 13940608DA
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792039792;
	b=qtFD9u7A10y/1+Vbeibm95NmWbOjxPmztEfJzxLbTGBAaxg3JsW7oxRnVtwHF782Udk0
	 tUu+lmjb/GJB4045zNhPOCIOvfa1t/7dEQDvn+gzNVzbPpvikhLSf7F/rdMZL/1Bc4igm
	 4QvZQxUtXHJ5P6Iy2jqciyydk+0+Zh7/N5Vgt+WInW9SFTlfpKprvh7K555dJorkHWkMF
	 V3UETRezuP47wez0XLr2D0NuHyxl9sL7LcFpT/2ms3ahJ6+nj0oZSMNawuYdm8BPlz+Ts
	 JF0dxaO8Eruu+LZr8X/WI6xX0KgTCb6KE6VJqKdpv6cKWmid9MLU/PDRbhbv4Rhx+cw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792039792;
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
	bh=SS/bI2whAjyF6XBAtD4lvA22r0I6YyQnD5clXtBokAw=;
	b=YtGlmA6XSXxCTk3aQOlelnYc46juqKT9zs4L3lt9JQ8eMyKMWXeKiSLhcaVhnnUPRe4p
	 HqVELX+799zZlcrcMehS3zhAKkFB7TMGm0g7BVbGuM3brCnxqsI6RJecP63AsTvBEQsJC
	 ZgM3AEwbIXSLO4n/FZ2HzHD6oTJU7DkTMmn0NLIyS+ANdTZM3BGp/UDI8rEumcD56r5u1
	 e+mxUiDKCpmVdfK38scnijjnI8dRaFXunlWuMvLxeawAziqau3pEW1dUX6l131V/WGlfF
	 48n53pLcT7TGUabMZQtvKaoUlsxEr7e5YocNTHWgWoVUxYRGmHP1bFJ+mhWe299szeA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792039792;
	bh=SS/bI2whAjyF6XBAtD4lvA22r0I6YyQnD5clXtBokAw=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MnRBFuhWsmOI9K5UbEbRVRdck+qYltjgHOMtBX8HdhmQTxWxGw8uzGSXA5CKJEeNv
	 gkTy/5XSCjjNq3kFp2zv5MR+vmK2MmDsQreL+Grf5LlYKLA3uzYGprBnybM7WBtSnb
	 2ZhSNiivP197jNm2VpYsFtPt0zXHsplnBmYm0tOY8m8Gsv5PlNhcf+wel0z5/dARtN
	 6zIWhB/+cn7aWA97o5VZ+yILmwwsQy692v9ZyFyV87JcCVwPQdTFjSzP7JlaLdmhwI
	 Ta1QTqbaMe5EW9xlCJOg4YVWN/uzyAN9VUPAW3pr3WJ/CgvcPbLOQM3gt7FbnIdQxg
	 7ePY65X5Jw8gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13940608DA;
	Thu, 15 Oct 2026 04:49:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2091BA58
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1259040223
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:49:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E7EVQoQ_7seG for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 04:49:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 103E040053
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792039789;
 b=ADJRZJN4Ycb3+VH0EDNSNwm/9I+KyEdhtP8tmPoyXi1xzPJT0ryn4foQeifyoc25tMdO
 kDPr9e6lz4HGPSvzdBoHT0znpnTJAlyOBnO8apyX0N7euwgJ2xfgbkMxmpODArSCMOQ2D
 el17/+qhiYlS2sxSWUSJlmqgfiFoI4fd0a/01YdtF+WQ5OcQ1XnRPzwWpylqXHCGRBduK
 slJAlIdvOaUYe7I2df6UknjQ+jvew7qMA6vYUEsYuV8jrFYbslpcw9SkkXbMv6ftrkdZa
 CKle2F4hBQclnBQrHbYZJNl0T7cxCslzVH+3EIZGKDAxecAj6hL03ILGjH/4hr1hohw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792039789;
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
 bh=SS/bI2whAjyF6XBAtD4lvA22r0I6YyQnD5clXtBokAw=;
 b=IrEz/Gbo8e2zUiIFUaFEbq6PzCYL2m89krIUfvYNw2fdT+rmQ/ofs5yJUbfwng6QTd+o
 evgp0yuzK3gIZ7xNmbix4Ii0psY1jqi9gGlotG932l0ZczUjh8DfE2vniAfuhf4FhDH+W
 oPxWyXkQ/g87HGdY3/ug81RXHxSMbol2iSGQXsnX0Hgu5MshgONkJ20JV+UrBpGWrlKUl
 2W3gTdGXut5dF0om4ucY35jxnyQolz1/BBOWhsIPx+9DiOP5hhWBSLur/EmnVqOyF4xT9
 eVI41Q9DdE0q7oz5liVaHJ/7YjgtT4+AlPJ6HOs2Dqjn+uJitnk0tcDHCqk8kWmxGqw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Q7CnSEYu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Q7CnSEYu
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 103E040053
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/K3RfMara/2m8rMFKheLgkeYHTREDF5kyugqNgs7psydEcz9wVrDqsQfmLPsXZru1g2e7ScKyHa8cJUoWZsZD1cgG3+nqA0QYGrhimigqjFjqWWRm+NtCuUv2qCAeacwz4bHU/1KECe7vnTz39TrXQuDobgoSF0yO+TmeGEzAsYic159rWaHdI/zU9gfm+biUzFLqMf8TpNm2rrnf4xSvtZ9jGhiGa4zCiMQRySxh8XBVLAebyQbUVWVkGIE+9k+WMf1CXcoPZIJc/8/Kfkuma+q1Kbc1FN2KE0IMg+7enizXqFNXcOa4LtBmF68pfwSi5k7tiILN5z07DY9rGGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS/bI2whAjyF6XBAtD4lvA22r0I6YyQnD5clXtBokAw=;
 b=mq+VpRTt/hDD5+TFBVPDtVjKQpojpCVqTjP2xP7i4T4HWQp3rWim4q5950cFqQSfYH2o8j1ozeBCXsjAZsbpew2QYDzC8kg1LCXbSwa/j22AHEpQ9LFOGdnl6Uh5qZUNn8fd9A6XiqKx7bgCHrbXL1oKHyhXRX7u+wcPGBdQDEe7X33D/8BoT2f1HG4GzGWB6U7zn7FzGXpajaaGJShGM2ZRIfj+Wwgro3jlcXL2AAfF91F8DG94KgPAyjMinX7GMY4NARRzZaHsZ2A0hHzx83H/2zC+xVdDdLvyofYa31xvR3mvdrlLAb6q/6SU7cyqI+VA9paOj9vewaQmP/mmEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS/bI2whAjyF6XBAtD4lvA22r0I6YyQnD5clXtBokAw=;
 b=Q7CnSEYuVfDng9rXU3Ak/FbyveBdTxthQwYOgOht7CybppDFb319nvWL47yUFKkl53wyzVTvK0eM1uUisYB5wDHkc1HuR43OrdNPoTmK2yf7bCvSDa15Fswi2TlrBCjy8vOx+fvV2djHjFg8Pzih80MmZqlTXq16Y70BtBF23iE=
Received: from BN0PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:e8::17)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.16; Thu, 15 Oct 2026 04:49:43 +0000
Received: from BN7PEPF000000A3.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::62) by BN0PR04CA0042.outlook.office365.com
 (2603:10b6:408:e8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 04:49:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A3.mail.protection.outlook.com (10.167.248.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 04:49:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 23:49:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 23:49:32 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 14 Oct 2026 23:49:31 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>
Subject: [PATCH v3 0/2] scripts: dtc cpp flags via response file,
 GNU Make 4.0 cleanup 
Date: Thu, 15 Oct 2026 10:19:06 +0530
Message-ID: <20261015044923.206217-1-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A3:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: c870c367-3060-4952-6bcd-08df2a77ba3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|10067099003|56012099006|6133799003|11063799006|261009223027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 91ZEtdHZyDZJsCGu/K7dUl8YnNYauLfiOmNANJcoG1e0NcyUXFeAZA9emPESLbrKQJITSsPCMqfhwvn4whpPEHk69YCOIzJ+3vICLCqaCkf4RgZOVjNmWoTQWjx/P6B9OphZtLgqME7qghoOWS2if48ww51Db/TS2Ts//RBAUkBRzHiLGU2BErEe2E7iV3MM0N6OBYo3yEPIYA6gevFOoHq7Q8DBsQg/QkrwKuisHGHnCGRFLOCo97xQi2yHjoZQ+3N3rqB6gFmJYwjM+51n+r6RgFsDo/NoOUDKrE6E66BMOM/nb/Rr6nx1+AvEoK4M9Ku1Q7RAX8MiqDY6S4vMFrI8dRyBzcge7CtMYa417Q62WtjPgakVIp5/k1ufP+q1bgScYrmKjtFqm6wa54o/dqDDH1381glXS036ZOOnurPU8JUDHIHAsOjaBonXwrLGNwxQd81dvNt5/lVvSdI22K2vVhOskqiQMV6MIUFrvMSuAwYLveEIQXL1c3Eaz/ASBkIOPtHeT3oBbD6IdYeIe9E2IPY9SOmaZjr0PS2Qqg7S51DvDl+dNE04ntr0gteLvTm/822f2UO+DLAzEOm/+Ws0z/QWAiZzwKwowYINhEY6Z/TWZhJGuKmy9J14Uc6GfLN2A4nGeJUFK+0tNPuMi+hFyXguOf8OCdogOHHQ99etf/zKaeKftT8D6I4vo4NqQAKHugFOVqhXzjiSQH9n2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(261009223027099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 337g7KILeYxZkyjC9zNL1OMDW4msByhAuThfKsllU4xdQfRoBRlBquboRfKr79ReRaWZ0ZTG8wCp9MXKoxJaqVHgzpL1Q9xigj3Ez8X8xukcVcwis1uzXLq9dKoB6WfTS0Tyo/y/b44iC7EsCTa341Lt+50295Hu1hGOlgSs84uAIy+qnkmhwlwOjzOmFxir5MO2xKA4apy34IZG9BGCOz5eVJQ8oxP4aiZOJX0FE/v0wue6qZyg9Vcd8jyBJ9mz9UqvDg0i/G70Gx4B+QaxkBPgMxkbXoJ/0NJa13TjcA3AdBd8SAiZHNEyXY+NGmvXuKoLNb5NTQ2+QKdi3frnn2GZ16MWIo62+FUHhTa4UtoXjizrhKFPSCniZGpajG8UPvA1UL24bNTUYB7m9OLTRXrYOEduxDosSrIDKOZSgz0k17QqPaJi8kDHk0pu4U+E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 04:49:42.3691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c870c367-3060-4952-6bcd-08df2a77ba3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285
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

This series raises the enforced minimum GNU Make version to 4.0 and
fixes a dtc build failure on long source paths.

Patch 1 raises the enforced minimum GNU Make version to 4.0, adding
an explicit "GNU Make >= 4.0 is required" check to the top-level
Makefile, dropping the now-dead GNU Make 3.x compatibility branches
and documenting the minimum in doc/build/gcc.rst.

Patch 2 fixes a build failure where a long $(srctree) makes the
HOSTCC/CPP command line for dtb and dtbo generation exceed the
shell's argument limit, by writing the preprocessor flags to a
response file and passing @file instead.

Azure CI was run for the patch 1/2. The macOS host-tools job
("Ensure host tools build for macOS X") and the rest of the pipeline
completed successfully: https://github.com/u-boot/u-boot/pull/1048

Changes in v3:
- Swap the order of the patches, so that GNU Make 4.0 is enforced
  before $(file ...) is used.
- 1/2: document the minimum GNU Make version in doc/build/gcc.rst.
- 1/2: updated commit description as per review comments.
- 2/2: compare and save the flags with the command, so that a change
  to them still rebuilds the .dtb or .dtbo.
- 2/2: write the response file only when a rebuild is needed.
- 2/2: also use the response file for the DEVICE_TREE_DEBUG diff
  command.
- 2/2: updated commit description as per review comments.

Changes in v2:
- 1/2: add Reviewed-by tag.
- 2/2: drop the Fixes tag.

Suraj Kakade (2):
  Makefile: drop GNU Make < 4.0 compatibility code
  scripts: pass dtc cpp flags via a GCC response file

 Makefile               | 20 +++++---------------
 doc/build/gcc.rst      |  3 +++
 scripts/Kbuild.include | 17 ++++++++++++++---
 scripts/Makefile.lib   | 15 ++++++++++++---
 4 files changed, 34 insertions(+), 21 deletions(-)

-- 
2.43.7

