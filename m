Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C19C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 22:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1B4D877AF;
	Tue, 16 Apr 2024 00:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yrpy+NB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C600B881B8; Tue, 16 Apr 2024 00:21:05 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C109587BF1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 00:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56fd7df9ea9so4332120a12.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713219661; x=1713824461; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUevteMqqt29zJ7GZ02pwSIVReuAe+ex21hi6p5BtoU=;
 b=Yrpy+NB6nH/WbAFwVq1LbK51RXS1KXhGEJphnkBlMUJuCw9eeMrFIsyDvKm3DdOPoS
 P3CC1QZAKUUGBBZ8lxRmu9b7TsdVorgLEYyo1l+OHFCrTSNEsSjXpOW2Qpw1UKOsOezD
 LZCutIUYFCbeGTsv8tiNTZhN0p3kfgIt0eWCLaiKu4nHo860ksFg7tiabgAguobkXDKN
 SP+AVyr/rgmIPgqXBJer2j1ZuNrPIG/AmoRknaq5Hzzq2sw6/GKIE6XHq8YIHZ+WXYnW
 lut0tt4Tk9Re/HGksKLMtXdEBPor3nYvJ/FNB78YRMXhu2QyhjGJ/a6lLSZM2gbctnZ+
 2PuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713219661; x=1713824461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUevteMqqt29zJ7GZ02pwSIVReuAe+ex21hi6p5BtoU=;
 b=aXkldWYuyL2fkDa4HjFrs5lITLtnW43/xdryrew4FlKtCjLxIrsUMhD/kkjIXm8uJl
 cT+hJODO4A8L0X1BQn3G2qsWQXJ6XJicvEbca4jL/M/tUKFJZnw8XxODZRZIad24/wx6
 vB7w9dAQwErx+/U0p2f2ALX0/1VLtcYBxqU0vArLdQTNYGiDYdugCqyPiJVHNYkHSacQ
 5aRSnIT9IxRjLX92xwew6wUqXOC16DomFywKlrjW55gIJKTowx5FjGLPBDQcrB80sXq5
 j7x9XfLos/n3j7gAKHjIJ7BaeXAgWUwFW4wDV2rS8EEv0wY1fKWUXH48kshLytMdQ/6s
 wTmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5/h1aFHJhIE+G16BaER2qrElBCIxbuXLlLq/RrCzZvlh7uIcVEiB5Oo/ymUYgyvKBwDQBI04L5wt0haGufxTfZCB5Zw==
X-Gm-Message-State: AOJu0YwZZ2IWxE3SI6C15iqtn9JKR+Aw9HJjN5P+4VGy0vjobSKX3Bkw
 pVoEN/p9UpF9yiWeTmaR+P4oHacsN7A+rDkAiY6dfQMoWpNRtQVJ2oLayxA1H73gSLlDcX884LK
 2veKUrXyavMwj7QmO9sP8wGFNp6k=
X-Google-Smtp-Source: AGHT+IGiN1QCrof9xMinbvL70ILXPF9ttskczQ4sAiMqnh7BQsgEXRaVx4JmJLPmnuipnZihxP5NRE1s5ti2kyV4DEk=
X-Received: by 2002:a50:9e0b:0:b0:570:d50:e7d8 with SMTP id
 z11-20020a509e0b000000b005700d50e7d8mr5015355ede.22.1713219660954; Mon, 15
 Apr 2024 15:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240415163043.7482-1-kabel@kernel.org>
In-Reply-To: <20240415163043.7482-1-kabel@kernel.org>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 15 Apr 2024 15:20:49 -0700
Message-ID: <CAJaLiFwFYn912mQu9LvPF5ap8ufiQA+k0WrQCeRGSnZf39zkBg@mail.gmail.com>
Subject: Re: [PATCH u-boot-mvebu 00/10] Turris Omnia DDR training changes
To: =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
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

Hi Marek,

I'm running a regression test with this patch on another Armada 385
board (Synology DS116). And
it is running without problem.

I noticed that there is no version bump. Is this still 14.0.0? It's kind of
hard to see which version we are using without a minor revision such as 14.=
0.1.

All the best,
Tony

On Mon, Apr 15, 2024 at 9:39=E2=80=AFAM Marek Beh=C3=BAn <kabel@kernel.org>=
 wrote:
>
> Hi Stefan,
>
> this series adds some changes to DDR3 training for Armada 38x and
> Turris Omnia.
>
> - patches 1-4 are meant to allow for reducing another 10 KiB in the
>   SPL binary. They were also sent to mv-ddr-marvell, via PR on github,
>   https://github.com/MarvellEmbeddedProcessors/mv-ddr-marvell/pull/45/
>   but I am told that Armada team has left Marvell, so who knows if this
>   will ever be merged there
> - patch 5 enables this reduction for Turris Omnia
> - patches 6-8 import old DDR3 training code and make some changes so
>   that it works with U-Boot. The reason why this is being done is
>   explained in patch 6
> - patch 9 glues the old DDR3 training code to current U-Boot
> - patch 10 allows for dynamic selection of old DDR3 training code on
>   Turris Omnia, via an U-Boot environment variable
>
> Marek
>
> Marek Beh=C3=BAn (10):
>   ddr: marvell: a38x: debug: return from ddr3_tip_print_log() early if
>     we won't print anything
>   ddr: marvell: a38x: debug: Remove unused variables
>   ddr: marvell: a38x: debug: Define DDR_VIEWER_TOOL variables only if
>     needed, and make them static
>   ddr: marvell: a38x: debug: Allow compiling with immutable debug
>     settings to reduce binary size
>   arm: mvebu: turris_omnia: Enable immutable debug settings in DDR3
>     training by default
>   ddr: marvell: a38x: Import old DDR training code from 2017 version of
>     U-Boot
>   ddr: marvell: a38x: old: Fix some compiler warning of the old code
>   ddr: marvell: a38x: old: Backport immutable debug settings
>   arm: mvebu: a38x: Add optional support for using old DDR3 training
>     code
>   arm: mvebu: turris_omnia: Support old DDR3 training, selectable via
>     env var
>
>  arch/arm/mach-mvebu/Kconfig                   |   15 +
>  arch/arm/mach-mvebu/include/mach/cpu.h        |    1 +
>  arch/arm/mach-mvebu/spl.c                     |   37 +-
>  board/CZ.NIC/turris_omnia/Makefile            |    1 +
>  board/CZ.NIC/turris_omnia/old_ddr3_training.c |   79 +
>  board/CZ.NIC/turris_omnia/turris_omnia.c      |    2 +-
>  configs/turris_omnia_defconfig                |    1 +
>  drivers/ddr/marvell/a38x/Makefile             |    2 +
>  drivers/ddr/marvell/a38x/ddr3_debug.c         |   30 +-
>  drivers/ddr/marvell/a38x/ddr3_init.c          |    3 +-
>  drivers/ddr/marvell/a38x/ddr3_init.h          |   43 +-
>  drivers/ddr/marvell/a38x/old/Makefile         |   29 +
>  drivers/ddr/marvell/a38x/old/ddr3_a38x.c      |  738 +++++
>  drivers/ddr/marvell/a38x/old/ddr3_a38x.h      |   93 +
>  .../marvell/a38x/old/ddr3_a38x_mc_static.h    |  226 ++
>  .../ddr/marvell/a38x/old/ddr3_a38x_topology.h |   22 +
>  .../ddr/marvell/a38x/old/ddr3_a38x_training.c |   40 +
>  drivers/ddr/marvell/a38x/old/ddr3_debug.c     | 1545 ++++++++++
>  .../marvell/a38x/old/ddr3_hws_hw_training.c   |  148 +
>  .../marvell/a38x/old/ddr3_hws_hw_training.h   |   49 +
>  .../a38x/old/ddr3_hws_hw_training_def.h       |  464 +++
>  .../marvell/a38x/old/ddr3_hws_sil_training.h  |   17 +
>  drivers/ddr/marvell/a38x/old/ddr3_init.c      |  770 +++++
>  drivers/ddr/marvell/a38x/old/ddr3_init.h      |  405 +++
>  .../ddr/marvell/a38x/old/ddr3_logging_def.h   |  101 +
>  .../marvell/a38x/old/ddr3_patterns_64bit.h    |  924 ++++++
>  .../ddr/marvell/a38x/old/ddr3_topology_def.h  |   76 +
>  drivers/ddr/marvell/a38x/old/ddr3_training.c  | 2651 +++++++++++++++++
>  .../ddr/marvell/a38x/old/ddr3_training_bist.c |  289 ++
>  .../a38x/old/ddr3_training_centralization.c   |  712 +++++
>  .../ddr/marvell/a38x/old/ddr3_training_db.c   |  652 ++++
>  .../marvell/a38x/old/ddr3_training_hw_algo.c  |  686 +++++
>  .../marvell/a38x/old/ddr3_training_hw_algo.h  |   14 +
>  .../ddr/marvell/a38x/old/ddr3_training_ip.h   |  178 ++
>  .../marvell/a38x/old/ddr3_training_ip_bist.h  |   54 +
>  .../old/ddr3_training_ip_centralization.h     |   15 +
>  .../marvell/a38x/old/ddr3_training_ip_db.h    |   34 +
>  .../marvell/a38x/old/ddr3_training_ip_def.h   |  173 ++
>  .../a38x/old/ddr3_training_ip_engine.c        | 1355 +++++++++
>  .../a38x/old/ddr3_training_ip_engine.h        |   85 +
>  .../marvell/a38x/old/ddr3_training_ip_flow.h  |  349 +++
>  .../marvell/a38x/old/ddr3_training_ip_pbs.h   |   41 +
>  .../a38x/old/ddr3_training_ip_prv_if.h        |  107 +
>  .../a38x/old/ddr3_training_ip_static.h        |   31 +
>  .../marvell/a38x/old/ddr3_training_leveling.c | 1837 ++++++++++++
>  .../marvell/a38x/old/ddr3_training_leveling.h |   17 +
>  .../ddr/marvell/a38x/old/ddr3_training_pbs.c  |  995 +++++++
>  .../marvell/a38x/old/ddr3_training_static.c   |  538 ++++
>  .../ddr/marvell/a38x/old/ddr_topology_def.h   |  121 +
>  .../ddr/marvell/a38x/old/ddr_training_ip_db.h |   16 +
>  .../marvell/a38x/old/glue_symbol_renames.h    |  247 ++
>  drivers/ddr/marvell/a38x/old/silicon_if.h     |   17 +
>  drivers/ddr/marvell/a38x/old/xor.h            |   92 +
>  53 files changed, 17138 insertions(+), 29 deletions(-)
>  create mode 100644 board/CZ.NIC/turris_omnia/old_ddr3_training.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/Makefile
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x_mc_static.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x_topology.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x_training.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_debug.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_hw_training.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_hw_training.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_hw_training_def=
.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_sil_training.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_init.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_init.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_logging_def.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_patterns_64bit.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_topology_def.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_bist.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_centraliza=
tion.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_db.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_hw_algo.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_hw_algo.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_bist.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_central=
ization.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_db.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_def.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.=
c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.=
h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_flow.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_pbs.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_prv_if.=
h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_static.=
h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_leveling.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_leveling.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_pbs.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_static.c
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr_topology_def.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/ddr_training_ip_db.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/glue_symbol_renames.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/silicon_if.h
>  create mode 100644 drivers/ddr/marvell/a38x/old/xor.h
>
> --
> 2.43.2
>
