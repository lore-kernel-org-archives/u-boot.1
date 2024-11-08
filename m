Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52F4D5C0F4
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E9E1890CE;
	Fri,  8 Nov 2024 16:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BRFdNsjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427E388E81; Fri,  8 Nov 2024 14:39:09 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C56F688D47
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20e6981ca77so25191315ad.2
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 05:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731073145; x=1731677945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c4IYlxxvlSGgcV+7lYxABGezlYjpIB5jYOEH2yiOK/I=;
 b=BRFdNsjgOWT8rdHm7kbArarIghPe2+NW4ylDABV5KjQCiivmUfTYNZscihA1VWr/1G
 kL1KkaqEU9xHVKVitQbtyR5y3BnVYmlyyCXz9f7SkcPKtwgg32KT+eSNA2jwefFqOIBr
 KBnSU3GFY3Rcz63Iu0Ko/ye4FVCA2J+ZhBHQfsD/wxBTBPsTaTgSEXJcIAs0+U8kht6A
 VssfEo/qokvr6QlVgs4imngMOJ/BXktTsFatEgBcQPO9pOzcP4rBwGnia0BNK99PLcNs
 ZRZEmkVbTahqJ+OCONlGDsBIw/VBt52Z4OSdRKYWlU1mr1/cEOaOvjkutSf19intXHYz
 QIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073145; x=1731677945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c4IYlxxvlSGgcV+7lYxABGezlYjpIB5jYOEH2yiOK/I=;
 b=apxtizlmq6KXiRc+/8SV5vBxfy31IqMMR50iKJvWXtJgyMGmt4qAi4B7rqV0WFYPSa
 CLOvsVuKMj7YdhqOb/O/Jv2VoCIZvleaZAIMAceeGcm+TMp2le/RjIPC9M9XmNmFxrL2
 MEgdKl21E07bMO4+ozKXgDTzATxTUe6qYdVxBDfCX/Dj00DoL3LYbcOC5f1YXh/KCviP
 vn8LZx2IFMUPHxseiD30RSj4e9lkkpiI2uwSmf8FKFmwUjV46ot9iJB2JHe0eH/kuYNY
 IWZLnkBUCV8XrxpcMb/Bn2oPa5I5CjqtjX8HsyJdrQPVFV/D7Ci4uIw6ykzaisnzPNeV
 4jTA==
X-Gm-Message-State: AOJu0Yxpx1vqWT7iG7XtymIhcnZlkMevQtaBCbiZ09aEBLx/Z5LvPcnh
 v1+0c/vk4gEU9h3ywBw0i9Pk0RFg1LmT461oW+yQqhnCEW7JSIL85FQ/AG9KpeA=
X-Google-Smtp-Source: AGHT+IEJdn3ZdzdurYhnaemrHFkiidyZVJ0uY5UxRQaZQoCdrakgGpjyZbltRjEXAgiknNblWcppww==
X-Received: by 2002:a17:902:d50c:b0:20b:449c:8978 with SMTP id
 d9443c01a7336-21183559ba4mr36995805ad.31.1731073145140; 
 Fri, 08 Nov 2024 05:39:05 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc8376sm30296295ad.44.2024.11.08.05.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:39:04 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 00/15] efi_loader: efi http and ipconfig drivers
Date: Fri,  8 Nov 2024 10:38:35 -0300
Message-ID: <20241108133850.431075-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 16:56:12 +0100
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

v2:
  - fix some checkpatch.pl warnings
  - send patches as single email thread

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

