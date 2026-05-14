Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5D4CD4F21
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40E184676;
	Thu, 14 May 2026 04:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="s2bvW2Ql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F83846A7; Thu, 14 May 2026 04:55:56 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 491D184099
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4K+vbt42opjkp7w/gzkX87qCtClYZOZVXtT2s2mD4FIBtR8oLGZAN/GBjoWGzHbg8MJq03qnUkF2pPSrmVANLKdrJNF72Nb9MFfJnM1SvSCJn1chCziszgCs9CJz7e+FKtllsTo6PxGkls8lv34PaZvAuSleDcJxxfUbprDiNFZ83kR8/LoDPuMPcCD9kmyFH4sN/6cHR2lJvpgyOx0eiCNT19V4mvf9L7dwDPZAH+ZuGNFXg9GE+0whf3MLIkcXpZ0J2my6fJUCK8fxZnBmKBAKmV/48hH3X+5FBhLOuFpiyG7Eg9qW1ZYgPwOIMOCUx2Fy6ndXqEXp50vUlw0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0/wEW0Cr8UIPjI+n4QGEgVjwJ8FwlvyvFhNyQO22sM=;
 b=paoSuIOm7IjIsvl65Vr2C9HNjvNtce7f/07DY3QtINXumV9c9pct+RMHpu2OJzJj1JBSQjUPpxNDmhDXtXw5pynqkaUEEwGfjPHpSieRnSCIsK+zp2/z4Fn+8GvqcPW7ba6I3HEpG7fWHzdkxavipfQRwUStFwsO8Zt8S1uZak73PRfng0dGlXeJ3H3GFg4tczjnrLHZ5htgmcOegwaA7iwZBkXK+ZiiCXKl9JI/em0A3S3HRKlzx1WHIpU1JaJrNoaLA//XX3kaYXAj2v3QJr2VIIPgrBH9ZwRao3e4HDJQFiVsO8CsNl/um61HRZTFOc7mwxwJJfwG9WdubhiJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0/wEW0Cr8UIPjI+n4QGEgVjwJ8FwlvyvFhNyQO22sM=;
 b=s2bvW2QlUuDZRCGKSIF5RMAjBnOoSWsmrG/QVAII5nMopjNDydrcq4kbDvArvSeKOWc7yYDVAObjulmKTqOWnxl8HoFZmSrRmFZr3bOocqBohRiPtCdML0XeZ4y8sQ5OJb/9kmQf4pH0j88BU9sKooZ5Yi6ZynZ9Wob5AX6IQV9dHzO7RAfsZ8iiNNEWz4f2pmO1xNW2FeRo+0kCltDSHp9ptMkrzTPD2eXoZwebA53Gf7pGAHv5qqYofr8e3ZSBDljNQ72dA+zh3Z9MvlJAbDcp6AxAYt5hYQo/u1wjuy+6weaurmRTugdLYc2df/uXe2rsqGybpfw/E5s2G6DjbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PR3PR08MB5786.eurprd08.prod.outlook.com (2603:10a6:102:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 14 May
 2026 02:55:52 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:55:52 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 00/12] pinctrl: add support of Airoha SoCs
Date: Thu, 14 May 2026 05:55:30 +0300
Message-ID: <20260514025542.398469-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2PEPF00000B7B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::411) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PR3PR08MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: e171f51e-2781-4c2d-7098-08deb1644f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: ssSMUmKabKr3LR3nabfrr8R4vUMl2GJ04W59n0dXSjtC3wfbTwyAOHPYesClKNqNJms+WLwAhAT72UsvnUJepGjPC9W4u7s6bpP3m6gHdmdYkmCkmMDIbi8EcymHWKLI+qS97y9fcLEU75V0kKC0AKT+pRrfSJXpH3vV5t7A1CCuxV2/INibXiSTlhXc2PNklDo6u3GK7gU1EBt7nCsoqZpJjRW6eWyAjz56ID8fe0CXDtsFcpScsSCcDwFljod5ejpuEU6vQfiW5o4G7GJWtuc/DLMUr2bmbFb1PGaclXvvDZrwRHc0Cc8EF988j06os17SOg2DZ4F8UyWfLkmpZPt6kO1w4IVbDE0HUVIr1PbMKIHAMzwmiM27K/j4AGer/59OBkVDyRRYvwQfJkTJrGsLyuHNYZPwaTyXbL0YnKGHKGe/W2EasLyYA4WgvgEI6e8vDZ4hTiu6vWs7sD3s5E1JtGgXEFnEs4m7+XTF05EZbZbeDG4+nEshssJY85e+g+fLnpOYNTQxNXiSFxxtbnSnWLSmo5CHS9Y1a6HOWB2LG4qqJjNQ/+Ju25XzSO9NOfomF/B5sZRLSf9r5OgPkLTJfL/Xb0CfHdynYIiWmyKNz/slGl4UzESV1g3KeLpFJPzgQMszgUGtTl0MRYJLM24wPhHuYGOb0JVM8b7e5lsT6eCMnCb4PWjXEuHUqFP+qgS9WDDj0IVFj277/1CdpGfJ1BO0k3UiaZoR/JNcvyKLuN3J7xrB86dx2rmFxYSf2v2rS3rMKUSvJM48c/VWsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkNkSWo5WkhpMnhia0lVREhxV3AxbUVVWDNUWEd2WGdvMUt0c0w0SHJ3a0tY?=
 =?utf-8?B?TmpoWVhFekVjbWlRdFMrWWo5cXJkZ3ViSFNtMlh2VktsUFJwMndpNlp5RFlK?=
 =?utf-8?B?dUxyY0VnQktKRTZ5cWRlQVByNWtkSVFFYlVwSXo5cE9tN0lXclh0T29YOGJr?=
 =?utf-8?B?QWN2Z28vNzIxOHVYQUtqZy9SSHhGdG9VbEUwYkpxMUNkMzI4RCsxVzJSc0tk?=
 =?utf-8?B?QWpib0FBWEZFeDMyZVZzRC8rTDVNdWRhZEdnSUhOL1plYXJST2p3UTduckph?=
 =?utf-8?B?YXRXUkxJQkhlZ25MOCtjVzNhelo0aFhHUWpsZGgxQWNTMGhVOVRqekhhOVg4?=
 =?utf-8?B?eTBJbHpwUk5ZZERlbTlsWWFIUkhMMUJsWjFWbU5rV21wbkczYTVnWmpuN2FO?=
 =?utf-8?B?eGh1MWt1eXJPVERlNkdHaGlwR1JIQ2dwWUVJMDRIZFhFVGsycVZVM1dvT3pq?=
 =?utf-8?B?ektsVGtSWGQrRzF1b2UyUnRuc0piSXBvdFBJWkRvOERhYjR0bjAzY3ZDQ3lQ?=
 =?utf-8?B?Uzd5dEZ0WVVzdkg5dnk4YjRJUTZYV2FIUHhpSk9qODMvSVlrRVlSMDlWRndM?=
 =?utf-8?B?YWk2ZHBUbjZJaU5lNUI5cmxjQ2ZqeXFmTndmZkVLV2JLOGZxOFU2UDErY1NG?=
 =?utf-8?B?T2FqRFMyVGpucHZRWlAxT3JjUUZaSy84VjRQNnJhaW1mWVFhamZCL3dGaGl2?=
 =?utf-8?B?aDlmM1NkQXJoM1hWQ2NXSCtBaWI3b1B4UllnTS9mbWpXdk8wdjQ5WHNhNWx3?=
 =?utf-8?B?Z0xmK2NvRlZXTnJkZE8yaUl1RzhjajhPbUg0WGQvQ0FvSnpvL1hLVlF0OUJu?=
 =?utf-8?B?UTlWaW4waVpDSGJKeHhoem1vQS84SEtNNzRKRDc2R3JCbktWS1NENENud2Fl?=
 =?utf-8?B?a3ZxdGVRN3FESVRKdWpMQk5BclF3U2dML2pIaW5kYmFKbUZ0NXlIc2RnRUhN?=
 =?utf-8?B?eXFKTUlrL2NmUW5aTVJtMzlBOEpLNTZpeXFZZFY2c0RkZGpLWXd2SCtVdVk2?=
 =?utf-8?B?SW1vWVVjUEswTm9Hbi92am9LWGNJU3o3SXJ6c3FCSjdSc1RPd1VWUUVFN0RU?=
 =?utf-8?B?WmJYYms4NGU4WEsyczNUOGxGcjJUZjlrQ0cyWUhLeW0zVVdtQlB2MVJFc3ZU?=
 =?utf-8?B?K0tJZ1ZxUVpLZitZZElGTUdvSzVESzVIM1BDdEtZM2hzK3RabmRYTnlUSTBW?=
 =?utf-8?B?Y3lnSXRqSDg2dVM5TzU0dVExQkZ5Y1Nyc2NOOHhMMzhDWEFDUFF6aFlWUXFs?=
 =?utf-8?B?YlBIK0xsQkQ4Y0Qyd1FvZkRCT1VpQm9pUm55RGk1Sk5JOXlJT0ptME5hQXdP?=
 =?utf-8?B?QmRSM2dab3JJaTB5aUU1RUwvOStrZFRBT01xSlVQaFRpbGtkZG1xOWFRN1FM?=
 =?utf-8?B?Vmh5R3N0d1p5Z1FqNER3dXJ3WWk0T1J2enp2dnNHR2lucjZua3gwRVRmdHFh?=
 =?utf-8?B?WENsTVRxbHVBZTE5OGJKUGh6aVlDVlFicmpudWNSNUNhK2VBM0Ivb2N2ZllL?=
 =?utf-8?B?UG5mN09uNzRQTmp3L3RUNXlaem9Vbzk2SWZvbkc2TDFCNko2QUFwbTUwL3Bs?=
 =?utf-8?B?TjIvdEk1amlHRTkrUXl4QUdzZ2x6a2hEYmRvamx0T2tiajZjb0hYb3hZdzVH?=
 =?utf-8?B?dHZ5V1UrZkVnZnJtVjcxSjY3RVhYajV1TDRZWGg5Qzh3ZmFvMFFlQlhRM2Ra?=
 =?utf-8?B?dTJzYjJla0F2VjNPa0grcStCYUo3Z1NBN1huUHBqZVlITjYwV3Y2MTR4Q1pT?=
 =?utf-8?B?QlhDWThRV3BqOHNqdWdTb3Q3U1ZQaWRvc3o5OVk1UFR0aGJ6WVJCMUQxWjhP?=
 =?utf-8?B?Y0tremJGejVZTExxMFR6eXRhdEo0QytoZWtZdU5ER3F2dHhRcjJhelhjTzdC?=
 =?utf-8?B?VE9aNUpQT21vb3Zzb211NzBRNlNuWkdvQlhaSWJmWHNaNkljUWFjQmFDR2cx?=
 =?utf-8?B?YWliN2lzc0g4SmgrbkxMcU1JbDc0M1FyNlQ5SVd4VVZtYTE3Um5CU3ZxZGdQ?=
 =?utf-8?B?ZmhURUtOSk5RMW1tMnk5QzlBRUdteDVPcGNHYjFkQWk2cHVEbGdrNG0xYU02?=
 =?utf-8?B?NW01dGttc2N1bDFGd3Yvam1lZlhUbkRVV3ZDbFZUcU1POSttZjhwMUlCM3ZX?=
 =?utf-8?B?dHJOclpveW95cDJPVnN1dXkwS3d0dHVOenhxQkVBVC8rT3JreDF0OWZMMGpn?=
 =?utf-8?B?NEVjM1F5eVUvWVp1U0N6TURpWFZ0bG5IeDRZTWlrQm1xTkJtZkk2RThYU1V6?=
 =?utf-8?B?V29tYmxhdDBRNGxQVWdwNWV0NWUydG5MbjYxZWRKYnNxbkduMFJkUmdqTUlD?=
 =?utf-8?B?UnJ0NmdneTBkM29jSlRNN080NFhpUWI4TGU0VlF2RjhCOE40SGcxUy9xRG9T?=
 =?utf-8?Q?Rsx8+jtcKFmSYqZE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e171f51e-2781-4c2d-7098-08deb1644f81
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 02:55:52.3821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLh1bxCDAai79nrcWms0EWDERAjcCZMWBeQZ307i7LgSNvzdQHqS/OzbsGD8u4VKk3tGAMFTWmCmsfaWjjfL7/b08G93GtvHRBmc681uCRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5786
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
  https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl

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
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1084 +++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7583.c |  979 ++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-en7523.c |  648 ++++++++++++++
 include/dm/pinctrl.h                    |   28 +
 include/linux/bitfield.h                |   95 +-
 include/linux/bitops.h                  |    1 +
 include/linux/pinctrl/pinctrl.h         |   74 ++
 16 files changed, 4393 insertions(+), 39 deletions(-)
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

