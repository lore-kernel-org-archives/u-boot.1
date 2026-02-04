Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEA6E83F11
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 13:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A769D80212;
	Wed,  4 Feb 2026 14:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j4mp0JlU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D33D7838FA; Wed,  4 Feb 2026 14:54:43 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B33280086
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 14:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7cfdf7e7d19so6171285a34.2
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 05:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770213280; x=1770818080; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBQPxYOs14A8BHiHR3huHv2z1dijzPPW42FLIIFMC6A=;
 b=j4mp0JlU6C9zI2Qm6tjK5o21VnWZlf05+R7rNHBWag9bOVyUPCcoYn5VG4drsAZXre
 sirvbVAtB671lbF4M+ebwAr8Lc22QU3BF9Q4nM73cuw0OEt90on1O8bzvmVjvd4QI8yr
 kbDndrDiOwDpwlgzIo4AtOoL7cecSdAQcW8zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770213280; x=1770818080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBQPxYOs14A8BHiHR3huHv2z1dijzPPW42FLIIFMC6A=;
 b=X3hgK227k1EsMK2aUJUbInI+/cisdjTr+ks7O5UaAd3bAPQlgpCJGApoAm2ikUbkIY
 EUam1o2esQt1B12PwnZ2sjJV6dkeuoOXXwbcVsEMuwpgUNN/BF3fW7t53In3nOIdLmUF
 rNRUSLCJpNmkFKto203KSFsKbkwreyH2jZbd+oprDuHWHg5D92PgdkPcRFLU9akTgr2A
 hKmDRzdOuGnHTyFBAy7hqi0oFbZuusF3kzIqHX6lMm4Tf5vW+FUJGUqxaKBQaqKe6VlB
 Y1Y7Z5u3e2v3QbLiXSSGfNTbmHOK9FEGc1c0Zp/zGlHLpYW+gbgSAXHYrOq7fRA98LkN
 OcfA==
X-Gm-Message-State: AOJu0YyO0/q/ZpQj6elxOOB6l2xoEjp8+EEvXGvxpA0l1Lv1dAyQj+co
 bS5Ag3ZsslDAuKBwiW1lHVEHstVUxCiYqVRak/bWS7PdAK1XPZhz22Om+mCRXIaF4xI=
X-Gm-Gg: AZuq6aLLcu0/WSc7aQCpDN7rd+8DMx9Nv3wmfLo8Hsn9XQC5ZPPL5MCqa5N6n2x9H1U
 wYncJcpJOeTTm5VtbLH9mJtqXAeSwPK5haAcpXK47MspkY7vfOXK0QCZGodN32sFcOCkXfZbOnd
 Q4QJZv9sBOkbT1TYV2xplvf/N09zE9f+Pnb8WObKnCqDbSi2kH178LFtxBb55d7yaAPsks5DXPP
 9mLfP16ynAQmAdjPEPyozTJVTaxEl/otHjMmMVsa+9Ekn+4NDyiXvZlk58HFtoF3SSlyUgHrBKY
 CwVn6g7GbrhXcxXzHT3KLQ+QQKRaKrKjRc+5A5tqDG9yuP22pDgB3MVcKReGzS3eoBxzh/rNJtc
 V8M5c03FlfW6tZ19TTXEyda0L9Ft5y+CMXIbhcxBmHcK5ZJLSnZt+gL4WXog+oJJoI+J0GP7DQd
 FAvooNO8hA3+oh97cezx6V0fKKbTNIQ/loYUm3YetRCgCR0wTfkLGqG1oO6uAstglKhUqITDG0Z
 W/zTCRanjXDE2/obp7Fp4WJyyngDJednYFqONk2vBY6Ri03jA==
X-Received: by 2002:a05:6830:82d7:b0:7cb:1287:e3d4 with SMTP id
 46e09a7af769-7d448af563emr1682784a34.36.1770213279745; 
 Wed, 04 Feb 2026 05:54:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d449116b51sm1738980a34.8.2026.02.04.05.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 05:54:39 -0800 (PST)
Date: Wed, 4 Feb 2026 07:54:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Joseph Guo <qijian.guo@nxp.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sumit Garg <sumit.garg@kernel.org>, Lei Xu <lei.xu@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ji Luo <ji.luo@nxp.com>, Simon Glass <sjg@chromium.org>,
 Justin Jiang <justin.jiang@nxp.com>, qijian.guo@oss.nxp.com,
 xinyu.chen@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: freescale: add basic dts for FRDM-IMX95
 in u-boot
Message-ID: <20260204135436.GW2603314@bill-the-cat>
References: <20260204-imx95_frdm-v1-0-85dc80e98a6d@nxp.com>
 <20260204-imx95_frdm-v1-1-85dc80e98a6d@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5xvY+OtQ/RaRbsuJ"
Content-Disposition: inline
In-Reply-To: <20260204-imx95_frdm-v1-1-85dc80e98a6d@nxp.com>
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


--5xvY+OtQ/RaRbsuJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 04:47:12PM +0900, Joseph Guo wrote:

> Add the upstream device tree files for the FRDM-IMX95 board:
> https://lore.kernel.org/all/20260116-127-v3-2-3dc49545a745@nxp.com/
>=20
> Signed-off-by: Lei Xu <lei.xu@nxp.com>
> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
> ---
>  .../src/arm64/freescale/imx95-15x15-frdm.dts       | 964 +++++++++++++++=
++++++
>  1 file changed, 964 insertions(+)

NAK. Only cherry picks go in there.

--=20
Tom

--5xvY+OtQ/RaRbsuJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYNPnAAKCRAr4qD1Cr/k
CusKAQCFKbnf10sS+8istNi1zSlhpPOg3x7mrQ63Oop4LrtZKgEAtXEcaewET0IS
NvjLDVCPiO1YXOMvMIPYsVYmlKDSGQI=
=81we
-----END PGP SIGNATURE-----

--5xvY+OtQ/RaRbsuJ--
