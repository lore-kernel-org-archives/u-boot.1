Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06B0CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5464584A6D;
	Mon,  1 Jun 2026 14:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uRlW/BUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3131C8487C; Mon,  1 Jun 2026 13:52:44 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 261508488A
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 13:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+petr.hodina.protonmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 92294436A3;
 Mon,  1 Jun 2026 11:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A6B6C2BCB8;
 Mon,  1 Jun 2026 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780314758;
 bh=LC1KEiCh5cgS0hAeF9Hre6xCEkCl5eQod5RNmlL42C0=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=uRlW/BUREnH01u7Q5RpM4t+I9+Bms8GSX19htH45Qt/6Gwnk+BwkfwKofwbsKzNfY
 0ZHTSWHo3bwQpTF5MvgIHr6ejM+uOsvS58XSyR2HShN1zZSM75h+mS0HBiZ5Q9obAQ
 NSV0MdPac2RBzcgn/Cq2KmYTQ/+spai6Nk5uxNDGsofySb99dcPZMdnLJ2LyPkxPUk
 8Qx7sMjtkEWiMO16qFOGTjFpl4qJPRazOwnTlnyqfkkrLd+rsbwtB8iKYWI+BN/mJh
 H6XSxB4g1cYQdKdTyk5wyJ7Sio2frEWB2ZNIpVPGNtv4qRl/jbXiKIlbqz+3vp0k8M
 JkV9LoOspJahg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6261DCD5BD1;
 Mon,  1 Jun 2026 11:52:38 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH 0/2] Add gpio configuration support for Qualcomm Snapdragon
 platform
Date: Mon, 01 Jun 2026 13:52:34 +0200
Message-Id: <20260601-qcom-gpio-v1-0-e24bcdb35da0@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJyHWoC/yXM3wpAMBSA8VdZ59pqFvPnVeSCOTiKzYaUvLvh8
 ldf3wUeHaGHkl3g8CBPZgmIIwZ6bJYBOXXBIIVUQomYr9rMfLBkeJFjnjatlCrJIPTWYU/n96r
 q335vJ9TbO4D7fgC9coBLbQAAAA==
X-Change-ID: 20260601-qcom-gpio-98e85ab22647
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, phone-devel@vger.kernel.org, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780314756; l=757;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=LC1KEiCh5cgS0hAeF9Hre6xCEkCl5eQod5RNmlL42C0=;
 b=GFU5sZU4RsOg0hvvaDb1hts/0dp1shvPTEM5/i9o6RVwFVP2eFSX8nTTtgWdyIxWmR/2GOcXr
 xOjizHsZ/JVBo7q3sMlUKS90D++x8HFfkHvmoV1nI627+TeU/nuo8Ax
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This patch series adds the gpio configuration as input along with
pull-up/down/disable and drive strength for output.

Remove the reconfiguration from the set_direction.

This enables on mainline Linux phones to use volume-up in menu.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Petr Hodina (2):
      gpio: qcom_pmic_gpio: implement standard pinconf parameters
      gpio: qcom_pmic_gpio: don't reset pull on direction change

 drivers/gpio/qcom_pmic_gpio.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)
---
base-commit: 1f89ddd61cd8c27a3dc1fc7edbeccb55d424eb72
change-id: 20260601-qcom-gpio-98e85ab22647

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


