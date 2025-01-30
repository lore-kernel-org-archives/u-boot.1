Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E1FC0218F
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 17:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04BC18212B;
	Thu, 30 Jan 2025 18:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MO+3aN5w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7499682132; Thu, 30 Jan 2025 18:04:50 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C1E38212B
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 18:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71deb3745easo221490a34.3
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738256687; x=1738861487; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7ZNx/lsrirFBYOgOBGdMH0uRNXwk9rvQP+VjFfpn7AU=;
 b=MO+3aN5w4Lo6NV//+ViJOkhOmfMjbKOCb/AJJqHey0uN8R1WCo2jHGUxugVipUrDe0
 WqvFsMnc5FpHHIdfxMGuglAi9zZLh2+22kTKQ+B2JW3iBZYI9Zqb4xSo86hA5TxXbTW6
 yquzaBu2yjwVWUTIbq7yyHbpA5vbKPsOZ658E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738256687; x=1738861487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZNx/lsrirFBYOgOBGdMH0uRNXwk9rvQP+VjFfpn7AU=;
 b=GGr44TrbH5p6gGQEOPI/2CgToq8d5/tcP1qDzlSVYKcxEizPzPueznU+ZMK+CtBwhv
 p3YxKWwi9hNpaF0ayb1yQ9APQrvH0lizxwHrwe9+g4qx8EEkDtfyV5PRTJixJSKeDdmx
 RrIaNNMc6G5zDMgOkSh+DQM/LrkmA1G1oUt+LbJRmj95Nl9c+/Uh9oaBG65qFyVK2Mcz
 MJ6kUsPDdwauXL29HWJmgaPtEX6+m2aYWMKz4T9+EgvZ5+r6l8d8SXTXptxS0OCPswnx
 elH1G3lgIe8QEAIkXzIpxwNo5v9OffB7G3yXTw0KAnrbw6pEaLqsVHtWdEbtZ8deP2Zj
 YlMQ==
X-Gm-Message-State: AOJu0YxtBOxfdn9Vpw+HFR/sGBUiMy6umfTWrbpN4apgP/X54SCxqgVm
 0wOc1t9+KHOeDg5V7L9Rwo6i3TQM9xthXFP9cwxW9hAJHy9xFAndk1z2Jfk4uAs=
X-Gm-Gg: ASbGnct4PRRlez60sQl5dgPjyfenxYJwTMfovKMZjEbJA3Zprd6MUrEMgAJyX67N6ng
 Qbg5BupYDDBujteIRc4wWsm9h8zi1zK9MhT2J0mKnq3wZASTTM+fDFKVxKTLgWEEcHTD+H6A+aE
 nEIORs1GBXKSMTwcL7JzAUk220nJKBkOxmxmxBQdHMZYafP+MDBBlkN1LWz5OpeFZieQ/fG1Uie
 Jtah2SnLI5kPVqzSxlhtlrGn/xT0JubD4NNJBsIUeNNpcpfKFi+1GJmenNoIlGQKJKObCUdcrP+
 KYV+M/gNONRwcYI=
X-Google-Smtp-Source: AGHT+IEnKMVxoehxSHGy7w2FG77VHIlyeqdpgfU3w4pMuZ3Ky2xsF8qPYeHKaOIG9lJuTRlR4SST3Q==
X-Received: by 2002:a05:6830:6683:b0:71e:4ce2:4342 with SMTP id
 46e09a7af769-726568d91camr4616316a34.19.1738256686958; 
 Thu, 30 Jan 2025 09:04:46 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617eb274sm395650a34.33.2025.01.30.09.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 09:04:46 -0800 (PST)
Date: Thu, 30 Jan 2025 11:04:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH 03/19] mmc: Allow controlling DM_MMC for VPL builds
Message-ID: <20250130170443.GG1233568@bill-the-cat>
References: <20250126184333.4058848-1-sjg@chromium.org>
 <20250126184333.4058848-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uKozWq8dNkw/RTr1"
Content-Disposition: inline
In-Reply-To: <20250126184333.4058848-4-sjg@chromium.org>
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


--uKozWq8dNkw/RTr1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 11:43:13AM -0700, Simon Glass wrote:

> VPL may want to use driver model for MMC even if TPL does not. Update
> the rule in this driver to support that.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--uKozWq8dNkw/RTr1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebsSsACgkQFHw5/5Y0
tyzVswv+IllHTzRsfQM56A/wTxNKS5ep6G7lzwEYKnNhYzl+GdxSRmOepoyRxMwX
x5ENWSj7kePAPc1zjZv9LqExSW9e56XExGbfrguZRDS7I+jtTAmKt85S4f9sBmEB
wxWcTcT94D+sKtHihYBFACp7c37zyF+TE1gshk5dOLZNgSvkOh/YYh4AAemR9RVS
fla1L36hmeov0yNhF4RGgwRm7a9P+rXH4CpSdotA/BzV4crnAJ8kbfM9LR+KHw4w
GoFhMEV8HcDNlikuJWHIAsWxWFgCnCpLm1u3d71RS6FCPFGp3DBMCneiJiYwQTw4
V+aKmUSYx7u+KrYCOSYiG4w2gio1O4R3jVrqT8YLp2gUoKGo8Cu952aPCEV3FsIP
fHLDAHAxWwrSjBT9YUPFlJ7kILQTBa2tN34LexiephsuO5TplSv+pT8+Qyanh+oJ
Bss9ex9scubeoDIqsrDkg3YCnVFRoR8ppuQLhrTLYcb1TQIdF6KkXRFj+pR9+RgP
Yy7r1pXT
=e0x4
-----END PGP SIGNATURE-----

--uKozWq8dNkw/RTr1--
