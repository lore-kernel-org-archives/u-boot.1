Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1471FCD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1714184693;
	Mon,  4 May 2026 15:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="MZriinfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F25884688; Mon,  4 May 2026 15:20:50 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1613284659
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mhv5V1LzfDV;
 Mon,  4 May 2026 15:20:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900847;
 bh=P2xxc3hUNaxI2MKXV8feIgIH0O6hL+bWl/bL3Ri1F1E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=MZriinfKuBhV8ibCaQS4sPRb5EEW5wdz6CSbnl0tvFCya32cJ2L/Bo7OUYqxsHQ4m
 Nc3rzmn9ZuF/8eWukwag/kfSCdI27riDoCWTF/dMVjBnJ0mNTnTRhVgAY+njsP6WbE
 dvhCiT3XFkOoCneCRQzPC/u/Apv9lVNUjH1DxYerPl5+sL8E08bO3uSeCVfm7KmBS6
 Vuc2G0szgbU1L0ZsD9OFiy4M+w50ocKfGNtiCKTfqDLP7iSw8PIkC8tu2/txjGma4k
 BUmgPZX4DjLcUNU8VVRyirnOrsBpHoNg6yuLKF0ZjNt5uiE491Fvs7zp07ELZPLHiA
 Vt1bqrQC8uLgw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mht4FhdzDsd; Mon,  4 May 2026 15:20:46 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:31 +0200
Subject: [PATCH RFC next 04/18] kbuild: re-enable int-in-bool-context warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-4-b19301d1948a@cherry.de>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

[ Upstream commit a3bc88645e9293f5aaac9c05a185d9f1c0594c6c ]

Original commit log:

  This warning was disabled by commit bd664f6b3e37 ("disable new
  gcc-7.1.1 warnings for now") just because it was too noisy.

  Thanks to Arnd Bergmann, all warnings have been fixed. Now, we are
  ready to re-enable it.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index eb61df70838..0404657dac6 100644
--- a/Makefile
+++ b/Makefile
@@ -897,7 +897,6 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
 KBUILD_CFLAGS	+= $(call cc-disable-warning,frame-address,)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
-KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, address-of-packed-member)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUG

-- 
2.54.0

