Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF69C36010
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 00:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307A680F6B;
	Wed,  2 Apr 2025 02:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CdYHuhjw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D282681703; Wed,  2 Apr 2025 02:37:44 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B5C580584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 02:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-47662449055so32204861cf.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 17:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743554261; x=1744159061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LmJJadXXjOdk2V4GsoMtIBBdB9r09HpTMANIWiRC61w=;
 b=CdYHuhjwz+wN4dPu1+hKcQJFZl6mKMAK8Y04me5VAZngyHGlsenKcnlv6G5UtBWDHr
 Dn94oPcUbPpm3CdpLWrdPjnjb/a+WovFChfPrj3HWuWuFuFwMcclIFpKaoCnkk5Bl6z8
 e6TMoUFKZetf/8N/cPbGoX315DYzPeJkj5E64+P5UMYU1WAoZemhcK25jghq0Eq97IIr
 038yUFSG8mkDjosbusGCyH69c3w6YNwgaQR80XiScYCIBCpmJtObvTepPZ26jZ440nR9
 XLdPNhtFx/EtYKkcPC1SF1SHQGmzDVpLnxvf0aNl6D+6+mlPxUD/pYcSDW8aQ0ZR+zdt
 Zwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743554261; x=1744159061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LmJJadXXjOdk2V4GsoMtIBBdB9r09HpTMANIWiRC61w=;
 b=MbG9wO/upeKma1wyD9H2hMVF7pxAcdKo0Ho5ZBxZD8a4yZqxR7tNXKFrQQHw/p4/nS
 WgNK3J/2VIt52ZqPhzBPffcyLiwZvEEoMuWqdA5S1m24CQWGwKZSvSL4lY9ezdDxpKnN
 c7O3Swof2dbqIvWX+FOlhMG1pqXSBmb26KuKlYIVjymt4USREdJOL89IWQSP5rI/3hOJ
 jdcbN5DHFYnSo+Dav3PKVqWCOkSsTBP/fg04QxOJtsPt9twZYwOj7+dVfl1CIcKWvhEW
 UQcrNxIKA5bxWaW9FaFyL8oQsW6WG995bJnwt1WGBd/Y6K9tGRUeirA4Y8nPA5gWL/vu
 x0CA==
X-Gm-Message-State: AOJu0YyFD/9/lDJ/ntcrgO56V9m4dTURKc3BQCBDgdlUW8+793k2pmGV
 g5avepC+ik3TGyBbaYp4uYrD4MHtVDt+7voRK3l3r/cWSV9QGnLXF5TPOOqs
X-Gm-Gg: ASbGncufQq3EJ7jlsXvQkZJdX+wXaJ91jdRzEWx4tYaBxvig5IGLOvczkdvtlb1arR2
 WHuUzjkheIE+tXj7D6YkKbkXk0g/x/d8TFxXd29/pvXuv9hhzw1ctqrTqXzsHRTQC9FhK+s+L1f
 eHHOTheh4+vphGlSpg0ueNupKr0fS3RVH3NsW+/0iCLZug8zZqagDy5j0QDVepzUyk43ZVY+Fr6
 qmXFtc2ufHdFX2xP1x9vZNjGfRqFunRuPdpnDPf2AqoWwDtMLv0TJ6GM3PyTdfu6CPTWeZ1BNJF
 jkkuAEmHlrk3rrnVbclC4ZqI34CF5lNS9cwfN1uz2rBiKyLVZMDu8ZvCTRCLkynpopLwaewqPD2
 yZKF3g40EH/PJZ6mFEPuh7IIzeA==
X-Google-Smtp-Source: AGHT+IHl+++r6NOsvu4DYMks6ug7Z0OibWiOPi5EwdoRKQ+59jhl7S7NNX04vFJ44kMZ3gXiAS1How==
X-Received: by 2002:a05:6214:1d2f:b0:6ed:12b0:f181 with SMTP id
 6a1803df08f44-6eed5f9c369mr185421546d6.14.1743554260831; 
 Tue, 01 Apr 2025 17:37:40 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net.
 [108.26.179.17]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eec967136dsm68270726d6.68.2025.04.01.17.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 17:37:40 -0700 (PDT)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Jesse Taube <Mr.Bossman075@gmail.com>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Richard Weinberger <richard@nod.at>
Subject: [PATCH] common: Add CONFIG_SKIP_RELOCATE
Date: Tue,  1 Apr 2025 20:37:38 -0400
Message-ID: <20250402003738.1241719-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.49.0
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

Add a check for CONFIG_SKIP_RELOCATE in reserve_uboot to skip the
relocation of the U-Boot image.
CONFIG_SKIP_RELOCATE skips relocation of U-Boot to the end of RAM
allowing for systems that have extremely limited ram to run U-Boot.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 Kconfig          | 7 +++++++
 common/board_f.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Kconfig b/Kconfig
index 6379a454166..f518768615f 100644
--- a/Kconfig
+++ b/Kconfig
@@ -443,6 +443,13 @@ config TOOLS_DEBUG
 	  it is possible to set breakpoints on particular lines, single-step
 	  debug through the source code, etc.
 
+config SKIP_RELOCATE
+	bool "Skips relocation of U-Boot to end of RAM"
+	default n
+	help
+	  Skips relocation of U-Boot allowing for systems that have extremely
+	  limited ram to run U-Boot.
+
 endif # EXPERT
 
 config PHYS_64BIT
diff --git a/common/board_f.c b/common/board_f.c
index 99616fdac80..d51696b8eda 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -476,6 +476,13 @@ static int reserve_trace(void)
 
 static int reserve_uboot(void)
 {
+	/*
+	 * This should be the first place GD_FLG_SKIP_RELOC is read from.
+	 * Set GD_FLG_SKIP_RELOC flag if CONFIG_SKIP_RELOCATE is enabled.
+	 */
+	if (CONFIG_IS_ENABLED(SKIP_RELOCATE))
+		gd->flags |= GD_FLG_SKIP_RELOC;
+
 	if (!(gd->flags & GD_FLG_SKIP_RELOC)) {
 		/*
 		 * reserve memory for U-Boot code, data & bss
-- 
2.49.0

