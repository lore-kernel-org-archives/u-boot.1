Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD25E83054
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 05:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E3083FA4;
	Tue,  3 Feb 2026 06:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RTiYccCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB00D83FAF; Tue,  3 Feb 2026 06:40:38 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEDE283F9A
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 06:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zpd4HNhdLBRF4PQfjaBTlqVwCossP0t9yNPdzpcubjpF+9ta2/titAVNJDXiCrpe/bqAU/8EOgXuyd/2JCFRneH0TzVhRZjhm6GDr9dha5nu5U/LuCJ+khzfPhj0dGwsgZUv/r2GGaLMrKkFCvbCpugCXsd+9sxfwW/3N2b6vtChc2ylFG2rCRG17Q8XAODjafMm91+U8jQT4iubU2v/zavZ7T0aT1TpuRQVdN6Xvg8dq1phA0xgTRAdCvwTM5wvNGFMS9jkPLe4AhAQ7RWW4w3Ict+sFdeyN3mrQYdUm2mA62d+0idq2b5P6lhYLbr6KTIgzUwrpngqRX/8D5p5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn9ezfWBX9P7oi1b3Ya4ldHjqc1Brlu5+GVVHGfswZ0=;
 b=nxdrgNL2OfGCAmsqQGyLK8tvDnS/1nD60HMNW8+/nBlDZArcrA1oAcwnamCw0wjvtc8NBFtvgYzgil1FE5kklPPt9lhSpZzfsVjBk+awiaT2SM/kZAMuB4eYboSznUVG/heG1m9iqeu5OTxWrqKUZkV/arF5lqzoofnymMd1/2H2qrbo0L2/GBGsUDnVkby7SwphC2YiZU74sIt3r0DX7+1s9ZJy8G/FmqAdXkp/WIJfaaSssp7IFYrBYBxX6PVp3At6mOSDC4pgzuYxt0L499vzNutnhiMpxY+JXgMQth7Njv5o6AIjGG9BNuceHrU1DWLDyLTTn+vxE/9FnowDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn9ezfWBX9P7oi1b3Ya4ldHjqc1Brlu5+GVVHGfswZ0=;
 b=RTiYccCTbGfpP0NbS1K3UGxHL7IfqC+hRI1aVh+Mw/X8ZwawOqcuDl1f4yB1vyh9LpQS+V0pv++qUOAeaDjqdDU305UTLZiFHxPeCGJKe6CnI9L6m0fgWbD8KqIzYqIFjfbpFa5nC5xH09mFGBCZcY/89Ghqja9qJcqTeCaN8qQ=
Received: from CH0P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::15)
 by MW4PR10MB5726.namprd10.prod.outlook.com (2603:10b6:303:18c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:40:33 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::51) by CH0P221CA0045.outlook.office365.com
 (2603:10b6:610:11d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 05:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 05:40:33 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:40:31 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:40:31 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 23:40:31 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6135eQOn3402758;
 Mon, 2 Feb 2026 23:40:26 -0600
Message-ID: <68206f3ce6dffdf7c42d81d24091426497a5ab91.camel@ti.com>
Subject: Re: [PATCH] board: ti: j721e,j7200: fix do_main_cpsw0_qsgmii_phyinit
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <trini@konsulko.com>, <joe.hershberger@ni.com>, <afd@ti.com>,
 <n-francis@ti.com>, <b-padhi@ti.com>, <ilias.apalodimas@linaro.org>,
 <peng.fan@nxp.com>, <jerome@forissier.org>, <neil.armstrong@linaro.org>,
 <d-gole@ti.com>, <j-humphreys@ti.com>, <semen.protsenko@linaro.org>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <mkorpershoek@kernel.org>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Date: Tue, 3 Feb 2026 11:11:50 +0530
In-Reply-To: <DG52P91F2IJ0.13IQHK33CRF1E@ti.com>
References: <20260202141058.648965-1-s-vadapalli@ti.com>
 <DG52P91F2IJ0.13IQHK33CRF1E@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|MW4PR10MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe9b5ee-02ac-49d9-6a02-08de62e6bfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1ZnY1dWeTVVWFZ4WExDdXp0elFFMUcrWk45WDRuNnJWdEhENUh0Yk1hU1dO?=
 =?utf-8?B?ZnBxTXhEWDRlT29kZGpsY3hnblNtWVlxdDc5NjQ1Zm12Wjg4VCtMUXF0OWcr?=
 =?utf-8?B?RjFrckVIY3BhTWdvOVJrNkVlREsrdTlpeE1IV29nbUl6S3RHNXk0TTdsWnNR?=
 =?utf-8?B?R0ZvZmlFUDZ0SmdEWmhJVGxjZmZzRE4zbVBReW04Q2ZydGJxbjNTUlhlbVA4?=
 =?utf-8?B?N2VPZU9UNXZtaWpNQlZMRmJFbzdGYXhPQjlIRmZQbklKekRqQ1VDTFZuQVdk?=
 =?utf-8?B?Rm1Id3cyTVRDNStGYWFVWmtoVk41cVM2R0RiS2sxR0Rxb3ZPV2swd1MyQnY5?=
 =?utf-8?B?UDFSRXZtYWx3M1kvOUp2cEo5bkhjbEt6L1loUUlCTVpjck5wWE1URkNIYTkr?=
 =?utf-8?B?bE9aMm1ETDVOcmZXdXlGMmtDUXNvQWlKVFpqMExSdGY3OW5hY1ZMSHhXVlJq?=
 =?utf-8?B?bWNqbHpqa2JHcjNyKysra2s2ZWM3Q1pQVVVSNHpTS29KeG9FdG5tSWRvVlFr?=
 =?utf-8?B?WTVLNXlFendBSXE3ZXBON1h5OS9kSjkyWXNzaXBJSlcvWFNjY3UzUS9ray9H?=
 =?utf-8?B?QVAzNU16SEpEWFVWaVZLeWVjcEVSemJFeGVsaVVDSWtIbGlxR1ZpM1BSK2pk?=
 =?utf-8?B?Z3h5UmdETzBsWERaekliVTAvZXlEVUQ0TE5TQzhnNUhkSVVOdFYwR3VidnhH?=
 =?utf-8?B?MlQzaXZndjJDQWo3MFRvYVhmMUZyKzZJQ2dWK3VkbCtudVloQ0FsUHdPakFN?=
 =?utf-8?B?U0doS3RBZVdubW0xa3J4ZzdaUHV5a21SdnFlLzRXUjNpdXoxWk4zZFMxZ0VC?=
 =?utf-8?B?RktNTXJrQ255ellLbVhjc3JwV0EyZ2ZoRVNwY3pJd2V3RE9sa2R0b2V1ZGZP?=
 =?utf-8?B?dWdKcURtNjdtVzc1aUdlVkljVE9vVGc4ei9vb05QTFRjRXI2eFNYbGd0c3Qx?=
 =?utf-8?B?bG5qUkxlek5GYVVjZlNNdDRjZ2NPRHFxajJ1SDFZWERxa3M5UXRBcXdpenc4?=
 =?utf-8?B?eGhrUzRpdExST0Rabmd1eEVZZUtVS0Y2VGZlazN1NzhtVVRJNFdUVWhPVVBL?=
 =?utf-8?B?SXlIV3NOZlZnMFBOTERtOTZldWsxRkIxMHJWcHNVRlAvQzF0VmV0QVNDMS84?=
 =?utf-8?B?MDNxSlNrZnRnRU9CMlZmQ2ZDb1lFMmsyT2tSR3FTaDYrSmJuaXJaWTZjOWRu?=
 =?utf-8?B?M0o0WkFUL05SeVBXZ0Z3N2RxZXVCTjZzOGVJck4vY1hycHozYnR1cnFUSlNu?=
 =?utf-8?B?S2M2T01BcHI3aHdXQ0lwSTBMeXh2NkIwQnIrckc1SDNvSFRJYWJYZm1XcnRC?=
 =?utf-8?B?a2xkTkRZOWRhRGFqVzJGci9mT0hLZnVJanFSakp5Vk9vK3FqMUpqMVhYamFP?=
 =?utf-8?B?dEQ4bytDSk95QSt4R2lWcEtwZ2JEelI2WCtiZFlHRmJDcER1WVFJMXFwc1dk?=
 =?utf-8?B?eXFqNUNPczNDYjJSeE5hN0NiRDNhYVRyRFVDK0ZCYkU4ZjdrekpEdEI4UDc0?=
 =?utf-8?B?akhXYVoyZTlLMG55N2tUMGVIUzg3R2x5OEVWdTNFbnFlQ0I1ZTlYKzArUExI?=
 =?utf-8?B?UWlrcjVta2lCYlVITG5hUEIyay9OTDhYM1U2am9rdkhpMEcvZVpOVmNJYWQ1?=
 =?utf-8?B?SnBRakJXRDU4aUZEdCtOdGh2UCsrcUZRZGRuZkI1TW1JK3pER2Q5Y2FneDNw?=
 =?utf-8?B?b0YybEowWUY1Y3cwd1ZUQ0Z4OEYwNmxEaVJDajd2VXZWak1ReHBEUmlxeEtm?=
 =?utf-8?B?UllReGNka281NWRoMGNLbkIya0tzcytYNmNSL3oxVHROUXpVUlR0TEhiNDgx?=
 =?utf-8?B?aVk2Q3d1bXRNOVJhVjJlK2thSzg4WnBvVk0zbkkwYXNQZmZuNkFvU0JyWlZT?=
 =?utf-8?B?Y245OTZ1Kzg5UlZLWENiWTg0RWhtNFQ2RmdFeE8vMklTRzFjb1V2SGlKaUV6?=
 =?utf-8?B?NGlVTHNmVDhwOWhqcW9UTzBIcWhycHR1VU85S2lacUM4MGkrNWNvQU5QSEpi?=
 =?utf-8?B?SXl4QzZIeXFsZ2cvV1k4SHZibkZIby85SThwb2NmTlN5NlVyaHViVHR5T3Fq?=
 =?utf-8?B?cmVXdU9MV1BSL2kyTm1KenBhRStCdUtPQkZxS08ybUM5enl6SE1DYWNyZEcy?=
 =?utf-8?B?OENCTEI2eDNGdDdaYnJ3dnY1TkFnT1daNXM2NzVuVlAvZ29NdFFmSHFPUnJ1?=
 =?utf-8?Q?/fBPRB/Wge/0jCRsK2pUtho=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pc6ynjLFVBPxvX7i69vzvpHTwy4H0nMVZUiI3NG8s3iUZITmS4kZUU/lkLcR4z4xcryQYPTQfbComgwf7VuElZsdHx9Y5HqHNnDlrtBfNFnGy5iDRa7u2inTJ8wJnsEy0VUm/vhXXl4dIqsMmircnvqih2D+0zi9uiXVKESUMoxhhHS487bbN6t0L9YbJw9PfgacqhXyEn6JNXF4Ces/QD4uEo5wzABTs2yr/0O6+uErE2QkbuzVWSFz3xT+Yren81uD/8khCi6gp9zOPtq6bMKpMBjxPQ1VuQSkYufR63TaF5lL/pKJn3Pz4TwdCXpDTGCvZuP+QWYg+dngSqCyxJ3NXZj9UxSbbK+0fQTXV9jvxXEXuGlXhrGuqY2uh5JGqgluIEwebhfH/wZ1hntoa0zZ5yrPXp8y2YQjiFSHOF4f39WhyIoFX3aRI0tPg56x
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:40:33.0070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe9b5ee-02ac-49d9-6a02-08de62e6bfaf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5726
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

On Tue, 2026-02-03 at 10:51 +0530, Anshul Dalal wrote:
> On Mon Feb 2, 2026 at 7:40 PM IST, Siddharth Vadapalli wrote:
> > Since commit 27cc5951c862 ("include: env: ti: add default for
> > do_main_cpsw0_qsgmii_phyinit"), the value of the environment variable
> > do_main_cpsw0_qsgmii_phyinit happened to remain '0' and couldn't be
> > changed without user intervention. This behavior is due to the followin=
g
> > cyclic dependency:
> > A) ti_common.env sets do_main_cpsw0_qsgmii_phyinit to '0' and its value
> >    can only be updated automatically by main_cpsw0_qsgmii_phyinit.
> > B) main_cpsw0_qsgmii_phyinit is defined in j721e.env and it can run onl=
y
> >    if 'do_main_cpsw0_qsgmii_phyinit' is already '1' which isn't possibl=
e
> >    unless the user manually assigns the value.
> >=20
> > Fix the aforementioned cyclic dependency by using board_late_init() to
> > detect the QSGMII Daughtercard and set do_main_cpsw0_qsgmii_phyinit.
> >=20
> > Additionally, to address the issue of do_main_cpsw0_qsgmii_phyinit bein=
g
> > 'undefined' for other platforms, replace:
> > 	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
> > with:
> > 	if env exists do_main_cpsw0_qsgmii_phyinit;
> > in ti_common.env.
> >=20
> > Fixes: 27cc5951c862 ("include: env: ti: add default for do_main_cpsw0_q=
sgmii_phyinit")
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >=20

[TRIMMED]

> > diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.en=
v
> > index 03e3267ef8a..a0ed83f52ac 100644
> > --- a/include/env/ti/ti_common.env
> > +++ b/include/env/ti/ti_common.env
> > @@ -22,11 +22,10 @@ get_fit_overlaystring=3D
> >  	done;
> >  get_fit_config=3Dsetexpr name_fit_config gsub / _ conf-${fdtfile}
> >  run_fit=3Drun get_fit_config; bootm ${addr_fit}#${name_fit_config}${ov=
erlaystring}
> > -do_main_cpsw0_qsgmii_phyinit=3D0
> >  bootcmd_ti_mmc=3D
> >  	run init_${boot};
> >  #if CONFIG_CMD_REMOTEPROC
> > -	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
> > +	if env exists do_main_cpsw0_qsgmii_phyinit;
>=20
> The patch looks good to me however I wonder if we should factor out
> cpsw0_qsgmii related envs out of ti_common.env since as far as I can
> tell we only seem to be using it for the j721e/j7200 devices.

Please refer to the following commit from 22 July 2023:
https://github.com/u-boot/u-boot/commit/4ae1a2470ce7895b747c85a140aaf8b647a=
e6a32
The commit added:
	run main_cpsw0_qsgmii_phyinit
in include/environment/ti/ti_armv7_common.env and ti_armv7_common.env
eventually got renamed to ti_common.env by:
https://github.com/u-boot/u-boot/commit/bf9c61acb6caed97114029d2dc1e91b148c=
d9b8a

Although I agree with your feedback in that it will make more sense for
do_main_cpsw0_qsgmii_phyinit to be present in the board specific env, given
the background pointed out above, it seems to me that we are simply going
in circles by undoing the changes that were previously made. Nevertheless,
if you think that it should be moved to the board environment, I will do so
in a future cleanup patch.

Regards,
Siddharth.
