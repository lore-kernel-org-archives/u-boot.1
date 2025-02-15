Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A96FC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 17:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1132680C83;
	Sat, 15 Feb 2025 18:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U5jT9wtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5175C80EEB; Sat, 15 Feb 2025 18:24:23 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA7380077
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ab7d451f7c4so434468366b.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 09:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739640260; x=1740245060; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JwI4b7VxfV2HzrtFQ/vFMrcl73EMhdHsQkNgOY2ZDjY=;
 b=U5jT9wtRsvQH+rKBRjISCFTZyCLCGyGTaI0ArE5SYKc2yzJZSMkqw7rRt6JVd/4AjP
 oHDPwp0vOfuHR9xJ5WRFtqoRYhnIcUI1XiRm1wANLAsZcU4TdZq1RVgY3yafN619HlDL
 NLUZwwcwCkvnKUUR4qAhtGQ2i22YVCaL1uaYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739640260; x=1740245060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JwI4b7VxfV2HzrtFQ/vFMrcl73EMhdHsQkNgOY2ZDjY=;
 b=nZfXs0VLq0qgCHRrHmXY48t7n8DokrLUamb4Y0bkQPBkqYec8jKAM5OKd08WStUB8i
 3eoa9giTX2OsZ7Sz1SkRwTlNVmQ6KfvBfBIOKt38L/8Nhg8ZVtt+Z9vNgyB1NwjVUVqU
 KnSOTd/u+1cekYk2i+5UQ20b8rYphMbrCLk9uA/1tH6WltwN65RfCJjWxaTAgB+TDKke
 eRrtj2zMNWceGboFItq5i+NtCpK+uyuxsTrisRwt2Q6RO323ZBBZd9zYhkAck7qtXX17
 1U2oIFPCo8m3EYAS2LJO10Nnl4BTXBFloOHh9iY+0iJI2LbiNptY0yoPwlbzkXrOd82D
 2wJA==
X-Gm-Message-State: AOJu0YzZcuT6GuCho40B9pKvwuhy6N63jo8wfqUqW1jR/gIPILqpxBDS
 fgqzlikk+D/akAdyvs6tZAzoRPETG19/K6rWI+o8+eV0MjTA3eWl/vnghFtfE4b5qTkV1rQYuG7
 p8NU4yx4C6VExASdwK0p/AOHPWhIUlHUcTf1H
X-Gm-Gg: ASbGncsiS/1KrgRd61VnshD2jBg9Vn79cH9FUDqAkQe5ma2JwWTj0v//Q/2oQ9b5Gy9
 h4CYfjAU129dKQKp/jvbd7kOSKbpD4acwKdhRAE/Rc4LUke+bE59oBK/BTAqnba9lCdZ+ZwkPBA
 ==
X-Google-Smtp-Source: AGHT+IFe4RsrR3VyaDUUlwQJeL5BAEGhGjXRNEOEXl2SnWXCMKrX5n1xw2nRv1xQ483HXJiH3hzdHA9/YcpSSheMYAE=
X-Received: by 2002:a17:907:9716:b0:ab7:d77b:43b2 with SMTP id
 a640c23a62f3a-abb70c486c1mr433678166b.33.1739640260265; Sat, 15 Feb 2025
 09:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20241206023626.2456858-1-sjg@chromium.org>
 <20250124191830.GS60249@bill-the-cat>
 <CAFLszTgZKtsCgrptCCJm2Ucbz2b0zPeOymT6aUb2=VBwjOubpA@mail.gmail.com>
 <20250215144652.GN1233568@bill-the-cat>
In-Reply-To: <20250215144652.GN1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 10:24:08 -0700
X-Gm-Features: AWEUYZlHOLlI0dRFOUOCdIQlQm3Vo1GfOWayl_dfoq7N-BCtAPYC2rNL5LHYt_g
Message-ID: <CAFLszTjnFH3tY5p5e0FNvufqVLzEAD8Sc7Fed=csuSQdMbebPw@mail.gmail.com>
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

On Sat, 15 Feb 2025 at 07:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 15, 2025 at 05:06:42AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 24 Jan 2025 at 12:18, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Dec 05, 2024 at 07:35:39PM -0700, Simon Glass wrote:
> > >
> > > > This series implements read_all() so that it is possible to read all the
> > > > files relating to a bootflow, make adjustments and then boot.
> > > >
> > > > Unfortunately quite a few things stand in the way, so this series
> > > > finishes off several pending items: zboot without CONFIG_CMDLINE,
> > > > required support in pxe_utils and the differing code in the extlinux and
> > > > PXE bootmeths. There is very little new code, but quite a lot of
> > > > refactoring.
> > > >
> > > > The bootm, booti and bootz commands have all been refactored previously,
> > > > so that they can operate without needing CONFIG_CMDLINE to be enabled.
> > > > At the, time, zboot was left alone, since it is x86-specific and a bit
> > > > more trouble.
> > > >
> > > > However it turns out that the booti support doesn't work with compressed
> > > > booti images, so this series resolved that problem too.
> > > >
> > > > This series adds a programatic API for zboot and uses the forthcoming
> > > > bootstd 'image list' to collect information from an extlinux file. It is
> > > > therefore possible to parse the file, load the resulting images and then
> > > > examine/adjust the resulting bootflow, before booting.
> > > >
> > > > The addition of options to extlinux resulted in the PXE and extlinux
> > > > bootmeth having slightly different features. This is tidied up in this
> > > > series, with common functions for both. This allows the same features
> > > > (loading images as a separate step) to be provided for PXE.
> > >
> > > With v4 of 45/46, this fails with lwIP on Pi in the PXE tests now. You
> > > likely don't need more than CONFIG_NET_LWIP=y being added but for
> > > completeness here's everything:
> > > CONFIG_UNIT_TEST=y
> > > # CONFIG_CMD_EFIDEBUG is not set
> > > CONFIG_CMD_BOOTMENU=y
> > > CONFIG_CMD_LOG=y
> > > # CONFIG_CMD_BOOTEFI_SELFTEST is not set
> > > CONFIG_IPV6=y
> > > CONFIG_IPV6_ROUTER_DISCOVERY=y
> > > CONFIG_CMD_TFTPPUT=y
> > > CONFIG_CMD_WGET=y
> > > CONFIG_FIT=y
> > > CONFIG_FIT_SIGNATURE=y
> > > CONFIG_FIT_BEST_MATCH=y
> > > CONFIG_SYS_BOOTM_LEN=0x4000000
> > > CONFIG_NET_LWIP=y
> > > CONFIG_BOOTSTAGE_STASH_ADDR=0x02400000
> > > CONFIG_BOOTSTAGE=y
> > > CONFIG_BOOTSTAGE_STASH=y
> > > CONFIG_CMD_BOOTSTAGE=y
> > > on top of rpi_3_defconfig.
> >
> > I just noticed this response (a bit behind on email), but I don't
> > think it is reasonable to require out-of-tree changes. We just need CI
> > to pass, along with any labs. This whole series seems to have been
> > blocked?
> >
> > If you like, I would be willing to debug it if this series is applied,
> > and send a follow-on patch. I have a second rpi3 in my lab which I
> > could add to gitlab, along with the changes above, so we can catch
> > this sort of thing in future. It would have to be added with some
> > documentation, so others can figure out what is going on. Just to be
> > clear, I have no issue with LWIP, just with this series being blocked
> > due to out-of-tree changes.
>
> I don't know what "out of tree" changes you're referring to. I guess you
> mean the test I noted above? It's only out of tree because you didn't
> follow up with Heinrich's buildman patch to allow using fragments. If
> that was applied then it would be worthwhile to have the Pi targets in
> your lab do more tests, including the above. And please note this is my
> lab that fails.

I suggested a file format to specify combinations that we test. You
wanted them to be created as separate boards. If you don't want to
reconsider my proposal[1] you could create a separate in-tree rpi3
board with these options. That would actually be easier for my lab,
although with Heinrich's patch it wouldn't matter much, as you say.

Heinrich's patch[2] is fine but needs a test. Are you asking me to write it?

Once we figure this out, I will add it to my lab.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241108152350.3686274-9-sjg@chromium.org/
[2] https://patchwork.ozlabs.org/project/uboot/patch/20241220002156.87780-1-heinrich.schuchardt@canonical.com/
