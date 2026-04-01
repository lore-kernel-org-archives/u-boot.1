Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112A6D35173
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 10:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7575D83CF5;
	Wed,  1 Apr 2026 12:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nc6nOLwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB7483F5B; Wed,  1 Apr 2026 12:45:18 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 690D883CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 12:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-65005a8840dso7682864d50.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 03:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775040315; cv=none;
 d=google.com; s=arc-20240605;
 b=KVNtP4CRHGQIrHX2pJIjRlX03Dj0wZDAX6ELQiAwDQNt2Zcvjx+XuuPpE+w8JBl+by
 wOOdBpDkW69AnI3QBsalha3yCOM5S9+GDFqVA9/k/OhaLbEtDICqz0h6ljkSJkElKby0
 LXpMtZesQuvykB40oo6weDs8V76TzsI7L1pTI2ZXfUJs4/5uyVLiWpIRjhgdCMzpcnxJ
 OvhnQIA3lXjNhQ8EBUTzVO0xK7wla2QsU1+S9gEr2fQR1G3Z8hUPfTbgEOSk2PxumbA9
 Te/LVgl9v5s7KE8tGyA7s4tOhBOOMEjcpmzzD9SWYfu1oA0Si8XVUvA/lMmhOnzcvsGv
 mnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mUePnJSeYJSzczOUTBklIp+cG41zE8x/PjWGF9h8M3w=;
 fh=5e8Mdu7gLIAgiwz1C9LTZYfyfbHximJ/pXztrpvnSA4=;
 b=WdovGxBkAZQeckVgvkgSOVosbMW/2yzw8mXAtuXOdN1uWCN2IZS/TJe8CDHm3MiIoC
 JTVoIqhzQ+Kjo8TwjJghNwQT2kLUTgBCVnURfLKJYhw8TXRaDlrMBYnLZG34CHmhnbrq
 wHflRzmnsJXF9B7DGF+Gks4GYiWLvLGEHT2NK5ThmFkyLkfmes+Xpe2Nt6tESIVh79F/
 7lKBOSl4XsIwKQTnANOiOyIZ2CnL7i8H/g2qdP2vFu7YZkKi44YH0n3bdPPipywPoST0
 uzofSfotUGNjNZTr72LmNTpgR/GYH/wk/+d/nNQlJ15RmM+LiL2YPZDmnPnypQm0cWeg
 sI8w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775040315; x=1775645115; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mUePnJSeYJSzczOUTBklIp+cG41zE8x/PjWGF9h8M3w=;
 b=Nc6nOLwchhgYl7boc+RTzdsAOk/eRXZP6u1Xps21/6knZ3CHr1t6C+ZXxM34VSU9l0
 ONn996InU3ZT8nyjxNdZ02S3ipU2rlsm4jp6yoeRqcVUtXy6+6lyp7xp0mpCch3GtI3h
 oSyhrntvHaBitpGJFVv7TtcRTpQpYt7xZXhZFq0OD29MxviMUukvVWMckn0P018rBb17
 ZVHUsw/pXM0taOZRYNxuCaGfRnK51rmmcB/LE0byPDqErxc+gvLjzA/wk6dWKSF6yHY9
 R36IjD85Rur3hZ2/10g/dT0TmuH8rzqTUmKwr0IAbUifRFHXgk0sF6s6sDTa2F1FFd/V
 re4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775040315; x=1775645115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUePnJSeYJSzczOUTBklIp+cG41zE8x/PjWGF9h8M3w=;
 b=Qd9BkefAdThaG8j4Ai4KsNkw+sAfd6eL3yZ3p24XP0+8VNWcyeZoHUQ9/fv2VtuBCH
 57ZjATetttXRCWvmSfFARAurpNoFaE6yHPJi79k3icwCeYjpxmtB+e03vouBqEMUUdbe
 dNnnIfvwoHqhZckgbfzSxSgDWSc2cQw+r2ZDWJVf5Jr6d9QGpJ8umq+eMWAnJqfVJISk
 d+7rXynZ+rtgP1NF+xZftzHyZHWqbIGepccLNDd1nIwC6YPXrgF60/jIgUGYvDTJGbjY
 mxZuA+lPUNIsTVuorkj9x8gPOAdCp+6UNT1jQyercclx1cke112aE+bPmi+hmsetXswM
 hbSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU30JH7WOCWbMjwcg+REiimYSASU71zMflOqbsCdRadICGw4Qwr7nV4D4HXIbAzq5Oa7xZ8oUY=@lists.denx.de
X-Gm-Message-State: AOJu0YxbtSGOJ7HlrzParwSbsUNvJFlZ9u/GHfwAdN/NPU9tOoMeTlEb
 rOqzxYYhV9yBJ/w/xCI9hpJX89QH7BYs2WAZkg71/N377MPEeWYXrZR7T+9BTIYIcpO4pOwi/cV
 h/uTyYIYjqKdAiZ5RVnmBHrZTZze+Quyc/JZdxhbuCA==
X-Gm-Gg: ATEYQzxAKk1NLxjJeDdgapHga3kYAkASYQF7h3QIcofsvmW6vWev6216RFF5g4pmwms
 ohZAfWb2cn56A+feuOqW5vyWQj7kr5mSvjMv1eol4WpiZ4CC0jERtTsLfH12gV2TT0cwLzXsQ5x
 ciKd1LX6yDW8oAHMfX/yyBXiiT8o/eEXlmbtyMs5H6GMcv5RQ4oPKYWXg5apB1MYZ+eBUBt+jNp
 zzR9CM2I/84/cOeZu5yIa7bkE7I3IOmJlhBovuJ1Q/F1hRg6cnOL2EgQ3AtUc/uAGIYMDZY5VXZ
 4TFYk3Att1iKDLTtMpz37NHPNn/oZdbHYOHAt9sgdvfJNjdjIMrK1xkSmf0gI7TQPrwFkQbx3bC
 5d8FlF6pa/wXEt/2uZpcyqRuNuVrAfz6icjV/JK+iZUaYT7h/CeYmOjjymTUpXmO6gnnr/TPMF5
 GfWaRlHLVh04KPSNdCGgITCj9FCzp0RYOUq0BdGMCTg4gnNZyf5gf7rzveGgmveMZEnN46oatAT
 b5zkmB68bo150RTjr8hqUfoxzeWXuKUfoOF8Lc9czKd2osLUmEzQvm8v+aUHi3y5QOrnnvlM4in
 bnUUcvd85QPOFX4kfcC5XZ2SilRp+VJLU3hUMpVUi8UF
X-Received: by 2002:a53:adce:0:b0:650:21cf:a43a with SMTP id
 956f58d0204a3-6502fdd6cafmr1998735d50.7.1775040315110; Wed, 01 Apr 2026
 03:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
 <177503910100.1968416.1541488991356907095.b4-review@b4>
In-Reply-To: <177503910100.1968416.1541488991356907095.b4-review@b4>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 13:44:38 +0300
X-Gm-Features: AQROBzBPva0KmScHb4EcUqo63i3a2v_z7VKnO65uTUv8NOSo_Xu3hcG0X8n19O0
Message-ID: <CAC_iWjJBuqyXThg=VSjVRYb-iaMk5qKDk_vtifURSRkomfwonQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] common: Allow relocations on the top of the last
 bank
To: Anshul Dalal <anshuld@ti.com>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
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

Hi Anshul

On Wed, 1 Apr 2026 at 13:25, Anshul Dalal <anshuld@ti.com> wrote:
>
> On Tue, 31 Mar 2026 11:01:14 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > diff --git a/common/board_f.c b/common/board_f.c
> > index df2b0dc899b..4270f368e65 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -321,6 +323,19 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> >                */
> >               return 0;
> >  #endif
> > +     if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK)) {
> > +             phys_addr_t old_top = gd->ram_top;
> > +
> > +             ret = fdtdec_setup_mem_ram_top();
> > +             if (ret)
> > +                     debug("failed to relocate to ram top");
>
> Should we not do an early exit here in case of failure?

We discussed this on the RFC and we decided to still boot and just
relocate to the old address

>
> > +             ret = fdtdec_setup_ram_size();
> > +             if (ret) {
> > +                     debug("failed to calculate RAM size");
> > +                     gd->ram_top = old_top;
>
> This should be redundant since fdtdec_setup_mem_ram_top already resets to
> old_top in case of failure and fdtdec_setup_ram_size only modifies gd->ram_size.
>

It's fdtdec_setup_ram_size() that fails here. We should reset ram_top.

Take a look at the email thread though. Jonas & I had a discussion and
I think I got a better idea for this patch

Cheers
/Ilias
> --
> Anshul Dalal <anshuld@ti.com>
