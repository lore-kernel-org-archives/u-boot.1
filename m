Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970D4D0E6C5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 17:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B7918897F;
	Mon, 21 Oct 2024 19:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ngoe5edC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1FD688E91; Mon, 21 Oct 2024 19:16:32 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 421D788901
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 19:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c5acb785f2so26153366d6.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729530989; x=1730135789; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6da+hsiydiGRaVLj00DnD9FXvj40QIevxs0iPu6zpB0=;
 b=Ngoe5edCAyitqY32UHwY0ulBhk8UJP/O6sUkhsOM83g7Ifs97MspIUQRmoO4HR2od/
 2BuQxqNppYjhD7DL+zTFxYHMPYkWK5a5FansT4gpo7yOkYeMonCH23Gu1FQsAfUybeVr
 mYd1RcI0bQeqwQ6IyrDFEj0l22/mDejSX8/aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729530989; x=1730135789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6da+hsiydiGRaVLj00DnD9FXvj40QIevxs0iPu6zpB0=;
 b=wq3Hi7Beh2vJqAe9kOncKH33zqRhnYXQDmQwFczdWQYGOm9VjblC1FoVnckjX4VqkM
 ityfhDAVcrEW80otW8zQu2QS2USdhMQTSbBA2PLTk+7TQWzrudMBt6yu0qBH35yC2dfk
 asUlfAQ5cyN3dqdTji6Fj/Z38BqSMEcEk4GHo77YG8CWvApy5LD9As2dnoOMzxaPJ1Wd
 BdtLoon9KVhIQfxUpsLUtAZVzeeQxIYXiEBsepFHPilEkPIkAEZ8y0Xag30IhK38RXiI
 GxBViCPTi7vhdnSWmfuLNb+EHr1sYFvsRD7+PLj4dAFgrPWEfeDPfTPe7F57r1461FVW
 PcXg==
X-Gm-Message-State: AOJu0YwaWhoxzgCLotxtc0I7voflCIEiDXrsd0394/EhYxO0CXC5BDeb
 1TOwm5ZdFXohf+GXBkjop4rcu+TCMj6s+lpj3SCSvHGT5ZsVim13rJCMwOJDZJ8=
X-Google-Smtp-Source: AGHT+IF8nYfgUTJkhXsfFvJ4jG7s2q5ngPZEdnEtSq9vZdpAlnWwGZsnxrNchP5dOA9zXL++KivX4Q==
X-Received: by 2002:a0c:f905:0:b0:6cd:eed5:bfc1 with SMTP id
 6a1803df08f44-6cdeed5c04amr123351286d6.0.1729530989105; 
 Mon, 21 Oct 2024 10:16:29 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce00a03a97sm19610096d6.139.2024.10.21.10.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 10:16:28 -0700 (PDT)
Date: Mon, 21 Oct 2024 11:16:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>, Baocheng Su <baocheng.su@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>
Subject: Re: [PATCH 00/11] boards: siemens: iot2050: SM variant, sysinfo
 support, fixes & cleanups
Message-ID: <20241021171625.GL4959@bill-the-cat>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
 <20241019141655.GS4959@bill-the-cat>
 <2f1ea8b4-f8cb-4393-86b6-766cd6def6aa@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r/TxIijowdUvKwSi"
Content-Disposition: inline
In-Reply-To: <2f1ea8b4-f8cb-4393-86b6-766cd6def6aa@siemens.com>
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


--r/TxIijowdUvKwSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 08:21:09AM +0200, Jan Kiszka wrote:
> On 19.10.24 16:16, Tom Rini wrote:
> > On Thu, Oct 10, 2024 at 07:55:44AM +0200, Jan Kiszka wrote:
> >=20
> >> This series depends on:
> >> https://patchwork.ozlabs.org/project/uboot/patch/a54b501a-9a98-426c-a5=
ca-faf547411a30@siemens.com/
> >>
> >> This adds support for the new IOT2050 SM variant, introduces a sysinfo
> >> driver which also permits SMBIOS support and switches the board to
> >> OF_UPSTREAM. There are some further fixes for the boards included as w=
ell.
> >>
> >> Not yet included is configuration support for DMA isolation via the PV=
U as
> >> this depends on not yet merged DT bindings and another overlay.
> >>
> >> Not a merge-dependency but still needed to restore full support for the
> >> IOT2050:
> >> https://patchwork.ozlabs.org/project/uboot/patch/6c201a24-422a-41f7-84=
6c-1ad5b0ebc7e2@siemens.com/
> >=20
> > This currently fails to build on iot2050 on master, can you please
> > rebase and re-run CI? Thanks.
> >=20
>=20
> You need to update dts/upstream to recent 6.12-rcX. I thought that
> already happened long ago, but I might have confused 6.11 and 6.12, thus
> did not mention this dependency for switching to OF_UPSTREAM.

Ah yes, we're on v6.11 and won't hit v6.12 for our v2025.01, so please
use the cherry-pick option outlined in
https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing=
-with-devicetree-rebasing
to bring the required changes along for now, thanks.

--=20
Tom

--r/TxIijowdUvKwSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWjGEACgkQFHw5/5Y0
tyyksQwAnYsahp3cS9QgCZaKhBmlhDc8ALucgzZa5JIr3D0cO/t7WH970+RT2cYk
JvRjCLczj6aWC/2MqfpyLG8rbPL1OQLZyB/sInWcA4iP8mCn50VezcAPyR+A9m9/
1h54oN96b2sC9NkvFQXnDb44qa8oSn6nYGwLeUQQU+GqAQ5WveBjZ3xlVF4SOOmh
/Aro4hU1ElwrBU+kPafO3Jf0MJ8+w4tO04SrrpUanF0r8w7bTOffx43Ym7N1Cumk
YdQVXHo2B9gw87QYeb78phf2k18lBw2DUNCclkcyEKSsnMtpaQGt+EbVxYEOiFdC
hX6cLsONKgysp0m5NfqkYX9+CUQmK8wx61xvboj6UHWCEbUOnxKAItzgn06n7Jgk
J4B4ltKSL1H0Ln9UD15frZvHXlBeeqG9lwIkZnAhffmXradXr01RguqDm0GDBrDs
JRduenrLshjE89h0OGY15lbd0ZaaqcFe4j49u0TExPWoBJruk2H+Ey8ANNoKNhku
H51YYkC0
=IALr
-----END PGP SIGNATURE-----

--r/TxIijowdUvKwSi--
