Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077EAD715C7
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 05:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE5883B03;
	Sat, 24 Jan 2026 06:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="LkcL0f/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC8583B72; Sat, 24 Jan 2026 06:50:52 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8526C839DF
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 06:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 81CEF10D50D; Sat, 24 Jan 2026 06:50:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769233849; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Rmk/KLC7vC3BzXKOzxZHLahrPjAVEr9XhpZvc0EPBIY=;
 b=LkcL0f/Mc6K3XKAuPS3cBB2DByEF+Ctrp1emR0CYU0QZ+XlZI8q/QN5OaM0PhpkqhYVOSv
 kw8sMucn7MFKpukIv/PykP3Dn3i6ThN6m5zYYpkEzpFg8uegyFlzZZrIg5YEZSlrE8W2mK
 YLJzZoL6S3lXbnk8/QmU6LXmVCrJC0RjsCUBtiM/n9q5f7VNVVME22rZS/j0u32DhvoScH
 XbYIzYroRa8tq8VfJeoDgIX5V/uBVMhwt0l4fv033kAKCyMnRjuLVBz/fx8IGzFcG4V+DR
 nwESIpSIjoquSI6MaO5mgLTofAD7gKpcdWZVfOUbaRYECMwsLHRx1SgSlVwTXw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, John Ripple <john.ripple@keysight.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v1 0/2] Add for imx8x SoC get_boot_type command
Date: Sat, 24 Jan 2026 06:50:42 +0100
Message-Id: <20260124055044.8149-1-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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


add function sc_misc_get_boot_type() which requests from the
SC the current used boottype and add a comand "boottype" which
saves the current boot_type in environment variable "boottype",
so we can use this later.


Heiko Schocher (2):
  imx: scu_api: implement sc_misc_get_boot_type
  imx8qx: misc: add command for getting boottype

 arch/arm/mach-imx/imx8/misc.c  | 27 +++++++++++++++++++++++++++
 drivers/misc/imx8/scu_api.c    | 25 +++++++++++++++++++++++++
 include/firmware/imx/sci/sci.h |  1 +
 3 files changed, 53 insertions(+)

Azure build (series is in a bunch of siemens patches sending
now to mainline):
https://dev.azure.com/hs0298/hs/_build/results?buildId=202&view=results

-- 
2.20.1

base-commit: 5c3e84731b68d26340e6acf8e27c7c680aa55360
