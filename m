Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41874C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 20:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC9B48842B;
	Tue, 16 Apr 2024 22:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aLft4mjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26FF88836E; Tue, 16 Apr 2024 22:26:29 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE3A2880DE
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 22:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6eb93ec8804so450810a34.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713299181; x=1713903981; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zdhj9PxoRDpVCTCFPQ+LDdJcRwih1eZjylLV2jVw3e0=;
 b=aLft4mjELp4gW8smDYnVyLy/AEzqhCRXjFZUjh2QmfV66VZhXaZyGOl9ZF6dknf7rI
 Ee6RXrIdt8JvY1G0+crJ0Kk6XpyVS4XGmNpzyCA4wOWASWSkKtDQEDj+EBlw3B3a2XCR
 ZvyI25gD/mHJnxoVvoLc4mVExuD0zKmd2EBTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713299181; x=1713903981;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zdhj9PxoRDpVCTCFPQ+LDdJcRwih1eZjylLV2jVw3e0=;
 b=M6nY+VLdG90x75sricll4eo3kxT5Qjy6w44QiBi6MO+YUQ6BX8Xwrc6N+vyjMZd/lZ
 ksWZdh7Q3lBEImI89P1gsczSmOAosFjia48vSN3Ca3wo/myXWokQ1opy8Hsfjfs2650U
 Mzxa4rOiIvNu+3A4Y6rHlWGkT3Ha+ohdMOnTI9eCHH7RJa0DGz3YBuvlNVeKDnaLJaTE
 unoquiK/dwwi7VtS9qmPt/xTUbF0nd4tHQj7FILER+wTBbIz89TLVu8gg7rk52ETCH8R
 97UPjYylu9G6Y1SEIzHzBAfHser+xJx3qHZ9esklkBcj3vu2vfUEL6IjaU7GPHrFG6EY
 TGPA==
X-Gm-Message-State: AOJu0YyGdQ+EpINqG2uYflwGM3vAyUNQ0Cxn177BfFRAr31m3AHNLyS3
 xktKFBSyci72JpTpfy1leGQq5t/Ps6MbDZib6dpvLa/hW5PllVVB6Wql9NZjhtI=
X-Google-Smtp-Source: AGHT+IGSd+bu0/Mo7ElrnMV7L2jwMqAkXPgL444FNupCPCLV+71TNqXmWq7I8c9WwWhTVI5Pc+ekRg==
X-Received: by 2002:a9d:4d0b:0:b0:6eb:77c2:aef3 with SMTP id
 n11-20020a9d4d0b000000b006eb77c2aef3mr11073059otf.5.1713299181561; 
 Tue, 16 Apr 2024 13:26:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 dy53-20020a05620a60f500b0078ec6778be9sm7152694qkb.111.2024.04.16.13.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 13:26:20 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:26:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Subject: Re: [PATCH 00/23] [RFC] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240416202617.GY1054907@bill-the-cat>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qgjY7zrAqHI7D0FS"
Content-Disposition: inline
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
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


--qgjY7zrAqHI7D0FS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:59:56AM -0700, Raymond Mao wrote:

> Integrate MbedTLS v3.6 LTS (currently v3.6.0-RC1) with U-Boot.

Please look in to:
https://source.denx.de/u-boot/u-boot/-/jobs/818534

--=20
Tom

--qgjY7zrAqHI7D0FS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYe3uYACgkQFHw5/5Y0
tywL2AwAgVEb5ZAnZOkFrDcHDdgz1n6aqeAALXb5HAPkTUlxrzJQNJ6mm15WCKRU
sO/a9Vj8d3cr2TAlHJFse/isBlDJc14uIdG2synI+w6ivx4rpiBHL1uMdAwzX5I1
edmZEa5pm3Znzb+2S0VGRfuD2NHfghs7W9yU3s856SjPBrQfSg/36ftXqGX5Ct3Y
uWY9aAeEkyHVxJAxk2sTfYgXPECe0FcEjCM/E8w+0PFXjXT3Fqn7YRg1+Zr9qN9z
Tpb8K75I91c6jpwuwMrG88/ri4dEhBibujnOs8ryfhKxYCiJDorV0SAlJfXLLD1W
KtCKsXqOW9jyQBaJ0nQGDDUFcZRtL8aLfkwR4dszscqoxPs8hi6cTABChkT0xHrx
kkn80gOkARRWIXaLUnF9nwnI6iaBnNO2oZ1VC7342y8tyWp3y3QjxSFUESO9FiBU
DskySKxL/Fjz/RzWcPZMxexKaGiVS0s+/PPOlyYYp/lGW0siJPP1VJBaR8oPmNbv
wKbxLBmN
=3N9j
-----END PGP SIGNATURE-----

--qgjY7zrAqHI7D0FS--
