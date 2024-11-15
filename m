Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DF6D6A25E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6959896C8;
	Fri, 15 Nov 2024 15:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EhuyTWoJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D6D9896B9; Fri, 15 Nov 2024 15:27:17 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54C7689698
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cf9cabe57eso421637a12.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680835; x=1732285635; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDA12GxhLIr87jIw/MaofytnPNz18O15TbsuHBeSDXE=;
 b=EhuyTWoJNjSahREX+hr4EjZoxDgqudXuFJhrdhTrJ5igJCBKyoHZ3+BKEF3fnd5OyS
 NtBH41bFn471ANfeUUcSJSKTDkEBOzWpMcGVEx8XPjTpWJK+pfAOjgqYdiU/kbkVpS8q
 Qs85J2FcQ+k1/v+YehN0w067EjGLggSy5hKs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680835; x=1732285635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDA12GxhLIr87jIw/MaofytnPNz18O15TbsuHBeSDXE=;
 b=cNbFogNAB6hY0sjx45NvGy/md+0Nn72OFyPHkXrvD9NOq2KkEYXpG2a75g/ncZtS2y
 joRy4ELXKp4DXnkT7jXrlXJJIZ0WGuVJzhsXwJ+gqedR6pW19s+7bdjK/UoBlorEfMo/
 7P5QKtH/uQ7z7qywKLzEK9uBAo0qRDZz/1w3jrgCfWdOmJHndDXX/RyH1KjRCu6DUmDP
 mz11nn9LBKPIpud9k61VGXR0SrK7jaEbL4+9VQY0ZMnKCOIobmByDzmSYiRdQnU616P4
 Jaqjx6eoAZRcKvytFrL5JeVZsWTuZzBGnrcfdQx3puek8yQgNcJ0k7Ze23KiTsQgz6QD
 wwuw==
X-Gm-Message-State: AOJu0YzOPgNJ4kXx3QWR8Js6n+swhl6loDzGrOefqqkIz6K/B/cHra88
 GjVwgqp2eE4W6BbrGhWz/NhIEOO6SM4JyejcgPL+jXBOXlpLjM8D/xiXhBZpm3jJMKmL39UMT4e
 Wbty5g4QPFmQagGw9vDk5WSu1y80bHOat/htR
X-Google-Smtp-Source: AGHT+IH1AL1kRPWUnzrha3nsBPFqL3d7a4xyMkftse5OrDk0a8/0UBXFsX1bq8iJnhaJYGeR6LAtCQZbvjX7Noxthg4=
X-Received: by 2002:a17:907:26ca:b0:a99:eedd:6466 with SMTP id
 a640c23a62f3a-aa483426483mr216124966b.19.1731680834735; Fri, 15 Nov 2024
 06:27:14 -0800 (PST)
MIME-Version: 1.0
References: <DU4PR08MB111882C823AA07294E82B4FFC935B2@DU4PR08MB11188.eurprd08.prod.outlook.com>
 <CAFLszTgRhKWNiB4LeDP+zkXrX12YnRfMvfx5ZdA7mWMU2Qb69w@mail.gmail.com>
 <ccbc084e-5125-45ee-833f-0844be8e5417@arm.com>
In-Reply-To: <ccbc084e-5125-45ee-833f-0844be8e5417@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:27:02 -0700
Message-ID: <CAFLszTig0AsCwVYJGtcHSNCC5Zpy2xb0PRdSS=44oDT0w2rdaA@mail.gmail.com>
Subject: Re: Clarification on Bloblist Initialization Settings
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Arthur She <arthur.she@linaro.org>, 
 Manish Pandey2 <Manish.Pandey2@arm.com>, nd@arm.com
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

Hi Harrison,

On Fri, 15 Nov 2024 at 05:49, Harrison Mutai <harrison.mutai@arm.com> wrote=
:
>
> Hi Simon,
>
> Thanks for the clarification.
>
> On 14/11/2024 22:06, Simon Glass wrote:
> > Hi Harrison,
> >
> > On Thu, 14 Nov 2024 at 13:41, Harrison Mutai <Harrison.Mutai@arm.com> w=
rote:
> >>
> >> Hi all,
> >> I wanted to clarify some details about the settings for initializing a=
 Bloblist (i.e., CONFIG_BLOBLIST_ALLOC, CONFIG_BLOBLIST_FIXED, CONFIG_BLOBL=
IST_PASSAGE). The documentation states that if CONFIG_BLOBLIST_PASSAGE is s=
elected, it uses the bloblist in the incoming standard passage.
> >> Does this mean that the bloblist is used in-place wherever the previou=
s stage places it? For example, if TF-A passes a bloblist at an address spe=
cified in the platform's boot parameters, would this mode use the bloblist =
in that location?
> >
> > Yes that's right, but if BLOBLIST_SIZE_RELOC is used, U-Boot may reloca=
te it.
> >
> That's what I thought but was slightly tripped-up by the wording in the
> documentation. Correct me if I'm mistaken, but it doesn't appear to be a
> supported use-case in U-Boot currently? From what I can see,
> bloblist_init assumes either BLOBLIST_ALLOC or BLOBLIST_FIXED.

Ah, I see.

Yes, you are right. The xferlist_from_boot_arg() side of things looks
like it needs a bit of work. We should be simply accepting what is
passed in, not relocating it to the fixed address.

> >> The reason I ask is that I'm preparing some patches to add bloblist su=
pport to vexpress64, and I'm looking to configure this platform without spe=
cifying BLOBLIST_ADDR or BLOBLIST_SIZE (i.e., automatically detect these).

OK, well see if you can tidy it up a little.

> >
> > Yes, that is a better way to do it, now that we have the ability to
> > pass a bloblist between phases.
> >
> >
> >> Thanks for your help!
> >> Best regards,
> >> Harrison
> >>
> >> IMPORTANT NOTICE: The contents of this email and any attachments are c=
onfidential and may also be privileged. If you are not the intended recipie=
nt, please notify the sender immediately and do not disclose the contents t=
o any other person, use it for any purpose, or store or copy the informatio=
n in any medium. Thank you.
> >
> > I hope not!
> >
> Argh - apologies for this!
> > Regards,
> > Simon
>
> All the best,
> Harrison

Regards,
SImon
