Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007EFC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A9987916;
	Mon, 23 Oct 2023 15:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a491jp8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD6BB8791B; Mon, 23 Oct 2023 15:54:49 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7AA986F86
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d84c24a810dso2941703276.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698069285; x=1698674085; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eTA3NGFbraPY+UNUGhm3Jtn9JGbkpVxoaa2w4XoVttk=;
 b=a491jp8ciC4v/vqu4hLLhdMpHczKJ+Ti+agx4GizUTz6Ig4b8oE3pyA72eFekc/qob
 qNpZ4V54tzr1DOeOQWsihzaNlBicl/GRMvZdC00aZbl7mq8d64i5QHcfGfQpZ+hC3FKq
 oN2dRJd+hSLz7auEH7M5yBIgqXzBxn6LZsOys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698069285; x=1698674085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTA3NGFbraPY+UNUGhm3Jtn9JGbkpVxoaa2w4XoVttk=;
 b=px69jTxMCQU9yT/+U3zXSPfmR/hzVq4MCPoCQPyrOdWSStWUpA+UBPQYNreXp29olW
 Ko05TzjhtSTjC8Kc4Xozi9HZSeuK47qNgygpJlNQjJoVeJL7MHfc9h7splrDgzZ6NeRd
 0wBhzlB+Nn71Li8XQnum7ohQfnOHPOUS6YCBELUqlMAfxQVKCtk+oCx1tkdO4f0bNkp9
 egxY3bGZOgzaZv3lQ5lJ19Ff5CfciudsWZ1LC6Re8bS7jF+ZsxLS9JQNPcqvhTp3BQfH
 xrMEVv8+F4f6Rmtl4QXeE+xneLXtH+rlRpwJ2Oyo1ZeBWf1GhFuKMie2AECvfKQfFtKB
 DZjg==
X-Gm-Message-State: AOJu0YySqDeSyPpN/VnJAIeGAQYuNJ+z+jwwIRsLShon5AvLGA00nNpu
 VhUsXhWdA+ObZFv/r7AR/uK3rJAWb7731OOYB4JunA==
X-Google-Smtp-Source: AGHT+IGUUUBMiu3wa3qtbZ8xACRzG3TQoBhq8Jx9HwSN+IB4GsbnD4obQYvBYVXSuMbssProrA0uuA==
X-Received: by 2002:a25:ef48:0:b0:d9b:4f28:4f7a with SMTP id
 w8-20020a25ef48000000b00d9b4f284f7amr9289625ybm.55.1698069285680; 
 Mon, 23 Oct 2023 06:54:45 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a25e905000000b00d9caf6f7539sm2718152ybd.1.2023.10.23.06.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 06:54:45 -0700 (PDT)
Date: Mon, 23 Oct 2023 09:54:43 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] general: fix GPL-2.0-or-later SPDX headers
Message-ID: <20231023135443.GK496310@bill-the-cat>
References: <20231022174707.72695-1-heinrich.schuchardt@canonical.com>
 <20231023134310.GJ496310@bill-the-cat>
 <303af8d9-3dd6-4c74-94fd-b2300f7fdbac@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="paIbHj3sFBDFKXEo"
Content-Disposition: inline
In-Reply-To: <303af8d9-3dd6-4c74-94fd-b2300f7fdbac@canonical.com>
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


--paIbHj3sFBDFKXEo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 03:51:39PM +0200, Heinrich Schuchardt wrote:
> On 23.10.23 15:43, Tom Rini wrote:
> > On Sun, Oct 22, 2023 at 07:47:07PM +0200, Heinrich Schuchardt wrote:
> >=20
> > > SPDX headers should use GPL-2.0-or-later and not GPL-2.0+.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >=20
> > So, first, iirc GPL-2.0+ is deprecated, but still valid, yes? We should
> > use the current form of all tags moving forward as I do remember there's
> > a reason for the switch to "-or-later" from "+". But second, the linux
> > kernel is still full of "GPL-2.0+" including dts files that this patch
> > changes, and so will get lost again on re-sync.
> >=20
>=20
> I cannot find GPL-2.0+ in https://spdx.org/licenses/ anymore. It was mark=
ed
> deprecated in 2017.

Yes, deprecated is still valid. A quick peek at the kernel shows ~4600
"+" and ~8800 "or-later".  So please re-work this to not touch the dts
and binding files that come from Linux, so we don't revert this change
on resyncs, thanks.

--=20
Tom

--paIbHj3sFBDFKXEo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2eyAACgkQFHw5/5Y0
tyypjAv+KzIU3K7WemmTNTXqMO5L7TcZKdethvvFNJ4sCxc9LAuf75oyOzMXeFM4
Ai3SesomP/Toh8QmyF/b27yXbE5koIm8OO1z0EwjJjlUYsBzya7KMXE0gAUA7cM+
CbSBN5T1pgXRJulw6JsYOMp7KEemFRigF0ETqaOyMlSSMwaOmox+vxfX6SgDBHRf
V6p1ltBMXK8iXYUegheIfpJZ0oPcQdfx4WcJot0prIUyfNx8aTQGcXO6lR0crFNn
pkRtoyi0F/UhQm0OCC5udYWs7dzGjTbvnxdg2sb88OBkn8GKbaqSq1sT5oKFqoRb
IGIO7NPTGoc3JbbjWdjchBxZhvSwxFHY+Jw6YagsloWgCDw1rRYKO1dkKwGKBsyC
+51H2823R4u+GnNM8ybA8vfO0AH/dNQYd1fQ8SjkyP3z+QVJN6xMaP0GefPH5kGK
kJjzBimGSEbVY/6+xJ3z1h/+T92e/hVdV5jogeyE0uOjKn45XmIjY3iS8N8eLudX
RgimK0Cy
=EQRe
-----END PGP SIGNATURE-----

--paIbHj3sFBDFKXEo--
