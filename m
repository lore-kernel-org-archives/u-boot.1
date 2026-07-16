Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6A1C44514
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 12:43:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B72D184C88;
	Thu, 16 Jul 2026 14:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q+trarTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D92F284C83; Thu, 16 Jul 2026 14:42:59 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68CE984C9E
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 14:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-664ce3000e6so2853195d50.0
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 05:42:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784205776; cv=none;
 d=google.com; s=arc-20260327;
 b=IP0lbyMEwjTjBWQ8aK/9iIVjTTKhZfJdxzIYARCWoGSkOEVrwVru4jxOaFy8bXJlC9
 j+Rm3DXhqBDjFwSGHkjr4zSajfn6P+S7bG88LdrjTmGfIIDkM3w/+yGvInddHZ9OJ6GW
 oTip2oSQAJYGOXiPTzgAHKeEhukknwFQqi/nA5Eyjd0a0PObyeqmYKYJ3i81WIxMXkPW
 dDyCOySqi5QW4eh+cTbZPoxY6oNcbB+vsKq9pDhiTT14FBtSmZdgydw3wIO72zHgi7KG
 qMIvA7dsioV2+NhthSJx8sZVU59pL9XXPcpBB1vYir8+fVc4mTHj5bEhPAKGJFC92eR2
 94WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rvGwYV9B2JK9v60qa8txLF/IJD7XWSkGoM6gUAY4Buc=;
 fh=62/sJvpbRSF7pznmbUTsXcnS+dZB4ci6XY2WwsRvBeI=;
 b=rwkiXDmDUZ6MoUCk3FkgDtBc1FvAoFVXTKUvGK4FPFl4iSmwouNOpGdeFACJ9EYxfk
 mQzcWpOiFklbYTMyZRieAYzasa+km/2bYy3L8x9D/fBNveCzYvxiYLYRpPUkvZshnM9l
 LEZCb03y/JcEvYUXeZWwQm0bxIhiTtuMUvpqzoVSAMoXXtaFfMVogqv59yb1REaBbrYY
 SNiE9192Brv06Lg4jdhWVS7YLsEOaew3Dh/1IDmOzHyUBAy/37MgCE87dbXTEzNpLYJO
 2A4kNPdXcq73G17z2yKdwP9kuFdMyhVq/KBK0qZOzzfu7MkzisAN9AcT4+BUBfFzoQkm
 T4cg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784205776; x=1784810576; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rvGwYV9B2JK9v60qa8txLF/IJD7XWSkGoM6gUAY4Buc=;
 b=Q+trarTKPTmT00jgH/pOXeWY/IgB6gzgeV1m/xVkPK1UU1/sjjzR/YETul9GXfmejJ
 z7A3WSeWQCMmaLD/c5vXMCt8xvKRuQzc7URV1Su+OK3QrEOnOvlZuWY8BT2wjH84f9Jy
 rF+wixHND86j3KV9+U0OU0Lwq/8cAjkBzgQkGiuX2pCa+JReuozpdfxJdWEjgfijwYep
 Dv85MV3hO7i2RkvPD3LSNUI+nP1xsDg1B5fY3u1FTjLXxX22L2669dtyyxXVi2qJsKkW
 Lwxui2lsMhwNN07J7tT5ux1J9EaLidjiFTLYhDD9jGTHLSZoIZ1hNV0aPt4r1/O4S94i
 rxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205776; x=1784810576;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rvGwYV9B2JK9v60qa8txLF/IJD7XWSkGoM6gUAY4Buc=;
 b=Ql6OJ9GWTY9QT9dE8paTdTsbmlld6+V99ag8P/EX4RVw/YKtutBVw9K81A3/Zk0ueU
 GEk6bPGPCUkk/D2Z01CpqVIwZZ04M82uCr9FERyys6+YFR7OP0FgStBMxVfrGG7wjVXK
 +I7u+vrH076joEYpL+Jh4Rpqg9qcd2EUlxVAAZt9JrcES6vdUvQMQZ1kRysSG3YMGE6g
 fIA8UOJGGE/Q8k9178kwhHXRLy/sYvCHDN8f7DhZu+fxIvMtwa0lxVGRBhQFk1UF5woI
 lJ6gRDJEfx1zPYaDXJKMrBR7iuGFeo47V6Zbv8G+mvoF6adpGSC9wptonGZLDd2tsgRw
 yhZg==
X-Gm-Message-State: AOJu0YyubrrZeHaVqeDU0GWvVmjbKgJnkseQD+IVqpw0LwJc0mGpGNYo
 +BajVW0qiCWyMqbQZUh+MGEQYUZgQA9CM5b/thsILmTs0PpvVGI1kHyq9MDk4PFUqoQTeisqUu7
 cLcG0Dnzzy63+75RRdK4i9WmFOswUCvQ=
X-Gm-Gg: AfdE7cm4MpkczK6ljwspwNbG2bhBvkE+7sARFpgS7Z4Bd6W1lbPEv+dLWZgWZkbTsS4
 K9CHF/+vXxSISOVnb86hpfJpfWv9vJFe7CG3E751ycBkIkDnWC2yS1TR9NnXtvqZk3xFDlK/WFn
 gJYFyPwri4IoIwuy5rwCEYt3WHRHwvGZodmaFkGXPUZS/iDNwmg/oa38zOjlPLD5w+RL7Ut71JP
 2fmbMdqLjZgC8z2aD3kTUZsJooWu3p8DuOE15LuwvJKQRBU1UCHNqtpqfKCJsA=
X-Received: by 2002:a05:690e:4419:b0:667:97c4:7058 with SMTP id
 956f58d0204a3-667d7ae60cfmr10721086d50.37.1784205776163; Thu, 16 Jul 2026
 05:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <CADt8U2LFgohjjFX8oQs2bM_2qfsWKgsvnO3HFSh-E0Q1wLEEvA@mail.gmail.com>
In-Reply-To: <CADt8U2LFgohjjFX8oQs2bM_2qfsWKgsvnO3HFSh-E0Q1wLEEvA@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 16 Jul 2026 05:42:43 -0700
X-Gm-Features: AUfX_mwGgLsT7tmwaqKB3nqp0F3sjlAQKVDMg70fEXlWA0KFj2Tv-tRGjAXRShE
Message-ID: <CAJaLiFx3dj2m7s458GgagWFmqpz+DhccT0eypc2g2_=DraUQZg@mail.gmail.com>
Subject: Re: Bug? SATA hard drives do not boot on Hardkernel Odroid HC4
 (Amlogic S905X3)
To: Lucas <bigheadrodeo@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Lucas,

On Thu, Jul 9, 2026 at 8:54=E2=80=AFAM Lucas <bigheadrodeo@gmail.com> wrote=
:
>
> I am trying to use the odroid HC4 with Armbian Linux and two 3.5 inch SAT=
A
> HDDs physically inserted. I believe I have traced a bug to uboot code at
> the start of the boot process.
>
> The issue is documented here:
> https://github.com/armbian/build/issues/9532
>
> I have two versions of Armbian, one works and one doesn't:
> Armbian_26.5.1_Odroidhc4_trixie_current_6.18.33_minimal.img.xz - fails
> Armbian_25.8.1_Odroidhc4_bookworm_current_6.12.41_minimal.img.xz - works
>
> Both versions boot fine with no HDDs inserted. Some SATA devices boot fin=
e.
> These are powerful WD Red enterprise drives. When I interrupt boot by
> pressing any key, I can run `scsi scan` and `boot` and have it boot
> successfully on both versions. I also see HDMI visual artifacts during th=
e
> scsi scan sequence (the text becomes garbled on a few lines) that always
> means the boot will be successful.
>
> I tried compiling edits to /boot/boot.cmd. These edits did persist (I saw
> my echo commands) but did not fix the problem. There is part of the boot
> sequence that happens before the compiled boot.cmd runs.
>
> I tried setting preboot flags without recompilation, but can't figure out
> if this is supported on Armbian / HC4.
>
> I believe this preboot portion is controlled by uboot.
>
> I made some edits to the armbian code and ran a `compile.sh` command that
> seems to create a new uboot. I wrote that to the SD card and the board no
> longer boots with that card.
>
> In order to diagnose further, I could use some help confirming that this
> portion of boot is controlled by uboot.

PCI-based SATA drives could be spinning up either during preboot or
after, depending how u-boot is configured. It would be more helpful if
you can post the following info:

- Which version of u-boot, and whether Armbian has any downstream
patch applied on top of the mainline u-boot source. If you're not
sure, post the GitHub URL of the Armbian u-boot source.
- The content of the defconfig file used in this u-boot, ie.
./configs/xxx_defconfig (where xxx is the board name). It probably can
be found in some build shell scripts.
- If possible, power up, interrupt u-boot countdown and list the following =
info.
ver
printenv

For reference, here is the commit to fix this problem, but I have
tested only with <=3D 4TB HDDs.
https://github.com/u-boot/u-boot/commit/53cc4332b3b37218a7cdab8bdb953da57ee=
c2668

All the best,
Tony
