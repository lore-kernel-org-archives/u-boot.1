Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41419CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C525286A38;
	Sat, 23 Sep 2023 21:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fFfw4DRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 423C686A08; Sat, 23 Sep 2023 21:53:10 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4AE869CD
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-533c5d10dc7so1236065a12.3
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498787; x=1696103587; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=66QApHK65z4ee1zY/kbo8TlCyzLkbXgpQn7mkCEsVhI=;
 b=fFfw4DRwt8TiTFtBAH9x10dZsQwmL9i4CowUfMjhRsN+bHejNVB+hd6brWVleYG+Tl
 qheWE6p99zgA6BLKJYXdOOkVHJsNefXfuF8uj8pEiPIshZQbOtQHx5fhg3/IHIAES9Uh
 uSyMkQ8FqUaInVqR6Ha7qF6H+itjI7eyLAEhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498787; x=1696103587;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=66QApHK65z4ee1zY/kbo8TlCyzLkbXgpQn7mkCEsVhI=;
 b=p9xTGzi3dGkhXzlEBHFm82iPrtVRfiUJO6cuJ1psLgZb+pEFY+rg54kDx9ctIVW/UI
 +4Cis+8sG1J/7X+Ho+yKyl1NuHsUdzLczuOHtmwxVXjcAjHpRlcEDSaSeBNmcq+G5s4c
 xg1S0u4mK573e94nAx5vdJMrwXUHsCOosxsF2SjjpSBMSg0SJSpjlLP+bTRY0aZEbxjo
 O0bbZ2fRm2gKiVa3FoK5rCIRnjF2UbGS9fd8D+0PGarlQ5tjlrueP36r3uzM+UQ/4BK+
 58+JDdVsaikYXM8JIxDchQ6CMLUra224Xv9WetkjTX3Gl90HDtferCtJBJuqS9c4rYCt
 9WUA==
X-Gm-Message-State: AOJu0Yxec98V4YhRAULLZWBrTGWNPzE9u1sDeu4D6sAORM7nl4dcb0+t
 7Bei84yvgN93EG+gXB2CvGwLsgIVhAJY7tIKSSZ5FFsDJSwnndusMyxFSw==
X-Google-Smtp-Source: AGHT+IFATN3tDZmdg0YSmZ5Sd4uv+XrVcGMhiwjTQ9IbqN34NysfazqStNo0CvE5YRl5vYuLAtXC1wQliMkUAdqnezo=
X-Received: by 2002:a50:ec84:0:b0:527:ab3f:4350 with SMTP id
 e4-20020a50ec84000000b00527ab3f4350mr2422781edr.38.1695498786987; Sat, 23 Sep
 2023 12:53:06 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 Sep 2023 13:52:55 -0600
Message-ID: <CAPnjgZ32+7B0SVvpE+r_c9ZyCXpkFErRJRf0uCAx-aCMuJc2ow@mail.gmail.com>
Subject: Please pull u-boot-dm/next
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

This is for the -next branch

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/17836


The following changes since commit b05a184379631d13c4a49e423aa1324dc1ae6158:

  Merge tag 'x86-pull-20230922' of
https://source.denx.de/u-boot/custodians/u-boot-x86 into next
(2023-09-22 11:16:22 -0400)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-next-23sep23

for you to fetch changes up to ae84514feee209091d331a8baaa344ed8d8e905b:

  kontron_sl28: Use u-boot-update.bin instead of u-boot.update
(2023-09-23 12:31:25 -0600)

----------------------------------------------------------------
buildman file-keeping and build-progress improvements
dm tree enhancement
adjust meaning of bootph-pre-ram/sram

----------------------------------------------------------------
AKASHI Takahiro (1):
      cmd: dm: allow for selecting uclass and device

Jonas Karlman (1):
      dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation

Simon Glass (4):
      buildman: Keep all common output files
      buildman: Show progress when regenerating the board.cfg file
      buildman: Start the clock when the build starts
      kontron_sl28: Use u-boot-update.bin instead of u-boot.update

 arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi |   2 +-
 cmd/dm.c                                          |  48 ++++++++++++---
 doc/board/kontron/sl28.rst                        |   4 +-
 doc/usage/cmd/dm.rst                              |  30 ++++++++-
 drivers/core/dump.c                               | 116
++++++++++++++++++++++++++---------
 drivers/core/ofnode.c                             |   2 +-
 include/dm/ofnode.h                               |   8 +--
 include/dm/util.h                                 |  15 +++--
 tools/buildman/boards.py                          |  15 ++++-
 tools/buildman/builder.py                         |   3 +-
 tools/buildman/builderthread.py                   |  12 ++--
 tools/buildman/control.py                         |   3 +-
 12 files changed, 197 insertions(+), 61 deletions(-)

Regards,
Simon
