Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6591EC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 12:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2FE2881EB;
	Thu,  2 May 2024 14:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GddpTKmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C348B882CD; Thu,  2 May 2024 14:49:35 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D69882BB
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 14:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a58c89bda70so803592466b.3
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 05:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1714654173; x=1715258973;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5rRiavS7z/c0O12eE5grqjuXIpJ+XlYw74NikKa/2s=;
 b=GddpTKmw5CQvMlDyKQZ1BrYPsAO9suqVIeh7yNDTUaPWocFzJwuh9acpqNWAnFaRB3
 +DZssx8tCLb7ffaQkWmgduA4qzm9MvBXVtedLzOK7Vv+NJqdw7qh1vywykgyECLb5we0
 1ygYb/mqucdLGctnhItzBFtJqt0gF7wW3DwMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714654173; x=1715258973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5rRiavS7z/c0O12eE5grqjuXIpJ+XlYw74NikKa/2s=;
 b=XMZlqv0sxsYnqSblC53hnVHR9E3+DiVeOB7zVgcuaMR1K15tEI8Ajw3W1sgIrtsow3
 znOAClqQPmm83IwLe7JREJ46702l+KzPYOu5v40EyxGRzQKCH9rLZPlJryNXkKsGmxdI
 Vobxtr62juW06WauylsHImme+SZIP3hQOzVBJ6S1k9wvBl5LeVv/8Lx2hjTNcE2+yvXO
 tRxET6QdTXrHA3tfv5LEauxXOPaOxZrAxIfGd4QBnBGju/M8JBvAVYPjj7CZfUNo0YDG
 2L3D/nDqEyE5DWhWQqttB8R/uDH8KO2UAakIgiqkfN1EtefFJkOiWRLkB0gxOktmnIXl
 wAYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWAywrGd/hAUEOji2Tu10lZwtwxvWwQ4xMfOALkFtUfKSRaAdp2+Auxpu37eeIhflDKe1ecfK/zNbbV5mlZLkQbAqDAg==
X-Gm-Message-State: AOJu0YzezSnUV3Gz4CX+KImQA188lTtlAXU4hMZYf7lvBiS572N8x7YJ
 RcVKJRXB1fDzI1FQA4MAWBfsFquSqT7SkPirQ4nJHx2L467iB50UDenGwgfxKVMBN4eenehbyJp
 fEmlBISvOnW2Kk7ROLjkTMrYfOR8MSbMPXb6cLw==
X-Google-Smtp-Source: AGHT+IFCEt4PNbGETl4h4/W4dwDcflxeZgSrXakoqlzMGqw961+sfdZe2Rk4xKrdIeTMBS42z5oaF11Erq22x5VAw/s=
X-Received: by 2002:a17:906:a205:b0:a55:554b:1f5d with SMTP id
 r5-20020a170906a20500b00a55554b1f5dmr3455619ejy.41.1714654173254; Thu, 02 May
 2024 05:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5BeK7QyqEZisSVX=fs9jmq98gjnf_n0FrRJrR92pThrGQ@mail.gmail.com>
 <b1733528-3c33-a52c-f239-dbe39c69d586@denx.de>
 <CAOMZO5De9dRiScGEv+TOHZexXQZjNs9JmgX+qCLNZeEaox5yYg@mail.gmail.com>
In-Reply-To: <CAOMZO5De9dRiScGEv+TOHZexXQZjNs9JmgX+qCLNZeEaox5yYg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 2 May 2024 14:49:20 +0200
Message-ID: <CAOf5uwnZaT+r=0Ag3Ccv_4EP+=Jufy6yn7b2CMPocmD5NHs0uw@mail.gmail.com>
Subject: Re: imx8mn: bootcount does not increment
To: Fabio Estevam <festevam@gmail.com>
Cc: hs@denx.de, Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Adam Ford <aford173@gmail.com>, U-Boot-Denx <u-boot@lists.denx.de>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
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

Hi Fabio

On Thu, May 2, 2024 at 2:45=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Hi Heiko,
>
> On Fri, Apr 26, 2024 at 12:40=E2=80=AFAM Heiko Schocher <hs@denx.de> wrot=
e:
>
> > No chance for a bootcounter in a register?
>
> Yes, this is a better approach. I changed it to:
>
> CONFIG_BOOTCOUNT_LIMIT=3Dy
> CONFIG_SYS_BOOTCOUNT_MAGIC=3D0xB0C40000
> CONFIG_SYS_BOOTCOUNT_ADDR=3D0x30370090
> CONFIG_SYS_BOOTCOUNT_SINGLEWORD=3Dy
>
> and now bootcount increments.
>

Maybe you have anyway a bug on the evk when was not incrementing on environ=
ment

Michael

> Thanks,
>
> Fabio Estevam



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
