Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2CEC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 14:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08D3B820FE;
	Thu,  3 Apr 2025 16:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X/07fm5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A52807B1; Thu,  3 Apr 2025 16:27:48 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E5E5810E8
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 16:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c1425fbfcso608284a34.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743690464; x=1744295264; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UQupQgkv1gm5nqDh5S/LrIaYMpx+XfZjvHyezbTJxHk=;
 b=X/07fm5LKLnikBqhIuG+Gnv7MP/FAUFE53/Q1L8YYLPLMPfAprLdVfTadYfpRjqOoH
 qToc7uHic6fU4LGq6P1aU81+2dkGLZ75+0rQb9twA0GZiid8zW21pbWf/VldqbxW9C4c
 OuxnoxoaUluadTPDVClCSiowHPUIKYrOjupCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743690464; x=1744295264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQupQgkv1gm5nqDh5S/LrIaYMpx+XfZjvHyezbTJxHk=;
 b=kMHLlxVJ3V+xg++yGjeRdh7mErtnY8jkJgBjUu5wSvEjePMhFTD4ZytwchZc4Mqg2+
 UxDIcquEIAt36PGxlQQSKRT4QbW+U5OTAdVr/4gFIsuTid24rgiyCc1TFRxdABP7gmVz
 qQ+9Og0eX8rwFYEUTcy0aLX9ddoqVYyeFVZ1jNf7RJTJNP/r9AYxjL6JKWDVyM5z2VKV
 WL6oql0uRIWVQyLU1pzfr/lTdegd9Dx8Rl0p8cYj/21Bgi89UMyJ+YgE35HmjebEKJWw
 HltmRn2ekK9V7FgfvoC0CtkNGDJc9HOkXJmZdK0IU9w7vS6NHkK167G0xjkcxALn+BlW
 xXtA==
X-Gm-Message-State: AOJu0YxRmh1845Tx6VYqjoohTGV2Xio5JDGEIYiDT9y9iwbW1rcwjXjh
 egFZDqEJNYHl4qMBa5qD7SxIjoTpMcAb/c/QSE5rzvygOdMOntD8DzP09GCdV5s=
X-Gm-Gg: ASbGncv8Eg3NHIUG9PwkUuajQP/muog7gDEUklZSSxpqxCSlLUSSdQhFK+VMUD/wdos
 YtIOIUdxsRFRHKtWILSPYZmBXRqIyiR3CXaarrkOlsjrY9o6PcdLoLt9zct1w73yljlg8ryPEa+
 At7iyKkCsEqtHDz/O+2Q5jEsNCH9jMtr0mlcaH5Hrp2mQTt1T+XGpaDtFm5vTTnn1WgxEfZfUPJ
 pF5xATa+VldpqADy83mXgGRubS4xxzBnvoYLCK2dwF+pN+OKF5SNhNcFBy3760xKiRbQ9w+fQ8Y
 Zj/zxqEpxu7u2cm4/gYT+OOcW73ICK+gfY69HQYlsb4jpizgfg8a+WkhEuiRGIOBMlQUIulKgAW
 5LdNtmw==
X-Google-Smtp-Source: AGHT+IE+RSmPBMslQsiZ01HVYmis80hU7kEtjCC3sxApsufUp/zY0h/E39bkXwHXbxBZGBBRupjyHA==
X-Received: by 2002:a05:6830:2115:b0:72b:9993:11a5 with SMTP id
 46e09a7af769-72c63793840mr14389113a34.9.1743690463588; 
 Thu, 03 Apr 2025 07:27:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e30500de7sm230666a34.8.2025.04.03.07.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 07:27:42 -0700 (PDT)
Date: Thu, 3 Apr 2025 08:27:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in
 the project)
Message-ID: <20250403142741.GJ5495@bill-the-cat>
References: <CAFLszTjv54tYLHkG=RNeXJoZ+f-QHxMH=B_aU2=iOZhaoD7qKg@mail.gmail.com>
 <20250307144631.GN2640854@bill-the-cat>
 <20250310155336.GJ2640854@bill-the-cat>
 <CAFLszTirohLrKadFfdw28UMfH7nt2owKHOGdf-ehwQqemQUpDA@mail.gmail.com>
 <20250331155144.GX93000@bill-the-cat>
 <CAFLszTjNXzkVe_OULMOtt2imSD5KY-KPMgxT7FA=fFqnm0aaeA@mail.gmail.com>
 <20250401171822.GM5495@bill-the-cat>
 <CAFLszTjzxXW_SdDMbjPKitgQ6HSv3Vse6ANrr5QEr85A1byyHg@mail.gmail.com>
 <20250402223534.GE5495@bill-the-cat>
 <CAFLszTiftx2RpeNdBmms8e=HZm2YqH_sjea7Ot1gyaSWAScivw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9FLQwGN0hsTuXAIT"
Content-Disposition: inline
In-Reply-To: <CAFLszTiftx2RpeNdBmms8e=HZm2YqH_sjea7Ot1gyaSWAScivw@mail.gmail.com>
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


--9FLQwGN0hsTuXAIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 12:55:38PM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 3 Apr 2025 at 11:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Apr 03, 2025 at 08:22:13AM +1300, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 2 Apr 2025 at 06:18, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Apr 02, 2025 at 04:45:37AM +1300, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 1 Apr 2025 at 04:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 28, 2025 at 11:42:20PM +0000, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 10 Mar 2025 at 09:53, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Mar 07, 2025 at 08:46:31AM -0600, Tom Rini wrote:
> > > > > > > > > On Thu, Mar 06, 2025 at 09:10:47AM -0700, Simon Glass wro=
te:
> > > > > > > > [snip]
> > > > > > > > > > Again, back to this thread, if you want me to migrate t=
hings, consider
> > > > > > > > > > applying the sunxi patches as I have described above. I=
 will then look
> > > > > > > > > > at the next target for bootstd. But while you hold this=
 up, I cannot
> > > > > > > > > > move forward with more bootstd migration. It doesn't se=
em that much to
> > > > > > > > > > ask.
> > > > > > > > >
> > > > > > > > > I will take another look at what's still relevant. But I =
believe it's
> > > > > > > > > still blocked on the fact that it changes behavior and br=
eaks users.
> > > > > > > >
> > > > > > > > In details:
> > > > > > > >
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/2024111315=
0938.1534931-2-sjg@chromium.org/
> > > > > > > >
> > > > > > > > Now that the underlying BLK problem is resolved, this can j=
ust be
> > > > > > > > dropped I believe. Removing the BLK dependency from BOOTSTD=
 can happen
> > > > > > > > when you're supporting a flow that lacks a BLK device entir=
ely. This
> > > > > > > > would be another reminder as to why putting unrelated chang=
es in a
> > > > > > > > series is a problem.
> > > > > > >
> > > > > > > OK, then just don't apply this patch. Problem solved?
> > > > > >
> > > > > > Well, for a hypothetical v6 you would not include it, sure.
> > > > > >
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/2024111315=
0938.1534931-3-sjg@chromium.org/
> > > > > > > >
> > > > > > > > This is fine.
> > > > > > > >
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/2024111315=
0938.1534931-4-sjg@chromium.org/
> > > > > > > >
> > > > > > > > This is not fine. This is also not a sunxi problem. It mean=
s that we
> > > > > > > > should drop bootmgr from rockchip, where the conversion has=
 already
> > > > > > > > taken place, and would need to drop it from future conversi=
on too.
> > > > > > > > Neither of which are desirable changes.
> > > > > > >
> > > > > > > Why do you say that? I don't understand how this relates to r=
ockchip
> > > > > > > or why we would need to drop bootmgr from that.
> > > > > >
> > > > > > Then you don't have enough of a grasp of the details of the are=
a you're
> > > > > > trying to solve problems in? Or maybe you need to refresh yours=
elf on
> > > > > > the details of the area you're trying to work in.
> > > > >
> > > > > Or perhaps there isn't a problem? The sunxi case is special becau=
se we
> > > > > have a FEL boothmeth. That isn't present on rockchip, for example.
> > > >
> > > > Again, you seem to have forgotten what the problems with the series
> > > > were.
> > >
> > > No, it's just that we disagree on the path forward.
> >
> > Then why did you bring up FEL? That's the part of the migration which is
> > NOT a problem, I keep being reminded when I ask.
>=20
> FEL needs to get priority, that's all. It was a problem until I
> adjusted the priority.

And there's been zero objection to this. So why are you mentioning it
here, in the discussion on why the migration is blocked. I know I had
been unsure, but I asked, and people answered, and I accepted the
answer.

> > > > > > > > This patch in particular is
> > > > > > > > where we have the note:
> > > > > > > >
> > > > > > > > "Yes, the introduction of boot standard changed the boot or=
der and
> > > > > > > > specifically deprioritizing scripts is unexpected."
> > > > > > > >
> > > > > > > > Which should have had more attention than it did.
> > > > > > >
> > > > > > > From memory the scripts are a fallback used when the other th=
ings
> > > > > > > don't work, so that was the decision I made at the time.
> > > > > >
> > > > > > The key point being we changed behavior that others depended on=
, and
> > > > > > didn't document it well and didn't make sure the change would w=
ork for
> > > > > > them either.
> > > > > >
> > > > > > > > This is the thread that to me spelled out in details where =
the
> > > > > > > > conversions are now blocked. We changed behavior and that i=
n turn breaks
> > > > > > > > users that have come to rely on ordering.
> > > > > > >
> > > > > > > I don't know what action to take on that comment. We cannot h=
ave 100%
> > > > > > > backwards compatibility with the scripts, which after all wer=
en't even
> > > > > > > documented. But it is very close.
> > > > > >
> > > > > > You need to get feedback from the people you want to migrate fr=
om the
> > > > > > scripts and ordering and rely on to something else and see what=
 works
> > > > > > for them.
> > > > > >
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/2024111315=
0938.1534931-5-sjg@chromium.org/
> > > > > > > >
> > > > > > > > Is an alternative to the above which then turned in to a di=
scussion that
> > > > > > > > I would very briefly summarize as "no discussions were had =
between
> > > > > > > > stakeholders before integrating efi bootmgr with bootstd".
> > > > > > > >
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/2024111315=
0938.1534931-6-sjg@chromium.org/
> > > > > > > >
> > > > > > > > This is fine, but only relevant once migration happens.
> > > > > > > >
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/2024111315=
0938.1534931-7-sjg@chromium.org/
> > > > > > > >
> > > > > > > > If Andre is fine with this, this is fine.
> > > > > > > >
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/2024111315=
0938.1534931-8-sjg@chromium.org/
> > > > > > > >
> > > > > > > > This is a generic bugfix. I will take this to next today.
> > > > > > > >
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/2024111315=
0938.1534931-9-sjg@chromium.org/
> > > > > > > >
> > > > > > > > If Andre is fine with this, this is fine.
> > > > > > >
> > > > > > > Well, is he? I thought he was. Can you check?
> > > > > >
> > > > > > You're free to. It's one of the innumerable examples of why whe=
n you
> > > > > > group multiple things in a series and there's problems with ano=
ther part
> > > > > > of the series, unrelated changes get dropped.
> > > > >
> > > > > It would be easier for me if you could apply the patches as I've =
suggested.
> > > > >
> > > > > But if you are willing to apply these patches and just want me to=
 send
> > > > > the series again without the BLK and RFC patches, I can do that.
> > > > > Please let me know either way.
> > > >
> > > > Again, you should:
> > > > - Take the non-bootstd sunxi enhancements, rebase them to next and =
post
> > > >   for Andre. By themselves. This way they won't get stuck.
> > >
> > > There's no point, though, since it doesn't provide the bootstd migrat=
ion.
> >
> > Are you saying there's no point in generally improving things if it
> > doesn't also involve one of your particular projects?
>=20
> The series is called 'bootstd: sunxi: Migrate to standard boot'. If
> you'd like to apply just the patches from that series which don't
> migrate sunxi to standard boot, please go ahead.

I'm not the sunxi custodian. General sunxi changes would go through that
tree. And then a repeat of everything I've said about how bundling
unrelated changes hurts everyone.

> > > > - You should work with Heinrich to come up with something that hand=
les
> > > >   efi bootmanager and bootstd without breaking how our actual proje=
ct
> > > >   users use us.
> > > >   There's no reason to migrate *more* platforms until we have this
> > > >   fundamental problem sorted out.
> > >
> > > It isn't actually a fundamental problem at all. We shouldn't even be
> > > discussing this and it is really unfortunate that you continue to
> > > block this effort.
> > >
> > > As to bootmgr, I would be willing to implement a solution here, but it
> > > would involve changes to how bootmgr works under the hood, i.e. to
> > > have it be iterative instead of doing everything at the start. My firm
> > > understanding is that such changes would not be acceptable to
> > > Ilias/Heinrich and anyway I am unable to get patches into the EFI
> > > subsystem.
> > >
> > > So the fallback is the work-around which Heinrich proposed. He is free
> > > to implement that if he likes, but I am not planning to do this myself
> > > as I see it as a short-term measure and it may cause problems for
> > > bootstd, as did f2bfa0cb1 which I bitterly regret allowing in (but I
> > > suppose they were happier days before everything froze up).
> > >
> > > > - You should work with any FOSS distributions to get their feedback=
 on
> > > >   what would make their life easier, from a user of U-Boot perspect=
ive.
> > > >   bootstd won't be useful if it's not something our users want to u=
se.
> > >
> > > Bootstd is designed to replace the distro scripts and the feedback I
> > > have received is that it is good at that. If you have any other
> > > feedback, or any suggestions on people I should contact, I'm happy to
> > > approach them, or they can email the list and cc me.
> > >
> > > But really, it would be a lot easier if you could just apply this
> > > series so we can move on. If I can see even just a glimmer of
> > > compromise here it will help my confidence.
> >
> > Your sunxi series is broken as posted. I am not interested in applying
> > or encouraging more bootstd usage until there's actual work being done
> > to move forward wit bootstd (a thing you want) and EFI (a thing most
> > distributions want). That would be some of the general feedback you've
> > been given and missed or forgotten.
> >
> > This is even setting aside that I can't recall now if you ever started
> > on making non-BOOTSTD_FULL more useful / usable in general because it's
> > so minimal that every conversion ends up also enabling BOOTSTD_FULL in
> > order to be flexible enough for users to decide SD vs eMMC and so on.
>=20
> You can hold this up for as long as you like, it's your tree.

And you can do whatever you like in your personal tree, sure. But
there's rules for working in a community project.

> I'm always happy and willing to discuss and commit to future
> improvements. The pattern I see, well-established now, is that you
> block my current improvements until some other things are done (this
> series, PXE and many others). Or sometimes you see my series, come up
> with a clean-up and block my series until it is based on top of that.
> If you could move away from that pattern and operate in a more
> cooperative manner, we could definitely get a lot more done in your
> tree.
>=20
> But again, you can hold this up as long as you like. I just feel it
> would be better for the project if you didn't.

I continue to not accept changes from anyone that knowingly break other
use cases and users. You are not an exception to the rule. Leaving
things broken for now and improving them later is not an option in
mainline.

And I ask everyone to fix problems that are exposed when they're doing
something else. Sometimes, when it comes to Kconfig symbols I'll end up
doing the cleanup because it's tricky to get things right for 1300
platforms.

--=20
Tom

--9FLQwGN0hsTuXAIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfumtYACgkQFHw5/5Y0
tyzlXQv9EkK0E7+CPuPnJQHPJqFNijsLPJzL+2eX8+oqRv7wHa84A2ZMQhPdJ30v
Hv+cN0VIfhIBJ3kC0p1RI/PGPibLrWwf/8ststFtxXyatjP0v3WKpHIZQiVVxORk
amwga0Tmyph0AT3aZP96ZS4C9fRmpoArXaxZnbyOTxDxzisH8cIBw6jPj2u/GgLf
Op9Qqcim/fcG0EAgWzfhsBpG/K6bYlf1gxyjJ2bfiVlirAGa1apKUNtuyRGZ8d/j
a27GXeT1c+phtG8Wib0PMUNMtxNyCtfOine7kX0ET6ncGzUTxVGCVU0sPSok67Es
gqLR1TZOC04XAYOFyAqZu6Wjf5h13V/gK+Ewnl0Q69VFR7VjcA5RdFcbpJkPHypf
/emVUM8A28El+/3HIZ6gezZXvxdUDPYOz1FldO1S8//9XW63p1UW1rBzANQj6lwF
lz4IN2CHRd9PvXed1Xule79EkmC2dvTLQhvEilQgO7ADsI5ZJsL04PGKRdQLQQNe
PrpQrkib
=VI3N
-----END PGP SIGNATURE-----

--9FLQwGN0hsTuXAIT--
