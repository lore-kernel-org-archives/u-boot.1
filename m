Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5671BCCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 07:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D6258307F;
	Sun,  2 Nov 2025 08:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="W8+uMSZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6DBE830A0; Sun,  2 Nov 2025 08:54:14 +0100 (CET)
Received: from mail1.manjaro.org (mail1.manjaro.org
 [IPv6:2a01:4f8:c010:b6e8::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED4F82A9E
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 08:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPA id 37A8D40D53; Sun,  2 Nov 2025 08:54:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
 t=1762070051; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=uvKYt0Fl47xdQlPZdqqrm4jH13GhGugBBkNPGs/n28Y=;
 b=W8+uMSZa7EdIjP39xPPmmfE4X6yHuagK1hw87hgErfMhVBLy5EoIDEE+W7fJV9SQtMSM3+
 gGiQyEA8GfGk6fEWJRYcpa4opM1meUMEV5iYS9Dc3WK/foT2BftL7jUUTmKp5dIekIIINx
 B/CSqs6x4AXfhaSUf0LiiSIovpxs0dQ6g1CKwtmITCX9BPBYi2sypAJLsDqWdYbco71tSV
 XznMWCsCQRpbSfRukMPICo5Lf2dFyoM59fa598YdjOXItGhYFMf46m1ANLioeBfRxmX3vZ
 UpzsaH+1oo6ak7p6NyXxJ2aYSQ8kQ98ccHmemblFkIS99oXxMDMLNbmDFFqv7w==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <3df8e40c-ecdf-4134-aee4-b59deb17de89@kwiboo.se>
Content-Type: text/plain; charset="utf-8"
References: <20251101203429.1603832-1-jonas@kwiboo.se>
 <878qgpqwpi.fsf@bloch.sibelius.xs4all.nl>
 <cec3cc0b-0326-4b0b-6832-f5db556c4cf2@manjaro.org>
 <3df8e40c-ecdf-4134-aee4-b59deb17de89@kwiboo.se>
Date: Sun, 02 Nov 2025 08:54:08 +0100
Cc: "Mark Kettenis" <mark.kettenis@xs4all.nl>, trini@konsulko.com,
 jh80.chung@samsung.com, peng.fan@nxp.com, ye.li@nxp.com, festevam@gmail.com,
 danct12@riseup.net, u-boot@lists.denx.de
To: "Jonas Karlman" <jonas@kwiboo.se>
MIME-Version: 1.0
Message-ID: <5c0f34da-2346-3404-5441-d83a61ba3008@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] Revert =?utf-8?q?=22power=3A?=
 =?utf-8?q?_regulator=3A?= Add vin-supply for GPIO and Fixed 
 =?utf-8?q?regulators=22?=
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None
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

Hello Jonas,

On Sunday, November 02, 2025 03:00 CET, Jonas Karlman <jonas@kwiboo.se>=
 wrote:
> On 11/1/2025 10:23 PM, Dragan Simic wrote:
> > On Saturday, November 01, 2025 22:17 CET, Mark Kettenis <mark.kette=
nis@xs4all.nl> wrote:
> >>> From: Jonas Karlman <jonas@kwiboo.se>
> >>>
> >>> Rockchip boards may depend on a working MMC regulator in SPL to
> >>> successfully load FIT payload from MMC. Typically, these boards o=
nly
> >>> include the vmmc-supply regulator and not its vin-supply in SPL c=
ontrol
> >>> FDT.
> >>>
> >>> The commit f98d812e5353 ("power: regulator: Add vin-supply for GP=
IO and
> >>> Fixed regulators") breaks loading FIT from MMC in SPL on some of =
these
> >>> boards due to now requiring the vin-supply to be included in the =
SPL
> >>> control FDT.
> >>
> >> I ran into this issue a few days ago.  Unfortunately that means U-=
Boot
> >> 2025.10 is broken on several Rockchip boards :(.
> >=20
> > Sadly, that's true. :(
>=20
> I do not think the commit was part of 2025.10, it was merged to next =
and
> should currently only be part of master and 2026.01-rc1.

You're right, the troublesome commit f98d812e5353 ("power:
regulator: Add vin-supply for GPIO and Fixed regulators") isn't
part of the U-Boot 2025.10 release, which can be verified by
checking drivers/power/regulator/regulator=5Fcommon.c in the
ultimate reference, which is the 2025.10 release tarball. [1]

[1] https://ftp.denx.de/pub/u-boot/u-boot-2025.10.tar.bz2

