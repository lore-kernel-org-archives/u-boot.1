Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8B4D3EE64
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 13:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E8D8397D;
	Thu, 22 Jan 2026 14:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="LeSE6oYt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE72883A1E; Thu, 22 Jan 2026 14:17:39 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1BDC80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 14:17:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1ufZs9M+WUUyq5jS9WK/Xz2n/39DUrbOP1fzqYL64lcMvlddmwPBKF0XCVNrMN+ljEqp/nwMhXckxBtkBdCAIKMuzCNhJPNCLlKOMduG/m87j/QIk6Ic9sL248OHE4AtL5HEtTTqO3VRGCHltA8FuoX+gWAJysQzxdZZzecbzHto4MuFUICgsaIMiMCYe6aOcFpoRlnjpLou4LDjg/0bKwmdM27OnmMectUWMBTMlCLlTELNs+0RaRu0EHhjd7F1OEerV2leiyIlzCY7zSUWA+7IrIvk/0AOhV0ch8qSaIjG2ZNNc4MPJ48/OSfrjWcvJ89eprPDRdrMGFgX69C1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/VP8QymH9dTR9TyGet0kigjflowDo1CETF5qFbTcjc=;
 b=aaloKzok76O8VzdWjW2MArd6WLT+y/aAvw68jnCB+kp6xlkavPGQGgNrk9KYmHRVVCdT+4rGExtkA8h88la2y32WnReVbblu+/Xdibjvovuj2hJdI1xu0h5T9OV+5AWmSwb0czWtjIdIBBc7APJfn3/e0yY07l2pFog+LagxOpAgQcrf1g+TBNzL8liDYIi5Eb0b6XPlSWQRGYF6Xy5RgmEyJV/RPlMR2fM1qVHMXMGi+a4x3Bm7sb5aEXEF5c10/RCtb04lS8Yd97m3BUqGerfO8p5WhK/xFG6LongBlVhpggdWTVKequ1e2Rfq1qO9Ug25DJyTNAzvgpNN23knZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/VP8QymH9dTR9TyGet0kigjflowDo1CETF5qFbTcjc=;
 b=LeSE6oYtiTIjSR8oZzbbAL+mYh+QldMyDhMXoubS2bY0Hm5U7ORmEm+W3YHDQvQfcyzVPy13UIKcz9wrdi6QfTDUGaDAdNAa9bG0ukNp5Hta4FgdCC4a7NN+BMM0jXEoobGDOJPDOMi1rfOFU04oOOMlkh5taoZK7glIoM9YUJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB6984.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 13:17:31 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 13:17:31 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] am335x: add support for loading u-boot from multiple offsets
Date: Thu, 22 Jan 2026 14:17:28 +0100
Message-ID: <20260122131728.1551365-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ff434d-9686-4518-7b82-08de59b8993c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?azpgs7rwHzUi0514BsE1r+SlPuYNkobwx8kkR2i0IlKaCazjvblYwfyCJlv8?=
 =?us-ascii?Q?wSUXYDhsV/bQXsQTscq2eAM2vTE/jtSPpuw+HkrrLvEiakkaXMv23Xt/Rldf?=
 =?us-ascii?Q?9ZsW/HwP+bn0e3I6ZbMXG6/bRt+f+0axGjgVi2SAeLDQwfERa4pTbAAOeedR?=
 =?us-ascii?Q?xradg6EFjn0fj67H2gZF592bMiw98Qr/uxqQv8DAXZru9AtwQY+M8xrrUr9C?=
 =?us-ascii?Q?qed6RijmGbOAtUEaqAykbSjU+W7I1sw/NYglUjCMFZr/Os0XqYufvr6CK+ka?=
 =?us-ascii?Q?Gw1gyycqwBqZIjb5dIyD204WS4upNt/rlCExUjOKu2VosxjuRNRhd2iU5M/C?=
 =?us-ascii?Q?eRxfSVloa+O5bwlR+KHD3W2J+FFANrndG+yPL2hLIdWTHSA5x2HjCo4r+Oz5?=
 =?us-ascii?Q?PN3R+00WLxYWoSIWkyleI6loyV3NQ3f0ykgsjcrsEXTIjTW/GHIDup6jMRSS?=
 =?us-ascii?Q?JuuzT7G18VgjHV8ZH9lgeav9Vpry/mitpqH1e6pgl61HRJjEeDkkw46Ek6kQ?=
 =?us-ascii?Q?3X9NrgDfDRN3uUbeabEv8SMJcJXQY/ycGZXOnD/TWuv7XC0fHCbPgHQyfSuC?=
 =?us-ascii?Q?EnhTsQl3b3zgx8F1xFU5fzqquqZLxrgfrppqAfK60COptaYJeq64F/T51gPp?=
 =?us-ascii?Q?vvuqdJaR8R30IGPh7CxXJou1Ft1rm3/4NPVpJBZkB53dvBEONB+WZiN2u1Wb?=
 =?us-ascii?Q?Agqo4cOJQ7MWNs7WAuy7+XYNOaQs6t/Y8m9AznZz4Xz861qTDM2ka2JRs67V?=
 =?us-ascii?Q?c76Fz3vS0KeJS/Gx5VrvhW7F5aq4S6j7Th0VZqUsYEHuHLcXgv8RtSj1qedF?=
 =?us-ascii?Q?3MO62pKlfhlC08HHxqzEBshoW7uzXO2i7bczRYYXyOzSTWBone2Kr4aylRSp?=
 =?us-ascii?Q?tX+R0kvDfIjAvRNGaizOwyfS+Gfq4f8VBodziriggtbZ7RolgOtbTSpik1eP?=
 =?us-ascii?Q?EvP8pA8C9C3hq20z8pOAos3KbUE0caEbOonv5B3V7DcjR0D0wc9+KRQO5HiQ?=
 =?us-ascii?Q?U/8Th2hvANpJlFt34htPmJtuD9pSnOB3RpYv7vEjA7uU5pAKTYC2GXDCkUQV?=
 =?us-ascii?Q?HzvKzr91mMHGxzxTJKlVkHKMausxohLAfusSeCW0VJuHG4Kjl7SDKevB9Hiw?=
 =?us-ascii?Q?GRTc5E35n+g+q6HxNm94OleH/QWsv1AxwxMOM2ikYbJXvKdfT9Di8+z3sf+M?=
 =?us-ascii?Q?1VcBLC7d/F/sTguEaytFBirOCx6xcQFJgCugHPtUB24W+I9gwZq2fYMLwnmX?=
 =?us-ascii?Q?w03n+yKthEGxJGV12NT7TLsH0EMwRJvEj1uepp4ur5sc3o04vAjDhJ39ItRG?=
 =?us-ascii?Q?6LJgJJUf/ApFNPcBXyxbtKdwJTafpN+crE6dxLctjqcLPRy6LR7bEwKSE9ih?=
 =?us-ascii?Q?d76NTyoc7gWyQkwKK8J7PJLKdEmutfJ92OJNwX7J14fFem9Eddbff6qiz8tl?=
 =?us-ascii?Q?GbS9R92D6ykoWaMItWDB0Lu44HD7jHWdpm3b25RsAmNVMxmdyLFW+takvP0+?=
 =?us-ascii?Q?B+tilm9mVtK/yRQsShk3dNMnkdKVWjqVI7d04cQe1H4JQTTaOmmwEebeKX14?=
 =?us-ascii?Q?1nQ/6S/6e4RDmyvxWrhvFh5i04/Dp5kjbxS2nCgqerskqSkOUSsaBjMUpt4N?=
 =?us-ascii?Q?eCQuZ7q6yFwXxk7aPq4iI1c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ueEGiBtn1kyRq0LYpe/H76Mu4zrZSOGF+qUVY1HLfnCLRXlxJHKRVB+8N9S?=
 =?us-ascii?Q?KsSvYns6y1588y4airvT9t8FurjJ5Z3XHOoeqVmpCsGNtlYC83CScXBuii4B?=
 =?us-ascii?Q?og+X65LrQt8CLMYdm1YNHYrW9dt6LB0y+CpS5wH6/VUxMDAmy4oPgdZ+tpV5?=
 =?us-ascii?Q?HtZdhbjh9k8HXWgaUnQ6ByrfszwilhPyQkn3hiQU8mzLi3GrGiK02Mh4Obdr?=
 =?us-ascii?Q?/P5rRmIyrWtABEsgHrjrY0XUWGj3JTQqN1KLZUQ0a8RxFExf9XewD15LF1P7?=
 =?us-ascii?Q?NYPWCCiShrYyZw+kUVBz/dl5bvJye7djundQIRgYrrNt9fFA/uzwVgIbfPzO?=
 =?us-ascii?Q?/iNlzGcVyvlJDdTUL51VSHZYF38kJ0SL2WEtFbF/wO0MG5sSZF8MZnyX9PeL?=
 =?us-ascii?Q?pM5hscB+cHYF+VhEMPTFTCJEPgEduBjR7+kvCJtRHt6p1H7wV82QN0H4WSCm?=
 =?us-ascii?Q?WVI7izaFZ152W2W6nNxiNqOhBjFCA9tY/TFYJnyD2ODetjflpPn12kX3k7vF?=
 =?us-ascii?Q?PxpQR7eF489zKGstRxMPrMzn3VTlI7jmHSpNQTsADvJ1GoKXhdJaHD1alDF1?=
 =?us-ascii?Q?zJ40D4B16sFPOpojx2ZJls+lRT127qdaNFyCJX/JepSetP14BFEvTQdX17zn?=
 =?us-ascii?Q?322DuUFVkuzd3gOvAnQoHckrc0zFTkeerUMagfkYsc5FHS7KUIJN/TbjPzhh?=
 =?us-ascii?Q?lI1yIcsK+ZJCPlEXlyejdiHAdkClsAhGT1rh9dRRq9k4n6+oJlpEwTw2VQ/3?=
 =?us-ascii?Q?XlEXj0jtVl91s13THR24RqWOHY0y8r0SaQaSqgMlOAxAgBMoqFg0cOPpoeyh?=
 =?us-ascii?Q?3hFbgWGzgm36KXFJ2pXGT6KTHX61lTQlY4vgbyD8cIIn9jrHLORP2QJU/N7E?=
 =?us-ascii?Q?yM5IT7Svc26XyvrndvN+Ba6nOcz9T+HIDN03wo25oQZfkQDU9ATI1ucYOOg0?=
 =?us-ascii?Q?Suhr8SObJPEUzpwLZdSFHFizo9yiaCa3x39fOLAjkNTsCdXsrUVLB994QEQo?=
 =?us-ascii?Q?QOKgm7vRCu7XFzRJGx9yWiRp+yHXVWXJlYBS8xwNoULoACZqG7DJ4jflIXLg?=
 =?us-ascii?Q?iicnVK8Jz9qY3CNByGZAIpp6m5d72DkD2/+kaVab6k1WFJoqO5tzQxHxAKuO?=
 =?us-ascii?Q?fD/MSbBH0Uftr9CnugCGFUOJ8GD8BA0F4RhXqe9BDBkZtp7ztsqnzl4RREm/?=
 =?us-ascii?Q?Vx9Da59WTo5wI+6L5SzP+Jbor2m1R+FZTz7cltrg5Wnjg07hSrq2l634hiEA?=
 =?us-ascii?Q?1wJ5qnh4m2Iwe0Kt5CmRwTVMwvTPsmS1LjQCkp9pVwB0UlLL521JJyn0U5iY?=
 =?us-ascii?Q?YWsAM3n+A+tvZdSlgzSLsPIxZsI26SJ9xz98hSgijLIk3RO2VczvxgO8BhGd?=
 =?us-ascii?Q?md29K7dqSUg5Qh0kV7PdVIZvng4+PTwmhBCOhLzTVLvQl3HPnBftZoCeN6Yt?=
 =?us-ascii?Q?54ryJJ3kdf+42ggJEEds2DwIQF2JlQ8Xdwsf2fmcLo0ceqrsSYKzO2hc47zO?=
 =?us-ascii?Q?zK0PQHN98ef8DZSwOarmOH8qyNnzl7LdHklqLn8BpKNc/v9s51gFB09E1QQ9?=
 =?us-ascii?Q?SDy6mJy+DSEzdGJ9UO6wUj0cCSs4e0JGrOMnH4F47F9+ifIK0tBtSo5cd2v8?=
 =?us-ascii?Q?M7/uMjSJJuNsA8yVCwHuz1wxwWaUNklscT4NznkKQOJtcYQ+u9l6dyLrnZP0?=
 =?us-ascii?Q?Gx/WNG50ivcT57poGmlYGUfI2PIIuqVK0zTZa/+lco6/frC9xFf4nn3I8wim?=
 =?us-ascii?Q?DbaJwmzK9UvHBxBk9XKeLUraTgmjyn0=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ff434d-9686-4518-7b82-08de59b8993c
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:17:31.4803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5jnZLqv9mvm3iyypjah1c5pvsFjUn76eRPCeAEHPwqYufpl5Q4J0FwuO6WdJbdiTqWWxVtRK+QDE9bw/c4yRStzxzohs1mopQeVjnSLmV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6984
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

The am335x knows nothing about eMMC boot partitions, so in order to
implement an update procedure of the bootloader which is robust
against power failure or other interruptions, one must make use of the
fact that ROM code on the am335x looks for a valid first stage
bootloader at several different offsets. Updating that can then be
implemented by (assume we put MLO at offsets 128K and 256K):

(1) At least one of the two slots must contain a valid header, since
we successfully booted. Pick the other one.

(2) Overwrite the first sector of the slot chosen in step (a) with all
zeroes.

(3) Write everything but the first sector to the chosen slot.

(4) Write the first sector (containing the magic signature that the
boot ROM uses to identify a valid image) to the chosen slot.

(5) Repeat steps (2)-(4) for the other slot.

It's not possible to simply write the whole MLO in one go, especially
not when updating the 128K slot, because an interruption after the
first sector is written would make the ROM code believe the image is
valid.

But this only caters for SPL itself; regardless of where SPL was
loaded from, it would go on to load U-Boot proper from
SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR. So in order to update the whole
bootloader, we need to teach SPL to use a
different offset for U-Boot proper depending on where SPL itself was
loaded from (*). With that, the update procedure is just amended by a step

(3a) Write U-Boot proper to the offset corresponding to the SPL slot
being updated.

We can know (*) because the ROM code sets a new bit in a certain
"trace vector" before each successive attempt.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/mach-omap2/Kconfig       | 37 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/boot-common.c | 31 ++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index c07dd68e6ce..1e989ac48ac 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -156,6 +156,43 @@ config SYS_DEFAULT_LPDDR2_TIMINGS
 
 endchoice
 
+config SPL_AM33XX_MMCSD_MULTIPLE
+	bool "Support multiple locations of next boot phase"
+	depends on AM33XX
+	depends on SPL_SYS_MMCSD_RAW_MODE
+	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+	help
+	  The boot ROM on the am33xx looks for the first stage
+	  bootloader at several hard-coded offsets in the mmc device
+	  (0, 128K, 256K, 384K) and uses the first location which has
+	  a valid header. This can be used to implement failsafe
+	  update of that first stage (SPL). But in order for the
+	  update of the whole bootloader to be failsafe, SPL must load
+	  U-Boot proper from a location dependent on where SPL itself
+	  was loaded from. This option allows you to specify four
+	  different offsets corresponding to the different places
+	  where SPL could have been loaded from.
+
+if SPL_AM33XX_MMCSD_MULTIPLE
+
+config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_0K
+	hex "Address on the MMC to load U-Boot from when SPL was loaded from offset 0K"
+	default SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+
+config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_128K
+	hex "Address on the MMC to load U-Boot from when SPL was loaded from offset 128K"
+	default SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+
+config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_256K
+	hex "Address on the MMC to load U-Boot from when SPL was loaded from offset 256K"
+	default SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+
+config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_384K
+	hex "Address on the MMC to load U-Boot from when SPL was loaded from offset 384K"
+	default SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+
+endif
+
 source "arch/arm/mach-omap2/omap3/Kconfig"
 
 source "arch/arm/mach-omap2/omap5/Kconfig"
diff --git a/arch/arm/mach-omap2/boot-common.c b/arch/arm/mach-omap2/boot-common.c
index 95b44c8b1e5..88fa59feaf1 100644
--- a/arch/arm/mach-omap2/boot-common.c
+++ b/arch/arm/mach-omap2/boot-common.c
@@ -318,3 +318,34 @@ static void tee_image_process(ulong tee_image, size_t tee_size)
 }
 U_BOOT_FIT_LOADABLE_HANDLER(IH_TYPE_TEE, tee_image_process);
 #endif
+
+#ifdef CONFIG_SPL_AM33XX_MMCSD_MULTIPLE
+
+#define AM335X_TRACE_VECTOR2 0x4030CE44
+
+unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long raw_sect)
+{
+	u32 bits = *(u32 *)AM335X_TRACE_VECTOR2;
+
+	bits &= 0xf000;
+
+	/*
+	 * The ROM code sets the "trial bit 3", bit 15, first, when
+	 * attempting offset 0, then "trial bit 2", bit 14, when
+	 * attempting offset 128K, and so on. If the tracing vector
+	 * has completely unexpected contents, fall back to the
+	 * raw_sect we were given.
+	 */
+	switch (bits) {
+	case 0x8000: raw_sect = CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_0K;   break;
+	case 0xc000: raw_sect = CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_128K; break;
+	case 0xe000: raw_sect = CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_256K; break;
+	case 0xf000: raw_sect = CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_384K; break;
+	default:
+		printf("Warning: Unexpected trial bits 0x%04x in trace vector 2, falling back to 0x%lx\n",
+		       bits, raw_sect);
+	}
+
+	return raw_sect;
+}
+#endif
-- 
2.52.0

