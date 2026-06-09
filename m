Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90C9CD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 13:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36FD6848BC;
	Tue,  9 Jun 2026 15:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sKqku0gc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F41C684704; Tue,  9 Jun 2026 15:36:42 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B18684878
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 15:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e6f8f26d66so2779340a34.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 06:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781012197; x=1781616997; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hYfD4TuMLb2GPtOyVcgbVO5Wo0x3/u3CyC665TcVqoI=;
 b=sKqku0gcwFKEfUDsJDqvIdclLj6xynzIAXWY2O1JA9wWtlREt+o2yOmD+0DxU0kl0j
 6yR7cz4K1zx9nK5f0XS4d3rPJOEwfmbM7xOAnC/aprapEflpofSN+/RcPPqS2TYpk0ab
 3RW6OT+kjTt8ZfORDsxqqbyxWoP7pATxK/Jbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781012197; x=1781616997;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYfD4TuMLb2GPtOyVcgbVO5Wo0x3/u3CyC665TcVqoI=;
 b=S2zq+HvV5Yj6att+nC27D3biV8nBMit82N1IpbZgof488m0vk+tZq8xc/ByOJu3VgA
 YANV2PrGOhWsUzQTCNJNRVgchL/7h3MeUpZaZys/fjweSSDe6ZVbuPCYHMZsX140agPL
 6bz3OlhUzYR7aN6l00mDZTg2VizJcz4zrjaiiwTUU4L709qABYf3lSJMIjTL7GUhN7yw
 tpu7mCVCz5x9tWKyxKwjCMzH87jNrsi4HRYafLrMj2DEkKb79pyai+eyApenJ99czF3u
 Y56dnH1ohJ8jUxxyuVA9DaXK7itVERCXg2AePH1ai+YX3xqwnzD1k21o0lOkSDUjz/bp
 V23A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/by+JAPEY/UZeb/oImkTvtGHIfSwaJuuTIYyRTLizNfDzW+HRPVMbYcAesTCwJWSqxQd5WC+0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxnpln1oPdpARG/dUM+8VOEdv4lfUayaLyozKxFCHhH/l/tsSpa
 4McWPAa2wE1pdtw0y1S5tQq/LK5tDUYBpzDshZA5yRPbaIRHKxMiYSS0R8x35YBr8ys=
X-Gm-Gg: Acq92OF8/aUf+iA/NhyUbaX4uGkSq3I02o7VzM6Ugd81Cee2ddOynxJHpYIbKq6Owmz
 NQhK/iTKOW6BKwz4q69KkvVxXLDd22ch8UEk4vk+fAw2rfYQOU5n12vuLX7BMFsm81YRvXXA+TM
 pi86tOuWDaOgC+0kmhWBb8uY5h6018h36Yq5uyDHNc2J+xhu57ZGiUbpvXo3SNo2bniKnZy4Ryj
 TqZ1DCyjp243gV9XtHJdYi/6hpGJrzv2OC029CHkaG/VI6udKuo6DXrRrwaNi0nKzqHms47Y+Zt
 e4qgFqKkJxQxa5gxVdOtFy9GDLFgcpEIk6G8ezFM0pZv1ZUhqmQvJkHOyaqWCwpaVT+GxRcpMBQ
 svLRm+iPDHpIMHmshHC11oYHQMyHWBtMrsA8bN2SqcNH3nzQMvvi5IppAvCgb56FoeftQ9uCA6t
 F8F09wKVJL6q+H3cUDB5/1F6uVzL4ynfOM84IG6Deg7by1kqwZ5b/PmE3qtuX+FiFc5sUWNbcwZ
 XsgvyxndruXG/sLAHPBgXWLngIDzYnfu/RLVZ3sbEDK1XUESTyKTLSY72QsrkO8cs39TJkd
X-Received: by 2002:a05:6820:4c88:b0:69e:5802:9680 with SMTP id
 006d021491bc7-69e6d30237cmr7071004eaf.6.1781012197199; 
 Tue, 09 Jun 2026 06:36:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e46298798sm11344353eaf.8.2026.06.09.06.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 06:36:36 -0700 (PDT)
Date: Tue, 9 Jun 2026 07:36:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Day <me@samcday.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Binman with Qualcomm
Message-ID: <20260609133634.GS382693@bill-the-cat>
References: <CAFLszTiPJ=a2XNxKjegPP4HgQrYYOrwiPG--A2=u59y6KEV0Dw@mail.gmail.com>
 <f19c6b35-bd26-4506-b2dd-cd6e6938f3cb@linaro.org>
 <CAFLszTipPLKDSyOsgCWPXQx5oORCQjUrohfZG1Z1P91iATzLhA@mail.gmail.com>
 <cbdb7a26-41d3-4f46-bbcb-c289ea844c29@linaro.org>
 <fBFdR32iMUBnz1xt4ThcZauDJSvuuDHGxDM160ek7-UCIG77hsz0xK9HKeW3kMgiQUJiYPUEuz9MeldVw_03Mg6iyvTrRheaf5oF-mIo1hs=@samcday.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fgx2iJzDd69+WFz1"
Content-Disposition: inline
In-Reply-To: <fBFdR32iMUBnz1xt4ThcZauDJSvuuDHGxDM160ek7-UCIG77hsz0xK9HKeW3kMgiQUJiYPUEuz9MeldVw_03Mg6iyvTrRheaf5oF-mIo1hs=@samcday.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--Fgx2iJzDd69+WFz1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 12:33:50PM +0000, Sam Day wrote:
> Hi Casey,
>=20
> On Tuesday, 9 June 2026 at 10:10 PM, Casey Connolly <casey.connolly@linar=
o.org> wrote:
>=20
> > Hi Simon,
> >=20
> > On 09/06/2026 01:31, Simon Glass wrote:
> > > Hi Casey,
> > >
> > > On Mon, 8 Jun 2026 at 12:06, Casey Connolly <casey.connolly@linaro.or=
g> wrote:
> > >>
> > >> Hi Simon,
> > >>
> > >> On 08/06/2026 19:13, Simon Glass wrote:
> > >>> Hi,
> > >>>
> > >>> I want to start a new thread to work through the issues which result
> > >>> in later versions of [1] moving to custom build rules instead of
> > >>> Binman.
> > >>>
> > >>> From what I understand there are some things unique to Qualcomm her=
e,
> > >>> as well as some general comments [2]
> > >>>
> > >>> Let's first get a list of the problems and then we can look at
> > >>> possible solutions.
> > >>
> > >> I wrote a whole big reply here but then I realised it was not likely=
 to
> > >> be productive, so I'll keep it short and sweet.
> > >>
> > >> For binman to make any sense to me, it would be a very simple fronte=
nd
> > >> and library for vendor/board specific image processing. Configuration
> > >> would be static and defined in the Python scripts, dynamic configura=
tion
> > >> is huge scope creep.
> > >>
> > >> If that's all binman was, and it was co-maintained and used by other
> > >> custodians then I would definitely see the value in using it to avoid
> > >> dealing with makefile fragments and other nonsense.
> > >>
> > >> Instead, it is a massive and overbearing "feature" that does stupid
> > >> stuff like pollute your boards DTB and ADD ADDITIONAL CODE TO U-BOOT
> > >> (which crashed for me btw). The moment I try to use a tool for
> > >> post-processing and it changes U-Boots runtime behaviour like this I=
 am
> > >> fully out. Choosing to design and implement something as overbearing=
 as
> > >> binman is just absurd, it prescribes a lot of functionality that I do
> > >> not want or need. I'm just not willing to invest so much time figuri=
ng
> > >> out how it works so I can fix it if it breaks something for my board=
s.
> > >>
> > >> As-is it seems much more appropriate to stay within my means and ens=
ure
> > >> that I feel confident that I can maintain whatever Qualcomm-specific
> > >> tooling we have. Vendoring a Python tool and making a tiny wrapper f=
or
> > >> it is just the plainly obvious solution, I know exactly how it works=
, I
> > >> can fix it if it breaks, and it doesn't fuck with my U-Boot image or=
 dtb.
> > >>
> > >> That you are so clouded by your own perspective that you feel the ne=
ed
> > >> to email me on the list to ask about problems with binman as if I
> > >> haven't already expressed myself clearly both in my mkmbn series and=
 on
> > >> irc (and as if comparing my patches doesn't reveal the issues) makes=
 it
> > >> quite clear that I'm much better off keeping CONFIG_BINMAN=3Dn
> > >
> > > Thanks for the candid response - I'd genuinely rather have the blunt
> > > version than a polite one that leaves the real objections unsaid.
> > >
> > > Starting a fresh thread wasn't meant to suggest you haven't already
> > > explained yourself; it was to give the topic enough focus to actually
> > > resolve it, rather than have it scattered across review comments and
> > > IRC. I've read the mkmbn series and I want to make sure I've
> > > understood the concerns correctly, so let me write them back to you as
> > > a problem list and you can tell me where I've got it wrong:
> > >
> > > 1. Binman is too large and prescriptive - what you want is a thin
> > > frontend/library, with configuration defined statically in Python
> > > rather than driven dynamically from the DT.
> > > 2. It modifies the board DTB, which you don't want it touching.
> > > 3. It adds code to the U-Boot image that changes runtime behaviour -
> > > and it crashed for you.
> > > 4. The maintenance cost is unacceptable: you can't be confident you
> > > can fix it yourself when it breaks one of your boards.
> > > 5. A vendored Python script with a small wrapper gives you full
> > > understanding and control, which a shared tool doesn't.
> >=20
> > Did you really just put my email through an LLM?
>=20
> Why are you jumping to this conclusion? I read Simon's response and didn'=
t get
> LLM vibes from it...
>=20
> Also, FWIW, point 5 seems like it has grammatical errors (though I am no
> English lit major!). Dunno if a machine would generate such a sentence.
>=20
> But anyway, more importantly, what parts of Simon's summary, LLM-generate=
d or no,
> do you agree or disagree with?
>=20
> I read Simon's distillation of your feedback to date, and found it to be
> quite succinct and reasonable.
>=20
> Whether you agree with the existence and/or usage of LLMs isn't really re=
levant
> here, is it? Simon began this thread attempting to solicit your concerns =
with
> binman so that we can connect that to tangible follow-up actions. Could we
> please focus on that?

I would find using an LLM to respond to this extremely rude, at minimum.
It says that someone can't be bothered to work on or engage with the
problem at hand. And I await Simon's answer, rather than further
speculating.


--=20
Tom

--Fgx2iJzDd69+WFz1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaigW3gAKCRAr4qD1Cr/k
CpEnAQCn3oedNye9IpNaXNv0okYTUAnBebP5CUq9wJxVlFdpzQEAs70Tgi55zeGG
vcZ0m2JBGJaPSHPSEKilN3bttZZAnQw=
=Wm6J
-----END PGP SIGNATURE-----

--Fgx2iJzDd69+WFz1--
