Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C779CD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01AF6838BB;
	Wed, 17 Jun 2026 09:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G+9gL+iJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4553D84704; Wed, 17 Jun 2026 09:05:59 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A0A803F0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kF3lozpM8kaKl7Pc7RPFYD7Tffw/jwL+IwMiaQOMw9t3aMhufR6HHnujA+B4pvv53A2o6XzivVa6VvN89RqeeQ1RV6JkDcpX2goVF4P3x0K1IcQWBEtanQJx4Zy/eN8fPM9M5yNQ5M/U9RR0a+O9UN82979yrDpLP7cNV10RJa+sKFKdie5xNajlXFYL3A7PBixKMfA7PCIXbtvnDs/1XiMKFKMX/5SdF5G3bKSHP3zo6JeNl/evdVTzoLermJKx+QVTVS6QUgDTFkbBaJ0ZG9N36B/B4hskvIxc6iJvi9z6JU9XqTSJS4XqppzIxte9T79axpKG1z0+3zecSSmJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLWFCr0zeYyqtb8pM7i3r4TYJr4kOApjNAVKAmLg+WI=;
 b=QMq6JjSpiN49iKZ+EQmhfUGKPK3XDR0sPn9dvF2ySAP6vYrA7DD27TcJrnxapYmLU4/c1bF7Jkapl+fP+BiSL49f3c5OJEsiMJyvd0I5zMBy0AHokZ3G86T6CtApQyeqK2nmxLyKOJ/vvbIqMBmsy7bTCAsHrAinEAn00NnZ72NKAHlnJEmeX/P113FNwRpqRpXoFVwh3r7W9544Te8SU0y81BX0vt/7bp6sJ9nOMgg9MoraT7G1B1RAoLPLU8c0ChScz5Tqowlti2bWib9Xl/sovGWEGxkgYtla/9xADupjpVYM6U22GZsCP1G56+iZmO2XWFEV7GnIJbIotFtx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLWFCr0zeYyqtb8pM7i3r4TYJr4kOApjNAVKAmLg+WI=;
 b=G+9gL+iJR94CleqY/Ahu5ionzswAHMyZwWyBjevTeQzraWty8b4on2I2mM/yTfpdSa0Uqb9UHlOAgC82Vya/iAtpE9P02O0lZ0frHwrlhCPsyMxu91aXI4HtybedsbDL2XxIAyKGqtyTbFWUBIVGaghaT7b+xJlnpHwirvOT9HTea63rUwbxKkuS95uFvllYT5JcS8g7Uuj3gwluAONOHgdVfrBiSRv5tLp8XDMKhgZNU3w5gSqnz2Tml4kyDzU2yeKrEBcgt99gG9Ci4CizuNBJZ4gUcZOqsgZ9pWqrungFcalJ1w0uJGrn+yWmxLAx4wd7iEyhRaIjykxFCfodRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBAPR04MB7240.eurprd04.prod.outlook.com (2603:10a6:10:1af::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:05:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:05:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/11] usb: Add TCPCI driver and DWC3 OTG dual-role support
Date: Wed, 17 Jun 2026 16:22:59 +0800
Message-Id: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGNZMmoC/yXMyw5AMBBA0V+RWWtSmtbjV8SC6WAskNYrEf+uW
 J7FvRd4ckweyugCRzt7nqeAJI4Ah2bqSbANhlSmRpokEysuyMIeqITRqtG2wDwvFIRgcdTx+c2
 q+rff2pFwfQ9w3w98wxK+bgAAAA==
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
X-ClientProxiedBy: MA5PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DBAPR04MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 25353a1a-853c-4238-57df-08decc3edeff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|19092799006|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 5FNdIQTSGwhbGaR+goMPpxVzgI1jSe4uBxHzQHmI8j8ebE6JV9KtDdwkDfGFHO/dr/ni4DUQLLlG5UQEVav7NOgkAi9hd88M6LIPi35XlMITjPsUUfJn8XlaS/vtLWdayaeSZbbdl3ORSVOLHIibYUXPVoQkRBrFQTX3D+t6nHZh/vTdCmiQ7kMGWoWUM9LwgXOmhYWPHL0Hz4MfXMMYE0DkHFKrU0LasVkCYImj0N9Ow3/6LT9bdyFa5Q0bbYybIi2UT55oyc5EpvyqE9OcpSbg6o709Rm8jwciCmp2o8/quccvap5+2FD6Fv0cYcTwoa6OC1xMzuG0ZQ02LXlsV5Pi7QhqWH+yaoqanyUu/15KB/+7frzohrOue3Cp6p2arvwM0cv7E4nBHs0nC4g0L/Ym7dJEN4XfaCnvbR/+6ZnUpLpkBmpQaMEOYXrrbV9WHZ9EwCgs45PXlkTjbPzVJJqi2bNWc+HncMZiab3vLn9dWR3zIB0TX0wyDCZsE1ahlGdNu/NH5pXxHx7DoNADKfBK6zLa/lbTxWCpQAOdsrBSIxKNxHaQ+17fl9MgyXn20dWLGTgbcnRwUS9HSNlMRcDhGJ6zY7jn03QTtwerdbYkIP7pA5DrOLHMawkZT6r3cSXEKjOU3b67nEViEkdWGpqccTzFiDbxqCBVSbgtPfx08R5Fr3YHTWSBTP+BLHqh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(19092799006)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWFJR0h6a1FjVUlrVENHWGIvbi9sQmhkNWFrWGJFR2drMzl0dVFPMFoxL0Ru?=
 =?utf-8?B?M20xOWRsT3ZEREpZTEpkQWZmbFAwMC9FZ2R0dGpkeWh1QzBxM1l2eHBPUnVq?=
 =?utf-8?B?NjB4bFYzUUNES2JyR2h1WnhEWWtOZktFWnBaTTI2R0s1dXZISldjSUZ4YUds?=
 =?utf-8?B?ejNGLzFZZnQyaUlpYTJMa0dWajBrRDJwZE9BNlExTXdSRGg3TmVvQm1VRGht?=
 =?utf-8?B?ejB5MjhsMFE3WGlvczBSbVNpbnFKaVJwVk5aQTMzbUQ2L1BiWGNaK2xWSFBp?=
 =?utf-8?B?RUlrUEc0R2ZGOGE5Wkx0c2hlQUJaYzQ2RjJseXN6NnRQUkNGcHFJMHJ4S2ht?=
 =?utf-8?B?SzBlSnNCeWFWYytzQlYxbWozZE13YWxob292c0hvb0Y0SzAwL1lxWUtQS09t?=
 =?utf-8?B?VldTeTNZaVE2ZUlEWi9vd3ZZOElKSFRiT0xCWU9XeXZ1Vnl6RmVvZjdYMGxu?=
 =?utf-8?B?cE5zd1BJcC94c0ZiQnJLUzhoQmhRRFpvRXM2M1hUejhzUldxYmRzVHk1c3lK?=
 =?utf-8?B?RHNjdWVBZVY5WmtvOW82QWh1dDhlTXA3cFJrcmZ0NGdLN0xMWHBKdDVYRDNI?=
 =?utf-8?B?OUZ5YjZCdVhTam1SR2tSK0JQMllxRExGd2t4aFVQcSsyZ3lBai9WaXhSeUJM?=
 =?utf-8?B?dzY0elhDWlBXRHBIQzhVK0crTjFJdHUxbnhqaW45T0E0dUk0WVlyWXUvUXFz?=
 =?utf-8?B?SkNCNGp0cUZxR2trY29Dd09CVUxueklJV2FncHczakpxVEptT0liN0taNzUz?=
 =?utf-8?B?Z245cWxtajFWQzNHLzRObmVHaUxtNFRqWVAxRGwyVWY1OStnSWxUMXkwclBK?=
 =?utf-8?B?T1pVQzJjdTJqU0FJeWZiUStpZWEyTU52bDFBSTJFR2E0UkhxNjhRY0IyL3FJ?=
 =?utf-8?B?OHk4bUpGaGlyckpQRXE1bWpvNHdxeXU0WWhSbTVKL3MrMWlnTmVCQktjYmlI?=
 =?utf-8?B?RVExU2M5d0dWbE9qQjNzL29jcVhUeGh2UWhxT0FxY2pwL2RiQzNZZkFiQjR0?=
 =?utf-8?B?Y3AyamFBTjZhRUljcTN6SGNsNzd5RGNGYnEzR3NlZXl4dnNhNXVMb1ppM1Bz?=
 =?utf-8?B?Y0lYem1pOWZVYXROZ2EvRUJiL1VhZ2JsOWdacXBLeW4xaW9NblZOajVleis3?=
 =?utf-8?B?b01MNlhBMi9wMVhUcU84b0psdkQ5RmpGSUpqT082WVFyRGx0QzFKTWRpNXV2?=
 =?utf-8?B?cjN3VjdEWnN0dUtrbUpTa0VHbW8va2FZNUVKVEwvb21TZDYwU0tGdmxFTTc3?=
 =?utf-8?B?TFNXTkN3NUF0Ti8zMmV3Sk5haGdzSmxIWDNrNEZMa1c5ZlhncUI4emowNVFE?=
 =?utf-8?B?ZnhZZXhRMmo4d2I5SmVXM2MyaGtWTkpKNUE0clJ2S1NXR1d4V3BJSk40azFr?=
 =?utf-8?B?ZzlCd1h4Sm5BZ1JnVGNGQjl6N1VjUGNkblZzbmVMbjNORmNzU3h0a1d3QUtO?=
 =?utf-8?B?K2Y2d2VyclN1YVUxZ1I3cXVKRjE3cmNKeHlVMlFLdFo1TEtITDBMRkFpZS9F?=
 =?utf-8?B?blFjRzE1amh5N21GQ1NyWHQyNUxyMFlYa2lmZ3hNTzlUQVR6S29zby9uNEJt?=
 =?utf-8?B?NzZZOG9VSU96NEVpcnVCN2EvOEVRUDBMU3BJMXBYK1Z6WWRZZzRpeXR0YURP?=
 =?utf-8?B?czYvNXZnOWFQTWhZdllkL2h4LzJOTlphVmltRm9iUFozRExpQ0pvUm53L2hn?=
 =?utf-8?B?RThRSmZPejhPMFBxN2ptNWVXZXB1SHpmTnVpam5JRE5IVUJqSnFmd1NDMDBZ?=
 =?utf-8?B?bnp5TTBLUndROGJ2VHk0YngrTXhUUXp2czNLVS9DM3NGNGFuYUFqQ1RObGpZ?=
 =?utf-8?B?MkF1S2loOVdHb0JsTVYyTnplcFhFL00zVTlGQzJub3liVHB1blpLMnRENzZN?=
 =?utf-8?B?ZllXY0ZXeGpra3V1MFhucTFvL0k4MXAzYzFzbTJkRkdvWFpKRmRWTXhQaW1i?=
 =?utf-8?B?NnJNaXJFOUpsazJlK3F2Z1FZdUludTExQVY4MEVvNmw2RUJWejA1TGxKaUE0?=
 =?utf-8?B?cWlpSlRrYmZRd29LcGJ0ejdaR2dzMXAwK1NSc1EwS3Y0eUwvVjZqY2FROHJ5?=
 =?utf-8?B?TUh1d1RnRE5ZOUxCS1JLYk5VdzJmUDV0VytRZ2Z4bVY1ZjdLakNUYjhxcTFW?=
 =?utf-8?B?bUVQTStkb1F2OEk5UmFCQytGQ1Z2WENqWDNubTBzWEhRMEJpQzcwdmlGeWJv?=
 =?utf-8?B?U2ZzREIvakVFM3dEcUd2Z2k3Mk1IYXVWT2dmYmJOVnhUVHZkcSt4Zk02Smxk?=
 =?utf-8?B?Rk12d1g4VXd3M3dWOUVac1JUbm1DQlEyL3NYTzhQK3p0WXFQR29lZU9tR1Iz?=
 =?utf-8?B?R3BuZlg1VlhDRzJKdi9NWDhlbGU4N3VOZ1BsZG50OGs4NW9DUUEwT0RnSFVl?=
 =?utf-8?Q?YuNy6lIh/V88OEa+E4G9nYkvPMbl+ZEy/sTpp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25353a1a-853c-4238-57df-08decc3edeff
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:05:53.8798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gU1s2uQ498DFQjofGrY2WiSnUKDsVKU8hL4S/bBm+1HB75Kzjjmv/9bzZYl9DiL5qfBjrJ39NsrTrsMS6eD/3/VE5Spp1QqJZnpxEgfb+JekCLJyf5N7/W3KFZ0DvlHs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7240
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
Peng Fan (10):
      usb: tcpm: fix inverted poll condition in tcpm_pd_transmit()
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
 drivers/usb/tcpm/tcpm.c             |  48 ++-
 include/usb/tcpci.h                 | 185 +++++++++
 include/usb/tcpm.h                  |   4 +
 12 files changed, 1351 insertions(+), 7 deletions(-)
---
base-commit: a0a1e9f2f1dffed04ee52723ce957c07bb905c25
change-id: 20260617-tcpci-dwc3-653a5d9c8893

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

