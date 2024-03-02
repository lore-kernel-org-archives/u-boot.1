Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E48C54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 22:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E02C87EB4;
	Sat,  2 Mar 2024 23:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N/xIEreh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB9487EE6; Sat,  2 Mar 2024 23:01:22 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB86087D37
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 23:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412ae6392f0so3180565e9.1
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 14:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709416879; x=1710021679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHzFY8qbmWdoS5CBznit7JNJutnVJku45yYXaQ3eM2A=;
 b=N/xIErehAOzwr/xnVYjD33hp/G/ruXj3e3AW4ggTa7cDeQTdYFSJ+VuALHavUozRyS
 cMndZiRakRqNT4fFT2JNic4AWuT0KDMAewA9IVB2IDMYu3AczvQ+KkLnt0lrLWBqCEMa
 P7z+Dy11gEXtNElw+YNILFHTcs7kgFE+OcWvtFNbQ1T99atscHDgRRiBIwiYp37GEcdD
 tQa/WvH1af4UzBFYC6zZmJyOnLV+Sqjlf25o6yC+Y+CFzlLfzm3GIDE3FVoa2wkNm69f
 r0uHdBwvUJnnYZ9JT1f+t9l9OhFHXpRyQVZp6ka3irC/zc96neGnfbr2Y3YqUvCaYhQh
 vd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709416879; x=1710021679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHzFY8qbmWdoS5CBznit7JNJutnVJku45yYXaQ3eM2A=;
 b=H/abx0zBxdpR3dY7PRAtrSi1r8PphuB72n3KvW2ffRFpmPq6oDWfb0XcR3DsT4j95q
 uk+nFZ1dlxx8wN4KKHE1kTfx/UREpsdrF8TIEIc7wP5bBKxfAEwIRrF4pr7iko7KBPTE
 8mxKqLMoJmEwMqdTKE3/RI9D0ncsq3hPYDuC1ZwI89q12XzT6w5pxgAjsXHpAETl7rM+
 oiN90Ix1bKg6SeWOtd48+OG85peWyXpHZTQBnSDRYL0f64eehhna/AhlJFVQjxJiXXQD
 C4sODI2e7eJiWMktB5g8LW3EzqpC1VH3lzF1l+36As+jZbxx3LAUmaTbsF8jkDX0+zN5
 vmfA==
X-Gm-Message-State: AOJu0YyHO5jVaezyBoTB2DPqTQPPv6EBd3S5CtYkbWt2QxXxX8Bwge88
 d9TGDLM5hMhHBQ+66Vlzk2vLNlZyiH+RsvTZsXP9hg+x6wxARexTL7IFpz5I
X-Google-Smtp-Source: AGHT+IFOGARaodLUuNgDUGWhJYkvhow62o4cWZ+kEKgNo0usMMdrNa0s2TKYo1lO405M62UiQpesqw==
X-Received: by 2002:a5d:4d83:0:b0:33d:f60e:21db with SMTP id
 b3-20020a5d4d83000000b0033df60e21dbmr3584341wru.5.1709416879403; 
 Sat, 02 Mar 2024 14:01:19 -0800 (PST)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 co2-20020a0560000a0200b0033d96b4efbasm8427912wrb.21.2024.03.02.14.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 14:01:18 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Roger Knecht <rknecht@pm.me>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/5] cmd: optee_rpmb: build cmd for sandbox
Date: Sat,  2 Mar 2024 23:01:06 +0100
Message-Id: <20240302220108.720637-4-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302220108.720637-1-igor.opaniuk@gmail.com>
References: <20240302220108.720637-1-igor.opaniuk@gmail.com>
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

Support CMD_OPTEE_RPMB for SANDBOX configurations.
Test:

$ ./u-boot -d arch/sandbox/dts/test.dtb
...
=> optee_rpmb write_pvalue test_variable test_value
Wrote 11 bytes
=> optee_rpmb read_pvalue test_variable 11
Read 11 bytes, value = test_value

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v2:
- Applied R-b and T-b tags

 cmd/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a86b5705174..8ad8c0c542c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1370,7 +1370,9 @@ config CMD_CLONE
 
 config CMD_OPTEE_RPMB
 	bool "Enable read/write support on RPMB via OPTEE"
-	depends on SUPPORT_EMMC_RPMB && OPTEE
+	depends on (SUPPORT_EMMC_RPMB && OPTEE) || SANDBOX_TEE
+	default y if SANDBOX_TEE
+	select OPTEE_TA_AVB if SANDBOX_TEE
 	help
 	  Enable the commands for reading, writing persistent named values
 	  in the Replay Protection Memory Block partition in eMMC by
-- 
2.34.1

