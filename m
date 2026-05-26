Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570A9CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 00:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A4A384940;
	Tue, 26 May 2026 02:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="IfFO62Ip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 021AE8490D; Tue, 26 May 2026 02:25:53 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B1D848E7
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwTATBhUtt0KMJCTZ0Cxafq4JFLwvuxIK+d/ZsYGgaM9MfKdtYsErBenZUd6ne0CBMhpb4+LbFYr/t0zvuntiPbH3Cq1UTKHoBkAEeG37fL3GvZDhiXkRtV8hv6KmvXBGFv/0iSVZHa6druusZiqC5nRIKkoYY02KJxPPjCb04RZ22YF6M0KXcQ8GPt8G2rSquh0ZJ88tP5Vdc1MTYpm4cmj8uCLOB50EaM4I7DNAzLT0aWDbPp/qBgbiyNGPZr3YjzlPZmXneglNaPXz7gDUl28/gNy/uys1E7c6OLV+ygDkHNlj+z4/UTH5WP5SJo4iwX9+hDFrgjriC3SZ5sM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIqccXiHKwqnZ3kj9HH+7sE+2IopicxqNfirc90kqeU=;
 b=cUF3DZu3uSWve32vkugxXtLnjgV2KNrdFv0SJsi4dpIUTrFaeONkTwSFSDTLLGMuin3V6TafkyerTBK0KkBvf9fH6csIyngQG4RsTicVuYLb2hLrGoqjsRCZ2V0RYR3zbpjE3UVHdsYeNFs1tk+7HPSsUAMmHyrCnpS2jV0J/YDafhK2rYYz81FzqpytLV4OlsnF6Haba6ZtVf5XHiRDPdnOTtqiMeGbyPD+jLDhIMyVGv2VUbB8L+DRBBTvp7Hk22dDfnti2Uj52VhcNp37NZKFMSqC5Ueel9LKNEY9pAqK48vF6P/HRRo7zrrON/rHB+z2/ATgWsDwakXuyCxrFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIqccXiHKwqnZ3kj9HH+7sE+2IopicxqNfirc90kqeU=;
 b=IfFO62IppAdNHwQWclxQ+8R1aG08GpgIKHJRO9fOwN3jgQoJURyuQ+O4alDOYpaPBgdL6eKLlGOiHilaOLCDPYrMe8e+eD6wJblwpFPoaxm2V9/YgjukYflLJmnOZyMHQiADqr+Na2B2KpB2D0f29tHoMYTkmAGFSyL0u0mN1lNE5U0j0sHdvnwUH8C0LmtRhknHli9SkaHVKzKuAOSOOw9GkIZJrA9Dyefou6NspY33SEJrgURJZDFihMkLKYBoyEpbaGvLeHR9JP0JEIZ9UEnl/0IwjdmzRzwnk2m1TYUDXbbpySXn49HW9VoKJbCvNuYaZacmwraktHasgp0HNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB7682.eurprd08.prod.outlook.com (2603:10a6:150:61::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 00:25:45 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 00:25:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v10 00/12] pinctrl: add support of Airoha SoCs
Date: Tue, 26 May 2026 03:25:22 +0300
Message-ID: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e844f11-03b2-4861-3661-08debabd537e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|11063799006|6133799003|18002099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 75eiLDtKbNb7IGaysgpWKgzvAsE3S0RDxd6rne+dNX//WWHa8znUcTRky57qI/UFf0Qu6xYhhhyYuFLrtG+N1vtTxY8FHoC1dcJGL9R9/OfC+UVeKJ2qggGXWWEhws8FE65c62lehiGomSQhat4b1N+kuh36kZhPzkrhxs4w4Eel2nnsxT+tPV4HEcrMDA24pbGQ3E4N/Tu5Tcms435wGEwDHV75/f8UVlDIFUNkJQlAJbwFIz8WYg7v9S0t8hEqa1hkz+qX8x1yOISCnqlc41yUibLEG0E22663cGH+VYeaIBLsKQqbY75zLITVunrMTi3J26+yKKo8BypZ5eJchfsAoUfv/gGusdBdkXpgVYcC5VJ/N2GvbgMDC17Ff1aB9k28wRYMgpo1258LYsOe4i7LQkh9ODw/6a4ntAQpBTQiwYm/vmF1BWBxY5qytU8kDd2CeJ0kSYiOr15vaSkzU5h7kCahMMGxnhCB9xrHvLhII8gvA6WZZzbwLvDZNCB7xmd2PdOgo1spPlqz8J8Rr4VmpgwYuYdzDX4rzqf0gitQ/ve0dvJtFl+ouYGLFDfgGUCwEymNxJOUGdMy2p56zAfCYM465YNSTlMPgCsHCDT0lTRNbDzySr7xm8YGUJqzwenkhBo4aNOJ7xo+YILow6fBXsb2sqfxSlEHfiAO2nhPjdCDSWxx7cSFJWuiCQCC3JZx7YBYOBuC6OOncklGpYTNxkAT3At9HiQOEmpNUx7egZa3R6lNyZx/w3bjPkCKTNHq6CXAxNSBf5VVhuMqoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(11063799006)(6133799003)(18002099003)(56012099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzNOMkFYN0JWQ2FGYlVFVlQrdEI5UEJDYTRjMmFwNWR1V0tZRmV2T05NKzNl?=
 =?utf-8?B?UmI3WEU4dTlzTmQxT0h1bVl1LzhwajRRY3p5TmlEZ2FNQTdkcyt4SGl4TDdZ?=
 =?utf-8?B?K3lrbFJ6dFR1eHBIYUE0NldGaHp0T0VZbGE0WXdadnBWOWZFK0R1dHJvQmQ3?=
 =?utf-8?B?SU1sN2dTY2FXUjFIVEpRMFFoMy80c0padVg0UFo4R1pad0UvVUJGcHNBWE9R?=
 =?utf-8?B?VFhvblpaZ05iSk9Ta0JtV2Y1R2FRQjFNa0c3VXdlbTRDT29ZcWpGMmlMK2lG?=
 =?utf-8?B?N3JBcU1xbE82OTNtMEpnY2t3Uk5EWTdaQTduM2ErQ2ErajMyMkptb1doQkc5?=
 =?utf-8?B?dytKKzNkeHlyS0cra1FUbWg4Y1hLUTRITTVGU2N6Q2hITDI3VCsybi8zamdi?=
 =?utf-8?B?Uy92bUl1WFAzZkV0VHpQZndKclRmUTFLcWJKZVYrbWpncU9YWVNQSmFZVG40?=
 =?utf-8?B?eUhmYjdKRllRL21KemRjN0liQjVHamQ0Y08vVGJURjJRdkxVTEt5MGF2MjRM?=
 =?utf-8?B?R0FueGdJWU9HT3RJaUl4M1d6TXZWMC81NVFlbUd4dU9kbUdMWm5GVW8wZXc2?=
 =?utf-8?B?NTZCcVUxMjI2NGFtMWZtMTA0cmdYanVweUoxaDF4aDJVemtBaW8rME1SdTRy?=
 =?utf-8?B?a3plWHdodVZlbjdQUERhVmgxYzh5a09hbllZRnNEdHNTT3UvUlJTcHZ1N0lh?=
 =?utf-8?B?Y3Y3aGNFbmxzRWhGRHg1ZFV6RmQvdWtnSEpDTklDWDhaWU1jY2xhbXEwN3hT?=
 =?utf-8?B?ZXY5RE9vVEtCSjN1SUdWL2dLSm5BUTJmMUNBUlg3SDNhTXNMc3pQazNwRS8v?=
 =?utf-8?B?MStVNk80NCtrdWc4OHFrcVpoenpqL3k2QkZPaVJOL2dsaVU3SEtPTzgyTE9w?=
 =?utf-8?B?by8yd1JFK2ZoOTdaQXRjZ25jYUsvc2QyWEoxcy9PbTNmTENGdHpSVGs4Mit6?=
 =?utf-8?B?ZG9NZ3FUeGwydmp4amdWRmJrdHRsNlZQOVFZMDJPMlByS3FhWXZKVnc1ZllU?=
 =?utf-8?B?WXRGUTd3NzMvSkVjTFd2TnhHK1FvaXRIcHpHWTVUSDVLcSt1eS9mTnlENGZy?=
 =?utf-8?B?RWtubEE3UGhmbWE5dWtyMGFxeXF1ZmxkZDZZY1A2ZmJnZm9jcE40NHRmRVNH?=
 =?utf-8?B?TDhKMEpnU1RFV3JhL1ZPNEZSZVVjSTdTWjVXdW9IdmllS0wzNzR6ampGY25m?=
 =?utf-8?B?UHdNNXNTNExLaDJXYWlRaGN4U3lvUTE5dFBrRXBNTCtWK0hUUkxBZ2RTWHBW?=
 =?utf-8?B?OUtyN1NNcGg2Q1hxOFJ0MWxxOVRkdVYrQURtYytaWFYvaEVQVm1GMUxza1hB?=
 =?utf-8?B?Qm05U1IrcGZUaW1GUVVIUmJxbTRSRitIMTl6MEhLV2pTTCs4bzV2RjFqUDRp?=
 =?utf-8?B?ZGlleFZ0bEl5NXFHcHZiTE5PNUQyZVcyTzhFNTFWY1FULzFTZkJNQTRtR2Ny?=
 =?utf-8?B?QU5sQWd4SVJMYUM1TmtIRzhtUWg0RG42cnFWMVNEM1pXWWYxS3VKOFBkRGg5?=
 =?utf-8?B?MktPa3hyR0pxUktUdVJEdzNqaXFrSXFmUEFncjJtT0dIdCtMSkFnVTk0Nm8w?=
 =?utf-8?B?Vmx5UWl5aE92cUF3WFl1YkwwTjdSSjlUYlVuNHdoT1FvMUIrWk52OS8za0Fp?=
 =?utf-8?B?ZnlGSWx0dWlEMmxrYm5uSzMxNjRoYkd2K0hYLy9FQlR4bXhsWW83WXltN2tz?=
 =?utf-8?B?VVBGaCtyQjVPMFVWMFRkVFFoNytQQWlKY1FEWDg0R0xjVG1LRW5YSGVrV2NT?=
 =?utf-8?B?V0N1R3NkbmM5M2VzNUVRZG5zaEUySEVWQ0Y4emRmTFQ4Q0liUUd6bld2Rm5C?=
 =?utf-8?B?S2Z3UEVwMnB0QWxXbjE2MXIwbnpwYTNZbzZwV1lRODgrblA1SFhNNHZqaTZQ?=
 =?utf-8?B?WllQb0YxbjRxR3NUZHBDMnY1UG5DakYyc21yS0l5V2tQL3dUbjZuQ3lBUEFn?=
 =?utf-8?B?SHBwSUdVUHVqM2VHNkN4RVUwelpEZUhPWURiNUVJY0J5R1JTQ1lubllSdXFW?=
 =?utf-8?B?RlFUbUxOK0FHQjZlM3B5Ni9wd29ON2tlOXhDRXo5N1M5b3Q5ejJhSDFqOG1O?=
 =?utf-8?B?TWtXK1FFZElCUUdld24wdlNob00vUXNaY3pDNXhlMDRzL0p1UXdTd0d5NlJX?=
 =?utf-8?B?TGlnNWFFYVFmRVRkUlU5VUVvTjMvQUhiNmVuOHhCSkdrQTBhZFhsSzdzUW4w?=
 =?utf-8?B?azlIVE9hbHhqdTREQS8xaFdYM1U5bVVUSzhldEVsVWR5OUFlRTVJYm8ycXJD?=
 =?utf-8?B?aHcrK3NlM1RKTk4zcVNROGQzWEZMa2hWdDk2bzdvZEJoMDRtQzJleWgzMjl4?=
 =?utf-8?B?R0JlSlp1Tk1GL2R1TFE5eCtpRDEvdUMzeC94Ullka3FKd2tOemtCSGhkZnlH?=
 =?utf-8?Q?bKYLSow/c97eMwv4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e844f11-03b2-4861-3661-08debabd537e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 00:25:44.7997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrID0Amv0rlWs5pdmtpA3wuMrVGl/EyyLtQfV5HLnN37j1DBOO8PpjXgR93fPqmWHJlbHirTyZtGm9B0Kz+wreWToasm5vb972bhq2vs33Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7682
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

Changes v9:
 * Remove an7581/an7583 prefixes from an7581/an7583 drivers. No point to keep
   it in the chip specific code.
 * Minor refactoring of an7583 drivers to make it more similar to an7581 one.
 * Fixed few bugs in an7581/an7583 drivers.
 * Sync code with latest Matheus Sampaio Queiroga work.
 * Remove en7523 driver by request of Matheus Sampaio Queiroga, because of
   linux en7523 driver is not ready (and currently broken)

Changes v10:
 * Add back en7523 pinctrl driver. The driver was tested/debugged together
   with Matheus Sampaio Queiroga. Pin numbers were changed according to
   the table provided by Benjamin Larsson.
 * Added myself to the list of en7523 pinctrl driver authors.
 * gpio-range property was added to pinctrl dts node.

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

 arch/arm/dts/en7523-u-boot.dtsi         |   23 +
 configs/an7581_evb_defconfig            |    2 +-
 configs/en7523_evb_defconfig            |    2 +-
 drivers/pinctrl/Kconfig                 |    1 +
 drivers/pinctrl/Makefile                |   61 +-
 drivers/pinctrl/airoha/Kconfig          |   26 +
 drivers/pinctrl/airoha/Makefile         |    7 +
 drivers/pinctrl/airoha/airoha-common.h  |  477 ++++++++++
 drivers/pinctrl/airoha/pinctrl-airoha.c |  927 +++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1077 +++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7583.c |  980 +++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-en7523.c |  762 ++++++++++++++++
 include/dm/pinctrl.h                    |   28 +
 include/linux/bitfield.h                |   95 +-
 include/linux/bitops.h                  |    1 +
 include/linux/pinctrl/pinctrl.h         |   74 ++
 16 files changed, 4504 insertions(+), 39 deletions(-)
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

