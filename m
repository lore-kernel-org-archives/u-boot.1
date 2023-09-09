Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E052EEB57C
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 10:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3D4864E6;
	Sat,  9 Sep 2023 12:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uUCi/1hr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 587768650E; Sat,  9 Sep 2023 12:13:54 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EA5F8620C
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 12:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50079d148aeso4797403e87.3
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 03:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694254430; x=1694859230; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qfFZoeqoNaQvgzA4HZKekgRTDqP/EoQ1uosrqO8t+3U=;
 b=uUCi/1hrr0WlP4JCWhp5XNoaX/pHhOvEWsGZ+bo8DnMNV4yMnWWL4vZnQK4ExbD9Ry
 UIK7VhbsigG1ojUQNJC6mlFJ8NisvG21iClSX7RNWt0LDqu9eb1lcYQDc4fQeHd/aDmF
 S/L30Ys231ZTnFSiyOvKh0vX1I+rxydkf7nZ/THMW6w0Zp4Li8dkL1k9ofKREruKahhu
 +l7aOmPSVGgNVhjz/c53vasIKESvEm38SLxJH5I5by6bZlmXXlDya2f43YFXCFG8furY
 YfgkinDwhMxxQho23T68DLTL6wi3du2Kq4BnQ9TUo0rDsvcLMnH0mynjYTabcHKJFuTe
 VXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694254430; x=1694859230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qfFZoeqoNaQvgzA4HZKekgRTDqP/EoQ1uosrqO8t+3U=;
 b=TbM7sxMbHfHmJZYf1t4iTvVDzVXMUbutim8hZWICXjqufsyS1yKXtgjgoUBsVHhMxs
 6WAbc6Ovlv1vjvcALrULCkXXSm0USNrmsJLSMpWRpcLs8SlvREpy5DAU6IAldqu6reun
 xi3+LEIqS1dhQzjXZpnRtz9ktMG0tb3yPdIrumZkNYKdhO51NWZLWiP7DxEZ0E24HSeV
 PH7UvuzsYawsDqwKar+PG/O+HI3ODm9HD6+JrZhpfLsHVf/LGxO6ukioIDaScB5AqypW
 cbNQk8hRFZC1kalpkYM3Klp4AfyTdQPtW1ZIjqukG3WnuquWlmhcFILXWm0f50/b4inr
 6FvQ==
X-Gm-Message-State: AOJu0YztfvNAXWKbs+EeWbO/p7t5nfQZX0ncSCXjVzAC/ggYPeF9bMjY
 gHKui5tctkcWqLLIRFS3nHMnTEGgYry/0cxDSvhVYA==
X-Google-Smtp-Source: AGHT+IFu7whFPtd5m/p8TZotqu4btat2GfG5sRqZc0AwqCn/ERqgTwTK4RyZaFHTLf3ULDb2hn35KNM7traRekGvXeo=
X-Received: by 2002:a05:6512:488a:b0:501:b97a:9f50 with SMTP id
 eq10-20020a056512488a00b00501b97a9f50mr3463178lfb.65.1694254430437; Sat, 09
 Sep 2023 03:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <a29e29a3-10f0-4ff2-9e27-3bb771ab2b8c@gmx.de>
In-Reply-To: <a29e29a3-10f0-4ff2-9e27-3bb771ab2b8c@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 9 Sep 2023 13:13:14 +0300
Message-ID: <CAC_iWjJvGH95igWgPz+EZciKxPTS07HfT5WUjVWJybi7--0VTg@mail.gmail.com>
Subject: Re: Pull request doc-2023-10-rc5
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>
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

On Sat, 9 Sept 2023 at 09:48, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Dear Tom,
>
> The following changes since commit c0c08be5468cb26db597932bc69c4eda1129841d:

Thanks for picking those up Heinrich!

Regards
/Ilias
>
>    Merge branch 'master' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-usb (2023-09-05 14:44:10
> -0400)
>
> are available in the Git repository at:
>
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2023-10-rc5
>
> for you to fetch changes up to 7314ba2bf8452df68d07f251aa59440de58067b0:
>
>    doc: board: ti: Move documentation from README to .rst (2023-09-09
> 06:12:47 +0200)
>
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17697
>
> ----------------------------------------------------------------
> Pull request doc-2023-10-rc5
>
> Documentation:
>
> * move more TI board documentation to HTML
> * update TPM usage instructions for qemu-arm
> * update the EFI app documentation
>
> Other:
>
> * tpm: Fix autostart for TPM1.2 devices
> * spl: fix undefined return value in spl_blk_load_image
>
> ----------------------------------------------------------------
> Heinrich Schuchardt (2):
>        spl: undefined return value in spl_blk_load_image
>        timer: document the unit of the timer rate
>
> Ilias Apalodimas (2):
>        tpm: Fix autostart for TPM1.2 devices
>        doc: qemu: switch swtpm instruction to 'tpm autostart'
>
> Joao Marcos Costa (1):
>        doc: Update path to source_file_format.rst
>
> Neha Malcom Francis (1):
>        doc: board: ti: Move documentation from README to .rst
>
> Simon Glass (1):
>        doc: efi: Update for the 64-bit app
>
>   board/ti/dra7xx/README             |  26 ---
>   board/ti/ks2_evm/README            | 194 ----------------
>   cmd/tpm-v1.c                       |   2 +-
>   common/spl/spl_blk_fs.c            |   2 +-
>   doc/README.ti-secure               | 226 -------------------
>   doc/SPI/README.ti_qspi_am43x_test  |  76 -------
>   doc/SPI/README.ti_qspi_dra_test    |  47 ----
>   doc/SPI/README.ti_qspi_flash       |  47 ----
>   doc/board/emulation/qemu-arm.rst   |   2 +-
>   doc/board/ti/am335x_evm.rst        | 437
> ++++++++++++++++++++++++++++---------
>   doc/board/ti/am43xx_evm.rst        | 188 ++++++++++++++++
>   doc/board/ti/dra7xx_evm.rst        | 139 ++++++++++++
>   doc/board/ti/index.rst             |   3 +
>   doc/board/ti/ks2_evm.rst           | 306 ++++++++++++++++++++++++++
>   doc/develop/uefi/u-boot_on_efi.rst |  26 +--
>   doc/usage/fit/howto.rst            |   4 +-
>   include/timer.h                    |   6 +-
>   17 files changed, 984 insertions(+), 747 deletions(-)
>   delete mode 100644 board/ti/dra7xx/README
>   delete mode 100644 board/ti/ks2_evm/README
>   delete mode 100644 doc/README.ti-secure
>   delete mode 100644 doc/SPI/README.ti_qspi_am43x_test
>   delete mode 100644 doc/SPI/README.ti_qspi_dra_test
>   delete mode 100644 doc/SPI/README.ti_qspi_flash
>   create mode 100644 doc/board/ti/am43xx_evm.rst
>   create mode 100644 doc/board/ti/dra7xx_evm.rst
>   create mode 100644 doc/board/ti/ks2_evm.rst
