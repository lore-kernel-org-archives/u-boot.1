Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8783CD98F0
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 22:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 124FC84081;
	Thu, 13 Nov 2025 23:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BGZBmc4Z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yC/fVpcs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14CF284082; Thu, 13 Nov 2025 23:17:13 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB84A8406D
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 23:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d6vlB45k8z9tvG;
 Thu, 13 Nov 2025 23:17:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763072230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xOvXMxmsiN8zMABt3Yi2t8mM2GamLr8PgBf8xijZz+4=;
 b=BGZBmc4ZinK7srltmsuCDJB2EXsoX8Pheajhx3ZbXShNmxV6gXw7KmzOOCg3BAH15Uezdp
 4s/KcyIkNBgFW8GQ3J748f6c+CDFgrNEcRvfu8rWgRjpbkFQZrdcm3T5uPaNVzkRv1vLyE
 sjEF/bnvz5KDhCBH9ucL2UW4U6RFxtgG9iJRnsIXn4/RuEnsJwrTwN8NL9MDsl6/0bgh9y
 /lIQa6UGmOVPZEgNy4AVsCRyMmByIu0OMZlK1ecPtDU8ly7B3q2f2IUtwsgE9rAfUGTRNc
 o2jancARM1OvndaBSV/0OdpZDQb55XZK6ad/eA8j5AZMNAcfVshkpVIFiV39IA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763072228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xOvXMxmsiN8zMABt3Yi2t8mM2GamLr8PgBf8xijZz+4=;
 b=yC/fVpcs9jV4YOlWmhhKMLJ+mX8LN1s5hkCGqERzl5rF3xaPo3BlkuZ2U3oeSf9LT83Hey
 27N78W0GRPiPsvF8+e0Tm9Y5gObyyPL4D23Sxu842y4Lp7/O9Vx82znC2mSdjDsCDiR/gW
 XCbdZLWcE4rIzvURmuANmx5W4qvLBOppVajlBzQZsUw4KT4ZEKtMWiRXj/FEOWxzZRDLIS
 YGYJj9W0AqD/azTIWvId8EUHJuDbFhm1+SXhaa4qBg4U/kIUulM5G8uhIEuEK2u0u+T8uf
 60VkQfLrD/dV2uyN1qcnp3q+LdksbK8hWa0F9DQrDpTCUAICoYmMgcE3Mq2txw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Huy Bui <huy.bui.wm@renesas.com>, Thanh Quan <thanh.quan.xn@renesas.com>
Subject: [PULL] u-boot-sh/master
Date: Thu, 13 Nov 2025 23:15:40 +0100
Message-ID: <20251113221627.1141330-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f19443509f9cfc019cd
X-MBO-RS-META: 6wyannih84oyikcdjn3bep3jskady735
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

R-Car Gen4 pinctrl alignment with latest reference manual.

The following changes since commit 6c2f2d9aa63d1642dffae7d7ac88f7ae879e13d1:

  Merge branch 'master' of git://source.denx.de/u-boot-usb (2025-11-13 08:01:57 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to f71eea7f85ab85b74f4968c1e1e46369614d3903:

  pinctrl: renesas: r8a779h0: Remove STPWT_EXTFXR (2025-11-13 16:30:26 +0100)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      pinctrl: renesas: r8a779h0: Remove STPWT_EXTFXR

Huy Bui (3):
      pinctrl: renesas: r8a779g0: Remove CC5_OSCOUT
      pinctrl: renesas: r8a779g0: Remove STPWT_EXTFXR
      pinctrl: renesas: r8a779h0: Remove CC5_OSCOUT

Thanh Quan (1):
      pinctrl: renesas: r8a779g0: Remove AVB[01]_MII

 drivers/pinctrl/renesas/pfc-r8a779g0.c | 100 +++++++++++----------------------
 drivers/pinctrl/renesas/pfc-r8a779h0.c |   6 +-
 2 files changed, 35 insertions(+), 71 deletions(-)
