Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C7D1048925
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 01:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 610AB83A1B;
	Sat, 28 Feb 2026 02:42:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Hfs0TxTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C77883CDF; Sat, 28 Feb 2026 02:42:44 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C618801BE
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 02:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rj4857SyBepHkenGA5bKqR+D7PRfHtGHaQFo4UfVyW7qVVx8+kv4EKOkI/LAH4VCeB9ng47IaT0yty7UKoPKmvvMlWHVlAyv9ec0uHvGQ3Dnpbo1b3AerLZCilivYNLoxzR7qtjXgx6z2gvfZpRwpoHewNbyhKk15w5rl5mffN0RRJ5Gi/FzTYPeVyfV3Zt+JZJsM8cFNmktv+H++P13OEqN9zAFkU8SUkuZX512cj+owMhU3OMttau82jptSPB42oFHv1IkZcWvop2cn/Fh3SzFN08er3N51GKgScY97rmFwr4qh+ScDToN+uIm9RHo8YQNBoGeaGBwvj6rIZWfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iz/XTa50eBW3CDtnD4AmJWp/rn7NISXkmwd0NO2CEP4=;
 b=KjFUGrXqmEn3uQ09w2WW+HyrYktcd3NbqZihcauVoQAcku4jvBWLzNp5ctl3GdZAQRZ55or08v1KFnL5Vt96+hbHMAhY7osZhvL9Yj007mwlWpqWxT+IRpg+OWZSuvIdul9WRwy/OCsNSQMMTaTLVjkfUrdnIWqUthKrX2gaPIJaxfj2h0ib5YHw4wJ6TUxryC5HXq+aye9ehReT4z1I8W+SdVNlMvQtoUmAJ94pB+071Nb6I70ZslfRMKaCdncs/k/C0bZQ2kA8+99dJPlI21la4mvOXOBmjVjElB/XoeeDaKXDEiUJfdEw5fkRwvUftJNj66jWZO7Fe9rd58I9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iz/XTa50eBW3CDtnD4AmJWp/rn7NISXkmwd0NO2CEP4=;
 b=Hfs0TxTM1nK0JHTqalq7nTJA4dflCwTye+6J2jXlzf9d7HSHZ1vPBOsFqwZ+4SFU0AwMzdB1vmc9rTgVBgHSrxLyi0ZB+8kp9VEh6eUuiLOHpdqQUAh7MkX7qmLVq3yYXgZgbv0pmEHYdY7aYM2/0f/xPpuYJvR0mpRPVeRa28jBGGfci++C5Iuwu3+eVgihrK1SvQ4+N2sWeWASPq/e4LD/jCyJ7wDlSpNuzozYZs1qWA0klQoIFhXmS2+bvIVGdkcbo5hSNBxvjXycOdm8iLh0VMBvFsg18ZdBY3pvqPjae0Ug0qjTh0Zr6a/BiBbp9vh1lXPgwIhGGlqX9Ik2Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by MI3PR04MB12440.eurprd04.prod.outlook.com (2603:10a6:290:75::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 01:42:37 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:42:37 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v2 00/13] imx: add i.MX952 support
Date: Sat, 28 Feb 2026 08:22:18 +0800
Message-Id: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADo1omkC/x3MQQqAIBBA0avIrBN0IK2uEi3CxppFFgoiiHdPW
 j74/AqJIlOCRVSIlDnxEzr0IMBdezhJ8tENqNAoRCv5LvOI0juljZ+scl5Dj99Inss/WiEjbK1
 9aUNU/1wAAAA=
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|MI3PR04MB12440:EE_
X-MS-Office365-Filtering-Correlation-Id: e5715163-5455-4c7e-f949-08de766aa6c9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: 8An1CXQTyIz1kpRoe55TgMM86LDMszLLBr9P9AlM5FCVoo5ucMb+Ttbrg1XvNOpeZrucAfjBso9rNMUCNxJQ1BLjeXC8DXr28Wz/admZcvsyiRhSaknb3wm5KFM40UBew+LCX+K17PMh8CPeCgNXBLuoRsw/bDKylMCKFCKQiJ5D8FRVNZ8NvByMX0ba9GgcKQCzVPu7fj169QEEIvNIPzYVR2uu+Us1tRAE2L9DCRBIwh1N9lzZoUjzefiEZ7u82dGWmsuv1OBVWh0k9f3cGmhBpURLo4naP7BMIf96P/ZduMspYbGq3K8fNSSdbni7weM5s9A4rgFIk1GyH2bK8rmgUZMnv2u0/zPR9sJGh3vh8u5b0PnrcEUIFMd+9ZgF4yx7Qjq1WkFZ3qlYlK5ao6N/pELtXgKA7DXcJWBLby0AO0F5Rv10IeHtPGs9/83haiMlnfabDghxv/T2vIMHg8TZRTq1KJiI6RLAGwJsubBPLngZ14U0YTFQxty8UgmJbaleTgyhm2fjDzsjFkj+Fk9vKYK72uokUmKS5YZbiBql5Va/29GT/HeUx4XnDkbEto70xItYf7Ko5wlf7t4SaYBMbsSZ2YE9mMF/8wBzR+Qah5pup4PSz93qQvOSnu2WrpxlJ0ZkCrpOWvsw5WOvT3YeTq64NHwaEWdYf0WuY2uISz/R65m7cTCpVLadBoqT5g839uHjmmuyWosU52U+JD28KvrC/UkBFlxw+Q0ENPl+mN9pYeFPfxSCFZ5s6K1A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjNtNi9jcm5uVG9TVWhWVjJOSU9QY0F3NHd5NFVhUjlkZDRCS1d4WnNnWTZF?=
 =?utf-8?B?bHJ4MEpodHJqaGRvRVVaSmUwL0FTdkltQjMyYWUxK0RHUWVBRHkxT0lkZjZ1?=
 =?utf-8?B?bThnNWZzeUNoZTE1a211eEk3OWREdWpPOC8xRXVabWlhYmxMTDhHdGtVNmNT?=
 =?utf-8?B?dTljSE1ROU5Ba1M1UHZENklWL3Y3SzRjU0RzUlVTMWQ2L0l6YTRCTEVqbGZH?=
 =?utf-8?B?bmpNSFIyQmYxT01WSFRhcVZramw2YzkrV3NqN3JUNVMvNVZhZk5GZnBsVm1x?=
 =?utf-8?B?QzNzdTZpTElveFplOHNEbmNUS1BkeXo0NW1GaGNaSVk3OWFVL00zS2NMejQ1?=
 =?utf-8?B?Y0xLWTlrTDJLbjBVeCtwM1RwN1JJMWcvZ2loNWZiSzExNFZRNUZoaUpNS3ls?=
 =?utf-8?B?QTlWZE9SS09QZFYyL0VlT0dIU2dqdW5kU3FLT1lleWhkTVp3eVViQjNUNyt1?=
 =?utf-8?B?cE9CVkNQNmxZWmRWaFNZdGROcG94SjBpWTdaVzAyWll0SU8zRXpxSmtJRXhV?=
 =?utf-8?B?QnU2R2p1dFBxelQ5TzMwd0ptVDIzQXFWdi9YajJJRi8xdjR4SWxrRWJHc0Fk?=
 =?utf-8?B?Y3RBR1k0OWpRNS9wNk14bjZIYmh4RzdjemdpRitJSFRZYnJYa3JxY25oSzlj?=
 =?utf-8?B?Q3hHN2tBa09hYUJjbnlDUTJHaUFkS2c4bWk0SzFOMG1pYllmU1lXWGhwZ1o4?=
 =?utf-8?B?S1RSa1c1SWk4R0UxKy9NV2Vxa05LWEQrWTJRZnovWFJNYVNOOG1QOVlPdk9Y?=
 =?utf-8?B?WFgya3JYWEh2S1BkSDgzQmI1S3NIa1ZURHpIczdYY21CWWpUNTBoTmZCQ0tm?=
 =?utf-8?B?VjZnV01LWE1SQnBVUmlmQUI4MTlmSVRjcUdzWXlIOXhFODR3eVVZMGxXWFV5?=
 =?utf-8?B?NWpnUjNPUGpJWUlDTXBLU3ZKdUE2ZTVVamh3TW0wK1UweEhES1VFWGZFT0lQ?=
 =?utf-8?B?cVNINXptMFhVUHpvVVFZa0MxTC9hdDY2YXNtTXgxT3BhRm45UkpIVEhtOFZL?=
 =?utf-8?B?ZnVkY3g1NDBHcGRhQlVSajA1U1BFM2FYR3RoeWIzS1FtQzdJUzJGMW5QckdG?=
 =?utf-8?B?Uzg5MGh6WUVlZU03Tzh3cm5nY0QyeXBIdGhkVG5BU3o1eG9hNitpMU1pV3Va?=
 =?utf-8?B?SUFqRHhIUDhObTU5QW94SitBVStISWg5ckpjSjRjV1ZTMWI1c1ZuUFZHUXVI?=
 =?utf-8?B?UDAxZ0t3c0Q3SHFXVEhjbWFGUUZMQjJ5b3VXOW1aKzlBUXhFT1B6eE5XeXlq?=
 =?utf-8?B?dlBkN0dmZ2JqWmM2RTkvdnZkMmh6ajlJL0xiL212RThObjRIajdQL21WVWxo?=
 =?utf-8?B?VFNTNTRhNXIyTDZpSzFoQlVIdFpyV2ZVdWtMell1UXl4akpTQzNuRzF6ZmJm?=
 =?utf-8?B?MnBmM3hiSkRFRmFhZ2NXbjhsVlM3TjJHcS9Kdy9pQUE5WXBpSTYrNzdWWWhj?=
 =?utf-8?B?Vmc1Q1UwOGNJTHNmdDE5TXV6MUhHdTVZWmZPcnp0SmtZYlVnbEN6ZWJVazJT?=
 =?utf-8?B?QmR3M0JOcWVVaFVpcDVyVkhTc1pmN1hkbWZEYkF6Q0dZS21VVUVCYlZtL2lv?=
 =?utf-8?B?RXBVODBCanFSeG5naGlSZFBtWkNPVWdjWUVoUUtUTDhQcDk5YUU4Q2NvWU9N?=
 =?utf-8?B?cmFXVG5MUGd5dWFxRTkyRWhIcEtlcExrclJsd0lTL01EUmQvZTBIb1FleHRR?=
 =?utf-8?B?cjJDR2liWjlqaUhmb1N3eDFwSEJVM0dRaG50YjN5ejlnN2ZxekEvWUZWc3lV?=
 =?utf-8?B?MENtRkxXaGttVUVkelNFM2tpcVFndGY1VlQxRE1uUnRURGRYY3Z1ZEYzcjBp?=
 =?utf-8?B?YVhocjVoWElpUEt0RVdDYWMvdGpDb2JNVFd6cXp4TXY5Vks4c2YyTUZxMm5s?=
 =?utf-8?B?WDdKVjByQWsrcUhPT2Mwc2VJdFJSd3R6SGdvck5hVGJLbWxPeGt2NEpnL2xO?=
 =?utf-8?B?WGJxamhHU2lOZ0xRRDJxRjFwdU5INXFHbjdHbzhLMzBWVVg4ZThrN1JjTXNC?=
 =?utf-8?B?R1o1UGV5VGtzbEtsS3RoWm41NWUxdWR4NzFEcU91cHVjbUR1YXB2YnduaTFH?=
 =?utf-8?B?c0xRTnM4czNyUnRSRGcvRDF3N2xLQmUwb0NyTDB6VW1YR2ZFOVUrNjMwTDFT?=
 =?utf-8?B?aVdHTk5INHZlNUthWm9PWHVXRVZXQXR5RklCbHlWQWpGTWF2cTdBM1hQTVB2?=
 =?utf-8?B?SklJTExIMklzS1RESDEvNmY4T3pvUDRIRGErMEk1RWliRUk4RjlEZzFvU2po?=
 =?utf-8?B?Y2dKY0ViUExtamVUamdYRlh0V01lckR0aUZyOEtKN2JmUzdTUk5kam10SHhm?=
 =?utf-8?B?Q3Ftc2lTc2s5bUV6QmF5Tm5VVGJ3bWd2Z3R3UGJCcjh1V3NyeEIzQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5715163-5455-4c7e-f949-08de766aa6c9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:42:37.3641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RF/EJDaUOUxFsuLzQ8PDL/0grJPHEwINqZlyPxUf2tifDmbwhtc2L0i0waBbr5tCfKg2aLo0Y3JrLgcAlgWiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12440
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

Changes for v2:
- Add comments to explain the fields of scmi_ddr_info_out structure.
- memset(out, 0, sizeof(*out)) in scmi_misc_ddrinfo() is done by the
  caller.
- Refine the commit log for patch 1.
- Delete the watchdog base address definition, as i.MX952 doesn't reset
  the via watchdog.
- Use /tools/update-subtree.sh to sync i.MX952 device tree files from
  Linux.
- Cleanup patch 12.

CI: https://github.com/u-boot/u-boot/pull/876/checks

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (7):
      arm: imx: Add i.MX952 CPU type support
      imx: ele_ahab: Add i.MX952 support to display_life_cycle()
      imx: container: Add i.MX952 support to get_imageset_end()
      arm: imx9: Add i.MX952 SoC support
      cpu: imx952: Add i.MX952 support
      arm: imx9: Skip WDG3/WDG4 disable on i.MX952
      arm: dts: Add U-Boot device tree for i.MX952 EVK

Peng Fan (3):
      arm64: dts: freescale: Add initial device tree for i.MX952
      arm64: dts: freescale: Add i.MX952 EVK basic device tree
      board: nxp: imx952_evk: Add i.MX952 15x15 lpddr4x board support

Ye Li (3):
      imx9: scmi: Get DDR size through SM SCMI API
      imx95/imx94: Remove board_phys_sdram_size from each board
      pinctrl: nxp: Add i.MX952 support

 arch/arm/dts/imx952-evk-u-boot.dtsi               |   10 +
 arch/arm/dts/imx952-u-boot.dtsi                   |  290 +++++
 arch/arm/include/asm/arch-imx/cpu.h               |    1 +
 arch/arm/include/asm/mach-imx/sys_proto.h         |   38 +
 arch/arm/mach-imx/Makefile                        |    2 +-
 arch/arm/mach-imx/ele_ahab.c                      |    2 +-
 arch/arm/mach-imx/image-container.c               |    4 +-
 arch/arm/mach-imx/imx9/Kconfig                    |   21 +
 arch/arm/mach-imx/imx9/scmi/common.h              |   10 +
 arch/arm/mach-imx/imx9/scmi/soc.c                 |   81 +-
 board/nxp/imx94_evk/imx94_evk.c                   |    7 -
 board/nxp/imx952_evk/Kconfig                      |   12 +
 board/nxp/imx952_evk/MAINTAINERS                  |    6 +
 board/nxp/imx952_evk/Makefile                     |   14 +
 board/nxp/imx952_evk/imx952_evk.c                 |   26 +
 board/nxp/imx952_evk/imx952_evk.env               |  137 +++
 board/nxp/imx952_evk/spl.c                        |  113 ++
 board/nxp/imx95_evk/imx95_evk.c                   |    7 -
 configs/imx952_evk_defconfig                      |  175 +++
 doc/board/nxp/imx952_evk.rst                      |  112 ++
 doc/board/nxp/index.rst                           |    1 +
 drivers/cpu/imx8_cpu.c                            |    2 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c            |    6 +-
 dts/upstream/src/arm64/freescale/imx952-clock.h   |  215 ++++
 dts/upstream/src/arm64/freescale/imx952-evk.dts   |  217 ++++
 dts/upstream/src/arm64/freescale/imx952-pinfunc.h |  867 ++++++++++++++
 dts/upstream/src/arm64/freescale/imx952-power.h   |   44 +
 dts/upstream/src/arm64/freescale/imx952.dtsi      | 1248 +++++++++++++++++++++
 include/configs/imx952_evk.h                      |   25 +
 include/scmi_protocols.h                          |    3 +-
 30 files changed, 3661 insertions(+), 35 deletions(-)
---
base-commit: 437ea9f8be5afaebe2d8cbab6242f1182857f21e
change-id: 20260227-imx952-fc016f870cf1

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

