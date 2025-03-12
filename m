Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61C2C282EC
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 00:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6494180F9C;
	Wed, 12 Mar 2025 01:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g3eybJt1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D4380FB9; Wed, 12 Mar 2025 01:41:19 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53BC080F92
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 01:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-30762598511so65231021fa.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741740076; x=1742344876; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oz1XBou7VEN8EJesYOxorpHitSQ3pzaY3V0MS4CSjBQ=;
 b=g3eybJt1e9pcEBPHGx4B9iQrwbM8zXogntoIxw/7jCKK06WEl4D7byG+TQVENKpVHn
 pghsWphcjmuvTKSlORFntdMXCprGEd+FrI5aXls/uY/j7QQ18P2r3nGtOt7bgXvlIAX1
 2LYbrhdyH+NwKpyKymj2HAX6C8PF9Gg/qzuRn84YH6z9fLRJ2HErsGGiqL0h51GK8rgR
 6lnorVYWp3DDe6xnhCQMvF23DSjagQuu2RCp3hlXQRwy9QhPdGEmeVhfov9D+Twn8kWA
 PTHYruzXtISP0jfSzv9lZ8JAbjy/9rW/wC/g83yVi57PWgCBPCpokBRzucsjM9flp7wQ
 ZjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741740076; x=1742344876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oz1XBou7VEN8EJesYOxorpHitSQ3pzaY3V0MS4CSjBQ=;
 b=kcFxvWjos+ej6miOQL7HwAc/2RyTcS4VOkIgSGGvB1Faph0pSz4tkiIGT17C07xPDX
 hA+OFObW6WfV6TlTKUfqwdmur3eow0ZrRyiMN/pTLHyIRm+uOOchegv60W8DB7HPG2k4
 E4KsL7hsmwAmJSByOcEp0NKqs4itQN9oS1+5zCQLXIOCb3cfQsFGTiwyY8H127jBuT9+
 KxIr99JMoB0tD516M8Mc44XK7w3CqPdV7CMiqMGVwQTaVp/We7utxSWNVJVlZM7VI47b
 WdpM7w/E+j0OOSwxeuW4sErKkNYXgfr4R5qTR4uG7ZogYdYHfK5PR0HMLGDYsjJRKXPz
 SvJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1V3abK6eqEhpZdSWuytqTGDuQUv885pFB7+sOMXDxyjo7ZpZJNT0I0U5iljdIOd94lqwEY1M=@lists.denx.de
X-Gm-Message-State: AOJu0YyvjrVKzyVPoIozi3+UFBPCwnZzBWir8lhVEUxSo5dAlE9G9IWE
 x7zo3TX3UAb08ZgSXstQSJS5VhJtfELqhISluvE01lv6Uhl36/OkdvzheF2DSImo6s9bBqxqbDT
 Apo1fFWV80SU6lpzT/NwTkbHm1ZE=
X-Gm-Gg: ASbGnct49Nikd5Y8T5YrcZQnHaJFHSjFu3AEnNC0Y/AS024wLjrej+fcDrYzT0a8wgf
 dd4uwtica2/1f1YLncEK86cDEqhtOIM0gGhamID+w+jsXW489bn8V4Cu0+7tURfbqPj9Z06Fynl
 XXVoleF5haI4ihEOpG/gklX1a/7wqqy5f6+I8MfJ7P9SF315hQQ/PVeVvftQ==
X-Google-Smtp-Source: AGHT+IFyBmP7CVZvBGZWWdSUPqJ3SIVWs6zUre47zkKcUtJTL4162LzgesXF7L7OXK19GQ+tPv1LpZckz4wMF7hT+bk=
X-Received: by 2002:a05:6512:a93:b0:546:2f7a:38c4 with SMTP id
 2adb3069b0e04-54990e3d8aamr6140281e87.13.1741740076282; Tue, 11 Mar 2025
 17:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250105203714.158480-1-marex@denx.de>
 <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
 <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
 <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
 <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
 <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
 <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
 <CAFLszTjcdFKn2ayTrLx930b+P5ebBfX_EE8-aS8sOJTBsqQKHQ@mail.gmail.com>
 <8647abd3-9378-42cf-a1fa-302c7891d439@denx.de>
 <CAFLszTiw01KB4ipwqi1b64A4MP3SyU=zFRymV4moiJ_nBtnHRw@mail.gmail.com>
 <a05cf63b-820d-4b27-8f66-37a6e6c7b372@denx.de>
 <CAFLszTgF+g2OXz=L=r7rOQcNkk19GfdCrwixG8ZAsR=1rh9Fqw@mail.gmail.com>
 <f1e4014e-658b-4a47-af8d-72ef76c1b134@denx.de>
In-Reply-To: <f1e4014e-658b-4a47-af8d-72ef76c1b134@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 11 Mar 2025 21:41:04 -0300
X-Gm-Features: AQ5f1Jqww_SyfYK7Vlm9Hzq78D_gbu3_B3yQ7XVGYuVIVIxREl3HWm_mfpM2G6I
Message-ID: <CAOMZO5B7cxEftN0TeTF--pKXqOmbmaFLc9mEPO4=8odrLBeypQ@mail.gmail.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Marek Vasut <marex@denx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Brian Ruley <brian.ruley@gehealthcare.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Fri, Mar 7, 2025 at 2:42=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:

> So what should we do about this particular patch ?
>
> Should this be applied ? Rebased ? Updated somehow ?

This patch causes a CI error:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1057151
