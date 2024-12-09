Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5893E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13153896CA;
	Mon,  9 Dec 2024 16:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hSg2JEbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 785A9896E4; Mon,  9 Dec 2024 16:47:59 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B9F896AA
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa69251292dso163131166b.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733759277; x=1734364077; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z94qqPWqnzZNAzdrJKNCUpa8PxvA7bvvcAJXQO7dl8A=;
 b=hSg2JEbEyfov5ur9kDojfQPOa6vOGMQYyyByU1H2jYH9Fp/g3TOJ120T7O8UiJcmBa
 N6QUJBXQhADoYmAvV0PrwFBIA2pHQ+0C4tMKc5Fk74lysC1vW5NA+aun9IVz/sVLrJdn
 iiJaTf7aD4LBh0og1jCRrvwYgAf3F76qGvKEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733759277; x=1734364077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z94qqPWqnzZNAzdrJKNCUpa8PxvA7bvvcAJXQO7dl8A=;
 b=lZv+Zg1VNHnTMnsRpNuy0TFQXV2nEPBH9oPIasn8P3qPvITaKJdMJC5JUpE46+FOfk
 c8vwvQHbM9QnlEFEO4wiK2F4upDutfPnkoMWe8rdyNGb/is+5ulTeozQJL7nxLxYpo9g
 KlP4HQOV2fJUABu61JLAPQaoWK7q3WDQhlqX+pBiMPzBPbi81vH0bdm1GY/4SbgIBYYg
 /MJ1DfxAWwd+tPiH9T6SDFc9zL+An9KfM1ScoLQtDErZTzlyPpKoJIWv5PnXiixAcS8y
 LmwHaif80CEEEPjPfYK/KolTGiMSQ5OityY7kjNcKvz5VzqAKzmQmYFtw4kOwqz+3f39
 pQMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWonffvr/HsxRu1ailSh68qCQ+VVisQght6v78WW5yV2h6r3HG4bIsrBJb+pERQmPFyr4LunDc=@lists.denx.de
X-Gm-Message-State: AOJu0YxG4jLRygncwxmhCWKskgl8U2A2d2Gf1kmLjzcgnYndoH3jbVXf
 eqC4ggARpD1UMfJDku7LvrPacspVEX2FGIkXSuy4Atg/HH0/LzGkrIzxZvb3Ia9oIjb0Y9H/kr/
 uoFytPojUKVaDUAnnzykm3ySHqECwsl5whGyH
X-Gm-Gg: ASbGnctrMYHrSjg6PgyPKg60O+TwRskc8MkzNxwkUmNupDpMeg0E6ICPfSPZGFkwj4J
 C8MSx8uusy5i+xqIx8gdor5h0qlsuxSID
X-Google-Smtp-Source: AGHT+IGcYG0YTWDyvMFOk5JjrOth1JuYRAt89q7w14VSfjluTT3QgZ0WSnX92X8rKYt3zQ4+sVYhU3rpU/FGhkGoDQU=
X-Received: by 2002:a17:906:4ca:b0:a9a:646e:d2f7 with SMTP id
 a640c23a62f3a-aa63a33b676mr1248600766b.61.1733759276714; Mon, 09 Dec 2024
 07:47:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730452668.git.michal.simek@amd.com>
 <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
 <CAFLszTiWOdsS8=pm7aSvyC2QYiXbbsciz2yb6s9YPV1FeFFrgg@mail.gmail.com>
 <2ee46698-87c9-47e3-8951-41ac3c50331a@amd.com>
 <20241209153216.GJ2457179@bill-the-cat>
In-Reply-To: <20241209153216.GJ2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 08:47:45 -0700
Message-ID: <CAFLszTjb23qYBS2YDWjTJDFtJ2OnZZ5OQG56i9DBu_NeUT=FzQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] common: binman: Calling initr_binman() when
 BINMAN_FDT
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com, 
 neal.frager@amd.com, Christian Marangi <ansuelsmth@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Mon, 9 Dec 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 09, 2024 at 04:26:15PM +0100, Michal Simek wrote:
> >
> >
> > On 12/6/24 20:20, Simon Glass wrote:
> > > On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
> > > >
> > > > Calling empty function when BINMAN_FDT is adding +64B for nothing which is
> > > > not helping on size sensitive configurations as Xilinx mini configurations.
> > > >
> > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - new patch
> > > >
> > > >  From my perspective there is no reason to call empty function. It is just
> > > > increase footprint for nothing and we are not far from that limit now.
> > > >
> > > > ---
> > > >   common/board_r.c | 7 +++----
> > > >   1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > This is a bit odd, though. Do you have LTO enabled?
> > >
> >
> > yes LTO is enabled. And there are other candidates like this.
> > Is LTO able to fix function arrays which is calling empty function?
> >
> > (without this patch)
> >
> > 00000000fffc0eb4 <initr_of_live>:
> >     fffc0eb4:   52800000        mov     w0, #0x0                        // #0
> >     fffc0eb8:   d65f03c0        ret
> >
> > 00000000fffc0ebc <initr_dm_devices>:
> >     fffc0ebc:   52800000        mov     w0, #0x0                        // #0
> >     fffc0ec0:   d65f03c0        ret
> >
> > 00000000fffc0ec4 <initr_bootstage>:
> >     fffc0ec4:   52800000        mov     w0, #0x0                        // #0
> >     fffc0ec8:   d65f03c0        ret
> >
> > 00000000fffc0ecc <power_init_board>:
> >     fffc0ecc:   52800000        mov     w0, #0x0                        // #0
> >     fffc0ed0:   d65f03c0        ret
> >
> > 00000000fffc0ed4 <initr_announce>:
> >     fffc0ed4:   52800000        mov     w0, #0x0                        // #0
> >     fffc0ed8:   d65f03c0        ret
> >
> > 00000000fffc0edc <initr_binman>:
> >     fffc0edc:   52800000        mov     w0, #0x0                        // #0
> >     fffc0ee0:   d65f03c0        ret
> >
> > 00000000fffc0ee4 <initr_status_led>:
> >     fffc0ee4:   52800000        mov     w0, #0x0                        // #0
> >     fffc0ee8:   d65f03c0        ret
> >
> > 00000000fffc0eec <initr_boot_led_blink>:
> >     fffc0eec:   52800000        mov     w0, #0x0                        // #0
> >     fffc0ef0:   d65f03c0        ret
> >
> > 00000000fffc0ef4 <initr_boot_led_on>:
> >     fffc0ef4:   52800000        mov     w0, #0x0                        // #0
> >     fffc0ef8:   d65f03c0        ret
> >
> > 00000000fffc0efc <initr_lmb>:
> >     fffc0efc:   52800000        mov     w0, #0x0                        // #0
> >     fffc0f00:   d65f03c0        ret
>
> No, but maybe Simon would prefer if we marked all of the could-be-empty
> functions as __maybe_unused and did:
>         CONFIG_IS_ENABLED(BINMAN_FDT, initr_binman),
> etc in the list instead?

Yes that looks better.

Michal, see also [1] in case you can work out why it 'stopped
working'. I could have sworn inlining the function was a win when it
was applied, but no amount of toolchain juggling could make it be a
win when I came back to it later.

Regards,
SImon

[1] e7f59dea880 Revert "initcall: Move to inline function"
