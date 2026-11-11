Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2795606A335
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=carqrq6Z;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=kT+d786S
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17DBC8123F;
	Wed, 11 Nov 2026 16:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qAays5hbNwDN; Wed, 11 Nov 2026 16:20:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7258781218
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794414055;
	b=Y6raXXMwOgxPVFqBotS/b/OwHV7yjIy+cUz2vka/ciXGl1AuVo3AKzmWOnU8h1N8ZzgL
	 LGR8V7nOCVPRSQAMxwqyL/s/KvxaAQ506v8/qiYPuTVO0fnPUXRApPJ2siTQ2H51Ayl++
	 MRtHQO19rcGS3X3GYY6NMg9G1ZtCbXPMMjF0yWB1VyDehq0IvPAnmiMNhKLk3nshvHL0r
	 6Micd989evP9hbUJZpujoLxwVqjLGA/nygBJRE1pSfRz43NUL0EWqyhlJHccGBYFGqb/j
	 SkC3Y+0+q5QGnxjgey2lhZtrAiEaKtuwJyBS0IjB+zfjW9hJEMIVUUqo30oRqAUrvHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794414055;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=B2jRTEfwZ9yzI434++lrInPFCLeY9AA9GnKiICDHh1Y=;
	b=kbTNZn7U4lhYt9lqGauDHYYmjp5NWHR/Tx1kH3dI+zSrJEY9kd7klSNXGZqWNfm/zsPE
	 ilQrOEz3KZ8oCXI4eFmuNDezBc9N0TgGM1oZ95L8VTMfprl9QgY4hNnQ3IO3DoIguyctz
	 EpsVN5ghtcNFCMb4TulHEy5Sk2Qmbdu34ksv0ghDzOuDtFPqBWwarNezrcbB9WmcoJTBi
	 PB8DqidxskzG5izGPu83OYcr/EXQ6REoPm25iqUEMT79LCNJFFndOMIV4pVdrZimdAnvs
	 5LvrfQFlgJGvHG2a0wtUjhCwgNxwMwJ/MvCUfGKbUcY6MDDYztOdey/t9jl8rutS3vg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794414055;
	bh=B2jRTEfwZ9yzI434++lrInPFCLeY9AA9GnKiICDHh1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=carqrq6ZFHtahvdmlaYo6yZ4spB9Zy1yy6wYqCSW/cxJAtx/A81G0bZJFcvxVlle4
	 3EQx7ydJmHFbQsDdedE3TWvS0Sme0GOvCGwtirbGFjvMU45I0+nvK8ZuT5+uFJRtjE
	 YjN+9iHZrxGHfbANfScw16jUbgGaUZCjv9JVnC63nkepVWB03AKZlQRE3rl5seo7by
	 UmV7HXjTluAplDrfpxvq+yvkB0czjX8XOmui63P6ZbhDKxrzkCnudQ4hBIEKzh0o+W
	 lPWvlWRlhsyS2TdFZw2jxROixxelgoRxbO8Toya18wihbJKEdSZzuLcm+yipaTKojp
	 0yfMMwjm09Lgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7258781218;
	Wed, 11 Nov 2026 16:20:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AD2F6731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 66CC04016D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YxMZZx51fyFf for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 16:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 815D74006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kT+d786S
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 815D74006F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:20:51 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6fe4372c5f3so1893487eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794414051; x=1795018851;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B2jRTEfwZ9yzI434++lrInPFCLeY9AA9GnKiICDHh1Y=;
 b=kT+d786SMl8H7DdPBn8DWNhJmc/ONZzRsZjPMF3OQ/PvmD3zQ6NRJjxRYgi4yF1Cmr
 2QWJAmvBlbCSlSvMRJlzlj7EIuSwUF8xbFvK9csHofr4ZXNW6Je4GMU/gRNvYFLlLvJp
 5jTxpfwYIbqxh943Uq7Z7pLHJRaaP8FA9WJ+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794414051; x=1795018851;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B2jRTEfwZ9yzI434++lrInPFCLeY9AA9GnKiICDHh1Y=;
 b=Ir1YEGdTIKn0RxA7KtkE9S2rUmQTCv3mVASSFF9zWXF6Yf/DbroPNBd2WD71M0d3p3
 4Dho8INnxmXi+c9S3uma3KgRlTsAznezUosPwe32i7U0PXGSY3EFOztkXRuoMBmFQm7Z
 xMcSElVEdU2PQu2QGbDuno8MxndaB3wJnqOZxdBNayW+5QYt9MnOAO7BMbUuzwvQaTQR
 6lvljmS5gOTcx/CyZuk8XpkCJ21suSUCSVqGIyMU8UKdQM3JozCwLydi4m0186EE6wbf
 zZESSrAQNox1O2nb5fP4DH1OrIRahHgxVRAy5nlpBhrbBLZEWB9KO1OtzxpodqVS+0zf
 cm1w==
X-Gm-Message-State: APuU4Z+DFaa68WSSTpgM7RCygwwFxZTFfWK0hmvpQKVqEnm87ouI2jpm
 E8CjVlcvp+1J2jAigBwGH8i0U7Nki1R2j2iYzVbiC7AruTP6CIGXoaSRclhkdcyeOCVbEdoEKIa
 Bd6l9MWBBRXrF
X-Gm-Gg: AYBFou2tZcG1IuVZokIDvwDS8parnyCfgTHCNuE6/nB823Xiil1ynpmfWT61MYqX0nV
 nvB+2r1XxwrqDfeHRr4+TIQ6mKiu66jteju2ECY7MBGlXeEgM89zEKTs32lRas/hvJ+mC4G3RVU
 JomyjTttMbc28uzn58fsSLLIbqakoNg5Fwmnq3twg8E7+sRCI3t7XuJP77gYFVZxCFVlnIvMn9v
 m+6lHXt6FK6O815+dxVQ6CkSAtJxBlqhKnsfBv79yt/N67BdM4LuT5Ai6pp4Eu0uXGmukAcozJl
 mCQl9AkqB7nNHIEIn7rHgBSh0MCX+c2OkgTM2sMlIHqZ1I2G24pz/TIFOMrsupQcZ6L6GDSSn9t
 ScVlcRNl4aQX9xkhfjYc/0oDC7Y9OgBIopOi9wVtPewetg6dcdjQZBvcMEdlrKrO2QOPFsM5Upf
 2gQtkZo03bnHuNg+Kp0VbRP1NmmOurLva4I44dej+DlyPZjctXPE1TZBKNGEitO8qbOCMS/76SD
 DoRTAj8eztIfICsMFvuYeXV/FKQKg+2iBunG/4vA9oSyKA31DFcsGNBSoAefz/7xree+Hr4JamE
 t4I1Szi80b/bibSpwEfpcNFIPOXrkbzEZYYfi4ils0rTE70O44JJlxh05pmUCWkY8wB6v1i9b2w
 PcTBVYndkPluXMDXiGLHg8KIDNexpcmMMPkzDX8H02B2O7IpvGgCRTNL40oMrwJ9gjmlzpTjZi1
 08eg2K7ElPmuIE7WMHuO6ZC8Bp+Rd8PDw=
X-Received: by 2002:a05:6820:1620:b0:6f8:2346:cd8e with SMTP id
 006d021491bc7-719179be89bmr1738950eaf.80.1794414050771; 
 Wed, 11 Nov 2026 08:20:50 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcbfa976sm4883061a34.21.2026.11.11.08.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 08:20:49 -0800 (PST)
Date: Wed, 11 Nov 2026 10:20:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [u-boot-test-hooks PATCH v2 2/2] bin: Rename QEMU arm* conf files
Message-ID: <20261111162047.GA530594@bill-the-cat>
References: <20261028035108.2910329-1-bin.meng@processmission.com>
 <20261028035108.2910329-2-bin.meng@processmission.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9XSeQvev8qbqiDLZ"
Content-Disposition: inline
In-Reply-To: <20261028035108.2910329-2-bin.meng@processmission.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--9XSeQvev8qbqiDLZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 11:51:07AM +0800, Bin Meng wrote:

> From: Bin Meng <bmeng.cn@gmail.com>
>=20
> Use a hyphen between "qemu" and the architecture name for the
> "board_type" field in the conf file name, and indicate "arm64"
> for the ARM SBSA virtual platform.
>=20
> Update the Labgrid U-Boot provider to use the renamed ARM defconfig.
>=20
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>

Consistency in naming is good, but we need to keep compatibility since
this repo is not tagged / branched to match up with releases. So I think
in here, we need to keep a symlink for bin/travis-ci/qemu*arm* targets
which also have a matching defconfig.

--=20
Tom

--9XSeQvev8qbqiDLZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavSV2wAKCRAr4qD1Cr/k
Cr0yAP9phAye+OxYBmbNe3HUYge60dMROGeP8qQXXSgNw1qYPQD/ab4fqW147v0+
cE5NeECglkElY5X2U3/vVvQSWNHQOAE=
=f2Ei
-----END PGP SIGNATURE-----

--9XSeQvev8qbqiDLZ--
