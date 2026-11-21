Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E37606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nMyzyt+u;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ihHNOCcK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E03B607C9;
	Sat, 21 Nov 2026 13:15:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J-V02T6Zv7Nf; Sat, 21 Nov 2026 13:15:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CABBC60EAF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266910;
	b=I7Pw/FcrgSem/C+y3ZzEv+RUbtk8jUawRyRY+LriO7gdbhU3V8R0tLDvmCBnGYqb9wN6
	 ZNufT6Nbp6GfZhpoZphPEw7AGUoTGUbazdjSzfejwfXJGStHlFbBz6fGazWBX4bBCmGj3
	 gC6kYowYDr3IOBX9qph6QnYIOQzgmdvPiEtXakLTKEF+/FGVcB5+LyitodRTfvb9ON4Y/
	 CDdKvXhpu2cVCaSnkCCpRth6skAnlPC/+EdoiyTTl5VoOcolFz3QLL/tBWgZ2zawbXMtr
	 cApqcGDjuGpJxBcUpo/e/BeCxA4Y3mqd3GyeysqUEuUk7QWZyFDt28ZN0rwhpj63NPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266910;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2fG+2YF3dG0VQRcJzXYrmseRICyePMR1BhvbD5VTzBA=;
	b=QPz2BfWTI1FAGQPmUVwfchpgvRWufjCa8jIuThPdLpDfEHLdOiK9AWsuN3by37KeCTy+
	 EkA7fsZsfJAaksSfahu1XBk8xooOJkN1rh8DI7R1mH+8/QEUq2gHxlF0yBvEhT6bY2aQl
	 d39xNOuPNDvXJU/2pDZo17EQBQGpLxZ3UjJGkR+84Pi07daIj4MF8Rm49da4+kinNHabO
	 WRLJ/L97GnATvvkExjZJsUdMCUml5ahn4sFfAZIUIAbQcA90846u3WmuSl4gFtABm0XwM
	 QGqst4BOsrqqkuKVnzHSaDSbmLgMJJfiR4CkDReAo/V8ai9vco3qOy+paz0GAS5WsLA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266909;
	bh=2fG+2YF3dG0VQRcJzXYrmseRICyePMR1BhvbD5VTzBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nMyzyt+uL4PJXbr5v76Cj/aFe2bd/XB24OSHUUyv4FaPZF8sippHZyO8WM5ih/ONi
	 NwKlMjXe8mmuJbEt6Ut6t8HsEBKneTdh2lWpQhvIZuRDLI04ZKbN4SVVba71WuSs9p
	 sTXCQDLi2FH3GvTgkd5vxXlceTeqiqxexqLfthDOTB23DHktOEvhFRN9FqcqPo7gaV
	 ZJYXstnjlcyO4F0xOHYpYyVwdOM1+kdY++KXIE/9Kt6luCdMmNXFmWwKSV/QDN4e1O
	 OWxaGnEO3R/IMB1hY5CHOJz6N5JX82UhSqFudLxRrg2DwzsfX+Zfj1yTHk0rX8iuri
	 ANWYHJh/kzmsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CABBC60EAF;
	Sat, 21 Nov 2026 13:15:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AECB715D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC8FF81404
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:56:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dO7BVcjuzghA for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:56:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CDC3C81403
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ihHNOCcK
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDC3C81403
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:56:22 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c50692e6c0aso30420866b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262181; x=1795866981;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2fG+2YF3dG0VQRcJzXYrmseRICyePMR1BhvbD5VTzBA=;
 b=ihHNOCcKgzvuws19BfBAlwd2JdBZ6E993C+e6ls2MMqR9069fPSri/rQ47KoFrTVJ6
 dfejWaOGelwPpqouPOBXbzDn5TBwb5B+mzlmSWPE1tgOBA4RO6H3s14AMLYIoQ7NMK7y
 qauJ138+nh/XUpXWi8ikKdyBjgx2PayB0fPaHihgzWCiImi359aw2UP7G5SZfQLhhrkf
 kCkyO+9zNcrudoob0BaTA8p6feGkMCeujtol26IgYgMzwxM10Vwjz4lPVW7ANRLQNyWB
 XaTSfTt4moiBPoY2vB7r+GTMNScEZec01c0DS8lEURt8rVcWnLWnawV7oy07GbZIXQe0
 YIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262181; x=1795866981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2fG+2YF3dG0VQRcJzXYrmseRICyePMR1BhvbD5VTzBA=;
 b=yrzuzq+pQcBphPZEPjYIOq5NLq91ZacmaW3UF7ltDBahCMdLWuZHjlzem+rOCZstEr
 9wLJprh6ypZFN1fQWSc7hZKayfJIRlIUEvzyltXsMIoLy6ZtdcopQVuT1gfhz4Cqgedx
 4RXA0fGHGUol/a7EQKA/0oJC/wGrECHovvVbRuMcDbqhDg8oTiaYYOkdZuxmjMKGVswR
 n524x5UhI+QYC1mo1fVms0YNfTGgYVOW17705OMYGew+miiW6pdEc9bK+x6ZlbV3KIKI
 EmQwS0wYdTqfHUUSyq+TrF4cEAyTRrY4waQLn9SgYgkMx8iPmd30yPD1ulHK4CZ72yZL
 llYQ==
X-Gm-Message-State: APuU4Z/cOHEKU+1+QhuhcEUgv6UL+hgthxyYF2Zjler7rvrgqrHhc5Us
 QOVDAPRM3peeeJBZ8hE0hZ6xnCG+tHGxnrZpqWMhUZ1g1673H3aTmJlTms+N3NgmGcPSHOvOh19
 xX16/
X-Gm-Gg: AZFdTZdx+PTaUgtoFxuDauu5z1CvBBHnYiTH3Sq0FrKJT1gQ7eaKdD+L7XBghF8EONO
 8bkxSS+J77Gk4VXTGqT3D3nCyJWi3TRblau/KM8Pa/p4mGnmYNM5C/HGfJSg6G3nDVKL0q2/Hn2
 b5V/LvCeybyb+eO7EcUb5p+69hakSa24jNfCN0czdWtlFH5xNHKu+YFIwZ6jS5z10RMNZ/F0pKD
 m86ul6w6iCkUXPc3msVR8FlfFzha1vj1OFve3+HSapB0NoBbgsAjwyF7ZJR7s5Sb8IIUPsFEuO8
 1J9AYwD40f4GZoaJlUo2wIhLNH+1oyJYIXV/gA3x4INZfqBMD8+tTgrtapOy89w4+HOo3UhCGRO
 CHQ34UjxDNAZqwG6OiIrPURlCYdgPUh+kRyMgqeEc+m0dP1ZKpOcMt2Fi4A/TpuO7NJXgVo30wA
 1MRSAlnfbpffQ3iMo9TXgeUlEh195g909iMU5XEGLPU3+7hR6ElmPJYgE+U+jV4vlooLiy80xN0
 uoJGq9FYq4vfgSI57gm5MHkGOVM8GmXHg0yGDVmc7FcAN9o0KDdibgmylAvdKmjDnyHC12kpCcO
 4VaoRguBBZAuBEPieKE8NDs6SpGpHG0KmEf7BrPmUcuaSy9rCZ36t9gPbfoEH77vnUGi84sfJ7M
 p3K+CYy2vWA==
X-Received: by 2002:a17:906:c311:b0:c51:45d1:eca6 with SMTP id
 a640c23a62f3a-c5145d1f0a6mr365827066b.2.1795262177369; 
 Sat, 21 Nov 2026 03:56:17 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae88143sm184577966b.32.2026.11.21.03.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:56:17 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v12 31/31] usb: dwc3: enable SUSPHY again after xhci is
 registered
Date: Sat, 21 Nov 2026 12:53:35 +0100
Message-ID: <20261121115335.548142-32-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The resynced core clears SUSPHY when it switches a DRD controller to
host mode. Linux sets it again in dwc3_xhci_plat_start(), but U-Boot
has no such hook and the bit stays off. The old code never cleared it.

Enable SUSPHY in the generic and layerscape host probe after
xhci_register(). That is a bit later than Linux. It is still before
any device is enumerated.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/dwc3-generic.c    | 8 ++++++--
 drivers/usb/dwc3/dwc3-layerscape.c | 8 +++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2406f8446179..cd4170bcb817 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -278,10 +278,14 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 			HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));
 
 	rc = xhci_register(dev, hccr, hcor);
-	if (rc)
+	if (rc) {
 		regulator_set_enable_if_allowed(priv->vbus_supply, false);
+		return rc;
+	}
 
-	return rc;
+	dwc3_enable_susphy(&priv->gen_priv.dwc3, true);
+
+	return 0;
 }
 
 static int dwc3_generic_host_remove(struct udevice *dev)
diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dwc3-layerscape.c
index 108b44c67eb0..afa31c48be6c 100644
--- a/drivers/usb/dwc3/dwc3-layerscape.c
+++ b/drivers/usb/dwc3/dwc3-layerscape.c
@@ -153,7 +153,13 @@ static int dwc3_layerscape_host_probe(struct udevice *dev)
 	hccr = priv->gen_priv.base;
 	hcor = priv->gen_priv.base + HC_LENGTH(xhci_readl(&hccr->cr_capbase));
 
-	return xhci_register(dev, hccr, hcor);
+	rc = xhci_register(dev, hccr, hcor);
+	if (rc)
+		return rc;
+
+	dwc3_enable_susphy(&priv->gen_priv.dwc3, true);
+
+	return 0;
 }
 
 static int dwc3_layerscape_host_remove(struct udevice *dev)
-- 
2.53.0

