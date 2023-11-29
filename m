Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F5DC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 07:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BEE78037B;
	Wed, 29 Nov 2023 08:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ied5A88u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CC5886F95; Wed, 29 Nov 2023 08:18:58 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92FAB80310
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 08:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9fffa4c4f43so867020266b.3
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 23:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701242335; x=1701847135; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/wABk+8WeDk+SzR7re2YBUhUeH5NbRBQLAW4rJmPnI=;
 b=ied5A88u55BzRfvD9dSt7+sv6JUmr7zMPlIBLuhb3/qLFld1FcxG6tgl7zT/yRPTSP
 uHNuwZFoM+TUzdjrilbzRM8dfMmsYBbQ5aAdaBiqaZOuhYZp92Ptxu4CN+ZoSbJYffRO
 GIkfQLSIkoxBMSvwXDQOyNUX3rQIyo7ZWoZRU+KgJUANWCEddWWt2waWGNUOQ69/xQ//
 icRPxluMC3N82N7BiknB/ddz+W/YG6muwz4EQnkk+qNQL9Ul6kKKbLNrS1pfaRbAIlnT
 o49xjKi/jywfmnwiRa6yuawbOCALpUgb0weXEt+4yn8M/prh0xUuaBT5nsE/IF7yooeP
 noWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701242335; x=1701847135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y/wABk+8WeDk+SzR7re2YBUhUeH5NbRBQLAW4rJmPnI=;
 b=BpQTck3HH+3pRQXmLqjd0iqRLjM58pKzDSWfvXrqJX3Y6Q1Bg0eQIUFMCOQAQi7Tk/
 GDeuUWFcw+rCLnMbJH4fQAfZHNydofm9VmTf02O4Z8yBo0ZgGajp++ou+8FkEzZy+VIY
 VNS1hQdyxMLIPNfRf4nDPvRZN/WXbiTQ/tCl69UrfHVjDa6ScN+y2hVcASJPv7YXT8AX
 Movu0UCPc/Yl9CSirjl3XjygfSnn/3TwioFQ0H4H84p4QjLUgfbCaoF33AbTThGzVVKW
 /WyLZx9VqKzlGhoH7k156lGH0x+Yc6ZX2j3qVphSjempQ2i7nCy4+zaGT2IrRRbacc23
 yPyQ==
X-Gm-Message-State: AOJu0YyXYlc7DQ4s40vrzjk55iPRERbIf4+poNxZ3NVxwTpfKEZrwTBe
 lS0wq9HU19p49+8wmhAxyoKl+eZbOtH/7Ypn2Op29Q==
X-Google-Smtp-Source: AGHT+IGAK+M/+eBbfC+1yvDgGXSk2uSxKx9jJNGzxN9NPF6evbwU8uLwPWBCdS9lx619e+ASwgZq5EYXGxKAsmAZFKU=
X-Received: by 2002:a17:907:9496:b0:9d3:f436:6809 with SMTP id
 dm22-20020a170907949600b009d3f4366809mr13769320ejc.39.1701242334888; Tue, 28
 Nov 2023 23:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-8-maxim.uvarov@linaro.org>
 <CAOMZO5AdtdHDnpNUkUieHh7_jhxDOtXp5Mtv2ybkTVLamuxO5g@mail.gmail.com>
 <CAD8XO3bLiTsgaYrYUSJgiwfYQGn6C9+=VN=UhxmZOo_c3ox3xg@mail.gmail.com>
 <CAOMZO5BkNQaMxg1b=Rryrvwfbfe5-0sDLiMe8=D9=NFbdZK-+A@mail.gmail.com>
 <CAJ+vNU0-kB_aW-T_prj-9463+uqGsfsudrX0iQRsW-KQuXC66w@mail.gmail.com>
 <20231128204322.GB2513409@bill-the-cat>
In-Reply-To: <20231128204322.GB2513409@bill-the-cat>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 29 Nov 2023 13:18:42 +0600
Message-ID: <CAD8XO3b0__L_LUNJDOGPTvum87V7s0eK5rg2Fqj3H=0BTVoZhA@mail.gmail.com>
Subject: Re: [PATHv11 07/43] net/lwip: implement wget cmd
To: Tom Rini <trini@konsulko.com>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, goldsimon@gmx.de, 
 Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Tim,

https://github.com/muvarov/u-boot/tree/master_lwip_test_v10
(branch master_lwip_test_v10)

Commit 8617b290e79e526119ccef0b0090cb220c78dd34
All later commits are experimental and I'm testing them in the CI.

And yes, this series has to apply to the current master without rejects.

BR,
Maxim.


On Wed, 29 Nov 2023 at 02:43, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Nov 28, 2023 at 12:41:44PM -0800, Tim Harvey wrote:
> > On Tue, Nov 28, 2023 at 11:12=E2=80=AFAM Fabio Estevam <festevam@gmail.=
com>
> wrote:
> > >
> > > Hi Maxim,
> > >
> > > On Tue, Nov 28, 2023 at 4:07=E2=80=AFPM Maxim Uvarov <maxim.uvarov@li=
naro.org>
> wrote:
> > >
> > > > From this log it's a little bit different wget output. My version
> prints "#"  for status. So I guess it's original wget. You can spend time
> on debugging it but this code will be replaced.
> > > > With my code I tried big iso download and check crc. I did not see
> any issues.
> > >
> > > Thanks for your feedback.
> > >
> > > I will test wget again after your series gets merged.
> > >
> >
> > Hi Maxim,
> >
> > Do you have a git repo that we can pull from to test for the wget
> failure?
>
> Note that "b4 am" for this series works currently on top of master, and
> getting more general testing on real hardware would be very nice.
>
> --
> Tom
>
