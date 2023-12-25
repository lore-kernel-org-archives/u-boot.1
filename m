Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33612C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 15:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 401D287767;
	Mon, 25 Dec 2023 16:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G4L136ZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C829787767; Mon, 25 Dec 2023 16:42:00 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D16EB8773D
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 16:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-336c9acec03so405956f8f.2
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 07:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703518918; x=1704123718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gahorcfoNv+yyzQwl9V0XMJNPRbMhyFuJjPHNmT7iCA=;
 b=G4L136ZRAo2zFjcftZq7mnVY0CMWH5P3XbctSMLw8IxmR1pZ8a20/cgEkmMXXiBJun
 3DZZuX8PwnD+9Ny5VUeUDPRuoaVEB06ueHi+2iqcS1eM8OtbO14QizbEu1bxJmZSx43e
 mCZGcGYYiGOsoUDRGdR7km/Fx5GUOi2LxvRKQ7pGOt/mxWwtz1Kn3ejy+D6gXEQrbH42
 fcIxUwbq0DqbM/SJ3oxV8ET0kK9UFPc0PHz65Y3cg/yAG40A5HU3uqBTJQe15JEM12sW
 RcEzVHY+L6/XAq+YQCNAlcXFQybrQD6Y4jJV9X4KjdXDITeQUn1C086t7vO1IoYfh1Z6
 t6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703518918; x=1704123718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gahorcfoNv+yyzQwl9V0XMJNPRbMhyFuJjPHNmT7iCA=;
 b=tPy7dWajFSOGPsym4UnVEb5Qify3gfY4BUqeg0WCqt/CGS93p4pKH0LSXAo2OBnkNn
 CUb2wHKwRIf0sJvNG9xKOE3Hvyg0kOrN4OVNhz57P6tbS+trEfeQPwMJSy70AzkL1W2e
 AfZpcFOTiLiU/fLzrf2ExLff4YA8x/KBceAaMXWm6OpGA2XI7bOKwZc+a3phbJtUNqi2
 UUnVE0c5oG3MKisC6tc7aNo3njTM/dnpfO6QBGP9e+yzxJye7ca5stSylCV6VQmI+OmN
 kGyksRujnwfkLPyEZIVDrWwBIYKIZtDtQ7vK+wKJpCE/pOeJM1lYQVJWK+k0KIQCZM0V
 FBAw==
X-Gm-Message-State: AOJu0Ywb0nx4612qtxlqHzltUyWngEoJc4QrNauHxoEHFIfT/gbwjj5c
 XBa47696dy1sHSk/AYXHB0ywq/+KgCn0Q+Uaq9kP55y98tw=
X-Google-Smtp-Source: AGHT+IGCQDIvRR+479QBCAeakWMa/i2iGDFjb6GRk2Zvow8iSpVKooOmN8McO9M8vdg1Ci70hFF2cw==
X-Received: by 2002:a05:6000:1081:b0:336:607f:5c9d with SMTP id
 y1-20020a056000108100b00336607f5c9dmr2940270wrw.16.1703518918210; 
 Mon, 25 Dec 2023 07:41:58 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a2ebe91000000b002cca6eafc44sm1425644ljr.113.2023.12.25.07.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 07:41:57 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv2 4/9] sandbox: eth-raw-os: successful return code is 0
Date: Mon, 25 Dec 2023 21:39:24 +0600
Message-Id: <20231225153929.8284-5-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231225153929.8284-1-maxim.uvarov@linaro.org>
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
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

all network drivers return 0 on the successful
transmission.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/cpu/eth-raw-os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/eth-raw-os.c b/arch/sandbox/cpu/eth-raw-os.c
index e59b96be5f..92c35aed95 100644
--- a/arch/sandbox/cpu/eth-raw-os.c
+++ b/arch/sandbox/cpu/eth-raw-os.c
@@ -256,7 +256,7 @@ int sandbox_eth_raw_os_send(void *packet, int length,
 		       strerror(errno));
 		return -errno;
 	}
-	return retval;
+	return 0;
 }
 
 int sandbox_eth_raw_os_recv(void *packet, int *length,
-- 
2.30.2

