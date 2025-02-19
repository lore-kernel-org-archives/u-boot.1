Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF20C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 15:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90732801BE;
	Wed, 19 Feb 2025 16:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TRMu1LJ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21439801DE; Wed, 19 Feb 2025 16:12:31 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 360D3800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 16:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220e83d65e5so113227685ad.1
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 07:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739977947; x=1740582747; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=peQ6J0p80FdIBuWoWzT6cSS8efFNMZUNmJ7IEowb2tU=;
 b=TRMu1LJ8drL4xwFA+K0a9rQfSohBe0uTl8sg0u/SMtF5/xeizyxihSzwIaZiQxMGrh
 w3raQKdc5RHl/YeNzBPnEdZZ+Diq/181erQYD6o81zpUQdQNYq8k5W3t2l5ioFVadZhU
 GvNrNJb8XDlLIA1BhfJ952q8pUvubBbMyp6xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739977947; x=1740582747;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=peQ6J0p80FdIBuWoWzT6cSS8efFNMZUNmJ7IEowb2tU=;
 b=nT5Ey0P202reWVMIhrVBjxdgILknOiKKzeOUsPh440Ou0z7bL1L+z7mOdSXmIyE7af
 6flaPc9h7wHXCequloilaZvS1Z3vHvvMkWJcJIJJAdWIJHCyRg5eJiCsZGbc1UDNAWCj
 xl/rQpcriyw5xCTuu6p4niCwUusOf2yRJNPtctLyTIASE4JjIANabBHma8xTlelapukK
 P6/zCvigSW0VbMx670g5jqH6zSaX2RX/t5hios639DIEUFOV245eNc43/jmPvkSouSqL
 GPqZvO61wn21sgi/APY9mXe2088TOLcWmretZlwMFWK++iAIgN+iw2gpvlcuk6pkvWoJ
 3pzg==
X-Gm-Message-State: AOJu0Yzh/WeebO0VzPJBhgHGGurRbdMTvocYSuxBH8QJRZAGyLoiC7n5
 nHIP0zRSHdK1rGM/Bk3T59B0fZ0LrQFdYxTrofI4Mvma8jRaAZBvefvxJaNk2Y79uxOX+wLmlSU
 o
X-Gm-Gg: ASbGnct8h10eCDXFLLHMrl0A02hQkTXNUUqaG9j1jjAHTa49ruxlLpUqk5WHvUkNwCq
 H7TRrkCrIiqLoUoy5rR3yg7yOv+qInVKdFmXqIO9M4n9qz7C1ATOe7F5J7OOU0JVwJTJyJnk3zU
 jdRNLvZXmv41wyucVlE28b1qBP9tReDMpNsP6NCikdfil/C/8bUo3mvhtVSvabkrexS34f3YDjV
 HH3/pvJ0IZ5J7gJt7cijNzWnBNCXs6VmOFA8RCnvbolYjGZpMUDKoUSj6LnEec1yzsViB08b5aq
 C0mcmj31H5v2kw==
X-Google-Smtp-Source: AGHT+IFXA9sGBnZOYRYcvK5azMQRtEGdgW4XJY5rjZHwZ+bp+8xiZUxyqQZPJFacak70vZPaWBZX+Q==
X-Received: by 2002:a05:6a00:4fc4:b0:730:7499:4036 with SMTP id
 d2e1a72fcca58-7329df28813mr6063761b3a.22.1739977946589; 
 Wed, 19 Feb 2025 07:12:26 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm11835431b3a.9.2025.02.19.07.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 07:12:25 -0800 (PST)
Date: Wed, 19 Feb 2025 09:12:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
Message-ID: <20250219151223.GU1233568@bill-the-cat>
References: <CAFLszThvdHTKoV3aWMSNBEV6zeg_kO=ca=tK2RJe-Rf8_UYivQ@mail.gmail.com>
 <20250215150116.GS1233568@bill-the-cat>
 <CAFLszThi7DzdheY7Cp3zQSNsV-4a1GBvB=CVQczdyrXjBBuSOA@mail.gmail.com>
 <20250215182847.GW1233568@bill-the-cat>
 <CAFLszThDsf322WQ1GCSFNmj=41yhBhLEZisXEaSTyHYjzG6TmQ@mail.gmail.com>
 <20250216150123.GX1233568@bill-the-cat>
 <20250216154801.GZ1233568@bill-the-cat>
 <CAFLszTgRaF-CLO=YN+9Uk3x-WMCg0LjTs3kUoxCwvcGe4F44-A@mail.gmail.com>
 <20250217141049.GI1233568@bill-the-cat>
 <CAFLszTigTn6EKXgFdyPi-6FK0bs7xxTN_qpox-pnf5T2tcfn=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SqnqomlN9+df/Qaz"
Content-Disposition: inline
In-Reply-To: <CAFLszTigTn6EKXgFdyPi-6FK0bs7xxTN_qpox-pnf5T2tcfn=g@mail.gmail.com>
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


--SqnqomlN9+df/Qaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 07:40:57AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 17 Feb 2025 at 07:10, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 17, 2025 at 06:15:19AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 16 Feb 2025 at 08:48, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Feb 16, 2025 at 09:01:23AM -0600, Tom Rini wrote:
> > > > > On Sun, Feb 16, 2025 at 07:10:31AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sat, 15 Feb 2025 at 11:28, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Sat, Feb 15, 2025 at 10:24:50AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Sat, 15 Feb 2025 at 08:01, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Sat, Feb 15, 2025 at 05:11:45AM -0700, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Sat, 15 Feb 2025 at 05:06, Simon Glass <sjg@chromium=
=2Eorg> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 11 Feb 2025 at 06:59, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The logic of this has become too confusing.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The primary issue with the patch is that U-Bo=
ot needs to set up a
> > > > > > > > > > > > > > > bloblist in the first phase where BLOBLIST is=
 enabled. Subsequent
> > > > > > > > > > > > > > > phases can then use that bloblist.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > But the first phase of U-Boot cannot assume t=
hat one exists.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Reverting this commit seems like a better sta=
rting point for getting
> > > > > > > > > > > > > > > things working for all use-cases.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Note: The work to tidy this up is apparently =
underway. For this series,
> > > > > > > > > > > > > > > a revert is the easiest path.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This reverts commit 66131310d8ff1ba228f989b41=
bd8812f43be41c3.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=
=3Df5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > (no changes since v1)
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >  common/bloblist.c  | 64 ++++++++++++++------=
--------------------------
> > > > > > > > > > > > > > >  include/bloblist.h | 10 --------
> > > > > > > > > > > > > > >  2 files changed, 19 insertions(+), 55 deleti=
ons(-)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > We aren't reverting this change so if you plan =
to move this series out of
> > > > > > > > > > > > > > your downstream fork you should start from that=
 and stop posting it,
> > > > > > > > > > > > > > that just leads to confusion.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Who is 'we', and start from what?
> > > > > > > > > > > >
> > > > > > > > > > > > We, being the community, in here, the community mai=
nline U-Boot project
> > > > > > > > > > > > tree.
> > > > > > > > > > > >
> > > > > > > > > > > > > My goal with this series is to have something tha=
t actually boots on a
> > > > > > > > > > > > > real board, so the bloblist changes are needed fo=
r that, particularly
> > > > > > > > > > > > > as the 'vbe' board in the lab tests this on the h=
ardware. I
> > > > > > > > > > > > > deliberately put these two patches at the end of =
the series so you can
> > > > > > > > > > > > > ignore them if you'd like.
> > > > > > > > > > > > >
> > > > > > > > > > > > > But for now, as I understand it, there are no use=
rs of standard
> > > > > > > > > > > > > passage in tree, so actually it would be fine to =
apply them.
> > > > > > > > > > > >
> > > > > > > > > > > > And you can ignore all the feedback you like for yo=
ur downstream fork,
> > > > > > > > > > > > sure.
> > > > > > > > > > > >
> > > > > > > > > > > > Part of the feedback in this series already was "Ye=
s, we can clean this
> > > > > > > > > > > > up a bit more if bloblist will do its own thing ins=
tead".
> > > > > > > > > > >
> > > > > > > > > > > So I see that Raymond's patch is a significant rewrit=
e of what is
> > > > > > > > > > > there today, with multiple aims and changes. I would =
rather add my
> > > > > > > > > > > revert and start from a cleaner place.
> > > > > > > > > >
> > > > > > > > > > Also, I forgot to mention that U-Boot doesn't seem to s=
upport the
> > > > > > > > > > firmware handoff protocol in SPL? If so, could you poin=
t me to the
> > > > > > > > > > code?
> > > > > > > > >
> > > > > > > > > Yes, you never implemented handoff between stages in U-Bo=
ot via
> > > > > > > > > register. That's not a use case for the platforms that do=
n't use U-Boot
> > > > > > > > > for SPL.
> > > > > > > >
> > > > > > > > If you let me own bloblist, I'll own it, but for now I am s=
taying away.
> > > > > > >
> > > > > > > Would you be working against mainline again, and not breaking=
 standard
> > > > > > > passage (as it's been split off) ?
> > > > > >
> > > > > > Sure. The only reason I have my tree is because (I feel that) p=
arts of
> > > > > > U-Boot have become no-go for me. So if you'd like me to maintain
> > > > > > bloblist again, I would be delighted to do so.
> > > > > >
> > > > > > Steps I see:
> > > > > > - Get my boards working again
> > > > >
> > > > > Already done. I'm waiting for Kever to pick up Jonas' small serie=
s that
> > > > > brings back output prior to that statement from DM.
> > > > >
> > > > > > - Add standard passage from SPL->PPL
> > > > >
> > > > > By who? PPL (and xPL) already reads standard passage via register.
> > > > >
> > > > > > - Figure out what to do on x86 to also use standard passage
> > > > >
> > > > > Standard passage, or bloblist?
> > > > >
> > > > > > I'm not quite sure that BLOBLIST_FIXED can be removed, as it ne=
eds
> > > > > > more thought. The phase that creates the bloblist initially nee=
ds to
> > > > > > know where to put it.
> > > > >
> > > > > When a phase is running it already has to know what memory is ava=
ilable
> > > > > right now or not, and can allocate as much of a list as it needs =
now.
> > > > > Later phases can move/grow it.
> > > >
> > > > Actually, let me elaborate and then concede.
> > > >
> > > > What I think the best design for BLOBLIST would be is:
> > > > - Uncouple "was I passed a bloblist" from "create a bloblist"
> > > > - Only allow passing bloblist via register(s).
> > > > - No bloblist contents can be globally mandatory until PPL.
> > > >   - Platforms may declare something mandatory (ie very first phase =
shall
> > > >     init certain clocks and hand that off to next stage) if necessa=
ry.
> > > > - A bloblist *should* be dynamically allocated but that's not requi=
red.
> > > >
> > > > I believe this solves problems such as:
> > > > - We don't need OF_BLOBLIST because if we were not passed a bloblis=
t we
> > > >   don't go and create one at a possibly inaccessible location.
> > > > - With fixed locations discouraged we wouldn't be forcing ourselves=
 to
> > > >   choose between limited on-chip RAM or DRAM for everything prior t=
o PPL
> > > >   relocating it.
> > > >
> > > > With all that, if we untie standard passage from bloblist (and mayb=
e we
> > > > want to revisit that in a year or two), bloblist can do what it lik=
es so
> > > > long as standard passage isn't broken. And with it being uncoupled,=
 it
> > > > should not get broken. I'll stop trying to convince you of a better
> > > > design.
> > >
> > > If you can convince people to let me act as maintainer (with the final
> > > say) for bloblist then I'm happy to do so and I can work towards the
> > > design above.
> > >
> > > I think we have the same end point, but perhaps disagree on whether it
> > > all needs to be done at once. The only question I have is about the
> > > 'mandatory' stuff. I worry that this is an attempt to make it
> > > impossible for U-Boot to use its own devicetree, even as an option. So
> > > long as it isn't, fine.
> > >
> > > My general issue with bloblist is that it has been broken for me for
> > > over a year and it just takes too much energy to get changes in. The
> > > OF_BLOBLIST thing was just the worst and I would rather not repeat it.
> > > I just looked at your tree and there is no OF_BLOBLIST.
> >
> > If you're willing to let "standard passage" alone, I'll let you do
> > whatever you like with "bloblist". I too am tired of re-hashing
> > everything about OF_BLOBLIST.
>=20
> That's fine, yes I will make sure standard passage stays working. If
> you could find your way to allowing OF_BLOBLIST I could do that too.

Part of splitting "bloblist" off from "standard passage" and outlining
what I think would be a better "bloblist" design is that sure, we don't
need OF_BLOBLIST except for when we say the bloblist exist in a fixed
address in a point in memory that may not be available and we neither
safely probe nor separate "check" from "create" but, fine, have
OF_BLOBLIST.

I'm putting Raymond's series to split the two through CI today, for
-next, so you can start on top of that later today or tomorrow.

--=20
Tom

--SqnqomlN9+df/Qaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme19M8ACgkQFHw5/5Y0
tyx+Kwv/UkqkjqZfC7HcCFGl9g+cv8FK3quxuvGuwmW/StQzuMSeATk7AzaoeXyx
11u30idacu6Y63YWysT0cr2P/shL3yPVADTR7wpkDoNl18WhT3ziezfR7nHQo63a
6QhZ4PGRQ36YIz+I2bgL6zuFmBAJgkuwWkE8YFsEp1Ub03vcKudqdmBGWTvxwjiq
OzRB/DpciCs3RBjpiggJI44KD8ViiL/03rcQsKURe0EMFpqhJSX2LDZEfh2jYoX9
H5Er6mMh4Ou/8gxGAPUf54lK6JileHBpTmzlfMTeoSg5Syq+a7CEkXAmHvLcMJ4U
1l2UEf0fpnxfeR/rjbFussjI8Ok82Kq6MOFMY6MEMyBt171pU04p/mCC5oy7iAAt
WBID28hpR9OEWhlplfnCsadecEZVYREG8F3/ItA9HkPBy/53DQcwkXlzzvImoaqS
5Jj8BrOnLbXGbLr8aXeiV29QvzmaEG3a8TBG2q4fa4sGIwiV0TQlFVhg1T2fM9XV
JA8hoNLJ
=z70u
-----END PGP SIGNATURE-----

--SqnqomlN9+df/Qaz--
