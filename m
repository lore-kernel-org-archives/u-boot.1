Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D60C369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 13:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE9FD8402F;
	Fri, 11 Apr 2025 15:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CCX9s0Id";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1040E82B5B; Fri, 11 Apr 2025 03:10:45 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D73AC82B41
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 03:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d46ef71b6cso12476295ab.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 18:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744333841; x=1744938641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uTWhiRbwxpbrXM6hdPwbVcKtMZgX2GqWVeAAsgp8yJY=;
 b=CCX9s0IdU8nt3EJezy86Z6zokwYL4L+RjQurn7aK90bbscQtoyl2fEsd9GaV/VNJme
 uWtenFT9mQbqhfydM753xMnPm697AmuKBPNnQbtVgmntrV4kOARJ6xE14NgY+hrldkwD
 Z81ZM0iW8AKGBsQAiFpKM6P47GUJ27Uwl+zEXW0sJmQhr4kvavc6y14NRdgNnitI9aSg
 o2x7A6IJ0IvHNpkGFQXVcLeOPe+s3zeavR6Jxt8t5BloeI/6bWgUSNM4BY5ie9tNFWY9
 tiV+xwDQDkcvPmmx5NwDCBjUBq+seK+/ZM9XtELodD3oGeO0CG5/9rc5WqosU3Oqb2Dc
 McYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744333841; x=1744938641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uTWhiRbwxpbrXM6hdPwbVcKtMZgX2GqWVeAAsgp8yJY=;
 b=MEnnKKnnuFLMY4rpvL5mnzphcSnKEJMmhU/h2QbDZPBa4XwV9uRceRFnUj2rMJxwnK
 7sXwyHDOrp3szGlzRC9h9by/QFdxRP+VIvhPxszxrKX2aGQ7VFR0vV8xOPmOrZU3RIqp
 1DT4PWZeibJ499nxI0Q7Wnj3g+QwMBsyMdk8DmpV+CBUvQLRXg26bJNJNgyUsiyTbXax
 eY91w2aHfsN3HA0+JMXtS6Z2jH+hbvmKwHgIjVj4/Xt3IeDqCD7mKr8EFQd2MfB/w0hL
 VpZKsIQiuo6ScrKwR+tZbB4fVPecOJHwgs+DUqNS+vpqf7MK0dLErqoJMGVKs0GQeEHk
 JGlA==
X-Gm-Message-State: AOJu0YzZX+tbtn9q6UsfvT5Rgu/deBuV0QLXiXPqk480uNiZIeM7Ob5r
 A6O3hBgaEjwIB6/e7STakqsqeOkrGPdHAiKqBpRbhDAokgyZNbrsXP9hSw==
X-Gm-Gg: ASbGncs6MwBgRez+cfiWjtomjtdB+hA8jlAcWC+q33qZb7slM5mc2KAltXFdC17wOBZ
 7OQ5LjFgahAzBUXqHBfgI/jRTv3MqIamor03o+cnqNmOCe0fIB/LL+kRzDkt/CFBGky5QPeahZi
 cOsGvivNbE/HluXz5BP6YgftdbdDIkhTpOriH/eMTZ90Bgl5mvQBRLjPU9Un0nGRmbIQazXYQqZ
 uwwgkJnLmMOlWkycKsQ/R+9VX5/LaoovXx6Umz2GSGwf2Ql9XIupVrOKO5KSr6v9r25eB1PTESN
 EwgB7huB2kSo9Q/vTl4hfhfZpVoBs6plODJHAeeguZFZlnEKwXpfs65CHQhx23bXTE4mXCvQhvZ
 FE+9Tkb9WOmoE28kpENs=
X-Google-Smtp-Source: AGHT+IEiR0/VROYenply7kw1IFqBGxMGs5fwACIKIxV2Z9hmwAxDY1RcrJNoZbbS67Z3IIB8eV1CSA==
X-Received: by 2002:a05:6e02:248f:b0:3d2:b72d:a507 with SMTP id
 e9e14a558f8ab-3d7ec27b158mr11849615ab.19.1744333841349; 
 Thu, 10 Apr 2025 18:10:41 -0700 (PDT)
Received: from james-x399.localdomain (71-218-109-184.hlrn.qwest.net.
 [71.218.109.184]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505e2be7esm983717173.109.2025.04.10.18.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 18:10:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 1/1] Makefile: pass KEYDIR when set to sunxi-spl.bin mkimage
Date: Thu, 10 Apr 2025 19:10:25 -0600
Message-Id: <20250411011025.1434660-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 11 Apr 2025 15:04:17 +0200
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

Currently we pass this for u-boot-spl.kwb targets, however when
building sunxi-spl.bin in the TOC0 format we may also need to
specify a KEYDIR, as such we should also pass this when set
to mkimage for the sunxi-spl.bin target.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 scripts/Makefile.xpl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index abc49fbe6c9..d1c1cea876a 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -445,7 +445,8 @@ MKIMAGEFLAGS_sunxi-spl.bin = \
 	-A $(ARCH) \
 	-T $(CONFIG_SPL_IMAGE_TYPE) \
 	-a $(CONFIG_SPL_TEXT_BASE) \
-	-n $(CONFIG_DEFAULT_DEVICE_TREE)
+	-n $(CONFIG_DEFAULT_DEVICE_TREE) \
+	$(if $(KEYDIR),-k $(KEYDIR))
 
 OBJCOPYFLAGS_u-boot-spl-dtb.hex := -I binary -O ihex --change-address=$(CONFIG_SPL_TEXT_BASE)
 
-- 
2.34.1

