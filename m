Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D10C3DA64
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 19:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEAE888744;
	Sun, 28 Jul 2024 21:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E8k5GYV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8949E88744; Sun, 28 Jul 2024 21:36:15 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B19287B1A
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 21:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b79fc76d03so15035116d6.1
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722195372; x=1722800172; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OLX2CBHmIt/0WJlvEE20be7SIphgv1Hxmzeqmuws8EA=;
 b=E8k5GYV4PqqdkRVSr91FZ7G4fs1KSFSmdE4O0jBD/JAEerpwzyq4Iod3p7PLUtsddC
 Pc97BRzz3UWQyktDR8L06WrSaRVZI4Mo2POtninLMOfsENw6EdC9F+heo2vxURV7Bmi6
 vorrvj5a03x9LuE8qntfXxxxMiTsAtf1eeEWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722195372; x=1722800172;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OLX2CBHmIt/0WJlvEE20be7SIphgv1Hxmzeqmuws8EA=;
 b=WwWcApLjqZlatxNU52QGgfJ98EVtAQboJYdAqglgKAeDFoYRb8anqrmBt3GfbgfFA8
 +alOUqT3bdpCMClNxgkFF6zrGLp75/Irj5FVP3EUDtAlVtiN4V5LQJdXm/6zl3A9tu+q
 qTQkoG6Fl2wZryPi3+GU4vQMJ/pQqLl0omLAaaa7JR2hR96zN0cC68YPKwxxvBHDtki9
 EcIEvpt0g2hOmhzNB8bUq9vq1Yoq9j/zesAzenxzB4q5oeYArGihSSlVtDouE1PcE5ra
 I8IW6EcxckNJyR14+ebO5jfG6o9jEdCGFYdho0o0Ymdh02wVUHI/svpVEYuvRBsPjF1T
 qKUQ==
X-Gm-Message-State: AOJu0Yzse1pLCiSn+iXT35VgF+IlNxI2h+tMIs5sL3TNcj+4VsaclSKO
 iv8kA0b0ndigS4xlQhec9kHd/R42uCAkXRzJkAb3wJaGNzHE6apyZe9eK0xrfEnFO6zFKc8W86K
 43zQJU8UN7RNLFmp5MWkqWX7mlLb3UKaFFMDL
X-Google-Smtp-Source: AGHT+IHjQMirQSQdB96x93lxxU7yUlcoyrPo4m1/5rroiV9cgFNOASKdgDBG/q+7LciGkj1VPnZOskkE8mhhoz8He7I=
X-Received: by 2002:ad4:5bc4:0:b0:6b5:ea0e:98f with SMTP id
 6a1803df08f44-6bb557d3a62mr67262116d6.0.1722195372174; Sun, 28 Jul 2024
 12:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240726175108.34704-1-Zhiqiang.Hou@nxp.com>
 <20240726175108.34704-10-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240726175108.34704-10-Zhiqiang.Hou@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 28 Jul 2024 13:36:01 -0600
Message-ID: <CAFLszTiofnEZQEYJwjhsqGx0C7poHtuczcCfkZYsqDeHFnhd_Q@mail.gmail.com>
Subject: Re: [PATCHv3 09/12] doc: cmd: add documentation for cpu command
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 festevam@gmail.com
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

+Heinrich Schuchardt for review too

Hi Zhiqiang,

On Fri, 26 Jul 2024 at 11:30, Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Add documentation for the 'cpu' command, taking NXP i.MX 8M Plus
> as a example.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V3:
>  - New patch.
>
>  doc/usage/cmd/cpu.rst | 82 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 doc/usage/cmd/cpu.rst
>

I think you have left behind the review tags I sent on the previous
version. You should pick those up for the next version ('patman
status' can do it for you).

> diff --git a/doc/usage/cmd/cpu.rst b/doc/usage/cmd/cpu.rst
> new file mode 100644
> index 00000000000..0970e57d5b5
> --- /dev/null
> +++ b/doc/usage/cmd/cpu.rst
> @@ -0,0 +1,82 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. Copyright 2024 NXP
> +
> +.. index::
> +   single: cpu (command)
> +
> +cpu command
> +===========
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    cpu list
> +    cpu detail
> +    cpu release <core ID> <addr>
> +
> +Description
> +-----------
> +
> +The *cpu* command prints information about the CPUs, and release a CPU core
> +to a given address to run applications.
> +
> +Example
> +-------

We normally put the examples at the bottom, after all subcommands have
been explained.

> +
> +cpu list
> +~~~~~~~~
> +List and print brief information of all the CPU cores On i.MX8M Plus EVK:
> +::
> +
> +    u-boot=> cpu list
> +      0: cpu@0      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
> +

Are there blank lines here? It seems like there should not be?

> +      1: cpu@1      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 30C
> +
> +      2: cpu@2      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
> +
> +      3: cpu@3      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
> +
> +cpu detail
> +~~~~~~~~~~
> +Print more details of all the CPU cores On i.MX8M Plus EVK:
> +::
> +
> +    u-boot=> cpu detail
> +      0: cpu@0      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
> +
> +            ID = 0, freq = 1.2 GHz: L1 cache, MMU
> +      1: cpu@1      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 30C
> +
> +            ID = 0, freq = 1.2 GHz: L1 cache, MMU
> +      2: cpu@2      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
> +
> +            ID = 0, freq = 1.2 GHz: L1 cache, MMU
> +      3: cpu@3      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
> +
> +            ID = 0, freq = 1.2 GHz: L1 cache, MMU
> +
> +cpu release
> +~~~~~~~~~~~
> +On i.MX8M Plus EVK, release the LAST core to run a RTOS application,
> +the <core ID> is the sequence number refer to the 'cpu list':
> +::
> +
> +     u-boot=> load mmc 1:2 C0000000 /hello_world.bin
> +     66008 bytes read in 5 ms (12.6 MiB/s)
> +     u-boot=> dcache flush; icache flush
> +     u-boot=> cpu release 3 C0000000

lower-case c

> +     Released CPU core (mpidr: 0x3) to address 0xc0000000
> +
> +Configuration
> +-------------
> +
> +The cpu command is available if CONFIG_CMD_CPU=y.
> +
> +Return code
> +-----------
> +
> +The return value $? is set to 0 (true) if the command is successful,
> +1 (false) otherwise.
> --
> 2.43.0
>

Regards,
Simon
