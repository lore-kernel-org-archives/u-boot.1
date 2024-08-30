Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BA6CA0EF7
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE5CA88D7D;
	Fri, 30 Aug 2024 11:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="B7fJeYLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A5788D91; Fri, 30 Aug 2024 11:10:11 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99DCC88D74
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725009009; x=1727601009;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=56XWj55qUbPpDC92RodHaT9PpdclmnWtmLgMAEtaOmo=;
 b=B7fJeYLojmgwfwteFgErIx0jKhLv1kpx2kHVVJkr5hxN+08N0OmMQHR3N2R2/fBq
 Q9tyegCs+gKbxDQqcU0X3BcXBbW1R0hVb2feQB9bL413GwZcEMw7jNwHJnkAnpuA
 p5+yEa8zFnxMJF0KbOtEufRmyOI3XnS1goTArxyrnP8=;
X-AuditID: ac14000a-03251700000021bc-2f-66d18c71bb18
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3E.42.08636.17C81D66;
 Fri, 30 Aug 2024 11:10:09 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:10:07 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 08/13] configs: phycore_am62x_a53_defconfig: Make BOOTCMD
 generic
Date: Fri, 30 Aug 2024 02:09:35 -0700
Message-ID: <20240830090940.2592157-9-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWyRpKBR7ew52Kawf9GRYtPOx+zWkydtJnd
 4u3eTnaL7nfqDiwerw6sYvc4e2cHo0d/dwurx/Uz25kCWKK4bFJSczLLUov07RK4MnYfWsFU
 MIe9ovHMEuYGxmVsXYwcHBICJhLrbkh1MXJxCAksYZKYP/ciG4Rzn1Hi+sHvQA4nB5uAlsSd
 LXOZQWwRgSSJXU+WgcWZBVwkFt/4wApiCwsESky9NoERxGYRUJVoWPAUzOYVsJJY+3saO4gt
 ISAvMfPSdzCbU8BaYvPXB2C2EFDN8Wnn2CDqBSVOznzCAjFfXqJ562xmCFtC4uCLF8wQ9QoS
 s7dNZoSZOe3ca2YIO1TiyKbVTBMYhWYhGTULyahZSEYtYGRexSiUm5mcnVqUma1XkFFZkpqs
 l5K6iREU5iIMXDsY++Z4HGJk4mA8xCjBwawkwnvi+Nk0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK
 4ryrO4JThQTSE0tSs1NTC1KLYLJMHJxSDYzCPvcfMN5frDpn+4FLNc/nzj106qTk8c8L9ru+
 bNu5eOJUK4X5PV0Wd8/OWsZXY3LqdNykL3PPykzba6Pt8dB3rUir3TzOcEtOlkxDJq2s/q8S
 l/MrK5z+brqU8bPg4/ejmkVGwcKqR3peuIkEbN95Iidm8ol1Nc+O7Y3Z0hE+c6N2TUfEmdDz
 SizFGYmGWsxFxYkArxKxNWECAAA=
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

The phyCORE-AM62x board code sets an environment variable 'boot'
with the device U-Boot booted from. Use this variable in
CONFIG_BOOTCOMMAND to boot Linux from the same boot device by
default.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 39161b722b1..7bbd8011fa8 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -40,7 +40,7 @@ CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run mmcboot; bootflow scan -lb"
+CONFIG_BOOTCOMMAND="run ${boot}boot; bootflow scan -lb"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
-- 
2.25.1

