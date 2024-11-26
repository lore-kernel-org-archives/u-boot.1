Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85077D3B9A4
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12FBA8907E;
	Tue, 26 Nov 2024 16:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V2UZ39XS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24BA688E0F; Tue, 26 Nov 2024 16:39:57 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9BE689646
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa5302a0901so447557266b.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732635594; x=1733240394; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DKdn/7eG86xvuEtQQ1rLEhw5WdLn6piStH/g8XzbKL8=;
 b=V2UZ39XSGdXDDmi4eWebg3sz/m0tlQGDMMqwnXaq8PE+Mc30R6bPxOeVyzqhg7CofK
 Ofso+lIAQKR87eh8NbUAE5DJWSeDvj7udbAsqybNfw+CvRR3L5d4YzeupOOpYQgxQgQv
 0HclUYaJlW4oh+s9CR+v4VfY0kqo/bOmCA2gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635594; x=1733240394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DKdn/7eG86xvuEtQQ1rLEhw5WdLn6piStH/g8XzbKL8=;
 b=ijyhZSg5i03fUwX1M3Hsvhcl3wyuv0LmMPoI7gpt1LGrLET2fp23pkM/hFt0o0bhZs
 QpYPdPQqUaEKpclBjAKENTd7EfQAQ8EPAjjiGZoQbdFqYdFsS4bdEozE5p9BVImbkdOx
 evxLFrT2vnN1i8AH1lnXuAHMWSstdHy5gntOz5RVw6f46Mg+X/H61Gcd/TOW8ZUt5U1G
 Jmb3XscuXq3ruBSTa4IbcFu2tdQI6R+/Yt+jHR+mlpOPIZ4O9GUkAmBYIV5zD5GvJhXx
 Ltm1AA9SdzKcnUEUXtuSFF2VBaYfr/0oTNr/fJEPVC9OA2ShSF9zc5Z1CXEjiEm8ndfR
 xLrA==
X-Gm-Message-State: AOJu0Yw1M9S8A57Ir8qL89yI5IS2uAP/dS/7YTS1gZEcM4XeCwoTzre6
 CkPSTEzpRtjb8LbRwGRYIdhUV01M85LhPqjMi96dSRG4bvpGJpb3bEHzDyJmbpzAKRhyVuIpuc5
 UR5w5Ynx2drfKEaGArpQsNVFKOd9XKLHpI5sw
X-Gm-Gg: ASbGncvOekxMppMBJYTIaT/TJe/Pr1lpfJkN0mSktH0nn9PkzD/cVgEA8oMjv2wu4Qa
 2qMf3/zIHDFz2s1fWTjMYgaUWW+a+LY0=
X-Google-Smtp-Source: AGHT+IFjdWeqk5/EzzqVTxwRVYAomltIcbL+OaYY8SoLwMWJtDIrPjwDu6+Gm0cAeCeUD36yGT4spO0ZXW+C9UifeJE=
X-Received: by 2002:a17:907:7701:b0:aa5:27a8:4cbc with SMTP id
 a640c23a62f3a-aa527a84d81mr1149985566b.15.1732635594375; Tue, 26 Nov 2024
 07:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-8-sjg@chromium.org>
 <CAC_iWjKAWrgFuKrNBq_+J9Tr726Aoor4+b=sPYwfydxfC6bevg@mail.gmail.com>
In-Reply-To: <CAC_iWjKAWrgFuKrNBq_+J9Tr726Aoor4+b=sPYwfydxfC6bevg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Nov 2024 08:39:42 -0700
Message-ID: <CAFLszTgssoqencFCOK3uVD_mpreEfhRbaQmyEd4BtHRno_wG7g@mail.gmail.com>
Subject: Re: [PATCH 07/13] efi_loader: Make more use of ulong
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Ilias,

On Tue, 26 Nov 2024 at 01:01, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
>
> On Mon, 25 Nov 2024 at 22:45, Simon Glass <sjg@chromium.org> wrote:
> >
> > One of the confusing parts of the EFI loader is that it uses u64 for
> > addresses, whereas the rest of U-Boot typically uses ulong.
> >
> > There is a case on 32-bit machines where phys_addr_t can be larger than
> > 32 bits, but this is very much the exception. Also, such machines have
> > mostly faded away and generally don't make use of EFI.
>
> I am not sure how true this statement is with LPAE etc. In any case, I
> don't want us to convert to ulong, there's no reason to break things
> for platforms we can't test.  So please drop this patch

Yes, I believe LPAE (only on 32-bit machines) is the exception i am
aware of. But U-Boot doesn't make use of the MMU for this, right? So
do we need to worry about this?

This patch is not essential to the goal here, but I would like to make
use of ulong for addresses, since it removes the sort of confusion
that we have with EFI at present.

>
> Thanks
> /Ilias
> >
> > So in the interests of consistency, update the memory functions to use
> > ulong in most cases.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  include/efi_loader.h        |  4 ++--
> >  lib/efi_loader/efi_memory.c | 42 ++++++++++++++++++-------------------
> >  2 files changed, 23 insertions(+), 23 deletions(-)
[..]

Regards,
SImon
