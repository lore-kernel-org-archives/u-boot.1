Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45560606A31F
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ngWvTM8o;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ntID8C9b
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74BF18116C;
	Fri, 30 Oct 2026 21:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c_VEp2DA3_Pw; Fri, 30 Oct 2026 21:16:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6833B81135
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793395005;
	b=J1TYKBeWVY0E5MS/BOuxdsXNDX+DPassKpW1XsqT5MdF1r8hLel3uRyf5wF2fgfpZ9Bc
	 vCkSiXdrglR1vYoSLzf84m10mOlRJhKfKkseoagSFa5R+TRZz/2LA8+obmdKNQMjudhTs
	 rQebbAYdmnUVTGa7Obm6N8Nkcin6ce5PAMYa5ssKlGDeNGYio9qSIS9ROBxHY2K5IEHY4
	 pKnMgNXRsX4kfKgLrnIv3nU11epbQ+ZsCpQcNaim7F9zKzWrr2S7TdqOZulbnDg4xooNL
	 CzDZTJs65xCYnJFXI95VbabtjhK7vQBCRIFMeg+074/fSZ9vWIsXZk3Mnh3iVbfhnEw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793395005;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vFchfAekc+kDYwijTSiJdvdWcEyPyhjKGwtWSB42ClU=;
	b=NRs2V3lM/yy5rDlhv43cmtSEgBbCChoNlzo+Z9FheqDo/QLdWCxc3nxgcinUNlxsFt2h
	 SBpwdHhhx8Ii6EkwZY6g60i+X/GGL5krneiYJF3uPjNc3aGukeu2XAALg5k1m06uoP3Yq
	 VGpWI5bKCCfqhMZuAw3xRtm4/6dcd3TePhDW55W7pms3KW1Fi08ogsv7S2Tv+cMFXM/9P
	 yqf2Q6jaAGN+e01jFkcTX86jsUkx+D/LxjKBwzO635/VB62gPNsx0MR3oQCKXYk/KqJV/
	 ziO3CrmO2g91/HfkYu4YNpo0POHPy49uH4KIodQkW2QC36v2wy7jeuaO1LP9ebmCt5Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ntID8C9b;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793395005;
	bh=vFchfAekc+kDYwijTSiJdvdWcEyPyhjKGwtWSB42ClU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ngWvTM8o9thiwInLiU67bRcDIbuDOaQvt3jAlIqCeEk9SeLv4ie++XJvJRLZTSgGa
	 4j1rXZlIR9HCZMXO0EeXD2cKmMQLoIOcE9hQNzERWSOohK3zJmB8CZQkIGx7QNGDhq
	 BWnnhdPVys+O/DBVv1G0Hio4W2HxecZayRSWMKrAhzzHR567Z/BmMYoY6VBfF3bVyF
	 +vGxLn5FlYV2uHncgtwTUDB5qAq94kRTH6Py+UZsrxM9Ru2uSdky0P7qKQuYZYyZyS
	 d5eAsFcpKG7/eNVGgysNkyDiEYsAMrTbL0bPSLJMVE1edJw5QsOjDMS5zStMJ+GDW3
	 FuQeaNo34hjwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6833B81135;
	Fri, 30 Oct 2026 21:16:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C7CECD38
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACE86807EB
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:58:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id anGHi4FuhTnc for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:58:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0151F80806
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793372315;
 b=TMzNvaUFrPS5DtdUIid7a33ym6SPNddXIa3eWmc7aOiMXpTKqUrVKxAuubFf5saMEv8d
 05df+61u1aprTjl15bxke/XgSS8RDBlZHJJoReRW0NTYL28MNyUoUDWl2zWA85ZzMEPi4
 nsq5eFhK1sehQMCuVLAX3S0G5vIKwKP/Q71S0cS7vmVivA9Oeq2Gce+6dCmle9RcuTe+L
 PMo7cWswVxB25iL5nQn0OMlkUC8f7Km1S04Lw4YlBgi58v9iC6rbp80ZP55Re7aApZbCN
 L0Ab8LYxkF21VWKXVdMUbZb2uwPAlluOtwAFMMZv0BwkSNB4x5l840gWobReRFzqDcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793372315;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=vFchfAekc+kDYwijTSiJdvdWcEyPyhjKGwtWSB42ClU=;
 b=g7VYrlnpMlmtVhg6TJ1nex52XHDHlOw15ut6/YmCoJi2c/9/5EHwAgwAA8FafxG2j5/t
 OrcuRrQBen7EfpjvjTWbRSCAwRZRzNCmEZ7nA9umlg8CoWVCJB/fHw4GrUtIKmMq2Jg3U
 6twxANPyVpOL6UB4N+sToKdX8ZaJWPQPgmmEKQkecjnpxUdaRU9xCmTva3dRMEPeIDm8G
 tCbmsC7GhyV629QIy/VtjFv/x4nInVM/CD/Z7xDvPRxUA4MYvib/BMwTtbuSuBv4T1KPQ
 2tlJrz/M6phIe12En/m95P0AomHZIpgo91k5JS3Jy18lQcdsPhSL1V+2Z5fKWVPvYeg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=foss.st.com;
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ntID8C9b; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ntID8C9b
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0151F80806
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuMKHyqmJbsyS48RzoVdd7Kl/leCjBosAl/g3lB1+6Xc/efgpc41voDNA8F9vphsmLmpJiaB8pSMvvRJKYeLjsSVPrIakQDx/6qtKKKbOuMXnss4SZmpoPT9J10aKLK2dHewr8p0YOTuzn+sIErC5tOUWUB0TWoeY5lOQIAkeOXa268LXRUYbZFlyXDG3g15kGkTZ2KDzaVWWGJ9yxkrJJ82nzti/owrJUF5QbItF/uVJ4MFh4/p1zQZ55Oti4Ln1bK2CKIniz9qCUlkQrzWANb98jD11hY47S18baVYezYgekX29ZQQwZTn8fqG27Ks5RY+QcpCNK4iUGvQBO4PYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFchfAekc+kDYwijTSiJdvdWcEyPyhjKGwtWSB42ClU=;
 b=Kct6cmmvJGEDbvkXVTPeBGmF6yPx9B8ULw59v7eXVko7pq1gEVtgsntq3N0E9kb6Uil+StcEvMWCij3T+6l22zb2f8QNYkFqObHBtAP7uTPUcm0FKFM3igMSxSA3WgTSyIoiEdT5KAIqibz2WNIo5nbcDlSVEu0TktDSZe3lHgIf5V8PP8iE2T29/G+AVLQUSgvtXWk8k/IDvhzpWDXwSNLAWIPmmlrN5Bt+I/ExHoShEU4J2MSNLt1YoICiZOSppY1lG6PwY/6MDTNMlOEy7oPCi7bo+1+lk7MRi/ZSRyV+cVYRiOscPGZIZEoXb7adNIOs7FXXm7v27rRMa6+52w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=bootlin.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFchfAekc+kDYwijTSiJdvdWcEyPyhjKGwtWSB42ClU=;
 b=ntID8C9bXYO5+fisHM1mQxeP0awl6ff49a3cT5dvayNIhNj+6T7rEWMMBFVanVDLAbb15Nhv78fZTzE98khcinfppJo237PJ9laMhwxRkVTmJ1nbZhlUhTv21RfkpBRr17OwEe4A/2E5OxD1dseoQbTonQQXPvVNOchKjccmvw2wjvePd/fBfCdvhS0pPtVwtjLO1yIzQGDQsrWIoigxEbXuoOu2CoCju0hkArnDJ0Lf2ozCVW0F4dVhab71uTIOyNJ8YD0fcXatKGKXPibtPFwNVAsb1Y6vmGt6oPzuJQXz/lH/KqaKY0Ltz+Y47zGCayBaCur3qtGby+90pcloyQ==
Received: from DU2PR04CA0215.eurprd04.prod.outlook.com (2603:10a6:10:2b1::10)
 by AS2PR10MB7888.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:648::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.5; Fri, 30 Oct
 2026 14:58:26 +0000
Received: from MAD0EPF000008AE.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1:cafe::74) by DU2PR04CA0215.outlook.office365.com
 (2603:10a6:10:2b1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Fri, 30
 Oct 2026 14:58:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008AE.mail.protection.outlook.com (10.167.241.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 14:58:25 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 30 Oct
 2026 15:58:50 +0100
Received: from [10.252.25.78] (10.252.25.78) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 30 Oct
 2026 15:58:23 +0100
Message-ID: <083a1ab1-54c5-4a0e-b40a-6a5d12392d3e@foss.st.com>
Date: Fri, 30 Oct 2026 15:58:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: stm32: Fix division by zero for 32-bit timers
To: Thomas Perrot <thomas.perrot@bootlin.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, Cheick Traore
 <cheick.traore@foss.st.com>
References: <20261030-tprrt-pwm-stm32-32bit-timer-div-v1-1-f6f93d7923e4@bootlin.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20261030-tprrt-pwm-stm32-32bit-timer-div-v1-1-f6f93d7923e4@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AE:EE_|AS2PR10MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: e675040f-9adf-43bc-63d0-08df36963fd1
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|261021121427099003|261026121527099003|261021123027099003|261009223027099003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kL0cqgubv1rT/Cvgil9M5/5TJ6B31mYeSSaRi1YN6xqk4HaRL72SusZBgvTxb/NCe2UR2cV4ILUw2o3+3zbIU4PCgS53Kl68QZAytF2wYSYuB70Yh9ZSqBXnRJBEVvC64fwEaaWeZ2I4kCQh/gOjC+GSbF4FgEG5+1DIqbhPZlPoT4MJcQr+aPO72psim2vS6nrmi++SZudPw47B/RoKbRSML0Nh+InqdoEPrFLVZKfI4eHXvsvP+tuGp2cv+USKgCKS+12MeXKhFiVycOSOKt3rC18OHJfT6yFBrBOubYHhtv3QgUFEi7YrYqCO6B+Q8R4raeL4xTPMVyKudq5cttfQ7mzV9RPPXe0mx0jusxLci1wnXtNy8nCvp/NAJD15fS+dSXaZaBR9v5KZVf+QSmX2l4DQ/g2SGUok5ChBm8gpLq4f0MM2RtTnappMcpCEKUBK/FRxKe75gBPTOhYfVbhAQFiWz3r07IG3nZSdQpp0dfJq7ko931tvvjG/kIClmvr4vbQRCuEcgC+fmaLNp+mj4OSNdJyNPsBldCyla3jkiOBKzkeEhNlgtOlQJ9Ez0/J6EaQrjqR4WkPBv8AvDR3B60IsB6qZJJOssy3a4n9ANrXNgoeWg9yBKSaMGpJVhOhKclLg8jc4swlcrc/TaKUGVncf2LZgzNMkVVXSp76m5Aw5BhehAT18jXBKjkZ9SYbWPzvrd3YRtC4KJq8HvQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(261021121427099003)(261026121527099003)(261021123027099003)(261009223027099003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qGD2vah1KI/90T94XDVORj5z+CZMvk36+5thqW+UTUt5NJNQeZCddkAM9LWw1wDGzCg/QdyxV1GMY9orRpD/1PDaNDSksY0uTe7viAwqSxGonsPCEc8qf4dBsG6sBLZjYHIQvPllgL7vcc3QjKcggBHiWUTQdVjprS7bWMQhLwq7V6eE10Cp096HTwOvG1J+pxyAT1JQiCdq3OaemT1vtcE9h6cmlsZUfjv8RA8tvt+jZJ9uF0GOTPKfrcQTwxC7LnSpRoW9kXX0aRFVQzBT4j+Gq3NXS4tPdfHNenToFtm3AYF0b5ORtncbQ5vLF+7lZ/0y+F0fbq9aGb8vvFguY8NwHvRsSt5yffsrztMOnKsavILCNsmOfSzulRkkFB5y6JfsTIEWL7gL69wg/9sKEt5TQTitddfVsVaoauCPSA37tT2Y0koEkGJf9IwNotpx
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:58:25.2437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e675040f-9adf-43bc-63d0-08df36963fd1
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008AE.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7888
X-Mailman-Approved-At: Fri, 30 Oct 2026 21:16:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 11:31, Thomas Perrot wrote:
> stm32_pwm_set_config() derives the prescaler with
> do_div(div, priv->max_arr + 1). max_arr is a u32, so on a 32-bit timer
> (max_arr = 0xFFFFFFFF, e.g. TIM5 on STM32MP15) the sum wraps to 0 and
> do_div() divides by zero. Configuring a PWM on such a timer, for
> instance for a backlight, resets the board.

Hi Thomas,

Ouch :-(

Thanks for spotting !

> 
> do_div() takes a 32-bit divisor, so widening the operand is not enough.
> Use div64_u64() with a 64-bit divisor. The prescaler then comes out as
> 0, which is right since the period fits in ARR without prescaling.
> 
> Fixes: be5523d38296 ("pwm: stm32: add driver to support pwm with timer")
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> ---
> On a 32-bit timer such as TIM5 on STM32MP15, stm32_pwm_set_config()
> divides by max_arr + 1, which wraps to 0 in a u32. Seen when a
> backlight on TIM5 is configured from U-Boot.
> 
> The fix is ported from a change carried in ST's U-Boot v2023.10-stm32mp
> tree.

Do you mean this is applicable to ST's downstream too ?
(I don't find such fix there)

> ---
>  drivers/pwm/pwm-stm32.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index a691f75e4a71..3f2b593477b1 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -13,6 +13,7 @@
>  #include <asm/arch/timers.h>
>  #include <dm/device_compat.h>
>  #include <linux/bitfield.h>
> +#include <linux/math64.h>
>  #include <linux/time.h>
>  
>  #define CCMR_CHANNEL_SHIFT	8
> @@ -64,7 +65,7 @@ static int stm32_pwm_set_config(struct udevice *dev, uint channel,
>  	do_div(div, NSEC_PER_SEC);
>  	prd = div;
>  
> -	do_div(div, priv->max_arr + 1);
> +	div = div64_u64(div, (u64)priv->max_arr + 1);

I'm fine with the patch. Just suggesting here: div isn't recycled later.
So could directly set:
	prescaler = div64_u64(prd, (u64)priv->max_arr + 1)

>  	prescaler = div;

By doing this, the div variable may be dropped completely to end-up with simply:
	prd = (unsigned long long)priv->rate * period_ns;
	do_div(prd, NSEC_PER_SEC);

	prescaler = div64_u64(prd, (u64)priv->max_arr + 1);

Up to you to update...

Both case you can add my:
Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Best Regards,
Fabrice

>  	if (prescaler > MAX_TIM_PSC)
>  		return -EINVAL;
> 
> ---
> base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
> change-id: 20261029-tprrt-pwm-stm32-32bit-timer-div-eeb070ead061
> 
> Best regards,

