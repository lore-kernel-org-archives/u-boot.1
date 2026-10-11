Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CD3CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 16:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E92D80DC0;
	Sun, 11 Oct 2026 16:09:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NWeTSldw1ITH; Sun, 11 Oct 2026 16:09:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3E50980DBB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791734969;
	b=IkbQ6Cmp7wmGF8x5O8VCcYIbpYx+NxlzhddTwMOlsCxAfCM5CyJOGuN8eVcv79jpwwnJ
	 raHsQIZirgav/kHHeWqEz3daKXSDXu/3G8RsE5NGfSa+68mNRvUYq5Jditbtu+M/TGjGG
	 5VvJ8bZ3G3BBMSiayfmnFWPecGQ+R9sxb51kYyoRI8F77DZgX2BwNNnSGsCRrv46YsZTq
	 O+qywtudVfHoSAUobTUw1pV1mwNtVGLzD04OLLm+iP6qGRVWAprpArwxdePJ3eXLJNiXx
	 3p42s/TZdBSb9J8DdtueUIureSRq5FCter6P55AFsLOXme7RlqHykpHxaiOGEmnQqbQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791734969;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=hVreMmSkMjFsmv7LmF7GpMfl0t+NxjTD7WIVOB+61nA=;
	b=M2WMSkXKnHIwdmOCo2PaBfluJq7iqREZZ3IVNReGFAzbX/HZz7fk6wNu7eUppVHzWoQM
	 pl5zbpgFfenVDEdkPfDtTt+lP9Cuvj6mgYmmBddoq6l8ZgGjmRny2h0PVE8xsyR7zevWl
	 ciPsahvjXirNQeKYdK/Sq6YC7z4Llnvs05UGw0KxP4bzvtj7zPj0oJ/5vtZDVD/1x+oWK
	 Qq6mdq/bECCcQgaLR3Zd1ZCE8VS7euhkuSxZNEFmSXdL4N0x418YY2tqprCx4nD7skGS7
	 /OBQZAs5lE2wngl4+03OvlC/Jpa9+CxXZCB1p6OIzt0MTWmXu+9slzMih9VaLo8QuyQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mF0foMew;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791734969;
	bh=hVreMmSkMjFsmv7LmF7GpMfl0t+NxjTD7WIVOB+61nA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jTE/tda7kHKaysn8KVFNpY6jgNODAOhI2Mh4Qb54WqXWc33KFPjCuJ2dJ1VUiIOnE
	 XcsBy48J/OHYHHPs7B6IUN1m8SXbWHBsVnG43s6LxJHOCo/oh3aMFLW5csXB3lt/Bo
	 KTpYd5d9Pkj+fUezkghJcyNqDBgq3NhCNq4J9D1fuvDWeXjDi0+uE1TrbeR9j1Owz/
	 S77MR4B6saI62wLTLQd6luYQFzye8xv84dzfpEEdDiDrnqUljDxfai0qfbTeFBfcC+
	 EHUzVQqhO5SQJDaSHtqrMaztZr7+bBVPJVu8NJMv2fRkRXIXgPjt1wP+NOjntKmsN8
	 v/0f48XcZhmUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E50980DBB;
	Sun, 11 Oct 2026 16:09:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 17141D5E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 16:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F175780DBB
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 16:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S6WzJGgrFOGT for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 16:09:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F18A280DBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791734965;
 b=b4Tvbk+LSsnVDAPkLxSu4jv+rv+g8EW/Lrr+uRXP76DGAtU8lv4jcPYSvQ/26aJwTZPB
 IO96yGZlV+w2ipUImDAEo+17TCcrITffSEO3bEHa4WjgULvcrfUACnMF4SaHygqBjjV72
 Y8Rm59rZotBLSaS88tWesoskDcPu+j3+UrhQ0zzKNeae0OVgZQy9XMfGAvbVHhpnoTSeH
 GpQaS63207rYRmgsnth9wZPPGRF7S3/Lj2GidmwrloELcVATWApPC6VnOyGmHQ0IHXkag
 F9cfuXpS2H8860YM0Zrl/x8MkXy1Z7nDhvD83zHb9UzFT1JU/MjRFwJDCNayZ+frHSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791734965;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=hVreMmSkMjFsmv7LmF7GpMfl0t+NxjTD7WIVOB+61nA=;
 b=PAUMVlMm1Q6keSc4ITK7LS8j+UMH8uQiIxPaTVEQWQ5kuCK8Pb4R9Or3DUSmF5FN9/X3
 MUGstGYuoOWfwnx5WBKTEAFeSwv2qojVmCW4kF6zzFJCzSrazs7xNuyvlgbaql2jyd4eW
 eMH5JCjNXQgyE+kYBoaaOwgFpuo733kfL/P0f1M/rSiW9jUbhNrSYZmQsQJpSmDXR1hNe
 VynmzgMLFAR3JHIQSP3xfzDlkPQi1amRNF+C1gs49jD/2qkloIqVVuOHCOkya95zdn+kM
 CK3dQU8+rZQEG0Z4L6G0/nbTId+d5YYy5mton1kU1CvJwuLzgIJkQT/zHSjCpkP2zyA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mF0foMew; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mF0foMew
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F18A280DBA
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 16:09:23 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6afe29c08ccso1291804a12.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 09:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791734962; cv=none;
 d=google.com; s=arc-20260327;
 b=bFUwKlfGFD6gWbtq0IkWqb4bfv2iDljn8ezR+4MwBz+rUxkF4hBjsIVWcMlvsH/4MD
 q3XHdb52W+/k20p0uAU9tGpQtRlEU8USrN90ACLWbplUyucJBZBDBUNcCfmk4XXMH1T0
 dvxry/MQ/uAJbVJlAlBJe189zqsjD6XVw8x4yR8vYKtrlniJvsTjrfUU+ESLbgk3rOV+
 s1o2bGQ7ESSwhre8wTpOY1WrFo+5VSc6WdORgQJPr1BLrt3g8F/pPD0FAn7zJvNfO4hi
 eqT5L3sSQlB6FnyRekzItPJIaZHJNdYhBRgIKuvsF+f4TtKnxyMTzL6J6BK0L+J3XfQc
 9qgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hVreMmSkMjFsmv7LmF7GpMfl0t+NxjTD7WIVOB+61nA=;
 fh=jud5WZhW7RxTTKqG5yqjvkc+Kr7ARYMaIia0XlqRUHM=;
 b=PTju7vDA6d9gNGQt1vTiWfP0e3M0xxkYp0eZlr7Jf+7IDndcOC0GEIJwf4ATyNi7F+
 v8yTHODYhqio9CitKiTdg46kZYXurINvN8GVRYYxLfUbFg6nocs1hxoU+8j63SxRaQMY
 KVR3xHQz8xCmyup+HmMeXqsMXF4pxz8d1ZKb+KaDJa7n2XgBbSqDCKCgKJdSSCoJfpM0
 bDEdU0R/4hA1YGyzNocqARTbKKd0tkqbIIOR+/12uqAhgh2ki8gTg9ETTdhq50p0BZld
 /SvYRNz7MGhQ7lYj5L0Z3TThqEfVvTcBqsDZKTKXqW0itvlTs8nSlXTHwcb393bcuCJy
 RkEg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791734962; x=1792339762;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hVreMmSkMjFsmv7LmF7GpMfl0t+NxjTD7WIVOB+61nA=;
 b=mF0foMewtDLhPY7hSEr8TuYECINt+pnX7fFhESy+Vt3GJwJ1wKj6pxtJhTziKf/KER
 /NMvr/gGXLhOdTHvxFsH7VSQ+cYdEojhwjwaM8R47k9CySe7bATvrEiQVOG462IgNlul
 aWink3JUHhb1Gp+BNLfhh19o/y74bpdsI0+bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791734962; x=1792339762;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hVreMmSkMjFsmv7LmF7GpMfl0t+NxjTD7WIVOB+61nA=;
 b=hOTpP/S975UGlm9XxA6tZxqosl4jKoFYvFu8iou+34ynBszETYmfn65W27Q12KKIve
 GswP8U88DXkjr2qFYR0MOohPIflhnCn/L4xB619GlTMxfNHdU3R8Hv/ng2vnwwo0YhpU
 59lpKZTAX9hq7+qpyYHG0OEUHHzHlkSOSUj5Bx4xxczQIiWcFWAKw27nGGmR7vrkz5RJ
 1JUTXyOWI4dRJMzb0VI3QBKagsKILtbIrovflI4qUGA7gXHOW/i5QrfJZ+0KKMX3NefJ
 99wfLnmajgKk0xEB9mXYuhohd/J2UZQZ0hR4tvQMWrq2dFwu/Fn4V7XApUtenG3plzuy
 iyyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvEPcvV0e3QFqfqAe8LCc6yqnIqEyMp4b0RFVqShiebHBeXa3ks+PRG7FMfQbwNdDy28cY3S4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKIkxe9f7Ie842G0BkQR2+ih8QoYvvRKYr62DoP0muYviC6uvji
 pmlsQZD0kEpt6zIoHK+ryK46AUJNeoTQemFuY9YRYgxzGnn+3oEoQM80Zf5khDvUftCysuwv1ry
 z2CY+4cu+7PQOor+3NF9lL/JFJ9wa5uDzLKOecxiz
X-Gm-Gg: AYBFou1ZUC8O3rm4RrSAZm101MQdKDu/3BhSDC3SDSqdYlHITLog0suE9nGH6c/VqIu
 84Yyat5zLkFYiRyp4HraKbECu2zJqICuETD99YiP9mvtjwVyZ4JGuOjRbzxwhZZV2WSeszcrCai
 pi6HqVs/FEkrKk1V+Mm6eEssMFOQNLXNyM1ySyK0geRfPeX9HASTQJc5pBTadQ2GM1+lwprmD3/
 Ee3n58o0x0R9qExsYju13g7ktZn/OOgefG/qvpA8fZhDoEmpfD7+vDvALBbbi8AbcZaGl85WP8P
 gQpvW2CwhyRKHjHfic89ER/dcWKn1x5sUTe/pe7S+sHr5EC5qasNtOMO
X-Received: by 2002:a05:6402:42c8:b0:6aa:9fef:641c with SMTP id
 4fb4d7f45d1cf-6b17c2cbe9emr6687225a12.28.1791734961892; Sun, 11 Oct 2026
 09:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com>
In-Reply-To: <20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Oct 2026 17:09:08 +0100
X-Gm-Features: AclHuK8PV0Cg6OQBF4O0f_6qGkA91uev9ghiZxxyt0EoGUSBSUG0zqbX-vl4pDU
Message-ID: <CAFLszTj7kB=JkLx1ws9QbKX682ZiYyy8LHJywzVq_pZnObbUQw@mail.gmail.com>
Subject: Re: [PATCH] video: use bpp conversion helpers consistently
To: imkyufie@gmail.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Eugen Hristev <ehristev@kernel.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
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

Hi Reza,

On 2026-10-08T13:51:38, Reza Kurniawan <imkyufie@gmail.com> wrote:
> video: use bpp conversion helpers consistently
>
> Use bpp conversion helpers for consistency and to reduce the
> reliance on the specially crafted VIDEO_BPP* enum values. No
> functional change is made.

Thanks for doing this!

Please can you name the helpers here (VNBYTES() and VNBITS() from
video.h)? It would also help to say that VNBYTES() is only correct for
8bpp and above, and that every site converted here is 16bpp or 32bpp,
which is why there is no functional change.

>
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
>
> cmd/bdinfo.c                           | 2 +-
>  drivers/video/atmel_hlcdfb.c           | 2 +-
>  drivers/video/imx/mxc_ipuv3_fb.c       | 2 +-
>  drivers/video/meson/meson_vpu.c        | 4 ++--
>  drivers/video/mvebu_lcd.c              | 2 +-
>  drivers/video/sunxi/sunxi_de2.c        | 2 +-
>  drivers/video/tegra/dc.c               | 4 ++--
>  drivers/video/tegra/tegra124/display.c | 2 +-
>  drivers/video/ti/tilcdc.c              | 4 ++--
>  drivers/video/tidss/tidss_drv.c        | 4 ++--
>  test/cmd/bdinfo.c                      | 2 +-
>  11 files changed, 15 insertions(+), 15 deletions(-)

> diff --git a/drivers/video/atmel_hlcdfb.c b/drivers/video/atmel_hlcdfb.c
> @@ -315,7 +315,7 @@ static int atmel_hlcdc_bind(struct udevice *dev)
>       uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
> -                             (1 << LCD_MAX_LOG2_BPP) / 8;
> +                             VNBYTES(LCD_MAX_LOG2_BPP);

The subject says 'consistently', but a few sites are not converted.
atmel_fb_lcd_bind() in drivers/video/atmel_lcdfb.c has exactly the
same pattern:

    uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
            (1 << VIDEO_BPP16) / 8;

The others I spotted:

    drivers/video/sunxi/sunxi_de2.c:221  (1 << l2bpp) / 8
(efi_add_memory_map() size)
    boot/fdt_simplefb.c:62               xsize * (1 << bpix) / 8
    drivers/video/video_bmp.c:322        1 << bpix             (VNBITS())

Please can you convert these too, or say in the commit message why
they are left out?

Regards,
Simon
