Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CD0C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 20:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EB9288005;
	Tue, 20 Feb 2024 21:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VRrwd8nI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D616687FFF; Tue, 20 Feb 2024 21:05:09 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828BA88003
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 21:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-365273fb1a9so8076555ab.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 12:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708459502; x=1709064302; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JhxifTka7CdK9NuaKFDOo1bkkHOUrUfcvm4A5g6d33w=;
 b=VRrwd8nINR53QVZsKNy8cmdH1v2IBQx/wygIYrmbVysAGgnhb9tITiAKN2fwChN6td
 WYWRm7ygVAEAMPVgldYMn71En9tFZFomCmmPv/PdARzDAIQRFyBIZ9exVIP/N0nM/WCQ
 EtBzAbwB7K66gCtQuBen7ylEdGb1+Nl8+NlJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708459502; x=1709064302;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhxifTka7CdK9NuaKFDOo1bkkHOUrUfcvm4A5g6d33w=;
 b=M+sIHGY1ezibQpB3TXbH5nNV0UHZpJItiHj2AGZPdLhiF8rwCjMRTae384aT0WRVV7
 x0Rmqop7ztAiB0k+kLt4IAyncr/obKc8JYzjIhmn+TOtLYSFs5QBr5AsMgldAkyF8VGc
 E5uASxk9YO3tlZ+rNF1VTDipF3oBNiIwzB7VVZxENrYM71MVFrDD8sdTTw/id6ZHqZnw
 RMxp45koC9JNv7hFoy2iZL7AoL9p4Q9v1aIgf+vcG4oaQbv6dAd9hKTBQlfzOSdM1Fj1
 jHXNzCGHP2K9ofeQ+SKoL29rZYxEAhbwVPYvtIkS7aLMY+nXnfvDTJJvK8Gk2hwoFekF
 3kdQ==
X-Gm-Message-State: AOJu0YxCSUfW42so6Fd7JtKS4SU4FspLTrVj3LoeHS7L8BE1o/fSMDN5
 eIo3fBhLvqwiPwJASZfDcOpZM2wbjJlPh3PEzCMxhVwNxBOH1ntZX9Sbs3vhuBU=
X-Google-Smtp-Source: AGHT+IGrpZBxpXhfDRHAesURMsmJbEbI9w/IWbErEwiO7uqxMJB0vYCHLDkyww4OHCOKzY/MYAN9SQ==
X-Received: by 2002:a92:c101:0:b0:365:1976:4869 with SMTP id
 p1-20020a92c101000000b0036519764869mr8947772ile.18.1708459502091; 
 Tue, 20 Feb 2024 12:05:02 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 bx15-20020a05690c080f00b006082aec5cbbsm1190026ywb.132.2024.02.20.12.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 12:05:01 -0800 (PST)
Date: Tue, 20 Feb 2024 15:04:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v3] test/py: saveenv: Add a test for saveenv command
Message-ID: <20240220200459.GS3040305@bill-the-cat>
References: <a206af0d5844af9b68d315e6e667db782fc5211b.1708413969.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a92pMPArJ1jqqi7x"
Content-Disposition: inline
In-Reply-To: <a206af0d5844af9b68d315e6e667db782fc5211b.1708413969.git.love.kumar@amd.com>
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


--a92pMPArJ1jqqi7x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 01:11:49PM +0530, Love Kumar wrote:

> Add test case for saveenv command in non-JTAG bootmode which saves the
> u-boot environment variables in persistent storage.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--a92pMPArJ1jqqi7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXVBesACgkQFHw5/5Y0
tyy5Hwv/Xf6XKnwSQXK6lhOEx87oKiDJceGFl/WAmrQYAxKLyQDNPoIIoLjJu9vx
ZfrXXhQjWLd3ma+YFE+a0NXIy4rcQ592SyMrbh0zJ8VboksZtAykPAisPOhEAkk+
gL4OM3vxFM6GPd5xOnSu8Dh8U1Zp0lPnyJAjF4LtY4a0maOQHF62stNWRDnnN4X1
6/xTJZiUBWJRq/Bhy4isg/TL+XWHdZTVcULAzEpdO8zgaoNC6g1DcDNrAQ2BEvBN
nZcGH8fR55MDao7PmejPMDEQMgUkIVOdRB7fpIoDh7J4J+83QvEylUVPChsxJHZo
Ls7V+LEatco1fu58cjRD4V+Nf/aTS64gRZX7WikCxO7V0xh6LgbbnMhuthGAjX/h
RoSEQEBs3R8Htv0W2daJyO4KjSdxzAFGQb2tWKhj3EmNIEORBAcz6Nn5sQ+GsUny
Og2Sd5H8n1i+13SimY/cC4LGl9EcMFHK5hYm725wyprKzDrK4E/o5VamW3F4wYuD
3xj0rWPy
=I3sB
-----END PGP SIGNATURE-----

--a92pMPArJ1jqqi7x--
