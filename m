Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74ECC6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 18:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB7CF880AA;
	Thu, 21 Mar 2024 19:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BMccPjk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC40D880F1; Thu, 21 Mar 2024 19:35:40 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D5587BAF
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 19:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-476025fde0aso443537137.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711046137; x=1711650937; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v6EoEdvVGhRLFnCYXOs0/o/qtfBQG6lWguEKAj0eRD8=;
 b=BMccPjk3RbAJyd2+JoDs2r1XKsVZIh8yD1l4vfPi40pK7PlOF6jB5HiVD8N/OUS6vD
 /OuYXSr3Mxe9hPjb/qajX3QDlBVtOA3pLYHXTdjrAhquP3XU2lrn5as+0FNd9mYnx2rf
 VFUqY0cNZuBabN3aBecRybJa5HGyWWAYtb144=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711046137; x=1711650937;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6EoEdvVGhRLFnCYXOs0/o/qtfBQG6lWguEKAj0eRD8=;
 b=qaBh6PIoqjfy7dtOaTH4eWm7WNhia2y4OVDc3xO2Gh1HT2dL1WFlGpNzOP+IVMkm5H
 wd616K2YnbPsjFnw7n+pVlHgzuAuwDoLOf4dCGanTb922wxYCBh0fTQlAABm8UsSSyDR
 HHXrrDbduL91NKH0Y++4cwYiZ6SffP17anzT5gZrk8n+aMGMlTl3bJhQRR9PNNgcqZ9w
 8DjerEBgEcdqH8RrRob+juL9bGdLkdcIodxzMCt7jgfl5KQD/+LcC4nyR3WD2HLwQ/9x
 0KPBnFykil8l7dac5sV3J5BO+Wcd+2sSSaVJKA8Q7L22VMRiw77gUpVM1MRuQ0emgKGM
 yZ9g==
X-Gm-Message-State: AOJu0YzpWlqBLABzRsmupNhBuZb/1qX3ZK1DhSlX1ST3uhT33HaCxHvP
 yusUzlpTzGdHMHpT4FzN7jhNuNTaoBsz2NHi1kl76I+eWCui2YmkkqbHaCMCBtE=
X-Google-Smtp-Source: AGHT+IH8z5nNtZOUBCHEbFVjP1NjEULXM1Wr7kHZLavi7hz8BHlvRH1+XsWUoACc8jZyzGIZHi5WWA==
X-Received: by 2002:a67:e2d6:0:b0:476:9a10:e9a7 with SMTP id
 i22-20020a67e2d6000000b004769a10e9a7mr455429vsm.5.1711046137163; 
 Thu, 21 Mar 2024 11:35:37 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 eo9-20020ad45949000000b0069614ae3f23sm145626qvb.123.2024.03.21.11.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 11:35:36 -0700 (PDT)
Date: Thu, 21 Mar 2024 14:35:34 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Douglas Anderson <dianders@chromium.org>,
 Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: Pull request efi-2024-04-rc5-2
Message-ID: <20240321183534.GY3442575@bill-the-cat>
References: <2c0ee51f-4f03-40b2-b286-5b8642ba207f@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ftBiJ4vygIVUJCrq"
Content-Disposition: inline
In-Reply-To: <2c0ee51f-4f03-40b2-b286-5b8642ba207f@gmx.de>
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


--ftBiJ4vygIVUJCrq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 08:56:12AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 6ec096a7116a5f1f7dfac5f69ef19242933190=
5c:
>=20
>   Merge tag 'u-boot-imx-master-20240317' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-03-17 19:43:02
> -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-04-rc5-2
>=20
> for you to fetch changes up to fcd0c8b8474f7db0b94608424715a73fbeba92dc:
>=20
>   patman: Properly document the patchwork_url setting (2024-03-21
> 07:36:54 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20013
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--ftBiJ4vygIVUJCrq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX8fewACgkQFHw5/5Y0
tyxlmgwArxTVqHN1YYu7Y7+PxGcvWwyFm9WgwHZ4jTBVGMFqj6zI1qIvWDuPNgof
HTUELHzZuOiAJOi5s+OG8rZSneKX1uQ/faM+EKDX3Djgg5/7IUdoHhgOVUmFAY0l
Jvainj3KKtuEu+BRxqap2qETiP4EvmzLlRmks8ED2NO1XUYunKKiZ+sRlLlTBwab
eA9sVn9pxkNGhC6Psm5qIlzB21SMjkadFux/6+vjsTWJzT9X6FGzsg6TELJcxh7e
vpavNSodvZ62v7Zq8dZCgkuFyva7uGe2s6vdm5IwcupfNouNl6cRamz39Qf5LPEH
jKV9pQA39XDqCRsvujt09G3OOBZc7CKt23caLuL7yMX5tOaZmGpJ7Cly0WVV9S3m
50fFv3tg2CkbkkpRxmogyYcn/4BYAHkgm39e/WxOs9MywXIIGgpFyn8XRIfgMICP
8CYSNodfRgzxNYX4CUwG3xEiPq/29zOM4+DnYrUkX1CM1jpSPmnSMbda6KWQ2c+P
PmWVK3dH
=NF9z
-----END PGP SIGNATURE-----

--ftBiJ4vygIVUJCrq--
