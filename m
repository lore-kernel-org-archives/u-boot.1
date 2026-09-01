Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86470C624D3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 125BD60758;
	Tue,  1 Sep 2026 14:59:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2LldHfqCvDTO; Tue,  1 Sep 2026 14:59:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788274747;
	bh=Vlq5UgGyuPuCF24mC5H7PRvvSotrQ3tnhamCzCp7DUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pCnxx9Ff0s5D8KVnYiN/AHHAPYFgwFHgRDz+8nHV1cORpNT/Bd5Kiuk806nVIf8vt
	 4siVCsanhxyLeEGBT8bt13xoMd+dtoEcn0NiSMvcRsF7k0Yi3655GdoWELl/6GrPwb
	 337dcToPRx6GJ4FVWezGFQVHTSuejDMlN9JyWlAzGzbTHTQgEt/vAgK9KQISjOPdba
	 3+yasHLs6a7oaKlB6RbFdkh/R5qJ2pJ97QkaU0e5KddWARuSloug9h0q7m1pgWV0ci
	 FEZIHPDyE2KNQT3OBTXUHk4eHxoZs3w+vMMpC9G2Qz7BjknlxDfyQE0+9nyf7z7NG9
	 nbux7qMPzv4sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28827606E5;
	Tue,  1 Sep 2026 14:59:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA9B3363
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C084B80D1A
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:59:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VH0dZR35WD_o for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:59:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=LjTSPVW6; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=LjTSPVW6
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43E2C80CDC
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:59:01 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=spRkiqXFsMhTUVj6h6XtTdTHIczjhDYNz+ft2lb5XLwjVd52Uqa3Rziln/uqR97LelHLaVZQ+RkGiMuff02tRFTF8gJmf1SiY6HP/MSkErnPksq2mOMIVYgANff7LfviZuf2akXOV5Ibu3kyz4id7hvi9zbRCBrySwcTOzZTjk0oiXmWJZLdbd7WFnhM60ZxsJc7dkVe52QeeVCJHtcJFEXT9X/8CCqN58uMUraW+NyvS83ZkktSkaTC7BhUkwUjEClE5NiYr6Kcindo+yvk/EbfBUWw62mbbLO/i9n4noLO11p5WPwSkgF8OOaJ9GpfQ+DV8QX0JDBx45LGlKymmA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vlq5UgGyuPuCF24mC5H7PRvvSotrQ3tnhamCzCp7DUc=;
 b=x7YeL7ghpGI7Wvp3HyRNj3HaYbyuIMttdsVeeezRRQWQ/Ai71ZX2u/AQafTpFFEtPbPaz2voBc/aBPFDyrc379VEt2JOxawlQCuc5F/ynUyTCVfa5ExEAzh8CuFF5ba2IPFqlztPm6YGh00nilvEgWhvMtZT8aVptjJn7VuSJeg/2gdUKwyt+L3Xh3ScQrOcVS2M7YSgjbuYTg7R8/ABtPIFIqc6mwfM0cBIxHoZat3B+nWPDZHDeSby7JwWDhvvAZbWZuD2+ktuJ2tjao9GfsSwnOdlhEJZqg8rTPAyEk4HBbp1cOE/pSVSx2VqNvBda1ZqhzHn2lNNzMGGfz2WXQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlq5UgGyuPuCF24mC5H7PRvvSotrQ3tnhamCzCp7DUc=;
 b=LjTSPVW6dHZHg54oCDuX/mRDbJdwdDFNR4M/R7btRghrG2iLxQ0RJ8v476mwZyhKKKXzfFcpEQU1/mgNLiNbZRSCmwQSGvlvoxLLao8kslhQzeBrK1KtUPELQ2ih+X/8am4Gq4MakrHtGnBjoT2xIOxFzxGVm6d0iUgoy0sDeic=
Received: from DU2P251CA0028.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::32)
 by AS1PR08MB7609.eurprd08.prod.outlook.com (2603:10a6:20b:474::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 14:58:49 +0000
Received: from DB1PEPF000509EA.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::7c) by DU2P251CA0028.outlook.office365.com
 (2603:10a6:10:230::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 14:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EA.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Tue, 1 Sep 2026 14:58:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsCDEiU9wWxd1RZu0U1xjElWNv23X+bdd0t40dc90KRkbeib/VZsycbq1pxdQpcpyeTzYN8LanDqLF1AL6/WODWWSqBHSItMo7ZVV9gC27KxDPLNkKqS/jGDIgk3bP4nsXe2OTqjrewyOf1AvH6vvRYFHwmKi4XmLR9zSakG1SHDTCrxIsPSWyuxAKfurveHekTcHicc3gyJKERniPblEg6fdmR8YkwFaNELO2ZzuiDNlo/ZrZwMN8nyOYyLvaLimm0rR1hGOD6PykYkiZNRHmjuX+1V5yg4EtMRwEBLQt47RjipAVUXJrcB/uuvMth23y5yUqU5vOJZwBrIm4fTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vlq5UgGyuPuCF24mC5H7PRvvSotrQ3tnhamCzCp7DUc=;
 b=cQqiKnzwK1i6ywfm+kyFGdmju4idHCas/FLwur3+zl1mHdEnk+xaq4/8e3IGJO3mw/W8JZUJGfyuWyMPEwVNyh0o0T1IR7i7moy5LspFZ7RTxJ1SP3x+RuOvLYtVOwJkexFXLhQQ/aNrJrUR7J6s5IgGX6+lPmp4B+rDCDtEh6BlVB50BGiHUF2vFH/TT9DM7cE6ycHvybFpgLjMiwHZO5lBewwICK7FI4Wv6ZkteylPN36gl/jwiB4Z9Zd4HEo29ELv9Qn5VSGJSNhw+NtRevNbLDpPTLEE2OgaT0HUIY7D+POsygHhEYOywLOYrC24ttFU49qgg21NZOtUNoNbsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlq5UgGyuPuCF24mC5H7PRvvSotrQ3tnhamCzCp7DUc=;
 b=LjTSPVW6dHZHg54oCDuX/mRDbJdwdDFNR4M/R7btRghrG2iLxQ0RJ8v476mwZyhKKKXzfFcpEQU1/mgNLiNbZRSCmwQSGvlvoxLLao8kslhQzeBrK1KtUPELQ2ih+X/8am4Gq4MakrHtGnBjoT2xIOxFzxGVm6d0iUgoy0sDeic=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB8781.eurprd08.prod.outlook.com
 (2603:10a6:20b:5f1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.8; Tue, 1 Sep 2026
 14:58:16 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 14:58:16 +0000
Message-ID: <11af5d78-cf66-4a4f-a924-fbf8aac3cce7@arm.com>
Date: Tue, 1 Sep 2026 16:58:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] net: share the lwIP runtime and support netconsole
To: James Hilliard <james.hilliard1@gmail.com>,
 u-boot@lists.u-boot-project.org, Sughosh Ganu <sughosh.ganu@arm.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Stephan <jstephan@baylibre.com>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>,
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, nd <nd@arm.com>
References: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0196.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::6) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB8781:EE_|DB1PEPF000509EA:EE_|AS1PR08MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 9827f84e-2745-4e2b-6e4e-08df08398807
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|11063799006|3023799007|56012099006|6133799003|10067099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info-Original: anKn5Zfqookx8T5CDY4zFgAukLOn9CJD80XEmOpQ9dYP4evz5UzM6G9xKIniaPK5br4kkf/1IyO5y+OJxVWHGon7xP60h5KQGm0d/tQRsIYNbloSZi9rEe+XD7m8GMAzrMD0X9bj3OzLL0azPaSI79j3wfMTZNp25fQoFChmdpc80xYrheHexgk68nzoWodcdtqizaxGPP3iaqQrTKdclF88KRoJDnGtcG8JHo1M1lWazBPT9gJEOGowaVrDivkc8d4DEt9CifjENAlWMH9GnBCj0U41H9NXabkTmQ0OhfGCgq/ki8Cl7wnKFwKB3KMpIw5Ohw61zNjGNoMx8sT2oxvneVWk66iuEyKodqPpsZhBUNDW/jI1KHXPHNOK7swcIVlxPayMXLzRmBGK4bRdX3ndQR6Zvg7Em5Ox5UJr7pgXnU1S0WX13t7qpbEfReWXaet1Mo44VE1nMkkmykX6kjcF3qEtz0BZoprSn9HfawD5BNYR+FCgyH7xns9Onm7rewxCJTuJa09LBDuVg/JOsq2zwoLPebRnKIR4+HN/+cDCWOJKCS53NKP1cXtL7tjhK+SmGYJFBypEt+y0t/l7ho1BFefAi6rDRVfhMKiylg3fRMagwrzfRYBfRrJLwkGLY8abn8GIsIS36Vy3Q60OZ33RwDR8CSu9Zyd1DvF5i2WYniZ+lAPlEM6CPYpBIxctZW/8W/6nj5PpX1cjYYbUi/UwxdlOv/I4XzZUng/EggMTEPcMlKIA1uQq9Oj7Lbfx
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006)(6133799003)(10067099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: UykrW8O0N1V2vdYXSStzM+P/xn1Yt5qmr6aRfXtg1QuVwCJpffJk1H11/PpD4LcJ++n9lFSlr3U9SphdH/3GxxRRaCFJY24u4iIdg7K6atvgvimWFpT+3YlZO/sHpfnsgG5bkHddjgkf2Nw/IumGPpFjvUX1OSC9gCnLi1Djz8XDcWMlRP4gju8R/xfD0N2u242+V6THEyrgIUU50vBe6hAAVYPYnizdKSEi9edrTGLNndnT/E7f2xV/aj+UvD14tkVm5bDCNgF2+ElkhqRQ5/CuCEq/qpdspJpeWkRR8aeqtBSIvi4L7JwG7lZeqFlJTm9klPCOODf2bSemGDwXSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8781
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 344b1cac-1b67-44dd-7538-08df083973ee
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|35042699022|82310400026|376014|36860700016|14060799003|18002099003|22082099003|56012099006|3023799007|6133799003|10067099003|11063799006|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: zNZxQmIQj37gp2uHWSFbkMCEZnWFBEvY1xCBrXSMbnNwLVYC+gU5JkkbUU+5tk0LdChLPSxZXX7m1mLq4oNjtd4mJwnYOcbXD2cilH22L80R4BKybFfCDBWYKCG3bdDFCBXsMMCzcIG8r21HuEiQWguuA5Lv25GRDByZ1oKXZ4i0WfchSFi/3ev7A1SIOGGk24fIcHoq0lfETnSNeubkPWm/9r1SiFkQp6Vu+mOFRFfEwjtmJ1Q1lZJsju0kvd1uYiVmx4ty+lfuteWoU42utAWA2EI4spe3LZhZ8KKO67D/eJ/flD5Ne4CnBRhrSU0BxI864CppY46yVvCuPiPrBJFhkPav3QtHuRqucZ+9dP9rpxNQl/psFONGwsA2TibfeIwTrlqSyDVdYa9GGxiVUFGkEC9JM7QzZNgndIMSIXPnw781qhaWqiD7FL0kq4HCfpF0XIjWPrj1/z8dJbFXFG4Mp1mJ1LX+B9KNrLFiQq+Gdns6QS9lC+S/i4G6heKOHy2W+2M829gH5+hkmqL6OPyRv8lUedGCXV9JR7tmGI9/DmLTqAqLSYN99oNQrS27lqFLyB6uuC1IZnuKSJq2K6cQhyfo7AY7IY9lVQjIazA6UB+Xlnm+f8sb3VUjcZCLckcuhz8UjexBSt4+9YtweEITid4TxRtyqSiHWwjGMw1nVbOXUprxBLsWUeaqX9xV0VsvicKK2MFb0tjdKeSMpCIgXXUYPalQuljgFTq7Tltlil4Sv65gyH1PvF64jXdhhCh9wTgulXK9P59SVV94Q25mqQzBt7+lwXqLNTsXJ74=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(35042699022)(82310400026)(376014)(36860700016)(14060799003)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(10067099003)(11063799006)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4ZOQN+iU6r8op2i3irNfHY7Au8orODXqP4TgKngPlqDTyhaE668IRWD2NikGHyP7uxJLead1VLY80xy5WfZgp00URUXsaI5o0CWtd2dfYT5EkxEqi+YPlQ4JYX/AfyjupiUxQxry/Y7QyN5kEKqVbPeFanEOq7SRGUzG0XhO5EM30Px72IK4l3EGYr+5PJuhU2K0gz3kHG617FEzfj32I0rDBMgawaHGAgYWFSxuAVer+Bhw1r9o9JFtpKZcSif3lEetW6dcJY64Hax8Jp7kTmCenmjDo3ArBuxHKuV+0mgLjA8pEW9+r4kG6d4LohkAfP9sP9lJAQvKeDcq14ViPKVCt/wb/mdN5lhNlOrE72onfQfyHhBBZhsIAe5xk6KTxT6UVH1jHtmmwETUURICO54ChoWYBhrNIBuSSwCBm9PHOrQEVfKdcnt5hPIDdjpW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:58:49.7121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9827f84e-2745-4e2b-6e4e-08df08398807
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7609
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

Hi James,

On 26/08/2026 07:29, James Hilliard wrote:
> lwIP commands currently create and remove the stack's only network
> interface for each operation. That model cannot support a persistent
> client: starting another command replaces its interface, and either
> client can stop Ethernet while the other still owns callbacks and PCBs.

Indeed. What was considered acceptable when we introduced lwIP for basic
commands is becoming a burden. Thanks for looking into this.
> First correct wget's existing receive-error path to return ERR_ABRT after
> it aborts and frees the TCP PCB.
> 
> Introduce a reference-counted runtime which owns one Ethernet device and
> one lwIP netif. Clients retain their own protocol callbacks and PCBs,
> while one non-reentrant poll entry point services timers, scheduled work
> and every attached client. An address-less DHCP attachment temporarily
> owns the IPv4 configuration; environment addressing is restored when it
> detaches.
> 
> Migrate the existing lwIP commands to the runtime, then add an lwIP
> netconsole transport. Netconsole remains attached while a foreground
> network command runs, and that command's polling services both protocols.
> 
> The runtime permits independent lwIP clients to attach their protocol
> state and share the poll loop without creating another netif or Ethernet
> owner.
> 
> Sharing the stack makes asynchronous teardown significant. Add DNS
> callback cancellation, HTTP client abort and DHCP stop-without-release
> operations so clients can detach without leaving callbacks or protocol
> state behind. The corresponding vendored lwIP changes are kept as
> separate patches for upstream submission.
> 
> Validation included:
> 
>   - sandbox W=1 builds and DM tests for runtime ownership, multiple UDP
>     PCBs, address handoff, callback cancellation, immediate abort of an
>     established HTTP connection, nested polling and netconsole
>     input/output;
>   - no-DNS, sandbox_spl, sandbox64_lwIP, qemu_arm64_lwIP and legacy-stack
>     builds; and
>   - H616 hardware tests of bidirectional netconsole, a TFTP download while
>     netconsole remained active, TFTP upload and HTTP wget, with matching
>     payload checksums and successful network use after netconsole detached.

I am OK with the approach but I do see a problem in patch 08/10 which IMO
doesn't enforce proper address ownership rules. Please see my suggestion as
a reply to that patch. Other than that, LGTM.

Thanks,
-- 
Jerome

> 
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> checkpatch reports expected diagnostics for patches 5-7 because vendored
> lwIP code follows upstream lwIP formatting. It also reports generic
> MAINTAINERS prompts for files already covered by drivers/net/ and test/dm/,
> and preprocessor guards required when optional APIs are not declared.
> 
> To: Jerome Forissier <jerome.forissier@arm.com>
> To: Sughosh Ganu <sughosh.ganu@arm.com>
> To: u-boot@lists.u-boot-project.org
> Cc: Tom Rini <trini@konsulko.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: James Hilliard <james.hilliard1@gmail.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> Cc: Luca Jones <ljones@t0.technology>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Pranav Tilak <pranav.vinaytilak@amd.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Vincent Jardin <vjardin@free.fr>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
> 
> ---
> James Hilliard (10):
>       net: lwip: return ERR_ABRT after aborting wget receive
>       net: split netconsole transport from stdio frontend
>       net: netconsole: use unsigned port numbers
>       net: netconsole: cache environment settings
>       net: lwip: allow DNS callbacks to be canceled
>       net: lwip: add an HTTP client abort operation
>       net: lwip: allow DHCP to stop without releasing its lease
>       net: lwip: share one network runtime between clients
>       test: dm: cover the shared lwIP runtime
>       net: netconsole: add an lwIP transport
> 
>  cmd/lwip/ping.c                                   |  41 +--
>  cmd/lwip/sntp.c                                   |  19 +-
>  drivers/net/Makefile                              |   6 +-
>  drivers/net/netconsole-legacy.c                   | 156 ++++++++++
>  drivers/net/netconsole-lwip.c                     | 200 ++++++++++++
>  drivers/net/netconsole.c                          | 201 +++---------
>  drivers/net/netconsole.h                          |  29 ++
>  include/net-lwip.h                                |  42 ++-
>  lib/lwip/lwip/src/apps/http/http_client.c         |  71 ++++-
>  lib/lwip/lwip/src/apps/sntp/sntp.c                |   3 +
>  lib/lwip/lwip/src/core/dns.c                      |  26 ++
>  lib/lwip/lwip/src/core/ipv4/dhcp.c                |  39 ++-
>  lib/lwip/lwip/src/include/lwip/apps/http_client.h |   1 +
>  lib/lwip/lwip/src/include/lwip/dhcp.h             |   1 +
>  lib/lwip/lwip/src/include/lwip/dns.h              |   1 +
>  net/Kconfig                                       |  13 +-
>  net/lwip/dhcp.c                                   |  57 ++--
>  net/lwip/dns.c                                    |  24 +-
>  net/lwip/net-lwip.c                               | 248 ++++++++++++---
>  net/lwip/nfs.c                                    |  25 +-
>  net/lwip/tftp.c                                   |  54 ++--
>  net/lwip/wget.c                                   |  72 +++--
>  test/dm/Makefile                                  |   6 +
>  test/dm/lwip.c                                    | 353 ++++++++++++++++++++++
>  test/dm/netconsole.c                              | 343 +++++++++++++++++++++
>  25 files changed, 1646 insertions(+), 385 deletions(-)
> ---
> base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
> change-id: 20260825-submit-lwip-runtime-netconsole-v1-9c08ed87e0fe
> 
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>

