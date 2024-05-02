Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B45C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 14:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B54F883BE;
	Thu,  2 May 2024 16:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YIONH7jL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B21A883AB; Thu,  2 May 2024 16:42:28 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B50883A8
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 16:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-43b0b09d012so21063241cf.3
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714660945; x=1715265745; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CBKgS6Xxz2uSRtTx20DfiaRmX94pzH9tc95TmNtPY9g=;
 b=YIONH7jLG2E4MJUDuP2khqOzW/Q8CViW2cL2mAOJg0KUDo4Vu4abYbgWbab3waU+a5
 yLwCO2NbEp4OjaZSgKPMbvY93P24vxvixq5m8If3O3f+gPEaY0Ho7tqUoARIDEAi20pe
 v+iG/k6nzz2fJr38kXRueYxmLapcEZbpeXJaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714660945; x=1715265745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBKgS6Xxz2uSRtTx20DfiaRmX94pzH9tc95TmNtPY9g=;
 b=JOhamOUPYzmnFDSKboL4r+/bMytwD7uN/zU72jz7P/4WeV8xNAf212B8PqDVfYKJhz
 w1dXh4nXweyOLJ1xKW4Y96NfVy6VjBd6aSJRW+tDIMI5p7LMcDKwlsl/81l3e37deQ1I
 Vgbvu/GrCfsZZV39VmnNyjb0+7SDVT+FJA6x63sq4/8s35yEi7t/GepnyyYmoNLwCiIt
 Ob2oXMjmbxOsfGHun2g9bTliexC/9hKWUKSLRhfgybLNjC5Wdk9xFJxinrKfh6wl6qqk
 EfId7rPmUTcr/ysFzQbgzUaVSI5ekmUAqae+1Qj45rDQjhjbV7vP9ULePE9XiaYin6pT
 2h3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmDa4aw7VL3ZEP+V+/cDRDz21+nLvTLF9+EQyB6oqTurWt7IZLKuFrc8LKFI2nabR/4WCFrb8ReB8L7qW88wA3ik4qtg==
X-Gm-Message-State: AOJu0YxHhm6fhsmAUqw8LvDOwsV2rUYnBUhLF6ZgOTymTy7UPJXceiUT
 0LTeeFUPBxMqL6DIVYXxOJ/v/CmRtHNZgd1qTQ7NFUQtL0pcCzE6CL6xvzUOK0TJkjUgSdXdELg
 ueP3wVOua
X-Google-Smtp-Source: AGHT+IGSQCRh9y1ocdgcxifsBlMPKNSo7HSTJBPx/iZR5tClDdw7N5T+wKiygQ6eyFL5okXwfYgMfA==
X-Received: by 2002:a05:622a:5786:b0:437:9875:9905 with SMTP id
 eh6-20020a05622a578600b0043798759905mr6509547qtb.27.1714660944783; 
 Thu, 02 May 2024 07:42:24 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 fp35-20020a05622a50a300b00439c660ee16sm522664qtb.84.2024.05.02.07.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 07:42:24 -0700 (PDT)
Date: Thu, 2 May 2024 08:42:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: rick@andestech.com, u-boot@lists.denx.de
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20240502144221.GU1054907@bill-the-cat>
References: <ZjJv89FBY8JofG2T@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fxmKqZKKOa1cxXoW"
Content-Disposition: inline
In-Reply-To: <ZjJv89FBY8JofG2T@swlinux02>
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


--fxmKqZKKOa1cxXoW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 12:38:11AM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit ff0de1f0557ed7d2dab47ba976a37347a1fdc4=
32:
>=20
>   Merge patch series "Update PHYTEC SOM Detection" (2024-04-29 10:56:05 -=
0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 19b762cf83f68b9d9a1f14e75d75781cedf4049f:
>=20
>   board: starfive: Rename spl_soc_init() to spl_dram_init() (2024-05-02 0=
0:01:18 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/20596=20

Applied to u-boot/master, thanks!

--=20
Tom

--fxmKqZKKOa1cxXoW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYzpk0ACgkQFHw5/5Y0
tyyr/wv9EFCTkwbOow9Q/EO4sCPR1dNk/ecJyI+eFtvFijDRg6rGTluma54Xe1MN
D48nT9Q6jHpAigVRDyhD+5/da4iwa7GRUmffzsMDpt+FIVXseoORvX7JZWievhjE
gSlRo172RK8elOCToeGhPcI+5wA06L21ciu+2x1BSLthqcugLT7FSbvt/xC6b5Vb
mYpdvmDFlwVs9brRtsnnQgzP3m9T3wvst4tLZ42KgVBpZaQr48JQjow+TeQ+elS4
q/ZHf0QZ76lKufbpN8oGddZStEVRB/lJOUav8GFQEn7PDpRFCAfSCXxpcVEj07Oq
iZDfmCIr229w7m+08NBtRH6+vAbsOMAkr95mJG5cnu+csIYVNmL9s35DK17AOH1s
ac/1TYFUlANROccFeG/jYE41mzDR4bfjDSYOabTOxJwykKiW4N10+yqhONKqJ8k8
vnJ01PctS1Z1DlW8PlDjMRyr+EUtuw9wcqYZmTXt34h1bXOa8UtRAIBN0qOVDRkt
B3rftXXK
=ik+p
-----END PGP SIGNATURE-----

--fxmKqZKKOa1cxXoW--
