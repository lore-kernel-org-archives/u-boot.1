Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D177AC79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 05:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D00140518;
	Tue,  8 Sep 2026 05:15:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CDUHMtnHLAXz; Tue,  8 Sep 2026 05:15:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 69537404EF
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788844503;
	b=B4rUo3hZk4SGw2vVwFtigCF0mah12ZLmDg45bhY4AggRf441r15VUU85D8GihOFko0d/
	 40iK6rlTc60/C56RTioFqx9ftMf6ADVG7sLAAysNnp0u2/0BbQLsUlsjh56kZgYAsZvoO
	 wj0LXBktc97mnrxXvl1CTmN7bzo3sXVta/EVvxfM7o5AgBq+hPJ6b01vIaw1Xo1jIVNwz
	 5YdsZ5f73xkNTCCTeR/mrWFeoZJ1RbqMFxAYEJWNLUHdMJdx4gr+nf7OxrFq/U2Y2BYHc
	 OaoT+3Hbs0uraWWo4To6OFE2Gth3B51hjTZnP3Zu3RKMjSKQHRKLNO7ALuibwiiHd0A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788844503;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ce2SFt/Lrsvy90NHAMnZ5BQkPHjeIUZp8v/0F7DMaIg=;
	b=JejKlT7ZGeMHHK8/OX8thYy52MDAaAr9TAo32J+rJzxNgtK6SUm5uG31QxnOb2RdP9PZ
	 kcIXEjaOlqs/715OLWlY1pBBYsRCV0OToM0aZh+wF4daQ5tHvQMxmOmg6SPtaCnxe2YgK
	 I3JVvEodQWi6q1J59R87J9Tv1S88kYopS0ZBV879t44wXnpovrJM7wG54hsf5eDmyxhsG
	 ad+1MkC8SsEOxTHFIQOsPMzlzqKm/qscMnKOw6/Iz7IyUOSyHikgvAdpicz1b+lKLTHC4
	 AL16bvtjZlVEiy1lwv2ViQFPB3vbRT2M3VT8TSfh+jHOuzJfv9nOwZUQD2JnO+HbG1A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788844503;
	bh=Ce2SFt/Lrsvy90NHAMnZ5BQkPHjeIUZp8v/0F7DMaIg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oAFb2bkVpPZAgdw4E079AbaEW8ipzYlvlIVlyOQJ1vpnSgQcJrM89azkhecXN5FWj
	 b4OeCfIXCxz5yUBEfPbl0EdqyXu5qPkApQ6sJfLBdNlMNWTdiEZixmIBDf0+ENzbfK
	 pCJVelurjsIuWFVVrnwcha95cq2oF30u3Z0w2bJVWw6ynzLFgjNfbkadAYrXptKWFa
	 xFqr5LUO8smqXwr1A3aimcCSVzol03khkLoo9JxcntdxpDIlqvHUhv5t4pMvlhtstn
	 NdRzN2/mP/sipz5tldBHqjqxDKLwTOhrE6/jtITzrglDltxlB/DfxdmFSsjpKYNDG6
	 lYLSaR93rtKgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69537404EF;
	Tue,  8 Sep 2026 05:15:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EB82970
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 151B360690
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YwhPh6uSLs26 for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 05:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DC7DD60650
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788844501;
 b=db4u+abvKNdukFFva6th5thm3/uWrRJWRHqzmr8exOMe5zWtTAi0kxhEIirnlp2SB//h
 YocvDUl9njrZDY0IToDGjRq8THup7vXH9/5JBRxaZgiB2W4jY8djwwyOM9Pyilfi+5+Pu
 /wLWxa8Wqi2KBZuaIPvfntlF+eh6W717hgXutcaPrceaCUzZlpENRcJ5PjSNs2US3ZEBR
 m/vFGP0IwENlcRpKiERThm9djP9G4fbKgAlKnil9MxN9Ubyu2cROebaQe4f7k7givTAQy
 1uqVH489wLRJLruJ0zzeGOmOxU2cuEg4ziC40wjENdAJkUT6r6KQ8iefI9UZR+Nxz0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788844501;
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=Ce2SFt/Lrsvy90NHAMnZ5BQkPHjeIUZp8v/0F7DMaIg=;
 b=fbEX7MV+4AuVB3RqlDhUcSIVzVMCQa6vR3VFl25qTcxiA29IUgIaL+w/0Uu3pnHETOWr
 JHuro1YZhTY/RhkDBW2lvSM9aGvUSO+GmugOcWPeSmWym89GngZ0ikOOh1ZNo3i0F6ZJ+
 ZrjoTvlP07bvzJ5PeBQaDIcaLR2glS9oEIPDMF4Jl0nujdSxXPZ4hqfNGTWkt8Iq9kvYD
 3lXFkIhIPkXf8Kpeu/6tq6yXMxX/H6k4tr+xumEcP8EMh7QV+PvD5AJWHZ3Z/NhjpCGT/
 3CCOgvNLCUpE+0fWcV37d0oxqG8Nl2cVyaaJdC70O6X5Ya+SlzyXGJ9GoWARoht5now==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b="N/oJvf/c"; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=os8mKqpp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=N/oJvf/c; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=os8mKqpp
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC7DD60650
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:14:59 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6881sXwU329994; Tue, 8 Sep 2026 00:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Ce2SFt/Lrsvy90NHAMnZ5BQkPHjeIUZp8v/0F7DMa
 Ig=; b=N/oJvf/c0v+C/d8lCMXs0uJKTt5eRiXrddtbk+mPb0rrf8gP6JEJCv6S4
 8IjpMBROqmO/56jX6tBYgNBL26+DA0vLn1y1OOeVZ7eVkk5zcknQcugZLIyl2tlD
 wNJtMoWtmFqTFWo09FGm5CCU9Hsz/f+Ps6EL5UePyuSKCJLLtgdrRBj+ZhXRt9qm
 y6WF3elkwQE+ypIT38YExy6aC7sQ4Eo7bW/BwvHednWVm3zVdf5/Rex33g3NJ5Rp
 hg45vIGDkaFhTMCOUwc4AR9Vsp6fYUlmza7jwGI8qNf0Z9PQL0M1rtTgSopVlEBI
 45apUvra995YHVnjhBv67zMFx27EA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj940gsqe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 00:14:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X18m+Xy5yXN+/ifsJGBn8YrLWdAacTZ4/e7239Tae4s6QqiVkKfLzJ+XJ/vYSx4m77nCajX1omP0p8QCk2F2qoNHHCkMaQoYeF1TYCVWRJrhHRzRYN0BiP9RMjQcIP5P0xQgvIFOlvjLXUqaJRFA1yz1eQV4GdVM0oHXaPZNAPvKH3UvHbOhQefoYALkEdriloo7iJaQBZxarGcrVCRPcB2X4DO6CALv0OrSSXi+vhmx/7ZQxcU77BJVu/DsxEAv3hNh3Tck4XCIzhNTFreNdlMCPamz91947n7iP6nvZ4LsX/HTUi4d0U274yby3kqqOGDE7+ahub/VEY2Ubx32vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ce2SFt/Lrsvy90NHAMnZ5BQkPHjeIUZp8v/0F7DMaIg=;
 b=Y8unIRb+LgnIlOxqCvNOQZoKenpyBVn5dJAySdJKwTOg/+gj0lqnV0gc6WxX1YnWt0mCRcEs1Y7LkdJRRon+s2ieQOvynTviFYehEVi/eB2RGsnhGWVE6ak0OYTnuToKlNHreCQCnMkn83dkSJ/Xgx6k3x8P8tsgZsvFahlOVML4blda6428JFvqv8H1gJoyrepLrrfTNxuvoTVD62o42gtjHTBEcRyytmd118Ql/AewDaCx2YSQr04ZDMbFQJYuZD2VWL5mWY/y+iAxnn9UapyVsu5slw/lpUob5ZB60SRDLay3xL/T0qIOi/CelZmDZw2H0crv43WJnvfzRt5J9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce2SFt/Lrsvy90NHAMnZ5BQkPHjeIUZp8v/0F7DMaIg=;
 b=os8mKqpp4Mw74PYy7Xc/DYYE9Ke2tfouHPSk5EXHfCd4buYQy3uCeUItrhDaxc12Pu/V+m1p4QJT6VDkIuS3y7LzxR+LaiIb0uZKbcqqFLAyv8jKwc9RzmGVsD30lrOlEdYiElt1BcXH2ELWE9k4jl6Q2fPYHp03pXsF6AsqyDU=
Received: from MN2PR15CA0054.namprd15.prod.outlook.com (2603:10b6:208:237::23)
 by DM4PR10MB5991.namprd10.prod.outlook.com (2603:10b6:8:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 05:14:54 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::25) by MN2PR15CA0054.outlook.office365.com
 (2603:10b6:208:237::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 05:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 05:14:52 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:06 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 00:14:03 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6885Dwd52811953;
 Tue, 8 Sep 2026 00:14:01 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 1/7] phy: ti: phy-ti-am654: fix logic for programming clock
 parent
Date: Tue, 8 Sep 2026 10:47:26 +0530
Message-ID: <20260908051741.868824-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260908051741.868824-1-s-vadapalli@ti.com>
References: <20260908051741.868824-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DM4PR10MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: c47ee57f-4d97-41a2-c15b-08df0d681d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: uJpEbm8Hs0TjYsua7n/7+2x3V2Sz7KWKgwOeATizMjjnaLY2uwuRQ1aswD/+JyQGKfVal3L7EnL7N3ZEVBjch91WN3iuhul2C8QGhynv8ROzl22c1bSbHopZyC6TiJWNUBsqk+UGS9oDagEsbJPKnUINn9bDC4H4XFlNQqz2+DXbaTJ0zFScUCoSy86sObKy/u+QPOdIidb9dxKwQcEmA2wZLuJdc4jjlBR1E6vn96kDna6b3ZjLGPqJTsTtD0knEUx3tQiJjlusBSk10f5VAnhff4smltjjqYE6Wc1A6u7Hgo4SUDuChL7t61nUKANSmankncQ+DfBG+s9fhflwxEHeGjz11uc9EOXm3gVBfRIRwBkylS6Dcmq2YzG0Ot6kqcX2NIEyERp6X/ek5fglAqt6RRy13cbDvESawE8Dssl/GeOEy/xbkca1L2i6FQpPNAwkX4AjdfZv0+ddhZ1pHDTooNkTTG0qBK3PK3t0BVTgXICQHMIWShUB2+CAtklcYmvM5nZAV35la5U91NcGrFOmhie4qEHtR452CN/DPpVk4XHgrk8hiDKVHxjYHup66E0wwy417f/SeDi9sJQ/ZE9uxhNgDZvhx7/KcyU26S9255IXxPXd3JtakSRu+dO/jFIRFc7yOWxjwHo7cD6Au6Wh00NDH/DHp/NuRJSLauqzgXFFM351LW4ym6iDaSshCt83HE55HTqkZSgOkqTs2g==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NnI8snla0nfGNiIpJV6NYH5BuaKTJhVza/25w+BTkJaaXRl/+HMjBWASClIv2kKQ+qb4KYXv5fGnBcXfz0pGDPEtO0XWam6I3DQ8PdKQjUgQRw6SRKrhuZN479GTD2I6c9xpjMqUqazxdFzrBZctS/DlNaiv+PJN7ecp4fnCButY0nIJXw0VyYPz+tudIgG5puWV5/xgVs9wObwQoy41RIQEJE1tMMpSki17AilBSq4+pxM0WNktgv///QaMEby6EJ6KAEtszmmDvnRwGngHqEkG+YNsITi9mOawoTbcwaYksWBjwmJQeRD5rYwHB8AT3Q6sqwfgGansWaaWroKjHKtP37P7A2yG915jdgUfb+6IJoRS2n3pUxpNsnIhKDYF+eXGi3qZPDKyW7Am3/DVkfFiTasZaYZiZHJHxyXUfO/OvFMy2pdoiTRjg43NauoH
X-Exchange-RoutingPolicyChecked: xsOPPZZzHKGqs1nu7Pt4VXufUyleAkRdTNzDDzYvEZmOEgdmn66fKt5DqOjGlCWfw6PzSRBA4Xsp7AJzbDdmYkkWqY2q5ertGcUv7G7sLvo/zM8NIxRlt1kJd5lnGLba8BzDyGOBCCuVTvfKCBUJFRs/5QLsieq7Ddjl4RMCPfiM0X0dnOdT5BZSPSK6StzpxfJSOk2aVdXJJj+1Gk+xsjx+TldKY6huU+0myBRpgxEZvI09OvY3uWCg9fTGQXa3UHv1BRVfOUz5swsOqPT3DJky6r4oDhIKXHKYl9xhnZF3Dxk4oDfxdRvsETZtf2FDNADKRvQlzhBTf2Jh1eJRxA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 05:14:52.4747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47ee57f-4d97-41a2-c15b-08df0d681d1a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5991
X-Proofpoint-ORIG-GUID: 2ziwOFwrYUO7FgQ6G9uIuetRgZcZxcEB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX/Km5tbHHLwPF
 pd2/iuWgvfitktwtiU/uR7sXWPVsMI55tYtgzAkWfIvtF325PGKmMrpmKsuOHzA8/2tlFO4gKBW
 48NWVH9p8pPCveZMGsMUm35HtYtF2TSdSDNoJhdLHOWcWcBkwGsDwbxnNWJlOs3kc1i6dv4t4qp
 7IwLpRHO8Z7dvG/Xple6oeBS7QsG+3Grq7FoW47VAdympCJCr3ekp6QPffc+wy2sDLX7nZ7EUMe
 ZQ2bqMwzVjQc0JldohUTARrBMg2yXU8dz3nNS1/GzBUmh0kEgskk2VmNnR5k0ORyZNwddd5YNXj
 6uP2SXBaJj93WhoJ8BENSMkeBvwYg8DszSmR2q8ApwxEavW+Ucys8aGmV8Xw6nUZm+/rxlFJHMP
 CM7e+l8gYK5qrR9se6WCGIjHXUM7QNKJCwOWOFenRKkmiqlSc4NNxWpUhXDhrCdGaoyh8HrnCGm
 7F1qbXY9VA0i2+ZMBQQ==
X-Authority-Analysis: v=2.4 cv=UrNT8ewB c=1 sm=1 tr=0 ts=6a9f99d1 cx=c_pps
 a=SWHM+P2JNiUeaYpOZLdr7w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=g8noQebMVTy4tJefGO0A:9
X-Proofpoint-GUID: 2ziwOFwrYUO7FgQ6G9uIuetRgZcZxcEB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX84AAfIsvkVd2
 wgvJ5D2twb13WMDesRvVOSfl8aySBFRmWpfKuOjKTf98oRuVsEGArUQhn7ykzAfLFqipTCVu5h9
 0Iubp9MY3gfDgb5+UkMR4E8hQp9LI8A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080055
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

The current implementation of serdes_am654_mux_clk_set_parent() assumes
that the register for programming the clock parents is exclusive to the
SERDES instance. However, that isn't the case when both instances of the
SERDES on the AM654 SoC are used (for PCIe x2 Lane as an example), which
results in the second SERDES instance's clock parent programming
overwriting that of the first one.

Fix this by using a dynamic mask rather than the existing static mask
namely SERDES_CTL_CLK_SEL_MASK.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

No changes since v1.

 drivers/phy/phy-ti-am654.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-ti-am654.c b/drivers/phy/phy-ti-am654.c
index c3d9972397a..23a5d1483b2 100644
--- a/drivers/phy/phy-ti-am654.c
+++ b/drivers/phy/phy-ti-am654.c
@@ -142,8 +142,8 @@ static int mux_table[SERDES_NUM_CLOCKS][3] = {
 static int serdes_am654_mux_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct serdes_am654_mux_clk_data *data = dev_get_priv(clk->dev);
-	u32 val;
-	int i;
+	u32 val, mask = 0;
+	int i, j;
 
 	debug("%s(clk=%s, parent=%s)\n", __func__, clk->dev->name,
 	      parent->dev->name);
@@ -169,10 +169,16 @@ static int serdes_am654_mux_clk_set_parent(struct clk *clk, struct clk *parent)
 	if (i >= data->parents.count)
 		return -EINVAL;
 
+	for (j = 0; j < SERDES_NUM_CLOCKS; j++) {
+		if (mux_table[clk->id][j] != -1)
+			mask |= mux_table[clk->id][j];
+	}
+
+	mask <<= SERDES_CTL_CLK_SEL_SHIFT;
 	val = mux_table[clk->id][i];
 	val <<= SERDES_CTL_CLK_SEL_SHIFT;
 
-	regmap_update_bits(data->regmap, 0, SERDES_CTL_CLK_SEL_MASK, val);
+	regmap_update_bits(data->regmap, 0, mask, val);
 
 	return 0;
 }
-- 
2.51.1

