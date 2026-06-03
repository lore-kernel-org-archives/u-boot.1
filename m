Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148C3CD6E56
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 11:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CEBC83EF9;
	Wed,  3 Jun 2026 13:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VsQiRv8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD8458469D; Wed,  3 Jun 2026 13:41:56 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABAD8839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 13:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68d2342c5e6so5523515a12.3
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 04:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780486914; cv=none;
 d=google.com; s=arc-20240605;
 b=ZbEAX8X9BizASIsoGhiv4qzCx/pYh/3lNKPgR/f5kx55PMExDQK/jTRON6eS5FTC+s
 lA+N4he1QZ+8k1+G0B3OEoxQ/kw8+Av9Iw6YwTUilNl+VvZLFKL38/TP6RHbs7fg7CXl
 WFvYkdwa+Ww1SLOOfBMwQhwbLAkZtxE2vbd6wzALy3CyMHJXH5FMZDgrKTjw8j0t1DiD
 WO1P3HuzbzAdvC9pZ6rMvhiqtD2opL6gDAitSPUB4OMJ+sva/cb4ed9z7rnIFnnhSUln
 j2BLphgyKiytiFkbZ0RMNkpcUAlW4Pjn1szmMTGF+9dLKWnfe9Y/r/HAynacGewVyKvR
 LOaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7z4ZcdquhauAFPjgNYqmkv5737lZzvrrsRgrv46HhVE=;
 fh=fB448QPoGJtFMvQKE3JcuQXlpEprLmT+gEqFRf+uQGU=;
 b=D0WqI4ZzkclJiBKEjqcU8pPamYcW+4imtyxlA6ngWe04na2+vh6RIxh15SeAWF5WKp
 ghqMGSXxMysro8LDPhsKE4ueQIPpYxqL6DNs9+8YhlpU9GCCgd/q+oZzb8dVoKypv0cn
 B33DuNgkllKvu5gralNvFWHYQtAYm9RKMaogxnE0s14miFx2qhG5VAyqX2seI+xjUuOD
 Ndn4dPavckLj+yqrhowGIqEAHD6t1aL+lJEKiadetEFyk7klDvcZkvpiAF5oFqAt9Byr
 hHW6a0d8yJ5joE1cjGG1desNQqJ7f00GzeU/hOYIPOyvx5NqI13O+Hm0FNs9hEWB+kZo
 eRxg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780486914; x=1781091714; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7z4ZcdquhauAFPjgNYqmkv5737lZzvrrsRgrv46HhVE=;
 b=VsQiRv8ElGUL2ijZgmVsLtiO71CSnVYVd4qZ8rSvmboEK2H+tevLVckpMoWpbdxZN9
 YrTPYRuFpXAPsz6mQ2F4c9+dcZ+7RPNqRzg68eGcDxq+mvEa+JRxQwhodq69y5sOucTX
 bjw6kheynLs7g0V6sKkMXc0IeTn955VGO5hZMolyluM8qSYVNQGaYbTICCnZOXU+TFdk
 QuMV56gdCs9Si5q2i4eNXnouB1AIMNgWEiN/vahi15QJGqjcCLjaqRaj7/q7gevJ42Sf
 8Pz3KEIR/81+Efkm2aHhwD0Qc4Yq1BFhQ8iwa7RSrBG3ju4zNbm9KA8Uep9JQrMWjlDx
 nOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780486914; x=1781091714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7z4ZcdquhauAFPjgNYqmkv5737lZzvrrsRgrv46HhVE=;
 b=ZSvHSd4dtu2qbSDndYaDXml6LrpBU9wK1+vZLMieNTzfD3QCmp1zs2VQ7xiZ9KEv2y
 PhKLfGY89AS7Gq2Jh5+uy36eZKZa3EsisWX5uSg5zk1x2nVPxcaOFqQQ832Gzn99nuVK
 EOYaEfKu2K6m6GkM7tz9beHeWlDZlcdYIx/eWbcrK2LykQmxndl1ECQHOGxMNuuaFUX8
 UDwqlvOxcmJHhKsP99VeM1vIYD66v09cnJtRClDuN7/u3zKaeNmlxDGwRIxpLNWn1JU6
 J6FwQpX6/Evrt+Sfg64wijGAs5xN5GrJw4e1DNwj3wb0GYqN1/MyfygN0o5WkA6n0QFp
 Fs8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vD3NQuOXzgSeF1yiYlmDsDPkUaZn/lyvt0iUJWjYlS+x6qNNfBXDuYbGfv5BCLWVL99J3zEs=@lists.denx.de
X-Gm-Message-State: AOJu0YwXuHtcFFPvcieTMjuXV3ROIeVEC12y35EYAYqikV9/kFqg5fI0
 5ApIU/mlwQVoUyZipmBw4F6eVpoxuLwLnwbYlesQqLthnXqecAR6Xtda6jO6kXtcxyatBoNg1Fv
 k/wukJKEaR7iyuAuROj1QXZts0w9mkrw=
X-Gm-Gg: Acq92OEAR2NuGQT+x4mdOMl8yQChG+JOcrdz/MApFa0idf7AZsReVkVzCC/AIwh8Xww
 zWwzk4o88eXDfjEwdaxIdrp7IsjZddyZ7GGyQyHsKd02wsiAX4F9YDzd0gvStkwqz0h+T7yLNts
 gK5o3/0Y69Bibb9E4BRbvhUBWJsml1PCM3foXzUT6FFqQS6JTL8XzQXXnJ/dClTAhHAWYUKZzCW
 bTBG4HGNEfz5KqF0E/tJ/hrj14Rks/2iqzI2dqCOxMjElcUQobnvCaTAUuX+egfpy/YLDHLG5a6
 KYp9SYHq28QADsoI64Pg2ZXtLYcy4sSMUYwhrKmU90oMMvYMBbrvb5GBszjDFaHnkpGFlXzBv7E
 SQckvOVRygu34Kvjf5oFw3fpIzOEKFIUXFuN1jHNIAzQHgPZ38ZlbTo4j0P+LdSWF4HN0FXUuq4
 6Zw+fPwd+kTigY
X-Received: by 2002:a05:6402:2681:b0:68d:6495:feb2 with SMTP id
 4fb4d7f45d1cf-68e6f4b5a60mr1436609a12.5.1780486913990; Wed, 03 Jun 2026
 04:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260530144604.71190-1-marek.vasut+renesas@mailbox.org>
 <8e28ea5f-039e-4620-bb88-8e992290da58@mailbox.org>
 <CALeDE9O4G21o2Onc=OpdwYO7o2PB7eS9u9JfE4nQjRFfRO4SrA@mail.gmail.com>
 <2604d7ca-1336-42af-b5ab-99fed506d63d@mailbox.org>
 <CALeDE9Nf5WPdf6VdaJGdWOJyo67DwNVp3L7eEiwkMPppLxVw=w@mail.gmail.com>
 <CAC_iWjJv-oQ8Z92kDpnX5mecvknBd1MsuEB2MVvDwpwAjRmozw@mail.gmail.com>
In-Reply-To: <CAC_iWjJv-oQ8Z92kDpnX5mecvknBd1MsuEB2MVvDwpwAjRmozw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 3 Jun 2026 12:41:41 +0100
X-Gm-Features: AVHnY4Im4oMVLXiT-Zhn9ZNGU0_dXqSOqB5iCZTmJ4tg4oe8PKyvZLJjVkttDWc
Message-ID: <CALeDE9MkMx1s=qErP0Zp47MnRaH=fqC2Bfj-faNzn-7am8rsvA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] lmb: Optionally limit available memory to 4 GiB on
 limited systems
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Lechner <dlechner@baylibre.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

On Wed, 3 Jun 2026 at 12:26, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 3 Jun 2026 at 14:20, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > On Wed, 3 Jun 2026 at 12:12, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > >
> > > On 6/3/26 1:02 PM, Peter Robinson wrote:
> > > > On Sat, 30 May 2026 at 16:06, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > > >>
> > > >> On 5/30/26 4:45 PM, Marek Vasut wrote:
> > > >>> Some architectures can not DMA above 4 GiB boundary,
> > > >>> limit available memory to memory below 4 GiB boundary.
> > > >>>
> > > >>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > >>> ---
> > > >>> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > >>> Cc: David Lechner <dlechner@baylibre.com>
> > > >>> Cc: Heiko Schocher <hs@nabladev.com>
> > > >>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > >>> Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> > > >>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > >>> Cc: Peter Robinson <pbrobinson@gmail.com>
> > > >>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > > >>> Cc: Simon Glass <sjg@chromium.org>
> > > >>> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> > > >>> Cc: Tom Rini <trini@konsulko.com>
> > > >>> Cc: u-boot@lists.denx.de
> > > >>> ---
> > > >>>    lib/Kconfig |  8 ++++++++
> > > >>>    lib/lmb.c   | 20 +++++++++++++++++++-
> > > >>>    2 files changed, 27 insertions(+), 1 deletion(-)
> > > >>>
> > > >>> diff --git a/lib/Kconfig b/lib/Kconfig
> > > >>> index 77ebc79e1db..29911068a69 100644
> > > >>> --- a/lib/Kconfig
> > > >>> +++ b/lib/Kconfig
> > > >>> @@ -1295,6 +1295,14 @@ config SPL_LMB_ARCH_MEM_MAP
> > > >>>          memory map. Enable this config in such scenarios which allow
> > > >>>          architectures and boards to define their own memory map.
> > > >>>
> > > >>> +config LMB_LIMIT_DMA_BELOW_4G
> > > >>> +     bool
> > > >>> +     depends on LMB
> > > >>> +     default y if ARCH_BCM283X
> > > >>> +     help
> > > >>> +       Some architectures can not DMA above 4 GiB boundary,
> > > >>> +       limit available memory to memory below 4 GiB boundary.
> > > >>> +
> > > >>>    config PHANDLE_CHECK_SEQ
> > > >>>        bool "Enable phandle check while getting sequence number"
> > > >>>        help
> > > >>> diff --git a/lib/lmb.c b/lib/lmb.c
> > > >>> index 8f12c6ad8e5..a8a988eedc0 100644
> > > >>> --- a/lib/lmb.c
> > > >>> +++ b/lib/lmb.c
> > > >>> @@ -611,6 +611,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
> > > >>>    static void lmb_add_memory(void)
> > > >>>    {
> > > >>>        int i;
> > > >>> +     phys_addr_t bank_end;
> > > >>>        phys_size_t size;
> > > >>>        u64 ram_top = gd->ram_top;
> > > >>>        struct bd_info *bd = gd->bd;
> > > >>> @@ -625,8 +626,25 @@ static void lmb_add_memory(void)
> > > >>>        for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> > > >>>                size = bd->bi_dram[i].size;
> > > >>>
> > > >>> -             if (size)
> > > >>> +             if (size) {
> > > >>>                        lmb_add(bd->bi_dram[i].start, size);
> > > >>> +                     if (IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_4G))
> > > >>
> > > >> This conditional should be inverted.
> > > >>
> > > >> Peter Robinson , can you test this change on RPi ?
> > > >
> > > > That doesn't fix the problem for me on a RPi4 4GB or a RPi5 8Gb.
> > > Did you invert the if (IS_ENABLED...) conditional ?
> > >
> > > Was CONFIG_LMB_LIMIT_DMA_BELOW_4G enabled in your config (maybe the
> > > Kconfig entry "default y" part needs to be tweaked to cover these devices?)
> > >
> > > If both conditions are met, that should behave like the old code.
> >
> > I dropped my revert and applied the patch, checked the new config
> > option was in the generated .config (I mean you could test that with a
> > "make rpi_arm64_defconfig" and checking the output).
>
> You need to invert the logic of IS_ENABLED() for this patch to work.
> Marek obviously missed a !

Ah, I missed that bit in grabbing the patch, it seems to work on the
RPi4 4Gb, not tested a RPi5 yet.
