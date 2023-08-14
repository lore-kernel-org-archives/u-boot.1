Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC3EC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5A76865B0;
	Tue, 15 Aug 2023 00:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VxvzSvKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E7686986; Tue, 15 Aug 2023 00:48:47 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA1F855CE
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d4364cf8be3so4942254276.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692053320; x=1692658120;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LDf9S7cAsNcSjP8x7dRG9QMNFknq+l8GcI3laqyiFZE=;
 b=VxvzSvKHP3g5+1Dr6AMfbcH06ejPzKI/+jy6siUi6OH38A1JbuizYMEzL6OtRcAmz7
 sElceWovac4TAoTcm0aqKZYsnGg75dmVzm9/gkm0vx5pzStq3e7UlU0EPOHnNkg0GBTa
 ZbAE9uN+vDIii07HjqBPrsNe9QN4DSCgNN9Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692053320; x=1692658120;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LDf9S7cAsNcSjP8x7dRG9QMNFknq+l8GcI3laqyiFZE=;
 b=dIT+f2kAA19tnnqu7DNg4MppVCxpMwH7yeT49EosdcspUIkTioTMxOF1NZzKrf/dfn
 884ftrZnS2LzD+51drCg7tdkz4Cvi36AN/+9jp4++/cuTNO/85IecSfTCm5Dkedzdtrx
 NGlS44cL8DqsTULK5r8OHgBCaUN75zZE0jxIwlZ88pwR6sEp7Sleli2ziThRnqqCsIYI
 MFZfL8EHLc0kA+O/y3PUdh6CTnLTmuPExlW4A7GDvnZLZl4ulKHL3NEvIeCsGwIb4Q96
 GsUWKxgUMrK/Bvre6qfEDMZJmcSibQ6B+NPn48LRmj5nb+NNhqotJaKmHfQeAaYZadOn
 FuFg==
X-Gm-Message-State: AOJu0Yy1b7LA+JNWXclBJI/o00QMl65sE1CgbCERC4CCNhYeLZEG25sL
 U5XYBtvkenJOgUwvehx+IKqqHrCyVOZIusyv/BtPLRxi/yd734wXTIHD8g==
X-Google-Smtp-Source: AGHT+IHFToNj7q2ZlPes82MbDiCwPMCeTP53B/Jso6TM2X2XeGycZb5pFXX5QSE1vlp+pncEL0JtrVgAhwJ0Z4gq7dE=
X-Received: by 2002:a25:9191:0:b0:d47:30a5:2f01 with SMTP id
 w17-20020a259191000000b00d4730a52f01mr12496301ybl.13.1692053320223; Mon, 14
 Aug 2023 15:48:40 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Aug 2023 16:48:28 -0600
Message-ID: <CAPnjgZ0F3-9T5pTjSakw26XXeaquhBkZRqeSifjFfcsM51HVUA@mail.gmail.com>
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


The following changes since commit 321d7b4d875a77552a969dd6ea5bbed2644fcb0c:

  Merge branch '2023-08-09-misc-cleanups' into next (2023-08-09 13:15:51 -0400)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-next-14aug23

for you to fetch changes up to daffb0be2c839f3abe431cd68c772fae0e7e49ca:

  bootstd: cros: Add ARM support (2023-08-11 07:33:40 -0600)

----------------------------------------------------------------
Enhance bootmeth_cros

----------------------------------------------------------------
Simon Glass (16):
      bootstd: cros: Correct reporting of I/O errors
      bootstd: cros: Move partition reading into a function
      bootstd: cros: Bring in some ChromiumOS structures
      bootstd: cros: Support a kernel on either partition
      bootstd: cros: Decode some kernel preamble fields
      bootstd: cros: Simplify setup and cmdline expressions
      bootstd: Move common zimage functions to bootm.h
      bootstd: cros: Add docs for the kernel layout
      bootstd: cros: Add private info for ChromiumOS
      bootstd: Add private bootmeth data to the bootflow
      bootstd: cros: Add a function to read info from partition
      bootstd: cros: Add a function to read a kernel
      bootstd: cros: Split up reading info and kernel
      bootstd: Allow display of the x86 setup information
      bootstd: Add a command to read all files for a bootflow
      bootstd: cros: Add ARM support

 arch/x86/include/asm/zimage.h |  37 -----
 arch/x86/lib/zimage.c         |   8 +-
 boot/Kconfig                  |   4 +-
 boot/bootflow.c               |  17 ++
 boot/bootm.c                  |  37 +++++
 boot/bootmeth-uclass.c        |  12 ++
 boot/bootmeth_cros.c          | 367 +++++++++++++++++++++++++++++++++++-------
 boot/bootmeth_cros.h          | 197 +++++++++++++++++++++++
 cmd/bootflow.c                |  47 +++++-
 doc/usage/cmd/bootflow.rst    | 139 +++++++++++++++-
 include/bootflow.h            |  15 +-
 include/bootm.h               |  47 ++++++
 include/bootmeth.h            |  25 ++-
 13 files changed, 845 insertions(+), 107 deletions(-)
 create mode 100644 boot/bootmeth_cros.h

Regards,
Simon
