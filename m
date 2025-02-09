Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B02C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 13:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 062FD807D7;
	Sun,  9 Feb 2025 14:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXoYvct/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0310E807FE; Sun,  9 Feb 2025 14:52:15 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DCC380141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 14:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hackpascal@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f3c119fe6so76572045ad.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 05:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739109131; x=1739713931; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTA5euf+nTJCL0e18HZoHCElg/Ie0nfzJMsGDFDCsJw=;
 b=WXoYvct/nxjzUMG3HbGuMCW/P6g6VSsJx7r+4wDq/kqJVwiP/f+u/BPAx6xwcqZbL/
 rpTTpd2GubXWyL8VPC6jVAXF5Gj3zCo5CLWCGmWqdLf1fNWm5L6F+tHy0wPtkLhNbVrr
 BTQL5RLH1PqDQZeI4WeRADhLkpSpGMJ0XOvLVLa2zvIWDlPsii9vR4PWSNqXSPbv5oCN
 UFliqNSzEdZmVFrrrfhVtVyYE2ZKjbdi++egIUJyDA9qS2L9hlxn2+byOa/mEW7NH217
 RA1Wc1+q42FDhejkXvaYrOk7/7nLLkV2o9lznoQk+KavHZrbAYB+r/K1KV4IplS/duGg
 ZaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739109131; x=1739713931;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTA5euf+nTJCL0e18HZoHCElg/Ie0nfzJMsGDFDCsJw=;
 b=bsr57pXEtdapIbww+xsjJqlE91FRkZhFQwf+pxzSiCNEDEMvdsmFSI6EzbT0FcyJEP
 5FFieFUiY2/PmB7ziR3IMOZGLoPamDw47gF2tj/yW5PUHkyKiyBnchyZhRirxtsMa6/H
 nkhEfqaGpUhJ0ONkbO8aq2LdKhCUa1XniIl2t3WwayXiAug0YCO4gmCHt/ubMVeANGF4
 SRnt7zd24veuc/+UOV/2ehs9D0yn5PKjQvWu+P5VSbbkcas2XMLr6aqjFqC72135TwFW
 xiVWLkaylR6FjT1UATLuG/HvWm4i5EeHVBIlB4MbyhFPxHzs9gI5HDkwo3j+0G/zLQAf
 nM6g==
X-Gm-Message-State: AOJu0YyfFy5ysNJ570+ZuXvMbbTzslFQ5ooQ4g2QrnMNoVbRHsose3XA
 xLKhRqIV6kWUAJVC0/cxp69bkXZXN2PIyBSic79eLr4hWRuUax3PBLZgSHn7lifVOtzxlWY7IqU
 zn7PlB1ssoc5xPmGLBeUN9axv/Zw7DQ==
X-Gm-Gg: ASbGncswkLgSamw1yOZLjYfrwOZBeQVJqOHCBf3ZQN7fGhim/mqeTSmgQgr69ehP/HB
 S/z5hXY3DLATaph+hC/eCSUBU8g4a2+KC1wXLi0udFb3qcUEEtCrO8rQf13rfH1dTjJktze5a+m
 Lx
X-Google-Smtp-Source: AGHT+IHqyhiSAsU42BFmueQJ8TGC/+OteIi0EFXqtDX4qQej14qSdIirAGYoPg3pdCmcrJJHd7FPscZtL4kDpzlgcac=
X-Received: by 2002:a17:903:240f:b0:216:7cde:523 with SMTP id
 d9443c01a7336-21f4e739f99mr179516085ad.32.1739109130766; Sun, 09 Feb 2025
 05:52:10 -0800 (PST)
MIME-Version: 1.0
References: <c2572b2b-c4ce-4deb-a110-1cdc4614c642@ext.kapsi.fi>
 <CAN5eEr1-h-p9mZjqpn+aCduc6A9U1F+8t8biKrODimy3AM-hVg@mail.gmail.com>
 <6e37e18c-b501-4e57-a9ac-23ae659fad3a@ext.kapsi.fi>
 <38cd600e-5dec-428e-bb31-b80459abad1c@ext.kapsi.fi>
In-Reply-To: <38cd600e-5dec-428e-bb31-b80459abad1c@ext.kapsi.fi>
From: Weijie Gao <hackpascal@gmail.com>
Date: Sun, 9 Feb 2025 21:51:59 +0800
X-Gm-Features: AWEUYZlEwFNDyE0TnBBmSKaitwBkG1MbzvqKKXKytXwyscoGyVYRAV_vorKiYm8
Message-ID: <CAN5eEr2aiJzbLMntu1d277VmSfQv7vTg5ZM-2vGHwhwJxZwGrQ@mail.gmail.com>
Subject: Re: Help needed: How to Specify MTD Partitions on NAND in a Device
 Tree
To: Mauri Sandberg <maukka@ext.kapsi.fi>
Cc: u-boot@lists.denx.de
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

I remembered that the raw nand framework does not support dt binding.
It's not a uclass driver.
So the way is to rewrite the driver as a mtd uclass driver.

Best Regards,
Weijie

Mauri Sandberg <maukka@ext.kapsi.fi> =E4=BA=8E2025=E5=B9=B42=E6=9C=888=E6=
=97=A5=E5=91=A8=E5=85=AD 17:04=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 7.2.2025 22.33, Mauri Sandberg wrote:
> > Hi Weijie
> >
> > On 2/7/25 21:53, Weijie Gao wrote:
> >> Here's an example:
> >> https://github.com/openwrt/openwrt/blob/main/package/boot/uboot-
> >> mediatek/patches/105-configs-add-usefull-stuff-to-mt7988-rfb.patch#L31=
6
> >
> > Sorry, I should have been more specific. Actually defining the
> > partitions is the simpler part. But the mt7621.dtsi in U-boot tree does
> > not contain NAND controller node to begin with and I was not successful
> > in defining one. I tried copying/mimicking one from the mt7621.dtsi in
> > OpenWrt tree but that did not work out.
> >
>
> With fresh pair of eyes I found that the 'mt7621_nand.c' in OpenWrt tree
> implements what the U-boot version is lacking and that they are both
> your work. Are there plans for bringing device tree support to U-boot or
> would you be able to review/assist if someone tried it?
>
> Thanks,
> Mauri
