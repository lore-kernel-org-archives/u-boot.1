Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7CDD69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E19D89D05;
	Thu, 28 Nov 2024 15:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FG47suuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A9689D03; Thu, 28 Nov 2024 15:44:26 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22A689D05
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:44:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7f71f2b136eso611360a12.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732805062; x=1733409862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TBE6TijouHJRela7b3//0il6hg5P1dJLZz11L6Q+Rgs=;
 b=FG47suuhuBVKY/YVOB4JSqzQLzzDcUYRBK4Ky1yLznSo2TwvJ/41JB1FNJ6EV2Pvh8
 x6O/EsgaQVNY0IOrDYA+IKPW6dEeAqssQlNtDW8xeYiLByeNeITBS36qITwAq7nJ/qRH
 69v9YG7RPDBU2gKAfQzdaWVSYPj9/+Hg4Gg5VFDgsvt2GVZ8xcT+9+UxVK0sk5NLWZib
 A1jcQHF6x+0QfXH9QoR2QU/q5v9jfeHoc0qD2kwKXvaZd4uJS1wgT1gkuKqAAgI8SAWm
 TW5gdLyerk/U8IPwsy0MdQZxZ+esDF3Ly7kRddr8QLZRUvVXm+CEJfFg8JB4QHuVUMQM
 SCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805062; x=1733409862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TBE6TijouHJRela7b3//0il6hg5P1dJLZz11L6Q+Rgs=;
 b=GX0ObUAvIMLnXy7X06cPcdeKhDOg6sBCbGWHY52o3UwuOhOkfU11LKF7Ei5Afa1/uP
 LYFeriZKpW2T+Nlil2GsKGSs9CQjqF2pDRsA7ONmEzmq1A/BBoVWefnzgZ8cwexkQElH
 6n2QUb/k2/u8luPj6rrgPkdK4rdLxqft7P4Ty/sVzyt6xt2kNDcHVk66k7qSyoE6ltNk
 qs3B9F/4bi0JjtTpeZuRXh3GIbqNrBa7sBzRvQAmtl6xPfKkHo5RYEx7DsqtHfBC/RHd
 Sh93FKx2DtgO7P3JLxnQfW1MtkLNh+UC0MBDv8b8UvAh19ml5Bal3VGvGSPLiYMpLj07
 +iAg==
X-Gm-Message-State: AOJu0Yy2IDQPqVK2Rb+8TB27C9d4PB955LXcp/umxcS7tMmNasOKpONF
 Q2p0K5sNeR6UtCLA7Y70PDjvjgu+JmDsk+VwmUeSRdCGCVy/vLet9pgGXHgxah4=
X-Gm-Gg: ASbGncuSdbWzh+1aZ0N4gAxa9oRGI3rT14RDgL3LsbeTo8TB/BZUFvwyK4nVB2WI5Do
 hy98og0rEKLEnUzy/ZXbkNBbNqf514x3NSls5VBq1viqRffEtSftrnyl2Te9649B6gS3Pp44mhB
 xqUjpc7JnrW6gnvObx4498rTTsA17lncACWg3rrvgjDR8HcV5MeK23Q2jPb8nEVXvg8/RtjWgDO
 OPfL6nDKbgUk+0zKC86twUm7TxWUODo0X5Z7XRAigs=
X-Google-Smtp-Source: AGHT+IECPUCITz5bPPgYhKlkNmubZ6oX4iI/RF3HWHIXD4B+RxzRHgZe6LUe8rHZ0lAf84sSUANgZg==
X-Received: by 2002:a17:90b:38ca:b0:2ea:691b:aa32 with SMTP id
 98e67ed59e1d1-2ee08ecd4b4mr8968686a91.18.1732805062104; 
 Thu, 28 Nov 2024 06:44:22 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee2aff1b77sm1532202a91.11.2024.11.28.06.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:44:21 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 00/14] efi_loader: efi http and ipconfig drivers
Date: Thu, 28 Nov 2024 11:44:02 -0300
Message-ID: <20241128144416.604126-1-adrianox@gmail.com>
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

A branch with both series of patches, concatenated, is at:
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
 include/efi_loader.h                     |  41 ++
 include/net-common.h                     |   7 +-
 lib/efi_loader/Kconfig                   |  17 +
 lib/efi_loader/Makefile                  |   2 +
 lib/efi_loader/efi_bootbin.c             |  40 +-
 lib/efi_loader/efi_bootmgr.c             |   2 +-
 lib/efi_loader/efi_device_path.c         | 116 ++++-
 lib/efi_loader/efi_device_path_to_text.c |  23 +
 lib/efi_loader/efi_http.c                | 548 +++++++++++++++++++++++
 lib/efi_loader/efi_ipconfig.c            | 214 +++++++++
 lib/efi_loader/efi_net.c                 | 371 ++++++++++++++-
 lib/efi_selftest/Makefile                |   2 +
 lib/efi_selftest/efi_selftest_http.c     | 315 +++++++++++++
 lib/efi_selftest/efi_selftest_ipconfig.c | 170 +++++++
 lib/uuid.c                               |  14 +
 net/lwip/wget.c                          |   9 +-
 net/net-common.c                         |   2 +-
 net/wget.c                               |  36 +-
 19 files changed, 2101 insertions(+), 48 deletions(-)
 create mode 100644 lib/efi_loader/efi_http.c
 create mode 100644 lib/efi_loader/efi_ipconfig.c
 create mode 100644 lib/efi_selftest/efi_selftest_http.c
 create mode 100644 lib/efi_selftest/efi_selftest_ipconfig.c

-- 
2.43.0

