Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A082D30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAA278916D;
	Fri, 18 Oct 2024 16:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lTRDV37/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F5438916D; Fri, 18 Oct 2024 16:22:51 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE5289169
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so14021345e9.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729261361; x=1729866161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K9EHlpRiD32tXVg55auCSfHaG8Kon0/IEV8a/i7dvMA=;
 b=lTRDV37/4O9pMXPMfy+ylE9gIMu0chize6M5MukjcADt7yp3b2ZoRXpYk1HFtvbTXt
 CeO9+q5hgRqi+x58OPvSpiHZqgnPJ/BQZF+3pBT9RuNp+U7/DVb0MaNhaEqzELUpp23d
 AmON/DkyYZs8zaqxlMktPyqm1GeQ/+1e2Nwiw0h7FDzDcT2/FIbVYQtqJ2W31xZWIP0P
 4VJtDloOH59yuoQ+jz/gPSMXF3WSKz/lk0lVm6g439xD2cw3E03Qqpz/UmHKXOymE1sR
 5opV5fcHPEtyD+XcH3A7ilRAlkCAZ1Ofnf8fG9i90PbWieHF1U2fN5JGCxGdvygSCO8N
 eyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729261361; x=1729866161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K9EHlpRiD32tXVg55auCSfHaG8Kon0/IEV8a/i7dvMA=;
 b=ZBKWrOKqqgFce6MMj/iuSBtiRG0VQHVacjc2WkyxXHeUd5f3pTKwpFGyJdyyLEIUwr
 3Dr0ZE1EvFhDs6u52qlxoAwWm4EDfXhcO+YE2flWMcc669mSUe1PCHXbweYTazD1GThg
 EoSD1YixizJgsgP3HLNeU1jPKJ6ARQP6Losr6W+3CeKGcMX6w2qxz/yYM0stm/uyHetd
 mVyCdmb1PJAIzGEm7/EKK51jEuj9FQ5dBwUUvdbEF6vNO8y8ad0YgGVhlep+1GXqg1dA
 nG+nn6sK5q1Fvo+GNEH6Kw3uflis5PnjI2hQSW/lwcJfj3vIrjnPYlIZEI+CUK2PVxw9
 P5Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy2c0QvTgFve1QeeCpujj6ps8ESCEZr+F8YrUWmFcAEd8yDKjFGANxIHiKwa1SXS6HrK7Wo+M=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6i4tI8Cve+2Qnd8U63wKzk4eBiBZEUNQ3/2/QxFIiNOsauADP
 Dz+jGihOdaJMG3kKO7tMomk7VwbU53xl4qmcM9wTpYgINAM5dCfZhrGlUGdstL4=
X-Google-Smtp-Source: AGHT+IH4kMy5PQawCkifJOTYrln8FQLaIsPALw54Viv4tiS2u7IK4BvsF9axULMvOs060iMXhIA4Iw==
X-Received: by 2002:a05:600c:458d:b0:431:5aea:964 with SMTP id
 5b1f17b1804b1-4316166a975mr18397065e9.19.1729261360984; 
 Fri, 18 Oct 2024 07:22:40 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316067dc70sm28781665e9.10.2024.10.18.07.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:22:40 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org,
	raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 0/6] Enable https for wget
Date: Fri, 18 Oct 2024 17:21:54 +0300
Message-ID: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Since lwIP and mbedTLS have been merged turning on https:// support is
relatively easy. We need to enable the missing algorithms and modes of
operation in mbedTLS and enable TLS in lwIP. Someof the lwIP patches
are in their github as PRS, but since they haven't been merged yet, we
need to carry them for a while

patch#1 enables the crypto algorithms we need in mbedTLS
patches#2, #3 enable anf fix the lwIP part we need
patch#4 is adding https:// parsing support in our wget
patch#5 is making https:// the default for QEMU lwip defconfig so
people can easily test
and finaly patch#6 updates our documentation

Ilias Apalodimas (4):
  mbedtls: Enable TLS 1.2 support
  net: lwip: Enable https:// support for wget
  configs: Enable htts for wget on qemu arm64
  doc: uefi: Describe UEFI HTTPs boot

Javier Tia (2):
  net: lwip: Update lwIP for mbedTLS > 3.0 support and enable https
  net: lwip: Add Support Server Name Indication support

 cmd/Kconfig                                   | 19 +++++
 configs/qemu_arm64_lwip_defconfig             |  1 +
 doc/develop/uefi/uefi.rst                     | 45 ++++++++++-
 lib/lwip/Makefile                             |  3 +
 .../src/apps/altcp_tls/altcp_tls_mbedtls.c    | 50 +++++++-----
 lib/lwip/lwip/src/core/tcp_out.c              | 10 +--
 lib/lwip/lwip/src/include/lwip/altcp_tls.h    |  2 +-
 lib/lwip/u-boot/lwipopts.h                    |  6 ++
 lib/mbedtls/Kconfig                           | 12 +++
 lib/mbedtls/Makefile                          | 33 +++++++-
 lib/mbedtls/mbedtls_def_config.h              | 52 +++++++++++++
 net/lwip/Kconfig                              |  2 +-
 net/lwip/wget.c                               | 78 +++++++++++++++++--
 13 files changed, 273 insertions(+), 40 deletions(-)

--
2.45.2

