Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CAEC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC4DD83A2F;
	Wed, 28 May 2025 10:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b3mq60Zm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 114F383A2D; Wed, 28 May 2025 10:37:18 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B741E83A24
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a4c6c0a9c7so2977720f8f.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748421435; x=1749026235; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IAGVq15LX9e/gSzeSMR1p4MaKXMTeiUiey6MLQFdYlo=;
 b=b3mq60Zmk4ZcHTHld03nyZegkTdr/HS4XDtn6wj2SfXORwYBTPFkU2drYFDlAuQEBR
 WElkmy0a/m+8tHk4rcHpVuA5qmDRAuBvBtE7sIK2tqqDHnf3vpSx4oi/9LeWGPzwK3Xt
 l/ctG4amPq6+RJzKZ1J4mWJgWwjR5LBXvYUZT29YVF0/QqiZK868Pezbz0TRdQ6gMIPZ
 Pwog7/3ITY0ThpKDBGzpSyeOxhLv218BtSyQAxsRsZ0E90AyIRp8t88gi031LJPct7O8
 dOLh8NSRjau2UD3tc2j/sprIR4WFmHy5JZToY870NPKoWcFBBaBn1CtE5JKsAUZbu4aH
 uR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748421435; x=1749026235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IAGVq15LX9e/gSzeSMR1p4MaKXMTeiUiey6MLQFdYlo=;
 b=eCKUpu/fssFDcPEjr/j7613O/4Pce1dS0JqUICUxNRjGJb1BBZMjqjYSgCCqbwT8eb
 ktzC6bU9r8bzO9Fbnv1zea5HGJOyQguyrNRTeoIhHQsHv8k/AEA1Nfr28X/v0FnEfGH+
 y/LQ587UF05xc4nkf/vfPg/H+NYhTWfmbuyEagP9fKYqjVUboF6EEfGQIcBuzlUfpSfs
 oXejaOy7OXciRYCuJTVB9avpqvRss3arlNZG5cA3aMYxaMSyBPYIrqUepTIz8YrSRs59
 92iFZ3fDCBsS/3sA5WHGBN/a1WjZ9biZmKRMtH5GvfkhwcOFj585DxPehAgDoPoh4P1b
 PNlw==
X-Gm-Message-State: AOJu0Yw6ZfeHDVFUDg/chn11kVv2RcwQhPwrehPHjP6NTYWfya7jv/GL
 5pOZ00A1pBuwWtNgVfbEWu8G3hHHDRbY7MOavrEz5oNTYaDBLgViUgHol/jSCEnpgWU=
X-Gm-Gg: ASbGnctu3IY8oH5PTDxNb+vgHWKLdvhm6Y/vKS4/3+TnILdDoCvIF1tSe0fl/lOqdlU
 0S5N6kWCJZUznlfPM85W7Iz/Ez8bKNQwASVPXjcOP8O51a+Cg8fntAsIVlpQT6D/rCZRcxqJ+SU
 Xxwm2GsnKc4EjSxtE20cXZ3VDaqEgAd3A8Roxh3IMFbZknRiN45PZ8wL0e2dGj279++lF7HAb66
 1TKe52Vfo+Tz109BLj6Isb6fTICpPLmzAGkQWSBwq7MgXkKv2M1Vd46IP2/uGdC/THJ1WZZH6iv
 0RY69lLDJJAwzUSiBATgZYhlLB+QGiZ7iVQEn/JqMpXVBkzQaM79MiggxefPSIg6pUpLVBLzjsN
 QCBrzP8eglBXCrSDx/WTxPclFS3E=
X-Google-Smtp-Source: AGHT+IHyRXePU3J/tazxrGb4fIJ5TXDQx6YbHrstyWwuhABIDEYMLx2U3oBKgyr+/WLMdgn6BXwF3Q==
X-Received: by 2002:a05:6000:2dc4:b0:3a4:e841:b236 with SMTP id
 ffacd0b85a97d-3a4e841b2c1mr1521616f8f.33.1748421434936; 
 Wed, 28 May 2025 01:37:14 -0700 (PDT)
Received: from adriano.. (15.red-79-153-17.dynamicip.rima-tde.net.
 [79.153.17.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac6eb45sm857130f8f.12.2025.05.28.01.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:37:14 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 0/9] efi_loader/net: spit protocols and add testing
Date: Wed, 28 May 2025 04:38:12 -0400
Message-ID: <20250528083821.567514-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
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

This series depends on series 457127 "test/py: enable HTTP testing".

Create lib/efi_loader/net/, implement each EFI network protocol in a
separated file under lib/efi_loader/net/ and let efi_net.c be used only
to un/install protocols. The network protocol EFI_FOO_PROTOCOL is now
implemented in lib/efi_loader/net/efi_foo.c.

Add an app netdump.efi used to test the EFI_HTTP_PROTOCOL and the
EFI_IP4_CONFIG2_PROTOCOL.

Add tests test_efi_httpprotocol_net_* in test_efi_loader.py to test
the EFI_HTTP_PROTOCOL in the CI using netdump.efi. A branch of
u-boot-test-hooks with the necessay env variables can be found at
https://github.com/0n41rd4/u-boot-test-hooks.git.

U-Boot branch with this series on top of
457127 "test/py: enable HTTP testing" and next:
https://github.com/0n41rd4/u-boot.git

Changes in v2:
  - patch 2/9: free protocol interfaces if protocol installation fails
  - patch 4/9: free protocol interfaces and close events if installation
               fails.

Adriano Cordova (9):
  lib/efi_loader: Move EFI network files into /lib/efi_loader/net/
  efi_loader/net: Remove http and ip4_config2 data from efi_net.c
  efi_loader/net: Rename efi_ipconfig.c to efi_ip4_config2.c
  efi_loader/net: Remove simple network and pxe protocols from efi_net.c
  efi_loader/net: Remove efi_net_obj struct
  net/eth-uclass: Add eth_get_ethaddr_from_dev
  efi_loader/net/ip4_config2: Add support for multiple instances
  efi_loader: Add netdump efi app
  pytests/test_efi_loader: Test EFI_HTTP_PROTOCOL

 doc/api/efi.rst                               |    2 +-
 include/efi_api.h                             |   28 +-
 include/efi_loader.h                          |   16 +-
 include/net-common.h                          |    1 +
 lib/efi_loader/Makefile                       |    5 +-
 lib/efi_loader/efi_net.c                      | 1716 -----------------
 lib/efi_loader/net/Makefile                   |    5 +
 lib/efi_loader/{ => net}/efi_http.c           |   24 +-
 .../{efi_ipconfig.c => net/efi_ip4_config2.c} |   88 +-
 lib/efi_loader/net/efi_net.c                  |  750 +++++++
 lib/efi_loader/net/efi_pxe.c                  |  190 ++
 lib/efi_loader/net/efi_simple_network.c       |  889 +++++++++
 lib/efi_loader/netdump.c                      |  851 ++++++++
 lib/efi_selftest/efi_selftest_snp.c           |    4 +-
 net/eth-uclass.c                              |   11 +-
 test/py/tests/test_efi_loader.py              |   63 +
 16 files changed, 2859 insertions(+), 1784 deletions(-)
 delete mode 100644 lib/efi_loader/efi_net.c
 create mode 100644 lib/efi_loader/net/Makefile
 rename lib/efi_loader/{ => net}/efi_http.c (96%)
 rename lib/efi_loader/{efi_ipconfig.c => net/efi_ip4_config2.c} (69%)
 create mode 100644 lib/efi_loader/net/efi_net.c
 create mode 100644 lib/efi_loader/net/efi_pxe.c
 create mode 100644 lib/efi_loader/net/efi_simple_network.c
 create mode 100644 lib/efi_loader/netdump.c

-- 
2.48.1

