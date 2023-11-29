Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95691C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 00:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F0686E7E;
	Wed, 29 Nov 2023 01:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QHE/dBLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB516875FA; Wed, 29 Nov 2023 01:16:16 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC01E86D93
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 01:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cf876eab03so10764025ad.0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 16:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701216972; x=1701821772; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXCSjL2Cmg/dpMf/0odLxmhcsAH5kgluhtWId1hAzR8=;
 b=QHE/dBLot7IbgzrnhyEr0c1RACvXZZwti7EgFuRkxsghKgs8BHhydVZy9j3xNDasgL
 9t2WtTBmBnJr2uUA7QzxCijTE7srdYC+OvZOtXD/hTdGzjCo9fFd+9o2TTagg331Ip65
 njkLWCRaUTeg/S0vGis+wGr/cDmpH0/iz6DHx/yopiMjfHNdxymsds5tdqZPDRdkoxRu
 tCFDiQWJif6Az794NKrp5a45BA1ExALdzEYRH9Ye/MkJwio0V7vScCfqd9qrrJAT9cSs
 BMeqpxGMw91/jZ9HhQIEUIeZ//jjG1RyJ5i1HiFLK/n6ytENVG7rGaqZUVBIDCSxkZqq
 yIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701216972; x=1701821772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXCSjL2Cmg/dpMf/0odLxmhcsAH5kgluhtWId1hAzR8=;
 b=Z7pl1Ug0UF7sUHWbJLpm+cclmc7CXf6oiFdAHoKEbpsdJ+7uY0iRu6N5BgvpZtkE62
 XNzjEGR7NTCBuIf6a7a2U14ObQJoEiwG34hfIurB2wMA5ArfIqB3lavi8tu1HanQFjRc
 r4JYEz/8fCpyyx8BBX4FMTDBgyCcLugwQ/KiZ7YalejJU7JNEwtUMG/J+64XQK5StLg8
 9Vp2RA9z3NDnWBAsSluBM/FvXOj/k3fBr3CSvYSVPRj8Gek+PV8t5l3Nzx8E8fLBsCF7
 9SIz7aQYNAP472kEDzw9qqal/VXTEc12PfkuZ6LbVDYebjKGFhtNc3jR4D+zJ7Ct0Jch
 svqQ==
X-Gm-Message-State: AOJu0YxfiJ9nQZrsZgVMBo1DRg7uN0nRnGf6gXgDfNl7QF6EBxGXRmTF
 djKgTf9zrDHMV7/mPGrlnB9wVdWPLIDclptu4rY=
X-Google-Smtp-Source: AGHT+IHL0D/pRnFrRI+WBM7KdYSA6KtzOusqS1G8h6mPFXlAHdvotD1uTQ8oYjbc6h93KADNwD/NOThjcq/ZJmPrWMU=
X-Received: by 2002:a17:90b:2315:b0:283:9d45:a815 with SMTP id
 mt21-20020a17090b231500b002839d45a815mr17250197pjb.3.1701216972083; Tue, 28
 Nov 2023 16:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <CAJ+vNU3BRgqByLKGe0=D6omSb+p5zqwq2PCvOj0si7guZHsh+w@mail.gmail.com>
 <CAOMZO5Dj6RUB1ktE9Adp0UzwGev1Rub7KBPOVC=GOGb45feAbg@mail.gmail.com>
 <CAJ+vNU3Nun6WWGq-1+ZNUwsEkQXuE4NE+AUiU_ttr+Y+AbXDhA@mail.gmail.com>
In-Reply-To: <CAJ+vNU3Nun6WWGq-1+ZNUwsEkQXuE4NE+AUiU_ttr+Y+AbXDhA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 Nov 2023 21:16:01 -0300
Message-ID: <CAOMZO5ACEd9q4QPmdeSsKWdsN5Gu9smH-VAowpSRhBaxA3pT-g@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: Tim Harvey <tharvey@gateworks.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com, goldsimon@gmx.de
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

Hi Tim,

On Tue, Nov 28, 2023 at 9:10=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> Fabio,
>
> You won't see this build issue with the entire series applied... only
> with the patches up to and including 'net/lwip: integrate lwIP
> library'. My point was there are points in the series where
> compilation fails which is not ok.

You are right and I agree with your point.

I am able to reproduce the build failure at 'net/lwip: integrate lwIP libra=
ry':

In file included from net/lwip/lwip-external/src/core/init.c:38:
./net/lwip/lwip-external/src/include/lwip/opt.h:51:10: fatal error:
lwipopts.h: No such file or directory
   51 | #include "lwipopts.h"
      |          ^~~~~~~~~~~~

Thanks
