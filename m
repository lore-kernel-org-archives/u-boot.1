Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6056CD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 01:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40A79844CF;
	Mon, 25 May 2026 03:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FzEUy7yM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 023F18460E; Mon, 25 May 2026 03:53:41 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC2C83DA6
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSYMqh43A0KLNCn0GSza16lKRMl2jzrKclTdyskZnYqGcA/Q8Q4qXRCfmTzb2RsmQZ85b07EZFOR2kUTIoIJYTBXay1RHsUQM3IhzsrQJLZADCx8q6WFdc9KL9VZ7j52Yh+IxBOEUFiwo8Z1iu1XnuTVLahLkGOozMSGv31O6y2Mn7SjXs3BNAG9StcyY0MO1YC8Wo+OObLOCMH617JNkAuH8VD8XN8b4Xi/O9x5zOU3kaG3c59/J/54R1PIhJwj1OlxwFcdR/S1O34NXQZy+tifvD+/VzNB6/KV2I+iYcrvF+PrfFttt9KJCMqH/Pj/055F90jUtnzwaFVOC2MCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElpBOdldv2xJ4GJk/tfRXC/Uxg3D5pYn3A4/DrQfYks=;
 b=Hf14u+h4C3RBnt2D3AaKTEJ6qP22CqdIVkT7NZYw5cM6ntfZoz3oB7yzrNF6f9+w0GWqsxjOHy5InqdbjZUO9DwVAPxP09IV8m3Y4ghBfT2wcS9QoZURuyu8lvLiPWdMSTPLIB7XcR30+h9XqUsXmYkPNzZ9p0Kyu5uSxNRxHiOxdiG05vj5q9e+cR6cJxTx6m1Dy4ssxOeW7E99Urx+fh/0HdgkVmd90Kkm5NE+luuvEsByFyHc+fPIrlRUB14KWYwCnx3ET2fMQfYHSDQ6IJMe/lg/4P07bv4o/sGg4wWzG/uY8KQc28iYcimkUHX0CKXc8SWk20pqoSuCUv/C9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElpBOdldv2xJ4GJk/tfRXC/Uxg3D5pYn3A4/DrQfYks=;
 b=FzEUy7yMpXcDGj0vf3bpF8i8bFI5ntysc108dfJccyye6S/61VmVAWAGQfulb4s4QzmtbJ9iiOjdcEzJCOKa7bxc2j2277djaAxPNxAtNPyRhqCXpl3RLsDXCRT/VXhlQYoQmBGaQy7MmXr67SWuktsSk0eM85OMYWWwiFdNk31aMioX2CzaXlKFQjvDrIQJZyGkiUCWGbXLBVmyFSaGcbTk+icXFJjnkom0IDjsofHgS4Wt0Td9HVMA6s1IADa+R5Kj2RJZ+OA+OWel68u3T4mmSXd/wl6Bq2RybWJFi6Spo2ECS1jnRdpJni9WdNkyT3dHLhjmzOtWckRqcLggLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10466.eurprd04.prod.outlook.com (2603:10a6:102:450::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 01:53:37 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 01:53:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/5] clk: Use device API to replace devfdt_ helpers
Date: Mon, 25 May 2026 11:10:17 +0800
Message-Id: <20260525-devfdt-clk-v1-0-f0dee4083e82@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJm9E2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNT3ZTUsrSUEt3knGxd40SDlERD47Q0A5NkJaCGgqLUtMwKsGHRsbW
 1AMPblQpcAAAA
X-Change-ID: 20260525-devfdt-clk-3a0da13ff04c
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, uboot-snps-arc@synopsys.com
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Romain Sioen <romain.sioen@microchip.com>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10466:EE_
X-MS-Office365-Filtering-Correlation-Id: a446f16d-d823-40b7-2e5f-08deba006faa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|18002099003|56012099003|38350700014|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: XAMlPCRqLe/+lfe/FQxc1tq3uTNvNKIYyZ+RSkt5YiPJpRKY8P5rBp1UzGWBBNVrnY9UXzVQPznJMqB8L+VFjKyWJR+cRY9RwCNn8pkPnj0YLV7YxUK+D9Iwr5b+AxV2+LJxgChs1RHmI21k7zq1BGCy38iBkEoK+vNNhRMdwW++TnYgTHN6i63V3FJWZEfvqvfueLY2xI1ffluErwxCeR8SDdrQKQWXQHGoEfK1yX8ieC+RYwfIxMB+hRxU1OQoVV4wGTjqaeULFFJze4ae1rm8uvpaOET5vF06kInmcChMBi2S2hyUkDLkbgdz+CH6+pi7gkAcmOQYPZ/UWGdkSdcMaSTHNXAkgsBVqYvpNjneYFYY5S6focK/4dwoyVlZ2K8ghQqUbcuX2PUBVaQ7aBUh+8gboXfwhHh7ObV7iVBI5fzyGMi9xn1DAJIi0A8JIEQzWdwkVtLv1/+jpsQXPuelv04HqHk96fzNPddlYhwyng0ntbDaJphBEc5MV7xkzezOHZlvX7HxOgi1Yynu+2MEG+T0npsu4mpPm2EIdnIyk82x3J75pF1qiwiGfYCvZTJrSFWhrMNl25U7F4V3FRLDz4zcYa0GDzwwTm6XmW/icHn98OvbAlgj5IQ0epChnE/hxll6pZVDmtQ0LgpTfYuqrwYEjY7yOkqsDhWT7H/mzBwiKTjsRTUO9Nss3+2EUDJFKIarILiMX19sdNjg6ReZrptmIqFR7Otpkft3fii2aLqNktW5wNhmMyVDnGKL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(18002099003)(56012099003)(38350700014)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjVXQ1IrOWFvRndMWWJTd1RFQ0dwN0hKcWRPM25MM0IrOXFtOEZTZnlUZHha?=
 =?utf-8?B?Z0ZLYUloeVpFeCsxc3FEdWFZQ2k2cmp6NXUxSnowSm9pK1VGd3lUdklrUStD?=
 =?utf-8?B?aE1PWkkxZ1pQaFNrL29YS3BlK2NtazducE1jeVRjWUN4YTBZVW5mVmY2ZmJI?=
 =?utf-8?B?T0RacWNsVHYzTVBBMUVLT05sb1BkRDVRYWpkcjJnZEg0NGpSclNEUlljLzBW?=
 =?utf-8?B?VDhZOGU4Q2JKanhQWFlHZklzeGM5Yzg2UVI0b3liZUduRWxPNjlXSmxhdk9F?=
 =?utf-8?B?Rkl6L0Zha0xMbURnY3c4NUM4b0V1TE45R09yR2FSYUc0MnJVYmhRMlRFRjhy?=
 =?utf-8?B?Ukc0VWFwVHEzV2VrWkFtdWFaQXpMQjZsUGdCV243ZE83SUM1ajY1SE5aVVdM?=
 =?utf-8?B?ZkNzWXRUMnhuNHZlcmxhZDR1TENPUXdTTjdhRHRRZ1o5VmlieTkyYkpHQ3JY?=
 =?utf-8?B?VHIra1RyVC85aC9mMlZPK2dGQ2pMWGlSZ0poeXpWQzZiZTBHdVQxOXdqTktW?=
 =?utf-8?B?UHAzdHFjVVlrdGF3d2w0dDVlbFFCczlmTnZicTVnTkxNZmNsVlhJZE5lNlVO?=
 =?utf-8?B?OUhoUHVZN1hzdTBOOEZrQnlHNlRuTVZGR0l0OUlnSUdpS0ZKLzl3a0JjWEVK?=
 =?utf-8?B?cUREWEFrTXA5elhpOFFKbzRiMUZ4SXRGS3FTRndWeWlkTjhHQXZRVjlkRzBa?=
 =?utf-8?B?L21tOXNROEtPZUllU1NkR1BVK21GOXBISkxCME54VEJIanliKzVsTVkyVitv?=
 =?utf-8?B?bUF5LytKcjhqOWc2MjhMc2tvSWYxNXVBRkZCdEZtL09UMFpvbFdzNitBYWVa?=
 =?utf-8?B?L09lcEpJQTlvVEVSQ0NZQ0ZoWWwzUW9QVmUrcGdnZFFIMzA2VFFndnNzWk1S?=
 =?utf-8?B?bFIwM1ZyQmxQc1d0VUYyMDMwbGFyQW9saTNtWWQvSlVQS2hyTUJ3V3dnMlpS?=
 =?utf-8?B?K3psWkg3dWNIUXlNYmZJNVNmK0VZQXZFNlF5Nmc5UWh4TGF6ZFNHVkNqNU1H?=
 =?utf-8?B?QzAzYW93bTZ0VGw5bG93azhTSWQzbFBQQnFiN0xWT2dpMlQ5ajgxWnpYZzJk?=
 =?utf-8?B?NVZLT2I1ZXRBaVBvZHpINGtDd21jTkl4ZjZ1T2lNUnZvd1k3VlJITjdKZHFw?=
 =?utf-8?B?MDRSTHVCcDc5TE0zRmlwdnNLaGQvTThHZVZjV2N5MHRnSzhDSHQ2K2hyRmF1?=
 =?utf-8?B?R0J4bHRhK0drL05HSTQ3S29hZTduSWZJWUkwSk8xbEF3RjdEWFk3RkpyK2NY?=
 =?utf-8?B?a2FSbU0rUU5nSXoxYnpFeXo5WnVXc1pZU1hsYmlqZS9zSEw2WnhmaHJQRnpl?=
 =?utf-8?B?bFZ3WG9WM2JKa3p5U2dUVSt4TFpIMjIzSlIzMlZwTXhxa1dWU3dYRXo2NU1u?=
 =?utf-8?B?bXV2NlZzT2lnQXV5NjhvZE0zNFJ0WDVCY2hDSVI4bW1BeDhLa0ZHSEdUZE96?=
 =?utf-8?B?NngyTzBVUVYrOEtvTWZOUnY2S0NnN0pEM0VnOWpzRlJaVFRMUUcrM1QvOTZI?=
 =?utf-8?B?WFVkT0h5aTFPVFNrV0J3YUZ1ak9mYUdlWkRxWk0vTkhMeWVmODNXeFhLSjhO?=
 =?utf-8?B?OEpsblJkOE9lb1BOMFhjTnZLbWZVMXlKVk9DSnVLNmpOR3J2MXFHNEkzU1VS?=
 =?utf-8?B?SWg4Uk1kbmFRT05oeW9ROHJGVDBWR3lpOTM3bkpmYXBqR1V6T2FZYWZ2WFhH?=
 =?utf-8?B?Q1I4UVVZR0RXOU5lVFhOSW5jc2JyYXBqZ3ZvWGZNNEUrY1BzOTdZUktzS1JQ?=
 =?utf-8?B?cUl6Y3lEUkY0R0Rxc3FkcjVIZ2lUM2djeW1rSnVYNTNwSDY5Zk13TW5pK2U4?=
 =?utf-8?B?SmxnNHk3VG1lWk5pWE1yNStrdGgwdDYvRW5wcFJrWCtvbVUvQUoxWmcrdldv?=
 =?utf-8?B?Uk5OZ2tDK2NlQldVMi9nNSsxZ0kyWVhodnhDNktPRXV3MDJrSktyejRRRko1?=
 =?utf-8?B?cUhxOEhESTZPQUpvTTFNbDRUK2hFR3k1cTBYSjhQMENxUFBoMldSMlNNMFEz?=
 =?utf-8?B?WGxXRWRvRG5CcGsyb3NnSXh0SU5DUTV2ZHBqczVSalh3SGtCWnVlc2ZsL0Ix?=
 =?utf-8?B?RUtuRVd0bUEwUVpZbmw4bkNSYTRhbjZMWnRla05DMkNDaUo4RWJXRlpWcndL?=
 =?utf-8?B?WERPZzMydmNzdHVkelkwS3FnbTZJZDJWRmt3eCsxZ3BiZkt0b3lSdytHb0hN?=
 =?utf-8?B?WEFJRGk1dGhqTVZnWWtIY3I5RFlPSm9PUWNvSFhlSXh5TUNCbDBhSjlDT1cw?=
 =?utf-8?B?M2R4RjljWlA0SGFiSTN3UHdlU3IxUllwM0hQZEpoTnIrMXRCVUdLblJMVmFs?=
 =?utf-8?B?bkU0bTI5amtWQ1VDMWdpQjMzY2xGTTM4UEpqR1pwUUlrUVM2Z3Y0dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a446f16d-d823-40b7-2e5f-08deba006faa
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 01:53:37.0147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKLakreuFrdoTh4kffoxqL+wC3UKm4IWAEw9jKCkG/pPo9ctkuN2V7jblTtakfJeV94+ucA0LaNRpchrETlUkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10466
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

The goal is to remove the direct usage of devfdt_ APIs in drivers. The
device APIs supports both live device tree and flat DT backends,
avoiding direct dependency on devfdt_* helpers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (5):
      clk: at91: Use dev_read_addr_ptr()
      clk: altera: Use dev_read_addr_ptr()
      clk: aspeed: Use dev_read_addr_ptr()
      clk: hsdk-cgu: Use dev_read_addr_index_ptr()
      clk: sophgo: Use dev_read_addr_ptr()

 drivers/clk/altera/clk-mem-n5x.c | 9 +++++----
 drivers/clk/altera/clk-n5x.c     | 8 ++++----
 drivers/clk/aspeed/clk_ast2500.c | 6 +++---
 drivers/clk/aspeed/clk_ast2600.c | 6 +++---
 drivers/clk/at91/sam9x60.c       | 2 +-
 drivers/clk/at91/sam9x7.c        | 2 +-
 drivers/clk/at91/sama7d65.c      | 6 +++---
 drivers/clk/at91/sama7g5.c       | 6 +++---
 drivers/clk/at91/sckc.c          | 5 ++++-
 drivers/clk/clk-hsdk-cgu.c       | 4 ++--
 drivers/clk/sophgo/clk-cv1800b.c | 5 ++++-
 11 files changed, 33 insertions(+), 26 deletions(-)
---
base-commit: bb354d04459f5425318aeb8a70bae995ee573f1d
change-id: 20260525-devfdt-clk-3a0da13ff04c

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

