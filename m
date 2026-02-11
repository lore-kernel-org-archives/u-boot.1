Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2512DEA3F27
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 10:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6197C83015;
	Wed, 11 Feb 2026 11:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CESILNQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8D1E831AC; Wed, 11 Feb 2026 11:25:14 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F82782BF2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 11:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7962119ff2bso52386087b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 02:25:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770805510; cv=none;
 d=google.com; s=arc-20240605;
 b=ErI1sdVhComIWxg850FrwzNa18ZY1RvsG+a3YUtFRnxg9RYvJ8r8lDSbKfak/H+yFj
 b6GkIhNhp3SbBLEKSa5UAMtvIco3u2IS4QYNGK+epECY2L8T774CmGX1eJB0mzBLG5qu
 z08Gu5weJIolJOdigyFbRmzPeQCgMsntJHOJ6xAiNiaAuwgWq43bA362N/B+mysrgvI7
 b1BsbDgCZDV5aWAPm+T9cwPSJZ6OQDtG3PPlyy1wHUVYe+PDQVp5RhHjU/fUP7GS3mrn
 G1RxKvro8tMcUngtoiEBuiMZYEvfQ0ubosHu+aZ+pNFm3hXtB5dfup6j8NzL2pBWaiYu
 1jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7Fr4cZarAHEfnAUayN5jeaQzkLb7E3Af7C7+MazlwYU=;
 fh=ArSbZPvkfVWYzCHb7yKlrEpUpMHO0KZROdk059Bk9Hw=;
 b=TQWh6qLgSUB45K/m6K967Kjv61gPeBmhgg40MmBxm/Sx2bHit1dlJL1g9PE8hMDDHF
 UZQAP2HC7+9fTeTI4/JcaEOjipWEN1vRVeYkh9crEMDIIXqgmQ6c118PeUDuOLDPF6LZ
 iiUQ2Bf2c27/Is6CDh8glry2OtQ6uy5m5T/aOGvDHQxLV5VjomRrQXT7AubioMFW52Ek
 lBAFHSyJXsMfzC77EbhR6yDtu/aRC6DpMB1M1moE0LfsRfwOW8L/iwtGKHiO4A5VhI5o
 wZgfccxpMfvOWQ2tRUeyaMvEHtuR9VQGqiG2g7885BJBDVxTj4S6GFK7E7CzWBjWrsov
 r/eQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770805510; x=1771410310; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Fr4cZarAHEfnAUayN5jeaQzkLb7E3Af7C7+MazlwYU=;
 b=CESILNQ/Azo9+0wN+HCxAyICIroiHNOHHk0jazinWM6O7mPLKk14Nse3xhnuXbR+Zp
 YxEAIdmLcpyxjeCWPJVkPh03CqA9V/F75HRXgZ/6o2MleCfU7i59bjF/NWcj02Ep+Dax
 wZM0JxMHGQT8C4Ar3s14EtmEpRQpaXqYC7Fs8TQ6WAS3Lmi51pbi83k91Hz8NenzvWxZ
 5svv6biP99C5AbTgu1DuxCDj2Op+u3PE+NZn66PQLxIIMKZu9NAm0ZjUAmjIirLWknrX
 MI4XmKOWLtCN5GiTcY17CUeDUlYLdUmkBnfECI+/8euvsvFxsarMyDNZX4gcCxzdek7t
 4f5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770805510; x=1771410310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Fr4cZarAHEfnAUayN5jeaQzkLb7E3Af7C7+MazlwYU=;
 b=kXdkeK/XzSOPnZvT8jGl5cfnAmi4BzDWVRZsVN9323NyHTZ0aonHyi30F/3TWmn8Ih
 n9IYccrsKNPe6S8VRW+3ECcMUk6lJQqfmvOXJ+5lz4m4EPrIdnsM3Qo1rSqUCyE2JKIQ
 XaTrxMPhy1UpHfoXcD1vKtI2redm0S3qrw8J5IdlMLv1wQCojWu4nUjGB/G+zzPps5p4
 1D1Z/Vf+rwrkOF/lRVzAmphVW/112VS2KmNgZUSteTerjvg3HoyoleJIUQ3pDpXDsdTP
 3hTv5mxGgv3Z3Y8Nhcg4ry0BDr7SRg5QJQThD1Y+mA+S3QYHZ1qNGhkbinTFIIswMSlU
 wB+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwY1TOP3IBC8vpwaIls3AK2dxp4bCzHZoMKr32rdqvlqqGRpTM3nHsSNTXssngDcpSiy3gHSs=@lists.denx.de
X-Gm-Message-State: AOJu0YybOMHy0LVLy43h7f4FLwmeZf2Z42Mb85BnwNj7UfrSEeq/hgqa
 liKhp9Zi9o7iTBG+/+MBI6b9YbXI156/amQSi5GIxham2xzJg8TXcG/3wy0PCDfOnsvWNibWGTD
 +xNgT7xLMF7GyS+mOC+Q9s/oAKUnSTqMFAtdN5+8XrQ==
X-Gm-Gg: AZuq6aIRO2+Xd+2kVwyTk0SMM0E0EzUOCrqlB0eL6IcIELQnrsu2aTqNbLWGZ/Rlf6V
 uJO/Q2cWhrxjo4wPba5O8J38H1C9M06WccFQ9l3l2wcyyr0e1V7P+TQ0YqnV6a8F9GG5Fw4Jp1x
 Ln5S4dwmLb6jURRecLBOXg1sbyl27kHayKwcMidSHy8ip0imBC4eW7u/CYhdewGsl8FSsO2tKXj
 mIowIQ35DER33YsNse+QgUROzY9KMNWYy2wVKj1IB11T9Y8SMn1N3qnj7TNZ2tlwnd2heZuvhyF
 /BZfDrmyCj8Y9CT0ewPwWD+W308EQHG5slTtS82AmyzsJBR5RX3Ux9svng84rsT4hhL+PzKoejZ
 df7YlTZU3UOAjuGKVplLLJWjzfJAijKMLI6xOcZ8nkZBaQq9K/mrbXgpvByG5lTyxretUaXklSZ
 ZKiMqsW84h7zM0MIDKl7u7MpyGrLQ6x8BEog9Nw6skwj1kS/gF5o0rKvZpQ7tbtaN2SbOd1nEqh
 cQQXxIrzDePFZFksUYF5qFQyqhTtPgQwPnOu4q2lkG70pvIpaZ6Z5LJNxoAJXtXWXBO/7IUYxmw
 tNoHlNV9iouIOU+Tqbw2MkAbcyq8oJMZ4czAzr7WEhJO
X-Received: by 2002:a05:690c:a91:b0:78c:5b3b:d234 with SMTP id
 00721157ae682-7966aafddf4mr17270627b3.50.1770805509816; Wed, 11 Feb 2026
 02:25:09 -0800 (PST)
MIME-Version: 1.0
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
 <CAFLszTjgsSj47P6u2JohHv3vV1=sOWQxQ7qS3RDuBYBQsejKWA@mail.gmail.com>
 <CANqXHyEShK3bCA-5K4K=zH_b19i9+o9DRPYW8LHo-gFpMB2Hkg@mail.gmail.com>
 <CANqXHyH3OwPEpo=rv6E+uSP01quOQisEJ3_aD2-r=DkNDK4_+g@mail.gmail.com>
 <CAC_iWjLKotX4X9mD1qnJbnkbh9xBHfnyF+b=b--XvMjjbCrU-g@mail.gmail.com>
 <CANqXHyGZSGybzchkqSE0-7s3HgfY=UBjpkjS1wjuRkZzOLDMWQ@mail.gmail.com>
 <430A021B-7511-4C08-B30C-72C153A25A27@wolfssl.com>
 <CALeDE9M7ENPccTD18b3YKrvYEu8yU0cXT1ePXM_tagV4Ou+Z0w@mail.gmail.com>
In-Reply-To: <CALeDE9M7ENPccTD18b3YKrvYEu8yU0cXT1ePXM_tagV4Ou+Z0w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 12:24:33 +0200
X-Gm-Features: AZwV_QiZsScZ6gCeBX-Yv8BNk9kgyuVO8Io_wqtbKNG6djGKAq4Vd4H-uTj_AvI
Message-ID: <CAC_iWjKnbp_gtHQ6nMZEHEOx92NA2U1OLFKkgDtyqS_aDHO6GQ@mail.gmail.com>
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
To: Peter Robinson <pbrobinson@gmail.com>
Cc: David Garske <david@wolfssl.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, 
 Todd Ouska <todd@wolfssl.com>, Larry Stefonic <larry@wolfssl.com>, 
 Wolfram Kusterer <wolfram@wolfssl.com>, Aidan Garske <aidan@wolfssl.com>
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

Hi,

Thanks for the followup. As Peter suggested, please submit it as a patch.
Github might be fine for the development, but we do have an email
based review system. Maintainers are already overloaded, so it's
easier for us to follow the guidelines

Thanks
/Ilias

On Wed, 28 Jan 2026 at 06:26, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi David,
>
> > We have made the U-Boot changes requested and attached a patch for upst=
ream. Let me know if you have any issues or questions.
>
> Please send the patch using 'git send-emaiil' or a similar tool.
>
> Regards,
> Peter
>
> > Fork: https://github.com/aidangarske/u-boot/tree/rpi4-wolftpm-uboot
> > Instructions: https://github.com/aidangarske/rpi4-wolftpm-uboot/tree/ma=
ster
> >
> > =EF=BF=BC
> >
> > Thanks,
> > David Garske
> > Software Engineer, wolfSSL
> > +1 (530) 409-2990
> > https://www.wolfssl.com <https://www.wolfssl.com/>
> > https://github.com/wolfssl
> >
> > > On Aug 5, 2025, at 8:31=E2=80=AFAM, Aidan Garske <aidan@wolfssl.com> =
wrote:
> > >
> > > Hi Ilias,
> > >
> > > Sounds good, I will keep them in cmd/wolftpm.c. I guess Simon can pro=
bably answer the other question the best.
> > > He had asked if I could "put the driver code into drivers/ with just =
the command code in cmd/" so I am just trying
> > > to get clarity on what driver code he is specifically referring to.
> > >
> > > Thanks for the help,
> > > Aidan
> > > -------------------------------------
> > > Aidan Garske
> > > Engineering Intern, wolfSSL
> > > +1 (916) 337-1246
> > > -------------------------------------
> > >
> > >
> > > On Tue, Aug 5, 2025 at 1:17=E2=80=AFAM Ilias Apalodimas <ilias.apalod=
imas@linaro.org <mailto:ilias.apalodimas@linaro.org>> wrote:
> > >> Hi Aidan,
> > >>
> > >>
> > >> On Sat, 2 Aug 2025 at 01:59, Aidan Garske <aidan@wolfssl.com <mailto=
:aidan@wolfssl.com>> wrote:
> > >> >
> > >> > Hi Simon and Ilias,
> > >> >
> > >> > Thank you for the great feedback. Currently I am working in the re=
factor you suggested and I wanted to ask a question about some of your comm=
ents.
> > >> >
> > >> > 1. What exactly is the "driver code" you are referring to in this =
case?
> > >> > 2. Do you want me to separate out our helper functions into a `cmd=
/wolftpm-common.c` or should I keep them in `cmd/wolftpm.c`?
> > >> >
> > >> > Looking forward to your response,
> > >> > Aidan
> > >> > -------------------------------------
> > >> > Aidan Garske
> > >> > Engineering Intern, wolfSSL
> > >> > +1 (916) 337-1246
> > >> > -------------------------------------
> > >> >
> > >> >
> > >> > On Wed, Jul 30, 2025 at 8:40=E2=80=AFAM Aidan Garske <aidan@wolfss=
l.com <mailto:aidan@wolfssl.com>> wrote:
> > >> >>
> > >> >> Hi Simon,
> > >> >>
> > >> >> Thank you for the great feedback. Currently I am working in the r=
efactor you suggested and I wanted to ask a question about some of your com=
ments.
> > >> >>
> > >> >> 1. What exactly is the "driver code" you are referring to in this=
 case?
> > >>
> > >> It's been a while and I am not sure I am following on that
> > >>
> > >> >> 2. Do you want me to separate out our helper functions into a `cm=
d/wolftpm-common.c` or should I keep them in `cmd/wolftpm.c`?
> > >>
> > >> Are you expecting it to be reusable by something else? If not just
> > >> keep it to cmd/wolftpm.c
> > >>
> > >> Thanks
> > >> /Ilias
> > >>
> > >> >>
> > >> >> Looking forward to your response,
> > >> >> Aidan
> > >> >> -------------------------------------
> > >> >> Aidan Garske
> > >> >> Engineering Intern, wolfSSL
> > >> >> +1 (916) 337-1246
> > >> >> -------------------------------------
> > >> >>
> > >> >>
> > >> >>
> > >> >> On Sat, May 10, 2025 at 4:25=E2=80=AFAM Simon Glass <sjg@chromium=
.org <mailto:sjg@chromium.org>> wrote:
> > >> >>>
> > >> >>> Hi David,
> > >> >>>
> > >> >>> On Thu, 8 May 2025 at 00:41, David Garske <david@wolfssl.com <ma=
ilto:david@wolfssl.com>> wrote:
> > >> >>> >
> > >> >>> > Hi Denx,
> > >> >>> >
> > >> >>> > We at wolfSSL have developed a port for wolfTPM in U-Boot. The=
 patch allows using the current built-in TPM 2.0 support or switching to wo=
lfTPM via CONFIG_TPM_WOLF=3Dy. It also supports TPM 2.0 firmware update for=
 the Infineon SLB9672 and SLB9673.
> > >> >>> >
> > >> >>> > I think there is probably some more cleanup and testing needed=
, but I wanted to submit this to start the discussion and see your thoughts=
.
> > >> >>> >
> > >> >>> > The wolfTPM library is GPLv2 and added as a submodule. If the =
license or submodule is an issue let=E2=80=99s discuss! I=E2=80=99m positiv=
e we can resolve anything.
> > >> >>> >
> > >> >>> > Attached is the patch based on latest master 3b6760ddeb4 to re=
view.
> > >> >>>
> > >> >>> Thank you for doing this!
> > >> >>>
> > >> >>> Here are a few thoughts:
> > >> >>>
> > >> >>> - Use lower case for function names
> > >> >>> - Avoid camel case
> > >> >>> - What is XMEMSET()? - Can you use memset() ?
> > >> >>> - Convert most prinf() functions to log_debug()
> > >> >>> - Can you use subcommands (from command.h) instead of parsing th=
e
> > >> >>> subcommand yourself?
> > >> >>> - put the FIRMWARE_UPGRADE thing into Kconfig, as well as WOLFTP=
M_SLB9672/3
> > >> >>> - put the driver code into drivers/ with just the command code i=
n cmd/
> > >> >>> - add config WOLFTPM, separate from CMD_WOLFTPM
> > >> >>> - can you add a test in test/ and docs in doc/usage/cmd/  ?
> > >> >>>
> > >> >>> Regards,
> > >> >>> Simon
> > >> >>>
> > >> >>>
> > >> >>> >
> > >> >>> > =EF=BF=BC
> > >> >>> >
> > >> >>> > Thanks,
> > >> >>> > David Garske
> > >> >>> > Software Engineer, wolfSSL
> > >> >>> > +1 (530) 409-2990
> > >> >>> > https://www.wolfssl.com <https://www.wolfssl.com/> <https://ww=
w.wolfssl.com/>
> > >> >>> > https://github.com/wolfssl
> > >> >>> >
> >
