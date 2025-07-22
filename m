Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AEDC83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 19:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 073C3833D7;
	Tue, 22 Jul 2025 21:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H6zI08L2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92DFF833EC; Tue, 22 Jul 2025 21:22:12 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6044A82C84
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 21:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-712be7e034cso58205397b3.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753212128; x=1753816928; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cgy0+KWGMiN+eTrUVIYwYqF/StE/9rlbmtHn5m9xB+M=;
 b=H6zI08L2a9nBcZcypjGd3PrcpqI+XCDWoJAK5lDqTddz6A1D6VlaEsrYYIJgDD9N8O
 LsrfiE55Q6XW+g7fTYDLHV7m17gMJRK9NbvvSOYMJ0kxeHmH1Mo82f40KzgY+0Nj1KRv
 2hS6GX95qzb7DMMfK22QNSgcZAUAhNc9vWDUB/rlBS8IjWf5tY/OzyDVAPfJzWxTar8d
 ea63Edgll2pc9wE6cILFzHc3i05XziCkDPU7Zhjuq5GqsiU1EmeqtTyvSdkVuBok3pCk
 LBahZEZi5VQXC6+D3LX9puiX9CZ4jk5iU2zDC59SlAEUnHkJR/ymgGL8SV3Of0EGfGmz
 or/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753212128; x=1753816928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cgy0+KWGMiN+eTrUVIYwYqF/StE/9rlbmtHn5m9xB+M=;
 b=sPltCVnC6quCJXcgao/+hJZuZllMWZQmIbqbT78iBdAk+5P9ie/TY5+afBEGhlJ6ev
 Zo8xqY+i7v1Kz8aRTTeDMWS2Y0gdleVfqPWFVHPbRk48Z8wq4dvO1se6SBVdFSI1J75q
 17yW66dkDP6kLmT8lXBFhEBTfBuBZi+jfGrlSc/xIbmbXI7zXk0N+K1rw0y4p23RFvNi
 PnfE4Gp1j0Q7MpdIG0j/FELQRSR6a35cKYHVUcx2ALZMBN8V9zlS/5HLjz88SPL3HLjZ
 LC+8sBo5rWmLrs0tjsCGhu418kpHw4w+R362Pec7EeDSuB5s+EY82oe8AhIBEReoGhSJ
 K3AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrnZyqHi+6gPr1tKsbPNPCxkCVttX2O3LCwZkkfg9HWVRsx+XCPOwA5GxvWbLtyYnrm1eFejA=@lists.denx.de
X-Gm-Message-State: AOJu0YyY4zFRFqfmG4D+yN5f1RscUM31+p+1P36Tb9pfJqY1COSYygqw
 gh/1uHCfM3iiWZOGu75UQontA6WgW1qas7LlDpTpXNvF2z7QkbvgWqYUFJ26yYDUD2ylFcy+aSq
 wE/HjKxRQXiHdhZXDEqujYA6+lUPL4J7OJQhLnZBZhA==
X-Gm-Gg: ASbGnctBVQeBj1/iBA0yYVxDJlXK0/Vfgav74lEinh7wCd8DE//nwQ/PbkzAmrTlnvl
 q6m781kxGQVXLcRL1Z4aXvbjnPLV4Gh4Mg7j525qziQhdDE/Q214mBebV4y9biiSFEAaYSLUO2E
 YDEqrQHqCGLCl90A00p08+SmAb4J5MhkaNrsvRgEg/o83bdbBy0C9YVcO0sMabu/C9tnVsFNS3N
 ORz23ol10btgKt/SQ==
X-Google-Smtp-Source: AGHT+IGCQ+rVfuMnoUVfEZhVSM4ByqjEgjz81nKdCXjh+pnn1wYH/+QKQG0SuQWrwDOyk/5EB6LvzwG9XftEJHGDYVQ=
X-Received: by 2002:a05:690c:6089:b0:70e:2c7f:2ed4 with SMTP id
 00721157ae682-719b3f517a7mr6331217b3.0.1753212127987; Tue, 22 Jul 2025
 12:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
 <20250709222926.24671-2-semen.protsenko@linaro.org>
 <87tt3b2ti7.fsf@kernel.org>
 <CAPLW+4moDYL0Q9TjSuWbqOuLQV2KCCrrzR_02-YUhivWuvQ=SA@mail.gmail.com>
 <87ikjllws2.fsf@kernel.org>
 <CAPLW+4ncXuT7=iP4wt6fuZ25cQvLJUTZe71oC6=y04Wefb5c6w@mail.gmail.com>
 <CALrBrZ2gGjk9sqqvAESs=tC4HV65Cg5Bp0qJ_ggsjd2ix1xUOQ@mail.gmail.com>
In-Reply-To: <CALrBrZ2gGjk9sqqvAESs=tC4HV65Cg5Bp0qJ_ggsjd2ix1xUOQ@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 22 Jul 2025 14:21:56 -0500
X-Gm-Features: Ac12FXym6ezl8gzvBm1BPOXBqY8YoIvNqRMOdBJT2u5sEhxQKH9RUzyhks2bC_o
Message-ID: <CAPLW+4=gdMZqoP3zZn0Dk6p5GY4N0pCDnKsXcqtLK41P-Qqu3w@mail.gmail.com>
Subject: Re: [PATCH 1/9] phy: samsung: Add Exynos USB DRD PHY driver
To: Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marex@denx.de>, Minkyu Kang <mk7.kang@samsung.com>,
 Simon Glass <sjg@chromium.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
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

On Tue, Jul 22, 2025 at 2:42=E2=80=AFAM Minkyu Kang <promsoft@gmail.com> wr=
ote:
>
> Hi,
>
>
> 2025=EB=85=84 7=EC=9B=94 22=EC=9D=BC (=ED=99=94) 13:30, Sam Protsenko <se=
men.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>>
>> On Mon, Jul 21, 2025 at 4:26=E2=80=AFAM Mattijs Korpershoek
>> <mkorpershoek@kernel.org> wrote:
>> >
>> > On Sun, Jul 20, 2025 at 14:57, Sam Protsenko <semen.protsenko@linaro.o=
rg> wrote:
>> >
>> > > On Thu, Jul 17, 2025 at 1:58=E2=80=AFAM Mattijs Korpershoek
>> > > <mkorpershoek@kernel.org> wrote:
>> > >>
>> > >> Hi Sam,
>> > >>
>> > >> Thank you for the patch.
>> > >>
>> > >
>> > > [snip]
>> > >
>> > >> > +
>> > >> > +#define EXYNOS850_DRD_UTMI                   0x50
>> > >> > +#define UTMI_FORCE_SLEEP                     BIT(0)
>> > >> > +#define UTMI_FORCE_SUSPEND                   BIT(1)
>> > >> > +#define UTMI_DM_PULLDOWN                     BIT(2)
>> > >> > +#define UTMI_DP_PULLDOWN                     BIT(3)
>> > >> > +#define UTMI_FORCE_BVALID                    BIT(4)
>> > >> > +#define UTMI_FORCE_VBUSVALID                 BIT(5)
>> > >>
>> > >> Comparing with the linux driver using
>> > >> commit cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD 3.=
2 4nm controller")
>> > >>
>> > >> I notice that the defines are in reverse order (from 0 to 5 and lin=
ux
>> > >> has from 5 to 0).
>> > >>
>> > >> Is there any particular reason for this?
>> > >> I don't mind it too much but it makes diffing between linux and U-B=
oot a
>> > >> bit harder.
>> > >>
>> > >> Anyway, I've compared this with the linux driver and it looks good =
to
>> > >> me!
>> > >>
>> > >> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> > >>
>> > >
>> > > Thank for reviewing this, Mattijs! Yeah, I kinda flipped the registe=
r
>> > > bits w.r.t. kernel's version, just because it looks better to me thi=
s
>> > > way (easier to read when it's sorted properly). Due to the driver
>> > > model API differences between kernel and U-Boot I had to rework the
>> > > whole structure of the driver, and I only added Exynos850 support fo=
r
>> > > now, so the difference between U-Boot and kernel versions is quite b=
ig
>> > > as it is anyway, so I figured it's not a big deal to reorder things
>> > > even more. Hope it's ok with you?
>> >
>> > It's ok with me. I was just curious if there was any special reason fo=
r
>> > re-ordering. I agree that it's easier to read with the sorting you hav=
e
>> > applied.
>> > I've noticed that only Exynos850 is supported for now. That's fine as
>> > well in my opinion!
>> >
>> > Feel free to pick this up through your tree.
>>
>> I don't have a maintainer tree unfortunately. The easiest way for this
>> series would be probably to go through Samsung tree (Minkyu)?
>
>
> Yep. This patch is delegating to me.
> But unfortunately I have trouble to access to denx git on my office.

Hi Minkyu,

FYI: it might not be on your side. I can't access denx gitlab right
now as well. There is some relevant discussion going on on #u-boot
IRC. See also [1] thread.

[1] https://lists.denx.de/pipermail/u-boot/2025-July/594671.html


> I'm trying to fix it but not sure when it can be.
> So I'll ask to Tom to pick this up at this time.
>
> Dear Tom,
>
> Could you pick this up?
>
> Reviewed-by: Minkyu Kang <mk7.kang@samsung.com>
>
>
> Thanks,
> Minkyu Kang.
