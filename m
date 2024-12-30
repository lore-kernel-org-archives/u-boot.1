Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC74E77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 17:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 920D3805ED;
	Mon, 30 Dec 2024 18:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Er1+vM6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E857480600; Mon, 30 Dec 2024 18:42:10 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9CD6805EB
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 18:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b6e8fe401eso780214785a.2
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 09:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735580527; x=1736185327; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tsCnSY1MEZ0F9bJbHwSNecKVl9yoU+jVatXagUOgVc8=;
 b=Er1+vM6KW0PXxNwFPDNjFuJu1Ok/0OzJTRn7YEojixzkGYmNOuZX/bR6VgjhS7+O4/
 SaeFEvbMhm1HPQwQ9XtdQjdrmOfS5OhT4b8TVq1DO7EqgwGXLaDYLj1RkvJ+FHzBTIQ5
 xwWkP4vQRU1qj3hO5lpj9Y53R4lPp+JBGm7Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735580527; x=1736185327;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tsCnSY1MEZ0F9bJbHwSNecKVl9yoU+jVatXagUOgVc8=;
 b=qnaxUXoo4JNlSahqOdLrPKE6jes38XwO/N6YkQIxI6n7SXJSBRd/15u6buNCtu8LI0
 whLF3O/qS3CUUpA7QlLmZkHlurD4+eIYtyYfMEnnZr6e2PDUTPeHqvcMPbk36XgWeQ+T
 dLWkRa+USx4q1+bCOm44K582YwZHeleDVTO189gwJUCvpHER5Enzo8OGka2iAOwBOBIu
 qtF2SQ2XXbXGWgLHh+TrShZMVkyjjcTcHfjyh2l09tXve+gKEizxbZvPi/XzOx9042bG
 5tJhwc9yBE4ORrRwesLPn31k9u0OUuW+rQA7ViyolU+ud5Mp2zuO7HfuUck+B5TX453u
 5qYQ==
X-Gm-Message-State: AOJu0YwndcSz4hwf4xFImNfLJ7iPSUdXQGOrHy0RPsikSckg5V8KiDxi
 0ecx5WFqKO04knvgV4XgEvHIxmChSxxcov3fgx5u327gDMJl6O5CSs1vs/ABIRs=
X-Gm-Gg: ASbGnctdJNRisKNAsNMN8S/v8ccaV9sgqUfFi8Q+2WGmnD0YnfW3y+IPIaLr3Tm7pZP
 xmc6jhDXFsnisTBpHgj7Mfo2TzhY1cOkfVnieb5TY6lIfAhubn0HuWmR2lgKjBrI1UJ/oXWKPQA
 zXSZavYQFU7PAvDjud+yhh0DgHWYX/k0VgSGCfCzqBs4dQbe2LeVINC4LFtkm5iTHxzWLOqPvlq
 v/CAyMJDPzNVpl7mv63/jt+WtK+GIGPpUpxBVXV7Vcc4EDyqsSMwoND2g==
X-Google-Smtp-Source: AGHT+IHrIlF/5V/7nLUAtuTRtwCOQViiGvnU5ooDZVhLJ11KKWFmeVov58fen0ZsmikIOf6Cc509ww==
X-Received: by 2002:a05:620a:2449:b0:7b6:f6ac:60e with SMTP id
 af79cd13be357-7b9ba7b059amr6757124985a.36.1735580527489; 
 Mon, 30 Dec 2024 09:42:07 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac4cc3c7sm935093485a.111.2024.12.30.09.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 09:42:06 -0800 (PST)
Date: Mon, 30 Dec 2024 11:42:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Santhosh Kumar K <s-k6@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: u-boot@lists.denx.de
Subject: Problem with "Cleanup dma device in spl and move dma channel[0]"
 series and am64
Message-ID: <20241230174203.GD3476@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="If6Mk2wUgKN16zcM"
Content-Disposition: inline
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


--If6Mk2wUgKN16zcM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

As part of testing the SPI fixes, I tracked down a problem on my AM64X
SR1.0 GP to the above series. With the series applied, I get:
=3D> sf probe
jedec_spi_nor flash@0: non-uniform erase sector maps are not supported yet.
SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB, total =
64 MiB
=3D> sf read $loadaddr 0 4000
device 0 offset 0x0, size 0x4000
ti-udma dma-controller@485c0000: k3_dmaring Ring probed rings:288,
sci-dev-id:30
ti-udma dma-controller@485c0000: dma-ring-reset-quirk: disabled
=2E.............................. (never ends).

With the series reverted:
=3D> sf probe
SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB, total =
64 MiB
=3D> sf read $loadaddr 0 4000
device 0 offset 0x0, size 0x4000
SF: 16384 bytes @ 0x0 Read: OK
=3D>

--=20
Tom

--If6Mk2wUgKN16zcM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdy22QACgkQFHw5/5Y0
tyyE1Av/WJ3MR9e2/W42kPZ8DoNf3wfpGmZIBVN2f/c9bDfM2zx7YciktawdPkVu
J9mlVk5S+rUOW/lcydByCFmJU5XLkmkzQvtk/qiwCkm9QKMpcplJGdWVswQ5r0OL
oEdaRoIj3HsDDfrqm2/tWYr07wxooJlBO/+reHvs9uidEDTCNslqxbGWQGrSfqpX
Rf8Hem5EsByJLU1bi2+6y9cRXd2GJnzrSW0edCLlLBcPbZEE9NoW+Lrm+AvtMrZg
WCT7kWyakO+P8bDB9qsbkYWZ3VY0AcSmnpqI5Xe3u311Cm8tJe7NbsPbxuZ9alcM
VD630OTHvI/zFN/e0N9ayZ4mpDifkqxyARZgVOhAk4M4KdM+tRieXbvr9vC3zr1A
c4b/8FS4azJy0ouXK92GWgZU1KK9bJnf/ipUh4skdi7ArE8o/RLD0+2sVk8AOxVF
XHpzUxXOovedAtt1REqqJW7QxEkLIChj0ZZl8733JOZ9fRkkdswTwUS9bn4GeADX
o+N9ZI0m
=gd4/
-----END PGP SIGNATURE-----

--If6Mk2wUgKN16zcM--
