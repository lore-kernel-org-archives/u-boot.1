Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D522C61DE1
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BABBD80E90;
	Sat, 29 Aug 2026 14:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q2VgSKve8E9Z; Sat, 29 Aug 2026 14:34:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014096;
	bh=NpG++F0Vk3qnU3UGzQnG1O2BwvIozaYissQCMCmdY64=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xt/aaU2vZf4fAzNrfl1aQRK4yLnsQ3vUss3JFLRY63JG+H97wd7/S+G+6d1C5FZbL
	 D0s+NopubE/8kks6pX/0/R358qDrxDzLt7BJ0bVn+5++S+Hmms9jxSzk/9pJGvr2XW
	 qWd5YhfJiOOcSrsLB+yBJcIZIhhCmbSL8kOGI039mKoJP6SY6pBR6TcfrHQwLpIBCu
	 kUKXrdoeCwQpeG06o/bfm4XVX/iZE0Gss5sFkP0p/k0Rz5Pc5Zd/DF+/OcXak8ZjzS
	 3c2FMPcJe4YPCgGg1Yx6lR7zUj51n+TPCQHoClkFu8dCoY516P00p5Wd+wuCX80XiK
	 Tj97D0JFjQM3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E710780E7B;
	Sat, 29 Aug 2026 14:34:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 27635465
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CE0380EE5
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0FlYSr0RCiwQ for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=mifZrGu8; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Atd+THh0
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2314F80EE3
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:52 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67TDxoFV269983; Sat, 29 Aug 2026 09:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=NpG++F0Vk3qnU3UGzQnG1O2BwvIozaYissQCMCmdY
 64=; b=mifZrGu8328DalbECYr5U24URvwaUcNK53yqFgpe7+Yehg3sdP1yceECq
 ueJ0+H8eHIIyplj2oYsMU2Xq7CHPjlOnrSLZIHlMKG7pYqFN/UBpbABuGm2wuzJP
 QekCoRKg9WCyMRv9se2uijKz4gHvxtu4F2mjPv3lLSmMOMbXcqSW8mmWPWCk1YGF
 gWLfRb/gD2M1+3o3oOiRIUPdPh5o7LsAeQaWTKfvopdR/L+3Tmj40g3PlEMteaWG
 WCn8w65+hykS6GgDf8wZtYPjY1A9yuphILfCxVbBX5hgQ2lVZmXsgXtk8y4gKc9X
 TGlU3iEEnB+7JIJLiXb1PofZFObTA==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gbqn1hrut-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEzSHpM39idIgUmwBT0OZ8mEL2Ut56R1yUhcTzmK1s9DjqMNIrwg2KBrLz/cqf4gER56LAqctPlLZccGBhD1QFylJkKW6KWlzFNo0jPrHagsnkt91ONcoWG1mdG0YvrDJEAURr9+5WRUfpf/oxCjwehfRZLpkhwWpJDxOIoaiCkl98RxbnnUokVtI+kYBH3yroZ3deIZJf7qgismJ9wqwM4i91/3aOHToMvzbL2Jk3mMMvsVlyO3x2mFuLDPCoCTDnVgpX0DpSLutmg8jredngx1IX8bjI3/luF5qzt8MM0W9o2JRBj9j7zNPevyRxxO77Zt/wmm10AURarIUMW5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpG++F0Vk3qnU3UGzQnG1O2BwvIozaYissQCMCmdY64=;
 b=Olg2zTb9R7K6h0nhJBvsiFV34UctmTqoFoYiqq/+2lPAwBVDPLNIZPTohdgP20nBYViRDc7XNs/HxtFUmYkz4298Cdas+DyGnu6jZWznjBBycDq1ZMqbks9IqLhU1ByXBUJ24NnEtbR29Wb3XEfMf5+ysVAc0Xhnp5IbhwvBDsDQVT6NcyHX12eN2YG8N6x3KMpnwumtsvQOsW0pOHGpkfcs2NZTQ5xrCiErcQSUe/1BFgAN/StduZDNlCKab53FaK8TdTob7FpgO86HK8tYaf7XVxDIN7KroCFoVjgYcLgZwSi94/v0i9n8i4TOQEratI8mlA3QJcPwOP3wzSASsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpG++F0Vk3qnU3UGzQnG1O2BwvIozaYissQCMCmdY64=;
 b=Atd+THh0KGrma7S+alb8PYTSuNusoPJsOiKJvpAicha4aO5D07mrnowLzpc9L/Q9Ict8Cr7fJ0y9CssCTwDIDlObrF8rQEeqKd/DNjX+1Nor0TsQHviXAn+l6ecdByUL3fXu6NY/rMRALvHJ7Nn0fJfOwAWuJahBK51ZzNRTYgY=
Received: from BN9PR03CA0268.namprd03.prod.outlook.com (2603:10b6:408:ff::33)
 by SJ5PPFC322FD87E.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7c9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:46 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::5f) by BN9PR03CA0268.outlook.office365.com
 (2603:10b6:408:ff::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.12 via Frontend Transport; Sat,
 29 Aug 2026 14:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 29 Aug 2026 14:34:44 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:23 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYN6V530312;
 Sat, 29 Aug 2026 09:34:23 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:20 -0500
Subject: [PATCH 02/14] board: ti: correct names in MAINTAINERS file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-2-e4e03971e14c@ti.com>
References: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
In-Reply-To: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Bryan Brattlof" <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|SJ5PPFC322FD87E:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c08d97-2694-4446-c3c3-08df05daab53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: lCK9l+P1iCNGoEFuBuOVkbAZ+ZPhtUW756Gs0IHek/UERLJYbsN9u4osrF3y+1h+2M77TXYkxr7hdbxn4pRkxHiL16giH6ZTfFMF62dWSmJxDTL7NkFzeCEzwrenURb0cB/T8XO7lvtKTw6c6DU/37gO5BTadpbpzzjdFH29glOHM40ZUhCOrrfV89OljTcPDul5NrZ2YTvEsg6gU/jOYB3VXorNAbwEFqcVRUfih7OkPZrbVaMd1R164/5m1ta+Fq5l84gJvaNbp4f4b26jd7i7hzVwzJohbAju1t5I+rq7esbIgSubYDGrLi5EC7FY2Q+/sfElvcxFBam8y5zaBodECq0ajzKZNEF2lTq1xjd1ffOd+cU5OB1mg1z3nEXp0oRkF8dvOAEksncbpZCh6eoe1DfRX48FQS5UycuNrBwUEG1Drjb/Kc45yMjn0BFbY6RwVJKd+A6+PYnZvtatKKjsOyVYoMLM7q77eiVAC6qUqwlwCisLnLzA5oAkbbLrY2xkZX/mU9GMlFhPJP1bbbkHdNYfXDdiAAENax0y3gbCWJgwtcEdxtEWQZPV/TxSRYc6j6ldxDSPrHarSkfZoe3sQ54S+GZ0JrpC7JYUNvIEXzXHPDJ1xJA6ecwwZVoyxajGlgPAeJIKGImbfMd8RrBofof8VIBbOGFqttNuH+oAXdkKMiOnpDJAqKaAaCCSBHsh7XOj0F7SR+QVybxXqg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8ae8WeRYdTLKL4dQlThRxheO3DWqV1wwm5rZcjHQW0WiI9PzK8z0N6+dHNeacrpQij6MUk7tgMr5KwK17pOYw8RyUf2AWQ9ilSKNY2vKIj1ysdPQOLLNIQKfGrbVI4ijdrrUyNGbO9Mg5/gy6dig5DcuDZwiZ5jk9N8+FiUkOUp7c+kwWdT72CcJpGU9r3Mg1uhxt+2FwxapIUwe2ybxYwTtcrgCcWnFRdcwsWnQo1Tzv9ceu79cfbsfu/pPbDtWdNvDp8vbPzaDrPICHySG9UGCyQAvLzdE5Kuw8LW+xrMdW6Y1xBKNl1aN5MEgr2/jIy/Vi6UD3qCY6Yi8On+gR6jGT111d2Sj8q4WubhoPkSH3Fj98gWj3p4q8YBkU7a0LzZSLCRS+TwkUanGI1wNh6g+oUepIlG+o4xLH2eLHsrGFAoPdxL5eqrPDGddFbl/
X-Exchange-RoutingPolicyChecked: JWF7MlKdnHx6Aikd65MbP0/MfrLtzifoRcDrPshz2F52VmjhaBLkLko9WvCjuwvNGOAKtD4bEZAQHjj9yDnADCRxbXcVq34Acb1sViRNT87U2BT+9R4it3Bz5uJgL1Z6hOC8F4iWuHlG/FSLi80kYhrT562AlrCu/iKg0akAqPKCjah1nvJng8DHNkdTbEJMuPa7/Rj8iYnAZZina07KqjB/0tP4GJP+Uo3Lu8Hypr0cgp4BxZEHSl8kR2Tf6Mv7o4UQ//D5HdqWiOhLomxh0b6lvKnmAU3klPt1VnpezMfxUlAqZRs/Mluoyw2OpUSLWGtUvjXGLTXS+BG0NoUbYg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:44.4013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c08d97-2694-4446-c3c3-08df05daab53
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC322FD87E
X-Authority-Analysis: v=2.4 cv=E9j9Y6dl c=1 sm=1 tr=0 ts=6a92ee0b cx=c_pps
 a=5XLVA79qUcMA6Bnn+7FYtQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=k-42gJp3AAAA:8
 a=17572Yx0TfHyVeBZ_DwA:9 a=QEXdDO2ut3YA:10 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: aY-yJO1Uyl-VcsODpTZ3GiIiaiTp5lT-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNiBTYWx0ZWRfX7AjT+rWo025W
 n3h97/1hNhe+0xpV9BOFEikeFg9qNWrc9oeiZVqaETsJdpXaVHtgUyFPWtUHIaV/UFKndccDFGn
 O2u0l5rFiStEzBBuZei0fkOqQ1w832B27ztVYE2yQvfpHdc2gsmMFMkPClYNQc3BVdI8VLaKJaP
 0WTvXudA1VuMCsHBwlx0LQDKHwqiaQqU+rHcfOFHxJ3KprDdo8ZgHD8WDhPGJMXR1K6rRSFtmUR
 TLBoOWsb6zRXtfSprsHlGg/Hzu6C2QyZ8kN3Nl7epgcYz/QTmhPx2CwqRx5603F13Mjd/mOTIf5
 /33cXXtpbBjoeU/g3EwcEgxEcqgYFPFz4AhnYaupPZ6sSWId6YGJWvTSgWsRMlic6NoNoKm2auC
 N9G6tMhM719aW73nhD4Hlw/ngCO8dQhqLsLa4m3CsRzjCm/Z/nSJOHtUublKa8wQOXZEhH9p2iF
 I0+Rm33KSi/9uym0Bbw==
X-Proofpoint-ORIG-GUID: aY-yJO1Uyl-VcsODpTZ3GiIiaiTp5lT-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNiBTYWx0ZWRfX2Ldf5JU8TZ6r
 8R1BCWslvuYp40J86ivltEhGA+gaLHLc6QqMhKfycxfja2b7ZspfgaS5bXkOg66XgpjlNqn0pGq
 WlTOnM+9WudI3kp3Vbgxt4vjXlCoSBE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290126
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

To allow for easier upkeep moving forward when new board variants and
board revisions are introduced, correct the names of the boards in the
MAINTAINERS files to match their names on ti.com.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am62ax/MAINTAINERS | 2 +-
 board/ti/am62dx/MAINTAINERS | 2 +-
 board/ti/am62px/MAINTAINERS | 2 +-
 board/ti/am62x/MAINTAINERS  | 2 +-
 board/ti/am65x/MAINTAINERS  | 2 +-
 board/ti/j7200/MAINTAINERS  | 2 +-
 board/ti/j721e/MAINTAINERS  | 2 +-
 board/ti/j721s2/MAINTAINERS | 2 +-
 board/ti/j722s/MAINTAINERS  | 2 +-
 board/ti/j784s4/MAINTAINERS | 6 +++---
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/board/ti/am62ax/MAINTAINERS b/board/ti/am62ax/MAINTAINERS
index 95ff5afb2c47..a5fbbd8b2f88 100644
--- a/board/ti/am62ax/MAINTAINERS
+++ b/board/ti/am62ax/MAINTAINERS
@@ -1,4 +1,4 @@
-AM62Ax BOARD
+SK-AM62A-LP BOARD
 M:	Vignesh Raghavendra <vigneshr@ti.com>
 M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
diff --git a/board/ti/am62dx/MAINTAINERS b/board/ti/am62dx/MAINTAINERS
index fd5c1c93b7ea..71469dad34a2 100644
--- a/board/ti/am62dx/MAINTAINERS
+++ b/board/ti/am62dx/MAINTAINERS
@@ -1,4 +1,4 @@
-AM62Dx BOARD
+AUDIO-AM62D-EVM BOARD
 M:	Vignesh Raghavendra <vigneshr@ti.com>
 M:	Bryan Brattlof <bb@ti.com>
 S:	Maintained
diff --git a/board/ti/am62px/MAINTAINERS b/board/ti/am62px/MAINTAINERS
index 7747f96104d0..320b0021b552 100644
--- a/board/ti/am62px/MAINTAINERS
+++ b/board/ti/am62px/MAINTAINERS
@@ -1,4 +1,4 @@
-AM62Px BOARD
+SK-AM62P-LP BOARD
 M:	Vignesh Raghavendra <vigneshr@ti.com>
 M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
diff --git a/board/ti/am62x/MAINTAINERS b/board/ti/am62x/MAINTAINERS
index 76c97ffc3b86..31ff7dc6522b 100644
--- a/board/ti/am62x/MAINTAINERS
+++ b/board/ti/am62x/MAINTAINERS
@@ -1,4 +1,4 @@
-AM62x BOARD
+SK-AM62 BOARD
 M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
diff --git a/board/ti/am65x/MAINTAINERS b/board/ti/am65x/MAINTAINERS
index c52f7c9112bc..a01168952258 100644
--- a/board/ti/am65x/MAINTAINERS
+++ b/board/ti/am65x/MAINTAINERS
@@ -1,4 +1,4 @@
-AM65x BOARD
+TMDX654IDKEVM BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/am65x/
diff --git a/board/ti/j7200/MAINTAINERS b/board/ti/j7200/MAINTAINERS
index 3d05910d1bc8..86badfb2384f 100644
--- a/board/ti/j7200/MAINTAINERS
+++ b/board/ti/j7200/MAINTAINERS
@@ -1,4 +1,4 @@
-J7200 BOARD
+J7200XSOMXEVM BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/j7200
diff --git a/board/ti/j721e/MAINTAINERS b/board/ti/j721e/MAINTAINERS
index dc0315b1c407..031f51b762e4 100644
--- a/board/ti/j721e/MAINTAINERS
+++ b/board/ti/j721e/MAINTAINERS
@@ -1,4 +1,4 @@
-J721E BOARD
+J721EXSOMXEVM BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/j721e
diff --git a/board/ti/j721s2/MAINTAINERS b/board/ti/j721s2/MAINTAINERS
index 64d0553738ed..81276116cc45 100644
--- a/board/ti/j721s2/MAINTAINERS
+++ b/board/ti/j721s2/MAINTAINERS
@@ -1,4 +1,4 @@
-J721S2 BOARD
+J721S2XSOMXEVM BOARD
 M:	Manorit Chawdhry <m-chawdhry@ti.com>
 S:	Maintained
 F:	arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
diff --git a/board/ti/j722s/MAINTAINERS b/board/ti/j722s/MAINTAINERS
index c5054084607d..be1bcb74c5f3 100644
--- a/board/ti/j722s/MAINTAINERS
+++ b/board/ti/j722s/MAINTAINERS
@@ -1,4 +1,4 @@
-J722S BOARD
+J722SXH01EVM BOARD
 M:	Vaishnav Achath <vaishnav.a@ti.com>
 M:	Jayesh Choudhary <j-choudhary@ti.com>
 M:	Tom Rini <trini@konsulko.com>
diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
index 781b16ee013c..975d68bee855 100644
--- a/board/ti/j784s4/MAINTAINERS
+++ b/board/ti/j784s4/MAINTAINERS
@@ -1,4 +1,4 @@
-J784S4 EVM BOARD
+J784S4XEVM BOARD
 M:	Apurva Nandan <a-nandan@ti.com>
 S:	Maintained
 F:	arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
@@ -13,7 +13,7 @@ F:	configs/j784s4_evm_r5_defconfig
 F:	doc/board/ti/j784s4_evm.rst
 F:	include/configs/j784s4_evm.h
 
-AM69 SK BOARD
+SK-AM69 BOARD
 M:	Apurva Nandan <a-nandan@ti.com>
 S:	Maintained
 F:	arch/arm/dts/k3-am69-r5-sk.dts
@@ -26,7 +26,7 @@ F:	configs/am69_sk_r5_ethboot_defconfig
 F:	doc/board/ti/j784s4_evm.rst
 F:	include/configs/j784s4_evm.h
 
-J742S2 EVM BOARD
+J742S2XH01EVM BOARD
 M:	Manorit Chawdhry <m-chawdhry@ti.com>
 S:	Maintained
 F:	arch/arm/dts/k3-j742s2-ddr-evm-lp4-4266.dtsi

-- 
2.54.0

