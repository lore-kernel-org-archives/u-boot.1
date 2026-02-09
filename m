Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9887E7E0BC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D9D83D0F;
	Mon,  9 Feb 2026 19:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FzC0oAMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF1F983CE3; Mon,  9 Feb 2026 19:03:54 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C393283C5E
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-382fe06a9c4so26314721fa.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770660232; x=1771265032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WyiowIpBMLp9AkdhmEnOQ+Ca9h0LPp7/v59fyfK5BsM=;
 b=FzC0oAMdPGXQ4L0YyGCVgRyYXEY0ptEqLX0uOdnIzwgvDtrpoh/7SYJ62sYqbT4mXn
 7UQj2WV2jJekiVHxKvmmQVl6aiooF67htlyJGrnDpBoBFbeV3RefWZGtaNMBqr01UjBV
 TjhWYZcxDdA4G0PWz3aZARxIGkuXzEQDwaryJ4ONqqBJdJVEqvQcpYUoKT8eSSZTpbc2
 UVBTCHWk+PgzvnXuojwucleAVTh/cGNGCT540E4kVuiCiENFz9k2b82wiFtr3/5Oh7H7
 febXiBgtizUhDTzOzNnSjdpju7ILqQ63/HCzpob0inc8nrgUkQvvFr+2uPCyugb2x8My
 A4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660232; x=1771265032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WyiowIpBMLp9AkdhmEnOQ+Ca9h0LPp7/v59fyfK5BsM=;
 b=LNT7kCh4uV0166hnHg+n49AVpe9Nj6VVCMPWVShKYqHhWU6/wRGGirAk+x8QwxTBYc
 6nzWk5no8hbAkUN9XHhcrv1WzmWT7ZIIsQ1f2OXiCVf8KUpIK9P+A9hl9p6o3aeX36K8
 AwR3cxCtSvG88JPQtOU67CA8qwQR42mfOhVtR+VHxwM/zV71AvTxyups4W4MmTVvB+jh
 Y/M5AuG4U4HkTY0if2GbgIM2DjBMBwYsd3mkAmJplSOSagrVE+6voKQsknLzxxYQIHHC
 sEwYo/Uq/BXeRaYEp87aoivstvS8nPqpp3GRKf6x5XIsUnjK+BCcTetAEyinotfdrxWQ
 WPyg==
X-Gm-Message-State: AOJu0Yy75HLkZanYcQh1s/Qw40iAvvIGqQbPAubb9p4/EMT2FLPE4qgR
 yBdIDbvfYytCukrqxLVS5ABet0mUMNOzz0Wp1JePIeaVU/FKRDsSVnwr
X-Gm-Gg: AZuq6aJLHeCRiDLYqaQM90G5TC22M4BZf8vPPWU5j4vXbkwjnajVPGjvVA1DL8hLD68
 gz11gNMIii9gpV3JmNxf9y6qNajvNEaC68TdKWl1iESW06SdkVV2bS00pusbFnaHa6Ki/r4wY9Y
 8X/38IxdOvQ2Ern3xdW95EbFMqShcddjkM+DWcBvu7G3CCmy1gQVebDAgtqTpULjgkRVQDItM0I
 xQTDjX+4y8ctI6UKRrW306sXFqIQKrvQ3aYv8Vmsg8lNK8O37fmnRvn/quRpXkW0yb5pLK6pLpl
 dzOsrircqyeVVZ9pELbpSce7qZI6eIFA2+/cK0UpbBinCAYpAT39EAuU7WwB+hdTmYdC90h8Urq
 RlrpcFjmMqEnlPfQnzWIy4/mCuuLAljbaXH3MoQ+8XEoQZtzsGiuuBpdtrcZDyyHjSbV90P9m7F
 +t
X-Received: by 2002:a05:651c:b26:b0:385:e82b:5ae8 with SMTP id
 38308e7fff4ca-386b50f9c2bmr42541991fa.22.1770660231893; 
 Mon, 09 Feb 2026 10:03:51 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-386b6236383sm27285351fa.10.2026.02.09.10.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:03:51 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/4] pwm: tegra: fix pulse_width calculation
Date: Mon,  9 Feb 2026 20:03:25 +0200
Message-ID: <20260209180326.32190-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209180326.32190-1-clamor95@gmail.com>
References: <20260209180326.32190-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

The pulse_width is expressed as N/256. A 100% duty cycle is only possible
when multiplied by 256 instead of 255.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/pwm/tegra_pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/tegra_pwm.c b/drivers/pwm/tegra_pwm.c
index 3d398490408..6ddaf626dc4 100644
--- a/drivers/pwm/tegra_pwm.c
+++ b/drivers/pwm/tegra_pwm.c
@@ -39,7 +39,7 @@ static int tegra_pwm_set_config(struct udevice *dev, uint channel,
 		return -EINVAL;
 	debug("%s: Configure '%s' channel %u\n", __func__, dev->name, channel);
 
-	pulse_width = duty_ns * 255 / period_ns;
+	pulse_width = duty_ns * 256 / period_ns;
 
 	if (priv->polarity & BIT(channel))
 		pulse_width = 256 - pulse_width;
-- 
2.51.0

