Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEAAC4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 19:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C60F80A80;
	Tue, 21 Jul 2026 19:29:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SygTQEbGTFkS; Tue, 21 Jul 2026 19:29:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F9E480733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784662175;
	bh=vkTcMRb1TKeZbtIDvHlTYYgt/NEqf16s0cwaJ3PmDSI=;
	h=Date:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=eDE4ii9rE2Jury5GrxKaKE7ooNuraRBAhGjyHif6kcnf07XkoEhFMR6Ct9mT4Ytui
	 tAk9AarGhjZp4TYi15vvUhTdF2SKyocsAOI24sy9DgMRLo76u+oFCgTgX6scwJecx9
	 4JvDYcASugvBvWQDjgdSZyM02QSGKGbvOelyXcyQrgue7rYzmZgfAfHHQB1x8kkHEu
	 umSVbRQAxf4zrSO+SfOI1gImFK3lUGhnVTJZdKbToFV8OnejPElKbry28eTfgkkLVE
	 LdCcE+OkC3pnOp3Fm9H/f/Y47KOFIMW+Rs5MUgXnzO95AAl3BdhYNuBm2nHZaTQ+C6
	 DTPd2JAlpiqaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F9E480733;
	Tue, 21 Jul 2026 19:29:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 98BD5EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:19:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 84A8B400B5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:19:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DgO5kNuB--AT for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 19:19:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6F97740015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F97740015
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F97740015
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:19:45 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH633S1403801; Tue, 21 Jul 2026 14:19:28 -0500
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fj7q932ga-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 14:19:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClShXIQyfh0tOVpv8RlSyTOUeBIuvRuaK7TatbRF1y2lQC9wUIGJVp8TUn4+dX26pL1x37NXWtKupBuNbl0Y747+Ll9BdiEG+BRFjzEJ3TV1uAk3ohSNcgAZt5tyNzZ9yTJQEHhQdxWOFF9+JhN667d1fh1gE23Jd0o7J/OS9zcHv2EG1qx3QZGsJkNRrghm4kQ7O/YE+Q0JwMHbZ45wimp53ugqN/YH5qHx/BNrSybrNswYGjWrDF6PiwQTrzIBAavUVc1BSeJbKkCiJVxdkhgLLIP8Rw/JWJ4C2RgbiaWe6w4LOg4QtuSWOKxLW2MKdFupIFAmaUa0JFwrFpp+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkTcMRb1TKeZbtIDvHlTYYgt/NEqf16s0cwaJ3PmDSI=;
 b=YFagPeJsyfH0VzW+HQFxpr9L2mJwAOPwSUqUuYDETYhZLzFs8iYQtpSuepHqNO8JVF2ExEw5OREmQw8ICrwQLDz9wdvZPiZzT5mb35iy2zOPubz7FJxBS1KOgZCT7Kw8ZW/4V4YCBr1DQjvcq4wkW5ByO3yue4YqMZsQambtvUnA19maP08TNa8SXLDY5Qb5UdcjLKS0dLqkbnWdJFs/883plfXQgd1P0RW3bsx7nOeQwmDRqe1FXYeXEqjRfq3NsAFIsTthsRoiDzh4ZLuouUPStr4EtBLr+KyTBVJcMZAMs0DIkSfukl0E2DNl72mcN0oHpMzJHo9TXjNaGt0fUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from SN7PR04CA0020.namprd04.prod.outlook.com (2603:10b6:806:f2::25)
 by IA3PR10MB8513.namprd10.prod.outlook.com (2603:10b6:208:576::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 21 Jul
 2026 19:19:24 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::39) by SN7PR04CA0020.outlook.office365.com
 (2603:10b6:806:f2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 19:19:22 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 14:19:05 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 14:19:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 14:19:05 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LJJ5pF1428443;
 Tue, 21 Jul 2026 14:19:05 -0500
Date: Tue, 21 Jul 2026 14:19:05 -0500
To: Andrew Davis <afd@ti.com>
CC: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Rasmus Villemoes
 <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>
Subject: Re: [PATCH v2 10/11] doc: board: ti: correct path to tcl scripts
Message-ID: <20260721191905.y7bqr26xdtjte4av@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
 <20260721-am62lx-v2-10-33ff580c267d@ti.com>
 <7f65e636-f2f6-4604-81d4-09e27ed6264e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <7f65e636-f2f6-4604-81d4-09e27ed6264e@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|IA3PR10MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ace4994-9274-4acb-106d-08dee75cf862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|56012099006|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: XQnIK87TAan/JGi/WPHJQeCnrquKVNKhZY3WqnXScO5KcguEXGA3bcw/A0YLhELIAgntvjuLLjIk1MTWQFrvNyaHahGU9usdI9qbp/zZQzjeBnkdYm2EF5BIyONPVwG4GWa4cLUQDOwtKeC0sZlB9ybLhGnsf9lxonDCHMX6ywAr1lt8ht8JmGdVEDqw2Plz1mFaYtcaK9N2PYct5C6HWDJJZ2FlmMKBwtgXajWcKT16erK86crcPHOTLmEWp5WdFDJmjBKzjXbYwyFCBMSdbl94Ik5RyUMFLpj9TRidEF4c2RsqK6kdb2Bxu5Nna78Tl2XUIBpDNQw1i3RCNJU/Hr/JR/LPKTwibXhahxHVQ1zk8QR0vq8KbVIMLnFn/gCRyWvs/TYDxB6nx/vcKctU8x1f6IcP7/gUQBOKPgmmvzd9nCbQ1By9NGTIpxPvmIlHEhgKKN9y3eS90XLGvprA+qvzLj/icb9FQ8j4V3MSopt4ezadIUnvo48raScOP2O2lz+sber+VXf6WELJ4eBgUIs9U6ZCGzGXKP/Ac26dzFZOw8dC6ZjoCITeZ+ijB9JssbwXbA/FJFMsSZ64Wa4vZ5Lq0lAdB6JMmdqcjlkvST980LPg2gCth0wwFBDYt5RBR6PqkLKmbxcMn28GxTPa11rcg1fybupNddthIW0dKhVY/bT/ibKzMpiOtDBxg4w8JGmdAGKpaKSkm30lDpNBWA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(56012099006)(4143699003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0uqJ8hWjAhwN5MJzvF+g3Jda6WuVcq1cHM8/G1apxujmC0Z89xkbtwww+66KjjAmQWp1oAyELFthRCQbAotlAv5swJhe6pRP3PaJ2hP9VsFm2Z6FdMWKw5O+nt6Nxt31Q2Vb9MnsS/aOa+Lq6ljLMMYVoOBsXHxyEnDBCglgJ4ceg48SSWWsi+CCtoJIZTMnKMNvl7HmeLse8Xlsp6/zbvuFDlvNOYrn5nJRWhut1RD1WGyU1YbRq7z+egM8hL4DqDhdxC3+dEkSsVIoYQURVV7uQgma6j9KKvyyxyralkw9HXYaubpMKBmuJHc9QaaUl96/m/JhtnPzWtb+198x63JV6xpjZiqK1geyFpP9UJXRSoqgD3u0o3qM09Mgx2nf6cQf+0a+ef3P9zUFtt8lOMaLcCsbd77FCsU7cqHuDRJv5QyFMSBJsohxN88XDWPL
X-Exchange-RoutingPolicyChecked: S1R4AP630YbeNdXsFkm0Tzpv3+brVoo31h3ZgmVESS27DaRz1oO12Yo2M1qs+yXy+Xe4c5l5gWXStwD6RMOZH/UMlDh2zFdE7IKwhm6E78BWI97Hud2vccf2+dXC2DXgCwdudYsRPJq9TarNRmk4Pu++NylbwKPQqMLmBLx3ZYDYfMwYh5gpAIOQfxRdQYOIReBlwm9Mi9KAcJ6+cmTALbWaVvlxSeLs+s555u5TsRbVu7JdARWDgp9VbJ8A6kbkUESPKYoae4/a9xNPZkOi5AH5Hwnr3BlBgBHR0tyEu9WHj43NCrOVtDABDMLNLd+TGaLrMFxd7Y6sN/8aHe9I8Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:19:22.2570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ace4994-9274-4acb-106d-08dee75cf862
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8513
X-Proofpoint-GUID: 8zx74dC5ompNmhCLUh3BZ9APo_ORaHLF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwMyBTYWx0ZWRfX594/08dkclFD
 8ur7bYtnDbao2GaHzZjuy4FMdBs1od/TQ+w3snIAXT0lnWmeJdkQ2NbHUsYLJeT7yOm1LFwzHnu
 cBn4HFkP/WOxBM0wKC3G5pjXUV8O77A=
X-Authority-Analysis: v=2.4 cv=CsmPtH4D c=1 sm=1 tr=0 ts=6a5fc640 cx=c_pps
 a=3vo4EN8bzuoLd/SmvO3peg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=TsfQrOGM1rGIJi8AYK0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8zx74dC5ompNmhCLUh3BZ9APo_ORaHLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwMyBTYWx0ZWRfX2fYbhPFD2dzL
 PMmjI1v4dHuy7o+VV0FDEnEY89/V3XkOSU2PgCwVC02/cKUvlGYmm0BBm1BH10HhMkSAELzN2uj
 348Y6cVfefH1Hvo9DdlSxPqr++Ystwfp5VO9T9bW9aOn/EfJ/Zz5JFyVRrYM/M6xNhEmzZQwyT4
 N3H2Nzh6rFArJAJFisk+bclVJ/31HZzNszt3AtDU38NZU2iWUTy1C/yjSf0ileXFuvkxU5XKjkc
 dLNNIADcWsqdCvhAeBpWv2je9g6Tp60Clxvl+GIxVYVv/1yUo6/205Sgvdl03DV+MN7Yteb65rR
 zexbS8k7KIYus8k0oHo/SKWgoHXnkFSHg6OZB1kUE9cw7PnveNGru3tuTmAvpPIvYVWdE+Qk7/r
 zHT60EEtqfuQpVdlAGcYor6emUO8fekjBlKwDkSFiOozjVu1YgFQ9OHMzI9EmEpGqUyDq6KZRHc
 AHj4Ta3jJN43n6YTX+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210203
X-Mailman-Approved-At: Tue, 21 Jul 2026 19:29:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=vkTcMRb1TKeZbtI
 DvHlTYYgt/NEqf16s0cwaJ3PmDSI=; b=maerbFq9aZM5IArygqO01CC3El02Xsr
 B43RUcQy1KbgUtKDFWgYm1Vwn6hLNLG4avsVWS0rtMh5CaaF2aXvBGv0IcgW22Lw
 Lod/2/vE7SpjiyK5p1uY5h368kennepu07hgh3R2npmyE5ybc9nFKvz8Mg3HHeMb
 pkJF+iU3tzog1GCTGegUx3Y0uRWAWta4uXKZLr9rRaJKXiiGwTCOLdczXXnNmI9u
 a9xszhnKJpJbDd/qB1+/IeQ2s1snCUvtj+7vXlosuQLvIeJvuDVRbxi8z5bjxLSq
 6bkg4A05BKrpquBbF7fjAcq4k3VEBIfFpXI5Co5ZgYyAvsQp2tTl9zw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkTcMRb1TKeZbtIDvHlTYYgt/NEqf16s0cwaJ3PmDSI=;
 b=Qg2+Yloo2NH6Lj8h0hztemkg7s+5128b6NudgXw+1zSo1XtkXdT800czVqqbPMeu+X7OzTL/LBl/qV/rBNJ7BD5HzSdbwgaIJUcgDqHFwEXAXy8SJQpSI6VJuXKuLeZgd+jSfmzITtVSb4i4CgEynIyVXN0WWHrFl9i5Gc9T2MA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=maerbFq9; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Qg2+Yloo
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

On July 21, 2026 thus sayeth Andrew Davis:
> On 7/21/26 10:30 AM, Bryan Brattlof wrote:
> > OpenOCD has moved where it has placed the tcl scripts for TI's reference
> > boards. Update their paths to the new locations
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >   doc/board/ti/am6254atl_sk.rst | 10 +---------
> >   doc/board/ti/am62ax_sk.rst    | 10 +---------
> >   doc/board/ti/am62dx_evm.rst   | 17 ++++++-----------
> >   doc/board/ti/am62px_sk.rst    | 12 +-----------
> >   doc/board/ti/am62x_sk.rst     |  9 +--------
> >   doc/board/ti/am64x_evm.rst    | 17 +++++++++++++++++
> >   doc/board/ti/am65x_evm.rst    | 10 +---------
> >   doc/board/ti/j7200_evm.rst    | 10 +---------
> >   doc/board/ti/j721e_evm.rst    | 10 +---------
> >   doc/board/ti/j722s_evm.rst    | 12 +-----------
> >   doc/board/ti/j784s4_evm.rst   | 10 +---------
> >   11 files changed, 32 insertions(+), 95 deletions(-)
> > 
> > diff --git a/doc/board/ti/am6254atl_sk.rst b/doc/board/ti/am6254atl_sk.rst
> > index 18a3520b39c7..7f919b10a8d7 100644
> > --- a/doc/board/ti/am6254atl_sk.rst
> > +++ b/doc/board/ti/am6254atl_sk.rst
> > @@ -289,14 +289,6 @@ Debugging U-Boot
> >   See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
> >   detailed setup information.
> > -.. warning::
> > -
> > -  **OpenOCD support since**: v0.12.0
> 
> This info might still be useful for folks on older distros still shipping
> an older OpenOCD (e.g. Ubuntu 22.04 is still on OpenOCD 0.11.0). Probably
> doesn't need to be a "warning" though at this point, maybe just a "note".
> 

Okay I can leave it in. I really wish OpenOCD would tag a release more 
often. 0.12.0 was tagged in 2023 :/

~Bryan
