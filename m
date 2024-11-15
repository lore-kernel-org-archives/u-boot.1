Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241FBD65C7E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A74B5890B1;
	Fri, 15 Nov 2024 15:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="luuJH8sP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3797890F6; Fri, 15 Nov 2024 15:17:54 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EC6D88BB7
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d400ffb227so2792626d6.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731680271; x=1732285071; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p07dijzzbl7JbREuZqE+k+F2/vk4fuURyXNML6NdDCE=;
 b=luuJH8sPhrZbKWjgFE9q1eWbOXt7Ene6Ss6iQsC1FCOBnvqqvx9d0isU30sXicgih0
 OWcuR59mA1//vV2VAp1low4dC0MrXgEYlMDg4o2GAdbK7tyuldxFTF4upX4fL1Zb8Ylu
 4RuM6ZEAweFL87a79OpuGCZIqoSBiuRV0EPmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680271; x=1732285071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p07dijzzbl7JbREuZqE+k+F2/vk4fuURyXNML6NdDCE=;
 b=k37VPGTTY9pixFYNm8vQ3UbVzZIztWCC9Vh6XpAm6MqaOzBJRdfJgjC/XvHqmWYLLs
 22UbuS3dPbII38KImOUrSJGFGJ/t3jU2eEtB8QKkVMnajK35+gPa3rDJ7U7ahGB3Haoq
 DsIxsV2Ab+A4JTNC/fj3/Q5Gla0y/2pV31Xz8Cj1+vzQoqwpD2WNjmuSKXmo4cv4LCnZ
 V8aXzo73i+r3RWiCv+tApFWxz3Gc5Bs/L+qy0V20+c/wTP7AOTJmTIpNNE7W9qPalSiq
 7HAJC7GSO3zed5VXqh65pdTbOXZmtT7LaubFZOMZDnZPq2b/yQiI9CV+zQG6J6lRIRUl
 4S1Q==
X-Gm-Message-State: AOJu0YxQKY4vH7UtJuNSISLygi1jB5rGpDqFgC0XgPu7pnryUwaejqOI
 h2F9eXdQaOdNxEc4Hz9iXCZgV2fdCREyXhojwz18Akb4Qcb8rALtYofjOWHQlhg=
X-Google-Smtp-Source: AGHT+IHuptAmTt9OWHHibUM6z/a9nzzhEoWVFDTAEEVmdU77WeDMgIghQg9OTSL6FgZzsgXDOnKRqw==
X-Received: by 2002:a05:6214:3991:b0:6d3:6542:8499 with SMTP id
 6a1803df08f44-6d3fb7dc949mr36169516d6.19.1731680271481; 
 Fri, 15 Nov 2024 06:17:51 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3ee7cfa88sm18102916d6.65.2024.11.15.06.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 06:17:50 -0800 (PST)
Date: Fri, 15 Nov 2024 08:17:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Git commit failed with mbedtls/framework
Message-ID: <20241115141748.GS3600562@bill-the-cat>
References: <CAJaLiFwvFVOKYpAQLSNUqAfVHCsPcxo6g74JGunw8HSQTMCFLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zJQQPsXRluZyViFv"
Content-Disposition: inline
In-Reply-To: <CAJaLiFwvFVOKYpAQLSNUqAfVHCsPcxo6g74JGunw8HSQTMCFLA@mail.gmail.com>
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


--zJQQPsXRluZyViFv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh wrote:
> Hi Tom,
>=20
> I am on 2025.01-rc2, and I am trying to commit some files. The error
> seems to indicate this framework directory might need some
> modification. Did I miss something?
>=20
> error: 'lib/mbedtls/external/mbedtls/framework' does not have a commit
> checked out
> fatal: updating files failed

That's odd. You didn't happen to try out some of the previous lwIP
iterations on that tree did you?

--=20
Tom

--zJQQPsXRluZyViFv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc3WAwACgkQFHw5/5Y0
tywkTgwAmFxuWs1ldY7gsYM55Q00yJzczztn9ZIrHWmK++w9Qou8j9atdW4PYPXi
umd3t89YPBD3eD/ZBtnp3/3knpbckVRf2bQVNlVY/oaT0qViUrcCIGCtQs67sjSL
W4Dud4IGlYpSKHA471jKdoDyzrNvCDP2Ke7ZKIuP5MByMWJM+gnrh2A1j64FHTVD
90RD5euzsQG3higQYQUcGniPuWkG2uYmMREQmBB9wlisG/2S2HqtIDUISV1bV64q
5te1qL12KgIQ0pOTyPnL/UtmZ8xKC/MAyiXrxmo2KEvOFPyNpI0/UYWnxni/MPIV
1iceS1VaP+4x8/XSbammDrDkUcBVETQyQjESUVrK/pWuJKcucxlglP/FTLUp+ooG
Dt9hF8ydg8jZ8LL2aDkQD+7FrnRMJlXp7zeVlZ/QLA+7Dya5GAuC/CZfU2nvQgGa
bCCPlI8JRtam4ZoG/S85zqhYV2+E49qYt4h4JunYjbLysnQJDxS2fc4MWnoTdO0L
uhfWvWZo
=g0ZU
-----END PGP SIGNATURE-----

--zJQQPsXRluZyViFv--
