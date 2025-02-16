Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5810C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 14:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04912801B0;
	Sun, 16 Feb 2025 15:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OAo0gV8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B419B8056A; Sun, 16 Feb 2025 15:10:12 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8012580104
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 15:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38de1a5f039so3347578f8f.2
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 06:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739715010; x=1740319810; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rGhib8IspIbAKsF+Qf81cGcheRiOkg+c1cLE9PDY2ic=;
 b=OAo0gV8Tr/MPEyTNqAfHy7Nl0lh5rvsEb3cMYu5BnHSKyKL/uYv7F9L9iixbq7bvzN
 zJWVjhtcVxwyzjVrXaHU8WwRyHzOkDD5Qj3ppCifNrQZi1HQdRlCTHsvUYQejbKAbFoO
 LbYlpfpIPv+MbY7hmZZNNwM/TcXXILXnWgdr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739715010; x=1740319810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rGhib8IspIbAKsF+Qf81cGcheRiOkg+c1cLE9PDY2ic=;
 b=NeHrc8lJ5ZwQ1Y8I+1eH93Is5VNq9vtg3aDihH8zrHPkHSVX6PZwzL48v1AlYz7Dg0
 sZuMcmNk188UuMZMLdkhNhIY3bstpnDSFXKxZOb9w3U3SB+WqmzZLc38DzNqvJXIpNWv
 3MxZksFcnKoLGzLekUdACpNGxITm3SmrOKTtVj6rRUgU4aQLYRgLFAkTKSOE5iTQQUdq
 D3LjVFpP0dwZIVWBOxETbHV3I2KPMscGT2PADvBMQ4b4F1m8H0KBzvIqRFyFLKdIVRkU
 I0w3Cac9MDeQCuN3htvShLjRJ81WYHA5eCA75bhnE9id1EtJFbtSZiq1h0bxTMtHAS8F
 FLCQ==
X-Gm-Message-State: AOJu0YwsgktfY0c2roS0PcM2I72jPa9rSYiRlr2HqqNPVmny51EnhVCz
 4nJdSf6231VOGxmeqNfz2XS5Mv1IHyKSuYcHZJKbSjpzzRVvU2daI9pLoGBMWWvMcaDCh0pFtqg
 r2X6/Z8vm0rntextwYUf3sTFJk0wkcIVcNeko
X-Gm-Gg: ASbGncsDLa468roViJG7C5VwWPzh9JFHZEz03r0mg4RZjCMkwqYjqsy74qsxUx6yQmC
 ob0rk0LQ4NyllyoFBsAVSa1CE7w/LkAypz39chzXXWCNfmvjT7sSgIWDrQMj3yJAeAMh0yYdbVA
 ==
X-Google-Smtp-Source: AGHT+IFK3OciQbShc5u/MAcNFIv7w3TgCnjGHZ43fHchU9N2TlxA/hFVaM2fu5PR8lcNTecfciei35/IYBDf0VmnccY=
X-Received: by 2002:a5d:438c:0:b0:38f:2856:7dc4 with SMTP id
 ffacd0b85a97d-38f33f62c72mr5428508f8f.55.1739715009837; Sun, 16 Feb 2025
 06:10:09 -0800 (PST)
MIME-Version: 1.0
References: <20241206023626.2456858-1-sjg@chromium.org>
 <20250124191830.GS60249@bill-the-cat>
 <CAFLszTgZKtsCgrptCCJm2Ucbz2b0zPeOymT6aUb2=VBwjOubpA@mail.gmail.com>
 <20250215144652.GN1233568@bill-the-cat>
 <CAFLszTjnFH3tY5p5e0FNvufqVLzEAD8Sc7Fed=csuSQdMbebPw@mail.gmail.com>
 <20250215182112.GU1233568@bill-the-cat>
In-Reply-To: <20250215182112.GU1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Feb 2025 07:09:57 -0700
X-Gm-Features: AWEUYZm3KUaoC8-CIJU18F5gc4ppEVUz6tcs4JWpdLRf2oCIGgbCYMPL6NJUT4A
Message-ID: <CAFLszTiG10LVJLeN=rvNBQxH=bHehnTYLTRJ7DGQ0qSOMK=epQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/46] pxe: Support read_all() for extlinux and PXE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ion Agorria <ion@agorria.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, 
 Nam Cao <namcao@linutronix.de>, Peter Korsgaard <peter@korsgaard.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried <rfried.dev@gmail.com>, 
 Rick Chen <rick@andestech.com>, Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Tom,

On Sat, 15 Feb 2025 at 11:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 15, 2025 at 10:24:08AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 15 Feb 2025 at 07:46, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Feb 15, 2025 at 05:06:42AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 24 Jan 2025 at 12:18, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Dec 05, 2024 at 07:35:39PM -0700, Simon Glass wrote:
> > > > >
> > > > > > This series implements read_all() so that it is possible to read all the
> > > > > > files relating to a bootflow, make adjustments and then boot.
> > > > > >
> > > > > > Unfortunately quite a few things stand in the way, so this series
> > > > > > finishes off several pending items: zboot without CONFIG_CMDLINE,
> > > > > > required support in pxe_utils and the differing code in the extlinux and
> > > > > > PXE bootmeths. There is very little new code, but quite a lot of
> > > > > > refactoring.
> > > > > >
> > > > > > The bootm, booti and bootz commands have all been refactored previously,
> > > > > > so that they can operate without needing CONFIG_CMDLINE to be enabled.
> > > > > > At the, time, zboot was left alone, since it is x86-specific and a bit
> > > > > > more trouble.
> > > > > >
> > > > > > However it turns out that the booti support doesn't work with compressed
> > > > > > booti images, so this series resolved that problem too.
> > > > > >
> > > > > > This series adds a programatic API for zboot and uses the forthcoming
> > > > > > bootstd 'image list' to collect information from an extlinux file. It is
> > > > > > therefore possible to parse the file, load the resulting images and then
> > > > > > examine/adjust the resulting bootflow, before booting.
> > > > > >
> > > > > > The addition of options to extlinux resulted in the PXE and extlinux
> > > > > > bootmeth having slightly different features. This is tidied up in this
> > > > > > series, with common functions for both. This allows the same features
> > > > > > (loading images as a separate step) to be provided for PXE.
> > > > >
> > > > > With v4 of 45/46, this fails with lwIP on Pi in the PXE tests now. You
> > > > > likely don't need more than CONFIG_NET_LWIP=y being added but for
> > > > > completeness here's everything:
> > > > > CONFIG_UNIT_TEST=y
> > > > > # CONFIG_CMD_EFIDEBUG is not set
> > > > > CONFIG_CMD_BOOTMENU=y
> > > > > CONFIG_CMD_LOG=y
> > > > > # CONFIG_CMD_BOOTEFI_SELFTEST is not set
> > > > > CONFIG_IPV6=y
> > > > > CONFIG_IPV6_ROUTER_DISCOVERY=y
> > > > > CONFIG_CMD_TFTPPUT=y
> > > > > CONFIG_CMD_WGET=y
> > > > > CONFIG_FIT=y
> > > > > CONFIG_FIT_SIGNATURE=y
> > > > > CONFIG_FIT_BEST_MATCH=y
> > > > > CONFIG_SYS_BOOTM_LEN=0x4000000
> > > > > CONFIG_NET_LWIP=y
> > > > > CONFIG_BOOTSTAGE_STASH_ADDR=0x02400000
> > > > > CONFIG_BOOTSTAGE=y
> > > > > CONFIG_BOOTSTAGE_STASH=y
> > > > > CONFIG_CMD_BOOTSTAGE=y
> > > > > on top of rpi_3_defconfig.
> > > >
> > > > I just noticed this response (a bit behind on email), but I don't
> > > > think it is reasonable to require out-of-tree changes. We just need CI
> > > > to pass, along with any labs. This whole series seems to have been
> > > > blocked?
> > > >
> > > > If you like, I would be willing to debug it if this series is applied,
> > > > and send a follow-on patch. I have a second rpi3 in my lab which I
> > > > could add to gitlab, along with the changes above, so we can catch
> > > > this sort of thing in future. It would have to be added with some
> > > > documentation, so others can figure out what is going on. Just to be
> > > > clear, I have no issue with LWIP, just with this series being blocked
> > > > due to out-of-tree changes.
> > >
> > > I don't know what "out of tree" changes you're referring to. I guess you
> > > mean the test I noted above? It's only out of tree because you didn't
> > > follow up with Heinrich's buildman patch to allow using fragments. If
> > > that was applied then it would be worthwhile to have the Pi targets in
> > > your lab do more tests, including the above. And please note this is my
> > > lab that fails.
> >
> > I suggested a file format to specify combinations that we test. You
> > wanted them to be created as separate boards. If you don't want to
> > reconsider my proposal[1] you could create a separate in-tree rpi3
> > board with these options. That would actually be easier for my lab,
> > although with Heinrich's patch it wouldn't matter much, as you say.
> >
> > Heinrich's patch[2] is fine but needs a test. Are you asking me to write it?
>
> Yes, I much prefer what Heinrich did. As he's apparently been too busy
> to address your feedback, it would be helpful if you finished it.

Yes I can do that - so are you OK to apply this first?

Regards,
SImon

>
> --
> Tom
