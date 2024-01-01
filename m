Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB61C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 17:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 499AB86F64;
	Mon,  1 Jan 2024 18:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P3h/Zb9d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5EBE86FFD; Mon,  1 Jan 2024 18:32:11 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23BFA86F39
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 18:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-67fb9df3699so62357356d6.2
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 09:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704130328; x=1704735128; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=o4onirU2klJxT3yXtKD3DC3AhUKtQpKFc35RVxsn0yA=;
 b=P3h/Zb9dqzTwUQWxaoHp1Yw/fxM4gr4DdFbkWDQkr6TYMrQHdRp+ZD81Frx2smrvNz
 trblonZ5Emt5QR82QAwuavhYpRE6j2zLh+TNjuSo71WvHlTd1cKJ0H7zmVtVT9Nnqwgl
 pWIa8SG33ocU8FvYpJe/rdv/pOQ75p5DcP8uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704130328; x=1704735128;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o4onirU2klJxT3yXtKD3DC3AhUKtQpKFc35RVxsn0yA=;
 b=lsinLxPlAOc7B0O9AOhvl+IiXG7iti2SsITDMPTaG6N4rJe4uEvP3NaIzk5dDFvcYx
 QHLuyM9Mj1zRd83CltA/RpNiOmi8tMnNCRy42IrhUlrhz8yLgL1aw7zcGJdxBjVvMxIH
 sGEcidGQMPvaZs0GVTeREFJZX3Nr54QceWyYFbyxGPPFmlPIN3orY5AqQI21od9cfJcE
 YmeFOK+7Qman05JQpMjuo9en1fjqJsM/HxWxFD5KJDZieFtl75Dc4hg0OVc9J1FD45ip
 YHZiarn6YGooqFXlZ9tqcm7kpEFgYk4dPV4fk73SSxQ43KiosFsmiDRwEEHQT8+HEr71
 QukQ==
X-Gm-Message-State: AOJu0Yw/qiWsZzWXFK4sVfGtTRbSYQvkQZuYUKe5U20WTPKkQSSZhE5V
 I+rO4qRwTi2DWfCQRq4q8QXqpYEpltiM/vGMKX9zdVL9kgaWb2lszF8nH9XYRw==
X-Google-Smtp-Source: AGHT+IF8ufwQ2FCPycAUky3QTUXVKuysxz8Xk1GubvGZ3uJLp0mmcgfTOmHf+KFGO7bqhLw/FtueasQEDQJM0pB5DqU=
X-Received: by 2002:ad4:5aec:0:b0:67f:179c:e1a2 with SMTP id
 c12-20020ad45aec000000b0067f179ce1a2mr22830848qvh.22.1704130327833; Mon, 01
 Jan 2024 09:32:07 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jan 2024 10:31:57 -0700
Message-ID: <CAFLszTiz8oT9tTA-w+qVnxy2=mjCya8RMXdbswS1GtoxV+hO8w@mail.gmail.com>
Subject: Please pull u-boot-dm next
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

This is for -next

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/19131

https://dev.azure.com/simon0972/u-boot/_build/results?buildId=57&view=results


The following changes since commit 2b28c3b871cd5d55b19f0a86cef970139f8ab952:

  Merge patch series "Modernize U-Boot shell" (2023-12-28 14:38:25 -0500)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-next-1124

for you to fetch changes up to e266d2731145681a55d862360f1b61690b0c6820:

  bloblist: Update documentation and header comment (2023-12-31 07:21:02 -0700)

----------------------------------------------------------------
support propagating supernode properties with bootph schema
align bloblist with v0.9 of Firmware Handoff spec

----------------------------------------------------------------
Heinrich Schuchardt (2):
      buildman: type cotaining
      binman: used-before-assignment in ftest.py

Simon Glass (22):
      x86: coral: Align bootph SPI-flash subnodes with parent
      fdtgrep: Tidy up a few type warnings and comments
      fdtgrep: Correct ordering of flags
      fdtgrep: Correct references to fdt_find_regions()
      fdtgrep: Tidy up comment for h_include()
      fdtgrep: Simplify code to inverting the match
      fdtgrep: Move property checking into a function
      sandbox: Correct SPL condition for building devicetree
      fdtgrep: Allow propagating properties up to supernodes
      Makefile: Use the fdtgrep -u flag
      bloblist: Update the tag numbering
      bloblist: Adjust API to align in powers of 2
      bloblist: Change the magic value
      bloblist: Set version to 1
      bloblist: Access record hdr_size and tag via a function
      bloblist: Drop spare value from bloblist record
      bloblist: Checksum the entire bloblist
      bloblist: Handle alignment with a void entry
      bloblist: Reduce blob-header size
      bloblist: Adjust the bloblist header
      bloblist: Add alignment to bloblist_new()
      bloblist: Update documentation and header comment

 arch/x86/dts/chromebook_coral.dts |   6 ++-
 arch/x86/lib/tables.c             |   3 +-
 common/bloblist.c                 | 205
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
 doc/develop/bloblist.rst          |   4 +-
 include/bloblist.h                | 166
+++++++++++++++++++++++++++++++++++++++++++++---------------------------------
 scripts/Makefile.lib              |  13 ++++++-
 scripts/Makefile.spl              |   2 +-
 test/bloblist.c                   | 105
+++++++++++++++++++++++++++-----------------------
 tools/binman/ftest.py             |  20 +++++++---
 tools/buildman/boards.py          |   2 +-
 tools/fdtgrep.c                   | 123
++++++++++++++++++++++++++++++++++++++--------------------

Regards,
Simon
