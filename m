Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD1DCD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 23:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD26846DF;
	Tue, 19 May 2026 01:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="y7C3lsXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77493846BD; Tue, 19 May 2026 01:51:30 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B1BA846AE
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 01:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZW50z8IV2uz1EmjNf7oDzzUP6exJ6D1qY8HFa8pqTb7JbhsN19LuPdv7+c3S+NfYsny8Nlc74TW1bP9W623PFTRgBLQAKBMSN2ph5Nc23yFW7xehqtvUAM+11MwBX+BzDSbUp/r7gbzx6w/fBiebHn5h0K+oBPjcmBv2fd8bYYAFYmtPRILKOIFvkxpTFE7n+mfeVC3iea2NaNGfVRQDU1+qkGjEgcjpSQV7kZF35g+C8NdAJyezDdQ36A27KjGd3gyWwHfgQ9gzV9vP3Q5Ju1/91jgtyIlJl9hFsrs1/lA8e+f2Mb9P489NzlKQ+xNdGddcsxQ01SlSHb+LI+pFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQfe6TzWHMbVpxkNm+teESHcZI+NuhruUIfPE0kmnFE=;
 b=heYJJYcRQF7Up/LNg1+qa46bFGu+xLlcb48h0MMrovNrJe4WR62/mj2O0x2IYjODPwWMcpTchfJ/Sd3WmXFNH+0FzH87hzPAhefmHCgQTWc9x7Ji1esiHX9H0LsbkwmcwMIkT+BvbsjOiVJoSviz33peU68LfzdYUsmmsOzK0Xvl4PlrbAt0PXMwWVzERxZzB1m8xrOYBI4/1joOdgi5KYm1VJeP5Lxvap5w8+RYzMaPoEPZ3yggaQ2C3PIWSwl6Anq/DPjj3X5uffVVsXZCAZhtCH8Z2FL6yo34zpAXpILnVceTrk5AHqTx5Y1rh715p47V3j0po7tCqPklgkasYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQfe6TzWHMbVpxkNm+teESHcZI+NuhruUIfPE0kmnFE=;
 b=y7C3lsXtiZ+LQ4k6segMMeO9ytTHqcba7GbFKX/iOxyLODIOQ1HjWBhc7VxsCEBqAauCXJ3DCVwSj9On/ZHWcgRBWej4cD80KFLtNcmUUH+t+3A4aMHuax/74czzDJN05EltsGQAaqMIGWrTvk7Dv456Xw215YLU+nPntK/RZEa9lVBQboAYjIa/OxfVDqRAWh+LUns+ooTEoCuHtnZBZL2bC0smeT62VbBfrkRoi4mkytLwbqEZWNRGg8Ewm20oG0DMFJHNP0goQF5rODm9j7+9zk+BAxWJ83nzDdEuVr8N/+KNTCJVEpEEB5X4Wsi5JYvelGWAA2+UNuzhomI3kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB9PR08MB7794.eurprd08.prod.outlook.com (2603:10a6:10:399::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 23:51:24 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 23:51:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Dan Carpenter <dan.carpenter@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v8 00/12] pinctrl: add support of Airoha SoCs
Date: Tue, 19 May 2026 02:51:03 +0300
Message-ID: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DB9PR08MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 434445cf-6970-4204-251d-08deb5385e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|52116014|18002099003|56012099003|38350700014|921020|11063799003;
X-Microsoft-Antispam-Message-Info: 4pF60fPUCGYVe/rf4BKdiURnn8sU+QK/Cm0aGP1tgI4mh4KAsVpFXDWZrw229KsqxaugR07jgioDgy36Cl55NeXm8X8ZvQkjZ4tFB7tclpP67AYVYg71HvMv4akjwQSpkE9RHeeEkS8lXPnSCXnINrVNkJJpx5OyAOrc7f01/WRPj6q00D1kUyM0W6FAqUBo9Gt5e2oSslv8tgd+wJYmBUvYcAv1NsY5Hwfh3NgpRGnDIpakNh7qGdrcKQTISbo8LPvH59SnkeSFMGF5VjLm5oyuIIrHD/MqM5Hr0KJctqRbm3EwYwNOsYjmtj8hOv2P96WAsdSOMeZpqcTrNEO3puvgMHKd/d5REYsHZ2pNke0KyJ8gtBYtfMnfQErZc4/8gaKDNzSDy0d8CeohOPYEsFt2AHgWxdYXsGWP4x7Q0IxaPb4c28HRMes0nZZnwIYFFSF3Z/Tl/5wm4y2l0XaPkWUNecAn/yru2mh/RUl5n2fPx2t7PSExKZbJxI+j0zlAP6jk0cMKaGHilxZDs1J86t30qjmveNhsBt0u/5J1tCv0ZmitBXI6aemfh1ldBKj7keF2FjF2xYneiBbJhHjJEUsnsn1E8FEIXkFOdu2CzElAt1pGwh2UYjAJdj/CQ08IXMMIarz3KiQIVs6ODVNY4QQvReAEFih8tQgMJeWQr28uGBvKnfZFXfh4wLb3P903GQVfX7718RO80pfvLapOwHDqy7veFNzT45TicLipr4t3Hd89FPCKEBV/Gy8SzMknukVmw5auTPqst45lyjH5HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(18002099003)(56012099003)(38350700014)(921020)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVR0Z251YzNRNGgydjdrRW1XbFZCNi93OWxHL2NLc0VwR3ZmSEpleEZINWpK?=
 =?utf-8?B?bSswbkx0KzB4alhVVDViY3B5T0lEdGN0V3FGZldkOHN1U3oydnB1ZXpIQmYv?=
 =?utf-8?B?eU5LdGNyLzVBVEh5Um00RUpjbHl0b2t5Um45UWxMVlhsNkJyN3cxWnZPc0x3?=
 =?utf-8?B?eUNjcHBqRWVhbkZRalhGYjVWMDVRVG1YODFOY2ZRMCtUUnBQUjUwbnJDOVpP?=
 =?utf-8?B?WXhCSlE1RzEzWEdiRXgvWWRpS29nYU5DK2xCZmZWYmZTRUFURTRnd01hZDIz?=
 =?utf-8?B?QlJpNU5icTRoSTNzd3dxcWswWjRCRERuNGEweEI2NTFENUtnbm1RYjZvdGRV?=
 =?utf-8?B?bnYyTys3MzNUSlJjbHNjNTcwM3FFZndkN1pQaHlVSGxuWnZ4eEwyVm5La1Jq?=
 =?utf-8?B?L2FOeTNac250bHBhZ1ozckQ4c0NaSmh3eExHUTRlWnJyZno0UGpHS0NBSE1l?=
 =?utf-8?B?dzFSd0xVTmVyVmRnZWtSbEh4T3FaWjVaWWdSMkU5MWlFd1ppa2I0aks1c2lE?=
 =?utf-8?B?NzVuRTdNMllSTytIYjg5ZFA2Q2JLZzhaVjRoMjVPYTZmMGJCRG9aRlM0TGpP?=
 =?utf-8?B?WFo3TWRmN0lKRzRXbDFodFY1OXQ4endVd09OWDl5UzZDWngyOCs1cGhCRDlM?=
 =?utf-8?B?QUViU3JVU2JNQ0JxclloYnVodkd2ZDEzajF0dTdMVTZ5aCtteEVJT2d3akta?=
 =?utf-8?B?Z2dlOUVwclFTK0h2UlhVMDgzMnhUSFFic3NPNHlUaEpwYnhmdUZRdCtGZ2xH?=
 =?utf-8?B?by84eC9XdDlmRkpRck0wOEVjemFJS0xHdHBSd3JVeUozeEJQUkhySGp1emQ1?=
 =?utf-8?B?UGJkVXFhNHB5VGhLVFlLanAwVHRqaEFOd21OWHRBa1IzR05CS2s2MkdLVTd5?=
 =?utf-8?B?RHFTMmVBWDNVWFhXdkJJejYvcVpXdEhMUmZoS2VlaUFubUsxa1poWnB6SFM0?=
 =?utf-8?B?ajBNUDNYNS8zckc5MWFndGpSWkgxcDhvWit4YkV5OEZpbTlSYmlNZ283bnN0?=
 =?utf-8?B?Uyt4N2Z2bC9OSEwrTzM5ZlR4aHgvMUFhbXFBV0wyMCsra0lCMVBQZWsrUWZM?=
 =?utf-8?B?V2VDc1NSVk5YY09lYVVvc3ZpZnpjT2psSXpOTWp5NjZVTTFFQmF3dUk4ejNS?=
 =?utf-8?B?Nk5YUExCbFdLVmFDbmlzalgzYUtrK09jOEFiek9Vd1hHZ3lOSnFuYjNiMlNU?=
 =?utf-8?B?MDlDZy9UZEdWbFpLMWQ0RU1pNnZiTnZ0eVdqTCtRVWx3bVdYWDNsaXdTaTQ0?=
 =?utf-8?B?M2hkRlplaGhwU21idWpYWGRGc05VaDBoaDUzdStWby9Mb0tMYXo4Zjh6di9s?=
 =?utf-8?B?bUMrejhBRkRUQjhxTTNmZ1I1K3RMTEdhZjJDK3daZlRtNGpIQzc3dDQrL2Va?=
 =?utf-8?B?VWRmY1pzUXVVdE5FenhWeGwyb004alltcTNoMDQ3cUtOR3IrUUY0R3ZORzFJ?=
 =?utf-8?B?V0ZqdXQwaXZPSGZVTGJXenlLYjJmbGZHZGRvUnp6QWJoLzFUU3pxa2NVZG1r?=
 =?utf-8?B?SGx5K2czQjJ6dnVUYll3eWxDd1dVTWdnOW1SSWJYSUpxQklONXNYbzlscUZH?=
 =?utf-8?B?R3k2a2hnVVl6aXY4ajhkWGI0NFFaV0RBd25nUmJiaDAvMVROQXZETjRoY25k?=
 =?utf-8?B?NEdVRGxVbmFSVjhTZGVMSGV4eVkvdjc0WGZwRm1JbjVxZlZoMlZEc291Q3Rl?=
 =?utf-8?B?dEE4UkZjWkczcWR0UG12S3grcVJXQjhMbnh1T0dFS0JlZVpLM05zUHdkWU9p?=
 =?utf-8?B?cHh6M0wzSlp1REQyR0Z1RFpwb3dRTXU0RWQvNEg0WDVMNzNMckJqWkpHZ2hD?=
 =?utf-8?B?Vmo2Um5TWHcrN0ZzYWxpNVg5TXdhRWJYdUFsaUFnQ2JiUVh5NDBQOWRia0FM?=
 =?utf-8?B?R3BleTBNb0JSOXJSWDN0Q1hpaEUzNHdweTg3UktyVUR5YVArTVdsdVk5Qi9j?=
 =?utf-8?B?aVlRZ3M1U2tIS3J2U0dHS3lpaTc2R1A5WGl3UjFRMGZQVzd5SjlMeGVMRWdT?=
 =?utf-8?B?aGFhUlIramI1MmRIbEFyUWs1SHlPb3NJb01aOXRxUEtZZ0hwdmVhYVN6SHo5?=
 =?utf-8?B?cEdtR0ZMQ3RqVzBKenNNSU0vSVVjVUM5Q2JhNU1ERkpoVFFidEEybTluSWZ5?=
 =?utf-8?B?Y3NrdEJaK3g2R0MrRFIrdjRrV1E3eHNtdk5GcmZtNTZ5cnlyYmJYNCtENkZQ?=
 =?utf-8?B?L3FRUzRNdWZhdDhpdWZjYk5za0MyeXp5dzRxRHc2bGFDQTN3U013NCtQV2R2?=
 =?utf-8?B?VTZRcE5kMjZKR0dlMGxCMm95aGZ4WmtqOG1qS01IbFl0S2FJMVZjTEd6V3V6?=
 =?utf-8?B?ZGJpN3lOeWJjaVJmMWR6Q1dZS0FNSm4yaDl4Z1VybVpQZ0hqMWlEZGY1dVJR?=
 =?utf-8?Q?dUVRS5DNxtQTC6qM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 434445cf-6970-4204-251d-08deb5385e5c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 23:51:24.0618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqE9kuInwmARINOa45OFOEj/jc7XsywsRrqmwpWVgLe0XV9lsSDmN9HA4SoSszPmPQSz4wJGvF9V8xmSoFwGnzRVsCv8HxLqz+CNux3qdTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7794
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

This patch series add pin controller and gpio driver support for EN7523/
AN7581/AN7583 SoCs. The driver based on official linux airoha pinctrl and
gpio driver with Matheus Sampaio Queiroga changes.

The original Matheus Sampaio Queiroga driver can be taken from the repo:
  https://sirherobrine23.com.br/airoha_en7523/kernel/src/branch/airoha_en7523_pinctrl

Additionally in the EN7523 case the patches removes existing gpio dts nodes
and replaces them with pinctrl node. It should not be very dangerous, because:
 * No official EN7523 gpio support present in U-Boot
 * Legacy Linux EN7523 GPIO driver is mostly abandoned
 * The same driver is planned for upstream linux/openwrt

This patchset includes bitfield.h patches created for Linux kernel
by Geert Uytterhoeven. It suits U-Boot fine. I preserve original author
and original commit messages. It might be not a best strategy, because
these patches refers to other linux kernel commits not added to U-Boot.
Please note me, if there is a better way.

The patches were tested on EN7523/AN7581/AN7583 boards.
---
Changes v2:
 * pinctrl driver was split on common and per SoC parts
 * EN7523 SoC support was added
 * EN7523/AN7581 defconfigs were updated to activate
   pinctrl/gpio support
 * Board/SoC independent pinconf/pinctrl definitions
   were moved to global includes

Changes v3:
 * add non-constant field_{prep,get}() helpers
 * put airoha common code to a separate patch
 * put en7523 dts change to a separate patch
 * add support of "pinmux status" command
 * address a lot of comments from David Lechner

Changes v4:
 * minor refactoring
 * fix gpio initialization, so gpio driver becomes probed

Changes v5:
 * more bitfield changes
 * sort contents of pinctrl makefile
 * address more issues found by David Lechner

Changes v6:
 * pinctrl makefile sorting/formatting was moved to separate commit
 * replace 'tristate' by 'bool' in airoha Kconfig (thanks to Peng Fan)
 * a bit improve menu entry names
 * add an explanation why en7581 prefix used for an7581 chips.
 * add reviewed by David Lechner line to all patches

Changes v7:
 * an7583: add missed gpio22 pin group

Changes v8:
 * replace en7581 prefix by an7581 in the an7581 pinctrl driver
 * sync en7523 driver with latest Matheus Sampaio Queiroga work

Geert Uytterhoeven (2):
  bitfield: Add less-checking __FIELD_{GET,PREP}()
  bitfield: Add non-constant field_{prep,get}() helpers

Mikhail Kshevetskiy (10):
  bitops: import BITS_PER_TYPE() macro from linux
  pinctrl: add more pinconf/pinctrl definitions
  pinctrl: sort and format the contents of the makefile
  pinctrl: airoha: add shared pinctrl code
  pinctrl: airoha: add pin controller and gpio driver for AN7581 SoC
  pinctrl: airoha: add pin controller and gpio driver for AN7583 SoC
  pinctrl: airoha: add pin controller and gpio driver for EN7523 SoC
  configs: airoha: an7581: enable pinctrl/gpio support
  configs: airoha: en7523: enable pinctrl/gpio support
  arm: dts: en7523: add pinctrl/gpio support, drop legacy gpio support

 arch/arm/dts/en7523-u-boot.dtsi         |   21 +
 configs/an7581_evb_defconfig            |    2 +-
 configs/en7523_evb_defconfig            |    2 +-
 drivers/pinctrl/Kconfig                 |    1 +
 drivers/pinctrl/Makefile                |   61 +-
 drivers/pinctrl/airoha/Kconfig          |   26 +
 drivers/pinctrl/airoha/Makefile         |    7 +
 drivers/pinctrl/airoha/airoha-common.h  |  476 ++++++++++
 drivers/pinctrl/airoha/pinctrl-airoha.c |  927 +++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1078 +++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7583.c |  980 +++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-en7523.c |  813 +++++++++++++++++
 include/dm/pinctrl.h                    |   28 +
 include/linux/bitfield.h                |   95 +-
 include/linux/bitops.h                  |    1 +
 include/linux/pinctrl/pinctrl.h         |   74 ++
 16 files changed, 4553 insertions(+), 39 deletions(-)
 create mode 100644 drivers/pinctrl/airoha/Kconfig
 create mode 100644 drivers/pinctrl/airoha/Makefile
 create mode 100644 drivers/pinctrl/airoha/airoha-common.h
 create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-an7583.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-en7523.c
 create mode 100644 include/linux/pinctrl/pinctrl.h

-- 
2.53.0

