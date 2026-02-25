Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694D7FD3760
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F4783F69;
	Wed, 25 Feb 2026 14:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LUGsXt7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB83283F63; Wed, 25 Feb 2026 14:24:38 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCDD883F2D
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHulUufYnl/AsH5TkTYzM2zcABXRcidv1irx3DU3doyUMBhlChXieOS4e9lzNkEHTC/dGjB+lO+8YYlTFLILfrsw9HHKMXgkKD2V2gXdVnjRPkkCmEHibCx6VF0TKvfJAHzgfpuLhvq0wxmeMggHExBiPWwE/HLvbrncndfcbcedlzVC9c+8VDFyP3vY9VP79GCqQpGTKtfriV+kQLCyIwyPTrjNCzCByYx0+/ZizcJMCzOm/OMk/BreBylI8pTzrUu2C7XuYCH+q2rZFgvwzuBEMDXP4L5F+sqUhNMwjQs9jlBAAmxSicHifuCkvJey10+nemrFlE41WAjT1EBoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWydnqC/4/LVHkrARzjKd5di4zIIYSIjuP48jpAjcBw=;
 b=G00MlwhoLFW55IVGsSt214PcPNae900UuffrJedlUiyKA79JUl8DlwytQfMgjK1v1VKH/ZXircbbCcXaLsPjplT5fMvesh9gGKLpQu27/u6DM7iF6hXkJ4+m+cJkoinHlIT3+cmcyB34Ye3C0zjn/n0kRGXd1aqP0V29KySYvXjixtpIk4Ck6QTyQ6AqgkpIIB493dp+yNTAHYDNgFmx7IYoEgMX3ctsIKh6KxCJ1N01BJmOKL2m56ty7MayjYaFyiNhH/VO1DVSfKlvvXj7N3ijLHPMPH2bME+wvLccYTKCna/3iDf+mUoBYEJBdv8Joh8nlXNhWdo4mjurDxEWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWydnqC/4/LVHkrARzjKd5di4zIIYSIjuP48jpAjcBw=;
 b=LUGsXt7cRLGy8aKh26FNWfitdzYUn95MycyKRcXYaEJbK82ACKuQv8uY7PwWTQtSf1cDmQ29VbO4M4uwc2Bwwytg9MQcp2s5XRAUjruQAZhgmNOZJ7mQg8lRAY149BLHCFcFdGcVHFUqV65L3qpo12d1uzHKk0E0VDTwzxoF3bi+Rlh8A+JOZ9aiKgiGBtxhvIi6wvuxK++spABhGY628WX5zXd2QYPPzZpi6Bjz1tovJEQKhA9lxdDX7bRy4n98MMv+HPAmeghtHzLtEZwfeQiZCuaRuKczLk3HYC7ejKL07JAGnro0i7Iz0riMIhwFmlaKuJ4lvDCX6NVcOLyf9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8863.eurprd04.prod.outlook.com (2603:10a6:102:20e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 12:48:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:48:03 +0000
Date: Wed, 25 Feb 2026 22:03:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Marek Vasut <marex@denx.de>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Anis Chali <chalianis1@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Ye Li <ye.li@nxp.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 3/4] scmi: pinctrl: add pinctrl driver for SCMI
Message-ID: <aZ8BITY4Cag1tyas@nxa18884-linux.ap.freescale.net>
References: <cover.1771856828.git.dan.carpenter@linaro.org>
 <a9f8de77176cf0b8afa2f1addd0183f52da9d00c.1771856828.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9f8de77176cf0b8afa2f1addd0183f52da9d00c.1771856828.git.dan.carpenter@linaro.org>
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0e34e3-6201-4a1e-a260-08de746c1d0c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: SuJVWb5kFulkk0lhA0tpsQkQbv+biq0vX7rkbINEFq46+z1zRG3ET2KSVPX4YI6q6A3qeWIRi9inSUleeJAmWyJSAeXfa+aW+veoguKkVlssaSQBus3Blyugi3BnAKobV1wAhfcIhDAbVU8AlzaxcTCRONrA80VXgc46afqYFuTEPsZgurQEIna/AMMkzwf23NC5hlRHEJtqBcddX/w2HghUmU53Aax4n6KLcZdWI7LsGyoizDLu1O6NnP4HTRIa3GFCGHfm26RsJrLTjqvdzyaoIhVSBMMU3gcKPy7OlNfWfJ2akf7WF74k++sAfqd5jCSra17FeUziJ5tZKyXaOScOhDYamvsYMsAO8olcTgqFmGWTE2WvUVXdU4KYrYQJsO37OhGtUW7HVmE8I2jtlBW9Eprax49vG1lo2IGgvveY8Xq3ZDODy11w44ur/fPhQH84xT9BZkMNyAPR6rKCoS8lic8VuDe8+pvSZS0DEQRNy6buxc8gwJZ2/OIz/HwE9LnQ3OyKLwmuNG9KCxkVCf4ofSKtfYhN5KINHaBvO5dwPysQjrOfWlggi7NsIGRzq4ygXkN34i/AYDd2mU/MZiWf9UzPrrlhl/iK9nGlwydKp6ITP0voOtmaOAhZKMuEwglhs5O+5Ha00c2Qdaw4YZ/zGo/yEmoimEcLSewk1Bk1zM3E1fVRRJ9ljJWtw/fp4O0kysyD2FU+1GfLmtAUja9w8y0j9tNttFV8wE/wnJ6+9yK8mkYwTPeI/Dz+fymd7x3yjYOsQvjdZ1YoMBLh8/VoTVPEMTyqyforIbxuv4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rWzVnBYLLKnzt98ZjfOZ0KWC0YlUZ5CQ/a9+F7Hbo81B7+TGpQme6r+Dat1b?=
 =?us-ascii?Q?oejOjW+tu/aRyDhjXEim+H/CHykOfgHnyDJBOJJruEu4FHMKxTTHNYY0ss0O?=
 =?us-ascii?Q?NhDstu/A/FT5v4rdnKE8eMdSphCkQL5qFdGsxtSv25/mJ94XTZKIlME48zlz?=
 =?us-ascii?Q?tMMX+hLIKFvojwv9epA5mUQ0FO4KCqfsRFpgoLHJpP6oQt1ryuSJ0ZMKN6eI?=
 =?us-ascii?Q?9jqjdUr7JVKLNpMes3woPIiD6FzA4+lZATWCKgtrfZKD8RNsFJCV39yD7tZp?=
 =?us-ascii?Q?u4fwnxBc55QjLGoRsR/zbxp9RBc8/3x4ng+QtAICQDA6wU/13osIJei8FSdv?=
 =?us-ascii?Q?w0QKktRDaKs9vlDPjxGruv58mR14Hzouf3UpFwVbD3FNw0n0zJDk0pzechcI?=
 =?us-ascii?Q?lFKYvBVsdarmQMu2fHcuMqi7HuA8vRJsI+IE01Cq9xzE7x2RDIqsnCap5sNL?=
 =?us-ascii?Q?3XcSGJcM/pXQ9ztmZngzcWAgokiWO3SP2mz88pmic5x9ZNuL0DcMn3TBHwIS?=
 =?us-ascii?Q?RMuOXc6+j+92/yTjSxow92tB571602vNS/ThKmU8w+l7QJfQMlff1qE51j6B?=
 =?us-ascii?Q?LRwnBjqIwcAVygVDO86fDD3nSEorYNB/8ITvfGO+8JW52VezoXurPNpYWZQG?=
 =?us-ascii?Q?YmE72E4pMvBoDnQYEnPM59m+qlOAl+ZosI7JFRkyHylK1d4aDnDaSEg7tnmN?=
 =?us-ascii?Q?0DCfu3u0pIsLXxi9anxDs1ss5hB6RLfQiFrLDvYcrwQqRLJCI4alnOu89ICu?=
 =?us-ascii?Q?GB4ZODaPOAY5rUebSQGrvarJBKSrYdCys6MecV53OHik/YIv2EbICv22i3eh?=
 =?us-ascii?Q?lPALNa4b9xOIIN2qIe9TlkIj2hGKKNkXEBSxyzRC0qTxJZ4oCHKwjTpePxWN?=
 =?us-ascii?Q?axtedSDEbtzymad20UfV6/xu5BBsE17mJoW5ehFllDSkKFQslSkzevBgOUZr?=
 =?us-ascii?Q?o92omFO/uZ59Rc5terl7YvZ0J3eoGF1W2PhFoCx3z2ACgvRUsMqIAi1WMstk?=
 =?us-ascii?Q?Cxx3xB0eMrdgPKBAWhNmrdcHztXexbgXAzP9GxcttrM4NVg/AUJQYyFnBz4R?=
 =?us-ascii?Q?FSuSjpZZ4QlwY1wRMZC6pWNG+nNf08nCnYrhZ/QRykLQcDrfBO4d09Qk6f5F?=
 =?us-ascii?Q?fxkhaWUAR6Jiy/X7NXBfdamiBsIetYzRiq9hNXuqZBzqRanMwbcMtXBEqySQ?=
 =?us-ascii?Q?+NVS07brblq9d7Cr8fc5Lfiu/l8mHLodICtMsskhviJtB5Ql5+qqMD0Kx6Cq?=
 =?us-ascii?Q?sdmAMXvvB2v0WocLIlvnoBb4pNwtOuamTZPwsc+4C3V6X09SuNpo9Rqr+qb6?=
 =?us-ascii?Q?155G83OmNUEiQRpfCbLRym0Rr5Pz4RK51KAonk3PwTtyo8sJVHFQTlF+Rl6+?=
 =?us-ascii?Q?6O4DWy8Cy2PhGlFFUbismZDU+GfXfYARN/UYUVdgeghj/GV8gKD39cgX2O92?=
 =?us-ascii?Q?qUoXgsB6Y4aNt8Z+qtVfwglDl/J91Pp2Hkgcu24s26ozIVnYWQ2aR56JMSvH?=
 =?us-ascii?Q?wyyU4ShGcoUAvv6cUgCVLpag4+BkPb96JHG2aNbamu3/4HspH6G2OYx70zEH?=
 =?us-ascii?Q?tMRsuxHQtFwHIfbO06HgR2r9FcTATgmj1owoafRBJGBA0YgpG7Yr/bEZ6Lwo?=
 =?us-ascii?Q?dfAm2WlTaCPc4JNme7y3orrtQmbaKpIv9ryQg3FNuSgrkwKvOV8y+V3zKD/9?=
 =?us-ascii?Q?euNK/WRU9Yg3mXgZL/q4YLa83RJwMJ3Ks8KUkD8attjSmCQ3atoZIdDVc34U?=
 =?us-ascii?Q?1h7PNVG06Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0e34e3-6201-4a1e-a260-08de746c1d0c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:48:03.1085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjyIOlLn8m0POPPFtPB56SfVubBFroJEPQkyU3QNAbr9FgPKdMcUzF8rPdqutr7dQ5vLzJyUFtiwXRmQaIkCng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8863
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

Hi Dan,

Thanks for your patch!

On Mon, Feb 23, 2026 at 05:33:35PM +0300, Dan Carpenter wrote:
>This driver adds the base support of pinctrl over SCMI.  The driver
>does two main things.  First it allows you to configure the initial
>pin states.  And second it's used a base to build a GPIO driver on
>top of it.
>
>To configure the states then add a pinmux config to the scmi_pinctrl
>section:
>
>                        scmi_pinctrl: protocol@19 {
>                                reg = <0x19>;
>                                pinmux1: pinmux_test {
>                                        pinmux = <0 1 0xFFFFFFFF 18 1
>                                                  0 2 0xFFFFFFFF 18 0
>                                                  0 3 0xFFFFFFFF 18 1>;
>                                };
>                        };
>
>The numbers are from PINCTRL_SETTINGS_CONFIGURE: selector, identifier,
>function_id, config_type, and config_value.
>
>Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>---
> drivers/firmware/scmi/Makefile            |   1 +
> drivers/firmware/scmi/pinctrl.c           | 363 ++++++++++++++++++++++
> drivers/firmware/scmi/scmi_agent-uclass.c |   4 +-
> drivers/pinctrl/Kconfig                   |   9 +
> drivers/pinctrl/Makefile                  |   1 +
> drivers/pinctrl/pinctrl-scmi.c            | 357 +++++++++++++++++++++
> include/scmi_agent-uclass.h               |   2 +-
> include/scmi_protocols.h                  | 356 +++++++++++++++++++++
> 8 files changed, 1090 insertions(+), 3 deletions(-)
> create mode 100644 drivers/firmware/scmi/pinctrl.c
> create mode 100644 drivers/pinctrl/pinctrl-scmi.c
>
>diff --git a/drivers/firmware/scmi/Makefile b/drivers/firmware/scmi/Makefile
>index 6129726f8173..761d89a11615 100644
>--- a/drivers/firmware/scmi/Makefile
>+++ b/drivers/firmware/scmi/Makefile
>@@ -5,5 +5,6 @@ obj-$(CONFIG_SCMI_AGENT_SMCCC)		+= smccc_agent.o
> obj-$(CONFIG_SCMI_AGENT_MAILBOX)	+= mailbox_agent.o
> obj-$(CONFIG_SCMI_AGENT_OPTEE)	+= optee_agent.o
> obj-$(CONFIG_SCMI_POWER_DOMAIN)		+= pwdom.o
>+obj-$(CONFIG_PINCTRL_SCMI)		+= pinctrl.o
> obj-$(CONFIG_SANDBOX)		+= sandbox-scmi_agent.o sandbox-scmi_devices.o
> obj-y += vendors/imx/
>diff --git a/drivers/firmware/scmi/pinctrl.c b/drivers/firmware/scmi/pinctrl.c
>new file mode 100644
>index 000000000000..981bf64cd74b
>--- /dev/null
>+++ b/drivers/firmware/scmi/pinctrl.c
>@@ -0,0 +1,363 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * Copyright 2026 Linaro Ltd.
>+ */
>+
[...]
>+
>+int scmi_pinctrl_protocol_attrs(struct udevice *dev, int *num_pins,
>+				int *num_groups, int *num_functions)
>+{
>+	struct scmi_pinctrl_protocol_attrs_out out;
>+	struct scmi_msg msg = {
>+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
>+		.message_id = SCMI_PROTOCOL_ATTRIBUTES,
>+		.out_msg = (u8 *)&out,
>+		.out_msg_sz = sizeof(out),
>+	};
>+	int ret;
>+
>+	ret = devm_scmi_process_msg(dev, &msg);
>+	if (ret)
>+		return ret;
>+	if (out.status)
>+		return scmi_to_linux_errno(out.status);
>+
>+	*num_groups = FIELD_GET(GENMASK(31, 16), out.attr_low);
>+	*num_pins = FIELD_GET(GENMASK(15, 0), out.attr_low);
>+	*num_functions = FIELD_GET(GENMASK(15, 0), out.attr_high);

	if (num_groups)
		*num_groups = FIELD_GET(GENMASK(31, 16), out.attr_low);
	if (num_pins)
		*num_pins = FIELD_GET(GENMASK(15, 0), out.attr_low);
	if (num_functions)
		*num_functions = FIELD_GET(GENMASK(15, 0), out.attr_high);
>+
>+	return 0;
>+}
>+
>+int scmi_pinctrl_attrs(struct udevice *dev, enum select_type select_type,
>+		       unsigned int selector, bool *gpio, unsigned int *count,
>+		       char *name)
>+{
>+	struct scmi_pinctrl_attrs_in in;
>+	struct scmi_pinctrl_attrs_out out;
>+	struct scmi_msg msg = {
>+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
>+		.message_id = SCMI_PINCTRL_ATTRIBUTES,
>+		.in_msg = (u8 *)&in,
>+		.in_msg_sz = sizeof(in),
>+		.out_msg = (u8 *)&out,
>+		.out_msg_sz = sizeof(out),
>+	};
>+	int ret;
>+
>+	in.select_type = select_type;
>+	in.id = selector;
>+
>+	ret = devm_scmi_process_msg(dev, &msg);
>+	if (ret)
>+		return ret;
>+	if (out.status)
>+		return scmi_to_linux_errno(out.status);
>+
>+	//estended_name = FIELD_GET(BIT(31), out.attr);

Drop this?

>+	if (gpio)
>+		*gpio = FIELD_GET(BIT(17), out.attr);
>+	//pin_only = FIELD_GET(BIT(16), out.attr);

Ditto.

>+	if (count)
>+		*count = FIELD_GET(GENMASK(15, 0), out.attr);
>+	memcpy(name, out.name, sizeof(out.name));

memcpy will always copy whole the name array, so use strncpy?

>+
>+	return 0;
>+}
>+
>+int scmi_pinctrl_list_associations(struct udevice *dev,
>+				   enum select_type select_type,
>+				   unsigned int selector,
>+				   unsigned short *output,
>+				   unsigned short num_out)
>+{
>+	struct scmi_pinctrl_list_associations_in in;
>+	struct scmi_pinctrl_list_associations_out *out;
>+	struct scmi_msg msg = {
>+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
>+		.message_id = SCMI_PINCTRL_LIST_ASSOCIATIONS,
>+		.in_msg = (u8 *)&in,
>+		.in_msg_sz = sizeof(in),
>+	};
>+	size_t out_sz = sizeof(*out) + num_out * sizeof(out->array[0]);
>+	unsigned int count;
>+	int ret = -EINVAL;
>+
>+	out = kzalloc(out_sz, GFP_KERNEL);
>+	if (!out)
>+		return -ENOMEM;
>+
>+	msg.out_msg = (u8 *)out;
>+	msg.out_msg_sz = out_sz;
>+	in.select_type = select_type;
>+	in.id = selector;
>+	in.index = 0;
>+
>+	while (num_out > 0) {
>+		ret = devm_scmi_process_msg(dev, &msg);
>+		if (ret)
>+			goto free;
>+		if (out->status) {
>+			ret = scmi_to_linux_errno(out->status);
>+			goto free;
>+		}
>+
>+		count = FIELD_GET(GENMASK(11, 0), out->flags);
>+		if (count > num_out)
>+			return -EINVAL;
>+		memcpy(&output[in.index], out->array, count * sizeof(u16));
>+		num_out -= count;
>+		in.index += count;
>+	}
>+free:
>+	kfree(out);
>+	return ret;
>+}
>+
>+#define SCMI_PINCTRL_CONFIG_SETTINGS_FUNCTION -2u

I see spec is using 2, not understand well -2u here.
When set to 2, no configuration values need to be returned.
The command only returns the function selected for the pin or the group.

>+
>+int scmi_pinctrl_settings_get_one(struct udevice *dev, enum select_type select_type,
>+				  unsigned int selector,
>+				  u32 config_type, u32 *value)
>+{
>+	struct scmi_pinctrl_settings_get_in in;
>+	struct scmi_pinctrl_settings_get_out *out;
>+	struct scmi_msg msg = {
>+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
>+		.message_id = SCMI_PINCTRL_SETTINGS_GET,
>+		.in_msg = (u8 *)&in,
>+		.in_msg_sz = sizeof(in),
>+	};
>+	size_t out_sz = sizeof(*out) + (1 * sizeof(u32) * 2);

	size_t out_sz = sizeof(*out) + (sizeof(u32) * 2);

>+	u32 num_configs;
>+	int ret;

Move below sanity check code here.
	if (config_type == SCMI_PINCTRL_CONFIG_SETTINGS_ALL) {
		/* FIXME: implement */
		return -EIO;
	}
>+
>+	out = kzalloc(out_sz, GFP_KERNEL);
>+	if (!out)
>+		return -ENOMEM;
>+
>+	msg.out_msg = (u8 *)out;
>+	msg.out_msg_sz = out_sz;
>+	in.id = selector;
>+	in.attr = 0;
>+	if (config_type == SCMI_PINCTRL_CONFIG_SETTINGS_FUNCTION)
>+		in.attr = FIELD_PREP(GENMASK(19, 18), 2);
>+	in.attr |= FIELD_PREP(GENMASK(17, 16), select_type);
>+	if (config_type != SCMI_PINCTRL_CONFIG_SETTINGS_FUNCTION)
>+		in.attr |= FIELD_PREP(GENMASK(7, 0), config_type);
>+
>+	if (config_type == SCMI_PINCTRL_CONFIG_SETTINGS_ALL) {
>+		/* FIXME: implement */
>+		return -EIO;
>+	}
>+
>+	ret = devm_scmi_process_msg(dev, &msg);
>+	if (ret)
>+		goto free;
>+	if (out->status) {
>+		ret = scmi_to_linux_errno(out->status);
>+		goto free;
>+	}
>+	num_configs = FIELD_GET(GENMASK(7, 0), out->num_configs);
>+	if (out->num_configs == 0) {
>+		*value = out->function_selected;
>+		goto free;
>+	}
>+	if (num_configs != 1) {
>+		ret = -EINVAL;
>+		goto free;
>+	}
>+
>+	*value = out->configs[1];
>+free:
>+	kfree(out);
>+	return ret;
>+}
>+
>+static int scmi_pinctrl_settings_configure_helper(struct udevice *dev,
>+						  enum select_type select_type,
>+						  unsigned int selector,
>+						  u32 function_id,
>+						  u16 num_configs, u32 *configs)
>+{
>+	struct scmi_pinctrl_settings_configure_in *in;
>+	struct scmi_pinctrl_settings_configure_out out;
>+	struct scmi_msg msg = {
>+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
>+		.message_id = SCMI_PINCTRL_SETTINGS_CONFIGURE,
>+		.out_msg = (u8 *)&out,
>+		.out_msg_sz = sizeof(out),
>+	};
>+	size_t in_sz = sizeof(*in) + (num_configs * sizeof(u32) * 2);
>+	int ret;
>+
>+	in = kzalloc(in_sz, GFP_KERNEL);
>+	if (!in)
>+		return -ENOMEM;
>+
>+	msg.in_msg = (u8 *)in;
>+	msg.in_msg_sz = in_sz;
>+	in->id = selector;
>+	in->function_id = function_id;
>+	in->attr = 0;
>+	in->attr |= FIELD_PREP(GENMASK(9, 2), num_configs);
>+	in->attr |= FIELD_PREP(GENMASK(1, 0), select_type);
>+	memcpy(in->configs, configs, num_configs * sizeof(32) * 2);

sizeof(u32)

>+
>+	ret = devm_scmi_process_msg(dev, &msg);
>+	if (ret)
>+		goto free;
>+	if (out.status) {
>+		ret = scmi_to_linux_errno(out.status);
>+		goto free;
>+	}
>+free:
>+	kfree(in);
>+	return ret;
>+}
>+
>+int scmi_pinctrl_settings_configure(struct udevice *dev, enum select_type select_type,
>+				    unsigned int selector, u16 num_configs,
>+				    u32 *configs)
>+{
>+	return scmi_pinctrl_settings_configure_helper(dev, select_type,
>+						      selector,
>+						      SCMI_PINCTRL_FUNCTION_NONE,
>+						      num_configs, configs);
>+}
>+
>+int scmi_pinctrl_settings_configure_one(struct udevice *dev, enum select_type select_type,
>+					unsigned int selector,
>+					u32 param, u32 argument)
>+{
>+	u32 config_value[2];
>+	int scmi_config;
>+
>+	/* see stmfx_pinctrl_conf_set() */
>+	scmi_config = map_config_param_to_scmi(param);
>+	if (scmi_config < 0)
>+		return scmi_config;
>+
>+	config_value[0] = scmi_config;
>+	config_value[1] = argument;
>+
>+	return scmi_pinctrl_settings_configure(dev, select_type, selector, 1,
>+					       &config_value[0]);
>+}
>+
>+int scmi_pinctrl_set_function(struct udevice *dev, enum select_type select_type,
>+			      unsigned int selector, u32 function_id)
>+{
>+	return scmi_pinctrl_settings_configure_helper(dev, select_type, selector,
>+						      function_id, 0, NULL);
>+}
>+
>+int scmi_pinctrl_request(struct udevice *dev, enum select_type select_type,
>+			 unsigned int selector)
>+{
>+	struct scmi_pinctrl_request_in in;
>+	struct scmi_pinctrl_request_out out;
>+	struct scmi_msg msg = {
>+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
>+		.message_id = SCMI_PINCTRL_REQUEST,
>+		.in_msg = (u8 *)&in,
>+		.in_msg_sz = sizeof(in),
>+		.out_msg = (u8 *)&out,
>+		.out_msg_sz = sizeof(out),
>+	};
>+	int ret;
>+
>+	in.id = selector;
>+	in.flags = FIELD_PREP(GENMASK(1, 0), select_type);
>+
>+	ret = devm_scmi_process_msg(dev, &msg);
>+	if (ret)
>+		return ret;
>+	if (out.status)
>+		return scmi_to_linux_errno(out.status);
>+
>+	return 0;
>+}
>+
>+int scmi_pinctrl_release(struct udevice *dev, enum select_type select_type,
>+			 unsigned int selector)
>+{
>+	struct scmi_pinctrl_release_in in;
>+	struct scmi_pinctrl_release_out out;
>+	struct scmi_msg msg = {
>+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
>+		.message_id = SCMI_PINCTRL_RELEASE,
>+		.in_msg = (u8 *)&in,
>+		.in_msg_sz = sizeof(in),
>+		.out_msg = (u8 *)&out,
>+		.out_msg_sz = sizeof(out),
>+	};
>+	int ret;
>+
>+	in.id = selector;
>+	in.flags = FIELD_PREP(GENMASK(1, 0), select_type);
>+
>+	ret = devm_scmi_process_msg(dev, &msg);
>+	if (ret)
>+		return ret;
>+	if (out.status)
>+		return scmi_to_linux_errno(out.status);
>+
>+	return 0;
>+}
>+
>diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
>index ad825d66da2d..cd458a7f4588 100644
>--- a/drivers/firmware/scmi/scmi_agent-uclass.c
>+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
>@@ -106,7 +106,7 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
> 		proto = priv->voltagedom_dev;
> 		break;
> #endif
>-#if IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
>+#if IS_ENABLED(CONFIG_PINCTRL_SCMI) || IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
> 	case SCMI_PROTOCOL_ID_PINCTRL:
> 		proto = priv->pinctrl_dev;
> 		break;
>@@ -179,7 +179,7 @@ static int scmi_add_protocol(struct udevice *dev,
> 		priv->voltagedom_dev = proto;
> 		break;
> #endif
>-#if IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
>+#if IS_ENABLED(CONFIG_PINCTRL_SCMI) || IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
> 	case SCMI_PROTOCOL_ID_PINCTRL:
> 		priv->pinctrl_dev = proto;
> 		break;
>diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
>index ea90713ec6ca..512c396880c4 100644
>--- a/drivers/pinctrl/Kconfig
>+++ b/drivers/pinctrl/Kconfig
>@@ -291,6 +291,15 @@ config PINCTRL_SANDBOX
> 	  Currently, this driver actually does nothing but print debug
> 	  messages when pinctrl operations are invoked.
> 
>+config PINCTRL_SCMI
>+	bool "Support SCMI pin controllers"
>+	depends on PINCTRL_FULL && SCMI_FIRMWARE
>+	help
>+	  This is for pinctrl over the SCMI protocol.  This allows the
>+	  initial pin configuration to be set up from the device tree.  The
>+	  gpio_scmi driver is built on top of this driver if GPIO is
>+	  required.
>+
> config PINCTRL_SINGLE
> 	bool "Single register pin-control and pin-multiplex driver"
> 	depends on DM
>diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
>index 33ff7b95ef22..8ab163531821 100644
>--- a/drivers/pinctrl/Makefile
>+++ b/drivers/pinctrl/Makefile
>@@ -29,6 +29,7 @@ obj-$(CONFIG_PINCTRL_MSCC)	+= mscc/
> obj-$(CONFIG_ARCH_MVEBU)	+= mvebu/
> obj-$(CONFIG_ARCH_NEXELL)	+= nexell/
> obj-$(CONFIG_PINCTRL_QE)	+= pinctrl-qe-io.o
>+obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
> obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
> obj-$(CONFIG_PINCTRL_STI)	+= pinctrl-sti.o
> obj-$(CONFIG_PINCTRL_STM32)	+= pinctrl_stm32.o
>diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
>new file mode 100644
>index 000000000000..32594489178a
>--- /dev/null
>+++ b/drivers/pinctrl/pinctrl-scmi.c
>@@ -0,0 +1,357 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * Copyright 2026 Linaro Ltd.
>+ */
>+
>+#include <dm.h>
>+#include <dm/device_compat.h>
>+#include <dm/devres.h>
>+#include <dm/pinctrl.h>
>+#include <scmi_agent.h>
>+#include <scmi_agent-uclass.h>
>+#include <scmi_protocols.h>
>+
>+static const struct pinconf_param pinctrl_scmi_conf_params[] = {
>+	{ "bias-bus-hold", PIN_CONFIG_BIAS_BUS_HOLD, 0},
>+	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
>+	{ "bias-high-impedance", PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0 },
>+	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 0 },
>+	{ "bias-pull-pin-default", PIN_CONFIG_BIAS_PULL_PIN_DEFAULT, 0 },
>+	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 0 },
>+	{ "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
>+	{ "drive-open-source", PIN_CONFIG_DRIVE_OPEN_SOURCE, 0 },
>+	{ "drive-push-pull", PIN_CONFIG_DRIVE_PUSH_PULL, 0 },
>+	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 0 },
>+	{ "input-debounce", PIN_CONFIG_INPUT_DEBOUNCE, 0 },
>+	{ "input-enable", PIN_CONFIG_INPUT_ENABLE, 1 },
>+	{ "input-schmitt", PIN_CONFIG_INPUT_SCHMITT, 0 },
>+	{ "low-power-mode", PIN_CONFIG_LOW_POWER_MODE, 0 },
>+	{ "output-mode", PIN_CONFIG_OUTPUT_ENABLE, 0 },
>+	{ "output-value", PIN_CONFIG_OUTPUT, 0 },
>+	{ "power-source", PIN_CONFIG_POWER_SOURCE, 0 },
>+	{ "slew-rate", PIN_CONFIG_SLEW_RATE, 0 },
>+	/* The SCMI spec also include "default", "pull-mode" and "input-value */
>+};
>+
>+static bool valid_selector(struct udevice *dev, enum select_type select_type, u32 selector)
>+{
>+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
>+
>+	if (select_type == SCMI_PIN)
>+		return selector < priv->num_pins;
>+	if (select_type == SCMI_GROUP)
>+		return selector < priv->num_groups;
>+	if (select_type == SCMI_FUNCTION)
>+		return selector < priv->num_functions;
>+
>+	return false;
>+}
>+
>+static int pinctrl_scmi_get_pins_count(struct udevice *dev)
>+{
>+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
>+
>+	return priv->num_pins;
>+}
>+
>+static int pinctrl_scmi_get_groups_count(struct udevice *dev)
>+{
>+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
>+
>+	return priv->num_groups;
>+}
>+
>+static int pinctrl_scmi_get_functions_count(struct udevice *dev)
>+{
>+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
>+
>+	return priv->num_functions;
>+}
>+
>+static const char *pinctrl_scmi_get_pin_name(struct udevice *dev, unsigned int selector)
>+{
>+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
>+
>+	if (selector >= priv->num_pins)
>+		return NULL;
>+
>+	return (const char *)priv->pin_info[selector].name;
>+}
>+
>+static const char *pinctrl_scmi_get_group_name(struct udevice *dev, unsigned int selector)
>+{
>+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
>+
>+	if (selector >= priv->num_groups)
>+		return NULL;
>+
>+	return (const char *)priv->group_info[selector].name;
>+}
>+
>+static const char *pinctrl_scmi_get_function_name(struct udevice *dev, unsigned int selector)
>+{
>+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
>+
>+	if (selector >= priv->num_functions)
>+		return NULL;
>+
>+	return (const char *)priv->function_info[selector].name;
>+}
>+
>+static int pinctrl_scmi_pinmux_set(struct udevice *dev, u32 pin, u32 function)
>+{
>+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
>+
>+	if (pin >= priv->num_pins || function >= priv->num_functions)
>+		return -EINVAL;
>+
>+	return scmi_pinctrl_set_function(dev, SCMI_PIN, pin, function);
>+}
>+
>+static int pinctrl_scmi_pinmux_group_set(struct udevice *dev, u32 group, u32 function)
>+{
>+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
>+
>+	if (group >= priv->num_groups || function >= priv->num_functions)
>+		return -EINVAL;
>+
>+	return scmi_pinctrl_set_function(dev, SCMI_GROUP, group, function);
>+}
>+
>+static int pinctrl_scmi_set_state(struct udevice *dev, struct udevice *config)
>+{
>+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
>+	const int batch_count = 20;

An comment is welcomed on the batch_count set to 20.

>+	u32 prev_type = -1u;
>+	u32 prev_selector;
>+	u32 *configs;
>+	const u32 *prop;
>+	int offset, cnt, len;
>+	int ret = 0;
>+
>+	prop = dev_read_prop(config, "pinmux", &len);
>+	if (!prop)
>+		return 0;
>+
>+	if (len % sizeof(u32) * 5) {
>+		dev_err(dev, "invalid pin configuration: len=%d\n", len);
>+		return -FDT_ERR_BADSTRUCTURE;
>+	}
>+
>+	configs = kcalloc(batch_count, sizeof(u32), GFP_KERNEL);
>+	if (!configs)
>+		return -ENOMEM;
>+
>+	offset = 0;
>+	cnt = 0;
>+	while (offset + 4 < len / sizeof(u32)) {
>+		u32 select_type  = fdt32_to_cpu(prop[offset]);
>+		u32 selector     = fdt32_to_cpu(prop[offset + 1]);
>+		u32 function     = fdt32_to_cpu(prop[offset + 2]);
>+		u32 config_type  = fdt32_to_cpu(prop[offset + 3]);
>+		u32 config_value = fdt32_to_cpu(prop[offset + 4]);
>+
>+		if (select_type > SCMI_GROUP ||
>+		    !valid_selector(dev, select_type, selector) ||
>+		    (function != SCMI_PINCTRL_FUNCTION_NONE &&
>+		     function > priv->num_functions)) {
>+			dev_err(dev, "invalid pinctrl data (%u %u %u %u %u)\n",
>+				select_type, selector, function, config_type,
>+				config_value);
>+			ret = -EINVAL;
>+			goto free;
>+		}
>+
>+		if (function != SCMI_PINCTRL_FUNCTION_NONE) {
>+			if (cnt) {
>+				scmi_pinctrl_settings_configure(dev, prev_type, prev_selector,
>+								cnt / 2, configs);

Check return value.

>+				prev_type = -1u;
>+				cnt = 0;
>+			}
>+			scmi_pinctrl_set_function(dev, select_type, selector, function);

Ditto.

>+			offset += 5;
>+			continue;
>+		}
>+
>+		if (cnt == batch_count)
>+			goto set;
>+
>+		if (prev_type == -1u)
>+			goto store;
>+
>+		if (select_type == prev_type &&
>+		    selector == prev_selector)

Use one line.

>+			goto store;
>+set:
>+		scmi_pinctrl_settings_configure(dev, prev_type, prev_selector,
>+						cnt / 2, configs);

return value check.

>+		cnt = 0;
>+store:
>+		prev_type = select_type;
>+		prev_selector = selector;
>+		configs[cnt++] = config_type;
>+		configs[cnt++] = config_value;
>+		offset += 5;
>+	}
>+
>+	if (cnt)
>+		scmi_pinctrl_settings_configure(dev, prev_type, prev_selector,
>+						cnt / 2, configs);

return value check.

>+free:
>+	kfree(configs);
>+
>+	return ret;
>+}
>+
>+static int get_pin_muxing(struct udevice *dev, unsigned int selector,
>+			  char *buf, int size)
>+{
>+	u32 value;
>+	int ret;
>+
>+	ret = scmi_pinctrl_settings_get_one(dev, SCMI_PIN, selector,
>+					    SCMI_PIN_INPUT_VALUE, &value);
>+	if (ret) {
>+		dev_err(dev, "settings_get() failed: %d\n", ret);
>+		return ret;
>+	}
>+
>+	snprintf(buf, size, "%d", value);
>+	return 0;
>+}
>+
>+static int pinctrl_scmi_pinconf_set(struct udevice *dev, u32 pin, u32 param, u32 argument)
>+{
>+	return scmi_pinctrl_settings_configure_one(dev, SCMI_PIN, pin, param, argument);
>+}
>+
>+static int pinctrl_scmi_pinconf_group_set(struct udevice *dev, u32 group, u32 param, u32 argument)
>+{
>+	return scmi_pinctrl_settings_configure_one(dev, SCMI_GROUP, group, param, argument);
>+}
>+
>+static struct pinctrl_ops scmi_pinctrl_ops = {
>+	.get_pins_count = pinctrl_scmi_get_pins_count,
>+	.get_pin_name = pinctrl_scmi_get_pin_name,
>+
>+	.get_groups_count = pinctrl_scmi_get_groups_count,
>+	.get_group_name = pinctrl_scmi_get_group_name,
>+
>+	.get_functions_count = pinctrl_scmi_get_functions_count,
>+	.get_function_name = pinctrl_scmi_get_function_name,
>+
>+	.pinmux_set = pinctrl_scmi_pinmux_set,
>+	.pinmux_group_set = pinctrl_scmi_pinmux_group_set,
>+
>+	.pinconf_num_params = ARRAY_SIZE(pinctrl_scmi_conf_params),
>+	.pinconf_params = pinctrl_scmi_conf_params,
>+
>+	.pinconf_set = pinctrl_scmi_pinconf_set,
>+	.pinconf_group_set = pinctrl_scmi_pinconf_group_set,
>+	.set_state = pinctrl_scmi_set_state,
>+	.get_pin_muxing = get_pin_muxing,
>+};
>+
>+static int scmi_pinctrl_probe(struct udevice *dev)
>+{
>+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
>+	int ret;
>+	int i;
>+
>+	ret = devm_scmi_of_get_channel(dev);
>+	if (ret) {
>+		dev_err(dev, "get_channel() failed: %d\n", ret);
>+		return ret;
>+	}
>+
>+	ret = scmi_pinctrl_protocol_attrs(dev, &priv->num_pins,
>+					  &priv->num_groups,
>+					  &priv->num_functions);
>+	if (ret) {
>+		dev_err(dev, "failed to get protocol attributes: %d\n", ret);
>+		return ret;
>+	}
>+
>+	priv->pin_info = devm_kcalloc(dev, priv->num_pins,
>+				      sizeof(*priv->pin_info), GFP_KERNEL);
>+	priv->group_info = devm_kcalloc(dev, priv->num_groups,
>+					sizeof(*priv->group_info), GFP_KERNEL);
>+	priv->function_info = devm_kcalloc(dev, priv->num_functions,
>+					   sizeof(*priv->function_info), GFP_KERNEL);
>+	if (!priv->pin_info || !priv->group_info || !priv->function_info)
>+		return -ENOMEM;
>+
>+	for (i = 0; i < priv->num_pins; i++) {
>+		ret = scmi_pinctrl_attrs(dev, SCMI_PIN, i, NULL, NULL,
>+					 priv->pin_info[i].name);
>+		if (ret)
>+			return ret;
>+	}
>+
>+	for (i = 0; i < priv->num_groups; i++) {
>+		ret = scmi_pinctrl_attrs(dev, SCMI_GROUP, i, NULL,
>+					 &priv->group_info[i].num_pins,
>+					 priv->group_info[i].name);
>+		if (ret) {
>+			dev_err(dev, "loading group %d failed: %d\n", i, ret);
>+			return ret;
>+		}
>+		priv->group_info[i].pins = devm_kcalloc(dev,
>+							priv->group_info[i].num_pins,
>+							sizeof(*priv->group_info[i].pins),
>+							GFP_KERNEL);
>+		if (!priv->group_info[i].pins)
>+			return -ENOMEM;
>+
>+		ret = scmi_pinctrl_list_associations(dev, SCMI_GROUP, i,
>+						     priv->group_info[i].pins,
>+						     priv->group_info[i].num_pins);
>+		if (ret) {
>+			dev_err(dev, "list association %d failed for group: %d\n", i, ret);
>+			return ret;
>+		}
>+	}
>+
>+	for (i = 0; i < priv->num_functions; i++) {
>+		ret = scmi_pinctrl_attrs(dev, SCMI_FUNCTION, i, NULL,
>+					 &priv->function_info[i].num_groups,
>+					 priv->function_info[i].name);
>+		if (ret) {
>+			dev_err(dev, "loading function %d failed: %d\n", i, ret);
>+			return ret;
>+		}
>+		priv->function_info[i].groups = devm_kcalloc(dev,
>+					priv->function_info[i].num_groups,
>+					sizeof(*priv->function_info[i].groups),
>+					GFP_KERNEL);
>+		if (!priv->function_info[i].groups)
>+			return -ENOMEM;
>+
>+		ret = scmi_pinctrl_list_associations(dev, SCMI_FUNCTION, i,
>+						     priv->function_info[i].groups,
>+						     priv->function_info[i].num_groups);
>+		if (ret) {
>+			dev_err(dev, "list association %d failed for function: %d\n", i, ret);
>+			return ret;
>+		}
>+	}
>+
>+	return 0;
>+}
>+
>+U_BOOT_DRIVER(pinctrl_scmi) = {
>+	.name = "scmi_pinctrl",
>+	.id = UCLASS_PINCTRL,
>+	.ops = &scmi_pinctrl_ops,
>+	.probe = scmi_pinctrl_probe,
>+	.priv_auto = sizeof(struct pinctrl_scmi_priv),
>+};
>+
>+static struct scmi_proto_match match[] = {
>+	{ .proto_id = SCMI_PROTOCOL_ID_PINCTRL },
>+	{ /* Sentinel */ }
>+};
>+
>+U_BOOT_SCMI_PROTO_DRIVER(pinctrl_scmi, match);
>+
>diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
>index 9b36d3ae67bb..c40b448bcba1 100644
>--- a/include/scmi_agent-uclass.h
>+++ b/include/scmi_agent-uclass.h
>@@ -52,7 +52,7 @@ struct scmi_agent_priv {
> #if IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)
> 	struct udevice *voltagedom_dev;
> #endif
>-#if IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
>+#if IS_ENABLED(CONFIG_PINCTRL_SCMI) || IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
> 	struct udevice *pinctrl_dev;
> #endif
> #if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_80)
>diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
>index a4efadafa73c..3e862adb8035 100644
>--- a/include/scmi_protocols.h
>+++ b/include/scmi_protocols.h
>@@ -1146,4 +1146,360 @@ struct scmi_perf_in {
> struct scmi_perf_out {
> 	s32 status;
> };
>+
>+#define SCMI_PIN_NAME_LEN 16
>+
>+struct pin_info {
>+	char name[SCMI_PIN_NAME_LEN];
>+};
>+
>+struct group_info {
>+	char name[SCMI_PIN_NAME_LEN];
>+	u16 *pins;
>+	u32 num_pins;
>+};
>+
>+struct function_info {
>+	char name[SCMI_PIN_NAME_LEN];
>+	u16 *groups;
>+	u32 num_groups;
>+};
>+
>+/* This is used by both the SCMI pinctrl and gpio drivers */
>+struct pinctrl_scmi_priv {
>+	int num_pins;
>+	struct pin_info *pin_info;
>+	int num_groups;
>+	struct group_info *group_info;
>+	int num_functions;
>+	struct function_info *function_info;
>+};
>+
>+/* SCMI Pinctrl selector type */
>+enum select_type {
>+	SCMI_PIN,
>+	SCMI_GROUP,
>+	SCMI_FUNCTION,
>+};
>+
>+/**
>+ * struct scmi_pinctrl_protocol_attrs_out - Response to SCMI_PROTOCOL_ATTRIBUTES
>+ *					command.
>+ * @status:	SCMI command status
>+ * @attr_low:	Number of pins and groups
>+ * @attr_high:	Number of functions
>+ */
>+struct scmi_pinctrl_protocol_attrs_out {
>+	s32 status;
>+	u32 attr_low;
>+	u32 attr_high;
>+};
>+
>+/**
>+ * struct scmi_pinctrl_attrs_in - Parameters for SCMI_PINCTRL_ATTRIBUTES command
>+ * @id:			Identifier for pin, group or function
>+ * @select_type:	Pin, group or function
>+ */
>+struct scmi_pinctrl_attrs_in {
>+	u32 id;
>+	u32 select_type;
>+};
>+
>+/**
>+ * struct scmi_pinctrl_attrs_out - Response to SCMI_PINCTRL_ATTRIBUTES command
>+ * @status:	SCMI command status
>+ * @attr:	GPIO, number of pins or groups
>+ * @name:	Name of pin, group or function
>+ */
>+struct scmi_pinctrl_attrs_out {
>+	s32 status;
>+	u32 attr;
>+	u8 name[SCMI_PIN_NAME_LEN];
>+};
>+
>+/**
>+ * struct scmi_pinctrl_list_associations_in - Parameters for
>+ *					SCMI_PINCTRL_LIST_ASSOCIATIONS command
>+ * @id:			Identifier for group or function
>+ * @select_type:	Group or function
>+ * @index:		Index within the group or function
>+ */
>+struct scmi_pinctrl_list_associations_in {
>+	u32 id;
>+	u32 select_type;
>+	u32 index;
>+};
>+
>+/**
>+ * struct scmi_pinctrl_list_associations_out - Response to
>+ *					SCMI_PINCTRL_LIST_ASSOCIATIONS command
>+ * @status:	SCMI command status
>+ * @flags:	Number of items returned and number still remaining
>+ * @array:	List of groups or pins
>+ */
>+struct scmi_pinctrl_list_associations_out {
>+	s32 status;
>+	u32 flags;
>+	u16 array[];
>+};
>+
>+/**
>+ * struct scmi_pinctrl_settings_get_in - Parameters for
>+ *					SCMI_PINCTRL_SETTINGS_GET command
>+ * @id:		Identifier for pin or group
>+ * @attr:	Config flag: one setting, function or all settings
>+ *		Selector: Pin or Group
>+ *		Skip: Number of config types to skip
>+ *		Config type: Type of config to read
>+ */
>+struct scmi_pinctrl_settings_get_in {
>+	u32 id;
>+	u32 attr;
>+};
>+
>+#define SCMI_PINCTRL_CONFIG_SETTINGS_ALL -2u

Not understand well why -2u.

>+#define SCMI_PINCTRL_FUNCTION_NONE 0xFFFFFFFF
>+
>+/**

Regards,
Peng
