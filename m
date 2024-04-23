Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA299C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 13:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41A75884FD;
	Tue, 23 Apr 2024 15:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="le+yiPvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E03868854A; Tue, 23 Apr 2024 15:35:59 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E57768851E
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 15:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1713879357;
 bh=sIAXFlQKaC4XWT0JhlY48Tfqyw3svXfAAhz3rcK4D0A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=le+yiPvVuDoMs41Ktw2YLUyIqCsiZ+JFki/f8B8ngXjOdiJ4wdntzX7hB4tQskvIi
 vrjDXSO0IyNLqY8QQ5NwTebDCmLhqoxamlBV9hEDanECTAVQzceA+r3aIuZfP8kuWR
 yNW5zwFp47++ugenPe3jW8skSykvxw2Qc56k5wcKr3tD6CiwF1tjAx95JGNqAsefEC
 Y4GOdaEfEjzQAlMv80KX6zH7fqRakXQ8c3kf33gZvgdda2/m8rz4vj1ExyvQw8lAkG
 vvMojA5f11f4bZfrpHi6q1EiXMAh6W+DJ5AQCUbq7SvTHT0nB4GckmFN91125+IBpX
 wf+TB80c/hhLw==
Received: from arisu.localnet (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id C72AD3782136;
 Tue, 23 Apr 2024 13:35:55 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v2 1/3] net: eth-uclass: Introduce NET_PREFER_ROM_MAC_ADDR
Date: Tue, 23 Apr 2024 09:35:40 -0400
Message-ID: <12429900.O9o76ZdvQC@arisu>
Organization: Collabora
In-Reply-To: <38f2306f-4c82-4bc4-b2ee-6051dc55a4c2@mailbox.org>
References: <20240422135927.23582-1-detlev.casanova@collabora.com>
 <20240422135927.23582-2-detlev.casanova@collabora.com>
 <38f2306f-4c82-4bc4-b2ee-6051dc55a4c2@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5781122.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
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

--nextPart5781122.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Date: Tue, 23 Apr 2024 09:35:40 -0400
Message-ID: <12429900.O9o76ZdvQC@arisu>
Organization: Collabora
In-Reply-To: <38f2306f-4c82-4bc4-b2ee-6051dc55a4c2@mailbox.org>
MIME-Version: 1.0

On Monday, April 22, 2024 3:47:21 P.M. EDT Marek Vasut wrote:
> On 4/22/24 3:56 PM, Detlev Casanova wrote:
> > On some boards, a MAC address is set based on the CPU ID or other
> > information. This is usually done in the misc_init_r() function.
> > 
> > This becomes a problem for net devices that are probed after the call to
> > misc_init_r(), for example, when the ethernet is on a PCI port, which
> > needs to be enumerated.
> > 
> > In this case, misc_init_r() will set the ethaddr variable, then, when
> > the ethernet device is probed, if it has a ROM address, u-boot will warn
> > about a MAC address mismatch and use the misc_init_r() address instead
> > of the one in ROM.
> > 
> > The operating system later will most likely use the ROM MAC address,
> > which can be confusing.
> > 
> > To avoid that, this commit introduces NET_PREFER_ROM_MAC_ADDR that can
> > be set for boards that have such an interface.
> > 
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> 
> Won't the system pick ROM MAC if $ethaddr is not set ?

Yes, and in the case of rockchip, misc_init_r() will set an $ethaddr based on 
the cpuid, which makes the eth driver use that instead of the ROM one.

--nextPart5781122.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEonF9IvGrXNkDg+CX5EFKUk4x7bYFAmYnuSwACgkQ5EFKUk4x
7bYhjgf/Q+MmgXfF1ZSnutcGJ5MPfjOrBjw1WdDVAaHbL3b7IRdLzmg+dWT60kv1
1SoYQKLzrctA0rx0UFgxTqYgkwklNOIzOaCro/9QOk8ta9GBCwDzBWZxE11Cg5eZ
KEtG+VXGICl/NL3aejJDXiJMO1kSnDb3RmwJnNVOE5I33dliDrxt5hsBVtYtkzhW
B4m08+7vBprrIvXIw7fJwRkIZ688d+RNVyrDvWaRwF0geRIxH5wijsvrnTmCVPcG
9jMsEPAI2RADG5/6owj05P0OC/DwZWiN88WLzf0RcfpB8AdVX5GWy26VxgQrkX23
xfEYMXyzboDHKpp2i0+AN2uJiJgKrQ==
=MqLw
-----END PGP SIGNATURE-----

--nextPart5781122.DvuYhMxLoT--



