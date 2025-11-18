Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9A6CED63B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA2F83E46;
	Tue, 18 Nov 2025 14:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Npq5MSai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF5BE83CF2; Tue, 18 Nov 2025 11:42:31 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6DF783CDF
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-64162c04f90so8553248a12.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462549; x=1764067349;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P2nb3Qx1L4Tb//gNj8tpT8eT2ePMlgaZxIGoSggfdUs=;
 b=Npq5MSaiAo39uANuLf/rgNR7OYJKnfwPH7nIWd5t3Yzt6WOKSwUzMYE/CDc2Yey/9I
 t2u8919wQhWo5/iSWOcalPVFIgWUpMP4FYDhy6fwhK8D7ai70b7+AljdpplVZLp3eQ7R
 VsgI0mhBzgWF92X9DoGdyYmezZENtJfZccVnix1R3S7wqabRvExpGbllPMbcbaMfvdOI
 0LNS8PE9sEzwUXDlUtOJPD9ueZK9iYKIXKNTQ4z2kNtpPUC2fVRhztnrx1M5mHYrj7fv
 PGOBRv+j9ex1O9lcEPfKzTI6PN2b0ATOtm2a8OLrosxpz1HiPUcN9ibATfVt5Gjgz2vA
 YuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462549; x=1764067349;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P2nb3Qx1L4Tb//gNj8tpT8eT2ePMlgaZxIGoSggfdUs=;
 b=gVc/t0YJSO9e0BNkcyMRldZDKRsaAS4zp7vVVIGNoz+xVZ8jy+JhkFlYCoJH0h3hCg
 5lbqGjNEbEtw+CjFunEDNiUWxOB1afmE/Fw6xQr1LFLaoo39ABVSCGVS2gfUpCAFCRq8
 bXH8jaVurApVFv/YMwUSC3WjzF7xXxxzhgk2XJy41wlIiarr0U6zNidPmMCnOJr1nySM
 exwacpvZUEmcQjv4plZjGWJ3vslU73lt1Ka77th33Z72WLJWOh1/vpqlTigALsV8wyqr
 A+vyY6q4kE+Neq8xYZJDdkOb0Qr4CRHX64BvkM51QcTFZPSFsbRY/JaCR/SO4OcW/jof
 9tDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWglCw+WD5VhvNFnJGZgkr5giG/33cD9GdGnJ27b8LvkSMXrZrRsVu0un/VF36pWKtfOQ7qfFs=@lists.denx.de
X-Gm-Message-State: AOJu0YzBPC2+chmyJBgoKzQnBLvj9yZbf6zbmnMrRrjSapOxRdAY4jq1
 Nxja5ZozJn4KFc7KT12xQmSvdgPWq6Efu2aJCrgVAIY8+P0YFn+vjNhXs1SJ2Os6Jzk=
X-Gm-Gg: ASbGncsd6GzXV5ucDDniGXVbCdDYGYYc/yiCbzRMruGu3j4vM7E3552cUC8nkOD3Eq0
 2fGFi7KeXIuMdYQJAwDr+/gvmzGaOPTpxZcIzPIXFIYMQG+E70MR430taDxLDtALmeAmyZYgfPY
 HfN/JbBnUytAvKR9ENDHudEUbxWxQFnwa/cwkYnyhqNPyLnyzrajkUKAtwMBZa6r465oVOsoMY8
 x0P8gbmCaNnDTCAP76HHLCyMBLDPP/uQALY7GbVsboYiJWN8cgn20go/n6T/TPbJEXL/YUPwv4v
 RjBAbvsbzOB3Jh4kx/HSEK26HOA1SNTZ1XyEw7XNu9Xa9ycxIjZ/RV2ccMdNrW2214BdO3L/zKk
 XbeqSfEplJ11FuttPFafNzV/zVSiBsUqMc1UCewfkFfKkZOHaIpr1Svf92OG+09WuVoxd939nXp
 C1oFHkVcg=
X-Google-Smtp-Source: AGHT+IE39xwsh28zBMAvM8IknParCURXHSWgCoOVlZmnrBo1BgedPoUfrWdO75cr1wl46k3sbrbSlQ==
X-Received: by 2002:a05:6402:2809:b0:641:8d6b:88cb with SMTP id
 4fb4d7f45d1cf-64350e88a7dmr15947928a12.28.1763462549201; 
 Tue, 18 Nov 2025 02:42:29 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-6433a49884dsm12275177a12.20.2025.11.18.02.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:28 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:32 +0100
Subject: [PATCH 12/15] am33xx: Support upstream devicetree binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-12-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=msp@baylibre.com;
 h=from:subject:message-id; bh=sRhdoiB22/GyVw+mNVOUheplx6PNL2RHzK67IsrT7no=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZ39xN6/0MnG060nes31s6iTVzrr+Dm499wLN9msl9M
 +3XPZnRUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABN5b8zIsH/XxartxYbCb4JN
 FtXaNXfWPa5N8viq3JjmsfOblTWXF8M/ReNSLsFZvnr/Un+y+BnP4LGLN98nOrUwQG7DA+GQwDW
 MAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

Support musb being probed by ti,musb-am33xx. The non-upstream DT probing
used a wrapper driver that probed ti-musb-peripheral and ti-musb-host.
This wrapper registered as UCLASS_MISC, which is why it is requested in
this board.c file.

With the new devicetree the wrapper that registers as UCLASS_MISC is
gone, instead the UCLASS_USB and UCLASS_USB_GADGET_GENERIC have to be
requested.

Also don't fail if the USB devices are not available.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index d7db260513308257f142ea70d5d5c643afc920c9..4bfdb55b2dd5c66cd58bce360cf1c69fb7a00cd6 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -266,12 +266,16 @@ int arch_misc_init(void)
 	struct udevice *dev;
 	int ret;
 
-	ret = uclass_first_device_err(UCLASS_MISC, &dev);
-	if (ret)
-		return ret;
+	if (IS_ENABLED(CONFIG_OF_UPSTREAM)) {
+		uclass_first_device_err(UCLASS_USB, &dev);
+		ret = uclass_first_device_err(UCLASS_USB_GADGET_GENERIC, &dev);
+	} else {
+		ret = uclass_first_device_err(UCLASS_MISC, &dev);
+	}
 
 #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
-	usb_ether_init();
+	if (!ret)
+		usb_ether_init();
 #endif
 
 	return 0;

-- 
2.51.0

