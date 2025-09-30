Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89707CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 10:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E96A883045;
	Tue, 30 Sep 2025 12:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n9OWm1cE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22044832AD; Tue, 30 Sep 2025 12:34:48 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD14828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 12:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ee1381b835so4807221f8f.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759228485; x=1759833285; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=03MveigEKySo9KfxJAFgZfVb4kfAtp1vTlzfP6bTlAo=;
 b=n9OWm1cEuqTfvl0TIfo2GkcNg3E4gV7zcsUV2CX9mR0D0GFk4jWOBDI7EbRgcSeQ0U
 RdMEXDrojK5Q2j5CelYYWrwJbK8xn4C8SClrTsmBCClPWJH6KOeHQ9JieVejZtQ0/re3
 0O1rwE6LO7ZY6cL8MghhJbej5GkR8Za7NUracoUl6z1ixg62SWZGslWq+OgdVUtE5Owa
 /SwmhANxWX9cwCv2QuC0fmD0BGeiohTMP15w1e9eXRIpllnrh5aQDGr1oAkwPDA9oQWY
 b72SUFlJOwoRXSQo2VVyTtTZ51TE2yaPkUPEUzGHAAge1aZxfDDR3qIP5LhqBY4hBsby
 8GwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759228485; x=1759833285;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=03MveigEKySo9KfxJAFgZfVb4kfAtp1vTlzfP6bTlAo=;
 b=IBQ+vODJ43bejiqUCnCheQBTisPmV/NgdJXk7FWq/bbIlzUL2depOJ2uOa+h8aONCm
 HbmCGX2cJws4kHAp4lLWtZ4vfDanRTszb7fiK0BuFqllR5So3Q3pdiP80MENqnOMazlL
 EkfxfXmzmBoSKB+Eu9W3ErQeJAokS7QgM/MdZuF1TNVFkE0ZCHSrZsxFSg3HS+r8PS6/
 C0ODJngtnr37omVb3xJegb9YvcuG43zdfh2ism10GxTUfRhjwRvKqEcCy09wj/LhZIYN
 M1G2h5YBxpmsVfTjaY94jLUfUH+2a90K80A4p4qsvLNyWUsynRt4sh3uK1io6u5gZPyE
 7FFg==
X-Gm-Message-State: AOJu0YzdK4XiFa5OSvgxvRVnHwE4Wszx8LMiXxq7R7Mo61Zg87nF9SsR
 YaXKRFMmNFPJfzhm38+SvU21KRw9JKXH8PH/Sw3REmTbkwPgxhzUbIgNvgA8omO/UPSYNhsOy6/
 vpUkI
X-Gm-Gg: ASbGncuQ5RX+uY3kGN1PNGhVZ2QeO16RNmUHt3wccwSvhPSudDFlcv4hyyGqJjRdva8
 PFiLCHp30/5d2sp5t52dpiWrqX80aOEHsi8Dijc+O6Tm57KFgBiBICUicSFU806g+/tBLs9Zrpe
 3drTj7eVQNm39hFFJpOoXzlDAg3bo7eshBd2vVkPwx+/uBFRAoh43+8BjrOMxVbsPsxW5JUDqPk
 irxu4mo+8LoQQ4Wv2h3m12kzKp8xDYj/O3t/O9GwGGHWAJ6t9dmEc24eGXZBy7bNU+fuCu6UXh/
 LMFU68BRPdKbNJzXKrinjybEzpnflAVBVTBfv5RNlfQGJXlB3XhAJjPeP3MUPrA05hvHl2SJE8y
 zImx5fCIskiPy2PiVadWa/t7630HjwcLRPz2LA6HdlXeh5xpU0Z17E/WbrWw4ONoHF3vmjdbf4j
 Dp91rzN3D0
X-Google-Smtp-Source: AGHT+IFk9jMtP1vi9YwQ/0Im01BdMwQHswPub1rd0qvKAVJ4qBxNsgbtX0B/5lkl6Z0QaEJo6OVMoA==
X-Received: by 2002:a05:6000:105:b0:3ea:63d:44c6 with SMTP id
 ffacd0b85a97d-413591d794amr10525217f8f.35.1759228485565; 
 Tue, 30 Sep 2025 03:34:45 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:aed:2018:ed42:d786])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b576b12sm12702455e9.1.2025.09.30.03.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 03:34:45 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 30 Sep 2025 11:34:44 +0100
Subject: [PATCH] usb: xhci: exynos: variable node should be signed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-xhci_exynos5-v1-1-f25920a8bc84@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEOy22gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS2MD3YqM5Mz41IrKvPxiU900U+MkSwtzUwuTZGMloJaCotS0zAqwcdG
 xtbUAWsNJaV4AAAA=
X-Change-ID: 20250930-xhci_exynos5-f53b987584c3
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

The variable node is assigned to the return value of a function that
returns an int. It is tested for being negative and then passed as an
argument to a function that takes an int. So 'node' should not be
declared as unsigned. Correct it.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/usb/host/xhci-exynos5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-exynos5.c b/drivers/usb/host/xhci-exynos5.c
index 6a2d422c4b8e510bf485c3069287000f8cf77aef..c509ce1620a079d684146d6f3470a1d10663e3c5 100644
--- a/drivers/usb/host/xhci-exynos5.c
+++ b/drivers/usb/host/xhci-exynos5.c
@@ -56,8 +56,7 @@ static int xhci_usb_of_to_plat(struct udevice *dev)
 {
 	struct exynos_xhci_plat *plat = dev_get_plat(dev);
 	const void *blob = gd->fdt_blob;
-	unsigned int node;
-	int depth;
+	int node, depth;
 
 	/*
 	 * Get the base address for XHCI controller from the device node

---
base-commit: 9710d98e8942151fc0c62d54100d9d27e8263d04
change-id: 20250930-xhci_exynos5-f53b987584c3

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

