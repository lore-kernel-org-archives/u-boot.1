Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48477EF48CA
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 05:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE2783B30;
	Fri, 13 Feb 2026 06:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="A+VUdUAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12CAD83D5D; Fri, 13 Feb 2026 06:15:19 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C9E83015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 06:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 577511106D1; Fri, 13 Feb 2026 06:15:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1770959716; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=NOAYacnW4YfPRS3ziP5lfUnuTG+177MO0t27c6GXcwY=;
 b=A+VUdUAPPqBbU9fwLEULTJDpY9J19kdN8DNOmEa7UzZitNMD8hPj2VRZOf+/xYv8lwjKDY
 uQ3Oel0XOxqG0i+SLXR2kkd/2ObsCS3EVbzVG0whRisAOgJkwHSyfB/+lHBKPRdTfoLGLY
 9iNj0yT9VpM2xNBhXgLVxQX4JlJrA3sJaooOECMAhDUSr1Ldb5JQqY7CbljSJeptmkpWCg
 1Jau6XPmeLljkhO7p+/kS7q49Y2aSAneKPW8EeQzxsEbndPohdgUbzii56PrgCcaC46xXu
 t4SYjlOwA8Q5hIgfwYYZlPgxrdhvOOP30Hmz/ubErwVmoL11FXIHcLXB5KBu9Q==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, John Ripple <john.ripple@keysight.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v2 0/2] Add for imx8x SoC get_boot_type command
Date: Fri, 13 Feb 2026 06:15:05 +0100
Message-Id: <20260213051507.23466-1-hs@nabladev.com>
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

Changes in v2:
- rebase to mainline
  b99da05e153 - (tag: v2026.04-rc2, origin/master, origin/HEAD) Prepare v2026.04-rc2
- add Reviewed-by from Peng
- add description for the values returned, as suggested from Peng

Heiko Schocher (2):
  imx: scu_api: implement sc_misc_get_boot_type
  imx8qx: misc: add command for getting boottype

 arch/arm/mach-imx/imx8/misc.c  | 33 +++++++++++++++++++++++++++++++++
 drivers/misc/imx8/scu_api.c    | 25 +++++++++++++++++++++++++
 include/firmware/imx/sci/sci.h |  1 +
 3 files changed, 59 insertions(+)

-- 
2.20.1

base-commit: f2b1dd4c6d1d549f5afddbc2323a9e8b74fce5df
