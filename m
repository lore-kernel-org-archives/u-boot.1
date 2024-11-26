Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B06D3B9A7
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E290895D0;
	Tue, 26 Nov 2024 16:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZbquuSbW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79CA389C8F; Tue, 26 Nov 2024 16:37:49 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF7B88D13
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cfddb70965so7107430a12.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732635467; x=1733240267; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GUUL3a9hvKNSttunemViHu4Mf+TWGMrVhPtkkJw0guA=;
 b=ZbquuSbWFAiwTD6fgrFbIocOgBtGNIGYByD79PyKsS3glBhGb1cTCjDNWWInZGEr3D
 Y68WvMBsoyzONrNdizeWUxhHWKPMYXYZRcn2qP7/eL3PMDWIPcP9PP5wFpNVOW0Lmkb6
 ZFoDZ7f+SPPbKrrflqUijilQMsjZeayKUgWF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635467; x=1733240267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GUUL3a9hvKNSttunemViHu4Mf+TWGMrVhPtkkJw0guA=;
 b=sT6HZHZGUPahp6LiR1JXwN8mvplm/du19j7Xu2XuRWcSZ7HxEKazOUJN2JinJepBmj
 UPYBSyHzDWhi6hhHQPjuvamwkZXfc54Y4jZPGbT3SxlWeU0R7V3E/tfh8nkBmIXpU+Af
 inyzdt/ZePSiMpE6LBe/ts2eS+I8FgWIZTfsug7qgrfv2KxqTDWPM316AoSn4WUK34L8
 n5z6fgtOm/eJpkYkkid52TGcyM7FjWSA+zsEWYCDQ8edHgXSS0+X1icgXClkkZRkvzdZ
 PM+yY53/KAweIc10ec3Ech4HEO7hqjoTFLk6NuD0jR56P5GWZc4cS1bQxCgE9jtlL62j
 o3BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWssV5Z6YIS0/AW+LiwEvFr6Owrd+4gmMwOdRgTrHgCpFkU+F69qB/PoM/Q4mLHgUcAPlgEAiQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxD7gH/1Kc72UshrZtsvDNRUaocdgpdv3ktBNG5H/+NZ/BLyM+W
 xirDElAwzANZF3AIBt/gQ9RT7WoP5ahvb+6UBoNRtudcA/SFUi+okBNj4+3DSZZw+G+xDcZ73PK
 TBGyXeoWP+eG0xdzO9lZvuCPwFcX3cUnERuQd
X-Gm-Gg: ASbGncve8B87OKIWhpNUv8AMgpulelJ4O4agicBy1rhG3UncFwnL7vSP53v4vta3w9K
 oLQNQPhXVQkR59vLBB15khCX2EWmiBwQ=
X-Google-Smtp-Source: AGHT+IEzt5TqFDpcL5sLPH9hWzl7Tj814C91QmgLvbQdCyl3mrcG1Joz5On3iqBR7diZ5pVcHVY1/SR9HN3jDDhsF5I=
X-Received: by 2002:a17:907:7786:b0:aa5:2483:3597 with SMTP id
 a640c23a62f3a-aa5248335f1mr1103062366b.26.1732635466930; Tue, 26 Nov 2024
 07:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-6-sjg@chromium.org>
 <d415c887-bb0c-47e8-bfd4-d0049f596367@gmx.de>
In-Reply-To: <d415c887-bb0c-47e8-bfd4-d0049f596367@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Nov 2024 08:37:33 -0700
Message-ID: <CAFLszTiOp56JkV1u5qOdJUYH2vJ5YHWwpBUmhb8WWiNs2S0B+w@mail.gmail.com>
Subject: Re: [PATCH 05/13] efi_loader: Move some memory-function comments to
 header
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 25.11.24 21:44, Simon Glass wrote:
> > Exported functions should be documented in the header file, not the
> > implementation. We tend to make such updates on a piecemeal basis to
> > avoid a 'flag day'. Move some comments related to memory allocation to
> > follow the convention.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Please, have a look at this line in doc/
>
> doc/api/efi.rst:78:
> .. kernel-doc:: lib/efi_loader/efi_memory.c

Hmm, we should not add C files as then we end up with all sorts of
internal functions, like checksum(). The help is a bit of a mess on
that page IMO and it could use an index at the top or side.

>
> Should we use a separate header efi_memory.h?

Yes.

>
> Best regards
>
> Heinrich
>
> > ---
> >
> >   include/efi_loader.h        | 70 ++++++++++++++++++++++++++++++++-----
> >   lib/efi_loader/efi_memory.c | 62 --------------------------------
> >   2 files changed, 62 insertions(+), 70 deletions(-)

Regards,
Simon
