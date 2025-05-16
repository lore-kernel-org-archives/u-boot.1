Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC41AC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87AD82935;
	Fri, 16 May 2025 10:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C+TX464O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78DE08288D; Fri, 16 May 2025 10:17:50 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF1181DD6
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso14363815e9.2
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747383465; x=1747988265; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EdSbVgVnWDiYdVxr18+vQx44115vNvEEwi9HaQpRtgI=;
 b=C+TX464OWuCp/PxbbrnNiikjjOlv8kMZwBTxVQZlbt7LdPEKAzAPMsWUtnHEdU0Jls
 mma9Ng2nhcu7ECai5+JzkujhmDf1yXKLN3KgZr+3Xd/Dnc2k15jBbbI3/YDrug6hRSdz
 HBW6lgw+RWyaApaCof2LGkqX0VGMSGsHB9/pYpMlC9waG2E9ZvxVOGmdR6tQicjdXH3M
 7EczQcdc9fyk7kxMWpdvwQYZDn/Ig+xGvA18XPAPHhomlSeiShvgyhwtDCtzD/DTFF5n
 Q8ST8dzCW1yMTrwkOTk2IuVWrJtuoCCANbB3cwWE7l5LOunCkFlfyv5jEGE5ZvaixQzW
 cAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383465; x=1747988265;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EdSbVgVnWDiYdVxr18+vQx44115vNvEEwi9HaQpRtgI=;
 b=PWec5xgHEdchzzFcccL3ZE1Inj8/EFREaFim8qxR2pQqB8iS9Mu7PV41QxTBfDm8My
 OutbLckBg81Xj+puj/0z8r/cLOXluVvvWuT1b6a/hXT0IYYEGzivsL8aztxCrwv+1brI
 S0OYTLrlTPbQ2mMQuN75UjgchHQMLqC3syZiz4eYQrMxiPwIXatEvFLkMWD1uKYAuwzt
 2d6gEbiGOAytyHkGGSh0J/wy0oIslwLtmTD4YZ3Hv1NOPaT5vRHQi8bmNCDUSsTxDwUg
 QYmHjf+qs9J4MFEV9r6goFLd94Aio2AdLcdN1Q0QiXiFJqy6fmZ9HkLMl1PhgicdWonw
 e1xQ==
X-Gm-Message-State: AOJu0Ywrj+J1zxH7aIMo4O1Hzm+nQFvin7/7mwDrqLh5/oWx+pyOWH0v
 RgDKk7nVgDpFNCeLzrEKNCO5FSDYefNGFYhSNLT1Ts4qrgKY3F++wSO+5f7sid7hRJs=
X-Gm-Gg: ASbGncvY4U2M83XD/I0XCygZukqyvO/KRcMLFWc6tpCQ9nnctDReAJ3JoeZTGlhRAl0
 bbGONlynifnX9eqc1DVHaeGaqW4WCOwgxl7eTuUswQu7/Esuxswk8Y6lUteGA4tyNr9j5MCGIsK
 7zje/iCOmJndknOwkW8GUpyD3Oq5Qer5J5XO5ueIKIeCdscPHUiv/nxhkgFaXYU8Fy42TjtBZc0
 Q6RP0WVO9Ly6haFPJeKSwFOVf59fVIIY7giz1CjtSTx96GvtNMMnyeSQ9eOzrhmdGIgDwssoWi+
 cpFNIxMXtScfPKUK0DkK5Eyt0xcoiwGk51mMuf/tu8Z2lMDZSb34hJpmaD/YaA==
X-Google-Smtp-Source: AGHT+IEHMx+Mwcnd8Hz1zKs5fOjnsRURbLyQV0nLOrRLzSE9w/WQoRsx6b5HqKew7rjrc/IIQCSkfQ==
X-Received: by 2002:a05:6000:2285:b0:3a3:5b59:cb24 with SMTP id
 ffacd0b85a97d-3a3601dc06emr1305075f8f.57.1747383464724; 
 Fri, 16 May 2025 01:17:44 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8ce9asm2010159f8f.86.2025.05.16.01.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:17:44 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 0/9] efi_loader/net: spit protocols and add testing
Date: Fri, 16 May 2025 04:18:30 -0400
Message-ID: <20250516081839.28587-1-adriano.cordova@canonical.com>
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

This series depends on series 456885 "test/py: enable HTTP testing".

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
456885 "test/py: enable HTTP testing" and next:
https://github.com/0n41rd4/u-boot.git

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
 lib/efi_loader/efi_net.c                      | 1715 -----------------
 lib/efi_loader/net/Makefile                   |    5 +
 lib/efi_loader/{ => net}/efi_http.c           |   20 +-
 .../{efi_ipconfig.c => net/efi_ip4_config2.c} |   86 +-
 lib/efi_loader/net/efi_net.c                  |  749 +++++++
 lib/efi_loader/net/efi_pxe.c                  |  190 ++
 lib/efi_loader/net/efi_simple_network.c       |  880 +++++++++
 lib/efi_loader/netdump.c                      |  851 ++++++++
 lib/efi_selftest/efi_selftest_snp.c           |    4 +-
 net/eth-uclass.c                              |   11 +-
 test/py/tests/test_efi_loader.py              |   63 +
 16 files changed, 2846 insertions(+), 1780 deletions(-)
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

