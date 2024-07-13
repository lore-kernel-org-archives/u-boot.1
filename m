Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5FDC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E558880E;
	Sat, 13 Jul 2024 09:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CYg6hziY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83DFB887EE; Sat, 13 Jul 2024 09:03:48 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76F76882B6
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52e99060b41so2858012e87.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854225; x=1721459025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUfgELQ+6xyN531+nbFYMRFicKKY4al68XKFyJzvncc=;
 b=CYg6hziYZaLZmTOkDDGkSbmw117gs+T774eccemTx1kQNwfhLuTqXvCqPWaP2crIfy
 gn+unp8gmAxcWWuwnIckuXA62Bppigfnk2W/YfEz4QT36dGyNKebJGit9/j95vlUoKbj
 +ZATtWJVUfZAoZUuFHVJMn5iI/8N4oprKYJUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854225; x=1721459025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUfgELQ+6xyN531+nbFYMRFicKKY4al68XKFyJzvncc=;
 b=b7Watoq7Z6AhKsTG92Htb1Lru+mlPvDMksdkbOHmeyWWbvHKtQ/wcmgG9Ad4wWXOkW
 SxLdolJ9Njb3eao4qz8f7wX48Z9jinQTDIMcKNS0DcBKKyRTBMts8Eih4Ci933L8TlGj
 qlRnUW7j+XJFQKTa1K95aV2qYJ/MhAJBkk2z48cicN1OL7/R0Vn2MmbgKutL/U7VtBEG
 zpIwTYEntqaxrIfc9nD0FBMEClR0Grw0lqMAXkgYDUCLXAUw37hJkdPTgW0JCv1wD6gX
 OAk/rDXeinIDNxTz040lDe7fwjLdceMvO9WCrs/986oLKUrfEk76oz9gzJQu3kVjvU44
 W2fg==
X-Gm-Message-State: AOJu0Yzmmo7IO9slfIT90RRs+hd1VxrUwPY6Rk+bnR18Y0JLq5V19RBg
 bvEg5DkhrFDid/+tgyonx1E4CSqMBAykJE+IFmGTjksAuLmXBO52ajWHSSdhACZViMOV2jyNXSw
 =
X-Google-Smtp-Source: AGHT+IFo/u6bAE19e0mC08GWWD7sxM2xG/pjRZfithizwVZbiOzNCp3kCO8vEYw9Gp8GSSk/KDBaMA==
X-Received: by 2002:ac2:528b:0:b0:52c:df9d:7cbe with SMTP id
 2adb3069b0e04-52eb99a2724mr7603942e87.39.1720854224954; 
 Sat, 13 Jul 2024 00:03:44 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/21] sandbox: Enable SPL_LOAD_BLOCK
Date: Sat, 13 Jul 2024 08:00:38 +0100
Message-Id: <20240713070055.2172883-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

Enable this option for all sandbox boards so that the FIT-loading code
can be used without generating an error about block devices not being
supported.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index af43b5f5d3c..970a4a346e4 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -288,6 +288,7 @@ config SPL_BOARD_INIT
 
 config SPL_LOAD_BLOCK
 	bool
+	default y if SANDBOX
 	help
 	  Support loading images from block devices. This adds a bl_len member
 	  to struct spl_load_info.
-- 
2.34.1

