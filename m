Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A71CD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 10:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 375DD84664;
	Mon, 18 May 2026 12:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=pbarker.dev header.i=@pbarker.dev header.b="mh0du7nm";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="BfHKeBtn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6821084664; Mon, 18 May 2026 12:10:56 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34B8B83FEE
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 12:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paul@pbarker.dev
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B2E387A00CF;
 Mon, 18 May 2026 06:10:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 18 May 2026 06:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1779099051; x=1779185451; bh=aJF4mbeTHA
 4sj46zntHpy3jGvrljoJc8eYh86jZqN1g=; b=mh0du7nmgpE0l00k2M1gZOm5jc
 agoEi8t7rtqv7r6GRmx0WkxUxw61pxa8e/HPPKn8/h50/TgNkXnmS44OXT+LVkOC
 aruv2RmDYNIh/MBfL11qkeMRdzDCzC0XtJlNRtOtcy5V4eJXApzAKXP5Dag+E89X
 sOkidmnBXlSTQrXeYhCCugZ2Gd0gGvr1QrI7hTVDvhQxyNMEK0oUtWgtalcNx/zV
 QiAqTQlk3uuICNE1VgzxFM3jQ5yaIpliSO01LrQMCkCC9iFyD4AK/B9suyaH6Age
 hXtHJhtemAbj93tx3BscKKAXZgijJwxstcz6v3fRF/f5BRXFCEJygtt1GLWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1779099051; x=1779185451; bh=aJF4mbeTHA4sj46zntHpy3jGvrljoJc8eYh
 86jZqN1g=; b=BfHKeBtnokEOdNT5HWTdlaJujSWqzb1d2+4IMS2vtFRjConZ+WY
 1lbeGOLIEQ7f9gfetfL413AqJNuE7EMJrEZzgrj9eOi6ih1+ODzAmDcg5KfIkjbw
 GbbGou02Fi1w/KKF6J9rN+F/oUra1rVL60aHYp5IFnNC9XVWEltZ3LEHcNN80sJg
 Kd5ixNtwMpYN/a7+XYT06qyLnIHZezu40lT5rXRbzR0D0EhIEqUHmGv8fGNNcYC9
 iJ8hCCeeioBurQTkeLLjm5bFSUU48WSlrDd4zgHiPULSzC32yCnbjNTTKGS902S9
 AL4eNGDzYvFCCROpobeNcNFB15OPacaFtFA==
X-ME-Sender: <xms:quUKahCBZykmiS5afCBoWUtvF8-yRJfIkwHdnYvZ93ZQ_87_PfD4Lg>
 <xme:quUKamY685RH6W0PuceCb0iAU5WeQ46qIg9WgoZIpSiT7Jry_IunX5rhJn4MFHHvW
 pgpWBJ0IhLs5UeXnKf-hZ9SUR892qU6AK4Z9lzBJ1xn9-rNBbozgp0>
X-ME-Received: <xmr:quUKak4UIt9jYY_KcBJkfY6n0GflDjt6gvvBYqHeZJ8uh5G8hajWFuED0eP517yTbJJM4vonUs666edngWjPiq55rQRZw6D44AkGBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekiedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdlqdeimdenucfjughrpefkuffhvfevffgjfhgtfgggsehgtderredtreej
 necuhfhrohhmpefrrghulhcuuegrrhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvg
 hvqeenucggtffrrghtthgvrhhnpedtudegueevheevjeejleeuudfhieekuefhkeegvdej
 keegtdfgveetleetjefhffenucffohhmrghinheptddurdhishdpnhhishhtrdhgohhvpd
 guvghngidruggvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
 rhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhopeehpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtgho
 mhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehuqd
 gsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopeihohgrnhhnrdgtohhn
 ghgrlhesshhmihhlvgdrfhhrpdhrtghpthhtohephhhonhhggihurdhjihgrseifihhnug
 hrihhvvghrrdgtohhm
X-ME-Proxy: <xmx:quUKanbjSYHC46NSUpB4SZWv3i8aMw4tvC39FDJ3hkx4LOfb_wxDNg>
 <xmx:quUKajiar6gdO3K8WEO9I4AWe-Uch-ZwmT-1Zgx9cf7cDnYBZa3qeQ>
 <xmx:quUKao9T71Z59a9KU8h_QFFSe1Y05eMdoIEl9rr1IirpANVGvZsrWQ>
 <xmx:quUKaupVBmnyHHxzsseQo34yYPHYX3_sml2ZuUj3aj_WQV9IpQFaSw>
 <xmx:q-UKavahHkQmdXL5qPjuKgbjErzVqgeAYxGVjvYYHXqoDTrM0hSASaXJ>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 06:10:50 -0400 (EDT)
Message-ID: <624edb010c76e59ef3e461fd487e25a2985c0089.camel@pbarker.dev>
Subject: Re: Status of CVE-2025-24857 in U-Boot
From: Paul Barker <paul@pbarker.dev>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, yoann.congal@smile.fr, Hongxu Jia
 <hongxu.jia@windriver.com>
Date: Mon, 18 May 2026 11:10:47 +0100
In-Reply-To: <20260512183611.GQ1858239@bill-the-cat>
References: <cb01c903e27bd1aa6198a51b138409c08abd3373.camel@pbarker.dev>
 <20260512183611.GQ1858239@bill-the-cat>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=mQINBGC756sBEADXL6cawsZRrDvICz9Y1SG0/lW1me4xpq36obh7a0IGAzp3ywNRb/4MO
 DTqP4+DD0cIFuDY41/N17g0sNlp8z+/k/IIDmNPtYQOTVmAkrkdDU4BP8dD3Cp1PUw6nrbInfujAJ
 NrVM0IVDkwKTbL2Nu1P+xns4MIpF9Kj4XN5celYJ9vEJ2n0Bo0nO5T5vg46dihIaDl+24iNIHSsHq
 YyEdMBfY8kY2RulpaAyFOuaaHdIeDkejVvO5xLSiYLjB5qrRhgH134lJXsuLOsFQ64ybGECuOasnb
 auevsPBAaroQW0pqVb9FneGrWHxMCLlQHJRqQJRdVa6bsUdp6NWra8/0msPawSrFwGQdfJBTA3aXJ
 C2CG1JxEgj6QQjEQA49DSjgzdhInbiIK8Vbp/zedM4aVue7qJnwPMTFQM9lYx63b7wLN4Tu8B9YZ0
 UFdSwMCJuqmYGsYRUYdwM3ArjS0VO6WpU+HBKvzLK5GQfUTSM8KaZ5eA2Uo2ain8SSZb+WptUYKpx
 F9jbtCPbjpZKzGuX4iHFl9eT75TM9iXJNGAjB5xigkADLwVfPoJ5E53S+KdNVuOWHugyLMPNAQHOw
 pw5Rey+0zxyzPd4wphutc93UIU5g/029ngAc7DuKCq12jl7fhkjqFlFtYPIc1k7nd+RSezmH/qRes
 bMErHSX1MBSZQARAQABtB5QYXVsIEJhcmtlciA8cGF1bEBwYmFya2VyLmRldj6JAlcEEwEIAEECGw
 EFCwkIBwIGFQoJCAsCBBYCAwECHgECF4ACGQEWIQSYsqrBAKw/grtdVGd0l1yBt+ZrrAUCaWoNAgU
 JCxiQFgAKCRB0l1yBt+ZrrLhdD/sH+qTaxCDUg47eW329yJWCDZmO+iuYzNSyHMs1x0DHKNIQQ8zN
 pA2S/de4jElQuPHjw/IS8B3VmM62Wuq5vHuxNlFv9IMwrwqi6zhCDui8+nCN/AQGGXousJI/SeZjm
 Y5gS9cqh4vNY+huqEEfdTFXIfTBRkmnvYozSO2uDB3EMuiWgBlw2uLrtmkvPLn/m/GvEouLNox6wv
 tcJcIbL59a0+3jv/m7pnWoZXOkWmKQnfFWikqjuKCISNU0gzBSL4UOj8gtQ2z+vu7ffi29b6SV5IL
 m1yzdbkigEn4HL44lz3N+oHZ3wWsRqqeyGSX5fCfx3tGWg6scZQrpsjT5yq+LiffiXVNpjeJ9KzQw
 0cbAZ/9uhk1sWBroP+/gMhsWjlbFYXVlRvkNKGPI22eZtOEz4jF6OrOONyOoY3i26niJUyIgdBpca
 H0hKUSVQ8VnG7qVTNrQk9BbeoSszqRwViN7lfyVtK9b1TCFuGewOETGn0TPvSzruYCtD3CLm7mjuX
 AMBpIGoRUiCFVmF1hlOgqDyH4F6zRTHhKLpfmNzfQcg+Uo147Q2IHpoh0mJsL4FEZEI8hFyecX1Pq
 7HqnvxGD2OhCof1Z6LDxptX0wbgocnYFNxN5S1owcXZUQOFnzYLlLugrcEjlGCm4Gn7k4SiFERSBj
 UFsQgIhw/7lVVn4o4rQjUGF1bCBCYXJrZXIgPHBhdWxAcGF1bGJhcmtlci5tZS51az6JAlQEEwEIA
 D4CGwEFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSYsqrBAKw/grtdVGd0l1yBt+ZrrAUCaWoNAw
 UJCxiQFgAKCRB0l1yBt+ZrrHy+EADNMt+ewz8H7BUKpEMMhpaA1VxyXO5IqlKXS0gElMgHYXl7L7C
 0/qLfRH96vwVD33zM+f0Vl9aWWkom/k8s42tLyPvX7D5zTrj3r5muJ+d9dXWGwBFXxXlE9YjSP26K
 bYfRusmRHbbEPlLPSnrr9KYS2FGVD6ViRNhhVguflgPv2i18+fNBE3YyByfNCiQgO/SgaSdh172Ql
 tuYE1Chk6FD45tCUv3dI9lO2PlVwrciiVYvIv/jiTDEwZOISOClTE/Ha18pxDJfLhS8QQnLWuBNX6
 HUkLi78fVmVYbcWIkTuSHjfNoGTMaFijMg9Wl6poFrY++Pl0S40681zEIrwZhW5pKoqXoaElt29Yf
 OwVo6BIsSOLEqKiWsdP7PJTaJYU1ovnshBcOmuXMgc13AjQ4AhEGqI1TaEJ/E1jEDDyTQFeWgrfew
 YaWdqpgiDmRMTj/tIGVj9iy7qZQICUUtlfm0QK6w6M7qq0GdO2o+S3uVF6y2AxQo8l9LSHiW9O35I
 juR37zeqv72puYyOteVYJsJaw999HUmhXc/X/J9FQFw8twxPKDLLu+w8MqDo9bhllzR93Zy/OShuG
 yGybcX3DKO2R+AQ90tXLbxKmHLtrnG/zyDPhLv/LGD480v5hEoT+IS0u9wPD2vP5q36a5DtzqXA/7
 t9PCamLoCvZLleg7GY7QbUGF1bCBCYXJrZXIgPHBhdWxAcGJya3IudWs+iQJeBDABCgBIFiEEmLKq
 wQCsP4K7XVRndJdcgbfma6wFAmlqDRwqHSBwYnJrci51ayBkb21haW4gd2lsbCBiZSBhbGxvd2VkI
 HRvIGxhcHNlAAoJEHSXXIG35muspk0P/1G08N6zGSdw2p8+8f/1HhaYEb9KdQHT1JmQfZUrIHIpD2
 ELNb91Z6Pz197d/igGpox1dzYOwE0WolWo44ZHX2yw+p9V+HJAUKRe0SPc1iNLkTzaAZ7oYJ1DnFh
 aaqZi4VtKKabKeorJjcDvl2apMwT0agRuDklU97n++ZUuXIEo1Z9uRqEvXz0iTSY7wPxwfoVOQsgf
 dN1cBLd9OpoOtJRdDJzQUYqjNoQi+5M6KRfBxPLZkmYb4uCGlp1H4AV50eC61j84LBg1ItvU2u+Fx
 X2JB7lHTswubprD2ZsSwp1VziU6pUj3vtslMWKpBGslpLtnaO561dihGyElayMd4VFg7VR/TsglJv
 A10EDs2DMhoYPfRQWvwlr5+jPP6s9H8KSTCGFvQt438rP/gk0lcEZUJK0iE2/yq5gQfaCNI5FLN7C
 q8LVr00oS4doXfmFFxMq6z1rs5SXZorWssjG7v5DILnPxLqYloQK/ebM5Ixbzm0Lq/8vWL7sw7yOH
 JVYCHCApGzKNii6rYyHdi0K8UwvpD++GCWLyvbgP/H3l5FqL63gAN0Rw1CO5r22+SmG7aOmekJH3N
 ChZPI3NMLnKZPJC8ZQZ4S8yb5oA3rqTA2DMODvsrEVlaB2cQ6IWHSa/mvBwA8Ias3771cp4fZS7W7
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-gbeM4mI9V04TnTUB85dx"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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


--=-gbeM4mI9V04TnTUB85dx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-12 at 12:36 -0600, Tom Rini wrote:
> On Tue, May 12, 2026 at 11:39:32AM +0100, Paul Barker wrote:
> > Hi folks,
> >=20
> > We recently had a patch sent to Yocto Project to backport a fix for
> > CVE-2025-24857 to our Scarthgap branch which uses U-Boot 2024.01.
> > Looking at the CVE info, this has confused me a lot. It says [1]:
> >=20
> >   Improper access control for volatile memory containing boot code in
> >   Universal Boot Loader (U-Boot) before 2017.11 and Qualcomm chips
> >   IPQ4019, IPQ5018, IPQ5322, IPQ6018, IPQ8064, IPQ8074, and IPQ9574
> >   could allow an attacker to execute arbitrary code.
> >=20
> > The NVD page says it affects U-Boot "Up to (excluding) 2017.11".
> >=20
> > But, the patch that says it addresses CVE-2025-24867 was committed to
> > U-Boot in December 2025 [2]. The first release containing this patch wa=
s
> > v2026.01.
> >=20
> > Is this commit actually needed to resolve that CVE? Or is it some other
> > change back in 2017 that fixed the issue? (A yes/no is fine, I don't
> > need a link to the exact commit)
> >=20
> > [1]: https://nvd.nist.gov/vuln/detail/CVE-2025-24857
> > [2]: https://source.denx.de/u-boot/u-boot/-/commit/87d85139a96a39429120=
cca838e739408ef971a2
>=20
> This is a "funny" one. The reference to v2017.11 is due to when we had a
> large rework of the FAT code and so the most obvious way to trigger the
> problem was removed. The changes in commit 87d85139a96a ("fs: fat:
> Perform sanity checks on getsize in get_fatent()") may, or may not, be
> only a sanity check against performing similar attacks. So yes, it would
> make sense for Scarthgap to have this change.

Hi Tom, Simon,

Thanks both for the replies with info on this!

We have accepted the backport of commit 87d85139a96a into our Scarthgap
stable branch so we should now be covered with both belt and braces.

Best regards,

--=20
Paul Barker


--=-gbeM4mI9V04TnTUB85dx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCagrlpxEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0blPvAQCLCEyAOcphn7wQXFW9Pd51+DQG5wFUU0aA
c7tEsPg0kAEAgL3OfulkI/I0s+ppY8z9GzI8+qgGxE3MvrCUznWs0gw=
=zdRa
-----END PGP SIGNATURE-----

--=-gbeM4mI9V04TnTUB85dx--
