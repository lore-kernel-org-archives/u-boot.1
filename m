Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E807CF58E9
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A1789382;
	Fri, 20 Sep 2024 10:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XJ1v3cF4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B41A87D1A; Fri, 20 Sep 2024 10:14:07 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F229489382
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c413cf5de5so2363087a12.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820028; x=1727424828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qEJrGnsgLTlE+u/F3aUcEDpzp+/XSfEN73udjDdDls=;
 b=XJ1v3cF4wCpcTHlSHRi+w3pTRgJpKP7V5b603h1sSaF8D81eVoFiFPvBK7AzynJ0a9
 BBMHx4IFEy8MwdX0B1THp/CHPxVq8uyp6nTzUC8IMTjtZuIwHfcRw/aq3/OdVCt8g/2U
 2s9xg8r37CsBPdJ4yWWKI3VJHaJzgFoSng+8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820028; x=1727424828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qEJrGnsgLTlE+u/F3aUcEDpzp+/XSfEN73udjDdDls=;
 b=YjaV1kKoD48OdBgcCgAHRhDxJdRgh7USCiAbfF8rNXFj67FPxlJhgCP6B2zoBPJu9o
 3VtJcx1y4B5UkY0iM7Z2nQDWajFbt9UE6P7zLACysFadh3M93HwMd975iUU7fL+GJuPp
 q7e7r+bjdPkoA7Maq47nZjFzoH0IYhw8GtHHXnVf26Q2ZlLPyEz3pYZ6n8z3eJcdhlpi
 YqkzN/Z4CQEZWCVXhbN/iviFyWALl823xw/OFbri2lqu724x0Hurrgf6EuAzfIkoMHty
 bbeF8K91ZetTHLEuyxLdph8zCnhPwZNClq6BLq0lWc34/p0ucmb0iT3BnLfEAkWIor1s
 Qerw==
X-Gm-Message-State: AOJu0YytADsuHwrKcCog2UTulIY7f/4R5xGe587YNpdEBV+/eHGzRMkE
 MaUjP7RJq/aSYlmbtgAdlcTHGAe8YRRv9aKxM4LfPwXsLksGXS/5YvuHdH73W/JMeBXnJJtom6+
 hWYN/
X-Google-Smtp-Source: AGHT+IH+hhS9nFbDwgUXkVRjvhNZJOPWR+TdQSh47auZl+aZdWjymcVjC8CXZ7gMGyDEux12KiMGaw==
X-Received: by 2002:a05:6402:1e8b:b0:5a2:5bd2:ca50 with SMTP id
 4fb4d7f45d1cf-5c464a5ad55mr1640439a12.25.1726820028123; 
 Fri, 20 Sep 2024 01:13:48 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/18] boot: Imply CRC8 with VBE
Date: Fri, 20 Sep 2024 10:12:56 +0200
Message-ID: <20240920081309.140426-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

VBE uses a crc8 checksum to verify that the nvdata is valid, so make
sure it is available if VBE is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Depend on TPL/VPL as well

 boot/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 9fd1424cd1f..48ed86bf13a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -718,6 +718,8 @@ config SPL_BOOTMETH_VBE_REQUEST
 config BOOTMETH_VBE_SIMPLE
 	bool "Bootdev support for VBE 'simple' method"
 	default y
+	imply SPL_CRC8 if SPL
+	imply VPL_CRC8 if VPL
 	help
 	  Enables support for VBE 'simple' boot. This allows updating a single
 	  firmware image in boot media such as MMC. It does not support any sort
-- 
2.43.0

