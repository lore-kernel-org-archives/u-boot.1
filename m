Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA874C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 16:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 399AB8746A;
	Thu,  9 Nov 2023 17:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cSJvyKCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D469871FB; Thu,  9 Nov 2023 16:21:17 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F9F9870DF
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 16:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rathore4u@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9dbb3e0ff65so160080466b.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 07:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699543275; x=1700148075; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KuC+Ca5gZ5CckvvTEGn27zq1GqCLjBne/zn4o+9nA4=;
 b=cSJvyKCAxUXpDFHGEaSJOqwu5eNXri6LF47FKrVviJnwnDGklzC7t/WPcRz/2zcvY3
 u1mxXwSQCjs3B3VWb66oST3xR0gCklk50Fa1DES88RQyi7NDyWO6/i5zIS0WOJRBpcl5
 GE6KAcFzsTYLO/i9LaXD2NfJLSvqXLgtLDsAJXo5iFiNVDEOjJOpYh0Ui9QKlpck2n2s
 yrJh/t2ZKZe0Z7g3g+TddkP+DTDGcJuYCwvz70NPZ/r/XME3teJ3QDfbvkKoZt0Bz2kU
 +c+wwwGuiX1nuZ6mX9fQLRnxc+2VXJn+zbn4sBvdJJ9DD5eavXbJ5qhacVMTAqKYbaaj
 Hzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699543275; x=1700148075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4KuC+Ca5gZ5CckvvTEGn27zq1GqCLjBne/zn4o+9nA4=;
 b=PzrY2+YZsrsbPUzw5yzxNuW134Q0Q/3Tu6VgNbJ9kVE5FCaMHCntfLS2hO4udCP2mT
 WzY0rfBVkKIkXV/A2AKc1/Vmf4vOAhEyZ2d+kU0a1KlBtHdU6phAEOaHAvmWCvFkLRYG
 /2rBcI0CqPNbCGc8RT5Toh9Bef8uIINOr0KQUomrldxTys9w3tpTjVAojp2tzWUcGTNV
 j/4XWF6rvmEfTYxXcycbgzBu0YzDf3Ogn+okhGLecm1z6f9OjgC8UCppsw8Lvi+DmhrR
 fvZbzbXFwmOLFV4SON1XxZK7d+nRHd97nSMxS5VakX+D/3BU8dPp3pSoCLo28WXsnqeB
 enrA==
X-Gm-Message-State: AOJu0YwdOjOFihmTK6TjiluBsN28953BeqnieH1knLFcGMIikimY5/za
 vslIciANUAuFgosMm/nXEc+Y3jYndlUWNU575x4=
X-Google-Smtp-Source: AGHT+IG0oVE12sja2i/bHFAcIllIJtuRzU4YycxLypu1tPT1pNxPWXSg0rnp4G1BHB1jut13dmI2O9qiFNBxKrM1LXY=
X-Received: by 2002:a17:907:7d93:b0:9c7:5a01:ffe5 with SMTP id
 oz19-20020a1709077d9300b009c75a01ffe5mr4241910ejc.5.1699543274939; Thu, 09
 Nov 2023 07:21:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2RP2LB=4GAdKWdckzXwiWUpAGY4T1UCu=YuJQgFWo4Qg@mail.gmail.com>
 <CALeDE9MaboQPWpDND5WD8ywhg5C-nhGPToXadK6CY0u-aDHGkQ@mail.gmail.com>
 <CAHc5_t0QinK2j9kiLh-3MT=NsLmTpbqVM7P=DM5Lf1AYGfLG-g@mail.gmail.com>
In-Reply-To: <CAHc5_t0QinK2j9kiLh-3MT=NsLmTpbqVM7P=DM5Lf1AYGfLG-g@mail.gmail.com>
From: Shantur Rathore <shantur.rathore@gmail.com>
Date: Thu, 9 Nov 2023 15:21:03 +0000
Message-ID: <CAHc5_t1J6KyF4_gE9UaxhvxxU6FzJEBtm_tYgcJS1jr2707a1A@mail.gmail.com>
Subject: Re: rockpro64 rk3399 dwc3 issue
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 09 Nov 2023 17:51:11 +0100
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

Seeing an interesting behaviour.

This NVME to USB disk gets detected 100% of the time when its plugged
in while usb is starting.
So after the usb controller is initialized and ready but before the
controller is scanned for devices.

It seems like the device isn't reset correctly on controller power up
and goes in an error state.

On Wed, Nov 8, 2023 at 3:34=E2=80=AFPM Shantur Rathore
<shantur.rathore@gmail.com> wrote:
>
> On Wed, Nov 8, 2023 at 2:50=E2=80=AFPM Peter Robinson <pbrobinson@gmail.c=
om> wrote:
> >
> > Hi,
> >
> > > I am trying to boot OS via USB3.0 ports on RK3399 base RockPro64.
> > > U-boot is failing to detect the drive in the USB3.0 port.
> > >
> > > If I boot linux through other mediums the drive is detected and works=
 fine.
> > > Can anyone please help me figure out the issue?
> >
> > Can you share the version of U-Boot you're using?
>
> I have tried 2023.1, 2023.10 , 2024.01-rc2
>
> An interesting finding, if I connect the same disk via a bus-powered
> (no external power) USB3.0 hub the disk gets detected 100% of the
> time.
> Directly connecting the same disk to the same USB3.0 port and U-boot
> fails to find it.
> Connecting on a USB2.0 port works too.
>
> Regards,
