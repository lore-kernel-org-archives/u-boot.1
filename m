Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B23C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 13:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BAED833C8;
	Tue, 12 Aug 2025 15:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eXlxPRXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96663833FC; Tue, 12 Aug 2025 15:31:23 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 269E583390
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 15:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-459ddada9b1so50812115e9.0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755005477; x=1755610277; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B2/bhvQ3rM/EVAvBM/j9Z8/07qDpnxB5AUBpDAF87Io=;
 b=eXlxPRXe0C/+MTBi9L6HirX/RaFAseVJgKR2pJaPvQ8zxyy0Hu72F1Uw4rxQrNox5n
 ibvfmoXnPyfk2R+nP7QgYOz/Oowatc2Utp2Lrtef5gjjCzQ8UlIiXeexxkXgb7gCiyIp
 J8lCeD/+hP67k6u1353ht41aIthjKj57Bq8Edb8l199LUe5BSd40W5HItI8UtbNThLQP
 NQtyGNsAKxQGnJ8hPWz4F6Naw/zygBEVDoP2GWG54ZnzvoN/9pN5Vb4vE57Ugu23u9V2
 P5YK7cdsRXRtqI1jMeKEAGJnrOtwZb2wrycJfpR3G7jtdS1ttAhuZhtWNEMxyse1BUqz
 6OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755005477; x=1755610277;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B2/bhvQ3rM/EVAvBM/j9Z8/07qDpnxB5AUBpDAF87Io=;
 b=R6Xj902JLZWKsxaVo5f3gUQQ8C8xLAE60u/X1G3Pty/SUccTcIwTGDcAWsC9loAWbp
 PcTHZjpcRei9I19VRd3GdS6+/vFscr1XIS4izvAn3ZSaaUIwgFXyibAlrtV7XRN0st6i
 9Gdbtw0uZadbqOrjMLKsk0//hIsw22rdl2jmck5KBnUcyXpPhbqd6gj9ImFv9Ryuh+YW
 CeM8yT05yxD2Qq/gfdOx4vqbInGiDj9s9oj1yu/uHi4A4hTl0BPti/mE86kcU0/ftH/O
 r9wIUlCj7HVz1gEcIu6wX8ZZ5re85EM6HOGjbnH5PA5tKkdwgsbrsX09nKf0KWT2T9M0
 zsjg==
X-Gm-Message-State: AOJu0YyQeaDHi3QNZsviapicUzdOhMpJpROSpWTdDRyY7GiO7pTij0L+
 4H94yqBJ6rt32QNRLGKKnsqLKguSPn7jvWJvCNoEPC73kQyYU1Vq74HmhIk7X4H6uO3E+/l1EZU
 Zt6cF
X-Gm-Gg: ASbGncvTkA6VND9lySGPzHUysycjc6XZUap9lSxMlpYRVdCm2nv3j9lZ6eTIXwWQBju
 tGqLqPXOzM5z2u27p9SnRF2ikdwIPJ4qeecWiwz1fj4g4HqWkpxUO0cmFfn1qnuolom2TTzrZOV
 9aC9YWdO45KsIMacdHPZ1bIquf1z86kY1yNjbs57AyVtvtwyEjq38b9LckYlBpC/gHY3cnqxfVj
 bNHRoivHS1G+bQ+5CM+Q7l8TofDGy2+3Ygtt3P65Ik1xPQSKtLZANMQSr/BbnBwxasR4lpuz9y5
 7UT8rl2RN6chTqBzUHOsWcXTfwvTatg4KWvr3eWxDvx3om189EUeuhFdIA6+hl5wWJ8V+Cby3dl
 zlWtfNsvlK0yZSe7UXAXmahvtY0llSxWOZ2b8ocOtfYEZJS5vunI=
X-Google-Smtp-Source: AGHT+IFXtXVxxYqKEdaDvSnyi/UKRLWMPhL+7pVgMksVX4K2RJdC8mK2aNgodi42wP1CBXsGjQlzKw==
X-Received: by 2002:a05:600c:35cb:b0:456:1c4a:82b2 with SMTP id
 5b1f17b1804b1-459f4eaf75emr173755645e9.10.1755005477409; 
 Tue, 12 Aug 2025 06:31:17 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e584302csm321550525e9.7.2025.08.12.06.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 06:31:16 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 12 Aug 2025 14:31:16 +0100
Subject: [PATCH] spi: ich: Do not use uninitialised value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-spi_ich-v1-1-6bfc94a2b31a@linaro.org>
X-B4-Tracking: v=1; b=H4sIACNCm2gC/x2NWwqAIBAAryL7nWD2pKtEhNqW+2PiRgTR3bM+Z
 xiYGxgTIcMgbkh4EtMeMpSFAOdN2FDSkhm00o3qSy050kzOy0qprrO1a3vdQq6tYZQ2meD81we
 8jk/HhCtd/2CcnucFN4+J7HAAAAA=
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
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

In ich_spi_exec_op_swseq the variable with_address is only assigned a
value in the case of op->addr.nbytes being non-zero.
Initialise with_address to zero. so that it is always valid.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/spi/ich.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/ich.c b/drivers/spi/ich.c
index 2264ca83d66..733ff8ac777 100644
--- a/drivers/spi/ich.c
+++ b/drivers/spi/ich.c
@@ -256,7 +256,7 @@ static int ich_spi_exec_op_swseq(struct spi_slave *slave,
 	struct ich_spi_priv *ctlr = dev_get_priv(bus);
 	uint16_t control;
 	int16_t opcode_index;
-	int with_address;
+	int with_address = 0;
 	int status;
 	struct spi_trans *trans = &ctlr->trans;
 	bool lock = spi_lock_status(plat, ctlr->base);

---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250812-spi_ich-30077b4c6826

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

