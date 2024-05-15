Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E50AC25B77
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 07:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B38358824B;
	Wed, 15 May 2024 09:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="D16eBPPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B325388249; Wed, 15 May 2024 09:36:29 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 117818820B
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 09:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuSd4RcCxZIsgWqbflbjVRCPl92efMEqrwwK+yBlGh8I78+/DTfxzShofsiHAt3SPVwwkLr3c/q/3SvEfGzXPEaumXXC7KJz2g+Ijusyp9eqAlpVgi3FhOAQWHyVJvOkL4fd7KE5JuItK0mdeyztx1LJdeQWRR1MAT9oHPD2nAcfh/DuT7gFN6atD+5uFFEf5uiAxEsn0iq1/nXazJM5ThPtaxwJ2gxnLSwsb0mp2PkTE2XWy1tf5uu6xt/3pVC4WoMKlSmIzP9Fi1Qp2o21yfvm3JtgoA8ZHoDIAHgzewGWZUMTDMccryAvCH7MCV4xtVmpNbEsYPVG0JgCy5zupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nPlvugdTy6a47ns1tiFpM5/RhGW1Di7imXS5emtxP8=;
 b=kd3AEqevVjuMFuukojTFjSMNOJCYPv4Oo3ueJlq8Ogc+wb10qSZQHZ931QpD1c7uLr7bXpqHOPD6hTX0LxplrUMhzm/Mi4LAJMkTPL7cgRVJaBo9k/HYrHq1OnrYsiQ72XSpRDd9v5VWwqCErozUMhDnAZ8w4lX3ncUJLL7ije/4p1B6+q6SSRoevmxmIIrtK6V6m5ss9jexEchdDZcIvSnE/rpsg2ntqUYPYZEuD2c9UZr/fzDibr9HXAB7d7A8b6RzxqPdrPGIbJvkisWMjmxsPzFmaGOpNq7bOv0nHl387mPbnCgqmlQ20o6hwcdrG5lv+2CBfoclnuIc1x+fqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nPlvugdTy6a47ns1tiFpM5/RhGW1Di7imXS5emtxP8=;
 b=D16eBPPkCWCLmz7DJjjouBT2j80d2Nww+3BdOflCrfZ8hcJltqKo+CcNFKLg4xd2tM0ifF+roRWp1s7nPf9+7DEM1t8uHVCETtUxyz6YGh3oUzt2woL28LndaD20ntPxCUnVjAaQCK68lYfBXiJVJh56Sj7QVcF66QnV1pLrvMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB8065.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:389::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:36:24 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 07:36:24 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 2/2] scripts/setlocalversion: sync with linux v6.9
Date: Wed, 15 May 2024 09:36:12 +0200
Message-Id: <20240515073612.1511149-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240515073612.1511149-1-rasmus.villemoes@prevas.dk>
References: <20240515073612.1511149-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::8)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: b88c8455-e82a-461f-f603-08dc74b1b929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|366007|1800799015|52116005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9nqEKup8Ob++9AYu+/CMap8u3KhGLmZahV3dC8x2ymIM7IfWUNxMAdpYU9nq?=
 =?us-ascii?Q?COM4oGGq/65/F2jn+f7H2ERNqx/FxmpGl/KEGQeLVf/coyw+Or5NYYdwKRvD?=
 =?us-ascii?Q?loInW4TzNJF6KD1yCP86uKnYrqZd5R1CloXGh3dbC8kQUOscVLFLX2hHye05?=
 =?us-ascii?Q?cdfas37BKlNMIyZ+vYPYJFPIBW+hrCd5cZ5u+MgIemiPKQ9PlmBOBYxxI3nS?=
 =?us-ascii?Q?QlMRN1TZb5hlpy7ru45ljO9EC/rVozr+rKbRzJu+4ye6gEDzSE8NwFu3Gtg/?=
 =?us-ascii?Q?AMX0AluCjL8tnXbUk+on4jNyI0f9sG5fmUzE6Je0B2Fk/mLIkfRHtLUGXuMs?=
 =?us-ascii?Q?AtryH0VB171aw4QqHjKPrioHebz0AccLwJEks2uV2z1i7+SXo9fnjsuiWzI3?=
 =?us-ascii?Q?HmcQj4yqojhrTiAeDOCfgXLl/jghwEYApyoPpFtx4tS8O5UH8EV5qbEilyCb?=
 =?us-ascii?Q?es5j8iUFFIkldy+9siyuWIqPU+zs7xcPh5SQjmVi5K75qnTurmwKcLC6AkrR?=
 =?us-ascii?Q?y3TFM+/0hyX7OTcP2IKrrmxn51EFSNO9yvFb4wj4jlIwYXVx+5DEGVo2rZQS?=
 =?us-ascii?Q?yoDTaHu9caXWenp6WNhEIuEqJw3lC0XMZP37+5imT57xJGhsYLg4+qJRhGtN?=
 =?us-ascii?Q?EWYVGOa1K5xe5Wl0LDXUR6V4y732r/mfRkSFAlVr3ExpbL7XadsxSeYNDQlA?=
 =?us-ascii?Q?BjKuiwWuAgjKSAtpr0Hpo8ShN//qgnIi3lUwrMEXFulIoMTbY4O1o29nIkMY?=
 =?us-ascii?Q?upYxT8w2xhd8ieeFXREuE9VcTzCix6/Efje80d9BsZv/w76NNGXrboM7v183?=
 =?us-ascii?Q?iLbq7WrM6R/Q3jQx6Nws37msIW8TUKgnXRkBxmrGVodS/a0uEzBPAF3vynHu?=
 =?us-ascii?Q?TYFcvbUdxxEzbBGGkHe203Fn3jHsZk7EitL+ANkYulL8ftGHyoB7XNbX2xKU?=
 =?us-ascii?Q?0l1oxEk3LAFqHH3n4QwbapcCp+5d9CKtuZxx+eJyrfcDM/Wek0Jq1fcggKDb?=
 =?us-ascii?Q?4lBgNKw0ysoos5f2lQL5OTj4JkqAS9X48QK8Z/KXBuqSN3jmu1kfzDrfxcTV?=
 =?us-ascii?Q?WdUgncSrWHwjFI2FCpuuH5goaOPD2kuuuxH+3LsgJ/kaWMMh2Hn1AJVbeVeP?=
 =?us-ascii?Q?lzg8bKFNBABtJRSuDmD58ddGcNttMTujUE+By9b66vCXTjEJOjpnWXPIVoqa?=
 =?us-ascii?Q?2oT9YYsjCi1wc9is1AXFlh2ZYna8/S2exPashQBUSXjBlTrtTv+bvGeYyl4V?=
 =?us-ascii?Q?90kZbCbenK8gZyW2mTR7WzlSwROZcwxHcmTkqhS9bb82Ls1Jv7uKB5D4fCtV?=
 =?us-ascii?Q?RVeGzO2pF1XmOV5328IZSbmVLEnVXFeCT9efG6CvA2OA+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lb7GS6Ec7Cr5WK5uRWkFCH5uefVH0lBF4kboUu0M/bCatAX7IeLmkg4WKvIV?=
 =?us-ascii?Q?VWebolFkr2+sLeOLqCO5778A0hdJ2L5ANT6qj/bS3FFzIZNJet3U5KCixgHV?=
 =?us-ascii?Q?d5MvcEAkj+Bn/w6GRt7EGWqaEejwT1eDRyL1Qvix76WOb5KYNpL+uOUSKArJ?=
 =?us-ascii?Q?ydwKWhtu1rh6rMO04I++nY+A2j56as1bPXQHxgVQqy6oa37VHG5DzkVaCfZu?=
 =?us-ascii?Q?jS5RERuxz44Tl2PTx+kE2H/UK1k5WtV1pw9W4Mxo85fGM2QRQAEAL4PJPd31?=
 =?us-ascii?Q?8fgflrhPBBt7BHktT07gM7aUsgnMeeFGbR0mnp2e1J1684ohDd8KR7ms11Lr?=
 =?us-ascii?Q?FT9N6cJudIBiIWy7hKTfacXZdzlDAdexQWsatPglgsUKgvF8Xu2hwydTzH3j?=
 =?us-ascii?Q?BQBoxa7/+AF/f8BJWoGBZ+UxtjgnYCbolt1YwLc+MFQ1dVThGOrgi+OM0GoE?=
 =?us-ascii?Q?3QxIUgdPWSI7IoMygyrq3Uk+W9WITsHee14jgUyYXrEy4FJSfDhV9DLDopha?=
 =?us-ascii?Q?j93VmRZtg8caLJF9vhk3nFzHLYtRB5AUOgw6XIT82xD3ULTukrlhog8h+dxX?=
 =?us-ascii?Q?m7b5+J1ibMpfX17yTgbOKVrHHasnAHLBxYlhxGX++Z0nbi+i281o7OhAudJn?=
 =?us-ascii?Q?D5I3LLrmpd23z32i7iB9SVT3Jb9qMgiGbL1YdiuWI8OsQ4jy4HdkMdjnHM1N?=
 =?us-ascii?Q?7qYyvihEmakOv3yTIuBYpVbMRBGY4BlHzsiViawCIcCgF8mr/WqjXpZNztku?=
 =?us-ascii?Q?NwcRKLWn7KVYJxJ9x7TCtjkHQC7QenCIM8GGhBN5HdrZGAhoD3GjvOyqd/HI?=
 =?us-ascii?Q?OWDCqFugPjl/aNjLfZUSMOq+893rY/DMvdfJJMdMixqhOua8oliGNV5IOtmy?=
 =?us-ascii?Q?etzNrWkr8kanaPiuFzOI89+l4Mg6g9QCxee6PK7oWJQNhZqFPYlZixjqV+ei?=
 =?us-ascii?Q?E8BCaurdNdvvMNLL3U7yVva40xHDJouoXLY2zi+mE8fh3IDt0yRkHsW13sP3?=
 =?us-ascii?Q?dIHovV8zkflUpNA2MN1P9j8QsC+zG+bbaUxMQ2XK59cDBN31huN8qmE5W3KH?=
 =?us-ascii?Q?9mPjCaV8TOeSEozdNyt+CDQZPjjrZjEdm0bUII/u9uZiQfVQOgK1EpNhGkeY?=
 =?us-ascii?Q?Unk+6eL+2bvo5TOXA9dghtnes/5grD0phCzYTFXldy1kBbICw3elFbdJZ5pH?=
 =?us-ascii?Q?TVHqjVL9eo+4iVwasj/HKwH9fcPOkic0b3VDCk2G4DeUAkvhToYgbVzXraAg?=
 =?us-ascii?Q?cIx30mEsj0pn9vYVuVWNNXF0Ze6XO2iRuXE06MTXCuGOP0U8J/E/DCG7R523?=
 =?us-ascii?Q?MwIQPMyguG41KUm5RuZnSwPxiay38IRTdU1E2sfAF5SrV7IiWxjRWV0Jb0GJ?=
 =?us-ascii?Q?mKnXLxmB0KGPfxE/Ya9CAbtblj3rFkZO8zSbSmpbNFxoAbdFdb3c55JoUpzC?=
 =?us-ascii?Q?X+nG1kdyYGkjxZiLF+wNlTTDNM6E7HS4DZnWvxwF2dGSO1dcelxbgR9BHbIE?=
 =?us-ascii?Q?uBs/csdzWcL15CT2O6zJ8n5ae2bGj91P9T+skpNrBvww0rTubU3j8gXnE2he?=
 =?us-ascii?Q?v0aUPg+EDGOUxitwRaztdRA1ct6vlEOZgEk+Du68WRW7gaVRHcU1QVs/iMFe?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b88c8455-e82a-461f-f603-08dc74b1b929
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 07:36:24.5786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+r+/jpmbiqjH9hTlIV80T2OmFaDgAk6asBPsOpGihxBomY+cjgalhwfhoAFSD7cYIHcpRbmzbXxhznMJvApe7uCp+Ds6WG4c7eJfHDhviQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8065
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

The changes upstream since the last sync (2ed1b242ab2
"scripts/setlocalversion: sync with linux 5.8") are

(5) 548b8b5168c9 scripts/setlocalversion: make git describe output more reliable
    77a88274dc1a kbuild: replace LANG=C with LC_ALL=C
    2a73cce2dad3 scripts/setlocalversion: remove mercurial, svn and git-svn supports
    a2be76a352f1 scripts/setlocalversion: remove workaround for old make-kpkg
    ffaf62a8050b scripts/setlocalversion: add more comments to -dirty flag detection
    630ff0faf84e scripts/setlocalversion: factor out 12-chars hash construction
    042da426f8eb scripts/setlocalversion: simplify the short version part
    5df99bec210a scripts/setlocalversion: fix a bug when LOCALVERSION is empty
(1) 7d153696e5db kbuild: do not include include/config/auto.conf from shell scripts
(2) 129ab0d2d9f3 kbuild: do not quote string values in include/config/auto.conf
    f6e09b07cc12 kbuild: do not put .scmversion into the source tarball
    992ebfab2a75 setlocalversion: simplify the construction of the short version
    75280bdf49b2 setlocalversion: make indentation shallower
(3) ec31f868ec67 setlocalversion: absorb $(KERNELVERSION)
    eed36d775177 setlocalversion: clean up the construction of version output
(4) 6ab7e1f95e96 setlocalversion: use only the correct release tag for git-describe
    05e96e96a315 kbuild: use git-archive for source package creation
    3354c64d4184 scripts/setlocalversion: clean up stale comment
    01e89a4acefc scripts/setlocalversion: also consider annotated tags of the form vx.y.z-${file_localversion}

The only thing U-Boot has been applying on top was to deal with not
sourcing include/config/auto.conf but instead using awk to extract the
right value. Commit (1) did a very similar thing upstream, so we no
longer need to do that. However, upstream then went a step further (2)
and changed the convention for what goes into auto.conf, so RHS no
longer contain double-quotes. That commit thus changed the sed pattern
to no longer match those quotes, but as U-Boot has not yet adopted
that change, we have to deal with that. In order to be a little
forward-compatible, I did that in a way that should work both ways:

 # version string from CONFIG_LOCALVERSION
-config_localversion=$(sed -n 's/^CONFIG_LOCALVERSION=\(.*\)$/\1/p' include/config/auto.conf)
+config_localversion=$(sed -n 's/^CONFIG_LOCALVERSION=\(.*\)$/\1/p' include/config/auto.conf | tr -d '"')

Furthermore, (3) now requires that there is an appropriate
KERNELVERSION environment variable set. One way to deal with that
would be to just modify the script to use UBOOTVERSION instead, but
for now I've instead opted to let the Makefile provide
KERNELVERSION=$(UBOOTVERSION) to keep the setlocalversion changes
minimal.

That variable is further put to use in (4). Note that the logic for
mapping *VERSION -> [upstream annotated tag to look for] works
unchanged in U-Boot for the current versioning scheme 20XX.YY(-rcN)?.

My motivation for wanting to do this sync is to get (4) and (5), in
order to get the setlocalversion output both more predictable and
consistent across different build environments, i.e. independent of
random local .gitconfig settings, total number of git objects and/or
existence of unrelated tags (possibly from some tracked fork).

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 Makefile                |   5 +-
 scripts/setlocalversion | 226 ++++++++++++++++++++--------------------
 2 files changed, 116 insertions(+), 115 deletions(-)

diff --git a/Makefile b/Makefile
index efaf24e58e7..14acea9c6b9 100644
--- a/Makefile
+++ b/Makefile
@@ -1898,8 +1898,11 @@ $(filter-out tools, $(u-boot-dirs)): tools
 # is "yes"), so compile examples after U-Boot is compiled.
 examples: $(filter-out examples, $(u-boot-dirs))
 
+# The setlocalversion script comes from linux and expects a
+# KERNELVERSION variable in the environment for figuring out which
+# annotated tags are relevant. Pass UBOOTVERSION.
 define filechk_uboot.release
-	echo "$(UBOOTVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
+	KERNELVERSION=$(UBOOTVERSION) $(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree)
 endef
 
 # Store (new) UBOOTRELEASE string in include/config/uboot.release
diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 4a631437067..dbe048210d6 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # This scripts adds local version information from the version
-# control systems git, mercurial (hg) and subversion (svn).
+# control system git.
 #
 # If something goes wrong, send a mail the kernel build mailinglist
 # (see MAINTAINERS) and CC Nico Schottelius
@@ -11,16 +11,17 @@
 #
 
 usage() {
-	echo "Usage: $0 [--save-scmversion] [srctree]" >&2
+	echo "Usage: $0 [--no-local] [srctree]" >&2
 	exit 1
 }
 
-scm_only=false
-srctree=.
-if test "$1" = "--save-scmversion"; then
-	scm_only=true
+no_local=false
+if test "$1" = "--no-local"; then
+	no_local=true
 	shift
 fi
+
+srctree=.
 if test $# -gt 0; then
 	srctree=$1
 	shift
@@ -31,96 +32,98 @@ fi
 
 scm_version()
 {
-	local short
-	short=false
+	local short=false
+	local no_dirty=false
+	local tag
+
+	while [ $# -gt 0 ];
+	do
+		case "$1" in
+		--short)
+			short=true;;
+		--no-dirty)
+			no_dirty=true;;
+		esac
+		shift
+	done
 
 	cd "$srctree"
-	if test -e .scmversion; then
-		cat .scmversion
+
+	if test -n "$(git rev-parse --show-cdup 2>/dev/null)"; then
 		return
 	fi
-	if test "$1" = "--short"; then
-		short=true
-	fi
 
-	# Check for git and a git repo.
-	if test -z "$(git rev-parse --show-cdup 2>/dev/null)" &&
-	   head=$(git rev-parse --verify --short HEAD 2>/dev/null); then
-
-		# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore
-		# it, because this version is defined in the top level Makefile.
-		if [ -z "$(git describe --exact-match 2>/dev/null)" ]; then
-
-			# If only the short version is requested, don't bother
-			# running further git commands
-			if $short; then
-				echo "+"
-				return
-			fi
-			# If we are past a tagged commit (like
-			# "v2.6.30-rc5-302-g72357d5"), we pretty print it.
-			if atag="$(git describe 2>/dev/null)"; then
-				echo "$atag" | awk -F- '{printf("-%05d-%s", $(NF-1),$(NF))}'
-
-			# If we don't have a tag at all we print -g{commitish}.
-			else
-				printf '%s%s' -g $head
-			fi
-		fi
+	if ! head=$(git rev-parse --verify HEAD 2>/dev/null); then
+		return
+	fi
 
-		# Is this git on svn?
-		if git config --get svn-remote.svn.url >/dev/null; then
-			printf -- '-svn%s' "$(git svn find-rev $head)"
-		fi
+	# mainline kernel:  6.2.0-rc5  ->  v6.2-rc5
+	# stable kernel:    6.1.7      ->  v6.1.7
+	version_tag=v$(echo "${KERNELVERSION}" | sed -E 's/^([0-9]+\.[0-9]+)\.0(.*)$/\1\2/')
+
+	# If a localversion* file exists, and the corresponding
+	# annotated tag exists and is an ancestor of HEAD, use
+	# it. This is the case in linux-next.
+	tag=${file_localversion#-}
+	desc=
+	if [ -n "${tag}" ]; then
+		desc=$(git describe --match=$tag 2>/dev/null)
+	fi
 
-		# Check for uncommitted changes.
-		# First, with git-status, but --no-optional-locks is only
-		# supported in git >= 2.14, so fall back to git-diff-index if
-		# it fails. Note that git-diff-index does not refresh the
-		# index, so it may give misleading results. See
-		# git-update-index(1), git-diff-index(1), and git-status(1).
-		if {
-			git --no-optional-locks status -uno --porcelain 2>/dev/null ||
-			git diff-index --name-only HEAD
-		} | grep -qvE '^(.. )?scripts/package'; then
-			printf '%s' -dirty
-		fi
+	# Otherwise, if a localversion* file exists, and the tag
+	# obtained by appending it to the tag derived from
+	# KERNELVERSION exists and is an ancestor of HEAD, use
+	# it. This is e.g. the case in linux-rt.
+	if [ -z "${desc}" ] && [ -n "${file_localversion}" ]; then
+		tag="${version_tag}${file_localversion}"
+		desc=$(git describe --match=$tag 2>/dev/null)
+	fi
 
-		# All done with git
-		return
+	# Otherwise, default to the annotated tag derived from KERNELVERSION.
+	if [ -z "${desc}" ]; then
+		tag="${version_tag}"
+		desc=$(git describe --match=$tag 2>/dev/null)
 	fi
 
-	# Check for mercurial and a mercurial repo.
-	if test -d .hg && hgid=$(hg id 2>/dev/null); then
-		# Do we have an tagged version?  If so, latesttagdistance == 1
-		if [ "$(hg log -r . --template '{latesttagdistance}')" = "1" ]; then
-			id=$(hg log -r . --template '{latesttag}')
-			printf '%s%s' -hg "$id"
-		else
-			tag=$(printf '%s' "$hgid" | cut -d' ' -f2)
-			if [ -z "$tag" -o "$tag" = tip ]; then
-				id=$(printf '%s' "$hgid" | sed 's/[+ ].*//')
-				printf '%s%s' -hg "$id"
-			fi
+	# If we are at the tagged commit, we ignore it because the version is
+	# well-defined.
+	if [ "${tag}" != "${desc}" ]; then
+
+		# If only the short version is requested, don't bother
+		# running further git commands
+		if $short; then
+			echo "+"
+			return
+		fi
+		# If we are past the tagged commit, we pretty print it.
+		# (like 6.1.0-14595-g292a089d78d3)
+		if [ -n "${desc}" ]; then
+			echo "${desc}" | awk -F- '{printf("-%05d", $(NF-1))}'
 		fi
 
-		# Are there uncommitted changes?
-		# These are represented by + after the changeset id.
-		case "$hgid" in
-			*+|*+\ *) printf '%s' -dirty ;;
-		esac
+		# Add -g and exactly 12 hex chars.
+		printf '%s%s' -g "$(echo $head | cut -c1-12)"
+	fi
 
-		# All done with mercurial
+	if ${no_dirty}; then
 		return
 	fi
 
-	# Check for svn and a svn repo.
-	if rev=$(LANG= LC_ALL= LC_MESSAGES=C svn info 2>/dev/null | grep '^Last Changed Rev'); then
-		rev=$(echo $rev | awk '{print $NF}')
-		printf -- '-svn%s' "$rev"
-
-		# All done with svn
-		return
+	# Check for uncommitted changes.
+	# This script must avoid any write attempt to the source tree, which
+	# might be read-only.
+	# You cannot use 'git describe --dirty' because it tries to create
+	# .git/index.lock .
+	# First, with git-status, but --no-optional-locks is only supported in
+	# git >= 2.14, so fall back to git-diff-index if it fails. Note that
+	# git-diff-index does not refresh the index, so it may give misleading
+	# results.
+	# See git-update-index(1), git-diff-index(1), and git-status(1).
+	if {
+		git --no-optional-locks status -uno --porcelain 2>/dev/null ||
+		git diff-index --name-only HEAD
+	} | read dummy; then
+		printf '%s' -dirty
 	fi
 }
 
@@ -141,48 +144,43 @@ collect_files()
 	echo "$res"
 }
 
-if $scm_only; then
-	if test ! -e .scmversion; then
-		res=$(scm_version)
-		echo "$res" >.scmversion
-	fi
-	exit
-fi
-
-if test -e include/config/auto.conf; then
-	# We are interested only in CONFIG_LOCALVERSION and
-	# CONFIG_LOCALVERSION_AUTO, so extract these in a safe
-	# way (i.e. w/o sourcing auto.conf)
-	# xargs echo removes quotes
-	CONFIG_LOCALVERSION=`cat include/config/auto.conf | awk -F '=' '/^CONFIG_LOCALVERSION=/ {print $2}' | xargs echo`
-	CONFIG_LOCALVERSION_AUTO=`cat include/config/auto.conf | awk -F '=' '/^CONFIG_LOCALVERSION_AUTO=/ {print $2}' | xargs echo`
-else
-	echo "Error: kernelrelease not valid - run 'make prepare' to update it" >&2
+if [ -z "${KERNELVERSION}" ]; then
+	echo "KERNELVERSION is not set" >&2
 	exit 1
 fi
 
 # localversion* files in the build and source directory
-res="$(collect_files localversion*)"
+file_localversion="$(collect_files localversion*)"
 if test ! "$srctree" -ef .; then
-	res="$res$(collect_files "$srctree"/localversion*)"
+	file_localversion="${file_localversion}$(collect_files "$srctree"/localversion*)"
+fi
+
+if ${no_local}; then
+	echo "${KERNELVERSION}$(scm_version --no-dirty)"
+	exit 0
+fi
+
+if ! test -e include/config/auto.conf; then
+	echo "Error: kernelrelease not valid - run 'make prepare' to update it" >&2
+	exit 1
 fi
 
-# CONFIG_LOCALVERSION and LOCALVERSION (if set)
-res="${res}${CONFIG_LOCALVERSION}${LOCALVERSION}"
+# version string from CONFIG_LOCALVERSION
+config_localversion=$(sed -n 's/^CONFIG_LOCALVERSION=\(.*\)$/\1/p' include/config/auto.conf | tr -d '"')
 
-# scm version string if not at a tagged commit
-if test "$CONFIG_LOCALVERSION_AUTO" = "y"; then
+# scm version string if not at the kernel version tag or at the file_localversion
+if grep -q "^CONFIG_LOCALVERSION_AUTO=y$" include/config/auto.conf; then
 	# full scm version string
-	res="$res$(scm_version)"
-else
-	# append a plus sign if the repository is not in a clean
-	# annotated or signed tagged state (as git describe only
-	# looks at signed or annotated tags - git tag -a/-s) and
-	# LOCALVERSION= is not specified
-	if test "${LOCALVERSION+set}" != "set"; then
-		scm=$(scm_version --short)
-		res="$res${scm:++}"
-	fi
+	scm_version="$(scm_version)"
+elif [ "${LOCALVERSION+set}" != "set" ]; then
+	# If the variable LOCALVERSION is not set, append a plus
+	# sign if the repository is not in a clean annotated or
+	# signed tagged state (as git describe only looks at signed
+	# or annotated tags - git tag -a/-s).
+	#
+	# If the variable LOCALVERSION is set (including being set
+	# to an empty string), we don't want to append a plus sign.
+	scm_version="$(scm_version --short)"
 fi
 
-echo "$res"
+echo "${KERNELVERSION}${file_localversion}${config_localversion}${LOCALVERSION}${scm_version}"
-- 
2.40.1.1.g1c60b9335d

