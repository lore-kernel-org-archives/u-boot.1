Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E85AC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 13:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4473876C1;
	Wed, 20 Dec 2023 14:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RHM0jkCv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC8B487721; Wed, 20 Dec 2023 13:21:20 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BACE187705
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=preventivaclinica@gmail.com
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-35fceb46c5fso287625ab.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 04:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703074877; x=1703679677; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zYY1Bt/5OQmtDFANY3F8IUHYP9dVwGPg12wEDdoAi5g=;
 b=RHM0jkCvRfN47c2PfzUx1jFZqi6EFs06O/StqI/aiZZIjBvAfu7G7wCInQGAl+81N8
 nViKilrzTKFbIUpupweSsoZgBXW3DAv1YS8JK7i/TR35lDCdoLhvy6RoVrGhPFbkdLtQ
 ya0A6A0WkDY7dmMQnnnANiXajqw5zQN9OQPmYfwuB6p7DdsablWgLFmVTkxXwKKP06wF
 WmQvk5IQb+kT+JhuN/qctcsScTjppAF+A+ph7IwfT+o9Y/1TRmNgKW1skxMfaxxSkS0N
 UP7hM2FCQrl8XeMMPQ7cd/2awHCTZmY4iSd91+RaL4ucSf2tXlWNsn88PQirbKZzKuVb
 ZM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703074877; x=1703679677;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zYY1Bt/5OQmtDFANY3F8IUHYP9dVwGPg12wEDdoAi5g=;
 b=fttBzfclm9ZHtfBNcb/BI4WMPnB8+4kosLTc7Ebm8mSk7llJhgtISo2TujJ3DvHx38
 16Ru/XdGSLLYBOjIe1pkwQg7LyvLxaMYH06DS2uUA9dZGlvgA2ocLD24WVEcndjFnIYl
 gDeFl5HhCATgPpaIuGN603I3K9WDcP87inXCboePeWtHjKcFaK2Y3Wu9gBeqlAscJTSm
 IYgb8ZFtPY6V+3Kteb/KKC8zlCEGA6D5zwp65XjCwpQIAvyrdKwu1UCR8Edr8JJGmDqy
 BAFEC9tjRLHLBYd+6+u4V5mDvx/rM9znwGRupzDIrMIGFBPGxlOr/k+KWNIKgyP92GY+
 8Dsw==
X-Gm-Message-State: AOJu0YzvYVe1aQkQkMcQBuKHODr38LOY+kMVm6+XOsSlxLAvvPl/IJ/4
 1S7FKWBck3r1Qvy7SxqxO8MLFpiDGXyrSr5Uh2SsV38ukFo=
X-Google-Smtp-Source: AGHT+IHaV43CTo/0bEP2a2NSkhQ5h3+WbVWjE6vlQY4ECmN2vLVmymn3wViBYteLi0bpo71p0g7jj1WuyYob8xYWjuw=
X-Received: by 2002:a05:6e02:1a48:b0:35a:e348:ab4d with SMTP id
 u8-20020a056e021a4800b0035ae348ab4dmr2112871ilv.6.1703074877300; Wed, 20 Dec
 2023 04:21:17 -0800 (PST)
MIME-Version: 1.0
References: <CAJik2ecgeu+zhzJK_bjJGi8_q2A81LpszO-ZJVDxvq5cynSGHQ@mail.gmail.com>
 <20231220-7038940eb70911fac7f0c5a1@thorsis.com>
In-Reply-To: <20231220-7038940eb70911fac7f0c5a1@thorsis.com>
From: Kledson Silva <preventivaclinica@gmail.com>
Date: Wed, 20 Dec 2023 09:21:06 -0300
Message-ID: <CAJik2ec=1t86=5r7fAuct0qeLC5dRfhP86ABFO4u4WNBg7Wk6Q@mail.gmail.com>
Subject: Re: Problem with CROSS_COMPILE
To: Kledson Silva <preventivaclinica@gmail.com>, u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 20 Dec 2023 14:08:03 +0100
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

Perfectly,

Thanks for your help!

Em qua., 20 de dez. de 2023 =C3=A0s 09:19, Alexander Dahl <ada@thorsis.com>
escreveu:

> Hei hei,
>
> Am Tue, Dec 19, 2023 at 11:03:12PM -0300 schrieb Kledson Silva:
> > Hi,
> > I need help, if possible with for compile and install VxWorks in my
> > Raspbery 4
> >
> > I follow the steps in page of WindRiver, but this step
> > (CROSS_COMPILE=3Daarch64-linux-gnu-
> > make), i have the problem below:
> >
> >
> > include/image.h:1397:12: fatal error: openssl/evp.h: No such file or
> > directory
> >  1397 | #  include <openssl/evp.h>
> >       |            ^~~~~~~~~~~~~~~
> > compilation terminated.
> > make[1]: *** [scripts/Makefile.host:112: tools/aisimage.o] Error 1
> > make: *** [Makefile:1858: tools] Error 2
> >
> > Please, any idea? its for a my project of university
>
> Your build host needs OpenSSL development library/headers installed.
> Depending on your Linux distribution this package might be named
> 'libssl-dev' or similar.
>
> Greets
> Alex
>
> >
> > Thank you very much!
> > Best regards
>
