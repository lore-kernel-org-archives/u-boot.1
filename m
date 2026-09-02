Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F11C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 10:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 412E96085B;
	Wed,  2 Sep 2026 10:25:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SoGUiSWJUvFv; Wed,  2 Sep 2026 10:25:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788344712;
	bh=CZVle/ByPYM1ijlw/a6ISMXXtjxf/K6SpLk5L7IWbKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KxnvPrCgJUh7xorW20qPAkgBBAoGj46wyHAxqEoZUjtwJiMVGN24A8ZHrFZxSK+Vr
	 EsYUyRwm09mQpa0+6jmOCAXXs9Y5hcnLE4qchxaBgsVCRcUZS+B/s39I1r9/MhdUD1
	 joC9fwDgNVhs8rQvrUIeoCwC8sRmWZ3rfQXtMdKxl/d3La+R2a3V8z8ZRUbshWFY5T
	 Eq7ebEQBcztZ5KXbcTCtZRYQ9dRBwFYwgyN1Yh6aa/Jq4Z+FxfdXHERrAK7JoyiS0w
	 hIVJzKQdZPWOJNf04NsKxtBSFaYgRLfylY0p91FJO4NYHf1LebHSJls8QQ4pE1u1rt
	 zEIuDWSr6QAyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1CA060824;
	Wed,  2 Sep 2026 10:25:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 61147230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 10:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5249260824
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 10:25:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0O--CbQgtip1 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 10:25:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=B6sZB4MW
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE60260823
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 10:25:06 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a63c610b8dso1287891a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 03:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788344705; cv=none;
 d=google.com; s=arc-20260327;
 b=Uv2INZkZsyxZlSfMJODKRVhMHtIbya5aM8YLzqJ8QQQLFdT2YZSw0SlJfXE2zEUJeL
 HkeDJngZ4K4wFHuI3bNQjD8BanMpKuhDqyMcPUJp6CN8eY86hfukAPrxtkDdHKe2ecgs
 MA14CjjmkeG462tXo3u30wEpnFhrbcgo5Ikd0a3K6EgF+xYws0hKKOnlnqDsuLiV362K
 X6dyHn1YYUPSOKgvRF7QRelo9xlT1djarzA3uk9mDqNe0BTcYLUSm0b1r0otz5eYrRW+
 eNEK9nynmnWZctH9jdA3hgnDJA7YrQM762ecsOdE4HOSHTOERgxAF4RY9K20h+X/2FS3
 6ZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CZVle/ByPYM1ijlw/a6ISMXXtjxf/K6SpLk5L7IWbKY=;
 fh=dz0otrMPqpve8bC7WcvFHhZud3tvBwQ+XrMM+phk/u4=;
 b=lbZ7QCnEeTfI/3v1WHbFNO0UyXf0liYyBK/aYA1PS7eRE/CIn8LPFSnRCZiB6UXvk1
 p7i3Gni7nyLrV4fWEi5LWCDn+JjQaRp7Ojw3EHANdZ1C99JejMXrMcO7HB2E1hwxrmPE
 9ZgDA56nKkPT2Y+AgLdV0GEV4erhVuE1d7iVTGkBgCr9EXUxToqbzPuFpeGxEtLXyDnG
 7f+DC1Gw4xZ35/2Uh2w8X1WinEPLB5qfSxlNn9qFaPwN3eSeL1wrVfIk0u2BBXmFz2eL
 gBvuiIhtf2dfH7iqT7wNn1jq4s/XWHBbXUEYfGGbVpJtZnM9aYTKJpAPZh25CENnFvVk
 Qfxg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788344705; x=1788949505;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CZVle/ByPYM1ijlw/a6ISMXXtjxf/K6SpLk5L7IWbKY=;
 b=B6sZB4MWscb+jEa5Fvxf213quuvEt08XQihYKKK3gGldVrpgs8oVWdEPHVCSf00Nwg
 saheRxVhMwpLcus/k3DQTgECRmMnnTPLaYzaGv1J70W6n5+NcgJtTq5J2q1GR3zm/E/e
 HEqPKPrXb9mWtxbYhBzyMLKopuWPIWMIBtH/2SPZcZAALt//AC6EENuP+2IPQIL8zanl
 b44JESaa47blLwoDDrfn+16uY4XtKpBu+z1V8rmU4srwifcpZ8S4VeyFRM8Y2Vzmekoi
 dxc3jJznC5DYrnLgCOc+ZvBk3RgnoEaFb98BwHGsKOPxM3w8sr88Nr710BVIMMX050Uc
 rOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788344705; x=1788949505;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CZVle/ByPYM1ijlw/a6ISMXXtjxf/K6SpLk5L7IWbKY=;
 b=oJo5JSUf1k6yDd7ok0em28k3Sx9GU8KFlP0Z5NF09hv9GuAsKtANDDRXjEHP+diyrD
 EbfBOngsAGEzONCaOea52d+xdFh+5fThw0E1LGO6qBSWnHHWRuuy0C1upqCYESE/08o0
 9VKmjehGIrD3JxjytGKtezaQ2s+e7PqZEWXm2b5D5+BXSeasrxnV9iZ6HwiXV7kkxUEu
 J4PFOpCHo/bR/qhl5PTpfB86aO0PB/grPwqgXMGqw2Yvq4CmODBkRm7Slx6J0brTb9sh
 rid2xs0lhrF4z+0XxBBkJyXPy3Fg9TkNWBJ5N8mHxVCO7Ehr0XYzoEXuvQVbdybcFYIO
 C0/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRXhiIFs8W0pY2ZT3Lz4+5b8pUGX6qmesS06X7E4RGKRQbXWJ4b0xffT2wl8VmIim+8g8ELjI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lmVCXGgRJpXeXCWcg3O4w20cFmDnUOWM7N7FXAcZWj0CFpL8nV
 CWQID/rOTP38KktlcSuGT3sHq7b27mOOj7FA8ZXpN9i0nKAxNkEGeXC+bPfcXU1sBZQE4fef/9C
 sJngXN4vg2ElxM+sde0i1RbU02QypwM3ieQ9g1s1DhDTNSQGO4Umy8y+x0g==
X-Gm-Gg: AYBFou3On5cX4I0crvH6+dErohYdkMvybZAdfrF/grAdoG173uZII92BfcOr9sbc3sD
 dgjH+Q71oZlfFXJDy7usE4gorjcS2AbmS98KxcsTw2ebyNiY/Bu+/XAq2zC604Oq9zuMUSyvbdg
 GHsDXSwZMKcnZ55zARFsDY3MZIbIoxDwo+09Z8F6t2oZ6v0RJgBkKTOsXBEiGDIQhwARzTTkshU
 puJYm0jvCXSGvMjQ4Us0WPnidBqkP0PCbrceUMGemCXINL2lI7WxSYs7cA00EIeEi6JvWrqXFl7
 b23zTnU9iPDM+KP0/deVMExD1QlJKV2V5mHmDmR+bmGuvRvqidl/ok0Z6Y5emd7BEHY5uPWnVXa
 sV2lFzCN/M0m0chwXrL7Kc12dB8CWV+vIr9VNWKcvLWqIPXcT5g5zh+Qv35Ua56K1
X-Received: by 2002:a17:907:9624:b0:c19:5572:d234 with SMTP id
 a640c23a62f3a-c25d53ba996mr233157266b.1.1788344704529; Wed, 02 Sep 2026
 03:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260814-video-pwm-backlight-num-interpolated-steps-v1-1-140b06287868@baylibre.com>
In-Reply-To: <20260814-video-pwm-backlight-num-interpolated-steps-v1-1-140b06287868@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 2 Sep 2026 12:24:56 +0200
X-Gm-Features: AcwNN1UitlWLmFbMZDVRP74iyL4ZF-pI0uN0SVwvGXfbkNsvdH-P_aoTpJYIoG8
Message-ID: <CAEHHSvYSoxKH+pM4468s0g-s3yP4fkf3bBwfXOm779J+bNOmTw@mail.gmail.com>
Subject: Re: [PATCH] video: pwm_backlight: support num-interpolated-steps
To: David Lechner <dlechner@baylibre.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Le ven. 14 ao=C3=BBt 2026 =C3=A0 21:15, David Lechner <dlechner@baylibre.co=
m> a =C3=A9crit :
>
> Add support for the num-interpolated-steps devicetree property to the
> pwm_backlight driver. This is used in cases where there are many points
> and we don't want to list them all in brightness-levels.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This will be used by the MediaTek Genio 360 EVK that we are currently
> working to bring up.
> ---
>  drivers/video/pwm_backlight.c | 124 ++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 112 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/video/pwm_backlight.c b/drivers/video/pwm_backlight.=
c
> index 1470eaf4cab..cd469417552 100644
> --- a/drivers/video/pwm_backlight.c
> +++ b/drivers/video/pwm_backlight.c
> @@ -16,6 +16,65 @@
>  #include <linux/math64.h>
>  #include <power/regulator.h>
>
> +/**
> + * build_interpolated_levels() - Build a linearly interpolated levels ta=
ble
> + *
> + * Some "brightness-levels" tables only list a few anchor points and rel=
y on
> + * "num-interpolated-steps" to fill in the values between them, so that =
a
> + * high resolution PWM duty cycle can be used without listing every valu=
e.
> + *
> + * @raw_levels: Anchor point values read from "brightness-levels"
> + * @count:     Number of anchor points in @raw_levels
> + * @num_steps: Number of interpolated steps between each anchor point
> + * @levels:    Returns newly allocated table of (count - 1) * num_steps =
+ 1
> + *             entries
> + * @num_levels: Returns the number of entries in @levels
> + * Return: 0 on success, -EINVAL if @count or @num_steps are invalid, -E=
NOMEM
> + *        on allocation failure
> + */
> +static int build_interpolated_levels(const u32 *raw_levels, u32 count,
> +                                    u32 num_steps, u32 **levels,
> +                                    u32 *num_levels)
> +{
> +       u64 count_out64;
> +       u32 count_out, *table, i, x;
> +
> +       /*
> +        * num_steps must fit in the s32 divisor of div_s64(), and count_=
out64
> +        * must fit both u32 (it is stored as such) and the byte size pas=
sed
> +        * to malloc().
> +        */
> +       if (count < 2 || num_steps =3D=3D 0 || num_steps > S32_MAX)

we should include directly include/limits.h for S32_MAX

> +               return -EINVAL;
> +
> +       count_out64 =3D (u64)(count - 1) * num_steps + 1;
> +       if (count_out64 > U32_MAX || count_out64 > SIZE_MAX / sizeof(u32)=
)
> +               return -EINVAL;
> +
> +       count_out =3D count_out64;
> +
> +       table =3D malloc(count_out * sizeof(u32));
> +       if (!table)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < count - 1; i++) {
> +               u32 x1 =3D i * num_steps;
> +               u32 x2 =3D x1 + num_steps;
> +               u32 y1 =3D raw_levels[i];
> +               u32 y2 =3D raw_levels[i + 1];
> +               s64 dy =3D (s64)y2 - y1;
> +
> +               for (x =3D x1; x < x2; x++)
> +                       table[x] =3D y1 + div_s64(dy * (x - x1), num_step=
s);
> +       }
> +
> +       table[count_out - 1] =3D raw_levels[count - 1];
> +       *levels =3D table;
> +       *num_levels =3D count_out;
> +
> +       return 0;
> +}
> +
>  /**
>   * Private information for the PWM backlight
>   *
> @@ -49,7 +108,7 @@ struct pwm_backlight_priv {
>          */
>         bool polarity;
>         u32 *levels;
> -       int num_levels;
> +       u32 num_levels;
>         uint default_level;
>         int cur_level;
>         uint min_level;
> @@ -196,6 +255,7 @@ static int pwm_backlight_of_to_plat(struct udevice *d=
ev)
>         struct ofnode_phandle_args args;
>         int index, ret, count, len;
>         const u32 *cell;
> +       u32 num_steps;
>
>         log_debug("start\n");
>         ret =3D uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
> @@ -232,20 +292,60 @@ static int pwm_backlight_of_to_plat(struct udevice =
*dev)
>         index =3D dev_read_u32_default(dev, "default-brightness-level", 2=
55);
>         cell =3D dev_read_prop(dev, "brightness-levels", &len);
>         count =3D len / sizeof(u32);
> -       if (cell && count > index) {
> -               priv->levels =3D malloc(len);
> -               if (!priv->levels)
> +
> +       /*
> +        * If present, "num-interpolated-steps" means the levels above ar=
e
> +        * just anchor points, and the actual table used for
> +        * default-brightness-level and PWM duty cycle is the interpolate=
d
> +        * table built from those anchor points. Interpolating needs at
> +        * least two anchor points.
> +        */
> +       num_steps =3D dev_read_u32_default(dev, "num-interpolated-steps",=
 0);
> +
> +       priv->default_level =3D index;
> +       priv->max_level =3D 255;
> +
> +       if (cell && count >=3D (num_steps ? 2 : 1)) {
> +               u32 *raw_levels;
> +
> +               raw_levels =3D malloc(len);
> +               if (!raw_levels)
>                         return log_ret(-ENOMEM);
> -               ret =3D dev_read_u32_array(dev, "brightness-levels", priv=
->levels,
> +
> +               ret =3D dev_read_u32_array(dev, "brightness-levels", raw_=
levels,
>                                          count);
> -               if (ret)
> +               if (ret) {
> +                       free(raw_levels);
>                         return log_msg_ret("levels", ret);
> -               priv->num_levels =3D count;
> -               priv->default_level =3D priv->levels[index];
> -               priv->max_level =3D priv->levels[count - 1];
> -       } else {
> -               priv->default_level =3D index;
> -               priv->max_level =3D 255;
> +               }
> +
> +               if (num_steps) {
> +                       ret =3D build_interpolated_levels(raw_levels, cou=
nt, num_steps,
> +                                                       &priv->levels,
> +                                                       &priv->num_levels=
);
> +                       free(raw_levels);
> +                       if (ret)
> +                               return log_ret(ret);
> +               } else {
> +                       priv->levels =3D raw_levels;
> +                       priv->num_levels =3D count;
> +               }
> +
> +               if (index < priv->num_levels) {
> +                       priv->default_level =3D priv->levels[index];
> +                       priv->max_level =3D priv->levels[priv->num_levels=
 - 1];
> +               } else {
> +                       /*
> +                        * default-brightness-level is out of range for t=
he
> +                        * table: fall back to raw 0-255 PWM scaling inst=
ead
> +                        * of using the table at all.
> +                        */
> +                       log_warning("default-brightness-level %d out of r=
ange for %u-entry brightness-levels table, ignoring table\n",
> +                                   index, priv->num_levels);
> +                       free(priv->levels);
> +                       priv->levels =3D NULL;
> +                       priv->num_levels =3D 0;
> +               }
>         }
>         priv->cur_level =3D priv->default_level;
>         log_debug("done\n");
>
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> change-id: 20260814-video-pwm-backlight-num-interpolated-steps-7d63c7728d=
b1
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Except the little nitpick that can be fixed while applying:

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
