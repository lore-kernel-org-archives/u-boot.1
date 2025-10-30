Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BE1CCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD50F836F0;
	Thu, 30 Oct 2025 14:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="0bbYvOm5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C2EA83710; Thu, 30 Oct 2025 14:27:50 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de
 [IPv6:2a01:238:43f2:8900:dd04:e3a0:ee11:a73d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F36F9836D3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 14:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown [149.220.72.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id 8BEF53D429C3;
 Thu, 30 Oct 2025 14:27:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1761830867;
 bh=ddwW3rp6bEO9m4t8RVN9BVaOrPPoOfa8NW6QITgVq2k=;
 h=From:Subject:Date:In-Reply-To:Cc:To:References;
 b=0bbYvOm5OasDJAXdPmJquJ/orD4e+kQtFfbr9Fqxuw+N2bH0rKvugck2yy5sDr7GM
 oBHb4agZbYnIq7v6E9oj6yCD0T51oUSDKBpv6CEnDudbCgSFwxtl3a7t+RZ6/nEXiG
 xu72dJhzOZz9aCnM1xHRlDZAOKTu1OPTU9exHHVw=
From: Jens Maus <mail@jens-maus.de>
Message-Id: <471FB4A4-9EE9-480F-B74C-1B60F437A5DB@jens-maus.de>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 0/4] Improve RaspBerry Pi 5 support part1: Fixes
Date: Thu, 30 Oct 2025 14:27:37 +0100
In-Reply-To: <20251010161442.410C4227AAE@verein.lst.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
To: Torsten Duwe <duwe@lst.de>
References: <20251010161442.410C4227AAE@verein.lst.de>
X-Mailer: Apple Mail (2.3826.700.81)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Torsten,

Looking forward to your whole patch series on getting Pi 5 support in =
U-Boot finally in a state that booting from NVMe and USB as well as =
ethernet would finally be possible. Quickly looked over your first =
patchset on fixes. When do you expect to submit the rest (patchset 2+3) =
so that we can start testing NVMe/USB Boot with a Pi5?

Regards,

Jens

> Am 10.10.2025 um 18:14 schrieb Torsten Duwe <duwe@lst.de>:
>=20
> Hi all,
>=20
> This series is basically a resend of Oleksii Moisieiev's from =
February[0].
> I forward-ported the code where neccessary, rephrased some =
explanations,
> retested and reshuffled the changes, grouping them into at least 3 =
parts:
>=20
>     1: Fixes
>     2: PCIe support for the bcm2712
>     3: RP1 chip and MACB ethernet support
>=20
> Haven't tried USB yet, but with the full series NVMe boot is working,
> and I get a "file not found" from my DHCP/TFTP server.
>=20
> Let's start with the fixes, they should be undisputable. Credits go
> to the epam guys for tracking these down. Patches should apply cleanly
> on 2025.10 and on current master [ecdc3872a767].
>=20
> 	Torsten
>=20
> [0] https://lists.denx.de/pipermail/u-boot/2025-February/579540.html

--=20
Jens Maus, Dresden/Germany
https://jens-maus.de/

