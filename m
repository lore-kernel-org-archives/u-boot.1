Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFE6D1D483
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 18:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E7C98415E;
	Thu,  8 Jan 2026 19:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aYRz2vGW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE16A841F2; Thu,  8 Jan 2026 19:27:20 +0100 (CET)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com
 [IPv6:2607:f8b0:4864:20::122b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 675F08415D
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 19:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-121b251438eso1376832c88.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 10:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1767896837; x=1768501637;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/oyCAVwHZPqf47awlsRi5joO8BreyLgAou2orqCDet8=;
 b=aYRz2vGW3o7ep/45RoAR7FOtRmJNBS+QrmURye6QQSmB7juhv1a63u6inSG8pH6B3n
 49cWPb2tlcoGdmCFiOGLnzJD32Re36VdngS6V/V52pUrZ8UPz/PufhJLUwFzb55qorpw
 JSnFx61RP48elxAZPyh2rK8ObxOh0yJWLfXQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767896837; x=1768501637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/oyCAVwHZPqf47awlsRi5joO8BreyLgAou2orqCDet8=;
 b=bF6WSOrjOURVpaFDAKDxx8lQKwh184sYPH94khct0qMmOkUp7rFcrM7BBP+pJ4zOOe
 z6838jHDfU8jFdyoIryKd4FcbtCSY6MAYq+wpZKw1qcmVhHC90LGxHUKvmThCNIQ/GwJ
 Hdb460ZF5BcLJnGx1Ua59GBKC3pn2wSeBlJzegmALTKBo1r+tVOs8zgYkARfZf55OW5X
 8517jxvoMT68kDNhNweVxxz0ZHqXbFxO8voucyeQc1uyYcoWgCDOd4wBBkm4X66mn87a
 A0I+9TYForguVmm0348ix7GzRqf4UFEVh8ftuPMM3RQBHyuFbjRHMhXv5AlKdTuWY5Wj
 7w+w==
X-Gm-Message-State: AOJu0Yz2hJC/vAapL6Z/MrcR68gdnoA2L/MJyCyhGXmSN5iSUWRexLsS
 yhkQhK5Qi5oCaZP2CTnlL8cUVj85ziV4Ye3YVxDn3neKHUaR9MNb1PecpyjgY7Z27K+yEIGpdT1
 M35xHELKWv7zxVXzc/1dJy9qmzdeeaoQXw/T+Vq61E+kylE2308f1Uks=
X-Gm-Gg: AY/fxX4SEnjeKXrnGnVsEeivXO4GT1NftMemHwQvoCmrxwbjg5FImGS5rjkwuAp1st5
 Kfm7o4NKhDtL62NrSp45T/xvrr5fqc2qzpihEJ5B/wL3FiuQXzzqxtjEo4plrAvrSAYFU4qezgs
 Za2AiBo9lMq5706PpJOgQ81RcthH60qIX9VSLsoJpN4icYfSJdSiDC6Ha/IskYFklzVHUqkBwUa
 4Xd8/MYfbLTAjYNgc2+7LSJONbtrVuqr9hx97VJfhPtXR0/WgPz1rNpXp8ihC8Bup8gP2Lcyl+6
 dJVNWs6lZmx2W++c8AWK++mMxuESWrAf4d2ngg==
X-Google-Smtp-Source: AGHT+IH4rbkFvXWH2bddysQbrRKnsN3DWId4yOei3N5qxkb8fdyHihrpObLwP0poxt/0lu6mvjUmngS4AA4pVX34ALw=
X-Received: by 2002:a05:7300:ff4c:b0:2ac:3c35:a6cc with SMTP id
 5a478bee46e88-2b16fead510mr8111580eec.20.1767896836591; Thu, 08 Jan 2026
 10:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20251228164500.313817-1-t.preissl@proton.me>
 <20251229144813.GP710860@bill-the-cat>
 <CAFLszTjFP4N1v-=Uob+DRpG_Fc3szkt+yziG+cbLQ7nxaM5mvQ@mail.gmail.com>
 <20251231015450.GW710860@bill-the-cat>
 <20260108150025.50206-1-t.preissl@proton.me>
In-Reply-To: <20260108150025.50206-1-t.preissl@proton.me>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 8 Jan 2026 19:27:05 +0100
X-Gm-Features: AQt7F2rT10lpvk_gNC2kLtpsIFSnQzbYnjAELiOERt9pFvX_P0AJYxKOIFCjcDE
Message-ID: <CAOf5uwnmzGeKjm0LqiRTokQWDxnXUGp71OK131kn+O9hmamV=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fix integer overflows in filesystem code
To: =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

Hi Simon

On Thu, Jan 8, 2026 at 4:58=E2=80=AFPM Timo tp Prei=C3=9Fl <t.preissl@proto=
n.me> wrote:
>
> Hi,
>
> this is a gentle reminder for the v2 patch series fixing integer
> overflows in filesystem code, sent on Dec 31.
>
> Any feedback would be appreciated.
>

Because you made a similar contribution , do you have time to review
them, and maybe rebase your series on top of this one?

Michael

> Thanks,
> Timo
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
