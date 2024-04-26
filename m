Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D56C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BC628824B;
	Fri, 26 Apr 2024 17:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Ue/ZV0kW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A01598824B; Fri, 26 Apr 2024 17:11:33 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC748823A
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a58989cd1f8so295849166b.1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1714144289; x=1714749089; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXMfavX9m4g9ssAPkexjmq5TAzzHYVkjDyhPi3odo50=;
 b=Ue/ZV0kWxkVsT5dB++kXzvlJL9dn4HiHMf8sC/dk8ZQIwZA+tCgQm5XAGTd7duFx6u
 oITZhnI+Fy1ejDPbtzzYxtYD3n1ebKVIwD3Cf5TJ4mjabXPVqLTCDmHv5HaQZf29GqsL
 anERXWDHVpUKulmabnu06FEDR6l3rfyrisgXtHfzQGkE+C6HicPvGClANBRRj4INmlys
 GJ/kbqwwVuILwYaNE8WLFZGmilUXDlf9MCQN3GzP1qfMsXWVllrrsunT7mjTszCGH7O3
 JliTLpUFHS6gLXyGWyRubIMy5+/minOi+LBhthwq8bak4kTLB5+GR5ZAzXVeowTCiGE2
 RxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714144289; x=1714749089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXMfavX9m4g9ssAPkexjmq5TAzzHYVkjDyhPi3odo50=;
 b=KGEgArHT0QnlReamEPfnI5liiQfEfraild7AlzpxtthWhk95EdCWGDvVq2T6f7RKML
 nlgNDqGZOau9JduedxrXSPE/uiYrGgMTQzCtwsLcDftczbFkduxezRdI6Hxx4DBxtxR5
 DH5vjlWQcUxymvUz/s1+yAZbNs3u455ChjNE9KnSOemaXXZ5b87TMrQImKLRpI0nPHQ4
 925ZscLDfqAZXaRffjTbngx+GH0xAD4sTR55z5fXp3PBQ1pi/OuCCylKYwIaOSkFjmMU
 3jGTMeQYT6EQUji1qNdqBV318iZY8ZqnHHUwdQiNN/sDUFpW34NHYo5bVimJK4oxvkfD
 KMOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWndUDiskFfybdmMF8dUoKqdv/61qQmR5t8U9IZiBcWitWr8II0vY8GjYi1Jy2qa08VuSjMrgrealLJXyLTmelytFzQHg==
X-Gm-Message-State: AOJu0YzcznRirOhM0m1YFUrntvZY4ZNbTr3cVql6JfA7ZBONG8eE0aht
 NkdZp00enjvQerIa4r3AN4QBi6vMWqh31QDQL5EdYWNmzwnAkwqmXp04J2T/gZm/oOaLvO4o3fh
 YWU2QgoS1fO2U5Kj9CMTUypjt55R11C8HY/1yUg==
X-Google-Smtp-Source: AGHT+IGLXh14+jQTPWPazHUU9v8M3d1M8fcn7C+TyfLGyFrOkr/8jJEsbBbpbTsK8L8qSi2UeCT7MS9Y1QjRUpf2LNA=
X-Received: by 2002:a17:906:7d0:b0:a55:a8a6:aac6 with SMTP id
 m16-20020a17090607d000b00a55a8a6aac6mr2089437ejc.54.1714144289179; Fri, 26
 Apr 2024 08:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240426001419.1210364-1-tharvey@gateworks.com>
 <CAOMZO5DYtWRxmBH9n5W362ajx8VRxmwwD7xEJ7hv-kAFbrKkMA@mail.gmail.com>
 <CAOMZO5D512G07JUX9=ZDxFJciD40v678o-2_mo_awn+-u4=Mow@mail.gmail.com>
In-Reply-To: <CAOMZO5D512G07JUX9=ZDxFJciD40v678o-2_mo_awn+-u4=Mow@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 26 Apr 2024 08:11:17 -0700
Message-ID: <CAJ+vNU29zVMM+8sk3DHL=6XjhqJa+UhPwtTdU-Fkof43p=4=Eg@mail.gmail.com>
Subject: Re: [PATCH] cmd: mmc: allow use of hardware parittion names for mmc
 partconf
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
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

On Thu, Apr 25, 2024 at 6:37=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Thu, Apr 25, 2024 at 10:35=E2=80=AFPM Fabio Estevam <festevam@gmail.co=
m> wrote:
>
> > This is a nice improvement:
> >
> > Reviewed-by: Fabio Estevam <festevam@gmail.com>
>
> There is a typo in the Subject: "partition"

Hi Fabio,

Thanks - I will fix this in v2.

Best Regards,

Tim
