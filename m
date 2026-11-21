Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C4606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ehn03Gt0;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=AnjrZgLd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2900B40669;
	Sat, 21 Nov 2026 12:06:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R202vs2ilR1K; Sat, 21 Nov 2026 12:06:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6CF794062B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795262763;
	b=O/YiH9PdWt/daPHlQGlKPibQknEr5Oix0LZXd9N09aJnzFiyDMoLrAdYpElTJe4eoVl5
	 OKP4EFsrsjUlnMAebfOqrdbIXp9CftHH7TSTeimys7oQxl+FmQmuKJpDSqVIBzEOu/wp4
	 jSO5sKnok9OsfqcG53QyAscjbrIMtRLw5Kgtb+enttjr+AohBf9pmFWEvtaxnP+sd0PF0
	 OziBdbZWUlLE+AHcbP2AsjXac0Hd3YMcwOcimJOxr/fF5zydIkSJ8gOnarbNvVyElhuJE
	 pBoL/9Ufm2Dq1hWwO/yszBxNAaLYWjSr3pQYMZLQGM6mOQSxr0aUk266teQcf7pZ+1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795262763;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f04Rw4F3CSpMpg1+RGhgK6n99gqLQCUshtt9YGGVybQ=;
	b=BljfinDda0BnbbcAggDWsypPM4DXb2qpDGofAYgZPrSO8abutpbETpknZzR/dcSA7Fy4
	 L33us3Y8nunqRlH9jKdB8VyQIWRNJouWWXIs30hXNXtRUEpvwRG6wxeVDQJe6NPtTbB8V
	 lOkTaCZiwKjux6v8NaFZe+fCgT+CP52RVuHVzWdMxa93YYH86afUrnd4vacgL6yebeXoG
	 9QFKUSeaiTuUrWsHN0C/xKU2eR5Z3FnqyGymhnDnd+jkEzteO19DfRjdWT+XMbMSH40D4
	 M95Z+/mclJ6WiLuptXymd+zKms91FmqhaQ3eCfhjoLYEhxg3k+tKX/P4CKxyqKhe0QA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=AnjrZgLd;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795262763;
	bh=f04Rw4F3CSpMpg1+RGhgK6n99gqLQCUshtt9YGGVybQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ehn03Gt0nszGa4w1uzxh07+dY+Q7uii+PJZnTwu6V44hNBflHTA/5L5CvHfochHOT
	 56oIe7FTFUwY5EOY90JtMfPviFPPctIMj8tg/8059U7yrGKTscMGuxKZ3CxPktjBxj
	 cQ82bCBFtMFc9SuHsvRKaYolJwhF/g1pZYzU4qidXrE//VWWV9jDZr8JE2y+pIjrCR
	 n6F0ObONo0ak2nEs4LGkKFRORe5BTFoWJJmNNYoBod6LHZii+qzvj4KeFWuXBBw+Em
	 JLBF7ePcctaENCu3SNrl7/v05qiRnjsAldxfPKEICE1hk3FuZ9dacrVcf5l3vx60Vw
	 d/aBa1KWT1nMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CF794062B;
	Sat, 21 Nov 2026 12:06:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B52B3A8
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CC224062B
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:06:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-Leu8zKAxAq for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:06:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7410F405B6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=AnjrZgLd
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7410F405B6
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:05:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 4C269B0054C;
 Sat, 21 Nov 2026 13:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1795262758;
 bh=K3u2/+GILralJYb8ZD7xnx/mbHdVZmDgJQSeS6rMvJE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AnjrZgLds5bk501tWotx0YZzf1ue4PI/KRxbvR+TrNRyIyFVcEyvULUx6UqMiCPSR
 88KcGZUv7Qss6bTcoDQooZ3zrzTOwO95J/B665FafjjdtIL+Rog2pZFFKyMR0XZyTq
 3+erBUx87pYaaKDXmyURfIolhdMiF6IU8xCJQ4Y+DH8fZVVdVYq1n65XLxjOs4qRj5
 zv0B3flg3u5hYf4TqwujejdbGVtl/VYnNhvsfRIZIqZNlgGVkmZT4aRPX/PTdwDcxr
 rOf3y0QqJNc6hNGm7sukLHfhX6YM/lyVMCnY+KYWGh5eNLEwOYkf202S+NOpvKc8BM
 TwhLEMXHHGSbQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Denis Mukhin <dmukhin@ford.com>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>, Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Simon Glass <sjg@chromium.org>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 2/4] scripts: Makefile.dts: build the device tree with
 DEVICE_TREE= too
Date: Sat, 21 Nov 2026 13:04:42 +0100
Message-ID: <20261121120445.3795725-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121120445.3795725-1-vjardin@free.fr>
References: <20261121120445.3795725-1-vjardin@free.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The directories built based on scripts/Makefile.dts,
dts/upstream/src/<arch> and its vendor directories, list the device trees
of Kconfig only:
CONFIG_DEFAULT_DEVICE_TREE, CONFIG_OF_LIST and CONFIG_SPL_OF_LIST.

If "make DEVICE_TREE=<name>" selects another one in dts/Makefile, nothing
builds it, it stops with:

  Device Tree Source (dts/upstream/src/arm64/freescale/<name>.dtb) is not
  correctly specified.

The arch/<arch>/dts directories are not affected: their dtb-y lists are
explicit and DEVICE_TREE picks one of them.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 scripts/Makefile.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 3871a4ad412..fd9ff420585 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
+dtb-y += $(patsubst %,%.dtb,$(sort $(DEVICE_TREE) \
+	$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST))))
 dtb-y += $(patsubst %,%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
 
 ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
-- 
2.43.0

