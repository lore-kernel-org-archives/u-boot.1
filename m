Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9735CD68BF5
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 16:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D84E78919F;
	Sat, 16 Nov 2024 17:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DJjn9dgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B7AC891BB; Sat, 16 Nov 2024 17:29:37 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1192788E77
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 17:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b148919e82so129926485a.0
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 08:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731774574; x=1732379374; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6Oe5MrEpiaxDq1fk2oThatMTHrLnRLZTDuD+vaxCmrA=;
 b=DJjn9dgOQKU1ZGL6oNyhPADLo34pmnrZu3f5EMhrCDFn19SC4BETVS2hjLG64ddafl
 TwC4VArykrMkUu6xwl263t8Gci7YkLGxCnsp5FYgxAPZAuaMcdgbE5XPl9UXunPpT6rR
 tlP6wwjJXjTlPxPWpx1kmMHmNuCut/fPBFATI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731774574; x=1732379374;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Oe5MrEpiaxDq1fk2oThatMTHrLnRLZTDuD+vaxCmrA=;
 b=MyuCQI5k6WlCE3H30TQ+zrMFp53YL8nM1QdCivcNd5WT1AhIlghkf3rbCLd/39cWR+
 kt9biZqNEyxGqOHHQ1Pz8QZOUWjxTKCP2epMonXqKR7ljl7I28+bG+PEw+55CNX9GQT7
 QyZm2qRmgq0feSPLqtOQlzkqwzfACNwICOaN7wMJhbKbh1Y4dRoldsXeLx7Y5OUnGxY6
 O3Mq/sGVa8aWqiga1Eq8tuK1pgqwVFB2naCcLRUfIR8A7zvxmIF5z1ntQsBaeRe4ly/H
 d56SFAbVunlVsY0zpknz5v5IPP1xDqWlFerH9sckIhyOsMFpW4hgY9xjUb6QL566uaau
 cvlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFVqAUp2gEJ+2NEdXg8FV/H2owPLCtLxrnCG68h6rEHlH08TdU1MC77JQYCAsjczheTmcWfwo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywh+AccOicQb5NkOOHDY39n6minWelQo+TqsYejACsPsumQMUoD
 BS5DXPfnh0H5/kazoVwYAbae66JaFpE5fcCWW2he5def0oBSjtPAi41erS/Qyuk=
X-Google-Smtp-Source: AGHT+IHbM2sWnq1nyPr+Ef+40ssIL19K5/I1WmOx/3MRQsav1v98LKHkgLnqCUJXH69TBaDwnooVQA==
X-Received: by 2002:a05:620a:2684:b0:7b1:4a0b:88a with SMTP id
 af79cd13be357-7b3622a564dmr751424285a.4.1731774573935; 
 Sat, 16 Nov 2024 08:29:33 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca58e5bsm273664585a.111.2024.11.16.08.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Nov 2024 08:29:33 -0800 (PST)
Date: Sat, 16 Nov 2024 10:29:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v13 00/10] net: tcp: improve tcp support in legacy stack
Message-ID: <20241116162929.GD3600562@bill-the-cat>
References: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
 <20241116003153.GC3600562@bill-the-cat>
 <9da1c8c2-efec-4c46-a159-f1efcfa6827a@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZdKKY7WoNbGZK0IX"
Content-Disposition: inline
In-Reply-To: <9da1c8c2-efec-4c46-a159-f1efcfa6827a@iopsys.eu>
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


--ZdKKY7WoNbGZK0IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 05:49:06PM +0300, Mikhail Kshevetskiy wrote:
>=20
> On 16.11.2024 03:31, Tom Rini wrote:
> > On Thu, Nov 14, 2024 at 06:36:33AM +0300, Mikhail Kshevetskiy wrote:
> >
> >> Legacy TCP stack is bad. Here are some of the known issues:
> >>  * tcp packet from other connection can break a current one
> >>  * tcp send sequence always starts from zero
> >>  * bad tcp options processing
> >>  * strange assumptions on packet size for selective acknowledge
> >>  * tcp interface assumes one of the two scenarios:
> >>      - data downloading from remote host to a board
> >>      - request-response exchange with a small packets
> >>    so it's not possible to upload large amount of data from the
> >>    board to remote host.
> >>  * wget test generate bad tcp stream, test should fail but it passes i=
nstead
> >>
> >> This series of patches fixes all of the above issues.
> > Can you please work with CI to get everything there to pass? Thanks. See
> > https://docs.u-boot.org/en/latest/develop/ci_testing.html if needed for
> > help on starting that.
> >
> Hello Tom,
> Could you look to https://github.com/u-boot/u-boot/pull/692 ?
> It fails 2 times on ut_lib_test_udelay, but this seems unrelated to my
> changes.

Yes, unfortunately Simon's recent moving of the tests caused that one to
fail more frequently now. I've hit re-run, if that's not something
available to you, just now.

--=20
Tom

--ZdKKY7WoNbGZK0IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc4yFoACgkQFHw5/5Y0
tywHwgwAiWAChwLucm1CqWN5c3fV6wskipmbS/2yaqlAgj+GTLum2X2f/u4E6k62
e1MSV6tMOl9X3KsRskovYvSbqrT+BpBeLtlzhzYGwy2CR6Fre6kvm/5fb3qxUgXx
GDKRLfj5y+yR2DQQYzYSQzkNhkdgWBLNK16GQECLsjqrxF5o1gPbMM6ECOmxtISk
lt245h5IuEYuvKdZmjC/Tu07E4neAc+Dzi3H3/uK4hG9RjNKXdbHlfmlZYrdbsJ0
4OrpsJPhest/0e8C0JKH8FInN2u2Ql2D3M6JZr+Pkm6cN5ZbVZXtvLoi2qdnPH6H
SOXGlck4ukUMqhEQBeHftBfnVfrya7FdzNzF7+t6x1sDlj0RceVpHmhV6GwQDo6O
8lEwKd12rkWaDQh+3wESIGc9MJrpnX4Ga2Jz2Mjgs5FPFQ/cwWEG+xgXkC7kDuM1
YUseS3fHEnjTFKlPpyVwlUidaYBsgVN0ONQBpZ72EVoqQ5Mwyg4kKAExWF45PHsZ
Zjz3jdIm
=73MQ
-----END PGP SIGNATURE-----

--ZdKKY7WoNbGZK0IX--
