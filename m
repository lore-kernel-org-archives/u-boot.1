Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DDAE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 409C480371;
	Fri, 20 Dec 2024 01:35:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hYfYXqp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0CDA8039A; Fri, 20 Dec 2024 01:35:01 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C466380328
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3ad272538e8so9437145ab.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734654898; x=1735259698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3n/aTbU6jD2PVBjphZMrjk4QZ83YxuS+J1PIEAT0nI=;
 b=hYfYXqp35U9ocgVf3az2rXo0Hs//J5KUuYWPwJenF8IwY6/VUb2lkN/VnzxUvvyeF1
 zMLmiflYwe5HOUZcpCriUW9OOXpwMpjwYKmQmXS3VOOpfyzR4oIRRzRe8O4HUNWrmFG9
 UXf3ESuelZokXSA2NQVGse6z8yQCdp5h53O6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734654898; x=1735259698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y3n/aTbU6jD2PVBjphZMrjk4QZ83YxuS+J1PIEAT0nI=;
 b=bY/5l4XBIrKizKkymLcPbCxKUib+O8MfDg/xBFHCzF1+u13et9kvhptykPE6DHi79C
 YWA7ldGa7YsiWQ26QSAdlr2zxh991nXk4upr8dlQPSkZH6We40ljMmO/RzIO+Nwbgc7g
 8vMKtm/mH+xH74jSDUcZ+NqeotRIxg6RznQl5hBFahmIMpsM4XVxROSE5X/jnZLTqTBa
 q+oK6ntJ8nGsAm3q+bgh4vKee/wbplK4w4qcPfAK8pYvtGTvNgjYDjpsrAperWLOmTdn
 e8X/QMwWzqtMZi+PipX9jGF6Yrg8YXqnYnKPMbCyCGWPHqVY+1P8vxa9RBUdX837A4mr
 1dGw==
X-Gm-Message-State: AOJu0Yyhlta2ZYMieL3izX7zgEIl0m81RDnzVXKLKidiOmUNw8SswppP
 ofuKOelDhP3zk8txVb6eQn4KkoAsZ7/7VG+PIWgYqMoTscCuyNvrRFPA1Omcoaia2qCQXpJ9G34
 =
X-Gm-Gg: ASbGncta1uA4CJ7U+/WMCXk3jiLFksA/ctFEgRTrsiqAzJT7+x8oFoiwawjgWQyYDnd
 kJAJG0egeoNVEVWhaqpx9miVTMGtY9svC3TVsMWlNpelMBGvuFGoEG7Pb9qWS5ZKQV8Y+T9J8fy
 A4048zF8JWGX8o50DZupXEleGrqEr8dpLMibLZZw3BoNZCD9p5xf1680BjWpadaUK964Z6ae/Zk
 NsL30UjA2UxoKecRtQY3KFCdkwH36G9n1FcHlZ+rmRdiU/5BH5DK7DtCfwaosshMuU+Xf8mmHij
 jwop8Y38vEUOMjDr4w==
X-Google-Smtp-Source: AGHT+IFNxxRjqzYe/mHzNYOV4SB3kIE5B4lOCK7v3Vs6bBcXQm8sCdfvmiVKro0OvgL9oHY7fab31Q==
X-Received: by 2002:a92:cc8c:0:b0:3a9:cdc1:f8a0 with SMTP id
 e9e14a558f8ab-3c02f9e9979mr38492155ab.8.1734654898089; 
 Thu, 19 Dec 2024 16:34:58 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68c20bc69sm548273173.141.2024.12.19.16.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 16:34:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v4 2/5] rpi: Set bootm_size to 512MB
Date: Thu, 19 Dec 2024 17:34:44 -0700
Message-Id: <20241220003447.2913443-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220003447.2913443-1-sjg@chromium.org>
References: <20241220003447.2913443-1-sjg@chromium.org>
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

Set this option so that all boot images stay within the bottom 512MB of
memory. This should allow us to drop the fdt_high and initrd_high
options.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Suggested-by: Tom Rini <trini@konsulko.com>
---

(no changes since v3)

Changes in v3:
- Add to the existing comment block

Changes in v2:
- Add new patch to set bootm_size

 board/raspberrypi/rpi/rpi.env | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index 30228285edd..a327fccc77f 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -60,7 +60,12 @@ dfu_alt_info+=zImage fat 0 1
  * Even with the smallest possible CPU-GPU memory split of the CPU getting
  * only 64M, the remaining 25M starting at 0x02700000 should allow quite
  * large initrds before they start colliding with U-Boot.
+ *
+ * Limit bootm_size to 512MB so that all boot images stay within the bottom
+ * 512MB of memory
  */
+bootm_size=0x20000000
+
 #ifdef CONFIG_ARM64
 fdt_high=ffffffffffffffff
 initrd_high=ffffffffffffffff
-- 
2.34.1

