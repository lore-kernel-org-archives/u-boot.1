Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD2FC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4ADC885BE;
	Mon, 10 Jun 2024 03:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UV4g+SIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA6A688578; Mon, 10 Jun 2024 03:12:58 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1DE488569
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-254a7fe21aeso507608fac.0
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981975; x=1718586775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jMeGLO1IlJDYqTIdTf9GhLx78Z2YsLiJBjEhU1B4nI=;
 b=UV4g+SIexhcKZFUMN08oDFZYlkXuEvG76qag5apevSkbql047WUlOBfdAw08PvHvWP
 0nawg5OTxZXWSP7ymu36jUt3qwd3OCum9K91UBJ0NJCCtqZiSZQuOEfAmY76OwyIHB82
 q1JgofSKDl9ka+13A8NG4f7zffxGwjkAmgJsoGizemTwfcbY9DaZVoFGPAvCOdsKkSFO
 NibWOuMT0E2woV4RFdkI+x+LwSZfFyt3VzEZdKQ3EJ5x8OTAhwAK+X3QmQ8T4XBKjrIO
 23Kr3CUAZ/WFTTZffBzs1mVGe5+Rupss8/kGISh652PDHncgK3PKr1hXPYTvzMUTbGtM
 dCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981975; x=1718586775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jMeGLO1IlJDYqTIdTf9GhLx78Z2YsLiJBjEhU1B4nI=;
 b=WHLdaMCuqfsBXoUuCsxDMhKVGXhl2BdgAAA50Aqi6Xqmw7RiE6Xy+mDpRRdLYZYmpW
 OG8rml8tQ24yjvesdc9AN+NV1MBJVVLPTC+ACw4WUuntOf2yihCBF3wpDkudi7DV7eGp
 A1qWHR59wASOAJc6tDHC3OIqYRRo65GV13DWPI2B1qB3UuemRO57OcdGZVy0AtZkae8x
 ZwCPRRlk764jCbP8jfdNIVDvaCpQ8l50+MtxTFU00bANXPBfDPuNAgH8m8oNQGWIQf3Z
 /QGJwGaNG4agYQQlvk6osGnLF3UMTjRW9cVBb3FF+fhwNxti1LKn8wsZOd2LJ2BVZCES
 wMvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrLYuolrxmfRjRhD7KVI3yy7imV79l9n1kXB3mIOAo85uO5LSr+nxs41zuTn86grDQfoosPsWFAqIj0GZvxRaTDfJoDw==
X-Gm-Message-State: AOJu0YxpOFDefDJZnIEvDPEqpZtHTdiuvJXL2HaIRYmEtUK4EwuZQKVF
 fgJq2jsJ0GM7GLdL0L3mXKy3jb60fmeVq9jOEY8xlyi4dUQ8R3jnXeCydN7nQco=
X-Google-Smtp-Source: AGHT+IH34NtVAdkqVDc6qglXLFrxC0TG8qoxTewaghgf+i6Gtcpq9ok9LIMuwQaHn8nhgBZgKSFodw==
X-Received: by 2002:a05:6870:b022:b0:254:b8b2:e194 with SMTP id
 586e51a60fabf-254b8b2ec1dmr1144821fac.12.1717981975561; 
 Sun, 09 Jun 2024 18:12:55 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254d8b2b4a7sm31872fac.8.2024.06.09.18.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:55 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 40/40] doc: samsung: Mention enabled eMMC in E850-96 board
 doc
Date: Sun,  9 Jun 2024 20:12:26 -0500
Message-Id: <20240610011226.4050-41-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

eMMC is enabled on E850-96 board now. Mention that in the board
documentation.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 doc/board/samsung/e850-96.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/board/samsung/e850-96.rst b/doc/board/samsung/e850-96.rst
index 0cb95473e536..0a7b6fc0c9dd 100644
--- a/doc/board/samsung/e850-96.rst
+++ b/doc/board/samsung/e850-96.rst
@@ -47,12 +47,13 @@ Build Procedure
 ---------------
 
 .. warning::
-  At the moment both eMMC and USB features are not enabled in U-Boot. Flashing
+  At the moment USB is not enabled in U-Boot for this board. Although eMMC is
+  enabled, you won't be able to flash images over USB (fastboot). So flashing
   U-Boot binary **WILL** effectively brick your board. The ``dltool`` [8]_ can
   be used then to perform USB boot and flash LittleKernel bootloader binary [7]_
   to unbrick and revive the board. Flashing U-Boot binary might be helpful for
   developers or anybody who want to check current state of U-Boot enablement on
-  E850-96 (which is mostly serial console and related blocks).
+  E850-96 (which is mostly serial console, eMMC and related blocks).
 
 Build U-Boot binary from source code (using AArch64 baremetal GCC toolchain):
 
-- 
2.39.2

