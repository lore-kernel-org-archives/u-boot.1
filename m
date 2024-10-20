Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC1BD3C92A
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 20:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF3D88E42;
	Sun, 20 Oct 2024 22:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fc2/PWoQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA34A88E51; Sun, 20 Oct 2024 22:16:16 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8270A88DB5
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 22:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b1488fde46so289986485a.2
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729455373; x=1730060173; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8d24K95Uhy5YuxMRl+T/SDPm1/QHzmeQvk8Wfvka484=;
 b=Fc2/PWoQtg+fIqiT4W/VnyTreSpn70L28502kcM+82guYwPo0vlswbrpLabFNPWgGg
 HTTpk3IU3XRkQ/lLRFQ/N2WU2Pt8nbqWmCKJhIM8Wx8XuoWZRqKPYla+HQipp7qgAVPi
 aXOQz89kkJxAseC+DTW5HnBZ/nYeOKfpyjyT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729455373; x=1730060173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8d24K95Uhy5YuxMRl+T/SDPm1/QHzmeQvk8Wfvka484=;
 b=YQfbiqbz/BNEV7V9e8LnZLzdbRiy80BXpYiiiA1fL5spY32P2IMBXWTuXzxp5EBXXF
 XLpkNyHhyK0wfHYG7kP1KUn5MXSEJevED30XsjH+/ossMQrtG1jkcIF2GzWZfGDIuOVN
 a1nTlU7nvCgBDR8rMvjwFzoF/EFiNa8dmX3ojhMCClTR/laqFp0pw4e0YQvmtZYTSwnc
 BIIPtDZIpiLZRZBVJxQE8BvSrJOZB8iAIrd6VUJFLBgfQonELT/ayrExdJRNZ4Cc1lCG
 nfJB7ucZyMX6dWfmZOEmzE7aPxcKwK2/1A1uu82JAZzeQqEkQmwTDGHhpsIfD4d8nwPw
 maWg==
X-Gm-Message-State: AOJu0YyPA1TVPdyMSDDJhaqyIILLEVE8fczK8X6TUuogrNk0xu4CERUx
 kkDCHT3lTVkUrUCUFJkYpmYl7Lgx7ZUG+NtRAEX7bYgqwl93yHrLle2hnAhp3h0=
X-Google-Smtp-Source: AGHT+IE3/E2vR0EYtmPAm3FZ4AHsxtMAg95Wimci4mtIm8D73pqO40k//mNbibotxs2BC2wmIzHibQ==
X-Received: by 2002:a05:620a:2402:b0:7af:ce63:cadc with SMTP id
 af79cd13be357-7b157b6b589mr1359337385a.33.1729455373362; 
 Sun, 20 Oct 2024 13:16:13 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a892cbsm105504485a.136.2024.10.20.13.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 13:16:12 -0700 (PDT)
Date: Sun, 20 Oct 2024 14:16:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chintan Vankar <c-vankar@ti.com>, Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: Pull request efi-2025-01-rc1-2
Message-ID: <20241020201607.GE4959@bill-the-cat>
References: <5b347d0c-65a2-400d-b7d9-470b1dd3fb41@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3BGWGJ/Z8UcpOoOY"
Content-Disposition: inline
In-Reply-To: <5b347d0c-65a2-400d-b7d9-470b1dd3fb41@canonical.com>
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


--3BGWGJ/Z8UcpOoOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 09:22:53AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit f1de0b97d1cbfd982b7a507962bb21b12a024b=
2f:
>=20
>   Merge patch series "Cleanup dma device in spl and move dma channel[0]"
> (2024-10-17 18:21:20 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-01-rc1-2
>=20
> for you to fetch changes up to 640c6c6cbaafa1b049118d431cf218d9dce3cdd8:
>=20
>   efi_driver: use blk_create_devicef() (2024-10-18 17:05:19 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/22810
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--3BGWGJ/Z8UcpOoOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcVZQQACgkQFHw5/5Y0
tyzjzQv/clC8JV0MgsMJutzYl8h+dROwkWS9wfxHICidJAwFVW2Wt/E1epdL3n57
5udFX3u4q7JpiuNEir9bToITX6J4If29t4yoW47n84GYUcLx8HFg0Mm4jjEesKal
u/SaPs/wmTYau+LxKXiZmZYlEQiV6X+X7p0IpMMDOaU13QsyIiPR7cl4X0QJAHAj
U0JIWUuvrHRPvTaFsGJQMvDd5vj0jb+QaUYWnY2l62+CMq42PRNlY02lib9vOk6E
wNCcoKVEoIiP2HgsEV5FKUGkbk0mtZ+1cGGUFKw+e9hu5ORVN+RRlWDT+kImWVve
UXNLXPqQOHhsL3q7POmXPiDDUFsBEyP8XquTpIRd4H5asXvQ5VImz2FtBVtYTnbA
7Q7YxdTbL4v8N8iuKSC8olHdPbAhCu9jbi93wiIOpQQSS/3ORnqAK+m+A1qq+j3X
DKYe9EUsAUR+pqM11eZW8mgj2VTmFz0oCqnATaxju8j22flXp9azgvFTn1o0ZrFK
QdPf/+9C
=uQxp
-----END PGP SIGNATURE-----

--3BGWGJ/Z8UcpOoOY--
