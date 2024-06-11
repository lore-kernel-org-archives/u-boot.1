Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5357AC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 16:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B24C388274;
	Tue, 11 Jun 2024 18:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j+fnJU0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9C5788274; Tue, 11 Jun 2024 18:28:21 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C543588262
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 18:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6f8d0a1e500so4296470a34.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718123298; x=1718728098; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/ayXpJJ6o3WrXwBILJKa807p/Dfuf8Lfmtedj5YtyQc=;
 b=j+fnJU0/X+Aql7AN72mBDrZG11hmOMgNAoYt1GiXYM0MtboexYckfCnKoPGSI+dO9S
 ZS2yrc0a4PP/M7KiLWPz+vnp7XQ62ve1+rpwd7GNY0TI8PrTEgurAOIbWzSogCeosWxD
 S5e1Yc5dZDkrxVtEBD16loWc4Tjv2EF+k3XIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718123298; x=1718728098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ayXpJJ6o3WrXwBILJKa807p/Dfuf8Lfmtedj5YtyQc=;
 b=r+7tqeVjrEvC14JNQRQ4zbjuBk9gI3sVjY3J2lk5yezaaO+nl70U5SnIuGEr9714q3
 rGEdS7aso+HKruq1KSR5XMFepGy18D8L5JEKY2ns/aA358voDda2KVGKfsh2bIEfGidA
 Pmg6gadCfEwydvZW8k28EeVwpmDWv7LPcEAcfOWBWo1v/y/CQSiUOMHE/GWdViKrVt77
 iJiZP0ywM1n2hdvQ36TBY0yAa7n4j6QJlHbmBxprHtcjDyZB9LJ0xQHOboWthFNTexpf
 FEF4ZzkqE/mLlafCW8KRCt4oyNre37XD5Iv/Cv+eR015vojPhG1pkj3CS94fDO1HJw0L
 cIXw==
X-Gm-Message-State: AOJu0YySJ9YgW9lQqkopD/mXIUkqnem36oFeO771Gpy2rb1omYMKs755
 6+3xLky2eWqrRID7QGiY6XV62cl//ds2q7fnaSfYzB1ssHIzAhXhG/GSi6jxCl8=
X-Google-Smtp-Source: AGHT+IGnfCMF7bMoNwI1npAnyP67Vczfgvvw5KYFS6plNFcyKrkGIz+yKR8Ud9FgatPRsWih1R0E5g==
X-Received: by 2002:a9d:7e99:0:b0:6f9:9da4:b1ee with SMTP id
 46e09a7af769-6f99da4b212mr8718474a34.3.1718123298463; 
 Tue, 11 Jun 2024 09:28:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f99dd99ac9sm1059620a34.81.2024.06.11.09.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 09:28:17 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:28:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH 0/2] Add support for Labgrid
Message-ID: <20240611162815.GK68077@bill-the-cat>
References: <20240610222743.255386-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WlLqXc1MPpMeYkus"
Content-Disposition: inline
In-Reply-To: <20240610222743.255386-1-sjg@chromium.org>
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


--WlLqXc1MPpMeYkus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 04:27:41PM -0600, Simon Glass wrote:

> This adds hooks for use with Labgrid. The only existing hook that really
> does anything now is the 'console' one. There is also a new 'getrole'
> hook which looks up a role to find various things about it, such as the
> U-Boot board name.

Overall this is pretty neat and I'm happy to see it posted. Would you
mind linking to the Labgrid PR(s) and sample .gitlab-ci.yml changes you
have as well?

--=20
Tom

--WlLqXc1MPpMeYkus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZoexgACgkQFHw5/5Y0
tywk4wv/aWXNvgljgAd0pjlPJIDmbykFoj3tspzsBQX80MC7g7X3KrTQIHkPzZ+T
SFTUwGaAzFm2YVS17M+vTAD2l+ge9ZLRLfdsSt4b1ZhljW1/hz24sz48DSHltd8r
yRQ/9VHJcO0Szdm+tHtdl+2/pg8saFcl68TMZZIA5PIVbzhqp+KBxzxP4XOn6y2G
0B2LkUkYh/OTDvCHBvaoq3iJnXe6/eFlVQdDg6G7dZa1HHK3CRwwnwu5SEa4oTKP
SBsMpskofNEgTFs8ZOodsQedNx86o6uMQfRnqFgrxi7lWcR/CM9binJO2fU/nhDS
D6BI3owSLVCPB92AxNo4I238Fi+0Vx+pBzKac5afpc7rlrxOMlAR84DRfsTaeUh6
XhnHyl4xiwT1Hr/MIttUULILSdia54Dt2znFhY5mP2sL4s6pCiqMhGbDotz8ZjJa
La4fbrwDRxKFCpusE1iz9TAVHM3XI58ukgopriAv9lvniUY1KYaHzExjc02capls
J7q1hkkG
=Y14W
-----END PGP SIGNATURE-----

--WlLqXc1MPpMeYkus--
