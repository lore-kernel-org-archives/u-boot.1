Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72792C02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D380E80934;
	Sun,  9 Feb 2025 03:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H/RoCzxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EFDD80BAF; Sun,  9 Feb 2025 03:02:25 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42FF080A23
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3d14f752bcaso6710705ab.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066539; x=1739671339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7XsTF+3EtdAKNdldfOWrJWn2LaEeC9a2vwztV1OvF4=;
 b=H/RoCzxAesSsAAS61TJogSYOp4TaI0a0X0BBJuGxcP5TIgB7ITBvmSBEK1H50uURjj
 AzfYSmekreO/7CgVb4mDZ9d3AvEs4fiwfiysg+2DBsCxMyx4YgcK8DjeMMNxkm+VOyv6
 gfPUYPrdP7s7liEIqSv9NeMuYGWloli35l5+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066539; x=1739671339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7XsTF+3EtdAKNdldfOWrJWn2LaEeC9a2vwztV1OvF4=;
 b=bljPYGQlb1cxhST4eJVRyDy58DiIu5yeKsa4Ssu3ApsU9Ol8t1EypEHlD4MqbHERnR
 mlM2MBE+ZlT5hh4HSd9rR6lkAMSPe4/hGsEEszOcsc6Awu6M0VP7ZS/ooB3jEODY+Qfa
 y1NhXijfmx0pzI20HBaokQvXOK4iOHEVBzNE5s/2xLbYU0PSHCQGFozaH62+KvALgXEA
 bjqyqpUWANkrJHtV6WutWL9KmeY5XBC/+iMstx2Nu6Mv+79nGhYarpNgEPXB5PVgpZ9q
 ejnJf1msyE96VHJEBp06lpF178S9satwjXmmI4s+GpqFoA0XD+45ay1vxXfZbDz0D9tV
 vADQ==
X-Gm-Message-State: AOJu0YznfKYenkCXYF/XCwUoooIP3+eWFKpD0v2ElmY1gqJcdT8wCbcs
 /kcmf6CzjXeBY50ybD+mp1Jm0qae0GnieGUWl9Oi+CxyrhbRXBU9QY3IiZ+hKkCqAqM+ej6c6OU
 =
X-Gm-Gg: ASbGncucSF9qw4pwyfOSmmM1yGdlwIpOc3VeOYeZkSF3yixT1JKa8ItXHBOGTlsKoEt
 HEspSzi+ezlcoI7Kc18eT8KLIdNqENpkZCQeRWFJXeyNUzrBMfRtxfPvbaqCV1r6eSHFMSEvRmS
 6NTQsx6+UdqnLmZKcBgus99KXpYF2Omiz6crNtGusfWQ6iTcFIuLHLiQ1t0hN7kPUets9D4XfWR
 GfQPfUWBobfehr1YgaNwzs4PRmO7PUX9GAMlpNqXyvLx84qdIyHxlb/KeXvbekGTbcLK+DB4/LG
 k9wM2C7QMPxCHUGXRKTtXFvO3t7nWfPG5+eFqxsv1nRdJwg9QXMD
X-Google-Smtp-Source: AGHT+IFQURpQn6LU1vTZrfpyxbOBUnpJuPGjW2Q1T2uTydqaC9qNFmVBfSP9/6PNF4lvOg/O6vnN+g==
X-Received: by 2002:a92:cd8c:0:b0:3d0:21f0:98f3 with SMTP id
 e9e14a558f8ab-3d13df6ae8fmr79693525ab.21.1739066539444; 
 Sat, 08 Feb 2025 18:02:19 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Janne Grunau <j@jannau.net>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 13/29] efi: lmb: Avoid access to _start
Date: Sat,  8 Feb 2025 19:01:12 -0700
Message-ID: <20250209020136.4108987-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

The app does not have this symbol. Also the memory where the app is
loaded is not under U-Boot's control.

There is no sense in relocating from one alloced region to another.
U-Boot is not able to relocate to the top of memory, nor decide what
other parts of memory are used for.

For these reasons, the EFI app skips relocation. It is not running at
the address pointed to by the _start symbol.

So disable this reservation for the EFI app.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Expand commit message to explains that EFI_APP skips relocation

 lib/lmb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 588787d2a90..420eae4d0b8 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -560,7 +560,8 @@ static void lmb_reserve_uboot_region(void)
 		lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
 				  LMB_NOOVERWRITE);
 
-		if (gd->flags & GD_FLG_SKIP_RELOC)
+		if (!IS_ENABLED(CONFIG_EFI_APP) &&
+		    (gd->flags & GD_FLG_SKIP_RELOC))
 			lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
 					  gd->mon_len, LMB_NOOVERWRITE);
 
-- 
2.43.0

