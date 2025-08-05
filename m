Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AA6C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0469E8327A;
	Tue,  5 Aug 2025 10:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ym1oYnAN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2AEC8327A; Tue,  5 Aug 2025 10:33:11 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 994818324C
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-61530559887so7055623a12.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754382789; x=1754987589; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DX2kQDIRMfsmFMYaGXmDlOPcg7TbtP7QhB4uj1WumSs=;
 b=Ym1oYnANsCGSuSucQUIz0fotsq6g+zSHFckz21ziLviMGdxNSDqSPqg9XF4u/mD9gl
 WWZH9tXJEBt53dEYD1uXjmU26S/dXyzQk4//BmRCUQeHBeVUlBpIb7B3p7T57MmC4/wG
 c4j0QEWYFq8/d2Q29p/2klYMO5urEbYSTj/cSdTrxV6kXdOd2A/Vh4EtF3Ou6k/3m1iy
 1fOhno8TUq9J/WfDf/FDhkcJiPYC5N2bC6Mu+hfJSyhJOGUNFhE5q73hULoOZbPisIUd
 +CpiBV/Vf8ZDPxJcpwqUX+mg9jIJzvxF74uRMb+4p8y1tDWyrX6OTopZkL8OHZcxC3/4
 +e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754382789; x=1754987589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DX2kQDIRMfsmFMYaGXmDlOPcg7TbtP7QhB4uj1WumSs=;
 b=ptIMixOL1jDsZQqXpr1eiVtnkpn0qrSYYdzXZuzGSUYWe43pwvEz7iKTt2y3RN1zbs
 GABZyHviIUr983QkGjYEhwhmYSyL3KGL5et7c3jD5FZ4n9S57hnPuSRTqE5y86/wmYS/
 ZIDdAPUNLUg8ncDOkMYGuYMOjwMvIkQz/OzESchMSRwZY5DhemGj6MNk2//N/CXpH7Fz
 3zao6bDXMNKNhw3IU1f9RM18hcle5QyyKyf18Qeft51O3pzEGDvhTdrm+OKQeEw6zjMU
 PJ/ow383xO2ufYBxIBECqQQqluSUrdinjlgZYkTlg/AHBn+La7G6WBYHTNP8HHNkva/C
 h7YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRE7r/Dip3ssWywzumBQeRoaUbN6M752di3M6vteYs10741JYwEmFBSCHGfGYiLMnzu3r2bYQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7MD84nhPPWjCCyeSY+EAKHOkN3wVl8IaQeyzqAitjVcoMudsM
 E4wE3r2u4vl49SVp/E+OHURcNy4xw8s8aUDTGxFGdtFsHgkER8JAo0j0sXGCmbxw9S9NLhYgwF9
 E2YHTbMaZia1QiVN6HeDsjrXFAHdC1ho=
X-Gm-Gg: ASbGncvSta0o0YzPIQt1xvN9gJ03/aFqQMCbmcz5XCcKot2Ccd/OO6wgH14sJKZenkT
 C4sXSsTyWo+WXtHvm84gwYdcglsdrvejb7DXbFHLfe443F2Yssin6zqG3FtTnQ5/y2wDlPdKPTt
 L56JwZof1yadYGREohgCxL9dvGFxoHO3X7UTSLM0g+gtZrv64nSlen8+ChQzj6QePIdBlTTJN0b
 w8oH79vDjQ4b/kqOvAvoq0Fh+Rk3zSJ6wM=
X-Google-Smtp-Source: AGHT+IEP3gnv/iSyBQtyog5clSDH4XLHk6k7piegtA81hUvi34nYHbi0uquU9IV9bJCTr9ERJh80HB/V0PiU+MfWKuw=
X-Received: by 2002:a05:6402:5210:b0:615:5563:548e with SMTP id
 4fb4d7f45d1cf-615e6ead70amr10990499a12.7.1754382788858; Tue, 05 Aug 2025
 01:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 5 Aug 2025 09:32:57 +0100
X-Gm-Features: Ac12FXy_CQvjBx3ikIgTZ9Yw8RKDpeAew7SFrPXrWylOF_Dxx5hoWm_FmXgB2es
Message-ID: <CALeDE9MqfKgFURM+oMFez6qKX63Szyi5T0JHbf7toodxON6gLQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] mtd: spi-nand: driver improvements
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
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

Hi Mikhail,

Please leave some time between posting large versions of patches to
allow review.

Peter

On Tue, 5 Aug 2025 at 09:25, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This patch series makes u-boot spinand driver almost the same as spinand
> driver from linux-6.16-rc6. This provides the following improvements:
>
> * it becomes easy to port changes from linux kernel
> * more flash is supported
> * spi drivers can accelerate flash reading/writing using spi-mem dirmap API
> * continuous reading mode was supported
> * OTP support was added
> * add support of special data recovery reading (for some flashes)
> * bugfixes
> * other minor improvements
>
> The following linux kernel driver features was not implemented
>
> * support of different ECC engines
> * per operation spi bus frequency
>
> The patchset also includes fixes for continuous reading mode.
> The similar patches were sent to upstream linux kernel.
>
> Changes v2:
>  * update patch description
>  * add fixes for continuous reading mode
>
> Changes v3:
>  * fix duplication in patch description
>  * add more information about commits ported from linux kernel
>
> Mikhail Kshevetskiy (22):
>   spi-mem: sync a bit with linux-6.16-rc6
>   mtd: spinand: Use the spi-mem dirmap API
>   mtd: spinand: Add a NAND page I/O request type
>   mtd: spinand: add missing MODULE_DEVICE_TABLE()
>   mtd: spinand: simulate behavior of linux's function spinand_wait()
>   mtd: spinand: more use of spinand_to_{something} helpers
>   mtd: spinand: replace enable_ecc variable with disable_ecc and update
>     corresponding logic
>   mtd: spinand: minor refactoring
>   mtd: spinand: more refactoring
>   mtd: spinand: sync code with linux-6.10
>   mtd: spinand: set bitflip_threshold to 75% of ECC strength
>   mtd: spinand: Add support for setting plane select bits
>   mtd: spinand: Remove write_enable_op() in markbad()
>   mtd: spinand: Introduce a way to avoid raw access
>   mtd: spinand: add support of continuous reading mode
>   mtd: spinand: Add read retry support
>   mtd: spinand: add OTP support
>   mtd: spinand: Enhance the logic when picking a variant
>   mtd: spinand: sync with linux-6.16-rc6
>   mtd: spinand: fix direct mapping creation sizes.
>   mtd: spinand: try a regular dirmap if creating a dirmap for continuous
>     reading fails
>   mtd: spinand: repeat reading in regular mode if continuous reading
>     fails
>
>  drivers/mtd/nand/spi/Makefile         |   5 +-
>  drivers/mtd/nand/spi/alliancememory.c | 155 +++++
>  drivers/mtd/nand/spi/ato.c            |  84 +++
>  drivers/mtd/nand/spi/core.c           | 937 +++++++++++++++++++-------
>  drivers/mtd/nand/spi/esmt.c           | 123 +++-
>  drivers/mtd/nand/spi/foresee.c        | 107 +++
>  drivers/mtd/nand/spi/gigadevice.c     |  66 +-
>  drivers/mtd/nand/spi/macronix.c       | 289 ++++++--
>  drivers/mtd/nand/spi/micron.c         | 180 ++++-
>  drivers/mtd/nand/spi/otp.c            | 369 ++++++++++
>  drivers/mtd/nand/spi/paragon.c        |  20 +-
>  drivers/mtd/nand/spi/skyhigh.c        | 149 ++++
>  drivers/mtd/nand/spi/toshiba.c        |  63 +-
>  drivers/mtd/nand/spi/winbond.c        | 228 ++++++-
>  drivers/mtd/nand/spi/xtx.c            |  20 +-
>  drivers/spi/spi-mem.c                 |  45 +-
>  include/linux/mtd/nand.h              | 157 ++++-
>  include/linux/mtd/spinand.h           | 342 +++++++++-
>  include/spi-mem.h                     |  93 ++-
>  19 files changed, 2936 insertions(+), 496 deletions(-)
>  create mode 100644 drivers/mtd/nand/spi/alliancememory.c
>  create mode 100644 drivers/mtd/nand/spi/ato.c
>  create mode 100644 drivers/mtd/nand/spi/foresee.c
>  create mode 100644 drivers/mtd/nand/spi/otp.c
>  create mode 100644 drivers/mtd/nand/spi/skyhigh.c
>
> --
> 2.47.2
>
