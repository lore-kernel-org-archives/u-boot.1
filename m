Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD67C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 19:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46856887C0;
	Fri, 12 Jul 2024 21:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LLHg3cnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DDD9887C2; Fri, 12 Jul 2024 21:28:19 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0253F88786
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 21:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-59589a9be92so3345682a12.2
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720812496; x=1721417296; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THWvHlpSA8AExucQp9s2FmlLNY4VPYsLm0ZfhGY0dhk=;
 b=LLHg3cnSS55C0DvuhiuuizaFixplIjLad5KaNYr1URXdAiJZAy3Urpd7lPLz4yWt8p
 MW2v+J1+1KhXgjCQZtC5tPWuF1l5AE2AWBGc42ZHpLVJn8aj1RIEBhBvHCU9WU7j+hJH
 o8GN0Rnmhph3ILA5BkI/9/BLBEsI/5nxwSCrh5Uh/o1IDQnKuUdqDM0msE8ChcfAdyHO
 Chy/dKFwbbdN8lIAY7ULZqZTj+d+ms25N6slB6NJyVb0I5cvjEA467vGS0DpxPgikpG2
 OFsCzpOkM53OvhloRDvJ4VYhyGiema5Trx27Ceriuwfjr8izoUFUf/ePUYcWZLlf66VK
 5+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720812496; x=1721417296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THWvHlpSA8AExucQp9s2FmlLNY4VPYsLm0ZfhGY0dhk=;
 b=QRBtl3KkwTEiNgQHzOyjS4asn50/qUE4/RydJ1IOprgURafsRE4zrvTmXFdvEAr10S
 rbO4JHW+4m/GCvHA4Bt5V4xazDrwrir3qeh80e4QzCTv2Z20ysIkqg7RdS6BpbUcP2xZ
 A5OMwMjul8nwSsp7P51WPAmqjbIh2ZDjSoBbrkazQUbA6/AsqYy3hjkV0bbe5lIjN2PO
 0G/M7/n0Xh4XRDzZQtDUgvGjHhzRx4iw8MKhE4Fwq08Z5EiZgDnHbkaePbwwlXeIUTgi
 bUIF8kSMwENPV9E21l9etDRKypz9dSQU0a0ec+Jm2w+hjlQHtMZ9KSxxaXICLE/pVZPr
 FS0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHaqTecva230eOFqj7BcIIMTv46h5xpRqtIuR64LLLckCy6tnNrw7kuC9AtZR/kPrlGX/zt6ILfcBT1MZvfXqtTpi1Pw==
X-Gm-Message-State: AOJu0YyMdRhff2X6ErKrBEjSr4GTvSR1/rYCPJBHv0Ilr476tmbxRDIt
 0gxNMn9IiCJAqAG1VHx64IYVBVxeEAf2H7IkuFxzQbm2tuo8QRK/BiaVZfAIvlPnJcLcLCQuWwb
 7MkFq5ltXVkF0C13+1bxx6cKVUpZ87g==
X-Google-Smtp-Source: AGHT+IEBcCeq2BQD51deJCkIocdigAWMJZjmeMzgip9vbEWaw0PdJ5XQOMk59sPk8wTDdrLUbzVtLJiuBm4pOEbE0aw=
X-Received: by 2002:a50:cd5e:0:b0:57d:357d:9909 with SMTP id
 4fb4d7f45d1cf-594bc7ca255mr7762609a12.33.1720812496219; Fri, 12 Jul 2024
 12:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFzx140yJxPs=x+1Rm0+j+xT3cXBN8svqaq6XW9_D1CHyw@mail.gmail.com>
 <87o773m3h8.fsf@prevas.dk> <20240712165026.GX38804@bill-the-cat>
In-Reply-To: <20240712165026.GX38804@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 12 Jul 2024 12:28:04 -0700
Message-ID: <CAJaLiFw7H9s2OtSdhjyQ4P7NVz277K=jYmssFu=Ed02W1X96Pw@mail.gmail.com>
Subject: Re: env: CONFIG_DEFAULT_ENV_FILE and CFG_EXTRA_ENV_SETTINGS
To: Tom Rini <trini@konsulko.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Phil Sutter <phil@nwl.cc>
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

On Fri, Jul 12, 2024 at 9:50=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Jul 12, 2024 at 10:14:27AM +0200, Rasmus Villemoes wrote:
> > Tony Dinh <mibodhi@gmail.com> writes:
> >
> > > Hi Tom,
> > >
> > > I'm trying to move some envs from a board header file to the default
> > > env file. I recall that the envs in CONFIG_DEFAULT_ENV_FILE are
> > > appended to the envs in CFG_EXTRA_ENV_SETTINGS. As you mentioned here
> > > before:
> > >
> > > https://lore.kernel.org/all/20220810170439.GJ1146598@bill-the-cat/
> > >
> > > But it looks like envs in CFG_EXTRA_ENV_SETTINGS are completely
> > > erased, and then the envs are populated with what's in
> > > CONFIG_DEFAULT_ENV_FILE.
> > >
> >
> > Author of CONFIG_DEFAULT_ENV_FILE here.
> >
> > Yes, the point of that option is that you supply the entire and full
> > intended default environment in that file. No U-Boot CONFIG_ options of
> > CFG_* defines or anything else affects what goes into the default env
> > when that option is used. [At run-time, U-Boot probably injects/sets a
> > few env vars, but that's true regardless of how the default env came to
> > be].
> >
> > I think there may be some confusion with the much newer
> > CONFIG_ENV_SOURCE_FILE, which is another mechanism entirely. In that
> > case the pointed-to source file is sent through cpp, thus allowing some
> > u-boot config stuff to be used/referenced, and I think some further
> > bells-and-whistles also exist. I don't know if CFG_EXTRA_ENV_SETTINGS
> > are taken into account in that case or not.
>
> Yes, I think you're right about the confusion as I too missed that in my
> reply.

OK, thank you all for your clarification!

All the best,
Tony


>
> --
> Tom
