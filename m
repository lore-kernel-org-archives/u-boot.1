Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820A3CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 14:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D20C2833F1;
	Thu, 28 Aug 2025 16:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="WppcC+Pa";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WppcC+Pa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF43E83335; Thu, 28 Aug 2025 15:08:06 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F3B383323
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 15:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Said.Nasibov@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ayLdEIDsadq1afjmR4HXqGdYVpy6iHWv/qT6qiPZf6DvgFoSzHV+ubCtVghs2v0aaTiGHH5gOjfUUrO2a8rg/KeXpVDRtGE2VaHiQSW4mfHNgoYzC1IGM0lgvCkQSGR1u+qejBQ6xgc6SY/WFH5lPM9JZENVH9DNxAwvgm+NomhPwhVzAjeNN+60FettOmmQdwc7PcAmOYB4zx9970i6K8NvWYtVrEkFAAzbjd51klxhzbFFNnJPeDXJSCSQuvxZxZBTSJ/fUEAo7+1Fx6ZlshNJtWXprsVREZbl81NANLdG7okQ25kN7PI2U3ogQfcJAcw7dWXe1as1TETTesMWtw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcpZm3RbwxE95lFL9Y7htgUa9iEJ3ih6wGYa14hgXIY=;
 b=YHyl2aVt44AXW3R0WRgT1GgiKvxLR34X48+Lo5H6mwIg/yLJjQkZM4qwPCDV/zCIqbAByI7TY4g8d/ia1HZcNA9tEy0+3gTKFiJdt0ch1chN7lZXt4sMJGT2LNoG2ZALjJPl2V5cKmPOoFaVQreZcDoWQurRuIm0XA8nVCneEUJUFeWQbkIN10d6w3KGyuEfVVkraR61u/0NgNhmahLhgzcu5LeMOZTQg+jESEKBLXQqpTvOQNA/0lG4N8Pu93cQv7XraDDGsSiu3G2H+/k6Bfyg2hNQiUtBw0v3+mvpz+Vg5Szn89ytY4QlKsyY+2Qv8KZWkCXlxkWuJEBS0z4eXQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcpZm3RbwxE95lFL9Y7htgUa9iEJ3ih6wGYa14hgXIY=;
 b=WppcC+Pa1jcKtZQoP1eoAnoQ9v2nHORqVDW52hZGaQddnFTugOY4kOVNKt4TDx2eu0FqSDm1cKhKyorHNb/1OEATYV0jVlXtgbl1AypX/+21yGm89RihV5fHxPgjhFJEDgugB0kvES5InCZeGu/SOEyEq+exkQ94hXk8SktEMdo=
Received: from PR3P193CA0008.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::13)
 by AS2PR08MB8746.eurprd08.prod.outlook.com (2603:10a6:20b:55e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 13:07:59 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:102:50:cafe::22) by PR3P193CA0008.outlook.office365.com
 (2603:10a6:102:50::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 13:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Thu, 28 Aug 2025 13:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T58MMKDG99bt9RQMZV59RGwmqSsPZrnON1clXhjAY3Ab1xJjjaRLEZVlbjbdOQ0kvk54STpBPUseKT62yPakUdnAosYJPE4UauHz17FssqB+eDQG6mKvI01KKukfKl3jVJqgXG6ilBPJhSlu4kq9uwI2U1tMXoiGKZm5a8/5SnrUPuBJF9aT59xb8XFqgRnJSnVl/HJ8fC01EwGymsyz6IjIzTH5iBbkQgLXItnnZYclIG13KNpWYqE57vGYGPEi2JZTrkuv7iaunOULbXmoWC4VwOcyqUmbLAMmsINK35Xx0uuf8MOwMX3jeB/GLh5ZTkuX9PDmfQXtnfmxiSEBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcpZm3RbwxE95lFL9Y7htgUa9iEJ3ih6wGYa14hgXIY=;
 b=km+hiCnP6ditVi3XBGvAdP7DJGhSLMQtHo93RBPcFbups6n0F+2mvNSP4ere8Hv9Buj5LHv9BA+TMVco/hGKsJxiDhqOYHkuz9MC3IO87a64f3uF21ljt0DVAj2X84bhZ6YMxML8iRjgoRDUZWFYv9KVajN7a2UrEDU3X9PfXHHlchuZsrMS+yh3EFAmTYPUoWyH5r/oX4oJfTEFhBEniaBPA71ky1H1rCG3wG7DLcc3EeSBnm/YcTuCudsnolPxX1aVgG3yYVCN2lc0JzefJ+3bQQ+H1iymGj23OELqJ5DhecuQcires6o//MnpbMznOVBrk1JZdqfPkw4B7Od/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcpZm3RbwxE95lFL9Y7htgUa9iEJ3ih6wGYa14hgXIY=;
 b=WppcC+Pa1jcKtZQoP1eoAnoQ9v2nHORqVDW52hZGaQddnFTugOY4kOVNKt4TDx2eu0FqSDm1cKhKyorHNb/1OEATYV0jVlXtgbl1AypX/+21yGm89RihV5fHxPgjhFJEDgugB0kvES5InCZeGu/SOEyEq+exkQ94hXk8SktEMdo=
Received: from AM6P193CA0086.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::27)
 by AS8PR08MB7837.eurprd08.prod.outlook.com (2603:10a6:20b:528::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 13:07:26 +0000
Received: from AM4PEPF00027A6C.eurprd04.prod.outlook.com
 (2603:10a6:209:88:cafe::6) by AM6P193CA0086.outlook.office365.com
 (2603:10a6:209:88::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 13:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 AM4PEPF00027A6C.mail.protection.outlook.com (10.167.16.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 13:07:26 +0000
Received: from AZ-NEU-EXJ01.Arm.com (10.240.25.132) by AZ-NEU-EX05.Arm.com
 (10.240.25.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 13:07:25 +0000
Received: from e121818.cambridge.arm.com (10.1.199.38) by AZ-NEU-EXJ01.Arm.com
 (10.240.25.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 13:07:24 +0000
From: Said Nasibov <said.nasibov@arm.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <andre.przywara@arm.com>,
 <peter.hoyes@arm.com>, <david.hu2@arm.com>, <michael.zhao2@arm.com>,
 <marek.vasut+renesas@mailbox.org>, <mkorpershoek@kernel.org>,
 <pbrobinson@gmail.com>, <ilias.apalodimas@linaro.org>, <m.schwan@phytec.de>,
 <quentin.schulz@cherry.de>, <rayagonda.kokatanur@broadcom.com>,
 <tien.fong.chee@altera.com>, <casey.connolly@linaro.org>,
 <patrick.rudolph@9elements.com>, <alif.zakuan.yuslaimi@intel.com>,
 <boyan.karatotev@arm.com>, <Oliver.Gaskell@analog.com>,
 <duje@dujemihanovic.xyz>, <1425075683@qq.com>, Said Nasibov
 <said.nasibov@arm.com>
Subject: [RFC PATCH 1/2] bootmeth: implement semihosting (smh) boot method
Date: Thu, 28 Aug 2025 14:06:56 +0100
Message-ID: <20250828130657.249153-2-said.nasibov@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828130657.249153-1-said.nasibov@arm.com>
References: <20250828130657.249153-1-said.nasibov@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.1.199.38]
X-ClientProxiedBy: AZ-NEU-EX05.Arm.com (10.240.25.133) To AZ-NEU-EXJ01.Arm.com
 (10.240.25.132)
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6C:EE_|AS8PR08MB7837:EE_|AMS0EPF000001AA:EE_|AS2PR08MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9c327a-934b-448e-c56c-08dde633e954
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?TvFz72WYwdAYVjGhxALRVktIdP0K0mNhX5lFi1aoMN/L4VaHzbyr6ZJzk9PT?=
 =?us-ascii?Q?cO5q1c4GGK/l9oW20Q/4xNGar3e5fozsOzWrE95n3VLTyGLukO9hFJkvJ1WB?=
 =?us-ascii?Q?9edMneB7NAk40qPcUhNy3m60d6YqFsVIBi5cgZBQeLIg2+IGVrwohTXzrzxj?=
 =?us-ascii?Q?fz4fClQOuSfxz104LCJxG500LBoUzvaT0th5F2gvj5QrwjjEw0W5dupvorr9?=
 =?us-ascii?Q?iUm0FZOmDMwlMai1YCE6aEiHUYhvOrqw0S+hvNhUejoXh5JcpIfG+llBnfHX?=
 =?us-ascii?Q?NIpVXcELp00N47E+z7uaF1SB7lfznRGfQjOc3iFx3N+5KTve2lts86l8LtGH?=
 =?us-ascii?Q?9pArxCsSeqIT/Wp/uqO9bX11J5tgoH77eSyPS868AUDSzuh9rRsIL8Q0SNUL?=
 =?us-ascii?Q?GzYHqMOcNcKFeqDF+zPpKS9b2eqDa9VyMgHwEFUxiM+7bWspzAgmHdkaxB+9?=
 =?us-ascii?Q?G6tRgIToUJrFMqHNS0e99ewsFiZ+joko75a1dGqc7QDpax5SkdoTZJLqOaGd?=
 =?us-ascii?Q?ZKg3Rg+asDbAEsvpFPZzOStmO49qlj/FV7fOyoewQU3aLl9yg2tmnJHLbTev?=
 =?us-ascii?Q?Y9AON5F5iJMg6mRvpWVO5KdV3IW2Nt44vYrhgGueQ/TXcROysaULNKHMJPUc?=
 =?us-ascii?Q?Nu/7dnta9M8avVv4PyEPDfhIGZWTZqYNC5jY8tlI66T0vmt4mKpTJPASMcU8?=
 =?us-ascii?Q?V+TVK8vPh3H5M7UaBF43NCQE2BX+CFmmESi7wwOl2HsGlHE+nLHq04QlcUs2?=
 =?us-ascii?Q?QNZEXtLIEWVWN8+eJsVwclqd+ats9GkWDWekdryHqwuNEmsNVGXJTcBQIADC?=
 =?us-ascii?Q?fi7GV4j8rKIvDlrneIfH+iwj1ylFLtxYkQMIKY0jvsWx8mj1gIop1b6VFJK2?=
 =?us-ascii?Q?7PsP8I0FybVLK31OkFqhNsGhlAqZiD5bkG2j9xFE5otqBXcM9riiApJ4vZ3a?=
 =?us-ascii?Q?V9z7DuwjPicuFCz1byY5/uhYOZtBWYIXogpXacA+vRzdaDoqClNQl1gXPMoh?=
 =?us-ascii?Q?HCRVrZxxBatP97zWvp2hTAW9PK5U13awCp8x7zvbN+zz4EIhqDHozE6stBXx?=
 =?us-ascii?Q?3W/wmQvlOao8yKffxrfQq2pm4u0/12pxSqzrWnNe1NXJixfrka1YL7CG3zpR?=
 =?us-ascii?Q?WGYlYBsmqAplcbWgKAMl+1hthEPyijxCNB4qflFKyOJEFkPtScv3toPznmcz?=
 =?us-ascii?Q?JRonLVAEdqxj7NtibbNrlax/zqPmmTKkdY2XasrCreqD+d2voFapCQjNhz/T?=
 =?us-ascii?Q?rhBQV2nXesMuCEIdPQf3mcwrH4wEuiWerIcw1+lOyfZdzhf9eFjDfijQjZ96?=
 =?us-ascii?Q?DM422qdP0qEGhSHITjj1FsxueOM82B2Biq+ZSaJTIecMBbkUypC3dVKyqato?=
 =?us-ascii?Q?om3RTK+6xmnxbCjchKzHCpVV2yie4yUj1CE81Y0H6cAx2W1Z1wAowU9HEZQH?=
 =?us-ascii?Q?A2vZxt33yPxIYrHsXQygU7A0OZtudc9KodjVNynczltjes8sTRcoSl5OdSyS?=
 =?us-ascii?Q?smPbOwFOH3RYzKdKHLdKqdZ2ni+YSwlcTVRF?=
X-Forefront-Antispam-Report-Untrusted: CIP:172.205.89.229; CTRY:IE; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:nebula.arm.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7837
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: df3ba3de-273e-4fc4-8529-08dde633d5d3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|36860700013|7416014|82310400026|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4v/kNDANYCq1otSqk9E/jleQL2d9LH2a+YA/iBC4gh258mDxn8vRojf6onq4?=
 =?us-ascii?Q?AUKLKPOJoxanjn/e1lcT9vAvVzrUz02Pn9uDZGmh4SDefx7X0dYHUeTB6egn?=
 =?us-ascii?Q?PN3aP8Zqry1+s8jHpuaah1rq9zgtz4/XAqD2xvG9XlG7ATacfuHeDz9SQdS2?=
 =?us-ascii?Q?o+/u5Q6Q2+5fHqWDa+dBeacpFsFA5NPprC4Tv3Wh1P6zWZqFPjfdjncMGDI4?=
 =?us-ascii?Q?WOPAcqVKPliJWhjkiJEoJBJKr9IWVgVhyTw/HfTu6DIytgMQ39P0+Iq6kfKX?=
 =?us-ascii?Q?OlGCJMWgPzIo9BIULF2u2Ozm5R4JGMGCXee8SYG9m0siXNkkHc5mNLtJIycC?=
 =?us-ascii?Q?7bd/i8nM6YZNvqnQhJSBLC18V+R0STnY/brOHfWV6rRZDluC2qh/6p/o9pT6?=
 =?us-ascii?Q?0NJf4uHhza0E8XSr+t3jgfbktqcUyAzblRQWKnW+LQyNftl+Wrp+rBCp2Y2N?=
 =?us-ascii?Q?r9SgbwKocbw99bnISkqi39jyjJArxIxGbdSNaPM2vpC7iepJUv/nIr7YZ9rR?=
 =?us-ascii?Q?7Jd8nAYuU5h7dKRsecHtKTy0LXb0F4Qc1gUT1vRjXhHEETIzRp2g+SAOLowF?=
 =?us-ascii?Q?19a52+nz7gLTeIZNJSImKHVrtnU2hhHGQ1iiiDtQEDGH7Eg11w29KBl4MZfi?=
 =?us-ascii?Q?uiHKY25qnpUKznVDzNpHJqBsWVbBHG+hTROQGb6YVKdea0NcAnvzEzydcoLY?=
 =?us-ascii?Q?cSE2vk/OI46Cadd3/5kuYGJ6o8jViu0h3+ighG1mdByzGEnej1jOkKRSN3Ax?=
 =?us-ascii?Q?9zxXFyv1iG++8/N7RWJK4uPOLFeK7IF9amguyDG8pEJBeHgN2Z8928/4JJsk?=
 =?us-ascii?Q?JJCHzSrbzipKfxutd7qUqCdy64SmqFXmbuvlti6TkNiMSZz4xvMqiJhqmk8C?=
 =?us-ascii?Q?bZhbZL3IPKGGyvV1kwdLrSM2jcOv/jBseLD6slGv6nBt6tCv1gtZGfjz91Yv?=
 =?us-ascii?Q?qaR56sI51QWIR0A+ja/n4F7xecqDBhBWgMb046WLTFrraQsQWmcJw7ONSWrj?=
 =?us-ascii?Q?FvkCjdv/bMCKBeg85udKlxVOAF+Fqf441J2LQzBSKF1OktSpZxuu94Y21Su1?=
 =?us-ascii?Q?7kHod5nI4jR6+G4hU0MGf4cC7SUTpQ3cOHLZ1lzhiTE1sKtO5rAVBoyAq2B6?=
 =?us-ascii?Q?5yCm7Q+KkJIr4j3+H7Bu1aQ6+LW0ISfSSJtZwOjH24BW6ZO3mNrTIH1Hy5Wh?=
 =?us-ascii?Q?TkiZlMpoXszRqoMAE8JEESGg3B7L3EitxjfJ7VjYdsxTOOWn6ZGLgrxRqt3v?=
 =?us-ascii?Q?uig+o0SuKvhdckeHZpzS8vTqVKRoYlYsmeqlgj07vudsU0CQPZCgSlHP05ut?=
 =?us-ascii?Q?eL65YTZ54Q13ntGa2bNuslD0kF7UHe81fPZtS7vFRR/xIPHX7Yw+av48sObd?=
 =?us-ascii?Q?Z6caKYae9Haep/E/PTU0HAV+Pq35Nb2vclRn+M646JuglV/0fFmG18D7kTDi?=
 =?us-ascii?Q?am2ghOQoCPpAswS0JQmxanU3QVZTyyhVncHk7ojgByIU83/YqF//P1PLlC79?=
 =?us-ascii?Q?/niSxleSGPeu3KYfJisjuD+4T9xuKdRcTkIO?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(36860700013)(7416014)(82310400026)(1800799024)(14060799003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:07:58.7787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9c327a-934b-448e-c56c-08dde633e954
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8746
X-Mailman-Approved-At: Thu, 28 Aug 2025 16:03:14 +0200
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

This commit introduces a new standard boot method that supports booting
via semihosting as provided by ARM FVP platforms.

Semihosting enables the virtual platform to access host-side files as if
they were block devices, which is particularly useful in early boot
development and simulation environments. It removes the need for physical
storage or networking when loading kernel components.

This method mirrors the distroboot logic for semihosting, which is the
default boot method for vexpress64 platform. The load_file_from_host
helper function is implemented to mirror behaviour of "load hostfs" u-boot
command, so it similarly sets filesize environment variable after loading a
file - this is useful for later commands.

This implementation is marked with BOOTMETH_GLOBAL so it is always
considered during bootflow scan without requiring a boot device.

Signed-off-by: Said Nasibov <said.nasibov@arm.com>
---
 boot/Kconfig        |  10 ++++
 boot/Makefile       |   1 +
 boot/bootmeth_smh.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 boot/bootmeth_smh.c

diff --git a/boot/Kconfig b/boot/Kconfig
index 2ff6f003738..fbd3f068908 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -936,6 +936,16 @@ config BOOTMETH_SCRIPT
          This provides a way to try out standard boot on an existing boot =
flow.
          It is not enabled by default to save space.

+config BOOTMETH_SMH
+       bool "Bootdev support for semihosting"
+       depends on SEMIHOSTING
+       select CMD_FDT
+       select BOOTMETH_GLOBAL
+       help
+         Enables support for booting via semihosting. This bootmeth reads
+         files including the kernel, device tree and ramdisk directly from
+         the host's filesystem.
+
 config UPL
        bool "upl - Universal Payload Specification"
        imply CMD_UPL
diff --git a/boot/Makefile b/boot/Makefile
index 3da6f7a0914..5bed9e66507 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) +=3D bootmeth_san=
dbox.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT) +=3D bootmeth_script.o
 obj-$(CONFIG_$(PHASE_)CEDIT) +=3D cedit.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EFI_BOOTMGR) +=3D bootmeth_efi_mgr.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_SMH) +=3D bootmeth_smh.o

 obj-$(CONFIG_$(PHASE_)OF_LIBFDT) +=3D fdt_support.o
 obj-$(CONFIG_$(PHASE_)FDT_SIMPLEFB) +=3D fdt_simplefb.o
diff --git a/boot/bootmeth_smh.c b/boot/bootmeth_smh.c
new file mode 100644
index 00000000000..2ceb66900ed
--- /dev/null
+++ b/boot/bootmeth_smh.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Bootmethod for booting using semihosting
+ *
+ * Copyright 2025 Arm Ltd.
+ * Written by Said Nasibov <said.nasibov@arm.com>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <bootmeth.h>
+#include <dm.h>
+#include <env.h>
+#include <fs.h>
+
+static int script_check(struct udevice *dev, struct bootflow_iter *iter)
+{
+       return 0;
+}
+
+static int load_file_from_host(const char *name_var, const char *addr_var)
+{
+       const char *filename =3D env_get(name_var);
+       const char *addr_str =3D env_get(addr_var);
+       ulong addr;
+       loff_t len;
+       int ret;
+
+       /* Mount hostfs (semihosting) */
+       ret =3D fs_set_blk_dev("hostfs", NULL, FS_TYPE_ANY);
+       if (ret)
+               return log_msg_ret("hostfs", ret);
+
+       if (!filename || !addr_str)
+               return log_msg_ret("env missing", -EINVAL);
+
+       addr =3D hextoul(addr_str, NULL);
+       if (!addr)
+               return log_msg_ret("invalid addr", -EINVAL);
+
+       /* Read file into memory */
+       ret =3D fs_read(filename, addr, 0, 0, &len);
+       if (ret)
+               return log_msg_ret("fs_read", ret);
+
+       /* Set filesize environment variable in hex */
+       char size_str[32];
+       sprintf(size_str, "%lx", (unsigned long)len);
+       env_set("filesize", size_str);
+
+       return 0;
+}
+
+static int smh_read_bootflow(struct udevice *dev, struct bootflow *bflow)
+{
+       int ret;
+
+       ret =3D load_file_from_host("kernel_name", "kernel_addr_r");
+       if (ret)
+               return log_msg_ret("kernel", ret);
+
+       env_set("fdt_high", "0xffffffffffffffff");
+       env_set("initrd_high", "0xffffffffffffffff");
+
+       ret =3D load_file_from_host("fdtfile", "fdt_addr_r");
+       if (ret) {
+               ret =3D run_command("fdt move $fdtcontroladdr $fdt_addr_r;"=
, 0);
+               if (ret)
+                       return log_msg_ret("fdt move", ret);
+       }
+
+       load_file_from_host("ramdisk_name", "ramdisk_addr_r");
+
+       bflow->state =3D BOOTFLOWST_READY;
+
+       return 0;
+}
+
+static int smh_boot(struct udevice *dev, struct bootflow *bflow)
+{
+       int ret =3D run_command("booti $kernel_addr_r ${ramdisk_addr_r}:${f=
ilesize} ${fdt_addr_r};", 0);
+
+       return ret;
+}
+
+static int smh_bootmeth_bind(struct udevice *dev)
+{
+       struct bootmeth_uc_plat *plat =3D dev_get_uclass_plat(dev);
+
+       plat->desc =3D "semihosting";
+       plat->flags =3D BOOTMETHF_GLOBAL;
+
+       return 0;
+}
+
+static struct bootmeth_ops smh_bootmeth_ops =3D {
+       .check          =3D script_check,
+       .read_bootflow  =3D smh_read_bootflow,
+       .boot           =3D smh_boot,
+};
+
+static const struct udevice_id smh_bootmeth_ids[] =3D {
+       { .compatible =3D "u-boot,smh" },
+       {}
+};
+
+U_BOOT_DRIVER(bootmeth_0smh) =3D {
+       .name           =3D "bootmeth_smh",
+       .id             =3D UCLASS_BOOTMETH,
+       .of_match       =3D smh_bootmeth_ids,
+       .ops            =3D &smh_bootmeth_ops,
+       .bind       =3D &smh_bootmeth_bind,
+};
--
2.34.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
