Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF036C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9049B876B5;
	Mon, 27 Nov 2023 14:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bbEy7hOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B218768F; Mon, 27 Nov 2023 14:00:53 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8754087633
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50abbb23122so5429242e87.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090050; x=1701694850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXzvm6rn44kJGwd7qA6dsX/8u+B/TFErI+G1ButGl5M=;
 b=bbEy7hOpaSiO/TOQzkl0WFvECzUSMkt5EY0h2yG++QGtUFVYWIQgPuZcRrphc32MSh
 +NdRdGDWW6TMNTscF7wxTx+iXIKwMvuT2EF8aIMI56E3Z8WrA00aaFaYC0sWA6Zg9RHr
 pVeIVfz9WbKkG0NhO2FJLGSRBwAWcQ63jgoixHYUOko7N5o2qtzZ+N+uQd5d3gK3EBIk
 Fc+OarPXWFjJ0wmKwr03dVZyWaDZchiqfqer8Y7sofLp8NwgsKXC5oI/jTsA+7LIZLOY
 9vHIscP78ksOzvMIZ3wvqEJyhJ2dCpjDnQ3tEvj7FMRJ3nXelMbzADjOAhHsCSm7ByU4
 9cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090050; x=1701694850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXzvm6rn44kJGwd7qA6dsX/8u+B/TFErI+G1ButGl5M=;
 b=MtGRNmk8ouZl5Jgi8pwYOK1/oMReJxC7VgQOli9EbgGZhZEw4NUR7FohOyQdyUtEGt
 kmklPBMVJeahNxzHIpD3xCPJ078FZfSP0amALK/AMKVrNumyfQM9JSF/lZxoFdkAhCLQ
 AUsSWJejl7HWFz41BralXBUxL5yEY5GunfYbhCKB5C6ya3O+1HpSs53LU8Xb8pJJhJ9g
 SalqydBfp5FBZ0dTJqMOV2USDYHyWXuMI6b7spfbbULwa6DnZ6Ex85WDxvsul7dyDyAK
 pqgoV6OZjhWnQFTJGFOIfwCzA4lk6/h5FTyM8nsF2mpT+OQ+6F9IJKsa0Ajt1nkwYvBz
 aFaA==
X-Gm-Message-State: AOJu0YwuUuFCDAHBVvy5X8L+PwTmzeu6E6xAck7gkgyKXeVsFKKL5dFX
 Yo5YTzRKqm2NzJXzLxyxYmZgH4ZHaoVhGKHoiiNaSA==
X-Google-Smtp-Source: AGHT+IFrVoQYR8NCAVp0KTUYqeX3ghyRfUR4EbZylQu67xgll95ngb3chElTP7/JwCuaK+zgipApRA==
X-Received: by 2002:a05:6512:4d1:b0:50b:a806:966b with SMTP id
 w17-20020a05651204d100b0050ba806966bmr4363877lfq.23.1701090050638; 
 Mon, 27 Nov 2023 05:00:50 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:50 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 18/43] net/smc911x: fix return from smc911x_send
Date: Mon, 27 Nov 2023 18:57:01 +0600
Message-Id: <20231127125726.3735-19-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

return value of smc911x_send is ignored, but on sucesseful
send we need return 0 and or error -ETIMEOUT, not opposite.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 drivers/net/smc911x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
index 5c5ad8b84a..616b7ce174 100644
--- a/drivers/net/smc911x.c
+++ b/drivers/net/smc911x.c
@@ -403,7 +403,7 @@ static int smc911x_send(struct udevice *dev, void *packet, int length)
 
 	ret = smc911x_send_common(priv, packet, length);
 
-	return ret ? 0 : -ETIMEDOUT;
+	return ret ? -ETIMEDOUT : 0;
 }
 
 static int smc911x_recv(struct udevice *dev, int flags, uchar **packetp)
-- 
2.30.2

