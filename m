Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F886C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE587864BA;
	Mon, 28 Aug 2023 19:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GtrgilGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52A5864F2; Mon, 28 Aug 2023 19:55:02 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53329864B7
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52a250aa012so4702780a12.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245297; x=1693850097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O+Ib9M+yz4YDtLYP17A4sk4Ae7rkYZHgGtd2UfmTkTY=;
 b=GtrgilGiQZhDJEHRIBby71+UQoPQObTnylnSjYhY0PVGTLZap1ccrhREh+MA0qCDfg
 IniA1oBJkGwjuKBABwDKdB+KAYAplyoAWD0mq/fsdN1LVkCM+203Vf8w1gvXcsOFqd38
 /Ng9tI9qEsa5o7LPY/3nEHUt5K142bMQa1cuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245297; x=1693850097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O+Ib9M+yz4YDtLYP17A4sk4Ae7rkYZHgGtd2UfmTkTY=;
 b=mBk7Rjog1svKVthopZgLZfw2iyofszfiw/zWMoKrW+ie7c2SLeYk4tBv/0F46IPcyu
 xw5qt0pQQy0mNlcLZpoOb57pAQ9uqtqQrm3YfcRiEKCg1vJDh7piAJDB1/BIYpQQ3TD9
 cn+5fIoLM46EOAMJnKJr7S+MXUGGyZFi0r4HPY+ye1MxKjh64CoYXfuZMlkGK++iZEKU
 uOJX2LGW8n+/4H0MHKI0cVwJUhqqgGi56jDYd2s6bQXyG7rtWkmhsvCigxoK0fYlqyvJ
 9YJoGISwd3ITakRILlsT457zraU0JzTcX21A7y6fKoeQyzooUaAmAJN/eHZdutFU+b3R
 ZhYg==
X-Gm-Message-State: AOJu0YwkU48IkvFE5FLicSd7YGRuHOEr3jBcaL8fGfPbgOeqSA+2K4xa
 VVVCX4V1bVWpoarOjqCVeSZo1SxBfURjiKUR7tS0KQ==
X-Google-Smtp-Source: AGHT+IGnp8XoXXZBUSIOqOBUyAjnCCjIwOpWs3lQDPXFuuCCXZUZ05BD3d1KRd+7BPhoN76cd83Re8PXSbmeZRRwZk4=
X-Received: by 2002:aa7:d9d8:0:b0:522:3a89:a7bc with SMTP id
 v24-20020aa7d9d8000000b005223a89a7bcmr17429383eds.42.1693245296785; Mon, 28
 Aug 2023 10:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-5-sughosh.ganu@linaro.org>
 <5c05f436-8c92-4b01-fcdf-ed9e0ec31d44@gmx.de>
 <CADg8p97io5JX85MJj0U0U0sNCiC5D8bDjioe-fGwvEpPy7AUcg@mail.gmail.com>
 <c149c664-7aff-43a9-8d41-f098622e1809@gmx.de>
In-Reply-To: <c149c664-7aff-43a9-8d41-f098622e1809@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:54:45 -0600
Message-ID: <CAPnjgZ1f=iJrN0-o8ct5nmT53Vs+gACDmXArpwQc1e7x-J1z9w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] bootefi: Call the EVT_FT_FIXUP event handler
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Mon, 28 Aug 2023 at 05:02, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 28.08.23 11:32, Sughosh Ganu wrote:
> > On Sat, 26 Aug 2023 at 15:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 8/26/23 11:06, Sughosh Ganu wrote:
> >>> The bootefi command passes the devicetree to the kernel through the
> >>> EFI config table. Call the event handlers for fixing the devicetree
> >>> before jumping into the kernel. This removes any devicetree nodes
> >>> and/or properties that are specific only to U-Boot, and are not to be
> >>> passed to the OS.
> >>>
> >>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >>> ---
> >>>    cmd/bootefi.c | 18 ++++++++++++++++++
> >>>    1 file changed, 18 insertions(+)
> >>>
> >>> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> >>> index f73d6eb0e2..c359a46ec4 100644
> >>> --- a/cmd/bootefi.c
> >>> +++ b/cmd/bootefi.c
> >>> @@ -237,6 +237,23 @@ static void *get_config_table(const efi_guid_t *guid)
> >>>        return NULL;
> >>>    }
> >>>
> >>> +/**
> >>> + * event_notify_dt_fixup() - call ft_fixup event
> >>> + *
> >>> + * @fdt:     address of the device tree to be passed to the kernel
> >>> + *           through the configuration table
> >>> + * Return:   None
> >>> + */
> >>> +static void event_notify_dt_fixup(void *fdt)
> >>> +{
> >>> +     int ret;
> >>> +     struct event_ft_fixup fixup = {0};
> >>> +
> >>> +     fixup.tree.fdt = fdt;
> >>> +     ret = event_notify(EVT_FT_FIXUP, &fixup, sizeof(fixup));
> >>> +     if (ret)
> >>> +             printf("Error: %d: FDT Fixup event failed\n", ret);
> >>> +}
> >>>    #endif /* !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) */
> >>>
> >>>    /**
> >>> @@ -318,6 +335,7 @@ efi_status_t efi_install_fdt(void *fdt)
> >>>        efi_carve_out_dt_rsv(fdt);
> >>>
> >>>        efi_try_purge_kaslr_seed(fdt);
> >>> +     event_notify_dt_fixup(fdt);
> >>
> >> The event is already triggered in image_setup_libfdt(). Don't trigger it
> >> twice.
> >
> > The reason I put an explicit event_notify call is because the
> > image_setup_libfdt() call only calls the ft_fixup handlers if the
> > livetree is not active. So the fixup handlers would not be called on
> > platforms that enable livetree. Although I'm not sure if livetree
> > should be disabled before the ft fixup has to happen, or platforms
> > that need ft fixup should not enable OF_LIVE. Disabling the livetree
> > is not happening now, so I am not sure how the fixup event should work
> > on platforms which have OF_LIVE enabled.
>
> We still must not call the same event twice. We further must ensure that
> our fix-up is called last (e.g. by calling it zzz_something) and not
> before adding VBE nodes.
>
> Is there any need to use the event mechanism here?
>
> @Simon:
> None of the other function calls in image_setup_libfdt() depend on
> of_live_active(). I think it would be preferable to move that check into
> the listeners. If instead of of_live_active() you could use a
> configuration setting for the decision, gcc could eliminate a lot of code.

Firstly, of_live_active() should check CONFIG_IS_ENABLED(OF_LIVE)
first. I noticed this over the weekend when looking at something else.

The original code was due to a limitation with U-Boot's ofnode
implementation, in that it did not support multiple devicetrees
without OF_LIVE. We need to support at least two, since we have the
'control' DTB and the one being set up to boot the OS.

Anyway, that limitation can be removed, so long as
CONFIG_MULTI_DTB_FIT is set. In other words, we should enable
MULTI_DTB_FIT if !OF_LIVE and all will be well.

>
> We definitely need better descriptions in include/event.h and a man-page
> generated from that include:
>
> EVT_NONE
>      undescribed
> EVT_TEST
>      undescribed
> EVT_DM_POST_INIT_F
>      undescribed
> EVT_DM_POST_INIT_R
>      undescribed
> EVT_DM_PRE_PROBE
>      Device is about to be probed
> EVT_DM_POST_PROBE
>      undescribed
> EVT_DM_PRE_REMOVE
>      undescribed
> EVT_DM_POST_REMOVE
>      undescribed
> EVT_MISC_INIT_F
>      undescribed
> EVT_FPGA_LOAD
>      undescribed
> EVT_FT_FIXUP
>      undescribed
> EVT_MAIN_LOOP
>      undescribed
> EVT_COUNT
>      undescribed

Yes indeed. I added some for the latest patch in this area.

https://patchwork.ozlabs.org/project/uboot/patch/20230822031705.1340941-15-sjg@chromium.org/

Regards,
Simon
