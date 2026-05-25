Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A13CD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC03F8465D;
	Mon, 25 May 2026 04:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bens.haus header.i=@bens.haus header.b="DO04Y4yz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E38383EF9; Mon, 25 May 2026 03:21:56 +0200 (CEST)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89418039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ben@bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
 s=protonmail; t=1779672113; x=1779931313;
 bh=4N/IGKYGB4uRNBmollVrjursj/1YDDSgeb1zngI+ji0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=DO04Y4yzUCKbY/L5uKsGC5WXAFo1XE6B85BBBPba+2mO8LD8iXlkHapBBCc6oxKZl
 /8kFG2c5D/r/Q1KjShYki/MdkS6UXBn9b+pg0CyP5Y6Mbo3KUQMcBAfHzDURg+g2AM
 dnLU4zvVQvFCbMzfHdE+CgM7Bhz3pNX+zQ79/QGUyhWvdsTvnbTWPNC8Gs6Mqpb//m
 /GlH48TCY34llNCTUAdLAjRYA4IMXC9sKj6VJg/Gim4PPheCvvZCRXcV5ynVQa9jzj
 zCdGehLoQ0IeWSUHixvjLt4LYCYaxbNIhFSh2SmFoSKkEXk7bJAlfbD9RI++zS/Ht9
 /oEIHhU3UCJ5g==
Date: Mon, 25 May 2026 01:21:48 +0000
To: Stefan Roese <stefan.roese@mailbox.org>
From: Ben Schneider <ben@bens.haus>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: v2026.04 crashing on Marvell Armada 3720
Message-ID: <aU0JJd40MuUFOULadJri1Poqfq4wrvGMF7zrdOEucjI-loO3N7kZDYa32JIaXoDBcusnMxLPEuRcBTPvSkfnSf3p_0Pn0oZPXHTTZXSn48M=@bens.haus>
In-Reply-To: <CAJaLiFzGYZ89B7LD7z6Mese0iH3-KqM8TFbn5Vkx11Zjr-7MrQ@mail.gmail.com>
References: <IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus>
 <9b0f2989-5c78-4e74-a691-b873b9bb2649@cherry.de>
 <ZJ8GNZXD-fYDaXZ4MCGrxvVAtJfaDjWWHRt6LlXWpQJpg3evBb4F-T9KO5yGvmFM3j643wz9PQa4ROK62TL6kKSnBW65XJmBep6yuxh2qUo=@bens.haus>
 <CAJaLiFzyOUV1r0gUAFpgGcQUGzmz_zneiC=AVbAnxKDcOMCvqg@mail.gmail.com>
 <so1abs7pAg9MrPZOVyW7dGcSFp2m4Tf47UW6T_QYYtgqkQ8DqrHNCfPLytOKux86LMpRM9t3fcv_I1uIYIOkdKGFkH5OZ8cEpueoLEK7iwU=@bens.haus>
 <CAJaLiFzGYZ89B7LD7z6Mese0iH3-KqM8TFbn5Vkx11Zjr-7MrQ@mail.gmail.com>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: 486740f53ce8559d45aa0c060e7f6ed284d69c59
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 25 May 2026 04:30:57 +0200
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

Hi Stefan,

On Monday, May 11th, 2026 at 12:45 PM, Tony Dinh <mibodhi@gmail.com> wrote:

> Added Stefan (MVEBU SoC maintainer).
>
> > The first commit to cause problems is actually 217cf65 dm:
core: Default to using DEVRES outside of xPL.

After a lot of testing, I think I've traced the issue to drivers/pinctrl/mv=
ebu/pinctrl-armada-37xx.c. There are two calls
to devm_kzalloc that, when I change to kzalloc and remove the dev
argument, my device boots again.

--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -523,8 +523,7 @@ static int armada_37xx_fill_func(struct armada_37xx_pin=
ctrl *info)
 =09=09const char **groups;
 =09=09int g;

-=09=09funcs[n].groups =3D devm_kzalloc(info->dev, funcs[n].ngroups *
-=09=09=09=09=09       sizeof(*(funcs[n].groups)),
+=09=09funcs[n].groups =3D kzalloc(funcs[n].ngroups * sizeof(*(funcs[n].gro=
ups)),
 =09=09=09=09=09       GFP_KERNEL);
 =09=09if (!funcs[n].groups)
 =09=09=09return -ENOMEM;
@@ -724,7 +723,7 @@ static int armada_37xx_pinctrl_probe(struct udevice *de=
v)
 =09 * we allocate functions for number of pins and hope there are
 =09 * fewer unique functions than pins available
 =09 */
-=09info->funcs =3D devm_kzalloc(info->dev, pin_data->nr_pins *
+=09info->funcs =3D kzalloc(pin_data->nr_pins *
 =09=09=09   sizeof(struct armada_37xx_pmx_func), GFP_KERNEL);
 =09if (!info->funcs)
 =09=09return -ENOMEM;

I cannot explain why these changes resolve the issue so I'd
appreciate if someone more knowledgeable would review.
I'm also happy to test other proposed solutions. Thank you!

Ben
