Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD9BC87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A4C842C7;
	Wed,  6 Aug 2025 07:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gQZR8LFV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D7DA83989; Wed,  6 Aug 2025 06:34:26 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46FD6839A1
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs+UM+f/bHRV5npI6snYNRja0q7pM0Rx+aIqHxgAnCtwC4qn3hjREAgwTXeyeuBLZ2yskN6fUehzqGEUgOQAvrk4QXdB2uzDZhjFXQcGFrRu6/U9W4zJSV7AzCcRVNgjLbOHvmrKNhsfddQSMDshiCdcTAVZoQda2fPWvCLQes9CAA9T9fKEV+EmLt1EHIAqHlreuwoHTMh7pppjzSMql3aFGhAhH/E/CtDQSJdOqRrH6/Z3haHf1XImMCfJTlfoQRpnGRuvsIknp8BMogZCbd8H5tZ9ROZNKz94bPlXxf6Wlk3XvY/xYXRONyLkoZ9f6cHNY+HTrtRMqAC+LTwhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MdOzS77KeHxgH0Ze0eKNU4Q3JDbr5hvMtjAZqwRXw4=;
 b=wJfa/Q8w8RkLmNZT3Eu23KXWAmn1+KpYsFmFNQYGSyCRjX6Wxjt2LTBHP1BeJHwsqS9RTgbXN9YIDiRVVL0mx29sp/AM1QO7yFuUbhAd5v4raAuYYyZKqt0sRHo10jgGd7ea5AmG4q2T/7hdh3Kk+zzZMGy6hXzxiEAjC8wNOvoVsmu/zNJu5e/lB7Dojz/czNs22WRAYAlfB1UjdBh93HQyTI2jA5uKYNev8+U0mXSchbP8c8/o4C78jUL5mFBoeARSB+e15bzbeN7sIkz4IDaMTyK7nDouI/xO/dIOM8URt/GnfPcaIhvvrDNzE4rS+yGxg2xxCp4/z17orvNExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MdOzS77KeHxgH0Ze0eKNU4Q3JDbr5hvMtjAZqwRXw4=;
 b=gQZR8LFVoVnCj0QMX073MpjuIm57YdQbFFVQRIaNetYMRTXRNfQtKJ8RWFUA46O53QMzk37ELhkAR6mglVgsig14dim0oKYvwO362EVlaKibj9hMNFcpn4OCuWmdlEdr7pslnsFDTL7pd4S4Puf+/7EEiRM9FrqYzqKDB27RPLnhFqq41v6OfcnRIDyh8ltRl8O39X+Wjn8gREXGsHSpsGIP2OI6BidCLWuqywRoEir9CiS2VPmqBRLPv8/6q3MXGkD/5CPJMjZqsu2noC3ztyWanl8m6CpMxcw02n6QAYRxh9F1V772Z3psmy0x66adsX2vMpUYUM25mRR/TE2EEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:34:10 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:34:10 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v8 11/12] configs: sandbox_defconfig: Enable configs for
 sandbox i3c
Date: Wed,  6 Aug 2025 12:32:34 +0800
Message-Id: <20250806043235.2260-13-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806043235.2260-1-dinesh.maniyam@altera.com>
References: <20250806043235.2260-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 7811c3ae-89d6-48e8-9a41-08ddd4a27d0c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nbw5rHS2eVtljHOZ1Zhe/YroI/L3tjTjbJ2QQHTKH/ahDJwbKTTH0xM2yLPN?=
 =?us-ascii?Q?FsIFYC5JcV5QKo9XxitukUv4NAWjPNlXHOE9BR21WdOFbABC2nGBccH542y1?=
 =?us-ascii?Q?bC7Cl99fqAGUSmKxNiuobt/5Qe2RpriOjDmWnc7KWmM17fQoujrGEHykq/0n?=
 =?us-ascii?Q?xFUwHUxKpKX22a7VB8sIAvsnhUcmmAJlVd2OR8+WLI2RSIe9+h6Y2HbZrxmG?=
 =?us-ascii?Q?FGI5TvvkZ8o5EaQvo6r6O+n44Mr9P3Bb2+jCDeSHIVPU1Hp//6Kk/5w3qDxN?=
 =?us-ascii?Q?lmzZ5WB2DRjUWcaHmcjIuVEa9lfGaj1qvx52IChuloez+gPKgQHfMO5A8epW?=
 =?us-ascii?Q?6/XIz+zrWHLGCKfJuOsJz2B5V5dFZsymhscww2mrDoIRg/BtU2x27t35v1uZ?=
 =?us-ascii?Q?G/0eHXrmFDuBG9AopRER+QTkf99O9osxeIvOn8CTrlteuonrzcacwJ28B94i?=
 =?us-ascii?Q?XizpQe3QFQXLZE7Yvum2TZYiUSUkFc3zqQgmcRPE42gRIBBpNnMBuSog4AJS?=
 =?us-ascii?Q?Hw6BNY3+q5QQPoygA7R1HTqP3UXcuZniMAXoZFj1dGzDLRQ0L90fPiVkRd8P?=
 =?us-ascii?Q?GF97kwSRYp2DRZNGElMM2wKAJ8VHz2ESn8/ve5O0jee+3nxFY2GSi8reO02v?=
 =?us-ascii?Q?GMnyz8n1d62/NsQGIcPBILY76M0ttK0PpuylpW7fUC7KOt1MaV51kdaOarls?=
 =?us-ascii?Q?nI6mKe77JIY65qTX7kr53zGrhz0YXQNc+RLEjHxylbjgKS4WN/+RxxRTdvWC?=
 =?us-ascii?Q?Bw6kPABYM6v/wMzdFRJVUPxAiKIfqEgah+LnWyw7KakdaP3ahWSxN0qq0ed/?=
 =?us-ascii?Q?qEhrzotVES9qxfZY2NEjDxS7dVcHRYtYWtn7Hh45+tX7Xk5afC5xySHRAMgo?=
 =?us-ascii?Q?2shImfteqvsruqsATfHc5IEBW07NA4Qb48aXmxmCyXkO5SfMs6mLyazU+t3I?=
 =?us-ascii?Q?zjdK4uhpXqpkoBz4ANzENC7GVsRM0547FE2CB1rs/5RSLmrZj/B71bc9ngF6?=
 =?us-ascii?Q?UH9Q+IlBN4/mfF99nd5By92TqfrTkwh3i4KnaoDXQnOVu+pXPu05YZATiaPg?=
 =?us-ascii?Q?ZzvSw3RWH1op3RpHNKZuglqoQ3w+xSudMIMPrM5vwnKx0GG/1cXSs3+Xhsuc?=
 =?us-ascii?Q?jd+U3hE1AoIw1HiMW88Z2DrwgPBbjAVYRc8fdaFwh200C6k1sgxMjavDCrMN?=
 =?us-ascii?Q?Z0KZLzTUyupEXIBE0S1Dh+Rl3e2Z5qY/hSFFh39GJReparKiQ4Nr2Co9stcE?=
 =?us-ascii?Q?jKaY0oyi61bUX+Z3zG9McJ841GpVEIFdpdcln0+RilKavya225owcnFNmWH3?=
 =?us-ascii?Q?bzIKQqK+OAptlsZjQ6hgCNvkTz2r0avB0908iNbY9tZt7tWQy8Eq6GETQaTX?=
 =?us-ascii?Q?Er25lesSZhSYz6flNdoRXtSRVe4/KnCBazZjkwa1XjU8Tto5et7YZsjI4Kjq?=
 =?us-ascii?Q?5pWIOwVzKYk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lm2U87O4MWUGa4atGU/YawvHWJiBw6D11ISMj7kBG3Hm7i/HZ4diMJviarSd?=
 =?us-ascii?Q?uhCcxtRvYV8i8fUR8EPefw2bpH/hLI73cIKqVx5Twb7/lFHJdT7OiDKrzClG?=
 =?us-ascii?Q?70Um4yOkEpPFE/h3ciUM6WZ6QYpLNFQhYiQ5awVBzhwW4OflYslrRB2+1fLu?=
 =?us-ascii?Q?B/CWDBWOq8cqAi54mjtgSBzYEpRcQmzabG6dSI0DSoYmiAxeV1YFQrHQSTcH?=
 =?us-ascii?Q?jC0boeE4Iygkm6bnpk0hmGNPlllzN3ez4R9JhsUasrCGhckuZWNbM20Kcbfj?=
 =?us-ascii?Q?VlhE/E2/M+RXCw/+s6L5kifyLuM4qMp83AyfgRxYqFEqk4FR/I8wzvezP/nG?=
 =?us-ascii?Q?I3fAeOraxzNTszTqrOpcPOz8Cnmo8xYQWvTqoVwmyj6YCIezvTkAPeNU0ObN?=
 =?us-ascii?Q?0mNS68/0vnae49Ff3qKNU7JZtZZYs7Q0n0GnoCqiXw5mSh3GQrBQ3I+DsNqR?=
 =?us-ascii?Q?kGqPOUul2ITUg+/YO+YPQ/adIQaq5sWQWiCwQvoPvY1h/+BmoZnGiSauGnuN?=
 =?us-ascii?Q?e0dycz4bt58qtrUFSS+pzlpXEV6hJmcU4d/9pNA6UdD8RlpFJqNqRrm2oCer?=
 =?us-ascii?Q?z+ssER0310rggdrxETWZ+EERBu1SypCGVYxEg8JyJyshCgNl6kzveaYBxSFI?=
 =?us-ascii?Q?QyY6iAFgsrce48ri2Ovwp+4I9lMSose7cXzijGaGT5fL6RN//qpd3V5PsCy8?=
 =?us-ascii?Q?+Qi3xK1g4wEsoNwSgNb821ywyfhYj4RVKgULVNsM2L1L15KR6td5W+nw1cuH?=
 =?us-ascii?Q?KgHBlOsXbAwfFpXFH6FlmVjs937vLaNC7ucgGXubrPD62GYPG4u/pBx1Fj9p?=
 =?us-ascii?Q?Rl4OBZjJgH0axaHPyKmcpcg4L2hL6zq0hBpMS4O4tMMRSlRMoGcLpGA0iEWz?=
 =?us-ascii?Q?I1sBj6mKAku30PZYB7PVT3WboLt0fjD6tRT7rlHoUCKFAglGHkR7ygRXpzJF?=
 =?us-ascii?Q?L3O2CLf0x4RxYOnLAwfrf2p4TjlnVW0SmNwcEj63Ehly4lncimxBb0pZThPg?=
 =?us-ascii?Q?P8cDXWayl2UcmKPDggZPPHGfi1JZ0mg/jBVJFUpqUsbbeZv2Cz/OVCPXX9SU?=
 =?us-ascii?Q?IMPAK8u52C2TeR8wpVi9eaZp1ViooPgvfnd5g9yO4qTVdzedVxZSXRjGdlur?=
 =?us-ascii?Q?ayqu+0NluPfFj5eOoCibCZkKZ9V4zgWulmMlZegNvHOSnDC7j3iv997kA5nr?=
 =?us-ascii?Q?bR8CsdceYe5FUl4NHt4gm/CjfA5RfytfYR4IkDQb0tLWQoKgzm9Ymy+tUftd?=
 =?us-ascii?Q?TaaF/hGvY7xZEJ0k0tglDz+oWndoe3oqDMnBe+jt5W41l+uu2cH6GURx8nuK?=
 =?us-ascii?Q?BAEFr+Sns8gijzCFrR4rpfXVApG69JRJq1TLD5/USZOEEfA+VMhjkYPGvdPZ?=
 =?us-ascii?Q?nBe4XiBNuERtQNmbiOKjMalXOT3y6zIck6lfba47peISqg6/TAxLmAORf4Fa?=
 =?us-ascii?Q?suAlsH7PXRhbko9sFDLOXJFFWb2qT9fprVYQ2SC9XbP2V4saa8YvIhPdxjAB?=
 =?us-ascii?Q?PcDjQWNqVEiOVyeUpzD1fh3RLJIGwyNpxJMWBKO8KKhOxj1hXQe6ZHzWCgxo?=
 =?us-ascii?Q?rIZPYiBBXRZlEnCqp9m9X/8w6VXza7JFutBvwdbA5qRB7oA40exa/3Xhj+t7?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7811c3ae-89d6-48e8-9a41-08ddd4a27d0c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:34:10.7813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zO9k7oxL8KvRJ+X/jp6Oq2AtVf3/VhlFtoizuYAs3Z5x9VqMAXb3xVCxvrzEvSyiU2Qbxio/5zy1jNCCJz+5jNjpGXtcJuvJFC44EcoXk0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable configs for sandbox i3c.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/sandbox_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 861a1f4cd90..ba98cb0ae99 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -85,6 +85,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_GPT_RENAME=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_I3C=y
 CONFIG_CMD_LOADM=y
 CONFIG_CMD_LSBLK=y
 CONFIG_CMD_MTD=y
@@ -206,6 +207,9 @@ CONFIG_I2C_CROS_EC_LDO=y
 CONFIG_DM_I2C_GPIO=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_ARB_GPIO_CHALLENGE=y
+CONFIG_I3C=y
+CONFIG_I3C_SANDBOX=y
+CONFIG_DW_I3C_MASTER=y
 CONFIG_CROS_EC_KEYB=y
 CONFIG_I8042_KEYB=y
 CONFIG_IOMMU=y
-- 
2.35.3

