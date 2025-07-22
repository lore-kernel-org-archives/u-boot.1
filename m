Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384B4C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 18:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96EB283390;
	Tue, 22 Jul 2025 20:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FtrpmfCO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6ED9833EB; Tue, 22 Jul 2025 20:27:14 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F5048331F
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 20:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lordrasmus@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso41837225e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 11:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753208831; x=1753813631; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/PKp+b0GPxQpMzuSzmkcyWv17u9BssXlZzJkKKShzIM=;
 b=FtrpmfCOwqhHk8v4pC6qvANdV+pGwJcMo67lUcNgK18W7+gU+978re5jlJO//wHdNe
 U1X2A2bTAcrGObDpfeksvR6xnZpiBUNtZmo8apefSyhq9s0dLYmH5yT3V/vsc/ZKcRhq
 87sty35y8dfmWvS3IsDJALYB/UPofvkAHyxs5zWkZ0aTLJNEs/PAcJre4SUh1e1aSoQf
 y+x+qTzRyUriRwdCYnpa7B4JyFHYEi+MChN0lnIHpzGCNx+0QgNnxRDV2S9tipGkc2DF
 cpl67zzE0+a18voFO6QdMYSdncmKE+lHkeuQt2lspx+LsMDs0fO37TdKoUvpOc6mGxOq
 XNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753208831; x=1753813631;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/PKp+b0GPxQpMzuSzmkcyWv17u9BssXlZzJkKKShzIM=;
 b=K3nMV6MuipkLTasnkvJeD9dsRoV+5P5XjVnhqeEKB1t4AS553OAclx7tH3uN6CbnKb
 Tpu82ZsrrdX2R9aRUatGMtR2kI92w358OKFj0jLqOXBiCB6dpfp1CPhufKS/r4RigzjC
 mwknsvEUcVeodQpMcHUpmUBeK67TC6uf/tkvA5HKNBnW41+R+wJg4wRwdAKveIpWycRL
 0dBjhxPNgjfu04E/u+B8r/0+kWbyIHwuLFprInPh0tG+tc1vSD7O2wXR/qce4uJo7C6/
 yjUb8pgkFM0KR//0396kvF8qIE6Qmj3YVQfmH18Ckf/tG1T8uT0FdCHFzLZD8l4vzOTf
 DUrQ==
X-Gm-Message-State: AOJu0YxGUloVs6oDEkBysRNVqVeZgmklo1FTXJlcMwCOi/2iMry6Z8bz
 1K6QyvyCMgG2hShchdgGqtK7vNjH+sKtvDwvgek13jKPL5NHoOanJkAe8Up6GV4I
X-Gm-Gg: ASbGnctM2PdLY5TCcHkjg01aIOtDdDT72ktht09zkVpbfB0MUd6I54g3EtvseZnNdsW
 HrZ2AZybb0o8hK1iYRYRe+/chQVg2yoqPygt28As9ZjFd/j3IMFfjRMfECR/zhuXKvDGO/bst97
 KecRP3Vu9aC720+e5QfGSQvgchWVlKVeZ7s9lwGMYRkHwTp3ohrF9iLvsjZncXX+a4UrLYF6VC3
 WQBapgTZ9L9A/dgg/7dTPx/BiAXo7T9TJIdoboa38/SOj9mI2ozFfsrIsZWUoNKqEGcxNk/RDBr
 jiC1yWgNrgRhZvFUhEWlZTH8KYzKIMsRyysJW2x8trnIytiCENngAcGe1JnMtLg93HpRomriMJ2
 GFn1cfGkqVIOUasbFtVU4zQrUJ7goeK0M4sNejg7ub4U1H+aDwQ9Pjhuie/s=
X-Google-Smtp-Source: AGHT+IFWiJQsyaljua0N8+aw/CIM1j7yj2CSl6HSzkP71oFwNFOu6GNU95qvma2rKmQZ2GfWLpJiiA==
X-Received: by 2002:a05:6000:2006:b0:3a4:eef9:818a with SMTP id
 ffacd0b85a97d-3b768ef3c4emr215192f8f.27.1753208831014; 
 Tue, 22 Jul 2025 11:27:11 -0700 (PDT)
Received: from archlinux (p54b96342.dip0.t-ipconnect.de. [84.185.99.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bb48sm14224079f8f.24.2025.07.22.11.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 11:27:10 -0700 (PDT)
From: Ramin Moussavi <lordrasmus@gmail.com>
To: u-boot@lists.denx.de
Cc: Ramin Moussavi <lordrasmus@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Alexander Dahl <ada@thorsis.com>
Subject: [PATCH] arm: spi: atmel_qspi: fix race condition in transfer
 completion check
Date: Tue, 22 Jul 2025 20:27:09 +0200
Message-ID: <20250722182710.6095-1-lordrasmus@gmail.com>
X-Mailer: git-send-email 2.50.1
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

In atmel_qspi_transfer(), the status register is polled with:

  imr = QSPI_SR_INSTRE | QSPI_SR_CSR;
  return readl_poll_timeout(aq->regs + QSPI_SR, sr,
                            (sr & imr) == imr,
                            ATMEL_QSPI_TIMEOUT);

However, this is racy: QSPI_SR_INSTRE can be set before QSPI_SR_CSR,
and will then be cleared by the read. If that happens, the condition
"(sr & imr) == imr" can never be true, and the function times out.

This race condition is avoided in at91bootstrap by accumulating the
status bits across reads until both bits have been observed:

  /* Poll INSTruction End and Chip Select Rise flags. */
  imr = (QSPI_SR_INSTRE | QSPI_SR_CSR);
  sr = 0;
  do {
    udelay(1);
    sr |= qspi_readl(qspi, QSPI_SR) & imr;
  } while ((--timeout) && (sr != imr));

Update U-Boot's atmel_qspi_transfer() to use the same pattern,
ensuring that both flags are observed even if they are not set
simultaneously.

Signed-off-by: Ramin Moussavi <lordrasmus@gmail.com>
---
 drivers/spi/atmel-quadspi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 8aa7a83aef4..0f9ce409a0c 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -616,6 +616,8 @@ static int atmel_qspi_transfer(struct atmel_qspi *aq,
 			       const struct spi_mem_op *op, u32 offset)
 {
 	u32 sr, imr;
+	u32 val = 0;
+	unsigned long timeout;
 
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
@@ -636,8 +638,16 @@ static int atmel_qspi_transfer(struct atmel_qspi *aq,
 
 	/* Poll INSTruction End and Chip Select Rise flags. */
 	imr = QSPI_SR_INSTRE | QSPI_SR_CSR;
-	return readl_poll_timeout(aq->regs + QSPI_SR, sr, (sr & imr) == imr,
-				  ATMEL_QSPI_TIMEOUT);
+
+	timeout = timer_get_us() + ATMEL_QSPI_TIMEOUT;
+	while (1) {
+		val |= readl(aq->regs + QSPI_SR) & imr;
+		if ((val & imr) == imr)
+			return 0;
+
+		if (time_after(timer_get_us(), timeout))
+			return -ETIMEDOUT;
+	}
 }
 
 static int atmel_qspi_sama7g5_set_cfg(struct atmel_qspi *aq,
-- 
2.50.1

