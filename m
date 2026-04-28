Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432B8FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 20:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6222B846AC;
	Tue, 28 Apr 2026 22:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Pqz6/Gep";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="mf5yOlpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B488467A; Tue, 28 Apr 2026 22:25:27 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D79C884687
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 22:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-fh50.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777407924; 
 b=W1rIjnKTODt+byIfkw6vIvF9E6g72ucPpZZ39yzmXrqrl5eYVE4Zm2r+tr/WXYomzgGaVYk/7m
 LXPin/GfebGdwP8neKsCqMRDIguNEYLXnuEh1H05vZ8mOn04NXmmn/lJWMVWySGUJFW/w+x58u
 pu3YWfsSMhL64gHkADxee0PB9C90NH56hc5Xq5ngictYmWP9atvFieixWtIT9SCKYxZxznd1Dk
 X9bePp8YrORX0xp2yrMtUpnUx5U7VMRXbL2lSlhsPemCxQl8Jre1POp1EO3BEDUOk7Qo+18lso
 kiLzUlaCMTAVcvjo6w43PfRAwauwr0pcRb5HpWW6Rdta/w==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-fh50.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-fh50.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777407924; 
 bh=kLiTZHQPHoHZHRSuQ+rBFfNN4bcx52MMED4PjMnx64k=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=D5c0NlEY2EVnVwyR/mGP7YhGbtfpA0bXkptXeeGyzAkPsmUGIpV4MQmSBZz1HyEV8brz0/e81b
 H005j9tDhsQj/6LHkGsh3wpzuzZgrZvlWqLnB4c593WP2ZxeGDJ/XXfSVh2hhHG3/5bkJSRPua
 87OvnPr4lR7LQOTYiT5eKerqS5Z4u3XLDRCq1i+UxUJEghqeYpmuJ7aDuHnzwKm3fTRgt7eOXd
 a2IuwmP5Dpz0bGqw4umIHCiV16PxLaVIb8MDLBY08MI8Nj3d7wIHDZkGXyXsNTzjv2EXfxeICk
 9aoqyEfKdkWL/G18G7Zezw6XylhLPrGPSlgijeQd/cSHAg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=U3jdgXV8LVJawgNt2EHe6KBeotwTlzyQe9xFp8Plj8k=; b=Pqz6/GepTJlg6iMv/87SPpZaXh
 wbh8iek3Vxx8AFvRODYVZ01dwsy2n86jLicJZe4hn+mnGtmX3hvyDOkWHqS8Jig7FGzbYSfSXm7Du
 xq/aa/6UtlIt7DbBpghDm8v121rbmE2WW07YJDA+vUbJ6QvtPyk1PiDs/66aq9Fq3fV0=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-fh50.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wHozh-00000006wWx-2t6u
 for u-boot@lists.denx.de; Tue, 28 Apr 2026 20:25:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=U3jdgXV8LVJawgNt2EHe6KBeotwTlzyQe9xFp8Plj8k=; b=mf5yOlpdTU06VBZ4oH2yMJHsCz
 hqt/irnUci5w+ULDc5gS4A11uKh8huLYCUscNlknXcNHBQfv4URnzD5Bu96EXP9vClt2Z4CPXcwit
 5mL1ffRUHeSjRTHGf10R8SGTURK8xNnzn/ZCgRJ/OEfnx9gKkrUd0BUTPIeVorhngnvQ=;
Received: from [95.248.129.24] (port=64167 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wHozL-000000002Bh-0ff1; Tue, 28 Apr 2026 20:24:59 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 28 Apr 2026 22:24:43 +0200
Subject: [PATCH 2/5] boot: fit: decompress kernel when in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-spl_fit_full-v1-2-dde63beeaab1@valla.it>
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
In-Reply-To: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>, 
 Dhruva Gole <d-gole@ti.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <ravi@prevas.dk>, Michael Walle <mwalle@kernel.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 David Lechner <dlechner@baylibre.com>, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=francesco@valla.it;
 h=from:subject:message-id; bh=kLiTZHQPHoHZHRSuQ+rBFfNN4bcx52MMED4PjMnx64k=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDJkfxad36FidLzURye6cbnJRYOu3Kl3V2feLGw4yfZ6zf
 V+jTUtjRykLgxgXg6yYIkvIuhv39sw1/5a2gfERzBxWJpAhDFycAjARRXFGhlcZczusvjD/OuAR
 p9Ra5nUp4Eb6RalJp4zKE3db7fC7f47hn24bK4uu08G59TcO1792sj7+rb3B+uSDItcte/qsufM
 4mQE=
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 2635baf9abae5644e309f13066cb6682
X-AntiAbuse: ID - 2635baf9abae5644e309f13066cb6682
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wHozh-00000006wWx-2t6u-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-fh50.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

During the esecution of fit_image_load() in full U-Boot, the kernel is
not decompressed as this step is typically performed by the bootm
command logic afterward. This is not however true when doing a falcon
boot from SPL; enable the decompression in this case (i.e., if
CONFIG_SPL_OS_BOOT is set).

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 boot/image-fit.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 9aa165a38cd9..f3ddee940dbd 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2291,9 +2291,10 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	if (!fit_image_get_comp(fit, noffset, &comp) &&
 	    comp != IH_COMP_NONE &&
 	    load_op != FIT_LOAD_IGNORED &&
-	    !(image_type == IH_TYPE_KERNEL ||
-	      image_type == IH_TYPE_KERNEL_NOLOAD ||
-	      image_type == IH_TYPE_RAMDISK)) {
+	    image_type != IH_TYPE_RAMDISK &&
+	    (CONFIG_IS_ENABLED(OS_BOOT) ||
+	     image_type != IH_TYPE_KERNEL ||
+	     image_type != IH_TYPE_KERNEL_NOLOAD)) {
 		ulong max_decomp_len = len * 20;
 
 		log_debug("decompressing image\n");

-- 
2.54.0

