Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DEDC4452B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 04:46:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4056A80E88;
	Thu, 23 Jul 2026 04:46:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K3BUShwlKgG5; Thu, 23 Jul 2026 04:46:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6163280ED6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784781986;
	bh=WgZbnyPGEwGx4QcrX+l8JQgGIKKgANRl/gsU4uakw20=;
	h=From:Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lbb+l4agaSFBz7yR3j+nMXTEEsNpGv+9L1uYFz8HZBq1lmmGvt+ArCcoq8ctgmrNv
	 HFvJ2pV/rKC6Jtms1vZ+TIsxBThCUMBmiLdiiGGn/tzlVVp6k/9LfueDtLKhOQKlvJ
	 hdZ6EMXrfh0fZi9KbaGb5QfnkYB5umBWamukjY9pIQ1MIxzL3eiz0/MIS1KeXUjeai
	 Bfu2sRgURsQntS9lkPI2Lr65llR4cdrQQ73pIzAgIwmDSoWtg9qWTM6AqfnbprS/Nu
	 bKjdA34VoqcPoDNqTrLqdXutM0RBzxiKZPW/1ygz6DCh/wtBYR7HkpVl2psymZXq47
	 gpsR679V2Y62A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6163280ED6;
	Thu, 23 Jul 2026 04:46:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 036D742A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 03:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8FCF80C9D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 03:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5mEBovHr077K for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 03:19:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.2;
 helo=m16.mail.163.com; envelope-from=liulhong617@163.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A5A9280C48
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5A9280C48
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A5A9280C48
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 03:19:24 +0000 (UTC)
Received: from liulianghong01.hobot.cc (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wAHV3UoiGFq1mDcKg--.25452S2; 
 Thu, 23 Jul 2026 11:19:05 +0800 (CST)
From: Lianghong Liu <liulhong617@163.com>
Date: Thu, 23 Jul 2026 09:40:21 +0800
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org
In-Reply-To: <20260713074539.32875-1-liulhong617@163.com>
References: <20260713074539.32875-1-liulhong617@163.com>
Message-Id: <1784776723.232131-1-liulhong617@163.com>
Subject: [PATCH v3] Makefile: depend on OF_LIST dts sources for fit-dtb.blob
X-CM-TRANSID: _____wAHV3UoiGFq1mDcKg--.25452S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1xtFy5Xryfur1ftFWDArb_yoW5Cry7p3
 savr4rKw4kJFy8t3yUC347uasxtrZ8t3yjkFy5Cr1UArs8Gw1xXFsa9w4Yqr17Gw4kJ3yY
 vrsa9343GF45Ga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfR67UUUUU=
X-Originating-IP: [39.170.101.209]
X-CM-SenderInfo: holxzxxrqjliqx6rljoofrz/xtbC+gkfeWphiClH2AAA3g
X-Mailman-Approved-At: Thu, 23 Jul 2026 04:46:25 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=163.com; 
 s=s110527; h=From:Date:To:Message-Id:Subject; bh=WgZbnyPGEwGx4Qc
 rX+l8JQgGIKKgANRl/gsU4uakw20=; b=dczRUonGpEDyiqO0W5/crVKAuAZz/7Y
 LKr9G8ZXV2g8uS/bre65p6QjgaDNt4zS2bSELDeMf3/N6wQXa4rCTRFfI9dQU+3A
 vdrZDBvordKk+/9+TdpaOaNnMUArxYHu60oOBs0ZOTPGqC4weR9qh9/mFyP2eniT
 q/mxoMisTrIo=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=163.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=dczRUonG
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

When CONFIG_MULTI_DTB_FIT is enabled, fit-dtb.blob is produced by
mkimage with one "-b " argument for every entry in CONFIG_OF_LIST.
The make rule, however, only listed dts/dt.dtb (i.e. the
CONFIG_DEFAULT_DEVICE_TREE blob) as a prerequisite:

  fit-dtb.blob: dts/dt.dtb FORCE
      $(call if_changed,mkimage)

Because FORCE is PHONY, if_changed ignores it and rebuilds only when
any-prereq or arg-check is non-empty.  Editing a non-default dts in
OF_LIST rebuilds its .dtb (tracked correctly via fixdep), but that
.dtb was not a prerequisite of fit-dtb.blob, so $? stayed empty; the
mkimage command line was unchanged too, so arg-check was empty as
well.  if_changed therefore skipped mkimage and fit-dtb.blob kept the
stale dtbs.  u-boot.bin, which appends fit-dtb.blob, then shipped the
old device tree and the dts change did not take effect.

A previous attempt to fix this added every OF_LIST .dtb *output* as a
prerequisite.  That is wrong on two counts:

  - Clean build regression: the OF_LIST .dtb files are produced only
    by the recursive dts/dt.dtb -> arch-dtbs sub-make descent and have
    no rule at the top make level, so listing them as prerequisites
    makes them rule-less/intermediate.  After a from-scratch rebuild
    (e.g. wiping an out-of-tree build directory) it fails:

      make[1]: *** No rule to make target 'arch/arm/dts/.dtb',
               needed by 'fit-dtb.blob'.  Stop.

  - Incremental two-build race still present: the .dtb outputs are
    written by a child sub-make descent while the parent make level
    checks prerequisites, so under `make -j` an edit can still need
    two make invocations to take effect.

List the .dts *sources* instead, which the top make level can see via
VPATH in both objtree and srctree.  Use $(dt_dir), as
MKIMAGEFLAGS_fit-dtb.blob already does just below, so that
CONFIG_OF_UPSTREAM boards (whose sources live under dts/upstream/src/)
are handled too; a helper variable keeps the rule under 80 columns.

Limitation: this only catches edits to the top-level .dts files in
OF_LIST.  An edit to an included .dtsi (including the *-u-boot.dtsi
files) rebuilds the .dtb but leaves fit-dtb.blob stale, so the
two-build problem remains in that case.  Fixing that fully would need
the .dtb outputs (rather than the .dts sources) as prerequisites,
which reintroduces the clean-build problem above; covering top-level
.dts edits is already a worthwhile improvement.

Signed-off-by: Lianghong Liu <liulhong617@163.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7f5d83658d7..fec20669607 100644
--- a/Makefile
+++ b/Makefile
@@ -1475,7 +1475,8 @@ fit-dtb.blob.gz: fit-dtb.blob
 fit-dtb.blob.lzo: fit-dtb.blob
 	@lzop -f9 $< > $@
 
-fit-dtb.blob: dts/dt.dtb FORCE
+of_list_srcs := $(patsubst %,$(dt_dir)/%.dts,$(subst ",,$(CONFIG_OF_LIST)))
+fit-dtb.blob: dts/dt.dtb $(of_list_srcs) FORCE
 	$(call if_changed,mkimage)
 ifneq ($(SOURCE_DATE_EPOCH),)
 	touch -d @$(SOURCE_DATE_EPOCH) fit-dtb.blob
-- 
2.34.1

