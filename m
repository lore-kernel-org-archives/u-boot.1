Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CC0C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8828982BA7;
	Tue, 29 Jul 2025 17:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IShW9Nuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0160E8311B; Tue, 29 Jul 2025 17:50:51 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F7B81E14
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso56969235e9.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804248; x=1754409048; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O1cnVQXuFquuLL5bpTvy6+/d6gfzbcSnL8NYj+WP9nM=;
 b=IShW9NuhImu/BSK5NA4Srs5hg/L5ywFBaCBg3n3Zl/8/PCluI2CNWha+bjPSNvWHMK
 ym0MPe10jsMYm+fKgA1UxTwq3Ojsa9GBYDqj9f9/3ggbzRwtHc9oiaI6JxeN1ptm2rLw
 /NL5jdOCJ86x+wFXkieGUbg/s8+AZRFTP4Ui/6Gb0Zh+6iM5fe/9868bVqi6Ntief10F
 gD9QM5nMrvQPaFRJ1quUKIS8Wn+5J/KNK+DdamW2hcFakLsX2pvOPTSYfKwaoySFMry0
 5aj6iVBhdcKfI2sCGq0ZBybPfo3sfVWVCxp7RmlXnzE0/nXqY8788eglAe+LV5o6+hpq
 JWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804248; x=1754409048;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1cnVQXuFquuLL5bpTvy6+/d6gfzbcSnL8NYj+WP9nM=;
 b=JhSe5QB9UXf/7tNpCKaD9nwF2qJPG1hCAtTcUMYH13T4CWwsm7KKwzkQ1VSwP4FTR9
 Pa+QmFSUa2fWMwWl+mxnX4IS6tJiU8Zy5U/zeZ7Shj3OiknfZxyvYUoDcf2eq/UcLGKB
 ho3BP1NlZgOgQ5BFToQCKYK9EAaP0cQzFacci4sZdHB7ea1KgKHH7crsUQkVpglgs1lO
 PUoI4rdAFNNdz8UtTZlKDyhEh9GsXLqM45l+L6ojbEc8ObrIr5tYIGp2gB6zPqDsgSz/
 racK/acOc/xiso9cQrQwvd5l1HL9aE7++GXSP3NQHOD7rukiV+ra+v/KxO6W3kPf7aTU
 1XOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA6buSiFOholPxZSE/014lrXnKPJwwcyRUnHDTKR2Qa3Qor4OjbPffetPJA/7/m8cO03+DSUc=@lists.denx.de
X-Gm-Message-State: AOJu0YyEls3RfBjDQnZamaZC2AkrPl9yYRHidT57c0rew8iqGGL1G3Kw
 oa0MlF6TRV5A6f982uBaAZOL4x4kYBQasYR1y9W5ms72vaUwoee/P2BcsYTwt9/ZsUXU6O8tV8x
 qZbTN
X-Gm-Gg: ASbGncuqQGbCNT/L4IlvM4S++HSF4PAKCOTVw3HVKc5neHugYQ6z9SCzsnCuEz7GWk/
 KwgRbOrFAC9/1GaG5Z7xokQPY9rrIYHMNdLKAAE/sGlR+/8A2aKmm/58MSHPsjooR2SqxPnvCLa
 9qv9Wpf8D8yLCmsjDt0P7Nb1o0M1cZstmu0niEujmKiZsoIKeQZL+sES2CsF4a6eBErnc57h7A9
 uqngBkLIG/C7IkWPRJm/WVentThEUXlZuix20lazuc6h3HN3A5o9KO9Ftb86pSCoF79qeTYvqLe
 6zncO8LSNtnKlAIDjvrrbyHW87OQtZNIN/XOupMv+J8f4AxSPOa8JSmSjxdgjxF0wMcemJfK6rM
 SEmexJ+ovrgWVpkaiCBr8WFF8q9xH4PC9rxudPWzTDbTuDbM3em64Qt391crzdX4b0fqqZkpSiZ
 kbLXuvXV/YUkOlPGDIeB7t
X-Google-Smtp-Source: AGHT+IFbJzJrzbQv4MKioL82ogbrQHke6mghaLFK9uKunE+RoL63adnOaIk1l1/tqr4qOIOqWTxEdQ==
X-Received: by 2002:a05:600c:c04b:10b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-458930a2e8fmr372055e9.4.1753804248449; 
 Tue, 29 Jul 2025 08:50:48 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5c1a2fsm30635875e9.12.2025.07.29.08.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:50:47 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:50:08 +0200
Subject: [PATCH v3 10/10] qcom_defconfig: enable framepointer for
 backtraces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v3-10-6f258b34fe8c@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=896;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=qbtQg8HJtEug/f6yeDjkin1KAD+HjGh206UQEHqDWKw=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO2rIOhzs4u3reqkMp30Nir0mJX+/CHYsJvPg
 NUBGWmYqD2JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjtqwAKCRAFgzErGV9k
 tq32EACJg0wrs3EaKUiUfFN6ch3JQuW6QOShFgwytcBCwQy0oMlR/+7Jv7NIy+Gi7RMRIrluIcM
 eJclXYezuurmZ68zi5wzfTbkHBfAnjJeKfKcBIoNIBDN3g3KS8B8XokxM5VPba7P3obZAoXOfuW
 R10oq/W7OxKHGZGTEB7VSUiU7zFZDhRt5ReWZk+OqR9mng+t59JEubq8xVoZ4yB/TQyVavqW/Il
 p/dUW8olSa0FqXRGer4aGBDQ5WQ3rJb4FlWNlH2gTkZ0jgdrPf+AOQzcC0RTEpnhxA916Roz+qm
 d3KQGei61sWYpoGT4JkSgx8TPgzv2gBy9YLIysJJhusF4vY1lec11Wnp1DZZVxPiNAe9oB5Zje9
 X5AKHjhM45+gRuBupsuSQkYr+lgZZJjkwdiIe3GZipEGgfHq9FG4Qq19MZXNB1TxkapeYVnpBVH
 cESE3RDTXPyBxcganvD7Mmm73wsK6Idm/ZGmJGzXDjNQnlyev+6+ErmA8j40PZRb9EjaAY/yZRe
 QkggRae8t0gVxeY19jo0mz1vKK72xOVjIrq3adY0jHEVegDC6aeifxrOsqSWf5m3Yr/jQKIAaqk
 WgscH5sNtNhG9OUdx5/gvGGYpgzevYY/h93uyZ4SW0RV3fEMW6TklPEL34T0I8WkboYYnxgesQj
 qTb1SrIpBllX+zA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Enable CONFIG_FRAMEPOINTER so that we can print backtraces when an
exception occurs (or manually with unwind_stack()).

This helps a lot with tracking down what caused the exception.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 86d7de89e7746e33f4385ca78c839b43319cd861..9036c39d637eb059e340b1b62675746a21cbb1a6 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -5,8 +5,9 @@ CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_NR_DRAM_BANKS=24
 CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
 CONFIG_SYS_LOAD_ADDR=0xA0000000
+CONFIG_FRAMEPOINTER=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BUTTON_CMD=y

-- 
2.50.0

