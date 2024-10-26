Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73ADD10BFF
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 16:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48FCE88B4B;
	Sat, 26 Oct 2024 18:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PtSxUwTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A85F788F71; Sat, 26 Oct 2024 18:24:05 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 040F6888EB
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 18:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539e59dadebso3662559e87.0
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729959838; x=1730564638; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDM//PltKAQvcURxdqh8jvWwaJHScejb5CWSURy65n4=;
 b=PtSxUwTGu+DqbOHAq7OcYRXxRtVLz1fCdkfkMNNQR2ci8HE7gHFtRo1VmLoYagwE5S
 ELgeAcA08O3ZstvWEG7Q3bLBFdlBz8rAmX7HBYZIPctxPulE2pbGSlRhReIxWK3NmOa/
 1c0JsmiuEl42l5Prwp17bT/RfhlFtPGe3vYzVZHxouhnGATicjeX+m09h2dIvGsBuJMC
 kWisnW7Bf5ZiyQaVwn0BBAxwh/MNBXJu6a6pOJWDWG87oCBy/UPePssj3y9Wdc48U+jG
 A8Zc5rplurxkGC5CQHXb6RLNSAw96xnyWCWxVtto5nrUMsf1Ph8zncltuOdrxSOunH7d
 kbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729959838; x=1730564638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hDM//PltKAQvcURxdqh8jvWwaJHScejb5CWSURy65n4=;
 b=dZMIuwLU+DCRz8t+L+czPmfwf2WnN9BKOzau9hb7GE/bXMmYrX76UdbX9VigFu08Hp
 BppoqzmruUlvVlYnSwyiV/doQsnbjgha/bGZadpA8WrTm59Hyrqv42cNMZVoaMngKWtF
 0iaGmAbGX47uS9HBoh8jE0k0QdMFRT6BX/FuEyqncvdWvGWzRGofZDG/j0GJIZq6OAAF
 8r07nW+8Yb28w+D1CJs/oXbrLPByjkvtBrBYXu9RbJs4Wno2ZXey3EOcHGiT4QNQnaA5
 GQ8MyWYWT8MnVADWrcGZDVaqPEBtR4SHh/ufJt8BDUiAZnG/VsAB0NRt62UUARClF1eF
 CE0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVtoz0uTe8nU3bL3hUdKFAp+F8nsNoEpGW4r8TRSP7LBof1HF6erAoI7sNmCASDQdGA0GwwjM=@lists.denx.de
X-Gm-Message-State: AOJu0YzDzQ/xhvHdtV31KG0QPWzE+WvkAr0tLMJMLDRg0CcFWnd3Akk/
 LdyfVnXK4xZ88poSAJebSPtoX9slSvWmOpSNr5L6pyeUd0JNVy1r6hyrgA5gcCyG8rtDhcFEkRQ
 U/O/vnbiuqf6CpoLC8ZRavSqDvmk=
X-Google-Smtp-Source: AGHT+IHareK+mgDzimgYgZUhgu6F1SdhrUSOj+8+itHHmW7sGCOGm3vEHJBb9wv73T/ysQya1ubPK6mWTZ4Vk4zc0b8=
X-Received: by 2002:ac2:4e08:0:b0:539:e94d:b490 with SMTP id
 2adb3069b0e04-53b34c5f8e4mr1154548e87.43.1729959837833; Sat, 26 Oct 2024
 09:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
 <20240829013058.6178-6-minda.chen@starfivetech.com>
In-Reply-To: <20240829013058.6178-6-minda.chen@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Sat, 26 Oct 2024 09:23:46 -0700
Message-ID: <CANV2PTMW3a0BS8cXrU_N5nJPrRv0jknfZUh7_CSsZ5LRG277eg@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] spl: starfive: visionfive2: Disable USB
 overcurrent pin by default.
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
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

On Wed, Aug 28, 2024 at 6:31=E2=80=AFPM Minda Chen <minda.chen@starfivetech=
.com> wrote:
>
> For some JH7110 boards, USB host overcurent pin is not reserved,
> To make USB host work, overcurrent pin must be disabled. So set the
> pin default disabled in spl stage.
>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  arch/riscv/include/asm/arch-jh7110/gpio.h | 5 +++++
>  board/starfive/visionfive2/spl.c          | 3 +++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/riscv/include/asm/arch-jh7110/gpio.h b/arch/riscv/inclu=
de/asm/arch-jh7110/gpio.h
> index 90aa2f8a9e..be2a1e0d1c 100644
> --- a/arch/riscv/include/asm/arch-jh7110/gpio.h
> +++ b/arch/riscv/include/asm/arch-jh7110/gpio.h
> @@ -63,6 +63,11 @@ enum gpio_state {
>                         GPIO_DIN_MASK << GPIO_SHIFT(gpi), \
>                         ((gpio + 2) & GPIO_DIN_MASK) << GPIO_SHIFT(gpi))
>
> +#define SYS_IOMUX_DIN_DISABLED(gpi)\
> +       clrsetbits_le32(JH7110_SYS_IOMUX + GPIO_DIN + GPIO_OFFSET(gpi), \
> +                       GPIO_DIN_MASK << GPIO_SHIFT(gpi), \
> +                       ((0x1) & GPIO_DIN_MASK) << GPIO_SHIFT(gpi))
> +
>  #define SYS_IOMUX_SET_DS(gpio, ds) \
>         clrsetbits_le32(JH7110_SYS_IOMUX + GPIO_CONFIG + gpio * 4, \
>                         GPIO_DS_MASK, (ds) << GPIO_DS_SHIFT)
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive=
2/spl.c
> index b794b73b6b..388a06e4d9 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -452,6 +452,9 @@ void board_init_f(ulong dummy)
>                         JH7110_CLK_CPU_ROOT_MASK,
>                         BIT(JH7110_CLK_CPU_ROOT_SHIFT));
>
> +       /* Set USB overcurrent overflow pin disable */
> +       SYS_IOMUX_DIN_DISABLED(2);
> +
>         ret =3D spl_board_init_f();
>         if (ret) {
>                 debug("spl_board_init_f init failed: %d\n", ret);
> --
> 2.17.1
>

As tested, this patch is required for the operating system after
U-Boot to enable USB on at least Pine64 Star64 and Milk-V Mars CM Lite
even if U-Boot does not adopt the other patches in this series.

Can this be cherry-picked separate from the series?

Tested-by: E Shattow <lucent@gmail.com>
