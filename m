Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286AAC4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 12:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A7EF87A7F;
	Wed, 10 Jan 2024 13:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t6pN9RCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D838797B; Wed, 10 Jan 2024 13:40:50 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2801C87AB1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 13:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7cc0f5bcb4fso1046906241.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 04:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704890447; x=1705495247; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MiNP/CdCDMxbnqAs22umrAsFNDnrljBF/5SYQI5VfME=;
 b=t6pN9RCome0TtoVJU84rg604PxnQ0+EV18WicgO6zH7j11iSZV2ELvYG+nB6zQlAV4
 46g5XSY6D9uD2P4D065sFHU5TOLTtQRWE8TDPHG/2jWZXyJ7Pw9x8wzWZLvGAhamBRhE
 G6bURj7SU9jPZ/5DaVRtCDttMfI6CK7JdvbVGXtGPlrM0uWqQVi6gSe+8VOqxmZYvr+e
 VkrAmV4SuoW4xmfdnjLbGNJ1kUSPB0+xRbnHLfb4JnoEtra2I51+vSsJKE8MdvVaKVZG
 ovFPwT1EeDeRaojFFpi3sGf2LJxmh97EkXtKUh6GuI0PgTFlelbzYjLPm+rtlnFriQU3
 lzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704890447; x=1705495247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MiNP/CdCDMxbnqAs22umrAsFNDnrljBF/5SYQI5VfME=;
 b=NcxSoH1FxTGAR28CL9XG5NBnbeoSaff7rf1oTGbn3LQxccfMrWGJXHXKX3ghUvnFjj
 46jvoAqg/Yncvp7jSjaQK6QQXE4tB3PulYgiSGK3lfC0hNphPnCfEKA7renDZdK2/qIC
 oij7n+wLhe49DaNV9hzzMU3CM5JClclvW51oE96Nn5AD29GJDA9GHDaJ2W65jZNQ/jF+
 8L13dQlsujy1DlCRr9kgXH6zoiekeBF1W9OBiCyAFvx7Gn1Zb6J8XdLIvdjjk6NS2uV9
 3ywuEO+jUp+5E3JvxpHK53W3l59W2Co+k//OY98+3864n6+xjHqU8F9poaN+pk9czjP6
 UAHg==
X-Gm-Message-State: AOJu0YyYDVaEVbwemUmTo2GMsQceDEUKJjCH84g7ePf7ZT3pGqUVhT3Y
 O2wwn5pAN6OhL8dfjgKab/MBCoAgmdbDNrQWVTd6o/diGZmTJw==
X-Google-Smtp-Source: AGHT+IFl6KFsHuwHd/CdScW0T1KYhrmLggZw7TF7qpbc6F/4WvFZ4/bwntVfXP02bpo+mwCgb/pP4XJBkI8iJPikO64=
X-Received: by 2002:a05:6102:41ac:b0:467:b84:62a9 with SMTP id
 cd44-20020a05610241ac00b004670b8462a9mr910845vsb.32.1704890446895; Wed, 10
 Jan 2024 04:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <20240110103547.719757-8-sumit.garg@linaro.org>
 <CAOMZO5BLev2quLZcOABQ9zow2hRHO61e5NY2WKBpH-YJNvBV7Q@mail.gmail.com>
In-Reply-To: <CAOMZO5BLev2quLZcOABQ9zow2hRHO61e5NY2WKBpH-YJNvBV7Q@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 10 Jan 2024 18:10:35 +0530
Message-ID: <CAFA6WYMr8TPbNv8mxCoo+uZ2NngJ+3dm8dpT0qoZWRbe1qB2RA@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] doc: devicetree: Align documentation to use
 Kconfig options
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com, 
 mark.kettenis@xs4all.nl
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

On Wed, 10 Jan 2024 at 18:01, Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Jan 10, 2024 at 7:37=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
>
> >  History
> >  -------
> >
> > -U-Boot configuration was previous done using CONFIG options in the boa=
rd
> > +U-Boot configuration was previous done using Kconfig options in the bo=
ard
> >  config file. This eventually got out of hand with nearly 10,000 option=
s.
>
> It seems that the original text should be preserved here.

Ah, you are right. I can preserve that in the next spin if I receive
further feedback otherwise I hope Tom can fix it up while applying.

-Sumit
