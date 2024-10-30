Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB994D5CC86
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 10:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 156B589206;
	Wed, 30 Oct 2024 11:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="J4baixF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3F3989207; Wed, 30 Oct 2024 11:15:15 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9887E88E32
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 11:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e29047bec8fso611910276.0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1730283312; x=1730888112; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mypEMnAkYFHVW7TfwqQpwdizX34yT06MAibcxTJix4E=;
 b=J4baixF123fI2RM+ZHNJkp+wSN6mvWmWi2KJGBjoZhwpQDL3OZFqVpTjfIqFMCRIh4
 zszfCwiNcdDda0Puz4cAjAx6AspWJ1RlJDxiQP6lwECwr2CiEVBbjvMZJGRV/IUkLXnA
 +aT0qG2rSzezT7PUE++XnOsqbMCGRKs9jg/KG1WynN+/FZmGuqjMa4oQE1/LBWJ1Hv8P
 J7hIU+76uN+P8T0nIutH0xMnzm/yhdlBPkpls1gLMp44tcjycH6Ziq9owFfTdAG8pxWr
 wGyU2Rd2US6ZbtuIZTTWhvYWX1phcgvhU3yzj3kI09oJLKzVFe+SKDr/eXSqeP2kcHXQ
 oiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730283312; x=1730888112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mypEMnAkYFHVW7TfwqQpwdizX34yT06MAibcxTJix4E=;
 b=MuMRENPr7ObVyciLIg97QaiTefjz0sYo5NvJhFasfNwnZq6gX5MTyoXLbYj73kKZpa
 UmNNUsbkOQ+8OCNykntU3AF03uB660X7ixbfQdA38XETVhT9e1O8poSZMYI+Oc2D39un
 fWzeagIr5s9Ufo+3rNY3r4Uv1UTuBu7YldyoOKreAzIePQ20x/TSjq41DnMVBnKKishS
 H2fs2orkbecP3fAiDHtwlmY1cutq8PBzjvVxb9T4BN5gvS/TgUxA+tLZ4iL5Dr3BVrvn
 GSrsNfxyinlzL/91LzNf3PF2pKA6pmGyqor0qvIbGErn73QCR3FnpR99hpVbweA3yeLm
 1VIg==
X-Gm-Message-State: AOJu0YwboBDSgEPV1p7RLI7gWNeAqDgsADj3APdlNzUxq3OTAR0/aNVq
 /IQVWhLJqR3zeIYokt6DD8KcTg5lASYYTXbAABgjmIoOGjweWiBQFzPSQL9VjUiEYJHxWjh+Ahs
 o2uwD06Fj8AxkSlrWgSwF9+ONzx1DsBzr+MnD/6auP05Mnp0+
X-Google-Smtp-Source: AGHT+IG8q9phLXyocfNPGxyfxUl8b6Q1KF8Sd9AvGwqGmXWqU9j0QWbIMV5BvdP9yEQ+G+JVIwm3trxU0ne/0TgRTic=
X-Received: by 2002:a05:6902:2107:b0:e30:c930:4af8 with SMTP id
 3f1490d57ef6-e30d53e51b8mr1290880276.3.1730283312488; Wed, 30 Oct 2024
 03:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241028080837.1590247-1-patrick.rudolph@9elements.com>
 <173015803439.2338198.5277824884771902648.b4-ty@konsulko.com>
 <20241029025317.GZ4959@bill-the-cat>
In-Reply-To: <20241029025317.GZ4959@bill-the-cat>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Wed, 30 Oct 2024 11:15:01 +0100
Message-ID: <CALNFmy0NYAWH=E4hO7U8x74adEe6m=p4aqZ0-rcjJOP77eZQUw@mail.gmail.com>
Subject: Re: [PATCH v1] acpi_table: Fix coverity defect in acpi_write_spcr
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

Hi Tom,
On Tue, Oct 29, 2024 at 3:53=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Oct 28, 2024 at 05:27:14PM -0600, Tom Rini wrote:
> > On Mon, 28 Oct 2024 09:08:35 +0100, Patrick Rudolph wrote:
> >
> > > Fix "Integer handling issues  (SIGN_EXTENSION)" in newly added code:
> > > Cast serial_info.reg_offset to u64 to prevent an integer overflow whe=
n
> > > shifted too many bits to the left. Currently this never happens as th=
e
> > > shift is supposed to be less than 4.
> >
> > Applied to u-boot/master, thanks!
>
> "I'll just bend my rules and apply this before release, it'll be fine" I
> said to myself. But:
>    sandbox:  +   sandbox
> +(sandbox) In file included from include/linux/printk.h:4,
> +(sandbox)                  from include/linux/kernel.h:5,
> +(sandbox)                  from include/linux/libfdt_env.h:13,
> +(sandbox)                  from include/linux/libfdt.h:6,
> +(sandbox)                  from include/fdtdec.h:17,
> +(sandbox)                  from include/dm/ofnode.h:11,
> +(sandbox)                  from include/dm/device.h:13,
> +(sandbox)                  from include/dm.h:13,
> +(sandbox)                  from lib/acpi/acpi_table.c:10:
> +(sandbox) lib/acpi/acpi_table.c: In function =E2=80=98acpi_write_spcr=E2=
=80=99:
> +(sandbox) lib/acpi/acpi_table.c:498:15: error: format =E2=80=98%lx=E2=80=
=99 expects argument of type =E2=80=98long unsigned int=E2=80=99, but argum=
ent 8 has type =E2=80=98u64=E2=80=99 {aka =E2=80=98long long unsigned int=
=E2=80=99} [-Werror=3Dformat=3D]
> +(sandbox)   498 |         debug("UART type %u @ %lx\n", spcr->interface_=
type, serial_address);
> +(sandbox)       |               ^~~~~~~~~~~~~~~~~~~~~~
> +(sandbox) include/log.h:159:21: note: in definition of macro =E2=80=98pr=
_fmt=E2=80=99
> +(sandbox)   159 | #define pr_fmt(fmt) fmt
> +(sandbox)       |                     ^~~
> +(sandbox) include/log.h:260:17: note: in expansion of macro =E2=80=98log=
=E2=80=99
> +(sandbox)   260 |                 log(LOG_CATEGORY,                     =
                  \
> +(sandbox)       |                 ^~~
> +(sandbox) include/log.h:282:9: note: in expansion of macro =E2=80=98debu=
g_cond=E2=80=99
> +(sandbox)   282 |         debug_cond(_DEBUG, fmt, ##args)
> +(sandbox)       |         ^~~~~~~~~~
> +(sandbox) lib/acpi/acpi_table.c:498:9: note: in expansion of macro =E2=
=80=98debug=E2=80=99
> +(sandbox)       |         ^~~~~
> +(sandbox) lib/acpi/acpi_table.c:498:33: note: format string is defined h=
ere
> +(sandbox)       |                               ~~^
> +(sandbox)       |                                 |
> +(sandbox)       |                                 long unsigned int
> +(sandbox)       |                               %llx
> +(sandbox) cc1: all warnings being treated as errors
> +(sandbox) make[3]: *** [scripts/Makefile.build:256: lib/acpi/acpi_table.=
o] Error 1
> +(sandbox) make[2]: *** [scripts/Makefile.build:398: lib/acpi] Error 2
> +(sandbox) make[1]: *** [Makefile:1914: lib] Error 2
> +(sandbox) make: *** [Makefile:177: sub-make] Error 2
>
Appologies, I only build tested it on a single board.
Will send an updated version.

> And most other platforms too. I'm reverting this for now, and if someone
> is packaging v2025.01-rc1 too, just do that too. Sorry.
>
> --
> Tom
