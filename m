Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9D4E67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11D908910E;
	Sun,  3 Nov 2024 01:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gfPE3x02";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B252089118; Sun,  3 Nov 2024 01:35:18 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F2E289058
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ee11ff7210so2272296a12.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594114; x=1731198914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jdss8yE2/awIEEy86I7YaeWMYJdbjKgylXCFi3piogU=;
 b=gfPE3x02e5mnxczl1m5306sLVG8QQa5nsLeDWVX0Ucl5C5OPDpMZCt2qmaUgqSbe3i
 G4qkPDldIhf2NsYNoGw+Hpr0sq+WSc4ojiN2DzeSIdoX0NLi5rAG/yRz3/DU74HuqNrr
 fXdugPM+xDdkC0thNgbRwPDhDmZOlt58IYiIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594114; x=1731198914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jdss8yE2/awIEEy86I7YaeWMYJdbjKgylXCFi3piogU=;
 b=hRcs/QUYp4cyvhfRmoo3wNdyi07EFi19qAQP4KOq8C92IDJHWBlq1zgdOhCHJt+cvu
 LANvEMAEWg3AsUVrBXgBQdC2ntg/le9BtCnFiwNj56NyPWNUP5T0wj2K5TpC7JEODy74
 yepMu6/c4kFEM7Qm0Zt8yK0Kolcubo4vH/p/QhNcr7utjZeQ2hTXy954NVmsHgmV6x5Q
 K/NIsV1CRmQ/RVxB7ObiHo0K387XJJRIahbaIj7pramF6JpCM2/c0HybdLvJY6tqK4wY
 94DRikWJBkkp2yPJrzTgY71+Rvt25Ggiyv9QuUgYMS8w6LFMxDt+RZekiB1N5vwn3Br1
 /EBQ==
X-Gm-Message-State: AOJu0YxXsQ8khf4nfd2EFa+cfFldK5xKECLAhpn5qXqy4Def7vckuDa1
 ZPMOYwa0+x66XWsCKJnPyWpvTzWF4ZYCbuA5677J8bvH2s7UyvCFGJiTySEV16qGfmnXarrQY+R
 tJw==
X-Google-Smtp-Source: AGHT+IH3JD9SwKJlpKaZwEIoL+67l39Jw901S05ulgcle3FytjDshIXBl4dvCeoi9wnJj/XUSOBLnQ==
X-Received: by 2002:a17:902:d481:b0:20b:6918:30b5 with SMTP id
 d9443c01a7336-2111af5a6bcmr102263155ad.41.1730594114470; 
 Sat, 02 Nov 2024 17:35:14 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:35:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>
Subject: [PATCH v3 06/25] arm: Drop old LED support
Date: Sat,  2 Nov 2024 18:32:58 -0600
Message-ID: <20241103003322.626036-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

This has been replaced with a new LED framework, so drop this old code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/crt0.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index 3e4906e273d..a691d844847 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -185,10 +185,6 @@ here:
 	movne	r9, r0
 # endif
 
-#if ! defined(CONFIG_XPL_BUILD)
-	bl coloured_LED_init
-	bl red_led_on
-#endif
 	/* call board_init_r(gd_t *id, ulong dest_addr) */
 	mov     r0, r9                  /* gd_t */
 	ldr	r1, [r9, #GD_RELOCADDR]	/* dest_addr */
-- 
2.43.0

