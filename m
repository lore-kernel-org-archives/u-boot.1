Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76532C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 20:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAA2580FB9;
	Tue, 11 Mar 2025 21:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IcTIHHXD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F17B1807D7; Tue, 11 Mar 2025 21:31:27 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3691580FB9
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 21:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7be8f28172dso388357585a.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741725081; x=1742329881; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f7JWlxtCrpkrq2Xmzyi64jROaW36Btkoet17H1mQ9L0=;
 b=IcTIHHXDYlt0v9hi+cY0p6/WbKtCSo6mvl2bAfO/gSVBmQ2s6bdq4wJcgKM3bBrNql
 bYxJAs8LX8RYsRBONdr0P8EX7wrJSjkSwryxRTigJ2RbVt+qTNlLiJ6foHdzLi7qXB62
 h1zTQBLWo2KZgSdA802crMCr61y5nrZHeufR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741725081; x=1742329881;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7JWlxtCrpkrq2Xmzyi64jROaW36Btkoet17H1mQ9L0=;
 b=Qi4k9wHWnvz0EpmyR8b+G7VRjE+t3x5ap0NHNG866T9MobEQMEwFXEEj4RZvxEY8nR
 NZeVeTZjA6K7VDwrJOkaeRhzq/NagG4lSkeyLHgBh+ljwcgYH0w+3OU/Gk3eq5JSB9Q3
 bQ9A4/ioUyWL5ZlweCrIB7LMNv3BbDEgWL/Isj4B6rT9M3PiTzdyZEZGzVHDCbsUnTZl
 wIjZvBz8GeZcq3oQXtLLQwWflLQKa7Etca4k9wkm6VyF+qU40QR8ux1KFPemXHXwQh3k
 Ouugld/e1+iEFjF0IrJptrH3WVwZhXRTh5xB3y/EGlJz13iwgnA9NbVfyAiFpokM/xjQ
 ZJoQ==
X-Gm-Message-State: AOJu0YynEVOUG+yXRzmjfuj/NwyJ8ezO8OJg2M7Ymo7pltoG64atY33X
 er01WqpAqLC3U2unMQn84vexPdSvr0a7B9jr5xzx/t2phcyHZw5p1TJ8KOcXhzyYyH+H5wvLmFz
 z
X-Gm-Gg: ASbGnctumjS96GzweA3LL903YlIzoCY47eieUyyAh5voTLMwVlmG29L04Yn7TRAKtyH
 2iSEQacl2f+KxkBBNhkUyJqU0eFnaSyFZfKpYdDsUb3+ugxUOWzcPEaKTEpH+jY5/2T61yQd+wb
 h4PLr/w8UING3hjTTfeu3RHDxGCb1H8WnMNtVGpCipbqEIFVVdKQjHdAJtILohvbPSuuG8O4BDK
 szn5FLx2lBWOY5TZXFURUQWrNmH40hByytGcG+8mlrPmKN2zECWuai0GrN6m0kStYV79skUQEQB
 OZGtaaF8p0XYucQaIR7sS4/51Scpl6po8TL2ZUkhdxSMJnmOLlZjcsUB
X-Google-Smtp-Source: AGHT+IGnqYFfKm/MB8n5/NEbFO+pA9oed1480ZaV0dQHYS9IgUT5vVBBq06o0s8YbTa43IoHn0xeyA==
X-Received: by 2002:a05:6214:1c48:b0:6e8:f0f8:6801 with SMTP id
 6a1803df08f44-6e900676e1amr264655486d6.22.1741725080678; 
 Tue, 11 Mar 2025 13:31:20 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47662dc1067sm50376921cf.56.2025.03.11.13.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 13:31:19 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:31:17 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.04-rc4 released
Message-ID: <20250311203117.GV2640854@bill-the-cat>
References: <20250310233215.GP2640854@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yucPmENeSdUV5ejC"
Content-Disposition: inline
In-Reply-To: <20250310233215.GP2640854@bill-the-cat>
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


--yucPmENeSdUV5ejC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 05:32:15PM -0600, Tom Rini wrote:

> Hey all,
>=20
> So it's release day and I have tagged and pushed things out. This will
> be merged to -next shortly.
>=20
> Continuing on with what I started after the -rc1 release, we had a call
> today and the link was
> https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280=
N2tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjB=
hYmQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83d=
e4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> March 11th, 2025. 9am (GMT -06:00)
>=20
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

Again, sorry for the confusion about when the meeting was. It was today
the 11th, and here are my notes. All errors are unintentionally my own.

As a general note, to try and reduce confusion it was suggested and I
will moving forward note that the calendar on https://www.u-boot.org/
has the meeting (and will show in local timezone) and just provide the
direct link and time.

- I noted that -rc4 was yesterday and we have one more rc before the
  April release. If anyone knows about regression fixes that are still
  outstanding, please speak up. On that note, Ilias noted that an issue
  recently was seen with small memory devices and EFI booting. It's
  likely a corner case that has always existed, and more debugging is
  required. If resolved in time and a reasonable fix, it should be
  included in the release.

- I moved on to stating that I had been talking with the Software
  Freedom Conservancy (SFC) about the U-Boot project moving to be under
  their umbrella for various reasons, and introduced Karen Sandler and
  Bradley Kuhn, from SFC that had joined the call and asked them to
  introduce themselves and SFC.
  - After that, we had a few questions / answers and I'm going to
    briefly summarize them here. Heinrich asked a few things about where
    SFC is located and how that might impact the project overall. Karen
    and Bradley confirmed that SFC is a US organization, but also that
    where servers exist physically matters more than where the
    organization is, with respect to export control and similar.
    Comparing SFC to Linux Foundation (LF), as a matter of US law, SFC
    is a "501c3" charity which needs to act in the public interest
    whereas LF is a 501c6 trade organization. This in turn means that
    SFC focuses on projects run by communities rather than big
    corporations. SFC does things like try and help projects to organize
    themselves, and when they have money figure out how to spend that
    money to better the project as a whole. Projects are not required to
    bring in more money than their overhead to the project requires for
    example. Andre Przywara asked if there would be any day to day
    changes to the project, for example how FSF until somewhat recently
    required copyright assignment. Bradley noted that there would not be
    and that for copyright specifically, they prefer the model that
    U-Boot already has. I mentioned that getting back to the differences
    between SFC and LF for example, the statement LF put out somewhat
    recently about US sanctions and open source projects differs from
    the opinion SFC has there and that I found the SFC opinion to be
    much more developer friendly. Bradley and Karen noted that SFC has a
    further post on this topic being worked on currently.

- I asked about new topics and Heinrich brought up the lengthy email
  chain between myself and Simon about speed of project development. As
  Simon wasn't on the call I didn't want to misrepresent him and his
  views and so tried to keep this somewhat brief. In sum, he and I have
  fundamental disagreements about the speed at which U-Boot should make
  changes. I believe we need to move slowly and deliberately and it's OK
  if migrations take quite a long time to complete because most people
  aren't testing every release, let alone every -rc. Heinrich asked if
  it would be helpful to document what migrations need to be done and
  what their deadlines are. I noted we have been doing some of these but
  some of the problems are that deadlines are years out, and then
  consequences another year out still, and I believe Simon believes
  this is too long. Heinrich brought up the example of bootstandard
  migration and I noted that yes, as the sunxi example shows I believe
  we have bigger problems there to resolve before we could set some
  deadline.
  - We had a small tangent about boot standard and upstream device trees
    and I noted that upstream schema is interested in taking what we
    have to offer, it's just a matter of doing it. The bootph-
    properties are a good example of how this has been solved in the
    past and can be solved moving forward.
  - Getting back to development speed, Andre noted this is side project
    for him and he doesn't have cycles for dealing with everything
    quickly enough sometimes. Taking a more "relaxed stand" makes sense
    for him. He does see this as something that Simon is very interested
    and invested in.
  - Heinrich noted it would be good for Simon to be on these calls and
    get feedback from the community on prioritizing tasks and similar. I
    agreed.
  - Ilias noted that with respect to how often / how many big changes
    come in per release, what a "big change" means needs to be defined.
    For example, the MMU changes he's working on, he did examine using
    the CPU uclass as Simon suggested, but then saw it's utilized on
    very few boards and so not useful for this feature.
  - I summarize the LED uclass as another example where he and I
    disagree.
  - Ilias noted migrations should be done by the introducer as much as
    is possible. I noted that Simon did that historically but was hoping
    more people would pick up and do them now. I noted that it's indeed
    hard and often thankless work to do those migrations blindly.
  - Ilias noted he's fine taking stuff that's in progress so long as it
    can all be logically and reasonably explained.
  - As Simon wasn't on the call, I wound this topic down at this point.

- Ilias asked how the MMU feature he's been working on should be enabled
  once it's merged as it finds code bugs, but also those bugs lead to
  crashes. After talking with Andre a bit, he's going to try out a few
  different allwinner SoCs with a number of peripherals to see what
  falls out. I noted that it looks like the generic problems have been
  found and patches posted, so it's going to be a per-SoC thing next and
  asked if TI can also try it out on K3 platforms, once merged.

- Heinrich asked if Allwinner D1 support will happen, and Andre said a
  number of people have asked but not a lot of developers. The ARM
  version of the chip is upstreamed, it's just the RISC-V side missing.
  Someone needs to step up and help on that side. Andre just lacks time.
  The next question is of how much long term interest there will be here
  as it could really end up as just a one time one-off.

- At this point I said we should wrap up the call and Karen noted that
  if there's more questions about SFC people should feel free to reach
  out to them. I noted that I still owe making a dedicated email thread
  about this and would soon.

- Heinrich asked if we would have a meeting two weeks after the release,
  during the merge window or not. I said I didn't know and Andre agreed
  it would be a good idea. So I will figure out making a one-off meeting
  for that.

--=20
Tom

--yucPmENeSdUV5ejC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfQnZEACgkQFHw5/5Y0
tyx47Qv9ELahFeAE+HBW8HGFqRdrOyYz0s2+HyBCdulxU8a3mS9plXDN89OYqrmO
P70MBhhvN+JaPBoo0Cn1QpmTikBlVsp3Ux/k77a5XUrFIqwRG1s8Ruw+gcTBE0rH
H9nrgjnREGsQoMQ5Z3xPLkVhnF6qVnLWLbQfhqsdPcT+IfyKlC4pP77whZ3CHeHk
Yl5wI4+GbZMRAiMLmuLtP+LY/lOxr73Lu/LvfdOPgMGmjWZwOznVntjeflcj348u
N55V7EmUUbU0so6qQkj7Z4ScCv5M64H5Py2GomM++HBZjyrari5za9MTtgjpBV1t
ppBP1vvyBLKX5/DlV4g5MDHJ0ObSs45LNzrvE7pMgoVQn5vyNcijTE/LwRB+DPFO
uX641lpGfQeiYuY7OzJ7osOC4FXkf4S/hEgSEYgQViqx4TgUXQkTqWb8dg7RP2zg
LEKaDp/DsfFszvx7Z2S5QhwiCzynUxSpSp2xpIJmfc58TBKcT/KRxfIfySpxVvCh
bQBAhyHF
=2E9R
-----END PGP SIGNATURE-----

--yucPmENeSdUV5ejC--
