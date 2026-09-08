Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F335C79F9E
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 05:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 563296067E;
	Tue,  8 Sep 2026 05:15:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3jX3UBiMSTGX; Tue,  8 Sep 2026 05:15:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5DD9260650
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788844516;
	b=HlTwPMF9nyMtk+UiBfkd7r0ZYd6+ARE0aRamVoXU28BtU60xXZl6GwB+iDjwK+g1zwam
	 mp4faliN/FL9jixBqNipFa4AOYm3H2DEmfE2159scfzZ4SZHbtOlCFwJ3b41E/RoUAZvc
	 /FoFb5Hox3fruY3V3ib3PnerL3zO3y/3ZB9tLxjY1HxtH76VX8CqRdRt1+m8kWfb7XKMd
	 8kVTrHNjZOD7oR6dFaNVLS0b1uthas+LEOQKnj8/u1D0aBK5a9kmWvYZwJEGtRi/8cWls
	 mDCk3FFt5WfAgA7VHynom4xkllAH6PxNklBCVUArhRYtwZGk8Mq4jHLgmfCmYmLpu3A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788844516;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yA1ntFD7ot1eFGtUxTsqpkoytXa9Fc7QMndzmvtPnok=;
	b=oIeaOcCU/R80Fo0J1AdGYL9rEpw5MZyObAbbHv8uTecNyjKlsu0TmwkIOlbt/qYY01jW
	 QtSGpc+pzCB1MWkS/7W0vMzyorDDliwjhrDW9MOCSxcjHRGcrRYi9g2xTr7BmBIIGp+vQ
	 9JN2bPzPuZM3oxMGa/fccK96TlgSlYIxxkKaUYVZMk4odFl2lme0W1qOuZfZzSIaexhFt
	 R1bQhTTZaW7HgI/1N+9otDma4hAZv0pX3wZ7k9EF33n6ed0ZyjJbpvRX37ZYboLurLBQR
	 4ms8/rTj0mAukDx4wv/+lIQ+7O57HW48w19V4Ev4Gm0C3yprZ5zvKj/L7RZk4U19+Hw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788844516;
	bh=yA1ntFD7ot1eFGtUxTsqpkoytXa9Fc7QMndzmvtPnok=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VzxkCOuSwtklDVBQCZLkxyP9TXBDnvUm6bhVjX5/eMoASu/is1I5SNyQuTF1uKEzo
	 bkeAM5o7JtVQKDBJBYXyN8mJRfEBPK0f27ny9NCDnnS6Z4lFYgLXGEf82JHfC66I7J
	 grWRzH5R4YYmTQoKz/NdYQAIW4pWEcLgmWiGXFEIJ2c/nrMnrce+KtUCzy54YFJ0mS
	 SKyyWO5k1Ce/RUYT0GUIRmenP/6mHDVnAhCzHmjw6VCRVhB13AuO5NFMR3POe0jyZv
	 86UJjkyiXjHmc6iXSyYgPoz8at3mrmkdOxwMoPDSI1kJeITzO+pOxivXA2E1v44FiG
	 QeiZLLXAyJZlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DD9260650;
	Tue,  8 Sep 2026 05:15:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BD98970
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:15:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F18C6808A2
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:15:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GCM3Nu5VOUmD for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 05:15:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 388E380898
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788844509;
 b=Awttgk4qdQt+1b+jgGFxfYEPxMLfkibMvgRcIgc2lzRrnVASNqOj8U3LU0p70/0feZ6h
 gzh3PgmqUMQtYk+XmsG4TeJn+QAAY86YrGIWGeHDaexUOpOYF0bq+UzNEJkMpmm7xHnOa
 RneAcYXWDAPa/U+rmQ94Si4Ak5Ntvh0UUMnQeSwhZNsBUHow3GgIqI/7XZ3PRYLO2blQs
 4kOLBm1AwqlTAwzot5aLVkYCNncRP7iIf6Cek3/DmhKog3NKtkGsVHNdLeDOKcmY5MPi4
 Yu8Oex7c1fccsaK4Uc6IYqurDGZ4TSoMjHxhuXSePyXZ3KBTpu/bViHTmtJR8HdIy1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788844509;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=yA1ntFD7ot1eFGtUxTsqpkoytXa9Fc7QMndzmvtPnok=;
 b=pmBvKQ2NkZHNBtXUW70fkZ+J/22hWb1mNQiHdPz75MPEk9oIWWKNU0RcCj+5XRu/CFu6
 kPDVtalpeZBLObIccvzEjnHdUfx6Y+YKgUbbzUTRRIYdKAX0QSBDYl219Qm6NT4kwdpbA
 siGq2RresD6mjN3HdSEL8xv94AptWTg3eH8nc3ebx+34iwr3c7zyPKgre4zQgNIULoEem
 4nAYbxh+kqFux1r4JdArt4P3oaM728WQugseCnBEBsdt6j6eNYPI9hYMfDnEcaoD4QN6I
 doobKXmdTWo6LiaW1mtdos8HoFwWN0WoEDFdrtvSsbiivMk7Z9hwalcrqblRi2zUB7Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=LGy6dcoa; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=CjcSmwFi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=LGy6dcoa; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=CjcSmwFi
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 388E380898
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:15:09 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6881rZI4714343; Tue, 8 Sep 2026 00:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=yA1ntFD7ot1eFGtUxTsqpkoytXa9Fc7QMndzmvtPn
 ok=; b=LGy6dcoacFxK+s5bI8qM6uEY8rIlmxU5Nxmkd9yXs1DI3BBZRf5Lg/kgN
 C2L+1jvB4chA4ErMWL8mWKD+L+L76wjfBc76SG9oLYAZo/MdDZtGpUIl4AJnYAW+
 mY9ccQIwVUfmkaGMk8eytnzkvxDCcgwWDbtDmPW6EzWJF/j8pNE00ZvOF97Yk0HA
 ZLr3Kn58cek3UsfIYTKfjEz4vlMXtt/XRfr3XzhN5BpImOKUF39AwqIxEPyccUhR
 icwzadi+Bl401c0Qh2Xh/OPN+qQZVA3fmllklkiDD5bnPohaxiHU+d7jTWsbCPOb
 uZvoOfZdP3E3XJTXLBlmnO1Na6z3w==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj93q8st9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 00:15:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3L6QfJ86nKZT7pujIg/ALKTED8P14mONui7w8Kt+XtLC7tRh8govYVRmYFfHXVKF/ffj3Am1H2BodYphcU07lWptnHIPgiebywGnlLD6SLpw/lfltaIhw4stm96DoiGf46zanrU2EV6mcmdDIOkQBuRrloCupL4ElxJ4CyT9y7jxNN4SvnJ/7nr6v16fAEo6dbPTzfnGwza5lF0mBXYyCISl31svMlR/gGJO8xo7MiFdU5imB06VNmyRp805wUvhBi9o9YDrJPY3iaOQIUybXUuiwTrnz2Q8dI991Fybm/6qzmrCuOkAAhsHIZMURzrVwlRtlizaPHDhQZCna1slw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA1ntFD7ot1eFGtUxTsqpkoytXa9Fc7QMndzmvtPnok=;
 b=hHBPY9bqmshTCW+43S9miF+iVQMGkhMTITDe5ZTxkbPJwY1RpXFau/2JKZoRPFU6e3QJIuju1nWyZIo8Z2wea0ktcNjfhPnPg4LTK4LiX9qDb3r5MQa9/QT7SW/47Q822NKnWtZ4gQjINz9VTEuD/FpM5zsSFl2CtAkPJWs2J9lEHzbyXNG5+95LvGZlZ7WOkWQOOi34traH1HUaZyuJi5rp5/b/wJH+nje4sF/e+wvo6XFOpByGHJp6KDkEZrUvMGmeBpAzDGtUk3jy1wlejHJQp4wq0DjoCnu/t6tjWIYeD9EkQvppuY5SuubJ9kq1mkR6kzaS2fgKDrvgVFndiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA1ntFD7ot1eFGtUxTsqpkoytXa9Fc7QMndzmvtPnok=;
 b=CjcSmwFiFgMt4MEDxGpY96aw2v3ywUilOefc+i7tWiDWXHnYNruoaEjkQTACscof0CQrq1PRNP9//x9FRR4uvVG4sPZ40Ohm5o3aqzD44mD0K1NDkuxT7utmrr9FP90bpAkpWLWVwUFLOa5gluRJyRnObYjAN0NUXzrmgN+tFak=
Received: from BN1PR13CA0022.namprd13.prod.outlook.com (2603:10b6:408:e2::27)
 by SA1PR10MB7555.namprd10.prod.outlook.com (2603:10b6:806:378::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 05:15:03 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::37) by BN1PR13CA0022.outlook.office365.com
 (2603:10b6:408:e2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 05:15:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 05:15:01 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:17 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:17 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 00:14:17 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6885DwdB2811953;
 Tue, 8 Sep 2026 00:14:15 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 7/7] configs: am65x_evm_a53_defconfig: enable support for
 PCI-USB2 daughtercard
Date: Tue, 8 Sep 2026 10:47:32 +0530
Message-ID: <20260908051741.868824-8-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260908051741.868824-1-s-vadapalli@ti.com>
References: <20260908051741.868824-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|SA1PR10MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bc7ff9-9c69-4cf9-404b-08df0d6822c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: cuDZDDjmQtsKG1RMV6SZSyPMo+yJlc5skHYwSQZRlWB2UNV65ZTBm7Z5HED0Q7LnvFhOg+pGUPY91HUJ5RWyA0bYJCASNNE9T8z4W9O+KcIc3G+wWH9suE2UK32SbCBj5LAxi/WYVy6mCikrwnaRQ/gNYqOIpWic5qXZkag8lE73hzfBHPc1EkNpRlwwv1tulfWgpgvfdtHRE1bjAYXzmsWbt6IQrIF33gQmUvC76sG2t+TfSeDCoRBc3aNeaIdY/rlYAZt3utoOj2s5YtpdlTORaubXmow4hxqIuphTr7H1/cWJjIyvAEOUt9+kADa6UAV4ctBlWCeaC34WYWpDz4MWjbm6EsRZgrL6grxaqLwzrr3k9yvrUbuzIrs1hSyp63BOqPaq+KoUxLrOoVtF/0mgKSNkVgFfiPd2BZhrg+7HPxTbu0jrwagZrJe6FHU7ivtX38o0Q//qbHra/Wg4FSkT+wGafXjNx4zXjj4GCFfdLNAAXBvLrhWBgPlGY5yESQBQC0YRZTh1sMy6WKH/tl1zZdcfGPqK4yEzqsaj50k5u935fvnJzAwLDTmAV2XIPIS/wQ8WH5JemalyTCVO3/zFEIPTJGeiNNkqEFOlnBt/rUUq98JO6BgzGflloRCp61T4pU0ytgarqJi2RWh98VqTz3T0i9QmRoYR2rWBAHw3D36bW7bcrmXIpJyfqNE4+wppvnJjBxNpGsVK1P5ZYg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UZoxNTjGSOJFHb+/+rno+RQMxEphVwREK48M4a3MgxgI/pBbzvel+4JJ5PmRR9FVB/2EFI4R7tCr+ISEiTs5xmWWpIFVVrDGTR8olUuzz8omB7CLdYznXjHKaROuDBZQ8L20TBhdrFJ+Nky05INFN9P92u3D5qsNLlnI/a1SEmZznwYpPs1cZV84sZPyQkG+e1ynvfbifdle6VXbCadfWH3oSmX7XGxFZutDLuAbepyQbyRYIvV+he9paA36JN09VnaKaR5ZNQGRkBDId+Z6g/LTFYL84uT9bjKWHenbaIwad6QmmANSsfdJCzIRUsabc4X9tGbhqQ/uDXm+oqdpO987I2Gryp39KZWk/Lps+odOoo/jz73XdejeLjI+KXW5zopfilcBRLAjv2ddsMePNhki3SyyADBc76Gg7lMeKDNMXRWONM7hpKXlB5fyq///
X-Exchange-RoutingPolicyChecked: p8kO3lda5yJpKc6vEx7PuDb4w3jNuqW3oFHWysPClv432hy+4g2oJGMnnkFk/RcWsRla2qPy2UM5imUFYRvkW+n0ZsbzLE2P6npTxwE/FLkNBayWmG8roQY/ISb1v279T46PnXhvpSp8jM3Pv2cNA40PUo94vfNrc0980Jf24BUn1cmf/VcEyLXlVUhFjEgOoB8xliHO4Ew7OPB7TytQxVaArfbiOjxn5hD9jIDCtCXhz3mIlZZn6qlDfmtRilbZHBVkBCI9fjL0Ve8phE33Z5lVWjEwCtAQU0i2X7rN078FAASvPWx4zH8TwbebbIs20xESWbMjMn+15gEFqfiF/A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 05:15:01.9550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bc7ff9-9c69-4cf9-404b-08df0d6822c0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7555
X-Proofpoint-GUID: vC0OS1tz-nCNf2HS5S_Z8MriktAlAF0S
X-Authority-Analysis: v=2.4 cv=FvQ1OWrq c=1 sm=1 tr=0 ts=6a9f99db cx=c_pps
 a=3/9ZW+mBBPtU5+OO10+n1Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=V7vL_nJxelFXuZnW9_MA:9
X-Proofpoint-ORIG-GUID: vC0OS1tz-nCNf2HS5S_Z8MriktAlAF0S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX9l0SQRrbwHex
 fT0J4JCARf8AgHNIMzHiWKo4aENOogX756XjoiAMcLu+xEb3YMW98Av5Gmr1Deg0jVs+0fVkV1a
 WbrCfpyQ5Xr5PnztaYZM5JkgJjwHE0/KXmYO4j163e6NySw8qjdMaao4UE7q/UYl1Ij3gar3JET
 Jr0Vdy+tPCXvwj0mL9bcpfP7+bYbAcljXg+rWQVKc7coyHT1kT4He8oPGPa1ShZzME3ONTgYqY0
 J3Fb/yJ3u1wtNRvHCl+9Eo+VE31HJg8z/MsQweHULfgzHhC2+0HHZjGVGbk6pyPzbM6WLpI76+Q
 2dNKViWmB71x2OSEKLcpQftr8TVjW6vFWa+4/N7it8uDSyTsZbBtgFiTsinxtyj9a8YhAXDHHa+
 HBxRoALoCwPAkgAa8dCRPLPKIZ+Czm4dmPeGRIvLHsCs+drYc7iknIawQ5aomKTpJ6NJoUIaZ9u
 dYfTZfXC+rubAgZxorQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX19nO66Fvxxj8
 uVoRxevXI8qdCTj0GosjENYH0esGh2OteHbOOasAPSe1Jn9mCDXwnn4p3pT48bsYp12ptIo46KO
 Q594D6K/7MtxbJ05UHaWLyKIEzuJyZ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080055
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

The PCI-USB2 daughtercard can be mounted on the AM654 Base-Board (EVM)
to enable PCI x2 Lane and USB2.0 functionality. Adding support for this
involves:
1. Detecting the daughtercard at A53 SPL stage
   => CONFIG_SPL_BOARD_INIT (to probe daughtercards)
2. Packaging the device-tree overlay for A53 SPL to modify U-Boot
   proper's device-tree at runtime
   => CONFIG_OF_OVERLAY_LIST (updated to include k3-am654-pcie-usb2")
3. GPIO support at A53 SPL stage for detecting the daughtercard using
   GPIO pin 38 on WKUP I2C0
   => CONFIG_SPL_GPIO
   => CONFIG_SPL_DM_GPIO
   => CONFIG_SPL_DM_PCA953X

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

No changes since v1.

 configs/am65x_evm_a53_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index 5878816f63b..036efbb0e35 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -11,6 +11,8 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x680000
 CONFIG_DM_GPIO=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am654-base-board"
 CONFIG_DM_RESET=y
@@ -31,6 +33,7 @@ CONFIG_SPL_SPI=y
 CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_BOOTCOMMAND=y
 CONFIG_DISTRO_DEFAULTS=y
@@ -64,7 +67,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_OVERLAY_LIST="ti/k3-am654-icssg2"
+CONFIG_OF_OVERLAY_LIST="ti/k3-am654-icssg2 ti/k3-am654-pcie-usb2"
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
@@ -89,6 +92,7 @@ CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_DA8XX_GPIO=y
 CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_DM_I2C_GPIO=y
-- 
2.51.1

