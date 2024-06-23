Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F190C2BD09
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 00:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA8A88176;
	Sun, 23 Jun 2024 02:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719102491;
	bh=EqLosxON9dtdvsmCzHxk7Tbmyo/OVpfdklhWD45HIi0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iqtwz4zvK6W3cp+yAVXg5r1y4ynbDAzRdSv1cBZR46mcihM7wQuL+oSTu9o328thK
	 RPBKk1BoKHxCePn/uhK+6qBM8MWQ3w4g1SZCb1d4NSZMSjqHUXJNfcr/MLJUIVRdWJ
	 bCYG9DqYsxnCJLo9se9BdW9NTy+FsSAABWOw5cBdoTu1wp7qD3vlRrnEa87HiE60ts
	 qem8xjlWeLzYEUCFP5wT2+j+zFZwKrgvsfqK0cSfTdZUTSnaAb5Ae5/Ue1lvVO1U0Z
	 NchT02rjUiBpKWXUbBxCOvAGXqYiI3JgJKEIgajo3gAwd00gRt1kjMAEn53q7rcqPl
	 F4eHdEuCtA73w==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 517C28803E;
 Sun, 23 Jun 2024 02:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719102490;
 bh=EqLosxON9dtdvsmCzHxk7Tbmyo/OVpfdklhWD45HIi0=;
 h=From:To:Cc:Subject:Date:From;
 b=NIXUE+n8MLkzpI6idwLnVWJXHKCL0nbb4/VzGtxsCNGTHB5CFOnGBUMhc6U/pwMUK
 1eVmtOs4FodwfLLtg5MBlibqg3wxyKYnheCVXkPyTflTxReB7HInrW03E3HAZrCEdg
 VVi+D1s0EG/F25AvrRGamh6nA/Flh+yG2nqX1PXu4sXc2jDr2BlPLoc5/VTIH0AXGC
 o2GFb1HZGHo85XgfXjN1+j/OAxaYgzjD30FQzje5j4NMpEd0AeBQKdLSJG+oGLMfoF
 QfATY51xdk8lHmthM7GLRHbG0T2A+8VYM9WD9X3Gi5vbleiLbdPklJUzYUP0z7ZFrg
 qnuEmg8/UGlEg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PULL] u-boot-usb/master
Date: Sun, 23 Jun 2024 02:27:06 +0200
Message-ID: <20240623002750.340406-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This can also go into next if you prefer.

The following changes since commit fe2ce09a0753634543c32cafe85eb87a625f76ca:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-watchdog (2024-06-18 08:34:56 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 0db3941a24bf0b6fc54438e7b9cc66b18f08115b:

  usb: dwc3: add newlines to dev_vdbg calls in ep0 (2024-06-19 06:15:37 +0200)

----------------------------------------------------------------
Caleb Connolly (1):
      usb: dwc3: add newlines to dev_vdbg calls in ep0

Heinrich Schuchardt (1):
      usb: informative message if no controller

 drivers/usb/dwc3/ep0.c        | 46 +++++++++++++++++++++----------------------
 drivers/usb/host/usb-uclass.c |  2 +-
 2 files changed, 24 insertions(+), 24 deletions(-)
