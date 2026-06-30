Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A22CC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02325849FB;
	Tue, 30 Jun 2026 03:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hSgpUMbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02FE984A1C; Tue, 30 Jun 2026 03:45:37 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A258C848D2
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fT1W/mGL/PBHn8xULzMbp5CQOsdv4ieSGaI+HggbrSf8ROG6aWGqm6lH3YmoimrqZRqrkwJRkAEaBuggfXgi2gmiNOcOtry4xMFoPnV6QcW5qAMi2Oh9UrkD2XURAHcs+DCbinewzQoOKygVY3hAA0qGf4xcHv/8OffZ+y/y5+/Uiy07MNuB2jt5JtN+UKMueqhRaow9EKhYjm4JJ9/Ml8dYkMOLwTwmlpPckuPqiO/LwQ+iJXbZcwbRvHZPXU/IIWLV2qYXVAOqHjYtFy41mSJuLZvPrWm1Yy/q8t0wTxdk8UDBw2QLbLDo/liNGSRm2Yc6CM533QJw/xYMuy0suQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA8ffs9huD15ve6CM/87A0itUtkwkMKs4flXYDKKN50=;
 b=U2IkkM7d6JCAa0uHmr8eFK1OQJHuAJACXJ1OM3DBrFEdhh2CjMrgoiRIo4CDi9kbqji0ccBbsGVIipXp8taREBevjJ+Xx3scpDhibp3g6nu+Q5jgk2WORwGrjNUSl2NoDhjGfRcjdzxSA3ueH75nKwLCLUZjhyLwKvijFgzd85xArnZzUfbynNrlt9EXEo/wO1b15VYZGBN4MMDEQZsLwtgYix5ltH62keE8SQFfWWsg0/UftlXDEDIXMS5GLhAUm3rpemyLBmaXO4aZU5xFMc4/9glNcpgdaKs585cgYqkHLWor9H1IyGo8CEngZoaKrw+vclZqg7oDCEh1Oz1tWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA8ffs9huD15ve6CM/87A0itUtkwkMKs4flXYDKKN50=;
 b=hSgpUMbwSW3fPLYwOo/QffwuxNaNxwZi5b/oPAkGjPst+dc0JZAjJEDddjHr8mVfz0Da0IDIGhQolZmkYZ2yF8DKV9Q4aWl/W0ycDGTdF/kNj3/5gnDZ32rqCvc4Xa0Jaz94rJ4unH5KIh06I0qIrotqkT0LDJI0fN/jePxZ2AdMQsvoxuHeUgpTdgKssnJ9nyO1lPQwgc/Dt0XfQdRdkdNXTkVhw0v2cfe/2btNQLNnA0gk2mR4byWlEirppjPq8kqeuTMavimgxmCF6DXXiKg/E+M95faKNd8QvakKw+x6YNXMWP1aQmVa0WtxU3cYPP0anjmSRtY/jD2xa/RvsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS5PR04MB11419.eurprd04.prod.outlook.com (2603:10a6:20b:6c4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 01:45:32 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Tue, 30 Jun 2026
 01:45:32 +0000
Date: Tue, 30 Jun 2026 09:48:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
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
Subject: Re: [PATCH v2 00/10] usb: Add TCPCI driver and DWC3 OTG dual-role
 support
Message-ID: <akMgh8AbN6BX9UlS@shlinux89>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
X-ClientProxiedBy: MA5PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS5PR04MB11419:EE_
X-MS-Office365-Filtering-Correlation-Id: fa258280-5788-4b92-0fd8-08ded64945a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|19092799006|376014|7416014|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KJl3ycUQQj9bOULnEwGBYNKii7M7kWxSvCFWLjzxLLgQb39Y4IrpkPj5MOBT3ixV/FYWiOTyAgjuLoSX3G7hQulsG7NBBNPfr5mCbk646cTTytOXqN66Ym+TbAkHOcH7T9Woq+/F8hW877ICjwVEGrd9G+nS48/Tn+f6i6szPuPmsVMCGFu0SZ6z1k9H9rwo0riyC+rIY42wQ1RlPQHzg2ddQhXEVc3gNPYHJkzuSLGdoP4x3LpwWleiDJD5cLZkeWK154P7tmUU3laAns4A7UE0OWrFmXeDgjM9jgdBSrTqpL5fXlEvtPySdr1DDj6iKskzuhHdWtrXQKSQwhOyMT+0YblY8M2WK54EjN+FRy69zDI+aVlGJIaKE9SBaAMrxM9r/569Rje7o4p0bW3cum//H1ZOBs/drWqKJzSaSMFB2K6IJ9EpFbajbZkjSQVNEaaH9vyFMfFaaXnDIV6XkiQDA9BCmLEYN6HNLA1HaWFgWs6TNmp7iBXN5ulwov52yARYm+RL6E/hT+yu7nIeKCVfyjnd91HDNWTZ1AOtPQxNDYqcpqD9/L5jjbHTPLvbRt+Bz6zEiivTTDY6ide6Ojos7YeXexDVrSdzRXGWf8E+RaetmiWntO/jChhojMHO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(19092799006)(376014)(7416014)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?igh3+66dy4VzBx03dX0jBcyqnKSYqOZaaequsbcb7oP9b9scDkW7gv3Yq89+?=
 =?us-ascii?Q?+8QhloyxZAmE8G+BqV3u9alXTHWzPUpX4KbpmkhySB2eu1srfRSo4eC2ph4U?=
 =?us-ascii?Q?5BVCi7qV7H19FJUReI1R5Qr/X8aPG7m1zio562UVQBAumblAxso3wd3oiha9?=
 =?us-ascii?Q?zj7o9w+rkFNWmBRVHOuVgQQHSJNeb0bBRXBoIcd+h5xSXW58KSJDI5t1Djzu?=
 =?us-ascii?Q?wfhxHyECOHeIQ5lT2Q2KSaSvlS6uGrW0/mnvPvVh9Q+MpbmpvFgOUf8C8Jkv?=
 =?us-ascii?Q?s8H+Ee+H4BdJUUapM1cWN6he0p+gSbl+YRjbFxvA2PMdDQTim1MlcfEhKOfi?=
 =?us-ascii?Q?rYP46HyH9HdXuda8g1xm+DhilUfd+C6QsiB+nPR4BGcaYUcyTAlJ7HKg9P/s?=
 =?us-ascii?Q?jGfNTo/sT+R79U59Fv2cvMaFS2aYa65bzbewbOngV7U5kQOAqjGhiKO1m23+?=
 =?us-ascii?Q?1yAsmnFTw1aVmJa03K+wQz42zGFzsxp4ZKAHStKaJJiNA2xZrNCxmCxixb6G?=
 =?us-ascii?Q?6/LbSFh/sg5eGj5eRKfE/G0TuWF43rNDuWL4qnvv7rayA/8WuiBJCgLiOyF7?=
 =?us-ascii?Q?kCuQLNAEmbq9MCR7Pyybzu+2r/4IAZrZ0BtWla5V1QvHRfG36F3bl46xfmJ0?=
 =?us-ascii?Q?ySBoes3Mm1ujutoTh/X0Xqmw0BFSiNCIEtZPZiF2NrJq9VVpISk/j+sPYwlN?=
 =?us-ascii?Q?HAUvxfRvNJ8WvKHeXX1L+1UikVDsgzJp372qzJSG3joP4vBeZLRbjKuvKsz4?=
 =?us-ascii?Q?ADMXKwX0vkA5ALnd9AzSViE8RZvDWTyOoWAGjHuBXaBkTRossGblEv1ZAzQL?=
 =?us-ascii?Q?/q8g2yFEU5o0+DHnddecXxqJaVO6sbkhQ9DXMLEv5QEI52Bzyhjwx0hkoxEt?=
 =?us-ascii?Q?RsC2GXdunlatINsVZE1FfyVnyIV7In0cn/BY8W7VEpBkczE0pq5qzJ6ZmAa9?=
 =?us-ascii?Q?EZcoY5R/BCGh2NWmpsSiiKhiLoGOU2ZSQm1KjD89Z4dgV2mYFnK1KcbqW1Sn?=
 =?us-ascii?Q?tuhj+buBBn/8Tp61mYlQio69Ibc02FcapitH+mO0gBivgx9stNrRmSVm6iT+?=
 =?us-ascii?Q?hqU7wKxrTGmxOU0ogeyrOmqGR3+Y+e9+jFW4gyAaKMBGXspBsir3S90wji1W?=
 =?us-ascii?Q?rK2+xhGCzuSBgru3fiqLkX7cdgBhtHRU161gpVFCzCG8ZUPpY7+AwqWt4NcV?=
 =?us-ascii?Q?8kAyMFtxkEKf9wvOCa+NL67ZXP1m1NnBMxhDApzfwehBstcWOUegeh05ehFO?=
 =?us-ascii?Q?U4EBhtaRAmjEkv/dXM+sKfzX6gW23aO61h19Cddi84TbcGWYmKNZAbU+2nlG?=
 =?us-ascii?Q?W5A8H9TzjXNMCRt7hr+ykgauAnxeQsaoYyAOr4MOZd+N3jDhQQDtiGee9LWm?=
 =?us-ascii?Q?sOweORcfKppkFvNaKXiX/jYq+KQ0U1ZMkow7aysbVefPmfiIsAnajCVbrzhk?=
 =?us-ascii?Q?OLgLjdVP3ma5bNr28fwOwbHmJUbDidBpwtGbyCnOinFbEh72XosiYKnvMp9G?=
 =?us-ascii?Q?1NPqwI5hPN+xQXEDEn5v8BKxuiGBC7iFZXXqBcpGFyKb2fIR7Kp33S1xsTAS?=
 =?us-ascii?Q?LVee5bwSybPYh04VGxNpknnm+Ok+NjCcZYsmtNFqBvYVlxtfQIeVY91r2zqd?=
 =?us-ascii?Q?6FIFMPtvVyYlUXc+8GhNNNlYD7pgGTieOUEcqRqwylTIjhX2siy+IOAHTnu+?=
 =?us-ascii?Q?cDqTcqRRdSR+5ZoeKkuZI7raXEaar4E1S7OciF6i5ROCLPw9P6W9KIG09spm?=
 =?us-ascii?Q?AHbXpMd9GXXT1Yhf7AjdJnfi2D0RzNufhV3q0nqV3Bd9mNLlUpVT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa258280-5788-4b92-0fd8-08ded64945a1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 01:45:32.5858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/3Mlv1M/f8el8/PzArk2jEXy8tx8bn4sQsBkQDvXMgOd3aSMKwTjxRpNS183tE1rtfOoitseGaKH452WEuxcYsjhir3FxjK2c1WZD7wNricOyi/CRTnkUZrINCmBNtz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11419
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

Hi Marek,

Do you have time to give a look at this series?

Thanks,
Peng

On Sun, Jun 21, 2026 at 10:06:36AM +0800, Peng Fan (OSS) wrote:
>[V2] Just resend this patchset without
>"usb: tcpm: fix inverted poll condition in tcpm_pd_transmit()"
>
>This series adds TCPCI (Type-C Port Controller Interface) driver support
>to U-Boot's TCPM framework and enables runtime USB host/device mode
>switching on platforms using DWC3 with Type-C connectors.
>
>The work is motivated by the NXP i.MX8MP EVK, which has a PTN5110 TCPCI
>chip managing a USB Type-C data port. The goal is to support both
>"usb start" (host mode, for USB storage) and "ums"/"fastboot" (device
>mode, for flashing) on the same Type-C port, switchable at runtime.
>
>The series breaks down into three logical groups:
>
>TCPM bugfixes (patches 1-3):
>  Fix three issues discovered in the upstream TCPM state machine during
>  PD sink testing with various chargers:
>  - Inverted poll condition causing transmit to always time out
>  - Unnecessary hard resets on sink-only ports when source doesn't
>    respond to capabilities request
>  - Premature exit from poll loop after SNK_READY, missing source
>    follow-up messages (Get_Sink_Cap etc.) that trigger hard reset
>
>TCPCI driver and TCPM API extensions (patches 4-7):
>  - Lightweight PD negotiation tracing (RAM ring buffer, zero serial
>    overhead) for debugging charger interop issues
>  - TCPCI driver for NXP PTN5110 and compatible chips, ported from
>    the Linux kernel with adaptations for U-Boot's polled model
>  - New tcpm_setup_host_mode()/tcpm_setup_device_mode() APIs that
>    configure Type-C CC role and detect cable orientation without
>    running the full PD state machine -- appropriate for U-Boot's
>    synchronous, command-driven execution model
>  - pd-disable connector property support in tcpm_post_probe() to
>    skip the PD state machine for data-only ports while keeping the
>    TCPCI driver ops accessible
>
>DWC3 OTG and board support (patches 8-11):
>  - board_usb_init()/board_usb_cleanup() hooks in DWC3 generic glue,
>    called during child probe/remove to allow board-level Type-C
>    configuration before DWC3 core init
>  - OTG dual-bind: when dr_mode="otg", bind both dwc3-generic-host
>    and dwc3-generic-peripheral children; runtime mode switching via
>    dwc3_otg_deactivate_sibling() which removes the active sibling
>    before probing the new one
>  - i.MX8MP EVK board support wiring it all together: TCPCI DT nodes,
>    board_usb_init using TCPM APIs for CC role setup and SS mux
>    control, PD sink configuration for the power port
>
>Tested on NXP i.MX8MP EVK.
>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---
>Changes in v2:
>- Drop "usb: tcpm: fix inverted poll condition in tcpm_pd_transmit"
>  which was sent to list as a separate fix.
>- Link to v1: https://patch.msgid.link/20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com
>
>---
>Peng Fan (9):
>      usb: tcpm: avoid hard reset for sink-only ports on Source_Cap timeout
>      usb: tcpm: continue polling after PD negotiation to handle source messages
>      usb: tcpm: add lightweight PD negotiation tracing
>      usb: tcpm: add TCPCI (Type-C Port Controller Interface) driver
>      usb: tcpm: add setup_host_mode/device_mode/disable_src_vbus APIs
>      usb: tcpm: skip state machine for pd-disable ports
>      usb: dwc3: generic: support OTG dual-bind for runtime host/device switching
>      board: imx8mp_evk: enable USB PD sink via TCPCI
>      board: imx8mp_evk: add USB Type-C OTG support with TCPCI
>
>Ye Li (1):
>      usb: dwc3: generic: add board_usb_init/cleanup hooks
>
> arch/arm/dts/imx8mp-evk-u-boot.dtsi |  52 ++-
> board/nxp/imx8mp_evk/imx8mp_evk.c   |  78 ++++
> configs/imx8mp_evk_defconfig        |   3 +
> drivers/usb/dwc3/dwc3-generic.c     |  73 +++-
> drivers/usb/tcpm/Kconfig            |   9 +
> drivers/usb/tcpm/Makefile           |   1 +
> drivers/usb/tcpm/tcpci.c            | 778 ++++++++++++++++++++++++++++++++++++
> drivers/usb/tcpm/tcpm-internal.h    |  40 ++
> drivers/usb/tcpm/tcpm-uclass.c      |  87 ++++
> drivers/usb/tcpm/tcpm.c             |  46 ++-
> include/usb/tcpci.h                 | 185 +++++++++
> include/usb/tcpm.h                  |   4 +
> 12 files changed, 1350 insertions(+), 6 deletions(-)
>---
>base-commit: debaadb75013a6d3706a2137d540bf4660475e3e
>change-id: 20260617-tcpci-dwc3-653a5d9c8893
>
>Best regards,
>--  
>Peng Fan <peng.fan@nxp.com>
>
