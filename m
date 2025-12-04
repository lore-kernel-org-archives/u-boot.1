Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608F0D216A4
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 16:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE19084154;
	Thu,  4 Dec 2025 17:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JomKHQZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0396284158; Thu,  4 Dec 2025 17:28:59 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82770840E0
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 17:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c6d13986f8so1074044a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 08:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764865735; x=1765470535; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIF0eFCyxLK8nwpFbWPMNkv7idFR+L7AmGChuYM3RAc=;
 b=JomKHQZ1k9VdQWpe03xhv4inu6dsB4s1C4Bu+qkiRoFJPYuZvniiAQaEw/8JWF4wNt
 ONXTw+IpIFrkpRXyPbbsrUo86zjqPzkNCosRxxOrYszq0evhSBF0RKC+UOtxfCHlV6ic
 M9F7Ggo+nPpe6cGcqnbZb1dUFKTxDh/XIAq6bNYdQAqNMtueSQPGR3OXbw/5cpwkjdZ7
 e7BdzNij8acjHeuXTiShxrcUJz7Mv80ITgBIdjMBq82oTyQYVh3/BezM+xwflZPU0nqa
 iZ1E47iKQJanntD9GLlSzYAX/hEZxhKocQdWGnZj/cIqtnlEqNONhVDOaXgvLVOlvNnj
 g2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764865735; x=1765470535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cIF0eFCyxLK8nwpFbWPMNkv7idFR+L7AmGChuYM3RAc=;
 b=dklMaRNtw4jhdoXDdtDYjM6QpCXjuDkqy6b5+9fkPtiCfkHgu1eor4winZv4qhKCOf
 q/1/azNC3n1uGfgwI4cxM/9tk4WAePbLQy29RUNuhQmYiKb4Bc9wYXdqQe//suCGDZJp
 6IO0+FLbRjHPgmTQ5HculNS7FEmygBvbe26PCNftusIV9c/VwJ+eXaCfVfPd2Nlw+xsB
 TzOADAB77qzJj+AjG8+E2SefhVWSvPYjGOsicnF7LvumY6CKucaD9EBwo56eBeRe37xd
 04muasyRt0j3trpRINx64f56KHmqNeN7GON3E4TgDB0Wa0VlNB13C9kwYnL339H+KdgY
 RMkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURc2Z5hUiXtms5yRZlTcv5wOSndDuva6Iij61lMWvNBg/l3ADt90Ehk3Tw96eKToqQcAMV0Vo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8nMPc3XvPUdiS97wVDSl5OsgWVyJjOP5gob60V80mDQS4rEVr
 t8jph/PDYSQalC3BEcJCCQzMxY4Lk16pzzqDPp327TH4VO8tdcBC/sWuC0+8crV4LSqoGJJ/d9U
 ZJyjk7DgbDw2fL/dSzFLANDTSztnraWc=
X-Gm-Gg: ASbGnct6EYRZ18EzYrLcehfMiVVEhNNqiDHJ8RkJXE7vGjT+Ha+48HsJStw/m7dLI7f
 OOHKjZ6tlQhe+mKecHKZ79Lu1FBxaQLC9U0SPHRLzlrFogA+msuYBA5cGJFR5Qx+7hmQad1HKaJ
 kZPajGRO2hAkvRNoyekKiSzNeYZbz1JW2PD9MB7UYZhwOQNd+bO+Psv94PQ0ULK8cTnTq+uZ+3p
 W4WnjULo3rlYvzt3VMaf/j5VwSD7SKTUCHp53oHEJ5DdBFvjZJMiWSfTgKPFaL2JkXI33Y=
X-Google-Smtp-Source: AGHT+IERrhXJ0uq51FTvHZBdpesTSBc1AlJVVi0INWGqvO2BwJoIOA1ceSMcFZiyF5rOgFcLx3hSK0crp1gEU6zB83Y=
X-Received: by 2002:a9d:480c:0:b0:7c5:3663:ae04 with SMTP id
 46e09a7af769-7c957c850abmr1914344a34.15.1764865735222; Thu, 04 Dec 2025
 08:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
 <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
 <CAN7C2SBSYkFrkaTDg7kuE2NsqUsjshZVepCdad+5buMSpBEmDw@mail.gmail.com>
 <CANp-EDZAJr5Hvh0T=53H-DeOU5G0mZ-ohs9c29+7eyOKny6yOA@mail.gmail.com>
 <CANp-EDZa0Y4NFOD2sco1xvONeLeixFQOrGLZ+hC275wMCHuF6g@mail.gmail.com>
In-Reply-To: <CANp-EDZa0Y4NFOD2sco1xvONeLeixFQOrGLZ+hC275wMCHuF6g@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 5 Dec 2025 00:28:42 +0800
X-Gm-Features: AWmQ_bmrWNxlU0re_Wmr7shVms7L-nQ3fCtX5NYEpNLsiH8hd5ibXcg-6Ry7Wpw
Message-ID: <CAN7C2SBop5h9WtF2GLRkWeNmLpBcDC5dHUmmR=WzRXTpr6-7VQ@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Ralph Siemsen <ralph.siemsen@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=9C=88=
4=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:47=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Wed, Dec 3, 2025 at 3:52=E2=80=AFPM Ralph Siemsen <ralph.siemsen@linar=
o.org> wrote:
> > Then it sounds like it is a recent issue... hmm... I'm currently on
> > 2025.10 release version (plus some cherry-picks). I'll give a try on
> > master/next once I get some other things stabilised...
>
> Just a quick note to say that master branch (with Jan's v2 patches) is
> working fine for me. The calibration is passing on both cold/warm
> reboot, as well as power cycling (I tried a few dozen times each).
> Note that my board only has 512 MB.

Thank you. Yet, no confirmation on 2GB situation. For 1G or 512M
I can also repeat normal boot on different brand.
Which for 512x16 ddr3 die can have several construction from the beginning.
But the question still holds "WHY" CYCLIC or WDT can trigger a normal boot?
Cannot explain nor trace.

Brian

>
> Regards,
> Ralph
