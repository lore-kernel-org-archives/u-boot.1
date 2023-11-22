Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90153C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 19:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7ED88763C;
	Wed, 22 Nov 2023 20:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wp3YPgzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED27487633; Wed, 22 Nov 2023 20:05:13 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 314978763E
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 20:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-548ce39b101so155589a12.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 11:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700679909; x=1701284709; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sT3PXe4L2h/CZTIX3O387dA7+GwoG4L4LpDupq3cmq8=;
 b=Wp3YPgzzigsaDD/5fvhpuvIaCgaTCT/BfiRJ7d+Wj9qdcGynCVbFkYvP8jbOZ5+xUI
 pgyQ8I3DCi12IP9A9fCiLrzIbj4WpWJudP8rtwtaJnQ82bgMpPu6TBn/bLtpeC2oVEGY
 c9nt5Oexopc/LR8qANz3xTyK8l7ZHtna/ffyr/g5k7JEYcgvoGr+qm1PbNk1KX8zW7ph
 +F061aQYyUqNw5ASKBhz5ZEDp99YwSxf+0lYtsKZLD0FqTv/yDvQrX56APcYjIO/ubme
 Z+X4ODiquU2yIINPE++/G0or5Yod+6UgoAb14ofRZEGaBiWT36qIM0wiPdjlOBbahn31
 Lqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700679909; x=1701284709;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sT3PXe4L2h/CZTIX3O387dA7+GwoG4L4LpDupq3cmq8=;
 b=R1MQZlbXakDh0/1yEJyoUIqppYpYUtG47aBuPQJ0KUmBjkqV1AV9HphH74Y4JMV7Ke
 HV8mqtGhOUpZwzFPRMs6ZnSUipawn2Lk+2EaDqDXLOQzMmYe6VttSr09cG6x3Ua18RyG
 HU8FTbIfRgnWMi8vTqq1QbG07NcOpAx3KceyvxTw/s57WEXcAC7YuBATB+oEF6B+K+rd
 2AOSB1n2U/eaCab9NBVcHSwhQAk3MRShL8aZEMAOmGfsM/eunRtIP4d1apqGP8K3+Kqq
 xFnXTuuvNuIPIVl0vBJjLndhHgQ4ThaZ/cdZHKsFa/25DUpTLJtEw76+OZvSlIenyfTF
 qImQ==
X-Gm-Message-State: AOJu0YzALKu3TTkTK0/ctr5TYvuVz1XkasRA2i774NP2CiDo7H9n7kNv
 TnqazGPkndZ/pSTwsP7/S5xrrn5lo+KhpxPxw+M=
X-Google-Smtp-Source: AGHT+IHzoiiEHCKHBGrFkU/wWBiLBOOylzdHiPhXUTCk3LlaATGmSXT945eLOyniDBJwjC25960xUQsVdxQH5BxZncU=
X-Received: by 2002:a05:6402:2683:b0:54a:9400:1ad6 with SMTP id
 w3-20020a056402268300b0054a94001ad6mr942059edd.33.1700679908647; Wed, 22 Nov
 2023 11:05:08 -0800 (PST)
MIME-Version: 1.0
References: <CAKRNjQ3YjFQGDmGmowbtbFnpAn7k3nHfbwqpx0_BX-+v_kQkzw@mail.gmail.com>
In-Reply-To: <CAKRNjQ3YjFQGDmGmowbtbFnpAn7k3nHfbwqpx0_BX-+v_kQkzw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 22 Nov 2023 19:04:56 +0000
Message-ID: <CALeDE9PGCWz6tNFGi9F9xwHjL6Cv0W3_4GPKUDVWhogy+_fUxg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rpi5: initial support
To: Dmitry Malkin <dmitry@bedrocksystems.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, mbrugger@suse.com
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

On Tue, Nov 21, 2023 at 10:55=E2=80=AFPM Dmitry Malkin
<dmitry@bedrocksystems.com> wrote:
>
> rpi5: get_board is no longer works. Print model name from
>  FW FDT

Diito

> rpi5 deprecated some calls/tags for MBOX. Better to use FW FDT.
> However it does not give all information.

Is that deprecation documented somewhere, in a forum post or something?

> Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>
> ---
> v2:
>       new patch
> ---
>  board/raspberrypi/rpi/rpi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index cd823ad746..6b678c5d23 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -429,6 +429,7 @@ static void get_board_revision(void)
>      int ret;
>      const struct rpi_model *models;
>      uint32_t models_count;
> +    const char *fdt_model;
>
>      BCM2835_MBOX_INIT_HDR(msg);
>      BCM2835_MBOX_INIT_TAG(&msg->get_board_rev, GET_BOARD_REV);
> @@ -437,6 +438,11 @@ static void get_board_revision(void)
>      if (ret) {
>          printf("bcm2835: Could not query board revision\n");
>          /* Ignore error; not critical */
> +        if (fdt_magic(fw_dtb_pointer) =3D=3D FDT_MAGIC) {
> +            fdt_model =3D fdt_getprop((void *)fw_dtb_pointer, 0, "model"=
, NULL);
> +            if (fdt_model !=3D 0)
> +                printf("FW FDT model : %s\n", fdt_model);
> +        }
>          return;
>      }
>
> --
> 2.40.1
