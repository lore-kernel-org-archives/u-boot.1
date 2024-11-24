Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3410FD75E34
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02CBA895B5;
	Sun, 24 Nov 2024 20:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ggqO1Nyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 504298958E; Sun, 24 Nov 2024 20:17:53 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47E24895B2
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa4d257eb68so702151066b.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475871; x=1733080671; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+OTbGvErowKXK3MSvlRU9/eK38YsCQAJ5+qw4mqKLK4=;
 b=ggqO1NyigPb44zwYdjfoUZko27gCV4M7JA5cOIx2vgjBFEKFmtdtU/21213TBiGT2e
 j+fckrDYLeyXDcE6P9yxP1xZX4vM8/l+l9nMBpGxCtS9FWoI8rw5I0FBf0VMgW+yxEKO
 zkCn1unMsKrTYqOY1jzcLA4vlIbp7JPkMl29VDUqPqQC4/N5srR5WMzhgZ6YjBVrovB9
 wkrl8J329ZLElMAwO3LwnI4amhf6FEeoTPZgLA1SW6F9qm3P5HZeCPgooifyYIpxFgVd
 XrVxURL2cr56TWqadLVkfRqAGY3h1O02a/FMXuvfCizHFWOPoEJ5jXMa+5fMW3se38RT
 8xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475871; x=1733080671;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+OTbGvErowKXK3MSvlRU9/eK38YsCQAJ5+qw4mqKLK4=;
 b=CrzLjq3eTVwFaVGmoyDyvRmWUxx9Yd4R8r0TBXywxhFc7YRDkapbZGKUxkK7l50Sqn
 cK95L9sHwYesVFtSATXrWuj/BfT9Nt9AMtx1axThNrksN0dpmIFoCKsT1uEzZU/t8NPf
 3jaRXGUDWdaBW5WRv8iVcjtmq6l3dWEOzCBza0eUfhSzQB/+AMQ8+qhh+uv00iwtbnCK
 zn8QY7oBqWLNE8r84Lb5Xc4LHb737jk++8MRgboZenylYwCbZRym/JBxFRbD5ANCIbE5
 /WqPbhtYeWF/jLIrLKvEPpaHI9e+e7S7j013rOjnTKl6XXMfeIjVcIcmpCjNkr8uLcbs
 yAXw==
X-Gm-Message-State: AOJu0YxKmO2QRAok7jg7Qi7YJokKYlWB3UpfoZfCgfhVlICAEZ9GEH9u
 v2U5GZk4sPGLvvYztZJbQ4qeuBHct8ZPuu+IZdEWCEIogPGF7WR3i1cNYCD2a+Y=
X-Gm-Gg: ASbGncvYr2pCBI3+oAT7jjX/32VxFQCR80u2EmqnDrLlWZ5tPlqgZ9W8F3WTtg8ktDj
 Wq221UJJtJgDrzx169mnXDX8TCdY7Lu0d+tjcB2qbXPj5OXOVFuIEGlOPRjs90YpNKpYsLhCeet
 imgEtz5KEvAtyAXHeobLN7RGurykkQY06BilcQQdittJldO5CwvJZJfvlldXnSUHzzkx6hsjdtA
 qmeRapjDPsOgghqVCkhw0FXG3jaHgtwF+sakkYyLSU4wxKF2g6c/WxiHjIlN6JXwAF7
X-Google-Smtp-Source: AGHT+IGWR/Ld3ggnNU1TwgdEXNfA6qco3QG1dfNbtdtLIQBYvO1yN/W+3Txt5wJ64ydNYBanJeE2aA==
X-Received: by 2002:a17:907:9622:b0:aa5:4a38:174d with SMTP id
 a640c23a62f3a-aa54a381849mr246869566b.29.1732475870754; 
 Sun, 24 Nov 2024 11:17:50 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:17:50 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:46 +0100
Subject: [PATCH 04/15] Revert "drivers: smem: sandbox"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-4-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=t8/nTIl8Vup687vgc5fbWUSkZ0ZrFTPTE0N0GbnNtYI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6htzNh77ovJj76NyD4E9Mb0O67smbnQ+VrFH7+b5+
 u+NhsvVOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEDlQw/JXPl5RY++56zf2P
 ew0v1ri18a3K0uFyLdutVGex/MZK12JGhnner8qnqMhv/3vt5OR3DpaNuk7fbkx4Yx2Yy3ms6LH
 WbSkA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This reverts commit 7fd7e2cf339ea2ec570f6dae1cdfaf8e066eb4af.
---
 arch/sandbox/dts/test.dts   | 4 ----
 configs/sandbox64_defconfig | 2 --
 configs/sandbox_defconfig   | 2 --
 3 files changed, 8 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index dee280184b1b..1c1f148d5b5c 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1357,12 +1357,8 @@
 		compatible = "sandbox,scsi";
 		sandbox,filepath = "scsi.img";
 	};
 
-	smem@0 {
-		compatible = "sandbox,smem";
-	};
-
 	sound {
 		compatible = "sandbox,sound";
 		cpu {
 			sound-dai = <&i2s 0>;
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 7960b2ef42e7..62a4fb80e2cb 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -228,10 +228,8 @@ CONFIG_SANDBOX_RESET=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_RV8803=y
 CONFIG_SCSI=y
 CONFIG_SANDBOX_SERIAL=y
-CONFIG_SMEM=y
-CONFIG_SANDBOX_SMEM=y
 CONFIG_SOUND=y
 CONFIG_SOUND_SANDBOX=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SANDBOX_SPI=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 718e4a8283c8..1428d8e4b411 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -297,10 +297,8 @@ CONFIG_RTC_RV8803=y
 CONFIG_RTC_HT1380=y
 CONFIG_SCSI=y
 CONFIG_SANDBOX_SERIAL=y
 CONFIG_SM=y
-CONFIG_SMEM=y
-CONFIG_SANDBOX_SMEM=y
 CONFIG_SOUND=y
 CONFIG_SOUND_DA7219=y
 CONFIG_SOUND_MAX98357A=y
 CONFIG_SOUND_SANDBOX=y

-- 
2.47.0

