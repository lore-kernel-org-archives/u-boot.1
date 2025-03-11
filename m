Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D884C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E923281B4B;
	Tue, 11 Mar 2025 14:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d+xo5uuP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7401B817D8; Tue, 11 Mar 2025 11:33:17 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C4A8169D
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso8473796a12.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689187; x=1742293987;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1oxt4krpdlIfQwHEIFik+HURy7wl1HB0ssMUuz+OyxQ=;
 b=d+xo5uuPERsMfU0YHCbiAiLoPOSeid9c9tnbjnJFWMh3EixZjtRfhTWQ3f6mFp8EvN
 XmbfHUILhaaD5WB3WG7S05RX+uar1Hm44pYptZNYPWixj9t+X/9TdfokG1CwW6IPWf58
 q35U4rlfsQsU5r0h+gsjnF7N00SgLITHMIVEZR3pc+4WmzF1wpG40Df6R6Yx/SgKz0Im
 M9BFSLH2i/XAu9dIa1ZllMkQgefwPJuFWooWmVrfEFYT3z8wkwIlL/h46fdIW+xqDMbK
 2P2n9HAepj7YshFplF3X+pXGbS1sbcS11Goah4W0cmzQ1q9Yt662et0FFqZ0qZvFH/t/
 ZoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689187; x=1742293987;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1oxt4krpdlIfQwHEIFik+HURy7wl1HB0ssMUuz+OyxQ=;
 b=PlMBOz6QzjLhnMll3/r2axuvhf/h13ETF5FUR3V4uAb+ybBneU19MJGfRaraqVBfM2
 UCK7ljqlowAqjJa1Ypz6nsB+rp+6U/3Cr60BveEwT8F78AvyOy2GzYs0nHAlqCDZJecl
 r2VTw/mGewCBI4Y38FOw2ejD8IsOOzhLAAURJwW8PoUebaSRIraNYXTCm53avq4OA8SF
 3DhHyqEi4xdx6UpronSl7cXtCpBtTpQr+Tlo+jT5m+xxPC/bcVi5lxkmzyMHmbscPNhI
 jibknGUu3P5SsZnwdVRxUgqlR+ifvqZsFhY0exSdLaV/q4q7AtyNXF6SUJYtDqadYupA
 QZ8A==
X-Gm-Message-State: AOJu0YxoZ9mMfhfE2rwwY8aBxfidI5/RrQx6ukKP0SeE73G381qE7Q3L
 mT94+tHD24/0drYMcBeveb8NCRtl2kSrjriz7rsLY2UegFjt316tEvwa5+d3UaC8F8CUyEWgQYu
 8
X-Gm-Gg: ASbGncvApISZl6dPBPDKxwo2TvHO0F+ebg+RiOAsZrw1VNd8oE/884eHdHy8iXIj+Jf
 yWPyL4d3qNZL/lwvJKaG2mXSOh6NQr+nttxqo1tbeuHlZcMqInXt1NynJXyWhKVudpiEBUAmQtm
 jKbh6MlMwRIsaMsqPfRVeNNOlU0cjHMTwdRDkZWYeFhmkI3iSMNP4Q2YjHP21MECZzOQdbQ9sX9
 BV//X1EaJHt44gFlNIijId2vSj+y2Ubn17S2ZCgCRwJ5qF5wEiAPXjALoQvfn9q0zZgkZEk71O6
 V5XrF2UVZakAPqjRsPFcIK8EwaAEqikvcG0/GaDF
X-Google-Smtp-Source: AGHT+IEHlOkbitI20/8iwjtpjeClFSvaZ13qj5f4e1kXzyyRE2UerJ1BdlxXf3fs+W7Va5tJwUHTLA==
X-Received: by 2002:a17:907:c80e:b0:ab2:f6e5:3f1 with SMTP id
 a640c23a62f3a-ac2ba4ca8ecmr362419666b.8.1741689187217; 
 Tue, 11 Mar 2025 03:33:07 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac28cf931d0sm432545966b.95.2025.03.11.03.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:33:06 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:58 +0100
Subject: [PATCH 19/19] configs: am62p_evm_r5_defconfig: Enable IODDR resume
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-19-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=624; i=msp@baylibre.com;
 h=from:subject:message-id; bh=5LVhoSlDWOtTPg7K2J1fe+zk94LOltrT79psW4GV7DE=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCHo6Sx7vCL2vXBqelv9E+vDp4mz2ao6VTWntAQbdV
 VE6kts6SlkYxDgYZMUUWe5+WPiuTu76goh1jxxh5rAygQxh4OIUgIlUbWP4X9UgIRhU+HwBY48t
 T+FVw7zzH++vOrhX1mej8t63Lz/Pfsbwz8zS5FpQ5BVtL1GHoIVn5BocZ2cvjv4wNWJ54Lre7U4
 unAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

Enable K3_IODDR to enable support to resume from DDR after exiting
IO+DDR.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 configs/am62px_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index c3adfb8697a73198298e8e9d955d1f1829cabfd6..be580100d9f4d098f642db3b35b979ea10f96096 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -124,3 +124,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.47.2

