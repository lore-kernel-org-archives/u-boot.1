Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839E6CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F0E380E57;
	Mon, 28 Sep 2026 13:42:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id labcMEY7Qbv6; Mon, 28 Sep 2026 13:42:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7DF3680BB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602937;
	b=VFoLODxRl6PrsMOVUXDhKl5Wu02t82D0lkHgpNFtsJaIq0X5mSb9pbfruO2F+nIKk50a
	 RUUIHhFYVeJW/o5iX9PdV3n2RJOqIGbNmmDHYefIRret1ekMA9LhQAhBwKDa0vIBYgq2p
	 x+YkyQy0reCzwBFy5YIxlgDMfZE37ZS7nXzCh+m9jhIr2DIQjwn8F/kNi8leDZQgv+53t
	 Qoz/dicdj2NYu3hYK+o2LHBY2bt/fbbHTGfAnPHZrk+lqtBHZGNo5W0PDMczjQMuFBC65
	 yczRsgn62X3DqoNPcFVFE4KswSUvkSs/clDFbwB+YsxDGh/+IbQGSKlOta+H3hq1b0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602937;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tasG6+3PwNZn5vvqG5gCOe3v/0mWFyNyBFKZISvApvk=;
	b=ORSISS4nCrq8PJeNEWnVR3dgeQVDp/MA3JKBxN1tj2P5DUIwshlW7ojvtcKQPaZT/ulE
	 OxFoD5ecunxflxNYZod1HR1M1Y9F1gsqb2sDefuMq2jzBUb1Kjy/FZmWzucdbdL/i/F+A
	 9I6I5FBRY+QhJkoygdASFvpW3+pLcX9MjxF/k369iSZBDayjhFw415DKX54gtMt9k/5Dn
	 g8Vxx8ZX4/Q4A7S+TSKDGQ1xtx7zKnY0hiESGPkaPdlLYexqHum6IY6scQ2WpF2dzfDlt
	 m9AFK61KelJ+uGXvov6bK70QgYefUXWkUv3L4a61tc9kLHUGjPzdAUgy6IZQvyTpXOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602936;
	bh=tasG6+3PwNZn5vvqG5gCOe3v/0mWFyNyBFKZISvApvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZLvyRPfQQsYe+5Ffq+3FgisT6/ysboDam/3Y+WeryDSi4SL88462W/i/PYzF6kDdx
	 dWQAD39hfVIMJzREnb5MYI6FXtN+3awpAlFotSaDo9LxgGfwn+rcj1CJ0f0NkJmQdc
	 D7+5lUKDpsiIxVpz+5YNE4biO7QMdVV//pcjGZ6vILpRLwWe4WG2sleqSru+A2S861
	 2kgZAw1aVFY37vSRNafKI5mhI0LxnpUI7AJU6LXjuCFOxOSOurMB/86X632evNNW9M
	 3AK7SIiIoRWmQtPqszZtJW11K0l7iQJQgKPQDyvz3+hDgFyGgrrrjtnMTUKyX1x4cB
	 4am1muzU9Hrvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DF3680BB2;
	Mon, 28 Sep 2026 13:42:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 99B7524E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 800244019A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ca4HghzkupFB for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:04:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 83AF340063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593495;
 b=i5X9xSGe3Zad6YZfLVS986VdIDZkZWIR8hV3DsfdM8o6iw7v1WG1MmePwJK8hswmLpKf
 66CpFGt3LhOqRpnC7A4JvSWUx71Q6kS6Ojsyz2XZALWoXyb8MG66QwP0CqvCeY763R7lj
 /8qPEKhJDcPaZMa1o8NUOiCTBKhs/lynBk9BW3BMfpIRogRXumn5wdyH5nLmQ2ZLg5jPs
 zvDGsTXeKsFdMg2v2A6u7LE3wMnO0GNoQprzCJ0tMvdpr7qIDYaY44jl1LHpf9Kb5UWeh
 XbhCBbTjEBzDzDEmfIgqwYBWlyE3TyjegGiN2ssak8mhQbRGRbuxIYmXne5fzYWeCNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593495;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=tasG6+3PwNZn5vvqG5gCOe3v/0mWFyNyBFKZISvApvk=;
 b=rCxdbeuCexR/WX8u0BCL2DsZgEw/9xSnA7670HN/Ph4y8Yu7WwDgQXBTg4Erf22YDooB
 2+BE78Gv5yukvmt/atrkbNmJua8tvQAckV60QHSFjVocVvvX8ZHK1uITB/xeq6F/6GBP7
 vJBLtOXj4bgW20hgfjiQqd1woHU4pc9xRDXp4d4WV8Ymwe7dy9uhfvaM3gQs9CIoYN0k5
 yhZFBmcqAK5XWB+yv8tHRv78HWuS3nqEsWvN89gne6K96ofrXXHY2AykZPfz3NlPYBX4u
 oOu856KADYOmUjGlhoLKabePpyIbQsWP2hhEQbKofImXiDiUypzR6XOg/65dc+nFQwQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=AghqCO23; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=AghqCO23
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83AF340063
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:04:55 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so14716625e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593493; x=1791198293;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tasG6+3PwNZn5vvqG5gCOe3v/0mWFyNyBFKZISvApvk=;
 b=AghqCO23eeguTKKyguUFscjNdKrUWAzvl+WZJq7DvOfMHH6GhQhQIHjiAaJK+N3zgO
 LpCzeJdj9CKY3wZK1s7NuDblgK+Q22fpC+HzxZVXwicraRqlPlGpn+zZ8RkFdMLfItnC
 Kgx2kmWvr1QhrMYdJGG+G41zXraK1INUCMpAG9ijt4mEg0eRDT2NZnUBpjmvWS9oEMDA
 yIc/vBlX6XJkKgXJZTGunrjbPjTLe8X5iwfrI/9BLg2u4LGfOm+Ltsi0TJ5OgWCL9XCE
 I8afHlYrNJKZsbKF1gl48uIOeoQsSZ65yAw0pdUihZtzl9Zg7xzyNCX9BGrarki/YQlv
 8NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593493; x=1791198293;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tasG6+3PwNZn5vvqG5gCOe3v/0mWFyNyBFKZISvApvk=;
 b=Y36XPX4UBRdxGhUYeTg/tNmEWKh41fIAXa/KKPCKaIWq3sv0LicJ/+Qsz7NtJtP1j0
 1+ryvbCiQR7hV+8Adb0N5dR2sgynoR/KZgCnw/2CD57VZRkML27+z9wyRovcJP1XTjXU
 iTeW4l+olcKKV/cUsK3Bpk0ECFSi6PhkexnA5EYiQxlJ6E35wPhOfrml9BHKWF/pmreu
 ZpCEDVPrqQYaNbI27LaEq4cizbLYqfu3J/0/ZWGREFR+PEJqYnHRFXQWI8B9qwplnIxA
 m4BMumcY4Wfn1RnPHHK21aDkPG8CNculvbQGed3YmdeIiFJufaktJ/THmFYv0QruWZIF
 d2BQ==
X-Gm-Message-State: AFuF++lqsw75r00hx4xktrBvJz97hYOXx7FRBMWbeBLnA7trzWDnp7F7
 pWfb0pJ/NgCJRaUHFoJkG5oau7OdD6pTeV0U0dG0TiT+tt3irpdVVc12f1Tu5VMXlEE=
X-Gm-Gg: AYBFou0961fb9v+xeXtH3LBBf9/0aqUV04mW5d234doeN5Y52wgdm6+S6kRho5MM8In
 SJDxtZScjG1Hfhd6+H3ehGnCApfwSZAVs6MEUw522TkTpxY2RxiZW2/A62jw9z15da00IP1ZcD0
 GSBa4grexQBEmSJaSNCiZ6xl8/VDiWN0HW73xQe5dpoXh6d0VK1ET3bi//NgZ3glY46VQl9B/hT
 Z48gr2hDfH0w894/qs7Xfgdd2vpA1HyDbWANC2/jFXYYtRSqYTgDlhhfGnA5NvTgvSBwVcGCJGf
 26nGfpVD6HpSTgFHh2Y6iNTFicfp9I4ojrDOGBAo7l+UrQ7xCX7K/PedOyt4Qzy/G9WmyMurVPZ
 wUaHUVZinSGMlY9iM90jsdhueivpoumMxjMLtmrlVg7jid/E4jNmQU0uW9tSFHlnEpNR90YYgmG
 m/g0RkGvqIr6zsS2gjysTgYtuoBp1HVMVe09jB6pZ7gHoD4En35X2TFPrH8XdMx2DRQq5SixCEl
 7Pdf3F1afbMcqnowvpwHbUKhnu+5z/qdooTUYL/MXv+XXf0qRjGSBwxeuENft4GNvB6bH4Jkc7z
 W3u1ClYXfYcaesntmUSbySiz3hC6TdcOZfX4AMB1
X-Received: by 2002:a05:600c:8a1b:10b0:49f:fc13:18a5 with SMTP id
 5b1f17b1804b1-49ffc131b24mr67461555e9.6.1790593492549; 
 Mon, 28 Sep 2026 04:04:52 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.04.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:04:50 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH next 02/13] Makefile: Link a toolchain libgcc outside
 --whole-archive with LTO
Date: Mon, 28 Sep 2026 13:04:23 +0200
Message-ID: <20260928110434.70686-3-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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

Commit c1094987d1dc ("build: support building with Link Time
Optimizations") put $(PLATFORM_LIBS) inside the --whole-archive group
of the LTO link rules. That works for the in-tree libgcc that
CONFIG_USE_PRIVATE_LIBGCC builds.

A toolchain libgcc, though, then gets every member force-linked,
split-stack helpers included. With Debian's powerpc-linux-gnu GCC
14.2, turris_1x_nor with CONFIG_LTO=y, which mpc85xx allows later in
this series, fails to link with undefined references such as
__morestack_fail and __tls_get_addr.

Keep the in-tree libgcc inside --whole-archive, but link a toolchain
libgcc after --no-whole-archive, as the non-LTO link rules do. ARM64
has no private libgcc, so its LTO boards now link libgcc this way too.

Fixes: c1094987d1dc ("build: support building with Link Time Optimizations")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Marek Behún <kabel@kernel.org>
---
--gc-sections, which commit 34ccadcd3334 ("ARM: don't use --gc-sections
with LTO when using private libgcc") keeps on ARM for LTO with a
toolchain libgcc, is set on powerpc and does not help here.
---
 Makefile             | 10 +++++++++-
 scripts/Makefile.xpl |  8 +++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e8615c247bd..ca18c3b32c9 100644
--- a/Makefile
+++ b/Makefile
@@ -1158,6 +1158,13 @@ KBUILD_CFLAGS += --coverage
 PLATFORM_LIBGCC += -lgcov
 endif
 
+# The LTO link force-links the in-tree libgcc with --whole-archive. A
+# toolchain libgcc goes after --no-whole-archive: force-linking all of
+# its members pulls in split-stack and other hosted helpers that do not
+# resolve.
+LTO_LIBS_WHOLE := $(if $(CONFIG_USE_PRIVATE_LIBGCC),$(PLATFORM_LIBS))
+LTO_LIBS_AFTER := $(if $(CONFIG_USE_PRIVATE_LIBGCC),,$(PLATFORM_LIBS))
+
 export PLATFORM_LIBS
 export PLATFORM_LIBGCC
 
@@ -2103,8 +2110,9 @@ quiet_cmd_u-boot__ ?= LTO     $@
 		-Wl,--whole-archive						\
 			$(u-boot-main)						\
 			$(u-boot-keep-syms-lto)					\
-			$(PLATFORM_LIBS)					\
+			$(LTO_LIBS_WHOLE)					\
 		-Wl,--no-whole-archive						\
+		$(LTO_LIBS_AFTER)						\
 		-Wl,-Map,u-boot.map;						\
 		$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 else
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 53522ced84b..221ef7f29b3 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -144,6 +144,11 @@ libs-y := $(patsubst %/, %/built-in.a, $(libs-y))
 ifeq ($(CONFIG_USE_PRIVATE_LIBGCC),y)
 PLATFORM_LIBGCC = arch/$(ARCH)/lib/lib.a
 PLATFORM_LIBS := $(filter-out %/lib.a, $(filter-out -lgcc, $(PLATFORM_LIBS))) $(PLATFORM_LIBGCC)
+LTO_LIBS_WHOLE := $(PLATFORM_LIBS)
+LTO_LIBS_AFTER :=
+else
+LTO_LIBS_WHOLE :=
+LTO_LIBS_AFTER := $(PLATFORM_LIBS)
 endif
 
 u-boot-spl-init := $(head-y)
@@ -520,8 +525,9 @@ quiet_cmd_u-boot-spl ?= LTO     $@
 			$(patsubst $(obj)/%,%,$(u-boot-spl-main))		\
 			$(patsubst $(obj)/%,%,$(u-boot-spl-platdata))		\
 			$(patsubst $(obj)/%,%,$(u-boot-spl-keep-syms-lto))	\
-			$(PLATFORM_LIBS)					\
+			$(LTO_LIBS_WHOLE)					\
 		-Wl,--no-whole-archive						\
+		$(LTO_LIBS_AFTER)						\
 		-Wl,-Map,$(SPL_BIN).map -o $(SPL_BIN)				\
 	)
 else
-- 
2.54.0 (Apple Git-157)

