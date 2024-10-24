Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E749BCE8E63
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 11:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52AB188EAE;
	Thu, 24 Oct 2024 13:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m9r0clgB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 201FD88F2C; Thu, 24 Oct 2024 13:25:17 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C171288C7B
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539f58c68c5so1369191e87.3
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729769101; x=1730373901; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kh2XcqplF8dOanxBgkX+l66sGLE22K0OCMnxo4JF+Dg=;
 b=m9r0clgBKU/Sx3/BzXXE7CVRSltcSFyK2Sa/X2jJHce42s9KtA8gq4isaFBm7jhOC6
 Owk8d18jq6UzVsQd75lJ9hcey59d81T0loFDxdae6E6nFosItEYsPubyQwYgisqL3pDI
 wwvITpuajpDFPcJSeL2nj1YK7NOi5O5hjl2FnHHfwRv4EXOUDXrVfLDl9C2IyKq4GtLu
 PlEq2kTmwZj7Sp+2CnNUS7VdKLjJtfX8UDOxpC5YeGTCTbY8Z55mefGUQuQgcv9kY65E
 9XD77O31CholuPBG17yRd87Djysj2Ao0uX++IUw4ObktSphvlGfwkuWfgsaIViLG8Klq
 p90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729769101; x=1730373901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kh2XcqplF8dOanxBgkX+l66sGLE22K0OCMnxo4JF+Dg=;
 b=J33RSaVYioMqEji0tewFNkPiovGKNdgw2ONGJLDXuNGnH42h/NGsMdWdeQQz0O6MFQ
 srh/w3Pz89bPo+7/3Q9F270yXfLZlb1NcZBXgqE2Gg5s6sRxSYhya/d6OY6GDSgq4eYi
 rtNU3O+04e5oZlyEzOUgJSWKYZl8y5yu400aCSbHhZVuWAflo7w1LBBDxAOltI32Xy2m
 Ub1q2vAx1C+PcZPiQXylnlWS8B3Si4xcOTQfUcFQvxOXJI3CxTCnBxj5CFi20BDFxKdo
 FC2wbqEXcQ4jFVOQndRv65uFbHK+vSpHBmxJg64sX3XPA5p3SjIabcoktRPfKMzH7z8s
 3vvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCFmrXWmu3yLcu3nyFBIjNh9zAJMJPi1IsDyA/TpWieJ1sRuAhiGP/1vAVvESqqjaodseP4do=@lists.denx.de
X-Gm-Message-State: AOJu0YxsueYaD8CnTnC1FNTSoIATxG8jA8aDu+4QiGesd1qRFJVskgF3
 kWUHX/8TVHSE0Yc56G1rOMMr/o6Xd7AS1yv85ZZGMCFA0geR3P1lP+Ryx+WIDb4=
X-Google-Smtp-Source: AGHT+IH6/ytfVIZqzqCJHOdXyxi/um83Xy1NPmJXPtVV+NpdW2myMu5beC24hZQH4aRWZI362tgL4w==
X-Received: by 2002:a05:6512:3ca7:b0:538:9e36:7b6a with SMTP id
 2adb3069b0e04-53b1a34d04emr5551563e87.32.1729769100976; 
 Thu, 24 Oct 2024 04:25:00 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91572c0dsm611534466b.177.2024.10.24.04.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 04:24:59 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org,
	raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 0/6] Enable https for wget
Date: Thu, 24 Oct 2024 14:24:07 +0300
Message-ID: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
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

Hi all,

This is a respin of [0] adding https support to wget. In short

patch#1 enables the crypto algorithms we need in mbedTLS
patches#2, #3 enable anf fix the lwIP part we need
patch#4 is adding https:// parsing support in our wget
patch#5 is making https:// the default for QEMU lwip defconfig so
people can easily test
and finaly patch#6 updates our documentation

[0] https://lore.kernel.org/u-boot/20241018142235.715571-1-ilias.apalodimas@linaro.org/

Changes since v1:
- re-arranged the Makefile objects so they only get compiled when TLS ie enabled
- Fix all the applicable remarks Simon had on the wget patches
- Fixed the title of a patch pointer out by Peter
- Rebased on -master
- Collected r-b tags

Ilias Apalodimas (4):
  mbedtls: Enable TLS 1.2 support
  net: lwip: Enable https:// support for wget
  configs: Enable https for wget on qemu arm64
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
 lib/mbedtls/Makefile                          | 31 ++++++++
 lib/mbedtls/mbedtls_def_config.h              | 52 +++++++++++++
 net/lwip/Kconfig                              |  2 +-
 net/lwip/wget.c                               | 78 +++++++++++++++++--
 13 files changed, 272 insertions(+), 39 deletions(-)

--
2.45.2

