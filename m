Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADFDCD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 15:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 719C9847EF;
	Fri, 15 May 2026 17:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mq+bG10m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD2384713; Fri, 15 May 2026 17:35:24 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95257846A5
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 17:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bce57c132b2so208117566b.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 08:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778859322; cv=none;
 d=google.com; s=arc-20240605;
 b=J7YP/Msn0dww2j47i30a3/vG+vhnIkrRRn8Kh5sifd7sbHT2dWtkt9ZgItljBjqm/y
 ChCXD4KJJ8nOiQqPOnatQ7d75ScKfJaHN/7UQXYf89Ac6QktJ+nauHlkW4GFdwiilYYy
 5Y0ZFu5Mhe4id69QQF1RjJL1jIAdFLPNEdsrokkd/9/Ui0LG79xcK7w1oaBt8CXLj3/d
 cLsIMPz25v8JWq3eufaGGJp8agav40R3NtDT2NW7jYbG0A1uUJmVUAKzTbru8kvKiWwJ
 yszDZSVEmTBO8DZ1nigvicUgjc3o8HS+VGhpHUf7S8rXU5qEl1ObemJGmgSEd783x8FX
 PAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TUSuIY+6leceYdQkY5Z5G34F7TJfB2DcIjYM76eTBrI=;
 fh=lZ0EECje8PeSW/GEUhoSocpLU4soXhDAJcZsP10VmFM=;
 b=JuycvMNzl06L8hU9dMhOS0aE/vmeLSTqfgJ2Zys+3sb7rLd/LFFn7s/p+I8oPEw21Z
 G6qdyBWaq4TNK/Qt5ACc9aisLH/6RUtL1ZkIwTeRyRq2iu2Bfc/eGR1yyzFjX9/GCqw/
 4O5wk+fKxFleffkO3lc9h+Mfx7Fx7fxgrc/poOJnqJq4LtMGNxQH6cIY+iYRFSP7x6xj
 8XesjwGsm1x7mvlmhQlAy1JU0kPDIGzbk0QpwYbUHjiyjV4hdqyojdJYgXe82E/G7C52
 ZQ28ev15VRL5VA2tcjHAY9l2fzURLk1NiWHUiqXTj6t21vxJkHHwBEgVdLZ6bGw+PTuA
 PCeg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778859322; x=1779464122; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TUSuIY+6leceYdQkY5Z5G34F7TJfB2DcIjYM76eTBrI=;
 b=mq+bG10mcaVj3xjznKq5MeGHAG3WCNlLJhnYu/DSIK1f05keEu7xKPzsLYH1nyKw86
 MqoULjrM7jPXhyEuYew+gte+UOjUuKcQ1bg2zlFvnokKmSZ9UYcLflUhFJkkOce2Cfxq
 1S23rNwLk9Wx95Ttb+L7NsvB9UNRRkL43Jq9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778859322; x=1779464122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUSuIY+6leceYdQkY5Z5G34F7TJfB2DcIjYM76eTBrI=;
 b=FINedHgmy62Zma/NP33xUegmbxHzx+SV69eTdfVhoyAJ7K+p3aIKIJ5nYvaY2YyBR2
 Fm43e3HAs6AKU4DLlJQQv1ln4tdyxa9pq39Uk3ASo/T+M344HHnHE3x7fCoi32nfpcWp
 NrYJPu49ycLqOSmSmBHvwXRvDHUV8u71dQR3R+Yh7SEjCrijphncwNThprPyU+0Z4bwV
 G9TREryv6x7NnRQDNc/SkOR4VRANW37r3mrKJUx4Bd1fXrDGDfGbzXjYxETEl9tHayQ0
 27kS+XUJPUhWsaYnLolOucx0TEfHrZFaaf4qqvb5DKYEpBWhFdp+VhZ/QLoquJ2yxdsp
 o4Yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jRPjwoztAXCSOgariWHCaltoivU9EZnXy+Q5q1IHg+R9K78Vp5S8sMEaJHHxuGJO1fnkPDV0=@lists.denx.de
X-Gm-Message-State: AOJu0YwTQ7plCXQKHMxhLHs+CqlnQ0MRi+VL/Rk1mzxh0SV2bId8vDKj
 quVdxV8Z87SQgUGFLqnnCsQQhMlCUIK85KgtCcgkL1orR9meSdjFB1JcgPGlLG2TJ6dUmqBKT0w
 Mwt73CiHiJ8HAipxwbiPDn9jFZkygsQhGGP1Halja
X-Gm-Gg: Acq92OHLXOBsIpKV1ZnrP6u3cp3Jg96QuwxepzONwPv5tX7pwWfyihWvG1OzEGsgkSi
 D9rHdzrTd02+9ARSsV+vtENE/X014QoCNZNA3EzHjMUUQdlQ4HiRl0lk0zoSR4IVL7utWri+a0q
 DqROa//e5dZlrohJjhaoYIYkdUtDc+SpRHH7EoMb/i3uWANtX7RmKOPQ0SpLyo209UzcPdiBQYx
 QD6EgTXfeZrzZeGIMNr12cUs5wqZgfsWGnaHqvyUT79JW09/E8ldb5wrXTGsbTSiXRkgCJsMZlB
 vvmz8Q3tmIDM2DGf
X-Received: by 2002:a17:907:9614:b0:bd3:99fc:5610 with SMTP id
 a640c23a62f3a-bd4f3503c54mr490957366b.30.1778859322012; Fri, 15 May 2026
 08:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260515054327.1033466-1-w.egorov@phytec.de>
 <20260515145400.GB1858239@bill-the-cat>
In-Reply-To: <20260515145400.GB1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 09:35:10 -0600
X-Gm-Features: AVHnY4IaLx4qfttEuXsiewo14sW_WmaU9YYydWWGl_cqxmHIxTcdOzuj2HFaXM8
Message-ID: <CAFLszTid-e+NWrFxoorfrUT23_mztUZP8FRbmT9FJ55M8A+FXA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: binman: Search board directory before srctree
To: Tom Rini <trini@konsulko.com>
Cc: Wadim Egorov <w.egorov@phytec.de>, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 upstream@lists.phytec.de
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

Hi Tom,

On Fri, 15 May 2026 at 08:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 15, 2026 at 07:43:27AM +0200, Wadim Egorov wrote:
>
> > A file like rm-cfg.yaml accidentally left in the source tree root
> > shadows the board-specific copy. binman builds the wrong YAML, the
> > resulting rm-cfg.bin may match a different SoC, and we end up with
> > the following error:
> >
> >   k3_system_controller sysctrler: k3_sysctrler_start:
> >       Boot Notification response failed. ret = -110
> >
> > Move the board directory ahead of the srctree root so that the
> > most-specific match wins.
> >
> > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > ---
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 552328f9f2c..1ec29dfe0be 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1682,7 +1682,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
> >               build -u -d $(binman_dtb) -O . -m \
> >               --allow-missing --fake-ext-blobs \
> >               $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
> > -             -I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
> > +             -I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
> >               $(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
> >               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> >               -a atf-bl1-path=${BL1} \
>
> Why do we need to look in $(srctree) itself?

See for example:

arch/arm/dts/k3-j721e-binman.dtsi:308:  private-key =
"arch/arm/mach-k3/keys/custMpk.pem";

Also, people sometimes put files in the source tree, e.g. BL31 images,
in the hope that they will be found.

Regards,
Simon
