Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F60C83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E94A86511;
	Tue, 29 Aug 2023 16:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LIq1meIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CBB986505; Tue, 29 Aug 2023 16:09:16 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77CC886500
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6bf01bcb1aeso2219380a34.3
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693318152; x=1693922952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=35pJMbiCM4tdyBwGt9gUfxx/zqOl0XOVSEkknLUdxls=;
 b=LIq1meIg07Ba/vn8lJmbP4uZE9NuaWIrtfBYxNNy8CKLACCdJd5X44NO5t5nA9ENS/
 ICWDRlhl5BbWXRRU3oMQOi6taI7yFF1VtVlkVoEoZl0SYkxP+Bu/lSl/rVLGMx51Kv+k
 cPZ99+weOnN57/AOV0CDdgjOr8SnCfTCPV7YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318152; x=1693922952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35pJMbiCM4tdyBwGt9gUfxx/zqOl0XOVSEkknLUdxls=;
 b=K1QlvSTR4PF093BiHBk480/RQLQbpHmMH0a5Eu8eAmT+tGI5qfBwGPB4meJClTcDsE
 ymERaMV7/UTKXhc20kneoYPYxVoUqzGoZvnUQFuE4pkU1G5eaNoehlwXrhelF0oXN1HI
 +zIitCthI6qFff3JUl2vT2cJFBunMBKvf777E9h5+86zcYWn5n90WNgTsYXiaANazfmQ
 7pzmCMJKl0QfNZSEQpxedsmhN0FmpA+JI1qpmKuVTlQWge72y5a3iHhyVfDOCl7EubV+
 0eK4BTayov0VpdRntKkhRaDWyoQTIN0fdgY60OeBcZ9IBAd5doUrRn6X8V1Uhb0wvfOn
 WKzg==
X-Gm-Message-State: AOJu0Yxw26YD0TSh9s1xPVqTMOAaIhNd2+5FeEoFxa5unEHP/RI282l/
 2Su+O/fdNBu+5SUFRhdDKgwScQ==
X-Google-Smtp-Source: AGHT+IHfErpHzp5RtNBqcmpMrPRp75SRXlTjTefRIJ0Ys3RW4s7dYBQkQJ6f+NNR6edX2c02CacOMA==
X-Received: by 2002:a05:6358:787:b0:13e:b477:8015 with SMTP id
 n7-20020a056358078700b0013eb4778015mr2206284rwj.9.1693318151873; 
 Tue, 29 Aug 2023 07:09:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a258801000000b00d5d4bae6fdfsm2110258ybl.30.2023.08.29.07.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:09:11 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:09:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] configs: Enable CONFIG_DM_SCSI in am57xx_hs_evm_usb
Message-ID: <20230829140909.GS3953269@bill-the-cat>
References: <20230821135910.55795-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pZWUC58GQ2X91V2N"
Content-Disposition: inline
In-Reply-To: <20230821135910.55795-1-afd@ti.com>
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


--pZWUC58GQ2X91V2N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 08:59:10AM -0500, Andrew Davis wrote:

> This should have already been enabled but was missed when converting the
> base platform defconfig, fix this here.
>=20
> Fixes: 3c5aa6caccab ("configs: Enable CONFIG_BLK in am57xx_evm and am57xx=
_hs_evm")
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--pZWUC58GQ2X91V2N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTt/AUACgkQFHw5/5Y0
tyw3PQv8DzPtDThVFCSpVGgvb6aJSm3aeQsW9qQF5cg2TYXUey8RoeNM0HFzWixw
oKLSy6p/aPaNN4mVslc+oBwc5qF1AG0vpL6iB7UJpCTrJAxvG6YhA241vChPfwTU
1Q0ficMT5I1Fv2UB0Tsbqk0T6PYmBJ6BBesEaiwFhC+mFcqZmIxtC7nQ7tE4wtG/
8POG2VPgufLaffOAlQzLF/j1dupGQzaZDFtw1odp3qpr2+eV6Rheqfl/doJ2mMUQ
IOL1ki6/hyA/Qcl3MgCYQv129dHwiqHIiEvErS7FS1kwVrRfhYymzcue7WfT0oB5
WQKZ8kVTFXdSz0vL6r0qagNedK6k+F7xyL5H71msj7cn1VrOrClHUWgS+EQWznzp
dTpr/VNe7jcjROHbDC0BbM+HREyWuuM2qkBRlXofTm5fY0WtTPGF2aTitiCqpHya
Y/R+FUJB3kmzlG5/P4sTkcFAdNf2ku9PGRt69bQSFnxQPnt6yx6hfITwhT03/PkL
Szn+zCnG
=SxMm
-----END PGP SIGNATURE-----

--pZWUC58GQ2X91V2N--
