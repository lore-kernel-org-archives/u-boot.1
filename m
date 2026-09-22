Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48958C982FF
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 08:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF9AF80DBD;
	Tue, 22 Sep 2026 08:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M4Ibh8m0dc5o; Tue, 22 Sep 2026 08:46:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BE17480DA2
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790066771;
	b=USyJ71Q4bviOf3i+Xo4/QlmqWp7ctJb/1cJ0GNbEdnuFFnu+el+O47JnrjqChr/W+y5w
	 gGOJKPHc9xrbiHu+suA2nDPfc3e4Vcou7YzzPryafgk0fv2y5oNedBQ39mZFJ0XrslnqO
	 3e6qm//jUOAZjsWVJjSOndxo8Z6Q2xdjFbMYcruBA1J/OyJ4xhWLgZ6IwHVbs2eb92u88
	 lS+kBdlpQEv99f8xtJQimSoyT5mjlaq0AiuNYm/XgeKCQVJs/4xzeEKgpwLQTgUf2KhX9
	 cSEjX99wtKr1i1RIRlvFFM9wKWuNECZe48L5VWuVmZqSGdjc/Yt1Bs5/s/7L8bi2z3Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790066771;
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YcjiA3s3i3DE6wK8mS7b+Z2dJQoqEaCIIySAzsAt5Mo=;
	b=GDbSkDPL5IKgWrbdO9EV4IznilJIAuZECOg3c6/pMk95FXxGKtMgnwcOheK151g0HKOX
	 5HK0sU/FIhF8TyMptoO99/SsTBmkB/p7rQZGLIN+etxa8gmV1JmecA131RUHee/7ZfSvo
	 7cA99qZAF6ixSYOZobuA6p/sEUbtTIIekmNEwozSR4/Ob9uhNfxKdYPi/Gd1CpllgQK8A
	 8xJhOh6f9N8ZThHS0OKGjBVAZdo2jU5PW4xFu8wgU+P8QRJjj1ONr+LIC2lm6RwfNmgYb
	 1l1o7UB+cxzFJmXOngNaH+6o1WbDyoovCO+ZzEFM+ORBBFziWplvIg0+zSwONiYVunA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790066771;
	bh=YcjiA3s3i3DE6wK8mS7b+Z2dJQoqEaCIIySAzsAt5Mo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rlbaf95WD/XNhn00QSY4lY8uh3i7NrDF/4jbgnRDe3ju7U5lffVLD7CkfUMTZAadC
	 XUrMIrUxEIwCUHylOqEPycuVdDZQJwV0ZC4ybmP09ugTKP5Jhzv7KaFKr1mDLtNiup
	 5jkvE96MjEzBLmMVA/pXofHbqRdNztLXwkoZDFjqw82r5xv91rFYkEER6OoMmr1HtA
	 d1h8Nc+iYs6qaZFooll4jrf23LebWN011pVyDV4hkhKjRnd1P6am4SU3dvZdMsjd8g
	 SEl9SugxgiQhGuHsEbCok7iuXZpY7sXiPNokumZFedaud2pIkmbg8F669f+YKdC4Pb
	 dv5ny+i1fC6jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE17480DA2;
	Tue, 22 Sep 2026 08:46:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01C91472
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB89340766
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5tB-Drc44of7 for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 08:46:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4A60D40750
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790066768;
 b=bRZ6plKCkmOjRB4zwCcK5stt2QbHNOe4WBhthtoAos6T/4dEZ95+dXSoQe3FTwqt5xvp
 ou0ghMgAN7LnRZs2kUNzI/EhwxO9itfeP5kcKDevuHVnCoqoIpALU9JqSeblPmHrMYDsP
 XHoN+Fbs7Dz1PlbYuIOvFynAO4iWl4zk6QH5xVD0/QZj/vHNoFuEY9oOfUqTZ6/JFinJT
 ukADEmTAnDc6DV7jr14ionuOODYZDfzhrzwmVJXCCmJxgxLcxJf1mzeGSt9dQHgfFfikA
 r9FzjRboq+TWyd1fWh+viTjviFYF3ciY9vj8E052qaog4jhN17U3jy3cyj4Kkrll2Ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790066768;
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
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=YcjiA3s3i3DE6wK8mS7b+Z2dJQoqEaCIIySAzsAt5Mo=;
 b=WrhTzUPqfhfLFkZrsxTqok6G4HQ3z3zu0Ue496k3mudURWCdRI2jNtKIcJm3CLKPYBQi
 N1bFgZfA7hmfmWLFu5f7OnOgVY3rePbleQHNI2nUS0nzfOJmpkYwibIzgnfYl7ns0KYgd
 jZKY+DW3gayVq3KwkBcKiVCrv9mnNHn/2ZbxPeAwQguqruEVa8NMUkPFPM8cnYCIJdXA+
 RAqOx9TglpvY5QoJn3KxbPi6oLvX1R0tIJMWIJFd6vm5C3fMVyxSikl79b6x4r/CkaR8I
 73j+Yv0tIJMuPv3Hm26mLu2p3IeIAETsRO23By9sDh3tFAVj6B6adwtOvjCONCpUWzQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Nk5Ax3A4; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=C3EG04UD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Nk5Ax3A4; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=C3EG04UD
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A60D40750
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:07 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M79ccs1436671; Tue, 22 Sep 2026 03:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=YcjiA3s3i3DE6wK8mS7b+Z2dJQoqEaCIIySAzsAt5
 Mo=; b=Nk5Ax3A4Iqusq9ku3O5OCk8kDbu+YoxA7Yef++aPcODP4NqDn5Xm6b4DK
 rIWxCUdnHZ7usWFRcBQ/yqRs8E9aLDD6LMb04lLhBRnBu9PqARXvsIyho1bfQvoC
 r/XkQ8Zi+mXMjV5IV0Ed1VpdBrSyK/HrkeSCzStpris7cITi/09A9F/WfUYUb3iX
 QcFTaRU7eymoXSRH7zuuucJZKkwqqMmzaY+W0CjVbJcIXc/40hTzy9wS5vW8iyrA
 joKq4tl3ybkpg3OymXMK1AKB/xGMTyt2X4piN83Sk4+8x6avqQUl+foAe76HLCzt
 SjUjmdKEVzTrF61LgdKno2KGCplwg==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012061.outbound.protection.outlook.com
 [40.107.200.61])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gugcssygv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 03:46:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/9FVsfeCmPa65IMdSHmn6SAh7/I5Vlgz7SUmbou1sASUMaZwiviaiC3qwQgiW2FrqhJMYfm1WCtsmYluxzvphWwCMXy0YGhh+vC49koECzKhb8W16p9nAn+2NpGYMhrl2hiSSYaRcPTRpI23oLbXW2KrPQCOb3TD6aA32jYxV8KZMlSbmUYo9QGDZIi+VF6NC/4DpSdOGukNcMFxSq0MF1udlTg47u+rllY5wAkl1lF+vOhgrUcSaAUn7Ua5eCcMmnroSVMNr6sFHt++VytwkI2OQ8VZCj4jowqo/P8ncexalGJszlMgyn+iUQEzCIa32f+AQBSlWSQ4C5Rh7n1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcjiA3s3i3DE6wK8mS7b+Z2dJQoqEaCIIySAzsAt5Mo=;
 b=TNdW8HmtMjtpZU4cVC1CBRH+TYzwqhYLoQIxbGetdF6s2u1m1tWprJYdrDe02kDtwcbQ6bREXvJUIajS47uEqwBo6c3KHJdk+rw1+Vernj4iVD127UMIpDZGTF44t1nQ6JGkCba7AibVldjr/Xz+fQbhhmKwEboNTTBvxMiNVgq5UCNZ1cN0GFhKHww9pbB4kO+vUpIuIyVVquWmta6tn8Plm0jHR83xVYXLwVGDY5aq4u64enNQ5Xv3s6VVgwTzjzDM/8YWFvUME4FpTfPEw6Np/v02vQrVKZMvbeB40wZuLbvqLDdcpUWkkEitSWOZU0iHwwtycuVXQPcP+6BvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcjiA3s3i3DE6wK8mS7b+Z2dJQoqEaCIIySAzsAt5Mo=;
 b=C3EG04UDmnKN2iFi9eoIyIXAm3P1aXoqhxEpxbkz2hEO9799xAz3g2YyDr6nIFDxKWZ9CXcnj/VQrlF+OrrsPQiQpXxkLgFjfGt237+F9jmJ0iLynerxZ+haoYStIYbdCDleUyHN3sTVbTHm4Mo2HPhkdniG3DRKsn2A95y8Sdg=
Received: from DS7PR06CA0018.namprd06.prod.outlook.com (2603:10b6:8:2a::9) by
 CH3PR10MB7161.namprd10.prod.outlook.com (2603:10b6:610:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:46:01 +0000
Received: from BY1PEPF00026958.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::16) by DS7PR06CA0018.outlook.office365.com
 (2603:10b6:8:2a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 08:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF00026958.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 08:46:00 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:45:44 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:45:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 22 Sep 2026 03:45:44 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 68M8jaFK3813357; Tue, 22 Sep 2026 03:45:41 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v7 1/7] arm: mach-k3: Add config options for packaging HSM
 firmware
Date: Tue, 22 Sep 2026 14:15:30 +0530
Message-ID: <20260922084536.2477291-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922084536.2477291-1-b-padhi@ti.com>
References: <20260922084536.2477291-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026958:EE_|CH3PR10MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: a46a10b9-c18a-4314-492a-08df1885ed5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|56012099006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: jj13Rj0V5taUluJD75QpmUXLQXtkg6wv43b6KLhIYRTzaMFRPQur6p2Ud4mE/H6zucUd/ZT+GY5rpjtHCad5np976lk7Hzy/vBc2445JTW/briJH3oBhh6DaYK4T8MUzKHJ+RZkdlkV6UMKNcvNE2Vc5JhwWpPMqPtQCNV1zCn4RT18/GiFXpilYf6u6/IxWZI0rJTrZuFxGrr/kKiaT10AZkJAT2VxG3CIi/AEfUGmyNlxik6GkL9WA06C6RpMgT4/iXVX9GsQKsDyLGcqw7zJM6lTX3caqnH5VO2k+31Tx0+MP7qWOjzZfdmWLF6LhAm1vHWEWdzsdm/ISYES+Ypsugu2lxCj8uWUkK9v5UBMP6WBC+ZpE4UdCnOeAHPqSsbx4tnq7Cq8rOd38LtE50aO6w1kwwbtEGZ8n58yVO59JRGYHiS+2ueTwea/Ax+hn5m+bBMNktfzw0hyeh6CJFO3Mvvg4DDoyYs3YGVBv/ev/KbQe1Khl9wP+O7ifXEbp6CIx4shTHPkIOYTwvuXveobTxGMFSfOmBsU+i57D7xCK1TebYMQtO31gZXa6G0PacqDeKnwLJG1ADg5neLp8wm8TO6OSK4vz+Rhh1duA7xjoSuUA+rqJyXnkv6NOPytEvuyGGURGjQ6OWStMtOxLUPG+WNcOTxcYQvBArHdBfVc=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BMWdDHYRMgQApfHj78JI85AFX7rgrtZCqIW7J5itsMcPUF7KmoQtkL5ca8YHBY2okBjjojLDmaKuSLl1UXMebWrm/UBIvhe7msjoCQoAWfZpdGgz8NMeKk1U0jGbGEXcyjmf7rhIyI9n2Bsji1ajtVV31DOTlze3CcjS4rW8XMRe3F2f2r2QUVIdb0kujLlRDyEgEo47oVpTluCGpANxRrHHLY6ktdmU/neqXVj+56ubxGFssv04KuDL6mBfimc/FtQZ6lfMAl4pDLjEzeuSCYchGLX+gOoTyKlP+/9mOqdMa1BB8HsVBeLn6dd9I9wVYDZnSJYNUo0urx34q8agjU+1Aj5ML+XL5yZk7/339DU49pIWCd/9UPx8UglV5qOOCQzNQR8XKpoISDEYQ+5weM8c/bN0D3j3HBfRqUC9FVOWD8qMFbJ5ykidycWwmIsg
X-Exchange-RoutingPolicyChecked: nj9xd4i0k42JqV7Iyb47QRPKph1MrEUwpu8wgDeLqvm7NGkiK0mY1xA7LxZstBzMfvWsCwD+Op8rT9HXGC/FhAacl8m73Y0MGAnBQB7AfIv0lOBo4IhDFwJikU0ajPL/lp33eBJMczOle+pEUjps8za+sszLa4/A7RbMt/h2gbKcpFqusohIUtCLlbenDRcc0b1nDPlb1tx+BQb78DQb77UCmr6RHDs50/V55V5Qhd1e9dpPNcNbu5fP9A0ZKEsHsj7M9LVNHlfEaAxkT5gJLojSfQACNEMIjb9oa1+b7VhKNcGJw9b5i0cx78ib3mAuGE7qYh7vS8iOKF39lL2muQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:46:00.0383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a46a10b9-c18a-4314-492a-08df1885ed5a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026958.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7161
X-Proofpoint-GUID: L4vl47M5Vp8aGF8PIbNKlLnDnS7cv6Kn
X-Authority-Analysis: v=2.4 cv=GI+dgeNK c=1 sm=1 tr=0 ts=6ab2404c cx=c_pps
 a=1c0oZQ8MA7sDNsoFSDv1iA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=voM4FWlXAAAA:8 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=Vh17HNacWqn-ezHjO_YA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyNSBTYWx0ZWRfXzVC/U/e7dGPA
 EVHc0rcL+2GzfMUMmqNpEGryz4ePDAjGS9vJYNllk3sGEj8CaoVqmg9KGBQL2Wa6U8r0yipUMVi
 u86EVQC3LVTIgSG6oQHesdVzgVZlwnw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyNSBTYWx0ZWRfX8AN37VuOggeu
 CAzWpTPKqbgqRyTFufYpNMsuc8ejOnFc62VPxE9c337E/nlTpDgNYC/II/7TurhOeCi4zpvJYOi
 m6hn+Pm4jwCvX7BhZGeArY+yihL1Eg7eIaiHDWH1sgtxKDHuZFnL5oKSyy8pn2XuTspqNVF/9Rg
 0EoY2G2kBnx94PzNjQAcPBBFhF9etVU/W21lqr6ih3KV2Bia2VZ8IiltTf0xPzwC2uLihnFYXKV
 kX39MQAFzKxasF4vvh7WSKAAToZUC0mV666f54lZidaZhrcCP27ZrAtQmrKj+vFiVtSFx7BJTkw
 eN2H/JJLRWDOUKE8NgBJx3kiPQE9C0M61yq+gzsdEjO9BPwNcuaitCsmLPHocGzpgJk1fd3Fhae
 nh8j8WIDl+MDYQ/+/svFgpmMjnyrwVeRpy9Ll0jn+8ssnCOEhaCItm2QvFBVrTYzD6NHzcqEW6X
 28ctnhcxM9Nt2El2TKg==
X-Proofpoint-ORIG-GUID: L4vl47M5Vp8aGF8PIbNKlLnDnS7cv6Kn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220125
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

Some K3 SoCs like J721S2, and J784S4 have a HSM (High Security Module)
M4F core in the Wakeup Voltage Domain which could be used to run secure
services like Authentication. Add a config option which indicates that
the SoC has a HSM core and the firmware for the core is available.

Add another config option (K3_HSM_LOAD_ADDR) to specify the load address
for the HSM firmware image. This address is used to build the FIT image
header that places the HSM image in memory during boot.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v7: Changelog:
1. Carried R/B from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-2-b-padhi@ti.com/

v6: Changelog:
1. None

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-3-b-padhi@ti.com/

v5: Changelog:
1. Add new config option to specify the load address of HSM firmware in
memory.
2. Add R/B tags.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-5-b-padhi@ti.com/

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-5-b-padhi@ti.com/

v3: Changelog:
1. Updated description of config to match with functionality.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-2-b-padhi@ti.com/

v2: Changelog:
1. Removed 'default = n' line from CONFIG.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-2-b-padhi@ti.com/

 arch/arm/mach-k3/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683..f7b42a4912b 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -198,6 +198,22 @@ config K3_REMOTEPROC_PRU
 	imply REMOTEPROC_TI_PRU
 	default y if (SOC_K3_AM642 || SOC_K3_AM654)
 
+config K3_HSM_FW
+	bool "Package firmware for HSM core"
+	depends on (SOC_K3_J721S2 || SOC_K3_J784S4 || SOC_K3_J722S)
+	help
+	  Enabling this will indicate that the system has a HSM (High Security
+	  Module) M4 Core and the firmware for the core is available. When
+	  enabled, the firmware for HSM core will be packaged inside tispl.bin.
+
+config K3_HSM_LOAD_ADDR
+	hex "Load address of HSM image"
+	depends on K3_HSM_FW
+	default 0x82000000
+	help
+	  The load address for the HSM image. This value is used to build the
+	  FIT image header that places HSM image in memory.
+
 if CPU_V7R
 source "arch/arm/mach-k3/r5/Kconfig"
 endif
-- 
2.34.1

