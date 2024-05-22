Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F4DC25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 08:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35E5787F19;
	Wed, 22 May 2024 10:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VvUC4ZQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E24888047; Wed, 22 May 2024 10:38:15 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B6E87EF6
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 10:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcmvbkbc@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e3c3aa8938so110105275ad.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716367091; x=1716971891; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZdIaDZYHhj++HYwV3TD2/ZOSsi4DRxGPSxL//J2vFs=;
 b=VvUC4ZQjb+WRi5i9fteD1y7lvyRs8NR2Ps3ej+vfeIlNqJ1IZnz53osf5S5U4Zs0VP
 nBNm2eNZTqs/Cr/eeViPXUCFbJypQEKTnbHAe9vzirAKy5R4RRIOT8r0f80FH7GxFgMY
 bkm3086UdsvpGpJLgZH7AjqsD/yC84iKyXflS9LeYNxB1QriqESah5l/PQOFSF3HY2Bg
 DYDm+DHFtaCd+lqaNMMJ/PwmOSUEd689p/zCbCCvh8GNB6w/tU4fsXTXmDOAoJqz+SbA
 TZ6zeSy219IVd0FVGwKU38WLi+wH+1OrB6YqMroFl9FJKApdVqfo6GldgksxQ87ZN+0T
 WWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716367091; x=1716971891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZdIaDZYHhj++HYwV3TD2/ZOSsi4DRxGPSxL//J2vFs=;
 b=qJ/M8afYWy5xiBGXVWnlPM8RJ48NPcU9oyPouaV08VzsrwGeB3f6yyb7oAX1bO/1Zq
 kYDDGuargu8wsDpQWA1rofIlZnnj+Twhi8lV9vX6t1iOzrc4C1gSddvFRn/qXVdqNeK6
 f+FOTIeY/uEoUtqwmQtKFNVVTZj86Is08eMG02R/vfnX/AFnZDw1/r7jmOWg8manrq/d
 KXx0iQXQA0wxAg4scyy244/bpDmqdxAYMO6u5DO9F8YjScXZsrsv68KbX8GmS/Kd/5aV
 G7MrEN34dBQg4kcLk2IfSZ16WLLw2JP3lqdYG1udgWi/qtiXoF0OQzUjD9Js/Bae8EJ0
 x4iQ==
X-Gm-Message-State: AOJu0Yz3rNSKEnt8BHZTSOzEO/bpbzUq1qw/AQeRzRyrP9fzDEyJi1ca
 oYjjuOGi8Ny88ilUTGZW2VMAm+kyIVqpHEGH96kky9kbxvFr2DxQ9706YFj+8950vPpxitjCzC+
 Aa8A3LF06TBYFrxDbCZvHSXezQFmsLA==
X-Google-Smtp-Source: AGHT+IFUDnYhLKhF1k/l3c+MyT7UT7SD46nnUUi9CQ+QQ5M7JxNBVQ3CVHiwv80sX+ALPmEWIqo298sWRDEztPSvjY0=
X-Received: by 2002:a17:90b:46cf:b0:2b4:b306:ffbc with SMTP id
 98e67ed59e1d1-2bd9f4531f6mr1333725a91.17.1716367090781; Wed, 22 May 2024
 01:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
 <20240519-qemu-xtensa-v1-9-8fff0cb11c19@flygoat.com>
 <CAMo8BfJXXozimNR8s2w+Fx8DZjMxT=t-039M+EKX9Ysb+-kwYw@mail.gmail.com>
 <2f58b7b9-fc0d-4bb2-bb34-cacc62cbefce@app.fastmail.com>
In-Reply-To: <2f58b7b9-fc0d-4bb2-bb34-cacc62cbefce@app.fastmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 22 May 2024 01:37:58 -0700
Message-ID: <CAMo8BfKMsyJhgMFHov_OzX8_8zvsi71YDT0TVkhy2ZpWi6Z8yg@mail.gmail.com>
Subject: Re: [PATCH 09/10] board: emulation: New board qemu-xtensa
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
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

On Tue, May 21, 2024 at 1:20=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
> =E5=9C=A82024=E5=B9=B45=E6=9C=8821=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=
=E5=8D=888:35=EF=BC=8CMax Filippov=E5=86=99=E9=81=93=EF=BC=9A
> >> +++ b/board/emulation/qemu-xtensa/MAINTAINERS
> >> @@ -0,0 +1,7 @@
> >> +QEMU XTENSA 'VIRT' BOARD
> >> +M:     Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> +S:     Maintained
> >> +F:     board/emulation/qemu-xtensa/
> >> +F:     board/emulation/common/
> >> +F:     include/configs/qemu-riscv.h
> >
> > This must be qemu-xtensa.h, right?
>
> Ah yes :-)
>
> Do you mind me to give you a M: entry?

Sure you can add me as a co-maintainer for this board.

> > I'm not sure what CFG_SYS_IO_BASE means for the virt machine, but
> > it looks like in the noMMU case SDRAM is going to overlap the
> > IO range with the above base addresses and sizes. And from QEMU
> > monitor I see the following address space distribution in the virt
> > machine with a noMMU core:
>
> So CFG_SYS_IO_BASE means physical address left for I/O with 1:1 mapping
> from virtual address. for PTP MMU I handled it in:
>
> [PATCH 03/10] xtensa: Implement phys virt conversion for PTP_MMU
>
> Can you confirm if noMMU core is doing the same on VA-PA mapping?

So far all xtensa cores except those that have MMUv2 (like dc232b) come
out of reset with identity mapping between virtual and physical addresses.

--=20
Thanks.
-- Max
