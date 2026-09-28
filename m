Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C870ACA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 14:45:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8074C406C4;
	Mon, 28 Sep 2026 14:45:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ZdPFY8WoIH8; Mon, 28 Sep 2026 14:45:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7C2D140778
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790606744;
	b=ifqrDN+eKdCttBzpTOxlyXp0EolY/YC0MkHV0YstIWeCZ2NLAiZXEpW42vB1Thy8impn
	 lJAow0Ky1afVey1R4z/Z5ttnxCjfgGVg2LwiEq4GbdkYyBmTP2N6sKF8oD1kST9/7y7Eq
	 RgH2DYmIuy1S9RV7Xoz7/PP0fez/TxZdfdyJb5HUHR6FERnNByGoaX0EbtPBNCd5QOBjZ
	 De/IpbSZBnoKv6PMl2pMk7Wqu9uYEJNn5WGK5cK1SmQfXLbatDj4A4+QDlV+3EQfpLKWq
	 UZZzUHG3AC9Y5ZkDwCVS1gu0Vs1XapOo3xM0I4LXYAb/uZfgptdcCD9GmylW1HXal2Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790606744;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1c4oIWLoMAgykxBuHLbnWbA28gkAQuqnRpgn6Y71zZU=;
	b=MmKkn6nymyd4mamO5H0jQy7TQWVVeHX6bWhwB3jtSsXCO8UnXceQtdBAe5Xyhmkrr6pn
	 QabdS5Y+j1oJAmMRhvp1q7g7eL0T8LrQj1wbBQaE68NJ3D0uJ9a0GLR/0ZaVIGcjCKbHH
	 fU2rqkxKroc2P2myyyRi+8ZynNCaXGocO8GgwdvQlhUrqpPRtK4SWYKnesOkf6qZsKtWE
	 dT4W9bGb9Xe+dF8vha51NNAzPN/j3UbQNATZlTpoqBZahAVQH0g2PE6vZ7aVxf61b7cnl
	 k72LMRm48hOKwQlRy+W8I5KLLgkuSecVXe2e+o3tPTUBLputP4nmMx2L75D6VdPpDsQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aatItHg1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790606744;
	bh=1c4oIWLoMAgykxBuHLbnWbA28gkAQuqnRpgn6Y71zZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rL8udHTZ/WN+7Ox5aMvxFKECzitXIrXo4HRLlJqvMiQurGELosRjzpJFlStSeG2Jy
	 PcVP0wzYNJ5G5xQtNIyjH+uXONo9FJZLRrkLjiWO/BgdGzLPTa4tk5mMIAYqFVFuW3
	 tPkcJV0wy8W54GO+vR0hWD24VM6i9V+Pq2GKkJCiZGI8JGqXGifZrSTnl4hcQ9CsKT
	 tHWQbVAlmdPRuFvV7/+eAr2fplKzvZDZ6BF7xcNeewZRZM6v5dJFd4aKPYhcNenSu8
	 aucuFvkRgG/CusGXdE6zRElD2nHz2MYj0mwTiOlbQuM/9hr7jTvp/JKHqN4RItiMpy
	 7XQoaX5r6tK1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C2D140778;
	Mon, 28 Sep 2026 14:45:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 38F423D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 295474076E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:45:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P2LOVc8NYjrq for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 14:45:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4E68340791
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790606740;
 b=mSVf25z/ze0utFcqFHH1vOhVphRX+AM7mXUsS8oAR5DQFqxraan3X2MZaFzoEtHFipsx
 FmAWLm6AnI92q4nyFF4zDWoygHGwcvq3as5Pl1iWWq3Vfx30kA0OsPmS26cPuaDCuE4H7
 3W5BKYVFgQ7EgXSCg/a6xmQpNh1rNGIo2Bz/W9Xn+IJKTbK2Hbb4ZrgmwQrI2mIjaupIv
 bSV/rK6RVOAIYpRzQPZSNoyN9o2p0H2yHnF8CBIRwVEYEROyQYqHvdRi+Ad/EgulgZIPS
 PPXI/9yjiYjFl24iaNSSQVovFcBm4+lP/5+apv37z1of864qLtreslDni/YflLHE1rQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790606740;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=1c4oIWLoMAgykxBuHLbnWbA28gkAQuqnRpgn6Y71zZU=;
 b=Lc9eFLWMwElhGKRVRwc50xiU5vdcVn9Vpc6GxkGDQiqGFVKu3YAdGOuRP+xaUahY6SOx
 EDP4ZRbG/ryDdGkbvWgrvLfS8f67TVFxVQ/RIhJbSOb6IFPiHF/oJCfh5S/0l/oaLJyxk
 VM9BkZmatXvsD0lBa15szfBTH1lNXplB91OT2k1WgE+SDoVA+Qpgv1ir9fzPmBBErFHn9
 1abduNV2F34pivHUhxdToQemmf35wWcyi+Cmnd01RXHYWy6/V5R8BGH5HS7P6yQhjns3t
 BtVWGmJArtA3/w17AeZjWkukxWqkDIFTF0ZXpIatkbWrvrGBLTAtnbOnY96/nb6iSlw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=aatItHg1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=aatItHg1
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E68340791
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:45:39 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaf688ebb0so3380064a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790606738; cv=none;
 d=google.com; s=arc-20260327;
 b=hSN4G8LTfiHbVdPa11SGwhZ2hYO+Hafgf3LNVOt9V8WF74WnMV4GwCotSHDxs+hfzf
 tAU0x3Ll08MdccjC/Q8xitzykLrkPIflxC0bC5Ogq08OWYae0ZwaSWomZ86LZlrTHFKV
 lOrz8fqScCLBaIM0iieqa+B7kfodZ0f2KAXzyNJ4/X7ghjYMSwJYaGuK86cfUV99FWip
 1y8ou+Dn6n6N28RWWxyPCqv2HTrrHf0zJeSYG375g66hDoKjx6AlvonbNtpFu8AnUbQY
 NsV8jHTHsIyfUjn6m5sPttIEeWWX2bYRd2l9aEP3q+GDz3vx7TCchImmgFOCjJVElhvB
 thGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1c4oIWLoMAgykxBuHLbnWbA28gkAQuqnRpgn6Y71zZU=;
 fh=n94gqMD2x+7TgDIH1CNL35bB22JMtSSTK+ktd2+TqfQ=;
 b=fb8sXEwbBQsEocnhMIdoN4zKFWz4A3zuyQMuyamFA14LhRop+TL1TIUur+LhzJlOFt
 c7ib+WgepIg14Nmnmrl3s21Q+URMfjPfEcG0zZFsiPXXTOk7UDaQHCzKQou4PFqD1sdo
 GRykvqCcSpvIgjphwWqnuyv0pV58OwWSTWbyAQjsAeh5Vg25vlsc9uEVYLZh/pPf/MXK
 T5+UXsrXrutXNBu9gCT76UCQug2yhEn7Z2Hst1tLDkGUKCBAHDzU552dulvZSdMLSa1L
 RR1AhZ1swj+Yy7OCtofc7GVMntAbz8YeGSEO+CSdpgMqrc/frquDAbah1DqjVpSzg4a5
 zpIw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790606738; x=1791211538;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1c4oIWLoMAgykxBuHLbnWbA28gkAQuqnRpgn6Y71zZU=;
 b=aatItHg1olQ5miKKcGIFTNf7QkPwfgy8e4nvWhPPwLwz/qWIs3HDLvPlXVlIrkUq1p
 /WyDqoNXc1rdqdptwnEcOofQR+l4r6l2P64eTRrg8mUe+ApaPIWiicTkoEK5ZtOgN+Aw
 wIzBjmZ/FClvRyZXEix6A5qD3/qeK4UTamVIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790606738; x=1791211538;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1c4oIWLoMAgykxBuHLbnWbA28gkAQuqnRpgn6Y71zZU=;
 b=MRPJzC0MuHrBTM4Mw+gZ9xsaOPqXAolUjpldFBkerQvUL+eH55OEVAqKL3/vW8VRrj
 cdUqkEZYOhBqhZmr2uv5rbIsEVdfo4zDP8DDaqF0U+GrteLH6WZfYUNy0PekyKm9oZNx
 CbWV9ZdWb3oKYrTinuQ3nz/4nGFRb2thby84TSyz8J1uMyuEqI0Hoijm8/FoeAlMiElS
 2sddcGMzpOGrHtmBCgnl5mKbSUUFNMRr8T7gEnMNJxF6jrtE718ARTsOrWEfQ53Ts60V
 z//BmxB4MYzl0xCp4pYEtbm0iVMvOpHSBryROVVYwA7i+GKE7Z6apXNnSCEF7mTysHV2
 o+LQ==
X-Gm-Message-State: AFq9FYIIhJjuiYcLX6sjEl+aGfKzNgRUuMCRRYnyTPgETdDQUU8yWar2
 qrL5w4f9Rg6nFb/BxyZfzPzFCqd9zwaTXfukPdSuiONXv/T3SlvQodZeSfjSfM5Zyp72jy08fRV
 D/KZaL5T5OHwJmkYjdnyImalGFT+60Xi2bgvhyzT3
X-Gm-Gg: AYBFou3vyGJJgwNjWuFaGZrJ2rr6gu6076K2F3tx5gok+0St+NRfAoSySzXCnSk3oA3
 eoglDMzvKyCunAyCVPxu+DJBDHq1EPzxl9NvpSGf9xHKkAutqV08FxJq4oMZxXlr0L3yjCS3SjZ
 Y/GVCCiNznc7ndWmGzhCqSutcGMR9GQGxWBs38nWY0ShZ8z0QoHJ2nhUC7VO9rZkMNNexwAHClR
 wVVaimZ8x3EXTgWKYPs1QGdy6ji+nOmsT28LYSsRqQL3gxqcugHwrM/hLXSJ1aRDCLLa6A7LeXe
 YOk8ckAZ7KvJWsXe4PABJno+cLuUouRkpwZ7o4NXNNLs+q7OMmsIWg==
X-Received: by 2002:a05:6402:3885:b0:6ac:70ce:baf with SMTP id
 4fb4d7f45d1cf-6ac70ce0f4amr2974693a12.26.1790606737750; Mon, 28 Sep 2026
 07:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260922060941.534035-1-hs@nabladev.com>
 <20260922060941.534035-4-hs@nabladev.com>
In-Reply-To: <20260922060941.534035-4-hs@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 08:45:16 -0600
X-Gm-Features: AclHuK82lItrnES2wX--upS7r6yGrrlv-j3BySUpPJlhYXw7NphipX5hN3_hQqE
Message-ID: <CAFLszTi6JG=Xf8Q5Sz9hwrMr+nK6jbkwP4n02GHOVnUfs0mN4g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] test: dm: add a test for the Microchip 23LCV1024
 SPI SRAM
To: hs@nabladev.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Vignesh R <vigneshr@ti.com>, 
 Simon Glass <sjg@chromium.org>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Anshul Dalal <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, 
 Tom Rini <trini@konsulko.com>, Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Heiko,

On 2026-09-22T06:09:29, Heiko Schocher <hs@nabladev.com> wrote:
> test: dm: add a test for the Microchip 23LCV1024 SPI SRAM
>
> Emulate the device on a second sandbox SPI bus and exercise the driver
> through the spi_flash uclass.
>
> The emulation implements byte, page and sequential operation and
> advances the internal address counter the way the data sheet describes
> for each of them. A transfer running past the 32 byte page of the
> device therefore only comes back unharmed once the driver has selected
> sequential operation, which is what its probe is for. The test asserts
> that mode directly as well, so a failure says which of the two went
> wrong.
>
> The erase is checked on both counts that matter for a device that has
> nothing to erase: that the area reads back as 0xff afterwards, and that
> the fill stops at the end of the range it was given rather than running
> into the data next to it.
>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>
> arch/sandbox/dts/test.dts         |  14 +++
>  arch/sandbox/include/asm/test.h   |   8 ++
>  configs/sandbox_defconfig         |   1 +
>  drivers/mtd/spi/Kconfig           |   9 ++
>  drivers/mtd/spi/Makefile          |   1 +
>  drivers/mtd/spi/spi_ram_sandbox.c | 189 ++++++++++++++++++++++++++++++++++++++
>  drivers/spi/Kconfig               |   2 +-
>  test/dm/Makefile                  |   1 +
>  test/dm/spi_ram.c                 |  96 +++++++++++++++++++
>  9 files changed, 320 insertions(+), 1 deletion(-)

> diff --git a/test/dm/spi_ram.c b/test/dm/spi_ram.c
> @@ -0,0 +1,96 @@
> +     /* Now erase the data itself, over more than one staging step */
> +     ut_assertok(spi_flash_erase_dm(dev, SPI_RAM_OFFSET, SPI_RAM_LEN));

The comment does not match the code: SPI_RAM_LEN is 100 and
SPI_RAM_ERASE_STEP in patch 1 is SZ_1K, so spi_ram_erase() runs a
single iteration here. If the intent is to cover the staging loop,
please raise the length past SZ_1K (or drop the staging step for the
test); otherwise reword the comment.

> diff --git a/test/dm/spi_ram.c b/test/dm/spi_ram.c
> @@ -0,0 +1,96 @@
> +     bus = dev_get_parent(dev);
> +     emul = state->spi[dev_seq(bus)][SPI_RAM_CS].emul;
> +     ut_assertnonnull(emul);
> +     ut_assert(sandbox_spi_ram_is_sequential(emul));

Please use sandbox_spi_get_emul() here rather than reaching into
state->spi[][] directly - it already knows how to locate the emulator
for a given slave.

> diff --git a/test/dm/spi_ram.c b/test/dm/spi_ram.c
> @@ -0,0 +1,96 @@
> +     /*
> +      * Since we are about to destroy all devices, we must tell sandbox
> +      * to forget the emulation device
> +      */
> +     sandbox_sf_unbind_emul(state, dev_seq(bus), SPI_RAM_CS);

The name sandbox_sf_unbind_emul() reads as SPI-NOR specific, but after
patch 2 it is used for any SPI slave's emulator. Please rename it
(e.g. sandbox_spi_unbind_emul()) in patch 2 and update the callers, so
this new test does not entrench the misleading name.

> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> @@ -1672,6 +1672,20 @@
> +     spi@1 {
> +             #address-cells = <1>;
> +             #size-cells = <0>;
> +             reg = <1 1>;
> +             compatible = "sandbox,spi";

Please add a spi1 entry to the aliases block above, so dev_seq(bus) is
deterministic rather than depending on probe order - the test relies
on it to look up the emul.

Regards,
Simon
