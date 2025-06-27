Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FCAC7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 18:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02D0A81F66;
	Fri, 27 Jun 2025 20:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KgO2ggKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3404681F66; Fri, 27 Jun 2025 20:57:40 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0A49806D8
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 20:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-60c3aafae23so7657734a12.1
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 11:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751050649; x=1751655449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SHGytY+P3bkVM9uLjNmAAcIQAhe6M2pXDAaC/etf3l8=;
 b=KgO2ggKtpQRbGYEKSVdnqIOfUoAk8jCWDcjjx3zwgIgkt7iQ//5p5umQ7PL4Dsj8O8
 quIJjxdKTe3ZF4rTxJql86NJhsFlQ/kIAs9lv6+PJrWNJ8a6BW2WTM0Vr+/K4g4gG5s7
 EAo2uzX9YwPJtiIlkhm++OP0BYsbyjHbyUZxngo2MUzYrUchWwIdROO9lp9oL+oOqz6h
 5obmm/lR2b6P55+sWdVfU1+xJKVhUUVrbkTN4xmAqaYPLLJXLT49KYJIUOI9aA/keB2L
 l+r1Pw5yfIStpGZmicf8hNkWU9gronnKKgGRdPaWVcNEZm30eJD5U4Is/kLLwqzZ5Po9
 wtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751050649; x=1751655449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SHGytY+P3bkVM9uLjNmAAcIQAhe6M2pXDAaC/etf3l8=;
 b=OAADbHVFIHoFomBuiluHpEkriULD4QCZXjMW28Cbj9luc3/MDM/AVLBDJVZGYk//DC
 zAkcBFEjD7sg8saTiYX+ALReGgYeUPwY7SXCMRHUHBr7L45S29iKq9YvfmtxkDlQF8t1
 HPdSc7wKzqazFQioLVaER1ohzOfdcdoi0sBcl8SrR4wVqT6oKBg670ZDX/iNw84WSrsE
 qRC5LTcYjrMaOW3sIhLLZd37XLtyQLbpxlCl9PNt74AT6V2VG0sObaqCE6Q1fJyFfj3Y
 hWnkxDIdczkuif8j08SJNy88obcCdGNgovytLEeZHtE/ysT0rahBpQ3PzMCFjf5iap5L
 cG0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOS0HGcQMd0XN861+2hYbN3H+MQKNjNzAWYGy3tpBAEPNWuqvYn1EsJXyM9U3px5Y9EDlhQ5A=@lists.denx.de
X-Gm-Message-State: AOJu0YyMP3hSnyijCapyghklbIHaEMnhbt7uSqDYDesPeG4nQahEMylX
 gXhsCvgYlOKdNb1yhEkKi5+9bpjGBBYm42Ax5BTpL5ebuxYC7BcflHaO6/NSvu362CM=
X-Gm-Gg: ASbGncsVBVzojxx8C/u+fjHBNRFSQttRflPinJDMzAVpGSiucd/SU4zuLvAnsI6vvgw
 SQDGtbjrU71Ag+18CUv317/eHZ1ysD6NXqk9gfE/OSk96/cRdwX3H2BfsBUGQAfIdcfGKYuXZxS
 002Ks8+TeZoMLhE4pTcBHIT5OTDmmo/sYCsFL/AGK7bDSqBKnJJH24bM1Ry+WFe//WiKqD3njC4
 wVek+g+ZccuPBf/4nccMdzEi8MjKolwzDs9w14yufyAaYsdV8TW5dtWCScgtJx+BHJgW/xoIoVo
 uN7Ua7ZxrBOvdYzKBN22tRB7hrwHINDnlnifsntXUK1fnrE4TBOMYAvS02RhY1haVxKrosqR5bo
 S1z2nytFR0+wEy2U1jaLXvBoVX1Q0NFk=
X-Google-Smtp-Source: AGHT+IEPQzUfan/DJx34WeJjjJyYDll4ALq9Cji2SYFis8TFXd/6bkVJ7oHm49TalvUOr1hM5zr1/w==
X-Received: by 2002:a17:907:6d0b:b0:ad2:e08:e9e2 with SMTP id
 a640c23a62f3a-ae3504d7434mr375337266b.27.1751050649089; 
 Fri, 27 Jun 2025 11:57:29 -0700 (PDT)
Received: from hera.. (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c6beb8sm173694766b.132.2025.06.27.11.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 11:57:28 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: sughosh.ganu@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>,
 Olaf Mandel <o.mandel@menlosystems.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Wadim Egorov <w.egorov@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/2] kbuild: Update Makefile.extrawarn to 5.1
Date: Fri, 27 Jun 2025 21:57:15 +0300
Message-ID: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Since we are updating our kbuild system to 5.1, add the relevant
clang changes from upstream

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1:
- None
 scripts/Makefile.extrawarn | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index f687515fc799..7df62263bc42 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -67,5 +67,14 @@ ifeq ("$(strip $(warning))","")
 endif

 KBUILD_CFLAGS += $(warning)
+else

+ifdef CONFIG_CC_IS_CLANG
+KBUILD_CFLAGS += $(call cc-disable-warning, initializer-overrides)
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-value)
+KBUILD_CFLAGS += $(call cc-disable-warning, format)
+KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
+KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
+KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
+endif
 endif
--
2.49.0

