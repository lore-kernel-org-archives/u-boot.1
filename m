Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F39F43857
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 16:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31D1E8429E;
	Wed, 15 Apr 2026 18:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="MKyHZ2Ly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D32842B6; Wed, 15 Apr 2026 18:04:05 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC8628424E
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 18:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488afb0427eso83206995e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776269040; x=1776873840;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EuONaSG+lMLRa2oA554ImlJ2y/z/OKdI28p9VCThWDY=;
 b=MKyHZ2Ly0XbQkW4g5Qt3G0r+wC4QmC6TEHcl1cz6SPTtU3Cfi/y8yt7R7GGx+/fJZs
 ThfNGplV9b8u8zJWoTbx+dTtkumcPt5czVkg+HaAQYx+jxCcyMAksgCPanLHg0WItVbQ
 UtKIgjSRnMnyaEGdM/g37FKpJmaVUyexMCCX251gXSN2utUVOJ0yWn0l0/uwQCghHRuA
 W7ZrX0gF6oANG5LZ4ZI6juSIm3v6fNLeEwOkI4ZqgKLOno3dCOxiOeO1JFOAMQw7iZi1
 KbemljPe0ld3nw2f309efwBmN477zzSeITqqbEJKLgKuWR7wiJxBb/M+/MTtt6tDEzz5
 01WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269040; x=1776873840;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EuONaSG+lMLRa2oA554ImlJ2y/z/OKdI28p9VCThWDY=;
 b=SNDnrAxMPlvmTM7Pa8fb1aTUoIzzeUTWOS0RTcGRpq1HBOs9NeojqAAfH8TlRA7b30
 FtMy9nEvRmcok8eiAu7YyViGqV561dq3KAD5wXV1LbnTv9cQSjlHGBWJ3Tel/loRDp9G
 66iikp8spqD+AkH05yRT8/z5bTUq1yrMi/Jyg4gaW1GTanJR7YH5lDC+uvzyj08xshU1
 jw6Fh1QjUU14vXxGvf7wt1YhFKGwSjm9AI9sKpQSOATXrAzaq65ZVByTD5AZGRIO3Ee1
 VCR5S0g+VrTjRiwaD6ir8Kk885NS54DvyN6wF+5DpxWz4xKAWIdYtxPqPioaAjb9OQy7
 dE0w==
X-Gm-Message-State: AOJu0YyyGnGFDRbtpkW/HXwG4Szgnt1WncOhKmKQsldsjHImd7nERE/b
 8AoDxvPgwuB5Iq+/Doahess0GMwayimnoxEuTWpwZCQYQXRqpZosXwhr+z81WB1CTi8=
X-Gm-Gg: AeBDieu7LAIVnKfsdMLGOvh3GzmcWr5WnEaukGnOdjLgyCyOIbiozLq+2s4XLL9eEgI
 fk9CVKZXDWuPN3s3r/PJEFGjkIrBXX4tQnVNE2bMH5VEvaK9go1z6kLZvaKaXlq6neb/cK6p2B+
 qifo8KPjODEHmUCUpeB5mj4Oye/5muRzN7OMgaBhqlPdc6njMvzAHdV7s+q0sLYKECatS0Gwosb
 j71rAaJWvknLfz5FfXDrA/+dtXnYZWQ+IYwMZXM+UA9cH0sgOfBIx3YIL0G+pMy0zPkphKLK+U/
 kmok0aTVJ71tdLLLbMD5uq69djd9LN4BY/jlocQWhpRrcFFp8jhCyIfzYOfPPZkBo7lL+r5fm5V
 A0G0m4CVThWkomNXrSSJ5NX+e/mOnfq3FUso9CMqGaEA2E/pWBbQ2UDfR3W+lLBz52dY100ZcJm
 u9tT06tSGlWgkrwIxaVZW97btUmfcuTDc=
X-Received: by 2002:a05:600c:3ba1:b0:488:90ac:8f71 with SMTP id
 5b1f17b1804b1-488d67c704amr324744445e9.5.1776269039987; 
 Wed, 15 Apr 2026 09:03:59 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f208572bsm59154565e9.15.2026.04.15.09.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:03:59 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 15 Apr 2026 18:02:30 +0200
Subject: [PATCH v6 09/14] am33xx: Fix comment about config symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-topic-am33-evm-oftree-v2026-01-v6-9-94cde349bb01@baylibre.com>
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
In-Reply-To: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
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
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=msp@baylibre.com;
 h=from:subject:message-id; bh=5Yykrkd1oSnyX7pm49x9FHg9Z9WPawInbezFIX1wlQU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz72w7oSa045xT9nctvmeqPmTHRsXoVmkF7pD57Hb0yQ
 XOzSDJ/RykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEwk7Dwjw2odm7DcF8Yqt0+c
 W294ctZayaJvBxq05J1+zO1+by7Ab8zwV2JNyTH1XVrmq5OkDQ4wcUULnPXPeRN9a6qus6+ATNF
 RZgA=
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

