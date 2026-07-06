Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29A3C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 05:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E949807C4;
	Mon,  6 Jul 2026 07:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gQ/vyq3J";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pEugz+co";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3A584105; Mon,  6 Jul 2026 07:37:25 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD0F80398
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 07:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6664bw3O3181049;
 Mon, 6 Jul 2026 00:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=MSvGsi5NGKRiUrB8jk++kQ/eI7yR75dL5XfsZZ4Ju
 nc=; b=gQ/vyq3JPjTSBH5ZbGzGVE65dVo2qi3ula4PWlgcKBVVC8+rHdRNTqdU3
 EpaOk0oTWgxqujyEskRauKmVwou9J+AsgM6zFMTJU56pa9SNMeKrUj9/FfYrVkHK
 Wx6zKRbUEjVzFiHPXlqiXJmTpRJCWgEwRSQacRnrAVwq8MHzz5XEHObbGQoTARdP
 7qyO3qudjrp0MzuQH+ggeNbz4hXxceRvZnew3+3Ro988Eq7FuBdoWxoD98egqIy0
 qEWriBZo0FNwE+o14V9pF1SKDd2ix+2buIFK/e6iO4cIIlwd6yOUYJTr/qJl6vuO
 B472JDJsB1hlz9vWKG4vKAz6/X2Iw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011055.outbound.protection.outlook.com
 [40.93.194.55])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f7p70kmjn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 00:37:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmD81VXV0+QiWTjgcsHGU+FVoLNQRzwQeFlgKwq/5tAuKinbvUhEmAm5B6xkkQY6XxC3ankYYGPRczosdkVOZEjjv/imQmCeFATNsBM4zPFm/0wGqnwA4aDpV3yV69nbImLWxvBAoZ9RujnVAfdW/HqcEfAZnqRPtRRv5T7iX1T5k467rIe4oysDlygDISsWxr88D4U6mgWIwpMSvEOYw6PCXmF49LW+d+0/0IDwwZpFK/T8MeGuEF0k5Pt7hAddrb+tbHVKEK+RdP8dgiYc6utuGMnJW8wYNZONj3ggYRrsx46C6prm+cBlwX37zXGtgZQRU0wQbiS2xc0EDrBIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSvGsi5NGKRiUrB8jk++kQ/eI7yR75dL5XfsZZ4Junc=;
 b=WiaDWFec3KVbXr38RLzVo7JDrzjGWyvUIvXKssfudXPQMZNHfLZwyOSHA0DFtzXEauLIe4GLaUOIf1hBvRHdj2dWqppL19rzsCJhbIblsdtdWRoHJL0Qo1WyOTauD65MjD/ncUYKbZNaSk8zFsM9tkp7MHqSC8A3I+HOeZk5hpZVeeXYE2iQmj3ZCAr9M7tSH8brR1Nk/uICNZtXWOVj0Fik9grzp8Dcd3fYD9b31siU9JivXY0gEpD5lQP5X2/KtGC1zt08VwC2Jaar4n/0p6cSqFjFhgHwAy20APhpVGThI9rarJxGar+5dcwXEq+shcWUXxe0RXubC9yYmBLZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSvGsi5NGKRiUrB8jk++kQ/eI7yR75dL5XfsZZ4Junc=;
 b=pEugz+cooUnjNV0l6XqZpwAYwAlgtfhlhl4rj9GHGQfubSQ1DvI5cQ9SsaWMtXTrwr0+UdJPmjZR1s/KbTVs93IBduW64Qk9+uod5UueVlteoqZSpmkz2x/Ys67cRw5BWAJt0tt9Tmu7QJwl0Q75jQu7i8WX8hdOWFzdl0A5ckU=
Received: from BL1P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::18)
 by PH0PR10MB7063.namprd10.prod.outlook.com (2603:10b6:510:289::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 05:37:06 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::58) by BL1P221CA0034.outlook.office365.com
 (2603:10b6:208:5b5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 05:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 05:37:06 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 6 Jul
 2026 00:36:48 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 6 Jul
 2026 00:36:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 6 Jul 2026 00:36:47 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6665ajMY1112653;
 Mon, 6 Jul 2026 00:36:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] ti_pwm: Add EHRPWM TBCLK clock driver
From: Neha Malcom Francis <n-francis@ti.com>
To: <theodore.oviguian@etu.esisar.grenoble-inp.fr>
CC: <u-boot@lists.denx.de>, Theodore Oviguian <theodore.oviguian@se.com>, "Tom
 Rini" <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
In-Reply-To: <20260619083217.12930-2-theodore.oviguian@etu.esisar.grenoble-inp.fr>
References: <20260619083217.12930-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
 <20260619083217.12930-2-theodore.oviguian@etu.esisar.grenoble-inp.fr>
Date: Mon, 6 Jul 2026 11:06:43 +0530
Message-ID: <178331620339.418905.7885345181354786311.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783316205; l=860;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=ULcxbPs7/Ll6QldcQMWfljbGO2uw6p5mxgIa13zCf1s=;
 b=xckC+L/+FT2+p+BTTpNIDDTjOE8Vi7E3elX0ngbbvAek4Fcj3eARLXxIGOnEeowk0frHtgqtR
 +hEzyxbtVu6BUU9nFcfAGCkbRuoNd4RVa82f1y/D38QR6LmhniZCneQ
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH0PR10MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3fcb99-dd31-4696-b200-08dedb209dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|13003099007|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JD0+TEWL3LEkSe0KDmvAbgz6L+FXWgMOkipZj4IEY6DyPi/c8dA9Gp12sYzPqEw46pS9KTd8PWgHU1jdKN6fdqfpK5NPrDNbPPAMJKSQhSf6SV6FXvoLUWCX77Hf4N5NuubYz4I9C/uo/BPhgFrQGZavDY80pyNg8AQAi7wFXwP38RafQQX9AGOED4lCv/d4p2xfY6k71uxu1Qvis3PDZmixaa3LTO1ui/DONONWi4WcAy2wrkmEcHv49GLRGcz0UD71hI2NYM+jak5l+eF3d0wobXYa/R+7hXKbs8i2M3tCF1gOkQROdhadYLr2r0yhTKKXU3dkgTpe7yHzL0MPSz/5eL35xFjLLwsmeDEWHlVZmuURpybENUZGFLYl5L8Qv3B9+GhwSitnB5SsNCDmwFp3HgL4jpaTzS1CDtDERCfKpVEEjJ2yrPg/pG2dv9NorzV+mJ0ntarVsAr/hRlqKEUegW11Q9tF8Ny4wHNo9X9cf2/bG8MCozV+oM8wkn33DzK5QDBzKqYka9MxPSRWOPLMAvWhTD4XRq3OxT/1ezmk1TIgZ7+DDVRQhs1L6mgS2EXAvXCVcF7J+jICSG9x9PwSTtdBUlyrkKbnT0tuxqV2oVD8lz8MQ3+4XtghwbP9Kz3rfnp+6Gk+mGfg/xyh+g==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(13003099007)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5lPmR7JIxkEhzu50FG6AApNG3nCXj3YCvggJ0Z1DYsWMsRGYhf6Q4dLRRefJ1faGSihvbvTgAO4hAuaj7BPDkI3UE9eZo6dkbC/KcJrfXHbxdXBjdMEBZYiC/FSxldbrZ6dZaVBch1xbb9e0BdYwee0zAAuM1PVBknBuF7pqjxmme4QGanmQ6y/FNqrEJzdJ7Zv+YgTGGoNBdkA03xRMHtDuHkHhJeo/4pCea1mp3m5YV5fqBZAFLtnZgvTtIGLeLF60b05RD9YKjpGKJN8m0jpqvmp2B0Cu5uWiZmglEXodMIixUT8OsnZ6SX0KeHL+FoxqX51p0P6Wohw+NcF6KrH73v/W2EjPgXLRU0dMBAVQ6kBvO5GXJXvqN90mYOjgtb8A6RgGgB4cViGUcEmvoz1Br8Jl3F0f8UQpWBdFf4jphZn1cyFEHcv0WwWaZc5P
X-Exchange-RoutingPolicyChecked: itCX0QipS8koMlLceAYDXIhQZAndnGoWwWY+2YXPOuygdtB2d8oWbQax1xgZelZvXgc7isbM2j08B5Idiu0Reyv5s2nURGKQcKnRnceyA99PEQjyasu/8Nz3wSwNDc9f+INofB0a2nM2V6MnPbCRWuuqx+OG3DozoezxZo+/FQ2UMSygo+KtPjNm+8i8T5ZrDsB/dDzo2xPU3xJXCdFGy5c3r6qYa52fs3mi7/WPNfHSNBMZv/YCGl0NFy1vfod/VouGKT9VigJmNQtqZa6I68EH4XDfu4w1vbj/paJye40vqye2phaD1BPF1NA8A1SXUPowWedb+auS37g+ONYtVA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 05:37:06.4310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3fcb99-dd31-4696-b200-08dedb209dc4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7063
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA1MyBTYWx0ZWRfX5efzt8GN2rz/
 BVHPqMFV49yzfaS9P4MT7E0Hr3NaUs6rMRV+X8VZETUG8vLRPIS9mcRPvibos0hSfgt5dXMx+YM
 s2eBcZ2ALnDSpChVELzpJ39n23np0RNdVEysY1s7zoSERfvD5mtoAtjoCM5FnzlF0SUh/TDKlXh
 RseQzcnk9XD57AGjf+j/BthPiCc0MrzRO4gH/NOpI4tTHQx15dmeYntrVlYx0MWWzzVHz/GxTtX
 QabclGFX5dINNOMhEfKNPc1FMsawrcqjU/FwGpZuBKINo+Jlf7UOXsCjnqrrS6qYOXAYGGEsn8b
 AyFC0LIRSMbij60XS3HmzIttNcHhK7XUdsIqMCbJVW94Hjg1G9tCmo/94XAqTxFVbUxwT/9rov3
 5STtmN6GH9vlaaioyIqdaQIrlOdtS1aBT1HKx89Tyr2KDVTAKX1pbLeLsnhSZNEkrMfIvCvW/mi
 zdpIoY9PaWpABxUE0KA==
X-Proofpoint-GUID: TuX8h9Ket5p7NC5bnn7AblCou_ptEd2t
X-Authority-Analysis: v=2.4 cv=Ksh9H2WN c=1 sm=1 tr=0 ts=6a4b3f05 cx=c_pps
 a=Ba9BPv0Mt2atAB5a3SkMeQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=UaCSvCwVAAAA:8
 a=sozttTNsAAAA:8 a=9mQ3WEWsulISCHhgxAkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=G716TjlRC271eIfUcke4:22
X-Proofpoint-ORIG-GUID: TuX8h9Ket5p7NC5bnn7AblCou_ptEd2t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA1MyBTYWx0ZWRfX5/BpuA+Xi39e
 ayOm8hfLWpBcQ7G9RYwaIr4XJa8pbnobKaquPewaPWEZLPH4c8ys0VDvL2ut00Dan6X65MFzFAU
 4Ski9aEAc95gOwfpkABUe0F33qEjBzE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060053
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

On Fri, 19 Jun 2026 08:32:11 +0000, theodore.oviguian@etu.esisar.grenoble-inp.fr <theodore.oviguian@etu.esisar.grenoble-inp.fr> wrote:
> diff --git a/drivers/clk/ti/ehrpwm-tbclk.c b/drivers/clk/ti/ehrpwm-tbclk.c
> new file mode 100644
> index 00000000000..bc91ef65b2e
> --- /dev/null
> +++ b/drivers/clk/ti/ehrpwm-tbclk.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *
> + * Copyright (C) 2026 Schneider Electric - https://se.com
> + *	Théodore Oviguian <theodore.oviguian@se.com>
> + */
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <asm/io.h>
> +#include <stdint.h>
> +
> +#define TBCLK_SET_REG_OFFSET 4
> +#define TBCLK_CLR_REG_OFFSET 8

These macros are not used anywhere, also these patches contain some checkpatch
errors, please run checkpatch.pl

-- 
Neha Malcom Francis <n-francis@ti.com>
