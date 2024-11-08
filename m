Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCFFD5E12A
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE639890C1;
	Fri,  8 Nov 2024 06:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043319;
	bh=4trGqbnJm4LKdD6/J7Q0uGak99oZnideYCn4NKU6uog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WKI9hThZroBx30UYw+CXf0K1CklgFsYX+whsiDpJU4Jtv8Sg++nCZ4pxcsxsn5q4C
	 J++/rga5zHYs1DlVBsH7oGylEGbDpHjyn/qRA/I4WaMyBLiVF9XF+gFy8f+3a9MgwD
	 xRk+iy0m+p7K4IFM9c7s0oIw+1CUjNBUa3lv7Qo2mW14uNY00ytVbjM+aOMA+9+U+u
	 ccK7XsX6yAv1NkDPz94kfGG52TvfjHtgVN/+SaFWaaprxBWv7j5gSKFmisBa2i/SC7
	 lgaJKSFxERyE6c7wqqmuNIs2CnU49nOHRePLe3Qdhc6zs3t8fkk/bMIiKgvcbGhs76
	 HbGb/ottYNcpg==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 80F7288EC6;
 Fri,  8 Nov 2024 06:21:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043319;
 bh=4trGqbnJm4LKdD6/J7Q0uGak99oZnideYCn4NKU6uog=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hQv0RkIASLz2Txq1KGablFjJvIatlWt+pemHUo/EVYAy27VtvoFA4J0jPadSzVaXd
 LL6TgiwZZncEQ6yxxyTTOO9fQtGXgFRdajsQAP9/W88hxMcaP+b2BRfmvrITfLZ3em
 l2jff3ybPmKtWmdePRAGaaVd6/xqXCAbYzeCcH4YkyLepb67oIlM4cLQ4eOvcV2BtD
 jvWWsOgRwOPD+mZtNM4R721btuXmGTY+xk9RzrOUX0n9diZC0oGxDTI1dzUbhmXK6d
 KbqsB7wLixU8SayHOyWtCDhgsA+4Se+d1sRk5hBWkluiLmIS823l4HjcK/EPMA37CZ
 iAywH691O+UUQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 08/22] siemens: capricorn: use DCD_SKIP entry
Date: Fri,  8 Nov 2024 06:21:29 +0100
Message-Id: <20241108052143.26874-9-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241108052143.26874-1-hs@denx.de>
References: <20241108052143.26874-1-hs@denx.de>
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

The SPL itself than uses the SCU API to communicate
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

