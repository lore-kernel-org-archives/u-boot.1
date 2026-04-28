Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D14CFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1457E84693;
	Tue, 28 Apr 2026 16:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J6mcQ3Qh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 298FF84605; Tue, 28 Apr 2026 16:11:57 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACFD88466D
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ba6838e76f2so1187522166b.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777385512; cv=none;
 d=google.com; s=arc-20240605;
 b=e5m8o23a6OOjc9RICfWvJBt/Jg7Col0YCX3QL/8XjOHLeCAvCl47j0VfEHYWMd9CDn
 PWWV3BotAUvVU+k6nWikCuEct5ak1WPoccvqhVf65+PKecM1Uv1c+II8tjAUUxHT4LRp
 d7B+J1gQgIjqCj366v4NNQgCp2ZMxKKsYtKQedb3Y22GWJZG2wAwd8sOka/E1z2MidZe
 8xnPqrKxaihZCXgyiR+6vRadlE4nzfiTuAJlLsYqaE4U49hSsiGBYm/nxQBkAzuD2Tcj
 4i9zUrx61g0YSvPo4UYXcRxZ1xKb/rrZSHQQttnlHs/6Es6eaySszy7gss8fBO6s7ioy
 i/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kE6qjtL466KvQxFJ/b88spzGuIBVeojkJgJNr3iWeoo=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=H1Z32lmtPtLrLwkGjdR87v+g5FP4Qf3A6F5oPG95n3PzSu+EyTGJ41MoTNukjR+otw
 7Gw3OSSkHd8wDeErc6880JDh78PX2jskfxYjaf+n9S5ZOyiBgdpoTitPD7erDvZ+Jav8
 2EYw6NvfcfQ7XLnT5Ws5tGsLDs7+a7VL5ZUhQIac6vtJyQNgRt7mY1VMWlzbW54Lf180
 FihO+wjiAyJdyko9Py1aa45iWfPRMwhQwtu2FfgCER351euGgOTkiDcAUUz1k+LHdHgh
 z6LUauytFnYNVT5aca4dJ6xOztM8Hn8yN3aHVunpkPXvFhQo+e9vT+qe1GsZvAhkNSFc
 C7Tg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777385512; x=1777990312; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kE6qjtL466KvQxFJ/b88spzGuIBVeojkJgJNr3iWeoo=;
 b=J6mcQ3Qhb1sjctVB/GygOKvhyMWKLh3l25754+n2OEc7kH3r52ZFKIgfFszdBFPMNa
 TiDIKvJxCZKNFRCQ2iv16d2Km724HpZbaneNd15WQQfjRPMxqmRtZW9wALFosk+O6Lnw
 HUaG+o8MIWWfyb3ZCygNU8lNpDCmmJn2R2PLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385512; x=1777990312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kE6qjtL466KvQxFJ/b88spzGuIBVeojkJgJNr3iWeoo=;
 b=Ej4TS5beCxz1pXDIgl5RnYjzErXvmvTb9PnZ0bF2ecRlgI6hCDljZMzBfzVAoXgDRC
 QjEPvUIT+ExtOwdjbEfryK6vzMZY1WMxDqEnjeTxXheJ0QwAqxTzzgMkIm5GIbXl1949
 cFMTQpJP3AyhBZOJL0EbYTYGniN2EK0EB+TU+gkqymdq85ByM9s1mHM8e3paKN85awFD
 BG2C/hGmEJw/gX/EnlylZflEgJWn0v41xi8/2btEbUdD6PBTjoFLMR27MY2fWksjPDxW
 8Ys/SEOgxwbRr77G1RnY4GlFUOIkyOgRUHqPNMhci9Cy7oa3SvsHyw1xiwS7HcvWf/K6
 772g==
X-Gm-Message-State: AOJu0Yx8FdYM9U+24Dff+zcNfJuHAQrXlUVJAURft1HTKoKOZhyaUXlI
 Y0KkS1P30/VC4A69kfRfGuNbw2TUWdmHpqO77RM3Cjs5fr5nqJUUU+b5L+izfcOuptLL3WJG6qZ
 etYHfjarS5nUQLQUeFDYnPkGgrKTUBy1qUOalu2ft2qtGb8P0JLo=
X-Gm-Gg: AeBDieuB6tmkONw+NVvkRw8txQaf0YvRoTBbLzqa/7j36P8TcQPVa4AKDNGdpnfJFdx
 1jnZMcZLZJpzEXnnuA8MdqlxJV+3prg0h4ZONn/5aMg4Tl6Oj4psRW76SaGZmhXFJ7/R0+RWgTS
 B7Upl0tDMdeDT95geI0wv13YTrahqyMBeVKxW2SW4gbqDE1zeRxt7yrheypC5S7ocuYSpBnVBPJ
 3lQ0Ipvojh3baLhlsmY09r0jDv5oiK4IrXziK3GU5JTDFSf2ub64v3RMOEQ+LN8QKsGDap8WcEg
 8Gr4zUSwz6CE/ScWTvnmDRAKVCM=
X-Received: by 2002:a17:906:4796:b0:baa:93ac:bd94 with SMTP id
 a640c23a62f3a-bb801ad7130mr195909066b.16.1777385512079; Tue, 28 Apr 2026
 07:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777272283.git.weijie.gao@mediatek.com>
 <d7ec0e5d655f8c2f1d159908f74d00927d7a0776.1777272283.git.weijie.gao@mediatek.com>
In-Reply-To: <d7ec0e5d655f8c2f1d159908f74d00927d7a0776.1777272283.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 08:11:40 -0600
X-Gm-Features: AVHnY4IDUf_zF6BwmofM3mNzhKN1zkQQOo7FlxhwoaEm9x2FYd0x445IHMK1-GQ
Message-ID: <CAFLszTgnQuEN3m8yyC_upE=tucO93O4Lb9SwMmBzqAxE9TuDQA@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] env: ubi: add support to create environment
 volume if it does not exist
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

Hi Weijie,

On 2026-04-27T07:09:11, Weijie Gao <weijie.gao@mediatek.com> wrote:
> env: ubi: add support to create environment volume if it does not exist
>
> Add an option to allow environment volume being auto created if not
> exist.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> env/Kconfig | 11 +++++++++++
>  env/ubi.c   | 35 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 45 insertions(+), 1 deletion(-)

> diff --git a/env/Kconfig b/env/Kconfig
> @@ -699,6 +699,17 @@ config ENV_UBI_VOLUME_REDUND
> +config ENV_UBI_VOLUME_CREATE
> +     bool "Create UBI volume if not exist"
> +     depends on ENV_IS_IN_UBI
> +     help
> +       This option is useful if u-boot will be booted from a fresh device
> +       where environment volume hasn't been created in the UBI partition.
> +       This is a common case where factory UBI image contains only volumes
> +       with valid data.
> +       By enabling this option, environment volume(s) will be created before
> +       loading if not exist.

Please use 'U-Boot' rather than 'u-boot' and tidy the grammar (e.g.
'if it does not exist', 'where the environment volume has not been
created', 'any missing environment volumes will be created before
loading'). Also mention that with CONFIG_ENV_REDUNDANT both volumes
are created.

> diff --git a/env/ubi.c b/env/ubi.c
> @@ -134,6 +151,15 @@ static int env_ubi_load(void)
> +     if (IS_ENABLED(CONFIG_ENV_UBI_VOLUME_CREATE)) {
> +             create1_fail = env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME);
> +             create2_fail = env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME_REDUND);
> +             if (create1_fail && create2_fail) {
> +                     env_set_default(NULL, 0);
> +                     return -ENODEV;
> +             }
> +     }

Just to clarify the intent: if only one creation fails, this falls
through and the subsequent ubi_volume_read() prints 'Unable to read
redundant env from ...' which is confusing on a fresh device. Clearer
to fail (or print a dedicated message) as soon as either creation
fails - what do you think?

> diff --git a/env/ubi.c b/env/ubi.c
> @@ -105,12 +105,29 @@ static int env_ubi_save(void)
> +     ret = ubi_create_vol(volume, CONFIG_ENV_SIZE, true, UBI_VOL_NUM_AUTO,
> +                          false);

The dynamic flag is hard-coded to true. Sensible default, but please
mention the choice in the commit message or Kconfig help.

The commit message is quite terse - normally we like to see a
motivation (fresh device with a factory UBI image lacking the env
volume) - also note that for CONFIG_ENV_REDUNDANT both volumes are
created.

Regards,
Simon
