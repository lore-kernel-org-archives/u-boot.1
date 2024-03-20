Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B796C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB56388064;
	Wed, 20 Mar 2024 13:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cr2r5DTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91DF288059; Wed, 20 Mar 2024 13:42:06 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B3B28802B
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-607c5679842so72155707b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710938523; x=1711543323; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fKTScFK7+pWnmEDu2tEhY1Ju2wPJtdwz8dBTZYgBO60=;
 b=cr2r5DTAoqd+QvioxaDnrsbgfvlXgCfcvL8X7n3ErydL61PoDOUi5b+iAi4ysFGurl
 UyPNyCtiGIcqqu21H022qpKMw1yEQSVzEJfodlAOkILWtfr5dYJUqw1bQrS4bL3TfhEi
 ipnt4EVlUNTG7D30gv4RhIXYRBFgKdCa5qZrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710938523; x=1711543323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKTScFK7+pWnmEDu2tEhY1Ju2wPJtdwz8dBTZYgBO60=;
 b=SklqE/2VVEn0OIMZHI9FDR4pWUNILXBBWOPMX69EdiunhxZ6uZsbNt6klUe7rURbAF
 wqasjqQechscpC8rR9mrVj1de2VjQad0F8JyX1h9z59ZMUgkPEraK1FiAbD93kwaSqfK
 v143Rk3lZ5rnYZtdZLiM9x1Kq5vivOLzhe+Er9LYelHEoNH8peruYpA+OIoBD7FN3mIA
 c9QW4UJwx/vjkcJWSewGnBpn7SlUDMxD/KWnHNkILqtZ+IV3HGXMCIUsUC7kGZgIwZrX
 DUrut3ziUGsJuoTFbtHZ83nNweGukKxAv1gvD9SnlJxYRMHMWqmCBbtF6qwogWCIhKmO
 tIbQ==
X-Gm-Message-State: AOJu0YzsdZrrjqVx4v9fLCgG0oA+N3zYptnNGqs11vhuTuJSki+eNK10
 oyXUXW3IPPIV23Pz6x8+wfnZx5qqQxogc7i6pE6mSKWweahA7cfidn5twe6xAzO9cvwlR/Rhebl
 j
X-Google-Smtp-Source: AGHT+IEFRdZDd7EM+RtC24pF4YGiivMdv3Xd7cgyYvXEKBE9YP6NaJTRnHF2lslAZHU4w1DFbOBHNQ==
X-Received: by 2002:a81:4e8b:0:b0:610:fc90:b07c with SMTP id
 c133-20020a814e8b000000b00610fc90b07cmr737792ywb.17.1710938523219; 
 Wed, 20 Mar 2024 05:42:03 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 ee2-20020a05690c288200b0060a42336a9fsm2736307ywb.38.2024.03.20.05.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 05:42:02 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:42:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v4] test/py: reset: Add a test for reset command
Message-ID: <20240320124200.GR3442575@bill-the-cat>
References: <043a52451c0e2d40f3da316a942236b27e21741c.1710233282.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fnHOEx/yXR3P/zWW"
Content-Disposition: inline
In-Reply-To: <043a52451c0e2d40f3da316a942236b27e21741c.1710233282.git.love.kumar@amd.com>
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


--fnHOEx/yXR3P/zWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 02:18:33PM +0530, Love Kumar wrote:

> Add a test for reset commands which performs resetting of CPU, It does
> COLD reset by default and WARM reset with -w option.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Applied to u-boot/next, thanks!

--=20
Tom

--fnHOEx/yXR3P/zWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX62ZgACgkQFHw5/5Y0
tyw4IAv/bM2iHR6Dn/R7w2wj0dX066lcoJYycaEvuhqPbn0OUg+XnjAFtptMU09B
n8GDXWfspiJf+TGmZkiAPVL0sz4sEE5nr+ZPvXyVAEtJNLc02/unXt3fhiiG6RvK
+pzPPaJoMHJrgktHCJOXLQKiNuFZjia+JSFv20U4dK0uKe9XHMRkZ6w4OZdtKH9R
NSAiqU9xGg0sKvQ8w9VuhAavHcFrf6BpIxfGratsBJQ0x3LO2lS37X/inZFVhRJ/
s2lF0jYRyltVpLakhcQ3CR7bi7kqopK8nRw7onA3oZzmeqGrFt9VJ/j0xvIhIBEX
4pVQ4oRnXxCV6omczl7N8hDBe02Pt2dANgLHaA8/JZdrO6XNHOUJFgsC4dAqZs+7
+59TJ5hpmLEjS7xeg6Z37Ivccav69MC5IQuDHeuPfRN46IT1lq20JlXC9rUO/YN0
Dq4XE9+b72YNi9B43uhiWvuYDSHvWR0hjEQ0KEZS6+Y9CeucmT8JP/Og0yaWQY4n
QJePDsf0
=biDj
-----END PGP SIGNATURE-----

--fnHOEx/yXR3P/zWW--
