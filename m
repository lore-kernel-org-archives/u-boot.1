Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60C4C001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 13:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3204B86784;
	Wed, 16 Aug 2023 15:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VnH+gksR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6B18638B; Wed, 16 Aug 2023 15:19:01 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9560486813
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 15:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso845988066b.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692191938; x=1692796738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wN9gQMUizqqaXi6qRRb3SjGkYKAyyuhEG56thM+j+v0=;
 b=VnH+gksRV5hTweiMJFdiCMTUxiNV9eDenguEVnIc2lJVYd8Rcjcu8EtrT1xDs1mGCM
 cDxaYl7hl6cBuLdbpykuTGEr1JrWGQPuccPSgVu4X54FO8XblPrwPQhSFgb+HnI5h2Yi
 ReKS7BDTgItZBnk1KfKvGB1kLVUhC8ia22kznXjaFJd5GNSf1js8pcxfXs0g8KmgnVVU
 6RihhLuX77VcMmtRoqjGumKH3jiMXGBwPAAQB2+zYVZJCLydzErx3exppzzyf3HvHjJe
 3bueh7C0dZv6mt9MqHQmT6x9SF+lBdX6R7FDmPiksov878NbUvyRwznM38oJ49hx5npI
 86xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692191938; x=1692796738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wN9gQMUizqqaXi6qRRb3SjGkYKAyyuhEG56thM+j+v0=;
 b=RrYzfBrPkDFDHLMrYBxdEzv5/aTZ8iqfbyWhMLAwMnCY3a3r5jS1qtY+TSwmWILRNE
 iXj7RwKfiwP0JbPvX8JA9AVGVAke1Kg1rVgDnbf2Mgc2pGz0DqoueJzApvx7xIQeGhxR
 NWqc7cxxkkm2og8hO093Eicj1jy8EC7+/JtwrHKsNO13BZ2m4VoBJsWJyj4UKHzgk4rc
 b7ct2dducN1YE0rTRIL4QgYZZYjd6mo7DMts7m4cvr6J+Z4B5DaVGlFgDoMFFtiiL5K+
 rWLS48wAaL/PbL3JTyYLhmFfg8GJeNa8XExLo+pTYgrH0sTius6IQ2/VicVfSqfRc8bL
 rTGw==
X-Gm-Message-State: AOJu0YwmxtC/bFKWxFsXMd3y02Vsi2djpfH7YmbDn4XOKD/iBoB6SDda
 DSr4EShvJDso0PFyv5fGeMQYHWo6dqlWzODmSj0=
X-Google-Smtp-Source: AGHT+IHmmA+VwbgHQ1P2Id6rZGYWokyn10ZDwCeF8oQRvRSaT8MEzVH1UDRyQ8zCGWkvuuU7yqm/MyOg0uUkuh2rj+Q=
X-Received: by 2002:a17:906:76c3:b0:99c:bcb1:3a66 with SMTP id
 q3-20020a17090676c300b0099cbcb13a66mr1570596ejn.70.1692191937917; Wed, 16 Aug
 2023 06:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230504134255.8510-1-thomas.mittelstaedt@de.bosch.com>
 <20230504134255.8510-4-thomas.mittelstaedt@de.bosch.com>
 <CAPnjgZ35Wh9dQ6cGi-ymbwDNa5oe2V52Tj1oTtn0_uwv3km-4g@mail.gmail.com>
 <CAPnjgZ1m+VCkxq6z=4DDuW=OxNruKHbjiEDxrj-N9x3yNuVaBA@mail.gmail.com>
 <CAEUhbmXbCYX6J0BivnEGruLKqC8VAJ3HKJLOsirFPFCC_KBR-w@mail.gmail.com>
 <CAEUhbmVQ_X4Gp3rDQWYquDcp_w3zzK3Ggwf7=TUBX7kZ21S0nQ@mail.gmail.com>
 <AM6PR10MB28231A30F0C4CCBBCE4DF5E3D315A@AM6PR10MB2823.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM6PR10MB28231A30F0C4CCBBCE4DF5E3D315A@AM6PR10MB2823.EURPRD10.PROD.OUTLOOK.COM>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 16 Aug 2023 21:18:46 +0800
Message-ID: <CAEUhbmWb+oZHzwDxQPeJ6ZtrtegBL+4zWETs4h6z+gUJht6pDw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] X86: pxeboot: bugfix: Set variable for size of
 initrd
To: "Mittelstaedt Thomas (XC-CT/EBV3)" <Thomas.Mittelstaedt@de.bosch.com>
Cc: Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Niel Armstrong <neil.armstrong@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Manuel Traut <manuel.traut@mt.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Mittelstaedt,

On Wed, Aug 16, 2023 at 9:06=E2=80=AFPM Mittelstaedt Thomas (XC-CT/EBV3)
<Thomas.Mittelstaedt@de.bosch.com> wrote:
>
> Hi Bin,
>
> I have never done this. Can you give me some hints:
>
> - Base version of U-boot
> - Path and filename for "efi-payload doc"
> - Some info about format of doc file and /or example to have a look for
>

It's doc/develop/uefi/u-boot_on_efi.rst of the u-boot/master.

The format is reST. You can add something in the example section.

Regards,
Bin
