Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9BAD6ACF7
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5EA48980D;
	Wed, 27 Nov 2024 18:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tvVcZXNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E5289817; Wed, 27 Nov 2024 18:23:08 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49D36897E5
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6d41b1e842aso64996d6.2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732728184; x=1733332984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCZ1PCz0aKxKh/Q4ZMD1v9aKoKeJ0Q6Y0Zvra5tWrzg=;
 b=tvVcZXNVUZK6hzfwN5FKL9czijHMC3zRn13kWRFDHrJPcmO7ceCVvS5UZN32fTFHCT
 iZO+NGF5Rlx6LxMcq/yT8goIKVJoM8wkZvOUxgZWIe5Y25vXHQj96cqYT+NlMgyTboy9
 OWxQVDjClMPyp7bcTGsFq02E+UBccO/LLnC8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732728184; x=1733332984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCZ1PCz0aKxKh/Q4ZMD1v9aKoKeJ0Q6Y0Zvra5tWrzg=;
 b=i6xquLlT7zo4TpgUhTQ2e2NTeGHFbyPL9OS9qCjRNqgU/XkuqRbffVeBI+/x2/ZYC/
 MHShK57zOmZBh7VLrSpvVEn1JKPN4TY6M3c9gwTOWvv3S71HO4f2ocChkdmc4HzpU9Mt
 pPPIiLMvxuk0HEZz5bnm4F1s2oxMijurzponZLEpQcXwTwEiYAQsPHPBUvA/r4Me8t3d
 Jyn2QvWKSlMhhQJth3UelpwWJMHZwZuT1iLmApnlaSRXYzJAa5/+WBLTms0I7B5Wlckx
 Ssebqj2N3IeFVLAEi+/5pCOhQ0g7dMAaVqdOwCHsA9hUeRha7+XGLDQkiWn4eeNAa/NZ
 FW5Q==
X-Gm-Message-State: AOJu0YxeIvfkT9GNZ1m1CyfwD7zHXXsehdzxbLFCrMv5R3ce8ylP2Lah
 CeU01TQxeEIH82uTlPcpkbZutN+i/8STJVmWN5TDeq4qeHFLuI9m40h4FxGMbu2x2LIC4j6fPYv
 cWWQ=
X-Gm-Gg: ASbGncuDBFR++i3rhzu1ArSIdurZMbPgUcpdbrTES1o39+fATwhlp6KEKb5UuKo3OSt
 7xc0fwZJbVuvpt57qYGluJQMtnEn4spxyoga9ArSENpZaRznBux0uLzpXzijmqBMjIQvVEn3wmR
 DCQ1eD+RS1HEcLR8IZYQXq61PFEK0Eh9d9/twrD1wK7sqP/Mc4XZjU0sAVr70nZVstUg6AjoM0k
 r7KIfCDFPdO7+lEgFV7vGzQeVD9BiOfz31nfmosfybOe0CZh3nIn27eBbllvZ8fsCRLn+KO
X-Google-Smtp-Source: AGHT+IErhWuSqFFrlLf+P6aG3QQQjamaK7JFzX56FcFFCFfpdEcl7edoHi5i0Ndl8ttiPC/SvIYF7w==
X-Received: by 2002:a05:6214:acf:b0:6d4:22be:9824 with SMTP id
 6a1803df08f44-6d864d82fbcmr61573556d6.28.1732728184235; 
 Wed, 27 Nov 2024 09:23:04 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e25sm67160976d6.89.2024.11.27.09.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:23:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v6 09/12] docker: Adjust installed packages slightly
Date: Wed, 27 Nov 2024 11:17:27 -0600
Message-ID: <20241127172247.1488685-10-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127172247.1488685-1-trini@konsulko.com>
References: <20241127172247.1488685-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

We no longer need to install libc6-i386 so we can drop that. Switch to
installing linux-image-generic as that will be available on all hosts,
to provide the /boot/vmlinu* file that's requires for various tools.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v6:
- Adjust further now and reword the commit message.
---
 tools/docker/Dockerfile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 43cd37070e48..5d3bd4e24ab5 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -77,7 +77,6 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	iasl \
 	imagemagick \
 	iputils-ping \
-	libc6-i386 \
 	libconfuse-dev \
 	libgit2-dev \
 	libjson-glib-dev \
@@ -95,7 +94,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	libtool \
 	libudev-dev \
 	libusb-1.0-0-dev \
-	linux-image-kvm \
+	linux-image-generic \
 	lzma-alone \
 	lzop \
 	mount \
-- 
2.43.0

