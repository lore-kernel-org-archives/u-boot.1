Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A372CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 12:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 245CD84A12;
	Fri, 19 Jun 2026 14:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=maquefel.me header.i=@maquefel.me header.b="XU1+gamB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDFB984A26; Fri, 19 Jun 2026 14:53:29 +0200 (CEST)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net
 [178.154.239.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5CAC84A12
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 14:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikita.shubin@maquefel.me
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:99a0:0:640:85e0:0])
 by forward100b.mail.yandex.net (Yandex) with ESMTPS id AD7338071F;
 Fri, 19 Jun 2026 15:53:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp)
 with ESMTPSA id HrSguQJd9Gk0-wfEWzezD; 
 Fri, 19 Jun 2026 15:53:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1781873606; bh=okLx7OjL0U8JWSOfsrYma11V2mgcY3v1Jz6sFQxvfkw=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=XU1+gamBisR76yVIXs2cJZi5k2Xh/vjVYwXH52QZzH83S/KaEXNXvbARPXYcLVoT9
 3JF14oHtF1bj18H4kbEvLo5/su/ymPRnOpocceOHn2kcBYcmVjcTGIfTmuaBn55TpZ
 zvV0Uf6ud198DMrwlM0UijP2bh3ZiGrzSR44wgcQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 19 Jun 2026 15:52:57 +0300
Subject: [PATCH RFC 1/2] image: fit: allow IH_OS_OPENSBI in
 fit_image_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-riscv-full-fit-image-support-v1-1-c6477cf4f410@maquefel.me>
References: <20260619-riscv-full-fit-image-support-v1-0-c6477cf4f410@maquefel.me>
In-Reply-To: <20260619-riscv-full-fit-image-support-v1-0-c6477cf4f410@maquefel.me>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <ravi@prevas.dk>, Anshul Dalal <anshuld@ti.com>, 
 Michael Walle <mwalle@kernel.org>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781873599; l=945;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=DC0YH0ljL+P1wYFReFz9n1k2346OIhdDwrWcOHecNaU=;
 b=wiYb1UsPuj78Ve4DEtTYBUlLUE4muunfnpJOGQaR81pjXvSnmqZ6Y9dJrHtsDO1FxzBQrKjdI
 QicWSmiH0Z3AeJ2dqdz0bLCE//wcj1TiA4fjug9i7mESnrqmRX1Jw3W
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
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

Add IH_OS_OPENSBI to the list of supported OS types in the os_ok check
so that FIT images containing an OpenSBI firmware can be loaded without
error. Otherwise loading OpenSBI in full FIT Image is not possible.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 boot/image-fit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..458df45ea7b 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2204,6 +2204,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		fit_image_check_os(fit, noffset, IH_OS_U_BOOT) ||
 		fit_image_check_os(fit, noffset, IH_OS_TEE) ||
 		fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
+		fit_image_check_os(fit, noffset, IH_OS_OPENSBI) |
 		fit_image_check_os(fit, noffset, IH_OS_EFI) ||
 		fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
 		fit_image_check_os(fit, noffset, IH_OS_ELF);

-- 
2.52.0

