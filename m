Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D671FC79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 20:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2656F40661;
	Tue,  8 Sep 2026 20:12:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cQ0ftlFf5hcr; Tue,  8 Sep 2026 20:12:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 246FC4061E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788898352;
	b=RRZ0x/tdxjbC5KiWNRRWstO/42fNiLpHdgpqXCEvHuPHpY2I0/Gm98Qk+nZZo7diDIho
	 Gea4s317ANyQGHK319UpmvvCtskJ4C0VWTDZz1pD681yRPmAoKUmzN9jiqo++zMJBVMw3
	 LbqeF7ck44vg3/yuMhKyOX9yvzDdaZQ2dvdGrgCjNsKrkF60PrGD1igiBTcFhiHrcRmOr
	 t0W03N3VWQanyBlYcyXparBbjvxDwQtsnN6PRypFBtA+85CSx/SkXtYDrrcdQmfwDey8e
	 Zur6Uf98+LCXIhWszCb1tgpcF1hWO/Tvxer/DHKiW/saLjMYHrSmzVYqNm/XPLWoNGA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788898352;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cjR1mEiEkBuATdsPV6psuY2/KK9r7+9RUc6KpZcCrg0=;
	b=LaqmZmNmeislylHh23s1qSnpwwlxVGak1e7NK6zYOv0YJWb4n2URbPRrPzT3/KN3xDkw
	 pJPMxTrv9rWTBs3TJE5sw0taDgDR8yi8QTpAMeUyNYH5SFFYVqBF+9l/8Uv8KA+gy08OU
	 bZqKZqwbVnjsfF47a6RAmSaWyorqS/Aa2c4t7IFZhrWV0i4E3JZFqr6g8mKrix/stUIzr
	 eFEqiFcscrIydtOYRs8ROMedBWlyvyHGm26gXTcvvQg7p+H1ugt1ygKymaDRd5gAStNHy
	 1GeYf04Q1JcqyNBaGs1Mtcm++JwJ3R0+nEcFZSMGjbRRcK+2ikf4kj7h6QFow5M0RFw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788898352;
	bh=cjR1mEiEkBuATdsPV6psuY2/KK9r7+9RUc6KpZcCrg0=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JAdrAXnyara+YHmdA+Clv9BxpmqbETsw9lq0y8HMkwW8bStXtZrJlSreBLRhtoLqL
	 wsm9e/4rRMNndlmvDzTtKcOl8W1ng/IDa2/WGkh02FbztP+bpJURZ+ckmu7IjQ1oFE
	 7zOUscivZUQp4b83+nXqe6T7u+bewiiusZ8SS+xHjdJZXIxRlYqMZkRpj4LC3AvUML
	 LrCVQKtUqfTZXbd/C8oNmW8NiUsTyC+3ZJLgZqJSWS4VHj4E2W62tEm3275hjbntQA
	 Wk1pawAH1aEuypJb/GTxDehG3rPkSdAL99fZdOKBuVp1kTyE0jRQ3HnHSio10R710x
	 FennkzQsQkkXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 246FC4061E;
	Tue,  8 Sep 2026 20:12:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C884F755
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 20:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6FDE80CD4
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 20:12:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lkZXosVkojk8 for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 20:12:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AD33580C67
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788898350;
 b=KMF0gEmxDv4IAn3qjZwE7+t3D5XXbC25SMRZJjVGFZ0RyphsEznxcZMhSP8UbtXYsAsj
 Q0XZciniFzXvxGcZwRvO02iQHJjEPdWDapHfcEM9kmeEBRJH+KAt0O7qswu8npb3w3IIN
 fgGiLLP9eivrkbeER6FddOcmO0bbZDVQNYIQOR44t+umWFsedEl717hkDBALFs34QxwWk
 aZ96FTk4oxJkTNastfWxaK1ZFX6zXCLcPS7hLc9gqtU03Y68Ac2F8xnVmxr3VVYr32v86
 xDszsm/ps156GccPzPLg7gfJ7YMoLKDDYnnKc30e3qrLISCGtPh8Impsnh4SKU4ZYQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788898350;
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
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=cjR1mEiEkBuATdsPV6psuY2/KK9r7+9RUc6KpZcCrg0=;
 b=Nvsnivb2ZS7Jr23auKpXSSeYpo6J/KkVry53/lKQarVuu8dg9cJgi39mKqrugo3ZJBdw
 4EFMsjduyzjGA1tgYgy6qMsx72+i3+8xyYEL/rGey4ZPrr4n7rnXrfZ/eUWYyo4y9ROvo
 HLJDCpeoXuxBW8EoIRJLsBgIXQWHe773M4vn3ILdSmjoI9dnDc7+bVf5Kfs1ulWtwGcZU
 Sh+HACx2YettRIrReeVIanwQYqi7fJY5u+XETZ/gSo3rNeVsa0q/0BHSDKBMpnCWnFMv5
 fdw5OteMKRXVUCTlRhWbqqIloRLjspWAP2i1VYG6a+NbyQ/cCAa/MBlmEj95ncc27zg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b="aQtj/5wV"; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=R+RaSZfd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=jm@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=aQtj/5wV; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=R+RaSZfd
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD33580C67
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 20:12:29 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688HQRKU2576513; Tue, 8 Sep 2026 15:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=cjR1mEiEkBuAT
 dsPV6psuY2/KK9r7+9RUc6KpZcCrg0=; b=aQtj/5wVpOIp0aNyclOGKe1/948xE
 xDkWAw3YsvOw7ZUdHX9xKaBRhYvzySsS0UZtNgSgndeq+qg88gCT1os8T02y+bx2
 /W5PXbCw7xKW2Y4gNCqaGnaQ7Qp0FREzM2w2CC3LlVYP8DtCaUN7c/dFOxDnC6Al
 tXasSyn4JJuPprqsvbmCI/LCzj4slEjh/vDuHJCSRbJZ5dmhQYIW7ki9vPloiAtU
 jvs/XqJmE0P/HTMZJ0NwQ3q2CsJzjKyUb/SPKUnW8Q6/wUEDx+IhDzEPyzZGJaH5
 TT0tT4o8WyH5vlTbZ6otJhWMkYZbyaojfasUyuOp91Xb7nFSY9Ks/x17g==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gjn9v1j41-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 15:12:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWQE48FDmiX+G+MSPn/Am96LDPhYDUMkYgq4ZZ+SXdVEfXIhkdm6t1AVChUBM2mBF86YSFAfN0uLE4aDaHPaMPV5ySH6OgfcS8025ds2Dsg6RXt1oYP9QNr/SEOnSkUoIPWibLcQTUXZgq2M34kFschjaLyOmc2GQdrAzUP+zgUMxllhxt4OkY+3BTXABTlrVq1rmE2CR3eXyrI6t7czByZPaQKIaoaBz9CsZjPRzXY+phVVcUQwjHqrsjX3WSETznMEe33gXS0RhjG8wTtXP7rac7g8c2gJeLtCxdODONZThQtOruBk0E9TsjD6Oe/+A7GiDrhaOAu38s2ZmlUvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjR1mEiEkBuATdsPV6psuY2/KK9r7+9RUc6KpZcCrg0=;
 b=W7bkSEmlLUoaL9FGrpmgV/uDBSkumzaCBse5vX+FoCFIQxp551nixmdfV8Ehhx5dcPl6lYSCeXLI6NEKIgIMZMQikYEqeSX+raqWD0t///b0y1zcyycp+bDlgyEeXLT+VDrMCVhkEg7YRqosEu2oPg0Hv4TmmwuT9lzg9+onxrGW62Cl46T9yD86uBXiupsdv2BZB8pUiU98bmnoXnvkyFHs+pDW9Mn9LlKYJdphrX44r12hQifWaQb1enG1VG3SBNbDd7WeEcO3b9tWXZgYooBUkndE2hgXdTmlNn04IAVfQbqqDbmQYfoDoxgjRJYn9lI40yVjH4T3qHoslgl0MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjR1mEiEkBuATdsPV6psuY2/KK9r7+9RUc6KpZcCrg0=;
 b=R+RaSZfd/cWgK5+0Hn1f6hPzfw529OXV6XXHN0Eh8DAmnDL/3AHWBYxUWaatBvrLYtqPjbLUEVhLkmV/zuhlNkObusTa76qnMN703w8IlVZNVDwzYuH/4TdTUefvQg2Bn/ABGMsQ8EubxktTD1hH1fXTAGZJjAde7z2fPcH+q8c=
Received: from MW4PR04CA0216.namprd04.prod.outlook.com (2603:10b6:303:87::11)
 by IA3PR10MB8018.namprd10.prod.outlook.com (2603:10b6:208:50b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:12:23 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::90) by MW4PR04CA0216.outlook.office365.com
 (2603:10b6:303:87::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:12:20 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 15:11:46 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 15:11:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 15:11:46 -0500
Received: from hpz2.dhcp.ti.com (hpz2.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688KBkfC3101205;
 Tue, 8 Sep 2026 15:11:46 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH v2 0/1] mmc: core: Add power-off-delay-us support for slow RC
 discharge
Date: Tue, 8 Sep 2026 15:11:45 -0500
Message-ID: <20260908201146.532645-1-jm@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|IA3PR10MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: ca584291-79d2-41bd-a97f-08df0de57d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|13003099007|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: FJfTLtA1Qtx0Mur2MkMWLdvOPUhd71Lv9MakBywIkCdSj+ONufH7nQqR16/zKNyiNYa1sdent/pVi1a21MGJdNZ236deYI+map0hPmLjbCeRPwNXfFsmYzFRkSqLKhnlVixaQDGX7UDG1hM6ysxFFJqEQfTf7ZAWfVig4eiPLpPLIecUO7smQbJ5Rz4eqloNlr6R/emnF/HHUaFQrRyCzqs6oS9DiwFxzVj0TPtlVVtXczqSdE6N6qghSDueAqKtHPFGLLcyY2U8anwyG/fntbMKkh6Okx6hrgpfon2D4FDzuyzHCVc+HrA3UqPwzp1CcRkfYlbx7TC17zm7QddR297V/kEuVu5XP0HY+NdnEZNyElv02Z5hisfpVd8V5baSea254J57pz0yG4W7+Aki4+3Vo7vXCiWMvsGdbJrsVZ6zZQDOX32UDgUVf5XLNpj7n9ji1XGph8fvS2GgMnvxD8GUbubRKjll4jdh1J8M5fQON9IID6VkZvN4v70z7RkV4IbDe/MOgGv9lOlOdU8JTRiK/3Ptvp4mef8naHg8RtFpTqdVdbqQ2Ts9Nr6HoxbhQDHr4Vb5Kr22/6NKIZ++zNoTznr2yFKZsifBDa+wOpx9KKG4EY4kvgeHmOfX/OwJiIB2MZfauaB0pP8JI6AXi9qTgg8+Gi0Vzn2XNfUUfkJwMLL3DnoGKVuAY9HzGiRFh3G5+CpngIsE5N3Tp2Q8Kg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(13003099007)(6133799003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H0W8LaTqFrYpWnhJ20e/H3wJPxKuNIE3mQ8mo7PZ/xQa4obkKhwUc70euiaD7xvHaCgzsMzbxFDxJADl7/FuxYVtMnpqlsztMUfYHLJwBVoKA54twCWslnAPSPaWLQkxMC1M5ds5Puez6JNWqdc0PakcQtMeJ7CzzxrzreMNkLkn4YuSwQFzE7hkHbI3hDL+oI18X9egm9Axz3RZ/oDw4+FS2WSo0RTEkn9uTzlSx3pmaJhAXTZI8SKVESZvV7+lTVb2YN61HvPXPdLYhJj54333XA4qCAzwj3+fr5s4qakT/UAcyKfnDrEmAA64/Qv8O8ICINIFuQ4HUMZwQuNWy53OE5JgjzlFyyafSoO1JLg1WDKV9CmTrNQTi7yQTU/UxZ5d0ZvdBwAEe2C9TYgLjZbTGCH7T55WfNnYsztH3CBhnRXD/4chVXpOFhR+IytS
X-Exchange-RoutingPolicyChecked: n7H0vthxjmIP3xL+Qx731BPCeTds2V2uteG9JgTqXqQu/VQrbLqjarwiJUtugzWaoBOYMuv/GKkY0MSlWBvAH4YXM2SXCx/bzsqcnIpxfOQ8cjJt2XD+GqUM80bttZSYU1kYFpFO4DxR8e3lO7ApG+7o6fvZLCxemSB7yRa+zC3HrvbsWGtYjxfFJJfdlL8ADhnSczJZ21/+PwW++SJ1CNd1EGzFCUd16nveQ8XgFGe25SHC6heG3Lw/HBSmOevXiVJfciTOfNY7H99L3n+D/naSmTkHLr6vNtuss76b2YRhTVufyNwkHxd+6UBc/6oxe0OGTKWaE14xh8cAfTI/tA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:12:20.7680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca584291-79d2-41bd-a97f-08df0de57d31
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8018
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIyMCBTYWx0ZWRfX9v4TfR+btgyd
 0bvtgO3a9GRI/9VhunKY9Ur2IPpoA9es+XHqyDylrb0D+SYuaelZp79SfX9aglKF+iw1g/3fuPP
 VCcKrODvXwsTeja5So2Q/HsOGI6Evyo=
X-Proofpoint-ORIG-GUID: fuuBANF1eBADw1Xs04qn-NKkYApnhduj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIyMCBTYWx0ZWRfX5qRcmg5tDIge
 o2dEBlk4DIVQatDLftZZ9pgZCTUCn/90IsBv+XjZj5OeAIqO+gggh0uKsi/QuF7L0LSzF381TKW
 yzC7oClNAkP0bcc125daL1I3kbd2n+c0Pi/engZn+pNYGj0G7hJlAPuODzn+av9y576t2lSDXzB
 ismo5OJq9GtV95G5lZYCcBRLp7nZWx2w3FR4YFocsjahZpGygFHb0n0yOBKmZxPKUqJnFzR4EXc
 WSpz0KSQUcMucT1xbenx7w5mUWvC5riwFo+8uhkMZg1fivOOFSIRPycuW2rBVaSDfFCZfdducU4
 m6IUgeMtYApjpHKZPkSJo4TZ5RMqcyfr2kTK+BHo97Lbvvi9M0R+cI0XDQSy3N1WF1rsP5XLWZj
 WSVFOJe7pmF5/FkGO2RFXAzfN3hF39pfgvQjkWebY88ON0xfDzNMi21CdRhNCLQL4yYrl1Aeu2G
 XajtfP/Xpbo4ZTyr3/g==
X-Proofpoint-GUID: fuuBANF1eBADw1Xs04qn-NKkYApnhduj
X-Authority-Analysis: v=2.4 cv=fvjsol4f c=1 sm=1 tr=0 ts=6aa06c2a cx=c_pps
 a=cRSuPULe8LMj8fTR+fkUeA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=HE6Ko48DAXqzgHd0A7IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080220
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

Add support for power-off-delay-us DT property to handle slow RC discharge
on MMC VDD rails during power cycles. SD spec (section 6.4.1.3) requires
VDD below 0.5V for minimum 1ms during power cycle. AM65x EVM requires
a delay of 650ms after power-off to reach below 0.5V threshold and allow
proper RC discharge.

AM65 EVM power cycle issue was exposed with [0]. An initial implementation
was sent [1], but would have created binding mismatch with Linux so binding
update was completed first on Linux side [2]. Now that binding is established
and device tree updates in progress [3], add U-Boot power-off delay capability.

[0] https://lore.kernel.org/u-boot/d17a810c-e2db-4a24-a37d-2d7e02466ce9@ti.com/
[2] https://lore.kernel.org/linux-mmc/20260806162202.657512-1-jm@ti.com/
[3] https://lore.kernel.org/linux-devicetree/20260908170635.238775-1-jm@ti.com/

Link to v1:
[1] https://lore.kernel.org/u-boot/20260710230409.147210-1-jm@ti.com/

Changes since v1:
- Implement delay in MMC core instead of voltage regulator driver according to
  binding update [2]

Judith Mendez (1):
  mmc: core: Add power-off-delay-us support for slow RC discharge

 drivers/mmc/mmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.34.1

