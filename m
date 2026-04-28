Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7B1FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 20:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3ADC846A0;
	Tue, 28 Apr 2026 22:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="kPJp3tGO";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="IvE5AdB3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DFEF84612; Tue, 28 Apr 2026 22:25:26 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1191C8466D
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 22:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-z056.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777407924; 
 b=ITS+kGUiK1H39OM0btO8muPWFoAdL3JwOnV28UfpsxyIGeljJwUeWO9/vyEZhbx+JeBazz7vp6
 Afa6L5e9hOcH3L2jA+KaUgrwgnwGOurSDXY46NRxxmDPEtZ6MyHdd85W+oFfr44OhHik9E8NQy
 t0BQpGvvzUw+P/wMpRN5QPQCEK/QWQ2XBxdQRRlrrbV+OllIehHsEdK56IzPxe2PPawnWzxlGh
 MMSDLgNclRPEzFxqJSLMzMB657pzT4sD+774yf4XsYV7X+lJAAHxN0FMaEjXsnkkVQNNOslIsk
 JR6+GRrhIQzaKAzdc0oMB4heRh0tlLiTea6SNSjKrz/foQ==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-z056.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-z056.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777407924; 
 bh=TL/AykIJkCnIlOoxVXc6+bRPLd1wcXufd0QFIXyDxWk=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=TxSw5kEKXvXA9ngRsQFZQwrXiJsTmf684DP6LT15Sf2R5TRGYWX190i9Bdl0/uRb2Tu1xSfnIV
 VuLCTu97HtKL2SMI7b7K7JxW14/KVmkcxfAs0XhO4Gkdlk9dEq11iTJ7PUmpheqAfUjxE0OIB/
 YBSPFh7lt810djLfcWMPRiAxotj00OkgyXbrPwKY+vVK1rPO3HY4jcK4SHVrnhnyb8B9hnVIhs
 juG35hbsbLL/+BaPNlTIPH9AHsDYI5YQZZ/y8spQuGCuMHTj8JUo51t2j61/y4Dd4ntZd1EyDO
 LAS1nSD+rwX6XVBV2lCexjn8d3FwaTkPhC7Dm5ilHlqK/w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=qrweVbuT0ePxZDmBQw65J46lYUY7sKoAXz5s5yonTYw=; b=kPJp3tGO5BPZ3HWRf/3E6aWBcS
 vdHc6XgHT2fWTtbw2xGHLz0qxEoLiRMxxQ2WkAuR1FVeLc5K9Yo7HGlw3jBu6k1JPb7Al1nIuj4Hy
 6p5L6HrPfdGxK5urK3WxIp19igpUPRLgw+TQXaYkUXiErm6pjZSg3Y5Cg7LGFCJGUyhI=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-z056.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wHozh-000000024mB-0xaF
 for u-boot@lists.denx.de; Tue, 28 Apr 2026 20:25:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=qrweVbuT0ePxZDmBQw65J46lYUY7sKoAXz5s5yonTYw=; b=IvE5AdB3wbssMJ5gJuISKib+Rj
 Gd+xTuJsuTimnnuRplV0q7Pjh6F7bgSoWKhKgwUcyn3J2gesmvufkedH9NBHGgq9ro7aJX7JDu8cy
 5FII5Iecy2IzovdpEnzZL9qHs+N+dugwNmkR7Xiw09kWeR2xdNCLeSqx5FNxf2eyMLhA=;
Received: from [95.248.129.24] (port=64167 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wHozJ-000000002Bh-44I5; Tue, 28 Apr 2026 20:24:58 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 28 Apr 2026 22:24:42 +0200
Subject: [PATCH 1/5] boot: fit: fix FIT verification in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-spl_fit_full-v1-1-dde63beeaab1@valla.it>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=francesco@valla.it;
 h=from:subject:message-id; bh=TL/AykIJkCnIlOoxVXc6+bRPLd1wcXufd0QFIXyDxWk=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDJkfxaeHnTp6rPLx6Q//fEqVGNqf/BKVLPNYsO/Atj9Rl
 1nTTcMZOkpZGMS4GGTFFFlC1t24t2eu+be0DYyPYOawMoEMYeDiFICJBGkwMrzRqnR54PQwwXD5
 lkrGwIesr/mPXQyaYflJZeo9c+Wlt1wY/kfFWm3b8Wqz9z/Nx8s2aHsci4x7X3eUeUKL7GGFRXX
 FmrwA
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
X-SGantispam-id: 241d769cac582114b661750ae48d3df7
X-AntiAbuse: ID - 241d769cac582114b661750ae48d3df7
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wHozh-000000024mB-0xaF-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-z056.prod.antispam.mailspamprotection.com; 
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

Align the behavior of fit_image_verify() called in SPL to the one in
full U-Boot. In particular, this function is called when both
CONFIG_SPL_LOAD_FIT_FULL and CONFIG_SPL_FIT_SIGNATURE are set (which can
happen e.g. in case of secure falcon boot).

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 boot/image-fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 2d2709aa5b16..9aa165a38cd9 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1439,7 +1439,7 @@ int fit_image_verify(const void *fit, int image_noffset)
 	size_t		size;
 	char		*err_msg = "";
 
-	if (IS_ENABLED(CONFIG_FIT_SIGNATURE) && strchr(name, '@')) {
+	if (CONFIG_IS_ENABLED(FIT_SIGNATURE) && strchr(name, '@')) {
 		/*
 		 * We don't support this since libfdt considers names with the
 		 * name root but different @ suffix to be equal

-- 
2.54.0

