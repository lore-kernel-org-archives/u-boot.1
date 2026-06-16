Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6D9CD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 05:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D4D84895;
	Tue, 16 Jun 2026 07:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ao65ck9Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44314846CF; Tue, 16 Jun 2026 07:31:25 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F51984105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHoRhlx/kg4GFXcB7bOe2p6APJbfHhIRwR9x8AEyeuEB0yCISKp/Hxj5arWzzXtbV6zgZ4fJ8X8php+x+ZVqVzvJqGlsT4yMA05GIWLBYWOMcaizTIFS+2+WosJYkjG3EPnGZ8TGIn1D6rbJFMG7KcoVZtOv3F1UThAs5Xbu6jCLDdBt7/kZVsiFVQFuK1zIuAddDOlTCtxQkug7jVMnIy1VMshrCp31gMS0uwyXsrBmuWMyUZu1fmVnJEaI1N3FWJDEvhhDi0CbV1OHHaAkFrp+Y3wMbRb8MroCuX1wHMlZ798nJy65qEozQeGRRntJQQkNhP34UTZNAkoitrh9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgcqfjl+suszqFD35oBl79rgGPMRXZYUV9UxodYMsYk=;
 b=WrG+24waK6CagluFcuZofymLViHGqgAFskGl5ny0gIKRsuEWucLO1LbVYu6pDkh/5XbUnx/QuitPfPNO5wYtPYTKeqZkQbJ95MLwE5r3bFhEjF/38f4lzOfZ8ui6YHQsqq+wdz6PFa6FkcrKSAfiV0WSlIUrRRxy393JipqbPFZIkd5Lb9txJfCnsKEPJjva2EPQBzXfbPCbnXas+JbJSkgpx/RGT2SC5ZHkB1finHKBT2Ch8aokiK0m7zITc2CzrfUT1xYJ8JhktjY/BKZKd8Tylh3AkE1zX0ue/ZHO2DwCo5hyb/VttSRCySMINfH88XbHPHGtMiz8+ozLtSf8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgcqfjl+suszqFD35oBl79rgGPMRXZYUV9UxodYMsYk=;
 b=ao65ck9ZpaMgZvPz1STdvL4YZkd+SzXqAFm+xT98+ddYbVPF/xqYQDeg7j6jy9DEt/vX6N/zwI+FSSD4y6J6VOU3lMi5bW45w/frfYj4E0YL9DFNvZJ81EWzTK271txVSASjR/U0PId3PtjcDBhjAV4OwbDOxvNYDrFENI3wraB1cJlEfv5hnTzQoQqQdiKoRTiKuf907t6KqPQhtBVLXsYTJagDCdgOybnwBeWMSK9BT46p8KvdVo8EdnN0lUt7F6ybT9FFxi7ODgDvvACoONGirERdo3L1S1k2zfCU/Loyk807bxTfP9xIdSsXayAg6lBgPjpgNfnc/gEdCd1ZRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB8996.eurprd08.prod.outlook.com (2603:10a6:20b:5b1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 05:31:19 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Tue, 16 Jun 2026
 05:31:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v12 00/12] pinctrl: add support of Airoha SoCs
Date: Tue, 16 Jun 2026 08:30:54 +0300
Message-ID: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 731ae92e-e1d7-4150-5fdb-08decb687e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|23010399003|376014|18002099003|38350700014|921020|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: JNlaXkjRbQ0qj14PtF/mqVDogKBMoNbPZdgBQsdHPFlb8SztStdax44ppTSmZbPIyMnUliKyBctUbpKpCjq+wvXvPvpEa4AxM8QVsR9Xey8niyH4bvByAcYfsvtKuAPi2I579/XjS9eMkyBiQ735g3hDIRYrDRiLLEDMNg+uZCe848ouXIYQtjgUYRimIGXwnX/BZeQFKoamt4RLbE6NQj0nKrg17DQTnH+eBAi80bYV2RVH/rCf2QLE8ZSVYCa0j4vRd/dcJcZWkO3tDHtTtJY7MbF1D3/qITTODci6NY9KhXd135rWZskwuh2LQJAL0U39plutVO1qXVnJvJjUqkJU3CV8rFi9waNvRqFEDy/Oa0ZUO72wh/mJKedZN6DSEjB6omCnAfi2KYenToKY9ZKZhHDPTzPoCxEeGkLx/kRPZKnAnMTaI3mu8iZMP27AtWWdb8veSzGkQXW56UTdUj8NoDaxRCaIhBA93LOIKUL54pgdXfz7CCvr/U+EnwOJw3DIFBxfF0GTebSd7/Iq7r9SpdHOTKuPdOxAC6Oq7ae7BoKeuw8hyYHd0FCMrCrk0HOqiCjapg4sho0T4wYwVcq6fvCgIKz8Mc5E0l/SQ8eIQDlOzyxd9BSxoCIdWRjrY6KS8Gm95kZaPAOexYvQz7HxQdmyL7Db5aEUoYN2qp5LZxmjqgv4t4tbn5op9SYwKx2Ry3pGQoSApGmLXw964HbGSZPJOVTzbtwDJtA5MqT+yTLKczVt1AsBcFv2bFyOBUcF27+410OPnALSe340zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(23010399003)(376014)(18002099003)(38350700014)(921020)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0U3aXBXV28zeVR4MDRnWG5ZNlppZXNTRVIyMDIrRHdZTThqakoyeGV1RG9t?=
 =?utf-8?B?OE5jTVE3THJPd0w3TnRKTDBlc2pkUEdnSXJnUGJaQzd2amJxNTRINS9DYzVT?=
 =?utf-8?B?b0s4R2tMU2djSVRuaTZzLzFhdmc1aE9SV1gvbVRZeTZpa09zTGdvek5lTFlQ?=
 =?utf-8?B?ZlNJS1pyTFI3MzVkbEtSLzdxNTZObUtDMW5FNXppNWZRYzdxai82RzhsRFZL?=
 =?utf-8?B?Sk45cTl4dDFpVklQLzZXdmsyNWtvTEpVeGRuY0JsZnJPWlVqcldRcndXTGo3?=
 =?utf-8?B?VktRc0czcGJ0RUtQL3pmMzdnWWtPUXV2UG50SjY1WHpKcDJ2OWdVSkhmWjhI?=
 =?utf-8?B?S2dzT0xha0JXNXoxM1hZU3FjeXRMNjNaaWhwWkFQV0ZnMHQ4aGVsZWFtODVr?=
 =?utf-8?B?Tkl3RXh0N0NvUlRBQlhBNlBpb2pBTWZXaUtHaVhxMkJ0TDdYd0s4M0tESDhT?=
 =?utf-8?B?Ni84Q0pZbVFHemJXZ3RwanFlWXl3K25EOTN1UDI4L0dpS0Qwd2JneS9wYjJB?=
 =?utf-8?B?bDFiTEgrY1duRUZiVTlyNVB3V2M4QUdxb29Fd2FKM0djeHg5ZkFlRlN4RVgr?=
 =?utf-8?B?TXhRT2dsdlFYUTNhYXIwV0dsZGhxNSsrVGhzbUdjSEt4ZzByRGpneSt3UEh0?=
 =?utf-8?B?c0hCK2lpcXdsYloraURZSUZqRDJCd0RxM2luTUtVcm1xaTZSUVMvV1h4b1Ba?=
 =?utf-8?B?b3Z5Z242NEY0S2ZkZEV6TWMzbUhMVm5KSU5EVlNqelliaktJZENCUHpKaXJ6?=
 =?utf-8?B?b1dMT3VuWXI4MVBpZ280WGhqbFZseFREYUR4Q2lPWENLanNWSUpjVXJwNzVw?=
 =?utf-8?B?eFRJVmlEY3N6UVdmdHAxOERMaGUzUWM5VnREeHBxZzR3bkhrOCtwYUhseXFI?=
 =?utf-8?B?YmVyQWR4cDQySFBOWG0yK3orL3k3U2NUSlZCU1J1K2RoQjVlRzZWaHd0QTJq?=
 =?utf-8?B?VWF2dHRCWkJPRlFoVUwxUVltQkI2c01LUTBwR0xwanJxa2hNK244SnM3UlFp?=
 =?utf-8?B?SEx5ejVmZE1QUklCQ09ENkNLMitDWkRRdkJUSzN6cnIzalBoSm5lSGNmT3NT?=
 =?utf-8?B?RUQrczZjdWl2Tng2VWpxSEhCQXNsalhCSEdnVTZYNzUxVjRpZ3VoL3NUMXNX?=
 =?utf-8?B?ZFFTV25IOGhIUDBmZDZrL3dlRTErNVdJcWlNbTBRTVQvQWJmK09nQzk0dEpv?=
 =?utf-8?B?OXdUZWtQMG8yQkZ4RmRqYnhSMDY5YzBMSS96NUw3N01FV2pPZTFkSU1EaHRE?=
 =?utf-8?B?N0hZUGpwaDZUbHcvVkIrb05pUkQvSm15RzAwMkpqb2U5Z1ZrVTNrY0ZyUVYy?=
 =?utf-8?B?SGI4VXRpcHJQSmVKcWs3VEVkd0crYmlkU2dBRytvY0ExVElxQkZlQzcwWTdz?=
 =?utf-8?B?YmllVm9CRW5XRldsbEdkck5TSEhUSHVKa2ROVW5KblB6ekxubWx3RFZaSVRP?=
 =?utf-8?B?dk9RZmdVZzZiZ3Q2aGJHZU1zdkhKTTF5anU4SGJMaisvaWlGSHd6RThBenRj?=
 =?utf-8?B?NWMwWTMyOU52WUU4Y3BTb2pxckN4V1BGTjNiRDFZK3laR0Y2TFZNSFJmR1Ra?=
 =?utf-8?B?d2kyWmJNdHlrUkRlcVphaXh6UmpMZWc4am1IV2s1MmIyS0N6RDZ0SzFnR3VZ?=
 =?utf-8?B?NlZFeDdTN3EwR1dpUXMrS0E2dXB1OXM5NElyUFF1dHVYNERYU3loMXAwdis5?=
 =?utf-8?B?Z3plRDZ2b3JlMEV3WnRxcjYzOGx4RUowVzBZU2JuS3BxWWUxalFUeVlPcGRG?=
 =?utf-8?B?VHlXSGhGZm9wNW5mRUJ4dDI2SUptcm5RQmZ2ckFrSEJPQVNyR24yTjNEMzNX?=
 =?utf-8?B?S3loR2NoZkRrYnhJOWMrTFdwbWNhRm5RQU5tVTNjSWxHWGVCa2UvdWplYjFi?=
 =?utf-8?B?Z1owdG51WFlYYmY1SVFWRU1BSjIrdzZYNFhGOWtIaWRIcDF4anpqYnR3cjN3?=
 =?utf-8?B?VDhoZXNHV2grUEYwc0tNTlNUN1ZPVkJXZ1h5Zm5tdm1WbXJ6cmp3R2xkUjlC?=
 =?utf-8?B?R0t6NmVFT2lBYW9VODZHY1RJRWczaHpxcXpZVFdVL3BWcUtSMVJMaHhvdito?=
 =?utf-8?B?dENoK2tvQkRqcFNNd0Q1RkprSVhZQzdyaUxvMGVVdEJKVC9ndVpDOHFFSno2?=
 =?utf-8?B?TUo1T0xQYXl6TjZqUnh6a21Qdjk2cmp0Wk80M2Q5dlZYQ2E2dVVVUXJ5eTMz?=
 =?utf-8?B?ZXErUVVkZDRLUkpOLzRSRVlSSjJHdGNSRDFwckxFeUplaTJldVNaNTJDYmJt?=
 =?utf-8?B?QW5SNG42dXZEZ0tWdnVXMWhiSUZYejZVdUJzeFN1anpJN1Vud0FwMnJKTk5r?=
 =?utf-8?B?SGFJQjdSdTBpcGVxTStYZ0ZzajdFK3hWM2dBbEw4N2RoOTFzR2EzT3FaSlFm?=
 =?utf-8?Q?odhKVyB7gabJ/em4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 731ae92e-e1d7-4150-5fdb-08decb687e2c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:31:18.9014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr2cQHKVxpZDVm0mJ3IlBvPO+ECzaa5a0xJkeBLGy4UftlBlVwcyw04H9SYaNK1tGFUOi2rL50kEnIAeXTfOZer1i3Q1jc22XE2tHwNfONg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8996
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

Changes v11:
 * fix mdio pinctrl function for en7523

Changes v12:
 * code was synced with corresponding linux patchset
   https://lore.kernel.org/lkml/20260616041939.2587012-1-mikhail.kshevetskiy@iopsys.eu/

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
 drivers/pinctrl/airoha/airoha-common.h  |  174 +++
 drivers/pinctrl/airoha/pinctrl-airoha.c |  927 ++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1471 ++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7583.c | 1473 +++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-en7523.c | 1117 +++++++++++++++++
 include/dm/pinctrl.h                    |   28 +
 include/linux/bitfield.h                |   95 +-
 include/linux/bitops.h                  |    1 +
 include/linux/pinctrl/pinctrl.h         |   74 ++
 16 files changed, 5443 insertions(+), 39 deletions(-)
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

