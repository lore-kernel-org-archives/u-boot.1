Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8263FB5E8B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D3798413A;
	Tue, 17 Mar 2026 02:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M58NVGUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1370E84246; Tue, 17 Mar 2026 02:24:40 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79A9D84129
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d55b97f358so3718279a34.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710675; x=1774315475; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LUGIPG/SpyBcUJbyL7b9/qUv1TQxpTbpzEsbKNoGt/M=;
 b=M58NVGUiQHK8kf2yazr4UoXcp5cvy1a1og1EWap7xk+m50oi4BnWoFQ3pRlGDr7Jjh
 kZbMx7cBxGVLpjlyBrNgXv06r3gD19hJ1q0GXVF2JBW1Ac0owdrF73kgifivMOGrD521
 gu+wvBBOoDoBjZDQgLEtXhxT3UslEze3qKLA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710675; x=1774315475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUGIPG/SpyBcUJbyL7b9/qUv1TQxpTbpzEsbKNoGt/M=;
 b=ro7UhdvhjqzCrX+CknSEodyli0zi9zYtIwGJ+ZRle5BaKuuXmzv1L06aqftbps16Nh
 6+qNApFuMWII2u478weYI4qztSCh2WUDsnSAnIqcdH7K/O7BGiA7KgLct1PKUfQhlEqE
 QB5dqaw2yE9U9Bj0ofb0XG0AFm+0qLBhJYievHWQ/4QBcX1kimVZn/z9V8PkxTDft29m
 Fl/5n36twveIQr/fhS0AaYBFvQfDx5V43hSHFgunIlQZwXqXj7b6KLCD/0v6FmBER4f1
 +G7WnfqEa9Rh5l5XJu4wU73JA2qLEntRqIJFeTPJHbGMdt7kSsefNeVaLRTvi7S+XrKX
 rlMw==
X-Gm-Message-State: AOJu0YwNmkLYeuEZL6dwo/OgLgcRLLJYMBU5xFa9wvzd0163PNaj5Gzi
 IhgZxh6ngvSjRzw+aWp1h1a+AoSFJR1hXu9Tg4aVh60wmAajvepaPu1agBi06AFQn9W/KFd8NXy
 l5XlDRl0=
X-Gm-Gg: ATEYQzyQbBVVKr/LPwsisY9Z8w9UPKiiIwq2wDuQWGvpJHSFYsoUTw1b521Oxl7E/+3
 fXgmIAXIfo7kP8otJOkVg7MW09oCiRCpoKb+Xxxdi/mSNPisi6CYrdggSFzKaYkmzu51kw+IbKa
 OZQQ84+pFe6q4QLeFaGASbKX+sWQ/bfa9Y+DQ9jV0TYnsSgd/qJhG3OY6+PqOuz8ulUkZ5SRlpE
 zVT30/P3qkx/bWD9XeuNVe7gScP5UJ8uCR/KgcGbfVqP/ri7CejmGJ1hb26zD6hiF4EUClrbtCy
 huE0OH4afGKexkw2BcJoqMVW2SSMvoSL42HK5OBhtdgjEmxoEO0tPmQhYrfLPYQE1k8sp8c/KI6
 Nxce5tdyzhh1sI/pP6I9aEqBGwjAjuycCrED1f4Kxc+s2k/rrDbnDmXEvR8rW1RfsqoNq+TkydE
 8FDs76az6u3Ohb6fyj14ZmX+KN8UAmH/2/J75hJyMHIlb/pQ9D4lE0a8HX3YR6tbYZibBxg8t/z
 vzqLXYM4QCMErhVnLuG3GldAP7FGqCgp/UC09CgMgANmbev1Oo=
X-Received: by 2002:a05:6830:67ee:b0:7d7:58b0:7687 with SMTP id
 46e09a7af769-7d782435dbemr11504898a34.7.1773710675029; 
 Mon, 16 Mar 2026 18:24:35 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac328b9sm13081342a34.1.2026.03.16.18.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Subject: [PATCH] usb: gadget: Move USB_GADGET_DUALSPEED to be slightly more
 visible
Date: Mon, 16 Mar 2026 19:24:33 -0600
Message-ID: <20260317012433.4162524-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As exposed by "make randconfig", we have an issue around
USB_GADGET_DUALSPEED. It is possible to select this symbol (via
SPL_USB_CDNS3_GADGET for example) and so have an unmet dependency. As
this is a hidden symbol, move it up within the menu.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>
---
 drivers/usb/gadget/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index baa2eb61ea33..a36be818a68c 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -44,6 +44,10 @@ config SPL_USB_GADGET
 	  Enable USB Gadget API which allows to enable USB device functions
 	  in SPL.
 
+# Selected by UDC drivers that support high-speed operation.
+config USB_GADGET_DUALSPEED
+	bool
+
 if USB_GADGET
 
 config USB_GADGET_MANUFACTURER
@@ -179,10 +183,6 @@ config SDP_LOADADDR
 	hex "Default load address at SDP_WRITE and SDP_JUMP"
 	default 0x0
 
-# Selected by UDC drivers that support high-speed operation.
-config USB_GADGET_DUALSPEED
-	bool
-
 config USB_GADGET_DOWNLOAD
 	bool "Enable USB download gadget"
 	help
-- 
2.43.0

