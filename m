Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520AED25031
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 23:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BAAB839E2;
	Mon, 12 Jan 2026 00:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 792A883A41; Sun, 11 Jan 2026 20:34:32 +0100 (CET)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BD1383A3B
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 20:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7caf5314847so4007657a34.0
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 11:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768160068; x=1768764868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GkYn852Tu9q0tPkoFGT8vCSdPljgd8X3NYVvGE1Eo3g=;
 b=QNfTBj2sCzfGNT16WRUZP4ATxbPCOh5YYShuDvHk29QdxKKKcqsTl10PA92FNThHmw
 eXNyDheMdOvSZP+xn7J4KfYavJdnmMxtZECXfSfh1zVrZmSADeudJQI1yu0PbutQqAx3
 xAeSgxmu00QTS4bO0ww0I8mg/L/wdvfg/+DZdCzFgKy+hIvWXP6WSG9mMtvvDJZM3eTp
 qKgKHiVKn14zXxdrUje1QNeLdLXyeGGvyjhUea5toce/nDJLwniH/zFbSX4vNNtAvPql
 F8okOE0ga3XcHGMUzWrJroEgQcO8Xws3YghdX3+yK9Y5O3OJwuoQYVaugRN7YrNOaZ70
 mSnQ==
X-Gm-Message-State: AOJu0YyAbf582cDwqQl2SPVpCVBoQU/1Z16fC0u8i+i033ctII+sPdgi
 1AV0TkRYUmcsmE3xMc+TyCKCciQK1kFhDDAuYuOhNiRVD5SBAIO+ech+XZslXA==
X-Gm-Gg: AY/fxX6UpvS1TzvDFH3KxKE8dtEDi3nUaX4UsK1+zTG0QRPa+NFyfwG4oaVB3T9j7ap
 SAa1LBKoFRuZ4Pd0IfmokGkX2WLUXmGtrXNO4Z/jvPkBdZyCKzUiR4ZDshnUEWUPYifIh3f+fyo
 7l2S3K2QSHloX+DqMNeAInmPHymVHTv/HTzb5KvqXo2mabQkaH6r4aRX+Ze7h0/GnBkOWEXjtqE
 8+KZ5R3BPpiJhnJY8hj8bGLwlfWK9LtOrDwbxy2ECaFjUFx+oYNJTMZhlLcaBBH4LsjHTEFgE88
 uIIdOYXghGygO2KdGct+P/4VYTJsbTanXf7zcWu1k4tMZyftV/RM6b/FB7txm11gGdwo77fu+3f
 TRHRgQE3i+e1UTYyinY0opDOp3kxEas7x1VT1F172th3R1d3Dft5IUPLI5HwgM1/zCPx2T6wl50
 wesVHqMsgh0s5EE6UBaoTqx24QZ9Om85PVRUYqenHq9Vwp2biNk+SOazAh/KndYTtyvfrimHV/F
 P7K+SBnlbY=
X-Google-Smtp-Source: AGHT+IHcOO+4xmg2W+3KLfXZzXKL3vhfZCl7z2auoL44TJ304d3GNjF8R+bh8ll3DDTg/8RTBRpZBQ==
X-Received: by 2002:a05:6820:16a5:b0:65f:1038:1317 with SMTP id
 006d021491bc7-65f54f76ed2mr8721391eaf.70.1768160068149; 
 Sun, 11 Jan 2026 11:34:28 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com.
 [209.85.210.49]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48cb1444sm6617673eaf.11.2026.01.11.11.34.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 11:34:27 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7cac8243bcdso4023139a34.3
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 11:34:27 -0800 (PST)
X-Received: by 2002:a05:6830:4995:b0:7c7:827f:2b6b with SMTP id
 46e09a7af769-7ce50bfdec9mr10107663a34.38.1768160067563; Sun, 11 Jan 2026
 11:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20260109-usb-dwc3-apple-compat-linux-v1-1-b6e255b5e5af@jannau.net>
In-Reply-To: <20260109-usb-dwc3-apple-compat-linux-v1-1-b6e255b5e5af@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 11 Jan 2026 14:33:51 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8EMWmwyMMXM-82PbXvLKdxUz9Jxus33dxEAZ8eRRxz3g@mail.gmail.com>
X-Gm-Features: AZwV_QiswhMQh-OfNIc-ljra59Z6BdVFFswTCuHhAUK8Tp-IsA-zsBu1qCLV9X4
Message-ID: <CAEg-Je8EMWmwyMMXM-82PbXvLKdxUz9Jxus33dxEAZ8eRRxz3g@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci-dwc3: Add "apple,t8103-dwc3" compatible
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 12 Jan 2026 00:29:36 +0100
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

On Fri, Jan 9, 2026 at 2:41=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:
>
> The Linux support for dwc3 on Apple silicon SoCs switched to using a
> apple specific glue driver [1] that uses it own compatible string. The
> glue driver handles platform specific requirements on the interaction
> between dwc3 and the USB2/USB3 PHY and reset-controller for USB role
> switches and plug events.
> To keep USB working as before when the nodes still carried "snps,dwc3"
> as compatible add "apple,t8103-dwc3" to the of match table. Eventually
> it is probably advisable to add a dwc3-apple glue driver and write code
> for the currently empty Apple Type-C PHY driver in phy-apple-atc.c.
>
> Link: https://lore.kernel.org/asahi/20251015-b4-aplpe-dwc3-v2-0-cbd65a2d5=
11a@kernel.org/ [1]
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/usb/host/xhci-dwc3.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
> index e3e0ceff43e6abdb8643f265819eff28c2c802f4..ba42c3247654b7d9272c42ea9=
c4cf0bd9082915e 100644
> --- a/drivers/usb/host/xhci-dwc3.c
> +++ b/drivers/usb/host/xhci-dwc3.c
> @@ -238,6 +238,7 @@ static int xhci_dwc3_remove(struct udevice *dev)
>
>  static const struct udevice_id xhci_dwc3_ids[] =3D {
>         { .compatible =3D "snps,dwc3" },
> +       { .compatible =3D "apple,t8103-dwc3" },
>         { }
>  };
>
>
> ---
> base-commit: 127a42c7257a6ffbbd1575ed1cbaa8f5408a44b3
> change-id: 20260109-usb-dwc3-apple-compat-linux-821ee75bec48
>

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
