Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44550CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 09:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62834871CF;
	Thu, 19 Oct 2023 11:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Ww8jX+8H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A77A4871DB; Thu, 19 Oct 2023 11:58:49 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::714])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACB65871C4
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 11:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F81zSJrAMnH4oNh/WkqyDvObx8NjzQYZ1rtYYX9SQGFi/H0GjJvKu63kTRpPVG+zn3ZELdIvfP6H20iDk9x6Ew9IpeEiwKDFPe//s2vs7bHX8fBC49u3Z4phHrD/6rEg+oxlefcdCLqTQMFAdotRLudoqHBsSLhI7R5jfTMuR/Z1jtN2JlhjCpeTCDfbJI9u4GqZFoAikV2z92Efa48bfdKqXNyhN+bFeXShRvti4hTx467Xkn7msE/spKttEJb6aTiJtX97Fuzo48+FxpehyuVpsjqZLrp18vQYnTmecShLDG3nbvJqu9qvnFq2Ier5ZeDXo9G+rlGOFHBhabvGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXO/C7gMXNRN9vvRdYkYsGBDC4P4o7ffWUqrA5oXSsk=;
 b=mF/GzWsXOpw/kKHyES7p/h59hsNsBAxBDWgi8NK6LBiQniBklBoGLpHQv/AmtvEF7BEFQR5salCrppGHdhtiOQpDcyaGo9tYoE9pmpBxNckJQHQKkOxd+hJ2g9xONlEpu+cN58NYdSfHcSaFlJfnL9eT6rtByJ7VRHGjAWKP9V6i5Wd87gyhd0RDiBANc90Ck38fGoh+gcZREFJFnM1Qzemf9FIdLBOPS9YMQvGQpa4pxWCJ6SEnwIxbP7XNgSN7Jo4594KtZtQP4gpfkznDN6wSqFhQ0SQ/sP9ER+ObC4VR6Th+Fi4su1DnyANzpPy0sSe8Ehh26C0S5u0nulNr7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXO/C7gMXNRN9vvRdYkYsGBDC4P4o7ffWUqrA5oXSsk=;
 b=Ww8jX+8HyOi7FONtMFXcAQiugjSHkGAQGSyYVr8xEqBQFvwZCtpnF/QScN0zk0ge7JV3FJMfiwZpJSDdMU0oZfLLmIUBWTE1aOm8cnhW8YkrDeYQHLkJG5p3okyWLOF1ZxKa/ZNvMiNusN6EsDMXARN8/GTtnTnJ7oyL/qz2ao4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB7481.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 09:58:45 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 09:58:45 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 0/6] some LED patches
Date: Thu, 19 Oct 2023 11:58:31 +0200
Message-Id: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::35) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: c54bad52-0de5-4b16-725e-08dbd089fbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zu2r7h34lTTTliaV6M+Q4F3JEdHQYUmqdkgx4aXCQ6GiFJnfvjTrEF+nmtqamCZI+rn/Y4w5XgMmOIFS3zfCts/Gez7RwGR8uc8pbAsREeTPlTe+0/nTzCboWFerAfD0KWhZlKp/9HTm7hetGEtGoJ3Nl4uFtC+y0m7EjUWp9FoqTDYmTC0+x50DPWYWnUVvYl4JqQVc+jLAgvqzNV/kUuhBWC3nGbzBpiUyJmtX8ih2g/6OStwgFbDNDTuIjMasfblnebwajNtCBccvYG8kuj0/YuZPlK14s/OLiNPfGh3hjpUrBlgq4jTEPBw6CNCh+JAT9oh5MzyXMdcg+w6TuB1rCSZHlLK6Xpe0myK4Tsqh6oztyzJQGnpxFHKRyaH8NWUW7THDue4UnmR/TSDRwX3mq5ZnwmH0ROZCshUxn+RcNE/xbhq+WtwZQpORt6p/9cq5IG/pYhnz0Kh1Zr4U9Vn1mFiO2KRTLbtMItcTJnlIoNcUFFiB3DqrR4syxYRXtw3FFvx8uduRKJQp18qYRQy4yLQ1MdMNmIw4+zTcWpGxMu6mMaEbcYet7eDyVLm16vgPQoHsUJTv07NzOKOBJDKPzbg+juidPFPHfIFoaaOA9FPkRmmRXeld0j+Gf3Id
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(39850400004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38350700005)(2906002)(38100700002)(44832011)(41300700001)(36756003)(86362001)(83380400001)(26005)(6512007)(1076003)(52116002)(6506007)(2616005)(107886003)(5660300002)(4326008)(6666004)(478600001)(8676002)(6486002)(66476007)(54906003)(66946007)(6916009)(8976002)(316002)(8936002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NBPqeKivGNr1vFZlPC+4JnUhcXCvHWQ9FAG38rjeC3JxokTm4K1N3E5GxAjy?=
 =?us-ascii?Q?TPUy/rxYEm9JSvkbACR7XpB4HG8fty1FrnJtNpxvZcghJOL82DKvfkXxayYD?=
 =?us-ascii?Q?IEEzHV4yR+yGzleqLH4L9TwAyPxhv7deEvZBQ/HG0REsxVpxyxAlAa2HBSfd?=
 =?us-ascii?Q?Of/Or9F3xyWrOiNS/jLGJzYtP4O/qWEajpzLlu2j7+jhXoWneBTgAy8sK98i?=
 =?us-ascii?Q?tAsb40DnKInWpi/vqmeaieHHAfEaNFxHSAJIwhR3OFuGVtaC2M1A7XDxuk6r?=
 =?us-ascii?Q?Ecuiwg2aQicVrhzezm7qv9pVQaKNJ4NWooyI26ojeBnVrjn1mJsyumilMy55?=
 =?us-ascii?Q?2pkmTmOxNiOUYaKENvIC8uu2c8UAtyfCjnQ42O5Pa/+DNseyvsOfg5s2j0Wv?=
 =?us-ascii?Q?sW/0onMg55tGeL7A3hm2hOA89UpDROd6nx4yhv/OXpSySE7hDPAqgwIOk6Tg?=
 =?us-ascii?Q?vJ3LSLDbiyZSMB2DsesQwtf5buECn1gcIsch+AyPULV2TCQpVArR4o13T3Oo?=
 =?us-ascii?Q?bpafu/tMZ+qj+JGKRknsDhp3jYOluWcz9PjAM1rEiNmzjjWyNCB44/hWHoBj?=
 =?us-ascii?Q?7SPwdwcyuTs40hxWghioWWKbx4lOYVlxxuwowpNSD38cIoA4LA23j+dTYRKE?=
 =?us-ascii?Q?iZsBn7r9+UjSICSEAV/MNj0r04aBcq3MoryNOSzvRL1TaPb7dNCqhYnAuxX+?=
 =?us-ascii?Q?8Hb1KkTPwB/gqzxygNZmvlTOEIxYajtSo3RqDLJzAtUzxLdJzgQiDwEXc504?=
 =?us-ascii?Q?Dy3VF0UkHWkHUsvUBKSDe2VXC1ke1L5joXyNU3cz+1ASrtdAvEi/jor2jIFY?=
 =?us-ascii?Q?nOJWxmDBSVsdDcZa47gKKuUWJe80BzX2KWilYkPpbp/0AK2LuBgckc5c1yEm?=
 =?us-ascii?Q?keLIP3wglbL07B+YxRog+pECSPWjm/GUPQ8+KDfzYFx73HIFFp3ugPXlza7Q?=
 =?us-ascii?Q?uZJvyzSSF3nzUgTHoM6U0MWwygLQG0hw+fxI7VGaUgMV/O4gHFIvF5kQlsY3?=
 =?us-ascii?Q?zx2pcSTeOWolQfOY+vbqJGMB1oABMtDIcbBLh3hqruCk2z3nFEz2L+TSPx4V?=
 =?us-ascii?Q?TyfmyXyCzcB+b+BqCvARHGYKBlWdLwia+CBOJPdb0y0o65ZmiowPhIqp4pS0?=
 =?us-ascii?Q?Yeuk1ZYdbJdWBgSRXgxPLqLEBLjrHanf4UIZJRhs2z7FuCi2OZwlIWj/cUDC?=
 =?us-ascii?Q?Psuku8/i/QUfsYF5jIEFdf/ri5eCAxCMtjwWXu8r+vPPB7AqaQAKJjlw94KB?=
 =?us-ascii?Q?DtSXZAh77DjP7m9QsFLIAWmmYZHCTyEE9iBR+pEvTAXJTpEiKnudxke2MV+P?=
 =?us-ascii?Q?inFpgsTVJRUP4XnnyGfhCJGi62Z8mE5UvynmmkmtJQc64IDWGLism82MGPKP?=
 =?us-ascii?Q?T+D5lwLeXjsY/YLfpzL34lflVKdYpFZ5Nfiv91TXL913ki4wLhv5F0kk8PVS?=
 =?us-ascii?Q?a2cy/+S0Q2VX9CxZXjeCHxbkF3t7rim7XxehBmVsj12mAKuX8NQtaBsdwGK8?=
 =?us-ascii?Q?ZUGb0g28P7d3h2nbup3XjTLHAWzSQ4onhmS25L56I6JezWPyYcmbYU5hKg/l?=
 =?us-ascii?Q?DqKrGmmxSRvPKdLvDrPeI+fifa5hKV033/YYN83alRrSTEfRvTGm1RI4vKEr?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c54bad52-0de5-4b16-725e-08dbd089fbb4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 09:58:45.6326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIQb1YZCOE8EZxhrKgXyIviXJUxd/WyPDbuZ2ApHnFVsL3kZb2mIy8pnZCKfexegsXzX5ij1TXe1yw4CyYRJNMDt1UAT+FeoVeKaf5yJRVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7481
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

I wanted to add support for ti,lp5562, and found an old submission
from Doug. While trying to modify that to work in current U-Boot, I
found a problem with the "move label handling to core" patches.

Patch 1 is an attempt at (quick-)fixing that, though the real fix is
probably to not bind the same driver to the top node as to the child
nodes and using uc_plat->label to distinguish in .probe.

Patch 2 touches the same area, and is needed for the lp5562 driver to
work with existing DT bindings.

Patch 3 introduces a helper which should allow removing some
boilerplate in most individual drivers, and 4,5 apply that in the gpio
and pwm drivers. Converting remaining drivers is trivial, but left out
for now.

Finally patch 6 is the reworked lp5562 driver. While I've changed it
to match existing DT bindings (with the goal of making it work with
our .dts that is known to work with the linux driver), most of the
logic is unchanged from Doug's original patch, so he is still listed
as author.

Doug Zobel (1):
  led: add TI LP5562 LED driver

Rasmus Villemoes (5):
  led-uclass: do not create fallback label for top-level node
  led-uclass: honour ->label field populated by driver's own .bind
  led: introduce led_bind_generic()
  led: led_gpio: use led_bind_generic() helper
  led: led_pwm: use led_bind_generic() helper

 doc/device-tree-bindings/leds/leds-lp5562.txt |  63 ++
 drivers/led/Kconfig                           |   8 +
 drivers/led/Makefile                          |   1 +
 drivers/led/led-uclass.c                      |  22 +-
 drivers/led/led_gpio.c                        |  15 +-
 drivers/led/led_lp5562.c                      | 578 ++++++++++++++++++
 drivers/led/led_pwm.c                         |  14 +-
 include/led.h                                 |   8 +
 8 files changed, 681 insertions(+), 28 deletions(-)
 create mode 100644 doc/device-tree-bindings/leds/leds-lp5562.txt
 create mode 100644 drivers/led/led_lp5562.c

-- 
2.40.1.1.g1c60b9335d

