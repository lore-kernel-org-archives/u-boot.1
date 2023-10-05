Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0053EE936ED
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 01:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0058B87619;
	Thu,  5 Oct 2023 03:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="DYXYHJ8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 732BE8760A; Thu,  5 Oct 2023 03:24:09 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 512BA875E7
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 03:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9a645e54806so81800666b.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 18:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696469046; x=1697073846; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MLBBhbdyRhy4V/790cVIezRTkFD4g4lv32R7Z9KSBxE=;
 b=DYXYHJ8L8moJAWgt/lTH66prkc/283xhzwraxLq1lNqko0kK03HHigaShPZECWr7BS
 S9KCbt7C5o03CQ/E+SUWdsTlbhw1Ca8jcm6YHAB3dX5cI07CGAqUChODhz8djOvTBGo4
 qy2VMMFsa+rEHu4u3bCg100m5IOd7muWQU5Sm2VQPy1XpqoFHoLAmEHIiYSJ1p/L8zui
 B4bGG/CyOChnoUCAu/ir7pKUX+LPzXSjYAEGgLvAjZTTSIh7YpKK9eVSIuSVPaurGYXU
 vD6X6BnwAoSrZgq4NLI2CTs/L+zBNlbKxf1IODMtOVE2CMFvPNe7C3MjWAQ+76u0HMKt
 bMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696469046; x=1697073846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MLBBhbdyRhy4V/790cVIezRTkFD4g4lv32R7Z9KSBxE=;
 b=pn0gMa8FQKC8jIiHuyNSTr98SHsyvxVoSv4YdN6lOoso34CC7uohnqKuYKkc1s/ABP
 p6AJKZtGcC6amUv72sRX8v69Nd1Sez7aJOEcWUfCx6eZzI1KgMYRDLg2F9tEk6MPpjvM
 eV6W2nsx0G2cavYaVQKtGHJw466ogyLvsXTtVzIOs/tl68QLTBC7db8v8FAPQIbQVE4k
 gw1oRywXfbKiYoGh6y4faviYC3FCftdIK1d7sGAfFlsBMQuZ582TqpUjrNYkoBFzM1qm
 QpwiINa7qRoHHNcoVKe5b65khH2AKjjtpBOTWnSstekCR+CKGLVdKQZsfOSxZF+yh+XG
 J/bw==
X-Gm-Message-State: AOJu0YwpfNMh/JVGrmtU9JXT7F86LiER6lm016jewLCmDZqX9qrcQzb9
 v4qDFZR7MMscQnsLxj/2JXcyLqw2x5Fbw5YX+8bioQe9IO/x1qsC2/o=
X-Google-Smtp-Source: AGHT+IGQf5j3FIpyUYpx6VHe2tjgFpzidFFaUcp8Qsnd0kgodbOWZUy5bKcDxkjZECGNAiAnUXB7I4g9wE8BzaC4STM=
X-Received: by 2002:a17:907:1dc2:b0:9a6:2a0:6391 with SMTP id
 og2-20020a1709071dc200b009a602a06391mr3163818ejc.14.1696469046274; Wed, 04
 Oct 2023 18:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230929230655.2932698-1-jonas@kwiboo.se>
 <CAPnjgZ2O7kxiRt9j3forPPjm=R5EgmLdZKVrwVbyR156YhNDpw@mail.gmail.com>
 <550d1f16-b788-d2b5-c2d9-fe5d199e63e1@kwiboo.se>
In-Reply-To: <550d1f16-b788-d2b5-c2d9-fe5d199e63e1@kwiboo.se>
From: Simon Glass <sjg@google.com>
Date: Wed, 4 Oct 2023 19:23:55 -0600
Message-ID: <CAPnjgZ3chkLnvExeJMs534X5A_g+nRp2zsxmNLh-vWd34DXnyw@mail.gmail.com>
Subject: Re: [RFC] mmc: Remove alignment hole for cmdidx in struct mmc_cmd
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Ferass El Hafidi <vitali64pmemail@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jonas,

On Mon, 2 Oct 2023 at 13:29, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> On 2023-10-02 20:56, Simon Glass wrote:
> > On Fri, 29 Sept 2023 at 17:07, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> The alignment hole caused by cmdidx in struct mmc_cmd cause strange
> >> issues together with the peephole2 optimization on Amlogic SoCs.
> >> Following was observed while working on SPL support for Amlogic SoCs.
> >>
> >> sd_get_capabilities() normally issue a CMD55 followed by a CMD51.
> >> However, on at least Amlogic S905 (Cortex-A53) and S905X3 (Cortex-A55),
> >> CMD55 was instead followed by CMD8 (and a few reties) in SPL.
> >>
> >> Code from the call site:
> >>
> >>   cmd.cmdidx = SD_CMD_APP_SEND_SCR; // 51
> >>   ...
> >>   data.blocksize = 8;
> >>   ...
> >>   err = mmc_send_cmd_retry(mmc, &cmd, &data, 3);
> >>
> >> Running the code with MMC_TRACE enabled shows:
> >>
> >> CMD_SEND:55
> >>                 ARG                      0x50480000
> >>                 MMC_RSP_R1,5,6,7         0x00000920
> >> CMD_SEND:8
> >>                 ARG                      0x00000000
> >>                 RET                      -110
> >>
> >> Removing the alignment hole by changing cmdidx from ushort to uint or
> >> building with -fno-peephole2 flag seem to resolve this issue.
> >>
> >> CMD_SEND:55
> >>                 ARG                      0x50480000
> >>                 MMC_RSP_R1,5,6,7         0x00000920
> >> CMD_SEND:51
> >>                 ARG                      0x00000000
> >>                 MMC_RSP_R1,5,6,7         0x00000920
> >>
> >> Same issue was observed building U-Boot with gcc 8-13. Please advise on
> >> how to best work around this possible gcc optimization bug.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> ---
> >>  arch/arm/cpu/armv8/config.mk | 2 ++
> >>  include/mmc.h                | 2 +-
> >>  2 files changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
> >> index 4d74b2a533e0..7177dcd7c73b 100644
> >> --- a/arch/arm/cpu/armv8/config.mk
> >> +++ b/arch/arm/cpu/armv8/config.mk
> >> @@ -7,6 +7,8 @@ PLATFORM_RELFLAGS += $(call cc-option,-mbranch-protection=none)
> >>  PF_NO_UNALIGNED := $(call cc-option, -mstrict-align)
> >>  PLATFORM_CPPFLAGS += $(PF_NO_UNALIGNED)
> >>
> >> +PLATFORM_CPPFLAGS += $(call cc-option,-fno-peephole2)
> >
> > Eek really?
>
> As mentioned the issue could be resolved with changing cmdidx from
> ushort to uint or disabling the peephole2 optimization.
>
> For the purpose of trying to get more feedback on the issue I included
> both changes that would resolve my issue.
>
> Also if there is one struct affected, there could be other similar
> structs affected by a similar issue.
>
> I do not really know if this could be a cpu errata, compiler bug or
> something else, including some assembly from a non-working and working
> case (peephole2 optimization enabled/disabled).
>
> Code generated with ushort and peephole2 enabled (not working):
>
>   60 06 80 52     mov        w0,#0x33           // 51
>   f5 3f 06 91     add        x21,sp,#0x18f
>   e0 23 01 79     strh       w0,[sp, #cmd]
>   e0 03 00 b2     mov        x0,#0x100000001
>   b5 e6 7a 92     and        x21,x21,#-0x40
>   f5 03 06 a9     stp        x21,x0,[sp, #data]
>   00 01 80 52     mov        w0,#0x8
>   e2 83 01 91     add        x2,sp,#0x60
>   e1 43 02 91     add        x1,sp,#0x90
>   63 00 80 52     mov        w3,#0x3
>   e0 73 00 b9     str        w0,[sp, #blocksize]
>   e0 03 13 aa     mov        x0,x19
>   f6 ff 12 29     stp        w22,wzr,[sp, #resp_type]
>   50 fd ff 97     bl         mmc_send_cmd_retry
>
> Code generated with ushort and peephole2 disabled (working):
>
>   60 06 80 52     mov        w0,#0x33           // 51
>   e0 23 01 79     strh       w0,[sp, #cmd]
>   e0 03 00 b2     mov        x0,#0x100000001
>   f5 3f 06 91     add        x21,sp,#0x18f
>   e0 37 00 f9     str        x0,[sp, #local_168]
>   00 01 80 52     mov        w0,#0x8
>   b5 e6 7a 92     and        x21,x21,#-0x40
>   e2 83 01 91     add        x2,sp,#0x60
>   e1 43 02 91     add        x1,sp,#0x90
>   63 00 80 52     mov        w3,#0x3
>   f5 33 00 f9     str        x21,[sp, #data]
>   e0 73 00 b9     str        w0,[sp, #blocksize]
>   e0 03 13 aa     mov        x0,x19
>   f6 97 00 b9     str        w22,[sp, #resp_type]
>   ff 9b 00 b9     str        wzr,[sp, #cmdarg]
>   4a fd ff 97     bl         mmc_send_cmd_retry
>
> Hoping someone can see something strange I cannot.

I used to be able to see what compilers were doing, but sometime over
the past 10 years they got a lot smarter and I didn't.

I don't see anything wrong with the C code. The setting of
cmd.resp_type to the same value could perhaps be fooling the compiler?

Regards,
Simon
