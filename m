Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95F2C46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 17:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F71879EF;
	Sat,  6 Jan 2024 18:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aWeLRi+/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D7FE879FD; Sat,  6 Jan 2024 18:41:15 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 806C4879E5
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 18:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bbd6e37af4so572578b6e.1
 for <u-boot@lists.denx.de>; Sat, 06 Jan 2024 09:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704562871; x=1705167671; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=baPpc50YsvReUs7nFWxTneWIuHRr4ghFgBEEpT7fPP8=;
 b=aWeLRi+/1WHQ/0F6HfXi5kDpyJPsl6GS+b+lrKUJKEHjSqen7LmyOaJ7Sy0Xps9Ao0
 NEe5FAOkqI1242GTBm7GCXOr/9350Po/0B1DC9iJeSR724EeqrBiq+21NPqnJ2OY/3pA
 IHcfvDMTIFRtd//A9npDoVlHdE1s5eztVRODI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704562871; x=1705167671;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=baPpc50YsvReUs7nFWxTneWIuHRr4ghFgBEEpT7fPP8=;
 b=bDVVLyayel4P9slAQ5Kk3vRYBXyHY6zZeD5KEPCkhtLB1IgpLiGr7+dSC/rSGG8UBb
 A+8WlNO4BLLN+ZDLh+inWFy4E5tyMeM88CsyN4nggyv/fX/DREJpzNUYGTKTcVDxaIew
 TjXV99q7urvVqaFY8wt3B16MsfOput/CVmQ9A+kGwJXxBOUXOeIPTVAalR/Ts9s6898N
 vC8RQN33VWogtMPUBkAyrGEsSwPW+W0LXWbG2ZE0w0rrKhd759CFdNjgl6Bg1e26Tlhf
 BnrSDDHCI3sD9LoTbNQPCYA00CvQUbNAEG3iLM36zw/SNvK3EEnMtK20OEomf1m/OnnJ
 s/Ew==
X-Gm-Message-State: AOJu0YwAhHPWKn84UHFFNm+vHnSJkLJB//DBspg3F0atVLIoyEtdZlRu
 ARY/+RLWp0FGAL3ORHTN+FR4PITdOggr9bAVZpYEg6nfl4A=
X-Google-Smtp-Source: AGHT+IGVTLeH24eh2GH5fwWf0dTKdTdsevl257qL/+zcDJlXl065uCrtt8KrGK9effp9oJdNICa8+w==
X-Received: by 2002:a05:6808:1489:b0:3b9:dd70:7660 with SMTP id
 e9-20020a056808148900b003b9dd707660mr1399411oiw.11.1704562870995; 
 Sat, 06 Jan 2024 09:41:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 cx7-20020a056214188700b0067f4e2ad746sm1519468qvb.44.2024.01.06.09.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 09:41:10 -0800 (PST)
Date: Sat, 6 Jan 2024 12:41:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng@tinylab.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] tools: docker: Drop the git user name and email
 configuration
Message-ID: <20240106174108.GY1610741@bill-the-cat>
References: <20240104132817.278079-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tcHr0Rt7czDdsmFc"
Content-Disposition: inline
In-Reply-To: <20240104132817.278079-1-bmeng@tinylab.org>
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


--tcHr0Rt7czDdsmFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 09:28:17PM +0800, Bin Meng wrote:

> Since commit b45ab9ca6621 ("CI: Update to QEMU 8.0.3"), the manual
> patch applying was removed, hence there is no need to do a git user
> name and email configuration.
>=20
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
>=20
> ---
>=20
>  tools/docker/Dockerfile | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index c4a2596b48..c12ed0fd9b 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -179,9 +179,6 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tm=
p/grub && \
>  RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
>  	cd /tmp/qemu && \
>  	git checkout v8.0.3 && \
> -	# config user.name and user.email to make 'git am' happy
> -	git config user.name u-boot && \
> -	git config user.email u-boot@denx.de && \
>  	./configure --prefix=3D/opt/qemu --target-list=3D"aarch64-softmmu,arm-s=
oftmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softm=
mu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x=
86_64-softmmu,xtensa-softmmu" && \
>  	make -j$(nproc) all install && \
>  	rm -rf /tmp/qemu

I'll apply this next time I update / respin the images but I hadn't
dropped this part just to make the next time we do need to backport a
patch easier.

--=20
Tom

--tcHr0Rt7czDdsmFc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWZkLEACgkQFHw5/5Y0
tyyRYQv/TDdoBBuhECdMDHPYANsn6DrHtZkDMh8KcsXf6oE0qvqKiNJ/IjSGeBJy
PUpdD6FfuCL+QfcCPTjF/PGp6j/EYNWVhweWTU6+q0d+ShpEl1Z3YUe1SN/kAIq9
Af5JS3zKkUDDYL3keBv/qjgCdK9AajqVfTK1atrPgCleLsjEz3NDKQ+7x4ibK0F4
3ygAit1cTSx9Si56ff7rWjQYoFOsJXYr2oucwnZgkclDtMUprazYqepGdVgQVWiV
DPYQ85gkCiBtnb8VTysdNbYLzSFXQKyNvUvTouvl9tI0nh7ffnIIUmIePekOVT0D
Ykxds6TF9XH6sapPFyFzp9Jw/7n8K1kqSuqYy4zmEOQSJqoSanzQQPt1ICztUpvC
lBZsrNTXVjZJlxfjPMcsJHAnYoq228+o3O+3BF8PeTmvmhGYL7ixf8E+1N7Hkqrh
b/aZ/BY9vzsf6ulgbhlWRyCpOQ+RluOgqYlEtxY/OmDH3NrmdEppHKQsgU9eHfuF
mPWfwOFS
=KUra
-----END PGP SIGNATURE-----

--tcHr0Rt7czDdsmFc--
