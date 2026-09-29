Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAC4CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 13:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2E9640735;
	Tue, 29 Sep 2026 13:34:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wj2v4-d00y8g; Tue, 29 Sep 2026 13:34:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D263A406A2
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790688853;
	b=XAIEu9L0mQfm6AuC0TUn+8O2LvBTPqmjuQEyDIVbjtB/tce23wYupPXAyn7P0jORQ0qB
	 4nJko9pO/EkncwYyVbqj4ZC+Hzyzb9i0vrPvW5teKL2777MwVgwV2sKZBexYnxwEJRuaq
	 2+ghwvjE/tiwZoX+sHxezH0++2xncGhvebzc4vTscA1pik5trgmNS6vZjC4AdNYeyDvGS
	 1CZe9EUAhbyXI5Mbwtnfbl/K1CLVd1Ys+EhxPYujkSLVuwggdY9e39uooIIg/xPm2Iae1
	 ZRYQBX06o4c85usn651eiwdwfL9Xs2ZT40l4R5ah+FbeLK7kyYVJaFxnBQ/w3k8smIQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790688853;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Originating-IP:
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
	bh=7WF9+3iD1n10wPiKtxRwnPZEWlOZkffj4emHZ4OO6F8=;
	b=lkH1L0ZW9vqfalRBEbC4TiqB/NqVkhpQmChFbRFt5Clc8+d4u2oQGZFe4PTpZEtzq8op
	 2vfXcfTuJzTlr7fMoOxNXK73HGtUgRR1dcQ2XTutBjw264fXDDi3IzKlWfLx31yGEbaee
	 2KLRKrFgtfDr8NgCG97z6ux+irDPHs4TgOcHjcTctsZPiFFuXAv5bgwEyWmOCKmVDSXOj
	 we9wn+UtU0COA3c3KpzUMtLx1vfPFxLoC+FLDVUsGAkHepIJ3kosE5RzPdudAu7DJ/wDG
	 bob3tJ7bSMII/B14RkZn6UtX0S+n52tK3owlOu3DuN5PwkEeNP3vCMhSx2zflB1VNGg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790688852;
	bh=7WF9+3iD1n10wPiKtxRwnPZEWlOZkffj4emHZ4OO6F8=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uoRbo6zjUMZk1ogP+SrFnnQ7qG7D3NYotRBGoCl+A6dnYiHw4xillBc6cSzEwl/hH
	 aX9+JIrr7nq5EzXzQz5ATFtqltHB2zdnjJ8L1pNCi/3v4jJmKW9ZWTpTiJmsNlhov7
	 oaTbi7M7khv7g8tiBJljH2AKbTKyGg8cyn8eQTlplaLvdKo75wJYa/3zwxSRGLkZdN
	 3ePLW3U6QHRh67HaBDMWkOisDrOGxcV9EZ3/8EKXA/I4kZ5oCjnp8GBuJ3oR6/Na2O
	 2etlLq6AOw+xKagBCEuIXznTc84pt0TdOmnaJa5TMKuXYtfL63HaDQGkLtPHPO3UZ1
	 TM3CN3VHCbUJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D263A406A2;
	Tue, 29 Sep 2026 13:34:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8413734E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E0748087F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:34:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dUSID9qQjq86 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 13:34:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5688380872
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790688850;
 b=AeMD73u3D5+UP8x6+tRLoUsFme6SZ6hWTr8weG8jv//V5nC8lRpr/lXG1+uLb8JrS4RJ
 dTx5r8CL3poyCFZ9DCLckzn/b+q0YupdtaudqEpYSGi1HmSBfyiPSnlKYslXW6nTbkOxD
 5zdItH/ddJ4T8KFG45xnk6bMQEQcLzDzy4s3mGgasb3j/zESTSs7P09qtMlaoKjNdqhe0
 I/SzOSIc4SQfdSN2NuxN1S2CBPYMc1Ivf9tep3qpSnfdqPn64B6vjhnq+ohnyxMFQZyzB
 +EMAWmygH1Xl32cApyi1MWuIW0YS13LV6vocy0O7JKgNirGpfIn0eZ1S5iw1eU9Lk+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790688850;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:X-B4-Tracking:X-Change-ID:To:CC:
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
 bh=7WF9+3iD1n10wPiKtxRwnPZEWlOZkffj4emHZ4OO6F8=;
 b=GdaropRjjXnw5n5XM5fR8UTqVpxru7VpucCqei2YwxMq91+ko44cvLRVx5fDrLO28LXn
 vjy8G3yKkk67yUDtg/yPknPz+aZotH3R7EvUXRZncDj/9zhoV89FLRdQpCLobKIPNrmu1
 ziCdL4U8SeXTBSPjlx5a1xPuga3fqno6fVdnXCajzebfOD5deSfOcySbOToF4rflewGew
 Vu6LYJMvIVdpnAbGFcXAbNpSuPc4N2cyorwhRqJtFmzdHTLIqxu3IBd2hPqt83w0i4LXq
 o2OmLv/f7JMc3LUKtMNWRnBZun495swEut0ublbzhdzCaHAAUGcXLljEMnIyTidi8CQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b="FLc/qmGv"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=FLc/qmGv
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5688380872
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:34:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7rtINtRwp8alb4+/Z/LdXV5b5gkSZX+28SWpO4ljLxzhqCGKp8yFT0rWf94S829Y9Xbur21i59NVLAKCbJtLpoOLYhirxddZbJyqkyPcJMDxGPrJsEAyonjhp4omR5C9vJ1/vgmIxEMHzPW58T4uZEkqIwCVsaqY6XTy46BBDkDHE8OPLXc2qP9ys2i7/sEWSUNZ94HfmGW1afBKO5kWxg4NmIxyi97itFIz3h6PfkBoGDnYJ41+DNKuCAw8moJNsm2oGFIQQ3C0zv/foAg8g9HYg89pNvtQJg34Hw3d262cG7iB2s1sKtAZ012TZtkiypQwMA9Ag072tdyoYQu0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WF9+3iD1n10wPiKtxRwnPZEWlOZkffj4emHZ4OO6F8=;
 b=JuO2U31xQkipJFULWSv9Fh11IPyqjLaO1cez11UgObsq9C++8JXUXD7X465DY4lJ51/xBGiIwJwPHwUWvsxlkT9nd2qUrZYGxqPMJWEXepFVK2tOlfrhSxgZJG/vOt2O0LVp69Zzjt6hPTpYgKXy3TcYFB8Mp0V0AWyhhMNASrfMacLiZR4S10oGIAULmOKEMx4XsgAsVBe3bX9W+lyOcnBA5FbbH5deoVdaCtYXnE1+vl7AnOvw96TSw0A8SmEVIZWZfO5XmJoNOyg0i2J0Yxbp4owGyvX4VhWlDs3of6ClOa9MTF4ccxhhDjMsxJqaRgDrWL5tfJJn6lw9UAFsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WF9+3iD1n10wPiKtxRwnPZEWlOZkffj4emHZ4OO6F8=;
 b=FLc/qmGvybuv96gBH3VtS+FFoGKUCie0u7AUDIyFQK90iyzfH52cuXjX9zx/vAuFlMRUEWOSS0Q0UWfwGm8kn0u0F7WO7zltKg3qADvcZwThRtTbJMOAu1axHHEodZAt14mIbxihK+4j1v1hC3+FpLNTdkkxCnm1N0yuMkeRS4VyBLuHldrKqVrYVMdXYVtdjgN/9pifjREiAUv3xrC9+8lEu480iHwzHVuTHHUMK8dBAVfgofNKsXBx3Au1E/3S4bMNBE3R7KEt/S4NJkiOYQ7xA2tLBlBYW1RjSGRmcmnaRLDNPoo4HsRhgqH3kmFtT2w4/UuR2Dx0eQwLbruQTQ==
Received: from PA7P264CA0332.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39a::10)
 by AMBPR10MB9779.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:766::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 13:34:00 +0000
Received: from MI3PEPF0000848C.eurprd02.prod.outlook.com
 (2603:10a6:102:39a:cafe::85) by PA7P264CA0332.outlook.office365.com
 (2603:10a6:102:39a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.26 via Frontend Transport; Tue,
 29 Sep 2026 13:34:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF0000848C.mail.protection.outlook.com (10.167.240.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 13:33:59 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 29 Sep
 2026 15:40:31 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 29 Sep
 2026 15:33:59 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Tue, 29 Sep 2026 15:33:55 +0200
Subject: [PATCH v2] usb: gadget: f_mass_storage: Optimize CTRL-C responsiveness
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260929-ums_increase_ctrl-c_responsiveness-v2-1-ec4220786c81@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAEK+u2oC/5WOQQ6CMBBFr0K6tqQtIOLKexhCoExljLSkUxoN4
 e4CnsDlS17++wsj8AjErsnCPEQkdHYDdUqYHlr7AI79xkwJdRaVLPk8UoNWe2gJGh38i+vGA03
 OEkawQMTFReWdyaCHsmPb0OTB4PuI3Osf09w9QYd9eTcGpOD853gR5e79FYySS14VmSiMyHPQ6
 mYcUUoh1W5k9bquX1N4vSPoAAAA
X-Change-ID: 20260917-ums_increase_ctrl-c_responsiveness-0824bf3ede7b
To: <u-boot@lists.u-boot-project.org>
CC: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, "Tom
 Rini" <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848C:EE_|AMBPR10MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c939969-704c-48e7-e590-08df1e2e51d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|11063799006|56012099006|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 3es2BzV4t6+71agvLzR7g/PsqOpPOVU+hpG8jKtKD4AdT5UKY4dBrFNn7gVfxN6CCy3D7V1VoCwOzcPrPgmFW+FnTMkazK6ElxgkzjkMa3UkEykBLoudqmed6HxHpmpSu1h/mhQU4fQiZSRmQ9jBAChfbRlkycFI2Rx6x+dyjmOnnVCynx+VGM252i6g0utDBtdRoH3nEeYy6HPH3tieAVfUVE0Rf+IPwFp7CkXQZt8drUSviCHU5wvUIgHfUFkOJFLNVHypNZJp+f0vx46di1sa27HpMHG+/s28P3ylVG4THCGBM+DyyQjpeRMjMlT64t6pMyhKeYuPu22QvqbDEp6OzauoMLSv1OVw7v84Wtp+E+eu88dgXBD0iL4RDZM7rrOBLmPE1XitMQFPVSnfptOT59qXGkTXRKrkoaY9QjD4K5G2jXGH+Um0GuoBqr6mlJFP4HoBN/gmzeNd2N3DUV96QA1EFwgERk4XF018jq/JznX2n8y/ET3i/EeyoYy/L5WzAmy0etL5cfOkoGhYKK9KXyoMVwzYe7lxyGsNFNpyXTY5uDPHb/TMpeuN+4QVGXWgCb4tggkoAjYv7GHRbgLEl+uqdyRZRNgXrHXOiQtUKyCjSq+lputSLHXAWoyy8DCR4lKvSGu1BR7M5kpJ7A==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cW+ynjyYTg733KSOq7WjcZNpx5FRCKVP2XTc12PNsWGiacq4ZJCGh+5PBAqfb7zi2AjAHBT4OPqg/IPY6x+z+jhgolm3GI94x1DHj6mRsqNAqlHQIYMrGYljfCcgSX/HI8U2qJZ2b+kciNGH34LZumFznq9v89GOdGLPyeVTCIMjI0a/9a5J4XN1CFzS1FnMI6dUJ1a/3P2BLxL0y9wFdoD7QVAafY6JrPNPsZM/jjj3bMlShWDa1w/D07nW9y6lXziyjFrVlZgrL7scuE62iOrVcqKjB2l3bBKUF58aOJjjJOV8u51wH6dxgV89LjHXSFgEEAJWUrNBVq/1h5EdNDZOEM5x1bpqwZ/I25eX62aCWLSSy2P+Hv5yCBIN2COm1aZ4hdNbRB5uGhjH3QG8mpcCj1cUFIBBksPKPW8EpUPgmQRWDRcsO3BDrISUpHOK
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 13:33:59.9712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c939969-704c-48e7-e590-08df1e2e51d9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9779
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

On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
it may take a while to get the control back on the console,
sometimes around 1 second.

By removing the if (k == 10) test, it increases the CTRL+C responsiveness
(around 28 ms between 2 ctrl_c() calls) and UMS throughthput is not
impacted.

Tested on STM32MP157C-DK board

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v2:
- Decrease ctrl_c() call frequency to restore ums throughput
- Link to v1: https://patch.msgid.link/20260917-ums_increase_ctrl-c_responsiveness-v1-1-95305f044ec2@foss.st.com

To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/usb/gadget/f_mass_storage.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 7eb667c130d..96581792031 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -651,7 +651,7 @@ static void busy_indicator(void)
 static int sleep_thread(struct fsg_common *common)
 {
 	int	rc = 0;
-	int i = 0, k = 0;
+	int i = 0;
 
 	/* Wait until a signal arrives or we are woken up */
 	for (;;) {
@@ -661,10 +661,7 @@ static int sleep_thread(struct fsg_common *common)
 		if (++i == 20000) {
 			busy_indicator();
 			i = 0;
-			k++;
-		}
 
-		if (k == 10) {
 			/* Handle START-STOP UNIT */
 			if (common->eject)
 				return -EPIPE;
@@ -676,8 +673,6 @@ static int sleep_thread(struct fsg_common *common)
 			/* Check cable connection */
 			if (!g_dnl_board_usb_cable_connected())
 				return -EIO;
-
-			k = 0;
 		}
 
 		schedule();

---
base-commit: b4ac71db13a33c4e6532c60a781ddf34b7f4375a
change-id: 20260917-ums_increase_ctrl-c_responsiveness-0824bf3ede7b

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

