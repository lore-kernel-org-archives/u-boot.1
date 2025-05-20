Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9C8C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F09BC82CB5;
	Tue, 20 May 2025 07:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tfw1XzLS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D2B582CB0; Tue, 20 May 2025 07:22:31 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 187CA82BD7
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a375888297so901952f8f.1
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718548; x=1748323348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dj7+/w/S4KZzGZjJda9e2FMa+lHOPOyGo58Hm86wPLs=;
 b=Tfw1XzLSQHAqb6YW0gFlOKuy+BO0ZNHvUtg/t/ou69b+0G4bK35Sie+h38xrB07t/Q
 xGJU0AasAZ3jKc992DjSGhOz1CqhHIEkJ3dQj2lgG+xtjHBfG+fW4doV8XVT2ilR7kI7
 rzGKaQ1psis7+Bx67AAXfxI6sCYlJCMSdpiLOKjrYs+Jtql8F4E9PycFVNQaC0Bj1G+4
 0AGP9YxLdzNd3l5f649do4y9OMFNNOPAZc0I+9mSYpdy2W/9OGfnC/pg+9We8Lpp9J9C
 qC7A0y2sXZCc5S7Ydg77J5/MC5QGOFJklDCphRPLzB5eRXwYYhA7bYWWXiaLUlF+p3Bn
 Lp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718548; x=1748323348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dj7+/w/S4KZzGZjJda9e2FMa+lHOPOyGo58Hm86wPLs=;
 b=RxNHLzQVWfxbRXqIQP6pagdTuAwLqKOWIKTXpyP/MUdTBLER/fF0RgFTmjnLs+Fby8
 aDBYf3KFgO/3XePqzOgi6WWFof3FLt2rBm5+tsEeeo/w0MwsGITtPcNC3rY/X+IZ4Au7
 v2ZK4rAPvVanxX0RESux9XH4IGz/cofWt/ClvMTcEJrQ9CD+tERCJXo4ymRIjuTp3pWN
 VGiBvG4sAjliylcblqeur8HFrtbROiUdSOEUYOQdVwuI131FajPcQgWUbhyYkulL/KLX
 gm8QyDLdQslmGUVp6b+QRKD7+hE7ycHP9qH19Yh2JUufz1LHvkadzGoL66JCXuQuKYKt
 caug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiwV5569fflNk+W6n4KGiYkmuL+/isgS8paC+eTM9YMFFNJc+PxgYGfMEbcARMLj8Z3FAv8+g=@lists.denx.de
X-Gm-Message-State: AOJu0Yyc3fSuP2JBoU60kWDT/y4dR+Pf5fAX0jIg3yF8VBcCOb9MgV23
 2n+EHeHTuxivmwwVltJMPQu9vAY6PBRHwMnAzO5kRNueL+yZiUmJkvMUNt0Df7sBPPcL5+eSl1h
 9xu5x
X-Gm-Gg: ASbGncs/xGAnUwnkfy4VjJwLs+fwr7/GpPO9C1rVe9q5VzAe2a7+MaTgtlCT0qYM1/A
 MBS1nuAybU9fpFJhTUQerMZ2uJILWu9Jbml8m9MN0/8BurtSHMBdE6FQTQbPWXbC3zRVQf1S2PB
 wGoAhRPfnLrRGLjyVpt9fPi3idDPb0pXJzsOyDYR8N5nlzXYpWjfk4ibr6cQzOYgFYTTvnlUicD
 vqVwgFkDqh0BoQV6tGMRXtGCzfH3fkcA1qyn1xBml9keqGNnMXuwE89amy5FqGp7SfJD3TcXiU+
 Oi89KOE3wdZoHvyYtIM9MOkBYATwuT5wDmYUPColeEo1xXlnwdxOvqpT876twN5eQe0UKi15wxY
 =
X-Google-Smtp-Source: AGHT+IEj0xJE5eLJn3YGFyEH85gqm6HjxANeu8z3xcpa9JfUp8tbyrUw414AmuY0Khvw37Vg1SAwRg==
X-Received: by 2002:a05:6000:400f:b0:3a1:f724:eb15 with SMTP id
 ffacd0b85a97d-3a35ca76676mr12897259f8f.2.1747718548594; 
 Mon, 19 May 2025 22:22:28 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:28 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 12/24] kbuild: remove redundant 'set -e' from
 sub_cmd_record_mcount
Date: Tue, 20 May 2025 08:21:23 +0300
Message-ID: <20250520052153.307194-13-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Back from kernel
commit 4317ee3b6a5e ("kbuild: remove redundant 'set -e' from sub_cmd_record_mcount")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2f2d5d4afc25..b2bf5a2c0001 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -223,7 +223,7 @@ sub_cmd_record_mcount =					\
 recordmcount_source := $(srctree)/scripts/recordmcount.c \
 		    $(srctree)/scripts/recordmcount.h
 else
-sub_cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
+sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)"	\
 	"$(if $(CONFIG_SYS_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
-- 
2.49.0

