Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C5EC982FF
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 08:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C6F280DF7;
	Tue, 22 Sep 2026 08:46:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cvyk3T2h-SMb; Tue, 22 Sep 2026 08:46:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2B65880DE6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790066797;
	b=b6X86DnFX+0qIfg3w0+SzuRV0E3D0Cs7ntrBa05JrWAEPF8iiOt8z3oMaOl1s9d027OT
	 b9K0GoKa9EqU3qp4+mYu/m26d4ZIRtaljHqw7wo0R6TjWe6OTFwM63PJdmwyV9dIJW0Kc
	 c3ZeBLdczS2cgJI4z4ngKFv7Nx77+sS6FDPbSnDQHNSlZ+qNvuxiygQ5kP8/MFRrRyHbv
	 Z5QKPEJ2b20tGErLLkE+uSNcYLFEvwCV2Yd0CEwlOF47Eb51ITHkiDs9NaUOKcKXxyEPE
	 3MDY0DqEKkD3qg3elId6EMaCS2byRbuoh9kj7mzTp81eCub2pKzcl0fx+oUU8t0Rraw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790066797;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=raIElAiX/LbGIe4xYtM+iSoVMormelVZCzwKrOcCkJM=;
	b=Eav5GGg8L5rQ79SuM/T5GgfOGImwSysxl09N6ZgV7Zi0arzZwQwEFqyLmSeHG/OEM4Ze
	 wIfGU8t9ViQon181rcbAue1gwQFn0cywBtfLt12nV+kqbwg2xRqSn71n3ELFBSmoi3oQ1
	 B5EBxkscRxULQpmSuzeR/lHR4PL3/VTfGYk3jEVBUktBM2zQUa/ZTAXwIdl2dr6x/oo+l
	 qsiTgWpoOJ5M25WBpMq8Nk8scoY/4MshsSX7y6y1zGiYVKw860zDp0zjB3PlK7sDrxEvE
	 4V07a3rflotuJ8PTBIjn2mpi3Gn6L8YAWubCvI29YqOR6q1JBowM+jy6hB5uCiBKNKg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cTp1uH9D;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=DsUfv5vm;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790066797;
	bh=raIElAiX/LbGIe4xYtM+iSoVMormelVZCzwKrOcCkJM=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HTqpMwuBsSmQmfWlZA18xfx8ljRW/CEj6E31bzLcTYI9KZ8O44sf16igrUtjoNZVh
	 nnfmciG3hn4ENWCEjBnATylTT4KT4FJqB5DCG81sJUhVyCdpQwNkmcqOfkvIXAzuyQ
	 0MbeWAcMLi2ghniuoEeF7QPJqxMtQhly7ycIUsc9w0Iwkq0OTExZYjXhVpeWU+FwjE
	 rMTi8g1Bi+xST8KSGTm2MH6lfY4EdwbYwXQWRbVotXZXUvgEpIhfvSEKrYfFi+zqUd
	 drl4FH/9fuet0/pNLhWiPZimoNrhIWPXcB7NjP7BMASH8je775l3nGH+tSptTmwGgQ
	 ChIhOQR7smdTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B65880DE6;
	Tue, 22 Sep 2026 08:46:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 970A2B02
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8731080DE6
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n2fVwj2zdYaC for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 08:46:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CD18180DD3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790066791;
 b=VfirEe3jWkgX2wUv5C9wtAUnQAmW5ge2AsRHZ42jWNq7ET8nZciaqAduEg+BJGXk+BsB
 zbQdZ+nrOwutrzXBcgN52kntbAtOINuIfrCXGWo4qnxpYZ5N6yvNg8Fvj80Jb/iRvKbYY
 l3f4co/KAgQ13fFqfy+a7qVwuCBlhbJmU9h4Fve5TuCYmzv+I+9UaB/pqTitLrrtTY3JQ
 bNHxr/d+ATiV27rrLY/JpNKc3l7zElu8x6I1o8ex4aqFjgZu5ZXkgrRNTHb4c3sGZ8oGd
 TxVHYRp6EpKFDTV/YAk7sOyUrIpn/s4chSKTv6rG+BPkSlejIvpUHQ8ylLTELr9cRDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790066791;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=raIElAiX/LbGIe4xYtM+iSoVMormelVZCzwKrOcCkJM=;
 b=mTB+T6a0kW2dkfgxEHpHDdnMBqspnkbDcIUZ/osN9slUadivUmBxU7lRRpUE/3F+E9c8
 6eb8J+LXpUiEkyzfzPkmg0z72z29LOrrQ0bkGrRt+R6SIL2yG7XOOX9Gxvb2CjrarlRUR
 /GFe1YeV+sEzlzzGYrasMuOz//sfipv5XcJKX+v9MoYGo11wEL+vbLuB1+nucI78B0srF
 j+KvqTvNd3VKUMAVVczhi4b2sdzvWMrNYl7rmVxExPg56VmIz3gG2k+vGuTUAdR1FzhA4
 HKz7IIXkITL7n5oghKlbOdBnvnq5fYJKpEacv5wHmgKFrSgY5LCux9lTwrNFs9Mz/ow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=cTp1uH9D; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=DsUfv5vm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cTp1uH9D; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=DsUfv5vm
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD18180DD3
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:30 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68M8j2Gf3143896;
 Tue, 22 Sep 2026 03:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=raIElAiX/LbGI
 e4xYtM+iSoVMormelVZCzwKrOcCkJM=; b=cTp1uH9D0RluQDN1YjHSZEesvLn2R
 vCaLb8UpaG3iik8Jgcc/wTPFbUONv2P6Q9W0qd5EQhx2qRw7xtbXyYOFYaWbqXOt
 WJTcUhRUb8a92Ay3lU+w99cLW3ATSDQK1bZHh4aZFIHHtVjPZ/KDPfWe7pkwrphb
 JiH9IQEqEa7VqXQ/mxSpbsKaaPuCSDTPofJuojTRL9hyrAAJcbwk54xwCV3Z2VwD
 LThWCQmU1jNqO/bP1ySLfD6yyQSwSEfprP9J9+/yCmkUPEIgzOeVCLPwb2WqJF82
 nJRzqb/YWwU2fs87O5uZkXCeciqUC0urMjUI5rrGXEQSMTVUsVfT+Ts+g==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gupea008u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 03:46:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hggr2Hf9XqwFLztFNMdX/Ior6kFnUn6mKjkhBCD//npxmJMsDvTjP5ujl03G0svy5SMyt+OlYSM0pdUIR8BuI5XSdNTPKqikSw2h3y487o09Tqmq1O3SP9JHKLIuwCUXRBp+e3NK4c/osvsiac4JU0tfMwjueVPRvqaDRAP8mVeePOpuLiBuG3nYtpu+4NrcVOH0M4TKxRkHihSplZLNjieKk8GAopyQ3PYFe88U28B81I5PvimtFItcmF7cfAViAvWkmR5lvH5ErrmmE1CHriI+Hsgzr2OG26UXMymYlK250+LJnZFVRnTlNPhNqTQZcdqvZ8tV6xl2UdfFZgxo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raIElAiX/LbGIe4xYtM+iSoVMormelVZCzwKrOcCkJM=;
 b=KTm3HRutJvbfv6at5Q4j/X0/vbRiOLd7Mw6/NT6AcVBCoOptI6lOfdfLh4ohukUAU2qv1MzV/ayXkC9/vkkG7zuyEqZvYxJWKiVxjIvpS02M+w8/GWkbjhSLrCAZ5zS7E6T9Dr1E0Xa7XtJKA5aS4Ap5fk5PQdslYGJH/Z6y56QNHu005fq/wfcXMc5q6JvWXuN/5neAMY/sKebg1AmVpt0rOOmjXdubPVhqzFZ5ofhH4PMz1VnU61LNCcYdE+mC/XtKQJ61+3vch1yvkDFNWQFrWu/Gzy9beeVOEWTAWY9I4AcMwvbm8bozeZ2u/d6yOMjR9byd2lw8ronxyTWX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raIElAiX/LbGIe4xYtM+iSoVMormelVZCzwKrOcCkJM=;
 b=DsUfv5vmnsBZVbIKBRyW8qHN+6RwVg4bZL3iHtCEpvXzVXocDVerP5v6mPPKrUgzkICWxnCu78BGatntm7/dAtx8wkVexcZkZO4pYzdjsxECQICYAz5VgSMEz5xBbmDGpZMXt84JYY0CR/tfe7HwVj1//cZw+MboHpR/OpnaUyo=
Received: from CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::23)
 by PH7PR10MB6202.namprd10.prod.outlook.com (2603:10b6:510:1f2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:46:18 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::aa) by CH5P220CA0024.outlook.office365.com
 (2603:10b6:610:1ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 08:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 08:46:16 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:45:41 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:45:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 22 Sep 2026 03:45:40 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 68M8jaFJ3813357; Tue, 22 Sep 2026 03:45:37 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v7 0/7] Add support to boot TI K3 HSM M4 core
Date: Tue, 22 Sep 2026 14:15:29 +0530
Message-ID: <20260922084536.2477291-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|PH7PR10MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b06da5-5d67-4b4d-a618-08df1885f772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|13003099007|5023799004|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: +TsgKT7wphWdR/xV0CpEeuSEmZyhC0CD8JTDRJhyQe0empRKsl3NYAh4a+Ii32TZJWbuRJ6fY3FWk9Rml/+hNwrlbBYYCuK/oQUKhnQkx0/F2LMDGVGs1x3aw5Xj6SZ6E7xCWHb7FVgwUaqAO5yhh1XU+MglzmDxH3H1wQ8oN20r4JzCaXOZBAhPP4JXtwZt3904cD9dajlgaaaY0rLT0oTrNo8uxAhAYaOQv6x58lNBFkq+ooXbWDyzEJWbqZQuuaw4jT8bUBQQgP04GP2vVv3UFqFBt+M1kz70/y97eQa50DSogWKsO4QdcgEDrBH3B5nGnPqUr1RlHulk7gBcKa/BMPEQmBwmboQ/6o8iKXcsWyPq8sfX5257daW8Lfea/X2OYuoDTG9ajq+e5n+4VzvHTTEvmwLBzx4MYohtwVUiVwzlEMCR3AM/e7U3DKn/RXsf+UkF7LULUwsGYEwjKrX/vvKMKPVyWWTbe+CV6ywL3D2Q4uuNoxoWxlIU0CdMcuuNGKFKQnKnVVGMPJW6ovm3pDtq/TDxahvNTHACgI3oXtiouo8/XuFyXvQHlGr4t5S/PPJlNnSOVm9Y9DPLapu6caoGcXxmP5lYuQPMzQRDzmJM6tarbxP8PMkhxZyj2YZfav/0ViCu9SA9L/f4Xg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(13003099007)(5023799004)(6133799003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oQsxuMiwx9OhXYsLFx3KIHb7h30CJpdtl+D6FhbLwqtENYwhoxrbSTlowAA2stbk++8LXtecJFekg1EJkYECBvBLjmmVlKpYLCSHJLv9LbxIaa+2HMMNgV5qK5L0p9ATVgbEjr3AHUkaLAqL/4k5Zqr+dxKcNmE05o8NrVy7m0GTKFBPh/BzTamG124uSl491buDROLcIhObLtbMiSWsE9pfVJrcz9TKDYFSpGzjOCY3ks9h0qyU24r3EA8+38IY1b1rcpMjmfoB1lweWVzozDnZJnQt1IQZuFZZMdV3gWcrfaI6nPuP6YnjerBCU77urKZIU6gXRmBJLt95PAS9vWh7ndzuAhTD4lkXket9vHwuq0DuTPoYGBNVC2d7Hbqnt/cFtv54opYQWQDI1+LRRU/YTPw4HtLozh70GMaKHlHBfgF8dLmtL0q3c1Jr2GKg
X-Exchange-RoutingPolicyChecked: 3m62G5hUKm9FC5WwTjvmz8byvQZgbNCbIql2Q//2YYOCHlxxEYjSnfq/TVQjt9cp8G+1/s/3ak7+WyXquujF/+0JYJb+ZqrkJmJbGYE5cR/nNUj+nFll2Lew7revkVJ9bagITsSkyu+MdTsdpdt40qpLbSshjlr5eVVUoIN4aHhF/IL0sq5tyS112N1TA23yoDAOy+4rtqVMU0Z2i7dMIAbUsUHu/oLPbuC8FUDcOW0PcAlcRzi6D+Rxxk05KQx0w7HYrZkTiWOcQvpbpQvICrSDpVBU8Qryw8KwdxryPlQDO4aeW4DZc8hGowgurPrd/LmtndSKHrAMECR4AsUl2w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:46:16.9839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b06da5-5d67-4b4d-a618-08df1885f772
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6202
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyNCBTYWx0ZWRfX5eGbBEmwl/C5
 UzXcv8R/Zbyg4u21+Q3jO8AdC3HtLcnRFSKw56w33F2MCbbYnu74Qng8PehdvzwEqvS2nH7nR0+
 1vhAFFJOAyBF6vwSrL1rmLEj6Jr5kGGfG/PQ3YTseJeWrFEa5OgpBw49Tk4QSpWXDohy99/kBaW
 t+tnn0bPuNisvuqpNN3sPVSYhBy5wB+wNl+mDmREBpEqUC9LSUsZ5eJISZMwREWDRoPXXmKmW4r
 k75LoL9AEF8J33SGzowdgJYUQYKUcnkTpZqvSB0I1AIaQXskqHKo53aMZRzFLLq7njyRqDyRS5h
 GuOcEenXN7qM75uSW9nFIXpzG3GsLh2mxW9ewYeniEJlZ9NrVAaBpWkui/ktvWCV56r6BgNJ1RT
 uKqvLNKWgbwvM9fyVAXB8lXFza6WAe2ZueNAiebvB2mCo1a47qPbvs0/Fl2s0NVpf48pxRUtCFK
 obvPBmCMG04jFVqRQUw==
X-Proofpoint-ORIG-GUID: yhcD_ilZ26EIoiH0y8diVrCzp9-haPLO
X-Proofpoint-GUID: yhcD_ilZ26EIoiH0y8diVrCzp9-haPLO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyNCBTYWx0ZWRfX1u7xaiEK9KH1
 F+dgD2Git/wDhHVt+OCskZuY+ch0nGd2BP7qcahMu3QFLnPW3kOl5ohRDrR49UppS6ekCJt3E9j
 gU3TOWqhkcvZnluNGwrdHNxxTmaqecg=
X-Authority-Analysis: v=2.4 cv=Mdz5KJ/f c=1 sm=1 tr=0 ts=6ab24063 cx=c_pps
 a=sh6lJpoQSmOZbBTv2jax/A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
 a=x0v_tFf1iXXrK4k0_x4A:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220124
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

Some TI K3 SoCs like J721S2, J784S4, and J722S have a HSM (High Security
Module) M4F core in the Wakeup Voltage Domain which could be used to
run secure services like Authentication. Boot flow for HSM M4 core is
different than the general purpose M4F cores, and is as below:

1. Request control of HSM M4F remote processor.
2. Assert Reset on the HSM M4F remote processor.
3. Request Secure Entity to Authenticate and Load HSM firmware into
   core's internal SRAM memory region. For GP device, load the firmware
   manually into core's SRAM region.
4. Deassert Reset on the HSM M4F remote processor.
5. Release control of HSM M4F remote processor.

This series adds support to boot HSM M4 core from R5 SPL stage. The HSM
firmware is packed inside the tispl.bin fit image. The firmware is
unpacked into a temporary DDR address which is then used to load HSM
core. The configs to boot HSM M4 core are disabled by default.

Additional documentation on HSM M4 core usage:
https://software-dl.ti.com/jacinto7/esd/processor-sdk-linux-j784s4/latest/exports/docs/linux/Foundational_Components/U-Boot/UG-HSM.html

v7: Changelog:
[Udit]:
 1. Update docs to include HSM loading section in applicable board
    specific files.
[Neha]:
 1. Post to new U-Boot mailing list.
[General]:
 1. Collect R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/cover/20260831083347.1168880-1-b-padhi@ti.com/

v6: Changelog:
[Bryan]:
 1. Rebase on upstream main branch.
 2. Drop [PATCH v5 1/7] as existing fix is already available in main.
 3. Add documentation about enabling and booting HSM core in
    doc/board/ti/k3.rst.

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-1-b-padhi@ti.com/

v5: Changelog:
[Simon]:
 1. Add 'depends on SOC_K3_J721S2 || SOC_K3_J784S4 || SOC_K3_J722S' for
    KConfig options.
 2. Use hyphens in DT property names and underscores in python code.
 3. Add comments to explain DT property values and link to ti-sci
    documentation
 4. Use lower-case hex for DT property values.
 5. Use consistent whitespaces.
 6. Add property documentation in function docstring.
 7. Log missing properties for boot and load extension groups.
 8. Update tests to check the load and boot sections contain the
    expected values from test DTS. Add negative tests to check it raises
    an error when some of the properties are missing.
 9. Driver improvements: Size check before memcpy(), type-casting, and
    checking device type via get_device_type().
 10. Invoke ti_secure_image_post_process() only once for HSM images.
[General]:
 1. Explicitly mention the load address of the HSM image in the FIT.
    Don't rely on U-Boot to assign a fallback load address. Use a
    Kconfig option to specify the HSM load address.
 2. Pick up R/B tags from Neha and Simon.
 3. Squash various patches together as they are atomic.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-1-b-padhi@ti.com/

v4: Changelog:
Re-spinning after Device Tree Syncup happened from Linux to U-Boot.
[Andrew]:
  1. Reworded commit message on [PATCH v4 03/11].
[Simon]:
  1. Add a binman test for the boot & load extensions in certificate in
     [PATCH v4 08/11].
General:
  1. Drop J722S defconfig changes out of this series. Will be
     posted/discussed separately.

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-1-b-padhi@ti.com/

v3: Changelog:
[Andrew]:
 1. Added dedicated remoteproc driver for booting HSM core.
 2. Added support for signing HSM firmware images in U-Boot. [Anshul]
General:
 1. Add support for booting HSM on J722S SoC as well.

Link to v2:
http://lore.kernel.org/all/20250506104202.16741-1-b-padhi@ti.com/

v2: Changelog:
[Andrew]:
 1. Added support in SPL to load FIT images with no 'load' property.
 2. Removed 'default = n' in CONFIG option.
 3. Used __maybe_unused to decrease preprocessing.
 4. Better error messages with error code. 
[Udit]:
 1. Added 'HSM' entries in enum at the last.
 2. Added error condition in if-elseif-else ladder.
 3. Hang System boot when HSM failed to boot properly.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-1-b-padhi@ti.com/

Testing done:
1. Tested HSM boot across GP, HS-FS, HS-SE device types for J721S2,
J784S4 and J722S SoCs.

Logs after enabling HSM boot configs:
https://gist.github.com/3V3RYONE/ad33683652c8c49e4fedab49f0493e79

Beleswar Padhi (7):
  arm: mach-k3: Add config options for packaging HSM firmware
  arm: dts: k3-{j721s2/j722s/j784s4}-binman: Add template for packing
    HSM firmware
  binman: openssl: Add boot and load extensions to x509 cert
  arm: dts: k3-{j721s2/j722s/j784s4}-r5.dtsi: Enable HSM core
  remoteproc: k3-hsm: Introduce a remoteproc driver for K3 HSM core
  arm: mach-k3: r5: common: Invoke boot of HSM M4 core
  doc: board: ti: k3: Add section for HSM M4F core loading

 MAINTAINERS                                   |   1 +
 arch/arm/dts/k3-binman.dtsi                   |  26 ++
 arch/arm/dts/k3-j721s2-binman.dtsi            |  12 +
 arch/arm/dts/k3-j721s2-r5.dtsi                |  10 +
 arch/arm/dts/k3-j722s-binman.dtsi             |  12 +
 arch/arm/dts/k3-j722s-r5.dtsi                 |  10 +
 arch/arm/dts/k3-j784s4-binman.dtsi            |  12 +
 arch/arm/dts/k3-j784s4-r5.dtsi                |   9 +
 arch/arm/mach-k3/Kconfig                      |  16 ++
 arch/arm/mach-k3/r5/common.c                  |  29 +-
 doc/board/ti/j721s2_evm.rst                   |   7 +
 doc/board/ti/j784s4_evm.rst                   |   7 +
 doc/board/ti/k3.rst                           | 136 +++++++++
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/ti_k3_hsm_rproc.c          | 268 ++++++++++++++++++
 tools/binman/btool/openssl.py                 |  49 +++-
 tools/binman/etype/ti_secure.py               |  65 +++++
 tools/binman/etype/x509_cert.py               |   4 +-
 tools/binman/ftest.py                         |  45 +++
 .../test/vendor/ti_secure_boot_load_ext.dts   |  23 ++
 .../ti_secure_boot_load_ext_partial.dts       |  20 ++
 22 files changed, 763 insertions(+), 9 deletions(-)
 create mode 100644 drivers/remoteproc/ti_k3_hsm_rproc.c
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext.dts
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts

-- 
2.34.1

