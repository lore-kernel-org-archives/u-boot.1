Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B989C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 12:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 061818758F;
	Mon,  4 Dec 2023 13:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Na5UOZc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EB8C8754D; Mon,  4 Dec 2023 13:07:18 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 590A68758F
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 13:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50bf7bc38c0so952204e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701691635; x=1702296435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gahorcfoNv+yyzQwl9V0XMJNPRbMhyFuJjPHNmT7iCA=;
 b=Na5UOZc5Q4ap2gwQrocmhAKB4jcFdBR/SzAEtsTav3+p4QIY8Y5sK0KA3drz4rKBBK
 11WHjxsa4XCCunHj9b/1ay0c6faHmYGMaKXIeMgqH8upqwjnP5b8PZzdDMDE3Nh4myyp
 W3QzEE8bPJ+Io5lPhGGuy1L2eqxa9Tci9b91zuOLxiahrqQmwZHUhzz7RbA7u0URUkHU
 /7iLdCWhLxBV32BPPmGJl/8XqZiGfcbV0lpEB3PkNHEYo3zbpnaSmL0HXJ6+4c0UaKyr
 108lOdlEr03StZ183cikwea0vNAbpqjsr5T1vzhJtZmAJwq2HRH7hgiovL1OZByhF9Qf
 RE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701691635; x=1702296435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gahorcfoNv+yyzQwl9V0XMJNPRbMhyFuJjPHNmT7iCA=;
 b=J8oRn5ZhO7COVeU2ZVT8nduKwrcx7YOn2uy1JJic37cSEvd0vr36DN1j73C9OSx/sF
 IZNCG1Q/if0Fxp0Gxq54uQk3QSpFLMglcjM/misR0e9YbG9vnT12//98m+0St3L1AcQl
 VBMIeMTBxbAyMWMemcZQj5/stP+D8Sgx9xgsUeJziNx6KYZg3heIgSP5T7e/vd7drrKT
 AftSyx/6jcBXBhjwAKx95pWYHO22aX8PxP1KnbpjZvT0EWFqSXPSthCziw5EU6dLxAF9
 Zcht0AkBWPTXgnRYZIsh+qEPw1WsnNjeK7QJWBRDUnTSllbXhKu+nYJZZfCq0eOH62Il
 J25w==
X-Gm-Message-State: AOJu0Yx1Mzi5w+pzwoWUcSigDAae+M1HMu5CT5Tob3xu8YinZxO63k+W
 WC6JKUf0PRZQ0iZ6vRkpyGg+35CI4uDHbDY1ZLc7iA==
X-Google-Smtp-Source: AGHT+IG5YgQ3nUY3WS2cb9XEvjnTqvKAD5NYt3U8R8v8u9H8/I4V783YLGy2PKzajTxSOEGiNtM01w==
X-Received: by 2002:a05:6512:131d:b0:50b:f92c:37fb with SMTP id
 x29-20020a056512131d00b0050bf92c37fbmr552684lfu.43.1701691635134; 
 Mon, 04 Dec 2023 04:07:15 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a0565123ba100b0050befebf0ccsm541675lfv.292.2023.12.04.04.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 04:07:14 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv1 4/9] sandbox: eth-raw-os: successful return code is 0
Date: Mon,  4 Dec 2023 18:04:41 +0600
Message-Id: <20231204120446.3277-5-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231204120446.3277-1-maxim.uvarov@linaro.org>
References: <20231204120446.3277-1-maxim.uvarov@linaro.org>
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

