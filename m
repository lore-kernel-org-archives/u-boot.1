Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF59EC1126
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 19:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56FB283935;
	Mon, 23 Feb 2026 20:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MAnysAAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A429083C39; Mon, 23 Feb 2026 20:51:17 +0100 (CET)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF5D80077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 20:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-45f18e8f2f5so3129825b6e.3
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 11:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771876273; x=1772481073; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xF7RnH9F25Btrb9OrPnTh0J3D64faMGzh+2beN6OkfM=;
 b=MAnysAAof+Vk9l1f7ThI2Zt/lns23NbnBiLAFVathywnxmlSZCEhN/gfDIrgFMdRfa
 e3EkAxWXOFmhNl2e/iw8rhxsLFfTaW9Dq19GxnJoxzLe2u7j3H7GD2/08eEEA/G7LRB1
 DkwNqqNMvaA0q4Fo+ESFq9wnrdZkavY762UHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771876273; x=1772481073;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xF7RnH9F25Btrb9OrPnTh0J3D64faMGzh+2beN6OkfM=;
 b=cpTqNP1b7T3gmKuzpxSSfQ2e1tXKJPzJs0u7OpTPkxBSkwhGfpk06UUnjK7UO4wVlB
 mQIxSR55Zbp6LAI57AgL1BD80vHA1lQK2feuuf+EiQ6zBXiw6+MN6NLUCvLkOVBZh5xl
 JTcFPQPRgVU54qxCFubPQTF3EzHqfoHgPCXgTQBmoSPLOsPV+LK/X9Yz2QGyVagJsuqm
 OAYLYtzIW1CvAq5HcbbV6wiIU9pyxRx7ZTOMcDBF986USP4qqsXxjWkNS6Ipr8iJJtao
 jHQUsc9bdntt+p2oN0DbHY491Df9A65COMKfeOmBWuEOd1BslS+Rhvm4KgNX5xS3hB2/
 Os0w==
X-Gm-Message-State: AOJu0Ywaddy4btRQz5jsBdNmVXalYU5FFJH9IR9mJcRYKbuzOmUG2ECj
 goBDBleqo1am3TDCaHgr85L7Be86LkG1k2M8gzg/tM9yilacU0+vf65CTSdH1SebXZKfnOTycUk
 jnGGEcQg=
X-Gm-Gg: AZuq6aIkJ9J09R5cz4LOZeuYXSyDHqQmiv+6zUHwtAuyD/IVPncjt92tVzK6b868c3k
 Tg0C7B9uE/JkyCYFKqMTznHSrbAl3D4/+ADQGjN2ugEoZwFaJofEw8AsY1wrKl+n9h+EB9ASVNw
 qnu7qW+3rk/XwhImSfcEgNNNq908yAyZjXSYaqqBxft0iZDT87xmPkTjvZi+/jzctCAqvVgTs2i
 RayGkiwBTDqXO5RvFz+yxByyhlsZfD3Nq7kclPewUdaLztdDBgNkI6X5/MTjwKTgHNFKzRtVEef
 eNtlUBCiiLv/0raEzkLMT+0qLNxlmZoxOUjXQZMITu6lf5vdguCdk1FN86QcCxY/glY7CU93v+7
 eI1RKb/ubaUyKeQ+MCITZ89oJbvKVxGF9DtAI747+wLs+XAxlb/pkjZk8ZNrQNiA6aa9rApB4jI
 D75J5dqzr2LFpZnpzrUX/Qz43ms73SktPh/SDrhOrpLdzk/NMJub4h6iiQ3+limwc/4U22pchI8
 gOSqWCwLCVscnkYZwLv+XYRyOIlQmsFWfDmLrXvzNK7GIJ0Dyo=
X-Received: by 2002:a05:6808:c16c:b0:450:aba0:f006 with SMTP id
 5614622812f47-4644619a0f2mr5543553b6e.17.1771876272500; 
 Mon, 23 Feb 2026 11:51:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a17a11csm5673612b6e.11.2026.02.23.11.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 11:51:11 -0800 (PST)
Date: Mon, 23 Feb 2026 13:51:09 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260223195109.GG3233182@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ESlGZZhSGjdKGQOh"
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


--ESlGZZhSGjdKGQOh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Looks like Coverity is a little unhappy about the FIT alignment fixes,
but I'm not sure yet if we can just mark them as intentional and already
safety checked inputs or not.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Feb 23, 2026 at 1:34=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 1
   - 1 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 1 of 1 defect(s)

Defect Details

** CID 644638:         (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 644638:           (TAINTED_SCALAR)
/boot/image-fit.c: 2410             in boot_get_fdt_fit_into_buffer()
2404     	 */
2405     	if (dstlen >=3D newdstlen && dstbuf =3D=3D fdtsrcbuf)
2406     		goto out;
2407
2408     	/* Try to reuse existing destination buffer if it is large enough=
=2E */
2409     	if (dstbuf && dstlen >=3D newdstlen) {
>>>     CID 644638:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdtsrcbuf->size_dt_strings" to "fdt_ope=
n_into", which uses it as an offset.
2410     		err =3D fdt_open_into(fdtsrcbuf, dstbuf, dstlen);
2411     		goto out;
2412     	}
2413
2414     	newdstbuf =3D memalign(8, newdstlen);
2415     	if (!newdstbuf) {
/boot/image-fit.c: 2420             in boot_get_fdt_fit_into_buffer()
2414     	newdstbuf =3D memalign(8, newdstlen);
2415     	if (!newdstbuf) {
2416     		err =3D -ENOMEM;
2417     		goto out;
2418     	}
2419
>>>     CID 644638:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdtsrcbuf->size_dt_struct" to "fdt_open=
_into", which uses it as an offset.
2420     	err =3D fdt_open_into(fdtsrcbuf, newdstbuf, newdstlen);
2421     	if (err < 0)
2422     		goto out;
2423
2424     	free(dstbuf);
2425     	*fdtdstbuf =3D newdstbuf;
/boot/image-fit.c: 2420             in boot_get_fdt_fit_into_buffer()
2414     	newdstbuf =3D memalign(8, newdstlen);
2415     	if (!newdstbuf) {
2416     		err =3D -ENOMEM;
2417     		goto out;
2418     	}
2419
>>>     CID 644638:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdtsrcbuf->size_dt_strings" to "fdt_ope=
n_into", which uses it as an offset.
2420     	err =3D fdt_open_into(fdtsrcbuf, newdstbuf, newdstlen);
2421     	if (err < 0)
2422     		goto out;
2423
2424     	free(dstbuf);
2425     	*fdtdstbuf =3D newdstbuf;
/boot/image-fit.c: 2420             in boot_get_fdt_fit_into_buffer()
2414     	newdstbuf =3D memalign(8, newdstlen);
2415     	if (!newdstbuf) {
2416     		err =3D -ENOMEM;
2417     		goto out;
2418     	}
2419
>>>     CID 644638:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdtsrcbuf->totalsize" to "fdt_open_into=
", which uses it as an offset.
2420     	err =3D fdt_open_into(fdtsrcbuf, newdstbuf, newdstlen);
2421     	if (err < 0)
2422     		goto out;
2423
2424     	free(dstbuf);
2425     	*fdtdstbuf =3D newdstbuf;
/boot/image-fit.c: 2410             in boot_get_fdt_fit_into_buffer()
2404     	 */
2405     	if (dstlen >=3D newdstlen && dstbuf =3D=3D fdtsrcbuf)
2406     		goto out;
2407
2408     	/* Try to reuse existing destination buffer if it is large enough=
=2E */
2409     	if (dstbuf && dstlen >=3D newdstlen) {
>>>     CID 644638:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdtsrcbuf->totalsize" to "fdt_open_into=
", which uses it as an offset.
2410     		err =3D fdt_open_into(fdtsrcbuf, dstbuf, dstlen);
2411     		goto out;
2412     	}
2413
2414     	newdstbuf =3D memalign(8, newdstlen);
2415     	if (!newdstbuf) {
/boot/image-fit.c: 2410             in boot_get_fdt_fit_into_buffer()
2404     	 */
2405     	if (dstlen >=3D newdstlen && dstbuf =3D=3D fdtsrcbuf)
2406     		goto out;
2407
2408     	/* Try to reuse existing destination buffer if it is large enough=
=2E */
2409     	if (dstbuf && dstlen >=3D newdstlen) {
>>>     CID 644638:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdtsrcbuf->size_dt_struct" to "fdt_open=
_into", which uses it as an offset.
2410     		err =3D fdt_open_into(fdtsrcbuf, dstbuf, dstlen);
2411     		goto out;
2412     	}
2413
2414     	newdstbuf =3D memalign(8, newdstlen);
2415     	if (!newdstbuf) {



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--ESlGZZhSGjdKGQOh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZyvpgAKCRAr4qD1Cr/k
CiSZAQCMbDm9yGG49TvXZrkRGCjSKfCHA5U8NvAC5RJcMxTjcQEAlFmuKDNjMGlf
mSZHkfNh2WJGqyU5FgTnIkSo9BizKgY=
=2v2b
-----END PGP SIGNATURE-----

--ESlGZZhSGjdKGQOh--
