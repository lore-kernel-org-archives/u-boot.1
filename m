Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B09D6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 17:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE308964B;
	Thu, 14 Nov 2024 18:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jp9W4b6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA0F8963D; Thu, 14 Nov 2024 18:35:59 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E99F8964E
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 18:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C36013F849
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 17:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731605756;
 bh=zjDk/cYQiHWd2fFCqscZPVVaABWZpGBk6mvqOCtFcmQ=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=jp9W4b6GuI3VND+alBV+nUcx7RE9HPL/sWWvkPpx5UXTH/wdOOYfQ/NofMw5QmjGC
 C47JV7F7UYbmzpdWkp44l3hZysfle8gbd0UFYsRqIlfxZkLo9R1W5UrlZLAednVLHn
 +kiDgh7h5oknJzNZMWqyep6N4NvulKQJ4iWi2eut8lgDoZxI/uyEyyVkeig9xs12bC
 iqvYMEh3fOJbnPC/cZ7tUSuoVnEi/06qi5cOjCiaKcbF8gou6iFnEu27eN+cPI4zZw
 ttJ8i/NynLljpTvU7UXjhV0iknVxXSnlJ1zyXifaREVpozSgbaZAaRE/r2l6cVERaU
 FL/4igIWnDAmQ==
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e9e34fb867so1012696a91.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731605755; x=1732210555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zjDk/cYQiHWd2fFCqscZPVVaABWZpGBk6mvqOCtFcmQ=;
 b=RQewrrMOeNUFKfoL4Gfj/EQUFlWjLEE1cLvkNEQerH7BvO/PWJbFqg3052n3b+MIaD
 auCfgv510EJVX9gilkViOD40uffmwWmWWFvTGHvahzmo74ZYC18+pflRRj/rZNYY0Mcp
 ZoKwi8ygyPgKZAY9OgnFiZR46Tra1okHtINNNSifVuvegS0OiFkuuNnQLYP4tI/iAyg0
 YAsBQop/qmuks2ftlF/viT4pNzBjNcyaE6ylqaI7EBRzK9vxr5SDJs+sZq5lQcsRwKVk
 f+GZBdKltmjxVVScQpqdPq2Gh6UERJqdwGblL0xN5p43rZEPv4YyeXVgi0Vf5hmU5u6e
 8aMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZvdh8m/pURhI8+dsudyqJVr64Rrg0kPk77vsBd8XqkEA1V6S5n7w0YmZmCbE1y27bYtPKcEM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywbz1DEBadHXx6SE6iG5jSLsfQ4ajIrsp3akfY64gVCKT4r4DTy
 8XZDx70QG2LFQWmo8H4MY3yiDgwriuR3L/DVjEz5EZ70G8Dg1Dy/lhec8Rig8qx87NS+CQ1Ivqx
 X+3dKKD/zYtO7U1Ndb0vXwAdYLibXI/DWskeIrek6+xQSjHm0hountvwd9GnH9UXt1jaZTpPX14
 XuWLewaTxvcSWPzbc4mfJ/UQL5jTSRb2a7rKXvZRwCDQ==
X-Received: by 2002:a17:90a:dfc4:b0:2ea:1293:7db1 with SMTP id
 98e67ed59e1d1-2ea12937f38mr1087488a91.33.1731605755457; 
 Thu, 14 Nov 2024 09:35:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFSOECu2300UiWGtX/LN9slr4fv91AMkvxDXuAKrJLJ14nbf53F6p9RL8KgZ9DsbHFfSQiOVBJb4CHJ78quRs=
X-Received: by 2002:a17:90a:dfc4:b0:2ea:1293:7db1 with SMTP id
 98e67ed59e1d1-2ea12937f38mr1087468a91.33.1731605755187; Thu, 14 Nov 2024
 09:35:55 -0800 (PST)
MIME-Version: 1.0
References: <20241102163259.305802-1-heinrich.schuchardt@canonical.com>
 <20241114172654.GA4059396@bill-the-cat>
In-Reply-To: <20241114172654.GA4059396@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Thu, 14 Nov 2024 18:35:44 +0100
Message-ID: <CAM=mAOmFn0tytht3oK1F59=-nGxuLJmtSr2HpJDyTf=LWKYQOg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: use cryptographically safe RNG
To: Tom Rini <trini@konsulko.com>
Cc: Hugo Cornelis <hugo.cornelis@essensium.com>, Simon Glass <sjg@chromium.org>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Alexander Kochetkov <al.kochet@gmail.com>, 
 Alexander Dahl <ada@thorsis.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Tom Rini <trini@konsulko.com> schrieb am Do., 14. Nov. 2024, 18:27:

> On Sat, Nov 02, 2024 at 05:32:59PM +0100, Heinrich Schuchardt wrote:
>
> > The PRNG implementing the random() function only has 2^31 states and
> > therefore is unsafe to use for cryptography. Use arc4random() instead.
> >
> > Fixes: cc34f04efd63 ("tools: image-host.c: use random instead of rand")
> > Addresses-Coverity-ID: 312953 Calling risky function
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  tools/image-host.c | 35 +++--------------------------------
> >  1 file changed, 3 insertions(+), 32 deletions(-)
>
> Now I get:
> /home/uboot/u-boot/u-boot/tools/image-host.c: In function
> 'fit_image_setup_cipher':
> /home/uboot/u-boot/u-boot/tools/image-host.c:439:17: warning: implicit
> declaration of function 'arc4random_buf' [-Wimplicit-function-declaration]
>   439 |                 arc4random_buf((void *)info->iv,
> info->cipher->iv_len);
>       |                 ^~~~~~~~~~~~~~
> /usr/bin/ld: tools/image-host.o: in function `fit_image_cipher_data':
> image-host.c:(.text+0xb41): undefined reference to `arc4random_buf'
> collect2: error: ld returned 1 exit status
> make[3]: *** [scripts/Makefile.host:104: tools/dumpimage] Error 1
>
> in the docker container. I gather this means arc4random_buf is not as
> widely available as assumed.
>

glibc 2.36 is required published 2022-08. Ubuntu Jammy is 22.04.

Besr regards

Heinrich


> --
> Tom
>
