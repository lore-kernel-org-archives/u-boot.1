Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75854C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CB1A409D3;
	Tue, 21 Jul 2026 18:09:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OpSyRdoMzGuo; Tue, 21 Jul 2026 18:09:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3787409A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657367;
	bh=GyUtIl6GZbGwB13NgPXVlwPNZTix9TpZpsO9QoXpBHw=;
	h=Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=HH7atdo2jnYQAqWwevbwnPIF5aUVzhn1TgcXLZW0M/LNz0Q/8XXRrydqj+DVsciqe
	 mTkBgo9vIWx/Sz0Xxa2wY5GF/ppoT0vOvEDd/Ey51R4PQvf7c1leU11+5q7fLkk4t9
	 C7ECKsi1fBuu8Y/+bDra282XwACdsrGuWn7tuyukFMmDVms9NL0FVx4vi2oRDOni/e
	 TsSeU5D1jZ+xRBpWBlncIlPfTI2QsmCVTWOXPz38MxehG7tz1gsiHr05gS/dl8jJwF
	 5/pfqZ3UcBX6DXSa28izpIwaep+vs83IuuOwEsxRtz/5Ntc7QSnAClpaCWuNiOMB8r
	 FGTCKk/icUIgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3787409A1;
	Tue, 21 Jul 2026 18:09:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9456E313
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8633840167
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:27:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CkC_gRx33oFW for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:27:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4071E40275
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4071E40275
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4071E40275
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:27:55 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDjYUO986954; Tue, 21 Jul 2026 10:30:48 -0500
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fj7pvsjtr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 10:30:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liDBOLxWIHuAtg7qzl3Al1BQxS1PgYUbWS/Z24S0KI1DXaBRAwZXst+9/4CdzqoMVrUKRprZINUyBa6drSWEvIl4P0OJyV8csHuA0Yr2AEiDyacOBBVE5VaDftdw1IQNYWg64yoU2GRNoPp294TtD1nLFcnG81uRIl68kS8JJV9uzaqmnTKisFTm/K/BEon6iUKgRyE+QoVt0PrkgFRkLWPoZK8bjpor6f3P9qVPtdii1HlGIi7kOlErXqkh5BrUYAfTe95uRCQkiPHPTPqLsDJyNial3yIV0kcGfZkNTW9Z7mkdM30i1hy8FAJkukWuJlC5NsOReK6SfLyRm7hKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyUtIl6GZbGwB13NgPXVlwPNZTix9TpZpsO9QoXpBHw=;
 b=V92BPF8W6H1gqcqTSIvim5uBBhU7dcz5h2J2WkgDGbc20aUTVFBR6Fe3YFGYQlhSMi1YiMplZsuUuF3DtS/d3JalXF2HdANLvaCf83Nt0A/KLHkYsmeQMzYZl+J67Cz3aRA1TRGBabOPzcOEm8QdMEa/EmEbDU/LQhcdfQ6pVbE2FY7wmPWuu+56zY6zf8STW0ARK5W7IY0n0FsEuAHpL/1nHaNzK73RMitQ9511R8b6sAjkbPyBDtD/VxCEmGUhiXWLKZjty1WdUK/3UpuryVW3ol18A1Q/FjgsaYyXJkCYXEewMnkhrc1kYY2XEs2V18wiedtUaLeOLCHLnKYsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from MW4PR03CA0206.namprd03.prod.outlook.com (2603:10b6:303:b8::31)
 by DS0PR10MB997625.namprd10.prod.outlook.com (2603:10b6:8:312::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:30:45 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:b8:cafe::42) by MW4PR03CA0206.outlook.office365.com
 (2603:10b6:303:b8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 15:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:30:45 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 10:30:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LFUM6Z1031805;
 Tue, 21 Jul 2026 10:30:22 -0500
Subject: [PATCH v2 00/11] arm: mach-k3: introduce basic support for the AM62L
Date: Tue, 21 Jul 2026 10:30:15 -0500
Message-ID: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIiQX2oC/zXMSwrCMBSF4a2UOzaSR02qI/chHaTxxl6wjSQlV
 Er2blpw+B8O3wYJI2GCW7NBxEyJwlxDnhpwo51fyOhZGySXreDywuyk5XtlpnMOtfKt8hrq+RP
 R03pAj772SGkJ8Xu4WezrTmhuhPkTWTDOhmunuFbK+qG7L3R2YYK+lPIDceoUV5kAAAA=
X-Change-ID: 20241025-am62lx-78cce63f43f6
To: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent
 (TI.com)" <kory.maincent@bootlin.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Daniel Golle <daniel@makrotopia.org>, "Rasmus
 Villemoes" <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS0PR10MB997625:EE_
X-MS-Office365-Filtering-Correlation-Id: 5417d3c9-8352-473a-3edd-08dee73d0889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|7416014|376014|36860700016|6133799003|56012099006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: 96g8il6V4qJnVPPru12IwOrfgT185E03Po8p3CUevu2u4kcwBj3tAeUPvnzpGDvn6A8+Un/5V9Ebex7TTOo22oepjne/Eny0f2+zrCiubwKXZ7HMHs/OaRFJDAovm3U1G7YM2ziCSx3O8R9gYpJZJ74r11rDMDXsNR+pXfEWeKo/WDtkPrRqnrRUyo4ccPNW5O1OuRMc1fd9zczJazYmUhpaMR0gq3M44JHlZpm90icyV0swSFCZQocBx2c4DkXgLMkdXOWIjlDe0oJHZPlhOATgjqvZqVL41AtnDNyQpWzp/g2fLO+bOidpQbf5LbGVKlWxVYW2k8cdku0DzZKMtsxOCfjNikwGaTBxO/NwZk3volws3mbqQqfBs1h7I9ZGA1POtOyxhYJp3kTXFOxobGld/JqaQQixOeWlEYjUX5sHIK/JI+aBoRQoZH/MbwBwmJuScrwEYwW6Ecn9XSJzyJXUwSo2oCErsk9tAs74+hIgSvPKoTPD6ZT8B794+jnOxkO9HPV6cU5KSGaHeTmdOTNcRlgiRe7X+VbLk1T6a9vg4Camwr6jt9dL95BDXTjxp+mwQ3gillFM2LkSobznd9Fzmuz1u5e/efqw1zYPPUbqZa0QmHFq8Vd5XD2LfuZskEEeJ0ydXfzJD+KID+rTZQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(7416014)(376014)(36860700016)(6133799003)(56012099006)(10067099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WyoRoNvHMUp2o/N5sUCIhHx/+W3YY5KR8HSXbxpZtkrGu9XoQMgc/DJp5vieIxQ6XtCx1L0NLlxMeiP6whQkwr/Xmv750noM0U0GYTvzwJE4sOby335RYblX3n+bIX/XC01kOxSYB/siEjsxA+fiE7pJ3xTeAYdFgy4KKLmkDP7FDqbpHdLOUTru9pvn4byZEdPXVVtQg6YfK153nzZp5PDiseqUxkVxXKkKjXlZPBBjHM/pVvSVheOji+AeHa6/I38U7pJNaG93fI10ivn6iNe+aANKqdEAVOzPYMKjhIBERDSR800yIeuWabrNr8l3n5fCmvnd8bbVsldtYqAo3NYHdBNFkhUX5x/iPfnSF5x+/8ToPX0qHUiDpBz43wRrKXmjqqU5ZFraaowATL7Q8NnDn2U0v1DvZ2g8KKuFnVxBJpxrjfdRr696/CUMdGQs
X-Exchange-RoutingPolicyChecked: C2d3kQphUhA14NieZMSQXJLjiuIttTc/PT3Du3W6wiJmu1PfgImyJBpqjCdF6Ns60Rh4SfOd2Qn6hn09/j+N+zDrvm0KhRr5iWvv3YNtd4rcqL4dGAcw3zHwEwfiDCPXRyjOZpCbeF+q7Ohl/vIh7CwkEuXGZORmH2L3lAdTotYeSPqtQLLVEj7+2YbCgBM5BNQ2gXz3Hlb9KZ7XYW4Ii6zIJSOJ/mF8RvJRdzvwE8lCbFVDjV0V4QPfSExRnbMY3QUOXGUmThTthXkrQcsnTjTD7iprLoH2DRGrD4BKFEIDGf4QHAAzxE/9Rxv2PyVxVJdYhx7tRAO1Cw1vhPIqpg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:30:45.4079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5417d3c9-8352-473a-3edd-08dee73d0889
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997625
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX+Bnow9008Ys+
 TTxO7wZS2t33GWEG6HKP8lPFziIZ7fpcdtepnro8/9b9QYiY+m+VCNoUOycidJroOdx7Kr+Zozo
 6VBksHtbhrnJsHmsSsbS78bxMN4CLXs=
X-Proofpoint-ORIG-GUID: EfhL5lgWU9CsUp1SGY0O_-Ec819ETSWC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX1jSw8wlr+tKN
 C35BufSWiz8HR5CJq/S5iZ7gFUXQKScqtBOGZLts5yRzq00+1W1+8dRO1iMStJjeaPUt4tc/Iaa
 M/z9HPDTpbjjTrc2sIl+Uhx4vNYFHnzYeBox9Spqco2trPvuEOMiPyx/SsbFbwc92EslIMAUtA5
 f5nPveBn6Bq0jygldF7tK9+5/4wlE1sAIaiF9nMV0HlOfHKr5pzkCNe1AhOymPjoPudhBsbhZpl
 rpzcXk4sMZXeGeXKv9rWPf4HXdVD33AoWX+kg+3O2VkZSaSnZhzyovaelIE86z9HRaaBo9phYbQ
 Y3Lp211GUAjIMUCCAwAizt9TLSqUqeK+ap7hnD9TL42Rz/lHzNTnh/kfy82Q+eJh5zA0gMUcjJX
 JMeciiZ8e60sWfa0fQybAyf5eSR8z4uzZxQ2Wbk2htc6nIX8AH3gI0H/drOs6uOCE6B4uSU5m60
 zrV5teA96Z5gLtNJNzQ==
X-Proofpoint-GUID: EfhL5lgWU9CsUp1SGY0O_-Ec819ETSWC
X-Authority-Analysis: v=2.4 cv=MbFcfZ/f c=1 sm=1 tr=0 ts=6a5f90a7 cx=c_pps
 a=3IxC/HLiWPPRhiYFHlIRMw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=k-42gJp3AAAA:8 a=KKAkSRfTAAAA:8
 a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8 a=DfNHnWVPAAAA:8 a=VT4XjZGOAAAA:8
 a=1VxDqnHFAAAA:8 a=DCGn2twoWKPKmm6NEM4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22 a=uCSXFHLys93vLW5PjgO_:22 a=cvBusfyB2V15izCimMoJ:22
 a=rjTVMONInIDnV1a_A2c_:22 a=6CpsfURP9XNmmWg3j1mJ:22 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210164
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=GyUtIl6GZbGwB
 13NgPXVlwPNZTix9TpZpsO9QoXpBHw=; b=i102CwzHWhqvKgpCihlykamkzONXe
 slnAVN4qH39/KLQYAoZ2LA1y9z8LIxIUKLyPC7JXBXBEN/Pj6rkO0cBmtJKGToZL
 nQRzq2vFEauS6ILJk3A77GUB6qZZGW2JlNJF0zr1fU4exsBwMSbOleMMPi10mVHV
 cQWQiSRTlB9oREfarHii5Ev0Jq7huEz3BXt7ZZv5ngD84VK8PsyLEl5mcqL+TSLg
 ldVxa3czTvfyArIAn8nNjC/TU13dwAOHGjA1bmsRSZFlHkV2I7yRYp9gDgyYC12X
 JpN9KveN1UZhxeIIGUCiovNi+4UixuN4ObGMZ2j2oBZm57OhYnxZhTfUw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyUtIl6GZbGwB13NgPXVlwPNZTix9TpZpsO9QoXpBHw=;
 b=XIzWLBZxzkp2sGyEMUXazP3Lk1SHmYZpJ35cjiOqRn/hrJ1vHbR6fXizi3mYnaMa3emt+5b6onHm1G8Zn9pa7LPYijhlfkEOsZeGp1hAYC4VbLk9nvqGbUaoE/vUPJfWlFxgU62czp00YkFkanx08fzrDGlGacKO4s/SOc7DZt8=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=i102CwzH; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=XIzWLBZx
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
From: Bryan Brattlof via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Bryan Brattlof <bb@ti.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hello Everyone,

This series adds the initial support TI's AM62L SoC family along with 
the AM62L-EVM reference board.

The AM62L is a lite, low power and performance optimized family of
application processors that are built for Linux application development.
AM62L is well suited for a wide range of general-purpose applications
with scalable ARM Cortex-A53 core performance and embedded features such
as: Multimedia DSI/DPI support, integrated ADC on chip, advanced lower
power management modes, and extensive security options for IP protection
with the built-in security features.

Additionally, the AM62Lx devices includes an extensive set of
peripherals that make it a well-suited for a broad range of industrial
applications while offering intelligent features and optimized power
architecture as well. In addition, the extensive set of peripherals
included in AM62Lx enables system-level connectivity, such as: USB,
MMC/SD, OSPI, CAN-FD and an ADC.

AM62L is a general purpose processor, however some of the applications
well suited for it include: Human Machine Interfaces (HMI), Medical
patient monitoring , Building automation, Smart secure gateways, Smart
Thermostats, EV charging stations, Smart Metering, Solar energy and
more.

Some highlights of AM62L SoC are:

- Single to Dual 64-bit Arm® Cortex®-A53 microprocessor subsystem up to
  1.25GHz Integrated Giga-bit Ethernet switch supporting up to a total
  of two external

- 16-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.

- Display support: 1x display support over MIPI DSI (4 lanes DPHY) or
  DPI (24-bit RGB LVCMOS)

- Multiple low power modes support, ex: Deep sleep and Standby

- Support for secure boot, Trusted Execution Environment (TEE) &
  Cryptographic Acceleration

For more information check out our Technical Reference Manual (TRM)
which is located here:

    https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf

Happy Hacking
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v2:
- Coalesced boot parameter table Kconfig address
- Removed signed u-boot fit image to align with older K3 devices
- Removed &smci{} bootph override in the u-boot.dtsi overlay
- Link to v1: https://lore.kernel.org/r/20260717-am62lx-v1-0-b9830633afb8@ti.com

Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Bryan Brattlof <bb@ti.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Paresh Bhagat <p-bhagat@ti.com>
Cc: Andrew Davis <afd@ti.com>
Cc: Swamil Jain <s-jain1@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Shiva Tripathi <s-tripathi1@ti.com>
Cc: Apurva Nandan <a-nandan@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Hrushikesh Salunke <h-salunke@ti.com>
To: u-boot@lists.u-boot-project.org

---
Anshul Dalal (1):
      firmware: scmi: switch to dev_ofnode during bind

Bryan Brattlof (9):
      tools: binman: extend ti_secure_rom to handle op-tee
      soc: add data to identify the am62lx
      boot/Kconfig: disable fit post processing for AM62L
      arm: mach-k3: Add initial am62lx SoC support
      board: ti: am62lx: add initial board files
      configs: am62lx_evm: add initial defconfig
      doc: ti: k3: fix pygments warning parsing device-tree
      doc: board: ti: correct path to tcl scripts
      doc: board: ti: am62lx_evm: add initial docs for the AM62L-EVM

Vignesh Raghavendra (1):
      arm: dts: k3-am62lx: Add binman support

 arch/arm/dts/k3-am62l3-evm-binman.dtsi          | 218 ++++++++++
 arch/arm/dts/k3-am62l3-evm-u-boot.dtsi          |  12 +
 arch/arm/mach-k3/Kconfig                        |  37 +-
 arch/arm/mach-k3/Makefile                       |   2 +
 arch/arm/mach-k3/am62lx/Kconfig                 |  23 ++
 arch/arm/mach-k3/am62lx/Makefile                |   7 +
 arch/arm/mach-k3/am62lx/am62l3_fdt.c            |  12 +
 arch/arm/mach-k3/am62lx/am62l3_init.c           |  58 +++
 arch/arm/mach-k3/am62lx/boot.c                  |  82 ++++
 arch/arm/mach-k3/am62lx/schema.yaml             | 427 +++++++++++++++++++
 arch/arm/mach-k3/include/mach/am62l_hardware.h  |  48 +++
 arch/arm/mach-k3/include/mach/am62l_spl.h       |  41 ++
 arch/arm/mach-k3/include/mach/hardware.h        |   6 +
 arch/arm/mach-k3/include/mach/spl.h             |   4 +
 board/ti/am62lx/Kconfig                         |  19 +
 board/ti/am62lx/MAINTAINERS                     |   8 +
 board/ti/am62lx/Makefile                        |   7 +
 board/ti/am62lx/am62lx.env                      |   8 +
 board/ti/am62lx/board-cfg.yaml                  |  32 ++
 board/ti/am62lx/evm.c                           |  19 +
 board/ti/am62lx/sec-cfg.yaml                    | 380 +++++++++++++++++
 boot/Kconfig                                    |   2 +-
 configs/am62lx_evm_defconfig                    | 139 +++++++
 doc/board/ti/am6254atl_sk.rst                   |  10 +-
 doc/board/ti/am62ax_sk.rst                      |  10 +-
 doc/board/ti/am62dx_evm.rst                     |  17 +-
 doc/board/ti/am62lx_evm.rst                     | 222 ++++++++++
 doc/board/ti/am62px_sk.rst                      |  12 +-
 doc/board/ti/am62x_sk.rst                       |   9 +-
 doc/board/ti/am64x_evm.rst                      |  17 +
 doc/board/ti/am65x_evm.rst                      |  10 +-
 doc/board/ti/img/am62lx_boot_diagram_phase1.svg | 450 ++++++++++++++++++++
 doc/board/ti/img/am62lx_boot_diagram_phase2.svg | 525 ++++++++++++++++++++++++
 doc/board/ti/img/am62lx_tiboot3.bin.svg         | 170 ++++++++
 doc/board/ti/img/am62lx_tispl.bin.svg           | 222 ++++++++++
 doc/board/ti/img/am62lx_u-boot.img.svg          | 143 +++++++
 doc/board/ti/j7200_evm.rst                      |  10 +-
 doc/board/ti/j721e_evm.rst                      |  10 +-
 doc/board/ti/j722s_evm.rst                      |  12 +-
 doc/board/ti/j784s4_evm.rst                     |  10 +-
 doc/board/ti/k3.rst                             |  39 +-
 drivers/firmware/scmi/scmi_agent-uclass.c       |   2 +-
 drivers/soc/soc_ti_k3.c                         |  11 +
 include/configs/am62l3_evm.h                    |  14 +
 tools/binman/btool/openssl.py                   |  11 +-
 tools/binman/etype/ti_secure_rom.py             |  32 +-
 tools/binman/etype/x509_cert.py                 |   4 +
 47 files changed, 3440 insertions(+), 123 deletions(-)
---
base-commit: 5a83cae32d9a1f29209d4f171a8de18bf82fd630
change-id: 20241025-am62lx-78cce63f43f6

Best regards,
--  
Bryan Brattlof <bb@ti.com>

