Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6899BC9EC6E
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 10:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C29AD83D8A;
	Mon, 12 Jan 2026 11:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zhKOr03Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B67E83DB6; Mon, 12 Jan 2026 11:55:45 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD35F83B85
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso57082675e9.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 02:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768215342; x=1768820142;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gBAVAY+n87ZN1UsfMhK/u2IONWmPezlHWfjfJSXvA6w=;
 b=zhKOr03ZKcXSdeQnUi+Lvq2qn8eLQFFk/zgVDyd4tHd3Sv9F6xTYRqXqrKTddatGll
 Xobns3nvu3F03+ZosJwd3nvAyd65sSNkLKShvQwRXg4py853/DpC33kH4ZqRQJvDPvfj
 5tlpMhBiQZj2jNiCG3QSkTbPcQvsfWT3IOEeLIXR97KBwBwZKnvmiPx0Pqh3nF820sSp
 D7aFMQyXkaPogZBX/ip2nS71yj7Q3XToZ809+04YTwbVzSwfElDJlGD3VOpKQgC3u6Dr
 i5vQN2zsy1wIcACVRceu4gyI33gmY3Zbj5CnjXRqdtsWwFncEp23jVsSwJoKLwUPKgET
 sibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768215342; x=1768820142;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gBAVAY+n87ZN1UsfMhK/u2IONWmPezlHWfjfJSXvA6w=;
 b=nO2aeVxFHf9zqbPzvl+TMfZ6DbiJ88Lt49iqTA46Jre93//1M22NgUVJpdIGHLEG/b
 F5AUV7Zp0zu6HxKv/1gp9lTc/F2XhokcdOXGNUkaHxRS+Pv+1rXMSlhdPgBuCTzxH+1y
 ykY3re4M/yNbovJ/7bFeZH2dE5arcHMAGa5BCQHPHiEffYRsYwLPxhONGSkyPWpflXkn
 IU4zTDI6T9VEgYjMiRBpnmD2nPHSzQEtzcHfdJ/1HAzS97BmiAEVFyj3zmSCV7/tll8+
 Rk4P6uTWWZJTV+UuSfQdFnEgC5NmORxZ4OQTwRcwLAQ9PF6xbuemxjxTmPEkp9B45T33
 cbPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFvhKSiFwg8nogoKexpRcRByrVSxcINmvYwN3vLWHjbPvjT8gONYYnCuqHAV3UA6+gpwCMsBc=@lists.denx.de
X-Gm-Message-State: AOJu0YzwaOyOdSNV3b7o6Y4q/M+uBR/84aCyYVO0nRwmL3T3MFCoZRA6
 58UbtUJVd5qmK3N2Q01TxAWVqvHAViJLI2J1BbVguM9/5iueyakz1Iud6fREedBIFPk=
X-Gm-Gg: AY/fxX5/ZI/rmlEwaG8uBjm3945ey4UIcvOuL5dl8FE+ioCl6PYuYQho/O6VmZGeOiv
 e66qf+ipWWWsCpDvNpivZ+kH9xCYz0ih211NVP/h3WToTQPtbPh4FmUf3lOhKQIPuPef4iBpUvZ
 F/AhRMbDY55MuKoHRA111VEwGc5zgLN3JesKNLlrFonJhK25HmAy4iUOVoUipqm7n9EASoEAttB
 KTbh8n97/WCwgreo7aP6ugDFqOaWkiuEqXHxQBRdFHhavYrPDS+CG5ce30fJwWtqmpwLeBHUQ+k
 eDTasvTYDQKFoQn5iux9A+NhXC+qpa61lPXOsXy6PBxdaReuk44NqqErpBhZ6Ko2y7sk3nqQnZl
 Lt/7IZXCtfXNH0AUamhzRD2vMK/3wOKrO27PhouJdXxXRwaythW7EgcyAEcUknqkBrrJmiVnop+
 4SS6MvCWpW2k9MzA==
X-Google-Smtp-Source: AGHT+IEVgXMdETY+g5I0mg7kRW0H3KRbQDDocPIpUEbqb6fczwfFxzRFA+AIH28we0Sn1yYyZ54D5w==
X-Received: by 2002:a05:600c:a08:b0:477:63b5:6f39 with SMTP id
 5b1f17b1804b1-47d84b3477amr175619585e9.19.1768215342244; 
 Mon, 12 Jan 2026 02:55:42 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:ad8e:46f0:bbfb:2e18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm36145393f8f.26.2026.01.12.02.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 02:55:41 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Mon, 12 Jan 2026 11:55:37 +0100
Subject: [PATCH v5 1/5] boot: android: import addBootConfigParameters()
 from AOSP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-bootconfig-v5-1-79b242159ac7@baylibre.com>
References: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
In-Reply-To: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Maxime Fournier <mfournier@baylibre.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome@forissier.org>
X-Mailer: b4 0.14.3
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

From: "Mattijs Korpershoek (TI.com)" <mkorpershoek@kernel.org>

To properly implement Android boot image v4, U-Boot must be able to
add additional entries to the bootconfig.

Add `add_bootconfig_parameters()` to do so.

This has been imported from Google's U-Boot source[1]
The variables/function names have been reworked to be
compliant with U-Boot's coding style.

[1] https://android.googlesource.com/platform/external/u-boot/+/7af0a0506d4de6f5ea147d10fb0664a8af07d326

Signed-off-by: Mattijs Korpershoek (TI.com) <mkorpershoek@kernel.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 boot/image-android.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/boot/image-android.c b/boot/image-android.c
index ea47869a64c..5407390ef36 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -57,6 +57,46 @@ static ulong add_trailer(ulong bootconfig_start_addr, ulong bootconfig_size)
 	return BOOTCONFIG_TRAILER_SIZE;
 }
 
+/*
+ * Add a string of boot config parameters to memory appended by the trailer.
+ * NOTE: This function expects bootconfig_start_addr to be already mapped.
+ *       It works directly with the mapped pointer, not a physical address.
+ */
+static long add_bootconfig_parameters(char *params, long params_len,
+				      ulong bootconfig_start_addr, u32 bootconfig_size)
+{
+	long applied_bytes = 0;
+	long new_size = 0;
+	ulong end;
+
+	if (!params || !bootconfig_start_addr)
+		return -EINVAL;
+
+	if (params_len == 0)
+		return 0;
+
+	end = bootconfig_start_addr + bootconfig_size;
+
+	if (is_trailer_present(end)) {
+		end -= BOOTCONFIG_TRAILER_SIZE;
+		applied_bytes -= BOOTCONFIG_TRAILER_SIZE;
+		memcpy(&new_size, (void *)end, BOOTCONFIG_SIZE_SIZE);
+	} else {
+		/*
+		 * When no trailer is present, the bootconfig_size includes the actual content.
+		 * We should write new parameters right after the existing content.
+		 */
+		end = bootconfig_start_addr + bootconfig_size;
+		new_size = bootconfig_size;
+	}
+
+	memcpy((void *)end, params, params_len);
+	applied_bytes += params_len;
+	applied_bytes += add_trailer(bootconfig_start_addr,
+				     bootconfig_size + applied_bytes);
+	return applied_bytes;
+}
+
 __weak ulong get_avendor_bootimg_addr(void)
 {
 	return -1;

-- 
2.34.1

