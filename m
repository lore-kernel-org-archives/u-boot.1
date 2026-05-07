Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74316CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1265A84B43;
	Thu,  7 May 2026 17:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZoLDdb1j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9E0284ADD; Thu,  7 May 2026 17:32:45 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F084084B5D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bc188a20e0aso135356266b.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167963; cv=none;
 d=google.com; s=arc-20240605;
 b=DZqnsKM355nT38/Rlmw+YtGte15Gct3gv9RBN60t+AKXesb7NMADqdc25a46pp1j6d
 UU31jIg6mzjbMnvbFfc+8cLd9Vkj11VtAWWQRiHNQ5+WkxK5304CUqh+aJEgr7cjYgyx
 GeDfW8n8ZGsxkT/QzVtimiOG53nQ8+hsNSITP6yruDXJLSFml3dgsp+po2wKz9XZyj5t
 UG5qnJZ6u7nfYFw5rNaCtLyyoTGPokyQOtfifqSkjTVPhZp/cLuhf3yFWQKEFI0pd3c8
 KZV+4lPmoP3n+6I1EK/pEUr8Hi/vylo8aIs2KNYNy49mzUsGsywM+lQt+NS8PDzednDK
 i9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9cTdR7OwE6zxCGb/l4QZJtcT1yKXWa26hdpQD1ie5eA=;
 fh=3zI1MY2jLb+geQSEEyacKu9xbYcO7fBIfrZAWhTcvFI=;
 b=GtnAwzmtUS0Ui1vQhQZTvQPv0PDIA9c4G7gIcJgSlDjD+FHSxIcfA7zpGi3VAHYMv3
 vqi5u65Imf+YxxdxhNtrWZD3GWgiHu+JNaXQ5TMiXyX1TyG/4nVfd683T+YA0axB5tYq
 qIaWhMpBzioG5ATWi/lUuWP8W7ymCkqzBITtDUTkswRi3CaudBjY84N14eNpcDOJSCiD
 0BQn/1szbfvOUZaSHXnZ5YtymV2BYbfogunoT0ZaANlPldWr5doxxGFUe/+aRQaAT+Pw
 wtYAJFx+N1mjSA0iWxhor8CB3DCTRIYz3BeC4JVI+WwyagX8e/rK5rTdx+4kmiCDSCH3
 e8UQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778167963; x=1778772763; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9cTdR7OwE6zxCGb/l4QZJtcT1yKXWa26hdpQD1ie5eA=;
 b=ZoLDdb1jMoXjnbrMgxUmsrhZo/K5GLWYlfhPhJQqb8TrJ2Di7nXJQcrp1kBa9DMK2X
 m4wDQyFvEF/g9inwPVsJnwrHVVM/oocc/4GF2OAf8oy5d3xkAldHFK2zXigELrCdUBMK
 20xHhAIYYeRa74PDqp9Et/bTREijocNCjeToc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778167963; x=1778772763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cTdR7OwE6zxCGb/l4QZJtcT1yKXWa26hdpQD1ie5eA=;
 b=F3WYZBWjNujXnocRG5r6SDvlfgGw1l/kut4ul/x089dVlIzvTTLID/5evbzxyp86Rh
 usiCVnnLY2UsP3Mhbqm7AJoER19eeONo5t9xYUAl4iv9ydT1Q+eSvwDZlvdbp0gyWRCy
 xHC+AsZFvonLEYE3W8mytpiiby8mgEKwM0p6tYnsKSvPzkI0YZh24CT7yDk7sBvqaa7f
 nww5IjJTjMgtlCNYLvh9BTWHbKXLx5B/Li5NsIwRy97mGxBiO2DopTi7juJE5eRgGcsE
 BgBRdDvBCkX8cdpQp6orUrZkjXr9OZ1I2i0UW7Vpfoehu3QgkhhqFM2DURKB5vBIGKZR
 lJGA==
X-Gm-Message-State: AOJu0YypBHBv+2vbm2ylaRwhjpYy0yMRaLjxRWc9ouTPKLrMWdzeNcc9
 XR9C/1IRFiEz+0EQCo5pfw2KDJ0NLHHdCtuch1Zmos/TJDFFJp7UvLZK8h+5BOzIdNKQ9JL4KKK
 MDYbdpy8fErYyYmlEl9fL7jcC2BzfOLx+2dJ6vCjd
X-Gm-Gg: AeBDieuTP3b5YVT4uvu8oXwbtT73xBj/6/ojWN+A/NF6lOnlU9I/VBF2AWNcxTqqc5O
 4kurQKeGezp8aEsIiM5oxJNQVgpoZJWYWujoUyi+s9lY3JgyHQqRxKLPDgMa7nN4VssQXbB88Z5
 TzcDFrdSDbUN5Z/u1zwkJ8o53jXd6qH1otYj5orW47IbwT9THIA+8kMb2ILm1hZxBLbl+oMJxXI
 oOQ24rl3afdE0SDpzdt/L1H+0eET60tdP0xBp4/1jDrKt65VeJXHA4DAJ5+aNgqzoH8MuYTlazJ
 lBRzVz/Lw50avcsB
X-Received: by 2002:a17:907:a06:b0:bb9:4586:5dbc with SMTP id
 a640c23a62f3a-bc56d80f156mr498181066b.33.1778167963144; Thu, 07 May 2026
 08:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-7-harsimransingh.tungal@arm.com>
 <CAFLszThtGo1n_fpMF4S8EYvUGPpaUu4mDwbjt8P5RF++pBo4UQ@mail.gmail.com>
 <177807005852.1171074.13649548036204819845.b4-reply@b4>
In-Reply-To: <177807005852.1171074.13649548036204819845.b4-reply@b4>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 09:32:28 -0600
X-Gm-Features: AVHnY4JA6i6GYT_JDfWVOMPFSUDlEGpVA_oabhCW5XkS28gT18RI3Q_gGt0NDtE
Message-ID: <CAFLszThK52TQF0eQY-gem=qEkMDx6WvT640t88oVb7x2LucWpg@mail.gmail.com>
Subject: Re: [PATCH 06/12] corstone1000: enable bootefi selftest
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
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

Hi Harsimran,

On Wed, 6 May 2026 at 06:21, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> On 2026-04-28 12:01 -0600, Simon Glass wrote:
> > Hi Harsimran,
> >
> > On 2026-04-24T17:31:50, Harsimran Singh Tungal
> > <harsimransingh.tungal@arm.com> wrote:
> > > corstone1000: enable bootefi selftest
> > >
> > > Enable UEFI selftest command in Corstone-1000 defconfig
> > >
> > > Turn on CONFIG_CMD_BOOTEFI_SELFTEST in the Corstone-1000 defconfig
> > > so the board can run the built-in UEFI self-test suite during
> > > development and validation.
> > >
> > > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> > >
> > > configs/corstone1000_defconfig | 3 +++
> > >  1 file changed, 3 insertions(+)
> >
> > > diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
> > > @@ -63,6 +65,7 @@ CONFIG_SYSRESET=y
> > >  CONFIG_SYSRESET_PSCI=y
> > >  CONFIG_TEE=y
> > >  CONFIG_OPTEE=y
> > > +# CONFIG_CMD_POWEROFF is not set
> > >  CONFIG_USB=y
> >
> > Why is this disabled? It's not mentioned in the commit message and
> > looks unrelated to enabling the bootefi selftest. If it's a stray
> > byproduct of 'make savedefconfig' please drop it; if intentional it
> > should be a separate patch with its own justification.
> >
>
> Thanks, these two lines are intentional rather than stray
> `savedefconfig` fallout.
>
> On Corstone-1000, enabling `CMD_BOOTEFI_SELFTEST` causes
> `CMD_BOOTEFI_HELLO` to default to `y`, and `CMD_POWEROFF` is also
> pulled in on this PSCI-based defconfig. I wanted to enable only the
> selftest command here, without broadening the rest of the board command
> set, so both are kept explicitly disabled.
>
> I can make that explicit in the commit message in v2.
> Does this sound reasonable to you?

Yes that makes sense, thanks.

>
> > > diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
> > > @@ -32,6 +32,8 @@ CONFIG_SYS_PROMPT="corstone1000# "
> > >  # CONFIG_CMD_CONSOLE is not set
> > >  CONFIG_CMD_FWU_METADATA=y
> > >  CONFIG_CMD_BOOTZ=y
> > > +# CONFIG_CMD_BOOTEFI_HELLO is not set
> > > +CONFIG_CMD_BOOTEFI_SELFTEST=y
> >
> > The commit message says only that selftest is being enabled, but
> > you're also explicitly disabling CMD_BOOTEFI_HELLO (which would
> > otherwise default to y once SELFTEST is set). Please mention this, and
> > ideally state the real motivation - that this is needed so patch 7 of
> > the series can run the runtime variable selftest on this board, right?
> >
>
> Thanks, agreed.
>
> The explicit `CMD_BOOTEFI_HELLO=n` is intentional. On this board,
> enabling `CMD_BOOTEFI_SELFTEST` would otherwise make
> `CMD_BOOTEFI_HELLO` default to `y`. The goal here is to enable the
> selftest command so the later runtime-variable selftest patch in this
> series can be exercised on Corstone-1000, without broadening the rest
> of the board command set at the same time.
>
> I'll make that motivation explicit in the commit message in v2.
>
> Regards
> Harsimran Singh Tungal
>
> > > Enable UEFI selftest command in Corstone-1000 defconfig
> >
> > >
> > > Turn on CONFIG_CMD_BOOTEFI_SELFTEST in the Corstone-1000 defconfig
> > > so the board can run the built-in UEFI self-test suite during
> > > development and validation.
> >
> > The first paragraph just restates the subject. Please drop it and keep
> > the second paragraph, which actually explains the change. Referencing
> > the runtime-variable selftest added later in the series would also
> > help, since that is the real reason for enabling it now.

Rgards,
Simon
