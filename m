Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB44CD6E56
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 11:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E21F83EF9;
	Wed,  3 Jun 2026 13:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ApzOynSx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F2A83FF5; Wed,  3 Jun 2026 13:20:24 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366DE839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 13:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68cc6c7df99so6263782a12.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 04:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780485618; cv=none;
 d=google.com; s=arc-20240605;
 b=jyRlSmnFIcjKoTsL6+IqaBnlLVNzzYw2yJjkFWlNdZICJS22ulGOP7q3+o4IkFDOkC
 WtzB1dlwHXSSE0LcYIzaVn8aWumkodAmGK/QOO6PedF7iwXKC9s2Dzc8fVoTdXiheH0m
 P6av/6NHGxilOBdaAs6AW3Z57jjmdcMrcGS9rPr0W/MTcfBGr3l8v7LFs0PyKeWexOsO
 jrFTvxbiZLxwVYVtuaMq1hgM5XLBw1rzm5dV/CxJEHOTtdWRq+4HL2uzCwYr9/eohewL
 3Ik3u8AdVdGWp9e/WnJoKzIccK4bajOAXEyIfj97d+NBwEdsYULvlD2DaazRS5LeE89K
 f0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=te5WwepJK26YpgAgqhaR8qT+iL52qghSSwjxqVa80GU=;
 fh=joAhEEwbgVgYRptP/lZfvtT9M/FhYInuc7h7PE6FMuo=;
 b=DBwlIh2s3sbankAwsZCY3IUjKGYzDTGt96cZCWaPUac8VDZHadBP2xX/9vbWdsidMY
 uOj0rhcINpPK/pEUJZggXeg2IDHadiJiWlHJI6/e+7jfy8GP0r8mhTjax780TqECdTkl
 hIQNVvceYlGlrUlnlYA6cazf5jfUpfNKvMyXjDlHSHOmH/6e7e6EZ9673rNYo9FevrzJ
 +JkP2yjTzYvAoY4QEOlyjsjkzfzkdi75yv+7F27wb0g1XGy/d3zf8XjevlEXDdlcpve5
 Dte2gty5nO89Pn1PIUydc7bnVO0QkbKESfTk3fBdSn1PqoAL0GqaBHwP+LG1Tj1MGnX/
 lyog==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780485618; x=1781090418; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=te5WwepJK26YpgAgqhaR8qT+iL52qghSSwjxqVa80GU=;
 b=ApzOynSxAZHR0fe2ylp+VPvy/ZLZWWddpiOnCfRvPmRfDrY3cZi4bL+GWWrmJotUEB
 jkv2DfLvXy6IY6P6YDf0yKA5w8LuybU8kjyeesU25E1mRaQrgawogj0DwFuG5yl0RNWZ
 KStabU/9kONllMTcE5Bzm48GMA6rSiAmk/qg/czw3LFIlYS5vC9ecKxgdrNQNK0Xf3mt
 ZZPaRIzwLREanr5487lcSaxtxEVbpCNWY3wycSNjY/8w07GwVg/b3eGVCvx5bFCOdfLM
 4xSLYTRGZXmDQ7gqMm+HjnjAggaOtLWln4vcUhpqA/5bojmVQ6X+xHUAaNlPGi1ki4h0
 h2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780485618; x=1781090418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=te5WwepJK26YpgAgqhaR8qT+iL52qghSSwjxqVa80GU=;
 b=FA+ZjTOHlw9oMRhfVZMGXs+CoCPSTkpKLTyng6qLzVoJCSb0/hl/kcILpjvO1l2CsA
 8wgyEsw0cKta/bmWzPF1x23GqRXwH9m1rbqRT5BGV/CVHULY7BGVGMQZQ9m3oqfa50vq
 Z+MLnpaTDxZ8QAhsxQk165wVc/52ToZFBWvjHWiudHStjnt0C/SKoSshl253QdoFzTGG
 e1sWH7stcAo5diG0fUqy085Mjtz6pk6N46xXet7OrJHIXjj18LvKmSJQZ1sEz4ZhnolP
 paJ+47cdaFfG/9fXAnY2UJVe5h6xAVoqHU7qwI1CbTojZv7dFTcUb1Maa1JcpSlVz6xq
 f9/Q==
X-Gm-Message-State: AOJu0YwXFzR7qKthgjJcM5C+p90VL0FH2T/lpQaZkvUSxA/1f9TDGn19
 5Nj3sieZhf4s6JQfcrRhLWk9vA4i2y/EGtpudIeTtLcUjks1kaZ+kkZMD6+2lhUW0BDZ/Jg6fOK
 Wlf85R9kw1bMl0X3lQcoaX8Cgn/IkIrM=
X-Gm-Gg: Acq92OHPseq8veOZ5BDLKBebWRLNXMgVgpG5sCVkJj3s+8uuVWm630LfxTpZ0dusJVd
 3g0xfwybeAJuktxhuVWOILHzHWr3Dtg6zF67XS/EMA8WsPXhv37Vg0Qb5r6/WBOLdNMdDbKE7YB
 TwQXScyt6xjm2Fl1+xoI46vsdonS9S8yEnBLqyI81RRwndmsFVe3dNTcIZ9uEnnq3iZ1CNKhhLC
 7aL1i0F5JDT49PQgO4sWXbAR/qiTbkyNjUJESsB7u/FQ66Uzgh7n386iNoFnTFaNgLYurENmz1l
 LreYPuADdlnbtz8fpFfLzbEnLixYN2kH3Cor7jCbXxKAUxWcsaXXUwlhu/C9/9cj1owWaiLxNXE
 G5nnp/DuTAwcydfCDj8xcBAyC8xHAoqsWFUGWMfq4FptKr4ib5wBOqRps25Zcu6kSjQbBHQU6kd
 ruyfy4WPi6Bra/
X-Received: by 2002:a05:6402:268c:b0:67f:7e9b:afe8 with SMTP id
 4fb4d7f45d1cf-68e6f97c207mr1311997a12.6.1780485617473; Wed, 03 Jun 2026
 04:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260530144604.71190-1-marek.vasut+renesas@mailbox.org>
 <8e28ea5f-039e-4620-bb88-8e992290da58@mailbox.org>
 <CALeDE9O4G21o2Onc=OpdwYO7o2PB7eS9u9JfE4nQjRFfRO4SrA@mail.gmail.com>
 <2604d7ca-1336-42af-b5ab-99fed506d63d@mailbox.org>
In-Reply-To: <2604d7ca-1336-42af-b5ab-99fed506d63d@mailbox.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 3 Jun 2026 12:20:05 +0100
X-Gm-Features: AVHnY4L-zJR075Yy0ES0UPUDNEIHE7o9ifQoJGa--kcm8Sm578yEUyhWFTZiql4
Message-ID: <CALeDE9Nf5WPdf6VdaJGdWOJyo67DwNVp3L7eEiwkMPppLxVw=w@mail.gmail.com>
Subject: Re: [PATCH] [RFC] lmb: Optionally limit available memory to 4 GiB on
 limited systems
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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

On Wed, 3 Jun 2026 at 12:12, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 6/3/26 1:02 PM, Peter Robinson wrote:
> > On Sat, 30 May 2026 at 16:06, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>
> >> On 5/30/26 4:45 PM, Marek Vasut wrote:
> >>> Some architectures can not DMA above 4 GiB boundary,
> >>> limit available memory to memory below 4 GiB boundary.
> >>>
> >>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>> ---
> >>> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> >>> Cc: David Lechner <dlechner@baylibre.com>
> >>> Cc: Heiko Schocher <hs@nabladev.com>
> >>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>> Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> >>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>> Cc: Peter Robinson <pbrobinson@gmail.com>
> >>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> >>> Cc: Simon Glass <sjg@chromium.org>
> >>> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> >>> Cc: Tom Rini <trini@konsulko.com>
> >>> Cc: u-boot@lists.denx.de
> >>> ---
> >>>    lib/Kconfig |  8 ++++++++
> >>>    lib/lmb.c   | 20 +++++++++++++++++++-
> >>>    2 files changed, 27 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/lib/Kconfig b/lib/Kconfig
> >>> index 77ebc79e1db..29911068a69 100644
> >>> --- a/lib/Kconfig
> >>> +++ b/lib/Kconfig
> >>> @@ -1295,6 +1295,14 @@ config SPL_LMB_ARCH_MEM_MAP
> >>>          memory map. Enable this config in such scenarios which allow
> >>>          architectures and boards to define their own memory map.
> >>>
> >>> +config LMB_LIMIT_DMA_BELOW_4G
> >>> +     bool
> >>> +     depends on LMB
> >>> +     default y if ARCH_BCM283X
> >>> +     help
> >>> +       Some architectures can not DMA above 4 GiB boundary,
> >>> +       limit available memory to memory below 4 GiB boundary.
> >>> +
> >>>    config PHANDLE_CHECK_SEQ
> >>>        bool "Enable phandle check while getting sequence number"
> >>>        help
> >>> diff --git a/lib/lmb.c b/lib/lmb.c
> >>> index 8f12c6ad8e5..a8a988eedc0 100644
> >>> --- a/lib/lmb.c
> >>> +++ b/lib/lmb.c
> >>> @@ -611,6 +611,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
> >>>    static void lmb_add_memory(void)
> >>>    {
> >>>        int i;
> >>> +     phys_addr_t bank_end;
> >>>        phys_size_t size;
> >>>        u64 ram_top = gd->ram_top;
> >>>        struct bd_info *bd = gd->bd;
> >>> @@ -625,8 +626,25 @@ static void lmb_add_memory(void)
> >>>        for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> >>>                size = bd->bi_dram[i].size;
> >>>
> >>> -             if (size)
> >>> +             if (size) {
> >>>                        lmb_add(bd->bi_dram[i].start, size);
> >>> +                     if (IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_4G))
> >>
> >> This conditional should be inverted.
> >>
> >> Peter Robinson , can you test this change on RPi ?
> >
> > That doesn't fix the problem for me on a RPi4 4GB or a RPi5 8Gb.
> Did you invert the if (IS_ENABLED...) conditional ?
>
> Was CONFIG_LMB_LIMIT_DMA_BELOW_4G enabled in your config (maybe the
> Kconfig entry "default y" part needs to be tweaked to cover these devices?)
>
> If both conditions are met, that should behave like the old code.

I dropped my revert and applied the patch, checked the new config
option was in the generated .config (I mean you could test that with a
"make rpi_arm64_defconfig" and checking the output).

Peter
