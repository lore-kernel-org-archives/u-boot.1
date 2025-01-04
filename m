Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149D6E77197
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 19:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5687480585;
	Sat,  4 Jan 2025 20:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UVWLqLnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 361588056E; Sat,  4 Jan 2025 20:31:13 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB56A80585
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 20:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa692211331so2517084366b.1
 for <u-boot@lists.denx.de>; Sat, 04 Jan 2025 11:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736019070; x=1736623870; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+H2WwChhy7zB/pyFQzgtEppR6ZSl7FlFO5kBKMHhyvQ=;
 b=UVWLqLntObS/s6OxX8EPZCyUzfsNMOmQ94ULrDHW86bV9M40IjLFmw897aHidGK5Gb
 Wq42CeAZN4sVxxitDyrhXW+2D2BMWEJ+4+4BCSfB4xl3Gb5H/ClzsX1TQuacb3pJk3UA
 BzQi0KBmKB3D7Pc7Y/ma25ovDY34MXLnk3e8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736019070; x=1736623870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+H2WwChhy7zB/pyFQzgtEppR6ZSl7FlFO5kBKMHhyvQ=;
 b=NdZYFrP9s402eMhyp/ESn9veNc2LLDqT4mZjvf/GLMqtLKGkks4+tlQQ8XrZX2TUD6
 5f4DVKsVxmb5euBbdm38oIF0nNq3niDRwaCzjOowZYi6kSRu7WTFYUZGBfqipwl55zw9
 aDyejrM/5DuXkgUfNBez1iPYuXU+hiE4MzKIWqnr1x99SuJY4hoDOGHXo79Qwfn7nVPE
 /dUT8AXkj6QKOE5anz3OHnP/V/m15fE6jBuuDAq04CH1a9pyEdOdf+ykOp+b8Ysj6uoy
 DeLgXDazKEhxhhS5EFEyEE8h7Oiw5oaTb11DtgaDZm3lGKbmIajcJOUzCPs4AcppgeEB
 67uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHXN0WoF84AJQBRkHO/7i/0fAXVbgsxueUf7sUMMolgpQHNiBxPIq+hDT97qCT0yacPfBtBeo=@lists.denx.de
X-Gm-Message-State: AOJu0YxpkEBe9rCn//luckXcn2SNM/OWuqNtj1NZNK3pxTycwtdYwXE2
 hTLozQShsQlMBtqdY+5uNMX3kVYaE1Ff7a31oR5L1HTVwKFB5r7+03izFnVFxdu0TKvCyTTKr12
 SUY5Zo2i4j3X07us0+04QCP+sxSd0Ft6dosy2
X-Gm-Gg: ASbGnctEQqNRI5oU3y/msjFGHsXpC+kT5eDdsxWKuPjM+S1zi7Mms0wFzewBL7i7FAf
 O4aLr/1dlPMwJZgb/w70FMj2D7A+YE4FyR/TWAulo
X-Google-Smtp-Source: AGHT+IGae+zWsEcMn8cv77OwP4KIfTmYipVfpT/zs8edQcI4iXjbX3kIC45HjtBma/cGhS54lW4v5hN5C8jZDAsCy+c=
X-Received: by 2002:a17:906:f597:b0:aac:830:fb76 with SMTP id
 a640c23a62f3a-aac3350650amr5119137066b.14.1736019070424; Sat, 04 Jan 2025
 11:31:10 -0800 (PST)
MIME-Version: 1.0
References: <20250104003402.8863-1-heinrich.schuchardt@canonical.com>
 <20250104012443.GW3476@bill-the-cat>
In-Reply-To: <20250104012443.GW3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Jan 2025 08:31:00 +1300
Message-ID: <CAFLszThsXV_mxaOftCM4K9=t1ziEenFG3NkA_h4wrt2jpLqH+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: eliminate YAFFS2 implementation
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 u-boot@lists.denx.de, "cdhmanning@gmail.com" <cdhmanning@gmail.com>
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

+cdhmanning@gmail.com

On Sat, 4 Jan 2025 at 14:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 04, 2025 at 01:34:02AM +0100, Heinrich Schuchardt wrote:
>
> > Upstream development stopped 2012.

I believe upstream is at [1] and I still see pull requests, perhaps
just in maintenance mode.

> > Linux eliminated YAFFS2 in 2010.

Do you have a link for the commit, or why that was? I have probably forgotten.

> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>

I don't have any objection to this. I think most boards have migrated
to MMC and UFS by now. There is at least one board in the tree
(gurnard) which could have YAFFS2 enabled, but doesn't.

Regards,
Simon

[1] https://github.com/Aleph-One-Ltd/yaffs2
