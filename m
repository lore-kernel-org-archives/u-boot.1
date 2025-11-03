Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACA3CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 15:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB6A8838E7;
	Mon,  3 Nov 2025 16:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T4mbXmad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 575D1838EC; Mon,  3 Nov 2025 16:24:43 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C34D838E5
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 16:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-29524abfba3so30900675ad.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 07:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1762183479; x=1762788279;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ed7sGU+y17dTGoH8yIokkpFc+sLfx7OM8CIm/QZ9kAM=;
 b=T4mbXmad8NYbhGqAMB8iWvMTsEziaB+fZ4fFMxhV7Vhr3v7rwYq6Rhmd8qT7z0CCdp
 c4xJyLaMYZuFJEaE6bUGGRINnMjWCRqJxvcEtPhgijJKvJU5lY1iTdl89z/oZa00XzNK
 rumAwfjvwUxDlYENpPsYaag/9KfRVgMO83HbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762183479; x=1762788279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ed7sGU+y17dTGoH8yIokkpFc+sLfx7OM8CIm/QZ9kAM=;
 b=JHKceJejxvX1F3Q468px2DofRJ/5sEgyouh8U4OSZIV19Bso5Zao51joJpYfgs2BBw
 ++u7vuW/P+MF0h9O5ExPDcegJkJwrhriyUQwTdVK3AG3FRFyLWV6u5G5LuoZQ6gfA0Uq
 qfRvL9gFVlCUWS1r88QOsmT7KoPhZRY6luWnhOC7iwzIAAYAbeGW8uVjnm4nmvTcDBBp
 noM5QUImKYjJmVn8tLz1GBn6ebwHL5QQ/MuC8lXcU6jbk6QB91ecaBaAlwf7nRAK84eQ
 BpBxFxVFmBWP/hxc4MSE/iBWoxL9gByyx29EJshk7w8RM9F2NPvGd1CwxyrjMbUrXIsk
 7FlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY7+feQH81g90AWExQXT2BQaIPpWwrjjuc3dOUOEzzXMDdX6UcvKW0NmGxiWuoaM5Zb1u0h9E=@lists.denx.de
X-Gm-Message-State: AOJu0YwD8vSIyi3PR+dbd4uNfZH1eeexxVthXC+B9KiKloFmB56KgkzP
 Yc8Zo2unzJ77uVWBlMH+Ww4Pn8SQILYCr71wFaazWp3RxzVwDXxReRa65+XyNqO/ctTbU1n68NW
 vFc/8PQ5PEgp6rc4Cku7YppmfCQEpYvL9M9EmWln38w==
X-Gm-Gg: ASbGnctIQ/jUhpf7XRn5KGsBYc3C4lucM2UqeItlNtnmWfq1JNf5ruh5Pzq+yF75AWb
 XOECWNiFRh61K8L8I5/JmYN0OTzQU8ZNacLuhkQPrEAM27GEKPKhoqSDAc8Bwkky75GNk94KsIZ
 sh4W17BMWXZqrCvL6P9F1hU2MJEh74YG2cL8+XywRs1HaCNQdsNy+SNGfjjbL9x05SU4Cs7k2qY
 uPZNlKoDwDFNyLXJwka7nDwEUrzs/NaPUjNlgwGlv4dt58VJACAw1Jqq1vtAYjDrEF6tjhvYSpa
 HSYbpyCb6uGa7wfm+9iWDrlpOyzxw0T/Y8czXUIwdTustMcEmE7WAdL2svG1
X-Google-Smtp-Source: AGHT+IHPSZV5EWIphVeIDBuR7gNaxFPOuyPBdCbB9boLvume5Y8sgAOHAF0Izs/0+OEM2JUpCXsN2qt67pR3kEXyRwc=
X-Received: by 2002:a17:902:ea0e:b0:24e:81d2:cfda with SMTP id
 d9443c01a7336-29519b9ef83mr161075125ad.0.1762183478957; Mon, 03 Nov 2025
 07:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20251011180636.GM298503@bill-the-cat>
 <ef6da754-8217-42ac-bde4-8752cbd3090d@iopsys.eu>
 <20251012190713.GB6113@bill-the-cat>
 <d0e51598-8786-4f4b-a62d-7c981bf186a2@iopsys.eu>
 <20251103151715.GM6688@bill-the-cat>
In-Reply-To: <20251103151715.GM6688@bill-the-cat>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 3 Nov 2025 16:24:27 +0100
X-Gm-Features: AWmQ_blWNytq3aWskx1P-zCO-PSDrP9uFOcvkiaZb-Rf7H3P4EIzuM3SxZFbmng
Message-ID: <CAOf5uwniF2C5txO=fqcKCZUbdZAm3b9Z2MkBamOpoyff-1p5Gw@mail.gmail.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

Hi Tom

On Mon, Nov 3, 2025 at 4:17=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Nov 01, 2025 at 09:32:35AM +0300, Mikhail Kshevetskiy wrote:
> p
> > Hello Tom,
> >
> > I just sent a fix for the issue in the my "coverity and 64-bit division
> > fixes" series.
> > If it's needed I can split the series and send patches separately.
>
> Thanks, that series looks fine to me.
>
> --

I will pick with other series

Michael

> Tom



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
