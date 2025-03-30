Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30F7C3600B
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEC6681EDD;
	Sun, 30 Mar 2025 16:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="cmzI7YG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A023681E06; Sun, 30 Mar 2025 15:37:30 +0200 (CEST)
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B21D681DCD
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 15:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=obbardc@debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:MIME-Version:Content-Transfer-Encoding
 :Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
 Reply-To:Content-ID:Content-Description;
 bh=kE9N6zUtVeEW9JkZMmzeb692jAyZOwrDaysC8zidVRQ=; b=cmzI7YG3sq2oDMjAlA7+rlOSMJ
 ubME+jj2tmL3aV0XHdy9TRQn8ILHjLws/nOcfrXWzR2iL8h/EZDfAhC5YajK2xOBtP16rbFwazN1L
 8tiJGUqtRoF8bIZE8UPiivdCGKnreEq93wY/dgu61LA9ZyQT6JSm1bikMnt6myyD6k1TOG3xkMqiB
 Z6YiTdreRw2ObnikcPzeSbgwLnpbmIXakXS7FDzMe1jkbg5lgSJIehOUiYs6SQUIWN6mD6m5NUOSU
 O8M4clUkppoWnld4v++bYrlkkZJ7i91HdgCRwb9ECfYgJQZQujlLbnX+MqcBt6QwJC90EJMx+LDr9
 qUYfH1Xg==;
Received: from authenticated user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <obbardc@debian.org>)
 id 1tysqt-0082Iy-43; Sun, 30 Mar 2025 13:37:27 +0000
Message-ID: <17946ac74959e3ab38798ced0a04863f5978efea.camel@debian.org>
Subject: Re: [PATCH v4 1/5] rpi: Add myself to the list of maintainers
From: Christopher Obbard <obbardc@debian.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren
 <swarren@nvidia.com>,  Matthias Brugger	 <mbrugger@suse.com>, Tom Rini
 <trini@konsulko.com>, Caleb Connolly	 <caleb.connolly@linaro.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>,  Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko	 <robert.marko@sartura.hr>, Sam Protsenko
 <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Date: Sun, 30 Mar 2025 14:37:26 +0100
In-Reply-To: <20241220003447.2913443-2-sjg@chromium.org>
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-2-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
X-Debian-User: obbardc
X-Mailman-Approved-At: Sun, 30 Mar 2025 16:36:48 +0200
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

Hi Simon,

On Thu, 2024-12-19 at 17:34 -0700, Simon Glass wrote:
> Add my own name to the list, since existing maintainers are fairly
> busy.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I think it would be useful to have another maintainer here. Of course,
my opinion means very little here though ;-).

> ---
>=20
> (no changes since v2)
>=20
> Changes in v2:
> - Add new patch to make myself an rpi maintainer
>=20
> =C2=A0MAINTAINERS | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba31f86feb6..8db1e605fc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -210,6 +210,7 @@ N:	aspeed
> =C2=A0ARM BROADCOM BCM283X / BCM27XX
> =C2=A0M:	Matthias Brugger <mbrugger@suse.com>
> =C2=A0M:	Peter Robinson <pbrobinson@gmail.com>
> +M:	Simon Glass <sjg@chromium.org>
> =C2=A0S:	Maintained
> =C2=A0F:	arch/arm/dts/bcm283*
> =C2=A0F:	arch/arm/mach-bcm283x/
