Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7114ACD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 07:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D95CB838BB;
	Wed, 10 Jun 2026 09:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="oamnEiCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F365839A8; Wed, 10 Jun 2026 09:51:18 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E11F380087
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 09:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-687ed9aabb3so12658008a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 00:51:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781077875; cv=none;
 d=google.com; s=arc-20240605;
 b=RHJabPbbn057qVhj6hiEPVdJQH8tp/ny6Ehd1JQ8jYcyt5nhkLZIO3pRyfrwVfNHV7
 OWFuM6Yr051fcMTUi4L/U0E0JckiWNO82DbslbWXZ+HBF6qz1olQ+hKDhM1PZOvdTUhW
 tLk31QqLJVwrdF8TnKhY0JRbAx38vcdQkvvfM/jWgiEVBQnvgcMOaWm+JVQ30VazrJmu
 4+dzyr2IiZEczVh/RBlhtZuX5K2UhBOHWLjGID2HUvxisLcovQrFMp4o6D1Ukl/xv+vS
 aFa5jC293+W8CbP8LYHu0LFXFj50cKLgI1XAnEA2Kpsgu2s/v+ptfnu56dRyTK20MD8B
 ewZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hi5ggREqPLMjIqibo2iocCtW7VBF/aB14KUumTysh/w=;
 fh=ZVzWass3jyWLBMqWzNydnIu499FB8I4k4g2UNWNtZzU=;
 b=YGei0QT9Dv9R/SyuhWf2/xx2EpHVDmZ2dgJGreIgH/yN4sF7W73jOeKN+4c0F5Hds/
 52QJkhXEYwiLOqjljs0DpRxWnU45BSQyzPwErU9KWKlewjsO1LK/UuC8vPNPiDl2QODf
 GNxCRv3n4wtUAD6ag8iLNhLwlJjwIquVfpsl6G/lVGnaLhD3UTSdPfETmV+o9hODPxGP
 aWrq6hjdnKj6U0L2wPdCih23gUmHSuhYPPqEawnN5VRx+YqFzSiQY9OmGyWDiJu3XIaF
 Td8kEuGACZhUuvqhT+zCnUpCn4OaPdhNaWxGPqKIHfr2c/RSTYUOgOECOXOB0QS10evr
 Jakw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1781077875; x=1781682675; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hi5ggREqPLMjIqibo2iocCtW7VBF/aB14KUumTysh/w=;
 b=oamnEiCGszd6z+bjfx2L0KEAKdqnWgNQPu3T2mhpL/+yQhkjxUB2b6oufhz9ib21Fv
 VvMMMbiWlK1s0zwhMyIIkPQrd9Z2tZJKFy4P6jBYIr5U8713oNSvTbKsC5dm64f17KHq
 ceWMfd56uXG5Rh3K/N6AZ5xeYG3yhXZa6baAS/rA7d3UI53iIgYNq/fk6TVx6msVf/n7
 2SbLNf/TbLD7CwdoUnqI0pC1y4H1qHEtFedg6uvZHe+lUjEVCChDQ9LjHUZkFNHNa362
 ZE47Lo3biWwQw8X+T8H37hvW0h5o/W7EtUQUrBGXewVgo8gCFE9b6KrurRHKyBT0RTFN
 0X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781077875; x=1781682675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hi5ggREqPLMjIqibo2iocCtW7VBF/aB14KUumTysh/w=;
 b=r3dkjSNtZ8qdvHXRPdz3glouLpKlrZlPQFRTfUI3eMMiZz3IG09NE2eV6Z5wy3QWoV
 DFYNmLpP5iEZtkavNvDgtFuh3BJ9XskPLvwhZtsBAKDPaD1iAx56k0ARcNxZzpjxSRzZ
 eRtjPm3zzmDkj6mctC7c5u/x8Yjp/gp8phvgVGlCKYgeb/36agQjw1PW4+tMHVmXs2xD
 qzy4CoK/0RbROTvDRUbxAIYwcbkFAFB/N5EohvrTOmlSWuvEQbYz841kpvVnle9axR0Y
 GjJ7on42S1GzktmoY6Jg63xZ6paMcgfTemxbL5RbuTj7RFJFNaQag5F3ZV6cdhpx5Kfv
 g7AA==
X-Gm-Message-State: AOJu0YzwOHPeYAf/6c8WTeOZLaLhHczMKeEZKbc7vrlEPaC/bt1bFgfA
 9UimEIWi/V4QGUsLR3TagDtcsPy8YoAJjV/zAnWhTT6Nyp+M67yUW+ahvshVNwoxX8RI9JFn0eC
 XhRW73qJ/rdRwIv3yANNXmXl8jdBlA6/lPP/BlN/ufA==
X-Gm-Gg: Acq92OGx/5MaoKJu8FRpc+b8ivhQJ3TQSESsWXM9s3ePd/FnZctI2V7SzF+oOAxca2g
 cGV36bjcvSA+RfZqubEFytT6Llym6Ja5urWD6ArwnvkYqKtZfXEBP/RrsoYzbMs0sDK7OA62l0H
 CIlvHw44DzhNg9cnr+hDzFQ/lSx5yJTXV8SRdYAw7iUhCZQ40CuHGEecelKxmDzDucm698vswc5
 uG5XFTz21qiOpZQUrpDwjKnsxiJiQLYev+649nVo2zZV4OOpw1Czi5Cny15rqIx6h87kLmmtbux
 eT7sYqEaKhCm+y4m28Cu+z9vkMyfOxwhxTS2d6MBNZih5HWfITQ=
X-Received: by 2002:a17:907:6e9f:b0:beb:7979:47dd with SMTP id
 a640c23a62f3a-bf3738f1f81mr1353490366b.27.1781077875247; Wed, 10 Jun 2026
 00:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
 <20260609-atf-falcon-v1-1-2b20c5e83615@flipper.net>
 <7d68bdee-78de-48f2-9813-4fd804a419a9@mailbox.org>
In-Reply-To: <7d68bdee-78de-48f2-9813-4fd804a419a9@mailbox.org>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 10 Jun 2026 11:51:06 +0400
X-Gm-Features: AVVi8Ce3_sJQmcblh9FE8TCAApPvSPMgyfopDJND8-P0YPEkeb4fPrLnI202pwk
Message-ID: <CAKTNdwGpo9N6BoW_D4pzdS52LHpK2q9FHBRvr3EdpY5TJQUykA@mail.gmail.com>
Subject: Re: [PATCH 1/4] spl: atf: support Linux as BL33 with ATF
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

On Wed, Jun 10, 2026 at 8:00=E2=80=AFAM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 6/9/26 6:52 PM, Alexey Charkov wrote:
> > Modern SoCs such as Rockchip RK3576 need ATF to be running to provide
> > firmware services to the OS.
> >
> > Enable the ATF boot flow to allow using Linux as BL33 (including its
> > calling convention) to facilitate Falcon mode boot on such SoCs.
>
> TFA

Ok, thanks. The whole file is saying atf though :)

I have to admit I'm still confused with all the naming. My latest
understanding has been that ATF is the whole firmware including both
non-secure BL31 and secure BL32, with TF-A being the upstream
opensource implementation for the BL31 part, and OP-TEE being the
upstream opensource implementation for the BL32 part (or is this part
TEE-OS?).

Anyway, happy to rename.

> > +/* BL33 defaults to U-Boot unless Falcon mode selects Linux. */
> > +static int spl_atf_bl33_os;
> > +
>
> Can we avoid this global static variable ?

Yep, let me try to refactor to drop it.

> >   /* Holds all the structures we need for bl31 parameter passing */
> >   struct bl2_to_bl31_params_mem {
> >       struct bl31_params bl31_params;
> > @@ -87,8 +90,11 @@ struct bl31_params *bl2_plat_get_bl31_params_default=
(ulong bl32_entry,
> >       SET_PARAM_HEAD(bl33_ep_info, ATF_PARAM_EP, ATF_VERSION_1,
> >                      ATF_EP_NON_SECURE);
> >
> > -     /* BL33 expects to receive the primary CPU MPID (through x0) */
>
> That seems a bit inconsistent, and not quite right. Do you know where
> U-Boot expects primary CPU ID in x0 exactly ? Which part of U-Boot code
> depends on it ?

That was pre-existing logic and comment, so I left it in place to
avoid unintentionally breaking someone's setup. Happy to try and drop
it, but I only have an assortment of Rockchip RK3576 based boards to
test it on, which won't be very representative.

> > -     bl33_ep_info->args.arg0 =3D 0xffff & read_mpidr();
> > +     /* Linux-at-BL33 expects DTB in x0, U-Boot expects primary CPU MP=
ID in x0. */
> > +     if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && spl_atf_bl33_os =3D=3D IH_O=
S_LINUX)
> > +             bl33_ep_info->args.arg0 =3D fdt_addr;
> > +     else
> > +             bl33_ep_info->args.arg0 =3D 0xffff & read_mpidr();
>
> [...]
>
> > @@ -269,15 +279,22 @@ void __noreturn spl_invoke_atf(struct spl_image_i=
nfo *spl_image)
> >               bl32_entry =3D spl_fit_images_get_entry(blob, node);
> >
> >       /*
> > -      * Find the U-Boot binary (in /fit-images) load addreess or
> > -      * entry point (if different) and pass it as the BL3-3 entry
> > -      * point.
> > -      * This will need to be extended to support Falcon mode.
> > +      * Find BL33 entry point. In Falcon mode, prefer Linux when reque=
sted.
> > +      * Fall back to U-Boot if Linux cannot be resolved.
> That does not seem correct, if Linux cannot be resolved, then the system
> should stop booting, falling back into a bootloader could be security
> risk. There is a "recovery" boot weak symbol function, which can be used
> to start fallback bootloader, but that has to be deliberately
> implemented and triggered by the user e.g. by holding a button down.

I thought from reading existing documentation [1] that "plain" Falcon
mode is supposed to fall back to U-boot, while "secure" Falcon mode
should fail. Which prompts me to at least add a fail path for the case
when SPL_OS_BOOT_SECURE is enabled.

[1] https://docs.u-boot.org/en/stable/develop/falcon.html#fallback-mechanis=
m

Thanks for looking into this Marek!

Best regards,
Alexey
