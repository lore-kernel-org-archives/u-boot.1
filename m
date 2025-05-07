Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A77BC3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 14:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5062E81F32;
	Wed,  7 May 2025 16:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=chewies-net.20230601.gappssmtp.com header.i=@chewies-net.20230601.gappssmtp.com header.b="Ux+7+Vxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FFFE8212F; Wed,  7 May 2025 15:04:08 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1EA48004F
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 15:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=raz@chewies.net
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so1282022066b.1
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chewies-net.20230601.gappssmtp.com; s=20230601; t=1746623045; x=1747227845;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4+LmSgXiLryF/j8oR/d0abK66q0D8JYbtiWsJTdvXQ=;
 b=Ux+7+VxjmSdS/se3JCm6yJnJKIvWn3dLtoV5yetxqZRYRD/dQcUI3oZRyc3nVpfVSY
 s9ay11ovYkrXhUPeJfcR29tocI4oVlTid6rcGlvjtDX0aslMhfCK2C+nf7r5Qqqq6ym+
 ELGdOfMzBUndDNkBAP28O8+4WjDw/hfFDOLw6YqFW+h3S+uv+qoYDHf88PWrfNZJGCVq
 bPQsypPaBBa8BKcKMHUMbDR/d5DlwQdwEuAYXzo02EllTVpGj4I3DjBHyKhj9mXxJsI/
 tSiSXFODH9EqNtB21HGF/HRmId82a1W/SBSRUHSYpRdY6+zvINptByuUB2xiFYxhbiPW
 aTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746623045; x=1747227845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4+LmSgXiLryF/j8oR/d0abK66q0D8JYbtiWsJTdvXQ=;
 b=XPaU0vqE5jh19Vf5KAn4oioJjLnLKniWI5n5nYb7MsOh4evMvPBVEqHPo6MMc52xDT
 LHLUb9PTa9PGOPEhZqSZ7c8xM8XTRfq9KlZYr7TbEzTAJeptdsu/TiR7QL+AhVo9WToS
 JopGt72ky3a9M0AAB+9v2PL5ERSiS5+ur+beFn5rmPfD3jj52gvbg8AMOpdMvg5uME8n
 X5V4VnLSijNQs0iTqvPpNdSZyD+pbKyY6WU+5aDRRBsTlOl0plpuWk8j/Z/Cdjw0H3Eu
 rttYQC/8NXQmHrgp6ZmPhA/L1ebmjHk4RmKz9lDkah/qGc590d0BRMEjIwmUEcklb0/g
 5AtQ==
X-Gm-Message-State: AOJu0YxdQiIso9Z+31vMp1ua1fv0v9RRAIsM+xrxOd/z/gCRFBufUpia
 pPNOzLH2Pik7vi2F5q9vSfQLHY8eovnSPQJd3kMS9nV9eXIPXh0Qjvqxu6U1fSMK2+YZuPH1JS/
 T27MQBWIv2yrGlUnBJ43pSA/ASBmEfVTpsSFN
X-Gm-Gg: ASbGncvjTiLg+LUPghEldsO/6FqjgpdqLVkV0jQIwVsamUso3wmZ2ZsGyvclA1k8f2P
 sPgsGNbl7QKrSlNrp9ACMpqaPEjO+bXXV+mO4BJEGNY1yCKFd5TnaTZ8DgxXVO34ainfz/r6waD
 p4e5IDvaROWPuK/Yo10bs=
X-Google-Smtp-Source: AGHT+IFzajSvRmyDEs5hHY4lL+t8+2vMhkjYGb7OU5fT3ekq5YUVOD2BAWbTh9IUJt7dgx74MkVuHg/PnkykKXwE4ik=
X-Received: by 2002:a17:907:9709:b0:aca:c4a6:cd90 with SMTP id
 a640c23a62f3a-ad1e8bc315cmr333347866b.5.1746623045257; Wed, 07 May 2025
 06:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
 <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
In-Reply-To: <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
From: Wayne Schroeder <raz@chewies.net>
Date: Wed, 7 May 2025 08:03:52 -0500
X-Gm-Features: ATxdqUGrMJl_qwtuZFp4N1ILboK2S9KpJF6PNjsTlAh7u7oPIil0F6b7Kp5_KIE
Message-ID: <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, 
 "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, 
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 07 May 2025 16:10:00 +0200
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

It's hard for me to quantify if usb works in u-boot as I'm not loading
off of any usb storage devices.  It certainly never lets me use the
keyboard to abort auto boot, and never has.  On reboot, to reliably
get it to work, I have to do a usb reset and sleep some amount of time
before doing distro boot.  I picked 10 seconds.  If you would like for
me to do some scripted boot command additions before my extlinux to
gather data, I can.

Right now, what I have done is make a reboot hook in linux to touch a
file on the boot partition that my bootcommand fatrms and if it was
present, it resets usb and sleeps 10 seconds, so it's reliable to
reboot remotely like that.  Let me know how else I can gather any
data.

On Wed, May 7, 2025 at 7:01=E2=80=AFAM <neil.armstrong@linaro.org> wrote:
>
> On 05/05/2025 15:12, Wayne Schroeder wrote:
> > If I add the usb reset command, it works reliably at reboot, but it
> > does not work on a fresh power-up with that change.
>
> OK this means there's a dangling resource, Does USB always work within
> U-Boot or it breaks U-Boot and Linux in those cases ?
>
> >
> >
> > On Mon, May 5, 2025 at 2:07=E2=80=AFAM <neil.armstrong@linaro.org> wrot=
e:
> >
> >> I think it's a very long term issue, USB lacks a proper reset at probe=
 on
> >> warm reset, does USB still work from U-Boot after the reboot ?
> >>
>
