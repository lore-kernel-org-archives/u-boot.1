Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B40C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 16:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98D7F864DE;
	Wed, 23 Aug 2023 18:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LplMAXVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0029F80702; Wed, 23 Aug 2023 18:49:34 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308F9864C1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-579de633419so65035987b3.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692809371; x=1693414171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bKJOhZX5Mrmi/Gl5owyUZtJlhSW3w5Ts86O8wphjJcM=;
 b=LplMAXVeFnXn3VtVilClzFBgkNAQVLv538V4xVi3tXrAsgCRemFhIKYr8DTSWuuIlA
 Faz7eeMmMUJToXkRC7VCcj6qdmUK2tEPVAkiAbjsPHUIjSTJ+/079xby5MZ2oSJz8hnz
 HukkgYbKYxKHedB9WW4QHUKyYASc7/AAMNwKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692809371; x=1693414171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKJOhZX5Mrmi/Gl5owyUZtJlhSW3w5Ts86O8wphjJcM=;
 b=HsCMocRBexCEaXM2IwHavLdkDDU1T9PFNLUNE/QJBIlBL4gAAPMAjFYzT55HWWm3l7
 llItGDwVwO71Jp5V4fdzFNKshY5F+12B3OusWVgD7iHiXzmN7cNY5Hs2w87PbzWSpjKi
 Kkgy48AsPeRCN3soumOCqBhwesrKg6TazCWxG0RzQ2LqH2YeGR6Txm5m7+V57QkOFgwj
 R//IzL+4kajU6jSZQ3da40eCgEI6L7vWBpdrVWTTmeYXQTG/DJ8aEtYV36APFxWxJZVK
 0q9UN1e6qUSPtvDt7hPZHtD6f3g07JvCjQWVi6C05euKM7RFgcATGZWRI8A9eMHQZNqd
 lvqQ==
X-Gm-Message-State: AOJu0YxRNRH7eRhsJFHd4lasg9IXOsKp9U0ajbmVrrJWCZutaf6Iupc0
 jIeAEU6YzDhc+7UtANEgah49qg==
X-Google-Smtp-Source: AGHT+IEpQIaG5RPkys7yRxp9muW9NX8Jm8FX12KA3kfjXYI677wrwRJHiRuWZ/vnW/S48dQd2JbCvQ==
X-Received: by 2002:a81:9289:0:b0:58c:54f8:bd45 with SMTP id
 j131-20020a819289000000b0058c54f8bd45mr13823648ywg.44.1692809370893; 
 Wed, 23 Aug 2023 09:49:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 v20-20020a81a554000000b00589a5bbeb43sm3407664ywg.117.2023.08.23.09.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 09:49:30 -0700 (PDT)
Date: Wed, 23 Aug 2023 12:49:28 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Config fragments
Message-ID: <20230823164928.GO3953269@bill-the-cat>
References: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
 <20230823155558.GM3953269@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/yRqouLdXwSNVbZ5"
Content-Disposition: inline
In-Reply-To: <20230823155558.GM3953269@bill-the-cat>
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


--/yRqouLdXwSNVbZ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 11:55:58AM -0400, Tom Rini wrote:

[snip]
> Using the TI
> examples, I don't know that you can use buildman today to generate a
> functional binary (and if you can, if --keep will retain the right
> files).

This specific point is wrong (export BINMAN_INDIRS/BL31/TEE, buildman is
fine) but instead has me down a side-track of what the heck we're
doing/not doing without --keep-outputs right now.

--=20
Tom

--/yRqouLdXwSNVbZ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmOJUACgkQFHw5/5Y0
tyy7Fgv/QULE0CSGwGhr2xQjYstXenHX+FvuFH/pG/XlW8M0vfwXfBMr93DwiPLc
hFNstNt5sTPBFF/1Bzp+S3QVbhkVZEyJBE5q4K7jwkyTo1Le6/66l87tcMyidXMp
k4iR5XgofhbGqhFn0Em10+eQKdOfPRU9OHyxYNiNEF2perA3OprbkGnrCPthvzZA
8u8wvYpwNT+mFzNyjOwuuyYgxjkfWJD4gBNgkJ/NvSb7Y0XzCA+Uy94TwXDTG5cI
yBSWy2Yjp/h8qecUajoQi0ekIfQTwZMABojhGhxo5jcJcsr7lhRu5lEU8I0QrHnY
+kWFs103u9gmKXuPDxppX2yJ+yiK8FYDAh7Dgav/luQ90+TT3iLQgw6VdSTUKog3
NigIrhRAcOy0+/N6pS4vumcZ9Yt57FQJkFgi3qhIWrs6YfL0ROOxvFqQQegqoTcM
QZ8xGgqIisWdWv5sNB2Var36sMdcu5Ky+vFRMhTcG9wkpNCO6DpSdgxZt2/RhTsp
TWY5feMs
=GWEM
-----END PGP SIGNATURE-----

--/yRqouLdXwSNVbZ5--
