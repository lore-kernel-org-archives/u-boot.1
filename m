Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D930ACEE34D
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 21:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26B9583A57;
	Tue, 18 Nov 2025 22:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qVBrAg7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79FB580FA1; Tue, 18 Nov 2025 22:00:21 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CEC28398D
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 22:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c6d13986f8so162937a34.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 13:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763499618; x=1764104418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VZNPSw2QHX46ux02kPluNPnpnMupG1wIm3xGbNGzxi4=;
 b=qVBrAg7VLuJMesgg1HaWYQ5RV4sDPSelzUplmzpMTU7UKbBW5DGY/zOtLuq/xuJQON
 lQy6yyYiw9+X9o1eO8AQQnoS6a5Wj16k5BacaFmB71qIo19HiQGcOtEWlswcytWuyLv6
 RVZ3iz5iZUfYbCMLzgrlFd4hVIXqKY//PdUQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763499618; x=1764104418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VZNPSw2QHX46ux02kPluNPnpnMupG1wIm3xGbNGzxi4=;
 b=BzZOeGUt0sfLWpmZDVw9lNByOcdHwtJqR6r9x0TsaSpdyAcaFJp+k7eGvtodRZM5r9
 Z42iQkjIy6F+2035BRHlyOqPFbK3J622XYae+mSqyS4qevFdrZN5TlfOc9kitX2AGLAq
 iQgAdovguNjGk0/OY1Q3Q9u6bogNi014cJ8PgG0o1gsJxbmCTQVp0a7z8SYnVmlnWh+Z
 hXAA15iww15CesV88eLU1FLTXkmuCmMdIpwLgH20QikPbIBLqpsZ2bEnlIxDpSg+3pcY
 sSQQ6mpz7qq1B17trIUPrW79tfr8zB0zdYl9Fan2RN9Bed+2gPLvYcN+xbu2irIHjdgO
 M78g==
X-Gm-Message-State: AOJu0YyQVQnEwlkC25TZHdJ1uSGovsfXg75gKpkRii44wf8Wm1eCwB5F
 wD3hTiGknEoZesP4QWMcZf/rpIaddG2UQ2IPo0GEOmZrhWr9MxhpMUku5C7iO8GwrKzR8CkY9jE
 aPtwPMo5KjQ==
X-Gm-Gg: ASbGncsmxkn+8mAF3a9PsBzfywT/rVTd2r1wC5Et1J5sHwspcZpZ7SbtLJPYKaZsxXV
 MBhHxZBX6dpgsg+d3fZXF4plKTgZ2o5JhzeImv35UG1fH6o7L4F4gUhcpytWYpk6r3P3S6Z1TjN
 x2lCdBhIwZQIkVXstkenxdPtZsXIF1tZKp8EG0bOzEgY+/920xCWI49Cq0yWqVVM/bLsFlF6kti
 jMQn5vjx6/iHPRNSfaKDlZcJ1QBAt6Z+PJX6eoZA4mk6aOYKbj2OH6O3Ult5NnBD3ybhvI9rbP4
 l3DUwZMrS+cLGBgBwNrH51vtKReNdIB8ypx+DVuyPitbmgBly8onvfsBIDQxXBILynPP8NhWwAi
 rjCzrAbTbxBQlxVo0Q7H4sRJxxDTRMN9RpOBhoyYO/Wk9WLllcrKiJsegjkd9ly5gEmhuOypIo2
 ymxnE/oN/5Q1yXDE59nOY0KW4M9+U3BFMU63vCLqv+PFfplb4wihwU
X-Google-Smtp-Source: AGHT+IHdGJ0sg1GC9JW8CosRgidO8oxFwJ/cvsAqd6c+OgYFKiqEUOS9CoOPCNdwiUIsEiecg0THxQ==
X-Received: by 2002:a05:6830:81c8:b0:7c7:6e2a:db6f with SMTP id
 46e09a7af769-7c782be9bb0mr45664a34.16.1763499617356; 
 Tue, 18 Nov 2025 13:00:17 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c75610f638sm3583110a34.21.2025.11.18.13.00.16
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 13:00:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 2/4] Docker: Add building TF-A for pine64_plus
Date: Tue, 18 Nov 2025 15:00:13 -0600
Message-ID: <20251118210015.624758-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118210015.624758-1-trini@konsulko.com>
References: <20251118210015.624758-1-trini@konsulko.com>
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

In order to add pine64_plus to the sage lab we will need to have a build
of TF-A available for it as bl31.bin. Add this to the existing build
loop of TF-A targets.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 2dc4bec33bb5..fd8765af4585 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -276,6 +276,10 @@ RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.
 	mkdir -p /opt/tf-a/qemu_arm64_fw_handoff_tfa_optee && \
 	cp build/qemu/release/fip.bin build/qemu/release/bl1.bin \
 		/opt/tf-a/qemu_arm64_fw_handoff_tfa_optee/ && \
+	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
+		PLAT=sun50i_a64 -j$(nproc) all && \
+	mkdir -p /opt/tf-a/pine64_plus && \
+	cp build/sun50i_a64/release/bl31.bin /opt/tf-a/pine64_plus/ && \
 	rm -rf /tmp/optee_os && \
 	rm -rf /tmp/mbedtls && \
 	rm -rf /tmp/tf-a
-- 
2.43.0

