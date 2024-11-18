Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0595D591B3
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 21:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D437894AC;
	Mon, 18 Nov 2024 22:09:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bOoPzPr1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C3B088C10; Mon, 18 Nov 2024 22:09:19 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7011894AC
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 22:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3e601b6a33aso1980675b6e.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731964155; x=1732568955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BEZASJod8kRud1QRcugr+WyQnjHOGB9X4w52LTABR7A=;
 b=bOoPzPr1kP2yAHGlHJpecF5hVF1f3on5aA94/vsnvA0ViWewNy0L8oeiEbLykXeZJB
 jaUi5VTQBdZ0zMAc7fWaT/+8b2qWxgz+bCRXB8LBz7ngiZI+ZsYb29cSIcDC9rkyDIiL
 atrNhq/c8gcH1DVO75oP9CcdCWg6Z50DgJK+DPn421cBnsVwNzbYfdDi8JPYT+i0yagP
 Or+8CLA/gkPV/KpePzLGeh45n9SW/y56i6SoYUz2qjW35vT1wQZ3CVoiu1s7UhHfwwUY
 JLQO+2oF2oU9Qesm2AQK/yPUc7xMXTrjfssNtv3Z3lkL6hHPX21F2LHzPMpVyjELJw+9
 y65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731964155; x=1732568955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BEZASJod8kRud1QRcugr+WyQnjHOGB9X4w52LTABR7A=;
 b=X+bYr1m3/3sDCRSE9at5weAg2vRlItBhVnALM3+g2nlOAyjWnlksBnzRQFjc8IhiPs
 UCpJ6fH+20XKLdAGJgqRvFjPEDO7MSS1GZKPFoFmczV+/dPcbwNklsBedd3tyL8BrBpR
 ARA35ZPzSOFAFCDwTOo+wCpYnz4WlTNuvPghI9tkIC80ZP4C4kbEhdFafHLguSMAGYwP
 hKc8MA9+1HFIa0dH2wW3JZrj05eSIjR9H1BJeiE9I7Ge3C9Qtyx3G3GWjw3+XDm1AYBq
 +jasija2PVRY1/YrM9R4vEGRFSojBmjbpRqxfPPSCBQGIkFyKtsd5ykhrXX7XrNNGXc2
 quBw==
X-Gm-Message-State: AOJu0YxDus6WesfE/iIFpEoYNxpckSvTjxblKQHBPPMMV3eLQIWHzOmy
 OHJLqscNH/8lt5yRaQJ9nnWw3LzV2SS+FqVloRw7zoHowt2azEb2wbkZhqbI
X-Google-Smtp-Source: AGHT+IFSVTVKZ93lRY/yTBYssyNRayLkRUdj19du2cy60kNQYngd5m+oLCkYnPiG5yDwMSIylqfJEg==
X-Received: by 2002:a05:6871:288a:b0:277:d360:8971 with SMTP id
 586e51a60fabf-2962e13747emr10682695fac.43.1731964155397; 
 Mon, 18 Nov 2024 13:09:15 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29651852a7asm2994621fac.3.2024.11.18.13.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 13:09:14 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v4 00/14] efi_loader: efi http and ipconfig drivers
Date: Mon, 18 Nov 2024 18:08:54 -0300
Message-ID: <20241118210908.51196-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Add support for EFI_HTTP_PROTOCOL, EFI_HTTP_SERVICE_BINDING_PROTOCOL,
and EFI_IP4_CONFIG2_PROTOCOL.

This series depends on the series 'wget: Expose wget to applications',
also found at:
https://github.com/0n41rd4/u-boot/commits/http-driver-wget

The fist two patches of this series are not efi specific and have also
been sent to the corresponding maintainers, but this series depends on
them, so they are added here for redundancy. A branch with both series
of patches, concatenated, is at:
https://github.com/0n41rd4/u-boot/commits/efi-http-driver

Adriano Cordova (12):
  net: wget: let wget_with_dns work with dns disabled
  efi_loader: device_path: add definition of
    DEVICE_PATH_SUB_TYPE_MSG_IPV4
  efi_loader: device_path: add efi_dp_from_ipv4
  efi_api: add definitions for HTTP and IP4_CONFIG2 protocols
  efi_loader: efi_net: add efi_net_set_addr, efi_net_get_addr
  efi_loader: device_path: add support for HTTP device path
  efi_loader: net: set EFI bootdevice device path to HTTP when loaded
    from wget
  efi_loader: net: add support to send http requests and parse http
    headers
  efi_loader: efi_net: add EFI_IP4_CONFIG2_PROTOCOL
  efi_loader: efi_net: add EFI_HTTP_PROTOCOL
  efi_selftest: add test for HTTP protocol
  efi_selftest: add test for IPv4 Config2 protocol

Heinrich Schuchardt (2):
  efi_loader: add IPv4() to device path to text protocol
  lib: uuid: display HTTP and IPV4 Config II protocols

 include/efi_api.h                        | 220 +++++++++
 include/efi_loader.h                     |  42 ++
 lib/efi_loader/Kconfig                   |  17 +
 lib/efi_loader/Makefile                  |   2 +
 lib/efi_loader/efi_device_path.c         |  92 +++-
 lib/efi_loader/efi_device_path_to_text.c |  23 +
 lib/efi_loader/efi_http.c                | 548 +++++++++++++++++++++++
 lib/efi_loader/efi_ipconfig.c            | 214 +++++++++
 lib/efi_loader/efi_net.c                 | 354 ++++++++++++++-
 lib/efi_selftest/Makefile                |   2 +
 lib/efi_selftest/efi_selftest_http.c     | 315 +++++++++++++
 lib/efi_selftest/efi_selftest_ipconfig.c | 170 +++++++
 lib/uuid.c                               |  14 +
 net/lwip/wget.c                          |   1 +
 net/wget.c                               |  37 +-
 15 files changed, 2029 insertions(+), 22 deletions(-)
 create mode 100644 lib/efi_loader/efi_http.c
 create mode 100644 lib/efi_loader/efi_ipconfig.c
 create mode 100644 lib/efi_selftest/efi_selftest_http.c
 create mode 100644 lib/efi_selftest/efi_selftest_ipconfig.c

-- 
2.43.0

