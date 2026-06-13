Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F6CCD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 13:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96F6F84869;
	Sat, 13 Jun 2026 15:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AFQwuenz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A379848A1; Sat, 13 Jun 2026 15:06:30 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B94F8486B
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 15:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-43d34292872so974655fac.0
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781355987; x=1781960787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dsMje8YrZzdvcL2wbz+9jByCQhhzAejSRBm5naMNbdA=;
 b=AFQwuenzERVc6QrnepzcOi+o3NCiDX1RZS6u/0dZngVC2NCvVdtmmXcr/7FBDDx9v+
 ASnV7et6uAuOfnTwRgVWEott7AtvJODQwci/GwkxLB5tN1kdCkXSPfM2R3DJpZaaSxOK
 U1f3eJ1HWq3rRhnGYyVsRUqu0CtaCqun6qx6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781355987; x=1781960787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dsMje8YrZzdvcL2wbz+9jByCQhhzAejSRBm5naMNbdA=;
 b=brpLrKMTRlc8JkRPk6/iiJP7AFVAjV40o3aECAkG4AIW2hIy+TZQ13sqlzT8FAXZWB
 cITCzmq+AbjZOMBAhdeSOot7DtsoDLNoW72AG4KrodJH8PercnbhRZfABR2Pm8g2JRdo
 86nJc+QvG+f2gOnB7BHqfF/+kiCN8rycx93L93e+IZOvAwV/19tnFQPgD7AtYTsP6/mG
 su/7eHZAECy5pJfMw03nPjSVNy7EEyNgx0llJH+LYhyHo5H/iAfeqBd/zYNB4Iyh4/hE
 nhjt6YYzrjGdn2L/Jz+ckFv3LdOYly/NJG0ZuJKE5xReR78LSLsuhcboUCMQNusW0j6p
 j6qQ==
X-Gm-Message-State: AOJu0Yx0rHKiJop/4crlu+w2pkDy9jPAGbfndzZn05Nszki0NG5MtV5l
 VaSMefkFwiNMI2PpGasVB7UbDPC8kP7eP6lQq0gn+JjoOu/rjEj9DS922Y+iQkqd92cnvzHKZ2W
 rC4pC8A==
X-Gm-Gg: Acq92OFURh3Pb4tupCeiUZE96bTm6yxNtk/5tdT+32Pepfe7KcRzaaeg93iA8jE4Y4V
 /+OzE4+5/4XOLTQ1IgOOa+GZLUtbo0Sg0lz79WM0HAU1ZabKoqjJ6p6zhFuqBP8eZhAEYZN/1Ap
 ItFWsoJkuh7u2m1qLA8V0foC5LjOldM+T00+2Q1rXT0Hjr/FFU60dbpag8gwxlApAp6E/xuAFuf
 WJnteczjbd8ug1JL6dN8S8672x0AR4TvnVCKTDm5DPCDbrtd23ZqHsLA0PYHPH5XBWKXnI37ZFW
 12IafC+BSj72GVg409OfNNRUqFr215zQlQVwSgibn8TTc2HmufAaaCIMDl2QMrH9T1O8dD/WVPe
 Kw6/sKV1GjDKZtJFUUxhyC28EbHddrSoi5rSJN3zlcFkDIRzMhiEwcKHRCKIIYNDUYpdA8PM8Yu
 NSNG7aYLh/t3ntCI2udg==
X-Received: by 2002:a05:6871:c8d4:b0:440:4df:c208 with SMTP id
 586e51a60fabf-4426e21cb07mr4739542fac.33.1781355986783; 
 Sat, 13 Jun 2026 06:06:26 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426b32624csm4459564fac.16.2026.06.13.06.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 06:06:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm: mxs: Avoid passing FORCE to commands
Date: Sat, 13 Jun 2026 07:05:13 -0600
Message-ID: <20260613130519.1516808-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613130519.1516808-1-sjg@chromium.org>
References: <20260613130519.1516808-1-sjg@chromium.org>
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

Commit bd3f9ee679b4 ("kbuild: Bump the build system to 6.1") adds FORCE
as a prerequisite to the if_changed rules here, but the commands use $^
so FORCE leaks in as a stray operand. The dd in cmd_mkalign_mxs fails
(silently, since its stderr is discarded) and the binary is never
aligned, stat in cmd_mkivt_mxs emits an error and cst receives a bogus
argument.

Use $< and $(real-prereqs) instead, which exclude FORCE.

Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/cpu/arm926ejs/mxs/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/cpu/arm926ejs/mxs/Makefile b/arch/arm/cpu/arm926ejs/mxs/Makefile
index 0df501e91db..6bd95a5185b 100644
--- a/arch/arm/cpu/arm926ejs/mxs/Makefile
+++ b/arch/arm/cpu/arm926ejs/mxs/Makefile
@@ -26,7 +26,7 @@ MKIMAGE_TARGET-$(CONFIG_MX28) = mxsimage$(CONFIG_SPL_FRAMEWORK:%=-spl).mx28.cfg
 #
 quiet_cmd_mkivt_mxs = MXSIVT  $@
 cmd_mkivt_mxs =								\
-	sz=`expr \`stat -c "%s" $^\` + 64 + 3904 + 128` ;		\
+	sz=`expr \`stat -c "%s" $<\` + 64 + 3904 + 128` ;		\
 	echo -n "0x402000d1 $2 0 0 0 $3 $4 0 $$sz 0 0 0 0 0 0 0" |	\
 	tr -s " " | xargs -d " " -i printf "%08x\n" "{}" | rev |	\
 	sed "s/\(.\)\(.\)/\\\\\\\\x\2\1\n/g" | xargs -i printf "{}" >$@
@@ -34,15 +34,15 @@ cmd_mkivt_mxs =								\
 # Align binary to 64B
 quiet_cmd_mkalign_mxs = MXSALGN $@
 cmd_mkalign_mxs =							\
-	dd if=$^ of=$@ ibs=64 conv=sync 2>/dev/null &&			\
-	mv $@ $^
+	dd if=$< of=$@ ibs=64 conv=sync 2>/dev/null &&			\
+	mv $@ $<
 
 # Assemble the CSF file
 quiet_cmd_mkcsfreq_mxs = MXSCSFR $@
 cmd_mkcsfreq_mxs =							\
-	ivt=$(word 1,$^) ;						\
-	bin=$(word 2,$^) ;						\
-	csf=$(word 3,$^) ;						\
+	ivt=$(word 1,$(real-prereqs)) ;					\
+	bin=$(word 2,$(real-prereqs)) ;					\
+	csf=$(word 3,$(real-prereqs)) ;					\
 	sed "s@VENDOR@$(VENDOR)@g;s@BOARD@$(BOARD)@g" "$$csf" |		\
 		sed '/^\#\#Blocks/ d' > $@ ;				\
 	echo "  Blocks = $2 0x0 `stat -c '%s' $$bin` \"$$bin\" , \\" >> $@ ; \
@@ -50,7 +50,7 @@ cmd_mkcsfreq_mxs =							\
 
 # Sign files
 quiet_cmd_mkcst_mxs = MXSCST  $@
-cmd_mkcst_mxs = cst -o $@ < $^						\
+cmd_mkcst_mxs = cst -o $@ < $<						\
 	$(if $(KBUILD_VERBOSE:1=), >/dev/null)
 
 spl/u-boot-spl.ivt: spl/u-boot-spl.bin FORCE
-- 
2.43.0

