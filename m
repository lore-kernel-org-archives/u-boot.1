Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9619DD116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21B0183A2B;
	Fri, 28 Nov 2025 17:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QVURhvKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA5AF83A8F; Fri, 28 Nov 2025 17:44:52 +0100 (CET)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A071839E8
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:44:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6430834244aso1658296d50.2
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764348289; x=1764953089; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYWFbURtajA953t9STLePy24iStYJYtHZElWpqx4JKQ=;
 b=QVURhvKK/w5CGsSuDqLSnQIDvZ01OL/0HSII4ysOwTXIlL8PplKgii8GPdCmGrqptM
 toQjag3eLhYW7NPdMD4EudPuXu7RIbUy8EUV6JXV4OYq6WkuloqqssEw3spB7vhz3apv
 NborE5gEoClH5rFi9pV9GWyTKlynXs84AMybh0rKcmKy0ZFx0hgyc+vJzUrqofkqWSJL
 f5BMnW/PJ7Le41UDXB5kxK+CMYbv2ZhtZDW3pVerIpPezYKyX4ueo+7uXv+TzEVId65R
 KP+kcCm2MyrzsMHQgTBvQUAduDTZEjK2Q9v4T0Fm82y0RSSm2alzoIoGEGr01O0xkNj/
 rQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764348289; x=1764953089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BYWFbURtajA953t9STLePy24iStYJYtHZElWpqx4JKQ=;
 b=Aa/8bTA4I/PP+HgrkQNzzb3Ea/kgRDSrM/B93hnoc/L39Mc1raItrKZjef6LOi4qRm
 CQr1Wg38SDo7k7oA/R6Vz3zy/5tOTS5C9iN4sr+GUakGHemO1D88zuEb4eQOT4Xk1H2p
 FMhl+RbevRnoGB3WDjdM1MEiiffIC/oZgSb/reTnHuOhPD5YwlfunjEaSc4LEl0EP7b0
 GsPdZ7zV3mI+2IqUkbRRZhbIZqPSeIAHGwKPeI/Ws2SA4XEO95RzhN5wti96l+vKAdPC
 ESEA1U1qCtoHH6L7ozWnrXUfoz5cAlR7A5+lL0qk4YmGvI+1srHX7b6cveCXzRuXDqyO
 lusw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWBW/WDzgI5hyQaN+CJqxcZ2puewUuuBMeboNhWflXmYAefNefxn5f/d8AaPuHRl7t0by8xP8=@lists.denx.de
X-Gm-Message-State: AOJu0YxlQ+w23jmDHThcHOjCROLBJN7Q2kFGxf5us2P10Jt5zZa9Ab85
 B6CQ6lQcQrHlSt4caKXlYsd7oxgGK9k+vh8bxZXp4KHu0qSWL7WR+eSXhxMvvVn6M01dDexifVi
 OE+N2IVc3MU24TVgag+8rquIgavuOexmwuq6Fk7uU3g==
X-Gm-Gg: ASbGnctLq6D9Cz3MYm2ngXEZrSz3cnLgDAZGrpdVEMvO5SWntRXMz6+S3YOJK9Je0Ug
 QKWtwGzDOTkfA5/sz2zznUfBeniLI2knO+4zKPRTA+E/rPSIksuFBMgCVVrBYP/BZYT8y8bq+z+
 XLsKX8xX4/4lJmIRZwlD5mcBshvlv86VQUhsJJukHcxO4ua70CgAxTaQHw7fUPdIsLZOM5e2eg7
 m5bJU9NVT+9+huitCv1WxK1e97utOwxSMG6SVXyld306PriBCYXNSqAgA+5R30cViuOfxq3gNuK
 1iv/iKp3JbpKra2cRslzk8WS4eXo+dZWDBh82a6f/cS6eHVa8w==
X-Google-Smtp-Source: AGHT+IEw1aHbvN3vfcLi2Y/OMWtmkyvczihoQ1/SD5WKwDF7A+7GRbbAfh9Ux3VjUWqLU1mLJvDJFPF2UnTYKjuy0oE=
X-Received: by 2002:a05:690e:108c:b0:641:f5bc:68d7 with SMTP id
 956f58d0204a3-64329420a5bmr8157187d50.84.1764348288717; Fri, 28 Nov 2025
 08:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
In-Reply-To: <20251128153130.GC2125796@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Nov 2025 18:44:12 +0200
X-Gm-Features: AWmQ_bl8-KjvTBV87lIFF9tH9Z2uPzELCJXENKhzE3qdX2pl53UImSgbIZ6rot0
Message-ID: <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: Tom Rini <trini@konsulko.com>
Cc: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 u-boot@lists.denx.de, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Brian Sune <briansune@gmail.com>, Tien Fong Chee <tien.fong.chee@intel.com>
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

On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Alif Zakuan wrote:
> >
> >
> > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > [CAUTION: This email is from outside your organization. Unless you tr=
ust
> > > the sender, do not click on links or open attachments as it may be a
> > > fraudulent email attempting to steal your information and/or compromi=
se
> > > your computer.]
> > >
> > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > >
> > > Hello everyone,
> > >
> > > > I already have the referenced commit in my test branch, and I can
> > > > confirm that the same compilation error still appears on CycloneV w=
hen
> > > > certain directories produce no SPL objects.
> > > >
> > > > The existing fix ensures that built-in.o is always present, but it =
does
> > > > not prevent ar from generating empty built-in.a archives, which old=
er
> > > > ARM 32-bit linkers (such as CycloneV toolchains) reject as =E2=80=
=9Cfile
> > > > truncated=E2=80=9D.
> > >
> > > Which toolchain is this ?
> > >
> >
> > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to compile our SoC32 de=
vices
> > - CycloneV and Arria10
>
> Ilias, do you recall the solution to this problem from when it came up
> on IRC a few weeks ago?

Nop unfortunately not.
Was this caused by the Kbuild bump? I remember the logic around
builtin changing significantly.

Cheers
/Ilias
>
> --
> Tom
