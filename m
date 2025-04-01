Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C536C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08D4281FFC;
	Tue,  1 Apr 2025 10:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CVLsSIVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCC9682012; Tue,  1 Apr 2025 10:55:50 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7CD581FEE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 219FB5C5664;
 Tue,  1 Apr 2025 08:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5FDC4CEE4;
 Tue,  1 Apr 2025 08:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743497746;
 bh=5hrtCk87TIiTinmiIQe7hCEIdCzHGKgu7aNZEN0KzDQ=;
 h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
 b=CVLsSIVRnuOlKZxvfEg7kwzLpejMw0BEVo3bONHfqU0N+X6CHi9wJ40Yw4nRTptK9
 wuwFBRmRSWSHLT/X7Cg+LucpW4pwt+MVcHoNq/DEwieifQTgw+gDjZ9Ji98aU6O6qP
 boAE9EPPH3RN96D8dZa+eTFf7r8slWMgXfbcdiRAM+UqEzyngIh4gOXdJyFjFA7a9p
 y1llB/Xm2XoIAhobdgu4cdDMbmKkbHyfcFKd67tdRkNY0MHfQZkPx/wI00MiWjV+f/
 JqjVJyeJTPOQO40SPy26t4I7ih7//XalGurhs2g1qMxXKcp6U7MT3MeNeDzQyXYqdv
 5G1T2vKzj47wg==
Content-Type: multipart/signed;
 boundary=edb30c51b787b803626654f9ffaa7afe0f821214279d786ca10663681b8c;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 01 Apr 2025 10:55:42 +0200
Message-Id: <D8V6D9S6CBRH.3LRHNU4XCVF14@kernel.org>
To: "Quentin Schulz" <quentin.schulz@cherry.de>, "Marek Vasut"
 <marex@denx.de>, "Christoph Niedermaier" <cniedermaier@dh-electronics.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] tiny-printf: Add support for upper case hex values
Cc: "Tom Rini" <trini@konsulko.com>, "Benedikt Spranger"
 <b.spranger@linutronix.de>, "Simon Glass" <sjg@chromium.org>, "John Ogness"
 <john.ogness@linutronix.de>, "Jerome Forissier"
 <jerome.forissier@linaro.org>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
 <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
In-Reply-To: <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
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

--edb30c51b787b803626654f9ffaa7afe0f821214279d786ca10663681b8c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> The issue is that disabling TINY_PRINTF may not be possible (size=20
> constraints) and some code is compiled for different stages and people=20
> typically don't check whether the format used in printf is valid with=20
> tiny_printf. I've had this issue already in the past, I vaguely recall=20
> "complaining" about it on IRC.

Yes, I've stumbled on "%pa" with tiny printf (i.e. in
drivers/pinctrl/pinctrl-single.c) which is printing the very wrong
value, actually :) So printing anything unknown as '?' would really
help here.

-michael

--edb30c51b787b803626654f9ffaa7afe0f821214279d786ca10663681b8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ+uqDxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hE4gF/SCyiU/+YBkMV75ZvwuVzl7iOlqDD1ILD
+/fgPzRIu5bnGXjYjvtM9IyHAiUOwjZHAX40D+Ruof2Y+zIkZlNulLtPJ3RP87Gg
nUiKZ3FZjJXh4BPpC8LvhGL5hBly296o49U=
=tE7q
-----END PGP SIGNATURE-----

--edb30c51b787b803626654f9ffaa7afe0f821214279d786ca10663681b8c--
