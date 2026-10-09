Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0EACA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 425A3813BD;
	Fri,  9 Oct 2026 07:10:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id raZFRGYaVsqF; Fri,  9 Oct 2026 07:10:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C0F7811F7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529852;
	b=MNxDC2EdGTBN+R2n1hwMK+7Xu+3fyrE8cvPOWXIKvnlLKRqe0qf1+oXbE6RRp9gHYae3
	 m3XmxfIa1H4IAmwzxhHuoYHdIcQXwoGoo13NR5Io+Ki+/EmJTQBWdiYip+B83M/2OY9Pd
	 n93rRSUpkromkKMVtkS9+jQZ/+G3IT4XknjV9PoqESYkoKtufHkIiI4i92/APQJJSFcj0
	 DUM2eUtKk5YQhyW6Xvh5Qp3qBZojRrFw1SiRPeVDzCfKGoe5EtW7xjf7Tyw7BcZSy4ASi
	 oUBDPblB4OblI+PB/zgjmNOS9m/B6GgoYHWhtjQKtgs0JihRMNJxK6aCKVFLM0mezrg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791529852;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=I5XATPpkqP3+ZUCDlb7KcQbiHBshtmgGaas/79Fcp18=;
	b=P+Fm0smiGMxvPbIrFR6HH+KN8Q8dWxKusUCCQrmm8/Ifp2GA4GSmxg0q4Xi/shY7WMUp
	 YCgZ1Ufwzu/jSUrJIcAg8X1gfVRaCDGMIe1wKmB4A/p+kcVOcc+GYhYIlsHS0Xt0LYP91
	 UPWbV0p8lspTt+6ZpILcEukENVpmzAPCg/xYX2tAfhIxgB+pz30ArwXcuJ9jXxkQymSn+
	 JXraMZIU7tJZBBFT2AvS5iIYt15pc3SCxUNagld8hUe6tE36NaWjll6hhbm2gOZyCc/kA
	 2cO0q+ldPHczKG48AHgeW07Cp8Ho/wcYHcFQFUpXGaTWYc8cLFnfP/SYILGmwvRYrew==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=K871JPjq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791529852;
	bh=I5XATPpkqP3+ZUCDlb7KcQbiHBshtmgGaas/79Fcp18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mY2osqBHOCP5c0xOeqPuc/4jgYGiDjFtHyCFUAun7FCACTAO3xlKQnuFFK6HfXtzM
	 wjFQsqgiXLyYa3op1VgrK1YhckoRDazyMeKTv7481/WXh0HIh+IvpU/48RRtmrzpOs
	 Cb5FuyCIUlNNlr3ld0s3+aN9ZX//OAPS4mVxWe1aqGEyx7rV8Se1NwRaheTB8xmZAF
	 DAvnFQU4VxJwLvGz6JZcHJkOMe7L71mMYtGpLR4jKhrCF0DSs3j3kVslj/Sr0zwKyd
	 msNI6y7bwK0Fq0jLkZTFHYo7UU6C5itVsD0+X+3qlPeMYkbqwA+Nkhbg7DdZmen0hD
	 BjV3dBSP412/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C0F7811F7;
	Fri,  9 Oct 2026 07:10:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3202175
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17BF2811F7
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:10:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id icCeenUmZ31o for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:10:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D20681089
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529850;
 b=naD0dvd8EAIyi4L8rEuIIrXhGsxUntKmyXZI+LopQlx52lQD+rVH46MMKS41SWz71FEb
 wsyPkzCMv0f8ugaBxAnUb04/y9TA5QBKfP/W336fzZzdMMGj9ach36D9dmglYKtxAjx2W
 rMJQFWD5CRmrEl/DlYutUtPDO8tbqZPBovFqeokHAlVUIZdEBF/SxiRu/lGDu+GkfJkmm
 Jmj5xcq9Suhpciv9M907nnJjelp0txV2aFfiEyARZuMqehDKljwGOvIa4nR7QHRCOyUux
 9qUkKbesv84Vn4LJUHlkrUlsfr28424JZzna0GpmRfZ6ByZUM0ph4xhh582LrGJbxaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791529850;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=I5XATPpkqP3+ZUCDlb7KcQbiHBshtmgGaas/79Fcp18=;
 b=DO/V8vh/vXplNS2cHsI42S7TtpIyJ/R2sUcMeTNUdWTJ+2Kxlw/7kGmyP8hpPL7mpDB1
 MEPzjjoQNs7t4DaJjFOV5pv9BMfZOkAY/fPp25naQxhYbIagR8suKoh87GO8kSu/a8bd0
 9XJbm6krcPaXEgKmJdKhdt2Js0eOYztIz0S1qzLD4A8KE0sQu79Y02WAJfPWMTa/vHEtf
 TvYcfHHAOc0StQVGC1l4tnmZW3eQ5TCrV5ziJVjuFgs1jayYMIM5sWDbaFAKY9u0hOtH2
 jNLpjnxsw9qUe0uotjXi76vaHx/5dAb+I6fdyqnNagX2Y3oTNzmEplGWXj8Wcuu2zqw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=K871JPjq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=K871JPjq
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D20681089
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:10:49 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6afa651700eso5898827a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 00:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791529848; cv=none;
 d=google.com; s=arc-20260327;
 b=OizpHsIicfN+ailSaF2osCVmfsdxnjmpwkFQ5owEiumfiDNqNF2Gt3kmP+opoF0mu4
 NMYOuNg9jkMk6lxPpxdZnBywCAmNxI6H/mW0S/BwMrLyKmJ0pea7KG1E4gF3ZraHWCzH
 bfJrT5H2UanNPS3a+8ZwfFdQbu+IdZ0g/Ze76t3tLAkCH13GLYvh8Ra2o3QQa14y2D7G
 QVRrjVtcwhwsZcaz0oKCNVc8dsnjM0QLECqt+IpkSe5Txz5x4eYj52YhDisuB+Tw/Xv6
 p8FatamKulWjhcvTfdT/0AqZcug+Zris9IC5dNSjZnZ6kAqXON2i3I4ELOhQit1HpUt2
 J4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=I5XATPpkqP3+ZUCDlb7KcQbiHBshtmgGaas/79Fcp18=;
 fh=Wlc/TozdG4H2T43BoFs5e7FUrwo8+lou8oyvdlctWcY=;
 b=EiwyF7aKZ6KXAsDJ/IaeMPcxEvAGW/dooAAkvaaPmWxvgZ4Qlar2iNmlUwZ4SDE/CH
 xuga3pPI/5QIyZ+myjLvz6+Y0edCIFypbKz+cio37/VXznnlK3vBL+vTcjuLC2mq955B
 25RrKXxXZe/OYutxkttnKxNdxYUl8LPSHYtS1hnlYJyJxD/zhsmyI0qM5BtW3acRq5CQ
 41aSgeKf6JM84z72DiL5gvYAbk8dSe5wX5rp6r0IAhzYPHOcfyFxDEau0qK9hdalCQZd
 gUJJYrcWJkqv3pgiDSH64pJF7+MqFLZmWjyy9JRzHwDFSTEIn0LuFkeNeA1g3DcWw2KA
 N2Ig==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791529848; x=1792134648;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I5XATPpkqP3+ZUCDlb7KcQbiHBshtmgGaas/79Fcp18=;
 b=K871JPjqd6YCY1oP/ALqeRmsFLfqQC/fkozeh53uKDh7LodaQKOrqea55CsORQOTJd
 3At2LMk5qMssacahkxZLeE7biNkjanXHU+7ob6/61fGFWKePTKcMT/R5oQrMl5fxNuW1
 vVGUtwUPEml0Q8XC6bsJsc2Q+3qvEY1JL419Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791529848; x=1792134648;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I5XATPpkqP3+ZUCDlb7KcQbiHBshtmgGaas/79Fcp18=;
 b=sZMAoJ2C10Besll4O3HUzjdSWW886s8ja+xxzLfpU6fRGKBG8PGFpOdmXQ8M0FGjff
 hnk39C4JHCENvnXgqs+/xcB2ouxO8aPWIT4ODRUFO47fJ1bxDOojfUiWN5Mel+rW66/1
 RXn43xRs1BdlFkkL+OMKMpqpfMQmVSgAxOa+VZeyB/t3dQLGErUbLOzvwcIW8rhluNHb
 N9tABUpjzNfvd+3MHBkK7gbX3Phv0ceVTpUmOuHJoH1dB/1eEaezA0xcf78S9rNBXRD2
 m55qXFPEcMSDBUogyPE91gO3sKWe3gwvKYR21jmXF6BjgKkBgUjtAVessTCYQM8w12OY
 YAiw==
X-Gm-Message-State: AFq9FYIbHifVjF8I7A9p63dKjEbTbpKRmMpVaAIZGH6wFdupSU891zPF
 oVR9a5rbJSz73MSRyUzJV9xU4RviS3w0LtiN0fJ7ob1jXZsjTex0Hg62/KP27BwTHY6JB0L//8n
 RqMYQNipeoJ1am3iqFLKp6r2iUADvTWByLjnx6Fc4
X-Gm-Gg: AYBFou0yxIbmpMqEl2ZuoTshbdqZRtqJnFCGEf3rex+JWFTYmRQZzNdOG6dKc87YfZk
 eA3qpVhF0cqr41XP/PBIeKYoTaiT0l/nXPaMmlohOt3Fbocu6Q+PmhkgTM6JXc036pgpP7Iqmrc
 N4k0VF28B1jyEiXhrQJM0xe40c2mYKWUJZvJQZ8AvynO+sT3H0k8l+HN1Y4ooXPrp7TpC573l05
 e2vdw/3uGfyNjiRu4ZYTIEwWDCgq2RZdM63gAR/jt3OmUXajR63gWcpK8YmPgBE8b/rRB9xzu49
 PAIIoDz1hcMxTWSeyN7FSvDvuRaJiA758IXM64GSxEZtCV2R1f3QhDiQ
X-Received: by 2002:a05:6402:3248:10b0:6aa:fce2:7b30 with SMTP id
 4fb4d7f45d1cf-6b17c243791mr461666a12.18.1791529847628; Fri, 09 Oct 2026
 00:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-6-hs@nabladev.com>
In-Reply-To: <20261004040657.3156402-6-hs@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 08:10:34 +0100
X-Gm-Features: AclHuK94noMJ647ghKxG1gsnDbFuN-VRj4hem-8hoasZhSarvw0kfPhX93Lb4n0
Message-ID: <CAFLszTi2mOSX2j6a38OwTvPO+vCKmgDFSz3MG6ZqJBHAOz3Gtw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] test: dm: add a test for the Microchip 23LCV1024
 SPI SRAM
To: hs@nabladev.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Anshul Dalal <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 James Hilliard <james.hilliard1@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
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

On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
> test: dm: add a test for the Microchip 23LCV1024 SPI SRAM
>
> Emulate the device on a second sandbox SPI bus and exercise the driver
> through the MTD layer.
>
> The emulation implements byte, page and sequential operation and
> advances the internal address counter the way the data sheet describes
> for each of them. A transfer running past the 32 byte page of the
> device therefore only comes back unharmed once the driver has selected
> sequential operation, which is what its probe is for. The test asserts
> that mode directly as well, so a failure says which of the two went
> wrong.
>
> Test also if erase returns -EOPNOTSUPP and data is not touched.
>
> A second test gives the device two partitions in the test device tree
> and writes through the one whose offset is on no erase block boundary,
> which a device without an erase size does not have to care about.
>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>
> MAINTAINERS                     |   2 +
>  arch/sandbox/dts/test.dts       |  37 ++++++++
>  arch/sandbox/include/asm/test.h |   8 ++
>  configs/sandbox_defconfig       |   1 +
>  drivers/mtd/Kconfig             |   9 ++
>  drivers/mtd/Makefile            |   1 +
>  drivers/mtd/spi_ram_sandbox.c   | 190 ++++++++++++++++++++++++++++++++++++++++
>  drivers/spi/Kconfig             |   2 +-
>  test/dm/Makefile                |   1 +
>  test/dm/spi_ram.c               | 167 +++++++++++++++++++++++++++++++++++
>  10 files changed, 417 insertions(+), 1 deletion(-)

> diff --git a/test/dm/Makefile b/test/dm/Makefile
> @@ -120,6 +120,7 @@ obj-$(CONFIG_SIMPLE_PM_BUS) += simple-pm-bus.o
> +obj-$(CONFIG_SPI_RAM) += spi_ram.o

I'm assuming that CONFIG_SPI_RAM_SANDBOX is always set for sanebox builds.

> diff --git a/test/dm/spi_ram.c b/test/dm/spi_ram.c
> @@ -0,0 +1,167 @@
> +     bus = dev_get_parent(dev);
> +     ut_assertok(spi_get_bus_and_cs(dev_seq(bus), SPI_RAM_CS, &bus, &slave));
> +     ut_assertok(sandbox_spi_get_emul(state, bus, slave->dev, &emul));

slave->dev is just 'dev', so you can drop spi_get_bus_and_cs() and
'slave' and call sandbox_spi_get_emul(state, bus, dev, &emul)
directly.

> diff --git a/test/dm/spi_ram.c b/test/dm/spi_ram.c
> @@ -0,0 +1,167 @@
> +     ut_assert(mtd->flags & MTD_NO_ERASE);
> +     instr.addr = 0;
> +     instr.len = SPI_RAM_OFFSET;
> +     ut_asserteq(-EOPNOTSUPP, mtd_erase(mtd, &instr));
> +
> +     ut_assertok(mtd_read(mtd, SPI_RAM_OFFSET, SPI_RAM_LEN, &retlen, dst));
> +     ut_asserteq_mem(src, dst, SPI_RAM_LEN);

The erase covers [0, 0x1f) but the read-back covers [0x1f, 0x83), so
if the erase did touch the data, this check would not see it. Please
can you erase over the written data instead, i.e. addr =
SPI_RAM_OFFSET and len = SPI_RAM_LEN?

> diff --git a/test/dm/spi_ram.c b/test/dm/spi_ram.c
> @@ -0,0 +1,167 @@
> +/*
> + * The second partition of the device in the test device tree. Its offset is
> + * on no erase block boundary, which a device that cannot erase does not have
> + * to care about.
> + */
> +#define SPI_RAM_PART         "spi-ram-part1"
> +#define SPI_RAM_PART_OFFSET  0xa000

0xa000 is 8K-aligned, so contrary to the comment it does sit on a
typical erase-block boundary. The test catches the divide-by-zero from
patch 2 but does not show that an unaligned offset still gives a
writeable partition. How about an odd offset such as 0xa001 (in
test.dts too), and rewording the comment to say the device has no
erase size, so the write size of 1 is the only alignment that applies?

> diff --git a/drivers/mtd/spi_ram_sandbox.c b/drivers/mtd/spi_ram_sandbox.c
> @@ -0,0 +1,190 @@
> +/*
> + * The command and the data it carries arrive as two transfers, the first
> + * one holding the opcode and, for a read or a write, the address.
> + */

This ties the emulation to how the driver currently splits its
transfers: a driver that sends command and data in a single BEGIN|END
transfer would have its data silently dropped. The real device just
sees a byte stream while CS is asserted. You could treat any bytes
after the address in the first transfer as data (n starting at 0 from
there), as the SPI flash emulator does, so the emulation follows the
data sheet rather than the driver. What do you think?

Regards,
Simon
