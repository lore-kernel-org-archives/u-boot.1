Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA85F46C5E
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 17:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2AD483C2B;
	Mon,  6 Apr 2026 19:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GQdH4yyP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AAF783E36; Mon,  6 Apr 2026 19:10:21 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11E3183936
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 19:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so764390366b.1
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 10:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775495418; cv=none;
 d=google.com; s=arc-20240605;
 b=S8isOjaKfFGppl9wFIZrmj7t5uA5mBsNt9j1JWsHKnEOf1SAtkTKGKROXsVp1WDk+j
 f8p7DeRYBCkBhRsRWkr5XByB3vSG69nTmtwBcV41JjaI5tkTMcBbjiDJcQvJ3WKpvPgG
 3dK799oujHg7brqalEcaPiNJjnPbPSSZzzDQVAEEpOXShe758LhjGqeFGZBf99W/pmoD
 rQyg46vPowbrbAFCsszB2JDS//wNIlWKeQStQSv0iPCTTi9qS7ytRqZvMCOo/M2l1LGn
 LvzzJpDurwo5E0738u13JQr88NlUL+vnrciAmT3CFZKH7Uoxw8dE1d1h5eezEt5SBHQw
 9W/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WNVBjxJe6ial/hiSDpkp7xp13loJRtomA53BSZq5QOc=;
 fh=9PCp1wSWEeLa/97RDhjPiJYjmm54m2GC+OOC8EwltSI=;
 b=Juom+mOqk163KvfoDfBaxEgDbi7TUuFxrXeP0NNuvD6CXVDLF8owUlkpQtuYKCEjjy
 E3F5ofUPbNmYzeZ1owL+DlX69qJMiZ30cIOBb2DSU9HlA/fYwhVeYN02W/joJoy8oxIM
 1Abf0X7/t9qKBb34zYORN4x/x9elLnzeTUKRfMx+m6lbi7+hyttwgYTgbAywaKQX3Tjt
 HEnjOXFHyov+0SX9853G58+D9qK+RVzy86dHljKX7UPS4pYqC6N+FByZONxhhbR5iNOM
 5nG0Mm/9smSBz7NM6OIh3O7U2RdBhTfhqZrIbeamPQyrZo5F02QnM76B0zwoDWfJum+c
 40sw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775495418; x=1776100218; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WNVBjxJe6ial/hiSDpkp7xp13loJRtomA53BSZq5QOc=;
 b=GQdH4yyPcEMgZLZJzAFJIqODG36wqmvOjDplwlb4gYTkeQu864ZGDVlaPpxK8xkJXr
 fmEDUra0YE23wBuCxGrxDU+qD/294/mKJVH5EgIpmWOoHuGZjujezuLcnAvyvX+nOoWo
 W3spCri+HWaU7onVG7HvQPPBR2pnA9HwIOtuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775495418; x=1776100218;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNVBjxJe6ial/hiSDpkp7xp13loJRtomA53BSZq5QOc=;
 b=B8qydFopqzpE28o/iklw8HcBfZHoBZukBGyEdwLwSgnlRRDCqZKmn5c3wOAY7yQyqu
 nu0iLNKARtaJVrjVvGoeyh5kTR6dY4rlRWBU0WIj04Fu+xBC+JyHSwg/V3QwgBoQhAhG
 8lfKx0WxVz8nIZAY6F5JfkROG9eDH+y8djfr4etqOZmcIplQH3pVITNNVMZHigak4ZjM
 JqqZVMRAMIIGY6O/oHiIo0JsZhevOnlv+hGaso7LnpVlQuuNuiPPI4RZ9r67dyUZwo1r
 6gjWpIzD2bs3ZCV78XHsko44MEn7S7GDPc11iRCCGyNPDH1cPmiS4k69Km72QfoCYFsE
 jKkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnkgi5rhB5YUdVAGpMpzemTWIPAfSZSHvmvCbHGoUcQusUJGMAizZyivj4HcUM8MhM+h4G5Rg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywvsd5HMMJe1OiswMQf6cRglK4FTnLtK++ZeXEhjuBP82tkIOP6
 /fII+7MG1Gk0L0b4T7J4KZjV7OVLg5eOhpasuZviE1yvtDrm9KAHZrbSwheikm512jDhaUFT0YR
 qBGOGRrsKt8Axuj/5O8dNaj78ChpwrnZ6GJ2z/nrJ
X-Gm-Gg: AeBDietcVuOAz8hlMiIOeFxAxBnsSf6CIeVg2Qu1d0OU/lsnT03QrtpLjEnAI7j9w9p
 7PWX+iv2yZOUUh5DILGtVjeNkOwfQjGG5ZvDmF7eGzXwjAt0HX+rAkQIuPVjm5pTIY59LYqjyDR
 woc9AD+9JUh0jGxXdPt015CaVSge6eRIR3jp+Ik5/L212WZ5sunnS42Ab2r1W0QEqYC90Za0r/0
 wJCvQH4vEfqFki+zVhMU0HyFW07ImaJM/MZSrWG/n/WAU2Aj85yGJ3H6ZIWRV9neev+vC5kBluF
 TTpDag==
X-Received: by 2002:a17:907:6ea0:b0:b9c:7572:ad3f with SMTP id
 a640c23a62f3a-b9c7572e0e5mr595349166b.21.1775495418353; Mon, 06 Apr 2026
 10:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260403135205.26979-1-ansuelsmth@gmail.com>
 <20260403135205.26979-3-ansuelsmth@gmail.com>
In-Reply-To: <20260403135205.26979-3-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Apr 2026 11:10:06 -0600
X-Gm-Features: AQROBzAA46a-J-JckTM1fJfYkit-erzi_zX-Cs9zud-vxASznc8fifdIl2ezvbI
Message-ID: <CAFLszTjPW27D8U_7wXeKUSn2TeeNhDZerTfpWH0VeA-XtQ5cLA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] misc: fs_loader: reorganize and split to FS and FW
 loader
To: ansuelsmth@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Justin Klaassen <justin@tidylabs.net>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Harsha Vardhan V M <h-vm@ti.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
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

Hi Christian,

On 2026-04-03T13:51:57, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fs_loader: reorganize and split to FS and FW loader
>
> In preparation to the introduction of variant of the FS loader,
> reorganize and split the driver to generic fw_loader function and
> specific fs_loader function. Create a dedicated directory for the loader
> and move the internal structs and functions to a dedicated header file.
>
> This will permit to reuse all the property and logic of FS loader
> with container that are not exactly a readable filesystem.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

> +struct device_plat {
> + struct phandle_part phandlepart;
> + char *mtdpart;
> + char *ubivol;
> +
> + int (*get_firmware)(struct udevice *dev);
> +};

This series introduces a generic firmware-loader framework with two
implementations (FS and FIP), which is a good idea. But the dispatch
mechanism uses function pointers in platform data rather than U-Boot's
driver model ops.

In U-Boot's driver model, polymorphic behaviour is handled by uclass
operations. Instead of storing function pointers in device_plat and
setting them during probe, please can you define a proper ops
structure:

    struct fw_loader_ops {
        int (*get_firmware)(struct udevice *dev);
        int (*get_size)(struct udevice *dev);
    };

Each driver would then declare its ops:

    static const struct fw_loader_ops fs_loader_ops = {
        .get_firmware = fw_get_filesystem_firmware,
        .get_size = fw_get_filesystem_firmware_size,
    };

And fw_loader.c would use dev_get_uclass_ops() to dispatch. This also
means you only need a single UCLASS_FIRMWARE_LOADER rather than
separate UCLASS_FS_FIRMWARE_LOADER and UCLASS_FIP_FIRMWARE_LOADER -
the ops handle the polymorphism, which is the whole point of having a
uclass.

See drivers/spi/spi-uclass.c or drivers/i2c/i2c-uclass.c for examples
of this pattern.

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> @@ -612,8 +612,12 @@ config MPC83XX_SERDES
> +config FW_LOADER_LIB
> +     bool
> +
>  config FS_LOADER
>       bool "Enable loader driver for file system"
> +     select FW_LOADER_DRV

FW_LOADER_LIB is defined but never used. FW_LOADER_DRV is selected but
never defined. I suspect you meant to define FW_LOADER_DRV here
instead of FW_LOADER_LIB.

> diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
> @@ -0,0 +1,144 @@
> +static int _request_firmware_prepare(struct udevice *dev,
> +                                  const char *name, void *dbuf,
> +                                  size_t size, u32 offset)
> +{
> +     if (!name || name[0] == '\0')
> +             return -EINVAL;
> +
> +     struct firmware *firmwarep = dev_get_priv(dev);

Please can you move the variable declaration to the top of the
function, before the statements.

> diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
> @@ -0,0 +1,61 @@
> +/**
> + * struct firmware - A place for storing firmware and its attribute data.
> + *
> + * This holds information about a firmware and its content.
> + *
> + * @size: Size of a file
> + * @data: Buffer for file
> + * @priv: Firmware loader private fields
> + * @name: Filename
> + * @offset: Offset of reading a file
> + */
> +struct firmware {
> +     size_t size;
> +     const u8 *data;
> +     const char *name;
> +     u32 offset;
> +};

The kernel-doc mentions @priv but there is no priv member in the struct.

Regards,
Simon
