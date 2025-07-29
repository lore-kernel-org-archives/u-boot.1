Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CF4C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D0C82CFA;
	Tue, 29 Jul 2025 17:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ApkSCHav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23B381E14; Tue, 29 Jul 2025 17:50:11 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AB2282BA7
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so35181095e9.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804209; x=1754409009; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eG215o2L6dTF5UVmOvDhoEeJt/2JGwDj8B519N713YU=;
 b=ApkSCHaveM5LPW1bCfjqLz5v39MYwrWihQbey4d3Erj9KkALCC1xC1ano5EI8uK7XU
 I94rwbx2MiAQqVCEAx5z+lujhI0VQeo5ZGgAUAIyQ9Nimw/QFSwERXxk6SL15Vp+BnW9
 D559WpKHmXmz0VqqOvVxoZLtytUWZEaOfcfJzc2PnOlSnJfvss+CuxlFoEngDDCYVPCt
 Bgybuylskr5A3SH/wNPfmzJVhSQkKFe6xNWlG88s5mXPzRizTUUJNm37f8RdoRnw7PT4
 eDl9mjhSvzQuqz+76+dPLQm5dE98jHrFF5ZtFbvjhgvitNFv5yZS1R8sUPzUqx+7kQri
 dmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804209; x=1754409009;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eG215o2L6dTF5UVmOvDhoEeJt/2JGwDj8B519N713YU=;
 b=lyW6/MSALOSwnXlfVxFTua2C+PgYCExi+j3PsVaCISnAIfqj68lLbb/jLGnxDNKYyO
 mJYe7wx+mqMGkl3U/fnJMbMlNe1fzfGFnuZNOxi+QVy6Df6ZjyEf0C3VJLDF2y59TiSq
 yzdDKLS8e2WD/tkPU86E7enFcMmM6CnZVNLuYWHNP59ZCCiWBE3R3I5HDUb0n1558OEZ
 kRpGlweFaSCNm3dRD96v2M26zUIvYjMz5Ls0iHf5O/njCOjzj27nazy29Rf/hsrJQSxz
 tprahz5UOz+nwCp8y19c9ga/3MmL5QAH+qjecdAEGrNGvNKMbM6Zo4RSQrE0aFjROFfl
 f9gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0FHYaxHP1Xk+WS4L7Sb9Nu9IZNzPKP8ruIHfqpItYw09/OAIiS5fr11iLk8DsWUEOPqgedhg=@lists.denx.de
X-Gm-Message-State: AOJu0YxYYIULQ0jD0M9WkH6fq15fBM6xjTm8RFfGuM9ilN4WnZ+3jGwH
 1CROD+WlQhfU8G7xcFy7roDbEG0sSgQFK0Iv+SnIXwxLLQOaIddX6j9wkGwboU6elmI=
X-Gm-Gg: ASbGncvugPYh1IR0tgLv/yQDBVQ9H+MQTOq2KUWuoP+XZqg07CVKaZgYHhYsYP3GIWM
 yTR4EpCMby1iySQe6ih4i0xWJi1a9Soq3eZ+mMe7HsFaU2z2EnEhF1fD6S32/GmlTgSKnWHDrYE
 dF2hk/f9RFNidNRyXfGn1QfjArqJvyJX8/BrEADvpBgCFAzm0OXfQuXoja8REnYw+3Ogk6YfQre
 LmyoRO2SiulfFPlZE1eo6EzWuWq2vRan2oU+fP3fzuX9o0Gab9VLT0tAGfc94vJMBNkj03kG27D
 CjkcHhIDSMKVpf1s5IXHOVblLlL+A1KtPi0W+2AyGvcOj2UM5j9QJUURgCPUHkHuugh40sq+iVi
 WT9odxcXz04rWHCeZe2vl78mFua///+eBYWu/vmj5OLvzhutRUYVsDfn8l47P89XwRbZKIdUAzQ
 +CPheynQXT0A==
X-Google-Smtp-Source: AGHT+IHIO53U7BX0dand/4+W/01Y0Sa9khc28Dg/kq8R2DWrH66fDzGazoXoZyXeu0nhMC5i63eODw==
X-Received: by 2002:a05:600c:64c8:b0:456:1560:7c5f with SMTP id
 5b1f17b1804b1-45892ba31d1mr3419535e9.14.1753804208874; 
 Tue, 29 Jul 2025 08:50:08 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5c1a2fsm30635875e9.12.2025.07.29.08.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:50:08 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:49:59 +0200
Subject: [PATCH v3 01/10] cmd/exception: missing include string.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v3-1-6f258b34fe8c@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=ht0PVAG/UPdWKeozeEuxksuwC/pt0UiZIujECKi0GJI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO2q/pEkaTl2LLh+x5/fNo/YgTKZRW5iftyxJ
 DH4eHC6IlGJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjtqgAKCRAFgzErGV9k
 ttHED/oDf/Iks3sY5HkJpKc4uHPdmZfQhj+03vidSxdRRISS3ZVc+4NPBUeW1oqgf7xVHY/wQ2y
 WT0G0BxOapKCjXhdLjUA6lcHJwU7GX8MGP2TaYxBDA56o0Gw4LrKzB3LZuSGGKpbblVxTxvxKPR
 mhyDgMGQoYJt07gDJf1Ty247bnEhbamtDOx2GVwKTxuOlENkQ6HJRQvSwWFTjG6tK6ys/Y5Qn8P
 3WpT03pAdm0fI0+oVw1+Mc/pSBQS2cOL1iUFosnsBOMh78FXQRsQKBYw+Iqtm6/a9z0kCO7ygIt
 zwnVhgXduidYN/iPA76EmZxg+qLcVsp8SimNJTws0HbrdQckvK0VIIlWLy5sCuPJJOAZFX/luqD
 4epRDBEA6aU3sKeGFImPRf3IiPgNZHcmY3VT1tiVALLH43cSxt1Dy31V/RwOM+431WgcS1UTAR2
 7roVNTLQVitNRmb95gMtro5GECs/SjCn4RZQ0NYRVnWi/Jjt1Me3OePWzf2CDRvjQ4FFT4zPioe
 3Wyzl6hlCLTlJZUhR7loSG/nhS6ugfOVMuaEe5jCqBUAA3UYJwQ2ZdeeVlmxbkbd/7gWl16R+Mg
 P1XWixkbg0mxJu5cY/sp+j8IPKmV0waGXY8jLS0L10h0UkB79GIFILuC634aXXa6hvaHpviyKmT
 NcL5fpZDWYOej+g==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

When building qemu_arm64_defconfig with CMD_EXCEPTION a build error occurs:

    In file included from cmd/arm/exception64.c:87:
    include/exception.h: In function ‘exception_complete’:
    include/exception.h:41:23: error: implicit declaration of
    function ‘strlen’ [-Wimplicit-function-declaration]
       41 |                 len = strlen(argv[1]);
          |                       ^~~~~~

Add the missing include.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 include/exception.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exception.h b/include/exception.h
index a7f21e73d7530972eefb3255d799ed45de30c82f..0d4dff49954ba1445a16c151ab480d9859a7bea8 100644
--- a/include/exception.h
+++ b/include/exception.h
@@ -5,8 +5,9 @@
  * Copyright (c) 2018, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
 #include <command.h>
+#include <string.h>
 
 static int do_exception(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {

-- 
2.50.0

