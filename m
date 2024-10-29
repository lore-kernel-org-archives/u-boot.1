Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61C7D7494D
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 23:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF1DE891AC;
	Wed, 30 Oct 2024 00:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J/kIgg7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01DE4891AF; Wed, 30 Oct 2024 00:52:57 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E360F891A3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b153047b29so409349785a.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730245974; x=1730850774; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Kh62XcKFSagOYy1L9IUadZ5Et2RI7+10uBHz+Uu6/j0=;
 b=J/kIgg7xI/jt0TLxLD9+9KL0rOtMR+B3D+92k2KkUqnDqt5nCnEV5iXaJufvbNcKDO
 t5w9crArj6Pozleb7t/HaeojKCMLf4jV4w1gqNs2ItabYjwO9RhzkhEfKVMq5JYE+lcs
 wXMsNkHyVkLzVfpWwM7h9LUxlXNOilXnLbb1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730245974; x=1730850774;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kh62XcKFSagOYy1L9IUadZ5Et2RI7+10uBHz+Uu6/j0=;
 b=nzcIAsX2zOgcxl9Wc6KYnt9PXffjM3NIZdpkvxRyztVPo+8LX0mXmLk2r5VRJVaGFs
 Cau51+c9DmfQrnOYbVFGy1kC3vFbUetpLuJ9dgq9XOX0cKKkjvsnj/4xFNV+B1nfbolq
 jFf/SyinnM90JyTt8+ZRm/YpRGlCgE0b3EhkyAKn5rFx7PmRej80s7TwoO1+3J9eKSaE
 Wk8SORnRi0PlrTLNCtE/tYYLGaYAjJjD5H1Ruw3GX++aC0hh+q1SHSv7MtL77F/o8N+l
 mHL87yoZpCgcX2s+TTOWv00OWjV9hXhegbU59RnNccjalCxX9XzsJyDwcqmRR+5kUU7Y
 PpmQ==
X-Gm-Message-State: AOJu0YxjRYEQ7kxGAulDkWvtvT42rPtdqSqs719tg0GF8dYWwxAfRxSu
 rioKfGxHWgP03l6AX2D5r1r50ztqEExwKIoG6R9K6Kp6WPghqGKsmfvEaSGsgAKRu7eufXXW9Gt
 THyo=
X-Google-Smtp-Source: AGHT+IGZY+JiLa8kKVwS+CJGbC7t5XJhv/EVdzTIwcRvKCwT9InO0D0CzEB4yM+DeR6tRpdmUaaQGw==
X-Received: by 2002:a05:620a:2944:b0:7b1:11ea:1f62 with SMTP id
 af79cd13be357-7b193ed7f3emr1936688385a.8.1730245973797; 
 Tue, 29 Oct 2024 16:52:53 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d35882asm465244485a.127.2024.10.29.16.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 16:52:53 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:52:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 10/11] test: Support testing with two board-builds
Message-ID: <20241029235250.GA2558755@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-11-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3nQSjmCH+1mYuPlf"
Content-Disposition: inline
In-Reply-To: <20241010015145.1977999-11-sjg@chromium.org>
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


--3nQSjmCH+1mYuPlf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 07:51:44PM -0600, Simon Glass wrote:

> The Beagleplay board uses two entirely separate builds to produce an
> image, rather than using an SPL build for this purpose.

JFTR, this is an incorrect explanation of what's going on. The TI K3
families have both a Cortex-R core and a Cortex-A core and the R core
needs to come up before the A core. But in both cases we have U-Boot SPL
and then U-Boot proper being used.

This is aside from having come back to re-review the series and still
feel like this is taking the wrong approach to the problem. We wouldn't
add a --optee-build-directory for going off and building OP-TEE and so
forth. It's just the case that we need assorted binaries for the system
and some of them come from building U-Boot for another platform.

--=20
Tom

--3nQSjmCH+1mYuPlf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchdU4ACgkQFHw5/5Y0
tyz+8Qv/WKpkioJ9wVnoEkb67Dbgd9qGIgVmuTrcV72oWVCEr35OUjFwgUVVSdZd
9pMEQXsLGOxYiwrj9f7na4UYwMNF7EGIJxJksWj6P/oZI/gIoZJsOXYAsBOccfWa
QT0OGF2KZIZBZqYHxf8txhjbZ1/JEBicrrkGjd7JortlbjGE6JprXBcrf5glqZYT
vbj31cXbyYZdclHyjROYEp+dlts1zBjtRdVlTB2LtXC7lFSlycu6+ywHMSOPnZxf
ouXotTIzq/vOYVym8p+ZhJ3zWfr0M+M38D5kfutuxR/pTQSSOkgIn7HbhfxtEz/u
iDepgakg/Cst/s2wcKiqEDWklrDJCSgv9a01SrytyiVnjkKkj9y4WBWfHT4V3ObV
iECZVG6CWFDB5cblP1LBtX4aAH4jedsHwCop6qHKLqkjQxrGljaKirPL02/p9Wjr
TFw1p7b/os6SyW9kS0bK6Gb/V8q77bLBnSKzFp29xFumq7hAIdVyvFlQ+0Mp+JG3
cc+2vg6S
=Uft3
-----END PGP SIGNATURE-----

--3nQSjmCH+1mYuPlf--
