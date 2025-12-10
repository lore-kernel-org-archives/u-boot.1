Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD87D3C932
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 23:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 950298389A;
	Thu, 11 Dec 2025 00:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tsbMV7br";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E7983B48; Thu, 11 Dec 2025 00:51:12 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82E7883869
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 00:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4537c9405ecso149193b6e.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765410669; x=1766015469; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B2aRdd/ZOgKEH4ge2GDv+AJansgI65CfoaRBHcyjnLo=;
 b=tsbMV7bru5xGCrj58SoaCWXQgtDIZIGhZvubp1x3WC/qm4Kqno8XOM7klqvUFZrZDg
 +PlOoQdtojzf37kDqhPS/QkySgNuxHIg0R+i65jYcUj4dAchbOklNKQlNvc/q+f1goib
 6OigOHaroguE1JfmHcd6sJy9eELvz81Gs30lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765410669; x=1766015469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2aRdd/ZOgKEH4ge2GDv+AJansgI65CfoaRBHcyjnLo=;
 b=WP+1MWJgedu0niLWvOa30Z4wfyQmUouEQ7oi3QwY7xrp3nFYPiwxH2gUL6dHFHkGeb
 AneiEiQNOsPJfNSMWKHYorr57jwp8Pxg/4eZXRdX5jCXjsKgV9bnAPpPkt7Ddd3ZYWlD
 2dlOdwzaVkDOG/qn5WtunyG+n0ekSILXhZLQ64BZLzVasTdCK3nXk056Ptut09prBBoc
 6o/yjKz0qUz+FbmyWL3QpPhNjQSgrWprKlbXthcf2zyMANFjLD+p8yvL4pCtxAAxo3yL
 jJ4SWb7d5xwD2/x1CqNlebF8aIsRjza8pYHwt+BdPNpvkRa3QyrVcQzvHo0MFv9GzGUw
 zwqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFNvmTJNandaZNmRKqw4t+TG7v+ArwLBvqU3z+HrVlqzy7juEhIsezDnDeknPd/6Jocni+uiY=@lists.denx.de
X-Gm-Message-State: AOJu0YwCVNEKMiIOg7JWdXUPDu9ozQmh2Ic2kqztB1nTNOKv/zRuurqw
 62SRLu3+a1G2CReb2hxhL222Rw3VOJKjOzI2+cpjUugdItAgN16y38TIQqnfcXI95hw=
X-Gm-Gg: ASbGncsd84PGez/tpj7XCatB+1ss9iO/rzlIFdL70HEVGk6kH+CeScV1k6Jn9juvqbQ
 guRDAyKiyBXx338BCXYyjjqwS6LtgdGcVjiuNmhOb4JWF1P8Uizb1oE/Wwji8or7ZQkLM84P/At
 4CUopaDVxXFjygt8/cffkc9BmgzhoR54qzlZMjG6//EcCtmXZ9iem3mpuIqb+o82stBBaqpmrDR
 CN9wLz34BSw4ElR+4CGZQRxsDMupuOZlLuUmQ5MJZnh8Qez/HSTWMRoNQ5Ch5RsigqIQ8zGiK1c
 1V9Ed+YeX5CnUETOxeM5NqfyNYgMofT2NwCtdijFju2U5o8GcRpnRjbk0wb+4YhiWvBYOep0qbL
 1rEkyYSbL3sSUwgNYjFnjGTHwRzjX1r1dNgka+osr2fSxEiMGCxc1D4bJJzqzfPDxGuoUxZZntx
 /azFjrSUAG5jufbriwcQwszuqNomxofByNiSu9Qp1iSY6Hq2eLhQ==
X-Google-Smtp-Source: AGHT+IF2pXFPMZeGiHPvbzgVHObOCuJxzf1zzHLIVXD6BOxF8bWpErlGQvGw9UKyjOsr1YERtcs0Ag==
X-Received: by 2002:a05:6808:f14:b0:450:dce4:8e with SMTP id
 5614622812f47-455864d3261mr2161929b6e.37.1765410669187; 
 Wed, 10 Dec 2025 15:51:09 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598b9966dsm274779b6e.9.2025.12.10.15.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 15:51:08 -0800 (PST)
Date: Wed, 10 Dec 2025 17:51:06 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de, Julien Masson <jmasson@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH RESEND] arm: dts: mediatek: switch mt8365 to OF_UPSTREAM
Message-ID: <20251210235106.GL303283@bill-the-cat>
References: <20251210-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-71317e50d414@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p179F2MOoVYRXtnK"
Content-Disposition: inline
In-Reply-To: <20251210-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-71317e50d414@baylibre.com>
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


--p179F2MOoVYRXtnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 05:40:14PM -0600, David Lechner wrote:

> Change mt8365_evk_defconfig to use CONFIG_OF_UPSTREAM=3Dy and delete the
> U-Boot copy of the devicetree source files for mt8365.
>=20
> The upstream devicetree is identical to the U-Boot one being removed
> (other than having more nodes for devices not used by U-Boot and
> upstream fixed a compatible string in &scpsys, also not affecting
> U-Boot).
>=20
> There was one minor glitch with upstream missing a few topckgen macro
> definitions, so those are added to the clock driver directly as a
> workaround.
>=20
> Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Doing a RESEND since nothing has changed (other than picking up a review
> tag). This got marked as "Changes Requested" in Patchwork, likely
> because there technically were changes requested. However, it turned out
> that there was an issue with the reviewer's email server that prompted
> the request and therefore no changes were actually needed.

This is fine, but in the future you can also just reach out and tell me
I marked something as Changed Requested but really everything is fine.
(And this is a general reminder to the community that I do make mistakes
in patchwork things sometimes, and to please point them out).  Thanks!

--=20
Tom

--p179F2MOoVYRXtnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaToHXwAKCRAr4qD1Cr/k
Ck28AP9nX9hODUAemMHmJy/cbJ3FZg7W0kRkTBMR+a8N7yU4cAEA6cdKI0nB7NHo
UkzVtLQdatKnEA+INsaOZBZj4KqxzQg=
=SeSl
-----END PGP SIGNATURE-----

--p179F2MOoVYRXtnK--
