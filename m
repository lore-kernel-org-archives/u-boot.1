Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E7AD3DEA0
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 17:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B69188C3E;
	Fri, 18 Oct 2024 19:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CvjBJfaO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62ACB88C4D; Fri, 18 Oct 2024 19:20:45 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 388A688BBE
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a9c3a4e809so182689685a.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729272042; x=1729876842; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zjR0F8lwsFt0fchQu+UjOxc94+DG99eXqDNlmMDUSB8=;
 b=CvjBJfaOLEFWBPgJ4BYjF70eOIT8WnsJgzm/bnVH9VFy2rWaSOZlK2g0vQ8a5GJjki
 SO5I+1cLAVY1Qx8P3G6kbnNR3JAzZ+BTGCW2VcNX9y/KL8LGwtCweZEQElEn45MNRF3T
 L8t6y0weY8qKhpHl/xQe5G21gudrQjAtdusMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729272042; x=1729876842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zjR0F8lwsFt0fchQu+UjOxc94+DG99eXqDNlmMDUSB8=;
 b=JfO0w1Eu/q1Em/fVIbdJ5ze5N41SZy5PwBui3uYfXTSAkPPCJy7NBImsbIY0kA1bnD
 YD6f2TEcNfVi54rpFK+54ofFyhvo9PwiP/FD++/tSNLCJLG3HXUzMWnfPwThZlFfdm60
 n0VxDaJQyw0zEsg0x2082+aVUtDJRxM8RnSuWOTAKkPidiCEibVhVXNXukvJ2z9ez8Oy
 kMyybHi3di6UUyWMX0FpQ8Rn5mN6INxr11n9DOU1BEPsDCBTnT90/iUSJAWN0Y+D+A7W
 U3dvHuaRMsuHpeeiFOLD1ovxsrxZ0gWFZT0E6BcbYDj8H+fly0YUTTHOZiH6C0RYF5x8
 orHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6a9+A9ktp29O8Gb1WNPR3eqjtcwI3LvIsnS+J3VSa3KJTccJRaltwkQwzFtkbdvcQn+cCcww=@lists.denx.de
X-Gm-Message-State: AOJu0YyhlIOBkoDfWcY16t8f/+h+sJWwAY23OOe/WzzOjevaj5Q/aUB7
 2DTSlSeoLoYdS61hxVTXrRs7XY0q2LG781EVDaPxXkPAMZPs5fpMzBsrsggUifZNdLkt9LIA7vO
 3xhPw6HvVEYHPwWIwcioKnIKT4VpuL4jlyXHW
X-Google-Smtp-Source: AGHT+IHbrMdvoYwzS7Y86tq+vGq7p3OzEkPj24Lk6Qqnd6JvjriuL1Kq1xWvvEcaVsOmEFmB1r9kVJqKP9ABXXnH7Ts=
X-Received: by 2002:a05:6214:5983:b0:6cb:d4ed:aa59 with SMTP id
 6a1803df08f44-6cde14c6225mr43998236d6.4.1729272042007; Fri, 18 Oct 2024
 10:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
 <CAFLszTjL0VfVJZsu34ik2uX8D_qpdiuW=OXoiromA1gOJ2vxLg@mail.gmail.com>
 <CAC_iWjKMo7=RE3=1=y3MpgC95itO170ruJYk6omh-4NuAJ8SRA@mail.gmail.com>
In-Reply-To: <CAC_iWjKMo7=RE3=1=y3MpgC95itO170ruJYk6omh-4NuAJ8SRA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 11:20:31 -0600
Message-ID: <CAFLszTiASiKYeau0DbuK0p3HVQSxBA1zfy-ua_Wo441jPf5_gw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Enable https for wget
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, raymond.mao@linaro.org, xypron.glpk@gmx.de, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
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

Hi Ilias,

On Fri, 18 Oct 2024 at 09:06, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 18 Oct 2024 at 18:03, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Fri, 18 Oct 2024 at 08:22, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Since lwIP and mbedTLS have been merged turning on https:// support is
> > > relatively easy. We need to enable the missing algorithms and modes of
> > > operation in mbedTLS and enable TLS in lwIP. Someof the lwIP patches
> > > are in their github as PRS, but since they haven't been merged yet, we
> > > need to carry them for a while
> > >
> > > patch#1 enables the crypto algorithms we need in mbedTLS
> > > patches#2, #3 enable anf fix the lwIP part we need
> > > patch#4 is adding https:// parsing support in our wget
> > > patch#5 is making https:// the default for QEMU lwip defconfig so
> > > people can easily test
> > > and finaly patch#6 updates our documentation
> > >
> > > Ilias Apalodimas (4):
> > >   mbedtls: Enable TLS 1.2 support
> > >   net: lwip: Enable https:// support for wget
> > >   configs: Enable htts for wget on qemu arm64
> > >   doc: uefi: Describe UEFI HTTPs boot
> > >
> > > Javier Tia (2):
> > >   net: lwip: Update lwIP for mbedTLS > 3.0 support and enable https
> > >   net: lwip: Add Support Server Name Indication support
> > >
> > >  cmd/Kconfig                                   | 19 +++++
> > >  configs/qemu_arm64_lwip_defconfig             |  1 +
> > >  doc/develop/uefi/uefi.rst                     | 45 ++++++++++-
> > >  lib/lwip/Makefile                             |  3 +
> > >  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    | 50 +++++++-----
> > >  lib/lwip/lwip/src/core/tcp_out.c              | 10 +--
> > >  lib/lwip/lwip/src/include/lwip/altcp_tls.h    |  2 +-
> > >  lib/lwip/u-boot/lwipopts.h                    |  6 ++
> > >  lib/mbedtls/Kconfig                           | 12 +++
> > >  lib/mbedtls/Makefile                          | 33 +++++++-
> > >  lib/mbedtls/mbedtls_def_config.h              | 52 +++++++++++++
> > >  net/lwip/Kconfig                              |  2 +-
> > >  net/lwip/wget.c                               | 78 +++++++++++++++++--
> > >  13 files changed, 273 insertions(+), 40 deletions(-)
> > >
> > > --
> > > 2.45.2
> > >
> >
> > Can we create a sandbox build with lwip as well? I'd really like to
> > get that testing moving, so we can test simple networking cases, as we
> > do without lwip.
> >
>
> Someone is already on it. But it's going to take some time as the
> current sandbox stack makes too many assumption for the backing TCP
> stack

That's great, thank you!


- SImon
