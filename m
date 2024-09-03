Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F92CD37B5
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 22:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DEA1881A5;
	Wed,  4 Sep 2024 00:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="SwBFjgD4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 174F088327; Tue,  3 Sep 2024 23:59:59 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B6D8817C
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 23:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGE/WF/9VcbAS6BkvL+36PcA9xkgoZRzfqTliuqAT64gmfw+1/wJxp0/UINPBzorr/Pg0wjN3tee1mSO6qukSFCZVsd8reLgiCULol+cc8bu6Cz8n/zR/Hg8at3+xlaRQ1JVYSGMzksKXoF5gwWYpfLr80uVSjk3l8IsZNzi3cr+KcZ7u5inF2xoP/GtjCDhZeneepoG0XoVdEMcqduj/+a1GyUXq//rnKJ4I2131N+pyXV6pCusSjJcvL+k/Ux+Y7IBnj/Nd8eHFM8m8L1xcAJ9orc4lnnMe46c+IfPBmE+LaB9/v+KyDwsalPF2g28O4EFTJFVi194cvQfWv1iIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eljv6Q39Q5Ao+7i2LDMcB4/JNEXwEpdDdyVkm6moS0=;
 b=a9DoIo3W2oPADRxZszIRjhMG+5DSYqKTCuiwzZOPjXkybaEI6kwwave1L9iE1Y32M9S1nmpliemccYF9e6F38qNoovYGuP29ghDNaFgAF+fUPxPEwLkqkKE4cjcQRYOu++GRTnj41VvS/+zqaFfVHRdaz8r9sV2428aNMbj3lGYYZXmegtvjvpHt4MPyPCyuecKkj3XKvxJHPzg2Hhfa4B+Q9lkUVuvl7wXlUA+ASrDn4CRd7O0IbJf3chwA1rKWat3VAdwChtBOvCr5jto1lU44zPHVgNNRh7QJa6fa9nxW/8VBqFI/UZgmjTDLt8VCBuV4oVNZdsq/st6FR4zw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eljv6Q39Q5Ao+7i2LDMcB4/JNEXwEpdDdyVkm6moS0=;
 b=SwBFjgD40qD6s60ZyXUxNDdkRWpGoOx6jJAwCvBAjOgMGDIyuEVuc5XiZO3m+5WuqSAcdh0QJvlpgwk3TY4m4el8XuqLDxsGDHTFjsnAfAtdYb6IiNl+NeOTCKDVpEzNELKef9GlUSlRxUFObsCWk4YDfCTe8HT+AT0zX1JQlJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PA1PR10MB8474.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:444::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 21:59:53 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 21:59:53 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Emil Kronborg <emil.kronborg@protonmail.com>
Subject: [PATCH] scripts/Makefile.lib: do not include
 CONFIG_DEVICE_TREE_INCLUDES in dtsi_include_list
Date: Tue,  3 Sep 2024 23:59:36 +0200
Message-ID: <20240903215936.2193393-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PA1PR10MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 392af48b-c339-4888-8f6b-08dccc63bd84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q8qLIJAPxUD80AZKF9SoaZHu6BPzrMriZelmR3TCzFfSwXNae1uKCJhepMx/?=
 =?us-ascii?Q?ivCETh7v1MJF+VPbAt17c+jweqXj6luNASs44pVPJhav/J/ry+neuYb/QJQp?=
 =?us-ascii?Q?+sAoFsnnW1PvV5C9UCIQqjSnJiPsKawExsw0CqbFYU9/UUTKbZs0DJBxbXW9?=
 =?us-ascii?Q?2iJT32OycKGUtLhDxdAJjHbV6tHXP6QQni9uO8d8+1Vgnao9JomP3bZWB3nW?=
 =?us-ascii?Q?HrpMFq8HfoqJckFgWL7V5iK223XXRXYOoWIwmDNgG2SrOGkxXG1xozwfzKEo?=
 =?us-ascii?Q?bLjX2wh1GXnLrRFucPRh3VNxOPvxFHKas1UPhpVIxv2lecd9s1ZUIWpy55e6?=
 =?us-ascii?Q?1GLnyy46ZuuQxjFH3GZw1KA9ek7qKnZB1JLYRt5WN07TzsFHXHrmQOWNNyiy?=
 =?us-ascii?Q?SU8Ts2afdvc61E/vnRW5Fs+qNJg4Go9lv8g/wqu/JsooFeD+LBMiKK1vg6w4?=
 =?us-ascii?Q?7IAyQQsYsLn429x57HvQK4xDP1erv2gccB0CvUv1b5LEzYCdvQIMISYmr7Yf?=
 =?us-ascii?Q?v3PVY1te3r3UXTu07BHLJCmuY1SwpIQjvZRp0qUBGmaZYwwqUmpLZPPR0Vq+?=
 =?us-ascii?Q?8xTCf2c8tJRa9eHQZTw/7AVJiB6F80fjDjJfeTdLpjktFr47xU+D9IXUrRaB?=
 =?us-ascii?Q?CWSUBphZA5lorq8O7eHma2KI2NbVCddvEdUxpmhw0FK4h3T0zHvsV8DeCi3w?=
 =?us-ascii?Q?Hm7Fp9ypnLBW8LGDwdljFqbSoRnnZMJXpn3Kr80StfhM1Hd0P0L6CTTofARL?=
 =?us-ascii?Q?qautiVgj6vjkl3GggHDuYD7IU6ieJLSKCTZfDWP7srAB6aXuvadJZvoJh+Fz?=
 =?us-ascii?Q?G2ejlxjtT9idz9vVgkaF7aGEKtMXgdWcTd2ie1mwHaFrjmF8NbdljJnKeL+7?=
 =?us-ascii?Q?4fCzA27hg+vqo3VBkc1THeWbwZjpadryS/U2ZtE+jfcYvm8o4RgNjq0JaSTD?=
 =?us-ascii?Q?4FzFA9efgKXWbVfdi4nHWwTkgQT2Yp8TBYxEi0Ron2sYjd7Yg+MIePXvBG57?=
 =?us-ascii?Q?ogY9z+J4kwvD/RHQ8ols7fVYMUpw3DuT52vPgH04GioNSAkpQ5J99JT+I2uf?=
 =?us-ascii?Q?asPt8SnYK0QPhWLsf7ZJ3aF1czjuKmQZlxUc/BLXVOlJs+bEhH2a79dtUkIS?=
 =?us-ascii?Q?kBZObXnJRYEvOjNIkZ/5rKNGptOSTY5v/yJMfFHSk9+BL9NiCmtmsu8I04Lu?=
 =?us-ascii?Q?YEcyhZ8jFCjUH1Jy8chEsBlX15NMJk49DISTsx25MM4KydP3WK8iGVpjG9eT?=
 =?us-ascii?Q?2Ngx7LRuod/4nyZNt8bmvdcl+mrUxuNoTZk0qs7ZFn4VViuhaZB6EO5/q+GS?=
 =?us-ascii?Q?vtDRqyJrkrg0IRS/Sp1c3vR7Fv96R+W5W3MdZbMyCSnNbeRsAgbg+DmDGOkE?=
 =?us-ascii?Q?xYQ0YFqldquRvDdCZWIpLScjjo5AjfjUq982hMe4yMEs/j+lyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E2UII5ohBdBLPFgOiOwZRx8bavOrIOPMBQdWQK/dUFHCn8UyDBNA2vYZ+d5L?=
 =?us-ascii?Q?b4sVuJtghY0jS0oUQ2CpakgvULuaJVuqdGdKzF3exprRh7uaBm1jpYHoYSaQ?=
 =?us-ascii?Q?5y+RC1kzrxFuzYKjLmJrVOoEqR5IenpeiOfy/ouVq+IUlhusCqZTj0SfT1rR?=
 =?us-ascii?Q?GECZGv6kNTyAJNXj+zKYkyYj1B5+hpFEmjN2SwBN3sEc863M9UFqFFrlEvLX?=
 =?us-ascii?Q?2ANzwW0OIeO/2L5fyt7tGhoqaveyOg9t8r/2a+kBaEtAaGE2Vr3w3AFNp0SG?=
 =?us-ascii?Q?Jf3CFmZ7ZnmAzBS2sYEyqUFk+1FTT9YefqGx+6tMthFn2KnxOluYV3pjdwk7?=
 =?us-ascii?Q?B1AmR9mIwx5KOjVNqRVkTKdZP5HwIVpiA8Uze1acsEUTK4OA232DaSTXnEvH?=
 =?us-ascii?Q?yPMr6qp3xxVe3AVdayqB145qDVJeSuy/1LBe4iL2VuIO9/vwHH4P/Uz6OZW0?=
 =?us-ascii?Q?Xuj/KVsxMtOIarHXSgD+xtmhB6Rv5iXj/HZoA12AFKkxMwii+tn7oc4Riyam?=
 =?us-ascii?Q?aFgc3zj0I/ZzCXgn7+AgbLgAyvN/650RC+gk0tZiR4CQwwdej99ZWK5uVj7L?=
 =?us-ascii?Q?oPpNJ9yD7jvj011RKKuHicou9cMw3D7eUBpX1Sl5QftxNeRwfVU1sZkpsDdP?=
 =?us-ascii?Q?vMHL55YrF4ZNYSyCTgGX3ctXl1/bjnTHN7bGjxtrVjqg6m8osdbrdOBy9/hM?=
 =?us-ascii?Q?jx9AaPIbIJ9pZ49n1MjFSR3YE7CaWDB1uQdJKmRKTZQxqz37cdBoy9IRzSRP?=
 =?us-ascii?Q?c/8tDKt+iaNeLy+iDs8yi4E0zVUwVtnc/9EuvyvfOHrvT2ylKc727iS83/2R?=
 =?us-ascii?Q?SH1bMQKji/qHSZgbEOGxIKPrOE9wKhZvT9pArTjzt7rsGc1wKTphdHsH+FvU?=
 =?us-ascii?Q?gh3Y98AwvHiXZ9FvwjpGyxq+wwR1Wc1t5NFkdvf6fpUMQhiBt0J7D7NBqxYm?=
 =?us-ascii?Q?9X8Qafh/VJm4aQY+b8+7QoYLdIlnmUc2WzsC9dWJ35OGVQqUyohX+2NiKHvW?=
 =?us-ascii?Q?45vVxxbaRMk2vsSm9iPCC1M5LHaPcIjaXjWw4oqh+6U0AIfopwyb5aA9Tra2?=
 =?us-ascii?Q?30K6ICsJWKd7AZyZuoNMcM6r35lxgEgXLE/hBBvlSnV7pmSyOtAYEWW278hq?=
 =?us-ascii?Q?WKXsjxV304L/uKLht03MSlZyVCCtoZ88be5pqr9uPtM7FZ2thXxF4ONBF5Pk?=
 =?us-ascii?Q?ko9yKGerQahIGlZQHFFbFXAn860fH2lJ4USVAoYAtgluUFIoGU648oVHZ6W2?=
 =?us-ascii?Q?KX1nUqe0uVPp+VfS/a9kqjhoNr3gzO548yfRFhBFmkuQGbh2Fsn9/eWARSV6?=
 =?us-ascii?Q?nwvdPkuN4UcEunEGpdu/YP/JkZWmZ1o8UCrcfzxnPQp/q5TYbCt/DWIk2zjU?=
 =?us-ascii?Q?05b7o52z04mUbLRlxq7P8s2AM108zZzMcEIx0mZQ+mD8WVEm6OJtVZs/+Bpl?=
 =?us-ascii?Q?EEuSKX1x07Z5wEvxwU1C0XQPP6vei8K8hpxVEvYuPJuLRS++PAhSWhsj/dqE?=
 =?us-ascii?Q?7ubAvd5p/mnOCLkJRLkuM7vwBHIcoTNPNSirUBrq5hJ+xWpETG5+1bqdOxCK?=
 =?us-ascii?Q?GgZhuGNf+TOBZGNtg2M6IYMbrlAhdeQ/o08DFQOvjTBe2+vbRPla3i1co1Dk?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 392af48b-c339-4888-8f6b-08dccc63bd84
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 21:59:53.4616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rADxXTKkIVPZC/USYX9M3MbkomqHmv6g0Gzw2OO2dhRG9RAgG1H8252TGmC8KVnBNtK6MJO7e0VomtXVCyaQaYgMoCL/hLHZPoB9phBe7gY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8474
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

The commit mentioned in Fixes broke the
CONFIG_DEVICE_TREE_INCLUDES feature, with the result that any board
setting any non-empty value for that fails to build.

The parent of the mentioned commit refactoring a bit by introducing
the dtsi_include_list variable and changing cmd_dtc to loop over that
was fine.

However, the .dtsi files mentioned in CONFIG_DEVICE_TREE_INCLUDES are
not supposed to be generated via the build system. They are meant for
e.g. including a public key for verified boot (generated with the
key2dtsi script), or for injecting some stuff to the /config
node (say, a bootcmd or a load-environment setting or things like
that). The files can either live in-tree in a private branch or
completely outside, e.g. in some Yocto metadata.

But regardless, U-Boot's build system will never know anything about
them, so when the mentioned commit did

dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))

things broke, because if CONFIG_DEVICE_TREE_INCLUDES is for example
"/path/to/public_key.dtsi", this would add a dependency on
$(obj)//path/to/public_key.dtsi to each $(obj)/*.dtb target, yielding

make[3]: *** No rule to make target 'arch/arm/dts/imx6dl-aristainetos2c_7.dtb', needed by 'dtbs'.  Stop.

To fix that while preserving the introduced
CONFIG_EFI_CAPSULE_ESL_FILE behaviour, disentangle
CONFIG_DEVICE_TREE_INCLUDES from dtsi_include_list from which
dtsi_include_list_deps is built, and instead just add the items
directly to the $(foreach) loop.

Fixes: a958988b62 ("scripts/Makefile.lib: Add dtsi include files as deps for building DTB")
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---

Aside: The later change $(obj) -> $(u_boot_dtsi_loc) (commit df6fb77c98aa)
makes no difference wrt. this bug, but I do think it used to be wrong
to have the -u-boot.dtsi file in dtsi_include_list_deps with an
$(obj)/ prefix - but probably our VPATH setting meant that it didn't
actually break.

 scripts/Makefile.lib | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index df754d1d9f0..5dfb4b6e46f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -185,9 +185,6 @@ endif
 dtsi_include_list = $(strip $(u_boot_dtsi_options_debug) \
 	$(notdir $(firstword $(u_boot_dtsi_options))))
 
-# The CONFIG_DEVICE_TREE_INCLUDES also need to be included
-dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
-
 # Modified for U-Boot
 upstream_dtsi_include = $(addprefix -I, $(srctree)/dts/upstream/src/ \
 	$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*))) \
@@ -350,7 +347,7 @@ quiet_cmd_dtc = DTC     $@
 # And finally any custom .dtsi fragments specified with CONFIG_DEVICE_TREE_INCLUDES
 cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	(cat $< > $(pre-tmp)); \
-	$(foreach f,$(subst $(quote),,$(dtsi_include_list)), \
+	$(foreach f,$(subst $(quote),,$(dtsi_include_list) $(CONFIG_DEVICE_TREE_INCLUDES)), \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
 	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
-- 
2.46.0

