Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DACC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 06:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 776748871A;
	Tue,  2 Jul 2024 08:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="pMTY1R4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A299884CD; Tue,  2 Jul 2024 08:49:02 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C48E88712
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 08:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIq63rpyCYWwQVzeLtT6pc4jkzVMmf1uMSVCF+IdR4O4F7tHScjJ/eqX61+nuSEeXxy4HCwgJZKZVWy6fsP6XqXZ1Q97w7WmTvK3r52kSHyguo4WYKQDM0NzXbr6qL2O+pauxGX4E2QXPsukizDuWmhz4R0jeoe1IqjiaAbGhacXA52NwRBciSxvOMm249SY0PXCFVhuGvZIHmLK/gGE+MnLHYo05jQzY4PVNL6R2dDv6xxsUZCCb8l7ZeDFwfroMON3/100RnS8C7inLrBpyTzScZwzYbtkJf3vrwHNZuB3R/Jj6wwYa+SIc/YxJdXIS98IEmnNIdbOX3d3htN8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qFYj+oWuayadb6TLUjX4K99L9cwrd8o+6o80D4ND4E=;
 b=m9urNxqskIMRP+onPV1HIP9fNJ4QpFoQIfZhkSU1+gxmcfIDPjam2yJZnMYEakR6ooke2/Tewn+8BS6ehV7pibmy/6xojyb1El8OHAeNQkmdadLu6IgnRcShi1mt9aiu4CxpCBxy8NobMofhoSij+9V26olG0kgwSBsOcEIvN5iUQVMKYNMnZLJUqwm/xTjkq5YV3+eG5BI3qoxAQiu2Aag4eKHPKUrwkUKz3xRZKuKQeEloLMKzCW5n9NmFdU2TsJzN3FdReoap3pOfejEEBsNO0CfR/ZwRnhNaLwiW9Ou94/tJVvIn3emU7ou7EswGmeB6JW56BW7OHcwPXvZBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qFYj+oWuayadb6TLUjX4K99L9cwrd8o+6o80D4ND4E=;
 b=pMTY1R4LY/XTX46kY7k9xJTZ+j/pUZ3Ge+fcBRq1wcDrqUGxEpAfWEjWv8UpB8HUWuB8/TnbgXupCp20yB2ra4w4G0hwwRKg9C/fz9/YNJcF3gXt6K6hINV1KlWBYmvL04NkBuG3S9vOtPcWUyPMXrB6Kc99q1kl9KyUjxekpdktDbwyX8muI54wgUbvTo5oQ74rZuB0ffwovT04sWUGaMd3l8lw7AkrA0ZaMjzqv5z+xCVjoqMOpfzsXTeoT52Obuzagtam26NDNxqhuo6/B1t3LIFa2zsIjpGjxTP+7CsS+aQ/YY8N3zzzBRh7HbeI8YOFFqR5tiXFuBMYn4eneg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB6356.eurprd08.prod.outlook.com (2603:10a6:20b:36b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 06:48:59 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%2]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 06:48:59 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Niko Mauno <niko.mauno@vaisala.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>,
 Ivan Orlov <ivan.orlov@codethink.co.uk>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/2] env: Add function to import environment variables from
 FIT conf node
Date: Tue,  2 Jul 2024 08:48:33 +0200
Message-Id: <20240702064834.9543-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240702064834.9543-1-lukas.funke-oss@weidmueller.com>
References: <20240702064834.9543-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: d17ddc25-b1fd-4379-e8b8-08dc9a630ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7j5B6jektX9gBoi28ObMHSs0D8M5DCGAL0TUG8jxfz25LczrB9Pk59fgWuOu?=
 =?us-ascii?Q?pZwLOdzR+XjCrey7S6ubriT/PyzAnm86699B6nTLqmyY2bmqcvyrrjylK7kI?=
 =?us-ascii?Q?hk/Fwn0k48kqlcLd3eXVpWCSzDr5o+a+bjDrCBJ4RRTSOS3GF6e34GWYxN2G?=
 =?us-ascii?Q?TyJWsN3I+OFn/kW8t+gmahNB1koBwTTC1HhvXVKjN1v27me4Z7zqVLv7Ez6L?=
 =?us-ascii?Q?Ntw08q9KkqnbU/KLljuJoKTQqxl6dcgwKvf7qwVdgR4yuxEBDPX0tE6TH9fv?=
 =?us-ascii?Q?ul+Yo/PocSf6DyobhzQYuSbQc9ijdjgGS4xwY1XBUkCx/agalAQS+mSGAvvM?=
 =?us-ascii?Q?/rBC4r5GHE4eydN5Pdpr9EAXgykVI5+tfBfax3zKGx9prvl1qEepcUECBIis?=
 =?us-ascii?Q?CniKmhclL14tl7qLbz5hr+SOsGNv1ASS4uR73GyXLXtd7709dFPlIJEmQf6q?=
 =?us-ascii?Q?H7iGBzLWx47a8MP/lZiQ6kb4krANvDwVkJteDKm7oPkbCYvlULmVjlXIYB7a?=
 =?us-ascii?Q?iS1OiYVF9ENy8nvNOQ0rWR9CfkJPALIG4uNxpMr8aIgg0Ck2AwvY/lNzCh2m?=
 =?us-ascii?Q?3PiX8Akd15YbWRwhldGxQR9WzdBI1vcBHp3VKDP4KclOb6Yb261V0E7De78G?=
 =?us-ascii?Q?vfDaq+wnTKn+m3DnlrVZA2I0f91vHVSYuBb7UfnSh4eTV1+vcoE5DVDZ9w+R?=
 =?us-ascii?Q?LuLAYvbCLpgbkcslJDG1Vs2ITKo3R/JzKEDf26Mu0Lcx4YY7eMaI1PtGj163?=
 =?us-ascii?Q?0AUkObXgxMboUU4CbFmfTBXbP+MMTaQmM0S4I/cs/ldaJ78CqWd3a6BfVlxc?=
 =?us-ascii?Q?jk8hY59AvhuBNVVqtx2WXAo+NcVzA7FteF2Fr2rsLvgWDcBE4Sgx97XQImhf?=
 =?us-ascii?Q?1Krp3uSE6PIeIhfsPNmVnnQMQgul0cUB6wXbF9jeYn8jF4YJBj64lO3gkOzY?=
 =?us-ascii?Q?yDMQ2zc0OlJNwEMKh8mux0eFh5Iwe3Z3zFMUAgK3QnoKPLUJsVeJ8O2Ij+FA?=
 =?us-ascii?Q?oHfhTHflrSDh4IaItuAO/NUsi6rfaQyCloDQ5cLQuIVuW7aZFh156euwU1qI?=
 =?us-ascii?Q?rtxpEFeUN6KB1+TldUEXiruU8yHPIkTE3DYpOYBUdwiJxHV4KGUZIuOpL4ns?=
 =?us-ascii?Q?0ExQmzogYB/JL5iIjaiAH5f6/XIxboqHkosL+GTQv2HNVxrkL51AmFPronp7?=
 =?us-ascii?Q?Wf6GGZog0vGInPRjClTDpw3eY8fnxMXJNY4pyRTyjqUuDG2TZIzAtCH84jg7?=
 =?us-ascii?Q?pk0f+CCRpvDyT/Sx5e7JyynuulVvwUasZTJg14idjgIU/+GvJC0VmVm/r0hn?=
 =?us-ascii?Q?z4M/7u6scJsBG9Npkn5AGtHeEQNs9178ekZs0cgeS1DEvdeXE1CkHtMcz3xc?=
 =?us-ascii?Q?VzByJJDJCssMizYxBUA4yK4tSjnxWE/rJuey6y29M8FUAQqDQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+FuxLYnNsi/Jor02ByxhRgJeN30b1uqAUl0SH6xpSsznmG7v97wvnkCNTH1p?=
 =?us-ascii?Q?pzj+SgQCh4H0IFRp+Wh33LciqPZgVE5PIuFg5V30KI1z+WsJNdV2jGBfifFW?=
 =?us-ascii?Q?K+u0wIBwJkVgVdNhD+q57GtCOZ9gxYL7zhHBx+RhS4aRtrCqsFrB3xpNVTKg?=
 =?us-ascii?Q?VnZpg6tlbJvzRsEkChgua6X5u9QafaPwLoarpJmpj60q6ZomktE0g7bpxc2I?=
 =?us-ascii?Q?AREnUmSJRFWfYC/9qegdvuUivYM4SHKyn1pQIGnCEME9a5dfLIxi/aGZC/VB?=
 =?us-ascii?Q?3Ez0IvoVgLZC12uWI2+ENltVAycVqwMmL7SuJu+RcHG5zGeS51kHPMJBGNYD?=
 =?us-ascii?Q?82KYC/1Dqp48EetJHbva3Edq0kG4n0s/PslFkrMOA9FYUPCYd1fmn07OwXLC?=
 =?us-ascii?Q?CmZ0nwwtvhoSKokXH85DAhmAs3xIZtO85tDYDAIaBnxDzr4ifdDDja5/9y8/?=
 =?us-ascii?Q?+7JEhEmkNgIsxI57mN0oT9JBOnJkjuwVWLayqnmESIyly1/GWUwZBA7psRcO?=
 =?us-ascii?Q?57arJ61iIBy0htAcG/GC8a7/jcCs0y1gM5VOz/ozslcB7pOB25wDoDaDNsLl?=
 =?us-ascii?Q?tgSYVqrzFE7o/K+uoqUMsB/faSFPny4IadJELiM33DX2fbuxepC/eKs6DEzs?=
 =?us-ascii?Q?EmqUuwy5P+QLJP2LygIAduk03HIQhFkFAnv3uoWp6/gmhmwXLR5lw/KlUH0W?=
 =?us-ascii?Q?DFd38KSORJfSlwb6qbYmYe7PnNfeCGlIuh2V2Omkmx7PUr6C1r23O2BUni81?=
 =?us-ascii?Q?4GvR1DS1c87NzHhl1zfduXWH65ziEcx/pPj7P0jHiGHhLtjD1Gs6JyOdzpB+?=
 =?us-ascii?Q?z73V/6uYU0i+YHGXxuFnM3C8phVK7qJ7H2l4qDWZ6nZThqmdh7XQAG4PrB/c?=
 =?us-ascii?Q?HbvpAZbLL+zzMceH8WsU0iS6/izAlbv613tkL8zn5EMNQp1QkiQGm88qNpV3?=
 =?us-ascii?Q?Srj3vTPJZCCdmZnNx39BJIMyqQuA/Jbk9fkhgBCvGkHxvI/9Byc6A/YNz/js?=
 =?us-ascii?Q?skdbfSG/wJuzyMU+7L7rbaVlcYtx0/FztO0qbhqwnkMWLiq4ajBQmZwkM70E?=
 =?us-ascii?Q?rJujXsdqPBBhmnEbO3leWzByNEuJB4b9BIW+7apjsE9ScRZ4C3rkblnKDBf9?=
 =?us-ascii?Q?9iT8tdrNDF3z6IqnxKFW28klEhOLMX/Uuh4qbnQXhNSSyTYam/yUahFVAHMS?=
 =?us-ascii?Q?DrNF3Dg1+B3cF77Y53w/yLvk0x46VhezKwgvB5J4zUrD8k/1aFHGiWJv/V5Q?=
 =?us-ascii?Q?B12naPF6R3ZadV+Ean1+xLO/G0QSLXuILPNMwxULc5hp7PQFEz6MCLMabGy+?=
 =?us-ascii?Q?N/ddXZFMX9B4SbsJvwI0N2546dT0KjZm+2DlkfmfZbe8XvOIPrBpxSO3f5GS?=
 =?us-ascii?Q?z6XhhLGGgH4h2gu0JtcTXEqsKeWNgq479BHN9WEJvqRm9kT2Wm6TkFMBqwya?=
 =?us-ascii?Q?9Mp8gU9/K1TmN5DrJ3fyKKnYsdT3jwLqfQHlFIToxWfTKYciEDsEk27lxvVD?=
 =?us-ascii?Q?M26/JyE/2szDVQTxiQfnfKfa+nP7HytFrdxjfiL3oR+LLfc227rlXOC41j1z?=
 =?us-ascii?Q?pmacsX/CBphVv9RfFbmWV6OKE5wWyp3i7BRSqmYc3QnwRv0arViW44dDGR1W?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17ddc25-b1fd-4379-e8b8-08dc9a630ce5
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 06:48:58.9738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNh2vavjjG9QAlsKWCKF5SWyUnQ0uvlQ6NraSllQsR/GKlAQuD4NhHIE8zJYPeB+feAge4smOue+DCEm5Pn/xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6356
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add function which reads properties from FIT conf node prefixed with
"env,". Import property name (without 'env,') and it's value as
runtime environment variables.

Note: this only works with string properties

Example:

    configurations {
        default = "conf-1";
            conf-1 {
                kernel = "kernel-1";
                fdt = "fdt-1";
                env,foo = "somevalue";
                env,bar = "someothervalue";
            };
    };

=> env print foo
foo=somevalue

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 boot/image-fit.c |  4 ++++
 env/Kconfig      | 10 ++++++++++
 env/common.c     | 28 ++++++++++++++++++++++++++++
 include/env.h    | 11 +++++++++++
 4 files changed, 53 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 89e377563ce..0ca31c5f851 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -34,6 +34,7 @@
 DECLARE_GLOBAL_DATA_PTR;
 #endif /* !USE_HOSTCC*/
 
+#include <env.h>
 #include <bootm.h>
 #include <image.h>
 #include <bootstage.h>
@@ -2128,6 +2129,9 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 			puts("OK\n");
 		}
 
+#if !defined(USE_HOSTCC)
+		env_import_fit_conf(fit, cfg_noffset);
+#endif
 		bootstage_mark(BOOTSTAGE_ID_FIT_CONFIG);
 
 		noffset = fit_conf_get_prop_node(fit, cfg_noffset, prop_name,
diff --git a/env/Kconfig b/env/Kconfig
index 1f8e90af55e..01b802e54b9 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -748,6 +748,16 @@ config ENV_FDT_PATH
 	help
 	  The initial value of the env_fdt_path variable.
 
+config ENV_IMPORT_FIT_CONF
+	bool "Amend environment by FIT configuration node properties"
+	depends on OF_CONTROL
+	help
+	  If selected, after the environment has been loaded from its
+	  persistent location, the "env,*" properties in the conf-node
+	  of FIT image are used to update the run-time environment. This
+	  can be useful in order to transport signed environment variables
+	  to the kernel cmdline.
+
 config ENV_APPEND
 	bool "Always append the environment with new data"
 	help
diff --git a/env/common.c b/env/common.c
index 48a565107c1..c8aa59447e9 100644
--- a/env/common.c
+++ b/env/common.c
@@ -24,6 +24,7 @@
 #include <dm/ofnode.h>
 #include <net.h>
 #include <watchdog.h>
+#include <fdt_support.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -661,3 +662,30 @@ void env_import_fdt(void)
 	}
 }
 #endif
+
+#define FIT_CONF_ENV_PROPERTY_PREFIX "env,"
+void env_import_fit_conf(const void *fdt, int conf_node)
+{
+	int offset, len;
+	const char *name;
+	const void *value;
+	const struct fdt_property *property;
+
+	if (!CONFIG_IS_ENABLED(ENV_IMPORT_FIT_CONF))
+		return;
+
+	fdt_for_each_property_offset(offset, fdt, conf_node) {
+		property = fdt_get_property_by_offset(fdt, offset, NULL);
+
+		name = fdt_get_string(fdt, fdt32_to_cpu(property->nameoff), NULL);
+		if (strncmp(name, FIT_CONF_ENV_PROPERTY_PREFIX,
+			    sizeof(FIT_CONF_ENV_PROPERTY_PREFIX) - 1))
+			continue;
+
+		value = fdt_getprop(fdt, conf_node, name, &len);
+		/* Get the actual variable name "env,somename" -> "somename" */
+		name += sizeof(FIT_CONF_ENV_PROPERTY_PREFIX) - 1;
+
+		env_set(name, value);
+	}
+}
diff --git a/include/env.h b/include/env.h
index d2a5954ded8..fa4c67056e7 100644
--- a/include/env.h
+++ b/include/env.h
@@ -382,4 +382,15 @@ void env_import_fdt(void);
 static inline void env_import_fdt(void) {}
 #endif
 
+/**
+ * env_import_fit_conf() - Import environment values from FIT configuration node
+ *
+ * This imports environment variables from FIT configuration node. Each
+ * property name starting with an "env,"-prefix is imported as variable where
+ * the variable name is the suffix of the property name.
+ *
+ * Example: env,somevalue = "foobar" --> somevalue=foobar
+ */
+void env_import_fit_conf(const void *fdt, int conf_node);
+
 #endif
-- 
2.30.2

