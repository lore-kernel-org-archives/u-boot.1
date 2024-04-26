Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EA5C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0011688398;
	Fri, 26 Apr 2024 17:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="ZWXJY9Wo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E39088398; Fri, 26 Apr 2024 17:14:15 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B47B48823A
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5723edf0ae5so2487069a12.0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1714144453; x=1714749253; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HdH/Lu8Y669YpjNT4JUJI1r4VmB5SF2Y4u6W3WS4qYs=;
 b=ZWXJY9Wo6YyrSmz8+eEcZ0BSR6tz1zCcHZMTzsRJaLD2AOUEyXvooa3I7aDTavmcBY
 O+FA2MLyYk401Jte6mT92gmKGVg05mAyQ4jcFOAir6HJoRwRVr4YnRJHoU39CFOmhi4+
 f/32WFOSANF73L00bj7U4WJWhJQhc2s+wGo404yxT8XPk9E5g1vNOewPHorlKhsR+M2v
 zeNft0Ut2WDEJwAb6O5JFR2ktlp/S4TeKmDPt8p1ciy0MTwlmP9O56u9KSrVgruBmdM/
 uTyv4s4FoFhASFvVts6DGs6B2dVmVFXsh2EIACddY2CUFH/dTRmv6OB+V4ukpHfEWmWu
 WvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714144453; x=1714749253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HdH/Lu8Y669YpjNT4JUJI1r4VmB5SF2Y4u6W3WS4qYs=;
 b=KE03u3IxkJkMSE1X1sscT8Ok6pUNFDFJa75jw0kXBNqBxnYCZchOkVupql/dLeXv8a
 C9FADbIL7by5cdoyQvMkuexo9iUtioyZ690x/g9iGaJM0wPVZavg7y52m/QqQvgwgVCn
 uQobK8s+rIXpfKlQSE216UcugxV6USLC6mYAC0zxJrEkvWrv/EojrKWA2Vb1BrYpDerR
 zQFDsK97tmCrXJxXWVEaG83zf/F0352+qpwi1UQ0oq5qVS3aoHYXOzoyb6goUHSXxYDl
 8la3aTp5yXbS+X/CXHyB/VNJ1g25vkHuHSlNf2wEoCVWmes+89rW0fNSlrL1LU/H8QBo
 npqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn/j6meMUOnye/JPsur9z2mf9INj4BHyd2iX38c25xkYQnz0R1XZNOgcPQ7jz0H5wy+8hJ1OhwEIxxUW8W5NlMnpBWaA==
X-Gm-Message-State: AOJu0YwJfkRNewlbLerFGASDha5JYxqz1yVJWDBlYKd431PKNRQXSS3E
 WAgIrQmZtnbvCJH5HlJRhjZyMAje+aAPUDYburmrwF3odctAQSfSR0b4ufkU+FPRCxaS5LAxEvR
 HiJ3SFSVYSagC6XcSAdTbKU05BergGGSZZ5dfcw==
X-Google-Smtp-Source: AGHT+IGGRLUM1RIpCrOpK9Pai8vmvjLumjRW7qTOoAKz7oaWajv87qnJg429OFXk4xvLgzADQN7kmpbuxw3P5DnNRwg=
X-Received: by 2002:a17:906:f145:b0:a58:deb8:8b2b with SMTP id
 gw5-20020a170906f14500b00a58deb88b2bmr34258ejb.56.1714144453235; Fri, 26 Apr
 2024 08:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240426001419.1210364-1-tharvey@gateworks.com>
 <254b0fd2-0085-4894-bcfa-686c456e4e2a@denx.de>
In-Reply-To: <254b0fd2-0085-4894-bcfa-686c456e4e2a@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 26 Apr 2024 08:14:01 -0700
Message-ID: <CAJ+vNU0fRLnZ-DvA8-ksKZAXWsgtFt_qa7Bcifb=3xLzZDu8WQ@mail.gmail.com>
Subject: Re: [PATCH] cmd: mmc: allow use of hardware parittion names for mmc
 partconf
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
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

On Thu, Apr 25, 2024 at 9:07=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 4/26/24 2:14 AM, Tim Harvey wrote:
> > eMMC devices have hardware partitions such as user, boot0, and boot1.
> > Allow these names to be displayed when reading the mmc PARTITION_CONFIG
> > field via 'mmc partconf'. Additionally allow a name to be specified whe=
n
> > setting the PARTITION_CONFIG.
> >
> > Before:
> > u-boot=3D> mmc partconf 2 1 1 0 && mmc partconf 2
> > EXT_CSD[179], PARTITION_CONFIG:
> > BOOT_ACK: 0x1
> > BOOT_PARTITION_ENABLE: 0x2
> > PARTITION_ACCESS: 0x0
> >
> > After:
> > u-boot=3D> mmc partconf 2 1 1 0 && mmc partconf 2
> > EXT_CSD[179], PARTITION_CONFIG:
> > BOOT_ACK: 0x1
> > BOOT_PARTITION_ENABLE: 0x1 (boot0)
> > PARTITION_ACCESS: 0x0
> > u-boot=3D> mmc partconf 2 1 boot1 0 && mmc partconf 2
> > EXT_CSD[179], PARTITION_CONFIG:
> > BOOT_ACK: 0x1
> > BOOT_PARTITION_ENABLE: 0x2 (boot1)
> > PARTITION_ACCESS: 0x0
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >   cmd/mmc.c | 25 ++++++++++++++++++++++---
> >   1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/cmd/mmc.c b/cmd/mmc.c
> > index 2d5430a53079..26692a8e349b 100644
> > --- a/cmd/mmc.c
> > +++ b/cmd/mmc.c
> > @@ -14,6 +14,18 @@
> >   #include <part.h>
> >   #include <sparse_format.h>
> >   #include <image-sparse.h>
> > +#include <linux/ctype.h>
> > +
> > +static const char *mmc_partnames[] =3D {
> > +     "user",
> > +     "boot0",
> > +     "boot1",
> > +     "",
>
> Shouldn't these be 'gp' partitions here ?
>

He Marek,

Do you mean that 3-6 should be named 'gp1', 'gp2' etc? I couldn't find
if those values were possible or have meaning.

Best Regards,

Tim
