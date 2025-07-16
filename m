Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5902BC83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916658329C;
	Wed, 16 Jul 2025 09:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="mULE15Dw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4501D82E37; Wed, 16 Jul 2025 09:09:37 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5186D83192
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1ZLsdkLbFAw3JuILyX0bgxkL+TgDT9fj2LWRjuj8/X+9bvi6xjP44suCwCYvRHBFrewnO7Rve36TB//kyue19DaIMbbLKYjuroxmcq3UrHtoVDe5ed0o4Vr9oA5VsDBcx/Z9nbHOuAQh1PpFDcg/AO4+LB6Ll/mF1hGvw0SdH5dLEgJ4ELfPKbOjkpkP9JB2Bo3GpHZvu4QzNXdSM7mayHfgc+Z9WBuhKPMooJoCMta11grQyMpWh1tywA/Np91F2jYEfHQbgsgnI+oWrPx9P3KF3c4QMWsbpy4uQlSoyeUFK8d+2kwsEEscYFEkqj2oc+U7IV5BKjRKdEy3QW/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MdOzS77KeHxgH0Ze0eKNU4Q3JDbr5hvMtjAZqwRXw4=;
 b=JoyF6IOekWPLLPK75nfDIevlVpoEfYimcAPqhM0hP349NNKoG/mH4RrJMvhoK1ZAiHWNL/52XY3dYQHTvRST8riB9luHaU6oHtvbHRmUMGhVr9uc73HSmyc2JhjUeEZCahKtATq5KIIn2BEGqbhwNkq1pFgXASKQtpn6DSGwdz6g7q/cgfm0adud8jbXmkd5PCSxc9nZrNJb3iEKz167/Qo+x7Zeyi4wEF80qo3xiGATz+pJvhCYgxlnUBbtktVAwnxico2/Re5byWHT5GddTl7BQWAFoKcM0Hdvb8+QgYfwNYwWZFSEN6m8eSnIU3YLWCrwd3dsGOPAfYo+nfr7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MdOzS77KeHxgH0Ze0eKNU4Q3JDbr5hvMtjAZqwRXw4=;
 b=mULE15DwsKwGVaPAA3SrfU5CS3WsF6pdCWqbz6V4jggOPERou/BNTs2gjrrhdoSRZoc+Y3Kylc9AIb63n1sXJlFyneI4k9sn6CSjPcnHbiU7AKabQmB+wfbaq7/C71/w82PrrA1lQQr8gDRinfizJnJLwvNcvHWbW5I81pvv61kTCcbKUAGOtCPWPBG/LVl0bOdPUx8CnTELRDWphMMFOOmfc9iWjbQOqPkfSBrMJPyQgi3IqGfhyrdVDfdozth9kPzSatPqkQSe7moOlTELMmSyqoOAsqJk1rU65aJKOWi7LCAh6hSwTcg8S1ThPglPyXHOTIu7iePE5McSH14vmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7170.namprd03.prod.outlook.com (2603:10b6:510:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:09:33 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:09:33 +0000
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
Subject: [PATCH v6 11/12] configs: sandbox_defconfig: Enable configs for
 sandbox i3c
Date: Wed, 16 Jul 2025 15:08:09 +0800
Message-Id: <20250716070810.8030-12-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250716070810.8030-1-dinesh.maniyam@altera.com>
References: <20250716070810.8030-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH7PR03MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a4b50a-3759-463a-2c8f-08ddc437b6d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EPd2WkggsMSATxpqBnXFSEl/OmZij9fXDpADZplcsOxzMtGM3ZKb/BPFUQu0?=
 =?us-ascii?Q?hv1rDat49mWIHApVWJ6TtNP060GRD0/0GmChypgKPxWpP1dqKxbCr1u0YwFI?=
 =?us-ascii?Q?ZifSG8yXHJUCqC4qGAITXdhYXpc1tKNT7/IMUq9Fc8j7dy6BLb8w5E49vBmf?=
 =?us-ascii?Q?CU844DYXmITrso0GMnlm8QhYUcbU4BmOisQ1KR+GsVect3rE4EZDd9IDLZjH?=
 =?us-ascii?Q?zl0RsY1MT6p/u/tvfkTi9w2Rl7eOHrMZWm604ct83fXUyevr322+RF+qo4bS?=
 =?us-ascii?Q?Qp7J+fFEXg7hjyOmzthUJaHnh8S5uZ9DYzdkbURxKCCs6pNJMgy5PLTsBvND?=
 =?us-ascii?Q?x5Qmoc9baFLuwJBUwrSMouYmTujkxsKeN8o8rroL7wLrBCShfJ/lj42MjISD?=
 =?us-ascii?Q?CueDx9khixUohf1WH7fdlUYQL3x9+vuI9cnpnUW098heH4zcS1Z8IKYp4vSm?=
 =?us-ascii?Q?geR2Dql8w7E7Itldo0qQmoMwzhQQUQZWIqyNsIX+epaDKM8RBYQteKCiyyQ0?=
 =?us-ascii?Q?r8jD7amzQJSZz/Q1NjMHR9H1sgUyNea7qhGRUrL1KHhG8/DiqSMM+b++u8rB?=
 =?us-ascii?Q?IzrkTdXmhxINs/j0f6Bb3sQ3XdvFwybtTbApLXWs1LeYTVAHkzlpX9tIZB0U?=
 =?us-ascii?Q?ugkaVYYVUn7m4YZGKXGooMcHLn1fCUMeAmFGx9kDkSQLmTJdajEI/HW7v7QB?=
 =?us-ascii?Q?zgdGmmWzyU32FShF1ikkdl+VAdAft9BAupOikLHZC3PeDSNv36XqK+Ib6CZa?=
 =?us-ascii?Q?e/V91f++SMfZvjvEzh8gBZ4rUJEMqVuQmn69DePhmeCWQ/YgYYQdT2ON+Gs1?=
 =?us-ascii?Q?92qYTu7zoy9wYaCMSLUvogdM8Mr1MxM0BcK8x9z4jN9BWKjMyh/xhzejimBu?=
 =?us-ascii?Q?6WJRo1JFyhLDe05mJjsNzERoOIdZeavG28z2UzsETopAykjrUsKyhmaO6hu3?=
 =?us-ascii?Q?aOpjmZn+1uk3h9TWEuY5JvrPv95fi8c7ix0azEJZpAW3juBHIKybFnDq4Ljw?=
 =?us-ascii?Q?i6ZdMXCTz/j0sNp7MBgCUWuao6BKebLQrk+A3RmOeJCk+wSeBvL23Hf+8G/o?=
 =?us-ascii?Q?11UPCKdnLgU6IrNsnSPmE//GarSXcAHLsc12GgKg1cGTx53BAdbOWnsiUXqz?=
 =?us-ascii?Q?qGQ94FI1YcJcHmXddFOOqxsgudZyV/X26osqaI9SSA0hA9fskf38YakrQ85V?=
 =?us-ascii?Q?jsB4SNiVw5Z3FSlF15+Y0TCl9+kDhp/W0zed53meYSLBEnY1NI7UmdUXNFXE?=
 =?us-ascii?Q?uIiAFfMGjI8wnbmjGyBLrshLn2hJDA7TEYiiOP61OAwJYc/GO6xgLzc1eNfx?=
 =?us-ascii?Q?zuZ1mkaQr2lcg2W29O0Qq4ZfKL9QLiBFyM0ZlblVXnQ6nomqypKr/41eHVdf?=
 =?us-ascii?Q?ipQQonIgHchpGS66reWPaIHy4531H5es73QlgXGKtORJUtOX1t0PmJmq+GMC?=
 =?us-ascii?Q?OYig7YcJjNw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Shdophuli+n9gay8cJZj55zlvKrlAnVbdHuHSobEfxQpU4NYcCviGzD1TxV6?=
 =?us-ascii?Q?IXq63HIbx5mDmfOISccLlvLHbfjVB2c38JoyhlDwDdjLjcr3FlDn+tAQeYjp?=
 =?us-ascii?Q?pNP0tUSvVBaoDWGMCo79LvKc1wzUU0ftgQWFeAtArvCRGnHNKgjHlLSU7VhK?=
 =?us-ascii?Q?F8/YputdjtVSc7HdugHxPU0O8jxVOCcFXJaWjP5fVIOckKclTFLxKzI8P8v1?=
 =?us-ascii?Q?SzOZFFlWQPOiwJt7U0JweaQ/+n6J9wGMtfqFkHtWhhlaL42gz6DXrnFOb8zq?=
 =?us-ascii?Q?2SDU2vrFuBkO+QGr0igxFEiaF8Hcs7SPDnU9FYjlwN6QOcPI0GkepSFQGhV+?=
 =?us-ascii?Q?n8wIf+C/C1sfZOTvIt6OnYmu/tj91Vyl1E49ncZGQmJQ7RUGYe5POsen9M8k?=
 =?us-ascii?Q?YaAXZrig7QGfv4Qqz7nyOCIywN30w74eHclWVH7y/3cZPzPxPgEt7sGiglbO?=
 =?us-ascii?Q?4RqBkH48Xz19Vyrc3a+FKI8cbMoWMYDknDZuJtcjyyqw67JNy2xQxvtloSPb?=
 =?us-ascii?Q?Ytc4/HJBD1G500dKnP2OUkE2oDQsZTsSjWUvcM3fW5tCUmHL3yMS7+6BDCC5?=
 =?us-ascii?Q?XQcgu4fGdbWyS4M+Q4Wv0sKlmeCxNQZuOPeskUdehqVhQft92Y3VGj5koEeR?=
 =?us-ascii?Q?NOFiwTN2Huzgd3mMZHbI/z3ALjN0j5AX9hBE1lkXeA3wpK0ZafuRZXd4S4P9?=
 =?us-ascii?Q?V+gVG0UejX+k+wzp7z7ccJ/11nXoMh2z+N7mH4QegGANyfIcp9RSLuObOXGI?=
 =?us-ascii?Q?Byot2BQSDjwh4uyeZCQP+1cyqnSg2kd95+cHJXbWyX1VRx83Dt8IznoQS7Ev?=
 =?us-ascii?Q?DERNKhIIiFNxbFh/raH5HC5GsAeWia9AijUQP5/fDcEtgMFahhA2NWyO1HYt?=
 =?us-ascii?Q?64F7cBx4ikpDAea6Avi8USzhvLVmU96KrCj3E1DkTJilqDfrVwa5nadIuymo?=
 =?us-ascii?Q?/c/ZBYLcL6lJBdbzhIKkVCd6mgjFqUpwhX9OlyifusmlU7IquzXlamxql4OP?=
 =?us-ascii?Q?NajFuBgScugw/+S+XqXmaBqLFQMFPTE//m5Vr0N3hb08BZTeUlLFpgv3Pblp?=
 =?us-ascii?Q?EW5LoSP4INy/HDGXIU2RwPWZiZufealyQrujROjM1RWfoIFPQnCJBZ7nh1Y/?=
 =?us-ascii?Q?Zmho9wawLQIteXtVDGPJtcaK3s6lJZCFLuS6qXDFMi+7EQY0wq0DgJX3W3+a?=
 =?us-ascii?Q?VV+VCEm9aDJpTxKlKycSuNG6H2GmYMQU7uf/AyZMaqdsLthsHpMJvVGcwEFv?=
 =?us-ascii?Q?pQ0nk8ea2jGTpcOkWQnWpxAuN3C95zKQmDifxbbN+dj+Hfmb17iKzxIlQ3sx?=
 =?us-ascii?Q?KFYD6vjI5Zp0t6Bfn4YhnVD6fUk9qcAz35/EfxjJtusIIXTNai3jKBkK0Wst?=
 =?us-ascii?Q?gb8Ls2sSnWfEH22YAONnf9WUyMgUH87q+eLtFKCgvKAFnGy/2xg1nB40Xs6Z?=
 =?us-ascii?Q?ZXG29OYw+yCmNiPDbcuMNw67AJ1FikinsDuSeQmEP1ThKhvbnEMjUMTfkX0O?=
 =?us-ascii?Q?WRi0Qbqm2dOKxLOI0kqNx8l4z72aqrPoRIvLTO+nggFnYwPEhEBjo88qol4e?=
 =?us-ascii?Q?seCDBiUwBpjZSGbQ3507kCEUKOcIQHEmxEwvrtomdMeHP1+wmKF/VOT61Qbg?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a4b50a-3759-463a-2c8f-08ddc437b6d5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:09:32.9456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMlDTXSuu/nai+7MzQqX5SonuANQJ07nQyO+3VUALBP/bhLRgXfz/MfXO7PALZdFfUREbzY+BFh7F9FOnYAYg8yKabNa69sK4X3PsUzLnzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7170
X-Mailman-Approved-At: Wed, 16 Jul 2025 09:18:59 +0200
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

