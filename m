Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFF9108E1CF
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 10:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5877283BC8;
	Thu, 19 Mar 2026 11:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gsXHbNlG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC03D83CF3; Thu, 19 Mar 2026 11:20:51 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67CA580517
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 11:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b98069e41b0so119860366b.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 03:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773915649; cv=none;
 d=google.com; s=arc-20240605;
 b=R4cLckjo0vGJ+//fhdW8i7LxlgqhHX7FZ6BTjrjHDlyBw+qtEDnzklftIJPUI9wBZa
 gSna+PFkQlYsTf0q0cgFS8QvVtNXOIXY8oMPFZdVzw41lP4JUXt7qbv6orIgCLRI4AJo
 5D9FtbgheWQvFGJnD0rqIzcjw+UfVCo+8XF1zdUEvoTJEsqHmNsicyAjOY+q9Bkyxy7T
 b1PLhBcCgAi6uXTChfPHX+ywLxko9pUtdbl1eSrYd/K4Jr/I/p/QhukwRJjBVzGNmCZu
 F/Bc8Eh7AJYtghidPwDX0C0LLN56tAn9rbRgMl9oKrPAlRskg/IcmiXx34CKAJy8SK9F
 Ci1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V/KT63OxmgMKGEkg8Fi9aRTTdn7lB0pBdrVgg4nJBrY=;
 fh=xngVyBwTwU3QOXGXepwpodf7G7hXDDZApcpqxq9qTHg=;
 b=hThMlrXokVyRPiKaJPgzi0z8Jf6HsquZv6vSCXZifE9n6WmlZh6mADAHObuyz2ZU/I
 Pyvnj6fjaDie978kS8iFXPAroGSkoh9Jhv7en1V6IpDbzd9NrHLm5/r5ETPjdzDXLwNL
 pRRzozoFfz2a2RbYdEvlv3LLJQSL1hPstgP6pbf9i6gIRM0SVJa/8lZ4bVhnb4HnQy5v
 BAtzn31icsMgzydXpDDdRBhh2nP4dHyUcLYtRYDtL3qbznBt/zYKEXKAyP5JaD/Qc6sq
 n/DOPp9V6ojlpqaQb8dWU8mXF8pLTzKILHtZ5PgtvR37uURZ5+VvbJL5YLCW7UuVg8dI
 VuSA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773915649; x=1774520449;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/KT63OxmgMKGEkg8Fi9aRTTdn7lB0pBdrVgg4nJBrY=;
 b=gsXHbNlGyNGhwThI1jvsuwWVYkJmzKFjUUyqzkjnVUAqTyzc3iR71bb6fYhDbYmyMe
 acSIUTrqf8zSK6y+N3S7GBkNEO0D/Jlz6jmEX9HJ0ZUcnnM1IpgKn0/qhtA7Ees5Zvv4
 NKEF/UVlvIpHq1tWtPl/olDvgmD191cVcAGUhvhSehHEMMPyvDhRG+1A3ud4MXQiP8Dn
 I988Hy1ZJPcfrHEwID2QhO2BBYDKSMYeem99wUazZNj4h9G/UT0PoAEBFCD2dorDYJ0g
 T02mqs6DVZzsrqHCnIlrynxLyTWHD2f9Ksdxy1+z0K/N0RoAbv3EGZ9UEAo2DK2ew7J0
 5XBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773915649; x=1774520449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V/KT63OxmgMKGEkg8Fi9aRTTdn7lB0pBdrVgg4nJBrY=;
 b=U6ANwqUhGQkWRQkCT/F86OnN9AVWfkSk4DauwPdw8iUUX8Bow4u0yaRv0EmXYObGOh
 e9bngUU7sY16cpIF6lM4vQYm2VL7BBba6UrwPdShIr9m4mA8sK4PlhXcvG11e5UBccub
 kdvCfjJlSZ2L53eT0Nhi+arHAmHQnBsxKGA/h0IGVcgm1oTgaigGXhAHUP996YwIvaTc
 ou0Bax8AKS5LQBLUPtZnrjE6xe11E/d+AgYVJAPRQft6ojZSjHlJSFyRx7GGKY7jIeOl
 fyonAuToQvHUv9EBdQrEnP+DwqvsWGRl4hKaImUipEyq2jBwXYXIGxVd8xNl5L1TiDot
 5H7Q==
X-Gm-Message-State: AOJu0YyQCWroQ+Who/6TzwG91nl56KfsfwGLweeyQw+kXPIbA6LN1wAb
 9p9pPFLyo1z+bahWlKKhmpaXDBXqxkQtU7W60LS3+W9xIcN8luGrmYw1vSqYGIz9F61rBuqr5+I
 fbliOyPAin6HoiRUgJTg7LTJ1ZKQpVrXZJxuTLjGyjg==
X-Gm-Gg: ATEYQzzzghibVP+Zb3yDTQH580itg+b31M3wH7tF1agy2PkevZblV48UMCpdN/dk46Y
 WssBd6yeTeHg+86Oxif6r7T+ubHpkPvdKZCg1nJF9EKQQ1dqwdAsrbxj8MZ8kLGNXeiv1RgL0Au
 t6LGPVWRauU/vWprRn0yN1Hc/FAfhhbXvUJvHHi3hfVXJRElXOyZYWaMI/8MxlxjYN1BM4bw8+C
 z9xbVW9JxLv2R8FBg4dv3FU7XJSpFmM1z9dYNl1eLXhFf5J3s+ytAkSmP1pP5rgwayJhPaN5j9I
 XDZcssd54+MEgJZyEFbKrZw/GCEux5WW3kfjP3U6RuvkNAfOtsrIQIdYe/KzYsEl3idqACQW7tx
 yxLyMK3qL7j8hxX8oituJBius5Q==
X-Received: by 2002:a17:907:803:b0:b97:b470:e07c with SMTP id
 a640c23a62f3a-b980faf222bmr165775866b.30.1773915648695; Thu, 19 Mar 2026
 03:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
 <20260319-ufs_probe_clk-v1-5-08c085d6b15d@oss.qualcomm.com>
In-Reply-To: <20260319-ufs_probe_clk-v1-5-08c085d6b15d@oss.qualcomm.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 19 Mar 2026 11:20:41 +0100
X-Gm-Features: AaiRm50tLTgim4q6GEB8wRCLEZnoBFd4rr33QfXVqaMGsJDk6o-zr3g4RMLyOXQ
Message-ID: <CAEHHSvb0HnGEOqrbJt_mcno0NuDDqR7QOCvtXaL3Poj5T7hQWA@mail.gmail.com>
Subject: Re: [PATCH 5/5] drivers: ufs: qcom: Initialize and enable clocks
 before hardware access
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 David Wronek <david.wronek@mainlining.org>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Le jeu. 19 mars 2026 =C3=A0 10:38, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> a =C3=A9crit :
>
> Move UFS clock initialization and enabling before hardware setup
> to ensure clocks are running when accessing UFS registers.
>
> Previously, U-Boot depended on earlier bootloader stages to
> initialize UFS clocks. When these bootloaders failed to do so,
> UFS registers became inaccessible, causing initialization to fail.
> This change makes U-Boot initialize and enable UFS clocks early
> in the init sequence, removing the dependency on previous
> bootloaders.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/ufs/ufs-qcom.c | 45 +++++++++++++++++++++++++++++++++++++-------=
-
>  1 file changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
> index dc40ee62daf..c63e550c881 100644
> --- a/drivers/ufs/ufs-qcom.c
> +++ b/drivers/ufs/ufs-qcom.c
> @@ -30,6 +30,7 @@
>  #define UFS_CPU_MAX_BANDWIDTH  819200
>
>  static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable);
> +static u32 ufs_qcom_get_core_clk_unipro_max_freq(struct ufs_hba *hba);
>
>  static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
>  {
> @@ -49,12 +50,34 @@ static int ufs_qcom_enable_clks(struct ufs_qcom_priv =
*priv)
>
>  static int ufs_qcom_init_clks(struct ufs_qcom_priv *priv)
>  {
> -       int err;
>         struct udevice *dev =3D priv->hba->dev;
> +       struct clk clk;
> +       int err;
> +       long rate;
> +       u32 max_freq;
> +
> +       /* Get maximum frequency for core_clk_unipro from device tree */
> +       max_freq =3D ufs_qcom_get_core_clk_unipro_max_freq(priv->hba);
> +
> +       /* Get and configure core_clk_unipro */
> +       err =3D clk_get_by_name(dev, "core_clk_unipro", &clk);
> +       if (err) {
> +               dev_err(dev, "Failed to get core_clk_unipro: %d\n", err);
> +               return err;
> +       }
> +
> +       rate =3D clk_set_rate(&clk, max_freq);
> +
> +       if (rate < 0) {
> +               dev_err(dev, "Failed to set core_clk_unipro rate to %u Hz=
: %ld\n",
> +                       max_freq, rate);
> +       }
>
>         err =3D clk_get_bulk(dev, &priv->clks);
> -       if (err)
> +       if (err) {
> +               dev_err(dev, "clk_get_bulk failed: %d\n", err);
>                 return err;
> +       }
>
>         return 0;
>  }
> @@ -561,6 +584,18 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>
>         priv->hba =3D hba;
>
> +       err =3D ufs_qcom_init_clks(priv);
> +       if (err) {
> +               dev_err(hba->dev, "failed to initialize clocks, err:%d\n"=
, err);
> +               return err;
> +       }
> +
> +       err =3D ufs_qcom_enable_clks(priv);
> +       if (err) {
> +               dev_err(hba->dev, "failed to enable clocks, err:%d\n", er=
r);

I think you are missing a call to clk_release_bulk in the error path
to free memory allocated by clk_get_bulk in ufs_qcom_init_clks

Cheers
Julien
> +               return err;
> +       }
> +
>         /* setup clocks */
>         ufs_qcom_setup_clocks(hba, true, PRE_CHANGE);
>
> @@ -579,12 +614,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>                  priv->hw_ver.minor,
>                  priv->hw_ver.step);
>
> -       err =3D ufs_qcom_init_clks(priv);
> -       if (err) {
> -               dev_err(hba->dev, "failed to initialize clocks, err:%d\n"=
, err);
> -               return err;
> -       }
> -
>         ufs_qcom_advertise_quirks(hba);
>         ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
>
>
> --
> 2.34.1
>
