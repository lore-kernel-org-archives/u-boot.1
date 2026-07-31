Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E1EC5516F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAD7B80E8F;
	Fri, 31 Jul 2026 16:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oGIOVP1bNJav; Fri, 31 Jul 2026 16:35:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D195680EE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515752;
	bh=yR7rkBeAfg1SCyFaG8C9GmTTa87Tfy3RLjjpYpiyMYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LDNrbFMUQXnVVNnu5rGPKTSwJZfCgSu9kZR/iPiZkdAvqSGSHrhW0fzW/JMFPujpv
	 v/ST1WCve+GjAguRSibrLumFybKqannFE39ghzHzq5XUaP5bosa576u9k3mVeJgrug
	 ItFrQhnr6H0lIEqAbF6sdgogUZ26f//2f8smVtxZTLefhkEThJtjX/iFMARHBUGd6X
	 nLN7jl1CAqEgPbw52hmaldyxJ1r+N5frSzVkQ6x/DWtdEZZaY1WfTzOosvlnyafZJ/
	 4y2n4yjo0JkBDpWvHCxunyPFgByHEaluOrwW0S33skz9aR/3wi09YcjQncBwaTjs/M
	 t6m8HPvZLJb/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D195680EE0;
	Fri, 31 Jul 2026 16:35:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E35627C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BF6B80D1A
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C1kPscYPehWn for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:34:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org ADE1580DC5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADE1580DC5
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADE1580DC5
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:00 +0000 (UTC)
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-74d55dac06eso639885137.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515639; x=1786120439;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yR7rkBeAfg1SCyFaG8C9GmTTa87Tfy3RLjjpYpiyMYc=;
 b=UhOz0JnQ0WOI1BVumwJ3LZ9BVd+vaXimz+ZABm05RIurSDJ+C+bclDp/FzX7+Gn1Uf
 1xJmsmyDm8dLQSubXmf7Xk3sah2hocUXMIA7Zi7jvBrxYcBvScWJ4dFQdgB4VfEoCnPH
 jR+XClumlMNTHhXftUkGWGR6swiSmqzue9xYlOuDtac48caPplp2BK6s9ll7W23yjyTS
 oTZrxSzIfeAqlSqohEtnF6hS2BeRLmFvlkOmKFF8jjFwXFCMVrrJXUna/lHF6LMOjrzB
 9WLzqtfu4KzsbKv3wWO1MRxiyoD7H4g7vn+NxsSvB9H6Qi1geFRW2/8fWTMd9vEVGGCI
 xO+g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpi6Azt8BrziosY4OTxL7J9wvOcFpHeGviD9LxpsZrpe431QNgEa+Wa5idUFEDymxcXi67vNK4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzQdVDuK32Wsi+waSxZBCG6MlLvlPtcAJebJvqRGouk+tdgW2Yg
 EMHgn0/Qp1SBiP87sjw7rgKB/zCjrxpczXjIQ0LyhzhPztQqH/yTWrxpE18maURMsvc=
X-Gm-Gg: AR+sD10vziSGIl3zRjx2Mh2rlFI1ek/FlH3MDIHuA7M/aAVJbR6h1Hc8nzJeF5r6lc1
 6A43nbL3fT1/WOxac8IEVXWsZk4JkymnacRsBE3r1Ddx2UJZO3dfjh3hcvu6KNrz3zIuVXBBqKh
 juKRlkJbn7acHKfYJjVo1ADmz24NeUnCghQfCPwHWMwMGAj3A1J4PM42hO/N7CJ+8DFpTaRZ6MI
 mmn1pLMa+Ggyvg2b4AUw5cyyuE8Vq6ZbmNxmLK5rFCGhm4HHrBjsImZpX0ViHx+6tI05sy3PdtB
 /2qQLeZYkm4ZGm0MQrzPshYBHEZB/IiOMgHGHN0osI3MI0zqdvMMR6T2Bi3/tSSRQ128hRhdZUp
 +hBiVKIL14iYBVLsW5hediaenrVZMyxn2B02gjKJjglAkSfcZ5ENXtaaP5W95DKAGdeYmjaJfBc
 qZX4Rqc9dioUrFEh/JSWAn40ENvHfCEZi50h3uQMLiNdG+FUETFl4Jy+e22HWRyNjwCMb/HqH6Q
 Qr0Ntks2SMr7inKW2lw9yM87xtGBuq+g5Zsd/Tjd7he2k3ZW9PWz7yjSmGf
X-Received: by 2002:a05:6102:e0e:b0:739:5cfb:50f6 with SMTP id
 ada2fe7eead31-75b23d68848mr775769137.11.1785515638581; 
 Fri, 31 Jul 2026 09:33:58 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:33:58 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:33 -0400
Subject: [PATCH 04/17] gpio: dwapb_gpio: Enable all clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-4-af2ce80db9d8@linaro.org>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
In-Reply-To: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>, 
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515625; l=1576;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=2LnNilWOrJZ4rQPy21N0X9k1Ayi8f/xFIcs5cGCDGBY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QA9ro5n945RByr0xK7g9LSf+L3UYSrOSrAnum8swYGa2dv9a7S+diqOaieh6FuGsYycoOL/2dPI
 tpEQHLpc1Ug4=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515639; x=1786120439;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yR7rkBeAfg1SCyFaG8C9GmTTa87Tfy3RLjjpYpiyMYc=;
 b=EbssdMT/zgqHGuUIG4hcoAYrMJ1QH63SBDtew0RoATsFiqunahERBZ0ZCgC/TSiZX4
 FDuoxejO89+HC32l5Y9gUX0ZiNBQ+qWiOXl//pD3qx9d9Doy6Ggq+i9E4oweqNLIh1L7
 VhQLAKMin/nYTag19SWf2lGNTgP5Jt2l1SCNf8MYAm+Gk0oCbEX+j7IetGGuAbcAtmuq
 xB6OE16AziqX0osKbaFsReTm2rSgWIOb1953xoOxENUuwnYU3jAfGOSOjGNxhXAwdoeS
 iIZVyaotXHl25xnbd6WjLGT96vZryItLfRx9i5v4g8aXn3fAnqUnik/xMTzUPWGQl1Q/
 tcuA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EbssdMT/
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On some SoC (such as RZ/N1) it is necessary to enable clocks prior to
using the register interface.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/gpio/dwapb_gpio.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/dwapb_gpio.c b/drivers/gpio/dwapb_gpio.c
index 7ab48780332..6fa50a2c2af 100644
--- a/drivers/gpio/dwapb_gpio.c
+++ b/drivers/gpio/dwapb_gpio.c
@@ -7,6 +7,7 @@
 
 #include <asm/gpio.h>
 #include <asm/io.h>
+#include <clk.h>
 #include <dm/device.h>
 #include <dm/device-internal.h>
 #include <dm/device_compat.h>
@@ -28,6 +29,7 @@
 
 struct gpio_dwapb_priv {
 	struct reset_ctl_bulk	resets;
+	struct clk_bulk		clks;
 };
 
 struct gpio_dwapb_plat {
@@ -136,8 +138,13 @@ static int gpio_dwapb_probe(struct udevice *dev)
 {
 	struct gpio_dev_priv *priv = dev_get_uclass_priv(dev);
 	struct gpio_dwapb_plat *plat = dev_get_plat(dev);
+	struct gpio_dwapb_priv *dw_priv = dev_get_priv(dev);
 
 	if (!plat) {
+		/* Enable clocks on parent device only */
+		if (clk_get_bulk(dev, &dw_priv->clks) == 0)
+			clk_enable_bulk(&dw_priv->clks);
+
 		/* Reset on parent device only */
 		return gpio_dwapb_reset(dev);
 	}
@@ -214,8 +221,10 @@ static int gpio_dwapb_remove(struct udevice *dev)
 	struct gpio_dwapb_plat *plat = dev_get_plat(dev);
 	struct gpio_dwapb_priv *priv = dev_get_priv(dev);
 
-	if (!plat && priv)
+	if (!plat && priv) {
+		clk_release_bulk(&priv->clks);
 		return reset_release_bulk(&priv->resets);
+	}
 
 	return 0;
 }

-- 
2.55.0

