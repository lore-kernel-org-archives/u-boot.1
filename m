Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F05C61DBE
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1605480E6F;
	Sat, 29 Aug 2026 14:34:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2A8NKvmoxDND; Sat, 29 Aug 2026 14:34:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014074;
	bh=XwO4/cL+ZkpaxCGoDYsluFPB9C92x441PrsFu9oRAqU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q9neDeTf2Qubq93jGDHTAjUp++9gvu2ZQd7dfj7zDOmow95bD4EGgktA22gdwDAr7
	 lRXPS9ndcD9qZsgmE0zAobwPyrDnknbWuduX1phz9OGjjRl3E5dH0gGK5icQ9CSpGL
	 QHIqMPVUO0pGFDLmHPgkXCajdTEeobvl4wJ8NYeOYXTnp7xYSdEdZaogotPMbPE1ab
	 OIIN4HV6mSwfbye406daY8wi4fNX0Fj2UFrfAkynohkktKLvO0R8fkWMQDn4HQ7Hws
	 fSjBGhFhLp6+5xXjgrOqyMGSLyWlGU1pQNIQuAXI6G3ov0TQO3AFZh9vo/czz3qy2y
	 o6dYMWqdReSbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2734D80E75;
	Sat, 29 Aug 2026 14:34:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF532127
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C56C780E6F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JsdjWGsKHm0X for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=USdfXrdi; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=p5MCqVh2
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1A8480E75
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:29 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67TDxqKd3258770;
 Sat, 29 Aug 2026 09:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XwO4/cL+ZkpaxCGoDYsluFPB9C92x441PrsFu9oRA
 qU=; b=USdfXrdiTHFGX53U7kd4PeWIMeq6NUQLIoJHrR0LSubtmx60B7rwphqUO
 Hs5Ag4WDHr+F6GCnCj/I/mrSm9F5DuVAf0NN3nkmfkm1zJqLLrqSpVQ8wb3+W+5H
 zueFh93Pbch92Gj9fSGjObxABZVF/12QHMebPeugAGfk9rriXuUzFaBx/9khdW65
 htHr//1Tltf4wBWlK/HyBylyiO6g+xCVtbULCtLVHQY9I9EhhiZsuW0TtXLp2UNu
 Jx8ssn+VaTIiNI0y5O6rNRgrSysefhHU43W1XeYAd1pQNAjuLbdHMw0DQ0XKvMgQ
 TV901nWr6lD1dQVKSa/9lOCVw3Gcg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gbqmmhqrv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohg9ErAWpNTbSbnd51O1VDdjJ5jtENpPAEgHL3f6DQc3WKqRyQlOpG+f4Qv/pCbaiY9pcUpek8dHqW1odAevaWvR6CNiz8z2lsGC2yg2DuRQA8kfyKV9J6aWbB1WkSOX56LGfKyZrzjmo/MhIG8lhIolDHa2is32iAd3tZ5sg13/vzik131Eve067kzmsQNTiMtfajsAjvOqZkSWXToUxAUCussqIyurwcAOEf2G86swAdXMkwRYJzNl4AFpIvSoasPZ/L4Q4lGBjutn5lF+auWsrNTRh3EjrLw5si39AmtM8Q6x/g4sH8EnRlehBkh1SUEqHD4r7z1dORBk4Riwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwO4/cL+ZkpaxCGoDYsluFPB9C92x441PrsFu9oRAqU=;
 b=mjIfjtLlu84YXv28cGkY+6CJXDuyy8CFx1d0xYs3eRpDqNFC/e0gfAOxOO0tpnexeNnOqKMYcsBTHaOIwWffKV8PUedhcTqNef4zZT5XtgIMCTNSLg7s81b3W9Th/TrMVhFXemzMRz2330fcxyCJX6486Uvop2d3BXAEOJqAU3lQ1UsCNUzzu/Y0INlgAYqP9FLlBxitaP9Rt5ELRcVCOCD5qSYw1dNDJi+2W+ZEHnRx7V6c/xSbLfQKxi22JeNVhgkV8dmjk1cspmwDl6q8dhVOX35pD/uPzcVQKCZANrilbonXSl1gFpO8064PpH81KSVwXtAvSwSH0HR7uXtsjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwO4/cL+ZkpaxCGoDYsluFPB9C92x441PrsFu9oRAqU=;
 b=p5MCqVh2aDYlHxJW6wBSIB8lb44Kp7Ov/WS1DCsoQ8g5nucQ4HFM0dCDuP+1TzWE2bYU9prRz1gNaF+KwIoMNTJsH+ZAaUBBbKYYwPIOcIODNrDg/9DmzYNU/mJ56T/qQhzLiswoq+3CwgCoplyuq88aOuOgrNhOikVJm+E+fLc=
Received: from CH2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:610:5a::19)
 by PH5PR10MB997757.namprd10.prod.outlook.com (2603:10b6:510:39e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:26 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:5a:cafe::a2) by CH2PR08CA0009.outlook.office365.com
 (2603:10b6:610:5a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.12 via Frontend Transport; Sat,
 29 Aug 2026 14:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Sat, 29 Aug 2026 14:34:25 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYOVr1551072;
 Sat, 29 Aug 2026 09:34:24 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:26 -0500
Subject: [PATCH 08/14] board: ti: am62ax: update MAINTAINERS entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-8-e4e03971e14c@ti.com>
References: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
In-Reply-To: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Bryan Brattlof" <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|PH5PR10MB997757:EE_
X-MS-Office365-Filtering-Correlation-Id: 57830ed8-18b9-48e2-9eda-08df05daa036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dEpRoo2l5NHJ6cZUvhk5RHCe1Nu9yeEaApwg99+GONndhz/X7L0sdlhWjWVqBBqPvYSxO/LbhVIW3aO2LB9I1YWqiuElAr1wfL7RTPPFBmpg1qfPG0s1PwY9/Cwy0BL0WtjfJHV+evMDqkw8GCl7y1ORzSplVoAWgXk5TtrFWTYla6FY6aGpRSRM/9FpmSA5ZT3GvyCxM9vD2B+dTOLIIVB3eydw7gjCb5D9jYdMzocVkdFvbXWTFhSyS1yXOgLmIVgwdfen9VOUfvY+4lq3XvGChJzbB7MMy66YTVvKoxDRThrEBDF9efItBhtjewbvt9rjuDA/ZbyfiR88c6Rhcz58GOGdglntFlZlTx+OI9SQW0Hh0MHgqVITZeqHvcFdKt5mzaWROYs/E3Y2meuSNCd535rBwsdpVy9s/1iB5unrl4WLYDJ7m6uMaQc8IkdNCLSZegBlUTDvGS3ubhXS5+5NtqfHwBUM3DaVV9AOzbzpi7Cm+mHoMbjEGll9aXIH/WI7wS2ywsqapZEIj8zVEIiBnAgWwW63C9AUHF2pKS2I9JKWRIInQOVrgPGzptZXymvlBffJjaeN6Whea2g0K/5/xymQ+f+Sme713sQBD0YcQi+A+zNzMu0FIJvv7Lf1GsCX7X2qic7vFYpC511U2QhiG8UcUBsFxA+BQaVntU+JzltqCrfYYYx8djmLoYcMPdgQ1aCCsmBEZF0mECDnuw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5ap6bTGlp8FVBG5sCViVuoGSmytXLXrsG8xKa/J3Vr2SI7uO53uorHNJYdn8GrflpjS4OUusCOF+LdnCuEB6EhGMyNtf56nMYI0VPwGb4X9jJSK0r5vifxuGzqma0EpUIC5rWitb7IvTluIMrFIZ7MbvyEcyK/J7qEUPZffn7yjrbgNSwHe9yguHv435aAz8VLWhgjmRMKoamkmgrf+k9QUCAbGp3+p36P3zUyefPWqvZvsSY+lNfz1SIS1oWomdXOUln/QXdKSRAYWg56I7U5XaiPc/QI8XOgs2YgUVwq9tvWOcO7u9NKdqYa0cDB8h7DUpTpYST3WHd860Baa+GkSAo5jRiyLKOdnnBrYFDulOZj/LRuPODzRGNZHUmw6UAKnTuWEsGdQQp6DNTXlDJkM0UOA+U+kpbgfWwmVfEg34C4v9X7LmXFaB2RqwD1RV
X-Exchange-RoutingPolicyChecked: Zc/6LxKRvjho2V0N70kky0yH8rg1nF/k6BzLUVQ+obuYw59nJgofX76yj/HRDFqZBjJFDG/rYncbjilnfZCLZ7JKRcGm8EYkSnaZK9qn9eKr7Qh/by2qOlt5QL+6vkoVWl2dYpa+63W8U8soCsKFUNwKb0TXOkjKPafNBWBEu/bRIdtGuTIPq6aPjOTx9fV6Cd7QIq6Pm/ym9RzcRPzG0LevPUP2GuCU732Zc4+RWyoObgqF5oXWOaLk9iY/bS084gvstcUWUBRFtyLa2Kd9rEuTPvxVs75ml1OSjh/0GjcxKYJ1MclbSWOB4wdbqF2kKz6a34eDs7sn9g9++jN3lw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:25.7855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57830ed8-18b9-48e2-9eda-08df05daa036
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997757
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfX+zClNcw1qUBc
 Z4KPjPp6eCOl+ccUsICeYb5XPWNAD2UUQq0wsmKgEnx8G1gYg8JPCMnPoZvZbJA4CfTLqmJND2v
 FxiG9hwSUX4I1UHkiDjmOOSqmMdS8TxQuL/j7cWnWeeU9eOP3JuJPWyd5SPDkgu8QEikfzOevEm
 ynz0GksAsevilEb5M25UTofkcIhXpLOINTHxUDnv0UIUV1doRq3mCr+3+8TWO2abMgcUFuYIvT9
 HcDWxp6iPNps7ZC0xJkex7wCvpAhYm70JjfZ5n4ceC7q+pnDrDofHKjfiGjw5BG7lCxk4YjkHyq
 PP99HThKxCBPmWnokR3gET+CNUF1Xa7KqaC3NaqKhMFHhRoKWZOKPgISrJdjx6A0Fh1CbBnNDLg
 RCDt9EBC0piAi+BczME7Gm6uHbe6Ri5YoFR91jnufX2jmJ+xCqlh20kwE7r4Cf1tW35C7giLJ8N
 EytGio0dLlEaV3YT5Rw==
X-Authority-Analysis: v=2.4 cv=YNuvDxGx c=1 sm=1 tr=0 ts=6a92edf4 cx=c_pps
 a=BRoDR27eCUDGJJSfTO8W4A==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=k-42gJp3AAAA:8 a=-lYE1ncAql8p4P8zhb0A:9 a=QEXdDO2ut3YA:10
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfX2UFwAAkHyRGR
 V0r3OFpQkQ2eM6s8Z1qUYabYHVGcR0FPNTSVdTxR39NfhMyKXU56Mx9BnkUGoBCy56Urflr1rzD
 iP+aRY9IQTomX5SLCqcz8GFw0WU8+mA=
X-Proofpoint-ORIG-GUID: 8PZJUzDJZOEimHEfNNGtiicV0V3HPEHh
X-Proofpoint-GUID: 8PZJUzDJZOEimHEfNNGtiicV0V3HPEHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608290125
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

There are some files the AM62A-SK board depends on not claimed in the
MAINTAINERS file. Add them.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am62ax/MAINTAINERS | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/board/ti/am62ax/MAINTAINERS b/board/ti/am62ax/MAINTAINERS
index a5fbbd8b2f88..f0ead6540e58 100644
--- a/board/ti/am62ax/MAINTAINERS
+++ b/board/ti/am62ax/MAINTAINERS
@@ -3,9 +3,21 @@ M:	Vignesh Raghavendra <vigneshr@ti.com>
 M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
+F:	arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi
+F:	arch/arm/dts/k3-am62a-ddr.dtsi
+F:	arch/arm/dts/k3-am62a-sk-binman.dtsi
+F:	arch/arm/dts/k3-am62a7-r5-sk.dts
+F:	arch/arm/dts/k3-am62a7-r5.dtsi
+F:	arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
 F:	board/ti/am62ax/
 F:	configs/am62ax_evm_a53_defconfig
 F:	configs/am62ax_evm_a53_ethboot_defconfig
 F:	configs/am62ax_evm_r5_defconfig
 F:	configs/am62ax_evm_r5_ethboot_defconfig
-F:	include/configs/am62a7_evm.h
+F:	configs/am62x_a53_android.config
+F:	configs/am62x_a53_usbdfu.config
+F:	configs/am62x_a53_usbmsc.config
+F:	configs/am62x_r5_usbdfu.config
+F:	configs/am62x_r5_usbmsc.config
+F:	doc/board/ti/am62ax_sk.rst
+F:	include/configs/am62ax_evm.h

-- 
2.54.0

