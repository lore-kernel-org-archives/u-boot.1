Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5D0C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 08:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E163876FE;
	Wed,  8 Nov 2023 09:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6746186F6F; Wed,  8 Nov 2023 09:51:35 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 0CF6087450
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 09:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,285,1694703600"; d="scan'208";a="182153779"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 08 Nov 2023 17:51:28 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.197])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5715041D0CBF;
 Wed,  8 Nov 2023 17:51:26 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH] sysreset: Fix unsupported request return values
Date: Wed,  8 Nov 2023 08:51:10 +0000
Message-Id: <20231108085110.883-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
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

The description of the sysreset request method in <sysreset.h> says that
the return value should be -EPROTONOSUPPORT if the requested reset type
is not supported by this device.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/sysreset/poweroff_gpio.c     | 2 +-
 drivers/sysreset/sysreset_psci.c     | 2 +-
 drivers/sysreset/sysreset_sandbox.c  | 4 ++--
 drivers/sysreset/sysreset_watchdog.c | 2 +-
 drivers/sysreset/sysreset_x86.c      | 2 +-
 test/dm/sysreset.c                   | 6 +++---
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/sysreset/poweroff_gpio.c b/drivers/sysreset/poweroff_gpio.c
index a5c24fd85bca..ad04e4b1a85e 100644
--- a/drivers/sysreset/poweroff_gpio.c
+++ b/drivers/sysreset/poweroff_gpio.c
@@ -33,7 +33,7 @@ static int poweroff_gpio_request(struct udevice *dev, enum sysreset_t type)
 	int r;
 
 	if (type != SYSRESET_POWER_OFF)
-		return -ENOSYS;
+		return -EPROTONOSUPPORT;
 
 	debug("GPIO poweroff\n");
 
diff --git a/drivers/sysreset/sysreset_psci.c b/drivers/sysreset/sysreset_psci.c
index a8a41528a849..aa09d0b88271 100644
--- a/drivers/sysreset/sysreset_psci.c
+++ b/drivers/sysreset/sysreset_psci.c
@@ -25,7 +25,7 @@ static int psci_sysreset_request(struct udevice *dev, enum sysreset_t type)
 		psci_sys_poweroff();
 		break;
 	default:
-		return -ENOSYS;
+		return -EPROTONOSUPPORT;
 	}
 
 	return -EINPROGRESS;
diff --git a/drivers/sysreset/sysreset_sandbox.c b/drivers/sysreset/sysreset_sandbox.c
index f485a1352993..c12eda81d03e 100644
--- a/drivers/sysreset/sysreset_sandbox.c
+++ b/drivers/sysreset/sysreset_sandbox.c
@@ -21,7 +21,7 @@ static int sandbox_warm_sysreset_request(struct udevice *dev,
 		state->last_sysreset = type;
 		break;
 	default:
-		return -ENOSYS;
+		return -EPROTONOSUPPORT;
 	}
 	if (!state->sysreset_allowed[type])
 		return -EACCES;
@@ -70,7 +70,7 @@ static int sandbox_sysreset_request(struct udevice *dev, enum sysreset_t type)
 			return -EACCES;
 		sandbox_exit();
 	default:
-		return -ENOSYS;
+		return -EPROTONOSUPPORT;
 	}
 	if (!state->sysreset_allowed[type])
 		return -EACCES;
diff --git a/drivers/sysreset/sysreset_watchdog.c b/drivers/sysreset/sysreset_watchdog.c
index ceada2e47b54..6db5aa75b541 100644
--- a/drivers/sysreset/sysreset_watchdog.c
+++ b/drivers/sysreset/sysreset_watchdog.c
@@ -29,7 +29,7 @@ static int wdt_reboot_request(struct udevice *dev, enum sysreset_t type)
 			return ret;
 		break;
 	default:
-		return -ENOSYS;
+		return -EPROTONOSUPPORT;
 	}
 
 	return -EINPROGRESS;
diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
index 4936fdb76c72..dc772b5ff9e3 100644
--- a/drivers/sysreset/sysreset_x86.c
+++ b/drivers/sysreset/sysreset_x86.c
@@ -87,7 +87,7 @@ static int x86_sysreset_request(struct udevice *dev, enum sysreset_t type)
 			return ret;
 		return -EINPROGRESS;
 	default:
-		return -ENOSYS;
+		return -EPROTONOSUPPORT;
 	}
 
 	outb(value, IO_PORT_RESET);
diff --git a/test/dm/sysreset.c b/test/dm/sysreset.c
index 691683c56740..5aa69e046186 100644
--- a/test/dm/sysreset.c
+++ b/test/dm/sysreset.c
@@ -27,8 +27,8 @@ static int dm_test_sysreset_base(struct unit_test_state *uts)
 	/* Device 1 is the warm sysreset device */
 	ut_assertok(uclass_get_device(UCLASS_SYSRESET, 1, &dev));
 	ut_asserteq(-EACCES, sysreset_request(dev, SYSRESET_WARM));
-	ut_asserteq(-ENOSYS, sysreset_request(dev, SYSRESET_COLD));
-	ut_asserteq(-ENOSYS, sysreset_request(dev, SYSRESET_POWER));
+	ut_asserteq(-EPROTONOSUPPORT, sysreset_request(dev, SYSRESET_COLD));
+	ut_asserteq(-EPROTONOSUPPORT, sysreset_request(dev, SYSRESET_POWER));
 
 	state->sysreset_allowed[SYSRESET_WARM] = true;
 	ut_asserteq(-EINPROGRESS, sysreset_request(dev, SYSRESET_WARM));
@@ -36,7 +36,7 @@ static int dm_test_sysreset_base(struct unit_test_state *uts)
 
 	/* Device 2 is the cold sysreset device */
 	ut_assertok(uclass_get_device(UCLASS_SYSRESET, 2, &dev));
-	ut_asserteq(-ENOSYS, sysreset_request(dev, SYSRESET_WARM));
+	ut_asserteq(-EPROTONOSUPPORT, sysreset_request(dev, SYSRESET_WARM));
 	state->sysreset_allowed[SYSRESET_COLD] = false;
 	ut_asserteq(-EACCES, sysreset_request(dev, SYSRESET_COLD));
 	state->sysreset_allowed[SYSRESET_COLD] = true;

base-commit: e17d174773e9ba9447596708e702b7382e47a6cf
-- 
2.39.2

