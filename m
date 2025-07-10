Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230D4C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 14:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A85835C9;
	Thu, 10 Jul 2025 16:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="lPNLwmWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11A0C8363C; Thu, 10 Jul 2025 16:40:44 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1795583429
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 16:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-60c3aafae23so4657728a12.1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1752158441; x=1752763241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QNf9RDjCMbtpEzjkJZdyLxY/4/FxHa2Fu1amPF/eGo=;
 b=lPNLwmWihidbh5qiBUtSqmIcCUwTIl668HI8KbX/frxroRN00LVMZWj8ylRr+kdvo5
 Ejygl+jNtqR7LVrl7Ylr+L+ViMTd6AfBRFPabqWKzA8T95sD+Aj3192xi1/wfc8CLOl4
 B7nK6C2khvg56/YBt1wED+moxqAHiU0iHGTa6ICD7Visj42pkOfYrCJoDooMsPpUkNKu
 bjk66H/m9tAtAQWN7gg/qQvA7p2ipwqXbpVlJa4s4rLo8Ks1OOEpQuzxt9M8bWpG/+xG
 Lk3Q1IfinVa1hxxD1tSJoZJAa830osa1U529GP0GsYpxkwLhdpiK9piJYc/VBKMr1t5Y
 A3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752158441; x=1752763241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1QNf9RDjCMbtpEzjkJZdyLxY/4/FxHa2Fu1amPF/eGo=;
 b=m+MVVdnVbzrwRJgGXXmw0pXwXw0bakNLzyT8BaA0CFk7HNqMyF5A017Qk5yw2OglHw
 J3T/dH/VGorwYLkhOnsIWjUfxelVujknYmSdiHCfkjhGhKT1FQs9FQq7R2t0p/1HYrZi
 iarAL5xb0cxlHeNL6fCgcyCqoVmmd6l6E+pScRO7fcH02tCbA50d7yRstEXeWDLI395l
 hV6FGqKZzUVzNyknIepR2eTCRYqXPRgCF5Nc+RMfMmG2DOYMFXZZZUQJDBWUhAhHZfSI
 POarGAmwDYgnIkHEAErRnRiqljUJcThGeG1RX9H+yYJHFif3gaoXSvYMRVuxL16c7Rwz
 inTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBe5gaM9fZcHP0AmMjC+Y3ym3DzlrQUCoyP/atWyTcSWE1SnuPXjNQR7zTqaYXqm1fhneZnho=@lists.denx.de
X-Gm-Message-State: AOJu0YwPDwqVOd4MVCm/l+sbn3iundJNJ76vB4yW72lz40NqPmrg918b
 chOj1LzbP3822gjkfhCxqe5GUJGtVNLWo7kR2gs6d1gP9yfrI8LyvKcz5Nh+jGlMKp0=
X-Gm-Gg: ASbGncv8ZM7Ya+wVRzl2UX0e7/+IeVZQRDjRcuMT8m9z6uOm2bqoXpd1pUaf3Clhz3a
 JsVD81BeW3sAaEoo0EeU/I1GddOtwDfY1dFSH/dzix/FkDT2Hdugm8GBM+k0jePA7Rqq7aW1C84
 oP2yf1Ous/7r7WfLcHRjYkMN/BrXOHod8hNYc38gpB894Ecfd5/FA85bT0bQ11kA8GbCPqLDwYo
 ep1vEgz0MWfpHZRalxO3pg4ZyYjdWxwwfCba47mKoWfOzdbR8gPErs0UJKbnzx8IPQz4tt1MUMI
 E92quhAhiVMhgmZdBN9pmcQFq1EYfpfoUIX0Sro9AGFrOfJ+Ot+RaYy/TaDr4gK93E8iVHOjbMB
 JIQYJmL4r/USI7Y7fa/2FBQ==
X-Google-Smtp-Source: AGHT+IFdmxtQn6v8VXZ0Zhtn4+dT9gUmRCyBTAn5EnS7qLuvSybmUgX20FdhWwf9JTRbfdTLeocVrg==
X-Received: by 2002:a17:907:6ea2:b0:ae3:a71b:1543 with SMTP id
 a640c23a62f3a-ae6e22d256emr411134866b.2.1752158441447; 
 Thu, 10 Jul 2025 07:40:41 -0700 (PDT)
Received: from somecomputer (ip128204144132.rev.hostingnetwork.at.
 [128.204.144.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e8294042sm141388866b.119.2025.07.10.07.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 07:40:41 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 upstream@sigma-star.at, u-boot@lists.denx.de, ddrokosov@salutedevices.com,
 sjg@chromium.org, tharvey@gateworks.com, ilias.apalodimas@linaro.org,
 kojima.masahisa@socionext.com, upstream+uboot@sigma-star.at
Subject: Re: [RFC, PATCH] fdt: Make sure there is no stale initrd left
Date: Thu, 10 Jul 2025 16:40:39 +0200
Message-ID: <18562990.Emhk5qWAgF@nailgun>
In-Reply-To: <CAPLW+4nz81kT=uTofbf86sqQnGZYB2d4A=mr5P3zT0kOstRKQA@mail.gmail.com>
References: <20250529150213.27149-1-richard@nod.at>
 <1752760284.mgMEAqHVhB@nailgun>
 <CAPLW+4nz81kT=uTofbf86sqQnGZYB2d4A=mr5P3zT0kOstRKQA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Mittwoch, 9. Juli 2025 19:05 Sam Protsenko wrote:
> > I think we need to distinguish two cases:
> > 1. The caller explicitly does not want to have an initramfs. e.g. you r=
un  "bootm addr1 - addr3".
>=20
> Yes, so fdt_delprop() lines should be probably moved to appropriate
> users, e.g. image_setup_linux(). Can you take care of this? I'm in the
> middle of something else right now and can't spend too much time on
> this. Or we can just revert this patch for now, to fix EFI apps
> breakage.

I'll try to allocate time for that.
Are we in a hurry? I'm fine with reverting but since the next release is mo=
nths
away and the change is only in next I'd first try to find a solution.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


