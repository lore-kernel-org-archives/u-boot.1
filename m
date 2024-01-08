Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FD9C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 13:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C0A787A34;
	Mon,  8 Jan 2024 14:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O6hAde2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C98CE87469; Mon,  8 Jan 2024 14:09:52 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E44A587A36
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 14:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55642663ac4so1933059a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 05:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704719390; x=1705324190; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8yoRqcl4sXzDJcVZBTrMc45JNhCN9KrBp4kKIYbhDY=;
 b=O6hAde2AWKGJy6boZyBLeh1D+4C9od7yjuvElDd9KRKfr92XS4MRmByxsgv5aymjsN
 r0R8wvXLLnlm6CrbJ5yRQzjIKdtwYeo9jzsSSZ6TfrWPtmZta2IEWZEPuvbB0BmUStfx
 YHGKhvtZYC4TrkjV6tHXtnpsG8/AVlc/YWJyfvooJbjDJGid4xajvVN6SBlwjKr/uTiy
 ijJ/x4ta2fRpWM5pJif1JfEL5E+e0hh86lDWutNvFuICPM3gHkZay/RNvcpv6blOG0rX
 2evk3qnaoZXyGyC2clssd1mBFfnEDE3L+LgTq4mdAXL+aMgFkftZlbGz4E0UlsJOsO0C
 CpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704719390; x=1705324190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8yoRqcl4sXzDJcVZBTrMc45JNhCN9KrBp4kKIYbhDY=;
 b=bWW0omJHYkritEOXCNJk8Y07aK4W1GY3lyY3OMNd2rbh+E4BAzHH0xKQHb83WpTcu4
 5BDJYtanF7o1r0qPIIHvBaxaBsXVAY0nk0LcHkhqTVJze9OJibtCC/nIKZfP7XwYlO1c
 /PXlFTYrbk+GicTuZGZNWqCZG271tGeZvHBEkH54QicjvKycXqRP5S5w64kPtKZO1sBJ
 Th2e1ae/IXVd0vdJIigxo5WOFjnnfAzZCMwV7l/f9cDmB+yDVAZ1MmHj9dUJBHRvs85w
 sWV96T97N/JrDbSdOwKXliv1hHvLKIf1/MhGet6g/oP/T3pFBvRF1hcRvQdLF1ayewgx
 i9Cw==
X-Gm-Message-State: AOJu0YzjEW2BlmjxF2FJ6eni5C5EchCs9U2BLOPfklIWiC1uOGKQyciI
 Vlfd5UqOLRcQUP/tWdCbeMgfcDEEPyQZYltrJfs=
X-Google-Smtp-Source: AGHT+IEPsziJfrZUeBAsvqRiFaCzW515TJ3PguFFY1+aXWvINAOl6Ziz7wTO5qctUJn8w8HSc9tBHXgON9M/VWWVC9U=
X-Received: by 2002:a17:906:260c:b0:a27:f7a1:2ad2 with SMTP id
 h12-20020a170906260c00b00a27f7a12ad2mr991796ejc.69.1704719390170; Mon, 08 Jan
 2024 05:09:50 -0800 (PST)
MIME-Version: 1.0
References: <20240108001455.35638-1-sjg@chromium.org>
 <20240108001455.35638-2-sjg@chromium.org>
 <874jfouq9e.fsf@bloch.sibelius.xs4all.nl>
 <6beec0824542ac0608a5dfad9b88d32a@manjaro.org>
In-Reply-To: <6beec0824542ac0608a5dfad9b88d32a@manjaro.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 8 Jan 2024 21:09:39 +0800
Message-ID: <CAEUhbmVc06RydZavZHAXS2oBZC=cRt0C801+dxYVYr9qZRvBVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] coreboot: Switch to a monospaced font
To: Dragan Simic <dsimic@manjaro.org>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
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

+ Tom and Anatolij,

On Mon, Jan 8, 2024 at 5:33=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> On 2024-01-08 10:29, Mark Kettenis wrote:
> >> From: Simon Glass <sjg@chromium.org>
> >> Date: Sun,  7 Jan 2024 17:14:55 -0700
> >>
> >> The default font is proportional, with different character widths.
> >> Select a monospace font for coreboot so that the 'dm tree' output
> >> lines
> >> up correctly.
> >>
> >> Update the coreboot tests to match.
> >
> > To be honest, I think defaulting to a proportional font is wrong as a
> > default for something like U-Boot.
>
> I agree, it makes very little sense to default to a proportional font.
>

So we should revert

commit b093753471c1a30d680868a9f4d9f6db090bf0b7 ("video: Add a default
TrueType font")

Regards,
Bin
