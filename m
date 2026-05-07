Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DE0CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 11:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 749C084A75;
	Thu,  7 May 2026 13:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="xCRnom3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A38E84A72; Thu,  7 May 2026 13:59:56 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5876084A72
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 13:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6530287803cso729226d50.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 04:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778155193; cv=none;
 d=google.com; s=arc-20240605;
 b=WyDHfSgswNrw5Nt6nxJAgbDYlxwltpE3Uj+OIwcroUVQzBpmgOBT2EA6TTP5LyFb7K
 6p44T8nPhd+pm7Fjr5y8yXycphJyZD6+trz6sEqfTpnlgXUOGsvX+raQ18g8s27SOBFN
 G9rekmQklEUbXfhSxK6qZ7fceMllcxZyCa03RSTMEMM4+dI1RPBKgba51TrYkWZIQuUQ
 T/olOB7h7f6MgtwR8LcC4vg0b80kJCo3NUjdV11JD5lSLa2eXF57KwVwdssFDcvFC5eM
 nmBjqMwpLIHZ5lqmdTpp7lMOtHTTf/RFKzyLyPQwecDQ0nO1a87Kzn/PN1hw1D/NdMzg
 xHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ezLeU7IP1hnfpua7tVRHyolJuoyndYKWmb3c8Zb2b1Q=;
 fh=ECBmsllh1P8eQu1ro8AwKXG1FkFlcIETP3dwK7IFcvk=;
 b=WoaKJajhZ1IvyicZoYGJFliLTGMv0ID8r+UulGxvzGB/rJkhwBdTde6dZv7N+1uCPh
 937UvtktOSHbmhrDNpwC140brL+gLZwuruAngOg2WqN62GH3+N0M2RXVCDt0dQyjdS5Z
 SOVtKZHpaFh/X9LbDlVmYiFS/baTolMaBnqYnkEM/DEQ0ROfPo1WdieBFO4nCAUvCTf5
 NrPPqGqWfjJK+Qz/CO7+72+UAEIWAOINQD1+UgkODaKK+12zhtYB7LetKpkULp/t6sD+
 /Y7bbLgSHsFuJDUkZrBrXXhqiVXFfmQaX43MybwXkyY/2cVvWjjzq2tYY+0TYs0W15kz
 Vyqw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778155193; x=1778759993;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezLeU7IP1hnfpua7tVRHyolJuoyndYKWmb3c8Zb2b1Q=;
 b=xCRnom3t31eG6iJJ6mxcbOaHnx1hozTUMPHTx0JH9LA+D+kw9zqPRjJ/YBde7ltl9h
 OS5ERR4JzvS23cXzrUlTzwT/FmE92cWOSShOjE15/Kqpwln3uc2c2bxurAJYw8Rv9J2+
 fBmnSv5VxgHG4CxvJTyhOB/hN353xNtskw2chWPdC6TV+SnU97egafhw4+AoBn3vGglg
 tAs1pbPNmiYQYP8qvtc80HqcclgO8RWk+aGt56fYIVvu/rmo/gA032r4IbPwafh3U0Ih
 lF0oxrCmXtdyrS5d8ZFlYKymNh7gGfQXwqBA9/6suUEwL+RO8qCmBu6waqXt/8heGm77
 AaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778155193; x=1778759993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ezLeU7IP1hnfpua7tVRHyolJuoyndYKWmb3c8Zb2b1Q=;
 b=d7CUMmAVCFm5CqqfZDhFcbSgQtzzcIOAYtXYbyPM+H/WNmIkjYuWBJUXWgpB7ofUNY
 vofR7hLicVY8HiGlMIf2vQA61OyrTzNDhmfrqd5x/KzRiVg8gH/SoRyCf7szctRNX3X8
 HXQQhOCiAPBBDFwAztNnjInD9cRUwA8sA0comhACEsUGdhGRTTEQo7HCHN/VNF+pEQtR
 knMkP6esJvA4j8kyvmHSE/DuE0QEEC2Y+uOnTj2JlgzBxP1C5E5DAMe4/vku1VKlE62B
 nmH0be1ESLsu1bBQ6YlPcf2JGBroGc2OK8Pe04iP63KQ7rrfR+84V9p8d+ADYHzjQSBC
 EOIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fRdWxSxJnQwSMIbazbUe9usuiIYxY4Oms6rE4VF1wQf7hgvRAeaO3urxBzxyd71UcbpSk97A=@lists.denx.de
X-Gm-Message-State: AOJu0YxPKqCLV9+hOchlNPxA1j16uh6tXl2YlOOxgwh1CmfkIl6/H5Fx
 99z4zB9nOU+xgW+a9KUnpvdu8Jc9VJhQnn4UqPYdvKf7B15p12fcLPerqHuL9bsfbAgiVh8caUa
 vqtW+qYDcfrQ/RVWMyb7C1AzZJ4e8pI0suwe3pb76vQ==
X-Gm-Gg: Acq92OFFDML7l1u2fUfkVH6H5M1+OXwUyrDRnxcjBxHRUyGTknNgFSAd/4eg/yaID+R
 ++1ff0lRGp+/JtmXrxinWyBH7N4Ut+jtPapS3h8Xp73sc8lFT+b8f6CLO/+Cq2sIOVzWBOyYQOS
 XhvG4GiJGBEzpamJzvcGUcWHAm5X1wpXyz1fAEQWaNyjukh3c6UHQMrTEHwHwGBmQtMNpFtNi4Y
 wHo1CBBBsCGpbV74k1DOFdNWQaB7m7yzyhNsHI7l33lo+3NQYh5u2QiqyTpHFpYvFIjjlMyKghE
 I8jozGcxtmA0Q2EJaXYgxqAj2LgH+72NoB6JzHWPlcJv1s7RD08rofflbKH6iRUE5RDbyy8g0e2
 Sjg==
X-Received: by 2002:a05:690e:1594:10b0:657:b16e:f63c with SMTP id
 956f58d0204a3-65c79941a28mr6760693d50.28.1778155192837; Thu, 07 May 2026
 04:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
 <20260422143112.1329478-5-raymondmaoca@gmail.com>
 <20260429-glare-anybody-16c98d01184e@spud>
 <afKvzj0yoJ85-5VI@pie> <6562F314-D379-42C4-8371-0184E48B8592@gmx.de>
 <20260430143326.GA1614990@bill-the-cat>
In-Reply-To: <20260430143326.GA1614990@bill-the-cat>
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 7 May 2026 19:59:41 +0800
X-Gm-Features: AVHnY4IVB8Ekzin87zIRyrtyA9j0Ou2N_YqHsWS9DiTu1EkeS8Y7Bt6azKhY6kM
Message-ID: <CAH1PCMaUEmuAEK-aiaScV4OAup=kKmN0A09GDGQnjt=so2dg6w@mail.gmail.com>
Subject: Re: [PATCH 04/16] dts: k1: import pinctrl dts file from upstream
 folder
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Yao Zi <me@ziyao.cc>,
 Conor Dooley <conor@kernel.org>, 
 Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de, uboot@riscstar.com,
 u-boot-spacemit@groups.io, raymond.mao@riscstar.com, rick@andestech.com, 
 ycliang@andestech.com, lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, 
 peng.fan@nxp.com, randolph@andestech.com, dlan@gentoo.org, 
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org, quentin.schulz@cherry.de, 
 samuel@sholland.org
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

Hi Tom, Conor, Heinrich, Yao Zi,


On Thu, Apr 30, 2026 at 10:33=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Apr 30, 2026 at 07:21:58AM +0200, Heinrich Schuchardt wrote:
> > Am 30. April 2026 03:26:38 MESZ schrieb Yao Zi <me@ziyao.cc>:
> > >On Wed, Apr 29, 2026 at 08:48:39PM +0100, Conor Dooley wrote:
> > >> On Wed, Apr 22, 2026 at 10:31:00AM -0400, Raymond Mao wrote:
> > >> > From: Raymond Mao <raymond.mao@riscstar.com>
> > >> >
> > >> > Import k1-pinctrl.dtsi from upstream folder.
> > >>
> > >> Why doesn't the platform just use the upstream dts directly?
> > >
> > >AFAIK, U-Boot's reset driver for SpacemiT K1 predates land of the
> > >kernel side driver, and follows a complete different (and to me,
> > >broken since it combines completely unrelated MMIO regions) ABI.
> >
> > Shouldn't we first correct the reset drivers and switch to the upstream=
 kernel device-tree before adding anything new? - This would reduce future =
rework.
>
> Exactly. That's a condition of bringing stuff in to U-Boot before it's
> accepted to the kernel. It *must* be updated once the kernel folks have
> provided feedback, we do not diverge.
>

Chiming in as one of the K1 platform contributors.

Yao Zi is right about the reset driver. U-Boot's spacemit,k1-reset driver
predates the current kernel binding. The kernel K1 reset driver was reworke=
d
to use the auxiliary-device mechanism during upstream review. At that
point the kernel DTS (arch/riscv/boot/dts/spacemit/k1.dtsi) dropped its
reset-controller node. And it is from there, the K1 uboot and kernel dts/dt=
si
files starting to diverge with each other.

To pull them back together, with the goal to reuse the kernel dts,
we plan to:

1. Refactor U-Boot's K1 reset driver to be spawned from each per-syscon
clock driver via device_bind_driver_to_node(), called from the .bind
hook in drivers/clk/spacemit/clk-k1.c. More study is requried but for
now we think this is the correct way. After the refactor, the K1
build should be able to switch dts/upstream/src/riscv/spacemit/, with
a simple U-Boot specifics layered as <board>-u-boot.dtsi overlays.

2. After the refactor, we'll rebase the still in-flight K1 SPL bring-up
work [1] and the PIN/SPI series [2] (this one) on top, dropping
the patches that imported the forked DT, and resend.

Could you confirm this matches your direction? If so, we'll send the
K1 reset driver refactor as a standalone series first.

Link: https://lore.kernel.org/u-boot/20260325223232.1553212-1-raymondmaoca@=
gmail.com/
[1]
[PATCH v3 00/16] Add board support for Spacemit K1 SoC in SPL

Link: https://lore.kernel.org/u-boot/20260422143112.1329478-1-raymondmaoca@=
gmail.com/
[2]
[PATCH 00/16] Add PIN and SPI support for Spacemit K1

Thanks,
Guodong

> --
> Tom
