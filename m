Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D10C02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 473C680214;
	Mon,  3 Feb 2025 18:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IoyC23ZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EFEC800B3; Mon,  3 Feb 2025 18:43:22 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 616ED800D7
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3eb98b3b63dso1272131b6e.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604598; x=1739209398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMV3Nkq9Hno/0/C+55Aaz/pPgP37+AjtHCxQb+ei9vs=;
 b=IoyC23ZSGRJ4YHgR/rOjRMjfQXns/dvrW5YJjdI9F123B+zP/LksagELUrOT89VJic
 XcFxw+PuUVt1FWkvSxJrMLVv9ec5FpYR6SZHh/Ostv4QOuMS7CCV4aiaiU3euFI30vm3
 /fIrA9W/AsR7qtoAUDt8QpJFFu4nOs2xZ83Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604598; x=1739209398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMV3Nkq9Hno/0/C+55Aaz/pPgP37+AjtHCxQb+ei9vs=;
 b=Tart7c43GUQKx+PL8VLq1xryHO9RhFPzOeamRSEfg7+/unoiviZ2MYDs+pE0pMydd2
 E6ETktxBsG3QfUkvQSOlbwfZMXsH2KUppIur0O60ZSkjfIURNOz70CT/uWsIffb5WpHB
 e+1+7TppUyBoe/fR3S4sJDruAXz5G97ESscE92y+t78u3JkaOrcM41FNtY8KeV3aftpS
 qkEMUO0xlQ3nb8Qz3vRMHXCc8DwzIhjITUk/QxsK5uZIRAuPSqxV2HrSRmhs8EZh2+fO
 +Ym4xioZVhho26rg2OwNrFyiIdLENtUjORbFTkvQ5LiGO9xqCBvOn8pPEhflmqR4kWg5
 tNLg==
X-Gm-Message-State: AOJu0Yxm4fB0RFluh68WtJsNV4x/6GJBpwG9ufNwIsrudxT0+KCwvISE
 P/kHBYwzYk+QdB32acrhaaRuiV2pyKHj/8bGlm6L+bp73U4DObRXdgxwyLH7jIXRvgpQTZqkWqA
 =
X-Gm-Gg: ASbGncu8yPolDE3Rn5cMpQ2n1zUuVWPinYnZPc1sUTtWlfsol107y1mnrMKvPJOlUti
 y+Fe4WYoCErHjq0HinG8hTNPt9+iB4QSrOutXTfVEvjXldfOC/Eev+OMWS0az5UWwnVXcg/h/WQ
 WB2YhRV2MOEVqOoram3HrAUGnVBIn3o0/b5Mpq1POX89LlKtLlpOX4bBmaYp3CDyHUI6YufDxF1
 r9g9qFVAgszOtRa8jTiPd2zL9GTCJ152R75PJP7ck5xqozxEe/cU6bH7aZ/5M/qC2fEg00cu+Bq
 21utp16rUccKoZGV90CebZSP5ywJYw7+uezd+PKE1E29Svaaxham
X-Google-Smtp-Source: AGHT+IF6Pw3VmOL0ZJmB8j4lF7qNRfxUxPy3BlfpBmg/a4tXyXpF8RCvIcfX7CNI5l5K0wiqT1G1dg==
X-Received: by 2002:a05:6808:3c4c:b0:3ef:27fe:e984 with SMTP id
 5614622812f47-3f323a1acf8mr14695117b6e.12.1738604598583; 
 Mon, 03 Feb 2025 09:43:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Matthias Brugger <mbrugger@suse.com>, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/32] lib: Provide fdtdec_get_pci_bar32() only with PCI
 enabled
Date: Mon,  3 Feb 2025 10:41:58 -0700
Message-ID: <20250203174245.1331464-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
MIME-Version: 1.0
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

This function calls dm_pci_read_bar32() which is only available if PCI
is enabled. Add this condition here too, so that the EFI app can build
without needing --gc-sections

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/fdtdec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 3b4247be25a..0244e8a3a72 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -248,6 +248,7 @@ int fdtdec_get_pci_vendev(const void *blob, int node, u16 *vendor, u16 *device)
 	return -ENOENT;
 }
 
+#ifdef CONFIG_PCI
 int fdtdec_get_pci_bar32(const struct udevice *dev, struct fdt_pci_addr *addr,
 			 u32 *bar)
 {
@@ -264,6 +265,7 @@ int fdtdec_get_pci_bar32(const struct udevice *dev, struct fdt_pci_addr *addr,
 
 	return 0;
 }
+#endif
 
 int fdtdec_get_pci_bus_range(const void *blob, int node,
 			     struct fdt_resource *res)
-- 
2.43.0

