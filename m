Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6028FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 14:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E01F84119;
	Mon, 27 Apr 2026 16:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SDXSgxEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9779584137; Mon, 27 Apr 2026 16:10:51 +0200 (CEST)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A1E8407E
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6501d242e3fso9734577d50.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 07:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777299047; cv=none;
 d=google.com; s=arc-20240605;
 b=cYWORmdSKcVvjNTF/8m/yK/Cv/FL/2kcRecEf7t+eYd1BV9QSL5z15lUmVbqRtb+Vb
 ywRgX8X3aCR8HU9BCu5Yz87AZTHz+/A43Sv18dvE25apJUZsh7D8yajqzuXxtf2pcCpf
 nuDLHAtTjXVRwKpqXsbN+cGqzSNfSrXNfSzuK/NvB7TLbeFlznKotXEPTm5HQkkGBf9G
 rltFA8S6rfoauX0WBCGEvCvQKl/vA0q2usuDjoSAiurnVQTniuqFTbWCoB+ONBlaSfTC
 LCYyPA0yAcbcUF3G/pDgBwyoWPaZZP8SO71hLmNm25FzVO1jsvkZSCVNl93Yy0h3i5UX
 nnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FLdYfGVgngtxiRQxyklnmXkicSbHo7dzMy2osVxnLAs=;
 fh=Szd7VNGVgzMPth/0KSrOxLdefyX/dwhFtux0gdtFwjQ=;
 b=eJ0PnRgQuztsvTVTZ0SQyHxErOqI1XK/uDKnkNwBq6xmwg6WpoNsrWv2TKi6sx5KUq
 1fOFU/WLAIEVsiA8CC/XuVZSkYEZ1FFAUNeOsRXX8ZlOSqRjJzc8H/KZ1zfG4IUsOyq/
 wuyeEoYTXESElHk76jNeEQ4C9pyxPudV8d0uZLe5OPo8VzBA093VvESfwxuy9IwUKDPp
 rpZFXqhsFPYGWLoJtaak+btdIDAV/30rCtlysPq3Gm5UPkvCsE664AZJQ5zzoW2bML0A
 b59DBi8cZop37Fxr60A7/yFpUUjqEhE2PRZwouc7BTNoQ6F2sbW+4kjglIb1dZq/2mzU
 M4GA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777299047; x=1777903847;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FLdYfGVgngtxiRQxyklnmXkicSbHo7dzMy2osVxnLAs=;
 b=SDXSgxEad7mFjEwSSL/oaSFI8RibOnYFZ1y5Vl7RzqqEhMcYKt6lFV9jOxqU8mpJbB
 rDC/DDeLGnumHKLiYhvDI12DwIUsgRtzcB15r0F586sUkpO8oInddBz4kiNvdjoOtTCu
 +Uzz+C7dXpOfV53nVrYnzbkoMd5CFAu6Wx/2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777299047; x=1777903847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLdYfGVgngtxiRQxyklnmXkicSbHo7dzMy2osVxnLAs=;
 b=mb9tfVtFAzrtN9TCGX5C2nCpfEfnlIPvokMjCDD8N1XGND5kZ7IXbXcDf3PQyPl5y4
 EPJUZzvBxZNdyB5zlcfEqVLzWnNE7U7jb0W3N0SkIrYe/e0PZbojfpWAvmW82QD27DcY
 XbqymjC7Qqr4TcgK9S/cOZUlDr3yLTolCebE8xG7twtnkqTZlOv5Q6BtyhJeqRs7zu+C
 UFeeX1mrfpWmm6D9MvTzVAw37KYfPDyvCkKUSogYn9RWdkGqZbCB70xspVdzN8uDzO0R
 Bpm4+EjX+/KjllpzmRrO/3HOHNFOdNk7s7QxfMFHGNAMduHAFuXNDEt9c7OUNy7encyW
 l/wA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/naCHug1bfH/pO/PIIYe8q8l59MoquURkAGEQqG4w2Ytz+Xjv9J7+fuORNmfqkiSRkA3uGHe8=@lists.denx.de
X-Gm-Message-State: AOJu0Yzsf6MYSt1BOO1zMO6FQABDmQChxjHUCj7rp1usiT9sNztDONjy
 TrpuzA43u1ZUCupy/y3XtPJc93NpcRZytIDaiwKSueDImaYLbKBXTYUKFTuWD9CiPXyt+hzCaP0
 HROeSds3V7DcwIlWpjx4P+dW6GaN0WXSV1BDF0HJfpM6EjCEYuslI
X-Gm-Gg: AeBDievRXuaHwwnOf0I+fQ6GChD+/bDFm9GPCQQWQNXhUfuWAV4B8AB+ea4l5T8ZCjg
 vbe4GKejv3h1EypvuDkhqG7Ud/C5Vgg9IXs9dCWNOQk3jY0fk8/s2q0AclO0KW0+gCtpdGfkm+u
 5lYNTLTEb2yqcoL23pU7fdyL7pUf5d/lAZfIDtumbkFFONpJlPxX0jp9QOyiOWVOSMt392uqBFL
 HPi9TjVjRQPwu3ZYhsTcgvFCVuYg0AyiXINtrZ3QU7oxpsF9FSRGWulP6ggdC2ws1bYsFVtlk8f
 DX0I4tep6vEICACra6lf4hQWe00HXcTQh70QyWZF9TbLEUDwZw==
X-Received: by 2002:a53:e1fb:0:b0:651:bc7e:4687 with SMTP id
 956f58d0204a3-653109adab4mr25340443d50.42.1777299047069; Mon, 27 Apr 2026
 07:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260327140508.3680105-1-richard.genoud@bootlin.com>
 <fb530fbd-6dac-4f37-8447-dc15e9b0b0fd@arm.com>
 <CAOf5uwkUXrsX6w_1LYiLK+f5HFsefx3t6Qp5urxEu_N-15KZ7g@mail.gmail.com>
 <86b9f145-e94d-44f7-b8d5-8ced07f478d9@arm.com>
In-Reply-To: <86b9f145-e94d-44f7-b8d5-8ced07f478d9@arm.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 27 Apr 2026 16:10:33 +0200
X-Gm-Features: AQROBzAOrKtmlmOK6-u5ISW_XtqBuTI-HweYrQYbYXhhSb7lCEFvIpFZyj39ot8
Message-ID: <CAOf5uwnfRXyz-q4xFgGR=xwne-fggSJrmZKZU_x7R+xHEynhjg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mtd: rawnand: sunxi: Fix user data length for H6
To: Andre Przywara <andre.przywara@arm.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

On Mon, Apr 27, 2026 at 3:47=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com>
wrote:

> Hi Michael,
>
> On 4/27/26 14:31, Michael Nazzareno Trimarchi wrote:
> > Hi Andre
> >
> > On Mon, Apr 27, 2026 at 2:28=E2=80=AFPM Andre Przywara <andre.przywara@=
arm.com
> > <mailto:andre.przywara@arm.com>> wrote:
> >
> >     Dario, Michael,
> >
> >     are you going to take those patches eventually, or are they suppose=
d
> to
> >     go through the sunxi tree? Somehow patchwork put this on my plate,
> but
> >     MAINTAINERS says it's yours.
> >
> >     I will have a final look at those patches, but I think they are fin=
e
> >     since their counterparts passed the kernel reviews ;-)
> >
> >
> > Company projects are stressing me out. I will check today with Dario
>
> Sorry to hear that! I can easily take care of this series, if you are
> fine with that. It would touch only those sunxi specific files anyway.
>
>
Yes it's ok, good that you can pick them

Michael


> Cheers,
> Andre
>
> > Michael
> >
> >     Cheers,
> >     Andre
> >
> >     On 3/27/26 15:05, Richard Genoud wrote:
> >      > This series introduces the correct usage of user data length for
> >      > H6/H616.
> >      > If the older SoCs must use a fixed value of 4 user data bytes fo=
r
> >     each
> >      > ECC step, the H6 can have a different value for each step.
> >      >
> >      > In the first round, the behavior was kept as the one used by A10=
.
> >      > But we have multiple choices:
> >      > - do like A10 like before (and not use all OOB)
> >      > - do like the vendor kernel (different from A10, but not using
> >     all OOB)
> >      > - use the whole OOB for user data bytes
> >      >
> >      > In this second round, the third approach is implemented.
> >      >
> >      > All patches but the 4th are code cleaning.
> >      > The 4th patch enables using a variable user data length for
> H6/H616
> >      > along with maximizing it.
> >      >
> >      > A similar series has been accepted for Linux:
> >      > https://lore.kernel.org/lkml/20260317142437.580204-1-
> >     richard.genoud@bootlin.com/ <https://lore.kernel.org/
> >     lkml/20260317142437.580204-1-richard.genoud@bootlin.com/>
> >      >
> >      > Changes from v1:
> >      > - gather reviewed-by
> >      > - clean sunxi_nand_chip_init()
> >      > - use all possible remaining OOB space for user data bytes
> >      >
> >      > Richard Genoud (5):
> >      >    mtd: rawnand: sunxi: Replace hard coded value by a define
> >      >    mtd: rawnand: sunxi: make the code mode self-explanatory
> >      >    mtd: rawnand: sunxi: clean sunxi_nand_chip_init()
> >      >    mtd: rawnand: sunxi: introduce variable user data length
> >      >    mtd: nand: raw: sunxi_spl: remove user data length reset
> >      >
> >      >   drivers/mtd/nand/raw/sunxi_nand.c     | 292 ++++++++++++++++++
> >     +-------
> >      >   drivers/mtd/nand/raw/sunxi_nand.h     |   3 +
> >      >   drivers/mtd/nand/raw/sunxi_nand_spl.c | 129 +++++++++---
> >      >   3 files changed, 324 insertions(+), 100 deletions(-)
> >      >
> >      >
> >      > base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
> >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com <mailto:michael@amarulasolutions.com>
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > T. +31 (0)85 111 9172
> > info@amarulasolutions.com <mailto:info@amarulasolutions.com>
> > www.amarulasolutions.com <http://www.amarulasolutions.com>
>
>

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
