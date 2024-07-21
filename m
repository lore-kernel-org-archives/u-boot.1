Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4A2C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB1088370;
	Sun, 21 Jul 2024 12:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WSl+KHML";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E90881E7; Sun, 21 Jul 2024 12:10:00 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA35D8813A
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-368f92df172so1103699f8f.2
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556596; x=1722161396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4BSLL7mbwg4IHPX70BZtmCNRkg7h78Ln46WjA9w3BQ=;
 b=WSl+KHMLhC5ROsEthWruxG6FZ3/mLlQyLOf9WRLwej3nT255fK2OY3CoVPEmQB3q+C
 0LGD2W4Ucj6GDPxofDGOnq3mUUY87opPNRd40zjKsPXx8VW/Lqy5VvPcqLtMAH4jEo2k
 WTEE5P1x2wGRpsIPkXLoHa/aHdGY6cf7Swaak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556596; x=1722161396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K4BSLL7mbwg4IHPX70BZtmCNRkg7h78Ln46WjA9w3BQ=;
 b=jBVDRNJNACgfBza3Zs4odhFG36oPJ2yrvS+QUb7obIO3U5lJnmgUNW5MvtCuRBNtJx
 JbatpuldaL/bYfSfalLONkCGJjFP0mUIEgDm+b6XRvXZx8vybc7lUdwahTatMZw+rCp5
 faznyoSiiWbcDrPmdn9afIK+l7gc50tY2QcZ2hV9/4U97ZHX7fYoVWMxmE4pSU9RDgc/
 urosSD0Ihr8yJSnhq8pw4eTaB1QFNsJIKdbxQLALjctF6otSQzgm4vmOFnbKKv5+pkN6
 alZAdkDUAPcvAcan05ALe4guemGAXC/10Vb/1uVHyz6pLbeeIX6Or1/DECJ1V4696wn7
 9ISA==
X-Gm-Message-State: AOJu0Yz42lV8yGiLgRcuIPTvifhOj1elHhsJaw2j7w+TQSwDrY0c5Eyo
 RPqRx25uNOMdD/CtSB27egaFAqUjQdjA2Ha1XKBNARHqA/AMKjitGOgGKjUwTq+DDVczKBe0Hlo
 =
X-Google-Smtp-Source: AGHT+IGIYCgyCddgX/rBeXYYaFp3apG3ZY+YPiQGG7wk6n9Ik8hPDfS0BvbF4dL4xo8PExpoWWn2Bg==
X-Received: by 2002:a05:6000:1810:b0:368:57dd:3822 with SMTP id
 ffacd0b85a97d-369bae529a4mr2434613f8f.37.1721556596032; 
 Sun, 21 Jul 2024 03:09:56 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:09:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 07/21] sandbox: Add ELF file to VPL u-boot.img
Date: Sun, 21 Jul 2024 11:09:25 +0100
Message-Id: <20240721100940.3202027-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

At present sandbox builds package up u-boot.bin in the .img file. This
cannot actually be executed, since it is not an ELF file.

For sandbox_vpl we want to be able to run the full boot flow.

Adjust the build rule for sandbox_vpl to package the ELF file and
thereby allow full testing of the sandbox transition from SPL to U-Boot
proper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f5b2512f369..f364cd31ade 100644
--- a/Makefile
+++ b/Makefile
@@ -1470,8 +1470,10 @@ u-boot.bin.lzma: u-boot.bin FORCE
 u-boot-lzma.img: u-boot.bin.lzma FORCE
 	$(call if_changed,mkimage)
 
+fit_image := $(if $(CONFIG_SANDBOX_VPL),u-boot,u-boot-nodtb.bin)
+
 u-boot-dtb.img u-boot.img u-boot.kwb u-boot.pbl u-boot-ivt.img: \
-		$(if $(CONFIG_SPL_LOAD_FIT),u-boot-nodtb.bin \
+		$(if $(CONFIG_SPL_LOAD_FIT),$(fit_image) \
 			$(if $(CONFIG_OF_SEPARATE)$(CONFIG_OF_EMBED)$(CONFIG_SANDBOX),dts/dt.dtb) \
 		,$(UBOOT_BIN)) FORCE
 	$(call if_changed,mkimage)
-- 
2.34.1

