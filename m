Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83281CD98F2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 17:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95246846B0;
	Wed, 17 Jun 2026 19:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VJiuZwf4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A762C84833; Wed, 17 Jun 2026 19:27:01 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D348460E
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 19:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-69d8f70cb0cso45262eaf.0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781717217; x=1782322017; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zhmg61tdO/oOnYaMBB6weWuziKmRNWkkqHQqgRsAE9g=;
 b=VJiuZwf4DjeU43PcRXOTy1gLbI/d79A1wH70iFPb5rp22j3rCm2swnwRNo10jjJM3/
 QkUAv18WPXEeRWM2kXDFhB0vxs0iQAXvTKeN9UudTHvZulhoM1C1WswC95UrYiggEpn/
 IvGVnnIOhA0IgPd/qeL7ElTyw8vydk2Al7V1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781717217; x=1782322017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhmg61tdO/oOnYaMBB6weWuziKmRNWkkqHQqgRsAE9g=;
 b=XZQk67wTXevW0GDRJ+1W5+7dn0bP26n8SZamTtQOLDXct2gHAbORWl2rVcNk/7+NIo
 XJpFp+7sOE/qhuAyu5msQfef7FB+I8nbV6mGA4LQBRbLhgXlVylToDKOye1VstEvZVEx
 v/2FkZvfB7tvrgyDmqK2Zqhe7H5kLrMFHd3Zw+c5l5+f35mptYBWN1ZA/nN75usd5AiE
 Levv7YtuKSBvBW9T5uzQclMleK6YmRWt+RQ2nM73xpnmxcEAK5VioHpEhGCYN0kSLtYY
 LPjkptZNoG4BrK9RCUIphFse4iQpIiUypdA//EWyHHhEWvjXdx4G23YhtZuHWEIkRe0l
 mGZQ==
X-Gm-Message-State: AOJu0Yx8vi8k9c1NE8iHnXUBmqTwzyH91ltyeUxbRQQecL25qfOoQNjo
 2hHXxLTkDs4a+oOCJgjppDRD3Lf0mZaBJRC5wsqTHQUwelhoPnWyFBTMLsfvuJf+1H8=
X-Gm-Gg: Acq92OEAW95FdqbpKmOvERvq2omM6/LrjOwOa+GjlOkOG+2Cf5ZmhMSi5z0ioRKNYQc
 Gpgwn/No5vtTK0bykR8iyI80/Zuyhsn9Ah+zWiJzvalXrTBIvJYNAI9KHHM6CL8gglc0vxpX4VZ
 53XJjjH/bPP3wOnL2vOBxKt5XX/DudHfNsaHrgdilo4FkLGHyIAzHxp4QnK11kwATrKD/ljxE/B
 nngAQvzUiWKS84P4one6wJZqZKS8M6fqd7ecjIHJFVy+i1ET2P8n3YHHNNjzvytXp33kZ/0IW6S
 5npHROar/VEHgp8ThNF27Y8yikAKXeWxHebwX/5pkqe+ojlbSEF0+WYijqFJAFz2/8AkkdBwB1h
 l2ldju4gYYJxyYGUnNhKVxtyA0axiImNQLAgkOYFn0zQOrtjcywq7tVsWo4rUGZrWCeUO6oPnEY
 dqv5fTTSMvxgZLB/JNFWr00CYntXNpClJUJ90pi4iKv68GWHLhOeTltQr1JsCZPHhRkXkQs5vNA
 e2dPHivtHIk17fPrO6azfEaQhV0TV7+fpX1546s
X-Received: by 2002:a05:6820:1525:b0:69e:3567:d7b6 with SMTP id
 006d021491bc7-6a0b60c0580mr3639085eaf.30.1781717217203; 
 Wed, 17 Jun 2026 10:26:57 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44308f09405sm4743881fac.12.2026.06.17.10.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 10:26:56 -0700 (PDT)
Date: Wed, 17 Jun 2026 11:26:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] get_maintainer: ignore Tingting Meng
Message-ID: <20260617172654.GR382693@bill-the-cat>
References: <20260616131133.2143136-1-casey.connolly@linaro.org>
 <20260616143649.GH382693@bill-the-cat>
 <151e43ad-d1d8-4c14-a541-0824abb7186c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l4bcKTHUPOGWToY1"
Content-Disposition: inline
In-Reply-To: <151e43ad-d1d8-4c14-a541-0824abb7186c@linaro.org>
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


--l4bcKTHUPOGWToY1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 05:03:52PM +0200, Casey Connolly wrote:
> Hi Tom,
>=20
> On 16/06/2026 16:36, Tom Rini wrote:
> > On Tue, Jun 16, 2026 at 03:11:26PM +0200, Casey Connolly wrote:
> >=20
> >> Their email is no longer valid and bounces, ensure we don't include it
> >> in get_maintainer.pl output.
> >>
> >> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> >> ---
> >>  .get_maintainer.ignore | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
> >> index 899a1469b2ae..5b7d84646f62 100644
> >> --- a/.get_maintainer.ignore
> >> +++ b/.get_maintainer.ignore
> >> @@ -1 +1,2 @@
> >>  "Pali Roh=E1r" <pali@kernel.org>
> >> +Tingting Meng <tingting.meng@altera.com>
> >=20
> > The .get_maintainer.ignore file is a heavy-handed measure for things
> > more serious than just bouncing email. It looks like Tingting Meng just
> > comes up via git history and so will roll out of emails in a few months
> > now, so I don't want to go this path.
>=20
> Ok, that makes sense. I have found bouncing emails and excessively long
> CC lists to be a bit of a recurring email when using b4 prep
> --auto-to-cc, do you have any ideas on how we can improve this?
>=20
> Maybe we could tighten the timeline and/or contribution weight a bit?

It's hard because we've had contributors at both ends of the spectrum
speak up before. I think what Marek has been doing to use "N" to get
more files covered by maintainers directly helps so that more things
will always have someone else see them and in the future maybe we can
try and lower the git range.

--=20
Tom

--l4bcKTHUPOGWToY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajLY2wAKCRAr4qD1Cr/k
ClRZAQC/6Jq7uotksQXp6OZvt04Rxh/T7ugxx6fESqWySfX/EAD/SuxfeIX+XUlX
Q4xEiGzMjR+NhUiawzm/9FWoqsC72Q8=
=JeAu
-----END PGP SIGNATURE-----

--l4bcKTHUPOGWToY1--
