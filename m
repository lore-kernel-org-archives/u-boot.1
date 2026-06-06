Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD10ACD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 08:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C26849CB;
	Sat,  6 Jun 2026 10:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ab1xwDsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F3FE84942; Sat,  6 Jun 2026 10:48:04 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D192F8493E
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 10:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DD8BD444D3;
 Sat,  6 Jun 2026 08:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF8F5C2BCB0;
 Sat,  6 Jun 2026 08:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780735670;
 bh=ticXsztP8o8s+OSoF+Wy8kc3BBouMVa5KxJj3EXqX6E=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=ab1xwDsaBdciDntgYoLw9/9Ft9Qy1dUV/NFrVgo+U9X32txG/t5yN9k2uP6uf1huL
 kU6jujlyzyyRWmlnz9Ci76X/Xkxfpmb10g99Ssx/uQ7/c0OlFiM896+hBiyB1fySFM
 IspwXMctQGfCN0R+bRqnyth+t8cuMbxzkQMKtVf9X9nbgkFYkBUYm5iZsRLxBmLLKm
 jyqeSlRUHqwSrDZFHNE7+6pWkT8kYyYl7S/iUnMoI9Xx6QQXAYS6otykdP1JN5w4fG
 uLZF50XQYtt4ld91OsHtRQ5s535AI5MKDTH8QJMsrlJUpHTtmL5sCFIJm/msOxJDAH
 pYizSvrX7StdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 950D0CD8C8B;
 Sat,  6 Jun 2026 08:47:50 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Subject: [PATCH 00/11] PM8916 PON support
Date: Sat, 06 Jun 2026 18:47:31 +1000
Message-Id: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNj3YJcC0tDM92C/Dxdc2OLFHMzsyQLAwMzJaCGgqLUtMwKsGHRsbW
 1APuEVJtcAAAA
X-Change-ID: 20260603-pm8916-pon-738d766b8006
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Justin Klaassen <justin@tidylabs.net>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Sam Day <me@samcday.com>, 
 Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780735669; l=3258;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=ticXsztP8o8s+OSoF+Wy8kc3BBouMVa5KxJj3EXqX6E=;
 b=NrkZfaEIEZBHcA+WCR/lELA1BCf+1KR7SKSDKXk6B+lRRIvYKPaJM8+4qmqiX/ifwomw1favI
 ZMOPQ4CXG4IA6NqjI9HsJaqc1PJsPwMlZ0EU90/q+RM/ujwLDBOdkbB
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This series introduces sysreset + reboot-mode drivers for PM8916 PON.

Additionally, fastboot gains support for driving DM reboot-mode, so that
`fastboot reboot bootloader` works as you'd expect.

This series should be considered supplementary and slightly alternative
to Aswin's NVMEM-based approach currently on the list. I cherry-picked
Aswin's commit for adding reboot-mode detection to mach-snapdragon
board code.

I think a native PON driver for the older (non-SDAM) PMICs should exist,
rather than trying to bridge the gap with synthetic NVMEM DT nodes. The
main issue is that we'd need to define these overrides for every
device/SoC-family since those nodes don't (and won't?) exist in the
mainline kernel.

The other main differences between this series and Aswin's are:

 * A sysreset driver is implemented, in addition to reboot-mode. This is
   what makes the poweroff command work on MSM8916 and other older
   platforms lacking a (sane, or any at all) PSCI implementation.
 * The DM reboot-mode-driven fastboot_set_reboot_flag implementation,
   which is what makes `fastboot reboot bootloader` work.

I think the PON infra introduced in this series can be generalized out
beyond PM8916, but I decided to stop here and leave further
generalization up to a follow-up series (or follow-up version, depending
on feedback!)

Link: https://lore.kernel.org/u-boot/20260521180549.282377-1-aswin.murugan@oss.qualcomm.com/
Signed-off-by: Sam Day <me@samcday.com>
---
Aswin Murugan (1):
      mach-snapdragon: Integrate reboot-mode handling

Sam Day (10):
      button: qcom-pmic: introduce exported setup method
      drivers: misc: pm8916_pon: add glue driver
      qcom_defconfig: enable PM8916_PON
      drivers: misc: pm8916_pon: support setting reboot type
      sysreset: qcom-pshold: PM8916 PON reset type support
      qcom_defconfig: enable poweroff command
      reboot-mode: pm8916-pon: add new driver
      reboot-mode: reboot method activation support
      fastboot: DM_REBOOT_MODE reset support
      qcom_defconfig: enable reboot modes

 arch/arm/mach-snapdragon/board.c             |  56 +++++++--
 configs/qcom_defconfig                       |   5 +
 drivers/button/button-qcom-pmic.c            |   7 +-
 drivers/fastboot/Kconfig                     |   7 ++
 drivers/fastboot/Makefile                    |   1 +
 drivers/fastboot/fb_reboot_mode.c            |  51 ++++++++
 drivers/misc/Kconfig                         |   7 ++
 drivers/misc/Makefile                        |   1 +
 drivers/misc/pm8916_pon.c                    | 167 +++++++++++++++++++++++++++
 drivers/reboot-mode/Makefile                 |   1 +
 drivers/reboot-mode/reboot-mode-pm8916-pon.c |  88 ++++++++++++++
 drivers/reboot-mode/reboot-mode-uclass.c     |  18 +++
 drivers/sysreset/sysreset_qcom-pshold.c      |   9 ++
 include/button/qcom-pmic.h                   |  17 +++
 include/pm8916_pon.h                         |  18 +++
 include/reboot-mode/reboot-mode.h            |  12 ++
 16 files changed, 450 insertions(+), 15 deletions(-)
---
base-commit: 75daa277941702bf58c88d65c0cb6ed962899d9e
change-id: 20260603-pm8916-pon-738d766b8006

Best regards,
-- 
Sam Day <me@samcday.com>


