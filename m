Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE1ACFD364
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E5583F89;
	Tue, 25 Nov 2025 09:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OBUjGfkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2940283F20; Mon, 24 Nov 2025 23:44:38 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F204683F15
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 23:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3ec31d2b7f8so1306567fac.3
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 14:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764024275; x=1764629075;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UZNNaqfoAEAMZAl2J2dTVjuSG0L6A0yijuyQNnA68pA=;
 b=OBUjGfkrTJU6QSTaxtWa1ipLHuPs2TBpgBczq0hiomxnimwKaiZmTYscZZcoXTrYax
 CGt1G05JhF4HD6oLkh43te4NvElK/F4GiNujFuRn+Hlgi5DcHFAbyvyFDsrsFodxezWd
 YWWcUz48oeBF7McdplLm6kS39erLn4w8zs0eqPT7mUXjZVQ6gAyinywzEMmx8TBl7AF1
 sfTVGp3w7C0DOocMFVA2+PvKWPWlP1U5zCPUFuIYa0nwiN0TN2tCWpZm3LanDWfXb68Y
 XP+w9cVJujhYHwaf6wYO0L7+pfjCH9RVlu5HpY5/beM76+3996DICvKS9ho5R0r7EmwS
 VLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764024275; x=1764629075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UZNNaqfoAEAMZAl2J2dTVjuSG0L6A0yijuyQNnA68pA=;
 b=Ja4RkHbs1QlJzBeWTY6c9b3Pbhf/k9L6UaZou6pDFDS/0ZZ8Ry3knE6+DKolrEDp50
 k5mwTPP/jT2cT1XQniGSSTBj6NMMnjPPPg5FuyvCDWoOwgixlpTlIeUNMrKKLx86FGdl
 UKLlsBUO0XZ5EstfnZPxmMuUQucjWuMY8F1at1mLBuMZ0Qe8KYGILj69nJJ7v5IIWqrK
 5/zcZfnxCyUhs82awpsXeuf1qDblesgWRRPXfUEiL4XpOGe27+eCUGamen6b82VT+/Gm
 s/xBFiO7rLALoPDWPW1c9WrlsfsDmPeWydJYyle4bW7AGCeF4apRcgxnCRFJJrXQ3kz3
 gZcA==
X-Gm-Message-State: AOJu0Yx5olqeVHwAct3CyGovFk471jCT9dFD1Myq8BgYWFMIyk/6gvRU
 gWxuCzLlud8S2uY7vf36ylokgLTf4FjaTxj/fb6E54GY7pDzqJPhnRGV4ELjDGoym0w=
X-Gm-Gg: ASbGncusfiON9leQe5xBl8cEtwZ+nMYazUMiGeiWQQVI4VFvDvTNoQJKJO4NkBsDr8F
 R034JMvfRRLH2PQvdFxwTuHevStj5aU2kvWWO9eO8yNc42TJ5aw2oP3hSdZpdcJvZ+BWB5C681e
 ivYED8M9AE2tMi8ilNHCwG9cfXzfPWYcz2z89Vq9RLyqf7JCn+wWVVA2tcKmBuKqV8SDmvIpZNH
 wlhMc1Q5nwpXJ0qnvn+vZx1j6LqZ+M5z1k85hBv95cG/CFVqCMIkecfuNFjdLznD3DquCLVjxd+
 p6k+Bv43/5lFFR3/JiJgZQ9HlGcS82vAPrzdrpwjo5Bz+YCgaOVjrTBH8fUOS94dcqLYS2oCRh0
 I8AC0w0ElA036OGP5i6ff3+fSt6/B/fbtYtvGy2HTwB+Np9m1EMkFS1FxAoQ7DlvHEWKUM1v9qd
 iWX11l2hTh7VpOWw==
X-Google-Smtp-Source: AGHT+IELu2lTfnL7T1fPlhbpwZSUwrhD9dZCAutV4oW4p6H6csxfVqYIMdUoFP604l6wQMMY0U41cQ==
X-Received: by 2002:a05:6808:2e48:b0:450:d1e8:6f5d with SMTP id
 5614622812f47-45115867592mr6348668b6e.5.1764024274707; 
 Mon, 24 Nov 2025 14:44:34 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8a36:4d72:5018:118])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffe65e6asm4095918b6e.6.2025.11.24.14.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 14:44:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 24 Nov 2025 16:44:06 -0600
Subject: [PATCH 1/2] doc: pytest: fix hook script environment variable
 names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-doc-pytest-fix-script-env-vars-v1-1-fec5b54007f1@baylibre.com>
References: <20251124-doc-pytest-fix-script-env-vars-v1-0-fec5b54007f1@baylibre.com>
In-Reply-To: <20251124-doc-pytest-fix-script-env-vars-v1-0-fec5b54007f1@baylibre.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=pSfznrZkSITmrUmfrkYy780Y8Li0/1DS/N0/zzIrgaQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpJN/BxqpB0YC56Qc9s5kFOV+b4LE2k6JZ0bDZ0
 5baV8fzTPCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaSTfwRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Azq4H/2qXgqg4lF+jZks8LJfX0Zna7C5wkiuRCMu8uh2
 4e0Ry6yvJjq6j4RExPhag1S8l0+VQJMKs2NLHbpfFfDauXcY/1TQYi0q8M0XjLcaa1hw6OqRvr5
 VdqaKyZEEkj8PLMv44Y4iWnPkg9QHTaXS4zEyqmljTW9JT2L2vorBYlJvlDkE3dTmzmi9KLjXEo
 79RJE8JqQxx/ulfX6Eo6iU77cJKSj508F/EZIv/28vVKGQJcEnyIDRiqFrugcuIAtpLQDftIv/E
 a9tp5LZNYN8aasS2l+h2IddjRzCU+MftMBd0CzjjhLrOsliGJBKEwF7b2inuM+P2GSj0AcqjW4t
 +ttY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Tue, 25 Nov 2025 09:47:59 +0100
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

Fix the names of environment variables set for hook scripts. These
have a U_BOOT_ prefix, not UBOOT_.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/develop/pytest/usage.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
index 7335a39b9633bb16869dfc976adab32d78dc984f..7c42a31528fd0ef78d3e24f65ee86ce2d61d6e87 100644
--- a/doc/develop/pytest/usage.rst
+++ b/doc/develop/pytest/usage.rst
@@ -315,14 +315,14 @@ Environment variables
 
 The following environment variables are set when running hook scripts:
 
-- ``UBOOT_BOARD_TYPE`` the board type being tested.
-- ``UBOOT_BOARD_IDENTITY`` the board identity being tested, or ``na`` if none
+- ``U_BOOT_BOARD_TYPE`` the board type being tested.
+- ``U_BOOT_BOARD_IDENTITY`` the board identity being tested, or ``na`` if none
   was specified.
-- ``UBOOT_SOURCE_DIR`` the U-Boot source directory.
-- ``UBOOT_TEST_PY_DIR`` the full path to ``test/py/`` in the source directory.
-- ``UBOOT_BUILD_DIR`` the U-Boot build directory.
-- ``UBOOT_RESULT_DIR`` the test result directory.
-- ``UBOOT_PERSISTENT_DATA_DIR`` the test persistent data directory.
+- ``U_BOOT_SOURCE_DIR`` the U-Boot source directory.
+- ``U_BOOT_TEST_PY_DIR`` the full path to ``test/py/`` in the source directory.
+- ``U_BOOT_BUILD_DIR`` the U-Boot build directory.
+- ``U_BOOT_RESULT_DIR`` the test result directory.
+- ``U_BOOT_PERSISTENT_DATA_DIR`` the test persistent data directory.
 
 u-boot-test-console
 '''''''''''''''''''

-- 
2.43.0

