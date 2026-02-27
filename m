Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83879FEFB6A
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 16:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7D2983D1A;
	Fri, 27 Feb 2026 17:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T65AC8Ca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 075B283D1A; Fri, 27 Feb 2026 17:44:24 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C2583CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 17:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d18f80b5c2so474912a34.3
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 08:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772210660; x=1772815460; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EYTFv5OGXiADjBUKizMz5Rk9VBZIrBujfp4DnmaUVms=;
 b=T65AC8CayI+BX/w5J4Lf/wU/XRHNCEakmSn1bC7DfXPNZACaDAHH15fDoweMIUUXFD
 A55pavLu+iqzvYovd02oGt+l8kxGPEVdB5+1Qxn8j8lebioRgyQRBl4rPXD/M2nuMI+d
 5HIdf37Ud/4pEMZYg8S53KenwG9m0sqmi/ivM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772210660; x=1772815460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYTFv5OGXiADjBUKizMz5Rk9VBZIrBujfp4DnmaUVms=;
 b=nWA25OkGkg3ZbUnUYgXoUvlaQ9Rg9/HM+lOQ7w5Zf4TSMOtpjdBjM2flu9CvL2tDcG
 IITI1DHkyxTMpVuAiMRJChlONWNYgYu9DtaZGlKMi6UANEe0VhNbR6lPCNk9DFtAM0RL
 A3hJSUdfuHxcdGStm6o2jxCbccMSisYrtB0O9GX+l9zDQAuubCXgefZO6sxSOxGL6OJO
 0lMkxOMFTL+v4Do8atDUPBek6uY/v7FkzPWCAHyimMXLcu4vOWgQMHzyvbb9le72Rebm
 OjjT89Jog504uTRO7PsVuGQ2tteywi0vw2l0NanDGsvlNBkfvrQiWlSynPMKerdVhxf2
 ojeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYe1N7nKX+bElFc/Hi58UC5BT0IDiZg4SR31x5l5VJ23ZXVFOWs2MsQoCDjSbsUctgod0mwqY=@lists.denx.de
X-Gm-Message-State: AOJu0YyIkHMmFGqaedeNssVNfAQnyax3bg10ale12MVcE/mIE4lxq0cf
 JwbPOkWl9T+ho6qirsElGwQoZL7xvaCl5WcGZ/e0ZmsHLmp3xQyrAOCqCr06xTrI+lA=
X-Gm-Gg: ATEYQzzPcxGW1WMl87qS8BWW/us8pf1+K0xOYyoPIdPnZnHgHSSHUCn8BG6GYhqW+NW
 Wj3gWuZvwx7QMXGPoAuUCzuQWh5ZGZxz5WMmR5Xhj7uzPLHELAzDzTcfHDGp8V761dXNSDfqrun
 okmanJbWHACVwqML/wYzaeopcRix1JDioRAcbfl1+62RRKwnWwTIGd9v3VcjSPEB7LDCRkHD9TB
 QAmPByomjhKMRLAL66lKix+XBo6dZKU1snhjoq75itUhK/8gB5QYLM5lE7uFwiIkFqr8BIWrSTv
 P+KP5q8O+5Vetrk9nJGy5FDp1H7ArccQwQevWZnLKLGYmyMZu18udFVU7XrRPDpEcwqIVgdEtBf
 UcGjehw4TyXzqhwvL0TQC8CnMgTDAchfEcLZ7miKX0rqC6KY8QrdIB8swACPyosRAA7wp1ngYLD
 zB1BkTz8msUnSKBZA32d7ZDbhjJdp9XvjzcM/62ykW3PQn3set94FTt5Fi1TXNnYeC9s6njBZZ6
 piQCzWAIf5pAza2zPLaGuIeM/e26qlPwEJVdWTFyqtA0/BciMA=
X-Received: by 2002:a05:6830:6b0a:b0:7cf:d0f3:4610 with SMTP id
 46e09a7af769-7d591bf39a6mr2541604a34.28.1772210659953; 
 Fri, 27 Feb 2026 08:44:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58666ea95sm4505060a34.28.2026.02.27.08.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 08:44:19 -0800 (PST)
Date: Fri, 27 Feb 2026 10:44:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vigneshr@ti.com, anshuld@ti.com, d-gole@ti.com, n-francis@ti.com,
 bb@ti.com, jm@ti.com, s-k6@ti.com, afd@ti.com, u-kumar1@ti.com,
 marek.vasut+renesas@mailbox.org, a-dutta@ti.com,
 neil.armstrong@linaro.org, semen.protsenko@linaro.org,
 peng.fan@nxp.com, george.mccollister@konsulko.com,
 u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH 0/6] 64-bit PCIe for AM64, AM69, J7200, J722S and J784S4
Message-ID: <20260227164416.GU1593142@bill-the-cat>
References: <20260227115841.333073-1-s-vadapalli@ti.com>
 <20260227143509.GQ1593142@bill-the-cat>
 <0980b08b-ef08-4ae5-8656-4b6c211a1680@ti.com>
 <20260227162355.GT1593142@bill-the-cat>
 <5e5e1b59-45de-423e-8b76-b75220597333@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9RceMEO1VtVVS/kv"
Content-Disposition: inline
In-Reply-To: <5e5e1b59-45de-423e-8b76-b75220597333@ti.com>
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


--9RceMEO1VtVVS/kv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 10:09:46PM +0530, Siddharth Vadapalli wrote:
> On 27/02/26 9:53 PM, Tom Rini wrote:
> > On Fri, Feb 27, 2026 at 08:33:19PM +0530, Siddharth Vadapalli wrote:
> > > On 27/02/26 8:05 PM, Tom Rini wrote:
> > > > On Fri, Feb 27, 2026 at 05:28:28PM +0530, Siddharth Vadapalli wrote:
> > > > > Hello,
> > > > >=20
> > > > > This series is based on commit
> > > > > 437ea9f8be5 Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-=
lab
> > > > > of the master branch of U-Boot.
> > > > >=20
> > > > > Since Linux device-tree has switched to 64-bit Address space for =
the
> > > > > PCIe Controllers on TI SoCs, currently, U-Boot needs to support t=
he
> > > > > same. This series adds support for 64-bit addressing for PCIe alo=
ng with
> > > > > enabling Root-Complex mode of operation for AM69 and J784S4 SoCs.
> > > >=20
> > > > At what tag did the device trees change? Thanks.
> > > The DT sync with Linux by the following commit dated 30th July 2025 c=
hanged
> > > the PCIe Controller from 32-bit Address Windows to 64-bit Address Win=
dows:
> > > https://github.com/u-boot/u-boot/commit/ecec23fc9a9f0eb48b761722c492c=
bbd4bb2e546
> >=20
> > OK, so we should add a fixed tag then? (please just reply with the
> > correct one, b4 will grab it). Thanks.
> >=20
>=20
>=20
> Fixes: ecec23fc9a9f ("Squashed 'dts/upstream/' changes from fe2d6c49bb4e.=
=2Ed08867ef8f12")
Fixes: 79f3e77133bd ("Subtree merge tag 'v6.16-dts' of dts repo [1] into dt=
s/upstream")

Would be what to use here (git is fun and can't "describe" ecec23fc9a9f
because it's a subtree commit I guess). I'll correct when applying,
thanks.

--=20
Tom

--9RceMEO1VtVVS/kv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaHJ3QAKCRAr4qD1Cr/k
Cu8aAQCeroeLIEUcXPOa8vFh/rAEEzAFOg0SMv3BJYY9wV18ewEA8Uq7vcNQtqwB
ZCLYm/X4Jo1LM599sKcilJHlzl6heAw=
=P+N0
-----END PGP SIGNATURE-----

--9RceMEO1VtVVS/kv--
