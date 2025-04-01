Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9870C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4747C817C4;
	Tue,  1 Apr 2025 19:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uGaYt9XF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13BEA81F59; Tue,  1 Apr 2025 19:18:29 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F438817C4
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72a4793d4e2so3648625a34.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743527905; x=1744132705; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+R2Yx5tXVtF4cn8Fs1+Da5PpazdwXQHQ4Vrpy6OsVDI=;
 b=uGaYt9XFsqNcE9A6Ztrl+idKhiH+sOq1SBtcVV6JeW8s7gCFiYOrmbULEefMKv5+dH
 Vpqac7dnPtOjOy5VddkFvlaUnBlxUgC4XaDLleCRZtX09wAxy6oRrWP38ZOWzTB4mb7O
 evmZjh3wlnRrUXDzVu1P3i82nG94k0mZwhuYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743527905; x=1744132705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+R2Yx5tXVtF4cn8Fs1+Da5PpazdwXQHQ4Vrpy6OsVDI=;
 b=AXG6ISkJvU6JgLhJ6cbOCS4CzalYoRPU5FFiXpjz1OFJ252YyW+bFS95w3qc6DBGCL
 m+SeD6olsKUi2KNJk9ebTzhYrutwJfWHhmAa5IV/Fm72jSR1fY8mS6yTOwHm9Fvuk3jf
 YhKX8qC3ytLgioHtvmgjeOXhHcvgzEPCxo/GhZpEyBdjWjMInlSeCic9Fwo1butJkqgJ
 1derTPor+F70f9yc7cQhaR0IuchvtxLVfGIOMatM6HK6Ju3vv0tbT3kS364sGjWxE9lK
 CVPdGG90Z6nob49SafmwyJoWnJBlDGrlkWiX4RtPHLcvfy1+5e4pG/q+JDzGd8TxJ587
 N5Zg==
X-Gm-Message-State: AOJu0Yz0iHNj24RPz5h929L2MBeD+nNaBgh0+JaykImN7ni9EOz5vZj5
 8rZlGn61Pc06Pb310jxX69qAQdBcHZjif+XqsFssH+7wTl0KZ5hCGTzvegX67jdpzuNl/3VFnNq
 C
X-Gm-Gg: ASbGncto2gD3Sxgq4dt9WXcDmzAC/sD9y7AXj6uSbyLj7EYNo+5uckLkYCwAhs06Wmq
 f2268b/d0vWSLPfNN74539PWeNwAsiChrE8gHlgL9SFnHC00aC0ljREzJtYkExsZ7Fw5azlRj+y
 YOV4rPd/Hqmo/E8HqEsEGRc4MjCivnSG7cZT/odimrIrwsKox4KpK0n38znU+pm7rzcObHoXE9H
 nWbLfuPIfz6nVAH1Hghrk/ci8sRtfkjgl31jFhf1PPHwqkfhjgyKi0uBhbWtMJujmb2Tb8+1oZe
 M+wtg3HH3XzKXw0iakemDhhKbgL7JcTE/cJ0t7AJ3rBCqgr7UO+tHaFyAxr5u7Nq2wEc+u5X98t
 BtKRapg==
X-Google-Smtp-Source: AGHT+IHYFj56bpA+Sq6pGTU1Onqk0Xee3B5dqHQKt20FFH9GS9KbpoOEsI/Ms0iKUeIMjaO51V1dZw==
X-Received: by 2002:a05:6830:6611:b0:72b:8aec:fbd4 with SMTP id
 46e09a7af769-72dae59c9ebmr2480796a34.3.1743527904972; 
 Tue, 01 Apr 2025 10:18:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5809253csm1945049a34.4.2025.04.01.10.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:18:24 -0700 (PDT)
Date: Tue, 1 Apr 2025 11:18:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in
 the project)
Message-ID: <20250401171822.GM5495@bill-the-cat>
References: <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
 <20250304152909.GZ2640854@bill-the-cat>
 <CAFLszTiNQSs51iE=rcM7qQjipmWCKZiPX+gV2ztb+ZAB8m2MBw@mail.gmail.com>
 <20250305162236.GT2640854@bill-the-cat>
 <CAFLszTjv54tYLHkG=RNeXJoZ+f-QHxMH=B_aU2=iOZhaoD7qKg@mail.gmail.com>
 <20250307144631.GN2640854@bill-the-cat>
 <20250310155336.GJ2640854@bill-the-cat>
 <CAFLszTirohLrKadFfdw28UMfH7nt2owKHOGdf-ehwQqemQUpDA@mail.gmail.com>
 <20250331155144.GX93000@bill-the-cat>
 <CAFLszTjNXzkVe_OULMOtt2imSD5KY-KPMgxT7FA=fFqnm0aaeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cgieTQqlOWE5wjcD"
Content-Disposition: inline
In-Reply-To: <CAFLszTjNXzkVe_OULMOtt2imSD5KY-KPMgxT7FA=fFqnm0aaeA@mail.gmail.com>
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


--cgieTQqlOWE5wjcD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 04:45:37AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 1 Apr 2025 at 04:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Mar 28, 2025 at 11:42:20PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 10 Mar 2025 at 09:53, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Mar 07, 2025 at 08:46:31AM -0600, Tom Rini wrote:
> > > > > On Thu, Mar 06, 2025 at 09:10:47AM -0700, Simon Glass wrote:
> > > > [snip]
> > > > > > Again, back to this thread, if you want me to migrate things, c=
onsider
> > > > > > applying the sunxi patches as I have described above. I will th=
en look
> > > > > > at the next target for bootstd. But while you hold this up, I c=
annot
> > > > > > move forward with more bootstd migration. It doesn't seem that =
much to
> > > > > > ask.
> > > > >
> > > > > I will take another look at what's still relevant. But I believe =
it's
> > > > > still blocked on the fact that it changes behavior and breaks use=
rs.
> > > >
> > > > In details:
> > > >
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.153=
4931-2-sjg@chromium.org/
> > > >
> > > > Now that the underlying BLK problem is resolved, this can just be
> > > > dropped I believe. Removing the BLK dependency from BOOTSTD can hap=
pen
> > > > when you're supporting a flow that lacks a BLK device entirely. This
> > > > would be another reminder as to why putting unrelated changes in a
> > > > series is a problem.
> > >
> > > OK, then just don't apply this patch. Problem solved?
> >
> > Well, for a hypothetical v6 you would not include it, sure.
> >
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.153=
4931-3-sjg@chromium.org/
> > > >
> > > > This is fine.
> > > >
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.153=
4931-4-sjg@chromium.org/
> > > >
> > > > This is not fine. This is also not a sunxi problem. It means that we
> > > > should drop bootmgr from rockchip, where the conversion has already
> > > > taken place, and would need to drop it from future conversion too.
> > > > Neither of which are desirable changes.
> > >
> > > Why do you say that? I don't understand how this relates to rockchip
> > > or why we would need to drop bootmgr from that.
> >
> > Then you don't have enough of a grasp of the details of the area you're
> > trying to solve problems in? Or maybe you need to refresh yourself on
> > the details of the area you're trying to work in.
>=20
> Or perhaps there isn't a problem? The sunxi case is special because we
> have a FEL boothmeth. That isn't present on rockchip, for example.

Again, you seem to have forgotten what the problems with the series
were.

> > > > This patch in particular is
> > > > where we have the note:
> > > >
> > > > "Yes, the introduction of boot standard changed the boot order and
> > > > specifically deprioritizing scripts is unexpected."
> > > >
> > > > Which should have had more attention than it did.
> > >
> > > From memory the scripts are a fallback used when the other things
> > > don't work, so that was the decision I made at the time.
> >
> > The key point being we changed behavior that others depended on, and
> > didn't document it well and didn't make sure the change would work for
> > them either.
> >
> > > > This is the thread that to me spelled out in details where the
> > > > conversions are now blocked. We changed behavior and that in turn b=
reaks
> > > > users that have come to rely on ordering.
> > >
> > > I don't know what action to take on that comment. We cannot have 100%
> > > backwards compatibility with the scripts, which after all weren't even
> > > documented. But it is very close.
> >
> > You need to get feedback from the people you want to migrate from the
> > scripts and ordering and rely on to something else and see what works
> > for them.
> >
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.153=
4931-5-sjg@chromium.org/
> > > >
> > > > Is an alternative to the above which then turned in to a discussion=
 that
> > > > I would very briefly summarize as "no discussions were had between
> > > > stakeholders before integrating efi bootmgr with bootstd".
> > > >
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.153=
4931-6-sjg@chromium.org/
> > > >
> > > > This is fine, but only relevant once migration happens.
> > > >
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.153=
4931-7-sjg@chromium.org/
> > > >
> > > > If Andre is fine with this, this is fine.
> > > >
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.153=
4931-8-sjg@chromium.org/
> > > >
> > > > This is a generic bugfix. I will take this to next today.
> > > >
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.153=
4931-9-sjg@chromium.org/
> > > >
> > > > If Andre is fine with this, this is fine.
> > >
> > > Well, is he? I thought he was. Can you check?
> >
> > You're free to. It's one of the innumerable examples of why when you
> > group multiple things in a series and there's problems with another part
> > of the series, unrelated changes get dropped.
>=20
> It would be easier for me if you could apply the patches as I've suggeste=
d.
>=20
> But if you are willing to apply these patches and just want me to send
> the series again without the BLK and RFC patches, I can do that.
> Please let me know either way.

Again, you should:
- Take the non-bootstd sunxi enhancements, rebase them to next and post
  for Andre. By themselves. This way they won't get stuck.
- You should work with Heinrich to come up with something that handles
  efi bootmanager and bootstd without breaking how our actual project
  users use us.
  There's no reason to migrate *more* platforms until we have this
  fundamental problem sorted out.
- You should work with any FOSS distributions to get their feedback on
  what would make their life easier, from a user of U-Boot perspective.
  bootstd won't be useful if it's not something our users want to use.

--=20
Tom

--cgieTQqlOWE5wjcD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfsH94ACgkQFHw5/5Y0
tyxxWwwAsOSB+QA0uydM9K3kRbsnvuKhslOmgQYcACWJOt6u8y8DTQno9NQLrBEj
2DlrMYwNGOSuTGYMR7D3AzItdxf8dCKwr8PfUVHJj+KNPH4d1X6lBN6NhcoDHxF9
fV4FkogRTtNi3+94Q1T0p9WyHKUEtGi4SrKl4AUw/JKFi/S+LGUZhHk+b5eXeH7H
5y63IpZta/iB/I2jTOzb/Va4ZpzvGUkdLfhEd43tzkDogvqCIVYSV9h5+XabcewL
QUBUf8yl0jlu2RCpqTfTZUcnGBGr2IE38VEHkOfIW7CSvM4r95M2UAUXBhg4qe6p
85GiXMJeQJz14N6ri7nrWxH/WQqhBlHA0xX35p5nBTp061abrXLkn7+AE6rqUXbZ
BA25k2HAb/WUC5qUBEozMgNPW5xJisnvyL4NXdsk88NkEYTza523KovtAG8lFhgj
41Rpnqbs/rY/XZbXPmXlIxbZL3anudT4a/FmV/NQl0qKPyEmJte0MyoCw0VsdZpi
XwLk37Ga
=yONC
-----END PGP SIGNATURE-----

--cgieTQqlOWE5wjcD--
