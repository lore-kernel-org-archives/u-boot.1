Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB67D5C0C2
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8131890FC;
	Fri,  8 Nov 2024 14:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MAPcmI8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 117F188DB6; Fri,  8 Nov 2024 04:44:28 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F2A788B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e4e481692so1565200b3a.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731037464; x=1731642264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5dIKOIekOLCKpzbZPNFEs/7b057G/AVDuiEteGuMYQ8=;
 b=MAPcmI8/2sAiHicqaiIMZqgJA6vcWwL3+3KCQwT+pPtpUev+es9ndX6LPCMV0lBAaq
 /90kfKRkRTMebkO8MzoSykbovs4IvPvKVAWSOXOCFAva/ncDsOroMddL3XUySkTyD5OV
 wOlB5h7/1t4tM2YPL2dWXzt6COI9tIKFjC5svPHZd/XVBxhX9i8BMZzWYjDaMwTfsSRP
 iXZl8LAhlP79wSZbz7vpItuAu9D9D3ayrArDhBMIVHiTMphtCvzXx8l9p18Ee0DEyjPW
 M8aMsSAULvU2W2QdxPEyDeU8moOoFykrDpeZt11Yn2o/gQG4+ERKECsizyszoUqI9gLj
 MW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731037464; x=1731642264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5dIKOIekOLCKpzbZPNFEs/7b057G/AVDuiEteGuMYQ8=;
 b=f4h/xzdS8MjomxaPJEJLSX60/yoISv4bg69evBWS/n91kssQHVIB9gWHbQnoLKX6EH
 KbASE3bS2+cuAH53PEwTDaGTZYW7soreeofQcuOYh6L4K321dqJs6xa69Vy+GIJsjQTU
 +D0TDwX1/H2Y8PsUR2Lpo4m3MUE2WOlGQMaq2atFwL0BtxmubHopFcBAPkdGTQzd9Nz8
 i4g71RluJQl6e1YvxP9zrFmulFS8VB7BlRSuOxTV7sxpj2V0gIJVlMVgxxRQGIIQMZHy
 c8EsVPlHq5SunkWFjVlN+cH0tF1hBPQfPj3LoJGhp0EoUiROhPVqOz8O7D5/mdKLcpx9
 mUyg==
X-Gm-Message-State: AOJu0YyHekrMGF/IrzRZ0TXUEJJDawJRsn71V0qNkP6a1huqPiHUopJT
 f6ScW8Z3eGZoXSkYCoXx7bmgO93AXy+FjETlkH0oP54zgAGw7GvwMvxcTAbt04Y=
X-Google-Smtp-Source: AGHT+IHnFzINo9+7q5gm8rJRnzHpPiGf2/uyJWjYs1AziZt7A7ynAYKY+HQDVvkf6iZ+KFE2zABNMw==
X-Received: by 2002:a05:6a20:7289:b0:1d9:c615:944f with SMTP id
 adf61e73a8af0-1dc22937f8cmr2009323637.11.1731037463933; 
 Thu, 07 Nov 2024 19:44:23 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724079a403fsm2637203b3a.105.2024.11.07.19.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:44:23 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 00/15] efi_loader: efi http and ipconfig drivers
Date: Fri,  8 Nov 2024 00:44:17 -0300
Message-ID: <20241108034417.346124-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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

Adriano Cordova (13):
  net: net_utils: Move ip_to_string to lib/net_utils.c
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

 include/efi_api.h                        | 220 ++++++++++
 include/efi_loader.h                     |  42 ++
 include/net-common.h                     |  10 +
 lib/efi_loader/Kconfig                   |  17 +
 lib/efi_loader/Makefile                  |   2 +
 lib/efi_loader/efi_device_path.c         |  91 +++-
 lib/efi_loader/efi_device_path_to_text.c |  23 +
 lib/efi_loader/efi_http.c                | 537 +++++++++++++++++++++++
 lib/efi_loader/efi_ipconfig.c            | 216 +++++++++
 lib/efi_loader/efi_net.c                 | 287 +++++++++++-
 lib/efi_selftest/Makefile                |   2 +
 lib/efi_selftest/efi_selftest_http.c     | 315 +++++++++++++
 lib/efi_selftest/efi_selftest_ipconfig.c | 173 ++++++++
 lib/net_utils.c                          |  11 +
 lib/uuid.c                               |  14 +
 net/lwip/wget.c                          |   1 +
 net/net.c                                |  11 -
 net/wget.c                               |  39 +-
 18 files changed, 1979 insertions(+), 32 deletions(-)
 create mode 100644 lib/efi_loader/efi_http.c
 create mode 100644 lib/efi_loader/efi_ipconfig.c
 create mode 100644 lib/efi_selftest/efi_selftest_http.c
 create mode 100644 lib/efi_selftest/efi_selftest_ipconfig.c

-- 
2.43.0

