Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BDFC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 04:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE00187ECC;
	Tue, 16 Apr 2024 06:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xb/5sUrx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D687A87FA1; Tue, 16 Apr 2024 06:09:55 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B198887E13
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 06:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-479dc603962so1252761137.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 21:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713240592; x=1713845392; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfnzXQw+45zzA8qqQSGvNsqCjIpVe1+ch1m9hp0oSRQ=;
 b=Xb/5sUrxXJWd2SDxD3nNoQ+H1chAOZOfwC962sjxO3gk91oeXoEdt6Df3yvqGlRnHr
 ByuVpXFiwz31kDcrVQvygpUA6J9HZmiFUxbaSdsLBUFW4Nfr/daiKJoso7muGExiKBxi
 QsMrSIegDZacQ5IIj9226riYqUvaXY+Eh6FFVCh+atXkmZ5sfnorOjwPD7pgCVED8Fc8
 HGRpztOwqHck5kAsSEH1Ep6Ian9Sc04TtrxAZU4B4OanUiFRppUPqriI/3VdPhu4pcwj
 CgPuD6TOIO4/TIqQbRNNqICDpGrUjkVmV6umI41S5fHScdmCJfQbjXnrNCI3UY8qZ5fx
 rOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713240592; x=1713845392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BfnzXQw+45zzA8qqQSGvNsqCjIpVe1+ch1m9hp0oSRQ=;
 b=GvGrN0Qd4Docs9Ew7mi4sJxnmE+6OSWwfv8Jm1/IsN/fBSRmzpDiebwG009QRDP+RQ
 ssU6Co8mBXOvyCozsETsBfw2IIuq3VeimVPX1bdKCV1XjKQtp4UhxsNmvF2ap93KIC6n
 K7UCvUp7Gw58UWcDnGSois3ROjLMYHJZCgKgVMYGNrnJENgRQ0DDlrdHztiJx0s+lGWd
 oHxSOlp4aT3ljD07a5u2b1klz4+qA95JihuLJGdBkictpKp8xAZKQxJVdcTgMNezn4Us
 0vX/OKK9KrBem6QMjV6XlnLWsocGQiNoVMwFiyTSUA5ySORmo+8I6eji44iRBHDTTTXf
 eVpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpc3zO6VsawC76tSb6HytGGJTExZJD4lEeps4VdV+lPbdRYRNISya9dA3kotIwcWe/VBnI6DSznTA1zFrsVWSCqklc0g==
X-Gm-Message-State: AOJu0YzUx1utLObgArQfqffvD4dq7wT/rEi7EY070WGW+LwTMfU0o+Oy
 RpQ7JjSLY6pjMafLDrpcP4iovSjadvQeP6xsTUlGQ8rf9wc8gIYslTLYVtfk73GcJdzsdEA9umM
 M6TwCkIn8wc4eIQyqwIiC6CpjZfM=
X-Google-Smtp-Source: AGHT+IE8NoLQIKz3xnKUqsUayhXogmbEwHBwVCrAatr/mWHLIMfZgxtlky7Pry0q3/lFJyWlPxiVO4sHaFic+hpGY8M=
X-Received: by 2002:a05:6102:54a7:b0:47a:2dfc:b366 with SMTP id
 bk39-20020a05610254a700b0047a2dfcb366mr13654661vsb.15.1713240592451; Mon, 15
 Apr 2024 21:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
 <20240415115035.46199-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240415115035.46199-2-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Mon, 15 Apr 2024 21:09:40 -0700
Message-ID: <CANV2PTPX43Kwwyff_3cuzyG2DVe8qaWn3C4DxA9ppv0m5o3c-A@mail.gmail.com>
Subject: Re: [PATCH 1/4] board: starfive: function to read eMMC size
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Shengyu Qu <wiagn233@outlook.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de
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

On Mon, Apr 15, 2024 at 4:50=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The EEPROM provides information about the size of the EEPROM.

"The EEPROM provides information about the size of the eMMC."

> Provide a new function get_mmc_size_from_eeprom() to read it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/include/asm/arch-jh7110/eeprom.h    |  7 +++++++
>  board/starfive/visionfive2/Kconfig             |  9 +++++++++
>  .../visionfive2/visionfive2-i2c-eeprom.c       | 18 ++++++++++++++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/inc=
lude/asm/arch-jh7110/eeprom.h
> index 62d184aeb57..17395d4269e 100644
> --- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
> +++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
> @@ -12,6 +12,13 @@
>  u8 get_pcb_revision_from_eeprom(void);
>  u32 get_ddr_size_from_eeprom(void);
>
> +/**
> + * get_mmc_size_from_eeprom() - read MMC size form EEPROM
> + *
> + * @return: size in GiB or 0 on error.
> + */
> +u32 get_mmc_size_from_eeprom(void);
> +
>  /**
>   * get_product_id_from_eeprom - get product ID string
>   *
> diff --git a/board/starfive/visionfive2/Kconfig b/board/starfive/visionfi=
ve2/Kconfig
> index 2186a939646..d7e8a7a7d78 100644
> --- a/board/starfive/visionfive2/Kconfig
> +++ b/board/starfive/visionfive2/Kconfig
> @@ -50,4 +50,13 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>         imply PHY_LIB
>         imply PHY_MSCC
>
> +config STARFIVE_NO_EMMC
> +       bool "Report eMMC size as zero"
> +       help
> +         The serial number string in the EEPROM is meant to report the
> +         size of onboard eMMC. Unfortunately some Milk-V Mars CM Lite
> +         modules without eMMC show a non-zero size here.
> +
> +         Set to 'Y' if you have a Mars CM Lite module.
> +
>  endif
> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/=
starfive/visionfive2/visionfive2-i2c-eeprom.c
> index ddef7d61235..cd3d8bd51a6 100644
> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> @@ -548,6 +548,24 @@ u32 get_ddr_size_from_eeprom(void)
>         return hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL);
>  }
>
> +u32 get_mmc_size_from_eeprom(void)
> +{
> +       u32 size;
> +
> +       if (IS_ENABLED(CONFIG_STARFIVE_NO_EMMC))
> +               return 0;
> +
> +       if (read_eeprom())
> +               return 0;
> +
> +       size =3D dectoul(&pbuf.eeprom.atom1.data.pstr[19], NULL);
> +
> +       if (pbuf.eeprom.atom1.data.pstr[21] =3D=3D 'T')
> +               size <<=3D 10;
> +
> +       return size;
> +}
> +
>  U_BOOT_LONGHELP(mac,
>         "\n"
>         "    - display EEPROM content\n"
> --
> 2.43.0
>

Fixed-position parsing on a data format of ordered variable length
hyphen-delimited fields. Notable is that some Pine64 Star64 and Milk-V
Mars CM Lite boards shipped with uninitialized or wrong EEPROM data;
further the EEPROM Write Protect can be trivially disabled and
arbitrary data written i.e. with a paperclip then `mac` command. Could
this code be generalized to split fields on hyphen character better
expressing the expected data format or is that unwanted complexity and
code size?
