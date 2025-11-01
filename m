Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78238CCFA03
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 15:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6AAA83936;
	Sat,  1 Nov 2025 16:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d6hFCPg4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3925283A36; Sat,  1 Nov 2025 10:40:08 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1B2F83A24
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 10:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=d3dx12.xx@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-429b895458cso1831978f8f.1
 for <u-boot@lists.denx.de>; Sat, 01 Nov 2025 02:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761990005; x=1762594805; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nDot3vzokeXh6QEixlkN57m6Z7VjXDoB1z7rpjbkNKc=;
 b=d6hFCPg4J2/EKVtTi9bfQXbssS63EmEi/kluv7EeSxuo8eiiqZAaKFX0NbWIYo3X3L
 rckzlUd5euKsoXokmBntoBWSmsApMNu0V7puIrEi/Uy36Ha6BGkGiRWPtC9EbvvIT18V
 qSZvVsoO0fffRdlOpczLHYn7WBPA27Mf/6Y8DTZghcB2m5tfDLK9H72NaM1DqBzFkOM6
 /9/Az0qC0gkodsec/gWu8/qqWh7xc5FS+1tBWmi4Z8a3ODmt168KkUd1PtTPMFgWXy9c
 k/OLRmm0+xxQAbDwA+r45iJDt2FMbi05ya2x8FnyiTQ/dX9Pi4gUd9unosuF2cXOc0Xo
 lxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761990005; x=1762594805;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nDot3vzokeXh6QEixlkN57m6Z7VjXDoB1z7rpjbkNKc=;
 b=aOklyVEk6AlMnoVoZd5J3XJdO9EOCPoToVFNxvHVjHI34e9vysbCRCfmAWQ4q0uQhp
 +KDRPwiCGfMNtx/zRZKJfrZ03SV/lNjTkR0xBEdUPImKz1SPxmnJwOzdbzKbUX2oTpKZ
 B9JnfoW06sGMKudHEU8Haa9K3EPXjmpwPj1VJTFZcPbNsJHuxVTqDeHyvHqX96LO/NYx
 cNHopMo7BpBogZhdyP6CJ+kYeYdjlDvfjS6MdzeaLuveSkzZ/hUDzVwJni+9lGxIATFB
 oDM0mVi41zHvlfIaVEzp1AnMDsUnbETp3WRj07KuGr4mYgkAs8cP9/xuGVbBeHsCgrL1
 Mygg==
X-Gm-Message-State: AOJu0YxQDhSVT8gE4HtrVA9jlm6ithJ86322pXXZSwvs2IyDNcLTJN1p
 jJReLrLCCrElsGnzoGgPcW6BOqblCSIV9sTXjj44zRdxzGbBnpt2qOM5
X-Gm-Gg: ASbGncs7RfV3Wp5ZJebcAM9f12KrQG5Asr38KZNmyP9+bf4bm/O3ILlwAyvCSP41toQ
 gnqn7hnaKYkv9fxZjwCo8QyBbOmcdhP9Glm1+/2o6o3nVgKqmWCDIcRaPLBFaX7EgUwS/x3wIwR
 DAEuMt29vNu/B+uwj3vGziHVhOAqcL8WGx6O+7b2HZlA3a+hFth/gyb/U27LzLjYBm8MTS4xKxl
 Cpq3fk2POaLBN7vGsnqqh36hkQ2l7+Yw9w50RTG26HpkojQKPxUptBil8Dhg6ofol/3JkeJNPZh
 U7KeWuTaAP/W30OuE7+rF17pubgXJmhntvy0HOq4tTlijTjlspnVGklXtM/Jw8XLePmAr54m4Vg
 +ZzWjS+YKmVM7tfawTN7i6O0I6F9X7YrfiQ4w7cXZMKKN9yRfIu8y2KARP9iwG307QDX9F8fnHR
 C8VmbDbPTGnnlfJbuo4qXKoD6B
X-Google-Smtp-Source: AGHT+IFe28JWH5ow5AVaISeawSuIqI2hXjRincYfNclO+ZGzEX/mVuyVzYleSGrPy3oFlpSxhhssSA==
X-Received: by 2002:a05:6000:2088:b0:429:bd09:e7ce with SMTP id
 ffacd0b85a97d-429bd67bc91mr4801990f8f.18.1761990005298; 
 Sat, 01 Nov 2025 02:40:05 -0700 (PDT)
Received: from [127.0.0.1] (B-228.ahl.uni-linz.ac.at. [193.171.46.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c110037asm8697791f8f.3.2025.11.01.02.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 02:40:04 -0700 (PDT)
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Date: Sat, 01 Nov 2025 10:39:59 +0100
Subject: [PATCH 2/2] build: fix building u-boot.lds with Clang as a
 cross-compiler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-clang-fixes-v1-2-a8398475226e@gmail.com>
References: <20251101-clang-fixes-v1-0-a8398475226e@gmail.com>
In-Reply-To: <20251101-clang-fixes-v1-0-a8398475226e@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sat, 01 Nov 2025 16:15:06 +0100
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

Make sure to pass Clang flags to the KBUILD_CPPFLAGS as well, as this
variable is used for flags during compiling for target

Skipping this leads to Clang being invoked with args for target, but
without target indication, thus defaulting to host arch:

  LDS     u-boot.lds
clang: error: ... '-mabi=' for target 'x86_64-suse-linux'
clang: error: ... '-mno-thumb' for target 'x86_64-suse-linux'
clang: error: ... '-mno-unaligned-access' for target 'x86_64-suse-linux'
clang: error: ... '-ffixed-r9' for target 'x86_64-suse-linux'
clang: error: ... '-mno-movt' for target 'x86_64-suse-linux'
make: *** [Makefile:2345: u-boot.lds] Fehler 1

Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 750f8a84b1f..c10bf71b9ac 100644
--- a/Makefile
+++ b/Makefile
@@ -608,6 +608,7 @@ CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
 CLANG_FLAGS	+= -no-integrated-as
 KBUILD_CFLAGS	+= $(CLANG_FLAGS)
+KBUILD_CPPFLAGS	+= $(CLANG_FLAGS)
 KBUILD_AFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS
 endif

-- 
2.51.1

