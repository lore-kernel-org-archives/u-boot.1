Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2700D340BB
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 493C5841B9;
	Tue, 27 Jan 2026 17:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pBzj/167";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6729084101; Tue, 27 Jan 2026 17:51:18 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C34384175
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so46247155e9.0
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769532676; x=1770137476;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U6W4HqE9yI+pkEX5/RX/GogLPWlMWTx3fDFgvOQybZA=;
 b=pBzj/167TPYiObYCQJLXPnfFHN54e5vJpxNjpRdnszTN45WkF1+9EIQ6Ll4uz3b/5/
 QDsf633ZuyzxAnGtx96qmydKC2Zaxkl93ndl00WTOSrbgSkBMdqtKZ9Ntp3qo16sZde8
 Nw8IS/t15lLdY5v09HjRHmWByBbyoR334eNHdgTUeI+EeMBeIebbv/wTArfGW3w00l1V
 Tc0GQP/qjKq2Dup5EE6DtS4Qjdfck9LvYh+QUP1xkvN7kzpmSQJ1ygg5HsXcGjNEjayH
 VVlMgdfeOyv0kwnr10P3x+XaPd3sLX6Ey+oPPQun7KEY3NBd7+6Lb5PJ7CsanL11zD9P
 eF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769532676; x=1770137476;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U6W4HqE9yI+pkEX5/RX/GogLPWlMWTx3fDFgvOQybZA=;
 b=RvYvz2jPvqLrIFDzl0lvWI6CF4WUXAxD5p+zEvN8hXg9/bRajx/WP4vng5bQA54Scy
 scrpT1mxSNAQlu6oDqSL8wuT93EpgGcZ0TzgnCEWjAnk581Ykyc3BpR3UiN6KkFB3u9w
 cHzN/Nvpa7swcrnBrzySYX923dcnkN1NLO2Z9N+Rk6l2prg+2OWpn77de5w3WM99gi5E
 wwxo4qcM9Zx6f0b0bKvsIm+CRQpQM+xd7/BlGDnNAjbZCGjkl79Do5RB8NyKbSNDP7Q1
 H9M6cLLXUhuIOA3sTgglaIAtky6CW+CS36uWoalh7/MJWWIsl6a2DWi/vYxM9tv3FpJS
 fVTA==
X-Gm-Message-State: AOJu0YzXLhzd0/7N80rY3LBBFkydaDQGdX0BXml2TXB5fNl5hF1uTjxf
 jq8Lq+S3OZPFFV0ddWU8bzsyjiedvTx/oflDqAYmZil+w1hrGtqjT6Q8F8UxFeiHElc=
X-Gm-Gg: AZuq6aJTKsvGg5pokX9OZdVQM00vDOtOkuxfjiMoKtxZV5HwDl41O6jjKOT519nVjFd
 tBSeczB0WJXbUm2ilxfAVE7nzr58VHzgxbb+2w+IoVq8TK05krPaM6dc9DfEA69BBYG/5iZ71WH
 Ihh4Trl/8MQHH5bzJdBNo/5YVBxojUc1MOGmgro3Oqgq951++QtAY4b3BUm8fH6exqupNTM24yJ
 VRpALTFUueSuM76QH4GmPsR0zsg4hHCIwZ6zZucwN3zss/srpX44Yepti1jzPU4kPJOGd0+iGp1
 FJBR8pzbaWGjU2zulkoH8NMS1CHbnE20r5pd2SNYhdNH3RtxqyLqyorVqpAE1bNnnTMVUBOu73/
 yeYmQ0OldvkOZ0dyZMpAr42FzgjTvw0UrD6Y0nQ3AwsvDv3Tl0k6E4eNry8ZApnDo1OmcLKjC4t
 UOhme5iPHapYEMb54aRxs=
X-Received: by 2002:a05:600c:3e16:b0:480:1dc6:2686 with SMTP id
 5b1f17b1804b1-48069c4a7ebmr28782175e9.13.1769532675800; 
 Tue, 27 Jan 2026 08:51:15 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdeafffsm4315615e9.7.2026.01.27.08.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:51:15 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 17:48:22 +0100
Subject: [PATCH v4 08/10] am33xx: Fix comment about config symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-am33-evm-oftree-v2026-01-v4-8-0dadb0710ce7@baylibre.com>
References: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
In-Reply-To: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=msp@baylibre.com;
 h=from:subject:message-id; bh=GOR6Yw1ouCDvQ1THX7A9qx84hQ8xo0RbLBPgzFeY3Q0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyKN09uNG4RLG7+snTS1BcP3iUqcdmvDztee/ot08oVc
 +8sNtxwsqOUhUGMi0FWTJGlMzE07b/8zmPJi5ZthpnDygQyhIGLUwAmwn+BkWGHiu6cg7zyc4Sy
 jk248qhc/NlUsUUxxqcb1+wRLBRyNzRgZOjnsnu2MkP2dYn99JXVG+QZq0v5qhV8753rWsKwS+j
 fbx4A
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
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
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
2.51.0

