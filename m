Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540A4CA9EBD
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:08:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 132E540949;
	Fri,  9 Oct 2026 17:08:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DJ8Ne4x5z436; Fri,  9 Oct 2026 17:08:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60B60408FD
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565732;
	b=rdQ7W5GOxPSCJHsw3/4yxxxiUJGEbPeDj/TMCO3gLqlGxJLS+Nj3OA1y0ukWj3dsNaSM
	 Pom4tJYPVnVesIAdo/aJ3sohsGJ2pkkL78LSbNG1VW7/z18HOCyQxYBD+rNWDIDM6HzO4
	 Z9+K1gKAGLJAnLv3sF+Rzh7Z2+9IJJNsPjjCgwXsX7Ov0I97rXgFx3xygS7/I9dIjZrMY
	 lpT1/12TbwkRKXfbtELVK+n3c0dxUjVz3EdUidyssjuzfIDTsVagXWbOVufg8/KY5/Nzt
	 hmZlzCTBA8m76gjGSsIHA1PkxRAV7XNk9uQlU7a8iAAfBdsnSAfhlEhLtYPWP7fiKsg==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:x-checkrecipientrouted:NoDisclaimer:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
	bh=obb6DxQ3mfhu7379JFHYaGioDJ3VNdeDBXef9CPWSaQ=;
	b=fZq3CahTQRFl+4NtNwz0BsAhu80wnrkC79kKhkmft70w+MkclvaSKlMCCQqpS3AM8YeV
	 TdTGSdH3HkRksXkhUvcGSSILS+Stri++aWgT0FB7HHVuOB15uzP0v9ND/EVOERsSzc6he
	 IVncDJk7RIgJcgZvMKpMgBalIjUMMUESk5cONjVnn13gfmPcYjLCV15mCGIGbtrYNwbxh
	 pV6jlEK5PxWh/0Z1KigYSG1t1vC3m3sPL/llPjKiZtBo9SmGAeEMlP81jMUTlY1QUQtD9
	 qzd9AI/vl1ZnFQ8Weex2nDe2nceK5nqllxJL6YRFtayXeux2IYVEhnW05DDg40XCVlw==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=RVQ66ox3;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=RVQ66ox3;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565732;
	bh=obb6DxQ3mfhu7379JFHYaGioDJ3VNdeDBXef9CPWSaQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q468X4pnzixDCpkx3tTd6trKcbc2ynzFFwWtw6oFLNAeg+a+EEbud5HWD3H3A9aNy
	 g128joJhFCJ1K0+L9FXOxiVqvKMK43UnuFET9IyTiUG7lVpEfCh+aVD6wh7M/e+xeY
	 hoSWes3rmCam+O04l64YaXXfDRX+HdBHX1/yHY6FA4mYiySe8xz+H73CSadiawU7p8
	 lz3l6IlaqZ4UmfLd2s98+xvJfL9hU6Oze01dRGMVaek9jWgx92Aup5IYn/DLtKRThR
	 BVCpca8aAXp2RAJqOXgorxlvstqb2TME2TWuTiPjMKJHMDdy4pReDObOjsoXP3kTYj
	 UFlo5813Q3zog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60B60408FD;
	Fri,  9 Oct 2026 17:08:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ECB894E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02EC4408FD
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:08:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fl7Bfiz8NCjF for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:08:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0D88A408FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565730;
 b=fwInmlwFra7LTpSw/OdF6GoyhgboPlm3FXo00AM8eeJgHof2UY9l8gHt6V5zRueJUHIa
 rf+VNIhTBUJxBQsbTD/VGD6rRPpQOTQZG3K8sOdo4yMkCPOjW91nij45g0HQgQEqa+umJ
 +5UU54vPioZRh1q9M8Qc5AndaJ+epChTcynYOBqLLoa9BukuhohPXjoAbaECQUn2bNl2I
 EmTeeEF8vTv5kHl6Y8EyXPT85CYNQgW2F361/NXix6PtmJciWObL8aK3Yrd24Aklq9+EO
 tl2SJoBGEtxncxrRsX7O28HteJFIB7Aa0NgrgKW2lt46H/AkjAbLHiiabhQMjgnqKiQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565730;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
 bh=obb6DxQ3mfhu7379JFHYaGioDJ3VNdeDBXef9CPWSaQ=;
 b=sB4yv0dfg2GJotiwqI5Pe9KgtxqfyMVfSQY0PEL8tgUU7RBVKCdYjjvuSjZ/3Gqskqee
 MqGun9RyUebZGT7d8jKKZoZFrvcnRzVvkerB7dP/3JykBce6ou7Cv00GpR48ViJWeTxPu
 BdofQmpUAPhj/Luwwi9WhrwYFWkYSLjFews0yDHqZb71wC2BZcyeO2ijRhve9ycmCyaie
 CWLifTVuZZNAxc894iZ32gwxkXqC7yrKK0QJc+2r6EH1FFvx+Yjiw+KJ+CaYE8gnVuZvE
 B6V/swRsp8GFxUFWMeGqcYC/GQjOuTNlXP5BKDNXWcyP0u8nYew1tZznMi8gDS1KSvA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=RVQ66ox3; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=RVQ66ox3; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=RVQ66ox3; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=RVQ66ox3
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D88A408FB
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:08:49 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TTwiqPU9LFiiYORf42JRDmcAlcouALS8DgA2DEJ4z0of/BCJPoIXGA28fNixiOA0+T0WBP5pcLAl4he2z2DPmrg7DV0ZeQEtPfWj6CgbfyMjJPdWTGUEYz9ICiS6BkylviqTAfjN90Kp5VeNcJ2mOUgLIHDWxyc2Xyjmt8hSmKNTp7E8r2+0yA4zeO0aii5qJ4Bkwj+nfbFUXfe0z/tj6nENN43Zty1nvyu+8Rt9KoZZo6meb4ZQv9vn/WWhOUf7T1rvf1Otllz4I7wbqRAOC/tLUOL5zp48mvCBqqK7NsDBZT9hHvDmtkpx5thB9CZkwrtQwnjTvQKumCxr0rCbRQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obb6DxQ3mfhu7379JFHYaGioDJ3VNdeDBXef9CPWSaQ=;
 b=Zdwu5r7nIVuOSkbKYO+niNDcOzH2Qfrsq1JRVkVEaN5QIY5xcT6ftIgrTc35JW3dzfg/RO75BPCeYwpW9kgvcwEqIy7fiUthwTCd/BnXiJBEhgpRxzHD1Xh0pIY61/txX2fS6liOMgHZW1UFPFn+hMQULtHrtH0J3nxJcAMHra6KSAdEQqR4Aj2jmhPLG2+Hf2GSb6pnytMWKlDnuamgzhsJ/H4CI1r5LdZdvGBvJP6HCoxKdRwKwQNpODa3hAGvxKdYKiXHZaUBh9Iu61d2txquqYR48jbznVpa8hRGUY0EAIIjXGm7rpx5zydCe/wbn8X/Z7xRKtxCvkKRLQSB0g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obb6DxQ3mfhu7379JFHYaGioDJ3VNdeDBXef9CPWSaQ=;
 b=RVQ66ox3/lCLsjyhUWlTj9eIxFsMoh2JjN7k6l05rhaSRsTUTx7PZ2zE6zRpP1tvI+EmdN7z6eRtcpBW2BPuH0oEPlG96WJdiQXWL5F3ukJoFtp/tVx4Atq7Iii/gsAKYH6Wm+gIYtlSbtXSBVsrUIb8MKr7mVnTdkZ23mNrWhg=
Received: from PAZP264CA0064.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fd::20)
 by DU0PR08MB7637.eurprd08.prod.outlook.com (2603:10a6:10:31c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 17:08:43 +0000
Received: from AM7PEPF00000057.EURPRD83.prod.outlook.com
 (2603:10a6:102:1fd:cafe::55) by PAZP264CA0064.outlook.office365.com
 (2603:10a6:102:1fd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:08:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000057.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.0
 via Frontend Transport; Fri, 9 Oct 2026 17:08:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdxkNf1QufLLaep6FHuwgxPItrFNC1xO2812pvEnZrH00maAB8eHQeqzi4BIyYqQBCuMZRvOX1DWguR3MVUwwewF8f2anSQPwKavNx9TFqIcQoT0aTQFWZuIRXhZJvW42anEFZJAM9omxcE3I2eYmxc/28C2UojtZXS4oFeRQQuoIjwXB8kyGp9TTOhBObVrsdewM3cnHJ08tduz4H04ZdohjDA0W1qQw8tiJ20/egC8Y3a9L01NB1aMPxPGf8e3m6sFi/lrKhWnJYNQlxuM5XpT+BG7D5l/7Wg7HYgkYF7A/h1fp9tuiaMuCZo0avIIumsnNr7Z0m6yNSOCbKRHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obb6DxQ3mfhu7379JFHYaGioDJ3VNdeDBXef9CPWSaQ=;
 b=ElysJGa97hhQBtvGxHUHpbNTYw6FINRA3/0q2TftIh/fP0pSE2wvqXrNevQUzj0ZWHRSac5MrgwOTY+Hi2snTTSsMUeiEUxLT3Dyh2MZ8drNGK5LAic3cn2Z13GHcnioLlxr82ATNGid70BkRY1VCwvAQ29T12EapSUG/9HuNMaWhCKTXCYbLjBJ3i/5aqhASY591x91QwgCl9tJhyXNEKMXfNnpiU4ESSnPo5/fHfDBD2LmeWye3El04mXi80dBA/PYPD9faXxFlXsFSEFtMeT3BKICgrD7ZTABcuZU4iTMVTeu+GULqcCdTYhRlWDrNg+CSGJH2O6eyGpy/fcs1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obb6DxQ3mfhu7379JFHYaGioDJ3VNdeDBXef9CPWSaQ=;
 b=RVQ66ox3/lCLsjyhUWlTj9eIxFsMoh2JjN7k6l05rhaSRsTUTx7PZ2zE6zRpP1tvI+EmdN7z6eRtcpBW2BPuH0oEPlG96WJdiQXWL5F3ukJoFtp/tVx4Atq7Iii/gsAKYH6Wm+gIYtlSbtXSBVsrUIb8MKr7mVnTdkZ23mNrWhg=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB075028.eurprd08.prod.outlook.com
 (2603:10a6:150:381::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.5; Fri, 9 Oct 2026
 17:08:11 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:08:10 +0000
Message-ID: <c9596795-9532-4675-82bf-d830f1057589@arm.com>
Date: Fri, 9 Oct 2026 19:08:09 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] boot: pxe_utils: Fix buffer overflow in pxe_label.num
To: u-boot@lists.u-boot-project.org, michal.simek@amd.com,
 Suraj Kakade <suraj.hanumantkakade@amd.com>
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>,
 Francois Berder <fberder@outlook.fr>, Rob Herring <rob.herring@calxeda.com>,
 nd <nd@arm.com>
References: <20261001040012.3491713-1-suraj.hanumantkakade@amd.com>
Content-Language: en-US
In-Reply-To: <20261001040012.3491713-1-suraj.hanumantkakade@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB075028:EE_|AM7PEPF00000057:EE_|DU0PR08MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 1844ed49-8b5e-40e0-8193-08df2627f8fa
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original: oPFDijytc/Pr7GDITp103Pw4RMSIzq+S6j8+KqV1IA4MiNIb1uNbOwvpRi4INqPoTtUAoqhTVdFyBPqeD5p5caZTwSqVUPN6//l1RiyNXlRGj00ROi35T2XQXB/xec1IxONQci4Z4063z0OiWrrO8mFv+FPjdfYduc5LKpik3yTYx7hiSKJmBIYhoCKHjb3Wye7iaTTY8x0SeVM21tHUaVP87+ob37hiV0dTjmNB3R15OwafxLpjNZavUTgUEGrupGxJlq0UE8lQepEJxBZ9YK8ziItWCFX/F27HC1SBZYGZWsS4g7DpIwV5qXA99YvWmZipvZVKAtn2nAeFydcOtM04Yu80Vnd1+HZ3nOTO4hooHc8r6haGv5s0SPh/L+w6nDCSBgq/OMMIAcM9OAAMynyVeKfELxGHJdQi5CHY+FSQPtiNKN8CiTUya3LK2Fg51Yjq+nXtizliO/p9RNJTNJZLEPCjBio1UHtvo/sVSjDQyg0V/itjx/+cYJVp0gf3bRrzAFmg064l0nfjuf4NkxxQSshntj8wcU9unvyXrdtpVg4y5GDz9OvzSVlXU/1aY7cs72Zgs4IgPcy6MIJiEvQooqV9etOIiJz9auVJfvgvkHFIFGZOAQb+vNHHwHF3uk4NFkNT+mkCs/foe0p4TXdaCAcn3UQ0PaSUrdZY8qc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: RsQWS1Xv09yTUGNrD9OpEf7M7GldFPj8Mx9cfaoQLT0Mr+hWWtIYQ+yHkEuG+UkaljBqZjJn1GZiW2CJw3vX0ayuPzNO+sD9qHIx0XFjTvhYyRU+tCMGr3WptBH/s/oRZUujDQZrBmgERO4q8CjziuLxe26971bXLoCOfkIQoYLOZAJVxdp/klvS1h3PZgjEtl/gJa9SD8QinYzd57Iv771rjprJqE7SMg/094VskkpO4wrkGHF5d6GPClE2c8sDr71XsJQ0PhocX1W/BvGnykA3r2PVq+Xy9iZSFMDBe7bk6/EX7461BspUjBjSpw4NvtHNZuPdYoCkjdIHyIbRvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB075028
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7PEPF00000057.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c5d6d487-e2e7-409b-c0fc-08df2627e5a7
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|35042699022|32650700020|1800799024|376014|14060799003|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: GcwGiIWL9C6ztuc5TTjAp6Zbtw3Eh4zmeFvkSshJr4SJju/NskDMeuoQW8NupQrqycYQkiCmAD7eyR2/nlepyAtx0J/ffjBxrfgle/FAogkVd/zEfYxAG+XyhTjPPtTzLAIGggGTmwcQnl2PAnRHHQwwhCZ0VyOXjn7qAXcT7lX1W4YqW6DY5w55G3ONunXtW/Z6fqkD2MUYGKGMywYZGfWA/x/06zhKw8gA3ax5EfO0pfkQG1wr7N9xfEYsMXO36osl9W2XSKMoC6VU0aX2G+cDA1SBThzq/TnfG3iQUMeUNFMmdWd6/RAIlTyr0i2M9izXj7XfKq3ecTdpeDGPOQcYwNPV5cZXQeEKjC81WD4zl8W1WD2DiWdadS/H3/wU6SOKcoHH6kAUXkOGPKakdpIDUstv3CshBfs6Ki5/x0tBK2BSvqxEJOlM2Vv3mYivOaLI5xLXHGgA32EXwm2+xIod79AAwPaNDftniWtR/GQ/52Fv4zun1rbNCzA3EdU72VJkbM3SnAZ5IH80PdahlDrNuisxY7LEj+1HdaM9HApn5dwDvhVQrENyt86+m/2vwEyRsuepwKkBglshgf7ldplSdtLUd8KttV3Vr0nbw+MuI3Z7ywgJSpWzrcrHsAGzKde/gPg7Gq2Dj8C9PwmhQ3Buew/yKRZcrUALQrmRRQzw2S6KbJraL34lzGuX3CIX1YbjhgwlMPnmi05Fw0vR3g==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(35042699022)(32650700020)(1800799024)(376014)(14060799003)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hat0PemCp9hWMbYVr2WtQPgVw+3waRgE7kpn4yfKVFNdQs3d00Y4MQ2x7vgqnc6l0Vz594EEi/ciKWqk4uupARSvJnoWM8IzsiCOaFT8H2yfVmaZr6ltQEQ2z7h9gPsQAo+Cd7ivNsWVgzyIPC2kJPyu6NS4H/uQpLvZq39200b2IaEixH7za5X/21Si5aDWOciQygz3QL7/7TepCpJIjMO0UKf1Oc06Qi0SRQ+Zo2dPmR5E8/SetcEjTsYTfD8pZCK6EW0cGMa2Xai+qcz0od2mG/4XtIbAFN7qF9sh99IDkNKC4VOpBYCeMrd19XJiv3x1fbK6OC6I7DWxJwEpq2ti9Um7hbskaGHKZyu0W0c9JHlYgWXPuLb31HKAoDw9xnoGLE/6CTuLDEoBNAcjEsP0hesswvt1NzxzjL6QBjnuQzbIpQYb2Ryb9R64av6Z
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:08:43.1747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1844ed49-8b5e-40e0-8193-08df2627f8fa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000057.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7637
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

On Thu, 01 Oct 2026 09:29:57 +0530, Suraj Kakade wrote:
> pxe_menu_to_menu() numbers each extlinux/PXE label with sprintf() into
> char num[4]. That buffer holds at most three digits plus NUL, so the
> 1000th label writes one byte past num. On 32-bit, name sits immediately
> after num, so the overflow corrupts the name pointer and the menu prints
> a corrupted label. On 64-bit, alignment padding absorbs that extra byte,
> so the overflow is not visible in the printed name.
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

[1/1] boot: pxe_utils: Fix buffer overflow in pxe_label.num
      commit: 2a64093c2f924bc072aff39ec6bfd77d32cc8646

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

