Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6C8C369BA
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 20:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B00682B54;
	Tue, 15 Apr 2025 22:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jgXRS2F1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B624682B45; Tue, 15 Apr 2025 22:49:59 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 138C182B3D
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 22:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so48135865e9.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744750196; x=1745354996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7ACoAnFin0+NaIJsTjXj6GO64iPv6oRILYAQkJCXQI=;
 b=jgXRS2F1AmPF/S9AXndisJrpLfW0pfi+Gyk00AnGAWbIn40gfAqlRMd8AuiBjKVS7R
 QsjTTMLesSw6i/iOEsubTYB28KsBd8urAN56oMcZKW3EnAKsy1iwI8L0l44/23kzZEUx
 nniL+qQPv/oFh4ZqwqSnFiauk9USRXhAVWyGr48whd4o7ZiOVTo2MuWgaZyIEFyuutKB
 8Zisftcvxc4y4ENRYEb2ABEFZhXoqmTPzrNQlZ50CXUASxjfgGwl1tInkMwSAAlXopEr
 IWOOphXQn9e2M0HOnNwCZM9b1eA9PaP4hfDrBVriPmFJrhllyrpH+NuGYZXwZIjm47Ak
 iukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744750196; x=1745354996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7ACoAnFin0+NaIJsTjXj6GO64iPv6oRILYAQkJCXQI=;
 b=TcfHKYYYvt7yOVtsR8wMmeO0JuyfXaKWnSpnTiTSfvzK8hItQMsvKOHNFIvcC6nekv
 jB4Fq8VXZhAFnUA8XP1922a1hPekyKHZf1QmR8LW/NYvpKrXwmXSTy4SE25RLvJSzqVm
 gX/+eB8AwgcYXlKMkMB0dpmSKGjkXlKWXTtTvc3voU4vhFK5SyR+DAN3DNdH3hWOnGos
 34ycUSun8D5U7U9iAsJ/c7NJohenp+8RLFuMUIoGtBaHB3dNUIllpmXEZ+iKAoKi1r7V
 OODraX8ZaWRE6/eR3WDs9LTxNvUS+AwfcQ3EjvF03n51mSBZn+8uCKN6yOBYqHXLlrkf
 mAkg==
X-Gm-Message-State: AOJu0YyZlnB3J8TUHFZWdNAZDx9m/sIAAEpIbFM24pWuAuumMNv2/VaJ
 /SYNdWxLA1TYxhsg7bHfg4nDvqNs8FB2cOkO3ZhM0BndmLgAfgXSAvs6X3aiphblLaq8lc3ham8
 gd64=
X-Gm-Gg: ASbGnctiJVya15sLCohVOVE7iTTSs7h6SY7tFM5O8w7naLa+4y7OlTyYEr+u8kieEVy
 flEByr1+cbhZVm2xIULIVPNi6CxUiayo6Ny+H6lP0HK0LCWpuXMxoJWOF+A9wBiNCCKk6QrnU1u
 oZOiGTi66+7bpUdQ/U+F5uk7lNQJeLwXTDWAq8mSSLwHrUP3Gi6Z3pmIGwNKTEzzqiavBPp1tsV
 akywQ3gom6SyvvlWykKI6ZBSaXjjyw+kxSW761+D1TKgzTwYq+5QISU1OGataVfGXEgxEfOGoUg
 01L57LYQ85PSR11teHKQqUdo0Mb60+dLHwnSb3PYvdVjXKUb
X-Google-Smtp-Source: AGHT+IGmbxWqS22dSuypIVm9tCxaGkPxlPKxpP0jf7dK3IM8TL7XQk4isHjiCqkBAK1o6/cIXcoc1Q==
X-Received: by 2002:a05:600c:1d08:b0:43d:1840:a13f with SMTP id
 5b1f17b1804b1-4405a0f6445mr3198425e9.25.1744750196260; 
 Tue, 15 Apr 2025 13:49:56 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4f3ed7sm617675e9.24.2025.04.15.13.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 13:49:56 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v2 2/2] qemu-arm64: enable UNIT_TEST
Date: Tue, 15 Apr 2025 22:49:03 +0200
Message-ID: <20250415204917.1250109-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415204917.1250109-1-jerome.forissier@linaro.org>
References: <20250415204917.1250109-1-jerome.forissier@linaro.org>
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

Enable CONFIG_UNIT_TEST in configs/qemu_arm64_defconfig so that the unit
tests are run in CI.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

---

(no changes since v1)

 configs/qemu_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 6c9d2505a69..cd9a4f2ae26 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -75,3 +75,4 @@ CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_TPM_PCR_ALLOCATE=y
 CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y
+CONFIG_UNIT_TEST=y
-- 
2.43.0

