Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2549BC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 15:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 295F48056A;
	Sun, 16 Feb 2025 16:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BU8ywigL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA15B801B0; Sun, 16 Feb 2025 16:48:09 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A847801B0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 16:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2211acda7f6so11310065ad.3
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 07:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739720885; x=1740325685; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=us0GERDwYvsbmDvU6Xkn9VyUDU45V+U5jFsA1aQn5ms=;
 b=BU8ywigL2n1xhBcNCfAbCF5wTXkTRHx6W+8SLA3Z/m8B++5SqFRQ2GXUCVJwHz2qn8
 o4V2T02yNxKpZOy9IDbz4+7rlsOiI/ykCCOkFYBa6VerShzo7XQ5xy+Csy/yJb3beNSN
 KWxb3WDhoQIGAbfP1hj25BiNA6Bn+Owj+v6Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739720885; x=1740325685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=us0GERDwYvsbmDvU6Xkn9VyUDU45V+U5jFsA1aQn5ms=;
 b=jPzfQTVDumrvd4JpvqzO9L4MtBvviW2Eo7u78Qte3ooO0girzJXnohymB1p9xI9FSt
 kj7zNOk9ZDzVT0nf6YXw3eMIs0FhL7tqgw4mA6ghRMctKaFGOLwTNSR0oyHWtlV+DGZ5
 bdlRuso9xA9DlROjauNhgvhanA19ZrWKsuPrb71Chfvsu/RI5il14F6KiipNVIglZPz0
 Dl7VjD1D5cCJjTFRiOpbJdTBhJPAJuqEyo9t+6/1/SlNFFqWeZNgDkRX97SMj7Kg/zDY
 cqoJ65yYgYXRYNxPPZ009c4RF1YFAQCpmc9KbKFn4SMnQ0OtfPwZq/3JngmfPeAhnQMb
 uAJQ==
X-Gm-Message-State: AOJu0Yxr6AH11ZrxEpEV0oGzNir5h6YTXW7ilCcC+39TdFeRKN16rqir
 dgBcRk78RDoZRUiUA9nJkG/M7UijdJXgwlU2V71fPTqgLWAGJOEYvK5ci0XQ/uE=
X-Gm-Gg: ASbGnctrMmfrttzWaUAzUYlqrO0firf5Z1ecT+GevHPGKfVOudrttJlO6f1PITBcGn6
 SWSSQjIEINXMJqR9H16cTsxoKTcV63/vtxOv9GTiOpn27Og8Z3p/BrU11yldC5VSfIXyHbZ+MWb
 SLyAlz51G5d/oo5mpfYEDmvPbEsPg3buRvC3uIEU/m+PCEtC+HJx8F9PMNck2Mhbl4EFC3KWt2y
 Z5wL34s/pS4NaFMFK2dDxR7SEUz+urrai+3sSg4h0+l6pRZaTizDaEQwQ+bQe67C1gluGmg+e56
 p27XgykYvDVIxg==
X-Google-Smtp-Source: AGHT+IEt2R7FZdNLjkm3Lbzm6pAiavTO72AZydkOiW6ytk4inJEMU/eX2Ia04EMab1l56A7wnhe9cg==
X-Received: by 2002:a05:6a00:c87:b0:732:24ad:8e08 with SMTP id
 d2e1a72fcca58-73261776247mr8183427b3a.1.1739720885408; 
 Sun, 16 Feb 2025 07:48:05 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324277f28asm6403931b3a.163.2025.02.16.07.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 07:48:04 -0800 (PST)
Date: Sun, 16 Feb 2025 09:48:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
Message-ID: <20250216154801.GZ1233568@bill-the-cat>
References: <20250210143305.GA1233568@bill-the-cat>
 <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
 <20250211135944.GZ1233568@bill-the-cat>
 <CAFLszThU+r-F_OUSM2rWVScfvgBTSCjDzxrYi5iBaBh7WNqHKQ@mail.gmail.com>
 <CAFLszThvdHTKoV3aWMSNBEV6zeg_kO=ca=tK2RJe-Rf8_UYivQ@mail.gmail.com>
 <20250215150116.GS1233568@bill-the-cat>
 <CAFLszThi7DzdheY7Cp3zQSNsV-4a1GBvB=CVQczdyrXjBBuSOA@mail.gmail.com>
 <20250215182847.GW1233568@bill-the-cat>
 <CAFLszThDsf322WQ1GCSFNmj=41yhBhLEZisXEaSTyHYjzG6TmQ@mail.gmail.com>
 <20250216150123.GX1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AV+i4ybr5EPOYYUT"
Content-Disposition: inline
In-Reply-To: <20250216150123.GX1233568@bill-the-cat>
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


--AV+i4ybr5EPOYYUT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 09:01:23AM -0600, Tom Rini wrote:
> On Sun, Feb 16, 2025 at 07:10:31AM -0700, Simon Glass wrote:
> > Hi Tom,
> >=20
> > On Sat, 15 Feb 2025 at 11:28, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Feb 15, 2025 at 10:24:50AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 15 Feb 2025 at 08:01, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Feb 15, 2025 at 05:11:45AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sat, 15 Feb 2025 at 05:06, Simon Glass <sjg@chromium.org> wr=
ote:
> > > > > > >
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 11 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass w=
rote:
> > > > > > > > > >
> > > > > > > > > > > The logic of this has become too confusing.
> > > > > > > > > > >
> > > > > > > > > > > The primary issue with the patch is that U-Boot needs=
 to set up a
> > > > > > > > > > > bloblist in the first phase where BLOBLIST is enabled=
=2E Subsequent
> > > > > > > > > > > phases can then use that bloblist.
> > > > > > > > > > >
> > > > > > > > > > > But the first phase of U-Boot cannot assume that one =
exists.
> > > > > > > > > > >
> > > > > > > > > > > Reverting this commit seems like a better starting po=
int for getting
> > > > > > > > > > > things working for all use-cases.
> > > > > > > > > > >
> > > > > > > > > > > Note: The work to tidy this up is apparently underway=
=2E For this series,
> > > > > > > > > > > a revert is the easiest path.
> > > > > > > > > > >
> > > > > > > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f4=
3be41c3.
> > > > > > > > > > >
> > > > > > > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKX=
NniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > (no changes since v1)
> > > > > > > > > > >
> > > > > > > > > > >  common/bloblist.c  | 64 ++++++++++++++--------------=
------------------
> > > > > > > > > > >  include/bloblist.h | 10 --------
> > > > > > > > > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > > > > > > > > >
> > > > > > > > > > We aren't reverting this change so if you plan to move =
this series out of
> > > > > > > > > > your downstream fork you should start from that and sto=
p posting it,
> > > > > > > > > > that just leads to confusion.
> > > > > > > > >
> > > > > > > > > Who is 'we', and start from what?
> > > > > > > >
> > > > > > > > We, being the community, in here, the community mainline U-=
Boot project
> > > > > > > > tree.
> > > > > > > >
> > > > > > > > > My goal with this series is to have something that actual=
ly boots on a
> > > > > > > > > real board, so the bloblist changes are needed for that, =
particularly
> > > > > > > > > as the 'vbe' board in the lab tests this on the hardware.=
 I
> > > > > > > > > deliberately put these two patches at the end of the seri=
es so you can
> > > > > > > > > ignore them if you'd like.
> > > > > > > > >
> > > > > > > > > But for now, as I understand it, there are no users of st=
andard
> > > > > > > > > passage in tree, so actually it would be fine to apply th=
em.
> > > > > > > >
> > > > > > > > And you can ignore all the feedback you like for your downs=
tream fork,
> > > > > > > > sure.
> > > > > > > >
> > > > > > > > Part of the feedback in this series already was "Yes, we ca=
n clean this
> > > > > > > > up a bit more if bloblist will do its own thing instead".
> > > > > > >
> > > > > > > So I see that Raymond's patch is a significant rewrite of wha=
t is
> > > > > > > there today, with multiple aims and changes. I would rather a=
dd my
> > > > > > > revert and start from a cleaner place.
> > > > > >
> > > > > > Also, I forgot to mention that U-Boot doesn't seem to support t=
he
> > > > > > firmware handoff protocol in SPL? If so, could you point me to =
the
> > > > > > code?
> > > > >
> > > > > Yes, you never implemented handoff between stages in U-Boot via
> > > > > register. That's not a use case for the platforms that don't use =
U-Boot
> > > > > for SPL.
> > > >
> > > > If you let me own bloblist, I'll own it, but for now I am staying a=
way.
> > >
> > > Would you be working against mainline again, and not breaking standard
> > > passage (as it's been split off) ?
> >=20
> > Sure. The only reason I have my tree is because (I feel that) parts of
> > U-Boot have become no-go for me. So if you'd like me to maintain
> > bloblist again, I would be delighted to do so.
> >=20
> > Steps I see:
> > - Get my boards working again
>=20
> Already done. I'm waiting for Kever to pick up Jonas' small series that
> brings back output prior to that statement from DM.
>=20
> > - Add standard passage from SPL->PPL
>=20
> By who? PPL (and xPL) already reads standard passage via register.
>=20
> > - Figure out what to do on x86 to also use standard passage
>=20
> Standard passage, or bloblist?
>=20
> > I'm not quite sure that BLOBLIST_FIXED can be removed, as it needs
> > more thought. The phase that creates the bloblist initially needs to
> > know where to put it.
>=20
> When a phase is running it already has to know what memory is available
> right now or not, and can allocate as much of a list as it needs now.
> Later phases can move/grow it.

Actually, let me elaborate and then concede.

What I think the best design for BLOBLIST would be is:
- Uncouple "was I passed a bloblist" from "create a bloblist"
- Only allow passing bloblist via register(s).
- No bloblist contents can be globally mandatory until PPL.
  - Platforms may declare something mandatory (ie very first phase shall
    init certain clocks and hand that off to next stage) if necessary.
- A bloblist *should* be dynamically allocated but that's not required.

I believe this solves problems such as:
- We don't need OF_BLOBLIST because if we were not passed a bloblist we
  don't go and create one at a possibly inaccessible location.
- With fixed locations discouraged we wouldn't be forcing ourselves to
  choose between limited on-chip RAM or DRAM for everything prior to PPL
  relocating it.

With all that, if we untie standard passage from bloblist (and maybe we
want to revisit that in a year or two), bloblist can do what it likes so
long as standard passage isn't broken. And with it being uncoupled, it
should not get broken. I'll stop trying to convince you of a better
design.

--=20
Tom

--AV+i4ybr5EPOYYUT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeyCKYACgkQFHw5/5Y0
tyx4oAwAin1DlBxli6W2Ua0Jur2wVCWwFg1LSmAgyk0OhtWXr+UYTfd+9ZIKnsyS
IDMy1bGLDdfBbTBrnYqG2YLksYgzxaOfUcdGCeJvp5TFo8nvXcYl7J/Wszc3rblr
I5E6TFVcaPn1XDe85VP3zUHI7zzsxnZ15OdkdbhvF8Im7lRGIl5K451g9D6bvcHd
q9SqOHW8OwA1qKrHAXbIaHz4sHuxJ7ERFGKZyGItQwcKkZO23AdOh3YczxN2Ms36
XH+CiAi3TwBYWNeb5UkMvTaS3+jluP21ywmCJ5ptNrS26ZN3ZvUiR6kyp13DHaKe
D4Kf3KUXNBy1fX0U/N/WGA2schOIDdVjLYUcWB5XClE3Y3ia58rfNkx7/SI9rRCa
ZuKZv85UC9OFCDLp2qq5i58Wp21EgMwZvYclK3V6sgakRwBntwgAJLlGhv+JhW8Q
9ZF+fJhjzWIc6m4QLgZUUbfc8fduNWtJP0ETXnVMVdDyYR1ZawCqoJpO2DcgCO6+
fA1XL0o0
=29iq
-----END PGP SIGNATURE-----

--AV+i4ybr5EPOYYUT--
