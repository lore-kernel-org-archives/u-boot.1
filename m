Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A33C1094478
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 15:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FEBD83FF5;
	Sat, 21 Mar 2026 16:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W/ohJatl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9756283FED; Sat, 21 Mar 2026 16:02:29 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AE383FA7
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 16:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b980b35534eso487442066b.1
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 08:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774105347; cv=none;
 d=google.com; s=arc-20240605;
 b=W70sVhsMo8YbLoMBHwM72zFAyYiIigUmJO3+67h7AL1kzZISIOxvMG1bhHD58Rid9t
 FbcwxDgIept//sx8rBsp4YMEH0QpnleTBPVmWM/9B+W14tSAgu58LyGaQtFKIsDjyV6j
 iWAcMBxOeZi+ly7zKO48V6Ugptzs4C2EzN/cwHqzdZhBs2jcD6YpuWgqyB+XzjDxSB0H
 wV2k9AohevfgYTQCGuF9HCQoa7EVaROwXsPDzy8OjkSBQXigsBbzmZFZiPpV+2TAoTg/
 oW3G494FkDttEOrcOjIf4q1nPznPcdhtuZ/95TOO5Dl7Tr93WRnmJsp2ALRbk8E4Xpqh
 Zxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9RhPAmZ+tq9gzid7QAuIIDks39OuZiJ4LGw1HPdDMyg=;
 fh=ToXak3o3FxKjeN9zN6KF+Y7XD0fq/gRTAn22wDFBJO0=;
 b=cHYtIij9d+g64N4FLlx+msCcyqTAGcQIbBJVbSntMfkjoVCOIiwB64JaMUQWJ0+tG9
 V7RbE5FRwskHLK4yjbeerWf+ol/H5EXAwTGDPzolgdmvmvg+exAYSei8E/ePvYy0k3oz
 RpR/admbPxB/XhYZ9CaxYTw22Pl9axkipbOBeG1PnBsbFKsiHuBWHV8Whq3o2MNjpvIF
 Hnxl3f/F22z0NEv2zJ5ujH8W50moKJfpFtTrGHK0SD7w9Eiwc+tUtfTcuVUC8tzxL7zl
 wTwYkXDEOAvtVrv3A9j8BOmW9hVRr9yF0SJVSPvSeDfhBlIygnHHqlCpW9WmKXHVth1U
 zUbQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774105347; x=1774710147; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9RhPAmZ+tq9gzid7QAuIIDks39OuZiJ4LGw1HPdDMyg=;
 b=W/ohJatlMspJMiRSQQcVLseUKQ5aeyw+ddQ9ltcArbIA7/QuE/gI3yoGrW7C5KvNF2
 Yieto4O6yYPpSiIoq/KqWKLDbhxZaNa1IR3zifF1/lGfRhhnWcgpA9IasuvamUjXpFKw
 jVZhCiCRWerVMfKXSNV9I6rxOWjWQ8yZul2lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774105347; x=1774710147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RhPAmZ+tq9gzid7QAuIIDks39OuZiJ4LGw1HPdDMyg=;
 b=evRadUVFJb1RGbMwFatCFssct2BJaTrt7E3CcrLHn7m0cso+PcLKNPjA7oudeEXfsw
 9F1yO0TI7GVA1NzfxhLxyFrST4sIpqOOqKrZ/jUnZN2+hS1qSBAZ8px+CXWcCSorCXRJ
 wGncPOzKORQlMvzxLo4itE4Zhjo0yuI2ZQ3w7khnvSUU9YZLpX8UPj2DrwyMDHXnufK5
 XynfY2ELY15JhSyOqTPbF21k1c6z2v7m5IJd4CDMHYCc+kXqK9SKX3ZKoi5eVdTAsUi4
 eCfT51avf+q9S4s5T1o1D8RZ4VHkuyHf/E+7j0+ihcJ9FDocUBVUU30Eci5HRpQ3vRL0
 1CJA==
X-Gm-Message-State: AOJu0YzVli7Dn3x4wvLIbP3Crcd/9cxGlK+YGs//jcyEaF4lyKfRcPtH
 oLusahzdZgFQ8/RYneimJh0+kPL8ELo3EigYbzSw7oKSOg7RA4Uvf06+NWbRln7je9nVCjwU0Jo
 E3NOLsdh/x0Pppe342FnU3O7sKU1vt5chRmgDZrL/
X-Gm-Gg: ATEYQzzh6yLlp2BL37N62fzGyM/AXqsSe0+nh6eLt4De+MNpBjapnCSyqZzdVCZ8KjE
 jLJtsKlYfVJbexUGM637OVXzjs+PDTw2wRr7c9TYeLMOK7yR1d43dxegwXhyOHXEyVlmvFPEMke
 erhRBTVVrzmnc5gb2BV2fvQkveJiIIboKMsRcioJ4T+7xwdbTvZR2AvfzoIertVhVkbZBJ/hWp2
 zycJARvbO5gl1RNB1dcquOY/GEjbjXNg7hNFvlWaglnWdp+kQrGyb0+IZO5YfdYbjV1xP6fGCFo
 9yUbWzc=
X-Received: by 2002:a17:907:398c:b0:b97:a4b1:51b4 with SMTP id
 a640c23a62f3a-b982f59564cmr416374166b.17.1774105346898; Sat, 21 Mar 2026
 08:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs94EYWoVAyWXexA=f_UwqUpo9zuxO6G6Tx7L7xPdciAVHW5A@mail.gmail.com>
In-Reply-To: <CAJs94EYWoVAyWXexA=f_UwqUpo9zuxO6G6Tx7L7xPdciAVHW5A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 21 Mar 2026 09:02:13 -0600
X-Gm-Features: AaiRm53NeuUQlkQGTOEvfDurG_XjXPKs2dojCRYu8EAcdtxOmhQUeIGkwKohygE
Message-ID: <CAFLszTjDnEoTP1fHdounqov_SYSDdr-Zpt7L_+-c9qb=c0F8JQ@mail.gmail.com>
Subject: Re: Need help with FDT overlay
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Matwey,

On Sat, 21 Mar 2026 at 06:55, Matwey V. Kornilov
<matwey.kornilov@gmail.com> wrote:
>
> Hello,
>
> I am running U-boot 2026.01 with orangepi_zero2w config and I am
> trying to apply my hand-written dtbo via fdt apply.
> The issue is that the fdi apply command just hangs forever for me. The
> issue only appears when I try to append a new node to the root. How
> could I find what is going wrong here?
>
> The overlay source is the following:
>
> /dts-v1/;
> /plugin/;
>
> #include <dt-bindings/i2c/i2c.h>
> #include <dt-bindings/gpio/gpio.h>
>
>
> &i2c0 {
>     status = "okay";
> };
>
> &i2c1 {
>     status = "okay";
> };
>
> &{/} {
>     i2c_gpio: i2c-gpio {
>         compatible = "i2c-gpio";
>         sda-gpios = <&pio 8 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; // PI0  (29)
>         scl-gpios = <&pio 8 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; // PI15 (31)
>         i2c-gpio,delay-us = <2>;        /* ~100 kHz */
>         #address-cells = <1>;
>         #size-cells = <0>;
>         status = "okay";
>     };
> };
>

Can you provide thte dtc command you are using to build this? Is there
enough spare space in the dtb? I'm not sure what would cause it to
hang.

Regards,
Simon
