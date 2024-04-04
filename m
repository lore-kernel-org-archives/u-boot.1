Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C4DCD1296
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 11:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CE508843D;
	Thu,  4 Apr 2024 13:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y6RuhxLS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A8E888440; Thu,  4 Apr 2024 13:48:22 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 694A6883D6
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 13:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B994E4248C
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712231274;
 bh=P29MOpz1iRI2T5F8PX3Of+suRGBv9a+oGO/TX8f5dBc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Y6RuhxLSLlTdvRVNiC0eVqdkf3+YHSMuc9/h36sEhDJyjfBJEMp2yuVL4AKjnbSJu
 5fg/Hx24hDOlTynR/WunqwRLo+PP2sADkWL29sKKw10cD3P2/psNYSTO+EjCmBvB3F
 72wVtWkxLpMQNosdMpWXqNbW3nhCJJqQc7WUbEd1KEUkI5rkb/EnONKQAzV6LTIooT
 CWtHDsUYxu0zYOO3OmYvL/LoLWMcZDYFNsmal+6MkQA38tZuN5zvnLII12SPIDIWDN
 rd9I+k3CZjgT9RKM9JnXptvJO+yXmBb+zcfk/9epsYCYmQpepSoHSdsw4OBmAprRpG
 OHsoCPlQmXSKQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41485831b2dso6369585e9.3
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 04:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712231273; x=1712836073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P29MOpz1iRI2T5F8PX3Of+suRGBv9a+oGO/TX8f5dBc=;
 b=chUm3gXzL6B50leipZMSOWeQsrywCwq5rSj2p7AtqVdqEJKOhl64rw45sWjTkTi5hY
 ppkFwmNjfLjlzgk4uHXkdKtpZyBuRBUbl0KhoqA4Zxe3YCqqlE5eLGdz9K1EO430aaEN
 DgrrXYOmFhY9EF9ryocdWeTQ+1dL/ywXmoag/qDCl8uf34HLi2Rf423DEWi1BqF1llcS
 mBS5yBl4kKaAfnx/vFizGFK5aK5hAbd9VtP8jwiw1q3+SeVen6aq7j7YcPekmI4v7Fza
 s5KR+4wYsib7zKYM4oTfHEY5metvqDr/gOmUdZsUqxGc9DveTqzTuDN2mpNe5SEi6c6U
 +zsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3FWNtKq7IveiYUShJLxekWUAw7QNdyW2d5wwlPg9Wrs88sfSW8Ov79InnhwPqRl64XEsNtQTLFzE3EJhCwE/wu/72pA==
X-Gm-Message-State: AOJu0Yz4xOeY9AvpdqEHUrbxTdCJYDos/XnzDDGUx8MKmRoSCk+jWHhv
 HnfUiH2lrPUtgNxX4c+Mgep3S9tXqw7SG07ttSdN9BeR3Tg91cHl978phWEEfBo9ks5OxAMTMja
 9gIYxcueQzOiVK1tdJ6FuQGHvA+UxlJ3r9JbDTY+fjccaY49uVAhnJEL7JgsIGSX4bFU=
X-Received: by 2002:a05:600c:252:b0:414:8c06:5c32 with SMTP id
 18-20020a05600c025200b004148c065c32mr2111956wmj.14.1712231273179; 
 Thu, 04 Apr 2024 04:47:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ9jSexF5j1GCWfabtiqx7ycxjt2iMCYYQpZRZMKWNwpDxPK80j6rz+QyxhPSxDS/+A4n99g==
X-Received: by 2002:a05:600c:252:b0:414:8c06:5c32 with SMTP id
 18-20020a05600c025200b004148c065c32mr2111932wmj.14.1712231272754; 
 Thu, 04 Apr 2024 04:47:52 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a05600c350200b00414906f1ea1sm2422134wmq.17.2024.04.04.04.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 04:47:52 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng@tinylab.org>,
 Shantur Rathore <i@shantur.com>, Mark Kettenis <kettenis@openbsd.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/4] boot: fix EFI boot methods
Date: Thu,  4 Apr 2024 13:47:38 +0200
Message-ID: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
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

The default sequence of boot methods is determined by alphabetical sorting
during linkage.

* efi_mgr must run before efi to be UEFI compliant
* pxe should run as last resort

If UEFI is enabled in U-Boot, we want it to conform to the UEFI
specification. This requires enabling the boot manager boot method.

The sandbox must not use an arbitrary file name bootsbox.efi but the
file name matching the host architecture to properly boot the respective
file. We already have an include which provides a macro with the name of
the EFI binary. Use it.

The path to the EFI binary should be absolute.

The path and the file name must be capitalized to conform to the UEFI
specification. This is important when reading from case sensitive
file systems.

v2:
	fix building with EFI_BOOT_MGR but w/o BOOTSTD
	correct finding the default EFI binary

Heinrich Schuchardt (4):
  boot: correct the default sequence of boot methods
  boot: enable booting via EFI boot manager by default
  efi_loader: move HOST_ARCH to version_autogenerated.h
  boot: correct finding the default EFI binary

 Makefile                |  1 +
 arch/sandbox/config.mk  |  2 --
 boot/Kconfig            | 10 +++++++++
 boot/Makefile           |  2 +-
 boot/bootmeth_efi.c     | 46 ++++-------------------------------------
 boot/bootmeth_efi_mgr.c |  2 +-
 boot/bootmeth_pxe.c     |  2 +-
 include/host_arch.h     |  2 ++
 lib/efi_loader/Kconfig  |  1 -
 lib/efi_loader/Makefile |  3 +--
 test/boot/bootflow.c    |  6 ++++--
 11 files changed, 25 insertions(+), 52 deletions(-)

-- 
2.43.0

