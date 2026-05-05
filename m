Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5D7CD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 11:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E758C848A7;
	Tue,  5 May 2026 13:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OboQwYQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E37B1848A9; Tue,  5 May 2026 13:08:18 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5EE98489F
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 13:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7de44ed7a11so4156926a34.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 04:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777979295; cv=none;
 d=google.com; s=arc-20240605;
 b=dcWU2/cOmjONBtmOsdzwaF7Zq8meO9Y5O8u2DQpEEfcHpPfNcZWrOCWczeDL6HwJoQ
 O/iDgECgzT3YXfVt5OO6M5cpG7K/0NfMDUxGGXd5m8d9gzObYmdCX1VmU1yUzPJC08Hn
 0f7cr7vHI80NAGOyNoB+v5jiklSRT5Xc6/Rrc+g+QwFvl/peKb85hQQMMMrmfc/2jb96
 9MZHmQy9cMdHDJRSPzu7VbbGjZ9yOvNCTpC/Qgb951lPQK9UQLc6+230nFLXJp2qjaRF
 awjJ/6atQ9ZL2NBndK7S9O8cKRXGVE+Ps2foUpho46yezCC1aOwA4QzM1FGX+g8AOBEM
 /+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K2FP2EAa5N94NPbUyAd+zPazSLFu7UKFRSwxU8UWtfQ=;
 fh=VRRZ4HWHUIsvciPRwRCXw9/MssnKVc+iZts14xzsiiE=;
 b=Q/sLGwEtEh07bYVw4WFTAIKCoVgHZjwbUBKI0cUokJFAKxep8FC9ioFe7GcU6kNZwg
 sA5757Z8qCLKR9rF5Ccb5fztCw1YXpNsWUOpZ+1GBb9Lz8lMVEdhEi3LUFrV+OoGBgDW
 V76zTJ+Xfr9RXzy4HUY0vW4kYUJ7i7vr0jHiiQDSsekZw2iA45HEqCODn6aPMTk1Kurx
 yJbANV3e72q6+EoSXdxEhfW+64MXcFkg5En2xD9qs6IcP0TBIU5ILXIwyGVf+gPSvr+Q
 r3nhBtQNa0lN2tntDphvWP1oVTm6Xnt7i3nbmMuLQjFolXEC+fHg/oeThn+sFZGF3qSj
 xcxw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777979295; x=1778584095; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K2FP2EAa5N94NPbUyAd+zPazSLFu7UKFRSwxU8UWtfQ=;
 b=OboQwYQ+XSZ7k6igiEQyryEO++H0cxvdxDH68eW9R1oNb2owsDjme3ei7ViKRRggQh
 DYVKccx42U5fyyudZGdX68FUf0gf6+H9X/5yAwD/Ib1M1ZPvoJe7yZr1tPNrWpNfxiTc
 3pfbrjJKJi2/qzFXFMc5tPQVAYfMfat4YAT0LKB/YNuDtat2AgkB464Gz03C0m3xJGx/
 JIIXdprdnXNS5jBnHkbpS5GUetBsVlm/Z/3LRFvk4Ue7IC3aumgMEJCjoMb4H+NC0xBw
 h34CIFQqaabRyXZ1UZ33jB4xoQyO59ZkuADxnozSJL8MNwlcH4GCX3axZ3HkPkTk4Vhw
 nkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777979295; x=1778584095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K2FP2EAa5N94NPbUyAd+zPazSLFu7UKFRSwxU8UWtfQ=;
 b=TYDi4Ai7YWTBYM/mGbGbi1XHWalmce3Li43C0sRJFY49VAeUn15gXotV1RETe70jdi
 Kk9T07d0DGPqBL7pQ6qEGaO846/qLxfTmnrfBWugbfsrQdxLpZi2nTP3m/O0g/eq+pVl
 vpXKnjElCiHb9N+97Fkad0dK5xWMp2yK8kvJMmzsBm6V7HL1UGKIrsv6hvEVziNORnW1
 kfgMo5Etzh8D486X6X2eNUU76Nlj8NQiCV2dDvhcJEOCyomvEwIVmcsCpgWnREfql+E1
 OttCjHrEilcsOwYtXc7lSJwc+x61O3/MOng/O77biiB7NtKNYs8+ob1qspmkwMz2+kx2
 NVFQ==
X-Gm-Message-State: AOJu0YwJMZ+4vwjSCWJLAknbTcD4Pay5BpHuFQIVq1x1Pc149OMp4mzp
 w1hsYSSUu4J7EVVSnFsFy7IdOB9A9afULhKHr5YE87nxF8yLATFfaEZyGg9OXVOCi/ym0ZioPOo
 Z6+lNNvXkHWbNuP6tJYXYFjejPanbgYQ=
X-Gm-Gg: AeBDies91vCYMWFqDowbTems98OXuwKtKZ3faTO8ewZQqchd/BYlDLZ8gV7L+Ghn7Km
 SzPtgdR3OtJYvbP4zmANUmISO4weSB5zl8jw5QmWYXSLUaVbozwU90DBuZ+MBFYMl42jc/mXeoE
 X23kjQ7HTWagfL5b20i5N9v2GgBriOZy49fq3TRIfXb8qPlnOwqJNecf05p5kI2MblvPr3YP1uS
 J+1teMIC32bFBv+h+/k/E5WbPmzavHuIWep3MrJw2UpvM+VEbaqnNYjEoR9ATRWCchwW+agRWfy
 Bo7bpCpHIulNpYOIRw==
X-Received: by 2002:a05:6830:380b:b0:7dc:e1d9:bdc0 with SMTP id
 46e09a7af769-7dee1431a7cmr7383399a34.22.1777979295370; Tue, 05 May 2026
 04:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-4-alif.zakuan.yuslaimi@altera.com>
 <2880c529-5740-40b4-bb98-aa471f0c628f@altera.com>
In-Reply-To: <2880c529-5740-40b4-bb98-aa471f0c628f@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 5 May 2026 19:08:04 +0800
X-Gm-Features: AVHnY4LQ2hJ2fH8oYK2diExatgi8UIDYiOb1jSUfEp7bX0iIHXD2KQ1XB-PJbJo
Message-ID: <CAN7C2SArQZxDbm3EZ+mnup-EniyQ79-1Cv7n_19AxPpFr=SnGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: alif.zakuan.yuslaimi@altera.com, 
 "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Tue, May 5, 2026 at 2:54=E2=80=AFPM Chee, Tien Fong
<tien.fong.chee@altera.com> wrote:
>
> Hi Alif,
>
>
> On 28/4/2026 11:32 am, alif.zakuan.yuslaimi@altera.com wrote:
> > From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >
> > The SDRAM must first be rewritten by zeroes if ECC is used to initializ=
e
> > the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
> > case.
> >

...

> Why not remove this?
>

Hi Alif,

Just few comments:

- If possible make it inline, extra file means extra time to compile etc.
- To reduce the code size which I tested a bit, the text message is the eas=
iest.
  So possible reuse or cleanup text print if needed.
- use "./scripts/checkpatch.pl" under the u-boot folder to clean things up.

Thanks,
Brian
