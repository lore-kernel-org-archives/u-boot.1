Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC97DE7718B
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 02:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1939B807AC;
	Tue, 24 Dec 2024 03:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a0Sj3CFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34FBB8074B; Tue, 24 Dec 2024 03:44:55 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1556D80786
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 03:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-46772a0f85bso39906981cf.3
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 18:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735008289; x=1735613089; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bEujPHroTVQ8OkcA8khixkSseE0XlHf+3cStmoCWiGM=;
 b=a0Sj3CFlPMRtU9JeLbCzb6g7RnCXyE26cTeW14hh6cOGbatxwVFSzrK/gSpbVwDGkh
 XFLAZcJYnd6tzmQeauV1HCVI9SgaPgD/obVLHoiwqRTycRi0V7hE88CdYAOAGThQoC8l
 D0ASQynfrKCcOMsk1MmnwPVrArPTKOjoABxqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735008289; x=1735613089;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bEujPHroTVQ8OkcA8khixkSseE0XlHf+3cStmoCWiGM=;
 b=pkwyabPy2+D/qJTFauj+quBOxEI16CZo3fSHalweyKdsB7aTEldk4fL9rTJKrK+OZF
 gEPBd6kXw7MzErSQfzfHkLZL/k1vndqQu28TxgW1QEwzqeE1iCovkUtc3EPQx2cIW4qI
 dlOBMXM9lSPTx6pxuzjcdv0JZ1fxW3rca4V9oAg/Lw/j66uQswDxlXctq4d6vyl3Ewag
 wPu90m5YLXykZKhF/TUCmpfEShDcELNJkiR2jX2hfXPGpyZBvv7p0tP8rlUfjrctmD3J
 33BX5usk9PN4fPkT9PT3TJ5qg5NOL2LxgxZOSVojWKQbBGl45CwO/EGnW8dm8xP22LtC
 TN2w==
X-Gm-Message-State: AOJu0YwMDtr+jXBDjheelTeJkSZVugzAnuRPCrf87a6UqQtCgDpqmJgi
 KE9LS9IsdIPmjd2PbGCVd6vUvzwQMo+aFA5xR+pV0Fk/CsHlg8NbDsv1CLqG0/0p60Bw0sHRXFf
 T
X-Gm-Gg: ASbGncvsxaHM7nxyHyv/h0i1OO4EAmIr62ouwfw+45SEWDb4uBiCJBys6SqnnwTB3xO
 ZTe/SdeIYDOlDjdjg9khPPXf9Lr8Rh42SRrv0GiIpuPaL3PMEypJVfgkoK1ZYJS3hnej+x4Xx7J
 V66cyN6Gnsi5wlvBPsz+Pq+tfLfFyVNSvZXDOcftdf2pmU8xQcBcSXboRmnxuGfig4/rPydJK5Q
 zAh/Mx/Z25wyN/aIkoIWxoHMhRQCcKZYFpShGkbRKLTPJ/EA2QgcJTPYg==
X-Google-Smtp-Source: AGHT+IE0dzHOdu4PXWSlR+3qipWCoCX7+Adv+GMoeDfej7oy+IeVfZtHmZN4ynHFRtJqYbuZ0IHS7A==
X-Received: by 2002:ac8:7fc2:0:b0:467:7557:5fbb with SMTP id
 d75a77b69052e-46a4a8ee06emr222105811cf.27.1735008288814; 
 Mon, 23 Dec 2024 18:44:48 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e6ada4fsm49344511cf.52.2024.12.23.18.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 18:44:47 -0800 (PST)
Date: Mon, 23 Dec 2024 20:44:43 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de,
 marex@denx.de, monstr@monstr.eu, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [ANN] U-Boot v2025.01-rc5 released
Message-ID: <20241224024443.GU1505244@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VqMUKsNU9FEtiI8u"
Content-Disposition: inline
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


--VqMUKsNU9FEtiI8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Once again it's release day and so here's v2025.01-rc5 and I'll update
the -next branch soon.

At this point, I'm waiting to see if it can be agreed that:
https://patchwork.ozlabs.org/project/uboot/patch/20241220143006.1921705-1-v=
enkatesh.abbarapu@amd.com/
is safe enough, or if it needs to be further re-worked. That's really
all I'm tracking between now and the release. That's not to say others
might not be tracking more things, but that's all that's on my radar
right now.

In terms of a changelog,=20
git log --merges v2025.01-rc4..v2025.01-rc5
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

At this point we have one more rc releases to go, next Monday on the
30th, with the final release on the 6th of January, 2025.

Thanks all!

--=20
Tom

--VqMUKsNU9FEtiI8u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdqIBsACgkQFHw5/5Y0
tyzrmAv6Av80a/+AF4XMt37MHrWyJhqJ3akFSo+quoOzkqxYr/viwF6I+Ke5Vbxu
4bgP3kDV2GeFgs08gp7wtCsoBnK2jSnPAX5fyhF+EUkSKm5GGB4ceZujHSy+G8Zk
a74vZB91yzFurqUax3NsFsamR0CRXzMFiQxcHyuJNzjGdwnKdiVrQ9nRHcymD5bW
rt2TtZ3nVQtWLN9kxR5Vt0NQKt/HWd/7C8CUOinb1tk/W9HaF6hvU8sCeuOIq2c5
fhi0XWFMZ/iTZMlfCpSiuPTHnSSsR3N4ya0onju9bqYPBHoQwqLpllcTpwCkY3l5
gPh0Pjp+EDejFrFzQ593MXthqrQsTFyLZrlUDpPxj4kS95Bhu6BJTbeU/56UI5s2
8jgaRsoaUQM3/np+Tgu304QTuTJ3TmsKaHNV1m7j2drv549a6ZAATj9NIZw/zob4
wye6ryAA6ink4TMJZOZqa0xrjfVvNtHzjfvSBY2BsWRrOGqokogvBuxpbbaixMUJ
5M40sjj0
=azBw
-----END PGP SIGNATURE-----

--VqMUKsNU9FEtiI8u--
