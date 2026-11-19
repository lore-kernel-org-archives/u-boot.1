Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11B606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oNeYx6Wk;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HfwFiRmn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8163F40AEF;
	Thu, 19 Nov 2026 13:33:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pBVz-F9-GTqA; Thu, 19 Nov 2026 13:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E6B640AE2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095203;
	b=ochP7AzKoDzl9SFdxFJ3eBxBbcT9hY1fSW0fSLX/lIawL4zvXgYMHz7pW8CHs0TlLkzv
	 dNCFpsNNwWU3nf9IN9Fp1++DuCRDHso4+eTVSagjuJ5PxEqM5gBpukF3ZCP/lDeXPJHGJ
	 8dcoKRtsIRhny30P3qNXf6rNaY05ll4rzOIR9GFBpKbTJw/t1Qrf2x0JY5VEhE0j/GpJs
	 a24mY4taY+8bpKHfVx+gfeXk692sOVKtC4Qz+oAdLzNEGWxTVfeXM6r81QKzFsNuOPR9d
	 w/JBfFjQfvTvsSEwgHNL8D+xDXZz8+hcPcY17PoP7x+o2uQGIluqBC4recEHDBfdBCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095203;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BIl5DJfbGGNviBRR93ndctWdXAsmkdifu9iRcs7S0JA=;
	b=V+dNnuAJLv5Et39G2zbwoBWiduOyrwhruseGSiEmFKRCP+txPdQZEwaqbVQgozHRpxtv
	 XPNivYLyBMy8F6GxDMjqKJmMBdluMyJ9kTZlxUSmr32XZUFby7NnmHB7HrtS/4MuaVS51
	 XICsaNLPlE4aNQQbdBzK//DXavtyDDWvYheAYKaUcwiuMSVj2oQAPa7keD5c36yaKy7we
	 DOqC0xMieFzaafV5EswixdwL7kfwqD42C55xsbgY2ZchYo9U//8gSOcr/EVHFY0JzkK+D
	 /hpQDARCRzYnLsS2lL47+Cippyy/ogPDx1gtldxSOwv8Z7qWhv5AyfFFJDA6hHFETYg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HfwFiRmn;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095203;
	bh=BIl5DJfbGGNviBRR93ndctWdXAsmkdifu9iRcs7S0JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oNeYx6WkF9Wv/L6F+g2MO+otgmT2OTfi9ffKUEzH9jZi9iuqvQwxLbcOrgg9cKwbz
	 TjjpKjN2+U3DJKBTWfUGbSVDw+TfUQnJnsxN4zjSEdOHPgw1NF1b+S+46JkgJ7CD7F
	 A2HU5tiQ2j5Sy4XQFHGfxT8lyH7b8dOghze898o8w5m8YB5acxqcdOsu4P0ICwL1Fw
	 xy8DoQ2F0xF1A0Zpqn7eFmj3RdTlSFVh+NhmWOTHovCy3j70tqdQGsnoKT83louuj6
	 AND3kuRD5r5HgYK/d9aB67dXvj8MLm8ZnIyxXBVx5p1Xb+xdU/PxXieK56R62gaxl/
	 RvSPQ+vkXnguA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E6B640AE2;
	Thu, 19 Nov 2026 13:33:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A358A32
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F02DD40AC6
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4YVHtpxFxu5m for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E0CD40AC7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=HfwFiRmn
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E0CD40AC7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:17 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4a34ffd3e39so1253151f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095196; x=1795699996;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BIl5DJfbGGNviBRR93ndctWdXAsmkdifu9iRcs7S0JA=;
 b=HfwFiRmnETLU1RoJwLTsUKDGGUTG1eJDWaoTnbLWdaeax00LxfxT2EevdOxSr5WQoF
 OrGkviiwQBA+fV5TZ9ZUctbDgDACzqRkUepRvf8Fr//mVFrW40UDuuf1PNdqk1OFU+3V
 1L/nxjR0oDkMHGq7Tetiktd2ZoqURTadsshk7mriajPWyLngqjsRZtRbDbP5NIu+xfEo
 UxMdjxcpWczOlW6ZrqWYO7YChTwF95q/ia7119wUokvb1LydN68gGYp6vZEFjQ2S5E3n
 Gmy9YFA0fy9wiJ2Hi8Ihm3x8/fQADBPu5a2CcHv5y/AA65CnHRThdzoTYWjGubpGLoQ9
 qXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095196; x=1795699996;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BIl5DJfbGGNviBRR93ndctWdXAsmkdifu9iRcs7S0JA=;
 b=YgMktF5HWB+WJw6cWqgDksalNF8DKnm9gJDFIZ48IMfWvhI1FK08cWnSuu7FnjaH1p
 /b2tztPefMpxzkTHVhZczDn7lH1qztPvMYhGyLHv5yHhF6QrKQwlJ634xdmjjegmE48D
 e/qUNBznp+4BNexRa/AvBMZa7U4mhPnK5qKT9KmY08NGAD7Wzq2QGjq4/xZuJyB1Dirx
 rwhhOqXYtMtY6jux5rgJ0RXIyBK650yZWDErcQNZ2hj6CtyJFT/c2CNQmEBU4PUIEBXV
 +WW0XTw34a2GdVx4LEdag3jBVryfzhP+1i7b1vlFp0xyTu5SxV7wP9gx8CahEk1Yapxt
 Ljew==
X-Gm-Message-State: APuU4Z8HQIQFMVhDM9EvDny3OGaEgoXiVfGMgnVe+QkA5+QrI+GLzANc
 d0eCEg3wX9VatEen1avS1kydpy702m1+OVRR9crqawpQXb9avG1lO9SXk2HlXdJj
X-Gm-Gg: AZFdTZdfVJNK1uC8rRWzH3Z69868EmVKL269YVwLGpb/9Y6TNMVAFXzhHvTfTAfYL2/
 v1sqY4j5VorxsEYZ0f6m7Slz9b0gKia94uOdl5JipvfBAsx3DUemdO7h+Bh/kZ/d1cnCCAioO/S
 My4/8mcn5MWaXubWnc9AmBGuCxCINWpQEFX/39oZknGo4ZwC6/sKd9Ubyx1x952H9PWp+lUA/Jx
 E8YnX5yZP6fzDgBQ612d4orHPvMmjm984Dr/JcvYoiL7/ycZk8n3em3hWzLs1eSoaEfsHbEqhOc
 gdEHMzqUis0zOLgv+QcE+/w8Gs0x07EMIYIueY6Pz5yugVEA99Rr9ifmeerFeNy0acLl7uy51Q5
 Dtbl5ZZHqmUCa6uRNOXC4ZvCFD6Z7fh6D9l0mrkc0/djcyOXMNbAFQALO5Ukw8/ADWy7i+eqsJc
 x2M/XbLZWV7BA/0Z5lOqf7EeMy97cYUntNReepQVaKLxI6UNdPFh946e7G6oHnrIrmUuDVEhK3O
 hZFkgfv4oumrp+0zek1LUFcUHq8wwXlFV5btu/B67/3vXZWly8HeFQ6/LxdJA1S7CgY+68Y4Q2J
 ELTDFHbokNxFyJGR0hRotwbo0Cdx/Pml8wDbDNdjyv2nesUmIzZJybJS6zuMrTrpcXHgDCNBL/u
 PYNyP9rwNB5FJBpt+gtqsbCLN4sLzePoLPcI0pT9b6VxlCADFc2zCNJR8qQHk2H5WsC+2dymoVz
 Fk8mZ+paQw44iYfYBlpVSEBb4prB9manZko3a0NXBUCEQPCOK/c8jQnesiQ5K4uwV6sfAwOMOgs
 w==
X-Received: by 2002:a05:6000:2a87:b0:487:6f2:1a4c with SMTP id
 ffacd0b85a97d-4a639ff652dmr10333033f8f.25.1795095195686; 
 Thu, 19 Nov 2026 05:33:15 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:15 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 02/14] powerpc: Make the global data pointer LTO safe
Date: Thu, 19 Nov 2026 14:32:58 +0100
Message-ID: <20261119133310.22732-3-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The register variable form of gd cannot be used with LTO (GCC bug
68384). The LTO link fails with "multiple definition of `r2'". In LTO
builds define gd through inline assembly accessors that read and write
r2, following ARM and RISC-V. Other builds keep the register variable,
and set_gd() assigns it.

Every assignment to gd has to go through set_gd() for that to work, so
convert all PowerPC ones, including those in common code, and give
PowerPC its own arch_setup_gd() in the new arch/powerpc/lib/gd.c
instead of the weak one, which assigns gd. Rename the gd parameter of
the SPL board_init_r() functions, which the gd macro would otherwise
replace.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
Cc: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Marek Behún <kabel@kernel.org>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
(no changes since v1)

The mpc83xx and common/spl/spl.c hunks change no build: mpc83xx cannot
enable LTO and no PowerPC board builds common/spl/spl.c. They are
converted so that no PowerPC code assigns gd directly.

Unlike on ARM and RISC-V, set_gd() assigns the register variable in
builds without LTO. GCC requires inline assembly that accesses a
global register variable to declare that access through constraints.

In the T-series SPLs, the board_init_r() bodies now use the global gd
instead of the parameter. relocate_code() passes the CONFIG_SPL_GD_ADDR
that board_init_f() has already set as gd and leaves r2 alone, so the
pointer is the same.

checkpatch asks for IS_ENABLED() on the #if lines in common/board_r.c,
common/init/board_init.c and common/spl/spl.c. They choose how gd is
set per architecture: set_gd() exists only on ARM, RISC-V and PowerPC,
so IS_ENABLED() cannot replace them. The new arch/powerpc/lib/gd.c is
covered by the POWERPC entry in MAINTAINERS.
---
 arch/powerpc/cpu/mpc83xx/cpu_init.c       |  3 +--
 arch/powerpc/cpu/mpc83xx/spl_minimal.c    |  3 +--
 arch/powerpc/cpu/mpc85xx/cpu_init_early.c |  3 +--
 arch/powerpc/include/asm/global_data.h    | 30 +++++++++++++++++++++++
 arch/powerpc/lib/Makefile                 |  1 +
 arch/powerpc/lib/gd.c                     | 14 +++++++++++
 board/nxp/p1010rdb/spl_minimal.c          |  2 +-
 board/nxp/p1_p2_rdb_pc/spl_minimal.c      |  2 +-
 board/nxp/t102xrdb/spl.c                  |  4 +--
 board/nxp/t104xrdb/spl.c                  |  4 +--
 board/nxp/t208xqds/spl.c                  |  4 +--
 board/nxp/t208xrdb/spl.c                  |  4 +--
 board/nxp/t4rdb/spl.c                     |  4 +--
 common/board_r.c                          |  2 +-
 common/init/board_init.c                  |  9 ++++---
 common/spl/spl.c                          |  4 ++-
 16 files changed, 69 insertions(+), 24 deletions(-)
 create mode 100644 arch/powerpc/lib/gd.c

diff --git a/arch/powerpc/cpu/mpc83xx/cpu_init.c b/arch/powerpc/cpu/mpc83xx/cpu_init.c
index 340f9a0da56..5618b79a78b 100644
--- a/arch/powerpc/cpu/mpc83xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc83xx/cpu_init.c
@@ -139,8 +139,7 @@ void cpu_init_f (volatile immap_t * im)
 #endif
 		0;
 
-	/* Pointer is writable since we allocated a register for it */
-	gd = (gd_t *)SYS_INIT_SP_ADDR;
+	set_gd((gd_t *)SYS_INIT_SP_ADDR);
 
 	/* global data region was cleared in start.S */
 
diff --git a/arch/powerpc/cpu/mpc83xx/spl_minimal.c b/arch/powerpc/cpu/mpc83xx/spl_minimal.c
index 7036e3fae0c..1d48428573d 100644
--- a/arch/powerpc/cpu/mpc83xx/spl_minimal.c
+++ b/arch/powerpc/cpu/mpc83xx/spl_minimal.c
@@ -25,8 +25,7 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 void cpu_init_f (volatile immap_t * im)
 {
-	/* Pointer is writable since we allocated a register for it */
-	gd = (gd_t *)SYS_INIT_SP_ADDR;
+	set_gd((gd_t *)SYS_INIT_SP_ADDR);
 
 	/* global data region was cleared in start.S */
 
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init_early.c b/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
index 75bfc07fe97..fb3d662c9d3 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
@@ -95,8 +95,7 @@ void cpu_init_early_f(void *fdt)
 	int i;
 #endif
 
-	/* Pointer is writable since we allocated a register for it */
-	gd = (gd_t *)SYS_INIT_SP_ADDR;
+	set_gd((gd_t *)SYS_INIT_SP_ADDR);
 
 	/* gd area was zeroed during startup */
 
diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
index 26cbc7854d9..d8aefd2ca0a 100644
--- a/arch/powerpc/include/asm/global_data.h
+++ b/arch/powerpc/include/asm/global_data.h
@@ -93,8 +93,38 @@ struct arch_global_data {
 
 #include <asm-generic/global_data.h>
 
+#ifdef LTO_ENABLE
+
+#define DECLARE_GLOBAL_DATA_PTR
+#define gd	get_gd()
+
+static inline gd_t *get_gd(void)
+{
+	gd_t *gd_ptr;
+
+	__asm__ volatile("mr %0, 2\n" : "=r" (gd_ptr));
+
+	return gd_ptr;
+}
+
+static inline void set_gd(gd_t *gd_ptr)
+{
+	__asm__ volatile("mr 2, %0\n" : : "r" (gd_ptr));
+}
+
+#else
+
 #define DECLARE_GLOBAL_DATA_PTR     register gd_t *gd asm ("r2")
 
+/*
+ * GCC does not see an asm statement write r2 and assumes that the
+ * register variable is unchanged, so it may move gd accesses across the
+ * write. Assign the variable itself.
+ */
+#define set_gd(gd_ptr)	(gd = (gd_ptr))
+
+#endif
+
 #include <asm/u-boot.h>
 
 #endif /* __ASM_GBL_DATA_H */
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index c0caa703caa..a3048975ae7 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -18,6 +18,7 @@ endif
 endif
 
 obj-y	+= bdinfo.o
+obj-y	+= gd.o
 
 ifdef MINIMAL
 obj-y += cache.o time.o
diff --git a/arch/powerpc/lib/gd.c b/arch/powerpc/lib/gd.c
new file mode 100644
index 00000000000..d36f784fbf7
--- /dev/null
+++ b/arch/powerpc/lib/gd.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Josef Schlehofer <pepe.schlehofer@gmail.com>
+ */
+
+#include <init.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+void arch_setup_gd(gd_t *new_gd)
+{
+	set_gd(new_gd);
+}
diff --git a/board/nxp/p1010rdb/spl_minimal.c b/board/nxp/p1010rdb/spl_minimal.c
index 8cd79c6fb5f..33930fef8d9 100644
--- a/board/nxp/p1010rdb/spl_minimal.c
+++ b/board/nxp/p1010rdb/spl_minimal.c
@@ -45,7 +45,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, 0, CONFIG_SPL_RELOC_TEXT_BASE);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	puts("\nSecond program loader running in sram...");
 	nand_boot();
diff --git a/board/nxp/p1_p2_rdb_pc/spl_minimal.c b/board/nxp/p1_p2_rdb_pc/spl_minimal.c
index 511bcf5506b..960b2c41457 100644
--- a/board/nxp/p1_p2_rdb_pc/spl_minimal.c
+++ b/board/nxp/p1_p2_rdb_pc/spl_minimal.c
@@ -43,7 +43,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, 0, CONFIG_SPL_RELOC_TEXT_BASE);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	puts("\nSecond program loader running in sram...");
 	nand_boot();
diff --git a/board/nxp/t102xrdb/spl.c b/board/nxp/t102xrdb/spl.c
index de6cdda194e..f527f62a5dd 100644
--- a/board/nxp/t102xrdb/spl.c
+++ b/board/nxp/t102xrdb/spl.c
@@ -58,7 +58,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 	console_init_f();
 
@@ -87,7 +87,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/board/nxp/t104xrdb/spl.c b/board/nxp/t104xrdb/spl.c
index e02a1f95d4c..0310baa381c 100644
--- a/board/nxp/t104xrdb/spl.c
+++ b/board/nxp/t104xrdb/spl.c
@@ -55,7 +55,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 #ifdef CONFIG_DEEP_SLEEP
 	/* disable the console if boot from deep sleep */
@@ -78,7 +78,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/board/nxp/t208xqds/spl.c b/board/nxp/t208xqds/spl.c
index 44ad4e68d9f..f8c641a9c64 100644
--- a/board/nxp/t208xqds/spl.c
+++ b/board/nxp/t208xqds/spl.c
@@ -73,7 +73,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 	console_init_f();
 
@@ -96,7 +96,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/board/nxp/t208xrdb/spl.c b/board/nxp/t208xrdb/spl.c
index df3b9c6fe40..4b1ab3618c3 100644
--- a/board/nxp/t208xrdb/spl.c
+++ b/board/nxp/t208xrdb/spl.c
@@ -33,7 +33,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 	console_init_f();
 
@@ -56,7 +56,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/board/nxp/t4rdb/spl.c b/board/nxp/t4rdb/spl.c
index 9d2472dec25..441015bf5a4 100644
--- a/board/nxp/t4rdb/spl.c
+++ b/board/nxp/t4rdb/spl.c
@@ -39,7 +39,7 @@ void board_init_f(ulong bootflag)
 	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
 
 	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
+	set_gd((gd_t *)(CONFIG_SPL_GD_ADDR));
 
 	/* compiler optimization barrier needed for GCC >= 3.4 */
 	__asm__ __volatile__("" : : : "memory");
@@ -59,7 +59,7 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
 	struct bd_info *bd;
 
diff --git a/common/board_r.c b/common/board_r.c
index a397e20959d..7a9de6ba5f3 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -796,7 +796,7 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
 	if (CONFIG_IS_ENABLED(X86_64) && !IS_ENABLED(CONFIG_EFI_APP))
 		arch_setup_gd(new_gd);
 
-#if defined(CONFIG_RISCV)
+#if defined(CONFIG_RISCV) || defined(CONFIG_PPC)
 	set_gd(new_gd);
 #elif !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
 	gd = new_gd;
diff --git a/common/init/board_init.c b/common/init/board_init.c
index 2a6f39f51ad..2faea5432c0 100644
--- a/common/init/board_init.c
+++ b/common/init/board_init.c
@@ -14,15 +14,16 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 /*
- * Unfortunately x86, ARM and RISC-V can't compile this code as gd is defined
- * as macro and cannot be assigned.
+ * x86, RISC-V and PowerPC provide their own arch_setup_gd(), and ARM does
+ * not call it.
  */
-#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
+#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV) && \
+	!defined(CONFIG_PPC)
 __weak void arch_setup_gd(struct global_data *gd_ptr)
 {
 	gd = gd_ptr;
 }
-#endif /* !CONFIG_X86 && !CONFIG_ARM */
+#endif /* !CONFIG_X86 && !CONFIG_ARM && !CONFIG_RISCV && !CONFIG_PPC */
 
 /**
  * This function is called from board_init_f_init_reserve to set up
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6c9a1a1cbcc..81aec2b1108 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -956,7 +956,9 @@ ulong spl_relocate_stack_gd(void)
 #if CONFIG_IS_ENABLED(LOG)
 	log_fixup_for_gd_move(new_gd);
 #endif
-#if !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
+#if defined(CONFIG_PPC)
+	set_gd(new_gd);
+#elif !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
 	gd = new_gd;
 #endif
 	return ptr;
-- 
2.54.0 (Apple Git-157)

