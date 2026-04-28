Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FB5FF8864
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B71F684099;
	Tue, 28 Apr 2026 05:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="a3JKGJdQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B6683BC4; Tue, 28 Apr 2026 05:08:26 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7524683693
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CV/YOEgzlohf2vNUGQdgkcvf9K9S20g9JpyxYda8EfYlFl9RbHL0qa0fJMUT2EEG5KX4O5RbHF0mABWunYY9l6P9uZHMxudgQVNPAGiLjXAEfGaeGObm6UHxFHHMp1GM23sjI30ERA72uXtGJD3ecBL7iXD4w+QLVW2eFEq3T6tUNkfVIILu0gj+1SNy+az6djPH1LJ8xJdXvcP3UNyuAnOkmvHeV9fzY0jwg7/9T+ybuNHstSDTO/Pf2Sw3jxWh88tvOKSbUBNnUh2ncg2PAsxxsSY1zdo83qpjPvWZuMWotksVPIf+54rGegPhIrad5RLaUsRXtMzwaJHDHDlwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwSsDNtZyvmqeYh8MsF3C3vqD8/pGip3a2RDOyAThSk=;
 b=c/id7GOsnhUgbd1VdYMJv5+j+1wQGiF5qTVb3bEn+mWguKqVFOwtway7EIEs/6/Ggs8BwHBpzkvVJ5q2+/LyBDsB8f1GOwew2YGVbeEpopB71HHZu4TLXhnMrDwHBrWl+zq6puVR+GL5mc+5PwtK/Gjy6ZE2r53b0rfDh7OwA9IllzLFL7+Uk2s6G3GqbOnub8S5dejk8o4GqOKX/n9Jdwbeub0SwdCkfxgY+7EJAzcQxbH0x+Jk+c2MJn5EjYeaoCB+nvJEuwRSIRTVNovgZhy4X3Im6IrQ9SYnJzr0bC4rE4uGjPNCXfyKb1DWK+S1WHoP8zFuc5mdtyDOvwdZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwSsDNtZyvmqeYh8MsF3C3vqD8/pGip3a2RDOyAThSk=;
 b=a3JKGJdQDuFmeeebNrtiEnMQ/IlW1phaJnCwz/Q9TtANtlg5T6Gq8h179vn1zx1bHpgeh97ayAVbz1o2wjmWIhNsG34McI7r0663IvYGlyI8gqStxDFgRS8PIMu5iIcTFh+wxE/uzfUOUug/BTg0kIhVz+HmJOuLSUsKzNEcspZJTbPUWyqIe4VF2ZpyVejqm0lSukqn2p5ey1je//6hd8quOcRSzC0JjkehE12WPUswvwSWOpyxGPueaYywyz5uwYFJHxsCayBEVZcKbyjEOKmAGpbb3RALw6F+ZRkbyAanHompvoH/mTwVMOeeLt6oUaZ6IB6dwxw5hIgXfNCVOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by CO1PR03MB5683.namprd03.prod.outlook.com (2603:10b6:303:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Tue, 28 Apr
 2026 01:35:23 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 01:35:23 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] configs: arria10: Enable random MAC address
Date: Mon, 27 Apr 2026 18:35:18 -0700
Message-ID: <20260428013518.27331-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:a03:60::17) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|CO1PR03MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5146b3-87dd-4ce3-60d6-08dea4c66a96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|55112099003; 
X-Microsoft-Antispam-Message-Info: uvH8XPG2YyhhJkNAZ/xH7b/0XHte/iOIFo5UPMsjxh4RFc6rSVXlxI070ZhkDFYihx3i9YNxfIwQEfchjg9csXXd15vzXWynob+UIqJy1GuoNpHiwO0zwzNeG7P7WnkHnPYjLUtbRDEiMd6Jy2phSvb8G6yfger+efyOytcRPU7q8z1SuAeVkad9KunVWHMTHKGMcShHBr1QMKN2ZBOGVgcnH/LqDXIEy/Tn6Mi5e+B1M2a6zoICuF52Trmwn51+Hoa4V2LGPVtNjO7mPrfRN/enw4shQc/KiE6b4Ujpuxlt8cGP7vmZB7uyt5NaFMI7/z2i8XCU+d75+ogD48qTlPcuiQ6Hr6SqCbN1WJVV6uysBzeg945+R+9SQWLTMUHDVc2ShbJ8zWVHfU9P5a6PF10LkSwxFpVK9sG4Oms6TCxdlZX190W/bbFquI3eMqPu2Duo5kvTg9AprmLyuhRpi+1czWjp86+9SuI3H4Nt0Q5Zx6C5sNpGcyx4eFLynGaXiibpw83Su8qmgoM7/fMxuN0ColJQUmyOvlF6SdWnTTnI2xAnWlN1xAsag6x30S4Iu9uRhUe2I+77dgHnp+XqWVLEo9yE9struquQsiV6vdPWF0b92gtdNaP5ybKONUHKr4xn9mjUw+5Yqbz2h4nWHDG15bZoOyIjlqfSMVX99itBC8280XM9NN0/zSpGVtyq36hRRpPRsOEHANFnq+pj9yGcd31U4OR24iR1+n9dZes=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m9Bwv+1gU1arlPDZjT9zIlYEA1B8WkQhD+zpZPt3nGbZwrgyjJtIMiDYBpqK?=
 =?us-ascii?Q?06cnrdqUXpA53uchIdyenVpoyy74PJQ9LT765Zus2jdaChodNFEXgXRLnnxe?=
 =?us-ascii?Q?bVqSbpFLBCtPqcLtV7P/WrbHTe0K2m5pYH+JRLKMKcFvgrmZ2cKb6jflptzI?=
 =?us-ascii?Q?EELAVypWHjE2Pg5ZV1j49r3h/vCkIy1Mm1XQ94RxITBU4/Q3MI8PtSeAM4AP?=
 =?us-ascii?Q?eOEKjjuDL5PNcfD9HESTIq4LTnfdpjdNCoqM+6i0RkCM4yTGhL44dDHX2sCJ?=
 =?us-ascii?Q?PTFbj71k0xE/vWtGICaW5fPHVj6hv4gTmc3RH1xY4llkhM4sgx7XsijIM14p?=
 =?us-ascii?Q?ZLn0PPqbaT6toCHhEJTCwYzowNRyTKjhgzr0nRoLFEDdk2JawVkdQfUTSTzS?=
 =?us-ascii?Q?fYE8PPHdeY27S/5fKBNW62d4ut64s2YBehiH2+0RmwIjGWQvSpdVOtEffrDA?=
 =?us-ascii?Q?LP2RWBYOaI3QRplOX82bEaQSbX25LQUmDoVPJN8PBOyR1/yeUPDsZB8/4Nom?=
 =?us-ascii?Q?bhE+saJU8eRBxmjkf/qqfkkZubo+bigO4OhSFPVDMa/oJrgI2d1bGYbblNYb?=
 =?us-ascii?Q?5pDWJAl+g2Eubs/Mnziq5ziW+XUfQdgxZ59sMxDB6edLvR3OcFS1g7DdgWqR?=
 =?us-ascii?Q?msQB7/QJBEIRPD9sJkx/zjmclRpGx9JeVwEysxhUTu9PJPFjh3UqoNJG9hli?=
 =?us-ascii?Q?jTD9ReaCURwoJOeJsSovJ42ddt2hEQ4QtQZlv1UwQ395Q+r0uJZg5EDiOcTB?=
 =?us-ascii?Q?XCc/jH6GHDfnYCZgQF/7zcSyuH8l21FNZNhKZCGA035/2C5pjK8WIAsj3gOG?=
 =?us-ascii?Q?AYAup3gyWQTzrvBmAe3RXYghOW5Nl4pSM3uFq1vTQopQJEzsdJ7ZGK4bUYfO?=
 =?us-ascii?Q?2qRQvGNuj/gNh2bmkm2wwjj1Zsvub+mj1vr3Kx6itiIhg36Ym9RfYbmpnsdj?=
 =?us-ascii?Q?owwUjOMBbVgOXz/XtUNhECtE6X8H0ZDjfeuMunf4Y//b6C6bTLE13OhceSv8?=
 =?us-ascii?Q?1Tr67SgNyzD/7Q+f6gwfDGSPqFY6FiOMqwPNdxp02p8w01ssgV02hLuKrQPO?=
 =?us-ascii?Q?tKJlb8hW5irRnxunPrF0JL7Yab+h/RqlDQ1IJzywcapPXv0ywZz79BSOabcV?=
 =?us-ascii?Q?IhzQC6Gp56BlrQoDbviqU6X0dIvDAD3kJWzPmkYgyeM75WUgdykWeGqDaKJO?=
 =?us-ascii?Q?Mltt5VW3AkKFOslTEsMkw91A7FOo9407KXuIyTsyXBMV5cQzj2E+os632ZZN?=
 =?us-ascii?Q?uGJFgo/cAGQolvuHilBEOT2jhy1zVVuZdcyD2mBvvjiFQbN9uXs4TR2E9ap4?=
 =?us-ascii?Q?y/NF8HNl3yjXP9lfJPq7ziJn+gXBRGJykA5eV9CBYNxGXEC0j/rcxII4bCkN?=
 =?us-ascii?Q?62kvWsKN9HBDkkmQpJe+E8olx3t5XkZNl468sp8gpTo1WQfA8qWYQehbweRN?=
 =?us-ascii?Q?ibs8e0yRKLRsgvSjkOpFMr0olofIAQHEdSexOzCmKyctk3YE3x/oaQoSo2pn?=
 =?us-ascii?Q?lq64vDnoGxdHEMEWEm+kaWyZV3dOgNjMjV1sA4W/T6XAVvUTtefRn28pkhbT?=
 =?us-ascii?Q?W1luzCdTIeahIx+nCmbEL13hcpA7jJgyLtPPydrWgRVYncLGk4tcB/9nQZEF?=
 =?us-ascii?Q?efO/w13DWXEg1YM6iMyjEyWUZOPZDgOMJJAx/maD56fj2h1IPKiVWNF+tMwn?=
 =?us-ascii?Q?5S9o4ldt74jxxp1ijJQdMp9YmNPe05SSD9SBLvlspoY3nZMKsAbQGqftuann?=
 =?us-ascii?Q?WdeXLOJqplreYNI5aGaUj3dORaih0hw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5146b3-87dd-4ce3-60d6-08dea4c66a96
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 01:35:23.3716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjmQWe716uToq1Cpwgdf4RRW2JraUwgB3pO9z7UYcBnvVP7RipW8PHnJ5LPwFu6ZzJpJYbwAem212Yc0nq/Twd4UUu/2Zm1grl1kSusW+1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5683
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Enable CONFIG_NET_RANDOM_ETHADDR to allow U-Boot to assign a random MAC
address during Ethernet initialization when a valid MAC is not programmed
in hardware.

This avoids network initialization failures and MAC address conflicts,
especially on boards used for development or shipped without a
factory-programmed MAC.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_arria10_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index b32f40ae408..4127b4ccbca 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -50,6 +50,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_FS_LOADER=y
-- 
2.43.7

