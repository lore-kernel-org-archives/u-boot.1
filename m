Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28F7C4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D4484A29;
	Sun, 19 Jul 2026 20:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SapxwZmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 806CA8005D; Sun, 19 Jul 2026 20:20:11 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A63B84A29
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4a456e44e01so3133539b6e.1
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784485206; x=1785090006; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iHithwn/KR6Sv3Grozzo07qbct8lQUvFKfbmAmeHH44=;
 b=SapxwZmVY4U/RZRbj7joPuh6ofUI4Lh2Otu2O/ijcJeKMjJbIJ6sX5RfqPBEQfayG/
 WU7cjxak/ZJC2IpwrchrCHQ4s3aQvE8V6lnr5JnM957zS0ZUSUo3ud1dHHxGMz08BKSq
 DpU6lxyJhGnfouOG6gNJn6gOR1NqPyNLgLjc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784485206; x=1785090006;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iHithwn/KR6Sv3Grozzo07qbct8lQUvFKfbmAmeHH44=;
 b=V3G0Y+jmiFqSPSqt1Ie9Lmefdbu1jkd47eJU4UFZsU+aU9df7GDrOaFBTvF+1wJ6WT
 nIRj8ZbxJB4pvYVaEn4lrOiDDVWPIemwuUg5ZodD7KGBdnd8/DJIdoL8BLk7xiKyYIK9
 iOnFu/OwFBcfX5uut2r7nei2eQVuAq/ZFQeYEqjsu2e/CCOcFDBJmoce2YzaKbIJL/ub
 CmwaPxxQX+x0UAkv0ltapq8lQOy5Btg1+AIvSb28B0YXEYhZ2moUpmx8xodPkTgNBH62
 eeHOHvKNFUZZBmX1sZoY6Cq/H/pyuUvtcWOlajHn8B8d0OwB8qviJjjAo4rwUiofkGLv
 JOGA==
X-Gm-Message-State: AOJu0YysqaugGhw1EpOcp9Z1KBKOInY9OrBNyDc8bcn6mgFNHK0blqJn
 cfJ1o3EWKTwdG8ONWSxtDjPgpOrkL83cdDPLnpgI/eRU6EQ1HIvmu0D3fwWtAkinxRAVwys4N2v
 whLSS2CQ=
X-Gm-Gg: AfdE7cnNKY7kjxWs8G/C1ywiK3nee7t3oGsitHV5od9m7l0RlLValeaGI2Z51GMx//E
 TfUplii1ZhuVDmc1U7VH52t3KOzt1R95xskQY9BmjM8YfdSNpaU7RAhwUMSsxrnmHQV7FC6Rz+s
 WRtAXWNihrjxLd5UGh11g2veBy+0RIl9R79G9BSXRAG6uqa5aUIS6b1Qq4IpC+WDMIlxaApXEqx
 RebWVjMmY9qat7IPbMsweK2k6OtEJcM/gtEDnV7egW48y83wqlqyIK4Mf3GDTGHNX52XUtzY1bz
 KwOqeMBK12tq9xVICTrnewSiDh1QUZFSQSwiGd+cJwXgsCz+7HSqFxLaIB+EnttOWucpgvx2lJ0
 K8Ip4vQbm1WtVBvp8P2DzS4DhhdsmJPLs140sCqrUIVhJobcx5xlb+aNCUpD+ZOe5QnDbszQpF6
 voOeYuv/GHvUF0dAuCC3IJTSBZsjqIwRVnVtOYyTBzcawF06eZz7VGnOBYIzxbYaHybmsSlpgzV
 T+2GVgo5qqVMXIZo7rGC8yvTSs=
X-Received: by 2002:a05:6808:191e:b0:4a4:a06:43b3 with SMTP id
 5614622812f47-4a4d054a2c0mr7874873b6e.38.1784485205914; 
 Sun, 19 Jul 2026 11:20:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a4d3607ea1sm5452250b6e.0.2026.07.19.11.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:20:04 -0700 (PDT)
Date: Sun, 19 Jul 2026 12:20:02 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-board-maintainers@lists.denx.de, u-boot-custodians@lists.denx.de
Subject: Re: [ANN] Mailing list migration to lists.u-boot-project.org
Message-ID: <20260719182002.GW749385@bill-the-cat>
References: <20260715173119.GL749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dRl3ajf9QbU64mbC"
Content-Disposition: inline
In-Reply-To: <20260715173119.GL749385@bill-the-cat>
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


--dRl3ajf9QbU64mbC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 11:31:19AM -0600, Tom Rini wrote:

> Hey all,
>=20
> As I've mentioned in previous release emails, we'll be migrating our
> lists over to lists.u-boot-project.org. The news now is that we have a
> date. This coming Monday the 20th of July, we'll be turning off the
> receiving side of lists.denx.de and then importing everything over to
> lists.u-boot-project.org.
>=20
> What do you need to do? Nothing much. All active subscribers and their
> preferences will be moved. This includes how lore and patchwork are
> linked, so all of that will work. We are going to try and ensure no new
> emails get lost in the migration.
>=20
> Based on feedback from the test migration, we believe we know what was
> missing to ensure that the archive links are stable, and so that should
> be the case when we go live again.
>=20
> I'll send out a reminder about this Sunday.

As a reminder, it's Sunday, and the plan is for this to happen Monday,
late afternoon Europe, morning west coast US.

--=20
Tom

--dRl3ajf9QbU64mbC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal0VTwAKCRAr4qD1Cr/k
CkiXAPsFO6KlySdBLJFgE+053XT4zwAPx0vwoapvGepObOHvJgD/SFwtlKp2WEZc
UYE5AICyI0hfna3v0tFiA8xwoQI1nQw=
=6O5g
-----END PGP SIGNATURE-----

--dRl3ajf9QbU64mbC--
