Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22113E7717D
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 01:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82C3888E31;
	Sun,  8 Dec 2024 02:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X4l1F3nr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C85F188E2D; Sun,  8 Dec 2024 02:19:47 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28DDF893D1
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 02:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6efa1e49ef0so33937207b3.2
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 17:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733620784; x=1734225584; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prd+Lzldtx6uEzpYK6qlJgNqnSuEtyumEYyJRns3HW4=;
 b=X4l1F3nrx1X+k3kPSIed7a83SH3DQSEiv0zLH4YRIc+Ua3Mf5d7hTELueGn+05yxZN
 DAdNaO9ayR/ir5y2qxIEum20sYED49Tl5salOw0tu+IuOt3KJpGQ19R0ish8+112j1rR
 JboJIdEuVU4ula2OHgXJ27+KYxU+mgi+0UKHvInNIY+XngLJc5dPbcf1kEPyMlUdRcOr
 4xrHCIWqxle5nQgJdxWOvGfvtYX8PwenlnqBf0pRsEiLxmFzXBhiLDSKYDXe8WCQSplz
 c8O+xvE7JvCpixmJDCxmh5FHZxPwjL2hn00clrkJOwgznit/bgFVjWjMEwnWLHvfwZVF
 YhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733620784; x=1734225584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prd+Lzldtx6uEzpYK6qlJgNqnSuEtyumEYyJRns3HW4=;
 b=bPrjVFas2DWFJteZUC34+Y63ZJzM76TOwMgUApnmh2r2d87dR86z9Pp/5knrGBIfnO
 DDNclSz3AFtK0IXVVXnf9jOypEMjXQlW2cl7hD3yoDF4eHhV9pweaIY0tKk+xM5dc9NF
 h/7m9uvKPxkG335guUvHZ9bRIdrvNKPqk4K2ghDJzt8c1WFpqP1x1WVCNI+F4LfrqQ7X
 eCsHM5+iCiFF3eSAnSMFY5YJkYA0EgRf+9SdkKAuf2Pspycpt37g2/PY3jHDsLMAGsP+
 JdM53RZCsammkbNEY/pBfL39C/yvs6Xm2G8vlLrghhDexcNZtTuo32gsUatNqEjMHKC8
 oixg==
X-Gm-Message-State: AOJu0Yx2sLBkOMHxZWfjo2RNC57FKs95eCvXJmadSDfYvXeVZKHqJ7lc
 bo/XUahET2dh0g/gZrKPnnGIRMFICH4ObFtlcV/1iCipuuwhrL+hIwr5PaBsUamylfKpTl3RRGE
 29fPjMo8o4sthe7YlqJ/rePvmjbJgH2Kv8x+p2w==
X-Gm-Gg: ASbGnctl5wujfMJRPjZoeG08+DFQjqlrjKNpaJzXy2kR98AWrhJpjro8QIH+bMZbR7u
 EZAxZcQCG1qquneTNS/JZDZCdbm1cieY=
X-Google-Smtp-Source: AGHT+IH6eoSGi+jO5jeNnW0duYwxdgO5r/uMU7lWwGWDiHm1ej3JkE/64hDX9nu/l4Bc7HlnUuhyxo99lnyz1l5hspo=
X-Received: by 2002:a05:690c:4d47:b0:6ef:79d8:c908 with SMTP id
 00721157ae682-6efe3bf91a5mr85787517b3.14.1733620783811; Sat, 07 Dec 2024
 17:19:43 -0800 (PST)
MIME-Version: 1.0
References: <CAPLW+4=qP6pCN0xd9n3U5jBePJk2jEKgixCs1A_uBaDTwFLT4g@mail.gmail.com>
 <CADg8p95bi5G48xZdT9+gqzKEByN4C3ZxfQHNPEaCX=0_559T9w@mail.gmail.com>
In-Reply-To: <CADg8p95bi5G48xZdT9+gqzKEByN4C3ZxfQHNPEaCX=0_559T9w@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sat, 7 Dec 2024 19:19:33 -0600
Message-ID: <CAPLW+4nh2kxgV2ri=kkTD6pLjM2--aewZ4kMO8cjagv5OZCXUg@mail.gmail.com>
Subject: Re: [REGRESSION] lmb: add and reserve memory above ram_top
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mark Kettenis <kettenis@openbsd.org>
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

On Thu, Dec 5, 2024 at 11:23=E2=80=AFPM Sughosh Ganu <sughosh.ganu@linaro.o=
rg> wrote:
>

[snip]

> >     ERROR: reserving fdt memory region failed (addr=3Dbab00000
> > size=3D5500000 flags=3D2)
> >     ERROR: reserving fdt memory region failed (addr=3Df0000000
> > size=3D200000 flags=3D4)
> >
> > It looks like all mentioned error messages are harmless, in a way that
> > I'm still able to boot Linux, and U-Boot reserved areas still seem to
> > exist in 'bdinfo'. But seeing error messages like that is definitely a
> > nuisance by itself, and might be an indicator of some actual issues.
> > Do you have any remedy for that by chance? Please let me know if you
> > need more debug input from my side.
>
> This seems to be happening because the board is trying to reserve
> memory above ram_top with no-map or no-overwrite attributes. To
> confirm, you can print the value of ram_top in setup_dest_addr().
>
> -sughosh
>

Thanks for your input, Sughosh! I did a bit of further analysis, and
found the mentioned error message is happening on 3 different
occasions. All 3 of them are caused by the recent LMB patches merged
in U-Boot/master. They are all probably harmless, but a bit
misleading. Also, I'm not sure whether they are actually *causing*
those errors, or just revealing some already existing issues.
Specifically those 3 occurrences are:

1. The one reported in this thread. The root cause, like you
suggested, is the board trying to reserve the memory above ram_top.
It's actually happening in lmb_init(). Details:

  - The 'memory' node from my dts:

        memory@80000000 {
            device_type =3D "memory";
            reg =3D <0x0 0x80000000 0x3ab00000>,
                  <0x0 0xc0000000 0x40000000>,
                  <0x8 0x80000000 0x80000000>;
        };

  - Reserved memory chunk: (addr=3Df0000000 size=3D200000 flags=3D4).
    That's 'ramoops' chunk from the 'reserved-memory' node in my dts.
  - ram_top (as seen in lmb_init) =3D 0xbab0_0000.
    That's because my board's dram_init() calls the
fdtdec_setup_mem_size_base(), which only takes the first cell from the
'memory' node.
    Which is 0x8000_0000 ... 0xbab0_0000.
  - So the reserved memory is above ram_top, as you suggested.
  - Not sure how to properly fix it though. Maybe I need to "teach"
U-Boot to use all 3 chunks from my 'memory' node somehow?
  - I was able to work-around it by reworking the 'memory' node in my
device tree as described in my first message in this thread:

        memory@80000000 {
            device_type =3D "memory";
            reg =3D <0x0 0x80000000 0x80000000>,
                  <0x8 0x80000000 0x80000000>;
        };

2. When booting Linux with 'booti' command, there happens the repeated
attempt to reserve all 'reserved-memory' chunks, which were already
reserved during the board init, which also leads to similar error
messages. I addressed that one (hopefully properly) in my series [1].
Please take a look. That one is caused by a combination of these two
commits:

  - 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory areas
with !LMB_NONE")
  - 827dee587b75 ("fdt: lmb: add reserved regions as no-overwrite")

3. I noticed another similar error message when running sandbox U-Boot on m=
y PC:

        $ make sandbox_defconfig
        $ make -j32
        $ ./u-boot -D
        ...
        ERROR: reserving fdt memory region failed (addr=3Dfffe000
size=3D2000 flags=3D2)

  Can you please check that one on your U-Boot/master? I was able to
narrow it down to commit 6534d26ee9a5 ("lmb: do away with
arch_lmb_reserve()"), if that helps.

Thanks!

[1] https://lists.denx.de/pipermail/u-boot/2024-December/574308.html
