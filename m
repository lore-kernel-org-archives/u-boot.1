Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076D1C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 13:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50028830CA;
	Mon,  7 Jul 2025 15:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="KHBmxJvy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76912830E4; Mon,  7 Jul 2025 15:06:07 +0200 (CEST)
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch
 [79.135.106.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1301A8305C
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 15:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail2; t=1751893564; x=1752152764;
 bh=VLkpF25GxNXkEP44Itqcd1zsS4LaJui7eP4w0UbYBGI=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=KHBmxJvyNNsxPfJN9gGLPRwqQanQl/kK8glydJ3i8VXTl4YjTpbFmMb0gIPITtAv+
 z8TMPkugmuDgamTiT4IVK1GVpQv9pI+/zRgLVXz8sEtFNWjvWekHZGMqzhq2FQ2mHt
 Y0PDHVCea1+U72XlkCpuDklKcuxOWBGHQNiKESc4klXQXD3okTg2lvgtcwdoWvWInk
 GhmmG0XjnqtFntQMdzPNW3tecuibrAxXGBuRAmoVF5kCw27VFNuzeRTMXmQc5YNxFx
 NwaciejV0pWW96iQH2ogqOLQmjkyR+di2lwbzdZl1Rp4smBdJwIpZ5fAslArlEYtzm
 JATwY1PVqRnOg==
Date: Mon, 07 Jul 2025 13:06:00 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Philip Molloy <philip.molloy@analog.com>
Subject: [PATCH 0/4] Minor fixes to comments, README, and Kconfig description
Message-ID: <20250707150438.3016690-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: 82271d47a9aca1576ab3c5cc458a463826287256
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

From: Philip Molloy <philip.molloy@analog.com>

A hodge-podge of minor fixes I came across while debugging.

https://github.com/analogdevicesinc/u-boot/tree/staging/philip/minor-mainli=
ne-cleanup

Philip Molloy (4):
  pinctrl-uclass: update comment to reflect code
  serial-uclass: fix typo in comment
  gpio: add SPL to Kconfig option description
  README: remove obsolete note

 README                           | 4 ----
 drivers/gpio/Kconfig             | 2 +-
 drivers/pinctrl/pinctrl-uclass.c | 3 +--
 drivers/serial/serial-uclass.c   | 2 +-
 4 files changed, 3 insertions(+), 8 deletions(-)

--=20
2.50.0


