Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E95FD64086
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 07:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B2A783AA0;
	Wed, 17 Dec 2025 08:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="XaaGsoGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D4A83979; Wed, 17 Dec 2025 08:26:09 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DDAF83AA0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 08:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so64293775e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 23:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1765956366; x=1766561166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8q4x9d+c/TosqSDE7GRXflwLAKreAO5jRHTE6nveOc=;
 b=XaaGsoGGYUk51VEVoSt+G9TYwiL2AhS3/VCwYW2eCIdSFl6Os3z2qdA+6kxI/5A+Cr
 T7XYeha2RmbY3P02TS7lht2M55dRjtz8Oekkj036WpyqbaPgWSga08G4VkLv0qXd5dDP
 JMsQcg1qpytYsO9+Ysy32paRDy8t6GdGJIceWp9OPs0/xW65t+m+7qSJbckPqZzW1+YD
 gyzmQFIf+Idd6ZtlEI2etRrazlUfirArYmf4UoVdJOtJT1QhCRVhB16TecPDPGh7/qpV
 RiyXMD9zhKVQJ2yKQT1FKpQy6DW1TaCzOuPTfpqhvOyLfVyjGCJLd6WW8aNpwyheXQdt
 NhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765956366; x=1766561166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J8q4x9d+c/TosqSDE7GRXflwLAKreAO5jRHTE6nveOc=;
 b=IWbgxPgi7CdifpxbCVNob/sqsQJeS88BhDiz0tNezXAKHkdTyBjdGBF+KcrXY5h0gp
 1Cc4GvCpS/wGTE5ldGt01Nk1AYH4WSuBaXijlQV81XzpVEUixuZreCyfmQDkpRXLAKUy
 CigbhM3iO6tWVuK5rTr3eOmlvkxLZMJI0WqV3mSE1GBNeom+Ji25znYuvv1mDFXdP5nX
 PUu209ANGq1bjbqYAQAJ6zMQS1LyDR3GgVw1sLZb8+qwotQtZwCd0CUMLYxd+agcRqQK
 RrmjacuRQRq/JO6CLWyJu9WEQYZIQByA0qVdaR+X66+xhbwrLPNznC6u4aaeRdiLT629
 /LpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk/VsJTBwWJfnkTiEpLYKFff5mLTYDrFmyMvni7eCjtLqRI1MIWfwRlS8E4AYHHxOaGP5SI4Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzuB6EfDnbL7bVF0hd0faXntyTYYd+6adV/m4++yHHrrU0hvX/y
 6KrE7SKxGfn2pAu2NbPdFao/xkwdUBhBGSqaBX4KBS3TVuroi/YYSkiseaNE1+6FHzsyzyvEMic
 6waVjfOc=
X-Gm-Gg: AY/fxX4094F/bE3F0b/ku5LGlFDDXLXhrOPvnK9UDnEixcEsPs/zO9dG3qpPw1WT6kd
 pfPMgM0sHBsg7RspMiJzDCQ83FHHNSinhn7R9t0nVzQXCA4FAa62HqermGPCbLLnrEECz5V4JZ7
 oJrlhcraO1IrduNCbqFgXpRSjEaOyYFr/8kJuvKJ4/+Kqo48hXWsmrbi+nxHFsp7araIDBAvTRQ
 9mdlfKaHSrLkTilGxXv6CnG1dQlApIbURbAsipN+jafEYcqVQXFfH7j/L2zaawGpxvIqq8ihRZ6
 GoHuhwAmYK9U/YCHn4Y05klLCxN3fBtOq2OpGhHEmGTnblzgHdcQRsk7h8sOEslL+6Q98YC8Rxk
 xh63Y0ublYoGvdBprpvlEKJn3SreQX4M4+pPTT4z4K+iOUGBwhpO4EYc8Otub1WvDTW5FUJlv8s
 fiRUhN1fVSHZylJBAGF0Cn/gZuc02skNQpPkyZCa9QgsdYjAQwo1XG/WyvZKTPGugnqHmFjXBg7
 C1wQgxqX+PLS411
X-Google-Smtp-Source: AGHT+IF+hJuK9lcUxnSEHRwCtQT1qwxaJnUxf3GSHyTCki6DhAEUTTNyrfU40bOl3oZGQ1Yh+xtPhw==
X-Received: by 2002:a05:600c:4e09:b0:477:9976:9e1a with SMTP id
 5b1f17b1804b1-47a8f89bc6cmr184911625e9.6.1765956366112; 
 Tue, 16 Dec 2025 23:26:06 -0800 (PST)
Received: from T14sGen4.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bd932a3e5sm24248265e9.0.2025.12.16.23.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 23:26:05 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH 2/2] efi_loader: Fix kernel panic when FTRACE is enabled
Date: Wed, 17 Dec 2025 08:25:57 +0100
Message-ID: <20251217072558.2949569-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217072558.2949569-1-patrick.rudolph@9elements.com>
References: <20251217072558.2949569-1-patrick.rudolph@9elements.com>
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

When FTRACE is enabled the EFI runtime will call the tracing functions
that are not marked as __efi_runtime and cause a kernel panic since
the functions have been previously unmapped by the kernel.

Resolve this issue by adding the 'notrace' attribute to '__efi_runtime'
attribute and thus disable tracing the EFI runtime. If required this
can be worked out latter.

TEST=Can boot a UEFI compatible linux OS on qemu-q35 when U-Boot was
     built with FTRACE=1.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 include/efi_loader.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3e70ac07055..7a13c390cbe 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -66,7 +66,7 @@ struct bootflow;
  *
  *   static __efi_runtime compute_my_table(void);
  */
-#define __efi_runtime __section(".text.efi_runtime")
+#define __efi_runtime __section(".text.efi_runtime") notrace
 
 /*
  * Call this with mmio_ptr as the _pointer_ to a pointer to an MMIO region
-- 
2.52.0

