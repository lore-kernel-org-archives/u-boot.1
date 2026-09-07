Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7BBC79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7959F80AFB;
	Mon,  7 Sep 2026 08:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MZQch8vRVlH6; Mon,  7 Sep 2026 08:34:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 42AA080AE8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788770084;
	b=F6VmNak+GXrucRYkwOXJdMAfzkvISkbrtRpEVt3lQC54LcxdbiGFQMFovXoZB8q2B4QC
	 kp6IS7jAL6ZJwVnR8RE4TU9yfAtlhtA1WD8zC+k+xNySZ+eUVjLpU80KPjKWj3TGLH2Xh
	 KKyNCkFiy9Ew0DFOIr0AUomHiDPa+A8mCPSsnlA+kKC/OV5N3xmdVx6LjCB+eqp8fzk3v
	 VVIUBJGOegfGgWZ7ZI+pKuGMUJgat9HaXn9uaZIEXpAXiNVFSNarTtT4g7G7lM1m0Sbw3
	 lJcJ6RBpDfJKtNwJVBEz4q7jzDsIzxYFr2d4rgibMSZWJlORdP2NZ8Hhm6jKPEOJpiw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788770084;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s0rYMn48LurZ1Jv9OG27AgmeAbaqKtnmgOmiXAC+34Q=;
	b=CvXB+y+tiLevseLXvaKblv6dVRq3oOcJxyZtAi2tRHGs66AW+IE1ifaRjCuYukvyBS1b
	 rXSo1WMGOyctPQVlFCS9P8oFfFrapuqii9KSfYycr4hK+LI1a88bnpeN56wWLBYsZzQip
	 v1mgePtwGk6PD7KEBk1z1uBQVrSdPiMfMqGG8dF6Pg8ftQlI5pKGuIwbGA39WHJxInKyc
	 SkDSqFXbHRPVQjY1Wfqr8q53mAmHpG3X/dDxqTKCvvk45wPnPct/t5KiemBDef7OY+up7
	 euSiK47iArxgZ8ncJFKKn3bfhcQeX3dpvUY0IeWWAXtGkuqSiDORa1ifZ2vCPoKvr/w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=qVTx4RjW;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=QMa0KO7A;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788770084;
	bh=s0rYMn48LurZ1Jv9OG27AgmeAbaqKtnmgOmiXAC+34Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=chougolON5/3wW8v3kwE7xrn0xzzfCvBBkW3j1mQUi2FG8Q3SPhybeugJbM3nobNU
	 IJQpWc/oCyzpgiRIA9HNqCa7Ich2Ov3RyXkQi7pE+LM9v87u+9moXs7z3ZdAZUS1PI
	 8R01Cyk6DD7H2m83glh7YOVXhxEeTBr34KqJBjsbyXchSf8V2wwYboLEmkE32CiByS
	 q6kR8YbIR1Eo8RBPVu6ChPBuvBlf9oxtQZ/r/7U57nvPHmWWgfjeZaNvt3FyZiX9Xc
	 6heEqpMP8cHLIHMmY7gxZhCs0aQk692073tq9bCzIk954HKiznyx2lERWzSfyZHgao
	 dIp8FqupnYtcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42AA080AE8;
	Mon,  7 Sep 2026 08:34:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 571E2970
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 489DB80AE8
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id haIsNvvYt8TT for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:34:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A4D3B80974
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788770082;
 b=Q4j+g5r/HkWSqru6+JIB8N9Ou2zBMhWJoHMvsxG2Cw7x2LtPapuJY1LYsDW0Stj4hueZ
 LFg5OiMopgb1EhAZKaiJhIS/SqHL5vYXgOEUd8I+XTfWovq0mcobMVetPQGRUKxkWv4OQ
 ra0k26PcVV2XwfOpf3ZUkQ/8BF6BYYXV25MS6NJ7We1TFRgaHpfyd2APA+5eBjduvVLoI
 qozjdLBaslcRlrtjdN4+ymmEyjVg738dYKI1m2q3x/OWjP+IBP8IUh44ygQIrXes0bqOT
 LiJWGSivQa+0nnGdOctAM1B2PpsEpl/2szhz5VYiHG2oqKkJYqT3xfWXl5VbGrpQfkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788770082;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=s0rYMn48LurZ1Jv9OG27AgmeAbaqKtnmgOmiXAC+34Q=;
 b=jV0g2C0OjgCp9hAy67IMVT3DGDVtzHqsvX6eDkSLgF8o/PO4h5KbHq01NbBE3dIGKjzn
 nj7aRYD1aeHG3WkyQLWPPKZQ7yaeUEBw/dZDqrLUi04psGnnw3OKW0HkloobTo1O3Od+h
 tTKClUEnw/AGmH1VAJOHW0bQpp8O0VqTuRUBZ9jGugKUllXAEafzkQZf523QTqCL1VaTS
 h4GDv7IhZA3idfzahYIa/x8tFS5iALKMUflWYPi3Xc5Tmte2lOqWjZD2nnf7LIRykfS71
 yuhAGPPIromhPSKUBpV95g9BCuFG1OJd7SORrOr5r/Txg4kZRQolivg+Zk7ZotlC/aw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=qVTx4RjW; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=QMa0KO7A; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=qVTx4RjW; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=QMa0KO7A
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4D3B80974
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:34:40 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687769T12415437; Mon, 7 Sep 2026 03:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=s0rYMn48LurZ1Jv9OG27AgmeAbaqKtnmgOmiXAC+3
 4Q=; b=qVTx4RjWv2nX3AjGjSkKxsyBLvcLY1+cEctMdSJsWAozoS1ymEPtUVZIE
 0rCdhNt3h+tjG77cg9L7F3ewdztxZmrkDa7YuvUGEQZ8ZZb9rjbWae1/2mGLc6lr
 jrqE65JlXoX9xVfXEmHARzh3hlXKfmknLee4+6SsRQXHI7KAm7P37RBYpkIcsByI
 ISmr3T80BGACphjbijKB2Mu0GuJ26YYEEq7tO3N9XpJvqZnCxXdjCOlBzguqR1cZ
 XGNauFfxa+LA1xnqW0Kh+ZW6qwlWcO6Techt8I8CbJ5BqB/LKd1j7TdzXGInQFFO
 x1PXVgfel1xEJUV0HX+YkmxGdFYYA==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gh27q4v57-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:34:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdsqW/q98ppepgxrgadgpZeYf8glNFgng+1OASqjOkTRLXA+7qUWPn/FVUDQ3UGsBtE8DOhXDBMxE5jIaz8tRiHllWogyKbtqjVpfFXe4dVLCXOPpOlAlyHOIzSxzhlPpWiupnpzfmCD0rGg8VNs3XI0vZv9Hg08KAJ5hywWLZJtOMtfzeYprvD5Zd/MJWuqn9FxcZW7QaTOch+sQ7Z7qj+uBT0Tmgqy3GWPQ6znSM/2GTVcixP0p1pbMoIhyxTmPOZddEyunZbXpJXIGexlf7PcsSIsGoch85EhyTOuA4OAFMZ0PSVvzFLKnQ2K+5xxL/dl5A+fvgG8mFKd+oDfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0rYMn48LurZ1Jv9OG27AgmeAbaqKtnmgOmiXAC+34Q=;
 b=TNAIIq5jr/eJ8ZPF40r/H1hWIxCdtLBpb/slO4txgeUjZmcm8/oWd5LOx73lD1TR4eMgb2jZZzdU+6by1Bj5UFDoeXQdJQHRW27Pbb50YOeXgQ95N8tVID6opHuDDLByLPPjqIzaMsJ4y+pEql31OdoUGwApiam0qpWOx9ELffOUvx8h0P3GsIbkAymkjPP0LDgSvZgjZuYpQwUBGaKC4CKlfs5/qBP+QVUoXCsj4o5JE51Z4Gqe/6UqarcEBGRi6rJk+mxmA0MN22thqpPREsLiViSxv7j/rxmCG7uGI7ev1tVPmnkowxAXxp3x7OiTBbNT4OJZqMg5Op7tUSOLZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0rYMn48LurZ1Jv9OG27AgmeAbaqKtnmgOmiXAC+34Q=;
 b=QMa0KO7ABfWdBRmzCpV2YZOUL5G4xiE5ycl0cUzsv1kLRyhn98Rv9b703J0l3A79JlFovksYzwUw+YuLCKSuHs2jJBDTgTdITTqlww33mRdz3jhcBTNVK7JEZgwFLitlijvmVfYy/9uqL9MEGyXblbb8BsFM32NVO3/+juiPxyE=
Received: from DS1PR07CA0003.namprd07.prod.outlook.com (2603:10b6:8:456::13)
 by SA1PR10MB6565.namprd10.prod.outlook.com (2603:10b6:806:2bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 08:34:28 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:456:cafe::8f) by DS1PR07CA0003.outlook.office365.com
 (2603:10b6:8:456::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:34:26 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:33:48 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:33:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:33:47 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6878XgCc1165038;
 Mon, 7 Sep 2026 03:33:43 -0500
Message-ID: <203b062d-33a5-49bb-ad7f-75dc56bf1889@ti.com>
Date: Mon, 7 Sep 2026 14:03:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/21] ram: k3-ddrss: Add j722s DDR resume sequence
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, "Francis, Neha" <n-francis@ti.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Kendall Willis
 <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.u-boot-project.org>, <u-kumar1@ti.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-14-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-14-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SA1PR10MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9b9211-920c-4281-3306-08df0cbad3da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|921020|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1yeHbuT6nXuINP81xSFwF9/Eu0H4qTXt3ztZzwWb1o6KNok5ojaX53+7Q10o4+Qj4qYWMSvGXBtpL4hZ5YyCafXbPapK63eJ+7EugnEnBDmcF8F6fC2Lb2wnUlKLz0a5aPegqnx0cHIXP/f7tbz4Qjhu7Flvmz/Hzy7iVPN39JSzpvjuC6ClEOunc1OLpt/miukaEbRPTQrjf6VSa+6PHo5iIMScMUYdx6g7I1Hl8yuMQYyUGuaRafrFekDNtLAm0XXiV2gSsaR9ODbZ2sr5nuuPE7eK2WDnKET2/cRXa36dIGY/nYF1islp658Dh3kGe7uPXeDeppA9C7Q5iWmYxgSX1VXg4sTIR/YGjzNRKH2gkyhK+NHX0PIXXb9xJjF/DJQ7pFfX6bJ+za2LT5tMvI4zlDS3gfPoKHEAFCHNDCcFvzs1vMkXzWl0MaeXqU9GCOLABRTsC8/k2njSqDz/yq9V1b0a6sdX1a6v7lLGtKptLWNy6kk+B7JLCMzSe7AA7KcQBfdnpdD3Z0dhNcVTj0rhkb0asD1UwJP3qBZ21phMtzD6rUqWAwAl7gGq76FsgzsZWTvlJhA0qRmfa2HAgrRrp7M/vkBLS6zTMDDD1iAbSfX6gNmHLlC5N3wRYgwpg7w8g81tz0RZmQwvd3OZ2sWEm/Pe0/DslAYfFDf+vnEHKtpNpZn9K5pf0vc9jIOK3do1e6AINY4N/MsqdHsgqaDnYSCl0rv7YmqgmFhepWfTz3z7d80l+WC/9oJwsa8O
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(921020)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Yq4Cc43S7Z0qd1DTKjA5O5ElpibbEn1qmaEzviKZrX44gkPdYuBmN/SHlnjUplNF85RlzN/TwNeiKcjGuXN3ifv18JXsrIF6mX7Vf/IKP3d1gyexre6KKo5R/sJy5yQPmZTLbhmQ/pgK0yUMQxHKc+jdZV3A2x6pn8VaOi2hCXOWYr+kJZnUGuFBMuF1cPrdwz442rve8WRI310EC+tXy48UnB+0tchca9pU6CkCWITNrfb2XzI8D3C6QX9xn70E5brNGBtb0ftGgJr7LNpzWQt8h132g27c+2GUDzo+37Q5kpRI4sdQ0ibShlmiU+0H1f1+d+ZmcA/Q2DoY3UUryItkytgTSCQ5AB7ERLoHBnRRb+/RrhkwRHWcBRb+RCPQcTHlKyX/PGUaVN1WLLkkMQWCToDTbIjryLY+MUM+FSr1NidU+1c7HH9YInzqTOkF
X-Exchange-RoutingPolicyChecked: mrgQUdFh6Bf0RgqWBgEwOOUJwhJXZrSDdAVCVrtSdDge+0eIQPMcak7Caq/962CexIOJjCw2cYYIOOqaLDTXwuUQk2B4nXPPc9RW8o1bzEuQaMhueqDtI+6tbVvtU9XKsguD0d8tOXldsgJqRnyMG8c1SuZQ+Sz1Rf4xagxEC6yDVyRFkOeWuWVAsDxQpjcB0zUQw14YtG89na4JE182V6pzHU5483eFM0ga1T4KWwQ1+E7J1kjevpJ6iuMSynOlbokYvgo2dLgyxViu9tPMVakFwscCufuTLjsf9Y7YDgSVRAIxz+eYwBBcBSTme22jyccbQlAodBq7RX9mFsHgOw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:34:26.6882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9b9211-920c-4281-3306-08df0cbad3da
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6565
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5MyBTYWx0ZWRfX8ikyXc+UCjki
 rgKYcHOqp0RDWLqNsRd+81BkpEwfYOLCEPmjjWpXMTvYHAwVgBFHJTTtEpfnpadLxPS+8h7BQ7j
 g38kT+UbxrwOWhsRdh+bQVNeOgrdN/p9lnOBeJ9lI/ZM6Lqm8RYQhjlrjxVyk/82YfT+jEYKQBB
 5iD0MKEFskbTI38JK+fu/WEURU8yEtnhrjXT5st3n1w86FAcP5u8nTn+VkNA+3xTivYlvcHEsNm
 1UC7gj8xwgzYXgomXafP01Vulrliqd7RNARp/LNCEUJU4kLsdM0eZGhkHoJSolFdxNaWP9jw7ft
 W/BcsQpjYzzUS0RnRTO2AMT7yhTNj8Vfxk6camv4/imrUpVBJZ+Y0FHukFDBweUo4KIeXCYebFQ
 ghzuO9vWO7lx+mlfqGaAySS5iqHIeFaMSY5wwLQEZesiUPzCRuCmRgyLyr2y5LK726WhdoPDa/m
 ifMAudRUgORuuABKxpQ==
X-Proofpoint-GUID: MnpTU3p8Wa15haYbFd4Ph6fNHzdi4CCT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5MyBTYWx0ZWRfX0CiVDmMLsfrP
 v2/cBPT1GyJl54ujeLGlh87OepD5955HN7K6XB7v/SfpVrCTZpGnJVhmz7858qYYYHVcVvtqw3K
 jJfN/NTpIhPbFLI030f2veVIO/VrSuk=
X-Authority-Analysis: v=2.4 cv=e/82j6p/ c=1 sm=1 tr=0 ts=6a9e771c cx=c_pps
 a=iFPpiVoc/n5aJfOMV5u8/w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=P-IC7800AAAA:8
 a=UeQGHI-cgEm_7HdXxCcA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: MnpTU3p8Wa15haYbFd4Ph6fNHzdi4CCT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070093
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



On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
> As the j722s and am62p resume sequence differs on the way they are
> detecting that the board is resuming, we should have a specific
> compatible for each one of them.
> 
> For that purpose, introduce ti,j722s-ddrss compatible.
> 
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/dts/k3-j722s-r5-evm.dts | 4 ++++
>  drivers/ram/k3-ddrss/k3-ddrss.c  | 8 ++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
> index e1ef5d181ed7..cc4a5910673b 100644
> --- a/arch/arm/dts/k3-j722s-r5-evm.dts
> +++ b/arch/arm/dts/k3-j722s-r5-evm.dts
> @@ -11,6 +11,10 @@
>  #include "k3-am62a-ddr.dtsi"
>  #include "k3-j722s-r5.dtsi"
>  
> +&memorycontroller {
> +	compatible = "ti,j722s-ddrss", "ti,am62a-ddrss";
> +};


Acked-by: Udit Kumar <u-kumar1@ti.com>

Neha, please add above binding, when you re-spin
https://lore.kernel.org/all/20260714125537.3304217-2-v-mannuru@ti.com/

> +
>  /* WKUP UART0 is used for DM firmware logs */
>  &wkup_uart0 {
>  	status = "okay";
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index d8ec8356b286..3af360f191df 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -19,6 +19,7 @@
>  #include <power-domain.h>
>  #include <wait_bit.h>
>  #include <power/regulator.h>
> +#include <mach/hardware.h>
>  #include <mach/k3-ddr.h>
>  
>  #include "k3-ddrss-lpm.h"
> @@ -1300,11 +1301,18 @@ static const struct k3_ddrss_data j721s2_data = {
>  	.flags = MULTI_DDR_SUBSYSTEM,
>  };
>  
> +static const struct k3_ddrss_data j722s_data = {
> +	.flags = SINGLE_DDR_SUBSYSTEM,
> +	.is_lpm_resume = j7xx_board_is_resuming,
> +	.ddrss_deassert_retention = am62xx_ddrss_deassert_retention,
> +};
> +
>  static const struct udevice_id k3_ddrss_ids[] = {
>  	{.compatible = "ti,am62a-ddrss", .data = (ulong)&am62xx_data, },
>  	{.compatible = "ti,am64-ddrss", .data = (ulong)&k3_data, },
>  	{.compatible = "ti,j721e-ddrss", .data = (ulong)&k3_data, },
>  	{.compatible = "ti,j721s2-ddrss", .data = (ulong)&j721s2_data, },
> +	{.compatible = "ti,j722s-ddrss", .data = (ulong)&j722s_data, },
>  	{}
>  };
>  

