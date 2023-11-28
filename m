Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB3BC07E98
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 09:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9110787579;
	Tue, 28 Nov 2023 10:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v7ZmoxeO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 494188769A; Tue, 28 Nov 2023 10:35:15 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 316728753B
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 10:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9fcfd2a069aso717709766b.1
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 01:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701164112; x=1701768912; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N3xnHrT4vg6d6SbP3/Lb6UUkw7GnG2oM8QBkJ8QdHZs=;
 b=v7ZmoxeOXLpwaT6uB5I6pV9MXdTMg0rNt4w5v0hvRxPWb2taCYweklD+/1D62l0/Vl
 Ig19q+y8TVrgx2/H340nVXa2jOIY34KlQ/buCG/kt6KFFA6IqxrpY81fizWByfx90MAa
 HemrGuUfSYdN0xzJHOeX7JcIdVF8AiGugLe5Ihg05p69aCAwVUa35dLjFsZ2gUtEgvw8
 42hSVaEyy1X+1i55+Ta9I5bjuwyltO7hp5qDJT1PuGYgHdsTsJDsVugRzPI1Rbj1dgVr
 lUhHztBF/qqngnlEU6b7/eyavSrrg4o9Fiz04aNzqxrsVALcS29HOsPulFRcvMrgICQP
 hTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701164112; x=1701768912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N3xnHrT4vg6d6SbP3/Lb6UUkw7GnG2oM8QBkJ8QdHZs=;
 b=Us2HMpKvKr/jj6cRQROTwg9siPOEZnXQTEt0QafRRXLEroCfN9+ytUZh6hw1gpqccp
 TKqC+azDEI0Bjz8Og5oY/Tz+TuYmUCHcEzSGqG2NAchJMJwd6SXu9iRu9VKYgBETDJr9
 12Ps9TkfkQ37iJ4UuNWY8T4RfFY6mpj6dDXHjtVHsw/qcsSbGuspPmSPoszqZPT7dLfT
 EjIHvcebgbRDWN0E9hg+2b/oILvlfMn4faIQ+L6CjlOEpLnETDk6/BbmS0HCfpVv8iDU
 rGbrzBnuN5yCyZAl2sLX9cS8GF3WusmAxL3BiSaK/xZGSwQTflUyYypVbrmJ0wBqdMKB
 tCHg==
X-Gm-Message-State: AOJu0YxIaJ2Pt19vptHVSOMQjgmmcxXFLIVkv9oo1tg+tmXg83vm9ZsN
 F09/IocYu84OCqoCWppaUbkwmDuBzyXBE9cYS+IZLg==
X-Google-Smtp-Source: AGHT+IH5aaWOdRihjb+7z93oNBw4RX8KYPmHNKo+prRfVQhtMCyl4QmY4VlOtWDn9fG0/csO9f/YQMl1gNINCadp1yU=
X-Received: by 2002:a17:906:3f88:b0:9ff:1dea:83b6 with SMTP id
 b8-20020a1709063f8800b009ff1dea83b6mr9783771ejj.4.1701164112632; Tue, 28 Nov
 2023 01:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-34-maxim.uvarov@linaro.org>
 <20231127130828.GC2513409@bill-the-cat>
 <CAD8XO3buruEtFvVv32J-LW+Jj=+vFJk2Q+TgBKL130sL2qY0DQ@mail.gmail.com>
 <20231127140813.GF2513409@bill-the-cat>
 <CAD8XO3b-BijLJz0fbsLA-DdAzW_Yj0Z+JOWZtFUFr-3KgKesQA@mail.gmail.com>
 <CALeDE9MMCPNtj9yaXdPwbppOsmUSvmuNWdicNLvqZmY2c=h9dw@mail.gmail.com>
 <20231127163156.GJ2513409@bill-the-cat>
In-Reply-To: <20231127163156.GJ2513409@bill-the-cat>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Tue, 28 Nov 2023 15:35:00 +0600
Message-ID: <CAD8XO3YyzGz3MFPoBu1SZyC1rA7u2y_vB8Y9XCry5bTvwdjoiw@mail.gmail.com>
Subject: Re: [PATHv11 33/43] configs/am335x_evm_defconfig: inc SPL size
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, goldsimon@gmx.de
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

On Mon, 27 Nov 2023 at 22:31, Tom Rini <trini@konsulko.com> wrote:

> On Mon, Nov 27, 2023 at 03:52:50PM +0000, Peter Robinson wrote:
> > On Mon, Nov 27, 2023 at 3:32=E2=80=AFPM Maxim Uvarov <maxim.uvarov@lina=
ro.org>
> wrote:
> > >
> > >
> > >
> > > On Mon, 27 Nov 2023 at 20:08, Tom Rini <trini@konsulko.com> wrote:
> > >>
> > >> On Mon, Nov 27, 2023 at 08:06:23PM +0600, Maxim Uvarov wrote:
> > >> > On Mon, 27 Nov 2023 at 19:08, Tom Rini <trini@konsulko.com> wrote:
> > >> >
> > >> > > On Mon, Nov 27, 2023 at 06:57:16PM +0600, Maxim Uvarov wrote:
> > >> > >
> > >> > > > Increase allowed binary size to fit lwip code.
> > >> > > >
> > >> > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > >> > > > ---
> > >> > > >  configs/am335x_evm_defconfig | 1 +
> > >> > > >  1 file changed, 1 insertion(+)
> > >> > > >
> > >> > > > diff --git a/configs/am335x_evm_defconfig
> b/configs/am335x_evm_defconfig
> > >> > > > index f048e60f7f..9fd608bd76 100644
> > >> > > > --- a/configs/am335x_evm_defconfig
> > >> > > > +++ b/configs/am335x_evm_defconfig
> > >> > > > @@ -124,3 +124,4 @@ CONFIG_WDT=3Dy
> > >> > > >  CONFIG_DYNAMIC_CRC_TABLE=3Dy
> > >> > > >  CONFIG_RSA=3Dy
> > >> > > >  CONFIG_LZO=3Dy
> > >> > > > +CONFIG_SPL_MAX_SIZE=3D0x29000
> > >> > >
> > >> > > As probably a problem for other platforms you made this change o=
n
> too,
> > >> > > you can't do this. The link limit is here because that's the
> limit the
> > >> > > hardware (and ROM) imposes.
> > >> > >
> > >> > > You might need to either:
> > >> > > - Figure out how to make lwip even tinier for the SPL case
> > >> > > - Limit the old network stack to just for SPL, and a later task
> is to
> > >> > >   reduce what's in the old stack to just what's also needed
> within SPL.
> > >> > >
> > >> > >
> > >> > Thanks Tom. All these size changes need to be reviewed.  Some of
> them are
> > >> > ok, I think like for x86 or qemu virt, but some of them might not
> work.
> > >> >
> > >> > Question - Do we need networking inside SPL rather than in the mai=
n
> binary?
> > >> > Is it a real use case?
> > >>
> > >> Yes, the device supports loading SPL, and then SPL loading U-Boot bo=
th
> > >> over USB RNDIS as well as regular physical ethernet.
> > >>
> > >> --
> > >> Tom
> > >
> > >
> > > That looks like not a production use case. USB + NET + drivers + EXT4
> + NAND + MTD and everything else and trying to fit into SPL.
> > > With enabling LTO I still need 4k (without dropping current code).
> From one point it's too synthetic use case here and might be a historical
> > > limitation which we will not see on future boards. From the other
> point it will be good to not break it somehow....
> >
> > Does this still include the old network code?
> >
> > Also I wonder if we can have a paired down SPL_LWIP option that
> > removes things like PXE and HTTP/wget because none of those would be
> > used in the SPL use case as they're all brand new.
>
> To be clear, I am fine with either "old network stack only for SPL" or
> "figure out how to pair down lwip to just SPL features". In fact having
> said that, the first thing I would suggest is to turn off LTO as it
> makes reading the linker map file harder, increase the size limit for
> this platform, and take a look at what's being linked in and not
> discarded in SPL, for networking, in spl/u-boot-spl.map. Maybe the
> answer is that we just need to be more careful about using
> IS_ENABLED/CONFIG_IS_ENABLED (and obj-$(CONFIG_$(SPL_)FOO)) in the lwip
> series.
>
> --
> Tom
>

Yea. If I disable TCP then we get the right size for this board. So for SPL
I think to build without TCP so that ping, dhcp and tftp will still work.
For normal binary TCP will be enabled. For other boards with limits I think
also to disable TCP for now.

BR,
Maxim.
