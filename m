Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CCFCCA490
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 22:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06D8C80F1B;
	Fri, 16 Oct 2026 22:13:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U1JD7_CvDfmf; Fri, 16 Oct 2026 22:13:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3E39080EA4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792188838;
	b=AociYmLw6kHvXWRoSKFNwret5Ay3zCaQT8gBtEZmSdpt9mwBsKwqhoYBN4T999AFLXIP
	 VkCo8dXanQhl2LqzGwtIjZa0/nvhAxCMvR5Dd483z49sZn+j/JbPJdGsANpjKkblrxOMq
	 bETMb9zqpIuV08mn0x4dmp3yOq4qwTr9uBbSGxjtD5M8VFuZdvTZqb1E5EAmIc1bDxIHN
	 uT+fMhn7w2AFDB0RSUOK1qAZTYeFZJlyCWXPPPtm5RneHpAiCZCb918a7PsKNQSpCBwTu
	 090Sv+aMv4UApSSBlXR/WyPytGUlYHqoZLxX5hsNM7f0GS3Kti0JQ+BWF9p8TLwZfmQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792188838;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-EOPAttributedMessage:
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nDM3ZHcPEP3a9thRknR/goZ0szOHFwOYeYTsFqSmqSM=;
	b=pt3DUlxgyDQ25WadbvMXfyED5bo+X/KNGfLNo/b7HnfjD3AfLOcqnV+rZJA9ZhenCVkv
	 zpRd8EMjFavGzxzNnh6+8yD2fndOmPXSUEI54HKP+qDGT4MHtZx8ebT5KyzMg6wvnY6bK
	 lSpf+iX5E/tqLBFq4+zUnVg70+ywDFE1tK9Ykq3Mo/biVnN8xPtHRqVuLBBSicLYTLZfc
	 oJqnjDaEIFJDC9YPYXjI3/ha1VSztO9nCR/6xYkXAYwcIKL2rwFU3SMmLuzSGbPy0FHxS
	 6xIrphME7YvBHiWh94Dym3iABYXYqMYhUoKxLo7HoRUjsA3BID89YimLrcjZQNJZkCw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792188838;
	bh=nDM3ZHcPEP3a9thRknR/goZ0szOHFwOYeYTsFqSmqSM=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AROyciiMC841unk/dEO/cP7R3n/jZu86kndtQqC4PHw6prn/9vKvc6dW/x/zaC4PN
	 p8WeSrdscbTiX/rmrWPHiuwMxB67iuS3feY8tpL4jrTiKH00/h1r63iNBd6LtUTUk2
	 CM33hlQnnMwZTGMWrsKUOSwYNxZXkGolsEuehwsifDukNIkmWDpPk50oS/Xphg4AAd
	 jRsM3DuoiBhUariPKGqQRyza93L5Ooii2CSYVBhlPkC4qyuQqQYUoTkyAIFchMYvUs
	 qEsh/50+GNOBkAamE5XhkmrS3zY3GHY3h0xnYtNtUOBgYMT01hAg3Mrjqij2oCkr5Z
	 zeuM9KZotmRZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E39080EA4;
	Fri, 16 Oct 2026 22:13:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 228D575
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 22:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 148C8409C7
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 22:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mXV4RbDADP1I for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 22:13:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A3DBC408BD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792188836;
 b=sjRvXb8F+PnxNsEHPr5Ql03+H364GdKGli64OHr1AjgKGrtr16ualRKJaV4HP3MBZMLz
 Cr8qYPNpjcGev6BlUWu3TlYAmJYlKYx9w8TmJztM2nWoQvJlScamvM/cavZ3YEHFST1B/
 aZJJn90Sec0dHfHx6Eb6UbW/R97Os79+fZ/Gh4U7s0YW/JLLYQOpvOjbZW+PNkmr/hzMe
 TDGqdO05sSq+iwCl4pUeYUHSXfPNSygzP5bl4tjDBu7UOsTEENeOloU5OEv3TyS5wxGhf
 cvexyQd0bfM+CXozNGeMlImWQqq9eyua8piYOXbztUxWODapiLiZs7n/bArHrYp5CyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792188836;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-EOPAttributedMessage:
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
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=nDM3ZHcPEP3a9thRknR/goZ0szOHFwOYeYTsFqSmqSM=;
 b=ZkjljYAfqBEpF20RveqBBmAWYaRhV0SQpLwHMXZRNVs85bRzU4XyqLVQVw9JA7wKzT1t
 1axe4TegSH2RJ2pxm5+4NKMgoW68SSH0f+RES4yb1lWue1eXAuA00Cxs/ngPmjluDwWWt
 sK39JWkuXBYeZPGXI2hUQlZM/cVTm+BA7xF2rfqEMvALTwympAhQFqec5wiUtPq8jXMSe
 VvsH0ir1uDKDBoCHHthInGa33tj+mOx5MPaHr31nrHAk/80dkGDM9z1T6NNxncI3vsk5x
 bg9sK3FjuDva7qNFF2Al9xcl+JMrCfcSAWcOKgVzoAkipUd/56A4Riy0KGuYlxGEfLQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b="kBKv6aW/"; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=qyi4EvU7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=kBKv6aW/; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=qyi4EvU7
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3DBC408BD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 22:13:54 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69GJh6KA1440123;
 Fri, 16 Oct 2026 17:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=nDM3ZHcPEP3a9
 thRknR/goZ0szOHFwOYeYTsFqSmqSM=; b=kBKv6aW/LJwibABFyMAJAvxvQaAGr
 MdIkgL+rLl2B85Vcc3rx5GVJcKH1/MhbiMLAywi58BOGZKEroRLYSYUm5QtQISKV
 dw4B6Q1EZBjroqGyNc40L6lpO2J7LyU0yMZ6fXYy353nLAwP1GkyvllFDLOpCoHH
 0yKeHceI49MppTT5blSqzLQwlrucrEa1kMyykgjMQ3po1mmTd8vAe/+VXEPf3uxP
 6WiBx5jzFTI/EP4/OePGSzkMaDsTYmVbS5sbTk5bq9JV33who43g7JZmGrQgd6At
 PQ0RDWpskb7ZjMSCw3Cex5mqTdhNyZjbWqX1jaV+Tc9aVIv/+JMXJDASg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
 by m0380145.ppops.net (PPS) with ESMTPS id 4hbk12k6qm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 17:13:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icCC0Ue2h5lMNQHSqpaZsvB1sW/oio1+aDb199f0GlJWYy+4tTmsI13zRbmhe88YSLP0v56k28SGV5CRBS/6ShkWPrkC1k22Rwlz66Pnrap5uw2RcX/8cMAhUds0OmGxusStIKfyIJPZoHqdW4ef/eCawq6olpaXCgUEisjiVhEypLqVg1CxVNifKhpE456Iv6HaOSgyru+LqYbECRmYDpHGwdKmhM3RwJvtB9evPDm2HR00W1hxyihonBk27yDwPa8LekUZIrE5EOikphRm+BEQz4TuwS7cjhCyhAv77BjYcfvMZJcNEQBw9TRm3kYP+gvwXZkgC5SrAhDimdN+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDM3ZHcPEP3a9thRknR/goZ0szOHFwOYeYTsFqSmqSM=;
 b=wW134gu/BGiDhZB4ush6CNcCnudAG3Y7nAXSsFhGkbMXaIpu+XPuDV0Dw9Evc+SUMEl/1p0LqETSopP2UXkkvZeQQU8V2LfU/GuYFhQW18aMGMzONz6Vfl2r6TSLWpqFdsI6tyS8dcSf586Cdy4iShC5Iq4HNXmcuYMyZ8o4Dw6KiNG6pZXFGBTvhixYDUBTVRKN64yWWKY0bK1H8il16WFqGqCE373B9JaI5/vDpU7wcjQEwP5/oAcfirD3py6UT1pAqk44OjT7l/7bObB9DDWunXH/9JULTnVHCo5A8bOh6dc7UYiLXjI2hXEi/i5oZJjdXhASSnNmh4PmE4nSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDM3ZHcPEP3a9thRknR/goZ0szOHFwOYeYTsFqSmqSM=;
 b=qyi4EvU7iVkVcPGMF2Y6XCZLIyPYR/JmKQFpxhpUcsO01mE/cHZ0nwsJsRRiRwU+tk1xFx1zMHqCTu4lV4sDqEBLl88zxaJrwcg5G/JNlI/ShHlkQPHpAzga7OnRyBoAEf8l3CxcLW+I3mUjc/0eluJ+u7rR+qii10jyNkhQaEU=
Received: from BN9PR03CA0338.namprd03.prod.outlook.com (2603:10b6:408:f6::13)
 by DS7PR10MB4893.namprd10.prod.outlook.com (2603:10b6:5:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.11; Fri, 16 Oct
 2026 22:13:49 +0000
Received: from BN3PEPF00022BBA.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::98) by BN9PR03CA0338.outlook.office365.com
 (2603:10b6:408:f6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 22:13:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF00022BBA.mail.protection.outlook.com (10.167.248.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 22:13:47 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 16 Oct
 2026 17:13:16 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 16 Oct
 2026 17:13:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 16 Oct 2026 17:13:16 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.75.137])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69GMDGKB2359564;
 Fri, 16 Oct 2026 17:13:16 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 16 Oct 2026 17:13:16 -0500
Subject: [PATCH] firmware: scmi: check if BASE_DISCOVER_AGENT is
 implemented
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261016-base-discover-agent-fix-v1-1-113519da193a@ti.com>
X-B4-Tracking: v=1; b=H4sIAHuh0moC/yXMwQqDMBCE4VeRPbuQRMjBVyk9xGTU7SGWrBVBf
 HdTPX4D8x+kKAKlvjmoYBOVJVfYtqE4hzyBJVWTM85bYz0PQcFJNC4bCocJeeVRdk4eBi4G33W
 O6vtbUOe7/Ho/1t/wQVz/OTrPCz5QKsB7AAAA
X-Change-ID: 20261016-base-discover-agent-fix-d6e0e2ca6332
To: <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBA:EE_|DS7PR10MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0c4504-54bf-4244-66d8-08df2bd2c061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|261009223027099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: wul/Cwn2CuzBlUlREp1VXZB6OZ6Q0KmgB2LWykIZOq/DZ7CiT1KugQuEZi3KAVbseknIGxlNani68s2VKVsjU1P/hqAYd9XRsYa36Ucx6vYyCleGP/z8axH+kSe30aj1b3GHkf2WJKZY5iB2Ly6dj/axMI1Scb1HCN/LA8PzcR8KpaUZD8ZO16lq4OU8QhnBlDFu7y8mf+DViZrD6RQTHdGp4RNZjwFdhc3t3tD4kkDgM/ISdVppluj6zx0dA0ZBbrd9MFwpUYFU+KQtTVY2RiRDDhGG/ik8437b3x9ZbeTOe8GxuVv6opMHLf1K4UVhQTa8BY+FKrG4W6lwBT6Bwqd8iu+i2ffHkfQNdUaNsdX+JS6zWUpIRWajxz7v2QN0M3r2fiScOSYzwqzsr36sGWXI4sxF4dpOtmq2/hJ1SxwAQ9FLUHswBpmq79fQsMG86UVWlzaOjilZikwhDbdh3EHqriOycdRfe02wF1KS0wzyAV3EsoKaehfGr/ZYGROjOXO3W8d9+wvHQUOeCp5FNxdxlF8i0PMW050ZOpF9cX8bn5HZQDNyO95O96zPFW9+nq8b9Tj5C9YYyYR76Hb4tRrTdyixlJfhXW/C4CuDZNj4JcWQyYTUTg9Sojsaq8G4YvUjlynz7IcIe+QGLfX1EnTfqc4pNhAVwfoWyEp33JuPM7bdlhQzbG6pKgu5QMsxlFTzEAlc3ylo3L7Jz2ejEA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(261009223027099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XelYu7hlzi0H+rEvOz+BaOa2w1DM4ty0+SS5HjJS9HuCqkSdzEYvTRImCjfkrOCPN/wkfahSbvaqUF1uafKmaAKwxuxUFIpKjNSQv4FFAlGHY9NeOxzSVgcgKUopvLGgf3pd2d2FpY2jgpaWTIcoU0zQf4UI5EOXCr+Ic0V9hlMC8iLUx64UoOtsyR8iY0lor3lH4ucDwYXQAmC7DuEZ028t293kUEn33MDEYaOZR1XZS6wV5eDrGK77Ia3o7MlLsKVJIJJX5XlC3926nU4U/7mgvOz8gWBIGw+UH4pb6arfVIyOuavL/Iq6XG5TwLqOgW/35LYXj4PZc2Tg7x7jh9yow4TZvC+2W7SGmSgCsbampf5nF1hcMG3auFeIFnrdlFGIPEBqR6XcGSnCjgS9zOM8xUxlDnJsr+Zr+Cw8xzk8cFeqHaCnwTs0y8Lyr7Tq
X-Exchange-RoutingPolicyChecked: PMK5wSEhklzukfdE/FSuCL3kvNAkF6RU+Bn9aNpAlagzEwdhYMKvpLVt3JqlFLBsTmYGE4E05tApNcGvrQZlI6iStwgTaOIiznmwuM9hR0+KrbqTRSlzRpq7By9+km7aesGSoKZeJJPhTpt9wmRZ+lRBqpEvnh7AyW4r+UaP7zslbj4mDAsyvU1OhMsHPl57W2z09mqyNtdCFV76iShGkT52HIKacNWPggYI/pqJmJn9YfyD6/N9qI7ITkom5ztY8B0WU9nmDAGvAHu0rNvHXFwIUpUfwpdyaba4/Ggf02Ih1PncfZnIYh/08LOOzHb1wkzOtMtq8bgpeYFyFHEXwQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 22:13:47.9434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0c4504-54bf-4244-66d8-08df2bd2c061
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4893
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4OCBTYWx0ZWRfX+6F0RyfgDY2u
 3998vhWgxfTYLISY9l/ZNuZgsPub6dSI8cmjtwCQZQYsUbrku6yZ+qHrNU2YOt7gOk284xQPTON
 b7D3E1iQp7IH4yg62RHXnK4HdO51XVDPzdbkd7FU4j313gy56fICwBsDr7hdYZAykEDvzdkOJRM
 OIF3tvKXAvf2jnGKCwV6f83pzouQnOFG/fSU9o0gIjllqD5UOh717fhLbly6SjQmIaqpkXSd1Gi
 uujjgWp4W43hLwVsDxNbt5oNRHLRgOg9/rpWxnxD5taZIxiin9A/RGphjasC/fwvemQOxFnfm9q
 C1OAaBgIHmeW/tdpYW+q8tWFQrYtWynEjzewYZCvDaE8maFC0OJbrZ0apM89TDddcLxoyFMdJy8
 kvP/TbZX2GloiozmEgHA5+nyZqIJ7TRfD6TIF5070bT6eLgbsdjWM3AxFbO87TSBEEcoDutoS7z
 R4lKJeb7vyUSZ7/+wVw==
X-Proofpoint-GUID: d7vgP7kIfyG2SosQNCFYuFiDKOhgbkvY
X-Proofpoint-ORIG-GUID: d7vgP7kIfyG2SosQNCFYuFiDKOhgbkvY
X-Authority-Analysis: v=2.4 cv=fspJ914f c=1 sm=1 tr=0 ts=6ad2a1a1 cx=c_pps
 a=XYu8HXWfxIrayFrXgJv6cg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=ajVFTv8ujG2krU7aKnEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4OCBTYWx0ZWRfX+9GbveW8N26M
 M2Yfs+6CyjSLfkyi/LzSbAUbBKE01vui55hzvjOF7Ffx2aVNZnW09rDjLvZKAequoM7DyIFnJa5
 /EzSwRisavfV2iS5U4zN97ocgWE6/wk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160088
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

The BASE_DISCOVER_AGENT command is an optional command which may not be
defined on the server side. Calling it without first checking if it is
implemented will at the very best print ERROR: messages from the server
about the command not being implemented.

Fix this by first using the PROTOCOL_MESSAGE_ATTRIBUTES command to
discover if the command is defined before we use BASE_DISCOVER_AGENT.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/firmware/scmi/base.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
index 78ee2ffd2dae..fd65eae3cb41 100644
--- a/drivers/firmware/scmi/base.c
+++ b/drivers/firmware/scmi/base.c
@@ -338,8 +338,13 @@ static int scmi_base_discover_agent_int(struct udevice *dev, u32 agent_id,
 		.out_msg = (u8 *)&out,
 		.out_msg_sz = sizeof(out),
 	};
+	u32 dummy;
 	int ret;
 
+	ret = scmi_protocol_message_attrs_int(dev, SCMI_BASE_DISCOVER_AGENT, &dummy);
+	if (ret)
+		return -EOPNOTSUPP;
+
 	ret = devm_scmi_process_msg(dev, &msg);
 	if (ret)
 		return ret;

---
base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
change-id: 20261016-base-discover-agent-fix-d6e0e2ca6332

Best regards,
--  
Bryan Brattlof <bb@ti.com>

