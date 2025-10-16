Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9847DCCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 21:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB644836EE;
	Thu, 16 Oct 2025 23:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G/dmSYas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7AE983700; Thu, 16 Oct 2025 23:04:19 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50580836D1
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 23:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-36e4d00ebfdso452865fac.1
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760648656; x=1761253456; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dmyTYNyc7WVicGKy/ClDWWrqsUC/ho6ohI6w5LfRC5Y=;
 b=G/dmSYasPWQ+Q2tWNraXKy82ueSUtR1U23CdYdDdtido91XDIG+8u4myBMAMwQYBz8
 N8f6hAH7VyCPRtrD9mAdet41tDotU3Zo5Gj+130tEWO6JUfR+Zx9JpSXGeexo+PwGZJ+
 sTqULqwOTgoMeKIf92gWUnT93rn8aDnCfQhtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760648656; x=1761253456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmyTYNyc7WVicGKy/ClDWWrqsUC/ho6ohI6w5LfRC5Y=;
 b=Y38bDm3jQoRD3pYBJYr8jDQp5AagVfAgix1whlNM3iz33tjgm3nmrPtovxzyLTjhvl
 EYlrkcFUtEqnH4Yw3/q186+cTDm28UVvsSGKa0itCo21o8qYTr5tXYfI3DxK4hC3PKdS
 2TFUdHVq4lKiJ+oItiW0Ix0CctN2Nd1AFor/sQc7CHg+XCMEpQ7ieT3fDnrNcZmVK575
 W0IqoU1Vcjecr5ZEx9+ZuJTECc7irkPiDWgg2yPP0OOeT5Oe97C7t0b+Rgit7T5CHXaY
 CUEX8BJKgyRMSMZ7No80BB+SY5VIDUwdLFtCNkt+uWb7lnZMB05lUVJt+n9lBQrt1zaD
 DbVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf+3cWyEme8iPa1J82zzajmO4QcYDqF5Wm0OWS5/vvle307dWO0XlHxiDwLzjmgTxod09Cv7I=@lists.denx.de
X-Gm-Message-State: AOJu0YxPkc+VKDb5ZJIlv+D9hKRP4719gCHTYyUgikLKiA0ZtDj0cBgJ
 JXj36s2iS01GLrUniXCxnTi+3gFyx3B/QB0Gjdznu5i8uHVmoo8qymJ271nbJ/fsi5M=
X-Gm-Gg: ASbGnctxVs5q6NXjyTHPb5MiFpN0B5HYDO4H40HVn6P1lUk2ZI0HbNbXfnJXuJytWQz
 v3vkrg69nGS7LUyPFBBsVjF7lVXEBVEqxVCFUSo7Of8LT8suaej1S067KV9cN6ZzUReZCK08VMf
 J3wWUXIwRfLmQsJfFPGfBzUxPlXoO4oO9bABq/NXaNEEUGyF0h67DUAsHPlXVl2GPMQTNvsSUlG
 RTqF4y1TRxjKAE5ITujY4S5NxE4ipg3y6eitihgWa9341CbRV4fqbAfoXCTu2W0HqX+pOKzkegf
 NbbCz6badyuZpNa50ZULwMEm6iB27NrYW8hMwkEp4AOpYWft1OHMivVgUlg2L/2FeJcXtLHyTNM
 YNX59L2W/qCfL8A017F/ksRR/Qv5GrUpADQwoDAPluJ0ELg2efXUlhx1e5JKhNBpXzYhLAebzDA
 3fnesIBs8F/Zy/Lb5dQwcK+VTikNfgNylIuDAlazM=
X-Google-Smtp-Source: AGHT+IFwJfPXYIJx29T0URd2u28ETZE0dgMucRRLtAeiOsjcTtQ8r2ZJoDp6J6H/j6MrDG/lluqwuw==
X-Received: by 2002:a05:6871:7506:b0:365:3877:5ec4 with SMTP id
 586e51a60fabf-3c98d10defcmr582014fac.37.1760648655970; 
 Thu, 16 Oct 2025 14:04:15 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8682138sm6817800fac.0.2025.10.16.14.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 14:04:14 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:04:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Subject: Re: [resend PATCH v4] disk: dos: Add all options for EFI System
 Partitions
Message-ID: <20251016210412.GA250556@bill-the-cat>
References: <20251008150832.627727-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0R6N4CM8K+1oSw0n"
Content-Disposition: inline
In-Reply-To: <20251008150832.627727-1-pbrobinson@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--0R6N4CM8K+1oSw0n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 04:08:27PM +0100, Peter Robinson wrote:

> The EFI spec states that the ESP can be any of FAT12/16/32 but for
> compatibility doesn't necssarily require the partition to be the
> EFI partition table ID of 0xef. A number of arm devices will not
> find their firmware on a FAT partition with an ID of 0xef so also
> allow the original FAT12/16/32 partition IDs as they are also
> permissable for an ESP.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

So the CI failure is in EFI self test:
https://source.denx.de/u-boot/u-boot/-/jobs/1267541#L268
and I'm not sure where to dig in to that part.

--=20
Tom

--0R6N4CM8K+1oSw0n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPFdyQAKCRAr4qD1Cr/k
CrWqAQD7gUd9G4kN6Rnfz52Vgczjtzy7EBcA21K1nIKhtI1fBQEAunq6pI8UFz+L
72VXoP9V/EhsS23Xwfwj0sQmSRC9AAY=
=aE7Q
-----END PGP SIGNATURE-----

--0R6N4CM8K+1oSw0n--
