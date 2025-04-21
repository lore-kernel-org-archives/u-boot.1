Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64863C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B10381E1F;
	Mon, 21 Apr 2025 18:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="APQbHskQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29D9B82006; Mon, 21 Apr 2025 18:26:26 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32CCB817C4
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 18:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C973741A17
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 16:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745252781;
 bh=ncoaB+r90aBsvI03KmzpaPWWDVZE1e/ygZxpnKWell0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=APQbHskQAj2FXRUFJh3i1VnqGF8bCmNZ5QemPaFOL4Fb2fk3Tgwvr+vIpnH552FLE
 j37j3I9/+s5cKYmSFslVliUX1QOyIkvoytbY3IUmY4+3dEyH0A4OxGqPs+IinVknkK
 xF3e50TiPV4HjcLJYwyZgjB1or0m09b73a3L0Q4oWD0GVDd+UFvpxITl9zcwdU//J7
 ep8UKbaJDNAF4TJ2Cjmj49apkrSfilzAsR7WKsPcX8XkMykHZDSpmPzB/ITjzhnpPi
 D8E90sp/zn48KkzqYBe7RBEap67882l/MCt8xJshIPJrgl3ZatzerT/FoadR2rCTIK
 KCBziyNJJIcyA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso22645335e9.3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745252780; x=1745857580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncoaB+r90aBsvI03KmzpaPWWDVZE1e/ygZxpnKWell0=;
 b=WS7snQ0y3jOkMMwF7rKZnVnDHp5KByzT5txO9D5gMF+5NOCDCHpS9pz/vORSUEbty3
 y8SsoMiJfcgURfXw2exfKtRLJ1hpnBdXJGaVfZ/0vVyb1npM9lwPU3nIZFCYS9OadHkp
 kGG+906niW3oI9T5YG7kvVx6CoovQb6McyHquiAL2nEVQez6Q5gj1uKlZMkaIVrZywY2
 fZ5jBuSp2ScLWYPTKUPvItRVOEtsVnTGvP2VoSWkXEfJcchiCldNdlKxOUb43c38naKR
 wmi4Z4fP/VqHGNkByBXL1z+zr46Os5ybhG7FyNZoTHINDRhunWPtWdCovij0d4hA5a9r
 t2rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6AZUAXFpKSOUT6d3tO4+hB/bLga2JXDTrUNCFqkgG8SOLX4FBjKxrKqcfKcvn8fixoKlOALU=@lists.denx.de
X-Gm-Message-State: AOJu0YxZZ/sllfwvpQHKRmilvAMbFNWkmXh4yZPrjmnMFogX4gZVCPZW
 W/HseX6IiqRJooLVOKFGkLtdPdyTPmIDxCBlWOikV0BupAtBUwmr0Xo0UfCE4TB1rOThkuqok8i
 5vQJltokEVRRaT+sLTKL9T7PJQwd6lFHu6kaCeYVO+gvcrciNMZVYkT8vLeaqM45BGLE=
X-Gm-Gg: ASbGncvOD8Ms7cO2dfiyjjpx7Z2y6ClvnQjW8bFOVnHLrgaApI9hh8YoNoYqUlqLIgw
 jt1ZMyUr1BLVOPsWaogT/W0t9j2a5hAFluGd+AG9/4rFE+xI8US1gua4qYvv+n5bKHriT6O5qmd
 QCeT/OlxfOj5NEHdxVEC7R+tuqBDOFb7cLw5gZXCgaJS0kmjUg2W/dt3m3z7af5D8LWycWaCJPF
 THMt0/JTQDdZ040WaYmyqP1nN/oKlEbcaQOZ3O4BhpxUdxYvkReBlv97zHTwIP80snwIOmmvl4p
 RQpeM5HHC1Cy+eOvn7ICrB7swN6CsMimk4aUkIuDc5iCrv7LWAtI/leTz/zUujHh8j0MLpmtC7C
 85XczdQJeLsv2Fg==
X-Received: by 2002:a05:600c:a13:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-4408ab25c8amr713575e9.12.1745252780202; 
 Mon, 21 Apr 2025 09:26:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE07iJA6IzHtn9Zh1mXpVTo+gN4jaDg1PpCB4S6lhaOCHHq/Znfsm3Neb5l0c5GOxXxmGNA2w==
X-Received: by 2002:a05:600c:a13:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-4408ab25c8amr713375e9.12.1745252779851; 
 Mon, 21 Apr 2025 09:26:19 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acce9sm141456225e9.13.2025.04.21.09.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:26:19 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 3/8] boot: make BOOTMETH_EFILOADER default=n
Date: Mon, 21 Apr 2025 18:25:50 +0200
Message-ID: <20250421162555.1200687-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
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

The boot method is deprecated as the EFI boot manager covers this
functionality.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 71ddb37f6bb..b973d9eb0a7 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -595,7 +595,6 @@ config BOOTMETH_EFILOADER
 	bool "Bootdev support for EFI boot"
 	depends on EFI_BINARY_EXEC
 	imply CMD_TFTPBOOT if CMD_NET
-	default y
 	help
 	  This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
 	  launching EFI\BOOT\BOOT<ARCH>.EFI if not boot option matches.
-- 
2.48.1

