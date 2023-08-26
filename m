Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51861C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 23:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD0F682BBF;
	Sun, 27 Aug 2023 01:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M9kEAu9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D708180726; Sun, 27 Aug 2023 01:50:01 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22538846EE
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 01:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-594f8a7125cso5843757b3.0
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 16:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693093797; x=1693698597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+6sfv3kfeGlYKQ0oIvHMB3V9IvnHwXvbyRiDLxAzG14=;
 b=M9kEAu9jH6C1pvLW4TLPxDkafpiNyuAFJ0IgFklkBquWTw+0PNt9xVLD1aoOvJF02r
 f5qrYUNCQPCpBbu1uHC/DxxZeHEQQyhUNpp4Z6NJYDyOlj/NiKiMO45Rc6k2tai68j9t
 wjz+HzOblII164o9WE0DAAXhCa2ru8CyW+k1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693093797; x=1693698597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6sfv3kfeGlYKQ0oIvHMB3V9IvnHwXvbyRiDLxAzG14=;
 b=Y0aDjAfjSkMmSd0gVQ+oHFuyY5gkt1ijSJ0CpcvaOHRqSErOBT6+zHusCOKlqA8Gyx
 fwQdGpyXSmTP9Z1M8YsEbEf1hjB+C5FQ1+EQfQIIeC3MjnmnaGpyIqrQnC77kSIinToI
 g3EVQv+V4bZ2BXRSQsQXAgYk59vYzLwLvKwBuW1kz3SIQwiutWthPH7vcZ+luxnlo2tc
 XkNyjVhjVyY7K6I9dtHzH6zNzptWPp4QzHzsJpb0xU+SWAIuzq9fUquUioulDJBzvPIw
 Pa9/saWZagfr58+NdTzM/K+194k8/CrmubjFv0ucaO8Gc1tSBlbP1aA0h0Nfo46FQokq
 blvg==
X-Gm-Message-State: AOJu0YxTp8FGzmDiHnvAkXq3WFjxoEBJSWMPSBH1APeq3ly58NStUqAy
 a+HPFGA9oS4RzG6LWhwApNhWXBU8nAOm9I3I79prcQ==
X-Google-Smtp-Source: AGHT+IFnyjZzdd87S4jNNHNyl/5PGM7XK0YYdePfvZzn6+C/mG/1qEJR05r6e0O2kRF12VNk7FRwTA==
X-Received: by 2002:a0d:df57:0:b0:584:3f4a:b790 with SMTP id
 i84-20020a0ddf57000000b005843f4ab790mr22825683ywe.33.1693093797558; 
 Sat, 26 Aug 2023 16:49:57 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-cf2b-5e4e-16cb-5c6a.res6.spectrum.com.
 [2603:6081:7b00:6400:cf2b:5e4e:16cb:5c6a])
 by smtp.gmail.com with ESMTPSA id
 w79-20020a0dd452000000b005845e6f9b50sm1316389ywd.113.2023.08.26.16.49.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Aug 2023 16:49:56 -0700 (PDT)
Date: Sat, 26 Aug 2023 19:49:55 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] CI: Move to latest Ubuntu "Jammy" tag
Message-ID: <20230826234955.GW3953269@bill-the-cat>
References: <20230825172127.3406461-1-trini@konsulko.com>
 <20230825172127.3406461-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pJMOddqCPBCxSPG4"
Content-Disposition: inline
In-Reply-To: <20230825172127.3406461-2-trini@konsulko.com>
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


--pJMOddqCPBCxSPG4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 01:21:27PM -0400, Tom Rini wrote:

> Move to the latest "Jammy" tag from Ubuntu.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--pJMOddqCPBCxSPG4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTqj6MACgkQFHw5/5Y0
tyxLywv/VUyy9Y/1/AwJLDLfI1hPyupgh1zxXgT2Dakvtiq6BW40tn3cGAZqq352
gknvkb1yXMeBQdLu9o+w9o7efYqc+yRnlD1o/rzCKHv7ckHTk/CUdPlCL+9BTKwI
fbRrwzvBQxTFNzC8PUZaqOHQomkz8B9z9jGiNHIVBDlkjqcFvxQxDAgYexhKddhV
vmp3ooxND0Jr5CKu/g/UTt9ysBW1oZPeUD8NjJ1uI4JDnloIgiUtRAdYS/IxUbT1
6SDqXqbi14o/itie6GMkD91mSLtHOzARWUnPRkr2707/svwZz3dQQqDKxBGSOJZh
kIdf+OOem01gJoOrjKGcnc3f7GJXLauJYLnfclu79TZZ37Uf77ccD6qRwQ5+J/ED
OmLYu+VR5aEPod34GXFJKag3wLeGExNQikzCNwRwcHNdRKU/34C8K6gN13gBLX6Z
ilFJF3O3cAd9n38t6FGjINUjuXMSFuTNZNgqXmi+p+hIqlgsqzm8h6Iy52FbKPDO
oatceZ9E
=Q7VH
-----END PGP SIGNATURE-----

--pJMOddqCPBCxSPG4--
