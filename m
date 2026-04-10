Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BE7F4485A
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 13:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34ED084222;
	Fri, 10 Apr 2026 15:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="v2l1KL3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADBA284099; Fri, 10 Apr 2026 15:33:05 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C39898421E
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d01d6b50cso2043213f8f.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775827983; x=1776432783;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EuONaSG+lMLRa2oA554ImlJ2y/z/OKdI28p9VCThWDY=;
 b=v2l1KL3wlBv+7nsp/KaFUtK8obfn2q003cXYzwNUTqjQRn+AKoXQNtg73BkuX7h3E/
 YW15XRzphj51NH9As/WAHCFjImUvnDa5TnwAcah0PpKqXTiA61FEyBzgZfgv047XhM+4
 k3IiUUjeO82YGf1nrmuywHpefLehtMO3qa5IYs2ftcaaslBzcMaxlz9VmMrEb+da125W
 8fPP6dUEFmo+KiItjzq4XZgzJxLoCi2tdvMFwxTtfHLCu3e7vRqQOjogcahnKTnWl+pG
 9VFWqfbUJ6j91Kxon1hQnpTRq4y/R45KB6kthOUUnhCYYTrv52xsGIgMUfkjEWEeAYfE
 4j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775827983; x=1776432783;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EuONaSG+lMLRa2oA554ImlJ2y/z/OKdI28p9VCThWDY=;
 b=JOqqSHNW/fRDuhrkP/sDdD5KYduZBmWYXEkZGRbC4jr2Festt++8Mi2BfMjZYG2y56
 NVJzrFe7RLgfXkMLn5VBExNZW1QUm+vIs4howU6+Dbj6kHzyBkFqu5wBdviZ6VzxYEG2
 lS0ZU1mmFBjYuYKh/E0dHqbaYhnTE3dOrq5kVBb2k0wCh2DkWlv7VTqgiYf53lP6TzrJ
 RF5lsZJhNB+dgBwNKqov1EJxVD9KjeOjxyoc6CtdbBcrt6lSN1/omciRziJWXnelRrv5
 BT5fs2dHNUW1Ae2DZy4o6Njmei0mifuQbkSgyRe5h/COIyAgPikiLyA/xvgImX8mZhaA
 ZGaQ==
X-Gm-Message-State: AOJu0Yy1B2hu0f6fRMNXPhVP8W2lM0JSBy607GxGexM5sPYc58k5Rkwz
 S3o8TIEfP5J0Cj5ZE9GiRLvMfueJyY6R0JVwZE/jE9dX4CkQEUc2KiTN2fNoX7Nklio=
X-Gm-Gg: AeBDievdQLSJgVLVEsatS1sQnJPW/sRgPYzQBN+480FfAstiBu5sqmRYkdNduEcbuXZ
 UqfCHO+nuz77e16UOyNHQ/gD0EayV5Wf2AbAEvYtgUbswsmmjPfiRQodVkw7eUEZKcotP+ACohh
 tmjdaEN7OWRiV4AqT310M0cJt9/TUZ1sY2G25s3UnLPLeeSVPpoSyuwYPizuR+SmCnZvzYE7698
 D5VXGkBp18HDTpDNL41W9QnYj+0dJT4kVPVoTYS/FQ/Jk3dPB3O9k70KpOOzIQr2AftRpDJZ/sC
 0ZvYnV351qd8/JVPm/7B/XIqQG0w+ket6KTNQvqGrkCQjk3+WKeF1cFQKkEfwmn8XOe9BJMIq0/
 A8hVXM5zdXaRYKAkVhNJPXqO6icgvWgNSHW//xv276uymd3Exbx8ZlZzmwfHtKRCWPC8zq6Xic+
 /Cdtz5C4c9UY9ZKhjmBNal
X-Received: by 2002:a05:6000:178e:b0:43c:fa96:d921 with SMTP id
 ffacd0b85a97d-43d6429b694mr4824391f8f.15.1775827981758; 
 Fri, 10 Apr 2026 06:33:01 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63dec3b6sm7282790f8f.16.2026.04.10.06.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:33:01 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 15:31:49 +0200
Subject: [PATCH v5 09/12] am33xx: Fix comment about config symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-am33-evm-oftree-v2026-01-v5-9-4b9c7aca0e3e@baylibre.com>
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=msp@baylibre.com;
 h=from:subject:message-id; bh=5Yykrkd1oSnyX7pm49x9FHg9Z9WPawInbezFIX1wlQU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbv1/nFxntT+HdlTN3Z5m56C326fLfbvQubkv54DNHv
 u9Wt9izjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIuv0M/ywW7j4k9in25tNF
 kRd7J18Itbw5rbZ3e+89c/P8k5X7BZwYGXafMt/yx9R0YrNR4inLh44lxZM3lGferxTqczq9VU7
 PjgUA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Fix #else and #endif comments to match actual #if condition. Comments
incorrectly referenced CONFIG_USB_MUSB_* instead of CONFIG_AM335X_USB*
and CONFIG_XPL_BUILD.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 90b341303c7309dc21b34cc01020db997f53c8f3..c3931900622957a5499fe6483473c61e3a62fff0 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -259,7 +259,7 @@ int arch_misc_init(void)
 {
 	return 0;
 }
-#else	/* CONFIG_USB_MUSB_* && CONFIG_AM335X_USB* && !CONFIG_DM_USB */
+#else /* CONFIG_AM335X_USB* && CONFIG_XPL_BUILD */
 
 int arch_misc_init(void)
 {
@@ -282,7 +282,7 @@ int arch_misc_init(void)
 	return 0;
 }
 
-#endif /* CONFIG_USB_MUSB_* && CONFIG_AM335X_USB* && !CONFIG_DM_USB */
+#endif /* CONFIG_AM335X_USB* && CONFIG_XPL_BUILD */
 
 #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
 

-- 
2.53.0

