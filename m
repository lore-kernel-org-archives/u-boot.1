Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F7ECD3424
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 14:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D44C845E3;
	Fri,  1 May 2026 16:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gNNC8I+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F52883E36; Fri,  1 May 2026 16:39:00 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B6CC80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 16:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bdklingerman@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso1759188a34.2
 for <u-boot@lists.denx.de>; Fri, 01 May 2026 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777646337; x=1778251137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zfUpncIfzzuXgfETeePOpi86eUzr1jVAz91urQ+ue3Q=;
 b=gNNC8I+lBWkElb0jRo/zo1J8/CJdC/7h0TLTp8jXs8Qzfk45Jnie+JrIPYzUpM18pk
 zgzm+lRJIMGTgrJKF9BI9Q2BTLJqHgVPXAVoGVGd1pYeeB8p5N1KPkeJ0f1uwtlP1yuC
 wPjteAnduWEFIYPG2rVl/C+iuNk5qZt5vy/7Q57UECuH71m3+3EUVawpiV9Hs1ScFTdp
 h8Fj28xoHD5FRHa249VP+dt+kowAlG1z8yS5G24xgPWM/1kiXyB165ySUZALvMWz110M
 64zloQSmo0k4Bj4yaVRjsbK90hBMgWbbTBdwKKZUm3IstDzee6P7w9Yz+6WwdU0ucu9X
 kWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777646337; x=1778251137;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfUpncIfzzuXgfETeePOpi86eUzr1jVAz91urQ+ue3Q=;
 b=sxZ+XV1FeKB43XXV3k9ENLd7o9BuN8CwLgcV29FvFc8r3pjFTQF7LSbxoMhGM2ioR5
 eEeo6ZZ6BCVtVm1LLOBZLnIwiacAZ6+srnkP+NUo/0wyuew626nTfsAjM0/wnEu99Aoo
 Wl41/ICrPoM7PdVnoaeyxvoK8Oum9/iyW0Bmaj0BGsCwa89xsbfKDLMr75OjmhN/HZW6
 DgEr9cNwbvfWneU1yXlr8ZDgbJCkAqdZ3mNTs+jm4lXYoFjCyf1yQplodsiIlvOGqQyT
 z8aEwZTLr1J+q7bRFTTyFgRAD4zmqdwK8AQGQ1fEt8FdHKxNvDUeCPEw/f+JmewFo9tI
 7owQ==
X-Gm-Message-State: AOJu0Ywr5QnbvjRZVztcDdjQlfFuCn1eAdnDuxMyyebjuSY22qKT+HBF
 iZ6WkQ3V8+uUSBmiBdO6bEgq8fPMX5bYIuTy5B5h6+Klt4CrI4imTIweO4JE4A==
X-Gm-Gg: AeBDieu7snJQHyTb/CwZ39qSZanUxEGpc0MnynBB30oXf3IKiTLUMtuKs4AEqHN89Um
 uCZy9ELoEdZ6IhFlmGEuFUaTWL2YJu2JBSLQFFwUibQM5i+4JhZVg8x+dCJvhdstz2Aw7URwKdE
 7DeZ+lgcgO65nd5or1NrB//jMaj4BBamXNzSH59d8svJ2JixPn5KyscUpR0Tr8UbY56rPt9fAwe
 t7hjkNg0afZwHGLDgfb/8jcF+6X91BsKdCJLP9YuTC9g1QzxQhTyKe4ShmbhhUouRfacKtQIG1m
 hOlAFB9E0IXc/Vpl6Wz/Ot1D+hQbbCx6hIoYF70xU14IS+9LKIfw3LfazUPia7IX9+7tVpuc9aH
 N0iTrcYIZj2NF7onQyWVRSLNOoXoR7jqnmHvUqFqr4EHguI4LFgKDdEa5YvdvnZYXUnqXWAvy5w
 dKGt+D4jxgPw7CArCMnC6NdNqn
X-Received: by 2002:a05:6830:6b03:b0:7d9:71fa:3079 with SMTP id
 46e09a7af769-7debdd624damr3920415a34.10.1777646336704; 
 Fri, 01 May 2026 07:38:56 -0700 (PDT)
Received: from xps ([97.86.254.41]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca7a5e6asm2332675a34.3.2026.05.01.07.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 07:38:56 -0700 (PDT)
From: Brad Klingerman <bdklingerman@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] Makefile: remove block from conv=block,
 sync in SPL alignment dd
Date: Fri,  1 May 2026 09:38:50 -0500
Message-ID: <20260501143850.2714779-1-bdklingerman@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 01 May 2026 16:46:21 +0200
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

The line that produces $(SPL_BIN)-align.bin invokes dd with
conv=block,sync but no cbs= operand. The result of dd conv=block
without cbs= is unspecified. GNU coreutils outputs anyway, but
uutils (default in Ubuntu 26.04 LTS) errors out for files with
newlines, including SPL binaries, producing:

    dd: conv=block or conv=ubnblock specified without cbs=N

Either the block operand must be removed, or cbs=N must be added.
conv=block is for converting newline-terminated variable-length
records to fixed-length space-padded ones, which is meaningless
for a binary SPL image. The intent of the rule is 4-byte
alignment, which conv=sync alone provides by padding the final
block to bs= bytes with NULs.

During build, u-boot-spl-align.bin errors silently due to '@'.

Reproduced with uutils dd 0.8.0:

    $ dd if=/dev/urandom of=/tmp/in bs=1 count=10000
    $ dd if=/tmp/in of=/tmp/out conv=block,sync bs=4
    dd: conv=block or conv=unblock specified without cbs=N
    $ dd if=/tmp/in of=/tmp/out conv=sync bs=4
    [succeeds]

Output is byte-identical to GNU dd's output for binary input.

Signed-off-by: Brad Klingerman <bdklingerman@gmail.com>
---
 scripts/Makefile.xpl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 862a8e6f231..a3fd3e1375f 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -257,7 +257,7 @@ MKIMAGEFLAGS_boot.bin = -T zynqmpimage -R $(srctree)/$(CONFIG_BOOT_INIT_FILE) \
 endif
 
 $(obj)/$(SPL_BIN)-align.bin: $(obj)/$(SPL_BIN).bin
-	@dd if=$< of=$@ conv=block,sync bs=4 2>/dev/null;
+	@dd if=$< of=$@ conv=sync bs=4 2>/dev/null;
 
 spl/boot.bin: $(obj)/$(SPL_BIN)-align.bin FORCE
 	$(call if_changed,mkimage)
-- 
2.53.0

