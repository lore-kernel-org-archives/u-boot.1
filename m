Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E09D358F7
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E12F283F95;
	Thu, 29 Jan 2026 11:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="jcE5zqo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 515D983F59; Thu, 29 Jan 2026 11:54:44 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5640F83F26
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4sRsRrZ7Lfsgcj9iH3u/4vNDju4tt7lRr/cl+M5OGIJsY7up8tcomkDvCurt/lQuO5Fan8uE1X5+pW3lBaw4nX0I5Iv8NjKPNQgYCgH2CNiLL90Q6lR06CG3fega8AOtgG+UMNScfJkGGReiC7ZGGM9J1Z3XQ2j/HEE4ebaxSKQBFFTjSSZBmAdGYTL9wAKuzrcLTfjxiy3Eao9RsEsm+R8FzYGXuDmkTLu7GPCP0u+y/s4E/5d/JeyZRS3qZWOrkexYITEhu4YQ6UdsRImdAzn6rlPQ1LN447ZHZWAZ2a2GsPMydnok3+T3SQdK6oqYj8HfB2WxEfElZHzyMq7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HzsOPqefwP/T7NH14Z90wjwhmpoBtR7OnQk7zD1Tqs=;
 b=fHXTnBmigv8pR7XHrzLip+g/teGTKb2Q+8acIRL2WeVzid+KbP4bzyaN4+YL/edv5j9aDlEHHqhF6oliL+/VgAa2gqGiBx/eVEdrCS+TjTABYV2Up78lfplbkHBWiRPik0faMrgZ0yhAsNRmBLxjBRwNyvWWxpQYiUK9S87ibHEgn9H/zAoOw5n8PyeyhDbY8S4daXKwcLluiCAyFJL/LfxMByeE3IHIFbnU8WWAoipY0KyJ6kn3xxkAwJzgRamUd4cT6g0qaPEh5KQr2+WdOiXAFVNEfZXj1ietrjP4syZ8TZnIxqg4n5+F1rW+XX/8FU5So8KbVV+rDj9ujmBmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HzsOPqefwP/T7NH14Z90wjwhmpoBtR7OnQk7zD1Tqs=;
 b=jcE5zqo9cdT27+c/LTCwC3MrL/oS+f+iXlSU1/sq3hqQvhpzRUJ8sKyYg/zMs6ihNtYR2uRr44tBz27bi8nGTWlJnd3xsBDxLvki6sIQ75K4lKDF+lov9FcD1X6MR6ooNyB7ZPuKc13uAt5HrfcmIHHidvojqWxv7fvhsFTX9XE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS1PR10MB7936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:54:38 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:54:38 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 1/2] am335x: add support for loading u-boot from multiple
 offsets
Date: Thu, 29 Jan 2026 11:54:32 +0100
Message-ID: <20260129105433.2624686-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129105433.2624686-1-ravi@prevas.dk>
References: <20260129105433.2624686-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0010.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::9)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS1PR10MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: e38abda6-12a2-4159-e054-08de5f24cc4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bbFQGQ0pcnyij6t10sYT5pv8SVbcBYFx1i6+g+21KgmSXE3QncF44Jaf5QZP?=
 =?us-ascii?Q?hnFrwqsofXZfkUqEWE2Ackv1PMSVa/4lgAEujKElL3sLuWHvdQRwh7689vI1?=
 =?us-ascii?Q?DpT7PigqIDF9HGA3hXoEYhe9vBr2+TVGD4OzQDaGvxpn2O2YbidLsT8yAAL+?=
 =?us-ascii?Q?etVfBs3JiFHhOcKsJ2tKquCBF7piZqDK7wq7whdLFRIVwgkrdtL47N0sGX+n?=
 =?us-ascii?Q?eOxWfC/USJtn9pzdHhd+5eKCJkH3XilCDOPZBAdtqUgZ02JVZiV3EyvL9yqq?=
 =?us-ascii?Q?FkuuhDIBAQ7P95eQxrLnDjEFMwRtW6KUilTM7/qyzpINLHETeWP0cPntKHSK?=
 =?us-ascii?Q?c5B0FY52YMzF5AbWOLM6VXot3FzlcpCa6tGytdrVCryz2zq74bIM+Jy3q9Fo?=
 =?us-ascii?Q?yuYkVsL0KKstpqpmv2m8UixtxEizpeQKglvdclOQowMsaxF/fDqiR90GzH1b?=
 =?us-ascii?Q?ZA4ghcWHVpqiNnoEutWGTVRxIAQJm5HD2txCcnGN8l3zep5KIx0Pz8sXDyA5?=
 =?us-ascii?Q?ds3ar/vR+JxUKbPaqmDt7eby+HBIC87xI87REL2c/cbOp2rzD6swo17gMM+y?=
 =?us-ascii?Q?KcLGl9c5v22+k1WLcBhYpA8MtkXdy2gKUX8yr0JReaMwRFbSyEOxNtwmuaBo?=
 =?us-ascii?Q?HD0EopmwfKaFXKJkYFzYroYywBpveldyVsayQemXXLw/cnZUqtpNi4bR+k/o?=
 =?us-ascii?Q?dLxJxoQTfcMZ0fJKG3GqTCtjJqRZZBPj+i8ff6MJRAPZuXbPAeyp9L6xxlEt?=
 =?us-ascii?Q?MMTWpzELiAtN2rX2pcJ8iAYGQlKWF6UucmAZsZHkrNn7mg/zrS4SKs2CEgIx?=
 =?us-ascii?Q?FXYctU6K2DIzoF7Q2vKjz1w2aUpWk9P7eMn1UBYE6tilCe0/DSMD0Xp1qaBD?=
 =?us-ascii?Q?xFe7EB+XKxAQpgAseAXJtubJBZEO9nP42E5O8urJwc3/QEAsrbXokwpxfZfS?=
 =?us-ascii?Q?zkd8bZvfiHVIyaVqq5EHSfJUQnCb9leN5oapj+KiF8jfIA/p1yTpSLN7g1+L?=
 =?us-ascii?Q?PSCdkJpdLnyH4laccZ0/XzWkGDqAY0fiSKcW4/xxv7mFdPW3mvIhDIZFD4FY?=
 =?us-ascii?Q?9L0tMZiqybEepREGV7Dr5h0OnNfBWN0TiYzgHNc++maWm1J2Mg0h4Zxm3zjo?=
 =?us-ascii?Q?HoFXanU9LWZI6rTvUh4l1FzKgfs+4CgS4n9NmdNZRUakzuzlG8L7HMcnNctY?=
 =?us-ascii?Q?q+AivwITqL70xJ69QVKKBrHQLXswd/fBvINTZukw25nbaVWZeWhMtPICgcZG?=
 =?us-ascii?Q?3KhgyCsSztZ5cqpv0r59688tpTaPomioz11e732MBHIKPoj23qne46Yb4xU/?=
 =?us-ascii?Q?wYOAmAk3kETQJCFPVAhFgfqf7tvNtaGxfNl1X/KFL17PX5XV+M34AzhfyL0a?=
 =?us-ascii?Q?4FySdLS5nqbtE4N4DKg93hxCfOgnXBEfpkGS70fPLb4YY4A44Av7lxFKraJy?=
 =?us-ascii?Q?PpCJDJ1zG/R1rzyED4lruYKIw3ZR8DLlYn2eFDzXoHr6IW8ZfqzHgUpIpHhi?=
 =?us-ascii?Q?pFRa48JNC4orNalrpolqTJL6pgydk+Zo+Wur0yI+SOozk9VtC6cceaKnHc28?=
 =?us-ascii?Q?POHzRt0pVDiVq8IPra50gA5kE0IeFCF4U02/UHsCXKXW5WrClqhIVRtEmIt/?=
 =?us-ascii?Q?xBxuX1t8aEvvSQCIYdAe4nQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gEF5UqglgVz0ZmySJm7HFuQJ5QfkozmQ+1yUWb6j4Z7hENUlPtA7rmH9tjsy?=
 =?us-ascii?Q?k17v2GXqfLc13bs47WATWa3TdYMQAekHJDmcncFIwIBPQ6LgxTaD7UFe8oRd?=
 =?us-ascii?Q?4QJawmIhsmXlKNsPC0hArzkz31X4Z9HoV3fnTsAjXLgS9GxUM3i3x26kQsRr?=
 =?us-ascii?Q?ZqyIOmSV98002YE/hBBR2hYu+YJGWPtim82YuGe0QUfk0meXfU+gFg1C3mya?=
 =?us-ascii?Q?Bjyyo+abCPuAkxQ05Q59oD7Om6+wGIaYbxeVNSsEXjHYv47qtVTBb8gakWVj?=
 =?us-ascii?Q?Y/YmhSUPPT20l9JjKTbkSwPz/KGYYfgX0v1fLnsvnFsj5fissRTgg8czyQ8p?=
 =?us-ascii?Q?FNN5nnKwK+0O6r4YhQR9T8l77j7+20o3qClFQIPAjDbCzT1pb0Tm2njLHmlL?=
 =?us-ascii?Q?cJp7Ob+mX/CKwDL84OmwtdDSysrc5NnncBX1tg5BrURfzdeQd3R6CYQCFtlS?=
 =?us-ascii?Q?zLC+5CcJhkEqiwguYv/SZ6BEL20uTvWqef1zvQyO/HWbba6b3pUyXfYsGfVM?=
 =?us-ascii?Q?KfP0P9TsX9ofFLtry75/BROmXj1FwW/rD4GHk4ZYRORnK975bhq65xmVa6RE?=
 =?us-ascii?Q?vlxiq0N154q8uygmJ4JCIrkVwiu67TTmg4cnxBje4w+ZhR9hLIxKTq62TtqC?=
 =?us-ascii?Q?3iqDLMzSVSZUFj8rRsH8b8yE7DrwlWU6sKOzX5TusBJhjtatJlfwKPZ9KTef?=
 =?us-ascii?Q?h2UL+JzsrcnBSpGOcUlU9UtCMrs4MA4XrilyWJRE6IPRRyuI9QNTwmwB2oaz?=
 =?us-ascii?Q?85Wcvgrw09pfO+CMyEzBtzGWVyDp5awpsTN0orrmRxlE4VH3KvA/1z5xlOWC?=
 =?us-ascii?Q?R0bPtakSiSt4HbTw0+ZkOFmtl0TNzMFuuondqLPYjm2vKY0Nxp3YEAa9r31T?=
 =?us-ascii?Q?ngrEsp8Xf2M0x4hz5xttGOfahBrQOzyhnyqE62P91t42emQnzvJwZlDGPC8c?=
 =?us-ascii?Q?uJO6ClDJozItU+FzvoP1iRHw2+3rUZEXTokmiQtjm34xTvQFEE5zXP8tVryh?=
 =?us-ascii?Q?Kxg3KVi5I9OuodHkQ2+rpPCoEBP7fzqlXaEKodBZ7vuLeaNWJhEWTgj5XdtF?=
 =?us-ascii?Q?yEXCzA8yenMbgcLk5iDVfnqGb6264hIF4bRBVjiQAFH/ET30fG/Ua4rqr+jy?=
 =?us-ascii?Q?GGVfWrvH3snwPr74YSbBvXwHUZD4tK1bOEx2VoIDpexlJXC5MndWB7EXcmnB?=
 =?us-ascii?Q?G6nZRdIXu5jF/9ZK++HvEQth27Da1KSYZofNJ6l7zfl74SDHvQiEn0ySYrpZ?=
 =?us-ascii?Q?ZMIHuVu8Q6J6pDZvHTfAdvoPGGqHhBxjIuRVLYfDkcdfRGct3a9iwEhyWCVd?=
 =?us-ascii?Q?tpFRXYirI9y+VQg0CK8zNsWn1YLF7RQP/v+YsLlQck9mFZIcSiv8pwmJh57t?=
 =?us-ascii?Q?7vafDgQ/fN2xTXdBZSsjPxN3tzaX7Xkhj5IhGorD6LcB4ilwEtAHDfu/81OP?=
 =?us-ascii?Q?2MebPIRkUhBa5vyLsxK1qYVzmvHX2FdJWRw+ofpOGsmgLPhW7oMGz1lXW7sF?=
 =?us-ascii?Q?XkT3ZI+xe8ZGV+9YsS9izchM4YlzSuqDn7BYjs0/B3xLn9HPxupijv2LhlYA?=
 =?us-ascii?Q?5rloGOCTvhMCtOWtiVQeYoqBcEsccLQcb3l90dnv1G58v+OKAcVL8qvmBJ5K?=
 =?us-ascii?Q?kIgWYDBfosyZgTs2sw+hkmP0X3Z+PlLbjQNb3wIQrT/8ozMqPoRB5ACeJMux?=
 =?us-ascii?Q?E4WZ+1Wt/+2r8NTvcOKJJsx52TStyBC2o089Mck2ZgyptvIbBuwrOL6xoKcp?=
 =?us-ascii?Q?OsVJQgTUCjJIMzrhydyOqkX4VWu4ghU=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e38abda6-12a2-4159-e054-08de5f24cc4d
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:54:38.6179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuF2auAfUIJGvqe/TePgDgfZtUVwRwo9HVmLJhW42AI1FqYgeLbrBx06iV57Voc0zsOa60jH8ErjmUUGmzXDyDDvNnTOA+crtyT4U8OAKfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7936
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
SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR. So in order to update the whole
bootloader, we need to teach SPL to use a different offset for U-Boot
proper depending on where SPL itself was loaded from (*). With that,
the update procedure is just amended by a step

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

