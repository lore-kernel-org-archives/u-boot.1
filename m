Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2307BE7E0D5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 994B283CBD;
	Mon,  9 Feb 2026 19:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mIkhmtLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28DA0805D7; Mon,  9 Feb 2026 19:32:34 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C9C83CDC
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-385e7cafef9so43307131fa.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770661951; x=1771266751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLdI+NiQPgsv+eRVzJuMU+FdZi8mTqXGMYv2dQgALsE=;
 b=mIkhmtLeDRCU8j3aSIxlCXvEw5fCqlpINSBdKw+KAflfJ2uy9bdLJpgUwM6L8APvno
 DtQTx2czx38z9TtnZFd36HCOMzntwZ282+WNRK7RaoGzdhBjkatUxmKj47MKaLrdeisv
 wkJ03sbUeZyeKOIHQ323KsnBHzF+N6dp56bWP9MJOXCM5YIN+3bYrs+X+WVbG88Ref3L
 7f3mYq8MphYLO+tXaSKufpUm8gRVzPBW62WYzRcM0qwkLNdmzaZOGv3uqf7DE2/h4CcI
 wTin0HLT95h/WkGxiFjTQIxK5VgbDIZ6n9WQpzEoNfnzEkjTrEr8WhYCY+DN3+ATLrwL
 +e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661951; x=1771266751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RLdI+NiQPgsv+eRVzJuMU+FdZi8mTqXGMYv2dQgALsE=;
 b=pVsA0e9nwy3Sxk1pmlHTagI0ITMvfiPgz/gQfU5/MjdhDDGI5DapQ1siNi34Q9BAea
 /RG9sZ/G8v158/IhDqHlsrUB6Wsf3Z4NiMfYIR1PCb5JRkZ6+iuQmRMI4VgXz8Lb4H9+
 aXZPKV1SN7cK37dbDfo9yJ5OoJXWt8pZ/e/SsmmkkelSKo2GbdO3dfpTelb4m08jN3LN
 QoX/riTXSYG1HpRRPkrevMBnrra0a+TfMXWfTyZmDmu+LcRKn8guts5tfgL02wv1e4xQ
 N35qasqkQVE9/dosG1Zw4KPPhVQc1r1V8CEFHhgMeOframhrBVeVHG7XmK53Byyllk+S
 tkdw==
X-Gm-Message-State: AOJu0YygvkZprrKJKPCVF+ZEqgEv5FrtuSXlcf+rYz6dqxVV0+/T3pIj
 a0oNHtkmSJ47LHD1bKk2QVax9a0FfN/e9/PAp4GQYf/0xWQGUpGqeK2n
X-Gm-Gg: AZuq6aLrDYKkB6wG76nxYKmVmrmH2cknAZONMaVefaEQ9A5BZl42hP3YMTNbd3Dd2l7
 9ZDkbifnm9G2jLo72BJt1B4+Bn2O44/qGVWoo4Ik/R+4rASCWhF5vXT2eOZIABVHRKF0X7R3ZLV
 VNLUAuBnU7Kw2d5oSalYAlXKXY3bcamigXPhuTAW+gFUOASv9ctbGCPzK+rGy3nOiR2UNeuAd5h
 2MXso+VQVlNl4HcaCeVOo6oWuR1tzHR//oeUnL5odMcOKllMx3LL5jD3Q18g45fjvfKLdXRLyX5
 HMVSLqzIP79CeHWtJ3m13P5OasiIsfE+81/2uO7JwcaaFs3v2x4aOuwrJyYX4qKdRPa4GzajCDI
 +cBr1HcA4oMChewMnLoIOU7/IaJYpyOd9kzJbhmXau/esbSs3f1LrHHF8m6CGXUtYPSFd1pvuO4
 re
X-Received: by 2002:a05:6512:3c86:b0:59d:e589:c977 with SMTP id
 2adb3069b0e04-59e4515c13cmr3307743e87.26.1770661951427; 
 Mon, 09 Feb 2026 10:32:31 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44d299ffsm2815391e87.55.2026.02.09.10.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:32:31 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Peter Robinson <pbrobinson@gmail.com>,
 Peter Geis <pgwipeout@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 6/6] board: lg: star: make panel fix optional
Date: Mon,  9 Feb 2026 20:32:19 +0200
Message-ID: <20260209183219.34250-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209183219.34250-1-clamor95@gmail.com>
References: <20260209183219.34250-1-clamor95@gmail.com>
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

Currently, U-Boot fails with an FDT patching error if the LG Optimus 2X
device tree lacks a panel node. Since the panel is optional hardware,
patching should be optional as well. Fix this by allowing bootflow to
continue if the panel node is missing.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 board/lg/star/star.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/board/lg/star/star.c b/board/lg/star/star.c
index 0b4a433a5df..ab700cbe828 100644
--- a/board/lg/star/star.c
+++ b/board/lg/star/star.c
@@ -46,6 +46,8 @@ void pinmux_init(void)
 #if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *fdt, struct bd_info *bd)
 {
-	return star_fix_panel(fdt);
+	star_fix_panel(fdt);
+
+	return 0;
 }
 #endif
-- 
2.51.0

