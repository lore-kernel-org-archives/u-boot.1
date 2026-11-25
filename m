Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378A5606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o1RmAc7i;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v+jS6key
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19E5340609;
	Wed, 25 Nov 2026 07:41:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Ppo-8U9SvUu; Wed, 25 Nov 2026 07:41:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3F2DC40620
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795592494;
	b=tSvfL41KKRUqSo7Ob7rNQEr0TbRi+nSbZxeVCo+JoQ7z3B6ijoIWCMAAB90nIRsKOyYL
	 TFkgfnPdBK8eyXT9gZIvqdO2xvfi7kQnD3i0ElewT6b0qibeM/F0+UmjLIcKfCNqmgt5d
	 bq4UMHi4F3+gSz5z1KZRrKt5qleW5He+tqBQcEdeKkbyLHfx37D46H01/CyS2huuS6D10
	 45X7WtQjPq53dkpFlFZYUNTf5Tir2xrTEAajgVazqUHUSyrPgXz0wJHJRO/rGWEYoqOwW
	 ovOxAgE3/gqKMd2Jt3+XQOlVD0cg+jhieMIExiAkB6Oj0rVvnq5rEFuGq9Kba3oFtwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795592494;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=32g9qL1KXtsW+VDiuLZc08Mfxy3+2OfMjuiDJUTW3tk=;
	b=p7nMwR8l92V2cat9BNmqszqXShZwM/dhS4ELr/aXpszLPZVMgE1sxL9W5Xg7vN/eit85
	 LEURAkwY221GNd9s7JajGCFyMA7DGstmUV0DQnJDTC+ev1zhbmfPCNfrXdtEseFe5i9TN
	 C+vkA3Dfwu4O46nPXV2iKG+Q22tCs6RpQbkIPyQ7dAB3VJoLJy9plNhGx3oPhipUL349F
	 3/vduHkdE+bNT5GmteFqV4hOAMGkGV9xh4L8phqAQyzVSH0xphU5JP850J8aruDGLgAfP
	 OYQGT+PYjXavV4TW4XNoFWQLu5kpkH/Cnzmy53xDgL+szsskGmk+RAqJsIWr3awc0wg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795592494;
	bh=32g9qL1KXtsW+VDiuLZc08Mfxy3+2OfMjuiDJUTW3tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o1RmAc7iM+GBy2ZJh33DD7/poUEzutXX/FLWwnoZcw1sajKrr+AQB2/k4O0ziG3Uc
	 9L1Jaf8D9LugJJEIsi7+qt/3SGh+yYkoNBoukJA5n07/VCjRo2wmn1Vsr1v5g2aH6r
	 PTBN3/uo3K4CW9V+8DoIQ0/77tjJcGO7vpK4eKr/IIyTChTD5YpF8woRtoWIGaLuD6
	 y09s9iW7V4tr0eqMZo/fC3kLbAd1htf7JwawkWbly1+AGCVw/+HmMXqI1ScMJ5LtAL
	 pqpXJf8qUZUcnErHz8zXm/UUQro1/xXXJPcvMpDqWCJunExmV27DcROEwwo0m36S/J
	 bR4OL8KcOCk6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F2DC40620;
	Wed, 25 Nov 2026 07:41:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EF4C1C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74C90606A3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:41:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vC-PsId878Er for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 07:41:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 195EF605F0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=v+jS6key
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 195EF605F0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:41:30 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so43178215e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 23:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795592489; x=1796197289;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=32g9qL1KXtsW+VDiuLZc08Mfxy3+2OfMjuiDJUTW3tk=;
 b=v+jS6keyqntHIiXriMkhq11/qKggDYAbWJzTF7yAXeZC1TX2qkSqr7QRBoKb8EISKq
 mn6ukf8BAygsJgPjV62u5ShgrA35rPZioenOGPH+Ml+Z4Bj5ehw5TWlA2pk7CAyw5XUf
 dbKoxao9OI49+3qnsAT7MzIjz1hMsaoEcTIym8Sv560zneRdXf6UGceh5UXuvqA+QroM
 MbjEx751hSEOrv2rfdrYi8W0TAlpW4KBiD+5+j01jwAWu1CYSN3kQonlI9yk63PDeicC
 SSJvQ8wCifAy2Z5EXtNLbSq9EDVzhoZt1ur/xu2SX9hSQHNjPst1UWABFWAnHQRtEEus
 3P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795592489; x=1796197289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=32g9qL1KXtsW+VDiuLZc08Mfxy3+2OfMjuiDJUTW3tk=;
 b=Q2OI27iJfeRr08UL/hIUilxiYBZ3R1tXfxZ+pqxrzBt6Ea6S0hJwCRj6JRPURkv3cP
 MvbnepmzPsucyio+KuKnw/X4tncFCuts21FV+O/f7tx1c6ITRnKNMVRhe/7dU4WmIdyI
 TKNlUXIT5BmLRB/OF7YlAcQaQTdNX26XK4HVzORBflPfcaWkQbParrKso5JiQtUaCQes
 xasFYA5+bTaAH30nXa0SMabUvHsVrG7Phlo9I0YGSJh6G+F0oKqTJt2nWCMtznQ0y8TK
 7pLeGYSGoqtbvOukKNd7HoUjzxyqY7fIHHvF6q7dHT32xyCGR4NL1z1rfk7qoCy1SFdp
 Ivcw==
X-Forwarded-Encrypted: i=1;
 AL+hErGnz7tuVrW9S5PHRdYW4KuOIKht2t1XWy2qh8k0QMrKzUeSNb9fcyVKz6kxUl6gVDTRmUm1mVI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+zW/2IW3jrho653najc4pwIje3M+NiavTIgQG8OmJEImahXWhu
 AHjQ1yVmynr02CygDE6dN1otBxx95PEbJo+RzgD2lROFndKsJYrzn4EBNAxmdX61frs=
X-Gm-Gg: AZFdTZct+Kk+D5Psvxiqb8EHP5YPSEQ4OKX5OUCPqdPLEwi+1pHiLZi/Pw05XdiNtXO
 Fw38dIYY+H06VDhBjFfiNRO4QKbtrgNJonADtVw34wggk5VfPyAMrx77wj/K5sLthfpMWLjozpb
 /X8Mg9UGWLAVeyiOeJzWHXJytwkUFjw6iQvPupMMhoLE+h6I4Bqx/UjY2d1ONpJIJKYPaKgQryA
 FU4vlzBSeV8c/Rdi8m6VhpGMdVoVZFZHQfq6XpAb2AahW24LZTlPiko69hwlA7a7gULBNZSmw9b
 hXTxEcSAq9k3Se2KVpsrNQES3Y4Wh5x7rDa4LObP6cq+2QAnGD690Ey/8vOszfsrNoDnzfEHd0S
 chdNUrRqr222NNyDeYvshiV/jEdxhCJq3CZVw9j0CQbBkJpd2xOacKbrB7+IyoVa1L8SCAoz4Nn
 0woKRDoXDwAbGdmuPC89e9Xms9ylPe30eqs9zRs044cqxWCs+/SMLYBtBpx265i2VPkSuerHVce
 UjOuKXE3/5VGXx6noHl6sxtqcB9paW36uK/8TLlAs0EliJ2HF4UjkF0na9I13sPE2qtVpHksko3
 9au9J6lKrnpLNWaxlhEApi/0fcvxFuGg0Rga84z5UWsSpqrbqHV3qB935bwBK/3K8xvcN5SgqRZ
 cCVzWmErPjJg33J9BWUvVne7MWb+XN6z9u3X8DPvGffo/laTOjUuST1/GwNKhq7humjgq+ovHKO
 NffCfb7WdRfZgRYXH17l7UC6nMsR+tGNKaVpcVnt3fgRnty9QSY5FZNXmlYm9KZEoD9TS2Q4LkA
 vh/yUeVHP3dXbi/KcfVb2L4OfOndLyYNTj1fQ4jSdJFs++SbPjKb5q/lQRW5HzWU9qKPGrYRvKl
 potzJXapMc8vLkgVhqGgQTY/WyUQcuZDTBFdcbc84CeN54jpqxwkyYSv2MSvtwoKN4cTfn4m5+C
 GnEHYm7YOLW61ajtJI4mHaUZ6KI/vXh96K1BI0pH1cjEHTQY44z9SVW+VHFylXxqP9g==
X-Received: by 2002:a05:600c:a088:b0:4a2:1a:a120 with SMTP id
 5b1f17b1804b1-4bb8880ac02mr325303605e9.6.1795592488721; 
 Tue, 24 Nov 2026 23:41:28 -0800 (PST)
Received: from hades ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa397asm33296675f8f.48.2026.11.24.23.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 23:41:28 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com,
	richard.henderson@linaro.org
Cc: casey.connolly@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 2/2] arm64: Add RELR relocs
Date: Wed, 25 Nov 2026 09:41:20 +0200
Message-ID: <20261125074122.1965495-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linking U-Boot with -pie emits an R_AARCH64_RELATIVE entry for every
pointer that needs fixing up. Each Elf64_Rela entry is 24 bytes, so the
.rela.dyn section ends up being quite large.

Modern toolchains support packing relative relocations in RELR format
via '-z pack-relative-relocs'. Instead of offset/info/addend tuples,
RELR stores a stream of 64-bit words. An even word is the link-time
address of a word to relocate and an odd word is a bitmap describing
which of the 63 words following the previous address need relocating.
The addend is the value already stored in the place.

Compiling for QEMU with RELA vs RELR looks something like this:

$~ readelf -SW u-boot  | grep relr
[ 9] .relr.dyn         RELR            000000000016f970 170970 000960 08   A  0   0  8
$~ readelf -SW u-boot.old  | grep rela
[ 7] .rela.dyn         RELA            0000000000115110 116110 0184f8 18   A  0   0  8

which is ~98% decrease in the space reloc entries need.

So let's add a Kconfig option and teach U-Boot RELR.
- pass '-z pack-relative-relocs' to the linker and add .relr.dyn
  in the linker script and the objcopy'ed binary. relr.dyn is still
  overlayed by .bss
- skip checkarmreloc, since we now expect R_AARCH64_RELATIVE entries
  to be packed in .rel*.dyn and older tools don't decode them
  properly
- process .relr.dyn in pie_fixup. It's worth noting that efi runtime
  relocs, due to how ld emits RELR, are now packed in .relr.dyn and
  efi_runtime_relocate() doesn't have to relocate anything.
  A sideeffect is that we can't support  SetVirtualAddressMap and ConvertPointer
  for EFI, but some architectures are already ommitting this call
  (e.g Linux on arm64, openBSD doesn't call it at all). [0]
- process .relr.dyn in relocate_code(). Note that the places are
  link-time addresses, so we still need the link-to-copy offset to find
  them, but the stored value has already been shifted to the run address
  by pie_fixup, so it needs to be adjusted by the run-to-copy offset

[0] EFI runtime services relocate themselves when the OS calls
SetVirtualAddressMap, using the relocations between
__efi_runtime_rel_start and __efi_runtime_rel_stop. Those are collected
by the linker script from the .rela sections of the runtime code.
RELR packing, however, is done by the linker as a last step and all
relative relocations end up in a single .relr.dyn section for the entire
image. There's no way to emit an equivalent __efi_runtime_relr_start
marker for the runtime region, or emit RELA relocations for the EFI
runtime, so stop advertising SetVirtualAddressMap and ConvertPointer
in the EFI_RT_PROPERTIES_TABLE when RELR is enabled.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Kconfig                        | 14 +++++++++++++
 arch/arm/config.mk             | 10 +++++++--
 arch/arm/cpu/armv8/start.S     | 38 ++++++++++++++++++++++++++++++++++
 arch/arm/cpu/armv8/u-boot.lds  |  9 ++++++++
 arch/arm/lib/relocate_64.c     | 28 +++++++++++++++++++++++++
 include/asm-generic/sections.h |  3 +++
 lib/efi_loader/efi_runtime.c   |  9 +++++---
 7 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/Kconfig b/Kconfig
index c8cfbf5d5de2..ebe7b30d7b78 100644
--- a/Kconfig
+++ b/Kconfig
@@ -40,6 +40,20 @@ config COMPILE_TEST
 	  here. If you are a user/distributor, say N here to exclude useless
 	  drivers to be distributed.
 
+config RELR
+	bool "Use RELR packed relative relocations"
+	depends on ARM64
+	help
+	  RELR stores relative relocations as a stream of 64-bit words: an
+	  even word is the link-time address of a word to relocate, and an
+	  odd word is a bitmap covering the 63 words that follow the previous
+	  address. This usually leads to ~95% compression of emitted relocation
+	  entries.
+	  Due to the placement of the .relr.dyn section and the way ld
+	  creates it we cannot currently relocate EFI functions at runtime.
+	  SetVirtualAddressMap and ConvertPointer for EFI are marked as
+	  unsupported.
+
 config WERROR
 	bool "Compile U-Boot with warnings as errors"
 	default COMPILE_TEST
diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index bce9a31e966b..ad73f728f7a2 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -111,6 +111,9 @@ endif
 
 # needed for relocation
 LDFLAGS_u-boot += -pie
+ifeq ($(CONFIG_RELR),y)
+LDFLAGS_u-boot += -z pack-relative-relocs
+endif
 
 ifeq ($(CONFIG_ARM64),y)
 # U-Boot uses fixed 4K granules, so we force the linker to match.
@@ -139,8 +142,11 @@ endif
 endif
 
 ifneq ($(CONFIG_XPL_BUILD),y)
-# Check that only R_ARM_RELATIVE relocations are generated.
+# Check that only R_ARM_RELATIVE relocations are generated
+# unless we compile with RELR
+ifneq ($(CONFIG_RELR),y)
 INPUTS-y += checkarmreloc
+endif
 # The movt / movw can hardcode 16 bit parts of the addresses in the
 # instruction. Relocation is not supported for that case, so disable
 # such usage by requiring word relocations.
@@ -152,7 +158,7 @@ endif
 ifdef CONFIG_ARM64
 OBJCOPYFLAGS += -j .text -j .secure_text -j .secure_data -j .rodata -j .data \
 		-j __u_boot_list -j .rela.dyn -j .got -j .got.plt \
-		-j .binman_sym_table -j .text_rest
+		-j .binman_sym_table -j .text_rest -j .relr.dyn
 else
 OBJCOPYFLAGS += -j .text -j .secure_text -j .secure_data -j .rodata -j .hash \
 		-j .data -j .got -j .got.plt -j __u_boot_list -j .rel.dyn \
diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 40c342e97e9b..c43303eb0cf2 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -89,6 +89,7 @@ pie_fixup:
 	add     x2, x2, #:lo12:__rel_dyn_start
 	adrp    x3, __rel_dyn_end       /* x3 <- Runtime &__rel_dyn_end */
 	add     x3, x3, #:lo12:__rel_dyn_end
+	b	pie_skip_reloc		/* .rela.dyn may be empty */
 pie_fix_loop:
 	ldp	x0, x1, [x2], #16	/* (x0, x1) <- (Link location, fixup) */
 	ldr	x4, [x2], #8		/* x4 <- addend */
@@ -101,6 +102,43 @@ pie_fix_loop:
 pie_skip_reloc:
 	cmp	x2, x3
 	b.lo	pie_fix_loop
+
+#ifdef CONFIG_RELR
+	/*
+	 * Fix .relr.dyn relocations. Entries hold link-time addresses
+	 * while x9 holds the run-vs-link offset and the addend is the value
+	 * already stored in the place.
+	 */
+	adrp	x2, __relr_dyn_start	/* x2 <- Runtime &__relr_dyn_start */
+	add	x2, x2, #:lo12:__relr_dyn_start
+	adrp	x3, __relr_dyn_end	/* x3 <- Runtime &__relr_dyn_end */
+	add	x3, x3, #:lo12:__relr_dyn_end
+	b	pie_relr_next
+pie_relr_loop:
+	ldr	x4, [x2], #8		/* x4 <- RELR entry */
+	tbnz	x4, #0, pie_relr_bitmap
+	add	x5, x4, x9		/* x5 <- Runtime address of the word */
+	ldr	x6, [x5]
+	add	x6, x6, x9
+	str	x6, [x5], #8		/* x5 <- Start of the next bitmap */
+	b	pie_relr_next
+pie_relr_bitmap:
+	mov	x7, x5
+	lsr	x4, x4, #1
+pie_relr_bit:
+	tbz	x4, #0, pie_relr_skip_bit
+	ldr	x6, [x7]
+	add	x6, x6, x9
+	str	x6, [x7]
+pie_relr_skip_bit:
+	add	x7, x7, #8
+	lsr	x4, x4, #1
+	cbnz	x4, pie_relr_bit
+	add	x5, x5, #(63 * 8)	/* Each bitmap covers 63 words */
+pie_relr_next:
+	cmp	x2, x3
+	b.lo	pie_relr_loop
+#endif
 pie_fixup_done:
 #endif
 
diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index 231ab28b50cd..73f0230629cc 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -149,6 +149,15 @@ SECTIONS
 		. = ALIGN(8);
 	}
 
+#ifdef CONFIG_RELR
+	.relr.dyn ALIGN (8) : {
+		__relr_dyn_start = .;
+		*(.relr.dyn)
+		__relr_dyn_end = .;
+		. = ALIGN(8);
+	}
+#endif
+
 	_end = .;
 
 	/*
diff --git a/arch/arm/lib/relocate_64.c b/arch/arm/lib/relocate_64.c
index 6f7a50f2264e..0572fe2d29f8 100644
--- a/arch/arm/lib/relocate_64.c
+++ b/arch/arm/lib/relocate_64.c
@@ -43,12 +43,19 @@ void notrace relocate_code(ulong dest)
 	u64 size = (u64)__image_copy_end - src;
 	const Elf64_Rela *rela = (const Elf64_Rela *)__rel_dyn_start;
 	const Elf64_Rela *rela_end = (const Elf64_Rela *)__rel_dyn_end;
+#if IS_ENABLED(CONFIG_RELR)
+	const u64 *relr = (const u64 *)__relr_dyn_start;
+	const u64 *relr_end = (const u64 *)__relr_dyn_end;
+	u64 run_to_copy;
+	u64 *place = NULL;
+#endif
 	u64 sctlr;
 	u64 offset;
 
 	if (src == dest)
 		return;
 	memcpy((void *)dest, (void *)src, size);
+
 	/*
 	 * r_offset and r_addend are link-time values, so the offset to apply
 	 * is link-to-copy
@@ -65,6 +72,27 @@ void notrace relocate_code(ulong dest)
 		*(u64 *)(rela->r_offset + offset) = rela->r_addend + offset;
 	}
 
+#if IS_ENABLED(CONFIG_RELR)
+	/*
+	 * RELR entries hold link-time addresses, so the location is found
+	 * with the link-to-copy offset. The addend is the value already
+	 * stored in the word, which pie_fixup has shifted to the run
+	 * address, so it is adjusted by the run-to-copy offset.
+	 */
+	run_to_copy = dest - src;
+	for (; relr < relr_end; relr++) {
+		if ((*relr & 1) == 0) {
+			place = (u64 *)(*relr + offset);
+			*place++ += run_to_copy;
+		} else {
+			for (u64 *p = place, r = *relr >> 1; r; p++, r >>= 1)
+				if (r & 1)
+					*p += run_to_copy;
+			place += 63;
+		}
+	}
+#endif
+
 	sctlr = get_sctlr();
 	if (sctlr & CR_C) {
 		__asm_flush_dcache_range(dest, dest + size);
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 48bd4fa86043..0e957feacc4d 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -41,6 +41,9 @@ extern char __ctors_start[], __ctors_end[];
 extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
 extern char __efi_runtime_start[], __efi_runtime_stop[];
 
+#ifdef CONFIG_RELR
+extern char __relr_dyn_start[], __relr_dyn_end[];
+#endif
 /* function descriptor handling (if any).  Override
  * in asm/sections.h */
 #ifndef dereference_function_descriptor
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 73d4097464c0..1bcd4b697b25 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -127,9 +127,12 @@ efi_status_t efi_init_runtime_supported(void)
 	rt_table->length = sizeof(struct efi_rt_properties_table);
 	rt_table->runtime_services_supported =
 				EFI_RT_SUPPORTED_GET_VARIABLE |
-				EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME |
-				EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
-				EFI_RT_SUPPORTED_CONVERT_POINTER;
+				EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME;
+
+	if (!IS_ENABLED(CONFIG_RELR))
+		rt_table->runtime_services_supported |=
+			EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
+			EFI_RT_SUPPORTED_CONVERT_POINTER;
 
 	if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE))
 		rt_table->runtime_services_supported |=
-- 
2.53.0

