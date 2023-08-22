Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C56EE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9277C864E9;
	Tue, 22 Aug 2023 20:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZAzb7PlX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63C12864EB; Tue, 22 Aug 2023 20:58:09 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86FE0864F1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-56c87f89178so2970392eaf.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KIKr8AFidWTikOtQEOunoA/y0OsaSNaOVqF7Jec4hYs=;
 b=ZAzb7PlXzkjGEKJTIwuxG2cdv4aGrpCANQNE9BUxTyA0TCYSvLw4QjDkr5lc1S47GP
 PPXjVo4XEb4e6E79sRqlnz7p5THHtYjKDnBh9rDEz8we9WEoW/c3NMzmwo4jxrY+yMzi
 C6H6aEkBKmUoOxgZFa+BI+jm9v+UMDeikLOaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KIKr8AFidWTikOtQEOunoA/y0OsaSNaOVqF7Jec4hYs=;
 b=LNAOawV2RbeGW4IUp6t7zaeuwX7RlluawIuZutWQrKeA3p6rVmmchJjWbR+9Svgkxn
 re6k+3+9g7SAibBqqF7Si7ZA0pzWiIAh4cS8qClN5h9aXPwnZg1nhnX7g3CuEv+Rhbms
 VvNs1dIpKSrbak4/nehvEvVOmE+jZ8Hm4rPorhUligzbbJVDme6OKZ4TsTvlAtuJaZWl
 9k6pn4EErXVA2uaugEe4eOjasbP1DFuVPmj2Ah0X6qdRRzeOb2G/e3kZ8/vQ0rm96j8f
 9AYlSbxzUdxVkJ1qpiyXh7K/TLdRQGzdLcW7WKhSpcTxoslNIEC1C8xYEmIZWOLeJXCq
 g/eg==
X-Gm-Message-State: AOJu0YxCr/9XxTKxHEpinU1q1NeZk/EaglVb0gKiePXMosn1QL/0HY8V
 0FU3jvWs0qvfz/r4obpVX+j5Jl0Td46Bju3+af7Jag==
X-Google-Smtp-Source: AGHT+IFng2vtcHcGlSsF19aWxmrXrxaH5jTjWSuP2DCikScmjhs+9yJ6O1qXdwjTv8XxAJReTtWIeAchRo7F2t0rgq8=
X-Received: by 2002:a05:6358:9986:b0:13a:319f:a56b with SMTP id
 j6-20020a056358998600b0013a319fa56bmr9114398rwb.20.1692730678875; Tue, 22 Aug
 2023 11:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-5-alpernebiyasak@gmail.com>
In-Reply-To: <20230822121026.1007105-5-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Aug 2023 12:56:35 -0600
Message-ID: <CAPnjgZ0uez=Wj+_G7nrz8iknuc_Tn56TdHjSS2R_73h5-FrJvA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] qfw: Add flag to allow probing before relocation
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Asherah Connor <ashe@kivikakk.ee>, Alexander Graf <agraf@csgraf.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

Hi Alper,

On Tue, 22 Aug 2023 at 06:10, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> QEMU firmware config drivers need to be probed to bind the ramfb device.
> The ramfb driver needs to be bound before relocation to properly reserve
> video memory for it, otherwise it cannot be probed after relocation. Add
> the flag to probe QEMU firmware config drivers before relocation so that
> ramfb can work as an initial vidconsole.
>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
> Alternatively, I guess I could default VIDEO_PCI_DEFAULT_FB_SIZE to a
> higher size with "if VIDEO_RAMFB". But it exists because "PCI drivers
> cannot be bound before relocation unless they are mentioned in the
> devicetree" and qfw is in the QEMU-generated devicetree unlike those, so
> I assumed this would be the preferred way.
>
> Changes in v2:
> - Add patch "qfw: Add flag to allow probing before relocation"
>
>  drivers/misc/qfw.c         | 1 +
>  drivers/misc/qfw_mmio.c    | 1 +
>  drivers/misc/qfw_pio.c     | 1 +
>  drivers/misc/qfw_sandbox.c | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
> index 4e4260982cce..265f45290011 100644
> --- a/drivers/misc/qfw.c
> +++ b/drivers/misc/qfw.c
> @@ -414,6 +414,7 @@ UCLASS_DRIVER(qfw) = {
>         .name           = "qfw",
>         .post_bind      = qfw_post_bind,
>         .per_device_auto        = sizeof(struct qfw_dev),
> +       .flags = DM_FLAG_PRE_RELOC,
>  };

Should we add this to the DT instead?

In the case where it isn't present it can return -EPERM.

Regards,
Simon
