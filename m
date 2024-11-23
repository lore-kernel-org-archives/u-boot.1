Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B01E6ADF7
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 12:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28D3A8938D;
	Sat, 23 Nov 2024 13:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ge29E31/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AC188939E; Sat, 23 Nov 2024 13:13:06 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 175EA8917A
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 13:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2fb57f97d75so32528321fa.2
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 04:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732363983; x=1732968783; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1OFcauyLahkEldaOqRz/A78kcaIW5NhZt0MIhA1Cog=;
 b=ge29E31/6fMP+bP4jTLEYuC0UgpVC9RMEandPKLcp7eonzb6IBYc9HQjdrb42BJ7lj
 +ShId8rwnWR+BPPtqqwNrU5yldw28+P4xnoAhrNM/IbxoHzPw72UFPY+k/zcW3lf2HRz
 A+gn5OmL/YzC05aDpYKBxMFjUkteNq4jYBVeqOid9WLLBUaT0J2/ueVLcVyPWIg3F1DQ
 Vmx/1RfS5r2MhinYSeI9C9l8SXWfgM0b0Zu+dGiE5/DPv+CzwIZN5joFEV63o4mZwYQL
 5dcRvrin4IIxnLJJdu2wXeKdsuiNunCwVldq7xOtUNXRC+n/bKQ1PqigFQ+JzI1fNbZq
 a39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732363983; x=1732968783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1OFcauyLahkEldaOqRz/A78kcaIW5NhZt0MIhA1Cog=;
 b=BuVhDpe9bRFMiV4bs0gFDh2kFp1Nn/11eOy2ndgQmBrBXKF5qMQmOxz3/rixzXJo3X
 4oIZnkWWbp9IzyaR8YLoV6iTOjeJ1RL5u1WeEIaSpduQAw1WsusHFsCb0SlipuNpImcN
 hqrrE0qFZRVmJiA/TA/ApljSJsiPowQg+tm1y8tTCLoPML7FSNfRzZRtd8fqOGUeawee
 zfRjzlKaS2ki6C5mE0hsZZA+HuyxxJaSmMVsJc/AXQskycsA+q8gLFUZ3Cl9wMkKLn1u
 U9nwHHU16uaIg8PFOrOWRreproGtsS9+S9ZC4Dmb130K4pLbOPkvnmMgRmnI+voSdt6V
 sxOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi2ji0cMGXqmkwQtEIRd3uCZ67iezco21zL2m+GU/tWx7/7pPbeoIFdMsisx5ovdHzDQtNOuU=@lists.denx.de
X-Gm-Message-State: AOJu0YwHuUub1IdSFB0dQuNvLg7v5Hqvaq9gnBQ7Jg5cC4BamA4Kimfs
 1+WC/z9UsdQnR4RVmsDuVFfwmz2WDKSZJC0rMYJY1L9JfflIuAsAfrjehzovGLF2MT597U96Fsb
 e+5KpUIuT+ywyBD4w26XcQhXCiRk=
X-Gm-Gg: ASbGncvUf8CYPOxkF9dHqspQcb3gg08cKNPrAcqHblxpqTmQLW9XR8zFSbJ3XMyb5ab
 eMf9UnxnzYgeKy5NYoStxPnaP31TisH4KqeS5pXqh+ELOZNdrjjXUoJX0Yp3u38tslw==
X-Google-Smtp-Source: AGHT+IGJaWfqaYTTEBAk7xjVz0DV62skI+fhjOy3LVKRNN6JyvWdjT9mC4eP/h/0lKEIwyUSGbmK2vv6u5T9kBIVhPs=
X-Received: by 2002:a2e:99c4:0:b0:2ff:a7cd:ee7e with SMTP id
 38308e7fff4ca-2ffa7cdeee8mr28251771fa.6.1732363983051; Sat, 23 Nov 2024
 04:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
 <20241119020425.51989-3-hal.feng@starfivetech.com>
 <CAFA6WYOLxG68O4FYrDPt9q13dR=H3c2LcRVKhx4sRMBhy8dCTg@mail.gmail.com>
 <CANV2PTNAqxrPYypHwuDa6Dz5LUO_kzRGV0PzOand-tOo_peMCg@mail.gmail.com>
 <CAFA6WYPciEc-WJNc73j=C5AoGb5bbQ139p6=m7a_xqCVD4uYSA@mail.gmail.com>
In-Reply-To: <CAFA6WYPciEc-WJNc73j=C5AoGb5bbQ139p6=m7a_xqCVD4uYSA@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Sat, 23 Nov 2024 04:12:51 -0800
Message-ID: <CANV2PTPuKLnn3+0d-hqEogq9aE0iat9NhXjC-CxE40m5ht9SPw@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
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

On Thu, Nov 21, 2024 at 11:44=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Fri, 22 Nov 2024 at 12:12, E Shattow <lucent@gmail.com> wrote:
> >
> > On Mon, Nov 18, 2024 at 8:06=E2=80=AFPM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, 19 Nov 2024 at 07:35, Hal Feng <hal.feng@starfivetech.com> wr=
ote:
> > > >
> > > > Add u-boot features to the U-Boot device tree.
> > > >
> > >
> > > For follow-up work, I would suggest minimizing U-Boot specific DT
> > > bits. You can either re-use what's available in upstream DT or push
> > > U-Boot specific changes (eg. bootph-* properties etc.) upstream.
> > >
> > > FWIW:
> > >
> > > Acked-by: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > -Sumit
> >
> > Sumit, with the whole series applied this U-Boot specific DT addition
> > is confined (with exception of what I comment on below for rx delay
> > values on VF2 1.3b) to a single include file. Looking at linux-next
> > there is a bit of re-organization since the Framework / DeepComputing
> > JH7110 mainboard moved more nodes out of the common file and into
> > board specific dts. When upstream dts settles again then there will be
> > some more work to update this anyways. Is it any blocker for you now?
> >
>
> No, it's not really a blocker for me. Actually it will make life
> further easier for the board maintainers in future if they upstream
> everything in *-u-boot.dtsi to Linux DT. This will ensure that no more
> rework is needed when DT is synced from Linux and rather U-Boot uses
> the same DT as Linux does.
>
> -Sumit

Does the "snps,dw-mshc" override of compatible belong here or should
the driver in U-Boot be amended to accept "starfive,jh7110-mmc" as in
upstream dts?

-E
