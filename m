Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58766606A6B6
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zun5qnNP;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ni3fosdD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06F1181777;
	Fri, 20 Nov 2026 22:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q83zWhKulSAS; Fri, 20 Nov 2026 22:05:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D029081858
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212331;
	b=Jum4BahgHSCxyeFKQtiB8tY/Gpyd6RLbGzYeEnw0qdNmuX6kBvb8Tm1Gk8TGHLgCiNwL
	 MLbsGwbGDghpsEmru1ocViFPNmZzyf8uQ9K83CFiYA9bjBxkPFdQnHPYStWYX9TQMT2Ny
	 ilfaKQZ2j3Ea560EqPEg8OC9RBx8LjYZVtXDB6G+JCfTzEjEQ9OX1B+llWcNiqHIKRQ1R
	 rAGGvT0XPLoxJ8pTyICCofDo/YZoK2q0BtL5WpyNvr39gbBmgLKRSm4f3hR1DW/Yjnd9h
	 0cZRgFUzFzE+INwg5keMDh6tJYQAa6MSCINs/BZhx/XJ24Za/phCUYx/9SDUbTeGR0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212331;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QErO8I0nTeaLSEGFLFcboSe9s+sOrzSCQPSbpPNjZm4=;
	b=tQdmHXagP9UH6glatpQF6oz8JxvWE2+EiD69x45+PtsY5LAJ6UjY7qCl4J1cxTuHkNsH
	 s5fiuKxktVg8x50fNstl4eK9dvvDaa26MnwVVvUJuX2WClu15a/KcEvxEwVOluVKg/1x0
	 xYGTku3i4U7LClAEbfaQ9RM1QpXAOGdcmB2cekPqi8PkDrE7U0rIRZHeLVNwOwCOkuq3G
	 QiTA/3Cf3ZCRGFfw3rAyJ8ePyVuSzk85x5NmwgQ/XBt9V1/V2foYcySfyHzLF0DyyNra4
	 D4ufBqmheyuWt/vau9i+upD7JvGWr5AjpaFAHWIYFm25L2huX4DI4vX+7Y1I6KJvcGg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ni3fosdD;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795212331;
	bh=QErO8I0nTeaLSEGFLFcboSe9s+sOrzSCQPSbpPNjZm4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zun5qnNP1nXK8jSk3dZSPMnt6wxmJo77VLUCzc1B5BPSC5NYcCTJR/sgQl8Qh8CSa
	 RdW9GRrR6l0pqyZj03CNpyICRw/4q8xuJsH195Yod7RKnFtCHas9kozBwdlVf6bwQ9
	 d9+EdieTnOAtg6ix/URtU7qZcBJFbMO5PZwfgB3vxOfXIhIjXxbY28d01Kp7NVcyqi
	 SPYIoS8gDIMdBbD/UIDUDjyNnywbDLUA68oUf1uvO44fI0ovgdJd9IUQjek5LJUq+p
	 8dh2TwP6pJs5zwtAxoT/S6cVilK4nXxdK5FB+nawn4kIiX+ZvNiwZWTDv7LU0Uul5R
	 fNURGx2Ht1k0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D029081858;
	Fri, 20 Nov 2026 22:05:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 13D46465
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D2548179C
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LwcuM8WbO0yU for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:05:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 629F481770
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ni3fosdD
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 629F481770
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:19 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-48ed0b68895so946573fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795212319; x=1795817119;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QErO8I0nTeaLSEGFLFcboSe9s+sOrzSCQPSbpPNjZm4=;
 b=Ni3fosdDlbc1/ISvdPheVFePVXVP1j8gKCyjAYy0HAYBc+tRXMCVZfipRAl5g2Bj4d
 lnVZUT27qYj46c0itbdeUtqR2SYgfdS13eYX0Cqc9KQp4y08kl8TCYtge7gPedYpbIUk
 /BSDjmk64LxKhlBNj3bqjQq9rHdLLHUoY2dtJyNcxlavkVs2R6jvwL5vaDvOYtjRi8Dv
 i78cSWwZ4GpHMW5CCnp026XnnbONNrM6Q0QQLmQjq5Xlvdc4iQPL8ngs4fMBbAGURqHw
 +wHhWSGrFk3qnYg4rb3VYnW2Rql1OSaZBONHpRDVqHJEdQH6+D4hkF5gYGbGbyT9aZuo
 CDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795212319; x=1795817119;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QErO8I0nTeaLSEGFLFcboSe9s+sOrzSCQPSbpPNjZm4=;
 b=kYrTE96JKwJz3Ws32imvwK7yjSHZS5eYaWKJUoTQTbGgWpLlvsGJcHiEJGhZ2hP6ff
 v7B60C42SyC6QyCJ2CogeJXkBKqvMk05dRihnvkggo0n7RlwybD9ZAh9BvHhO/Uz2/Z+
 N+OhnH3w7WI/dSDeSwHYkxJyBQx/Q5atMypRCRlId8XUdt58JZFjsSTLUwEVvWR/QN7Q
 xtiwN4OeLbPc1A1FDGHI0CAKWrD7v8yIVATaxuuQV2N2Gz5fJrRXn4+R/WsAXr49GZg1
 wJCN8LIpSe4w88qNp9JgotQWlX8Ul968LITc5JUqSW24ZAOot8QjTlEFETaoaPIfjA/u
 OGVA==
X-Gm-Message-State: APuU4Z9UmYs3t/6Ig3rJMmg2v2Tf2cI+Ko46aP/pMJno6oMboqgFWNi7
 zBGoBINn+7T1/S6oUAlRyMePLxWHGJz5HULPuPvUpXR/4OLP66a9OJ6suFJ6fMfwZLU=
X-Gm-Gg: AYBFou2jM23a2fPoco3yfLLCWnxDklWoakkuC6kQiIYHIq5rugo8yaU+mN93bUUS/au
 2pJCtkX+oJA8Hc2KFkOoYlLipFCOfpNSiLFfFUkY/aFTpSyWiLEHc6WIPNcySSF5dWpks8SxOU3
 JRUrctDnwsNEpPid0j3RZLb6jvrkXvFkBt4CDvuDI2GQeTH7PRn4CIBT8feLKNeKC0WVqxnyhnm
 X+zeDhjJE5SrLRTm9DuPUYihsoqFg9BR4BZ9MjXri4rXleuGsvOJmHFiruWiONemHwtKpWxxKa2
 VwUtP/FIR0Wyimi+PJqYxkU4Xv6BxWnFIg0CgGGK/IXHgdsPYzj0c2p1OoISQcedQjgLdcZkesl
 PYAgMVTirC223Q7tI+m6NIWfqBc/gvEn3TkpkZL1IF7fiOIrNbqn3x1BMRimbiyZdlvRYEDok26
 8AYt78DKhjyMjSbnplDZ85C2B01tZcSuq5dVVtMpplWivLfh1FwRijv+2w2YVRTXKf+7h6etKpo
 dXQwpBUswXan44ksosEvI50iSNw1/CBZADoe9cjEg5Iqi5LMITsnjGJH8YZzAY6o7tnLL+tddQQ
 Aiywsfbre8Ttv4PzVpwMo6E5nzgKTre91KrkZVETcshftmQ1UZ2UOg==
X-Received: by 2002:a05:6870:7207:b0:4b7:1343:cf37 with SMTP id
 586e51a60fabf-4bc81aa23fbmr4588739fac.18.1795212318663; 
 Fri, 20 Nov 2026 14:05:18 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm3878346fac.12.2026.11.20.14.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:05:17 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 16:03:45 -0600
Subject: [PATCH v2 04/10] dts: always build the binman devicetree from
 BINMAN_DTB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-binman-dtb-v2-4-4fa1894b7e2f@baylibre.com>
References: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
In-Reply-To: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=5B0bbarF5zFazPhcemzch1exUzyUCiPZOu4c0VXmPFU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMPizwS6EH9g2H9nYJA4nI0wZX9SQUvApRoVM
 HPR5shV/tKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDD4hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AGl8H/jOHCGFlreirb9zFGOisAdqOsutwD4sgZqVpase
 VS8PBrq0qKtEIeTgOfdrxLq4lyWw9GzHfgd/0AQ8C+LEGSpc4PQ/tchS+SmfIeMeYI+XpY6uydU
 qcIeevo48JFu0BgEuoYFAL0kFbYTNMczJY28zvKmcAVYDyLQt6YwVfD/mbqfV77cmoTyd2iyVBB
 JYjeiD6uIkbIhB+dpK0qkB4XyiOGKMNgZqwMuEcsR2bGyClRenIDoZwsTdPUrhzZbb4h9Uujtzg
 ySPx0tVOpepgPECkH/IJfE2XE3VSJcLZ3F4u5hd0GzIF9mdjXQODzzxOOGl4l8gyrc5UESWZHnS
 W+Y8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the devicetree named by CONFIG_BINMAN_DTB with the dts rule for
all boards, not only with OF_UPSTREAM, so that setting the option is
enough and boards do not also have to list the file in
arch/$(ARCH)/dts/Makefile.

Boards that list it there anyway still work: the rule runs after
arch-dtbs, so it finds the file already built.

The binman devicetree does not describe hardware, so do not check it
against the devicetree schema with dtbs_check.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 dts/Makefile | 13 +++++++------
 lib/Kconfig  |  3 ++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/dts/Makefile b/dts/Makefile
index c85a333df9c..58b2617a778 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -30,11 +30,10 @@ else
 local_dtbos :=
 endif
 
-# With OF_UPSTREAM, arch/$(ARCH)/dts is not built, so build the binman
-# devicetree from there explicitly.
-ifeq ($(CONFIG_OF_UPSTREAM),y)
+# Build the binman devicetree explicitly, so that boards do not have to list
+# it in arch/$(ARCH)/dts/Makefile. With OF_UPSTREAM, that directory is not
+# built at all.
 binman_dtb := $(patsubst ./%,%,$(subst ",,$(CONFIG_BINMAN_DTB)))
-endif
 ifneq ($(binman_dtb),)
 binman_dtb_target := binman-dtb
 else
@@ -82,8 +81,10 @@ endif
 
 ifneq ($(binman_dtb),)
 PHONY += binman-dtb
-binman-dtb:
-	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts $(binman_dtb)
+# Run after arch-dtbs, which may build the same file from its dtb-y list.
+# It does not describe hardware, so skip the schema checks.
+binman-dtb: arch-dtbs
+	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts CHECK_DTBS= $(binman_dtb)
 endif
 
 ifeq ($(CONFIG_XPL_BUILD),y)
diff --git a/lib/Kconfig b/lib/Kconfig
index cb81dda032b..437387bcb3d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -55,7 +55,8 @@ config BINMAN_DTB
 	  with limited storage.
 
 	  u-boot-dtb entries in the images get the U-Boot control devicetree,
-	  not this one.
+	  not this one. The devicetree is built from its source in
+	  arch/<arch>/dts.
 
 config CC_OPTIMIZE_LIBS_FOR_SPEED
 	bool "Optimize libraries for speed"

-- 
2.53.0

