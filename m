Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD80C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A360788A32;
	Wed, 31 Jul 2024 16:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KzBEYPIS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C7F88A4C; Wed, 31 Jul 2024 16:39:07 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6FD388A3C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3db14cc9066so3621718b6e.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436743; x=1723041543; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E49iAr15TzpjyvX8yGGY/5x1cUYwnZu/RrsTyhlQmHM=;
 b=KzBEYPISI2ByYukbqfx9PC7rY0u7iQrn1jbZb1JNIvHxa0qwXmfmWJnn2kYxPIqG7Z
 QkD9+HM8F/uoB1AzS3OlQdEsowZRlMp/jCIOX5JEMthazGaPWfdsjdUYk//laxttRr26
 q0eEZWEz+fyWMGsYETfX0jsHEtI7R6Tby/R+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436743; x=1723041543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E49iAr15TzpjyvX8yGGY/5x1cUYwnZu/RrsTyhlQmHM=;
 b=dsfOMfmCHfEIurxqc/AeilesLroF6D2YvtF82JzdAAJt7Ab5U7EHw/l0TAcDLMOm5Y
 VcpfIV4RHaHs9P18Bs4me6B99zL/gpAVEojmE5Vgi70fk65kuRdlIhSN8tzGYzO7BQX6
 Jrz8IXZbCx9Bb6rHOfbJmsB3f0v43CvSF4UMqgse0B0Ymuor3lv7O0Fs+gOCVnOQUexM
 /18Cpx5AWGSsdRPU8AVbGm+JLAddPGqaWeKJIQpwo0S6LwrhxWLMfxnm1ZD19B6YZP1n
 XolOscIGH45/Oj+LTCVbdABKpfwi7EzVI5ESZtcPWYjPwP9Rz6HdaufjJ1Z6bQ5SiP9d
 WcZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8vpSNk1H7fLe6/0ETE/07WM+hM45v72ExG9Vkoj/duwTFXudUFhvCcpHRe7v5aZ5VhDefzo9iZiGwHCka6QeAb7PwwA==
X-Gm-Message-State: AOJu0YyRWeXRrUYVnzmssdyfeuF4ixYytrRknimQRXFmsT/UKzSaeZ08
 fyzSVrTtZ77IBhaT44dYfW9SsQz0XDk4SZZIEY3k3wM6cKMoH/LFWFQlv/CS2JCF82sglDTO2Vw
 bKQ0+1BsIPlBHlc9We8NQI3+CGIbWANi9xRS0
X-Google-Smtp-Source: AGHT+IEoWKEfkDS2KaX2fraT9AZajbtGta9IB8YPQCV6F2/ER+ovYsQ3+JERQG1BWmHPwQsNeLfMpHTbIO8TwjVxtkE=
X-Received: by 2002:a05:6358:5e04:b0:1ac:ed54:224d with SMTP id
 e5c5f4694b2df-1adc06b2124mr1720560955d.11.1722436742725; Wed, 31 Jul 2024
 07:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240712081118.29189-1-richard@nod.at>
 <CAFLszTg-bqTTv2NtVC-3m2O2nw+9eczcM9_wn41u6XMcujqNEQ@mail.gmail.com>
 <12856391.hYdu0Ggh8K@somecomputer>
In-Reply-To: <12856391.hYdu0Ggh8K@somecomputer>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:38:51 -0600
Message-ID: <CAFLszTjs84g4qcRrUxwqx3THMqttdhKya4m+AksoQkxKyDOswA@mail.gmail.com>
Subject: Re: [PATCH] reloc_bootstage: Fix out-of-bounds read
To: Richard Weinberger <richard@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at,
 u-boot@lists.denx.de, 
 patrick.delaunay@foss.st.com, yangshiji66@outlook.com, raymond.mao@linaro.org, 
 n-jain1@ti.com, eugeneuriev@gmail.com, ilias.apalodimas@linaro.org, 
 devarsht@ti.com, bmeng.cn@gmail.com, trini@konsulko.com, 
 upstream+uboot@sigma-star.at
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

Hi Richard,

On Mon, 29 Jul 2024 at 15:57, Richard Weinberger <richard@sigma-star.at> wrote:
>
> Simon,
>
> Am Samstag, 13. Juli 2024, 17:13:50 CEST schrieb Simon Glass:
> > Can you use 'bootstage' as the commit tag?
>
> Sure.
>
> > > +       debug("Copying bootstage from %p to %p\n", gd->bootstage,
> > > +             gd->new_bootstage);
> > > +       memcpy(gd->new_bootstage, gd->bootstage, sizeof(struct bootstage_data));
> >
> > I would like to have the relocation addresses in board_f like with
> > other relocations, so it is easy to see what is happening, in one
> > file. So how about passing the old address to bootstage_relocate() so
> > it doesn't need to access gd->new_bootstage ?
>
> You mean passing the *new* address?

Yes, sorry.

REgards,
Simon
