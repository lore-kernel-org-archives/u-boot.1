Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FF3D6DDEC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 08:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD08889DA;
	Fri, 15 Nov 2024 09:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="t77pxAsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C688885F4; Fri, 15 Nov 2024 09:35:11 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F075988C85
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 09:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 253C43F2BC
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 08:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731659708;
 bh=Eju0quAA/W/3ITifqo8O6rLo9aY55/vG9/muPYCUbcM=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=t77pxAsCq8K7H9RtGEugyz4r/C+shShS+LThbCd3aam9vrx7TSN/rUtGk7lyS/C9b
 NF7c8CsORfEyIh/ATJb5oCfhtbAAcMp5vpMUZujV+8W0dzgkR8ubgRIulk48D2yc33
 Hojq4jR4U5gdMhZtNet0bYc+4db3Q/fc5fg9c7u5CwbkGjTDQ8dV49OjR2U5pQPsxx
 nl4yg978f0XVijF8H/MUUYk18A+MpFnfQ0KSh7r9Mfc0yqYtz6T4xUmGFbotdfpKK1
 NV3lpIeT+SHvN4I6u9cbhaq1uNXiI4Mgsn+3TZVIBATzMCHgerl4/yaV260qnRpw+4
 ro5Y8Mv5pE7fQ==
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-71e69e06994so1882482b3a.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 00:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731659706; x=1732264506;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eju0quAA/W/3ITifqo8O6rLo9aY55/vG9/muPYCUbcM=;
 b=CzYnUNaP2Ul4LNLeRRSuQTI5Jwxwrp1li5bDcJ8+O5usKPS0UcVN3ea0sERC8ySveO
 +S7M4ngqYuO9auBQyLOqMVRbZzevyhO7xS04jbH0BS5OKc2jpImPQYnHk7yV9sFR/yYj
 ej4YAZ8qHDAZDHrZCNx17gWELafgrkUcSDoEHxI5JZadYlnevgb7tCcBCmWbUOJroESl
 axf6AoPvx8QtE8UAwbFBrdI/PDnpp6PtCGEhlO1p3429FCRuBcfTUuFEc0B1fNcZZEPe
 Dg05/iFu72dS/TFoDzE2gaeA/ZWOrZlsBWdPlFRrewns02jx5s9vGNLR0o3ORML3VvcU
 5p/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlSmaHEmfDLJG7lwG6JoJndumZeP2u6GU6DjR7/e236aXxy6fNbQ0EVJud4OtTli0O07P44c4=@lists.denx.de
X-Gm-Message-State: AOJu0YykF7cR8YPUk1pqnTxDG79kd5UZTL8bYvdx0erairuGTTds7w3G
 /DzRw5Mpe7a+klaNctFyvU+Pqp4X6IHIR4cAx9cRJgpphkRrFlvJOtFltBS+YpFVAlEMY2OmFpt
 d731jdb2heXp6CpwVHATkd9nTcl6+SOzIRpav2BU1GPcpfJ072g8mhAOJ+SJFSypcVOnfZ2zJYj
 Mhc+XdOtaWIjApcK2PQ9JrmUj2fbcMM0bIeLI4lfqS0cUu0DL4WLoY
X-Received: by 2002:a17:90b:1e0d:b0:2e9:5004:2502 with SMTP id
 98e67ed59e1d1-2ea154f7469mr2217816a91.13.1731659706484; 
 Fri, 15 Nov 2024 00:35:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgqZDP2IfAqi8Y2u9Y+twcWviC0Z7nrVvXUemYIn5BMu8x8/lpMKgH0refblwNWCFENdyUXBTABSQx0wq6Utw=
X-Received: by 2002:a17:90b:1e0d:b0:2e9:5004:2502 with SMTP id
 98e67ed59e1d1-2ea154f7469mr2217789a91.13.1731659705877; Fri, 15 Nov 2024
 00:35:05 -0800 (PST)
MIME-Version: 1.0
References: <20241102163259.305802-1-heinrich.schuchardt@canonical.com>
 <20241114172654.GA4059396@bill-the-cat>
 <CAM=mAOmFn0tytht3oK1F59=-nGxuLJmtSr2HpJDyTf=LWKYQOg@mail.gmail.com>
 <20241114173927.GJ3600562@bill-the-cat>
 <87plmx1h4r.fsf@bloch.sibelius.xs4all.nl>
 <87ttc9m0cm.fsf@prevas.dk>
In-Reply-To: <87ttc9m0cm.fsf@prevas.dk>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Fri, 15 Nov 2024 09:34:54 +0100
Message-ID: <CAM=mAOkaHf-TZ1Xw0W6kcYV7G+9wCJk14svaiCtdt6V1KpVQ4A@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: use cryptographically safe RNG
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>, 
 hugo.cornelis@essensium.com, Simon Glass <sjg@chromium.org>,
 paulerwan.rio@gmail.com, al.kochet@gmail.com, ada@thorsis.com, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Rasmus Villemoes <ravi@prevas.dk> schrieb am Fr., 15. Nov. 2024, 08:18:

> On Fri, Nov 15 2024, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> >> Date: Thu, 14 Nov 2024 11:39:27 -0600
> >> From: Tom Rini <trini@konsulko.com>
> >>
> >> On Thu, Nov 14, 2024 at 06:35:44PM +0100, Heinrich Schuchardt wrote:
> >> > Tom Rini <trini@konsulko.com> schrieb am Do., 14. Nov. 2024, 18:27:
> >> >
> >> > > On Sat, Nov 02, 2024 at 05:32:59PM +0100, Heinrich Schuchardt wrote:
> >> > >
> >> > > > The PRNG implementing the random() function only has 2^31 states
> and
> >> > > > therefore is unsafe to use for cryptography. Use arc4random()
> instead.
> >> > > >
> >> > > > Fixes: cc34f04efd63 ("tools: image-host.c: use random instead of
> rand")
> >> > > > Addresses-Coverity-ID: 312953 Calling risky function
> >> > > > Signed-off-by: Heinrich Schuchardt <
> heinrich.schuchardt@canonical.com>
> >> > > > ---
> >> > > >  tools/image-host.c | 35 +++--------------------------------
> >> > > >  1 file changed, 3 insertions(+), 32 deletions(-)
> >> > >
> >> > > Now I get:
> >> > > /home/uboot/u-boot/u-boot/tools/image-host.c: In function
> >> > > 'fit_image_setup_cipher':
> >> > > /home/uboot/u-boot/u-boot/tools/image-host.c:439:17: warning:
> implicit
> >> > > declaration of function 'arc4random_buf'
> [-Wimplicit-function-declaration]
> >> > >   439 |                 arc4random_buf((void *)info->iv,
> >> > > info->cipher->iv_len);
> >> > >       |                 ^~~~~~~~~~~~~~
> >> > > /usr/bin/ld: tools/image-host.o: in function
> `fit_image_cipher_data':
> >> > > image-host.c:(.text+0xb41): undefined reference to `arc4random_buf'
> >> > > collect2: error: ld returned 1 exit status
> >> > > make[3]: *** [scripts/Makefile.host:104: tools/dumpimage] Error 1
> >> > >
> >> > > in the docker container. I gather this means arc4random_buf is not
> as
> >> > > widely available as assumed.
> >> > >
> >> >
> >> > glibc 2.36 is required published 2022-08. Ubuntu Jammy is 22.04.
> >>
> >> Yeah, that's likely (a) too new and (b) strange because:
> >> https://source.denx.de/u-boot/u-boot/-/jobs/945810 and so is jammy
> >> 22.04.
> >
> > Linking against libbsd might be an alternative on older systems.
>
> Or use getrandom(), which according to the man page has been exposed via
> glibc since glibc 2.25. Or just read from /dev/urandom which should work
> everywhere.
>
> Rasmus
>


/dev/urandom is not available in containers.
getrandom is not available in OpenBSD.

Best regards
