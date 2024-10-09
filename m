Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77355CED628
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 08:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9926189156;
	Wed,  9 Oct 2024 10:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VV7JGHjL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C108916D; Wed,  9 Oct 2024 10:24:32 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E95C89079
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 10:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c924667851so245138a12.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 01:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728462269; x=1729067069;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hFuojnyHwTuK4ZGtKq+7LBYFTthesy7kQ44WIcNbpOM=;
 b=VV7JGHjLWhYT/FZSsTDl57V1D586rcrYXheAU36TmTgxJAPKlWkVPzHPeuHzGOm2+w
 9noK0jFWtOhoKcM5laPVRf+MJ4nNlhXgsMYr/EBZAAqr26JQUwXhmqKbsZRgNc1I7JY8
 QWa4GTNsYzVWzzCwfMjHIfG59sdO//29OU8cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728462269; x=1729067069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFuojnyHwTuK4ZGtKq+7LBYFTthesy7kQ44WIcNbpOM=;
 b=j2t5EFPs2a7ffWGgNsuKMWGryzNhQWDjMXh0SKYLcQDerEjyujE1OAaPW6zS8fRAGS
 SuNUA97+6bDrK2fbxFMyusXrWaI1okWO3Ym4akM30UfQfAkVwieRfJiUUHGJ02Svul9/
 GNEqfxt6h7AGCS9Vz7930QNsswcfCCa/G08ZHQMNRK7VTGONu2S+lVY2f3VqnVoh4SuW
 klAGnRs5Cn5GhzvF6Az4LcxrunqGtpOZH5OyVFd3gMyxP68IXRULXygb7ztwyvPg0M7u
 4aXnU2u3hGVKT8fPegw0UDiXtzgrldzRmxzwV2NvBupw4II9StNTvz3X9gImLTdoZ1xP
 OWHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH87GhCImiUqBSpV/Mg5anlFb5a8CCzxMQKkmz9+cFTXeczrV7eiODrUAu7FEnql/e5ZDPbSw=@lists.denx.de
X-Gm-Message-State: AOJu0YyZXt4YweebNJkoTh1F0cnJfOXlv6Cac0mMpedKTyL+tTMNRBWc
 DRNUyf1BU6OvbkQa+eMWHu+B26rHlzp0RRJVH3Ne/JDWNJpb31wZqBn0fKlFORGvXMdbdbe54Bf
 d76wSae8eavrOVyLuvzBvyAH7DMWUW5h1k3rgtg==
X-Google-Smtp-Source: AGHT+IHJUmrCPqa/RwtMGU3afHhoEglS4fPRVNUS6HhUtKHN+1wTcdaKYU9nn58h6aGX8NjIO3LANtp0Mn4C3Wseu00=
X-Received: by 2002:a05:6402:5247:b0:5c8:84a8:5185 with SMTP id
 4fb4d7f45d1cf-5c91d53e915mr1142971a12.6.1728462269444; Wed, 09 Oct 2024
 01:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+GyqeZvs8eoS5XphbC6JvdESRBWB3v8OaNzr7M5k7PEVP3Qew@mail.gmail.com>
In-Reply-To: <CA+GyqeZvs8eoS5XphbC6JvdESRBWB3v8OaNzr7M5k7PEVP3Qew@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 9 Oct 2024 10:24:17 +0200
Message-ID: <CAOf5uwn3MQ5XWCxOzW-MM1XwkTNM1W8_2H1w5kcbQUh3K8=grQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: nand: raw: atmel: Use ONFI ECC params if available
To: Zixun LI <admin@hifiphile.com>
Cc: Alexander Dahl <ada@thorsis.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi

On Wed, Oct 9, 2024 at 10:22=E2=80=AFAM Zixun LI <admin@hifiphile.com> wrot=
e:
>
> Hi, sorry to bother, it seems like the patch is not picked up yet ?
>
> Zixun

I will pick up today and prepare for next pull request

Michael

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
