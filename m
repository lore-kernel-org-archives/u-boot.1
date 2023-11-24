Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5538C61D97
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 23:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA49487076;
	Sat, 25 Nov 2023 00:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="X3pVBKR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 668168708A; Sat, 25 Nov 2023 00:46:46 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E152286EE0
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 00:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5079f6efd64so3182709e87.2
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 15:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700869603; x=1701474403;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1F0MTeQvwLAxRNZCRnQ5LdlmMWhAGK80EWiyNnUCI8g=;
 b=X3pVBKR2Ywa491dd7aULBE6j8ZzSY/UB8IDvVjAEBKMipLAsYj6lbjDfo/alGTMySD
 BpXbiEUs6HiRzeFj6jr11Y3aBkZfZzgPRLqGsYLtkA5v6gPEgTdq+GKGnJ2D8DvDTHys
 FJhsLRzo4CUTwEMudqd0zoAPKbzobT9jGU2Ztm6kM9zPl1S688EYJPCATUx/ToHX/D64
 JM4l2Dm7Jon/G8FSZqrUYT/h8Sp+eXiKb/fJsI4rwna2hmNGuZPbT1+XjoYxyRuMervY
 TLe0GDLhQB+HLNyTzV8VXtf992wiXQ3F4cazFVh6wJgfftN9oS9FayzYdBX6ZqDvCcPz
 0FXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700869603; x=1701474403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1F0MTeQvwLAxRNZCRnQ5LdlmMWhAGK80EWiyNnUCI8g=;
 b=KMDitwRVR0bHVnsxTjeHH8wInDLJgt9ljWnBJ+e6cR6DwFdUJ277LSJ0ZkD++3t3tE
 7OvJajkrvpqCRfj223eQYPyO4XHtkZ/VE8Z85r18p3t/egO6YUs3bEusCpjuidWa1fKC
 QrhgTw3kh5GAeaUSJVMu5qTAjg4jvG6U/N0LvnSKmMII+V2oCLxsMcOhVVYiHCcFaiiS
 M3OIIkbQvzlejHGjNUmNrtHe7ULowItkZnOAXnyYFCTRsEZR22D2a2rq/wrzFUkfGTVX
 Ydz+NVHPMuXhDjIfr53qqtYKgBoPtpxQ8uCI8yo0aHvRPHb1PlLKV1GrUTleBbEEYcCQ
 p6kQ==
X-Gm-Message-State: AOJu0YzLfmmYkLqfxMECEA/OahA9wQJAX9iqEneHMNVq4ZejnrTi5AF9
 D4qI4lsODeUNlLe+hfI74u50S+6SXrJjBVu0l/MvbQ==
X-Google-Smtp-Source: AGHT+IGN2DrB48intQsFqhHJpn2FVCFVRaJxY4Lq3WpMyRaSJ+cQzctJDNygcaXYa7RPGQd0d/M4zg==
X-Received: by 2002:a05:6512:1581:b0:50a:2721:a43d with SMTP id
 bp1-20020a056512158100b0050a2721a43dmr4007432lfb.49.1700869602062; 
 Fri, 24 Nov 2023 15:46:42 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com.
 [209.85.218.49]) by smtp.gmail.com with ESMTPSA id
 e12-20020a50fb8c000000b0053e88c4d004sm2244013edq.66.2023.11.24.15.46.41
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 15:46:41 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-a049d19b63bso340791766b.2
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 15:46:41 -0800 (PST)
X-Received: by 2002:a17:906:6811:b0:a02:f424:f817 with SMTP id
 k17-20020a170906681100b00a02f424f817mr3346146ejr.30.1700869601319; Fri, 24
 Nov 2023 15:46:41 -0800 (PST)
MIME-Version: 1.0
References: <CABEcMwVkWqwKVGCUTJw366rM7qk1NGGpJ_Aw8cX4wRCSvJMwPw@mail.gmail.com>
 <CAC_iWjKNf6RxPoKzPjJiLV+UnQES344wb=sqS1wCnQzC+J-Hkw@mail.gmail.com>
In-Reply-To: <CAC_iWjKNf6RxPoKzPjJiLV+UnQES344wb=sqS1wCnQzC+J-Hkw@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Fri, 24 Nov 2023 23:46:29 +0000
X-Gmail-Original-Message-ID: <CAHc5_t0UNC5PPxJ3ji4ToOqzHpcSovYRUJbb2ZJ64qTTOZ+1Bw@mail.gmail.com>
Message-ID: <CAHc5_t0UNC5PPxJ3ji4ToOqzHpcSovYRUJbb2ZJ64qTTOZ+1Bw@mail.gmail.com>
Subject: Re: efi: Set Variable Runtime implementation
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, takahiro.akashi@linaro.org, 
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

Hi Ilias,

On Fri, Nov 24, 2023 at 10:50=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Shantur
>
> On Fri, 24 Nov 2023 at 18:51, Shantur Rathore <i@shantur.com> wrote:
> >
> > Hi Heinrich,
> >
> > I am trying to work out how to enable the SetVariableRT service in
> > U-Boot and came across your patch [1] which initially had the
> > SetVariable RT service enabled in EFI but in the final patch this was
> > removed.
> > I am hoping to implement it on top of the SPI Flash EFI store [2] to
> > be able to set Boot order and boot items from Linux the UEFI way.
> >
> > Can I pick your brain on why it was dropped in the patch?
> > Is there any limitation in SetVariableRT service ?
>
> I recently had a talk about it in Plumbers [0]. Generally speaking, RT
> + hardware owned by the kernel is a very weird combination since you
> can't guarantee exclusive access to the flash or the bus and you have
> to preserve a *lot* of code alive in u-boot.
>
> I'll respond to your v1 patchset and we can discuss details there as well=
.
>
> [0] https://lpc.events/event/17/contributions/1653/

Thanks for the background and helping me understand the problem.
Makes me wonder how things work in the PC world.
U-boot being only ~1MB, can we not leave it all in memory and maybe
just disable SPI access to Linux.
I might be talking rubbish, just thinking what weird ways it can be worked.

Regards,
Shantur
