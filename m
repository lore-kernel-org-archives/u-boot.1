Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E34CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 00:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E618499C;
	Sun, 21 Jun 2026 02:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LwknYMd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55CB78499C; Sun, 21 Jun 2026 02:50:14 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CEC483FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 02:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9+mBKcedVfhEdyneN3tjMV1rG498EnBL7uF5/zM7evF4WFFzVzz1A5JhtkDLsMVrLDpnlrPx5eRYvLSNAcCCqw7P9vMX8G/Eyq50jNvMo1XTGThtVTaPUhAg42u0v7C8p0YsiM/V26nOMSOlC+rMe1Fx5zbyObLyTnK1Zg+/xONqWF5qQJycKVKWASTRFKDaQmOiAVJUE9nxJIZ8/MvLBp2EiBbEjrFFG0mQfG/QVf+UTys4tSOH/R0W2DbL51vuM9d6g/AKTnsEwHFbK4TKorhYHsL0EExGAEe/mzdtVB3oGR8mqLmrFSCulP6LSGDBEJ/5nD4Kqu/6ULE1Q3ZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruuhzyD8ydeVgSGhPAYu5unWoAEG/yaLypc1ATkysus=;
 b=UAX9uD4CwnQFmo66qI0H0EyWddn4BolXU3LHs8ldw92cqxmkBk2xNMiK4m9WR8mStKB4wuFxubCV6sWrkXxpFGsHvGIJhSbK/rSWjfbFNbM7dgyVRdEokv4s9P0A9wjTU2b9+9lnfcohBiUjZAAEAPABBMF3QKpcVPqc0e8vwMdFHQNVNL9Vzgor+YzpFY68bTZ3eAewGy+beF/gA7+8oj/wd/UqamYvnr4ptWb/H9U+neTuK2NWPX5Bb/VuOdSlM+IrQrmp0F9RUSo1+wFd7NNel+nFNLJ8TaADgKlXQZFhzIbJUoUAudzelZEVZyYa7SIHWs/TE8dcLIOqrdTDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruuhzyD8ydeVgSGhPAYu5unWoAEG/yaLypc1ATkysus=;
 b=LwknYMd+ijRcH6slZv+BxSlzR55R1h8SLh+17R2+MO8btKE95y4qBnh6gd7Yu3P3rl23Vek1xuayuAuwqYZmiWTmFuU7Dbfk64guXhfp8ZmIdOQcwZ9fGYtmnV8Dn44JWxD8oDaEKPegZJc5HiZW07D/QyF6c3wDRjx+XkxMf+1y6G8M3yJg3wM6s3At3KWPZRCOlIZBzIll6LzFFT8LhiQmP9zAeVcrXF4xVhlW/MDjjY+Mmwc8SRzboM7G+BKR5/Q/gg/2Sq56I/fecGlKk2AN/Smkpzp2xZMvCXFKQ/2e+QHptYoOL4YoGoyfZqsuFxz5vRMwn2QspJEda9yMDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 00:50:09 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 00:50:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jun 2026 10:06:41 +0800
Subject: [PATCH v2 05/10] usb: tcpm: add
 setup_host_mode/device_mode/disable_src_vbus APIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-tcpci-dwc3-v2-5-990ecacc111c@nxp.com>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
In-Reply-To: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4939d0-bc99-4336-5a94-08decf2f0b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: U2ivW+OmFYX3OrgLxM3HiwB+vSWvwp5w3DDbduN7uabN5KwYKWjKHhKi23WyqUI6jwpZcaPwRVySd/IS3qgtzDvhqfgMJQbERJlSVfHwBcViEPwJjoJ6gNpLt6F+m52MGemDqWWAf7HY9YZ+np75KTfk5Sffcwu8EcWtEQs1XV3k1lcfE3m9nTo4ApmRNo7tSq1hiNc0zVx7nN1c9ZdSHSfSwEb+JVeqlr+31EBTpAN09ek+Sp4YIYxvRpMr+N2mn3DEb8xVr6hjreH5vNf6Rwpx2QjV8Nz8AfpKHQ83yrr8EIddNq5W3yCb0u0yLMy7cWFiQ0BfqD+eXzoqYclcP1asi4aaV5LxdF3wuhScenPUYC3MmBdT6XdMujT0YdmyRpZ21fo5QDNO9eIP0NzkLOA2siC55EyURVdE7Pa9d26ldJLhyMFOWVUzriq996JyVH7DUEvcbabGhyqriu17iSHeUuXWrGTAripuIyP1tNxaSk3dL/JCVWe5FlHmtMGbLkdVqWQLjmiF13wi91ZR/KI+0SEM7gsdhhkK8cLEGhZ2uUySRIo/wVfltlMfhkxYta7NyGDn/vL/3V+F77YtljfVUoJQw711IQh6xlRXoaZifA46svbuNSpyyt8kqL1GxE/788k9onwmVUglaK6ORntu93wHOC5l4p7kWWr05fk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXl6ZWo5K3MvWkl6L0pkZU00UE13SmE3REhCcnluNzJhek02NnVqNHVqR1lY?=
 =?utf-8?B?ZDdqQTNGUVIxWHhXUWhTeWo2QzdrNXlJREZSZU14cnBYWC9nTDRoYXIxOGlw?=
 =?utf-8?B?YXJWVW1pWVlsWHdxZjBXckdWdHBqczVhekZXRjNvaEx4d2RkYzFqeWhmeVFL?=
 =?utf-8?B?ZFRYdVE1TVlEQjhNR3BxWDZ2YnRwcTB4N3EwK21NOHR4a0k5b1pLMVc0Rk82?=
 =?utf-8?B?YnFSbXJpTG5RL2JJS3ZhRXpLOUJvUW9yK2ZUaDR4Y3EzSzZiNTIzUDhGZXZE?=
 =?utf-8?B?Q2N1MEIrTVdtN0hCQWZGT2grV3NKbXo5eGtIT3lXVFZ2ek1DUzZaRmw3Q1NN?=
 =?utf-8?B?ZDVDZEtsWU56NVVOWC85UUtCdDB4YXFHb2JjVTNUOXhEa3NOSUZRQ21rNkNH?=
 =?utf-8?B?Um4vcm84bWpkT0tnb1hMdTh5ZzllQWw2R1pyM2cxejN3Y1JDNFBaYjYwRnh3?=
 =?utf-8?B?R0FwanQ1dEJVcWNSZmhTMTVTdXdyeWFrNlk5RnJldnl1VXlobXJQZEFSSGtZ?=
 =?utf-8?B?TStWOUtHeDFwdXdIOVY3Z0RsdUlsUTNaT3hhYS9USitSUzZuSjkralgra1k5?=
 =?utf-8?B?eitMcXo2UXFiL05NaEk3MU8wamkxNjZvb3YxNGM3VE01VmF5cENMYTlISXZE?=
 =?utf-8?B?L3N4TG1lL3h6NXNvTk10ak9WVmxoYk1tUENsZzBiOTAydlNtcnNnbFVyRUZv?=
 =?utf-8?B?WnlhOHkwM2gvY1VWaEk1SEk5cTRDZzA1NTFjRG45MmlVRldUbjhodi91dnhv?=
 =?utf-8?B?dWxTUG1MTHRMNjhDeHhFZGNPdkFyOWl5ZlJUYTE1dlJtUDh3YnlJRUMyQTNK?=
 =?utf-8?B?THZQTWx1a0NsM0o2UlRBR05HeXJOc21nYldqUmxtcllveDgzQk1Gb0NJdFN3?=
 =?utf-8?B?NVkzcHVGc1o4UC9ENG11dkxHQXJkeGpmZ0F3dDdndzgrdXNSUzg4THFzaGZR?=
 =?utf-8?B?TGg2L1FjdmY4WWxOWkZhSzFlajMwQTJLdllSK29SaUJhMWdyT05HZXNyUndL?=
 =?utf-8?B?RFRZVitBSWtXeHBMUGxnWUVaelJ6OFl2MXdPSEpPQXVsOWJrb0IzTktucCtT?=
 =?utf-8?B?RERDelhXS3VuL2h6T2hQM3RlUnVjMzQxUzdnNTArbm9rMytDWGU2QnZUUWRn?=
 =?utf-8?B?UUtwa0dtRnVNYjZRUzVwOW5PVlc1WGc1b0IrUU41ckhHWml4aGsyUXJQU0Vp?=
 =?utf-8?B?REx4RXk5WG5UUlBENzZScStFK0g5aWd0TENVWXJ4SGR2WDhpSS9qOXAvNllI?=
 =?utf-8?B?Y3pzaGZ0ZG1jdTNqMjMyMXZDRXIreHc4MEl0SDBPZWpFTm5seDl5M1dnRFJX?=
 =?utf-8?B?eVhRVjJMRU9tcFlvOHBFbk91SERwRXdmLzJIOEZaMlk5SzJrTWZ6dVFJQllk?=
 =?utf-8?B?SUorTnJzSUx0ZUhqZ1d1L0tMODh5NUg0VHFwREZMc2xxTlZWK1d0OTJwU0ZK?=
 =?utf-8?B?Vm1aQ25TaEV6d1lvNnlBaUg0NEFnZ2U0WkhVd2JwajVReDNCNXU5eFVSRS9o?=
 =?utf-8?B?RkFLdHA4TW9zY2xsbXpJQ2pRTkRnZUt0QWNUT3VwYStmTFNtQlJzU3NmcFlv?=
 =?utf-8?B?T2tTSHVCcVpRQTRkVUJ3b282Nmlnb2I3VG15QnppcllnMG9XbHNndlBBOHhk?=
 =?utf-8?B?NHo5d2RHN2N1N25tTlkrN3FxU0htc1R4Mk5MMVkyZG5DUDluRUk3TmdndzQ2?=
 =?utf-8?B?Kyt3MnF3Vko0dTVvNjBjUWw1eEdDTVNPQjNsdnYyOGxNeGwzeHZjNzI5MzI5?=
 =?utf-8?B?bE9aY3F0SGRVV25xcERFRDc2eWJZdXVzK3F2VUYyTkZJTzRzNmFDWktyN0l4?=
 =?utf-8?B?RHdlOGJ6Q3dnQkQ0WVJNK1l0WEtWbjJ3Q2ZkSDJYOXhYRGJQTkVmRWtROHp4?=
 =?utf-8?B?bWlLRjRheXk3V0dMUWRudEhhaXU5c05BYUdQRTNKcUVlNnlVVTJEcmliNXlS?=
 =?utf-8?B?WFA3TGlvUmtaQ1RFdm5ITTJtbVMvZk5KU2cySjhjVFZ5NlpydE9rcDdDbUwx?=
 =?utf-8?B?Q1NwL2w3REdiZ2V0SEdZeXA2OS9pZzFQZmJIUkhsZk4wVGV4QXRtSDI1Qkt2?=
 =?utf-8?B?VWkrOEJPWlIvQXl1V1ZBaUJFRDgzQVdpYWRhdGxRNmN2eE05MGh1ZkQweXli?=
 =?utf-8?B?T3ZOd05IcEZWUzJEcEJiY2tPbEpSRVpNTFlFaThXd29ZSGJXWnBHRE96elVv?=
 =?utf-8?B?OE4wYitGNlRmQVA3RnpFMnY4RFVOSmxscGh5V0hIeTFlSlZOMDk2bFdaUnda?=
 =?utf-8?B?Q29pclkwSlQ1MG5zWjVpdGYwUVU1YWRsTFdHTlpXOXF1TTdLUlEzYUhxUWty?=
 =?utf-8?B?bkRXOXgwelZRV05Kd1U3bnZ0VERYS1RGT05lb1dyUE52VkdEVS8vc1dzK1lZ?=
 =?utf-8?Q?u8mP8XMSFSTQLNS96vkG+7QJBX7HTP5T4Z5Ox?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4939d0-bc99-4336-5a94-08decf2f0b17
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 00:50:09.0692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLxELanZMNmKB8z0AUpJp0VzpTs6gYNi10QBfVNlCBiDzy5lU7tUzDLqPu1F+MTgNDtMkDLvVO1NvHD/2O7YXgxDGlC1vm34MKc7Hrx/oY7kGd5YYsDjJKsXCJzjWW+P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305
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

From: Peng Fan <peng.fan@nxp.com>

Add lightweight Type-C mode setup functions that bypass the TCPM state
machine and call TCPCI driver ops directly:

- tcpm_setup_host_mode(): set CC=Rp, detect device, set polarity,
  source VBUS
- tcpm_setup_device_mode(): set CC=Rd, detect host, set polarity
- tcpm_disable_src_vbus(): stop sourcing VBUS

These are used by board_usb_init/cleanup to configure the Type-C port
for USB host or device mode without running the full PD state machine.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/tcpm/tcpm-uclass.c | 87 ++++++++++++++++++++++++++++++++++++++++++
 include/usb/tcpm.h             |  4 ++
 2 files changed, 91 insertions(+)

diff --git a/drivers/usb/tcpm/tcpm-uclass.c b/drivers/usb/tcpm/tcpm-uclass.c
index d4fe260e0db..e0f7ce62a79 100644
--- a/drivers/usb/tcpm/tcpm-uclass.c
+++ b/drivers/usb/tcpm/tcpm-uclass.c
@@ -8,6 +8,7 @@
 #include <dm/device.h>
 #include <dm/device_compat.h>
 #include <dm/uclass.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <usb/tcpm.h>
 #include "tcpm-internal.h"
@@ -140,6 +141,92 @@ static int tcpm_post_bind(struct udevice *dev)
 	return 0;
 }
 
+int tcpm_setup_host_mode(struct udevice *dev, enum typec_cc_polarity *polarity)
+{
+	const struct dm_tcpm_ops *ops = dev_get_driver_ops(dev);
+	enum typec_cc_status cc1, cc2;
+	int ret;
+
+	ops->set_vbus(dev, false, false);
+
+	ops->set_cc(dev, TYPEC_CC_RP_DEF);
+
+	mdelay(100);
+
+	ret = ops->get_cc(dev, &cc1, &cc2);
+	if (ret) {
+		dev_err(dev, "Failed to get cc for host mode: %d\n", ret);
+		return ret;
+	}
+
+	if (cc1 == TYPEC_CC_RD) {
+		*polarity = TYPEC_POLARITY_CC1;
+	} else if (cc2 == TYPEC_CC_RD) {
+		*polarity = TYPEC_POLARITY_CC2;
+	} else {
+		dev_err(dev, "no device detected (cc1=%d cc2=%d)\n", cc1, cc2);
+		return -ENODEV;
+	}
+
+	ret = ops->set_polarity(dev, *polarity);
+	if (ret)
+		return ret;
+
+	ops->set_vbus(dev, true, false);
+	mdelay(300);
+
+	return 0;
+}
+
+int tcpm_setup_device_mode(struct udevice *dev, enum typec_cc_polarity *polarity)
+{
+	const struct dm_tcpm_ops *ops = dev_get_driver_ops(dev);
+	enum typec_cc_status cc1, cc2;
+	int ret, retry;
+
+	ops->set_vbus(dev, false, false);
+
+	ops->set_cc(dev, TYPEC_CC_RD);
+
+	if (ops->start_toggling)
+		ops->start_toggling(dev, TYPEC_PORT_SNK, TYPEC_CC_RD);
+
+	for (retry = 0; retry < 20; retry++) {
+		mdelay(100);
+
+		ret = ops->get_cc(dev, &cc1, &cc2);
+		if (ret) {
+			dev_err(dev, "Failed to get cc for device mode: %d\n", ret);
+			return ret;
+		}
+
+		if (cc1 != TYPEC_CC_OPEN || cc2 != TYPEC_CC_OPEN)
+			break;
+	}
+
+	if (cc1 != TYPEC_CC_OPEN && cc2 == TYPEC_CC_OPEN) {
+		*polarity = TYPEC_POLARITY_CC1;
+	} else if (cc1 == TYPEC_CC_OPEN && cc2 != TYPEC_CC_OPEN) {
+		*polarity = TYPEC_POLARITY_CC2;
+	} else {
+		dev_err(dev, "no host detected (cc1=%d cc2=%d)\n", cc1, cc2);
+		return -ENODEV;
+	}
+
+	ret = ops->set_polarity(dev, *polarity);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int tcpm_disable_src_vbus(struct udevice *dev)
+{
+	const struct dm_tcpm_ops *ops = dev_get_driver_ops(dev);
+
+	return ops->set_vbus(dev, false, false);
+}
+
 UCLASS_DRIVER(tcpm) = {
 	.id		= UCLASS_TCPM,
 	.name		= "tcpm",
diff --git a/include/usb/tcpm.h b/include/usb/tcpm.h
index 10f0515fe12..caa67a5639d 100644
--- a/include/usb/tcpm.h
+++ b/include/usb/tcpm.h
@@ -96,4 +96,8 @@ enum typec_data_role tcpm_get_data_role(struct udevice *dev);
 bool tcpm_is_connected(struct udevice *dev);
 const char *tcpm_get_state(struct udevice *dev);
 
+int tcpm_setup_host_mode(struct udevice *dev, enum typec_cc_polarity *polarity);
+int tcpm_setup_device_mode(struct udevice *dev, enum typec_cc_polarity *polarity);
+int tcpm_disable_src_vbus(struct udevice *dev);
+
 #endif /* __LINUX_USB_TCPM_H */

-- 
2.51.0

