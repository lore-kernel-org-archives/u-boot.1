Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714D1C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E1C18304C;
	Mon, 23 Jun 2025 14:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oqSfnUrX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27F3E82977; Mon, 23 Jun 2025 14:10:59 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 362EA81E13
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ade5ca8bc69so703418266b.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680657; x=1751285457;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5Jwcq0ZFQ4yqPzOvKm9Y32mOyZbD8QWC9T5XoeC3gmI=;
 b=oqSfnUrXRyIH7iH7++lRvNaCuP4iuLBYckTxxsLQaWd62H5R5WNAwzo35DrYZ2YyFi
 f4gI89R4BWtQCZPdOHeBhLSN28ZtUIrLBiJTaIePdEx+UuSi7ahfkRiVIwAdlPYTZZkT
 q4YmF+x6q+MX8ipQbJLaIw6It35zkCPDliuodt+F8m2M7OUFfOfBkJfljq4pixVypOc9
 oaZXPRO/tmLF/l80U0Ijd0cM4cbMkTmw3iWL9zYjd5skWasTr29JPxqUUGfaJpSoU4Ua
 F5KT4DTxZ6Qw7RBuMM2n6K+iorcY7r01U+Ij9dBi3I82uwicHFo6eXtAwBjACQDTHJqA
 ah8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680657; x=1751285457;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Jwcq0ZFQ4yqPzOvKm9Y32mOyZbD8QWC9T5XoeC3gmI=;
 b=jaOBCT8qeLZS9Dc/sC1C/mXkj3DRlmqWESmSv2LFKVJw8ombtBWjMe8PsWrZw/MPI1
 ju8AntuJN0JC+X9lfhtBEYQ3tG3XZxTaymJ5u+xhsI+zfaw/pmB2X/AdhmDV+ql3l6rt
 IvLSktSRDGNKtoMh3r13x0LZMhW6Vl+WtFa7YFSMlItYJW0ooM3kLymEYuyJnG7MuNgL
 Clo4s8QtbGm/UX/A5VB7qN7ftJYOwYPgvSpL5i5ChiNn1Vqk5VkaefysZH8zpeVvxPW2
 SAnaRxKK3+PhSF6KVIap3URNWPIh8kgXRvy3q8S5bbYvTlFSCjz+2xLzw0U5egGdfZK9
 RiNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj1uO2DbY5n7XowkuVY+0zoG/UbXkXtDH4MlhgYv4nqKNz/zrJ8WX3t/2kqYcKiTvvBrUd+fg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2WO2xZvwBCCpsKXOJz76Dbi5oJYwCDutMRut2ykHsF5uUPL8Q
 MmEWYk2iWCSnmwWMGTq/ZFc50rQ9GpvUFdtPJPsb9lJmLXPEpnPPawSzHWa5j8eWTPU=
X-Gm-Gg: ASbGncuec3HujjHdhtlRKVai9nyhFHgXkTOKK5DBUrz1pkEMz+59MirW+5lxGQvJavr
 x8GXNLK7iM0NEm33LZISKOM1+4qjdWkREMM/PVieS7qGd08hgwe/6bR/m90uMFgOpl/QpYl86UR
 n5R0JvHgD2V4sEt86X+uW22wm9HpvSZrWWNQFyz3ELVjdHjh8iguN50OK6wPJ1EBcRkJuffZlNf
 CoArdZ8nLwZ7zEoX855FD79COsJdAueYeL2ozycInyVJ2kRV/w2dBpiGyYrynQ2Jqf9e4mjBZV8
 wBXlbWd6Mw3dTLd7zS/wga/y7AlNmur8vUp0Hw4SKnbb/Hm5KUOvvAncYQznkSfrfyfdZg==
X-Google-Smtp-Source: AGHT+IENGYNvyZTP+47WL5xwcvVv13N03qqpO5lO1oCkwdRQKFoc4uhLvn3UeUQGNtdB5o+UEOYJ8A==
X-Received: by 2002:a17:907:1b29:b0:ad8:9909:20a3 with SMTP id
 a640c23a62f3a-ae057b41278mr1093581366b.43.1750680656649; 
 Mon, 23 Jun 2025 05:10:56 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae053ee4cdcsm712892766b.56.2025.06.23.05.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:55 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:44 +0200
Subject: [PATCH v3 21/22] configs: am62ax_evm_r5: Enable IODDR resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-21-a4da322c16af@baylibre.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, u-boot@lists.denx.de, 
 Kevin Hilman <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=624; i=msp@baylibre.com;
 h=from:subject:message-id; bh=i/EaWUTIDf9kyh1YXKjcJg1sXdpLMeQG/XK8eXUZhV8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxIF/UXq27wLzum5pjoFSlzoSgm8duDHUJn4hZXTPAvi
 dXm37u7o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZyT4uRoeP3vX7TEg5D+b2f
 3x/8Znn/htGEmrt3kpOXyK/wOOW37CgjQ1s5y5bYWQnHcnk3H/aaYrrCMHkN5/qMv3nxSzUefl+
 eyAwA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 23 Jun 2025 14:23:35 +0200
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
 configs/am62ax_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 52df6e0ca3f5ce9f5b6e8d85196bd71e31be8a83..eddb9e8e31da403e4b7d32988e07d5d19671ad8c 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -105,3 +105,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.49.0

