Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C720EC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 21:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EDF288918;
	Thu, 13 Jun 2024 23:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jC6BbiHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F7048890A; Thu, 13 Jun 2024 23:51:53 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 367BA8894E
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 23:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-797f1287aa3so92938785a.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 14:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718315510; x=1718920310; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLzlIB4R0FSYj7LfkN2GaPISbdVCVKqZA9cD89PCE90=;
 b=jC6BbiHfLkJKCCpxil9Z9Iu2uB04CAEqhD2iwup02LO0ZNx43Q1LFUINqLUyOfUwbn
 d9Kz7QYoOlgEreKelINmzFWs9UAxDnO0r3C8mnMhD/eX9cXR6L/0x4adZwTkU+Z4e8eu
 AiApqrJXcZW4dZ2wgVPzO595G070WB0NsHSP3R1+mOCglz9WiD4BZRTuSXKdlg9TNfXI
 rsGintgVwuloLiX54I2+XgeRP96U8mggUd5fhGQm5S1U8Jl/vstyyQgCvQyGacd+SWPx
 IuvaOD93NZx5bswL9RTKAv5GxTQFxyDLJ9A9GLr7fjLgsDbd5dg4I2Xd4FONfwgR5aUn
 KkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718315510; x=1718920310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLzlIB4R0FSYj7LfkN2GaPISbdVCVKqZA9cD89PCE90=;
 b=g/higaEuFJ8Jm2+yawVw5hMu5mBEQx7K3WJBDCGhusq6piKlHPkfBnPtcngqNDVoon
 7m8DbtsDWoIcsf2fv2rDoQ5m9tFRWjN+rv9ODJNqcjODofF8kaAF8y82WnXKU+1r2jJ7
 EyBrcFLYFrb8xO8BpXbGXzkpe1+wdKMcQ5Jkf7Wl2i5mMECDZvk87OFIqGDdlUHaKt87
 EfNzBtiEQyQXUQjXBYHfT5F/UVwtxDLQ29Hlo5eWx/mHVVkQVf/nLAI8QOB35jCwrPlq
 qW+N7RKIuRKZ0THGXXYLzUo3z6ZChF08ZXVgbs+dRy5OQWui3LP7TstlACqlTqlMzOnf
 KwkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrPclc1riWlK18fHAMSCioKoWMHDKiuQxoWydWM6iAjAOeHmA0z+yzqfbkoZJsBwt4SRkLr3FaB5JW3V92ijYoTRLlkQ==
X-Gm-Message-State: AOJu0YwngcDRN06SifevyCCWwkPuxpr26VORPnfRHxzGcA5A0P3lP94t
 PAKeB+zzbrYmEKsUJs05WeA5TUrdmMUhRPqlw01chPXCTzbUY9OVNbm9zeEejtavZSzajdInnpQ
 VLZRvniL2XLj3Y1sPrFMUatfxuT4=
X-Google-Smtp-Source: AGHT+IECTTtJap3P3pdRpd9+mdUgk4gFAkNYIhNgqm1tySCwljurN5+QBhQWLV8+EZh2wVfVO7qGBSqfxu6s1TZV+no=
X-Received: by 2002:a05:6214:1652:b0:6b2:b13c:5b12 with SMTP id
 6a1803df08f44-6b2b13c5e15mr5145876d6.61.1718315509949; Thu, 13 Jun 2024
 14:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240613080604.3828083-1-d-gole@ti.com>
 <CAOCHtYjAFE0sbyYRXnbsv9EohNfH99vsuVYiZbi2Ami_xdoxWw@mail.gmail.com>
In-Reply-To: <CAOCHtYjAFE0sbyYRXnbsv9EohNfH99vsuVYiZbi2Ami_xdoxWw@mail.gmail.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Thu, 13 Jun 2024 16:51:24 -0500
Message-ID: <CAOCHtYi7vjHeCcUzgDBkayGx9W3gR6MT==8ASf+7524pu21Vbw@mail.gmail.com>
Subject: Re: [PATCH] board: beagleplay: Fix the bootpart to pick from root
 partition
To: Dhruva Gole <d-gole@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Vibhore Vardhan <vibhore@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nishant Menon <nm@ti.com>, c-shilwant@ti.com, 
 m-chawdhry@ti.com, vigneshr@ti.com, Judith Mendez <jm@ti.com>
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

On Thu, Jun 13, 2024 at 4:47=E2=80=AFPM Robert Nelson <robertcnelson@gmail.=
com> wrote:
>
> On Thu, Jun 13, 2024 at 3:06=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote=
:
> >
> > The Kernel Image and DTB files are supposed to be picked from the rootf=
s
> > of the SD Card, this fails in legacy boot flow because bootpart is set
> > to 1:1. Fix it.
>
> and where is that rule defined?
>
> Production boards ship with Kernel Image and DTB's in the 1st fat partiti=
on..

Besides, u-boot should scan for extlinux.conf on "any" partition.

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
