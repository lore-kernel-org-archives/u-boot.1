Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEF7C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381148882F;
	Sat, 13 Jul 2024 09:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jJChLC7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27FCA88817; Sat, 13 Jul 2024 09:03:51 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D2D088789
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ebe40673e8so36985491fa.3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854228; x=1721459028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4BSLL7mbwg4IHPX70BZtmCNRkg7h78Ln46WjA9w3BQ=;
 b=jJChLC7qS89wrkwgK2uUO5XOW+ZHnybQXcrfAYDNVv7OS7Maa0neg/xHF0uub6bWqa
 suCBAM9r20IWb9V2PqU2hJUiotCXLIVtrfEyAf7gTnjUg+O9firsYv6VCVfhvxsVPTW7
 JPKD5eD+qysjogKL8704NqildX8ZsZsfcIRs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854228; x=1721459028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K4BSLL7mbwg4IHPX70BZtmCNRkg7h78Ln46WjA9w3BQ=;
 b=K7K0gpBZ7BHwmH+ioApQFneX641bN7iyyKVo0PBhPB3I2Clkh54qHUxdR4qfWbUDId
 yDktT5YO8zqvQRpu1nXjt41xmLC3nDOtOlVsGj3s3zFhv1CXuXBdK2wILSDWVIPWB8wr
 Ep5+L04weuHvijmFCQZhIKAusnV0inlyy9wESPQKyYY8C2+fSrzmAKrbzVTbEgkQlj4I
 IoFiTxaQwdft5ILPi4OaRoP5gi6DzqRbNPWZxFbBywe+e0+uCUaPWBY4H0I36CDiXQMn
 S0ChxCEUSJNGf17elIG/HDTcxOJ1GXzdRNndYjSvAMzHQNE/gjLAWrOlI0cdorwoRJw7
 7fRw==
X-Gm-Message-State: AOJu0Yx9jz5HfVshAGr85nexXWGrUJSUbbvl/6ancODOvf5NZn1HWHbp
 1ozZJ+6rk9K2FCJUvHVOH58RZELKLZhH138kVjsPtL9AGBxes4tMyn68UMFRSARCk2LhfNoDyik
 =
X-Google-Smtp-Source: AGHT+IHi+l6ZUvxeacxZOVdpaQKjCHyqD76UCV8BV/EkyHzAZl/SvStqB1qTY7Y3Urh4aqSTMuiBPA==
X-Received: by 2002:a05:6512:3b82:b0:52c:dba6:b4cb with SMTP id
 2adb3069b0e04-52eb9990f7cmr8950292e87.13.1720854228111; 
 Sat, 13 Jul 2024 00:03:48 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/21] sandbox: Add ELF file to VPL u-boot.img
Date: Sat, 13 Jul 2024 08:00:42 +0100
Message-Id: <20240713070055.2172883-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

