Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F20BC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 03:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0B6A8744C;
	Wed,  6 Dec 2023 04:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IzihtDuK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1C586D37; Wed,  6 Dec 2023 04:54:12 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 778038744C
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 04:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33338c67d20so328473f8f.0
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 19:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701834850; x=1702439650; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QdaYoJ1GDa29f5YsXr65k6bOZXFjfiCdd6Pwlv57Oms=;
 b=IzihtDuKe6lacGDTyYY6KvQz9BjX+JoAqTAIcHukgDHbuyBi5TdRb5eYDCWg9XevXz
 L50S6X7peqNCgEg3dGTGngyyhOSxVuMVCxPfbW3GydfWz549LEkLSOLcsrxpbRToOZgx
 gNIeOnFs9LiO9ZrqOGOPe6hoz6XRsWqnwFya4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701834850; x=1702439650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QdaYoJ1GDa29f5YsXr65k6bOZXFjfiCdd6Pwlv57Oms=;
 b=ZD/v8ezLTzonZGo21wg5BtdpuqLW3W2XIUmOX7TVf4pgvU3DN85nRAXaIqHV2Q8Tjn
 MP72UI4SeFZ14yHkQZagCVZpxOrQpkYCKWvMx7XZxiQhx0RMa3LELtX/3plkhH9FXkIw
 ZLu5a2+NfAXGdRuh1iV/dlpwjn2lcTnfwaZaRZMtRYBB1hnL0pMh6b+jRdYlfXMz7kAe
 HdzjJxUzHMLjrHnqvry1a8ZN9W3ObbX4tBW2+lp0H9+vYYQALsVdEEP301b4wbkPu5O7
 6AlE2QNCTxIgItP6NQe5QmaIiMbsBZYL+1x4ehDlZ5/Z+qC3p9B+t2Grqr+EpjeNLb/d
 oQfA==
X-Gm-Message-State: AOJu0Yz53G9atuB5VLa9fRMkQnsdwypvrpGFQvwgVIIA9FAYbTAzt2Lp
 9Q1bsNfBiquVqwOKYZ2pvc3/jpobsliD7pOVHAK3iQ==
X-Google-Smtp-Source: AGHT+IHbj8FPpzQaFe7VryFv5kbxcsZHpOncQQv8747/cBGPJsoKFhju+smxPZlVMwW4uKtFMixVShYcfdvcizlvi8w=
X-Received: by 2002:adf:b35a:0:b0:332:ee1e:1993 with SMTP id
 k26-20020adfb35a000000b00332ee1e1993mr99434wrd.20.1701834849806; Tue, 05 Dec
 2023 19:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20231204002642.895926-1-sjg@chromium.org>
 <20231204002642.895926-2-sjg@chromium.org>
 <87edg2b5vy.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87edg2b5vy.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Dec 2023 20:53:58 -0700
Message-ID: <CAPnjgZ05y__ReH0giGGsLaScfz+4=x1pZOy8LT35-X5EJUJtnA@mail.gmail.com>
Subject: Re: [PATCH 01/18] bootm: netbds: Drop passing of arguments
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, trini@konsulko.com, marek.vasut+renesas@mailbox.org, 
 sean.anderson@seco.com, Martin Husemann <martin@netbsd.org>
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

Hi,

I am replying to this email since it still has the context below.

On Mon, 4 Dec 2023 at 03:48, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Sun,  3 Dec 2023 17:26:17 -0700
>
> Hi Simon,
>
> There is a typo in first line of the commit message: s/netbds/netbsd/.
>
> > It isn't clear how useful it is to pass the arguments of bootm to the
> > OS. For example, if "bootm 1000 2000 3000" is used, the three arguments
> > at the end are passed to the OS. This seems like a strange approach,
> > since the argument have already been parsed by U-Boot and processed.
> >
> > Rely instead on the "bootargs" mechanism, which is the standard
> > approach.
>
> It is a very Linuxy approach though.
>
> I suspect this feature was added to pass kernel arguments for
> "one-off" boots.  For example
>
>     bootm -s

Martin says that this is used with NetBSD. So do we rely on U-Boot
parsing the '-s' as 0 and then using loadaddr as the default?

I wonder if we could come up with another mechanism? Perhaps 'bootm --
args go here' ? Or define that if the first arg starts with '-' then
the args are not parsed?

Martin, would it be possible to send a patch to doc/ describing how to
boot NetBSD?


>
> could be used to boot NetBSD in single-user mode and is quite a bit
> more convenient than:
>
>     setenv bootargs -s
>     bootm
>
> That said, I'm not sure to what extent the bootm command is used to
> boot NetBSD these days.  So this may not really matter.
>
> Cheers,
>
> Mark
>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  boot/bootm_os.c | 16 +++-------------
> >  1 file changed, 3 insertions(+), 13 deletions(-)
> >
> > diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> > index b92422171a84..b5055d78706c 100644
> > --- a/boot/bootm_os.c
> > +++ b/boot/bootm_os.c
> > @@ -102,19 +102,9 @@ static int do_bootm_netbsd(int flag, int argc, char *const argv[],
> >                       os_hdr = hdr;
> >       }
> >
> > -     if (argc > 0) {
> > -             ulong len;
> > -             int   i;
> > -
> > -             for (i = 0, len = 0; i < argc; i += 1)
> > -                     len += strlen(argv[i]) + 1;
> > -             cmdline = malloc(len);
> > -             copy_args(cmdline, argc, argv, ' ');
> > -     } else {
> > -             cmdline = env_get("bootargs");
> > -             if (cmdline == NULL)
> > -                     cmdline = "";
> > -     }
> > +     cmdline = env_get("bootargs");
> > +     if (!cmdline)
> > +             cmdline = "";
> >
> >       loader = (void (*)(struct bd_info *, struct legacy_img_hdr *, char *, char *))images->ep;
> >
> > --
> > 2.43.0.rc2.451.g8631bc7472-goog
> >
> >
