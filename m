Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA044CD98F0
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 07:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4504847C3;
	Thu, 18 Jun 2026 09:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VphrgLZ1";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C32/oN1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 134E684874; Thu, 18 Jun 2026 09:32:03 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 800718460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 09:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I6ViMM3435884; Thu, 18 Jun 2026 02:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=rpTr9Hd1n/aa7lv0ozdUgXQvEHxVmrpeTMRe4vteF
 P4=; b=VphrgLZ1QNZJxyHlvFUwDDPAjseoMYIqnhZkbH+i8A9SZGG47M7WHYg89
 k/MvMGBIledJzmvOTY4mzIuTjbFP1HKF3oFal7nLsGC9rQqUyUG2nKiDFgz9NrMj
 DwFeJDnbyhJcLmoyUjMi750qy1/9q0qg6ADAU4qa3AM8evcHO8ZM7iKPPE82lG7s
 +uAt9s9pmM294tz9hj4pL5CtPgf5ZFoHI0nn1JuA6Gm1+KnSDZdAeJUf/ZqZcR5n
 AJqpQhuNVLjYvR40nBI9V4vS/hJ1mYoF0vf5hiUiYf9yaVlAymqBCj6rjoftFkuj
 AmeTrY/ND4w3IT3bR8FKygj6APsuw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ev63rj018-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 02:31:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lK0pX6mReIYYk2f2o1FYBlUNJXYCkf14Q1jeviWnxwZDUsZrpslYjDM7VeopeET2QmK1JOCXIX+Wp2WcOl0lXmq4hB30HpJd2eWw79tw6fDq6T/WgjbR83ADcE3cFFFFs8/IFbCEatVmOzeUt14tqRyWmgJkF3SgHZg1hQulMZAvJmFtQNthHKm1V8np7oCjtk6MF2rVUsToazGPsCfKlLdHush+tz52+MWLehmVr5BC+TWipzHFS+43Q1WZuSm2QNFcieKRUIhYNT3XncXnayJhBAfe3F13QUNlMgOqDRoNUii3dsAIz9LEVKO+kMEiDMCVAiwCRwAHU6oaWrNTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpTr9Hd1n/aa7lv0ozdUgXQvEHxVmrpeTMRe4vteFP4=;
 b=YYWEs9zSedCl2fmivYAYBFd1+/RqdqFhjeqABYQMNd8lZ5nfj9sNWd6O7iLS89dQrw2fGb1Vm1WykSZkdNclmSTv4gkBdfIZfGreuprp1UG0So8iJs15xJ8rTEkm73rFD5xpasyjYfmB7F/5VEOtQLfRKzlT9W82z6SEVBdASYs9XN3RZP8IlxWA/Fag+mrIJhaob8fdgdzEzHfvGkxxJ8ybUEjlfxuTDjKYpVg2Z9OAh4pW29zpofdfAXG+rwJ2sICjPJ0wTEgln8YFzDOsxVtLEGlleyeEeDFxp2dRzC3y3R5rEIocW63zU+W6MA8FI76rdBVB2Lm0UzR9l4pfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpTr9Hd1n/aa7lv0ozdUgXQvEHxVmrpeTMRe4vteFP4=;
 b=C32/oN1IRvME4aElaLipIhNp1k/Hlfdtv4cBq2jKoXx7Q/DgmlKMhDoeYctHPMPDH+SbUOKBEILS0WeUBs6lx6VcCRL7qpEp+aK+cKf0T3rs7M47+akC/h57bCGdPsBiK4D6H//5JL1Y2xt6utyjYAFLyCb49BhT68bF4Oa/Zz8=
Received: from DS3P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::11) by
 DM4PR10MB6135.namprd10.prod.outlook.com (2603:10b6:8:b6::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.13; Thu, 18 Jun 2026 07:31:48 +0000
Received: from DS2PEPF000061C1.namprd02.prod.outlook.com
 (2603:10b6:8:45e:cafe::20) by DS3P221CA0004.outlook.office365.com
 (2603:10b6:8:45e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Thu,
 18 Jun 2026 07:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF000061C1.mail.protection.outlook.com (10.167.23.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:31:48 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:31:46 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:31:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:31:46 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7Vb2f3513641;
 Thu, 18 Jun 2026 02:31:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 4/4] arm: k3: drop redundant tifsstub runtime filter
From: Neha Malcom Francis <n-francis@ti.com>
To: Aristo Chen <aristo.chen@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Anshul Dalal
 <anshuld@ti.com>, Jerome Forissier <jerome.forissier@arm.com>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>
In-Reply-To: <20260528132746.719699-5-aristo.chen@canonical.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
 <20260528132746.719699-5-aristo.chen@canonical.com>
Date: Thu, 18 Jun 2026 13:01:29 +0530
Message-ID: <178176788966.2536492.3811015875625321543.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781767897; l=659;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=XsUAfAnoY3EBllcuiL+fcmKg0kqxiKTjpdMoctzX08M=;
 b=Grx+OEFOh9/8SGufxlc3FStv5SSgJMXXRKqrNQa3ampQtYKC10hB6s+5wTDLXdfiG94aLKaWi
 P5xcIVpV0sgCGsB55gdh0kToVD7W9PLxs5brSn6rG5YzJOpJQW/mKoA
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C1:EE_|DM4PR10MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: c8513228-cfb5-45bc-d81f-08decd0ba81e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: ZT0J4FTLF6Ed7dgElifCS2FIRRRjTJi2UBw1INGeyLAEh4BSMGj49cs1CU/WO3qKDYB2ksTDllvzB7QVjujfeOr6cdRaJCQvIi9xat7LeUP2e0X2k0eH/gpgnKpN3zhhluaERhNA6EUapM8VSRkUTGGwn+Nz4r3aOct/P+sLfeKOySNu11PWm+zjPQI35el7wr8ItdFaw/RP4vYDrJ/tlRG5f3wsohFnqnxtxfEpF/J3qkopnyB1BFV0v++kmuxvHl+Xxv/NkMEOw+7DTZ6znXTcvhlkt/G+C0QgthTiAMnx1WMpZ1tSUqShsiF6GPJPs2afHyqXJmu4gLGbTL3GItcZcQV1PlqrC896eKpzFAekMZ2m8lrJ9ZNt3jQ10mFUEPUDmxPGQCmpBJwlS5J4wJG4Omr103+X3/56Aai/a+dateBonGKGOMhksnxSAiNO4IBICjrVM1Z8CcfvSy1JtzqmkH4tjRqUDH337giXjFzblBMw+kB9uh2dpjKyqK2p7fkDIf5ZDELsABeoeYs0KvBr3Au/6a03t8fQ9uNQR1uWFTVwUZwub5kIHuX1HoEp09LlJT4uuAcq3YllrX26Bl+XHw0Bj9LQ3NxmxdzfZ9CjohlDjfS+ggHFkSwJ8xlmj7tXA3RvURy3bLKpQEZuNNAZUUmQzNAdyiJDlXLvwS57OLZElO0Qw1yScewoR58GJ9HPebjsQGWVMm1CeIwndjmFwpPx7I8tyHk02kMX+Bg=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8dsYP1ADQXI2TNoqOFAf7dj9ocghXwd+ZtwR5p/9ghUHkNKooBUUxq97fNk05yon/HYRXsAY53Xieey6joMROyd4uDC1kO8+lVVhCVMuuRwtE/PpCef9snjcZuxuUVHz5P2V/Y+e7sNwug2ZrTrnlw3dG11Ix5KxKW8xq4tBQvXm3SmgOAiZQGSgNmda7N0TRlsGeTWrGOSBJ0iDANtrTJ353LiYpX2feJZqgSSHVP63swWfZgPWbnyjKDNNwE0QossaiHXC1P5Hcp+pJt8z4NFeWIG9qFVTJMxn1wLPnvfua+C7RBuTgy8li1YnEyULBwsrnX1kxLPdtm5a3Hgp7Cp3fKyDZJecIAa92aE8i0QqUevrfAusg47JLNEj+bg4025gt/6OXx6M1Qs4hiabE95Kqb4knkEjwqZGFYDz3fhF+yglxXyeSbptb7eN7a6D
X-Exchange-RoutingPolicyChecked: pvsn2Xp3hMRjZFkoOnqeZauGorDfoK9pLO6YMPavzuglikGnEtW4AYXy7tswcROzYDGOk6odkOlKJhe7oiyHIOYQZhF3Nj2kgjtHnFazMZE/ZobV/Fyt5bpjMFL2rXyG2bJue+zmKCiRymJCSpd0wB6OhkPNcG4ADdi8/YF8zIW/t4icupBwhrAciIDDVfw01onH/CiufkSgHxhP3DBrCv02yj4wIggGghGqBjGMKqLzAFxLZ1InnXjrcj9uOty/NNHa8o2/h/tLEgUgFcpYSkNvD8lpdQHr/GKYAsr74f+utgFdA5FvnqmMG4bZcu/EOaI7RYNmIn/yJiisXj+s1w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:31:48.1119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8513228-cfb5-45bc-d81f-08decd0ba81e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6135
X-Authority-Analysis: v=2.4 cv=LpqiDHdc c=1 sm=1 tr=0 ts=6a339ee8 cx=c_pps
 a=IFr6uxAXmWssV7p2N+XdEg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=DfNHnWVPAAAA:8 a=sozttTNsAAAA:8
 a=vGpJ2D0REXEXaXbbVxQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2NyBTYWx0ZWRfXx8ie0qreSzC7
 Q9w97D86Csw9s/Q7Pd8OfWgseV1TY+wx7STldIQMh9Sg21sMJlx2OW/z7asANX4W0F8zJAzurrw
 lmovZb6LitglkhX2OwTgtbVyrrB6Bos0NxVX7yhadSDlOSnWIz7H9qtX6tFSdgZ3zCXXkKASYzP
 W1wLfzFP/jvJCPcaw2GQ4XmveB3SLx0aFNcue5bNEnnFTdsXStIQvldjeYT/CL4D5Y5SUVkZynK
 TQe3PuhBn7f8WAVFEvTA3yh8oqD5YmO+vNTgKlAFzBn2RY0D6zbHkCV9S61ktNfkJS063m7fe7K
 HqjaBd/JwFp0fIx2mdU8QjP79uq9pIU433siKHGF1kAFkOtsSBBA7K1ZszQLafKspFhDu/G94UM
 DXCXHfPW+o03VRifUJLiYgwHx94YOijpOZmj48JY942xbdc0MbnrWA94pmkj1fIkbjr2G8SHr7R
 rkCgI4sEAq4bpIu4auQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2NyBTYWx0ZWRfX+2e+5EFfeWRj
 8sbyjdpi8/UN0f4OAxWlP31TEKTpLfvIrs4arDXEDEA9aaSgFrq7kNyh597R3uf16NF1uKZDwMz
 iaFQLTUlBuvuCvG9TsXEZ+mW31N1Q6I=
X-Proofpoint-GUID: dtyTY_QykhMCkStw-G4jbdzRGq0Vh-Da
X-Proofpoint-ORIG-GUID: dtyTY_QykhMCkStw-G4jbdzRGq0Vh-Da
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180067
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, 28 May 2026 13:27:13 +0000, Aristo Chen <aristo.chen@canonical.com> wrote:
> With all AM62x family boards (TI EVMs, phytec phycore, toradex
> verdin) now using per-security-state FIT configurations and selecting
> the right one via board_fit_config_name_match(), the runtime filter
> in board_fit_image_post_process() that zero'd out *p_size for the
> wrong tifsstub variant is no longer reached. Only one tifsstub
> variant is present in the selected FIT configuration, and it is
> always the correct one for the current silicon.
> 
> [...]

Acked-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
