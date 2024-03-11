Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBF7C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 14:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A68987CF2;
	Mon, 11 Mar 2024 15:02:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DJ1UMeB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D942E87D0A; Mon, 11 Mar 2024 15:02:51 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A1E879A0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 15:02:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-42f2a4f77a6so15452201cf.2
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710165765; x=1710770565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QZFrH3xFXm1u8ZSU7Oko71V1weffPzgTWtk7HQ5jlgU=;
 b=DJ1UMeB59bsXJuDZ5CAeCBlHrhn4s76nehnP6gHf30Zhe9A34Xme1PRkYNs+0ETusl
 T7AAZy5E3Ea4CHCjkyAwJ6148jCTuKU7IP15L58IKoEAO/oaO6G3JeTmphpsQLWuD/ay
 4O4GCkfJunKxIh1cQ40i6rsHbLZWeB+R2Kga8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710165765; x=1710770565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QZFrH3xFXm1u8ZSU7Oko71V1weffPzgTWtk7HQ5jlgU=;
 b=pnXnqeFdJ/upvuu7oQ8ifzkPZspDPRQ4pCN0GIx1yCxl9Zs/cI9Ej4qDiZT2SS8Jit
 40pr9GxijbgbJCtOsm5j8SfzveRk64N+VyyPU+dUUjX7tnQqWTrlXUfMunu8wwIXsg/c
 eWQ2ChVTB+pndmIKofofvnw0wmFUDdYZkec3dT9M+FBJgXfT7wElBgHe6JWANMMOwRfA
 kjlaLdKfFJ9oXOQLgYBCZuU1pPqoJnK1ZPynQm1AAV6o+aV7rYuulpM0BLqbgYBF0Upr
 QygP0wslzm3IBGfXQn1M3dOjr6dYuKwrftcpJjoaD9qrU2wmCUtD5tTaof8zw/gP6023
 1Dhw==
X-Gm-Message-State: AOJu0YwMihtJQPLlLpKrLjW5K/Ro1eK2Cl39uySSkiLE2931nfYoDyZZ
 JppY3SUlKdkTNGpP0wKmzSK73uMLTNcegPWPfNbypkRL3SrjacYeF/oGlcVVWthDiMkmBo7jJHv
 X
X-Google-Smtp-Source: AGHT+IFpWmVY8vULx4mw4cWGcTRWRj2DBLtfune6KId7SvKaFDxqgBIwyfdFZv8BEUtmyyyZWjHCwA==
X-Received: by 2002:ac8:5850:0:b0:42e:f8ff:b820 with SMTP id
 h16-20020ac85850000000b0042ef8ffb820mr9525709qth.67.1710165764820; 
 Mon, 11 Mar 2024 07:02:44 -0700 (PDT)
Received: from bill-the-cat..
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 qp27-20020a05620a389b00b00788712ca95esm694514qkn.13.2024.03.11.07.02.44
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 07:02:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Cherry-pick reset support for m68k for QEMU
Date: Mon, 11 Mar 2024 10:02:43 -0400
Message-Id: <20240311140243.2008537-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

In order to support the reset pytest on QEMU on m68k platforms we need
to grab this change from upstream.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 274255456619..136bc01f0937 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -184,6 +184,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	git config user.email u-boot@denx.de && \
 	git format-patch 0c7ffc977195~..0c7ffc977195 && \
 	git am 0001-hw-net-cadence_gem-Fix-MDIO_OP_xxx-values.patch && \
+	git cherry-pick d3c79c3974 && \
 	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
-- 
2.34.1

