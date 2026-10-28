Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32BD606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NwdP3gxW;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wJOnSkov
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBC0580FC1;
	Wed, 28 Oct 2026 11:13:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fjrQwAPRt-0i; Wed, 28 Oct 2026 11:13:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0106A80FB5
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793185984;
	b=andzY87y+hCh3+ztigNyZx/PzrXS196nDSzLMExIA5gtJIZC60PCf/1ml4DtybN4noX7
	 O08mL1q2i84qp75+kpAy8DwHly3Jm+GJs1WQcTXuNlrfQHVsjTMj4+CnBCgx7HHVd3Yqr
	 ry5pJ4vkPMFZx27Ya0INWolFWupE6bOJbFO5GAaLRRtgZPx0/EHc3BmBUaBL5vhtqa4UD
	 NnXsZbV4T/VAFM7nvTtlvC3SU7Ad+4JPRybbCg0eKYKyyW0A8D42OglTme+GWsWF5yxIK
	 dO1l2VpNWuYfSI8fOtnUXgGVoJ2miujJ9ssBXQwUXklZILlFcDScyoq2lDi7qFZrAAQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793185984;
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
	bh=JGTp/BjTkQ5ewghgydIhlEuQPm95cFZKjywsV/UJmes=;
	b=Z45oVsfyohKXjEnoitEx5vikZsvDB0gadwGO4udxkKRElI6RZT9dvG37yPhnZIYwEFna
	 fcKLkU5KyWFmmEGNnulbb7s3zMzxdDbXaAc2yXXRZmJPAgU7ovXxk7QnEU8MVZT2dfxjz
	 zwowewosM9w0iVNm7nOK2h9RNvAmrcsiLZFy4H1LF8IMj1WK4w16tVqWSZmEjV2BAOM18
	 o0zCxUCKKZkAXr6LwINACS3cultuU9qcdl8imuCzv1T8e+mFhGEXquHhLmSoAdcE4VGqK
	 YyzEmWPL9Z5ljsPLxWRrrg1wnt6IAJz5+iFwGpTgX6xlfY0taV9AeevfDmFJrAZCQqg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793185984;
	bh=JGTp/BjTkQ5ewghgydIhlEuQPm95cFZKjywsV/UJmes=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NwdP3gxWFXn0tFu3eisD/VDKTOyfVtRw3KItAdcA01aQubXCnKjDW/VTbpVxiYegJ
	 S09H6kta2Q3lxs3bLXVfdTDDO4qJyRSXgKPmT9D8b6qsfmHAJ8s8igC2hjZAio0v2I
	 KWezS+dV/Bq3RSHNjYGCtYNzZa0Ky0YCsQnYIGLdf43NaK+mN3u+ojeVtgqeHUoehj
	 CbSyE/SUIuqqAzUfxuFkvtdadS0AnONs78J5D9+jen5pMLixl4N1ng5HXsXaZ0HR28
	 8S5mAiVL+SMEtrqlOxXuZ/+vX+1H+3zhMSIt809F/QtjQGrY2qf86xrrxK8usfplLe
	 7TJigDfeiaRfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0106A80FB5;
	Wed, 28 Oct 2026 11:13:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4B37972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6FBD40087
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:13:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BaFkGvFU4GVa for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:13:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EFDC94006F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c005::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793185980;
 b=ohXo2tEbVZD78LieIJgRaTo7wG9u4kJO0fwX6qknE7vVXudA4xkidyoJvr3krNMoBtOZ
 EqP+PJ51HN8I6ypRi1Ww9x10ZU9rEkQehNF7IIIaSlkxtxPU9SSVBPvrkvcNPXwKUDEQ1
 /jve3yuppybEd8zNY24mOVZeYSBb8JqoJse2PVeWWu8/GBuDvqug4sUryn96z2/jSP0a4
 2G4ZY6kwBB9+3sqdHO5k894MB2uA0T+UtnyHrTU1uQ9PvLs65X5GF0CeHd+bo8vhfrXkW
 uYgj0DzVf7AEIPQzKzh2flK8uUFKDI9e2yekoFauNoDB2IEFDX5vSX5Gh/Vhu1zLWRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793185980;
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
 bh=JGTp/BjTkQ5ewghgydIhlEuQPm95cFZKjywsV/UJmes=;
 b=iy9BQ0Y/0fQXGT0tj2GABV8pMPTgDfy7yp/7rcKFY1eLEZyz8wau905w7QGvSonlE6cM
 HfOb5tfPBu+McDGv+qzuKnKUljWCBumc6m+l4G9dnp1Bz5DkwiBcMgy3S9nU/MXj7B/NL
 CRMmTk8aaZXpMENMPUOrXZkFBPHSJMvl+Vcn2td+bk7472yO8qfq6RrqNmg82AQxMfsxL
 pxTraxHEaXiuQkDg77h0Resj4Z/mzUTRAPgJrWy/grpC3qdjVPi0w8BZhoLpBcHeOyKEi
 yQV83ecdsxEFjJ4eR2Ei2eQ1ZIQ2erAP3w1s58D3xDQP6TQk2kQDtDlFX55TrnVdEXg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=wJOnSkov; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c005::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=wJOnSkov
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EFDC94006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPl/SNzE3xDQmanOT+DlGj/dy1hXv+20vkUrqMSIROdn9kqAQBv/8J9KfGw6Fy+T7IiXxTLSsHtN6+hQ86L+wlweHVU8kkY3iLpwrjZyy0kVpWwFNw0Ni7nh5up44kGYgZssqBwLAlPZNAioh6m+kpzFUSBmSWi7+zKzDW5x4iffVYbScj9Scfi7taIvLQwFXdGIt6JhlhdLCs/TyPLWk0wIZSZlUoghTVr/i7z0pIJThBDNXCqBQZsPdnreZQqJLVOdwP4TFr5HWfmGRxr89ZmXTwx5mAXnLPaOCnKjyQqUwZ1gcp1T07U6hof7y7FL5ZfIaYEqmP4DFDop+M0PHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGTp/BjTkQ5ewghgydIhlEuQPm95cFZKjywsV/UJmes=;
 b=rnvdKV/3KYa2BOkPZ8t0MzgO7c9iqrIf895KG1fUMfV1H4SjnVyvv6UIRtG3pSN1xpN+77oFwD0zLKicoQBttrF9iZJq05ZA60WPZ392/LwdyOzvH1xKvhO+WdCSNhlcvlEM300SUa+Qmpb/MU5GXcHzJzyBFTxGz6vbOdYQcxHKrOdwwnlPHyYwF619VB+eQr31ndEfw52itihG7lJLAYVwXJRGWJ8FB3Q0qvnPbeeuK6OzY6t7nqO1+6mB1Mycvek/sNWYcJU6pOIMiu02fy5lcxzInETLvg8I3n51mWFz6F0GFV62WtU5ZF30e6Dfkyd0i98eyz8zFy6DZctITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGTp/BjTkQ5ewghgydIhlEuQPm95cFZKjywsV/UJmes=;
 b=wJOnSkovB/r4419ds2QBgXSFXJE7nrytyzsj/6SCumoKrUuT5mutwWdRsWFkitzumLKt8lqOHXLTIk+yg7HOfmBwccxRpzzGBaOtouH9CyHhZO9cFUAL3lEt1ZFWfk7pM8GQTzFR5AYW3PYsYKWZIUMHKCLomgCj1FFQkNBgc10=
Received: from PH7P220CA0172.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::33)
 by IA1PR12MB292992.namprd12.prod.outlook.com (2603:10b6:208:5a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 11:12:54 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::5b) by PH7P220CA0172.outlook.office365.com
 (2603:10b6:510:33b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 11:12:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 11:12:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 06:12:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 06:12:39 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 28 Oct 2026 06:12:37 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Tom Rini <trini@konsulko.com>, Akshay Belsare
 <akshay.belsare@amd.com>
Subject: [PATCH 6/7] spi: cadence_ospi_versal: Enable the DMA DONE interrupt
Date: Wed, 28 Oct 2026 16:41:13 +0530
Message-ID: <20261028111123.1198451-7-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028111123.1198451-1-padmarao.begari@amd.com>
References: <20261028111123.1198451-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|IA1PR12MB292992:EE_
X-MS-Office365-Filtering-Correlation-Id: 772e1500-dc35-434f-73b4-08df34e469ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|261026140227099003|11063799006|56012099006|261026121527099003|261021121427099003|261022105027099003|261021123027099003|261009223327099003|261009223027099003|261009221227099003|261009220027099003|261009221727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uGoFF4xuayLhAE74lvx2gvdB+TRzillKm0qredzygka4KUDN7C/4TGtJYsREGWxVnJKzJ9UMuCaUnQkQIy1tevbqlrrKySAGiIKiws8ZeXEhtB11MEqUaZQKBlJl9ZoLDn0H5BxRBwgJDNxIPqVrKAdsI6WrBM13QvD7CNgB2fUCiGoly4QD1bSe3rjVX1AgFlQoKvxtSOX5P09si2ylroSjWXaCCHs6nWsKXgs7CuFoQ1nsoaQkuhJ41xtQks5Y+mISx1RDPIoJU52RAUTsTcwpRislRC+vLAMa3gzufYQMLo796kK4U+y+xOO+OaoubXSWSDq6S9LTL0BucXZkp4f3Ezbmp4oHoKuoMDXgeDCOMmZrwRzFrlG5JGOw9el5aSJ6WW4tEWmy3qqNloY2YcO5Hk/RMK0yuPjh/PUa9rHYWxZVCT6rEsAUwnVjjIst4bmV/xKwHc9nl0uyZHxxt3sVIuRQYLuGf4n/2cdClNRk3zu6jGqtBjFu6zmiRfz84cBQbAuRNr9QtHUp9uvrYU2O1nozvpJWGyLErnH/SU10g31N4WQQrTQ4dM3xgMfJBI6Ekn/7G41Ond/BJFsSqyPQh8wJCCuFgtm9Q4SHCA7NDLPFHsPs6EuOlp/fy97oaSzdrCdYq0I5m7Z8IM4qUpUyiqeHpJ11nMHNCLT1QOoJxUUnPer55OzkLtuax7VFKFnu7C78nhIu08EzYhLlMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009220027099003)(261009221727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HBjuLLs3+u/UxSzbv7rGjUk068bUC/b6ULV+FZn5vDHrXD5LOp8hiVTXVkimfW805o6coZjy1c3EfiAgHgSvlPQtjxuMvGAlSVhb+gQS9Rgg9rTUFuuSvtvdBPZWPg4AasG4ef/IwYJ5PWpg2wFdFos/7qjdUMM7YbTvONy+oey7BINfhiFwUA5KTp93tPByR59n0sQHJlc7ehQn6ou5gZNO369YM5R6JJQ8GYfgZy3UJBVtTLTE+ckb89SfIEvsbDcje6bIUFrtp8pYKTajUcjPDlQtgHS4mvzKmDu5WMBd9z3UqSo5Orl0vc0YmDo0invOmiqXrXkYDGl+XuXybr00Y5m1KMkk13Nmw6yFppA6/HJWMpvoqA22ogLLoUMIKH9l03N4+TQK1CByCzx7MYlfwERndNmNjLmBEFixFpJPV4I6aTnnx4IfJYCPMB49
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 11:12:54.3042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 772e1500-dc35-434f-73b4-08df34e469ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB292992
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clear all controller interrupt status bits and enable the DMA DONE
interrupt in the DMA DST interrupt enable register before starting
the DMA read. Also poll the BUSY bit in the DMA status register until it
becomes zero, which implies that the DMA is done with the transfer and
may accept a new command. Return -ETIMEDOUT if the BUSY bit does not
clear.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 20 ++++++++++++++++++++
 drivers/spi/cadence_qspi.h        |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index f97bf744122..0133c92b60c 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -50,6 +50,12 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 
 		writel(CQSPI_DFLT_INDIR_TRIG_ADDR_RANGE,
 		       priv->regbase + CQSPI_REG_INDIR_TRIG_ADDR_RANGE);
+		/* Clear all interrupts. */
+		writel(CQSPI_IRQ_STATUS_MASK,
+		       priv->regbase + CQSPI_REG_IRQSTATUS);
+		/* Enable DMA done interrupt */
+		writel(CQSPI_DMA_DST_I_STS_DONE,
+		       priv->regbase + CQSPI_DMA_DST_I_ENBL_REG);
 		writel(CQSPI_DFLT_DMA_PERIPH_CFG,
 		       priv->regbase + CQSPI_REG_DMA_PERIPH_CFG);
 		writel(lower_32_bits((unsigned long)rxbuf), priv->regbase +
@@ -73,6 +79,8 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 		if (ret)
 			return ret;
 
+		/* Disable DMA interrupt */
+		writel(0x0, priv->regbase + CQSPI_DMA_DST_I_DISBL_REG);
 		/* Clear indirect completion status */
 		writel(CQSPI_REG_INDIRECTRD_DONE, priv->regbase +
 		       CQSPI_REG_INDIRECTRD);
@@ -152,6 +160,18 @@ int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv)
 
 	writel(readl(priv->regbase + CQSPI_DMA_DST_I_STS_REG),
 	       priv->regbase + CQSPI_DMA_DST_I_STS_REG);
+
+	/* Wait until the DMA is ready to accept a new command */
+	timeout = CQSPI_DMA_TIMEOUT;
+	while ((readl(priv->regbase + CQSPI_DMA_DST_STS_REG) &
+		CQSPI_DMA_DST_STS_BUSY) && --timeout)
+		udelay(1);
+
+	if (!timeout) {
+		printf("DMA busy timeout\n");
+		return -ETIMEDOUT;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 86f2fd639c5..7efe0454936 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -192,6 +192,7 @@
 #define CQSPI_DFLT_DMA_PERIPH_CFG               0x602
 #define CQSPI_DFLT_DST_CTRL_REG_VAL             0xF43FFA00
 
+#define CQSPI_DMA_DST_STS_BUSY                  BIT(0)
 #define CQSPI_DMA_DST_I_STS_DONE                BIT(1)
 #define CQSPI_DMA_TIMEOUT                       10000000
 
-- 
2.34.1

