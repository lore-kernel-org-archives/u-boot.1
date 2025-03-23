Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC99C35FFC
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 00:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 795B2810FE;
	Sun, 23 Mar 2025 01:04:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N8lB1sBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0AF81219; Sun, 23 Mar 2025 01:04:02 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F6C880C93
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 01:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ff80290e44so6678504a91.0
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 17:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742688238; x=1743293038; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lIsmuo2JKiIg/ls8C9h/e3+AOIApWS8skStHYxqmY84=;
 b=N8lB1sBJX5ut+mrkaoS7HnALIyxYjdcF7ZGY1ASaRIyMVB9ihC2ZDxnCPIsSYuGrao
 xTbNVj0mUBA4hwxOQ4Az2BSVfyiq0xrlQdUevU0EUx9XNMSmliKU6CT8WvvlItmUO1/A
 SCILPIcP6X8Lymgf9GT8YeEkecKvk5ODxBBA61YGl3xdGKsxxnzgXWxh/IqKSnGh/vOk
 Lix8TVYcgHEtCzG4A6a9mzGR9fjXcIX0XWJGorevnFqMGsopUAl+ptK5XRChC0I8i/YR
 c/hELH8eP5yIAqGpESaWQEhUZvG5GEagGpqleK3E+d5JvULnthtoxPXN58PbnWatW2bX
 bKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742688238; x=1743293038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lIsmuo2JKiIg/ls8C9h/e3+AOIApWS8skStHYxqmY84=;
 b=FhWhXJfdBejeODFLVI4oiBr6T7nQv7ItXxQPF2janeFdPulcAXgflyHuUBbes4sPHt
 zNBEDW2XCj4XXr1T3UEBb4zgDjR0fDtFurEyyaPp4G9aGq217qxQQW9P2tw3BipuolBG
 EfSkNYDSgXOoeN1/iGJnAvzCu7bxEk/xkLEbQ+lMg1pY4u4wC1To6gHAroqjcX/OWVhG
 Hpkz1hNnfz4P/mUoAl53tqsSwY0zFYjofNC2wT/llq1v7sQurx4YLp79Hz7MPPGiJlJw
 NB7mSxgFfSPDaGX1664lAn5PC7U1BZ8+4gIqz0MlT/QWuvevCnoVxTi2tJNrhPeCw5bv
 GPRw==
X-Gm-Message-State: AOJu0YxHht8WvE61X7/fsxGOxyZ93kISFxdhFo3AL+1SHRCcSSKJwGNC
 Kjgxl6ZEXUW/EIXA405ztbYZovvbDY3AGkHPUPsOKiaezDDpx+dD7XGthy0Rj8wCdVSz5Wh+Csz
 jrHNs2HuFLcnJfDArsoCSJnIOs58=
X-Gm-Gg: ASbGncsPkyEU1rQ7WZ2nRTwVpzvq9AMxbRts6bHQwcSw0nQTM7Pc4rtozUs45p7Zd0s
 MBYGAa2lNTWsLWvlA+LCWKfs938HY4IpMQ4dUTAzcce3ZPtQnHF30LWCp9EAklGQ6NFQCLrIaYh
 o4ny42Ou9tlATF9PXcE5GrqZ4noA==
X-Google-Smtp-Source: AGHT+IGuwrAvKZxwXzZcMYl4JWc/T359WmqIxvjFIYshLTnh5Ta5cSYXRLphQB/X1fmjJ4DTU3/wtwaQn28caApJKQA=
X-Received: by 2002:a17:90b:2e52:b0:2ff:53ad:a0ec with SMTP id
 98e67ed59e1d1-3030feb4f8amr12589534a91.21.1742688238395; Sat, 22 Mar 2025
 17:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250322183812.784676-1-aford173@gmail.com>
 <20250322183812.784676-4-aford173@gmail.com>
 <16100abb-70da-4b0b-a5de-3e961c0551d9@mailbox.org>
In-Reply-To: <16100abb-70da-4b0b-a5de-3e961c0551d9@mailbox.org>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 22 Mar 2025 19:03:47 -0500
X-Gm-Features: AQ5f1Jo47HWotHQJRZ2G1VKR_Ie36OHIGbXKrrxzgLTPplC0xuxkMYn2aTGtPnA
Message-ID: <CAHCN7xJHmQqX5jF+AcAitL3hKPn=C-cZ7Bt-oCb6PX+8+483Qg@mail.gmail.com>
Subject: Re: [PATCH V3 3/6] cpu: imx8_cpu: Print Speed grade if IMX_THERMAL or
 IMX_TMU
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, festevam@gmail.com, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Yannic Moog <y.moog@phytec.de>, Sumit Garg <sumit.garg@kernel.org>, 
 Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Ye Li <ye.li@nxp.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Christoph Stoidner <c.stoidner@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
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

On Sat, Mar 22, 2025 at 6:31=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 3/22/25 7:38 PM, Adam Ford wrote:
> > Much of the data that is display by imx8_cpu.c is also displayed from
> > arch/arm/mach-imx/cpu.c, except the temperature grade and active
> > temperature are only displayed when SoC is an i.MX9. Since IMX9 now
> > implies IMX_TMU, change this to check for IMX_THERMAL or IMX_TMU
> > in the same way it's done in mach-imx/cpu.c to enable displaying
> > this information for any SoC with either of these configs enabled.
> >
> > Before:
> > CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
> > Model: Beacon EmbeddedWorks i.MX8MPlus Development kit
> >
> > After:
> > CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
> > CPU:   Industrial temperature grade  (-40C to 105C) at 28C
> There is an extra space after 'grade' , please fix.

No problem.  Should that be its own patch, or can I roll the
whitespace change with the #ifdef change?  Normally, I like to keep
them separate, but it seems silly to me to make a patch solely for a
1-character whitespace change.

adam
