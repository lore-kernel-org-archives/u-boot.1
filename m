Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EFEC83F1A
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 15:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 764BD83560;
	Wed, 23 Jul 2025 17:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MaPeT0xg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2468835AA; Wed, 23 Jul 2025 17:54:14 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C94F28317B
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 17:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45600581226so70983945e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753286052; x=1753890852; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NIGDyyVMi/evug30YmdEebYIiZyVwDDzre7q1RSSP90=;
 b=MaPeT0xgdWn3frC/f9QYCCg7qO0cb0ImhvXqKWzOPSDn99m97CWoOQt8AjfDAV8u9q
 iiXAFkKU/ZftxaOEKotgTJCGhjUwFOCbUPtuqw2ZVTA5ewjX93P6Kq627CKphYpOYfDW
 RZLmzT+Ty+1C5vVM/N20eDv/OOC28zP39+bKyjBiNSbD2X7vPo3QSPAn/35LnKGOAAjV
 vOIyQ0rI0UCeWKJQbaVjMrBKW1n2kneuwFz4qz3P7MSNDLCnEg+XPgdqLDurQGkbqeBK
 DjHh829yGAR1hvKmFU7x4OEE+GhGl+US0PhJwB9FXkTw0nm/15pN+i2tVnI+hfAqYDqd
 BnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286052; x=1753890852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NIGDyyVMi/evug30YmdEebYIiZyVwDDzre7q1RSSP90=;
 b=AyDIcTj92afpErLm3es/0w0W10L3byAZH/rskhE42SOqvSjDUzWVHTJ30WGIhge4cQ
 OmiAOJLow1e2rjIaxyjnikMABEJQKVx30xxIUAPOFHr+iu95Ad67M4/o4YevGV/jcyqM
 MzvrSo5BSqm17WBgmIJbzMR99ToT31aB04IRK6/1OyvLrCMx8lxsRIhASMBbkNZazsK+
 oQRaT0eqEPz6t8rqA3ZsjDWc9fOTKK+8nwAYGfYBYDdTSfuFaGrLSbYRjblLBJvlxA9K
 E4O7f6NxDIiIZ5osIf673YSrfSPq7hpcjcxIpukInWEHJN0TtbaBBdwsqa6CxbbokGsh
 Od4g==
X-Gm-Message-State: AOJu0YwhD3oDlRGJuObzLLMm4v0sfbSYfoid2FfWRJqBLCT5kQQlVpoj
 vcR6aHEtAwe2VvubnFziU7o0w1QqCzXiZi94KUybO6Onn5Q3dhkcV6TUWQIflecujT8=
X-Gm-Gg: ASbGnctfYRq3V1niAUjYIRymvU63EB6Z45suhFnmUlui5GqW6ivtw3A+qKJsChtPTJJ
 rX6ODdXAtXQ5792rvI4yfIJ9jLJf/tTeKc6qEwET3QTBATjfestQikd/Wud7aV28pNkRjE++iO/
 QF0KgqtU8yNvttlQtbDC79dL0JaDFM8tHYPCB1IPdnM9UpVJy2+d/tYbk3i3M4AaFqW9w9dfNPJ
 XAGQL6xXWFfhYYrKjocIhYIhOpzbgYRfANfOLY6gkFc48BEupiC4vYcuKrUtwJ6Ko+V6do62Z5V
 Zlouyl+lnqgseGK1aOzvIR/E48laJLAqclpWe4ymPR/0DnnpdELBW0nAJlsAWKDW2xNWXFmQJ41
 ZtUNBF1dHM06BKlNEYp+idvFonQ+7+RAd7DwuVxUqnvMX928mmCM=
X-Google-Smtp-Source: AGHT+IGvsXLAR1W6WXVCTi6h61L2X5XL9eYsCJdQOb/f0ukfSTEnrQ9zGA3bd7nMi5XA/YSg6Wu7uA==
X-Received: by 2002:a05:600c:8b46:b0:456:fd4:5322 with SMTP id
 5b1f17b1804b1-45868c978cemr28056085e9.11.1753286050667; 
 Wed, 23 Jul 2025 08:54:10 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cdd8:a59a:1949:12ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45868ef50d8sm28345045e9.0.2025.07.23.08.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:54:10 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 23 Jul 2025 16:54:08 +0100
Subject: [PATCH 2/2] clk: versaclock: Use IS_ERR check before dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-clk_versaclock-v1-2-9d70f2530871@linaro.org>
References: <20250723-clk_versaclock-v1-0-9d70f2530871@linaro.org>
In-Reply-To: <20250723-clk_versaclock-v1-0-9d70f2530871@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In versaclock_probe vc5->pin_xin may be an error pointer so need to
check with IS_ERR before attempting to dereference it.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/clk_versaclock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk_versaclock.c b/drivers/clk/clk_versaclock.c
index 790ea4dbe82..19a787eaf0c 100644
--- a/drivers/clk/clk_versaclock.c
+++ b/drivers/clk/clk_versaclock.c
@@ -904,12 +904,12 @@ int versaclock_probe(struct udevice *dev)
 	if (IS_ERR(mux_name))
 		return PTR_ERR(mux_name);
 
-	clk_register(&vc5->clk_mux, "versaclock-mux", mux_name, vc5->pin_xin->dev->name);
-
-	if (!IS_ERR(vc5->pin_xin))
+	if (!IS_ERR(vc5->pin_xin)) {
+		clk_register(&vc5->clk_mux, "versaclock-mux", mux_name, vc5->pin_xin->dev->name);
 		vc5_mux_set_parent(&vc5->clk_mux, 1);
-	else
+	} else {
 		vc5_mux_set_parent(&vc5->clk_mux, 0);
+	}
 
 	/* Configure Optional Loading Capacitance for external XTAL */
 	if (!(vc5->chip_info->flags & VC5_HAS_INTERNAL_XTAL)) {

-- 
2.39.5

