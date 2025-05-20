Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5F7C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2657582C8A;
	Tue, 20 May 2025 07:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uyBobRLZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC12B82C96; Tue, 20 May 2025 07:22:23 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C779482BD9
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a37a243388so287965f8f.1
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718541; x=1748323341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NSNNW0Lxdsdb+CG0WOvzIn/xRqPJRoz2EmMLVVPhvP0=;
 b=uyBobRLZkt4T3JXK3T3jcb8yZjO/pXz8RkrHKEe7VNXFgZoIUO+5fLOe6C/L/3v4x+
 Hb7S9AxmmAd/Xlzb8xhmKO5EcziLw7mxSCTpTdIepczlP7M4PqV28u7njehEwGzvvj4p
 2qLdUze8bjJMnyFMGXriwqGxIJDe+Ucnyth5TkUGEjBG8hXg2NXjKSMgan83wyMtvg9S
 W6OYyJjrvwYiy3DWXv890XySYCOj4x/UuOxD3GfYe5l8CHoTZtbS6hpAmJH04eGQ/crG
 HfPNKQNMWhzM0cfgwv+hGxCzenh/ZFVg2Qe2nbdX+gmej9ugGRdnIRLrTgTG5115fGsQ
 Ek6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718541; x=1748323341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NSNNW0Lxdsdb+CG0WOvzIn/xRqPJRoz2EmMLVVPhvP0=;
 b=dL0n2fcnigAw+mZ+aWYw33+TWAZoR024uVxh7uLz7S1zDWKOzn/eLr+uy+gC971ak8
 2uLAnYUv5pNimt4z1LU825tOYc95E6bjGPOxuHZ+XiRtjvTsoKy4WxhyRM0EwHIXSrDs
 Gwe8VLke3/UcYeERIxRlG6aFZ4LqzemcbgoufA7ZM/iUTxk4brXKySbQqV1hHj1zQcM/
 QHq6MuftTcKO0JzGwRyrtjRHI3L7cpayuMgi/rY0PqSOHbzqBF8NHiYfsT/B0Ztx3SfG
 ytLLAZF8x1iLW1SR/n4exhR2CpQ6mBtGBVLktsTc904zkJRdKsRlbm4abB3sD4O/nvfM
 q7Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpbrOG+pD03y+bKjzIux7OCkGQBQRdzYgf08EznYdwBnC7sZO9BNH1vXFnfDcp7BEZhqV+kW8=@lists.denx.de
X-Gm-Message-State: AOJu0YweNmk7XAd+PUG/7iD/kCHF1BKlD/mTqd2R48Mn75scTBgjKziE
 vIOXLi4gfoxn+Veg9FGyBCg9Xjm94isKxXvFtsJQDVk4XI3XO/JJoem7f4Yyrfpzv+MASAYxDb+
 SObET
X-Gm-Gg: ASbGnctM05JZrsVpa0kkAiwTpyKjGQjWTF7APBTjs4FsiSmWschi6rEkjf8Xb09bvCp
 69hX9C5wf+x2P0M5ZN2UBHnZSTlu+WpBgr0Otl4aPjMuOtPLu3hbvu5tSRjOfswlk+MQ63fa2/A
 zynb7jJwhnRHhs+qK4kSK8MmEZMpvOmzZy44/HBGaNpBBWO1EwqIe1GHpMCnnWQYnUSc+nO9wha
 2eXO075oVIlzuzytXIeOaJsUBkVgGkvcGqeSGyymyhHoQrZ4ed1jleTg0LOs1q/cKYgr6fJ2bGH
 zFu8Xw6R/HAFEjubsgwxX5PIYqX/9oBU3/2hXHdDBqy9KLTwlizSqRX5bPW5yMRaEUPB47QF4QY
 =
X-Google-Smtp-Source: AGHT+IG0hAdQS5myQbQthngS1QZAWuo93u9MlI7A1OKdVuht2sZXF+ILCAAsIe9ck8NpQWUGcBEKwg==
X-Received: by 2002:a05:6000:40c9:b0:3a0:7aa3:cc74 with SMTP id
 ffacd0b85a97d-3a35c808cb7mr14847328f8f.6.1747718541308; 
 Mon, 19 May 2025 22:22:21 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:20 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 09/24] kbuild: remove unnecessary in-subshell execution
Date: Tue, 20 May 2025 08:21:20 +0300
Message-ID: <20250520052153.307194-10-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Backport kernel changes

commit b79c6aa6a1f1 ("kbuild: remove unnecessary in-subshell execution")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.lib | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 4861b1332c3c..28295c7ff125 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -324,7 +324,7 @@ DTC_FLAGS += $(if $(filter $(patsubst $(obj)/%,%,$@), $(base-dtb-y)), -@)
 quiet_cmd_dt_S_dtb= DTBS    $@
 # Modified for U-Boot
 cmd_dt_S_dtb=						\
-(							\
+{							\
 	echo '.section .dtb.init.rodata,"a"';		\
 	echo '.balign 16';				\
 	echo '.global __dtb_$(subst -,_,$(*F))_begin';	\
@@ -333,7 +333,7 @@ cmd_dt_S_dtb=						\
 	echo '__dtb_$(subst -,_,$(*F))_end:';		\
 	echo '.global __dtb_$(subst -,_,$(*F))_end';	\
 	echo '.balign 16';				\
-) > $@
+} > $@
 
 $(obj)/%.dtb.S: $(obj)/%.dtb
 	$(call cmd,dt_S_dtb)
@@ -560,20 +560,20 @@ printf "%08x\n" $$dec_size |						\
 )
 
 quiet_cmd_bzip2 = BZIP2   $@
-cmd_bzip2 = (cat $(real-prereqs) | bzip2 -9 && $(size_append)) > $@
+cmd_bzip2 = { cat $(real-prereqs) | bzip2 -9 && $(size_append); } > $@
 
 # Lzma
 # ---------------------------------------------------------------------------
 
 quiet_cmd_lzma = LZMA    $@
-cmd_lzma = (cat $(real-prereqs) | lzma -9 && $(size_append)) > $@
+cmd_lzma = { cat $(real-prereqs) | lzma -9 && $(size_append); } > $@
 
 quiet_cmd_lzo = LZO     $@
-cmd_lzo = (cat $(real-prereqs) | lzop -9 && $(size_append)) > $@
+cmd_lzo = { cat $(real-prereqs) | lzop -9 && $(size_append); } > $@
 
 quiet_cmd_lz4 = LZ4     $@
-cmd_lz4 = (cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
-	$(size_append)) > $@
+cmd_lz4 = { cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
+	$(size_append); } > $@
 
 # U-Boot mkimage
 # ---------------------------------------------------------------------------
@@ -617,12 +617,11 @@ quiet_cmd_uimage = UIMAGE  $(UIMAGE_OUT)
 # big dictionary would increase the memory usage too much in the multi-call
 # decompression mode. A BCJ filter isn't used either.
 quiet_cmd_xzkern = XZKERN  $@
-cmd_xzkern = (cat $(filter-out FORCE,$^) | \
-	sh $(srctree)/scripts/xz_wrap.sh && $(size_append)) > $@
+cmd_xzkern = { cat $(filter-out FORCE,$^) | \
+	sh $(srctree)/scripts/xz_wrap.sh && $(size_append); } > $@
 
 quiet_cmd_xzmisc = XZMISC  $@
-cmd_xzmisc = (cat $(filter-out FORCE,$^) | \
-	xz --check=crc32 --lzma2=dict=1MiB) > $@
+cmd_xzmisc = cat $(real-prereqs) | xz --check=crc32 --lzma2=dict=1MiB > $@
 
 # Additional commands for U-Boot
 #
-- 
2.49.0

