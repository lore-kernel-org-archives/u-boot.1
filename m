Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C03C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 04:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 705E6879F3;
	Tue, 23 Jan 2024 05:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QFuclqif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01CB787B4D; Tue, 23 Jan 2024 05:34:02 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6BD8879BD
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 05:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wenst@chromium.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2cf12a9be5bso2077381fa.0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 20:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1705984439; x=1706589239; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fpiz2A54QRhe37lVRRR8z+JmkotZidReuWN+CE14T0=;
 b=QFuclqifA4G49jI5hbfKWz/DqubmW52HCQntIXHzI8dNOUPxgqRzVKAQyfhlf6ZF1c
 nsoaAhuP325zUQiRE6PoUYavUgMalEYt9hQKiI9Y59L/DiLDUAAVzNFLEgLWGLupI6m3
 Sxgq/txxSaAfMlhamFeiY0RNlkI4kbxHe0V3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705984439; x=1706589239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fpiz2A54QRhe37lVRRR8z+JmkotZidReuWN+CE14T0=;
 b=kkbXwehpJLdsstDG/5qfg8y0K4b7FIjuikhzxZlzDXsecfhuOJo6+6BSD/OUd8CJng
 40Dc6iVZSmDjqLDkge/4Ikyk1Prp+3Q4fjInEbBJ9AB0RWAS+UsByvVZeVbL9bg7ss2t
 rhJV1knX+H17RLGkSJNhSzLU4LjqmooJahPvEQIz7ZEzpSpWoz2ATReZ4bqU5kZkuF0w
 gdV3DgMN7v0Ia2KiDOx5699NsZCW1fBgKZlicugxVtUF9zmxOJ9dfS9HNpjQ60dVIGJM
 LJTHmqOSaYYR/A7J8drng+sHd/kXEunytmyqUPDkCUQU6sB9Vsv5poG3LmAYb4eJPcHr
 IAkg==
X-Gm-Message-State: AOJu0YzZUnq5PwhyDx+PJ+26aeBZHY8Lxlje3HV2NxygP32LiW0oVTpr
 /2q+EzvhTQASz1txTGJS+AydTo4yRJxSfpPM5zoTnsBew48RM9jyWGvsfi2Q4YxtIK+t0gKQq0+
 1wLeouxPse/+5j/rcufO5J1slq5bvi9XBIVbe
X-Google-Smtp-Source: AGHT+IEFZiP3VZh9dZSYVnIrD9Zmvm+6ciXc+5+kY1cyuxE16sjwxN25kz5VAIq7Xyt54xznofc5cPN3A54lHixtWq8=
X-Received: by 2002:a2e:bc86:0:b0:2cf:725:f93 with SMTP id
 h6-20020a2ebc86000000b002cf07250f93mr478520ljf.88.1705984438922; 
 Mon, 22 Jan 2024 20:33:58 -0800 (PST)
MIME-Version: 1.0
References: <CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uPMH_9sTF7Mw@mail.gmail.com>
In-Reply-To: <CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uPMH_9sTF7Mw@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 23 Jan 2024 12:33:47 +0800
Message-ID: <CAGXv+5F6pkYg-EJUDUVN5CnUbFcCpar-q5EZFQsiV1CRMhP=Cw@mail.gmail.com>
Subject: Re: Proposal: FIT support for extension boards / overlays
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tom Rini <trini@konsulko.com>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>, Andrew Davis <afd@ti.com>
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

On Tue, Dec 12, 2023 at 10:06=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi,
>
> The devicetree files for a board can be quite large, perhaps around
> 60KB. To boot on any supported board, many of them need to be
> provided, typically hundreds.
>
> All boards for a particular SoC share common parts.  It would be
> helpful to use overlays for common pieces, to reduce the overall size.
>
> Some boards have extension add-ons which have their own devicetree
> overlays. It would be helpful to know which ones should be applied for
> a particular extension.
>
> I propose implementing extensions in FIT. This has a new '/extensions'
> node, so you can specify what extensions are available for each FIT
> configuration.
>
> For example:
>
> / {
>   images {
>     kernel {
>       // common kernel
>     };
>
>     fdt-1 {
>       // FDT for board1
>     };
>
>     fdto-1 {
>       // FDT overlay
>     };
>
>     fdto-2 {
>       // FDT overlay
>     };
>
>     fdto-3 {
>       // FDT overlay
>     };
>   };
>
>   configurations {
>     conf-1 {
>         compatible =3D ...
>         fdt =3D "fdt-1";
>         extensions =3D "ext1", "ext-2";
>     };
>   };
>
>   extensions {
>     ext-1 {
>         fdto =3D "fdto-1";   // FDT overlay for this 'cape' or 'hat'
>         kernel =3D "kernel-1";
>         compatible =3D "vendor,combined-device1";

I think the example would be a bit better if the extension compatibles
were something like "vendor,device-X-feature-Y", so as not to be confused
with device-specific compatibles for the configurations.

>         extensions =3D "ext-3";

I assume this means "existence of ext-1 makes ext-3 a valid option"?

I think a valid example would come in the form of:
- ext-1 as a M.2 E-key hat, and
- ext-3 as a WiFi/BT combo adapter for the M.2 slot, with BT UART and/or
  GPIOs described

>     };
>
>     ext-2 {
>         fdto =3D "fdto-2";   // fdt overlay for this 'cape'
>         compatible =3D "vendor,device2";
>     };
>
>     ext-3 {
>         fdto =3D "fdto-3";
>         compatible =3D "vendor,device3";
>     };
>   };
> };
>
> So FIT configurations have a list of supported extensions. The
> extensions are hierarchical so that you can have ext-1 which can
> optionally have ext-2 as well. This allows boards to share a common
> SoC to add in overlays as needed by their board. It also allows common
> 'capes' or 'hats' to be specified only once and used by a group of
> boards which share the same interface.
>
> Within U-Boot, extensions actually present are declared by a sysinfo
> driver for the board, with new methods:
>
> get_compat() - determine the compatible strings for the current platform
> get_ext() - get a list of compatible strings for extensions which are
> actually present
>
> The extension compatible-strings are used to select the correct things
> from the FIT, apply the overlays and produce the final DT.
>
> To make this simpler for the common case (without extensions), we can
> allow multiple FDT images for a configuration, with the first one
> being the base SoC .dtb and the others being the .dtbo overlay(s) for
> the board:
>
> confi-1 {
>         compatible =3D ...
>         fdt =3D "fdt-1", "fdto-1";
> };

I thought this was already supported? At least that is what the FIT image
spec says:

    Unit name of the corresponding fdt blob (component image node of a
    "fdt type"). Additional fdt overlay nodes can be supplied which
    signify that the resulting device tree blob is generated by the
    first base fdt blob with all subsequent overlays applied.

> Comments welcome.

Very happy to see this. This could help cut down the DT duplication for
some of the ARM Chromebooks.


Thanks
ChenYu
