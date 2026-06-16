Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35D5CD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 162E984869;
	Tue, 16 Jun 2026 16:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F8ZvjM6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35DFA848C5; Tue, 16 Jun 2026 16:25:06 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF8B78484C
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-69d7cdd3b8eso1965197eaf.2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781619902; x=1782224702; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXch9jDqprYS8As3LON6NUAOqWLiV4CQDJdUlQb7f/c=;
 b=F8ZvjM6UGffNeULZBU7/dO7kKKnKZY0qCJdMYW0l9aPpjX0yUTuOCtScvhJZ5+RTSU
 m15UM3AgHA6Fg2TI2Tp0/tzN0rROHlkkIzs4oCvdihf3GYgJT8xapgUUXAfnZtaGuHU4
 TbPdlKkJHTQ69wNOX7LQUpU2vggFtGP63tyIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781619902; x=1782224702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CXch9jDqprYS8As3LON6NUAOqWLiV4CQDJdUlQb7f/c=;
 b=Bm/vUY+ReN18yjFPlDqMyf+i7433SZvw6fdqg2WjIBCIpUDDd917z5b0q99VcILvGX
 TE2wo6s0B+DgC1myy0n3CM2fXSzPpVzp/bBjhBve27mqL7KFVfThjXL7lClWFW2GkHcd
 YkRE/z3bVeVEvPx0mI+wRnqIyY0qWH5JGAMWbZja2gjJVgpKeEYs79VtijOHBVOka3Gu
 zDr+rp3lo5SyWIXsGeIF9LMT/bN8WYc9rKHFOo/9eaNm8283DRZjDMIvunIgnntzZ2h0
 RdXMdrVfvqw0k33rbOR51WWrXSOouvSJupz48FgYDXj6y+ybnnW7DpPj2nuQGPpv2E2G
 TEKw==
X-Gm-Message-State: AOJu0YwPSupdZPpyhh0qlF3T9ip8rN3aPw8xWeyzpkvzuU++iik2Lmri
 MS6Ium54JEbZZUbLztuDhUMmqrRhMYh/hI8vKsqoIdAjt0yEpgGBuwFTrMvm+fhnW08YlrG6vIk
 ezrI=
X-Gm-Gg: Acq92OEtCXvMcdXik3zkDa+F6CHrLQDjXdthi1qeODctzJlTvFPRRfvR+U/GJrYykbf
 J+IQhPoL5OpEV80HCywd2AFGSODRHy6fuBkWUHJB+zbkPMP7OjlnVCunVQNLCY2/E7vghi0x/+m
 p+9j+a1EB2kkK38etjIes9yRWYiAy3Zoy+wyVyelgmgzw9XC9TXG273fEriZDkc8ijbaRgVk+MX
 sKT5j1H1AMV97XusVG9vpWZ/afmNu+0Vjkw7cRoF7Mf3XgaZ/X4Hl0DSl8D3dBRfNplKw3FI0R+
 IAFYwonBu5ozGSmaQK098T5yftvQVzS2tei+7LclSwLMAtMot+9Rh2fNXCrOI4S+28/yZUWUCOa
 UWwn3pnNHgpxr2elv8tInUVtqipzBwQwfKkNP8MthUVfs00FnSvaQ6Vqfndo25N9chgfW1ha32d
 hoR0ZHOd/8j+pqOsPnxA==
X-Received: by 2002:a05:6820:1892:b0:69e:40a1:5fc6 with SMTP id
 006d021491bc7-69eec64b7a2mr9815432eaf.0.1781619902600; 
 Tue, 16 Jun 2026 07:25:02 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430900e368sm2215230fac.16.2026.06.16.07.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:25:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/5] x86: edison: Move U-Boot alignment into binman
Date: Tue, 16 Jun 2026 08:24:18 -0600
Message-ID: <20260616142444.48193-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616142444.48193-1-sjg@chromium.org>
References: <20260616142444.48193-1-sjg@chromium.org>
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

The mask ROM loads the OS image to 0x01100000 but enters it at
0x01101000, so U-Boot must sit 0x1000 (4KB) into the loaded image. This
is arranged by board/intel/edison/config.mk, which prepends 4096 zero
bytes to u-boot.bin through an 'INPUTS-y += u-boot-align.bin' rule whose
recipe moves its output back over u-boot.bin.

Since the Edison image is assembled by binman, provide the gap there
instead: pad with a 'fill' of 4096 zero bytes ahead of the u-boot entry.
Wrap the fill and U-Boot in a section that is also written out as
u-boot-edison-dfu.bin, the [gap + U-Boot] payload to flash into the
u-boot0 partition over DFU, so that no longer needs a manual prepend.
Drop the now-redundant alignment hack from the board config.mk.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Reframe as a binman conversion (the boot fix is now a precursor) and
  drop the duplicate 'Fixes' tag
- Wrap the gap and U-Boot in a section emitted as u-boot-edison-dfu.bin,
  the ready-to-flash DFU payload

 arch/x86/dts/edison.dts      | 21 +++++++++++++++++++--
 board/intel/edison/config.mk | 10 ----------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/dts/edison.dts b/arch/x86/dts/edison.dts
index 8fdacfb0fd8..00eb787deb1 100644
--- a/arch/x86/dts/edison.dts
+++ b/arch/x86/dts/edison.dts
@@ -177,8 +177,25 @@
 			intel,load-address = <(CONFIG_TEXT_BASE - 0x1000)>;
 		};
 
-		u-boot {
-			offset = <0x200>;
+		/*
+		 * The OSII loads the image to (CONFIG_TEXT_BASE - 0x1000) but
+		 * enters it at CONFIG_TEXT_BASE, so U-Boot must sit 0x1000
+		 * (4KB) into the loaded data. Pad with zeroes ahead of U-Boot
+		 * to provide that gap, and emit the [gap + U-Boot] payload as
+		 * its own file (u-boot-edison-dfu.bin) for flashing into the
+		 * u-boot0 partition over DFU.
+		 */
+		u-boot-dfu {
+			type = "section";
+			filename = "u-boot-edison-dfu.bin";
+
+			fill {
+				size = <0x1000>;
+				fill-byte = [00];
+			};
+
+			u-boot {
+			};
 		};
 
 		u-boot-env {
diff --git a/board/intel/edison/config.mk b/board/intel/edison/config.mk
index fff187caa15..da7c9acf1a2 100644
--- a/board/intel/edison/config.mk
+++ b/board/intel/edison/config.mk
@@ -4,14 +4,4 @@
 # Copyright (c) 2017 Intel Corporation
 #
 
-# Add 4096 bytes of zeroes to u-boot.bin
-quiet_cmd_mkalign_eds = EDSALGN $@
-cmd_mkalign_eds =							\
-	dd if=$< of=$@ bs=4k seek=1 2>/dev/null &&			\
-	mv $@ $<
-
-INPUTS-y += u-boot-align.bin
-u-boot-align.bin: u-boot.bin FORCE
-	$(call if_changed,mkalign_eds)
-
 HOSTCFLAGS_include/autoconf.mk.dep = -Wno-variadic-macros
-- 
2.43.0

