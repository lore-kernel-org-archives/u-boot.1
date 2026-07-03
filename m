Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BDDC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 09:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7BB846A4;
	Fri,  3 Jul 2026 11:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d1NBRkMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6D4784119; Fri,  3 Jul 2026 11:12:51 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F9768469D
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 11:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdZkdOOMND2JkDiD259cUwl8sgzp/Wvrc725pFYP6eg29rT9p9qLxRCAhczueGft1u2ITROooVdE6gngBcRSbhHFK0bmPlJpETWzJ+U+wio1et3bTI8/qJGduoAjwMvNvEp5Lbdv+YUaj6q4lJBw+XXa8XxEuhtt4nZEGw+Wh2cKgTbldVjuMEXzw6ep2JYVCl2vQ0yhDZPQCWgdaudAb9aoU/4+6ZhTTDvE2f/28sLr0umE+YqVxhogrZig/rX9WDWPUyAgI6Aq02+whpyA3ghshfVdMRGPF53M9Zwv4zEPE79tI9c7Er6siGoacpwVPunf0RN+/ea4GlS7LYmIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1APt3xWrdujblx/178NY0fpT/wQiprUtDkmhHIf13mw=;
 b=XKA61I3+ypvyPgwEyGCYRXJUcuClzYZ8jKI/BrcdFCVXg0dg1cuG/jCcUhuuYdLI1kHDhpoW6fkSDcVpM0gpmSr5+Yw+u4mc2R7/TBbRIjGSh5mRxX8Vw+39UI3Gq6aLySnOyE/AEu6VS1xt2QFNelK6s2dhl1LUZxX9jpFjxFqm4EFw4CisuR0XdTJViX3eFYtuP1HYh2yMM9YNLjeBcKzwGZj/A3tI7C4OjFNQFhMy24+QgGnd8xmAcfmvKiUF5+8X9vbmTdr4YQ8QvgseXF1JczU2uLr/05DMKV8qAqW5nEGu8jmqfT+HnlnTRboLfDj6VXP0oUpLzYw1XBKO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1APt3xWrdujblx/178NY0fpT/wQiprUtDkmhHIf13mw=;
 b=d1NBRkMOyHKzRTP/8/zfhxcHn2YETpX5ixKSNWBogSvBVbBn4+45NmmVx6G7NeRUIon6lmstZ03HafCHtKO7Zey3VmQ3TGERrJSAwOOFf/kE8HVXtGbIinZyEpFzeHTxZys34Ba03HM9aAV9EsYqtoghHl4OXk5RNeXtHbmDQQZtvDuv4ZfFlFARUlwB4PydxCJkyvYPbemNnaOSmFp1y4bgFULlzdGo8b5pcB5S38FKiDm3NEj6RThW57yugpp23a2/5oCoyK/ZQRMA+iy+Xlt6Wpp+pRNWCf1GnkIfqzOzEyxVENwzNLuPjr/0uIT+qfCzeRB+BJfdRLC5NimmWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB11579.eurprd04.prod.outlook.com (2603:10a6:10:60c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:12:34 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 09:12:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/4] dm: core: misc fixes
Date: Fri, 03 Jul 2026 17:11:23 +0800
Message-Id: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALt8R2oC/yXM0QpAMBjF8VfRd201KyOvIhfMGZ9i2pCSdzdc/
 up/zkUBnhGoSi7yODiwWyKyNCEztssAwX00Kam0LKQS/SyM8xAoy05rabXKQbFePSyf31Pd/A5
 7N8Fs75zu+wEOEHf2awAAAA==
X-Change-ID: 20260702-dm-core-e88b660f625e
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA0PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB11579:EE_
X-MS-Office365-Filtering-Correlation-Id: d1568b6e-7314-4535-61bf-08ded8e337d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|19092799006|366016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: R6Iqva1vmKLn/YO4ycAvqkq/FxjohBqF3UjijYStI9n20VbPwLew2gaHF8zOW6kpDIR9fFXPVdM1ShY1QjEIAKzb1VoUpp75G7dywyglwx7B2sOQVu/orlkwNI81PESZh/cW4X587+JNzcWtHMVhIFCM2WLiCMVJ6o5fqNU8N0tOiuhTFH+GePFH8O9X6HKXPkzqjFClhrf6uNnN5BwqPYHF8dmYzkHAqFG0i3+iMKMnEQX/GVd2iVkkWTaUupCRTrugBkmMVV2u2sfrnsMbXec49AyD8w6q+CcOVYcfZQDumR2lKHpGJdjMWlyl5bw1Rx+ouQLwvE3bdWZQ/Kbl/gAcWknG3WvGaIP0kknd9LPf+Dt1oAkD7R2xdIG/mbIAzSWwhK1E0sHOuYAJm7RmBtR7NruPTEXy4VJQbEjbhChihDfFV/sWsC33YwP6H8GLI83Q+oBHV5Y7jdlWqedOya1EuU9KG+iOakRA48H8hVtQSyFkYL00FHG+TRqDzkXRULApPKTNH4ndETpj1UzQ+VrAH+pW3wDDY6RNIjDh72W23MW9MpvPxvEgz5r7BO2k3uIOVhqvOmhpJvZG8jxNQ0EG4E1jP9Ot4JxJPXwEloH1es83ihgjWXhzZxhK3AJUOUdBQRHQO1bO/NTKjmA4U2qBD4WFNoaqcg8kVzBS0/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(19092799006)(366016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFdYVXgwL0Fxdk51QUxlMUxzbjUwS1BqcGtlZi81MVRrYXAxdXM0OEZyUkdu?=
 =?utf-8?B?dWhBZFBrckl5dHBTdHMxVnRoV3lsUXZsT2ljS3d5UHhEb1RYVkMxV3hMbnN2?=
 =?utf-8?B?YVBUQlEvdzF1Sjl6Ym5FRWUxTy9TejNTNFNJS2MxU0xKM1lBN2VUTzdQakNz?=
 =?utf-8?B?YXl2N21Uck1XWlFSUERHbG4wR1FnZ3l2dnAzZHNnMllNeTdQSzdvYU9Sb2pq?=
 =?utf-8?B?SUE5MXhDemJ1eW1qbmE2RnNvcmkxaGgra0QzS1RKUExXZU1vMG8wakM2V0dw?=
 =?utf-8?B?UmtrK1JmYXNkM25qUzQxM0xvUWlWYWNlZ3ptQ05zRVFvNW1IRVc3NEpSOFdT?=
 =?utf-8?B?VzFHV1Vqa0JrUXNOZU5nWXUxRURxTXkvdS9Bb3ZqcWFtUTFSbXlNR215ejNq?=
 =?utf-8?B?eFRLL3lsWncyN1JaZGNOYjdrWVZ6djRSaHJ1Y0pCZldDczIrNWRvN1RiclJx?=
 =?utf-8?B?aDNLZzBobnFFNzM0WVhZZUZ4TWd6WmdqSG1FeVM3RVhqTGJCR2RYV3kwTnA3?=
 =?utf-8?B?bTFRWmNBcFo4MkwxWGxKSjRCWWQrWmpCeFh0RXdqUGx0Yng0dkN1d3RMcFJ6?=
 =?utf-8?B?UHJCVXFFeGc0NlhtRmtPQWhuelBPS1JmeEFqTVdQaWFxUnlWSnJWaUVNY1ZK?=
 =?utf-8?B?eisvVFgzY1RvT0RCZE81NTk5L3hBT0JaUHdENmZqT3YrZTNzdndrY2pjMGhR?=
 =?utf-8?B?cHZ5Mkwrd3Z0MzN6dkNlc05aWi85emdoUExjamx3VnBBK1prd2NSOXZQcVBh?=
 =?utf-8?B?ZVpYRkl4OGdIdFNZQUpoZ05jL3JzSS8xQkRDcUVDUVZBaXJveVVjaHQxV2tq?=
 =?utf-8?B?YWZ3Q1Ewai9oSGVETERobVBOUmExZndtbm44dVN5Y3EzNVdoNTk2TFJoTnBa?=
 =?utf-8?B?ajNhck5VRGlUbUEreFZxS0R0V3Y0VXp3dEFvSFNzdWFUTnpBaXdtVHlpaWNh?=
 =?utf-8?B?R1p4NnNKY2t2MmlqSXlyQmMwRVFSb20vQVFKcUR6endrRlBpejRoL1FNK0o1?=
 =?utf-8?B?T3hHMVBCNTkybWlDMlEvMG4rV0RhK3VvUHZUR0lGK3RYTDJSS1B5Wm1EanVI?=
 =?utf-8?B?Tlc0dUkyTWVPZnVQZU82eUhzL285ZWFvb0U5Qm8ybGROZHdTaWozQjVOcS96?=
 =?utf-8?B?S25KME95S0F2TzcvTFVXZTE4TjAxZVdCZjlSOExnZFpMNzE2a2dXaEpQdWNV?=
 =?utf-8?B?WXpBQjF2WHkvbTNLeWROcXJOWlE3SEo3ZjdPZkZDTkNSeGxJUFpIZ1VvVVE3?=
 =?utf-8?B?eTFVM3pUS0xxOG9UVVhOL2Fxalo5ODUzRFJoMUp1dlh1R1dwTUh4ZHVEM2lk?=
 =?utf-8?B?RGFCTG01cFNDRzBMcWpCZk5XWWhDWE1TUjBDZEF1bkYzSzJnWnlHLzZER2NC?=
 =?utf-8?B?dVVuTFNhUjBFOXJpSjdneTBVZGloS05mQk9lZXBtbWQ5cmJZOW9rdkVyWTVh?=
 =?utf-8?B?bE5ydHNjMlNHQ0FNN1FEdlBjYmVxMzRRTWVTbTNWeUh4a0ZjOU1KanNaMHIx?=
 =?utf-8?B?OFVvQU5vdG5wTFNQNnRYdVR2MmIvMkdPN0d2cnl1WURseDRGVGFBK2Y0WWMr?=
 =?utf-8?B?cXd5N3NMaTJkSUZLTEdHVDd5d2t3UHAyZFJ1amNoRmNaZk9hZHBVUmlNKzVG?=
 =?utf-8?B?U0VuSDFXc3hlcUdQcUtKeCs3cnZ6Nk9NM3pXNVFCMldselFCNy9nNGU5RUJm?=
 =?utf-8?B?dTBMbWUva3NaTnlmZFJLSEwwNS91clJvMEU0djM3YjF2N1NsQ3cvczI2VEta?=
 =?utf-8?B?YkF5ci8rYXkySjRuT3piT2d2NkNqcm5sVXF5aVZIL1lMZ0Uvcksxc09JdUdS?=
 =?utf-8?B?bnBmRXk5MlhoaUJDYXV2WjRmUmZFMjNUM2h0ZFBsTmZlVjFOUXhSK0VnQVhr?=
 =?utf-8?B?S0NRRHR2SldJWFhlalhCTUw2R3VtQlgrR2xYL2JQTHYzQTVRd1lZeCsrL2J3?=
 =?utf-8?B?OHRhUmN3bkdialVpdHAzZXptWTluMlFyVHp0c01haWxGcExQME51Rlp1aGJn?=
 =?utf-8?B?b1Y5UlZNRDFLVndvL0l3d0xFREIrWFdXdmQvZC9JcnVxVDdCSURiNi9yakxi?=
 =?utf-8?B?dEEyVXdPZVc3N2V0S3g1SGsySzRJSE9YM0VSVyswOHlWeW5pYTN5Y2EwOGQ4?=
 =?utf-8?B?NEd5TkVaYmdqZHJub0xmaEowdFVFRnZJVlIxQTZNZXdBZHZtdjZadzU1NnpD?=
 =?utf-8?B?RVJITlpQRnZ6dDQvVEJHMWlsT0NRT2dGRmZBYkFYMDNScno1akdxT2xvUUNu?=
 =?utf-8?B?eUorSXNkcVlFTTJlaU5XZGtDcUo2eVdVbjE1UXJUNzNWQjlod0s0TDlsY0s3?=
 =?utf-8?B?djFiL2VyN3NnR3JQQzZMVk9zR3RxMkUrdzJFcDVXcUZybFZGZERGNUxORjB3?=
 =?utf-8?Q?UzjGlD9L29jC6UlNVnxSBPsRtUWiIG7WqpyDV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1568b6e-7314-4535-61bf-08ded8e337d3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:12:34.1626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il+GRC8fssLv9+b4nRbOsNev3uIbHtK8bi+Wpoiw/a4al/Weto6wVsDPm7+O+Vpf6E1bg64le34uCvzrXrrM4InbmMvFx/HUDty+WgVhXHo65yb/5xUxkn6Gg0KbyIAm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11579
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

A few misc fixes to dm core. More information could be found in each
commit. Patch list:
 dm: core: free old name in device_set_name to prevent leak
 dm: core: Correct calloc arguments
 dm: core: fix wrong strlen check in of_add_subnode
 dm: core: free fdt when fdt_create_empty_tree failure

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (4):
      dm: core: free fdt when fdt_create_empty_tree failure
      dm: core: fix wrong strlen check in of_add_subnode
      dm: core: Correct calloc arguments
      dm: core: free old name in device_set_name to prevent leak

 drivers/core/device.c    | 2 ++
 drivers/core/of_access.c | 2 +-
 drivers/core/ofnode.c    | 4 +++-
 drivers/core/tag.c       | 4 ++--
 4 files changed, 8 insertions(+), 4 deletions(-)
---
base-commit: e800cc67f5b6cb50a20f37c993ec1cd4063bdbd3
change-id: 20260702-dm-core-e88b660f625e

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

