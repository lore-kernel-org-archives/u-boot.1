Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BB3FF886C
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 22:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A6E846AC;
	Wed, 29 Apr 2026 00:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nj5c5lId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ADBA84660; Tue, 28 Apr 2026 20:04:51 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 137E58465E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+christian.dreher.nanoxplore.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D5A0D6111B;
 Tue, 28 Apr 2026 18:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B837C2BCAF;
 Tue, 28 Apr 2026 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777399486;
 bh=kM8wEbUbzNCx6ta+YFar0b1xB7KC0IbGPQ6eZ7DKkpc=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=nj5c5lIdOJWPtM+l+qhjCoiyKmN4Fu+g/UVdz9AXCD+Kr+fSFTjTiJpAfA2QAYN01
 RoO1oKnPkQdk1HjNBpfRhAgUg/yHTqnyokoOQmtx7EYA9GdEmHnb4EwsWqJtJH6RkE
 wmm3IrybDLtbwvCRc/iu6JGjueie9iuVPIi7SkzeMz9wr50YygC4a+R4AymuHUqIkv
 OJ/AbmAzx+qlYmmTPtunEF35H3BkdP3iTretaLKLWfp1mIDjihHt6QLd2RRu/Z1mop
 10w7VKA7jXFjVaSrOz5RHvzofXg9QVtg4Pg+Rc6zn3IRFh5MShxxp9G0OHJrKc6KAV
 xLAHVluMqXUcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 831F2FF885A;
 Tue, 28 Apr 2026 18:04:46 +0000 (UTC)
From: Christian DREHER via B4 Relay
 <devnull+christian.dreher.nanoxplore.com@kernel.org>
Subject: [PATCH 0/4] net: macb: support for instances with less features
Date: Tue, 28 Apr 2026 20:04:04 +0200
Message-Id: <20260428-net-macb-support-for-feature-lite-instances-v1-0-480e4cecac01@nanoxplore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJX28GkC/yXNQQoCMQyF4asMWRuoRWbEq4iLtpNqRNshSUUY5
 u5WXX6L9/4VlIRJ4TSsIPRi5Vo69rsB0i2UKyHP3eCdH93BH7GQ4TOkiNqWpYphroKZgjUhfLD
 1QVELJZFijm5yU4xh9iP0x0Uo8/tXO1/+1hbvlOybgG37AL3UBwmPAAAA
X-Change-ID: 20260428-net-macb-support-for-feature-lite-instances-fb0707bbad26
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Christian DREHER <christian.dreher@nanoxplore.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777399485; l=1844;
 i=christian.dreher@nanoxplore.com; s=20260428; h=from:subject:message-id;
 bh=kM8wEbUbzNCx6ta+YFar0b1xB7KC0IbGPQ6eZ7DKkpc=;
 b=OzfefxG4/r3rjF54HopPKQrV/2b1GgLUuoiJE56xPkknBqmY5Yn8jdUxmazRwTSdEP+X2xfon
 H7MYbKgPLzoAr0OuFwb0thujVXZmu4DmYii6P0GrOrwSFg3HpSUSnqJ
X-Developer-Key: i=christian.dreher@nanoxplore.com; a=ed25519;
 pk=id7EcKmXLV2xNgNiCIcsPjkoMQHM/qxTYqEqMhidSAU=
X-Endpoint-Received: by B4 Relay for
 christian.dreher@nanoxplore.com/20260428 with auth_id=760
X-Original-From: Christian DREHER <christian.dreher@nanoxplore.com>
X-Mailman-Approved-At: Wed, 29 Apr 2026 00:48:15 +0200
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
Reply-To: christian.dreher@nanoxplore.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

I am updating the macb driver to use it on a new SoC with a Cadence
GEM (IP7014). The GEM is instantiated with a different setup than the
ones in the Atmel family, and this patchset allows the driver to run
on this other configuration, with no significant change of behavior
on already supported platforms. (The support of the SoC itself will
not reach the mailing-list before months).

This patchset was tested on emulator, with a RGMII fixed-link, by
pinging a remote host (an actual computer, connected to the emulator
and running Linux). The test produced an ARP request/answer followed
by a successful ICMP request/answer, using the legacy IP stack in
u-boot.

The patchset was developed and tested on top of U-boot v2026.1

It was not tested for non-regression on previous hardware, since I do
not own any.

This patchset
* Remove a build issue when the mach does not have its own clk.h
* Uses MAC filter 1 instead of 3, for GEMs without 3 filters
* Does not set the user_io register on GEMs that do not have one
* Add fixed-link for Gigabit (added for test purpose, may be dropped)

Thanks,
Christian

Signed-off-by: Christian DREHER <christian.dreher@nanoxplore.com>
---
Christian DREHER (4):
      net: macb: include arch/clk.h only when necessary
      net: macb: use SA1 for MAC filtering on GEM
      net: macb: do not set user_io when it does not exist
      net: macb: add gigabit implementation for fixed-link

 drivers/net/macb.c | 94 ++++++++++++++++++++++++++++++++++++++++--------------
 drivers/net/macb.h |  2 ++
 2 files changed, 72 insertions(+), 24 deletions(-)
---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260428-net-macb-support-for-feature-lite-instances-fb0707bbad26

Best regards,
--  
Christian DREHER <christian.dreher@nanoxplore.com>


