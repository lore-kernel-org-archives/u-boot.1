Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A052CCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70D258486D;
	Fri, 15 May 2026 22:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=l4re.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=l4re.org header.i=@l4re.org header.b="nFyo8fsH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE4E0847D9; Fri, 15 May 2026 22:40:43 +0200 (CEST)
Received: from os.inf.tu-dresden.de (os.inf.tu-dresden.de [141.76.48.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 174938481F
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=l4re.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=adam@l4re.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=l4re.org;
 s=mx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
 Cc:To:From:Date:Content-Transfer-Encoding:Reply-To:Content-ID:
 Content-Description; bh=rjaRNg3AS2JhKMmVWpy15ILrJFm5HusDqlBGdY4FB2g=; b=nFyo8
 fsHS5F8YnZUuxrfSF2F2NdORY1rt1EfPFq7h2/QFYURrqumweJ4GpX7QV4v9d68yKqU5lCavbI1sD
 tVJDAH3L48GUxzBXCJBu+CPxZa0KMOKO798J3+pgO0+D7/GCZ3Z+mNi/fjfgeQsqykuKCKmSiB70j
 70J3DHIfnbjqPSPBSVqRuLGAVB3YaPP0b2IwRBP7Lau/U86wAMKFUJdKieGyy1alvQorMX0CLRESW
 DKWhZUPZJ5sbBSe01l/95i+sHuhmI3JlEFWletumuUUy3nrWduuRf3cxQlf1lha0tqJnpEfKZm2AG
 3Ea0FHz1xcPauJojvOFOLetgb7m6w==;
Received: from erwin.inf.tu-dresden.de ([141.76.48.80]
 helo=os.inf.tu-dresden.de)
 by os.inf.tu-dresden.de with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256) (Exim
 4.99.3) id 1wNzKr-000000010yT-3IXn; Fri, 15 May 2026 22:40:41 +0200
Date: Fri, 15 May 2026 22:40:37 +0200
From: Adam Lackorzynski <adam@l4re.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] common/command.c: Avoid NULL pointer use in
 cmd_auto_complete
Message-ID: <ageExbncTevFp7jB@os.inf.tu-dresden.de>
References: <agXW8eM2DdZLEqt4@os.inf.tu-dresden.de>
 <CAFLszTjn8H=3x2=UcBEVX22FGP+_27fsvFksE7CoeORL810xOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFLszTjn8H=3x2=UcBEVX22FGP+_27fsvFksE7CoeORL810xOQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
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

Hi Simon,

On Fri May 15, 2026 at 07:58:38 -0600, Simon Glass wrote:
> Hi Adam,
> 
> On 2026-05-14T14:06:41, Adam Lackorzynski <adam@l4re.org> wrote:
> > common/command.c: Avoid NULL pointer use in cmd_auto_complete
> >
> > Avoid putting a potential NULL pointer to strcmp, which would lead to a
> > load at address 0.
> >
> > Signed-off-by: Adam Lackorzynski <adam@l4re.org>
> >
> > common/command.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > diff --git a/common/command.c b/common/command.c
> > @@ -373,7 +373,7 @@ int cmd_auto_complete(const char *const prompt, char *buf, int *np, int *colp)
> >       const char *ps_prompt = CONFIG_SYS_PROMPT;
> >  #endif
> >
> > -     if (strcmp(prompt, ps_prompt) != 0)
> > +     if (ps_prompt && strcmp(prompt, ps_prompt) != 0)
> >               return 0;       /* not in normal console */
> 
> This avoids the deref but isn't quite right. uboot_cli_readline() in
> common/cli_hush.c falls back to CONFIG_SYS_PROMPT (or
> CONFIG_SYS_PROMPT_HUSH_PS2 for promptmode 2) when PS1 is unset, so
> prompt here is never NULL. With your change, a NULL PS1 makes the
> comparison succeed unconditionally and promptmode 2 gets treated as
> the normal console.
> 
> Please can you fall back to the default when env_get() returns NULL,
> mirroring the readline path:
> 
>     const char *ps_prompt;
> 
>     if (IS_ENABLED(CONFIG_CMDLINE_PS_SUPPORT)) {
>         ps_prompt = env_get('PS1');
> 
>         if (!ps_prompt)
>                 ps_prompt = CONFIG_SYS_PROMPT;
>     } else {
>         ps_prompt = CONFIG_SYS_PROMPT;
>     }
> 
> What do you think?

Thanks, looks good to me, will send a v2.


BR, Adam
