Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6F6C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 17:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAE388840F;
	Fri, 21 Jun 2024 19:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DD26jO26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B1E88440; Fri, 21 Jun 2024 19:11:44 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7123C880FB
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 19:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3762abfe005so7533405ab.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718989901; x=1719594701; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WQLg3tVOSCeMsWzFi+tfUt6UeD8ZSYjDEJxcZvwY8Pg=;
 b=DD26jO26qDZqK7xIufrkBO9MWH+XgijUV5x9M52RkUCzSr6rsGFp+UPGqslvpLZ7PO
 h3b6dTiA0cUXdlavmohqE5ew6Nw342PfPDDlGtrCBuweoOWu/dJ543yJKvygewYD2j1Q
 EaPXZPPe09EOp7fxqEdankZF+6AgAR1zHVD3D5maXYYZs8rK7/ZRT59EDWFYGLj+EvIx
 5RLx7VfrOneLJnhDF9cqRwPeKiSup3z6GRlJqfAb+Hmp7wp/VF3Ez9EKKGB5STlRsBZF
 wMkfgUlvqxXwEVPJLQSc7Pffc2BljSXqfJ5wMN0O5GKCnVcgxCw8NmUObSsY9hq7Kik3
 GVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718989901; x=1719594701;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WQLg3tVOSCeMsWzFi+tfUt6UeD8ZSYjDEJxcZvwY8Pg=;
 b=m/khnRzcN+0xMu3gycmhzmHzbXiqVf6W6ChbWB/7XfKUV+N01saRc319Yn7Pb4Cf/l
 mlNx7XY4m9A87Ss0QjSDSzb55FerRgk60ck7Ffe3LUdBgyKkwPfkIcx+mtJCR1p/ucPK
 oj98t4OrEKyhi8YdoIT1hkshtPgWRY7880VS9sqtoY0hyp6O6ag93EHveIR2ZRveRSZI
 AwU0UNrReQ4yjVy9P+GoQzVDXd47CAT3HO8m6hyaDYJxcz0a6f8zkufXKyUd7R9fvycf
 jaePL6xm6l5+qcbpSoif8JJ1xxdXBvq+Av0Xu26F8aAeionJRIwRFoqPAcMUyLmC0n6M
 AQKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOeHO9AjoZIg4tS/NsurXoXoRimDntvjT/RSLeVb2P65AlJIvzM1gydD75d5eq+F7xT43XkFaAg42YvXxIN+9YTXDVvg==
X-Gm-Message-State: AOJu0Yw4bVTuIH9q86XLCsdfINk0sqI7MW4bA5sZ87Afv6Cy3xIW+VuF
 q0KUQ6eGOwdnE2k3j0DIZomyKKy4GrNNPnyEIs3MPzTFXIm8OLf2zikkO3mb1yl6O07Kr2dc7m5
 FSqYuD9xWRgT/Jwd+UbNNjATlQIZgr1ihkp9uDA==
X-Google-Smtp-Source: AGHT+IHAhOFuRKci6tQN96uth1+iU06NZgdiOW88SJGpg1Fo50UmBVQfxBqU4gCQZilZjgXHo/uXGHPAfkZw0qDHzaA=
X-Received: by 2002:a05:6602:168b:b0:7eb:815b:bead with SMTP id
 ca18e2360f4ac-7f13ee867b3mr938136039f.15.1718989901010; Fri, 21 Jun 2024
 10:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <ZnLk_pXstP2dlRGo@debian>
 <CAC_iWjL_rytosTAcsW2-3fmwVhjTgkMRAB0LwPuNpq73K=YmcQ@mail.gmail.com>
 <ZnVEALsxt2b9s-cI@debian> <b2f16a9c-e916-4fbc-9f9c-87b23c0277a5@gmx.de>
 <ZnWzJKEf1B0RLOyP@debian>
In-Reply-To: <ZnWzJKEf1B0RLOyP@debian>
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 21 Jun 2024 19:11:28 +0200
Message-ID: <CAC-n0DzafDJqP7LwzKJ4Gii48X1pQMZ9hXuG8SsnwoHpo_FWxg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, 21 Jun 2024, 19:06 Vincent Stehl=C3=A9, <vincent.stehle@arm.com> wr=
ote:

> On Fri, Jun 21, 2024 at 01:00:51PM +0200, Heinrich Schuchardt wrote:
> (..)
> > The current specification is in RFC 9562, 4.1, "Variant field"
> >
> > "The variant field consists of a variable number of the most significan=
t
> > bits of octet 8 of the UUID.
> >
> > ...
> >
> > Specifically for UUIDs in this document, bits 64 and 65 of the UUID
> > (bits 0 and 1 of octet 8) MUST be set to 1 and 0 as specified in row 2
> > of Table 1."
> >
> > This reference to byte 8 does not depend on endianness.
>
> Hi Heinrich,
>
> Agreed, variant is not concerned by the endianness.
>
> >
> > U-Boot's include/uuid.h has:
> >
> >     /* This is structure is in big-endian */
> >     struct uuid {
> >
> > The field time_hi_and_version needs to be stored in big-endian fashion.
>
> Thanks! I thought this structure was used to hold either a big-endian UUI=
D
> or a
> little-endian GUID, but now you have convinced me.
>
> This confirms that the generation of the dynamic GUID is missing somethin=
g:
>
>     gen_uuid_v5(&namespace,
>                 (struct uuid *)&fw_array[i].image_type_id,
>                 compatible, strlen(compatible),
>                 fw_array[i].fw_name, u16_strsize(fw_array[i].fw_name)
>                     - sizeof(uint16_t),
>                 NULL);
>
> It is not possible to cast the little-endian efi_guid_t .image_type_id as
> the
> big-endian struct uuid output of gen_uuid_v5() like this; we need to
> convert the
> three time fields from big to little endianness.
>

I'm inclined to disagree, the comment above struct uuid in include/uuid.h
state clearly that the format in memory is always big endian, but that a
GUID when printed has some fields converted to little endian.


> >
> >
> > tools/genguid uses UUID_STR_FORMAT_GUID which prints low-endian which i=
s
> > typical in the EFI context but not understood by 'uuid -d'. Maybe we
> > should add a parameter for the output format.
>
> My understanding is that there is a single universal string format for bo=
th
> UUIDs and GUIDs, which uuid -d understands, and which has no notion of
> endianness. (Only the structures in memory have an endianness.)
> This means we do not need an output format parameter.
>
> genguid is calling the new gen_uuid_v5() function, which outputs a
> big-endian
> struct uuid. Therefore, genguid should print it with 'STD format, not
> 'GUID.
>
> Best regards,
> Vincent.
>
> >
> > Best regards
> >
> > Heinrich
>
