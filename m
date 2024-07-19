Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B766C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 18:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81FC38855C;
	Fri, 19 Jul 2024 20:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eN2JYJzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8E8B882FA; Fri, 19 Jul 2024 20:07:08 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD3FC88BD4
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 20:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3d94293f12fso1247616b6e.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721412424; x=1722017224; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JSZyCMBlqVvLXyTRiI2oRhRZxOi8iOo2WHa8W0VAtv8=;
 b=eN2JYJzQG6PjO9FZA7BHM4tQx52lumvNN/eZS73FRE1wgXuNcsmowbUyqPQ++ong6g
 xonuTQsMB769uB/sV83hW3olzYWKZW0xvh24X24VFlayBkzZ0eXkAJu637W76l790S0c
 d6bX5Q0SYxuWmbwFLInd2R7+VdWtFGZIBQuuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412424; x=1722017224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSZyCMBlqVvLXyTRiI2oRhRZxOi8iOo2WHa8W0VAtv8=;
 b=bWgCh4EFD0a5XbrdyD14Ktjiz+UAcVONZPc3HVryUWyeMIK1J9Y0oDQvGilnu1djB9
 d2LzM/SB8VdgZNQFYGSBaMS+KnmcCZ9tb11353xZonx/7C3vi2PVSQhK7uXa/B7+cQHV
 W8diDG+rYvcyXI3DxmXXsmYSvlEuLU+3/BMAtsRQka0iEujTF6pObzzFmHyLsiGkh1kc
 EGYt03HTL7arWlHkKOfiMZ/5WkYXCzdNrrB5NeCTaH8rRJ+CfHt1Emr7nmleQquCqDv4
 OA2Upa3KcDxKxC0BipUDyvhlrHNi8/RFX0F5w4yXj9kUV7hnpuOAlOY9bxngpw+hGlQH
 kQ0g==
X-Gm-Message-State: AOJu0YyUasHkYLnUKfWSm25J8dfKPu75Jtu5SBUcId4vTu85wWEcrRjq
 Dzzn10kYWKgzJUVAI2v6VAnFlmpnFWQlgrltJFXUnmAMmUt1IQJrZhcXWC1xjJY=
X-Google-Smtp-Source: AGHT+IEFh7IeiDYh/QvLNeYcVoWI01eAj0DprEyKRK7HE3CTBeZ9jcfjltoTZdfzg0PYkvJR9ZCVYg==
X-Received: by 2002:a05:6808:14d3:b0:3d6:2b12:7dc0 with SMTP id
 5614622812f47-3dae5f1eafcmr784542b6e.20.1721412424503; 
 Fri, 19 Jul 2024 11:07:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae0969e73sm366139b6e.5.2024.07.19.11.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 11:07:04 -0700 (PDT)
Date: Fri, 19 Jul 2024 12:07:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sam Povilus <sam.povilus@amd.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: Pull request efi-2024-10-rc1-3
Message-ID: <20240719180701.GC561963@bill-the-cat>
References: <dec71b07-2360-444a-ba0d-19f09ae45a53@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YZcwBOyxBpzuhXPN"
Content-Disposition: inline
In-Reply-To: <dec71b07-2360-444a-ba0d-19f09ae45a53@gmx.de>
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


--YZcwBOyxBpzuhXPN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 04:26:43PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 459560000736ac7c9c8b04522789c20fb45ff9=
5a:
>=20
>   Merge patch series "bootstd: Add Android support" (2024-07-18
> 17:03:47 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-10-rc1-3
>=20
> for you to fetch changes up to 38b000881ebc0a48b0a814fce9f52dfe62ac644b:
>=20
>   doc: Describe the bootstd settings (2024-07-19 14:01:46 +0200)
>=20
> No issues were reported on Gitlab:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21685
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--YZcwBOyxBpzuhXPN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaaqz8ACgkQFHw5/5Y0
tyz7jgwAjukgvt+vAnpz5iaOKYgn8X63D21e5iw8dTf2Y8mOmSp2ml09qEb/0wuF
Q4l1QiCka0fd3RTmKo9qVMGTbV7QJPPSGwyRVpIQJwafLnffmu7eAXk4h0ISGcKA
Jx9ynpEMB2ynHXIAHeCwMZ2Ag6FAC71O7SjRLGt4D5eBww5fTtySPHjOFVWANkBb
U8puEhWbqHg/u4kOOGHMUr+RqR0+Hmk8i0xcGV0RJWM/SCA1hckVrVc6WtYl1AaM
FeTwl3wuFwH5o4YSAZWCfonpfb7SQOo6ZlZPAxfcAYWLpG+TS6eJukXuth/dYkCD
Gx6Qh2HPrtW6C4yffJ9z2lgkpVfz2O8ut2LexDX35SUBfOJ2uRE68uhcytkfdy0Q
h+VdokEjCXWh8MNe69WASh7LnWikv4VTztJ9vFch5dOq6Cc564VKviGjl8C8Oydo
qZmGb53nww22neG9k06yKVyseQJfRJApErvu6PEf7wVtvSGcYUH8dFdJca23DgSC
pNpYFUrt
=xe5d
-----END PGP SIGNATURE-----

--YZcwBOyxBpzuhXPN--
