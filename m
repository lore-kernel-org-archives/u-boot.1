Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED474C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C318B8680E;
	Thu, 31 Aug 2023 18:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PZp3MS94";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE11867E2; Thu, 31 Aug 2023 18:27:09 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8150867D2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d7820f9449bso809650276.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693499225; x=1694104025; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5XrHVITCfBcRWTyc4YlyH8r7P9GI9SyrNcvPFnlm4dk=;
 b=PZp3MS94G+sqpbkyW8NyqA+H8+i8i2mS5ClUDRlzpOk8vQpmxNxlnOFtOKOk7hxrjV
 MGBBMgIRHjnv3Y8H8VrcMG3WElNJCiD2Wa9qiZG6PT0TUcm1PG3PQ5jNhvcfYLVzufsD
 n9zM4wbh21H7o1HqCUEN1rpOSqKESbPfbxlxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693499225; x=1694104025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XrHVITCfBcRWTyc4YlyH8r7P9GI9SyrNcvPFnlm4dk=;
 b=Y7AA3hspI8DNTIO72orPGU62/+r8ymsaFubh1NUYW9Q/DYN0JGjzXBIegFkaz19pGA
 pQnKbMA3bSxFVdk5Yxow6xb8Xbq6ncQflPotINwZ92ELKWYZbiGxEra1YD0PXyne9BUi
 f/DHfGhenwb6qqL3r96Xz2v+RwDYJ8JRIN+J7hL1Ov9bXq76+Mt1By/xCbhrAZOUpHnX
 c5tITjEWoe/krDqnA32VPWqAjKdDn4aEDfzAOi6gP0n6BFyorpz8prCIcAf9EnNI3HmS
 l6UfpzZKw2/2YPuG56kRsFdAqDMDeBE/AMJ/WivNnLUkZlM2h2aCzTGdIjziepSmUc3M
 H8Hw==
X-Gm-Message-State: AOJu0YxY2/cF1NQf0cDl8PDtTSKiaiYWYzq0C+UACRgSrDXyZaXXonfR
 B/BkfZQbcyx9x+1RGNdUFzD/hg==
X-Google-Smtp-Source: AGHT+IHJTmgEER1NIhZotjOAGvEJ4LgWd6tc+Fc8J7T8Y2m88t8mAMm0VnIVX4i8L7GPNTB+8SwSTA==
X-Received: by 2002:a0d:d612:0:b0:577:1560:9e17 with SMTP id
 y18-20020a0dd612000000b0057715609e17mr5002444ywd.35.1693499225482; 
 Thu, 31 Aug 2023 09:27:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 y126-20020a0def84000000b005869fd2b5bcsm504617ywe.127.2023.08.31.09.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:27:05 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:27:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH] net: wget: Avoid packet queue overflow
Message-ID: <20230831162703.GL3101304@bill-the-cat>
References: <20230720125156.31773-1-richard@nod.at>
 <404816774.38.1693477679941.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Skyvdpy/sIIvKANz"
Content-Disposition: inline
In-Reply-To: <404816774.38.1693477679941.JavaMail.zimbra@nod.at>
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


--Skyvdpy/sIIvKANz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 12:27:59PM +0200, Richard Weinberger wrote:
> ----- Urspr=FCngliche Mail -----
> > Von: "richard" <richard@nod.at>
> > An: u-boot@lists.denx.de
> > CC: "richard" <richard@nod.at>, "Joe Hershberger" <joe.hershberger@ni.c=
om>, "Ramon Fried" <rfried.dev@gmail.com>
> > Gesendet: Donnerstag, 20. Juli 2023 14:51:56
> > Betreff: [PATCH] net: wget: Avoid packet queue overflow
>=20
> > Make sure to stay within bounds, as a misbehaving HTTP server
> > can trigger a buffer overflow if not properly handled.
> >=20
> > Cc: Joe Hershberger <joe.hershberger@ni.com>
> > Cc: Ramon Fried <rfried.dev@gmail.com>
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> > net/wget.c | 10 +++++++++-
> > 1 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/net/wget.c b/net/wget.c
> > index 2dbfeb1a1d5b..8bb4d72db1ae 100644
> > --- a/net/wget.c
> > +++ b/net/wget.c
> > @@ -35,7 +35,8 @@ struct pkt_qd {
> >  * The actual packet bufers are in the kernel space, and are
> >  * expected to be overwritten by the downloaded image.
> >  */
> > -static struct pkt_qd pkt_q[PKTBUFSRX / 4];
> > +#define PKTQ_SZ (PKTBUFSRX / 4)
> > +static struct pkt_qd pkt_q[PKTQ_SZ];
> > static int pkt_q_idx;
> > static unsigned long content_length;
> > static unsigned int packets;
> > @@ -202,6 +203,13 @@ static void wget_connected(uchar *pkt, unsigned int
> > tcp_seq_num,
> > 		pkt_q[pkt_q_idx].tcp_seq_num =3D tcp_seq_num;
> > 		pkt_q[pkt_q_idx].len =3D len;
> > 		pkt_q_idx++;
> > +
> > +		if (pkt_q_idx >=3D PKTQ_SZ) {
> > +			printf("wget: Fatal error, queue overrun!\n");
> > +			net_set_state(NETLOOP_FAIL);
> > +
> > +			return;
> > +		}
> > 	} else {
> > 		debug_cond(DEBUG_WGET, "wget: Connected HTTP Header %p\n", pkt);
> > 		/* sizeof(http_eom) - 1 is the string length of (http_eom) */

This seems fine and I'll pick it up soon.  Thanks!

--=20
Tom

--Skyvdpy/sIIvKANz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwv1cACgkQFHw5/5Y0
tyxGgAv/U07Tw6ZtzQGgWzlAgLab6w5Iu8bUlWYUClaxQwBzG3fqV+3bnizszUbz
KP1R/ciMDRgl2ApB+l//BOWt1uM0Qx1OFFOTr9NHqsOJecUPwFdxmocBoQdpxUw4
lYQKVT47pT6FQ8bg/gJyC2/+icV88dcnHIW+H9vFfeTe4yF3rr9dwOly2CzgwTjr
2qKuczryA9xjpuPejX6Z9/r6H3NNdRxRCDtv29DqdmOqOzGBG1J2HGHV/J9CHmWo
06S0lXJUuwUwzvItVH3Z9uKuzo1qcVSKtbn60tdLQNC9KKUmelshVVhUYdoZqWwn
6AnxwsxoWZ6WX85DX4W6Om5APHrQFFKmf0XXL6q/t3IINuOrnBSOR6lHu09umUL7
pX6kUzFlL8UTf5Ec4lMCXpveiNjEUj8Z/dgglOhjKT2j1OId5r37kcAWAAF3PdD0
eyBktLJ4y9VV47uHXecWryesT96Y0yaX2qI2tw4LJQ8Sp0rHMTSdhS1ZTnI0RtWR
bCuTbJyn
=Rtjt
-----END PGP SIGNATURE-----

--Skyvdpy/sIIvKANz--
