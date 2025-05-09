Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16546C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826E98211F;
	Fri,  9 May 2025 09:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bNIo6T5w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 756508288D; Fri,  9 May 2025 09:08:58 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 207AD8210D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5f62d3ed994so3229802a12.2
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746774535; x=1747379335; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDOVTvBY2hQzl4x0xlAS9VP7sT+X5C+A8PuttaCFmyA=;
 b=bNIo6T5wWCvvDJy4BgMI6+p8qnWJPGiMcYyTrPV20m0k8lKzqPouR4zLHeu5wBHLaX
 /qXB5zVA2Q0LKyvb0TpLvi5+jvxTjQIKJHCbZGex4N9IExAhUBTfpu/Hm3+StmqfPG6p
 2z+FiVpk74zG71jr9NGb0IFCrTLfXfDOak97MfzDLedzutUshLLFvW3NqOPemGmKhmET
 ItZF4YvP2FxUkGwrNZkH1STMkG16furtQpT/dumzZIuTHGWSi0TSKGjk0YtPmGSbU+Pl
 SMD12vSf6TVZKEBRCkz/QLe65Jh+v712WenHHX8TSXLLEjLqGeouU0a+IuGSCKKSGceX
 nEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746774535; x=1747379335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDOVTvBY2hQzl4x0xlAS9VP7sT+X5C+A8PuttaCFmyA=;
 b=uGPhzspqSTLEiYSa7nYfXi0YUv5b4AcpjiGH8b3MMivcbJKQndBIS/H1ijZ4ySAuM9
 SwJvVa1CRu2UmXHnT8dz17SLik2V3sWjmEo4kWre9lDDg5FShp2ed23HFn6tVzecuRjx
 fA6mluQeGBbvhjlGpjj/wSTLFpdCu/vmxcg2VTeJZYdnxovU5BaxZY1dHcqOJuKI2FKl
 VSqOn6dLhvnYJ+EF07rPwTuHxytZp+zTlNR/jRoK9kiQApE37qIRObN88njTmpCoslTF
 KWXZidfbMMudy7R5TEwcheGvp8UViOcIex5t7M40nsXcwWvfur0ewwHF3iKKJIw7Ix18
 61Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXZUE1fJGbZyUeHAmQZYSZTAmirxRcTTlNZjtIykBbpgGmi28TYhufm3bIwh5R79HsP3NJ80o=@lists.denx.de
X-Gm-Message-State: AOJu0YztwqPtBFu22MV+A2cwT59c3tZU/wNI3zon5ApFasG/OU2/2vY3
 epYm1kGI6hnyEqKX9r/FCnltTTnN+t8Wui8dWy0VllwAYDHWOtnsDpsan+OWTiBUbG+D/SwMrLF
 L+/Q3DF+v1LOyQPgIQrlvq8Awc5A=
X-Gm-Gg: ASbGncvyjFBvJ/5adgHsAS8viRVXQv2vBSBC/2NrGkF2y/++tUxuaXZVVPJP4RmU6v3
 S3ZAavUcMlryvqpYbpFQdMHfTTKho52cyVy+AigmG2lvVgVs/VwcuHRtUMla2q/tJNMMfWbvW3T
 xHoYfoJa2qHHuZgfPOeoA=
X-Google-Smtp-Source: AGHT+IFy6xSeENnr6GpZhNdMlhkEbAuN+UZ4rG9yxOM+Fw1GvytEt7cTK20FJVRt02pTE3RFKoZFSKkTIULzJWvTRRc=
X-Received: by 2002:a17:907:688a:b0:ad2:2417:12d9 with SMTP id
 a640c23a62f3a-ad2241716a5mr51158766b.39.1746774535293; Fri, 09 May 2025
 00:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
 <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
 <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
 <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org>
 <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
In-Reply-To: <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 9 May 2025 12:38:38 +0530
X-Gm-Features: AX0GCFvlAIyHMSqomrT8B9EkBmrGtOImqqnXVMTyKPDTZq4Vn-h2XNtU_Hhsenk
Message-ID: <CANAwSgRkqAj5Q4LMO-CKBSoMgO-+zd6JpbVs+eWY3kPgmj9bug@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: Wayne Schroeder <raz@chewies.net>
Cc: Ferass El Hafidi <funderscore@postmarketos.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, 
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
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

Hi Wayne,

On Fri, 9 May 2025 at 01:25, Wayne Schroeder <raz@chewies.net> wrote:
>
> I actually already have a working solution that I documented in my
> github repo (dubschro/odroid-n2).  All I do is set BOOTCOMMAND to
> check/delete a flag file on my boot partition and if it is found, then
> reset usb and sleep for 10 seconds.  I then have a systemd shutdown
> script only on reboot to touch that file.
>
> CONFIG_BOOTCOMMAND=3D"fatrm mmc 0:1 reboot && echo Resetting USB on
> reboot... && usb reset && sleep 10; run distro_bootcmd"
>
> It is a hack, but... the system reliably reboots remotely now, and
> that's the important part for now.
>
> Wayne
>
> On Thu, May 8, 2025 at 11:22=E2=80=AFAM Ferass El Hafidi
> <funderscore@postmarketos.org> wrote:
> >
> > On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> > > It's hard for me to quantify if usb works in u-boot as I'm not loadin=
g
> > > off of any usb storage devices.  It certainly never lets me use the
> > > keyboard to abort auto boot, and never has.  On reboot, to reliably
> >
> > You can send bytes via UART to abort boot, if you happen to have a UART
> > adapter around.
>
Can you test this series to see if this resolves the issue?

https://patchwork.ozlabs.org/project/uboot/list/?series=3D456088

Thanks
-Anand

> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
