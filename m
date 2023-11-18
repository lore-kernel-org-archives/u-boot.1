Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FD5C072A2
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 00:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62EA186DA2;
	Sat, 18 Nov 2023 01:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MjJljgVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E83C986E96; Sat, 18 Nov 2023 01:56:04 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904B88008F
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 01:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cb615c6fbso14491841cf.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 16:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700268958; x=1700873758; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=szwMMIdrcTwUN+tbaTDLyDVBWeSZNwWOAa9t95sNDEc=;
 b=MjJljgVaHC8SJLkHxciUIL4gJfPGOXHhwvixpSJiyf3MkNgKHaQCF97GKyCryxMHei
 hJUxbQGRYyTCYEpLPNBHotm5No+j901y40eKIonAjGO1rEXW0C1svkm4xTO142ItSnJH
 DFgS3TuUfD/fvjw0iz/sCEs2IVi3KaTyAI+M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700268958; x=1700873758;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szwMMIdrcTwUN+tbaTDLyDVBWeSZNwWOAa9t95sNDEc=;
 b=Lyr+peG1y3C7zhGo6PwPBV1s/+levVjY+ujlDbHtI05ByRvU3D/012KHDclD0ujipq
 zombZNIMSNWFW+02sGGmgSc3uz9BZmdJ8RzyhE/Ns7ikOVrGn3BdOGBbb2d/8wB8VTuK
 t2ZavE6XZfco4FsYB2z5PcR5YwoMfq+AjVXORO56KBrmki7KOS7t3i1gQXZuZ34a+QmC
 A9Zu8yQAk1NQ9m79zzRI37ctkbsRj1OkYqwM79CJeHSoh0E5QVcP8LFbNbxvmyfsFgxs
 jm/VfvdVVse2iZmJh/6PpTIutq4wrqR1Zw7dF5NugqI66bslgvSkAIH+y3jlT7seFviM
 s0oQ==
X-Gm-Message-State: AOJu0YwNVx9LzW8bnjiQrV1Y1mbr3UPFYWflEuQ4abfVEcc0HZyD+LVk
 SW5oI662p46qBnfCfVKH+RR5lg==
X-Google-Smtp-Source: AGHT+IGbEngmd16GKpj5aFio4e3HfW1T9VsZ7Qs106YKmE8hJTAmIxTlidzipbRC5/Hqaq2xSh6izQ==
X-Received: by 2002:a05:622a:1107:b0:41e:2523:da45 with SMTP id
 e7-20020a05622a110700b0041e2523da45mr1727248qty.31.1700268958350; 
 Fri, 17 Nov 2023 16:55:58 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 b1-20020ac85401000000b0041cc25a75e5sm953413qtq.77.2023.11.17.16.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 16:55:57 -0800 (PST)
Date: Fri, 17 Nov 2023 19:55:56 -0500
From: Tom Rini <trini@konsulko.com>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, pbrobinson@gmail.com
Subject: Re: [PATCH v5 1/3] net: Additional fixes for dhcp option 209
Message-ID: <20231118005556.GF170968@bill-the-cat>
References: <20231118004826.157835-1-seanedmond@linux.microsoft.com>
 <20231118004826.157835-2-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5nad7zW+beSxFqFl"
Content-Disposition: inline
In-Reply-To: <20231118004826.157835-2-seanedmond@linux.microsoft.com>
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


--5nad7zW+beSxFqFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 04:48:24PM -0800, seanedmond@linux.microsoft.com wr=
ote:

> From: Sean Edmond <seanedmond@microsoft.com>
>=20
> Addresses feedback from latest review:
> - Enable option 209 by default
> - Set pxelinux_configfile to NULL to avoid potential double free
> - change hardcoced 209 to a define

I was unclear in reply to v4, sorry. This is the kind of commit message
I was saying needs to be reworded to say what it's doing, not saying
it's in response to review of...

--=20
Tom

--5nad7zW+beSxFqFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVYC5kACgkQFHw5/5Y0
tyxy6Qv/Y7MqA8aYSBz5Wmk4XlX9VqvVU5GXFuQ6vUkCzCKkfQ3OeXHg6fkEvkbr
7HfYqc3Bo6ekiCdOfjbbgMlHiAgJMMK7vsR6LEWVbiqtdy7oMIcV7xe55CPsUe02
wJqOsKkJ8370KtmX+hUjiDHT3UmACqNw7I/SpFfFRVQCT5/FuIoJzhS7axuu+j7u
Yg3337DjGCLsYRHC+LYHieBOAQwKiCQLx6l/scIekX0Pb7KAmxxhvEZKFipfK0Sm
NbqtGZDonwVzhpFBFy7E74j5+BS0QQR0+EN8g6NvLWnaQ7Q1FYOWdSRRZ56wZAp8
UdnGgGKsS0qWxLxt2hSTWpAu0lznfSV97rxL2W+Zv5HH4Aoz4O2eUIkl3kUoPXaX
s8E2mlsKEPPuQpAdnvVvb5RBSYZrg3O8DVGrL86QgAoRfwhFYwqtrzDALXjZZCP3
gONJjyq458RAirr3/RDJNykn0B48vSU1GFDXTxAzRY0tLSaqC/XNTqIKfqz342Pw
x6imp3I2
=4egW
-----END PGP SIGNATURE-----

--5nad7zW+beSxFqFl--
