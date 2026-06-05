Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F253CD6E79
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 14:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70C4F84963;
	Fri,  5 Jun 2026 16:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kvk+iRk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FEC684964; Fri,  5 Jun 2026 16:54:01 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95DF584962
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 16:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rmandrad@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45ef1198766so1150617f8f.0
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780671238; x=1781276038; darn=lists.denx.de;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mf2mQBna0N6LDDJ0o+MzHddQJJIIZomtX8IqgoFVT8Y=;
 b=kvk+iRk3qZSXKgpzCGgiFoSUEYVfS3jfe/ROZKUNAJSWZcLD+kqzpzZfHP8vZF0bD3
 xUiJziQ9rTz5675JjqFuu51ZMLLdwwcaCDEeG0t2A6TUK7waLwDW4+Dy7eusapHrjZjh
 wgKN6Q2qJkk7CWpeAJJe6omsjOMIhs4GmCA3hmje8C9FmE/CIo78HPgEUc6exdGF7bBG
 P0Y1jPWeJyHZ+WnThaAO7Lgkkc1rCp1c+nM6QVQTMXTzxDy/9qvnnK4m6ZDWWRWqRRrs
 EgpMpzOHZGxlzjLqVEM+tafAnbALrTPIXzznQIYu1Ge9ldz3dRDY0lv26bcs0ScG+YBO
 7CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780671238; x=1781276038;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mf2mQBna0N6LDDJ0o+MzHddQJJIIZomtX8IqgoFVT8Y=;
 b=KpTkEzaUQw3FwT+X/rjwJ93OrwFcGYkza5wjLdwte3pwEFSM2cArRJxdSyZn/RPttK
 rd52YXKWbrRRu8PBvJ99xqKLqo+RGEGhvRTKvtmGETc2mXuq5d2DJ+uKA5Bf/rzKKfuE
 qORhHB4T/x7oj+vGW2/m/MGBBs/Wat2kbOWC3bfnnPF46OUSjMsTETPZonYt2/M2ybha
 rJoXpOcs8V7rmzx8C5BmDMpe5IhJ9xjgSHdttSL/IJ4KFEdaDxGYrpXSO0FyNR7Ageg9
 Jkxf2/YrC3wRZDM6ffR0F91fU2Prw+AFXsNy/o7SxXwOTKr9J6uF9L17neVF+xFxY3MV
 FL/g==
X-Gm-Message-State: AOJu0YxcIcnD7QcbrHKDK9fT70tQYk69eeUKJ5fXHNJv/wTTz6Dr44Ne
 lwBBHpCMaXpM0fzibWd4FvXYfnCSm4ggBWYYKFlh2v3n+NBJPN3p+ic=
X-Gm-Gg: Acq92OER3uC9k49e0KE5WbRYF9TiMsKiQm6IfkORc0OYWvTOkLT6VpunP0MNnG2UOV/
 7wBMEBi8w6hEYp/vNwg6SZn6EWDQi2OSbIzQhcyKD8eCl6Ko00T86BrewL81KFVHHYTVvgenxxc
 +z7Vgm58FNOMES2lruBMxnpyTew3kBxSHT6DQd4X2DzQEdkfpHKll4E4FKGKlWWyEHFlzyVLLEA
 2MW2dZ1f3lhXEc3tAEjfv7Pp3wxBuIpFMHoWT6ALwtybjm3TmCbsgzafzsPGUwIgYU3a2rZb2qu
 Ix3cyzNJ9Dk0f5lGDOuiewLBfBDsIPdsER2SQCjKSsdaMxyZdfymtgQ5Tw+hiAEADXuCAYMEcdn
 MpGNeLoSnP7hhZT1y+3j7qPXazMPBmFaYbeCbutRMCdhxDBNqD5yBwMSJtZQX1+KnQXpmVXxFYw
 A3TY4s+p3vrNgSIdcWI1rLchhKIeAJvNzEscuawvWwqhT5B+/XciHt0eC/484HarHkx/psoxQhW
 rVMNRN4iIMN4HoA0aMDmvU=
X-Received: by 2002:a05:6000:2083:b0:453:9897:76aa with SMTP id
 ffacd0b85a97d-46032dac90bmr4322295f8f.21.1780671237825; 
 Fri, 05 Jun 2026 07:53:57 -0700 (PDT)
Received: from winhome (cpc112753-pert6-2-0-cust678.16-4.cable.virginm.net.
 [86.18.22.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dc412sm27348199f8f.4.2026.06.05.07.53.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jun 2026 07:53:56 -0700 (PDT)
From: <rmandrad@gmail.com>
To: "'David Lechner'" <dlechner@baylibre.com>
Cc: <u-boot@lists.denx.de>, <trini@konsulko.com>, <ryder.lee@mediatek.com>,
 <weijie.gao@mediatek.com>, <chunfeng.yun@mediatek.com>,
 <igor.belwon@mentallysanemainliners.org>, <jstephan@baylibre.com>,
 <GSS_MTK_Uboot_upstream@mediatek.com>, <emanuele.ghidoli@toradex.com>
References: <20260602162233.2418471-1-rmandrad@gmail.com>
 <CAMknhBFeV8qio29t1zNhoBNdumbWh2ErOE99dQEphDKZN8GodQ@mail.gmail.com>
 <003e01dcf4ec$6a507830$3ef16890$@gmail.com>
 <CAMknhBFPN8rk35ijCQK8ACM=joV-tXuX1m6sYCVEFPYegMjXxA@mail.gmail.com>
 <CAMknhBGng1iVxs7+5cWPaAyjOxBs8Dbzp3fuHhHWHbi3eJs3fw@mail.gmail.com>
In-Reply-To: <CAMknhBGng1iVxs7+5cWPaAyjOxBs8Dbzp3fuHhHWHbi3eJs3fw@mail.gmail.com>
Subject: RE: [PATCH] arm: mediatek: mt7988: restore full DRAM bank reporting
Date: Fri, 5 Jun 2026 15:54:37 +0100
Message-ID: <000a01dcf4fb$3ba10810$b2e31830$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIEQ/kMLkV4Qkej/ZvY+9FqTz2RbQHquDCHAS7aWFsDgZ3TzwG+qYJUtZ6eY4A=
Content-Language: en-gb
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

Was just about to reply on that... happy to drop this patch and let you =
work on a solution just thought to report my findings but would suggest =
in the meantime to revert=20
bddd6bbef3dc ("arm: mediatek: mt7988: drop dram_init_banksize()")

-----Original Message-----
From: David Lechner <dlechner@baylibre.com>=20
Sent: 05 June 2026 15:48
To: rmandrad@gmail.com
Cc: u-boot@lists.denx.de; trini@konsulko.com; ryder.lee@mediatek.com; =
weijie.gao@mediatek.com; chunfeng.yun@mediatek.com; =
igor.belwon@mentallysanemainliners.org; jstephan@baylibre.com; =
GSS_MTK_Uboot_upstream@mediatek.com; emanuele.ghidoli@toradex.com
Subject: Re: [PATCH] arm: mediatek: mt7988: restore full DRAM bank =
reporting

On Fri, Jun 5, 2026 at 4:30=E2=80=AFPM David Lechner =
<dlechner@baylibre.com> wrote:
>
> On Fri, Jun 5, 2026 at 3:07=E2=80=AFPM <rmandrad@gmail.com> wrote:
> > > On Tue, Jun 2, 2026 at 6:24=E2=80=AFPM Rudy Andram =
<rmandrad@gmail.com> wrote:
> > > >
> > > > MT7988 detects the full installed DRAM in dram_init(), but after =

> > > > commit bddd6bbef3dc ("arm: mediatek: mt7988: drop
> > > > dram_init_banksize()") it fell back to the generic =
dram_init_banksize() implementation.
> > > >
> > > > That generic path populates bd->bi_dram[0].size with=20
> > > > get_effective_memsize(), which is capped by CFG_MAX_MEM_MAPPED.=20
> > > > On
> > > > MT7988 this limits the exported DRAM bank to 3 GiB even when 8=20
> > > > GiB is installed.
> > >
> > > Can we just remove the #define CFG_MAX_MEM_MAPPED (and the header =
file that contains it)? Or is it used somewhere else?
> > >
> >
> > Not the header file as   TARGET_MT7988 sets =
SYS_CONFIG_NAME=3D"mt7988" in arch/arm/mach-mediatek/Kconfig
>
> We could drop that config too since the header will be empty.
>
> >
> > In the mt7988 I don't see CFG_MAX_MEM_MAPPED used elsewhere than=20
> > just in common/memsize.c where it limits get_effective_memsize()
> >
> > Unsetting/removing CFG_MAX_MEM_MAPPED would take u-boot above 4gb... =

> > Some MediaTek ARM64 ports may keep U-Boot below 4 GiB because=20
> > peripherals such as MMC need DMA buffers below 4 GiB ... so, it may=20
> > work on my setup but not others. Also, not an expert on u-boot  I=20
> > would suggest for others to comment/review
> >
>
> What I've done on the other MediaTek platforms for now is add this to=20
> init.c to take care of the 4GB DMA limit.
>
> phys_size_t get_effective_memsize(void) {
>        /*
>         * Limit gd->ram_top not exceeding SZ_4G. Because some =
peripherals like
>         * MMC requires DMA buffer allocated below SZ_4G.
>         */
>         return min(SZ_4G - gd->ram_base, gd->ram_size); }

Meh... I've just realized that this probably doesn't fix the issue as it =
does basically the same thing as CFG_MAX_MEM_MAPPED. I will have to come =
back to this next week when I have more time.

>
> There has been some ongoing discussion of a better way to handle this=20
> in general though, the last few weeks. I need to check the mailing=20
> list to see if any progress was made since then.
>
> If there isn't something yet, I would still propose to drop=20
> CFG_MAX_MEM_MAPPED and add this function so that everything is the=20
> same.

