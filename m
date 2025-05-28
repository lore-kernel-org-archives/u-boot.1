Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A95C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 715C3839F0;
	Wed, 28 May 2025 10:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XJVzucmu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F89683966; Wed, 28 May 2025 10:26:39 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6ED839F3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3dc7294716cso35222415ab.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420795; x=1749025595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQNEZH3JOAL8B/l3VOrOCgFtyewiXCqYFFIrCOgKock=;
 b=XJVzucmuPNNRGS87EslreBiyOrv/aGrXVulT9+0Gv2C7PxQHXQhB9XZBTjT599CG91
 h0cXDnQzA9fCgwCGtKdlCJlP9o+4zb7Nq/5cNkjyIxOhwb7xWUBj46OmfZSQgesfGbj5
 I6SQQFqPalgzLiIJTAXO52A8VGNcoGB82p+WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420795; x=1749025595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQNEZH3JOAL8B/l3VOrOCgFtyewiXCqYFFIrCOgKock=;
 b=MlX0mlxpt+JKCMQ7dO3/nICHlljdVpL4qHwrcrVni0l+tYxIPkCyXiAc5fk4sOPebX
 yM2IRsox2eJLOjRyiv392H8OsVrRx89euWeVKRIYLdarvHgEBKrfv/0qamIlbrs3z8n0
 TOlfyMThgTkceTR1WtdN6zu4oebLC6yyEv9LETkLaz2AWiwxR7ZKILJjKqaKCh3DxsW6
 oT28QxVqirt2FlrwljSQRwNctRAc+xbMaaoioNY6HpFzzKjWvna4drC4qmxPb6qApN9X
 vdUbygTPIEH9zKuBW9DZqWFA4F/sOBvQ+8wgW2Zz3STJSTLjNT2mSccH5IlAP08tUrEI
 PDcg==
X-Gm-Message-State: AOJu0Yy3pj2kkLeq7igIbqhgEotCpQR0Sag/r++E3FXQePh7BcsaDRdm
 yayFWCNNSp3AJbOUFckmHTFze3datdUkBz0PC6I9uxGtae+WsjBWDxT8y6W1y1QULJdCRKtuyCQ
 IUMzhG/36
X-Gm-Gg: ASbGncu7e2rbqok8anQ1jlsOqH6JTCUDYJa/0s49pX70zz3tPMfPRp4nIWkRnH2KJEs
 b//Zoj6f6DI9KxWBjOpcCiX0ZIuX5QzIE/g/eoOvMnUP+wYpTAIY2OCi6e7ir28rtprAorDrUP3
 REGduFHgek3wfOtpPTowppYUyhfbt+kVZVQr1ErVYyOJley34C6/uy5I63V9z4nTOR9cnqwPWZm
 IceJbSx2fB52mUkXqco+fsoJfsPDV7lH32LZ3KZZhFGgn5s2NlJ+gKfFLrW768ZdAffZ72kNdIh
 2ZNxyQRNhckz7/aOY8V9cjRakf98UiG2hoiAnlGI+h1wT10bvkefiyt/43mJ/BrAbMCbUWfPQEW
 KrEymJNXMAIsd
X-Google-Smtp-Source: AGHT+IE2FLgDLX2NT3cwGkdHiP1sZYCuTToyStkgFXfzhRs1iI7+pDhf0S2sK5z/GKTSdgxV7UJTEw==
X-Received: by 2002:a05:6e02:1a09:b0:3dc:7df8:c822 with SMTP id
 e9e14a558f8ab-3dc9b723da5mr137708465ab.14.1748420794997; 
 Wed, 28 May 2025 01:26:34 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 23/27] x86: efi: Drop relocate and physmem
Date: Wed, 28 May 2025 02:24:49 -0600
Message-ID: <20250528082520.152391-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

These two files are not used in the EFI app and it does not make sense
to compile them in. Omit relocate.c and physmem.c

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index afb6abb57d3..253207b9987 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -35,8 +35,11 @@ obj-$(CONFIG_I8259_PIC) += i8259.o
 obj-$(CONFIG_I8254_TIMER) += i8254.o
 obj-$(CONFIG_PINCTRL_ICH6) += pinctrl_ich6.o
 obj-y	+= pirq_routing.o
+
+ifndef CONFIG_EFI_APP
 obj-y	+= relocate.o
 obj-y += physmem.o
+endif
 obj-$(CONFIG_INTEL_MID) += pmu.o
 obj-$(CONFIG_X86_RAMTEST) += ramtest.o
 obj-$(CONFIG_INTEL_MID) += scu.o
-- 
2.43.0

