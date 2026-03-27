Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A1010BA422
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 03:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A2481E18;
	Fri, 27 Mar 2026 04:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="NsCknT7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCB4B83CF5; Fri, 27 Mar 2026 04:10:17 +0100 (CET)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F00D280517
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 04:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso1592852d50.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 20:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774581014; cv=none;
 d=google.com; s=arc-20240605;
 b=GzLzxLaXM0CqXByyDQn6SZDrJtQzn9bWuNkSdkTV52iB+WYPqLgJIXoDRdI3lHd5/k
 fFc1UtBg40ga5IslsjA9aHg1vrHC46wvyaqeljHXTukulEw3hglestcsJQlAHIX3D51j
 AVNcETk2YfRymAJeJrfYD4y5JTYcd7F8EjLodGIArFAfqD27mJVcH4DV1PCBNSRN+TtK
 uw0TiWkfQQwWC/Oyij6TZXoHGfgWjV03a2yJvjIpWxmnimpw117SYx38+GRChI+yVvQn
 oK/J8/dSEeLWKBJy4jHrZ0cgtj8tm3BUiRHUiB17dSl0e1vE64Dm4qnAjQmMwv/qhxY7
 ujjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RSebRSZxdsbA7SrW+6RqMrc3w4k0GMjTAN+RxogTVPM=;
 fh=JMXHZDCYPMdmeaqNYC6J/i6G1pHMRozwUIVBIZsNHXQ=;
 b=Hp+heOVJX8Jf2LzTwefmzDwqiMuH8HW2cFZjwZawo2D1bnvl/Gwnr+0SKO+wClk3dj
 1cXHrReGN5cdH7Dcn0KdawHqHDRhGfuA22j5B7l2ExOpm6XMh13ooTHjpjliiTn9b9P7
 mQ0tqPU5ZMVIE16WS0i4gUep7DR98Lujl1mcJgrgftzX9YZVn+4dJfnP/LqXqlKME4Vq
 YeW/9vDd/TVuaf9oN2B0mh+jR4PUkf0zf7woiZ+wBsX5CqiYlYdY1qNM1gWO4ryPNJzJ
 oyLjoq8NsuWQjTKlvJIXrPVxWTydIgxh7fjYc9JeO4ycvx8xh3TQ/uHmyXb2dLzAdfkm
 GT/w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1774581014; x=1775185814;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSebRSZxdsbA7SrW+6RqMrc3w4k0GMjTAN+RxogTVPM=;
 b=NsCknT7jCwOKvP+vTHJAFVjFNfq4bELyEUwldQ6cqoraYf46J0pMRqSsmYW9uMWnQB
 B5SYxMhbSSmvqWtnHxkC7TPpQ8h8gbtTtmuXrroTyaaj3EyE0WiiAm5pLTCSlRcBEZ/9
 L2DUPu7UxpEvLj1Mk/2EtHFoPamVgmbfJ3frwDj1P6W53efL6zjv0vX3L2UZ3gGLa/Qv
 Gb/AWi9luDJeyq5hY1n2gqhcbT1cxjactdszaNcCjC8v31AhRMhd7wOroSeXLKa2DCAY
 FFaVlKrbKaMywetOgKuYvNhQ3ibDCO25HTZ4FCJNreMppUSLY0wC/JLXhN/RfbgegXa0
 Bt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774581014; x=1775185814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RSebRSZxdsbA7SrW+6RqMrc3w4k0GMjTAN+RxogTVPM=;
 b=QSf5/YXbN92P9aDEdigVx66c3zjidxlX3NFOH5NOvlHamJG2eRR8rGr4iAbRGfE1wm
 nGh1oHzmCOhv20qv28XJA01xj2DODT+gGc7cgA5mHMj6hb8/SOn0DiLlv60Texni1814
 R9xHbgeSagCtbSAbo3JlRzxhpW9C7de7vOcwjJrFP0QwrqlBKKEiq6VwuFhAC/lpEoNg
 IVAFApFK1RR1VXTODhI8jfI/GWtns8DgyNhSxHvQR+gASX4shQNjLei6w5L/63JNCXGj
 zmoof08Wo4wVjjmngAZQbtreC4GdWOSbHBedmWJA+qlMIHwOqwhC2L5GUQffwTim1Oa1
 esSA==
X-Gm-Message-State: AOJu0YzKDn3SEV5xwamWw70SuC1k1oPeteZBhWNSXsrcT+8MKNScmf6/
 oAh3Pr9ip1hR8ahkcaXYICSJfukoyHgj79sH1MOPjc34bO861EgvuuOox4ZbT5r66kUF6aRejdz
 L5nIzErH1iatc7I0dd9sXgjwjnt5qFHcOVL6BBBjXhA==
X-Gm-Gg: ATEYQzwrgjkSrH8r4+r3oku9Mr27NjDgc9Mvgat5ThFLFDNJB8ROIOmC3BBDwkVcgwD
 HmtTEUi2tcVPBsdHIuvEYNYYta5OQcBw69f5Cd7x7XukON+Xz2tX2apDGK44JkItcKz9GGv9gKp
 tovvFc7lKKQN36J3LSUzn7Nv0Q4bGVUCOxv2zmiUtMLmNeDa2oQh5kkcsQpwM6ZPW/XNmBr4Tr0
 0GCTYw2L2ALoNr301xw3iDB+8++I6PKw2od388c00Avh7saFxwOmf1haTsFVWfefvD2YyyQNkvO
 5yxgKAJX5QBZhxLG3azgXUBGw10mHa8yGRlgm/swYvdpTYmczzNIrkirvfb0B5Z3zao=
X-Received: by 2002:a05:690e:69b:b0:64f:9647:e7be with SMTP id
 956f58d0204a3-64ff720b305mr786042d50.28.1774581013665; Thu, 26 Mar 2026
 20:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
 <87d4cc89-e60a-4365-b6c0-efe5b20d0c7f@online.fr>
In-Reply-To: <87d4cc89-e60a-4365-b6c0-efe5b20d0c7f@online.fr>
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 27 Mar 2026 11:10:02 +0800
X-Gm-Features: AQROBzCu-v53mHtDgt3hJI1b2f95mym4iuQSOjMbpLo6DaHJNFaeB_k5L3LhhQU
Message-ID: <CAH1PCMa_+n-sVeFnUwKwXcSyRrpc9f9MeCPnR2WNbLA+V85XPQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] Add board support for Spacemit K1 SoC in SPL
To: Vincent Legoll <legoll@online.fr>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, u-boot-spacemit@groups.io, 
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com, 
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, 
 peng.fan@nxp.com, xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org, 
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org, quentin.schulz@cherry.de, 
 samuel@sholland.org, raymondmaoca@gmail.com
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

Hi, Vincent

On Fri, Mar 27, 2026 at 2:36=E2=80=AFAM Vincent Legoll <legoll@online.fr> w=
rote:
>
> Hello,
>
> I wanted to try this series (applied to upstream u-boot, next branch),
> but it failed to boot properly.
>

Thanks for testing the v3 K1 SPL patchset.
Actually your result confirms the SPL patchset is working correctly and the
build/test procedure is generally complete.

PS: I added some walk through to the key lines in your log below (for you
and for the community's future reference purpose), but for here please be
noted that as I said in the doc patch [1]:

"After DDR init succeeds, SPL proceeds to load U-Boot proper. If
 U-Boot proper is not yet available (as in SPL-only testing), you
 will see SPL: failed to boot from all boot devices - this is
 expected and confirms that SPL with DDR init is working correctly."

[1] https://lore.kernel.org/u-boot/20260311073741.80616-1-guodong@riscstar.=
com/

> Note that I tried to follow instructions from:
> Subject: [PATCH] doc: spacemit: add K1 SPL build and test guide
> https://lore.kernel.org/u-boot/20260311073741.80616-1-guodong@riscstar.co=
m/
>
...
>
> # Here the path to fsbl.json was not right
> # See:
> https://gitee.com/spacemit-buildroot/uboot-2022.10/blob/k1-bl-v2.2.y/boar=
d/spacemit/k1-x/configs/fsbl.json

Thanks for bringing this up.

Regarding the fsbl.json path: allow me to explain the upstream gitee
repository URL has been redirected from
  https://gitee.com/bianbu-linux/uboot-2022.10
to
  https://gitee.com/spacemit-buildroot/uboot-2022.10

Somehow it causes the fsbl.json path in my doc [1] didn't match.
I will update the repository URL and fix the fsbl.json path in v2 of
the doc patch.

>
> U-Boot SPL 2026.04-rc4-00543-g2ba03a569e61 (Mar 26 2026 - 16:48:44 +0100)
> Fail to detect board:-2
> vdd_core, value:900000
> vdd_1v8, value:1800000
> vdd_1v8_mmc, value:500000
> DDR firmware: [0xc08159c0]:0xf0227179, size:0x8d98
> DDR is ready
> SPL: Unsupported Boot Device!
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###

To walk through the key lines:
 "DDR firmware: [...], size:0x8d98" - DDR firmware loaded successfully
 "DDR is ready" - DDR initialization completed
 "SPL: failed to boot from all boot devices" - expected, since no
    storage driver (SPI NOR, MMC, etc.) is included in this patchset
    to load U-Boot proper

Back to the patch series itself, your log is a good validation of
the v3 SPL patchset.

Thank you again for taking the time.

BR,
Guodong

>
> Thanks
>
> PS: I just (re-)subscribed to the list. I tried to get the email
> threading right, hopefully it'll work.
