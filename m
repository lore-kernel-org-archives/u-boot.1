Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA89CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 03:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAA1B84944;
	Tue, 26 May 2026 05:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZXeTm5X6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 375E5848E7; Tue, 26 May 2026 04:09:51 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24F8D846D3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 04:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B1BF73F56B
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779761388;
 bh=jInwxJpbl1AFa5SzE+GnUaqcVTkGW/T3Mzi8Cz5WB00=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ZXeTm5X6tZZknUJKgDznQpI5JfYKCbdWCYa4MIYt9YqWHmzSJ9+l6XDs+O5PLFwmn
 9uCu7q5QhmorgdTJdUo0Jzs1opbsoJpoi3ktTi56bxlDpZUPknPMD4slSAJZoo3amZ
 /fe+ng/VhAhAWVQ4vEUWtsnMPItKoHelXgOYW43mgCHatyXlMNrSLfA9GL371fFEHd
 WDCT/JrMfPWm1x+s4cgPvt9sNzi1JZC4aYEgj0MkRDsqCEfc9Rp0vgP2m7HRuqYDWu
 0Xf67+6enpGJI9HeRtiX9gNgZXPYFglct55bEm5EEMdyTldfwXVEF8rCnpsyFTG4iB
 fBWVk+pW+N2elOFCehEOGVSq/hCcKzstoJs2MFg6apD7nD5WdFV8AJfaAyd2/YIE0X
 nqIM8+6ek9Rhb9vmVn7NT+JkLaYg/PEin3JfH6rvyknX86HBZIMWDI+g8O3JbnNIIS
 z6Aj0iepc5Di9Pjpn1CFQ/2UMkIGNhtvMtpjAm/MaBackGHmh/aNPr65qVW8XZWuyi
 u4C4nUFVPS+exhkudy9+ngS9cQmZmAkaQmBGONkaAg3NzLIthYwQeG2PGHERpTX5gQ
 22ztlvLEKNE8IkSzdEQqVP2pwGW3kJGIfZvj8DiSZG7y6t/oWOsxu7QX2f4zE7DbEe
 Jh+VAaIAeAuXYV/tUoHtWXd0=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ba054e0304so88521455ad.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 19:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779761387; x=1780366187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jInwxJpbl1AFa5SzE+GnUaqcVTkGW/T3Mzi8Cz5WB00=;
 b=FcoN3DC5fSOpcLYObMHRb8IU/P4xyoU8d1CFtU2PE72QqJXyBu3gFgDTImOB7SgAtb
 mTpd3oqPqNA01JSUZ3dymb4b3C6JyRbXeMH/xGFS9gPnWWzJCQOwv4v711R+DDXWyL8B
 W09FxDn+EeOtrMuYhwilvd1rGvaNOwd/S/r3TXSaWEi3ukmIG6yWUirQ+ItKHbQdG6HI
 MGZhNooPUB5zl2mP8ynvP9wiVweVNhW84injYHnLYiVaM64e4Mx7k1SKL/CupREOcevJ
 t8ax8eXRpB2q1Gt8lP1VPW+0bFowyAWAZHYSdvlzo3lufh1+D1DprvCEdjCit9wh9Uga
 MEQA==
X-Gm-Message-State: AOJu0YzAIZIG/cXoV/ruMlw0Jrhtlb8/isxlfkw8c4a9IcOqsM0qRpQP
 R0biSIyiO71ubIjoH1LW7P7nZsXnsAhY2JuHU4KElv5Pw4sFk2Tb3J9hDMfsO5JFJLf++SvQ7/R
 62aJARpwhQxo0eWwFYW7Z3UiG+Jem3TMYMYobq/9QsTxajxmdxq+ruW8hxhL6tmF46RazDGlEly
 tIrH7BtWuE
X-Gm-Gg: Acq92OGJd+R4Lt6SilVIXpzW/SnKXsDc0XUbwt84vxcf7rmTLuU/ywqH82bsQu670RT
 Qxdp/12eELQedzMN1drm/pjOSkMAlczMYbPrCVYWtNKyEvLkkVO9MFzXviL1YMPFKM9/7CDJFqQ
 PwgBFAH/hui4UlXadDir0bxIc6y/enJ2IqdaxtHkHWyrmbokSUv+SKFv6p59d8K2kYspkLwwQs4
 2hCJaxBZcQN4YVZtvf8AteYMuNuziXCkfsb74HlIUYvB50csosmUZjKaiC8nEs2rdMRZd8v1pTR
 howevR7nTB5nnWuqlK17RVa12farwN1wnHNu/VzyB/5Dmo3tgrIDImHk+LphV5pJ4G6wtScaKEu
 DubmgZPH4PTl7IfJlm30JUujr2VKNvzdHeUAjwLwthmAsbuulsMaRjNNwaXjbkuE53ZM3YGESTK
 xMiGl7BydffYyy9fA=
X-Received: by 2002:a17:903:2cc:b0:2bd:eed4:f42d with SMTP id
 d9443c01a7336-2beb0794de9mr142609175ad.1.1779761387235; 
 Mon, 25 May 2026 19:09:47 -0700 (PDT)
X-Received: by 2002:a17:903:2cc:b0:2bd:eed4:f42d with SMTP id
 d9443c01a7336-2beb0794de9mr142608935ad.1.1779761386797; 
 Mon, 25 May 2026 19:09:46 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695b2esm101522015ad.4.2026.05.25.19.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 19:09:46 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/2] fdt_support: validate property lengths in chosen and
 dma-range fixups
Date: Tue, 26 May 2026 02:09:13 +0000
Message-ID: <20260526020917.8438-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 05:44:15 +0200
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

boot/fdt_support.c contains a number of helpers that fix up the kernel
devicetree handed to the OS during bootm/booti. Several of those
helpers consume fdt_getprop() results without validating the returned
length against the per-entry size implied by the surrounding cell-count
arithmetic. When the OS devicetree is not signature-verified, for
example an unsigned FIT, a DT loaded from $fdtaddr or $fdtcontroladdr,
or a DT supplied over a network boot, the property is
attacker-influenced and the missing checks turn into out-of-bounds
reads or writes on the FDT blob and on stack buffers.

The first patch targets fdt_fixup_stdout(). The function copies the
value of /aliases/serialN into a fixed 256-byte stack buffer before
publishing it as /chosen/linux,stdout-path, but does not check that
the property fits. The patch rejects an oversized property with a
debug-only message and -FDT_ERR_NOSPACE so the unbounded memcpy
cannot run.

The second patch addresses fdt_get_dma_range(). The function reads
one full dma-ranges entry of (na + pna + ns) * sizeof(u32) bytes
after checking only that the returned length is non-zero. A
dma-ranges property shorter than one entry causes the subsequent
fdt_read_number() and fdt_translate_dma_address() calls to read past
the property within the FDT blob. The patch validates the length
against one full entry and returns -EINVAL when the property is too
short, matching the existing failure paths in this function.

Both rejection paths use debug() rather than printf() so production
builds do not pay any .text or .rodata growth for the new diagnostic
text. Measured against master on real cross-compiled targets, the v1
printf form added 88 bytes of .text on CMPCPRO_defconfig (which links
the fdt_fixup_stdout check) and 119 bytes on rpi_arm64_defconfig
(which links fdt_get_dma_range). The v2 debug form adds 0 bytes on
CMPCPRO and 20 bytes on rpi_arm64; the 20-byte residual is the
length-check branch itself, not the diagnostic.

Build tested with kontron_sl28_defconfig (aarch64),
CMPCPRO_defconfig (powerpc, which enables both
CONFIG_OF_STDOUT_VIA_ALIAS and CONFIG_CONS_INDEX and therefore links
the new bounds check in fdt_fixup_stdout), rpi_arm64_defconfig
(aarch64, links fdt_get_dma_range) and sandbox_defconfig. All builds
are clean and scripts/checkpatch.pl reports no errors, warnings, or
checks on either patch.

Changes in v2:

The two rejection paths are now debug() instead of printf() so the
diagnostic text disappears from production builds. v1 added 88-119
bytes per warning per board that linked it; v2 adds 0 bytes for the
diagnostic and only the length-check branch remains.

The __FUNCTION__ to __func__ cleanup that was patch 3 in v1 has been
moved out into a separate treewide series.

Aristo Chen (2):
  fdt_support: bound serialN alias length before copying to stack
  fdt_support: validate dma-ranges length in fdt_get_dma_range

 boot/fdt_support.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.43.0

