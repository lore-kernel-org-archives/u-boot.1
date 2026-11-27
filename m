Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D965606A32C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pZKwGgds;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=NvNmMOc9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCC2A40963;
	Fri, 27 Nov 2026 12:56:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VtH2-zYNu5fL; Fri, 27 Nov 2026 12:56:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 24B1B409F9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784195;
	b=G5utU6t5JYrO1xYIQrusYxK+XGdY+sccmI4TaAes6J0ySZLb2/f5D4rdBSCAC4TxatkA
	 uOKSbRo3fFMLvPJ6oLvRgBlWKgjf5BzeHvwo+Fn3qAtngOJJI47aN28Kk/+ddPfHu7gQx
	 u0EdZkKKKOjpTqwPLkZnjOs1CF2UqE4IvYxXx50UVLW2nh00CMzKvFSgsGoRXLfIxdcJt
	 Yq8iKu8aj7c7hRu/H2bAYVFhdv85XQU97n+hLXmA9SxoKqFE5a/OScZWSQ4dwZZco5ppf
	 DNbm6Bspl6XiDn5hdqJrH2cc7WL6KUwDCMnHqH8PuPK6T0sZD0MVH9VhxGIHNJfmwdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784195;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rgv02hZOtEcAdCxhzxbTmR0EyiuxYkW02pONlLBHjRE=;
	b=YR8Al+jDxhnBnCGkfaWME1M4xYnyei8B1k+yYiykY6Y4oF7RA8gsv+OaBMyY6Q2o7BHm
	 RpzZETrfV6qQ0fwbnOBuWKV3BNFHuTWfChlpze3Q3dU/tvKxszJCSE0daZfCaOSG3sA7T
	 pv7HtrPImLdINOcpkp5vVKeCP+PSsX6GIOrhNNgIfEnlRrnD3yr31mDJOyEFqLQSdjCuH
	 NUiDd9Ht7o9jUxMRxAKufnXt9brFjmr7wfkt+eyMR3YOYLgGjlO0WcWObzBCvaCMIN12Q
	 2b71fNIsCFfC3gJZnkRyLrw32eAbEwgxnAECLDKlpXPj9k4xyoggTkUSvUIDVa/p23g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784195;
	bh=rgv02hZOtEcAdCxhzxbTmR0EyiuxYkW02pONlLBHjRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pZKwGgdsmUOlpM9nmUaF2JVNEX5PrchVJOVal4vah176KydUWyt5Cs6cmMUCP8wcC
	 CzfwyzHbg1tTQ4FNcl+DWoFa0iQhnvsuDUMvAMa5+9CNzupVNMxVMSslwSQeHJldgA
	 BukGKAt4QfnqlbMcu8OBB30GyCs3bzlJk4lcbiH4e3Kn/v4s+Ooc1q83AQu5/A84+D
	 95oY2fJXpohbp4t0ocJGDXfzpEsz2gUotn5Yrrgc8kFN/UZo4sQ+29EBzWr5AulE54
	 kI3Sak76kiUfz8adHUd61DvjXAhfY6Y9ks1m9H3y6zy+P8KaL6Z920aG8kdEsXNDSm
	 DmE+kld4mlwVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24B1B409F9;
	Fri, 27 Nov 2026 12:56:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2EEE26D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A467340572
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1AbXW1SryJv7 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 12:56:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 54F0E4004D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=NvNmMOc9
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54F0E4004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=rgv02hZOtEcAdCxhzxbTmR0EyiuxYkW02pONlLBHjRE=; b=NvNmMOc9FLAtfMN279P5SHNoY6
 UvuKWB9JKLSIfxif+WZ8vv4L/08gIci0+J3yOvRoIdakVs2Ve3TrQaQuF4o3SoObDv3Jf1VBnaXrM
 3NDgG0gvoyR9qxYejh0Lf3dox71aqhCYKNgbZYulz+32JKmQyugRCkldh8RRF36H6Ugmgo3vdaqFP
 sC+VaDxCvJ3WV40HV8nWjgH2oyjzaEiIjvPZyUEm9/juguDw2Au6yOGK+4ySd27s5KI6FW6FLGlGY
 JBfQmHUuaPkGcRJQgr8aXdcb/dtX8tiAFc9WNZEYeG8rg8qu3qdX0wgk8O3lcNUO7f1kxujLGZhQn
 QnckeXKQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWvV2-0006GY-1y; Fri, 27 Nov 2026 13:56:24 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWvV1-0003Uw-35; Fri, 27 Nov 2026 13:56:23 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Fri, 27 Nov 2026 13:56:21 +0100
Subject: [PATCH v2 1/6] configs: tqma6: rename .defconfig to .config
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-update-tqma6-v2-1-3465ac0d32eb@ew.tq-group.com>
References: <20261127-update-tqma6-v2-0-3465ac0d32eb@ew.tq-group.com>
In-Reply-To: <20261127-update-tqma6-v2-0-3465ac0d32eb@ew.tq-group.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Adam Ford <aford173@gmail.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.14.3
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make it easier to distinguish between usable board configurations
and shared configurations used by multiple boards.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 configs/{tqma6_mba6_common.defconfig => tqma6_mba6_common.config} | 2 +-
 configs/{tqma6_mba6_mmc.defconfig => tqma6_mba6_mmc.config}       | 0
 configs/{tqma6_mba6_spi.defconfig => tqma6_mba6_spi.config}       | 0
 configs/tqma6dl_mba6_mmc_defconfig                                | 4 ++--
 configs/tqma6dl_mba6_spi_defconfig                                | 4 ++--
 configs/tqma6q_mba6_mmc_defconfig                                 | 4 ++--
 configs/tqma6q_mba6_spi_defconfig                                 | 4 ++--
 configs/tqma6s_mba6_mmc_defconfig                                 | 4 ++--
 configs/tqma6s_mba6_spi_defconfig                                 | 4 ++--
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/configs/tqma6_mba6_common.defconfig b/configs/tqma6_mba6_common.config
similarity index 100%
rename from configs/tqma6_mba6_common.defconfig
rename to configs/tqma6_mba6_common.config
index 6865d3b2641..415589db03e 100644
--- a/configs/tqma6_mba6_common.defconfig
+++ b/configs/tqma6_mba6_common.config
@@ -57,12 +57,12 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
-CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_FEC_MXC=y
 CONFIG_RGMII=y
 CONFIG_MII=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
 CONFIG_DM_PMIC=y
diff --git a/configs/tqma6_mba6_mmc.defconfig b/configs/tqma6_mba6_mmc.config
similarity index 100%
rename from configs/tqma6_mba6_mmc.defconfig
rename to configs/tqma6_mba6_mmc.config
diff --git a/configs/tqma6_mba6_spi.defconfig b/configs/tqma6_mba6_spi.config
similarity index 100%
rename from configs/tqma6_mba6_spi.defconfig
rename to configs/tqma6_mba6_spi.config
diff --git a/configs/tqma6dl_mba6_mmc_defconfig b/configs/tqma6dl_mba6_mmc_defconfig
index 06166cb7da5..f16d8e484ac 100644
--- a/configs/tqma6dl_mba6_mmc_defconfig
+++ b/configs/tqma6dl_mba6_mmc_defconfig
@@ -1,5 +1,5 @@
-#include <configs/tqma6_mba6_common.defconfig>
-#include <configs/tqma6_mba6_mmc.defconfig>
+#include <configs/tqma6_mba6_common.config>
+#include <configs/tqma6_mba6_mmc.config>
 
 CONFIG_MX6DL=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
diff --git a/configs/tqma6dl_mba6_spi_defconfig b/configs/tqma6dl_mba6_spi_defconfig
index f22ea543042..fcc03ad491d 100644
--- a/configs/tqma6dl_mba6_spi_defconfig
+++ b/configs/tqma6dl_mba6_spi_defconfig
@@ -1,5 +1,5 @@
-#include <configs/tqma6_mba6_common.defconfig>
-#include <configs/tqma6_mba6_spi.defconfig>
+#include <configs/tqma6_mba6_common.config>
+#include <configs/tqma6_mba6_spi.config>
 
 CONFIG_MX6DL=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
diff --git a/configs/tqma6q_mba6_mmc_defconfig b/configs/tqma6q_mba6_mmc_defconfig
index 2d3fcbccc14..05fad3d82f4 100644
--- a/configs/tqma6q_mba6_mmc_defconfig
+++ b/configs/tqma6q_mba6_mmc_defconfig
@@ -1,5 +1,5 @@
-#include <configs/tqma6_mba6_common.defconfig>
-#include <configs/tqma6_mba6_mmc.defconfig>
+#include <configs/tqma6_mba6_common.config>
+#include <configs/tqma6_mba6_mmc.config>
 
 CONFIG_MX6Q=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-mba6b"
diff --git a/configs/tqma6q_mba6_spi_defconfig b/configs/tqma6q_mba6_spi_defconfig
index 5d61d097eec..7af41523c2d 100644
--- a/configs/tqma6q_mba6_spi_defconfig
+++ b/configs/tqma6q_mba6_spi_defconfig
@@ -1,5 +1,5 @@
-#include <configs/tqma6_mba6_common.defconfig>
-#include <configs/tqma6_mba6_spi.defconfig>
+#include <configs/tqma6_mba6_common.config>
+#include <configs/tqma6_mba6_spi.config>
 
 CONFIG_MX6Q=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-mba6b"
diff --git a/configs/tqma6s_mba6_mmc_defconfig b/configs/tqma6s_mba6_mmc_defconfig
index 323f582e874..23d2a75e55b 100644
--- a/configs/tqma6s_mba6_mmc_defconfig
+++ b/configs/tqma6s_mba6_mmc_defconfig
@@ -1,5 +1,5 @@
-#include <configs/tqma6_mba6_common.defconfig>
-#include <configs/tqma6_mba6_mmc.defconfig>
+#include <configs/tqma6_mba6_common.config>
+#include <configs/tqma6_mba6_mmc.config>
 
 CONFIG_MX6S=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
diff --git a/configs/tqma6s_mba6_spi_defconfig b/configs/tqma6s_mba6_spi_defconfig
index 9701d35cfb8..4e674fe6634 100644
--- a/configs/tqma6s_mba6_spi_defconfig
+++ b/configs/tqma6s_mba6_spi_defconfig
@@ -1,5 +1,5 @@
-#include <configs/tqma6_mba6_common.defconfig>
-#include <configs/tqma6_mba6_spi.defconfig>
+#include <configs/tqma6_mba6_common.config>
+#include <configs/tqma6_mba6_spi.config>
 
 CONFIG_MX6S=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"

-- 
2.53.0

