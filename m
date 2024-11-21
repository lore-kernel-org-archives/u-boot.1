Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F43D75BB9
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B0CE89678;
	Thu, 21 Nov 2024 06:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166781;
	bh=8U6ImE8BxUlE67+byrp9+zyRafgyuXWhTs2faD0w6YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AgHzEVQQ2MCjPnqxpHMlKu8CH6JtB1Y7BrgC1sz3PMX0iphchfReSqoEd2GHDzJ0F
	 i81fRvMQQ+W2WSs/mGfnt6cB4DgXJ2Sbeq4Zym8XpdUdUNjc4WYAZFtYwG2YKeUKBd
	 Om+2BAa6UNWxYW/7vjXl5gwoxjt1rVFUfnEfFVltwJW6ro2lOjAdwDbjJGOwMjrvdF
	 ZmKAK6G71XVn79F5y/Epl5eRGi0wkeRf0c9ozFdUXGp9i92errpEuiQGbLRxl4Qxpt
	 ZSlTTrItZ8Lymhd6bnoGCpBpTJwtQ4ZhKH4/j428ykETzu7OZnFpUfF9B9Te50LOgl
	 hrrafuC3jiBEA==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 46BE589678;
 Thu, 21 Nov 2024 06:26:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166776;
 bh=8U6ImE8BxUlE67+byrp9+zyRafgyuXWhTs2faD0w6YU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T92p/tzTzAf1k38Mi2F3wyGVELtIOhwpbN7OUlBAzOCEdMajjmvfWVK3mF38xMmJm
 QWXPRiiJnfrDXtaR+IA5Yo79/aafCf0pkX3yGTxr/1UnQE6Pe3fTT0Q1KhR+v4RPRp
 GGMM/TyCuDiCttDiNtMt0PNcBrTz1CxM5Z/6XiHKniBtodfIVvnGoFt6w3mliEbOTY
 3TLLLouJez4WE9g1LBscXwfhx/Xh5IbXOoSJrc1I/IgPb+wvMcgpB8Bd+tp9VO5PS6
 q1f4KgQwIoNDBLPunSkhQo1onpi1xIDkKEg/Bj+MAyHkEsp6N8jgjWbaBEauxXm6Q5
 zDMBo4FEIZWIg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 08/20] siemens: capricorn: use DCD_SKIP entry
Date: Thu, 21 Nov 2024 06:25:49 +0100
Message-Id: <20241121052601.72880-9-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
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

Boards which use DCD data in SCFW can drop SPL.

We tried in our mainline rework to use this approach
too as other imx8qxp boards do in mainline. But we
failed ... it was a hard way to understand the
reason!

We cannot use DCD image in container as the SCFW
from siemens, does the RAM init on boot itself!

Siemens SCFW reads the RAM config from i2c eeprom and
dependent on this settings, initializes the RAM.

Adding DCD data to the bootcontainer will result in
hang of the SCFW, also DCD data in container image is
static which do not fit our needs.

So we must drop DCD data image, and this has the side
effect that we need SPL, as the task which loads the images
from the container only loads the images to addresses,
and if executed bit is set, starts them.

As now RAM is not initialized from it, and there is no
option to "wait until SCFW has setup RAM",  we can only
load SPL into internal RAM at this point, as than SPL
and SCFW boot parallel.

The SPL itself then uses the SCU API to communicate
with the SCFW and it seems that SCFW only responds to
this API requests when RAM setup is already done by the
SCFW, which has a side-effect of a "sync" for the RAM
setup is done by SCFW!

We checked if SPL is always save in accessing RAM for
loading images to it! For tests, we added in our RAM
init part in the SCFW long delays (10 seconds and more)
as we thought there is such a sync missing, and we can
break the board through delaying RAM setup... but we
did not managed to fail booting U-Boot from SPL!

Signed-off-by: Heiko Schocher <hs@denx.de>

---

(no changes since v2)

Changes in v2:
- add comment from Walter
  fix typo: than -> then

 board/siemens/capricorn/imximage.cfg | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/siemens/capricorn/imximage.cfg b/board/siemens/capricorn/imximage.cfg
index 4350e2967cc..e45f2c9589e 100644
--- a/board/siemens/capricorn/imximage.cfg
+++ b/board/siemens/capricorn/imximage.cfg
@@ -9,6 +9,10 @@
 
 /* Boot from SD, sector size 0x400 */
 BOOT_FROM	sd
+
+/* skip DCD data, as firmware initializes the RAM */
+DCD_SKIP true
+
 /* SoC type IMX8QX */
 SOC_TYPE IMX8QX
 /* Append seco container image */
-- 
2.20.1

