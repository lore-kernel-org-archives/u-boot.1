Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73355F94CB7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C69B840D8;
	Wed, 22 Apr 2026 03:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YYtgtIyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B644805D7; Wed, 22 Apr 2026 03:17:09 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A854A84312
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ba388bc0a9dso862394366b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776820624; cv=none;
 d=google.com; s=arc-20240605;
 b=kLz3bWCkXTrg9xl4GfHDbNDmQizukS3g2fDfA0TNTlYuV/XYdbDl3NbCmDc/jbdil8
 upS4eO+w4lL7WS6q2fVYEQGg/Y4Okc+Cp/ZntRSXr/cmaeVP04LabSZrCUl/Vl+DnVJs
 MNWUpB+9pshzjsZkE3oS0IURkQ+h8hUnJdFyEY8/aQ9jnsWTeQtCrXN76phz1tAKybpr
 qIW0CFCUQsQaVa+x7t1o+l0xGwvUqS8VGi7ZsnhFrrfHRfjTBdG8pp8hOKLIkhzSWMaj
 u0045LudFP7s9SdwYwYYTO/fN24vJOHNwcYbq9NKlhkvwt5nPI/nCqd7E0PdoT7LgLNj
 6Kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uzvkiFFOl98qIwjWWNWQ4AFWk7eq5R7ZMEYP4rzUIrY=;
 fh=Fu1380ZE8Ji25f1ktfNTB2sI0wDqXl9uRwbpc4nX6rQ=;
 b=X9Kmxq4DsEgRa8RhyPGlLE6gLNZiFyNi+C16ta1TiKMMiGOdI0xWqyHANybiuVCE/W
 OYLlZdL3JVYwIDrFfqUO3EOQ/kmRGupAKqX+9lQUBXCQ9Tp0NJ+RswyrJg7eMRASeIwe
 jzREp3whUj9WVq1rYpYvWJfEUHsie2zK4SmM1Hnkwj7GWGOBXCxfeqn4cNBRmpvTpk99
 CRR2TGCxC8Qh7jxDu/iZ0Md+hCJQ8K5xmQrdj/N9yg+6PPu/60JeTCRFtZUDhbxMekVz
 M+2mlckNEcpnKui8Nccdv3elzpvPAAHWTekzB9ACNoXseHLjFiojfYI7sd0rL9eEfpzw
 5iNg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776820624; x=1777425424; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uzvkiFFOl98qIwjWWNWQ4AFWk7eq5R7ZMEYP4rzUIrY=;
 b=YYtgtIyLX0+d4dG6KQjuO+31eiUS5ZxE4G90bAA5ZeVcfO94KWTdYHvTyPIPW15C4+
 ua2CjJussx8I9lOyKg4tlvzcKhchrHsDwPLsjoxdXT+EBdpK2aRz+muqCprDUErSha7/
 7SGPJfROAQv7/TfOIS4KSVYIZywRctqqgtMSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776820624; x=1777425424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzvkiFFOl98qIwjWWNWQ4AFWk7eq5R7ZMEYP4rzUIrY=;
 b=MZ5k85b9/BmENq8mGBlmbtI/6v4P4W0r4t5ZHtgEoPM7kp6CmrUkUdqKOb+3X0sZw0
 bWpAXiAf0yF4p08jfVUSt50IfAa/6vw9UG9DV6UZRSGeuDtqa9E9ax0/WGgRnXERHJHj
 CGMeZGNo42T3PnbhqE2G9A9siKYl7pjgQ2riR7Qdalbqf4pGwQz2QJ2lWhZ3SGkaXo0z
 BglmyPPK5BoXTUBQLAWYeMiE15qmANgx5Co6aWhcz3miHfxkAfe5ZS9D/NoljptaHVgx
 JnFqC+FFqNGqM0LH6Ga2gxXKPBr6abvJbNSSkSrhnBQ1oL4NSu1TcdEmF12VIViQGqxe
 ratQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EOdfCq0R3US3zcvIfDNcUa52kWMYiBuVjNtTQ9iISude0fMkWRhvDK17klECum+LBCYx2mR4=@lists.denx.de
X-Gm-Message-State: AOJu0YyQyh5i/DBGWag1KneAgplco4NF0neL1pEcDC8xyFSfAhT2BEAs
 CJXgQSZYUfeLqcBdsIlXwdjITJHPD/5zG8a3ppOb0qPoie+gO1mciUlC5Ce78lDgl/anTGa3Hvb
 9iuLFzmSuFPDFEN82w6v3YVLCEL51xTtyWPXwocKF
X-Gm-Gg: AeBDies9V1Y+9ZG7Vd9/+pJ4VTSmRObnW90aHCCFCvbB/5pbEt7NdrEY7o0O/cosYeD
 CJa6yYsX6qWvGSvGqFLjV7mlOpFgnAehUON1HnMZYuThJyHqmw0HTivA8zFP8zmG5sR8/wKUiGo
 ULW1vZf7n3Xe3688NRo+WquJ2qLAZB/jq4eEwqYkEZlMljSiSklzG68Y9aFJsE3XBDUaTSR0b2D
 nIwdGLZ/7tOikViwFrFcwP65L5vzUlRqhWXBWo0dHKeY880dTknebP5b7fF7jPyV1wQfzUsSfdK
 Pd0Ju9yXkhefCd1kx08W
X-Received: by 2002:a17:907:8707:b0:b9c:69df:4d8e with SMTP id
 a640c23a62f3a-ba41aa160d8mr679284266b.25.1776820624061; Tue, 21 Apr 2026
 18:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260421053511.84312-1-S4210155@student.rmit.edu.au>
 <87a4uwn3ed.fsf@prevas.dk>
In-Reply-To: <87a4uwn3ed.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 13:16:13 +1200
X-Gm-Features: AQROBzA2-vx_z17JDb4FGnkyaFM_1vGNjDZm0ubcuWukzkOjootpT0qXfBY28xI
Message-ID: <CAFLszTjjpuvPMXZ1LeDf4JEz+mRW655jWd0tya=asDX373qC+A@mail.gmail.com>
Subject: Re: [PATCH] common: cli_hush: fix console_buffer overflow on boot
 retry
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Ngo Luong Thanh Tra <ngotra27101996@gmail.com>, u-boot@lists.denx.de, 
 Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Tue, 21 Apr 2026 at 20:06, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Tue, Apr 21 2026, Ngo Luong Thanh Tra <ngotra27101996@gmail.com> wrote:
>
> > Add const_strcpy() macro to linux/build_bug.h that enforces at
> > compile time that the destination is a writable char array (not char *
> > or const char *), the source is a string literal, and the source fits
> > in the destination including the NUL terminator.
> >
> > Fix the console_buffer extern declaration in console.h to include the
> > array size so sizeof(console_buffer) is valid at call sites.
> >
> > Replace unbounded strcpy() in cli_hush.c with const_strcpy().
> >
> > Fixes: 657e19f8f2dd ("cli_hush: support running bootcmd on boot retry")
> >
> > Changes in v4:
> > - Rebased on top of current master (as requested by Tom Rini)
> >
> > Changes in v3:
> > - Reject const char * destinations in const_strcpy() (Simon Glass)
> >
> > Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
> > ---
>
>
> Hi Ngo
>
> Please address the feedback I gave in
> https://lore.kernel.org/u-boot/87zf3co6pz.fsf@prevas.dk/.
>
> Also, two things on creating patches:
>
> When you create a new version of a patch (or patch series), please use
> "git format-patch -vX" where X is the version number. For the next one
> that would be "-v5". Then git will use the subject prefix "[PATCH v5]"
> instead of merely "[PATCH]", making it easier to distinguish the
> different ones in one's inbox or on lore.kernel.org/u-boot.
>
> Second, the informative "Changes in vX:" stuff should go below the ---,
> as it is not part of the commit message and should not be part of the
> permanent git history once the patch is accepted.

You can also use patman which lets you add a 'Series-version: 5' line
in the commit and handles putting the change log in the right place.

Regards,
Simon
