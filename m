Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF42CD3B7CA
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60B6B895DB;
	Mon, 25 Nov 2024 01:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qyg9a44w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB0D0895DB; Mon, 25 Nov 2024 01:58:26 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 470F38952A
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-723f37dd76cso3681294b3a.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732496303; x=1733101103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YfouRfHR+unrsLM+DIml9kDgwZ9wog4Hug1UMJUogPY=;
 b=Qyg9a44wnwP9PGS6DYqtbci03nJUDKuhb6X+c9UxV5gNUVK3E4PL2jTtjqob/hlRA2
 XdVb3VwZ2Md1XJ6p4ddy7tN8qwmLsNltF8a5LTTLdN7awb7AzIUFfzCwqGQHkFmblky2
 kyPCTMBb2FUvQ4YPa7JHZzyUM1ilZ6rXH1Xep22qMSLr/bP5RCDymj37+vG9lwNTno+4
 qYblzQ2NUOQ/kLsLV4MRpjr07Rfq47+6ZTDePVSPcnAQhRxUIBGLW96N5GEGO7PEB/jx
 noFg9epovJmofOnFAprMtCBAINPxu0Etw61HF/KsimG88d6U4SdeORF4VteE+Kb5NFIc
 2c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732496303; x=1733101103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YfouRfHR+unrsLM+DIml9kDgwZ9wog4Hug1UMJUogPY=;
 b=ldc5kQDCNI3mQ84TtJSIh6Ch8rv2qP+pyT0cGgCb6FgXYOIFLoiU1bY30CMXuTxJfb
 X4DMYNZuYFx0h2EN6WD0OKy8XwgsT73NqpVfB1cPcdDwSAbW0joouisAtQri+nhnr89E
 yomi1q6ttx3Lat5Gkp8tGKZrKo1rivoUBrbpDcnHAZO/RzriKnitOvoGNujuUMcw/ZKp
 xCfjs/lZfIYUlUMHgt3j0kfdD8VOfrMkGS24cvwN8yPXAschNFBC25xXBCLm1bwMJJm3
 XOiO5skGuhVsYAsrlX+7EZkBeR2hyQfSY1zO6soMwKU/Y3qtETuTnK3DfGUmUanMCaD0
 wptA==
X-Gm-Message-State: AOJu0YzscD8IjPQoAYdb1yX1XXoBKuJaKYCc18aw7AKQnCZsRSb1Q1+S
 GPfGObiacuts2uH2lmr9J/4GSR7GAL7w9WXFvNyWZB9Ra2Z+wPzqYSOfaD7TA5g=
X-Gm-Gg: ASbGncuwHblD+CACs4EWz24DcquIqk2iDMq9eDtlggYvj1rchIioHNH2HZJdKWtiLH+
 v4vynhD5E5/n59Epu0um8dYLglSjn/LP7pEMsTLvphOA6xkFpfqdfuD5Sy7ZqIdUp4I5tE+CNTG
 s9yX7E75BhHdKspSwrGR4YMVNuM51DXA/KO5ShAcXCJ1ualEu1IrnKkSKKBrSO9gwJrtVlA2V2d
 tIviGgo3fo8yuDR7z3BQ38oEk6bUkL1uuUOZXy4FqKQ
X-Google-Smtp-Source: AGHT+IG5YKl8dmSoaqdapIDM3++VkLjELvCjNmjj0W9/prFBBi0u8hhESwJhZjahYVLZmVL/oT/PkQ==
X-Received: by 2002:a05:6a20:6a1a:b0:1e0:ce71:48e0 with SMTP id
 adf61e73a8af0-1e0ce7155ecmr997102637.39.1732496302672; 
 Sun, 24 Nov 2024 16:58:22 -0800 (PST)
Received: from adriano.. ([186.11.57.125]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de47955asm5377793b3a.65.2024.11.24.16.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 16:58:22 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v5 00/14] efi_loader: efi http and ipconfig drivers
Date: Sun, 24 Nov 2024 21:58:00 -0300
Message-ID: <20241125005814.236669-1-adrianox@gmail.com>
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
 include/net-common.h                     |   7 +-
 lib/efi_loader/Kconfig                   |  17 +
 lib/efi_loader/Makefile                  |   2 +
 lib/efi_loader/efi_bootmgr.c             |   2 +-
 lib/efi_loader/efi_device_path.c         | 108 ++++-
 lib/efi_loader/efi_device_path_to_text.c |  23 +
 lib/efi_loader/efi_http.c                | 548 +++++++++++++++++++++++
 lib/efi_loader/efi_ipconfig.c            | 214 +++++++++
 lib/efi_loader/efi_net.c                 | 360 ++++++++++++++-
 lib/efi_selftest/Makefile                |   2 +
 lib/efi_selftest/efi_selftest_http.c     | 315 +++++++++++++
 lib/efi_selftest/efi_selftest_ipconfig.c | 170 +++++++
 lib/uuid.c                               |  14 +
 net/lwip/wget.c                          |   5 +-
 net/net-common.c                         |   2 +-
 net/wget.c                               |  35 +-
 18 files changed, 2059 insertions(+), 27 deletions(-)
 create mode 100644 lib/efi_loader/efi_http.c
 create mode 100644 lib/efi_loader/efi_ipconfig.c
 create mode 100644 lib/efi_selftest/efi_selftest_http.c
 create mode 100644 lib/efi_selftest/efi_selftest_ipconfig.c

-- 
2.43.0

