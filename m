Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7121EA7944
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 20:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F008341A;
	Wed,  4 Feb 2026 21:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d6OV1pZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09831838FA; Wed,  4 Feb 2026 21:29:22 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C72A483015
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 21:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-662f2fa7e67so70855eaf.1
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 12:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770236958; x=1770841758; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=It6Vbn0BG8QzuTLBtiiLobKhqC3LTWmvYTbetOVIJ+U=;
 b=d6OV1pZlob9fKYKdntdl8p644a+jPj1R1IAf9BnQo/B4qBuMnJE5lEoWB1qIYKzsgg
 qqLJnuMRTpgvk312lrbELkNJ9a67MNvCU+mJV1dP3OMEWeVREi/Td7Sky109ZndRFyN0
 lUXAGYYACFuns69o585XrOaaJGXFFZM8NPrFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770236958; x=1770841758;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=It6Vbn0BG8QzuTLBtiiLobKhqC3LTWmvYTbetOVIJ+U=;
 b=mdNdRneY9Z3xpvddlXzOqUiN9QfknS8zUZ5G47WkYz0z6WNtswxwadjCyVnk9WHEFQ
 CgwVcTR48zYlh4rfYAI1Hjgd+JBk6hcItKmYPn3hLw1f1xFG43gA7Nh4FW4YEMMEdWeK
 K9CI91Dll7lB6G8gO16XyFNB485aTYC6+BqXvflAWvPzVgBCqbmQR0wLNjwltICRrmUy
 1TEA+RDo5PhqAf+k8ODdkg6/Lk3J0KIA92oNklLhN0Tbx7GWTGsFFujhNRzAaPmHOmgx
 XGbeV3/GG7ApzBcHO724WKFWdQ47rORkXf8mrBv8w45mhqpAOsf1xYLX0rcLBgSgcLin
 55Yg==
X-Gm-Message-State: AOJu0Ywi9AigD1dQkgvrG4Ycsa0b6PmbBO02UJ2EFcPuj09K/+w5XTbh
 ThNQMbsjye3msQU6BLx97VcOxNE7U80RttP4ZcXJgje3PrIjPTg5EiyyGIg8HOaPSRA=
X-Gm-Gg: AZuq6aLNyAPrOLbjeqezpaJbAz1C9yumUxNMicxIlvS0H3iUS23zYfhudrcbJIpsmsz
 9dwky4hzItBpfJ6LkMnxNJ8LZJ8kPBwPvnBdL2JYPt7cD1W2Y2GieTA36nALId2evGba5YgE3TH
 qsq9KkGg5TQDbN9BgAAt0sOK8eOFgzMKaZPG2z57pJmMhG2n9dejr1L89W7rAJ8nQxZWeKYTPaW
 EVjydr5tjMkdgEaik65GhZd/Zv/IjnT79KXtSiRwKPBloBS8IC4YDQoFhKC1PgdYxnj4KgZ+mNE
 chU3UfB0OHJzspMR5WqEnHlN1nOlY8xB9fmVUOJey5RzgQ1CBYOD/29BNYf9wMss/oq0iTm5hpb
 qhh309Xxnu6dpYuVvvXBXgcCfuzblNaDvFHlJKaAiO5GCBbBvcffKIY6cUKxibzqNR02KXaMtNq
 PogEDnfLbOxFr5OtcXhMLFxrkIO97TiiQwZbyDX+hfZMywgq0a8sVwwXYWl8SlX2y7KEbfOE8t9
 2vdaC1Q5TD7g4LNN9DyI0Ffh4CKLjKxgNlS2O12JrwDIGD7qA==
X-Received: by 2002:a05:6820:468d:b0:662:f30e:d56d with SMTP id
 006d021491bc7-66a200b92b9mr1596450eaf.7.1770236958452; 
 Wed, 04 Feb 2026 12:29:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a35a94a3asm1735734eaf.14.2026.02.04.12.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 12:29:17 -0800 (PST)
Date: Wed, 4 Feb 2026 14:29:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Masson <jmasson@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] board: mediatek: add MT8370 EVK board support
Message-ID: <20260204202915.GB2603314@bill-the-cat>
References: <20260204-add-mt8370-evk-board-v1-1-3132f953d845@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9ClA6gAL+LSZ4ihv"
Content-Disposition: inline
In-Reply-To: <20260204-add-mt8370-evk-board-v1-1-3132f953d845@baylibre.com>
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


--9ClA6gAL+LSZ4ihv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 09:24:30PM +0100, Julien Stephan wrote:

> This adds support for the MT8370 EVK board with the following
> features enabled/tested: Boot, UART, Watchdog and MMC.
>=20
> MT8370 is based on MT8188.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  board/mediatek/mt8370_evk/MAINTAINERS  |  6 ++++++
>  board/mediatek/mt8370_evk/Makefile     |  3 +++
>  board/mediatek/mt8370_evk/mt8370_evk.c | 34 ++++++++++++++++++++++++++++=
++++++
>  3 files changed, 43 insertions(+)

I'm wondering now, can we reduce things to be more generic? I'm assuming
the memory map is not the same but this is basically the tiny bit of
code for mt8390_evk or mt8365_evk (which doesn't have an empty
board_init, is there a CONFIG option to disable in 8370 and 8390?).

--=20
Tom

--9ClA6gAL+LSZ4ihv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYOsFwAKCRAr4qD1Cr/k
ChW2AP9vGD79tXIprzguHbyGPhFdj/Tu9n9IEu75nPGh1oTmSwD+PtOWklZcqdBn
Td2iCgD3SmPgACRP11FCVN+OuBIhagE=
=esey
-----END PGP SIGNATURE-----

--9ClA6gAL+LSZ4ihv--
