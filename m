Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C54CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 00:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CEC84873;
	Sun, 21 Jun 2026 02:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ataqVlGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 960BD84874; Sun, 21 Jun 2026 02:49:35 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3589A83FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 02:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRCDCBBuRy3RFhbs7MowtoQzDu/EVFgsmqIqwHc+s9NNQM7EJYKWGoVsZMef5/3DBz77K1RFTH9P9gvDhUAog5l6w+MUQYmQemtRL4aZSVuj0dmONiGlKhqZJNWW3pqgkFoUofhrWgeyUAhZX8dV1mfO4RTHfh3EpPpJUO/96TQHQg7KyNaIVXjvavtuJSJ7awyEPeYfjhG2hh3u9eAXc4xOafv8R5UJ1/ofoxuTIkmuIQ6KuGJolVj2j3pp1xM0hw74A/vHsQiXm+xms9oXZ9IzsYlJsC3YhO9gP7ylC6VRCOBetQX9+E9cryMHHCoEP/pfAX/ZtGPGY0i02E+8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/ozNkzxLfbn6lkwJmYCM9QATWGqFCKDGmO/1cEp0NE=;
 b=XA3iyHG1RWW2PxRkScJzuvUScfuacxdQqA+7kD/C34JX1ODiHKvm2w9y8FJvtJ9Bny1S4FlJbt4ENEHjPRR+ci8p84mQZeP+J+RaK+QIn0Vuci6MYxsLNhLj6fNvYGpEgOrroBJjk9vip/EsQ6ljTWpaHK74SEqWLNnJaDPNa99YThsABDlz+GE5RlHUSezUjaesnMvFjAndMEnjbQMWoCGUmNg7jyx0yd/xu9rYRxLbjed4t6m5Y0tRFA0Fi9O2rMncbO39H3vWN/E7DfUbxH/c9KAyJ9d6lxXVgIBiJPTB8jjGXqKVd+tXOEY3rYSxigByms9khlCk56yHRHDd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/ozNkzxLfbn6lkwJmYCM9QATWGqFCKDGmO/1cEp0NE=;
 b=ataqVlGRcq89ILAEh/4IfWvrBO7a7X097JCkI1fh60JSgEyZeE4JT2rPlPLcRpTBvr1o2IfAsebA63Z24N0La1eShM9ahDUgIndQSGi1KtmXuJQfzIN1iJwPw3x0yKN1lExXHKzr782HMRQZGkxqKyt/s+wpnlPylmrFJ0dBasdDDL4I1INC1Wcsx7Iq6mwvaR2JzCftQxM7hfy414qKYO+bijEeGeb0Grp2lAh95lz0mpjDPU/Cm8LwWDAQEG+wtU9bHGWZBDQaE16Rmn+bxkhP2IrnT4PkpKiHa3qgXXqtCoulW6caLIkbUyu6cCmWg1yNC3s9rnAkGJj8jYnfSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 00:49:30 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 00:49:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 00/10] usb: Add TCPCI driver and DWC3 OTG dual-role support
Date: Sun, 21 Jun 2026 10:06:36 +0800
Message-Id: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACxHN2oC/22NQQ6CMBBFr0JmbQ1tBakr72FYwDDImAhNWxFDe
 ncLbl2+5P33V/DkmDxcshUczex5GhOoQwY4NOOdBHeJQeWqzEt5FgEtsujeqEVZ6KboDFaV0ZA
 G1lHPyx671T/2r/ZBGLbCZgzsw+Q++9ssN+9veJYiF22lTj1JMsqY67jYI05PqGOMX8tIKuC0A
 AAA
X-Change-ID: 20260617-tcpci-dwc3-653a5d9c8893
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
X-ClientProxiedBy: MA5P287CA0288.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc127b8-f191-469f-7a3b-08decf2ef40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: dUqvwszFNzfnLaCyYhxjxAfLD+vqMDi79D2ZvXjwOzNsKwMrAurMaS6aSlTvNyICeKECgyUUvZvRQDZOdLfBz6WdkAAEYbu56hRg7bWregPE/WNoRHFWjaS/m/TTtXJzpIt3BADG/DYLQ5C00tIg/rU9oGe6RQsCQdtCN3pRsphzj2xBTGkGLO43wcCqC5JHEkZYufp0gXlQldo0ietDa6XMyMCqpaK6AZcLqt6xAoYY1aIAYhItdDinZZvR4EQC5AA/mCMGckILSk1R+nS7wTi5FefxCVqleTq+SONVOD0mN6+RahV4SmqsYjbneLBK2QinBCLAHB7MdVeSmAbiMX9Oyy5/wobUrgnJ+TnVTPxIvXWayOLtGx3Dqmr+Sipws27kjHxpMPQ66uRNLK8OXJaiW25QebDZY0vuBYLOqax6WZSH5n/KTlXUBNthllTg1Zeqg6PAbj9axPk3qvNj873PZk0YefwzbguuMIc+iy5XHEL8G+AHzySDxlKIZdi6yaJ+Vnnp20iI2jPcySICpRKliRPO3Kt3wq1ILHw4CLBOX3ONYXkNvo7u0DTgR82I5O7NrHJPLyr0khz2KAF8N3RmGs6OyiPj+bSfka07Zh6cGmveZUD/q2bGfHbJtKzS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXl3Y0U5ZGVJYld6WXArKzFFOWxvbUx1N1l6bE9VdUg2cmNxYTZ3TlhYTlhu?=
 =?utf-8?B?eEpqb3JsOFhVSmdiSi9FUExGU3BDb1ViRWFRZVlZQ1JnZFE4aDZYaXd2TlJl?=
 =?utf-8?B?YUxuWkJma3RET09jMmdONkVsckN2UzlCYUc5NGVjNHg0NklDalhPUFJyN3dy?=
 =?utf-8?B?RnVvazhBU2kxZDFjekNNOU9sd3gxdmVNT3ZYdDFlSjhuRmVVWWlDaFpOblVh?=
 =?utf-8?B?OEIwVERGd0FUeVZjRHlXS21aQVpySk10RGFUZTlKWmcrQ1ZFYWxTcy9TOVFt?=
 =?utf-8?B?UmQvY0dzZkVNQVNoenVCK2gwM3lCdFNZVFl4L2JxSXFoc1drNlRTYy84YVRE?=
 =?utf-8?B?Y043UjE3Wm03T0MvUVBua2dUZ0RZN3gvSzdyZzdYVHAraGlEdTZjOHpXZ0Jw?=
 =?utf-8?B?WHI3NDdyVm4yZVpmU2xwWlBJMGhRdzg2dFloMGtlSlFCSnBtT0RQcjJRdUJ5?=
 =?utf-8?B?QS9QYU1XdnljOGJOYjhsT1R1b2xGblRUc3VtV3R5V1JrZnJvc0ZJTnJpV0x0?=
 =?utf-8?B?MzNBclpsUGNBT3dlYlpyY3NtZkNxTVdQUHlWV0FieDRXUWZPMkFXVUx6YnJG?=
 =?utf-8?B?RndjOXlwbWV6M2RsK0FFTWlxaUZoVHRROTVWRmQ5ZHgxcy8yayt3R0xKVEVB?=
 =?utf-8?B?S3ZWZVpFNnJhWnNKdW1Jd2wyMmoxZldKYzdBeXJNTWtTWTl6YU1NL21iT3px?=
 =?utf-8?B?K3Q2TDErbDJaL1FWcUlITno1NHdaT2dVMHRzNi9IeDc5MGVQM2tFT3UycEg2?=
 =?utf-8?B?MmlNZGxSL3RqT20zS3UydGVWS25VRUVYU09zQlZNMWV5UStLcDA5ZG9CbGdq?=
 =?utf-8?B?T2tNc3VINnZLMmUxWlhQMURrY1FxQ0VzNDQ3SFJQWWQ1UjNrOWcrQUw0ZFQw?=
 =?utf-8?B?Z1V0KzE2VGNhWmVaa0JwNWwydmpEdkE5bWF3NjgrZXZXYlZXcjlBR0Q3eldp?=
 =?utf-8?B?eHRJc1Y3RVQ1a2V3T3FHWnJpcFlmSHEyNTlMeXg3NVlyZWszNGF4Mi9YWXJw?=
 =?utf-8?B?VW5iWi9QaWtPNzA1Q1dkT09Xc0laZUoxUWRtUjgyRnlmK2d1bHk1cDZIdDd4?=
 =?utf-8?B?RmlMK3BRRklxbm9Tc21oRXNNRVJhTktseWQvaE5jVjdiY2gzMUp6ZEFBaDdr?=
 =?utf-8?B?REd0L096SmpoYUV2clNkUnVIZTdEa2VnY3oySVN3VGpzNkt0YUhZZis2N1ov?=
 =?utf-8?B?dmpuZWZDdnZKblpXeElJVENWcERLbFhpQkg0bVVVQU5nU0xKUHloRjhwVElB?=
 =?utf-8?B?UDZ4dVpoS1RUVHNVbTUwYmJBeEx2VTF6RTd6b1VocEFoc0x0K2NnVnA1VThC?=
 =?utf-8?B?MUkydk1PWFV0N2ovbG8rKzlyYWRFMDA0dlAzaDVqUlpDakllWkUxYkhzZXBQ?=
 =?utf-8?B?bzVpWHFvdmxvQ3ZJV2dRa21POXRpbkwwLzkxUDcwTkI5QTB0VTNCQjhiSkFW?=
 =?utf-8?B?TkZsOXNHYUpjYnNibWtFanJBeDdISVozenVNMC91Ykt3M0taWUsvK010akQx?=
 =?utf-8?B?djFNRlR3NWFLc3ZRa2hLRHBlRDlvNWtTbURSY2tYazZPT3RHOUdBZHRsWSt2?=
 =?utf-8?B?Q1RqU0ZpQk9SY3graGVocmNNa00zZEh0Zmx4SFRmL011bU1DdnZ1a3JJejVR?=
 =?utf-8?B?cTNwVlZTamltRllQazRqbWtZUzVFaEREVE02bHM4aTVFVjJ2Qnd4OGpaaGpa?=
 =?utf-8?B?VG1oRHZGK3E5UTF5djA5SVdqRmNwdDlpNVhOb2dxOE9oSWg5b0UrTFhzU2U2?=
 =?utf-8?B?YU9yRGRQR1RQOW10bUlEeXpQUnJOVUtsUUFtVWhKNitycklhR0FLUk5rY1or?=
 =?utf-8?B?OURPOTFQY2RxcXJnVS9tSTJtRG9rRlF1b2VpV0NPRFprVWsrT1ZxOUdkTm1I?=
 =?utf-8?B?UkpoQ3dJR1ZpZnY4ZWVqejFrYzN5SDFpOVJxUmNneEswbDdNZjBYK0cxREFq?=
 =?utf-8?B?cjJBRThNT2FwSml0ZDVpeklZR2hOTjl3M0hFbXJHRkJySlNzRGEyeGpVdHRC?=
 =?utf-8?B?UVhFUklHZUJicjZBcnV2NHJ0NGx4Sk5hREhKbEErN2kwaURUcWVXS3ZrVkgr?=
 =?utf-8?B?cVVXZlB3YkVvY09WNTR6YjlGRGVJM0xYL1dqRjlOOHNGVGVYTitiSHByTm5D?=
 =?utf-8?B?S3pwcUpqc0d2ZUhpRWY1Q2VvbkZ4aFB6Um5YcWJPbEdMY2d4V0ZmbUMwT3lI?=
 =?utf-8?B?UHUxbDBqTDVZOEJkZndiYy9HRlBaeTJvTHVKTGxIQWZiWjJIZ2VrL2Nsbzh3?=
 =?utf-8?B?QzJ3d1Z2VHJnZlFVNENiWGlmdnFrdVZZZW1aeVFLYzRNU0IybjE0U0VzTXNt?=
 =?utf-8?B?NFpxN1NBTXNUdElWZVk0Tkx5cWRvWHB0SFJyeFJZLzRKcHlYcitDb3N5amNr?=
 =?utf-8?Q?Q+K6IQNzDZEXX7X/sn/Xjet9rN5R/9+wU2aaO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc127b8-f191-469f-7a3b-08decf2ef40c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 00:49:30.6920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FUNKsbAjBN1TcFYayArl0+bZeriQkvyqccEON/8D23Y4LdRb/NMlrmPpDKrExSfgGSmbHd6AOzhneGDbAzq89ZH0xM5W61nwKlnMUemXC5bQN6SMZeoEAqIrtrAd0Cm
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

[V2] Just resend this patchset without
"usb: tcpm: fix inverted poll condition in tcpm_pd_transmit()"

This series adds TCPCI (Type-C Port Controller Interface) driver support
to U-Boot's TCPM framework and enables runtime USB host/device mode
switching on platforms using DWC3 with Type-C connectors.

The work is motivated by the NXP i.MX8MP EVK, which has a PTN5110 TCPCI
chip managing a USB Type-C data port. The goal is to support both
"usb start" (host mode, for USB storage) and "ums"/"fastboot" (device
mode, for flashing) on the same Type-C port, switchable at runtime.

The series breaks down into three logical groups:

TCPM bugfixes (patches 1-3):
  Fix three issues discovered in the upstream TCPM state machine during
  PD sink testing with various chargers:
  - Inverted poll condition causing transmit to always time out
  - Unnecessary hard resets on sink-only ports when source doesn't
    respond to capabilities request
  - Premature exit from poll loop after SNK_READY, missing source
    follow-up messages (Get_Sink_Cap etc.) that trigger hard reset

TCPCI driver and TCPM API extensions (patches 4-7):
  - Lightweight PD negotiation tracing (RAM ring buffer, zero serial
    overhead) for debugging charger interop issues
  - TCPCI driver for NXP PTN5110 and compatible chips, ported from
    the Linux kernel with adaptations for U-Boot's polled model
  - New tcpm_setup_host_mode()/tcpm_setup_device_mode() APIs that
    configure Type-C CC role and detect cable orientation without
    running the full PD state machine -- appropriate for U-Boot's
    synchronous, command-driven execution model
  - pd-disable connector property support in tcpm_post_probe() to
    skip the PD state machine for data-only ports while keeping the
    TCPCI driver ops accessible

DWC3 OTG and board support (patches 8-11):
  - board_usb_init()/board_usb_cleanup() hooks in DWC3 generic glue,
    called during child probe/remove to allow board-level Type-C
    configuration before DWC3 core init
  - OTG dual-bind: when dr_mode="otg", bind both dwc3-generic-host
    and dwc3-generic-peripheral children; runtime mode switching via
    dwc3_otg_deactivate_sibling() which removes the active sibling
    before probing the new one
  - i.MX8MP EVK board support wiring it all together: TCPCI DT nodes,
    board_usb_init using TCPM APIs for CC role setup and SS mux
    control, PD sink configuration for the power port

Tested on NXP i.MX8MP EVK.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Drop "usb: tcpm: fix inverted poll condition in tcpm_pd_transmit"
  which was sent to list as a separate fix.
- Link to v1: https://patch.msgid.link/20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com

---
Peng Fan (9):
      usb: tcpm: avoid hard reset for sink-only ports on Source_Cap timeout
      usb: tcpm: continue polling after PD negotiation to handle source messages
      usb: tcpm: add lightweight PD negotiation tracing
      usb: tcpm: add TCPCI (Type-C Port Controller Interface) driver
      usb: tcpm: add setup_host_mode/device_mode/disable_src_vbus APIs
      usb: tcpm: skip state machine for pd-disable ports
      usb: dwc3: generic: support OTG dual-bind for runtime host/device switching
      board: imx8mp_evk: enable USB PD sink via TCPCI
      board: imx8mp_evk: add USB Type-C OTG support with TCPCI

Ye Li (1):
      usb: dwc3: generic: add board_usb_init/cleanup hooks

 arch/arm/dts/imx8mp-evk-u-boot.dtsi |  52 ++-
 board/nxp/imx8mp_evk/imx8mp_evk.c   |  78 ++++
 configs/imx8mp_evk_defconfig        |   3 +
 drivers/usb/dwc3/dwc3-generic.c     |  73 +++-
 drivers/usb/tcpm/Kconfig            |   9 +
 drivers/usb/tcpm/Makefile           |   1 +
 drivers/usb/tcpm/tcpci.c            | 778 ++++++++++++++++++++++++++++++++++++
 drivers/usb/tcpm/tcpm-internal.h    |  40 ++
 drivers/usb/tcpm/tcpm-uclass.c      |  87 ++++
 drivers/usb/tcpm/tcpm.c             |  46 ++-
 include/usb/tcpci.h                 | 185 +++++++++
 include/usb/tcpm.h                  |   4 +
 12 files changed, 1350 insertions(+), 6 deletions(-)
---
base-commit: debaadb75013a6d3706a2137d540bf4660475e3e
change-id: 20260617-tcpci-dwc3-653a5d9c8893

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

