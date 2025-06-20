Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7966EC7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 21:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9DFB82CBC;
	Fri, 20 Jun 2025 23:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PIBMl6xa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A7C682CF8; Fri, 20 Jun 2025 23:22:14 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C3682BA1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 23:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-60768f080d8so3909066a12.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750454531; x=1751059331; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYDEmFT2KjV/t2p2+9hw/ZUYqo3I1jgbq1dZ2yQXIVA=;
 b=PIBMl6xa6rlUg1snd6idM2zYijLo3IHmIG99g4K4rsJR6lebPJ3tVff+M59kEGnKSn
 AtF+HpRCxqJqyhfsVuwQh+LgJ5NYdXTVoYQAxnoSAGENRnusobQ5SkeC8Ypb6Wo+trt5
 KKxSTPxLNyDpy+XgPh4Cpw/Kee6uNOLvP5CduDtjrNCfvwIPPnQ/r33TJMcqYuO7Nv5R
 +55saxRlj/3iAr7i+Wv7kC4Hhn57c5gsbT39wlAocAK1sf6kChJeUxEkQdTtfHRtBeLV
 vmej2xq6hX5D9h0V2QzWD9x4TcdjnmavDtBsbZiDb5qrN3J2Wi/hvKI+t6WDCEZzs2eY
 bMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750454531; x=1751059331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYDEmFT2KjV/t2p2+9hw/ZUYqo3I1jgbq1dZ2yQXIVA=;
 b=DddrbUwuaVgiv+iT4mGR1eforhb4J8oGSPDT/u/cOunQpiJ55jyYe26e1sDkc6ZMga
 pAGqwjkTa28vDi6E4ryoy/FC6vH6P6nDtEBcUHW+tduz1JkYsFJnCvFosdk3lmTwZFXQ
 OKEmtek+4xb+OMLW+jpx/0pHynBUecK7Hv3d/b5inC1VNa+4h6XNbKXl90fVGWMpn0BE
 fbSjeKe+68M+jVDxLkEHdtScgY9w/SgtlfBHXVQBkT1+o3nluRsdepp0xgoMF63Up0Ql
 PD6d2o65g86BJT1LzKjS7SeioPDkWne/+OVXe1r5rY/jkbCEtPBzA/JSPbSPl5An9VYE
 Ce8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAI9um5lY4uX2eODbP3hfU3escO9F9enE3/19EyC9k3OzFt+x6rkUKHb95CJ/LS0BqHzHSMs0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6XOAnMwLbFeqHXVLYceLHIUKP170ZMdi/m0A02viGjlJ+kzXf
 QBhVHmpXFvPudCqYo9d3Y4sOPnchA0w/WqbxwfjeC5aYsP1MR1jNubbC5O+QND6JX06OlUTL29l
 FlvReD9H2CDuE/ghIfEUGXNKpOBTVDG4=
X-Gm-Gg: ASbGncs6cVgwUJ0oVh/RH5pWviOGaw0ckhSMnexzuFeJxLSCX1yaSyyFCFWDvBGZ5r6
 pofCxibsQCGxSRuCtWiHOhPPTmanX/JcJrnq1Thk6UvX7lFYPRTtWWzHb/5BmyqnCB+fXaWJ7v7
 skoq0Aha1R3gNDS1eOjV0hzu4KSsfVbcmvMIguCuNagJzN
X-Google-Smtp-Source: AGHT+IE+7T2FgTf8WmOsok/xD+na30FteQDft+ftcMDtQ1o2Z8P4pZipu55jLgi+Z8129m/fb0n4uw0CuCJM/KcB6qQ=
X-Received: by 2002:a05:6402:278c:b0:608:1670:efe6 with SMTP id
 4fb4d7f45d1cf-60a1cd1efbbmr3989111a12.22.1750454531069; Fri, 20 Jun 2025
 14:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFwpdskG-eQjFKQseB3ResK=6Lt_RNRbXZTEFq7FYYSuAg@mail.gmail.com>
 <47e2ae8a-19b1-4841-bdde-e2994d1a7f70@linaro.org>
 <eb06107f-2a8b-4347-9937-89d099f22c89@linaro.org>
In-Reply-To: <eb06107f-2a8b-4347-9937-89d099f22c89@linaro.org>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 20 Jun 2025 14:21:59 -0700
X-Gm-Features: AX0GCFv52qq1d2u3OkGancLlDGTUKxHY7T7DpnHXulQzg1m73hULXYhp3o4O7zY
Message-ID: <CAJaLiFwW_=GZcyS8qEyCepkYyHsGs-3hOiS6ubNbN=2=WC9ReA@mail.gmail.com>
Subject: Re: arm: mvebu: Kirkwood boards are broken by commit 6fe50e3
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jerome,

On Fri, Jun 20, 2025 at 4:03=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> On 6/20/25 12:53, Jerome Forissier wrote:
> > Hi Tony,
> >
> > On 6/19/25 22:37, Tony Dinh wrote:
> >> Hi Jerome,
> >>
> >> While fixing some ext4 file system problems on 2025.07-rc4, I ran into
> >> a problem booting a few Kirkwood boards. kwboot loaded the u-boot
> >> image,
> >> and then u-boot execution was frozen without anything going to the
> >> serial console. I did a bisect and found the commit that caused it.
> >>
> >> https://github.com/trini/u-boot/commit/6fe50e39508043f386fc1bd40bbc02b=
8a75c1940
> >>
> >> When I tried to reverse this commit, I had a build error like this
> >> "{standard input}:24246: Error: selected processor does not support
> >> `mrc p15,1,r3,c15,c1,0' in Thumb mode"
> >>
> >> Currently, the only way to boot Kirkwood boards is to disable either
> >> CONFIG_LTO or CONFIG_SYS_THUMB_BUILD or both.
> >>
> >> I'm using the pogo_v4 and nsa325 boards as test beds. Please let me
> >> know if I can help with testing to troubleshoot this regression.
> >>
> >> All the best,
> >> Tony
> >
> > The problem seems to be that some arm32 instructions are inlined
> > inside thumb code and that's not allowed on this CPU without some
> > interworking instruction (bx, blx etc.). For example, consider
> > board_init_r(), is is mainly 16-bit instructions (Thumb):
> >
> > 006186a0 <board_init_r>:
> > board_init_r():
> > /home/jerome/work/u-boot/common/board_r.c:799
> >   6186a0:       b5f0            push    {r4, r5, r6, r7, lr}
> >   6186a2:       b0ab            sub     sp, #172        @ 0xac
> > get_gd():
> > /home/jerome/work/u-boot/./arch/arm/include/asm/global_data.h:127
> >   6186a4:       464a            mov     r2, r9
> > ...
> >
> > but then suddenly:
> >
> > /home/jerome/work/u-boot/arch/arm/mach-kirkwood/cpu.c:242
> >   619aae:       9b15            ldr     r3, [sp, #84]   @ 0x54
> > writefr_extra_feature_reg():
> > /home/jerome/work/u-boot/./arch/arm/include/asm/arch/cpu.h:100
> >   619ab0:       ee2f3f11        mcr     15, 1, r3, cr15, cr1, {0}
> >                 ^^^^^^^^
> >                 32-bit arm instruction
> >
> > I would expect some call to a *_from_thumb() veneer, such as in:
> >
> > 006009dc <do_bootm_qnxelf>:
> > [...]
> > /home/jerome/work/u-boot/boot/bootm_os.c:379
> >   600a02:       9501            str     r5, [sp, #4]
> > /home/jerome/work/u-boot/boot/bootm_os.c:384
> >   600a04:       f04a fc7c       bl      64b300 <__dcache_status_from_th=
umb>
> >
> >
> > 0064b130 <__dcache_enable_from_thumb>:
> > __dcache_enable_from_thumb():
> >   64b130:       4778            bx      pc
> >   64b132:       e7fd            b.n     64b130 <__dcache_enable_from_th=
umb>
> >   64b134:       e59fc000        ldr     ip, [pc]        @ 64b13c <__dca=
che_enable_from_thumb+0xc>
> >   64b138:       e08cf00f        add     pc, ip, pc
> >   64b13c:       fffffb28        .word   0xfffffb28
> >
> > We may need to move the inline functions with mrc/mcr to a .S file,
> > making sure it's built with -marm on CPUs that do not support Thumb2.
> > Then hopefully the proper interworking sequence would be inserted by th=
e
> > linker as is the case when Thumb is calling into object files resulting
> > from .c files built with -marm (for example: arch/arm/mach-kirkwood/cpu=
.c
> > which has CFLAGS_cpu.o :=3D -marm).
> >
> > In the meantime, could you try the following patch?
> >
> > diff --git a/common/Makefile b/common/Makefile
> > index 35991562a12..a509675335a 100644
> > --- a/common/Makefile
> > +++ b/common/Makefile
> > @@ -19,6 +19,8 @@ obj-y +=3D version.o
> >  # # boards
> >  obj-y +=3D board_f.o
> >  obj-y +=3D board_r.o
> > +CFLAGS_board_f.o +=3D -marm
> > +CFLAGS_board_r.o +=3D -marm
> >  obj-$(CONFIG_DISPLAY_BOARDINFO) +=3D board_info.o
> >  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) +=3D board_info.o
> >
> > I think it should resolve the issue, but is does also increase the
> > size of the binary (+4 KiB). So the .S solution would definitely be
> > better if it works IMO. I'll try to propose something ASAP, will
> > likely be on Monday, feel free to give it a try by yourself though :)
>
> Or maybe this which is a bit less radical:
>
> diff --git a/common/Makefile b/common/Makefile
> index 35991562a12..f0b7eadf7d2 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -19,6 +19,8 @@ obj-y +=3D version.o
>  # # boards
>  obj-y +=3D board_f.o
>  obj-y +=3D board_r.o
> +CFLAGS_REMOVE_board_f.o :=3D $(LTO_CFLAGS)
> +CFLAGS_REMOVE_board_r.o :=3D $(LTO_CFLAGS)
>  obj-$(CONFIG_DISPLAY_BOARDINFO) +=3D board_info.o
>  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) +=3D board_info.o
>
> Still results in +1 KiB.

The above patch works great! I've tested it on 3 Kirkwood boards: the
Pogo V4 (88F6192), Zyxel NSA325 (88F6282), and GoFlex Home (88F6281,
same SoC as the Sheevaplug).

The Sheevaplug is now 498K, which is well under limit. All these
boards see only 1K increase in binary size.

All the best,
Tony
>
> --
> Jerome
