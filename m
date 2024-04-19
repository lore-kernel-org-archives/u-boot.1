Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C040C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 09:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E4088526;
	Fri, 19 Apr 2024 11:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nVns016n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A54688074; Fri, 19 Apr 2024 11:49:04 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C88AB88526
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 11:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d9fe2b37acso23732341fa.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713520140; x=1714124940;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kWClStVGBfhQnsG4cJoA5H5O/1uobKhSuQbj8j8hALQ=;
 b=nVns016nhXHxz6F+USTQvhAc7s3RtIFtenR6sf/t/BeHDzJcKgjwOn6ADuYcAnzz9j
 o0tovhbk6J3ODc6P22uKVLtR9udQdG7RugQzBg4eODV+34QvJx1ME6SigwYLr0XxlRmJ
 U6kxpjxPB3BIPnLhPt/QWOcU2ZFyi/lkENIR2NxdEOKou8if4SuSWWuI2oTi6jhn4JqC
 owNY0CqpJQMwRxF+DFuwcG8qlMOKw79diZhT7xMh3XGAtyS125NuqJcP5Cmy2ml2+5uF
 xRdtG7db8Mfv0n916X8AvfwPcfaippQsvKEfLgBVyrZPZ4n6CbrgYgI04+CHxXUp0Klw
 /fAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713520140; x=1714124940;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kWClStVGBfhQnsG4cJoA5H5O/1uobKhSuQbj8j8hALQ=;
 b=uM4AoBbg3ikpU0skVqg4e9ODyT/auWCAcY/U+HTkj0+CueLj+kFTHAfKhU9PSywBxE
 2XIgLbZann08PGy+2XY8QfKFVWnUgteUYQjO40hiZ5Zo9pLzcq3RDFhnPgTQ2Ucp913S
 eOMrocudWhNPZtFtrf70/Hwt7n+5PkNNFD8jd3tnWwWiOm+lXyZml4n8cIwYJJMZF+d4
 YUti6uawEYWuIWtdgYTLCQb8OuNbZbi+cFMzIVc9naR0R37neeECiA2PHMBw6Uegb9Z+
 PTy48OXXlQQ7k0iIbTzmROfFyLyTLE1ZIu1IQ4U8yWiRo2UXqpPLDh1xFCi4MMePOLPj
 RgqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn7+/WO263bxGUZeksQ5+ymsvFWRNSRuUlq1PhGkfEl373+Ue24/mRlKDXM1UZ1SqIlHRPdQ9HrEwxqHOioxr8NVdGRg==
X-Gm-Message-State: AOJu0YzQpJ/LkIS+L1ILeNTtJq84Trjw/NARtEhJ9ot9F4uOXFpihNke
 em6yqAf6f00qJ7YVvev4YRJ8+MzWrGVDINzQU4W+B5YNN0qGeJqmQlIOopDx11A=
X-Google-Smtp-Source: AGHT+IGQf19F0/RoMWa81IRpTZr82LocMTSAOcWmpMCqZdseVUziKG6vy/JznYTHdyETCM+Qwa+wOQ==
X-Received: by 2002:a2e:9801:0:b0:2da:e7f7:7315 with SMTP id
 a1-20020a2e9801000000b002dae7f77315mr948171ljj.45.1713520139843; 
 Fri, 19 Apr 2024 02:48:59 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05600c444b00b00418d5b16f85sm5836832wmn.21.2024.04.19.02.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 02:48:59 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, Alexey Romanov
 <avromanov@salutedevices.com>, u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-dfu-20240419
Date: Fri, 19 Apr 2024 11:48:58 +0200
Message-ID: <874jbx4r91.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Here is a new development for master:

- new "fastboot oem board" command

This CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/20427

Thanks,
Mattijs

The following changes since commit 2c3fa4b8add3cb6a440184ab67debc6867d383c0:

  sandbox: don't call os_close with invalid file descriptor (2024-04-17 17:06:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240419

for you to fetch changes up to b2acf59baf917c3b4002c1b2094ddb46c03ab02e:

  fastboot: introduce 'oem board' subcommand (2024-04-18 14:54:38 +0200)

----------------------------------------------------------------
u-boot-dfu-20240419

- new "fastboot oem board" command

----------------------------------------------------------------
Alexey Romanov (1):
      fastboot: introduce 'oem board' subcommand

 doc/android/fastboot.rst      | 18 ++++++++++++++++++
 drivers/fastboot/Kconfig      |  7 +++++++
 drivers/fastboot/fb_command.c | 30 ++++++++++++++++++++++++++++++
 include/fastboot.h            |  1 +
 4 files changed, 56 insertions(+)

