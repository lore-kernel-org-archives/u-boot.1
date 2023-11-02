Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3852C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFEE8770B;
	Thu,  2 Nov 2023 23:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RV5UeJNp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F18DA87713; Thu,  2 Nov 2023 23:54:51 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DEC6876DF
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7c95b8d14so18209507b3.3
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965684; x=1699570484; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xs8bmEjqurV6AONfrX3eYW3+cxtmLEx9a1bDMJArkaI=;
 b=RV5UeJNpZwT7CpfgTqMau9Ic1ko7q8rgbF6UEAfe2dKpVWF9SSOspmrwrPRU9MVWNn
 Xa1lkyMv/clk5uYMpUSPwJoGJP+3K6DohfMLAvHu+zNZ+u8CCY/7XUfD1FZMnK0a1o8i
 4ohQ9Y9qxLEI/s5xnN6G2GDhBHCyLe4X/gzBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965684; x=1699570484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xs8bmEjqurV6AONfrX3eYW3+cxtmLEx9a1bDMJArkaI=;
 b=suE4evvr2lvPfE9T5Gq9PR/dwhtMgUi3HAw2qH0JAAwc1Z8hJbBIBNcQWr+ppoD/Up
 qKwGJQytSpn6uoCMiQ/B3sYkWpp6+PJHQ7L0bQPOKSzQ7qEJVQ76eZ83otYV3NOA3NYu
 vXxUq71VCpNb6Ld7qnvSWpsNhp7pT3rAK6Vw+DCthkUfUeGQ3fvL1Mos0m4ZGwbXv7Yr
 brJMiGzB8GhXlZY/EAXG7qYvKwNWFJl36GJSI6d9ZgygFTtPgRMq/nQGiX4e21G/aUIn
 dTkijXgAqnXnqaHKMlBzLTsLrawFRrN3AtO1i9+eHQIkZ5xKSKTpq2w6MpOdp+9OaWv+
 NRSA==
X-Gm-Message-State: AOJu0YyfWL9MSEZUPbJy+A8PusnHbDi5VOHo5nTyP2eDxdR6VX6EaOdf
 T4E/Z/aOP0MeP5C6P6taah0UF62uUKeI1zorw8+Ynel3aNCrUZcqu6cTkA==
X-Google-Smtp-Source: AGHT+IGklDIlmb/czx4iM7jqxkdwyn6YWJezSSVmRFV30U7i7UYRQTezVgJZojtT101kdIg4HJJdfN77+nTszyWWrSs=
X-Received: by 2002:a81:6d12:0:b0:5a8:2d2b:ca9c with SMTP id
 i18-20020a816d12000000b005a82d2bca9cmr1165048ywc.32.1698965683890; Thu, 02
 Nov 2023 15:54:43 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Nov 2023 22:54:31 +0000
Message-ID: <CAPnjgZ1QEypD08Py_9k=upHF2SqO3wZ7h5uVT0Pz2qza=a4J1g@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

Just various bugfixes, apart from the TI one


https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/3227baad05481e3=
7d75aeae7c7c1467fd6903f7d

https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D54&view=3Dr=
esults
(not finished yet)


The following changes since commit 07fe79c93c5caba181f37844ca95fbda4db3f613=
:

  Merge tag 'i2cfixes-for-v2024-01-rc2' of
https://source.denx.de/u-boot/custodians/u-boot-i2c (2023-11-02
10:12:33 -0400)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-2nov23

for you to fetch changes up to 3227baad05481e37d75aeae7c7c1467fd6903f7d:

  u_boot_pylib: Ensure subprocess is closed down (2023-11-02 09:38:54 -0600=
)

----------------------------------------------------------------
Heinrich Schuchardt (1):
      sandbox: eliminate unused functions from binaries

Maxim Cournoyer (1):
      patman: Add a 'keep_change_id' setting

Milan P. Stani=C4=87 (1):
      cros_ec: spi: disable annoying key echo on console

Neha Malcom Francis (1):
      binman: openssl: x509: ti_secure_rom: Add support for bootcore_opts

Simon Glass (9):
      binman: Reset missing bintools after testing
      binman: Don't add compression attribute for uncompressed files
      binman: Ensure attributes always come last in the metadata
      binman: Replace FILENAME_ALIGN 16 with ATTRIBUTE_ALIGN 4
      binman: Rename TYPE_STAGE to TYPE_LEGACY_STAGE
      binman: Move stage header into a CBFS attribute
      buildman: Include symbols in the read-only data section
      buildman: Support upstream branch name containing /
      u_boot_pylib: Ensure subprocess is closed down

 arch/sandbox/config.mk                  |   4 +-
 arch/sandbox/cpu/u-boot.lds             |   2 +-
 cmd/cbfs.c                              |   2 +-
 drivers/misc/cros_ec_spi.c              |   2 +-
 include/cbfs.h                          |   2 +-
 tools/binman/btool/openssl.py           |   6 ++-
 tools/binman/cbfs_util.py               | 125
+++++++++++++++++++++++++-------------------
 tools/binman/cbfs_util_test.py          |  23 ++++----
 tools/binman/control.py                 |   2 +
 tools/binman/entries.rst                |   1 +
 tools/binman/etype/ti_secure_rom.py     |  11 +++-
 tools/binman/etype/x509_cert.py         |   3 +-
 tools/binman/ftest.py                   |  10 ++--
 tools/binman/test/297_ti_secure_rom.dts |   1 +
 tools/buildman/builder.py               |   6 ++-
 tools/patman/__main__.py                |   2 +
 tools/patman/control.py                 |  12 +++--
 tools/patman/gitutil.py                 |   5 +-
 tools/patman/patchstream.py             |  17 ++++--
 tools/patman/patman.rst                 |  11 ++--
 tools/patman/test_checkpatch.py         |  16 ++++++
 tools/u_boot_pylib/command.py           |   4 +-
 22 files changed, 168 insertions(+), 99 deletions(-)

Regards,
Simon
