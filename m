Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE02C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8424F884D4;
	Fri, 14 Jun 2024 14:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="kaUCLT5j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C9408844D; Fri, 14 Jun 2024 14:29:17 +0200 (CEST)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5430A88702
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
X-Envelope-To: contact@jookia.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1718368154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/JoCYJ+4LlhCPFc1TmVE3gQdP0A3EixZI4rudxX8kcM=;
 b=kaUCLT5jKjP71Po3Ro7a7dGG/gw69TYQfhmG0B1QHIeARsRc2Xf8JePqYhDaePPGkKjNkF
 UFgg1uXgj4vq1hOZ6C/U6rXfdadcUsK4wbtAEyoYj3ZI00RrM5GjzMHBdWWgh0dL6Wv9C5
 f3Co18N93Jc4u1YsXCecwz07Lpebg6fPL8bKJxfYAdmdI8f0s+55tQSEuMio03FPV3o51y
 tGIm8+eyiGN0rovUC2q/n3lsgFQVr/NR5ACxntVGl6+u6aV+mi6MPivjG43DR5vuuqKi1T
 GZS+Mit2Xnm8I+4yFN8zLCnFAcLDhdTm+yzNiVsTqsuSsUgYYgI+/f2WwKuBwg==
X-Envelope-To: trini@konsulko.com
X-Envelope-To: andre.przywara@arm.com
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: jagan@amarulasolutions.com
X-Envelope-To: agust@denx.de
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Subject: [PATCH 0/2] sunxi: video: Fix lcdc polarity display flags
Date: Fri, 14 Jun 2024 22:28:44 +1000
Message-Id: <20240614-sunxipolarities-v1-0-15bbbf57dfff@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHw3bGYC/x3MQQqAIBBA0avErBPUJKqrRAuzqQZCRSsE8e5Jy
 794P0PEQBhhajIEfCmSszVE24A5tT2Q0VYbJJeK90Kx+NhE3l060F0h06OWwnTcDHKFqnzAndJ
 /nJdSPqO0NYJhAAAA
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Anatolij Gustschin <agust@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1718368128; l=712;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=FtofB0v+557Kkbgz2VZu1s5UU68ilMCiN51tySDjV9k=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAIMbbF7AXwvKNTLNB+bLlR3R
 3qToBJas/JTL3O+jT8B5y21lcWPQis+nZ3wWUlW3TPAmzc1Np3aG5RrKui0W4AwUAAP/Z
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:/gEvgms/9HpbgpcH+K7O4GYXmqkP7siJx9zHeEWRZTg
X-Migadu-Flow: FLOW_OUT
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

The current LCD controller driver has incorrect polarity masks, so I've
provided a fix for that. While I was there I also added support for two
new display flags related to polarities.

Signed-off-by: John Watts <contact@jookia.org>
---
John Watts (2):
      sunxi: video: Properly invert hsync and vsync polarity
      sunxi: video: Support DE_LOW and PIXDATA_NEGEDGE display flags

 arch/arm/include/asm/arch-sunxi/lcdc.h | 2 ++
 drivers/video/sunxi/lcdc.c             | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)
---
base-commit: c0ea27bccfb7d2d37fd36806ac2a2f7389099420
change-id: 20240614-sunxipolarities-a9a21c30c82b

Best regards,
-- 
John Watts <contact@jookia.org>

