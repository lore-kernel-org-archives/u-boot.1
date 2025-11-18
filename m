Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC03CEDD86
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD29B83DBD;
	Tue, 18 Nov 2025 14:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tsB0YMt4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DEF783C96; Tue, 18 Nov 2025 11:42:22 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E47D83C96
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b735e278fa1so791250366b.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462540; x=1764067340;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b1pkY2sbFxSReEu5uVVcQLsHdxTtdvP5LN/LK7NANdY=;
 b=tsB0YMt4xYaQEHQUxniUCxHEgUsmYbNefRFD/77tM/LsLCVNJzG/63DFHwsIog3n1N
 4DHnz4uAhGm4/EOenWJs5O0ejlQujlkcWGQ66LioXE1ySBXkjKcvJ+jn77RHc3uQSdbg
 RCkdmQ7SjY5DI8UGMNh6enrhzbxiKKTJa/nhaunYoOipFodH0JwZHpldezqMmGByr41J
 U+1qYQzPontW/c6dQRXChJBzNNSR7tSikIb/y18z+dXPUSEzd4Y4NMuq7CiwZDcnpAmg
 MjczbGbkuIggor+zC5/zni19W37Xxl6E8Ah1LcvoVTgWpj92dlN6Aco61LQ2yKk4PTzF
 1VmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462540; x=1764067340;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b1pkY2sbFxSReEu5uVVcQLsHdxTtdvP5LN/LK7NANdY=;
 b=Nc3lRVZBkAP0fpXuOak/JVA0KgbUhUvO4Fgq8NeD3r4ZJYxfKWhvmwCHFVXXLTlF/B
 8qunlW2FT7n/wNtosNJSybuhQ38qgIYMrzz/rChi1bBLXxdcTvfwFktBojESIUYYzyGL
 FaQ+GVbfQsrVu44+4r5M9Te/p964zak05eMP/6g8+/DZI8XIY3H0bSBfY8z+CWh9jQ/D
 yr8hEvzpNMQ6ucLzPwtb7PT6aUfjVj1fCGaHR1KIIcaGDNHZx2zJhG7Ynz2joRIs71MG
 zC6uBAYUPYm2LyHEFxHX2lEl7EztDnFx75h2a99TAITd4fRfK4tXgdSOdO8UwnpFPtmw
 xgjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMaSl+5fXDoOKNpi1t12pAIikDpA1HdX80Jj+yeaLxmDjP+4Er8Ki2XPomI5mZVb4IDungw50=@lists.denx.de
X-Gm-Message-State: AOJu0YwGX9BvzFCVyWnE7WmE4oRRz37oKA3qWEaAVwp4Bf6dg2hYk7lW
 BfG3VOq/i+tyTydCFAy20CRR5dtxND7d5K8uTQRJd5sBy7AjNZekLmmxlHn/5+gIINk=
X-Gm-Gg: ASbGnctKVnDxVjHTeg0zKwLpeBeAiIW2DHoBvkdCZ6mzBX63SP+pVT817ntlY3WJ1gw
 zsnFs1KA0F7Fa9gC3WryukdlbrdUsQZOyfKODEMzR+qFJgn71liRms19KktWMWJOtEMfN3EHhKc
 JtV8C0MM9c2/LgP2mjzYHBe+/NGAeVIPETSINS4ZL329N+rDPwyiTtoksQwwD6uXpnzVOzYycif
 kzUzsz/6MYYJnkaC/pIv1+SbdwIxrmk3qDgaCnbMiSCv7S7yYqVIkav6JgIz7RWSrtCWmUD+N3I
 h4ry6115d2l9xCq79olD5WewbZBXpWj0qI13Tt75dOsKLlQRQ/BRGXhz5+ki6KVnNPXaD6alXTR
 gob48SfLPZVp65cpPgy+zgHzIP3rb3iH/Q/F7tTC/ceJXnCCHhAgghHcNMq+3Dn8liY7e2ULRZv
 lClYZpn2k=
X-Google-Smtp-Source: AGHT+IGZk8m4ygdVu9+e8vZu/5DgXctfV/1Qkr0pG8aLcy7RNZTvsL1npwEIakf9VeUYqf///0WsbA==
X-Received: by 2002:a17:907:d09:b0:b3f:cc6d:e0a8 with SMTP id
 a640c23a62f3a-b736786e693mr1451463366b.17.1763462539716; 
 Tue, 18 Nov 2025 02:42:19 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fedb2cfsm1316394966b.71.2025.11.18.02.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:19 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:25 +0100
Subject: [PATCH 05/15] simple-pm-bus: Make clocks optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-5-91ce13c661e2@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=msp@baylibre.com;
 h=from:subject:message-id; bh=NVhFPRNEqJbSa3bFuzlHz+KzmkWLmAkYmcQKSeYH8Ek=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZXy+DXD8/6xnKLG3+p/59CPBmczsseG39X/PQVzPOt
 X+2+WHUUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABMJNGf4n1dY8PH/QfOAulfy
 Ae06R1bbN33c9yZtNs+d6TJqakv6khj+xyT6+nT956puXLTnnsWh5T+Wihad0lqw/vw9syc+a9T
 2cgMA
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

simple-pm-bus binding requires either power-domains or clocks, not both.
Allow clk_get_bulk() to return -ENOENT.

When no clocks are present, bulk->count is set to 0, which works
correctly with clk_enable_bulk() and other clk functions used in this
driver.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/core/simple-pm-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/simple-pm-bus.c b/drivers/core/simple-pm-bus.c
index f38372ec60bcad4d8c630001d164630f2f99dc32..5df11728e82848b83eae6ab7dad857a8762c2aab 100644
--- a/drivers/core/simple-pm-bus.c
+++ b/drivers/core/simple-pm-bus.c
@@ -16,7 +16,7 @@ static int simple_pm_bus_probe(struct udevice *dev)
 	struct clk_bulk *bulk = dev_get_priv(dev);
 
 	ret = clk_get_bulk(dev, bulk);
-	if (ret)
+	if (ret && ret != -ENOENT)
 		return ret;
 
 	ret = clk_enable_bulk(bulk);

-- 
2.51.0

