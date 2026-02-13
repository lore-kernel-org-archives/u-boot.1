Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028B1EF48EE
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 09:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5318B83015;
	Fri, 13 Feb 2026 10:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lOWNYfOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B1683AAB; Fri, 13 Feb 2026 10:00:19 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AAB180FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 10:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4b9c839b1so297493a34.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 01:00:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770973216; cv=none;
 d=google.com; s=arc-20240605;
 b=jlLC1WHdh1R5kgTzKIsdi8zQ6m9blwqhD2po0vAOYEFOYKq6+WAAItUyFd22XgRlAT
 RP7VTog59jGhostPQo18i/WKwwm1DQmZ8BPRFcwUtjYnjSHEnrrUbuy8HgANrO8ADyCZ
 ltOUa/YhbNHI1Ie3nblpt0jZu+PpoKNQz6Y7yDLOiiJh09b8MOZvbbhUubf6XFJMMtwx
 wZlbv/MOeKVbiPuCVoYcZtYmP7dLK9a1ZsMBZ+SjpJl/x/lolEBVIIu7C/SpxGFRDX9T
 Kz9lpIxwdmGccNWgTHqKvYwfAcY2Yf9KFn01PDDhVUTQG+6UT6vCMfGwUUuuTBOHWh1Y
 3HaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xgtppdqImphClyyUU1f1mV8R/mYvFcTngJx17y/MXDg=;
 fh=eEi8Xo/lKegsBCPHHmDPcf4jaXl0OXhlbgpBC2bs1Eg=;
 b=S8s+tWfh/EOTQnXV2qbAWTlGErnOVezzl33LMz777m/PLNuRqaK6AgdjaoPYWoRh8v
 kXZ+LbD+7QecM9UdWVPsrImi+913Gnfhb5DFXznj/yRCLJTog8evWEXVBkd0OxwxCOKG
 +1NCWbt26RAdm3pcFRQVmwLvpAJyzsn1OVk4i/L2mA/i55Yf7mqhdtMn3J/fj4Wdc8et
 k+yD2NwWhemM+kPuRdV7IrEO87PDXx7kV7TWATELAP6vQzrZf/y68hFs/MBlOXsXAJnE
 6qgx2yATnq/EyHUpt3U8I9i0d/iLbzEZkPfAFAr6NuBf6+GGziUlgusDm8Sep1XC30SH
 3UnQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770973216; x=1771578016; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgtppdqImphClyyUU1f1mV8R/mYvFcTngJx17y/MXDg=;
 b=lOWNYfOF/dlSJo5mHFxuEOYPWUt36Kvqcz6UGCO8fTRnMbOoTJ19PFMVDsd2ByJJ1a
 r9M2PIwmOY2npfFY8gShYnoDqoQVKWykDoNLqCyJje/0sPoS9xS0GDMEAAStmR+ZDXyw
 +yST0Gub2UtWyFtVfRZ+y9XnjnZdSBpOWfZsrUEeVoV5GcXnCFVLTq2b7kwGjdRoQ46q
 H6SY+Ls8mNQ2B7Z296xvwSz4E7YVt9h4/GZcHG4z6jJp1a/+3ulwqyJZzTn7da2f5rAy
 4n8SUbBRywKTRqLllU8BRlXEslH5MpOK8Iukt3SsNUjfxt54GWhGTk372/0XkOI2UiVu
 9/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770973216; x=1771578016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xgtppdqImphClyyUU1f1mV8R/mYvFcTngJx17y/MXDg=;
 b=F0mpSp++jIokJZC0OF7Be0EnhtLGXqlQUS0N13bfzneAXTGga6o52j3RkH1QglqXdh
 osyQjyBob98y+EmuOUxxLZ22G5Rjcwv4etnLn1tSiRCwlD7Y2Mxy5I6+opkBGq6sOMd4
 sU2/lWFYwyyDAyOlt3Fe/Wli24I5Dg00kJ2pegsv52GKjZiKyE537QDebM8anhWDXiRb
 WNfuO2LJZ0T/DqP4+obpb77hJ0cLQid5nUTY6LFCpfXZg3ty8xVvmxCZ0PLqzRI+H7Y3
 V5lTtwDD1bFD0LDGH4b5U6XeQnEf0rpOXWcjTsflGk6isVqjxcAjjlsM4VyurJXWamjc
 TcsA==
X-Gm-Message-State: AOJu0Yywc3MgOeFmpXVjet45Pu2uFUN2blJ+xFidQgdLw1CYugOVt4gJ
 0Trda1XPZsnl0ULN4kxzt3GZNlU4OS0LsuBJnrs4DoLthT9DYOyrflX6MMYrbByOh1DcpVepakN
 vQb4ZeiWXVVxdTtdcWgpkryLIyPUDyW9VowzOysbrHg==
X-Gm-Gg: AZuq6aJVg7kGWfNSKA629h7bKaezipSjgAUbbd8L43VAEaDXMtjUsyp87YbZZOW1RQK
 RPj3UnyRHQ/R1+EZQLqHzooqD1WvuPzuoCFWG+iZ1R1NF+JowxFxr24FqluQfzF2O9kPhnYSVCv
 RP7K8RNnstUYlRuTsiT8cz2xdAgMlWoJI4sPfMJeRP/hlWGcmBI53nuDJFdka7TtYuUi0LHczB5
 ZncTzAgM5kZlM5NQSnlgHFbv1qiC9B1QSXIbUI6La6l6XXaDvGPcoqocQ3jRYq/9rE97pBFX4uC
 wt3FmxSd
X-Received: by 2002:a05:6830:2aa7:b0:7c7:8280:9207 with SMTP id
 46e09a7af769-7d4c4b495fdmr634375a34.37.1770973215696; Fri, 13 Feb 2026
 01:00:15 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SC4GTf004JyBeeVtnBPo=BvqorCy87ZFTNV4RkWFOJKbA@mail.gmail.com>
 <b25f6c14-7db2-4517-a3ab-e2c55a52818c@altera.com>
 <CAN7C2SCC9L30S2BNYUzRE1jRJeQ2H1d6fq_Hgsu7uPge_QgsYw@mail.gmail.com>
In-Reply-To: <CAN7C2SCC9L30S2BNYUzRE1jRJeQ2H1d6fq_Hgsu7uPge_QgsYw@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 13 Feb 2026 17:00:05 +0800
X-Gm-Features: AZwV_QgNRvfnbMwN2PF82JkE30D8ixQdHQqo151VFl-pnkMOjyfFN1mpcRWvEn4
Message-ID: <CAN7C2SAOLdokAaVcuMPWMTS4HsY-4d2dhnkwLadqsGS2qAsKaw@mail.gmail.com>
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

On Fri, Feb 13, 2026 at 4:44=E2=80=AFPM Sune Brian <briansune@gmail.com> wr=
ote:
>
> On Fri, Feb 13, 2026 at 3:18=E2=80=AFPM Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com> wrote:
> >
> > Hi Brian,
> >
> > On 6/2/2026 11:09 pm, Sune Brian wrote:
> > > [CAUTION: This email is from outside your organization. Unless you tr=
ust the sender, do not click on links or open attachments as it may be a fr=
audulent email attempting to steal your information and/or compromise your =
computer.]
> > >
> > > Hi Alif,
> > >
> > > Since 2025.05 to the latest master.
> > > I do not have any issue as you mentioned in this patch.
> > > Both RD/WR are used on the FPGA2SDRAM SDRAM2FPGA.
> > > I tested 256 AXI3 or split 128 AXI3 x2 which is the maximum
> > > that GEN5 Cyclone can support.
> > >
> > > Not too sure what is missing from first place?
> > >
> > > Thanks,
> > > Brian
> >
> > Based on the CycloneV address map which can be found here -
> > https://www.intel.com/content/www/us/en/programmable/hps/cyclone-v/hps.=
html#sfo1411577374877.html.
> >
> > Bit 3 of staticcfg register has to be set to apply all the settings
> > loaded in SDR registers to the memory interface, in this case the patch
> > ensures the SDRAM controller applies the latest configuration after
> > disabling FPGA SDRAM access.
> >
> > This is a safety and correctness fix for re-initializing the memory
> > controller in the proper sequence during FPGA reconfiguration.
> >
>
> Hi Alif,
>
> Before I plan to undergo a test we got to understand why w/o this patch
> SDRAM2FPGA works properly w/o issue.
>
> > If you have the time, can you help to test this patch with your setup?
> > Although unlikely, we want to be sure that this patch will not break an=
y
> > existing GEN5 boards out there.
>
> I might be wrong, I think static cfg has been done already?
> Does the code here if not wrongly understood already finished that static=
 cfg?
>
> ---> Quote start
> void socfpga_sdram_apply_static_cfg(void)
> {
> const u32 applymask =3D 0x8;
> u32 val =3D readl(&sdr_ctrl->static_cfg) | applymask;
>
> /*
> * SDRAM staticcfg register specific:
> * When applying the register setting, the CPU must not access
> * SDRAM. Luckily for us, we can use i-cache here to help us
> * circumvent the SDRAM access issue. The idea is to make sure
> * that the code is in one full i-cache line by branching past
> * it and back. Once it is in the i-cache, we execute the core
> * of the code and apply the register settings.
> *
> * The code below uses 7 instructions, while the Cortex-A9 has
> * 32-byte cachelines, thus the limit is 8 instructions total.
> */
> asm volatile(".align 5 \n"
>      " b 2f \n"
>      "1: str %0, [%1] \n"
>      " dsb \n"
>      " isb \n"
>      " b 3f \n"
>      "2: b 1b \n"
>      "3: nop \n"
>     : : "r"(val), "r"(&sdr_ctrl->static_cfg) : "memory", "cc");
> }
> Quote end<---
>

I forgot to quote the func call location:

void do_bridge_reset(int enable, unsigned int mask)

During boot users are supposed to use bridge enable to
control the needs of the HPS <-> SDRAM or H2F F2H LW etc.
When calls if I am not wrongly understand it will reset and
simply do that static cfg and simply do not require additional
calls.


> Thanks,
> Brian
>
> >
> > Thanks,
> > Alif
> >
> >
> >
