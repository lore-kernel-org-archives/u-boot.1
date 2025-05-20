Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7BAC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBF5082D06;
	Tue, 20 May 2025 07:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Na3tv/DF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5788A82CF4; Tue, 20 May 2025 07:22:50 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FF4282BD9
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so56142725e9.3
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718568; x=1748323368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3kk1pY9CNaQhZdYqtPu3iz9HnxJiZ8tAZj1sTxPVQ4=;
 b=Na3tv/DFOTaXvDxlu+688z85Ga/WDoMmETmoIFmLH3S4qzZS42cczh2SO9lNzRDAJQ
 wwYGfXbpj5FeA3UOiA/8njdN3N3Jcoxsn6u3wUcQYiPOpfjkkxAz7KYhHlAEvbQ1dza5
 eQfADLKOMlyoNggTY35naueW7N8AS2orhHNph9mIAmwL2gCBE2twR2uzPQ1SOd12a0CQ
 lRpwOP+wW8Bgk5woyzW7R30YG9gjHOIk4bOLsgB8IqAPaOHTSSakIjlzz4C8Z/Ffjk+m
 YTR9GE8bxTF8QnEYPijgC36T+19qkb/+Tta567n5+sGXnl7FMX/BqS3/u+EjB+nizgaO
 ZH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718568; x=1748323368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3kk1pY9CNaQhZdYqtPu3iz9HnxJiZ8tAZj1sTxPVQ4=;
 b=Zsba1GhMbZ/+XC/Hl/3ziBFLpscl552okQ5du9D2FBDAeVq50DvCe/DCgk8g2+n5zP
 nKZBuBiC+NeS7ZVCpppozakKI19cpFTVUUG0QBYVN7mFp7QQ31n56mwvypVL2caQD8LS
 CiNfBvhTZdlLSOHGM1/iFj+uGB1ZncNP9jh8RrVewQFpmhwdCZxSK1kLKK/xfWzVQGN9
 WK5P1urFbYifd5IcGaV8DwvwOiLkkLLgvTE4nSdnttKuwx/NF2v0eOwv+eqrHR8+Y95f
 IzST/vH01qBYS8Wfigsg3D40w6tktnS5gIB6k7Kp/VIGxlNkj3GtizfwPQAc1tGaaItM
 hPNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUosA9W2r6NW0wg6jvdvdX3bKrMgLGr12SOv52r9netVsHX2V9jogp2s+wmAQP9WDAOjfz0rWA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy33CyRhsmUzIE4OPxWqqNMj2VEW4/83u8pwpq0ryarzjPNj0IS
 ZPUubvEkzxqViKIuujrsjiOa3iw1VCBZGMQEKK+OMPit93cMBu8nqPpbJq1y7+iTBiY=
X-Gm-Gg: ASbGncsqfvDDhCQaODU5JgK7/QsBSiMp/f94OUMlCHzreAOD/+0ZT0VRnTgKx3XsYr3
 GKN9iXvepqLT1I0LMOduzmvjPRmS2QJ5zXQqP6KCmzHDKPQ+1uSRWTaDkY4p0joeyNeRUVw2yKD
 Xsagb7qkymZL91O0xEPVfLwQNxZmH0bLr821dVfkd1LxoTYJGPzZJYzIt9xs8O+uqiBQAHr158j
 vH0j164wUrmNvqB3TqH9xn2jUz5nM7uItYxmAiVxVwc2b8hCtjbpvC0n3HaM333sJ777JPH2P9l
 Oo8Q+Wj0QBmT0hVmx1PIgI5YVYi4M69pEwChWSFlns1PpY0tJUK5ptc3BLrs1w0iRagsSGFFEjr
 8m0OhpAO9DQ==
X-Google-Smtp-Source: AGHT+IFG6dg+84Mxk9OQsizVwAYkiNzOqsbmlDGw0kPpyr5j7KdG3BKiB6QNYWenuYMjkrRsgJYeJQ==
X-Received: by 2002:a5d:5848:0:b0:3a1:4343:f834 with SMTP id
 ffacd0b85a97d-3a35fe5c5e9mr13710681f8f.2.1747718567968; 
 Mon, 19 May 2025 22:22:47 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:47 -0700 (PDT)
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
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 20/24] kbuild: hardcode genksyms path and remove GENKSYMS
 variable
Date: Tue, 20 May 2025 08:21:31 +0300
Message-ID: <20250520052153.307194-21-ilias.apalodimas@linaro.org>
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

Back port from kernel although it's not used since it makes diffing
easier.
commit 88110713ca9dfb ("kbuild: hardcode genksyms path and remove GENKSYMS variable")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2b2beb01bd3b..b7611c030088 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -148,7 +148,7 @@ $(obj)/%.i: $(src)/%.c FORCE
 
 cmd_gensymtypes =                                                           \
     $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
-    $(GENKSYMS) $(if $(1), -T $(2))                                         \
+    scripts/genksyms/genksyms $(if $(1), -T $(2))			    \
      $(if $(KBUILD_PRESERVE),-p)                                            \
      -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
 
-- 
2.49.0

