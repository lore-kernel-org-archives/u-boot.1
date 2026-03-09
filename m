Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83846EF371D
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 08:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8BB3839DF;
	Mon,  9 Mar 2026 09:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=egym.com header.i=@egym.com header.b="PLxK5iK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B829D83A8C; Mon,  9 Mar 2026 09:54:11 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31F9383952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 09:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cibil.pankiras@egym.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-38a3486419cso33143721fa.3
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 01:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773046447; cv=none;
 d=google.com; s=arc-20240605;
 b=V4tGgaFtcwFbiXJhv156NHXPHob9aoqVvlHiRC6bKbVR1QkNzjDVzP60+kpvAcCAmA
 x9GG81FcX/Um/LR+2CHoRvT/30W7CBX2lA+/svh7msOlsXODsOGUHKMuBaxx3CMTVP/1
 iTAsghp7PQS6oc76urOCpkZc9JJ1R+bgY5e8HEWl69HQnwnLpDUW45I7AYIHR26tnenr
 t802pN6Lqn5OfSRZtBK8ze/cQU+1FIkMnjKQZWY8ZODaPGZKAW+Wl0RNu1cc6b0tMKc4
 FNIX/AZ11BttIYr60URn8yAxA8Su8LknXqa0UVQNJ/rst8Kj1DoTAr7AlSQBPxBlS4vN
 9ySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1RPfaVRzuABLNso4Uj4qhD6naNtSgbMZ0SJG/a7C15U=;
 fh=HaIPtZf3Pgz85VsN9CYaHBIYxht2i2ce9rjxgwF9FyU=;
 b=IN4p9Ljbi3+2EfsV4JyooW2zUX3BgKfJlN8q22tLb5qnDQ0zwI01JP4fu6tTxtYCFQ
 HhTG9hzkErZPRfYkT8VbqcJOejvF+KQvXGh6iG4x39+C7t9j6IDtkIk2sqDgGj3oq+EC
 SCvdgNHmEety0ALDpgvoz0+u2SRqic6sMkcWCEuondRhv9F86BNM1enBQo4p7lLWoFl4
 uFolM9Sa+e7Rg6LMpVgxrShC+A+60xQYiq2EBmAY77sYjHlue3FOL5csE+XaqJSz1iJR
 xreCgDOKR+lFNnJ+181qBX+mdV0+7DDR6Gm/gSVw3Os2SyI95JY2AN5iot0LBJ3zeoXb
 1VmA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=egym.com; s=egymcom; t=1773046447; x=1773651247; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RPfaVRzuABLNso4Uj4qhD6naNtSgbMZ0SJG/a7C15U=;
 b=PLxK5iK306O/vXgYK1BX8rYIs8vJWqpP4qeE8EhSiPYd4zcOkQ4tujBAlEcW72byrO
 lmAtBbJKSJagiFYGwZG/3Mxj2f5THVrQTBR6/Ppif9hFBFBW2HdZG8Ol0I2gVSK/z4H1
 GZJWttooQjjt0XsFywFaXfMx7cN1psiu9pBsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773046447; x=1773651247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1RPfaVRzuABLNso4Uj4qhD6naNtSgbMZ0SJG/a7C15U=;
 b=HBX98xWi9Fbw+X4uCTucAFEvtXVB61AnVppyftENdvfM7H2ce8W76NFdfbgej+WLt8
 DTEddTAtxmFkFGqsc1FJTxONhNsHC0OMQMEkrKy1VoBHt690SHrZa9Mi2bVZqXBxXj5A
 7NSJTbtRip8H06HT8FVsn+yPGuSXOTzEiqLsAjXjDbZ3dEWB+CGqd1sTMLdz71r5LydN
 TlIrd0YIGgU5YIx5J0j/tF6j5svKX6JppMHh5TjjxB6heYIh7Br1+RIVIs6SvJU6D249
 aZ5sWh2mLsabGVDLwcEom2YU8iysgLE3e02WtQCB7ii2Hrha/oy3UOt30+S9YyZ1X0jb
 qGBw==
X-Gm-Message-State: AOJu0YzPzHiNAmx6Q6QtnEeG4MssuHNc842OG1dO237Rz8AGEzgq1hHl
 PAbNZRpo9tTOA0ocUZS0C2jpi0AqZS0N9nfoJyA//azwqvZpLLefYUam+XEd2/egpTKYUIviCjR
 zmeI4m4H+UR9Pdnv+pWu0gR6z/Wlf/Qp/pmXPXwqMxOgOVelg4A+EgcMf+4ZwEvgkWcEqPty/LC
 T4od3o4wMdCVMREJuualoQMPGoPS1634RIJhQ8PA==
X-Gm-Gg: ATEYQzyyB/78HM43JY1K8bDHGC+M/jfvw4TglKzzKeYZhdcHU0TM/P6Nx+Of7DCUdXg
 LVH5o868BL0o2TUKs+6vVypyiVLQ1EBljnAW01POKrhIhSs7KM/d44WFfRAf8L4vqT1cqaPaoR9
 1Ajo+EbRtN2zMkOBW3jOBG1+azfMPF85E7J26VR6CjfJMXKpksZgW81zMpik9UswecS2ZtCbogW
 ngIS1gHYZP25RVy1oX/EIf+UyaqadQYGSzQkdUU3Ud9ALfi8qs6mpBRsKNFpiXPDxaFyPp9dkpV
 8/npJocMSE1j7tAbubf0W7FdHfZVo+x2o/EkDml4xyJTYvXr76fia49l2dG3+JxOkFN/SiwBfgS
 yuqyztdWpgH88xxHXmnJK3JlM
X-Received: by 2002:a2e:be9f:0:b0:389:eed3:5685 with SMTP id
 38308e7fff4ca-38a40d65498mr30540651fa.16.1773046446768; Mon, 09 Mar 2026
 01:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260206104701.34358-1-cibil.pankiras@egym.com>
In-Reply-To: <20260206104701.34358-1-cibil.pankiras@egym.com>
From: Cibil Pankiras <cibil.pankiras@egym.com>
Date: Mon, 9 Mar 2026 09:53:55 +0100
X-Gm-Features: AaiRm50btSP7_N04ZEBYyfF5xxWfgC3-SVBmXvpfk70T_lqh6bM48eFpJd0MBnE
Message-ID: <CAK3EG+=BUz=1srAZFaOaYoMeGQ_bL=q8aeOZFiSj1-d4uGT+Mg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: bcm283x: Fix GPIO pull state register values
 for BCM2711
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

On Fri, Feb 6, 2026 at 11:47=E2=80=AFAM Cibil Pankiras <cibil.pankiras@egym=
.com> wrote:
>
> BCM2711 has different pull-up/down register values compared to BCM2835
>
> - BCM2835: NONE=3D0, DOWN=3D1, UP=3D2
> - BCM2711: NONE=3D0, UP=3D1, DOWN=3D2
>
> This patch fixes the pull state register values for BCM2711.
>
> Fixes: 2c39d975f87c ("pinctrl: bcm283x: Add GPIO pull-up/down control for=
 BCM2835 and BCM2711")
> Signed-off-by: Cibil Pankiras <cibil.pankiras@egym.com>
> ---
> Changes in v2:
> - Moved pull value swap logic to bcm2711_gpio_set_pull()
> - Updated the function header comment for bcm2711_gpio_set_pull()
> ---
>  drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinctrl=
/broadcom/pinctrl-bcm283x.c
> index 4ecc8bac645a..90eee88eb137 100644
> --- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> +++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> @@ -30,6 +30,11 @@ struct bcm283x_pinctrl_priv {
>
>  #define MAX_PINS_PER_BANK 16
>
> +/* pull states for BCM2711 */
> +#define BCM2711_PULL_NONE 0
> +#define BCM2711_PULL_UP   1
> +#define BCM2711_PULL_DOWN 2
> +
>  static void bcm2835_gpio_set_func_id(struct udevice *dev, unsigned int g=
pio,
>                                      int func)
>  {
> @@ -93,6 +98,17 @@ static void bcm2711_gpio_set_pull(struct udevice *dev,=
 unsigned int gpio, int pu
>         u32 bit_shift;
>         u32 pull_bits;
>
> +       if (!device_is_compatible(dev, "brcm,bcm2711-gpio"))
> +               return;
> +
> +       /* BCM2711's pull values differ from BCM2835 */
> +       if (pull =3D=3D BCM2835_PUD_UP)
> +               pull =3D BCM2711_PULL_UP;
> +       else if (pull =3D=3D BCM2835_PUD_DOWN)
> +               pull =3D BCM2711_PULL_DOWN;
> +       else
> +               pull =3D BCM2711_PULL_NONE;
> +
>         /* Findout which GPIO_PUP_PDN_CNTRL register to use */
>         reg_offset =3D BCM2711_GPPUD_CNTRL_REG0 + BCM2711_PUD_REG_OFFSET(=
gpio);
>
> --
> 2.43.0
>

Hello Matthias,

Could you please review this patch when you have time?

Warm Regards,
Cibil

--=20
EGYM SE, Einsteinstra=C3=9Fe 172, 81677 M=C3=BCnchen
Gesch=C3=A4ftsf=C3=BChrende Direktoren:=20
Patrick Meininger, Philipp Roesch-Schlanderer, Florian Sauter
Gerichtsstand=20
M=C3=BCnchen | Amtsgericht M=C3=BCnchen HRB 303509=C2=A0|=C2=A0USt.-Id. DE2=
75313632
