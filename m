Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9454DC27C55
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 03:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AE008834D;
	Wed,  5 Jun 2024 05:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KaGw7gCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D80C88369; Wed,  5 Jun 2024 05:26:45 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19BA08785E
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 05:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3748d68b7b8so20966425ab.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 20:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717558001; x=1718162801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xy8Pg3S8PFWO/1qkoZhzBYf32QarjsOExYRZQlWgvFI=;
 b=KaGw7gCxznqc8+CLyH9MU98iQtAnQo/0gpb/ngM6nMxuGYRzUh8v41bdX4SlrmxIFk
 KUpOkxpVbSkoD57z31iMRLKNA2nHCD8NKxig+WxFIwzXtLvZHeYGJ0CjKOjZb/0qDdCU
 QZluSubLFP2f7zeO9Vyd2W1PFBTEjF3APSZ6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717558001; x=1718162801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xy8Pg3S8PFWO/1qkoZhzBYf32QarjsOExYRZQlWgvFI=;
 b=rg1aGV1n4YhXVO3POOLMa51/q+CbH/D/v6YIXy1DoB2HplU1a5816Usn1cdxBv3ONc
 EnbMbxzMkaBSbdTWc+WL+o/v+xo1E4Opyey+HOsUeHwxH9XkefaF7HXVsjBIzIKUBUX/
 016FhFCyLQ0VtyG5/VKXp+jZJ1y9RrHxfCTeaG2GCj9lqIfnsf/Sx8WlR9yC9Ca7J+Sj
 7GKPNXxqWx9hY/y1bJncS0yrhTZk9bCYGNwxDfDf2r4lqpYlq+vEV/QwAJt4yZJ8ERhX
 XvOaAGb6ESos+EEp+jrj6xcArLJpq0V79S373YuTkT0wpPSlyT+YlLQAEHH8/bHVMaZB
 pDXw==
X-Gm-Message-State: AOJu0YyHGjS0cAEvPH8tAAsiuc5rriNDzrqxSur9nKXC3ys0T+Fc+oZ+
 69uwmUZEImLeImCtibAYbdH4WyBiEI/iN2IfLqE4RYO9BTzL+nNZjJI3EP1FTV8PTV1L5dU7MUn
 6oQ==
X-Google-Smtp-Source: AGHT+IGsYAG6XDToPV7qBeplPEMB30hCNByY443M3+rCqH7N8iZHqirXtspZ0Pe6XX2UT0X+GeN+Yw==
X-Received: by 2002:a05:6e02:1806:b0:374:984b:104a with SMTP id
 e9e14a558f8ab-374b1f3e318mr12958885ab.23.1717558001559; 
 Tue, 04 Jun 2024 20:26:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374af0e3ef1sm3691495ab.34.2024.06.04.20.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 20:26:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 6/9] spl: Allow ATF to work when dcache is disabled
Date: Tue,  4 Jun 2024 21:25:18 -0600
Message-Id: <20240605032521.1142768-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605032521.1142768-1-sjg@chromium.org>
References: <20240605032521.1142768-1-sjg@chromium.org>
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

The dcache may not be enabled in SPL. Add a check to avoid trying to
use an undefined function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl_atf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 3bdd013a35f..9afe6456bc4 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -204,7 +204,8 @@ static void __noreturn bl31_entry(uintptr_t bl31_entry, uintptr_t bl32_entry,
 						       fdt_addr);
 
 	raw_write_daif(SPSR_EXCEPTION_MASK);
-	dcache_disable();
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		dcache_disable();
 
 	atf_entry(bl31_params, (void *)fdt_addr);
 }
-- 
2.34.1

