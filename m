Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB5FD66B85
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 20:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9176383C30;
	Wed, 17 Dec 2025 21:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gdng0Vo/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE7B83B49; Wed, 17 Dec 2025 19:43:16 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CCBC83C02
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 19:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-455a461ab6eso2102528b6e.2
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 10:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765996993; x=1766601793;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L84JosZphhQdKw6C66/qdbMZ9wyL1nLvtK8mrqMjiM0=;
 b=Gdng0Vo/26X4MuYUdCZo2obC/faV3OqzTOeha7tmCm6vqpuzN/9FbKYErreL+aRoij
 plr1CutRg2Gg3NTmLIItM1NFmXIiXG5QqGSBxUqZPyN61XIA2p0cPWsqKraGwbdW3nND
 JzUcnCqmoUbgpPtgpza6Vn31wQERQo4PUm2k0HIkZzkEAklqbjZ+JaBfbUBmrVkrXyOK
 +B1/SEUcZt2XxQrb6EgofTI+4A2Mk2Gp9kXGlcChNfhgSFFA/Rk1oxEsUydG2t8ssiPn
 RnAEpbKN83yU9/ftR30KqLf0HYcx+H0cctG1hfxs4LIpRrRYA9doRL8qt6f55QSWg+Ge
 G0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765996993; x=1766601793;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L84JosZphhQdKw6C66/qdbMZ9wyL1nLvtK8mrqMjiM0=;
 b=h9K7/Y1DvtbZLrmpZsGB0jB3KfDNUBfy1F6+wS87XHDkb/UDPhomQ5l3HHaoZMv13R
 6b5a/8pGL0GvHAh6JPLxLFNBjmQm0JecWug6p+OQ3f9JUc2cgism63JnVmZEOrOhWGMj
 2pk0nvMR0MocrgHEwkeMPprR9jlOoMTtkkcZdtAR3YVLs7OdCR9ovuyDcWQu+fIkOvdG
 jrpNliC5TP3QNyH7PsoJPzt/Bccmd00vC6IH9M/IftqmAvoZdrXEJWbVVCeJBC/tILf7
 wyZU/xbCujtXyWyRBGdgA54JJdZ6+M6FFuke8R+2X4vJYXa4SB+dIkvYiVXbWjsvyjhA
 SSRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBt020GJjod6jCPr8wLNAXA2JcC2mU9aVefqOSk2yJoIdrMT+pomBeMyyqHdC7+YU/YJ/RaCw=@lists.denx.de
X-Gm-Message-State: AOJu0YxWeS6JFEAyBsKZRUELM6JEWNOM2c0OeTWogxTQWb0WFu7xtIea
 b+m4Ao2SsdpRFVLDWWw8G4zc4+CkCK7gGnR0TtIDXQS5TZEXOIUu6PHtGyzjdWH08VBkKgKj4KJ
 xwH51
X-Gm-Gg: AY/fxX4jTLKjrpkg906ORGg1wcMzdL6pDb5xE8IVoHXDOFyQAOiCFvD8audPq72bkw1
 E8ajlQhrJOoUOkACAgHF1BVEXElfX928uSPFHC31vKCp1Kv35B5q+pJT0rJx/SVlwOUqUTopBNq
 ZrKsOTx+pOO3X6JAlJO8ShyYCyd5GqmoyJFA78dQ0zLsDjmemuGBaSgaSGa3yVSXJNFK9vceGTN
 E4Qq3a/xkhkEr0cLhHouvS/RWqSjKc841hQ+6ImMGcbUQp6SwT705ULZudZudojMD1RsMCjAaep
 Qz95mr74+vgggc6GC8jquQTPEpCUd44bLKs3/nAfgJFF7elCzJy0/I5Eykn0DU13Mx14fzjal2p
 Z5bIwv1T+qoNJGYW55oOyae0glOBDMS+zrdkKxaziW6I6lvH9JCvUvXVTAPJSUvtKvVzzbgRMrl
 bVDedh7XzT2k92yw==
X-Google-Smtp-Source: AGHT+IHSpPSZ6jKTo1Fz/n6ATer1DmcX99L8I7PmvP/ti7VyICTxqAkPKiKyEu1giTBwnqd/Q47Nyg==
X-Received: by 2002:a05:6808:bc3:b0:44d:8e2c:41c0 with SMTP id
 5614622812f47-455ac9101e3mr9080159b6e.35.1765996993144; 
 Wed, 17 Dec 2025 10:43:13 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:11a:676d:852f:9349])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fa18021a81sm91782fac.20.2025.12.17.10.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 10:43:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 17 Dec 2025 12:42:11 -0600
Subject: [PATCH v2 3/3] pylibfdt: add requirements.txt for setuptools
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-a-few-test-py-improvements-v2-3-e1f91e3bf551@baylibre.com>
References: <20251217-a-few-test-py-improvements-v2-0-e1f91e3bf551@baylibre.com>
In-Reply-To: <20251217-a-few-test-py-improvements-v2-0-e1f91e3bf551@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=715; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=fQtJsjOosE7RnrYKM/+4LGD4vvvKN9uRgQonSbz9Hn4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpQvm2Q2vPSHAHYqYk4SH337Q33VqPJ7K5iqAji
 T+y1O3srSOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUL5thYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AI2oH/iqe8IeEKqopNZXzpJDup+atG+j/L8JRrxZa+I0
 BMAMuQFcqWmDv/hyEmd/tbW17KQP8HEs+RXdbPCJm761a4E8w2VlBOO2NlieoHByOgYyJB2amZF
 kaU4AbF/Oy639cyfE6/Ofbm3k+/2IXTYQfHDXgF0ncwcm0+PccX+KpyENQ16ok2t4UYWvXslDAh
 ihLc2WUqQeXvA2IncrDt7lKXNNLPt9mnJjaEzGOcE219VLlWRHmjm1pFLgDmmUsCiqVUGEPtZhC
 39WM6IKOUvNbXmuvZpkKRUIsoZ7aAsi83rRGvp7NRIFUr/sk4Y8bfpAhkTH3hJ5F4tghh3FsZsY
 oBVA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 17 Dec 2025 21:08:13 +0100
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

Add a requirements.txt file to the pylibfdt script directory to specify
setuptools as a dependency. This follows the pattern of each tool in
U-Boot having its own requirements.txt file. The version is set to
78.1.1 to avoid conflict with the same in tools/patman/requirements.txt.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes:
- new patch
---
 scripts/dtc/pylibfdt/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/dtc/pylibfdt/requirements.txt b/scripts/dtc/pylibfdt/requirements.txt
new file mode 100644
index 00000000000..b7dbecdd587
--- /dev/null
+++ b/scripts/dtc/pylibfdt/requirements.txt
@@ -0,0 +1 @@
+setuptools==78.1.1

-- 
2.43.0

