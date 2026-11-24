Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D478E606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jrpvrJmk;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RMiWq6uK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AECA380FB3;
	Tue, 24 Nov 2026 13:22:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0hP_Xf8Nli7v; Tue, 24 Nov 2026 13:22:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F2C8A80FDE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795526576;
	b=EhZ3raWbj75l2x3Eu+pQLcL5rgj9z6C1+x69AjD0RUQ56JRHnohluz04xwptDdNVStsy
	 /bC9L4gTQ52lJy+WBGYsee4MkKm0pe0XKnYFLonIduTTfbqc8w+bH17ljaz8EgPH3sWwP
	 NNJ+MShUezJBqmvQoobB5RJKz9/OXmhyP1lqv4y8ulMtlCM4F5iArryxrk1Gy1I0LeRDx
	 I+gSiwdTmUqYZhbwr7ZdmVqI98EXCcR/X3Goh6nteIDIVvKNvDRTC87okUHWYWUJd8ZOd
	 aEKGEfl2X0ZS8wTYqgxEEatDd+ajA6nnsGpL6dn08J86h52gSA3v1Wat042db9QEvKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795526576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FDuEMxYgYBVobl/Z5dl6njT/IiUQ6/EkCRGt1PlxcR8=;
	b=dNguejeWYZZKWmhwdVV/kmYoDnADClZWfoP+XNcm7MlSykpxV0AbiHASrKjPOvwIvoIQ
	 xnZEAyHmjWAtWIJ8qq0eUbLRo9R6F0dmdcNW03wiVUJnang/Loxt+Hkr33ItN79/ni7L3
	 ifuES962n1ZaBX93UA2c0IgER+dwGYbZsQ2onIHn38XJ/CwqWL+n+aSTLcCf/fJW3xjcw
	 Q2HbedeobBcOWmGs3jy7FRDz6XsAvSMD5OkKgfXsDBI4gOhlmO+wB3i3KbMtZpao2/Wgf
	 KabOoZIfOStV7wvBUCAzK2qcZvnm0SQ/F62HDJvyA74D5UfyEthuzOBksM1vlALOClw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795526576;
	bh=FDuEMxYgYBVobl/Z5dl6njT/IiUQ6/EkCRGt1PlxcR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jrpvrJmk+rPIBqIgreqQWyCj4pW9Tn6h5UyfmmiK0hqRjfQTYrffo+0hd1CYbMKWg
	 bqd8hf6vKJn05zxRWcrnpgvrQi74l14tOJt0F85T+lBUW6Yl6DzBvluLWvdq9yichB
	 wd5cDSYsvQ0P3BxXbZ773HD8rlS6oDH/FM8IuIhvu8Sv3ZgyQ1crzNf8k8FYJ09TmO
	 fStRBfPQS80Dc9YtlqYGV6CJiCsz3TP8Tcd3Pu/gtr04DWJyRlcZ4cj/nOEUHlWTge
	 iMKeAvcB4+ZyROpBTVTCoNXAND4aSLh7R1sk6adgN2YORf46fMKmiEGlV42NVYdsmd
	 RPPMTlRqBFk7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2C8A80FDE;
	Tue, 24 Nov 2026 13:22:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 86C08D43
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6CF61606C7
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:57:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gqDVlESGpTuq for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 06:57:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 70DFE605EF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=leeonion.muyu@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=RMiWq6uK
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70DFE605EF
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:57:16 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF10841F2; Tue, 24 Nov 2026 07:57:14 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D1A83108
 for <u-boot@lists.denx.de>; Tue, 24 Nov 2026 07:57:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leeonion.muyu@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2f07a960666so22117945ad.1
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 22:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795503426; x=1796108226; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FDuEMxYgYBVobl/Z5dl6njT/IiUQ6/EkCRGt1PlxcR8=;
 b=RMiWq6uKMswyr6H3U/m68lcm4q+qb7Y5YoBIQIUTOomz9ER+g7ZB7Uj4y0ZQC/LA/h
 oMdn4/o8TkPIMXoN/Sf8yBtuJuOrGvAaF9oD1eL3KHuyPowTiugoiq0Ocn2mumUawI0V
 AGIhyBwU6HoU1AVp5yvCNlWNDvm4Bnt+JIQ30V1+RQlsdEe2cxezBSobucOtlXdI0GPx
 3QAnk73ijGDwIKy/gbaJ5znoC8Qw190+IesdV94MDSq2pncv/9/h14tsYtLZPmOFjHjF
 D/u4rCRHlgEJ2+wnW6zhAL4mdzP9R0mPzatB75Ci1J8XIBtWqSYXoQkUY29f3RIh2Gqp
 Wa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795503426; x=1796108226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FDuEMxYgYBVobl/Z5dl6njT/IiUQ6/EkCRGt1PlxcR8=;
 b=H/gb3Q3DIwq16HDEdfmhLWOpRIGO7UjuyDAEOpZO2p44vaESeno1xPFD6xWcwn+/0b
 ejrveVF8GZt6QvppCpIQzxwJXjSNbQB5eLpSRorV+Ds8rf8mgZjb7B2Qu5UREyzDMVhQ
 1M9ID8piuvC7gtPamu3OcQJNKh1QKV+2kzw9AyTvcXzgm8/svo6c3h+tOMVKtKuTJmlv
 6jDet3Jay3TMhu0s6AX9ntLwy3cTpvi6d5d6ty8DTbq0eDp7r7MkyZJuaZbTJGx1z4Oa
 JR89kMhu+7mZFUVid8baKcypov1a+vWKHDfRNerDiZuLxL4YsBiJ2m0I8RAqCEwLdB9e
 2ElA==
X-Forwarded-Encrypted: i=1;
 AL+hErHzsy14E6ACwrwPX++wlsQvfQ0vuin344Xc7WNqrkN6FStJIajPjhd2KDhIjlY8AVqZxLJTnc4=@lists.denx.de
X-Gm-Message-State: APuU4Z/gcOr5Nb4buDYhDmKb42MjS/bWyzR5MhH9kDdEDVGwfbc5Kk2o
 zVV749aJL+4QjLnfGJMjiIZ23ygLcCjNLOVZ0U+OOi1Z8Th0sl9G8erc
X-Gm-Gg: AZFdTZeB6ZDYBUZ+BoiCajwUQonCm6CVbKVPpMnMrkYtEuE3K7IPddJ2AuFbOtZQyhf
 eyWaPm2LWC9rxD/ZQ11mDbUC4Osse7VCDqspBeCofOKSXQdMCVfTf6nvvAnm9EIV/G3Obabpnxe
 Bxcs7ex9FyNpFmnEiTz4qIzbz8IqpdFvnTLKHaYI4Y9YRP5AjcaJbO9D1mwfFoMUKw2heXVGdW9
 IeyW7Mgn1TGcd0W5FMV3fRFayBpv2IbQ6XK5pGV1+ByddjEmFZMM2sHlhDE9JwFGv7t0p1Gj06L
 /nrQLROngHn2Nf/D2ks7JGq1h4P0HGzX0xfs+WsHyNrk26tcEDxHikLN1fODfmsdPUFiskOOQWy
 RzIDkTToZHS7kebA/jgyEVU2GOiBiBarNF7ZL5gxoupupCV4HXSn5XYPX4m1POoZyzrVZG8NeWl
 tsbS983s0wtxV5WBGX1hutXv6k9cT7/O79Y+H/JnCvQu6moKoI2+FdWHlCto2bpTtoiCWmf7tIL
 aL2HGGqdLbLr3kjECPdLzrocwoREk9Rew9za/LwBbq2xafBcckebgdobWcsZXDujShJjvaXnkov
 43VXI26d3mBmlNLp3s5nwzvMU/3VhA92Kg==
X-Received: by 2002:a17:902:cf0d:b0:2ed:3d88:4c24 with SMTP id
 d9443c01a7336-2f03f11da29mr128145425ad.27.1795503425640; 
 Mon, 23 Nov 2026 22:57:05 -0800 (PST)
Received: from server225.. ([39.170.101.209]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f105b66sm64966685ad.51.2026.11.23.22.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 22:57:05 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: catalin.marinas@arm.com, will@kernel.org, palmer@dabbelt.com,
 pjw@kernel.org
Cc: mark.rutland@arm.com, alex@ghiti.fr, emil.renner.berthing@canonical.com,
 masahiroy@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 u-boot@lists.denx.de, Ping Li <leeonion.muyu@gmail.com>
Subject: [PATCH 2/2] riscv: boot: emit standard LZ4 frame for Image.lz4
Date: Tue, 24 Nov 2026 14:56:50 +0800
Message-Id: <20261124065650.1968930-3-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124065650.1968930-1-leeonion.muyu@gmail.com>
References: <20261124065650.1968930-1-leeonion.muyu@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 24 Nov 2026 13:22:50 +0000
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Like arm64, a compressed riscv boot image is decompressed by the
bootloader, not by the kernel itself.  The shared cmd_lz4 rule
passes -l, producing the legacy LZ4 format (magic 0x184C2102) that
only the kernel's own decompressor understands, so U-Boot's 'booti'
compressed-kernel path (boot/image.c image_decomp ->
lib/lz4_wrapper.c ulz4fn), which only accepts the standard LZ4 frame
(magic 0x184D2204), rejects the Image.lz4 built today.

This matters in particular when CONFIG_KERNEL_LZ4 selects Image.lz4
as the default boot image via boot-image-$(CONFIG_KERNEL_LZ4) in
arch/riscv/Makefile.

Emit the standard LZ4 frame through a local rule, leaving the shared
cmd_lz4 untouched for the in-kernel users (the lz4-compressed
initramfs and the self-extracting images of other architectures).

Signed-off-by: Ping Li <leeonion.muyu@gmail.com>
---
 arch/riscv/boot/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index b80a077a8e8f..0e7607d7e39f 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -33,8 +33,15 @@ $(obj)/loader: $(obj)/loader.o $(obj)/Image $(obj)/loader.lds FORCE
 $(obj)/Image.bz2: $(obj)/Image FORCE
 	$(call if_changed,bzip2)
 
+# The shared cmd_lz4 passes -l, producing the legacy LZ4 format that
+# matches the kernel's own decompressor.  Image.lz4 is decompressed by
+# the bootloader though, and U-Boot only supports the standard LZ4 frame
+# format, so use a local rule that omits -l.
+quiet_cmd_lz4_std = LZ4     $@
+      cmd_lz4_std = cat $(real-prereqs) | $(LZ4) -9 - - > $@
+
 $(obj)/Image.lz4: $(obj)/Image FORCE
-	$(call if_changed,lz4)
+	$(call if_changed,lz4_std)
 
 $(obj)/Image.lzma: $(obj)/Image FORCE
 	$(call if_changed,lzma)
-- 
2.34.1

