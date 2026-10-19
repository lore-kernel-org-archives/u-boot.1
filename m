Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EEFCCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 531B64069A;
	Mon, 19 Oct 2026 10:40:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lK-gOevX4gYN; Mon, 19 Oct 2026 10:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B7227406AC
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792406410;
	b=ZdaTSbNvpf4bz/P7jeKPoxOUjoNyXOdD0umzPrUbhM7V1xG9hJLuXMwwelmhjynA1Wmm
	 rNWIOUthKTVeZeBW0X3aniVOk1AgBJd3D7P7LOQAHCtZ5M546uguf06jPni5KXU1jZgPB
	 TauCsIUsjRlJ16YPW6fdNVQ8BQRFFYQJu3OzO0SeLyZYkBhtU4xq3rZgGw86zqNXji73b
	 C3ShDxC3eHftIR/nTbBxES568Lg9pYQco59YatSQMevsqvmHVNX6hTz0JJ5kRdz8cUP95
	 mYpbRhkJgmEPALsFIjDTZf/4tzqLFlxeuXVnmkPGMUAaDvbtTOTbc9hci7G6lceFrPw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792406410;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TSXECmUAWIJ1FI9PaXUXHzznv2bIcwNZDaut2WOTzbE=;
	b=LMe7uJJghhbcIGe8bu06KK7RiuH5YcMTHrYPGFb2inMWPmoXUxtnWl3wdPHPQAeoJ1gV
	 a1G8b1VVd6d/VtAxEEdjJkdOc0Isj2WeL90+Mflll2gUecaM8yW5Fo6UQdkBGhN0DYopp
	 2Y6INSp4P/v2p/DSMG5mrkbvqQhWsYucg6qVopUjlAu2VMdxmVSCFi6m+xyNjwk72ebnV
	 PPwdENPeQp/ASFmU/+0zgmtXYze/Uv/pbvw9GRf6TjGSUkiz127zEoLI8svmVD1Btd6Tq
	 KmMaDmwDP77FHwtyE0LrhkgQ0HnLcWjgzxdNipMlWtQ9+Qp3O7Pv/7Cu9s9Ew6eAc+g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792406410;
	bh=TSXECmUAWIJ1FI9PaXUXHzznv2bIcwNZDaut2WOTzbE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eXGnuokfp6VAQPqhDvsc0UtbBxYfrTfusa8KYY3cxSLzr6HjHMdbCqE5gdAQScS3c
	 o5uSF97N7Dcz1k/hQAxl3Cx5Wn8S62zzJRN+dtE+f44YZ2Xp6NEnJrnY+dI1/QpdrR
	 knWLO5y3RIchMSaEIsaBt0JuECO0VW/jHVwAJUzoHvTIxFuCqHbTxaVCiC/nGta9yD
	 Zz2I2FuDf1dmArp+nQ6XbfcWfkH0dWsPStv1ZXvZRaDG8ZOnEVSNB294C20PX2pt3g
	 3DncM/eP34IHerKQKWNBzLct735rVOmbx1uTiASC2jX9CAm6kpV0DlX962N3H/50MW
	 QBCTUvq9K7SQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7227406AC;
	Mon, 19 Oct 2026 10:40:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E0B0723F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE4E380F84
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:40:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YQWQzUPjR-mI for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:40:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4367880FB4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792406407;
 b=Znaz9zqYByTB4u7oCHXz/Ov/5IYop0H1aTlSZfgjvrnlsYlIGzEzFjAbayTm8nwDqWAw
 OiLaznhY2UupFnaxkSGQzHPQ+ZrttCw6ekuSS28LJwrzGaMg8GiRjWFe4kk2onXnoEao3
 o6h4HH2lftI7HgFQm+qFdG9TqGD80i8su2pgHkrKS+333x4V9TB8FQ4yfRlesl+Ge1jDQ
 sW7eoxwVMsLXjKsxu5+zCU3fJWrM651fKFzx9LGM5Wf6cuyqG7oScQktOpuhhfiM2W0VP
 FINgzeCVbaZpnPwGQa5TThxS4TCF3xVQzxg2onZaI94qMqpItqnewkCVCWqt5cxlYIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792406407;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=TSXECmUAWIJ1FI9PaXUXHzznv2bIcwNZDaut2WOTzbE=;
 b=A4hP2b21V61cSMKV+Fk23ERf/Fjx/02hXyVHsgnzzRRJwPmMzgComuFfNCsSbEWYF6zL
 bIMbr4XePpgrgcZYP3S9xUsBgk/RTji3Y2jbbPC4cBGpc+H4/QbsRNcWtbFgzmj2wWAQZ
 bIinsDTIq8Do7UOXR++U3j2HVus2598XYNgYrvOVzS3S9PoqqituwuWraa/OYLUxnaggR
 7XzG1OlsdD0fbGt33QKFM49Lz6kK2ftHfiOAjFIKDyzysgHizXJma55mXx3w+tNnXRhJ9
 LorZbZXdVfbFuGc13vLpW6sFdIRhYu3HSphPYspiKRk4It89CswwXDAkXFWlMLRe7hg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b="O/KZP4Dq"; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=AXa6kirN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=O/KZP4Dq; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=AXa6kirN
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4367880FB4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:40:06 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69J8MxXA3814258;
 Mon, 19 Oct 2026 05:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=TSXECmUAWIJ1FI9PaXUXHzznv2bIcwNZDaut2WOTz
 bE=; b=O/KZP4DqTsSg470ttRkyQm5Gv5Uf+qUeqP/eTfZGsYyhA1guh1z4WUtDr
 kmZO0D1F7otK4dIJI6QFcvtKfS9JTWNtjlVYR7/0dQdxlT95koSLXBk0iOCsspf0
 9jXTCK5V0iamDrOuFHXjRj/Ok8XHK4rKdBTCSfELk+YU0r9ygj6tjfdA+SHuVXIW
 29fchGaAZd/yOw3Nba+UeR/LLKUb2hoWc/soiLwuu4A/6el8zNHGRSb4iJO/iErc
 gNxfwcCOW5w/S8eel0QvKU1HAA6NgrXk86a6FH+wVPPJeZERorxIMlUOt0lE+Xwq
 JfhLA2AE6rJgO53VVferhIbSokC1g==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by m0380145.ppops.net (PPS) with ESMTPS id 4hct1jn5dj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:40:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DG010SSCvMiLClTMYtW1BmWw3CmAv4lcJ48rCpJSkuYORfchqluXah8V/d4w96PyZdpmKa56Q6SEP2s723QEq/jzjvWy3SjLbxn3hynIRghD+5UvbqNfuwP7poHyhLEru4ygtQZTS5zouNeqjWSdJco9O+fXgaJE87OXykZcBe+u8qaSxZfkFWjtKB5yy4vviCzfWCR0LPBamxRo6lL2GmIgTGNmMQxVgu9GfA5LOVy8/e0uzS/rU8+fItNj336MZr+o6nD5hwdo7tWn7yLdNxqZnXXwzU3zzPrutHeYVNvA0B7wHMUfHaRL41iYAD00z6nHNQ/F2wDAnZGcjWQPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSXECmUAWIJ1FI9PaXUXHzznv2bIcwNZDaut2WOTzbE=;
 b=DIEXc5E421B3Ha+8rQ7QROXKXXDIB2vfgnOUDjv1eOiPf2/KnRFNV2EuP9e1I0zFuChqNS2fIAz+wspkHkxzDK0UF37N5wMF2dOGQY/865PbV26KZtwOLZK1qNvcncgiIHEYneSTMZs2QMCOC25JWjkfaxTUCLw1tVBC6Eb3AE5YAvwzggEY/icT31MlEDDI/rOOxleUS/oDkHTtCBqMcK5HCKjL5JMuetZXOR109QtaJx6DMEFU8XBc5duDfkXilTms5GOyJTQvZ/xUy5KyffUm5i9OM9m2l8x+Nh983L0HBsC36BZEq7CBfg29vlKtOknF9e5oTcVIICZ2EyWQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSXECmUAWIJ1FI9PaXUXHzznv2bIcwNZDaut2WOTzbE=;
 b=AXa6kirNV6+/aohqtPAekFHOJF5dfaLq2PjRjCL9it87YKOtwRnKK76blShDtLoKy7TqO1xTnJYgzVyNPiNay1qiTybtNsp3LA8TeDgpCEMd0hksMtw7qRPhfx6RyVskn1wBMqMhG38cipCylQKQPw0HeP7+dgs8Zl8aHTz+v4U=
Received: from SJ0PR13CA0220.namprd13.prod.outlook.com (2603:10b6:a03:2c1::15)
 by PH0PR10MB4406.namprd10.prod.outlook.com (2603:10b6:510:34::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 10:40:00 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::82) by SJ0PR13CA0220.outlook.office365.com
 (2603:10b6:a03:2c1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 10:40:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 10:40:00 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:39:58 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:39:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 05:39:58 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 69JAdgTj2629975; Mon, 19 Oct 2026 05:39:54 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v8 3/7] binman: openssl: Add boot and load extensions to x509
 cert
Date: Mon, 19 Oct 2026 16:09:38 +0530
Message-ID: <20261019103942.2497201-4-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019103942.2497201-1-b-padhi@ti.com>
References: <20261019103942.2497201-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|PH0PR10MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfd1323-fa0c-479e-bd74-08df2dcd5374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|6133799003|17002099007|18002099003|10067099003|22082099003|13003099007|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1qx0sLyIknnL12X5PD8IEiNdvLZ/4F5ZHyk+fGI51wnZ3or+qq8rm0mrZLJq2bTFB7i0doOVsIxw+Wx8sk1IkAdjqCvR/u70CnpG8t0av+JS2siJ+NlPSC9913izQoI+U1Q4mrMXPxdKv2ao+YOPxSadSP5OgIvW2+tz+mqzZMxAFCSgdVEsbqpi/2Dgx9FTRzVI6c8wpGHfOEyUfKF5B7TYvKaEB+AJDLB3cxVme2Ds77Fk49I5laZNyvawrRwKTJxmuNBPBQgpZ1RcuTH8ZZRSHV63JyKORyR6GQp6Z7NCi7jc4FDgMwPTCMbAhenIJw0hKXgPDXX+iBghY5dY8jFnDQn/aREGMOOPgXUGw5QfVodpXQDVa9NkucsWuxfG8Zk0gTKvGSMLcb+bSctCx8iJ97jrOv3NsMWp5GtvOUTTcSzzH3Tk1/GVp34F4cpIpV1ZBOWQQNYYESQSaaH8IQtyrjKNpMIvL+BTe8LQsG6gu4yUZH+31bZXt+y1B/oCPey+bHW0VB7KNzOptySiP5s8VA6mt/AZUMjYzN//104FIZv/9GFQbaEkQ31ZQInhQD/TFCCF/RwoHiFqEuXqYOFlJg2fUygWmTJ3Jh2Lb6cWe9cmhwVOTgSSArlBsYZr7pfHrkB0GtYgP/lvBMg2mA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(17002099007)(18002099003)(10067099003)(22082099003)(13003099007)(3023799007)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CUz6G23EWUU2m+4ENuAVsRsHAqp4zk7L0J/fE/rHsg8jm4ppwvoA83IQEWVTNNgYh4++UFXZkrQHO5UhtM1YbFURkjX4xKsBGFB8oBZ2JfVeX9b3hLFsVOdig5HsdfUInxrc6xrbMQoN18saLJh1uDfORuSyUkjdNwfA9y8wP0FmT4arywZDXjTZDEYUqbtGvQTh3bEczmSoeeCmCBbQLPlId6zZncUFJBu/pQdhUg5AGI1ONJZ8u802nht+0jYCvnoKGzOTb4RLnm5qL4h7fREKxls9keY17kgqunpqEoH5WB3FWzTkHBRg6XZXFD59H3XSHzaR2RffqzUQDIAl3yXqZSLCUZN1AXZgSywzKCjX7wZMbMsSgSPKk9uKwasiY8fMTCxiK+HidhfMcJHpfL2HH9Uzio1cBDUhG5pMYhxjpgHMsm5i/gqKFtrZojK1
X-Exchange-RoutingPolicyChecked: WzeH1SqnXjafJIlZYC/9pNo/IBq/UoZugMJ9gKmoambmBtQnS7NKVeGd1VR0Xw+Lfdfh3LK+Zp9SrlpmkQoVH8vopVHYrD5exPvKvpahL3y6nZZeXgJb0mda2+jJK/Q3oJYG4HCZVZHG/8nBLeIP7ztjYO5i5jrI5R2XH5EVfwKFgYhzExzRblSv+/WCiojfrYyNaOQZZVBvUTpebiyOkKuo6cyLbU82vL4TJ9hDkWqP3xEVhjpKx6AfrYJG3kq2HbxvwWdmX0Jbq3i6XI4Cjr89bk88oNV1cYaIn6tGQ7+wpcTR5pojj5l+Rw3y6GVgEl0UejlKv4EL1APWtbEKPw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:40:00.0264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfd1323-fa0c-479e-bd74-08df2dcd5374
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4406
X-Proofpoint-ORIG-GUID: 4nZsXqH1GFASI8z6b0sIA8u5_qruTh1X
X-Authority-Analysis: v=2.4 cv=ZN9CCn7b c=1 sm=1 tr=0 ts=6ad5f384 cx=c_pps
 a=VtjYC05bhoYYzE9JtrBllg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=voM4FWlXAAAA:8
 a=cm27Pg_UAAAA:8 a=vBQL81K45hsBuQYaBbAA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfXweB+H8EKQMrA
 BuEnz7d7Z+hwzpD4PfGXAMrOxOwMXP4vvoyfRvM2pdju4BcYrTskbT3BhD46P/8Ieqxdy/nuzCO
 ApuAcTksZ48Lf/89v+Eq5ozDwGzz5q8VyB1m7yUFSkqT44HPPA7Y/oUECXfA4nQPu7kwcHWd+0l
 co6G8nfi8dfgixznaGOMNPd1xOYkm9qzACf2J5VeuC4xY3L+YZael6n1/E+baAd4ZFoO02S3CAQ
 AE4pUtPxvegIi+VPZroNc+Fkz3giqyg8nHbmlyrJQaLQXhRr+OhRfnyGCh2BOjaNFuJgdKE6mjy
 yCNLeLjFCPEf5yoaPGIq7RK8tys4xtJV29C0OJeol4UNpbIsJv/MWqRCDoAed8oRv4si1DJ9YDn
 9pL4WlaRgqwYj6M+mz6or/B3fze4zSHS2T4UpW3/bUad84/MDBIRmxI1kJRz/r1w+mPtmW8M4v0
 3lTM2usCeRVhmTRyrig==
X-Proofpoint-GUID: 4nZsXqH1GFASI8z6b0sIA8u5_qruTh1X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX8YSoVkRnKBvY
 GeyEXDPTXmV6dDRY6mBXLNeOZcI6MGtpGhMKFE7Otq18zVU4caAHoVnOMMDWsrx+o0fcK5wcgPg
 mwx6kK00ZYxs7LEhrfvmVTo2KTRmnFE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190042
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

The boot and load extensions in the x509 certificate are required for
requesting the secure entity (TIFS) to boot a core. These fields are
defined in the binman node for each core that must be booted by TIFS
and must be included when generating the signed certificate.

Add support to parse the boot and load extension properties from the
binman node and populate them into the certificate. If any of the
mandatory properties for an extension are missing, that respective
extension section is NOT added to the certificate.

Add test coverage for the boot and load extension functionality in
ti-secure certificates. The test reads the generated config file and
verifies the sysfw_boot_seq and sysfw_image_load sections contain the
expected values from the DTS. The negative test verifies that partially
specified boot/load extension properties trigger an error.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v8: Changelog:
1. Initialize boot_ext and load_ext to None in Entry_x509_cert to fix
pylint errors. [Tom]

Link to v7:
https://lore.kernel.org/all/20260922084536.2477291-4-b-padhi@ti.com/

v7: Changelog:
1. Carried R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-4-b-padhi@ti.com/

v6: Changelog:
1. None

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-5-b-padhi@ti.com/

v5: Changelog:
1. Log missing properties and raise exception rather than returning
silently.
2. Squash [PATCH v4 07/11] and [PATCH v4 08/11] into [PATCH v5 4/7]
3. Document properties in function docstring.
4. Update tests to check the load and boot sections contain the expected
values from test DTS. Add negative tests to check it raises an error
when some of the properties are missing.
5. Add R/B tags.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-8-b-padhi@ti.com/

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-8-b-padhi@ti.com/

v3: Changelog:
1. New patch. Add support to sign HSM firmware here in U-Boot.

 tools/binman/btool/openssl.py                 | 49 ++++++++++++--
 tools/binman/etype/ti_secure.py               | 65 +++++++++++++++++++
 tools/binman/etype/x509_cert.py               |  6 +-
 tools/binman/ftest.py                         | 45 +++++++++++++
 .../test/vendor/ti_secure_boot_load_ext.dts   | 23 +++++++
 .../ti_secure_boot_load_ext_partial.dts       | 20 ++++++
 6 files changed, 203 insertions(+), 5 deletions(-)
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext.dts
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index b26f087c447..39ea4a51356 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -82,7 +82,8 @@ imageSize              = INTEGER:{len(indata)}
         return self.run_cmd(*args)
 
     def x509_cert_sysfw(self, cert_fname, input_fname, key_fname, sw_rev,
-                  config_fname, req_dist_name_dict, firewall_cert_data):
+                  config_fname, req_dist_name_dict, firewall_cert_data,
+                  boot_ext_data, load_ext_data):
         """Create a certificate to be booted by system firmware
 
         Args:
@@ -101,12 +102,52 @@ imageSize              = INTEGER:{len(indata)}
                 extended certificate
               - certificate (str): Extended firewall certificate with
                 the information for the firewall configurations.
+            boot_ext_data (dict):
+              - proc_id (int): The processor ID of core being booted
+              - flags_set (int): The config flags to set for core being booted
+              - flags_clr (int): The config flags to clear for core being booted
+              - reset_vector (int): The location of reset vector for core being
+                booted
+            load_ext_data (dict):
+              - dest_addr (int): The address to which image has to be copied
+              - auth_type (int): Contains the host ID for core being booted and
+                how the image is to be copied
 
         Returns:
             str: Tool output
         """
         indata = tools.read_file(input_fname)
         hashval = hashlib.sha512(indata).hexdigest()
+
+        if boot_ext_data is not None:
+            boot_ext = f'''
+[ sysfw_boot_seq ]
+bootCore = INTEGER:{boot_ext_data['proc_id']}
+bootCoreOpts_set = INTEGER:{boot_ext_data['flags_set']}
+bootCoreOpts_clr = INTEGER:{boot_ext_data['flags_clr']}
+resetVec = FORMAT:HEX,OCT:{boot_ext_data['reset_vector']:08x}
+# Reserved for future use
+flagsValid = FORMAT:HEX,OCT:00000000
+rsvd1 = INTEGER:0x00
+rsvd2 = INTEGER:0x00
+rsvd3 = INTEGER:0x00
+'''
+        else:
+            boot_ext = ""
+
+        if load_ext_data is not None:
+            load_ext = f'''
+[ sysfw_image_load ]
+destAddr = FORMAT:HEX,OCT:{load_ext_data['dest_addr']:08x}
+authInPlace = INTEGER:{load_ext_data['auth_type']}
+'''
+        else:
+            load_ext = f'''
+[ sysfw_image_load ]
+destAddr = FORMAT:HEX,OCT:00000000
+authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
+'''
+
         with open(config_fname, 'w', encoding='utf-8') as outf:
             print(f'''[ req ]
 distinguished_name     = req_distinguished_name
@@ -138,9 +179,9 @@ shaType                = OID:2.16.840.1.101.3.4.2.3
 shaValue               = FORMAT:HEX,OCT:{hashval}
 imageSize              = INTEGER:{len(indata)}
 
-[ sysfw_image_load ]
-destAddr = FORMAT:HEX,OCT:00000000
-authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
+{boot_ext}
+
+{load_ext}
 
 [ firewall ]
 numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
index f6caa0286d9..9573fab088f 100644
--- a/tools/binman/etype/ti_secure.py
+++ b/tools/binman/etype/ti_secure.py
@@ -59,6 +59,33 @@ class Entry_ti_secure(Entry_x509_cert):
               ( 0x02: Move the authenticated binary back to the header )
             - Upper Byte - The Host ID of the core owning the firewall
 
+        - proc-id: (optional) The processor ID of the core being booted.
+          Used in TIFS Boot Extension to identify the target core.
+
+        - flags-set: (optional) Configuration flags to set for the core being
+          booted. Used in TIFS Boot Extension.
+
+        - flags-clr: (optional) Configuration flags to clear for the core being
+          booted. Used in TIFS Boot Extension.
+
+        - reset-vector: (optional) The memory address where the core should
+          start execution after being released from reset. Used in TIFS Boot
+          Extension.
+
+        - dest-addr: (optional) The destination address to which the image
+          should be copied. Used in TIFS Load Extension.
+
+        - auth-type: (optional) This is an integer field that contains two pieces
+          of information used in TIFS Load Extension:
+
+            - Upper Byte - The Host ID of the core being booted
+            - Lower Byte - Load type (e.g., 0x00: Copy to dest-addr,
+              0x02: Authentication in place)
+
+        Note: The proc-id, flags-set, flags-clr, reset-vector, dest-addr, and
+        auth-type properties form a group. If any are present, all must be
+        specified together to configure loadable core boot parameters.
+
     Output files:
         - input.<unique_name> - input file passed to openssl
         - config.<unique_name> - input file generated for openssl (which is
@@ -116,6 +143,7 @@ class Entry_ti_secure(Entry_x509_cert):
         if auth_in_place:
             self.firewall_cert_data['auth_in_place'] = auth_in_place
             self.ReadFirewallNode()
+        self.ReadLoadableCoreNode()
         self.sha = fdt_util.GetInt(self._node, 'sha', 512)
         self.req_dist_name = {'C': 'US',
                 'ST': 'TX',
@@ -126,6 +154,43 @@ class Entry_ti_secure(Entry_x509_cert):
                 'emailAddress': 'support@ti.com'}
         self.debug = fdt_util.GetBool(self._node, 'debug', False)
 
+    def ReadLoadableCoreNode(self):
+        # Map DTS property names (with dashes) to Python dict keys (with underscores)
+        boot_ext_props = {
+            'proc-id': 'proc_id',
+            'flags-set': 'flags_set',
+            'flags-clr': 'flags_clr',
+            'reset-vector': 'reset_vector'
+        }
+        load_ext_props = {
+            'dest-addr': 'dest_addr',
+            'auth-type': 'auth_type'
+        }
+
+        self.boot_ext = self.ReadIntProps(boot_ext_props)
+        self.load_ext = self.ReadIntProps(load_ext_props)
+
+    def ReadIntProps(self, props_map):
+        props_dict = {}
+        missing_props = []
+
+        for dts_prop, dict_key in props_map.items():
+            val = fdt_util.GetInt(self._node, dts_prop)
+            if val is None:
+                missing_props.append(dts_prop)
+            else:
+                props_dict[dict_key] = val
+
+        # If all properties are missing, return None
+        if len(missing_props) == len(props_map):
+            return None
+
+        # If some but not all properties are present, raise an error
+        if len(missing_props) > 0:
+            self.Raise(f"Loadable core configuration incomplete. Missing properties: {','.join(missing_props)}")
+
+        return props_dict
+
     def ReadFirewallNode(self):
         self.firewall_cert_data['certificate'] = ""
         self.firewall_cert_data['num_firewalls'] = 0
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index b6e8b0b4fb0..0d3bc06da1c 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -52,6 +52,8 @@ class Entry_x509_cert(Entry_collection):
         self.sysfw_inner_cert_ext_boot_block = None
         self.dm_data_ext_boot_block = None
         self.firewall_cert_data = None
+        self.boot_ext = None
+        self.load_ext = None
         self.debug = False
 
     def ReadNode(self):
@@ -102,7 +104,9 @@ class Entry_x509_cert(Entry_collection):
                 config_fname=config_fname,
                 sw_rev=self.sw_rev,
                 req_dist_name_dict=self.req_dist_name,
-                firewall_cert_data=self.firewall_cert_data)
+                firewall_cert_data=self.firewall_cert_data,
+                boot_ext_data=self.boot_ext,
+                load_ext_data=self.load_ext)
         elif type == 'rom':
             stdout = self.openssl.x509_cert_rom(
                 cert_fname=output_fname,
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8caf275d466..a26a51fa210 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7361,6 +7361,51 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                 entry_args=entry_args)[0]
         self.assertGreater(len(data), len(TI_UNSECURE_DATA))
 
+    def testPackTiSecureBootLoadExt(self):
+        """Test that an image with TI secured binary having boot & load extensions can be created"""
+        keyfile = self.TestFile('security/key.key')
+        entry_args = {
+            'keyfile': keyfile,
+        }
+        data = self._DoReadFileDtb('vendor/ti_secure_boot_load_ext.dts',
+                                   entry_args=entry_args)[0]
+        self.assertGreater(len(data), len(TI_UNSECURE_DATA))
+
+        # Verify that boot and load extensions are correctly written to config file
+        image = control.images['image']
+        entries = image.GetEntries()
+        ti_secure_entry = entries['ti-secure']
+        uniq = ti_secure_entry.GetUniqueName()
+        config_fname = tools.get_output_filename('config.%s' % uniq)
+
+        # Read the generated config file
+        with open(config_fname, 'r') as f:
+            config_data = f.read()
+
+        # Verify boot extension values from the DTS
+        self.assertIn('[ sysfw_boot_seq ]', config_data)
+        self.assertIn('bootCore = INTEGER:32', config_data)  # 0x20 = 32
+        self.assertIn('bootCoreOpts_set = INTEGER:1', config_data)  # 0x00000001 = 1
+        self.assertIn('bootCoreOpts_clr = INTEGER:2', config_data)  # 0x00000002 = 2
+        self.assertIn('resetVec = FORMAT:HEX,OCT:70000000', config_data)  # 0x70000000
+
+        # Verify load extension values from the DTS
+        self.assertIn('[ sysfw_image_load ]', config_data)
+        self.assertIn('destAddr = FORMAT:HEX,OCT:80000000', config_data)  # 0x80000000
+        self.assertIn('authInPlace = INTEGER:2', config_data)  # 0x02
+
+    def testPackTiSecureBootLoadExtPartial(self):
+        """Test that partially specified boot/load extension properties raise an error"""
+        keyfile = self.TestFile('security/key.key')
+        entry_args = {
+            'keyfile': keyfile,
+        }
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFileDtb('vendor/ti_secure_boot_load_ext_partial.dts',
+                               entry_args=entry_args)
+        self.assertIn('Loadable core configuration incomplete', str(e.exception))
+        self.assertIn('Missing properties:', str(e.exception))
+
     def testEncryptedNoAlgo(self):
         """Test encrypted node with missing required properties"""
         with self.assertRaises(ValueError) as e:
diff --git a/tools/binman/test/vendor/ti_secure_boot_load_ext.dts b/tools/binman/test/vendor/ti_secure_boot_load_ext.dts
new file mode 100644
index 00000000000..226415f39ea
--- /dev/null
+++ b/tools/binman/test/vendor/ti_secure_boot_load_ext.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		ti-secure {
+			content = <&unsecure_binary>;
+			proc-id = <0x20>;
+			flags-set = <0x00000001>;
+			flags-clr = <0x00000002>;
+			reset-vector = <0x70000000>;
+			dest-addr = <0x80000000>;
+			auth-type = <0x02>;
+		};
+		unsecure_binary: blob-ext {
+			filename = "ti_unsecure.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts b/tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts
new file mode 100644
index 00000000000..e90d27cb087
--- /dev/null
+++ b/tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		ti-secure {
+			content = <&unsecure_binary>;
+			proc-id = <0x20>;
+			flags-set = <0x00000001>;
+			// Missing: flags-clr, reset-vector, dest-addr, auth-type
+		};
+		unsecure_binary: blob-ext {
+			filename = "ti_unsecure.bin";
+		};
+	};
+};
-- 
2.34.1

