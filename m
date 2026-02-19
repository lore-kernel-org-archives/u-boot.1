Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF57DE9A03B
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 02:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B04C783AC5;
	Thu, 19 Feb 2026 03:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BDXzisTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14CE983C19; Thu, 19 Feb 2026 03:21:43 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABC483A47
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 03:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4c9537f90so379432a34.0
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 18:21:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771467698; cv=none;
 d=google.com; s=arc-20240605;
 b=QQopppKJV9I5kIi/j4MbYRWxKyV4HopE8VMljimvW78A/vG6hloxymHF5qWfuzVzov
 UU171y9a/RmRMrePkY18+JJJxAgtYYVYMQSsMlToGGx/OcvAegaAucF8W6nU6CbjKPTP
 oG43Xz3bpJlDf/pWV/kMsYjC11FYJVxkbEnZPOApmo9El7ouBYLOwbelCNEx0rpdHbzc
 prXh6GF7EeAs/qnV4OhFdpbEv3opdINciBo6qX/b8VvQacfwabr5TjpLie4ptopvbWNQ
 1Qt/X3amhkI48V46txl72TorLYJU3TzDw4P/IXgNJI/O5WUi4RLVUT7avYZDnxN46MHF
 /Y9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xTMmeQboSNeiJwPwfUB4Z2QRGqso1dLq822+0g3BCos=;
 fh=eEi8Xo/lKegsBCPHHmDPcf4jaXl0OXhlbgpBC2bs1Eg=;
 b=Q2CHUlc4+zwnbr4a48cao0Zb6uxNB2uG1Ggg+ts1Ax+oGQLqc4wHnCQVXnhFITLID+
 FbD6RsmFDd2D5+evIPcrwWZ0PIGG3uouf8NkDicIDD6mM2f449uPWvXuqVJ7Q7gUoP67
 yDI0NXc0BKo6fzDaGaHMybCcY73QaH9tZvPXMrCYvgNan0wUhFaeJE/wSYSniXQOTi8r
 0Gko+E2ou/yPpaejKwnYardr5Dag3oQ7v3k5Z6JNn0rWlENG4/9hb1pTiugTwUE2oe+N
 djR5jPeYQ9vOcH3s1SF7Mu+HWOmMWyLD8i2xEK47bOvLQPpE1O+qIkMXlXJzHC1eQTsq
 G8Dg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771467698; x=1772072498; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTMmeQboSNeiJwPwfUB4Z2QRGqso1dLq822+0g3BCos=;
 b=BDXzisTYo41FfdY9r7gQLIjnVdVDBpZE849qUMW97AwiYYMx1ubG0FkI9jxsNPQJl0
 RVZpa8ss+x5ypuHg+ZKnUOvWlfnWdHvXfQ9Y2oQItJ6kZ+UmX+qHxNhBOKhCNPv0FrUC
 jEO42Gb6fxq3LGXOkxJMkkP0pI5YV2JL/CEMIVsI+PIHs06V0OvJBmDn4NNXDgkaM45q
 9MhGhGvXCsQno4n++s2Kb5aRka9NO6RBlgYs4DMgwHbJse+NrQXfPRrMbo0lMdTYC9iX
 GxIbUfAC0oUXO5MLFh6ySdrQSyIeWumdfAXLqhKiltRABidI/5Yr48MCM/v0sd/ug51V
 v26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771467698; x=1772072498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xTMmeQboSNeiJwPwfUB4Z2QRGqso1dLq822+0g3BCos=;
 b=lnENT4MohmjivJliZfWpww1GvenvFX1P1oTNlza/t0id6yNMFp9fFMJ2P2A/9PKR1N
 RKwp8eTfjqHGjJo6TXuQcpvl/SYaBvugVn1KgvPPxR+BDGTtbe431OCMu0v8d6Q27AGB
 1o63wlnXhEr/GJW0cDJhFZdYq9s4GaLy5kbiaeW3VN+NCIZcLMEq9QJlqLV2YQrRZGNs
 UXl+9WaNj5NOBXj2X5ysF22TJbMlpmMzG+KdSjwFKjqzDRZ2JUVaEMySyeayhxglyuZ+
 9DSj9rSKw4G2Sc13UpMrT2M/j4f5juwuzdECdenG7/X9uVZp7wzEqWlwtcHpg0aMgy6P
 j3Xw==
X-Gm-Message-State: AOJu0YznWnSPVbUSO/pDv1Kujk+USlAxs3pMOqQY3Jg9ZzVo+2m5RkdP
 o5ZqsXoWRcsjzYYeTc+1jKfl5nuLOqP1h/vQWYlWQQ1XWqvMQNAyclu0WmsEf6hF24xuSzB+AAd
 DAz7QBy1MzuA9XTR5bYPiE74Z2eH07PEq1c2j5CE=
X-Gm-Gg: AZuq6aL1/+QFOGAhMcvQSilrtkziDvQucKcQlGsOYPExe9o0TPomdIjwSfc8Ab8pniN
 nuJpZMITl+doN2/MjTllsPEyWsEw69jeNZzZSvz5IijfZHjWVHaBL6ePVyntDLTbPMJJjPsFWg2
 BWdc0bwAcgY7QcvbfYbt5xSZmp+2KjOaz8AEVeBr2lYDJal8qqElb1Hfw0QUIQbzrn6qrcL7hn6
 6tLKHSdhXhA/RpbxldXbhLBvaGF7plMtBSmo/JYog1869736knAGUvvBme+KSfi3UTLCfB6N+PX
 xQy2feht
X-Received: by 2002:a05:6830:922:b0:7cf:cbee:6bd5 with SMTP id
 46e09a7af769-7d505e16fb6mr1773560a34.19.1771467698221; Wed, 18 Feb 2026
 18:21:38 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SC4GTf004JyBeeVtnBPo=BvqorCy87ZFTNV4RkWFOJKbA@mail.gmail.com>
 <b25f6c14-7db2-4517-a3ab-e2c55a52818c@altera.com>
 <CAN7C2SCC9L30S2BNYUzRE1jRJeQ2H1d6fq_Hgsu7uPge_QgsYw@mail.gmail.com>
 <CAN7C2SAOLdokAaVcuMPWMTS4HsY-4d2dhnkwLadqsGS2qAsKaw@mail.gmail.com>
 <4b6327d1-681d-46a4-b672-6d53fbfa1e89@altera.com>
In-Reply-To: <4b6327d1-681d-46a4-b672-6d53fbfa1e89@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 19 Feb 2026 10:21:26 +0800
X-Gm-Features: AaiRm51kj-2N-g8gQQ0iK4YWDQp9q4x9ZD4zOOrZ6YxzFkCODLpgykdeGnxEk8c
Message-ID: <CAN7C2SCbyuBz4d8QmqGUNFBGjhGaSFyZD-J3GcYy9r3DGNSjvA@mail.gmail.com>
Subject: Re: [PATCH v1] arm: socfpga: Add call to
 socfpga_sdram_apply_static_cfg()
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
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

On Thu, Feb 19, 2026 at 8:18=E2=80=AFAM Yuslaimi, Alif Zakuan
<alif.zakuan.yuslaimi@altera.com> wrote:
>
>
>
> On 13/2/2026 5:00 pm, Sune Brian wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > On Fri, Feb 13, 2026 at 4:44=E2=80=AFPM Sune Brian <briansune@gmail.com=
> wrote:
> >>
> >> On Fri, Feb 13, 2026 at 3:18=E2=80=AFPM Yuslaimi, Alif Zakuan
> >> <alif.zakuan.yuslaimi@altera.com> wrote:
> >>>
> >>> Hi Brian,
> >>>
> >>> On 6/2/2026 11:09 pm, Sune Brian wrote:
> >>>> [CAUTION: This email is from outside your organization. Unless you t=
rust the sender, do not click on links or open attachments as it may be a f=
raudulent email attempting to steal your information and/or compromise your=
 computer.]
> >>>>
> >>>> Hi Alif,
> >>>>
> >>>> Since 2025.05 to the latest master.
> >>>> I do not have any issue as you mentioned in this patch.
> >>>> Both RD/WR are used on the FPGA2SDRAM SDRAM2FPGA.
> >>>> I tested 256 AXI3 or split 128 AXI3 x2 which is the maximum
> >>>> that GEN5 Cyclone can support.
> >>>>
> >>>> Not too sure what is missing from first place?
> >>>>
> >>>> Thanks,
> >>>> Brian
> >>>
> >>> Based on the CycloneV address map which can be found here -
> >>> https://www.intel.com/content/www/us/en/programmable/hps/cyclone-v/hp=
s.html#sfo1411577374877.html.
> >>>
> >>> Bit 3 of staticcfg register has to be set to apply all the settings
> >>> loaded in SDR registers to the memory interface, in this case the pat=
ch
> >>> ensures the SDRAM controller applies the latest configuration after
> >>> disabling FPGA SDRAM access.
> >>>
> >>> This is a safety and correctness fix for re-initializing the memory
> >>> controller in the proper sequence during FPGA reconfiguration.
> >>>
> >>
> >> Hi Alif,
> >>
> >> Before I plan to undergo a test we got to understand why w/o this patc=
h
> >> SDRAM2FPGA works properly w/o issue.
> >>
> >>> If you have the time, can you help to test this patch with your setup=
?
> >>> Although unlikely, we want to be sure that this patch will not break =
any
> >>> existing GEN5 boards out there.
> >>
> >> I might be wrong, I think static cfg has been done already?
> >> Does the code here if not wrongly understood already finished that sta=
tic cfg?
> >>
> >> ---> Quote start
> >> void socfpga_sdram_apply_static_cfg(void)
> >> {
> >> const u32 applymask =3D 0x8;
> >> u32 val =3D readl(&sdr_ctrl->static_cfg) | applymask;
> >>
> >> /*
> >> * SDRAM staticcfg register specific:
> >> * When applying the register setting, the CPU must not access
> >> * SDRAM. Luckily for us, we can use i-cache here to help us
> >> * circumvent the SDRAM access issue. The idea is to make sure
> >> * that the code is in one full i-cache line by branching past
> >> * it and back. Once it is in the i-cache, we execute the core
> >> * of the code and apply the register settings.
> >> *
> >> * The code below uses 7 instructions, while the Cortex-A9 has
> >> * 32-byte cachelines, thus the limit is 8 instructions total.
> >> */
> >> asm volatile(".align 5 \n"
> >>       " b 2f \n"
> >>       "1: str %0, [%1] \n"
> >>       " dsb \n"
> >>       " isb \n"
> >>       " b 3f \n"
> >>       "2: b 1b \n"
> >>       "3: nop \n"
> >>      : : "r"(val), "r"(&sdr_ctrl->static_cfg) : "memory", "cc");
> >> }
> >> Quote end<---
> >>
> >
> > I forgot to quote the func call location:
> >
> > void do_bridge_reset(int enable, unsigned int mask)
> >
> > During boot users are supposed to use bridge enable to
> > control the needs of the HPS <-> SDRAM or H2F F2H LW etc.
> > When calls if I am not wrongly understand it will reset and
> > simply do that static cfg and simply do not require additional
> > calls.
> >
> Thanks for pointing this out, Brian.
>

Hi Alif,

Pic by pic.

> I understand that you saw potential redundancy in this patch's explicit
> re-application of the SDRAM static configuration, which may already be
> handled by the existing call to socfpga_sdram_apply_static_cfg() during
> bridge reset.

This is following the old boot flow to the latest and not having issues
under boot.scr with "bridge enable" and sub-bit bridge setup.

>
> I would imagine your current flow works as the current code already
> applies SDRAM configuration changes at the correct time during boot or
> bridge reset. However, there are some cases or sequences where this
> apply step could be missed - such as during partial reconfiguration.

Not too understand this case even if you PR the bridge enable MUST
be done after the reconfiguration phase aka "bridge enable".
And PR itself has nothing to do with turning on F2H SDRAM the first time.
One is the FPGA manager and the other is the HPS register unless it auto
reset all bridge registers.
I can also reload full bit during boot again and again and boot to linux w/=
o
f2h issue.

>
> This patch would then be needed as an extra safeguard in cases where SDR
> registers are updated manually or outside the typical bridge reset sequen=
ce.

If the user doesn't use f2h then turning on this bit for what purpose?
As "bridge
enable" under boot.scr have good control.

Brian

> >
> >> Thanks,
> >> Brian
> >>
> >>>
> >>> Thanks,
> >>> Alif
> >>>
> >>>
> >>>
>
