Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8CBC6FD1F
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 15:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9113A87D74;
	Sun, 24 Mar 2024 16:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZBWzQpq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E3987D42; Sun, 24 Mar 2024 16:19:15 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F038E8718A
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 16:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christianshewitt@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56bb22ff7baso4168420a12.3
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711293553; x=1711898353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orAznLnWy0CEitEVvnSeuGQAseklMB0s/6SFzX1+Rno=;
 b=ZBWzQpq4xDGYl9xsyS74sxfsPU7SQHiURuxtTH8enrrQrWVPdMkZYYrhjA0In8kS0f
 EGVgwxVLaGPtvBrZVPzujT0zC/0/9/Wg9yzr99bKRbRBLnOR/ATPU/cROPII2k/RDtEp
 Q8NTwDhY915Tietu4fJrC6nSpVDmNahD8tAfXbKjIvWGBKJnYSh8FnCXrmEyBcpDR+CB
 gEEZPQoDfWChB6zkemmBxHDK0I52QM63Jna3M+DxjAFfMBHjv+XI4RVsAFe5MjmkiwKE
 ednXDH7GLHuR6hJJwHzxNvyspBuIG8U0NgG7/E1Hr83/rrspJb02pLwA3kOdkhyz9Thi
 zoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711293553; x=1711898353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orAznLnWy0CEitEVvnSeuGQAseklMB0s/6SFzX1+Rno=;
 b=ZPOPk++640yTy2jmIjTnhkrWPlJuI8bg7QGiDyd2COMsvPUw4Fjq7cO7/KHIL3VA5G
 Cxr8Y+SVCAgxbJuHqHxVDoST2Gt59OZCP9wVbFcNJW0+oowxw0U0SYbXsJbft4S+cbH6
 FISShHcqNdumMcCUV8vpZuXN9sX6o4wkl/H3LTdEjEXMO2A6AHYrhD7u/lx3F9SFftIj
 KylOu1UplP9Dd6fdAkK1Zjo9m4SPseCCKz3vjhRiZ3lnbqWNPGVimDPtHCzio9ymQCAh
 ZTzgsWGW8+qc+9pIsYOPLf5ZHVj+hUcALhOlPlQ3+YIt6L/EFXdRCVLTwPQJzvDzEvjJ
 +ESQ==
X-Gm-Message-State: AOJu0Yy4T9LNl6Zl6PAGURlOZP09X2KS/5gFO5LjLWbTwk24MfOOaGl1
 YE2X9LEHgB7dg7wWJKoWSfTHxnfPKR9BQbyPcALgF300zYAKMTPPxik+P/9TUQg=
X-Google-Smtp-Source: AGHT+IFhRJgpiqLGFCc44rQRz5LPiyxEJY5CVYn69exzGloG9UHUmJzBBQMw9KF+UW7QUds+qK+B2A==
X-Received: by 2002:a50:bae7:0:b0:56b:d15b:6dc1 with SMTP id
 x94-20020a50bae7000000b0056bd15b6dc1mr540362ede.23.1711293552801; 
 Sun, 24 Mar 2024 08:19:12 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144]) by smtp.gmail.com with ESMTPSA id
 o26-20020aa7c7da000000b0056bf34d656dsm1996114eds.29.2024.03.24.08.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Mar 2024 08:19:12 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 2/2] board: amlogic: add meson_generate_serial_ethaddr
 fallback to p200
Date: Sun, 24 Mar 2024 15:19:05 +0000
Message-Id: <20240324151905.3817732-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240324151905.3817732-1-christianshewitt@gmail.com>
References: <20240324151905.3817732-1-christianshewitt@gmail.com>
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

Add a fall-back method to generate ethaddr from CPU serial on p200 boards
if the MAC cannot be read from efuse. This prevents random MAC addresses
on the WeTek Hub/Play2 boards.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 board/amlogic/p200/p200.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/amlogic/p200/p200.c b/board/amlogic/p200/p200.c
index 7c432f9d281..3061f7a6b3c 100644
--- a/board/amlogic/p200/p200.c
+++ b/board/amlogic/p200/p200.c
@@ -30,6 +30,8 @@ int misc_init_r(void)
 					  mac_addr, EFUSE_MAC_SIZE);
 		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
+		else
+			meson_generate_serial_ethaddr();
 	}
 
 	if (!env_get("serial#")) {
-- 
2.34.1

