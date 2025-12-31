Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CD1EE6428
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 14:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E0D84067;
	Wed, 31 Dec 2025 15:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AFsiKmDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C68E584073; Wed, 31 Dec 2025 15:16:06 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA4878401F
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 15:16:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AF39D3F863
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767190564;
 bh=9eotYKmUxceOR4fFF2v6qmVUwLm8PYGRh1cBJ+G2tTo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=AFsiKmDvFN5IsjVcHiNqnqn61PyEqsfBj8geV+YyHZBHZUH41tCdw05McMtnzwLDb
 myxhy8mfFigWXdOxD+5Yjfee9zQyexPEDAQbTOsYqRo1Z/915c29N/nVcAfFXgRE3C
 3eoLR02FW+tc1HHOzTbeFpyQx06yFmcRr7stvFcjpKhcJ9rJTKE0K/F+B6zM/2nv4I
 HI8q53YcRhm7cxvz2cw7de8oqETdW59yTJkxtABjtrrnITdvZrer2gKHaTk+DVgJTQ
 rRQfWCSyFegAk9zpiH+vMw+BiMwoVA72rybe4IlzrUWiYT5gDKwzz+A4GbpIo1H323
 51EmcM+rJj1IviEMzmPumP5J6LSHsjcDuo8EGadI0C0+Ts7xlfG3oT6UvNY7T4iLTZ
 jOzM/q+9crWzvIgPhxUxGiCfrlza395NPF74ITY6BbpncpvEykBtr74TP/lt+IZ5Lx
 MMbiOjNnAWoxTk0RF6P6SKRoLa5981H1d4hsPWAcrmzEnF01OAGdEOSmS4Vr/azG+r
 8qZ/2gqyuxikkMoerGTTiA40xfsEhswOPd6V9KkgZZQrlVm/toin3ItlzrM9r8F2up
 l7s1WzHtF3JIX/TX8g9HUdwzG/1QPVA4GG14H3zZvGEuOR5Ar6fd0eO9Diq0uEf05q
 zXkOJvkOzMPwEjeYEqcupoas=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso39084415e9.2
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 06:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767190564; x=1767795364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eotYKmUxceOR4fFF2v6qmVUwLm8PYGRh1cBJ+G2tTo=;
 b=GGNWsCfsN80Y8FLtf1VnFxhCxkooY+86rej71HCBlk/ZER1RcD8Vx22q2ELKo4mbtl
 6PblspzLwx7KB3w0AG9eeFLjmurqVpt/+a4AcvX8hPgZZnrw4aV1buBHRTjULWLoI+ZF
 y1oaG0tzNxshrozDHKRiJjZqE/lsKFaoxrWNikj+4nJOX1cYCGd357WATf6IlI6zha95
 JGHGVGv0jm8T6rGfqlc7SgLewlS3q+C8mqIelfqH7dHqT5UdPgE+I1GIPdT2MM+Wha0A
 Z4ARHdrt1TbZBRrCr0kQ0lkFSKmftnrz2z2fUwK39ziGCGD9dRunvCEowDRBJndoU6xv
 3KaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuuFfHGP0DAhiBGCpBbO+v8mDQFgfiaWKOruyjfz01hymLsaQV9ZYwC5yqIPykqh/uvdJQhsM=@lists.denx.de
X-Gm-Message-State: AOJu0YybuaJr/VvxU/OE6gUKRt7rrQI1kMK9oXpq+UcLWv7jOYKZq3P2
 V1im3sObZAOi7feZVWY37SsjdggOBI1Gc7Hnk9z6sU2KM7HcfUuwTzWr/+DWsaeATANsmpw6Dhn
 qcOarIKE5+qjdy5aB0UGeDChOlZtssr1PKIWOUhGiWb18PVxNKgSGrrHz0J/6qbPDohn6Qhg=
X-Gm-Gg: AY/fxX43jTwnumyxIWIxuKJiWOhSF/iXtpKP4p4HuGKHDgfFK+8TT4ET1ooPDlRigin
 DQCWQNMsRJV04npnsC91sSfvRBjK84M2p8TsRCQWpvX0rM9Z0nBU7PcK/6mf7EeSPDBY0YN9TmO
 YLz9r0VxketvQDI2diEK2T3WYJSahdphcXe2ZNG0pR6tybMXjWCs23qM3vMOmxFOVBAOryuNqZh
 NkcYmPew/iwRyj+8ZOBS9KPUxRDIiAOYAAdRaZ6/vTSNw2PvBNUtF2rfn5igihze1xf21VbOH+c
 26+r6D0WOjuG/Qpl4+4Nbo3qGMmZeRB7ElUDbqM9mHt2Zivz7vLfSaBCc1vxM9RIrAGXqcCf8Dt
 JmnMaSLX+Wfg/EjyERlTniVWlROATdKxTOc13U7jxVw8ChpsIbRwgBr4fwJUwxEp6wNsDkJcSFZ
 /y
X-Received: by 2002:a05:600c:a31a:b0:477:b48d:ba7a with SMTP id
 5b1f17b1804b1-47d1afcd9e2mr336758415e9.32.1767190564294; 
 Wed, 31 Dec 2025 06:16:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQVd37dl3nnrmCA4JvOcz6WmposmO6VfOGLxC0sc6jurOSoQT3iqCxQoDaDRp2L3lp6UKggQ==
X-Received: by 2002:a05:600c:a31a:b0:477:b48d:ba7a with SMTP id
 5b1f17b1804b1-47d1afcd9e2mr336758255e9.32.1767190563945; 
 Wed, 31 Dec 2025 06:16:03 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19352306sm636689175e9.5.2025.12.31.06.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 06:16:03 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: command `font` should depend on CONSOLE_TRUETYPE
Date: Wed, 31 Dec 2025 15:15:50 +0100
Message-ID: <20251231141550.64310-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

The font command is not usable without CONSOLE_TRUETYPE.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b71ac554c0b..b5b03eb5363 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2649,8 +2649,8 @@ config CMD_VIDCONSOLE
 
 config CMD_SELECT_FONT
 	bool "select font size"
-	depends on VIDEO
-	default y if CONSOLE_TRUETYPE
+	depends on CONSOLE_TRUETYPE
+	default y
 	help
 	  Enabling this will provide 'font' command.
 	  Allows font selection at runtime.
-- 
2.51.0

