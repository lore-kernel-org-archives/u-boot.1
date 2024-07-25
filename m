Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3FFC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 14:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C68588381;
	Thu, 25 Jul 2024 16:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L14fFjM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A8A4881BA; Thu, 25 Jul 2024 16:03:03 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B85B86E35
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2cb4b7fef4aso721529a91.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721916179; x=1722520979; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V2XTKtxWZ1Z+txRnlBslGd8MTTcPBdU8Ghzlq+T0W8c=;
 b=L14fFjM9dGn9xx3GO1WlOCkuOJvkTLA8A2F2FvV230oQo5rjbyRGfAnxRPYBAj1TxI
 fTYz2kLNM4q0GeUj6i03/CMgN+Zw/jdxlCbtBe/cyev2bFDRgheS/c45zK+KADU/5zBn
 b7vzm8Li2CYgttaib3ze3Fu/iQL2AClZ4uqwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721916179; x=1722520979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V2XTKtxWZ1Z+txRnlBslGd8MTTcPBdU8Ghzlq+T0W8c=;
 b=iryufaxmB9B+6q0j8S60xV7bEN+/TCdwQ8+Qx1BLQb2VuOvx6hXzlb9jVlQaCg7Bbs
 2wjl7qAMlQLxI43nx58P7wfR6Ho6JD+HEysyN9jZ5+IgwvlsMfZgM1cLw+DFSX5N3IBd
 1cEwSXtoftqP13meIwCdj4nkrcn+u2XUhN/rZZfO9k7U6EzO+SyjEaN8wN1hX/y5eGmA
 B8tlMpz7awgT8imeYe94GaefRwR5G4yavCXECA3UTpjgc5doXvSiteSkflB6PtXJdCm1
 c2S2oloYRmoSFsa0eacH6QtTqItkJgV7F4Q2EGhiIIrfjUV+3w+aGMOXgDiU+83sPvMp
 0BBg==
X-Gm-Message-State: AOJu0Yw9/yVQzgChfs+eTYQDdsF0L5YXLnuRra2JqIunUAP2CBf5DXYZ
 aOvjEAgWM6yQj2ONmPdbGd9qsG2MxGiJx+FO/EPnF1R9sSZ1Wu3zcff8mE6GWnZ9C4/WWnEfop3
 4IAjmgOO5v5edEafrpR6ov0D/tqNx+d6ot94QtV2taqsgiG0=
X-Google-Smtp-Source: AGHT+IGKw729pd+jiRr7fEMyu9mpINqGga696WO3Dkxc/bI4QCthiW7PMS0/R5YRNmKwkW0eVQn5prD2MfvWjEpPKE8=
X-Received: by 2002:a17:90b:3b89:b0:2cd:40ef:4764 with SMTP id
 98e67ed59e1d1-2cf2ea0be00mr2448074a91.17.1721916179644; Thu, 25 Jul 2024
 07:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240725095331.14245-1-Zhiqiang.Hou@nxp.com>
 <20240725095331.14245-8-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240725095331.14245-8-Zhiqiang.Hou@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 08:02:45 -0600
Message-ID: <CAFLszTjDWn=1D+rraZ8eONq9Y0=kUSSU_G8bANg3-wpqXuEVdA@mail.gmail.com>
Subject: Re: [PATCHv2 7/9] cmd: cpu: add release subcommand
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
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

Hi Zhiqiang,

On Thu, 25 Jul 2024 at 03:32, Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Add a new subcommand 'release' to bring up a core to run baremetal
> and RTOS applications.
>
> For example on i.MX8M Plus EVK, release the LAST core to run a RTOS
> application, passing the sequence number of the CPU core to release,
> here it is 3:
>     u-boot=> cpu list
>       0: cpu@0      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
>
>       1: cpu@1      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 30C
>
>       2: cpu@2      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
>
>       3: cpu@3      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
>
>     u-boot=> load mmc 1:2 C0000000 /hello_world.bin
>     66008 bytes read in 5 ms (12.6 MiB/s)
>     u-boot=> dcache flush; icache flush
>     u-boot=> cpu release 3 C0000000
>     Released CPU core (mpidr: 0x3) to address 0xc0000000
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - No change.
>
>  cmd/cpu.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

While you are here, would you mind adding a doc/usage/cmd/cpu.rst as
that is missing.
