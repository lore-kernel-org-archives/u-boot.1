Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2C7C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 16:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2F12879F8;
	Fri, 12 Jan 2024 17:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705075329;
	bh=sSW4odYKQ57hHP0TrmW6YLEFLAGVfR83OcdqHX+rV8c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KvvQKDm9myjU+ATpqVSMH1r0OPaPTMd9GTUPvJmYI+JrV6i6FKLhyQH7HxH9iOt99
	 H6G40gtHxFkgpSui1JKcfcu1ASkSdT5eWy6XoPJ3gDZA5AitSs3qp8q8tpgIpmItqF
	 QaWEqNROC09a+eKHnghdWiKtYeIAjCf08Nz0sCp+VgDl/U6uSnazCjBcyREn6FHBrn
	 jBVSr7BRzhndhu+78AVb8XPXrpgDX3/CFJflOCNP4S8Nkc/KCSJx2wpoLZ8ZJRCHcg
	 WpHK9ARWszY0kXSPXJNa4tkretLoMbQF7qH+fU8BYmun8vyDBu/ljq0vrMzHDIU91e
	 DzyoS6zFzRRXg==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6F9C1877CB;
 Fri, 12 Jan 2024 17:02:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705075328;
 bh=sSW4odYKQ57hHP0TrmW6YLEFLAGVfR83OcdqHX+rV8c=;
 h=From:To:Cc:Subject:Date:From;
 b=cVduGDCAjXPL2Ase0I3W82A7R8dNXk52bXWFM51FKoNhM9DeDgn+IHxzn5rMCDIL9
 eTeB8EjW3/c6sKm4CNmqiw+dBjRp1npPrnQM8A//4D0OHyBtn5WtDK8t31fruP1Q0g
 s+fVkmPtHrf78dYmx/T4rzFZ9FA2Bl6tSIuo7hkaqVYkMp+rbvbpVn5zvRJQXrKjgH
 wARnCYCwt543htyztygd4YUlkqFgXvIdwztaiF5zZMXtzpkm0ayGoPdbH1OH/wS94Y
 nL9+SdTwOjuX9xGKAHIkzZqA8qrsMiQcstmDTCNyLWD9SEeIjeYTvmgzp7B0v3Ei7k
 IciQ7MN0ed9gA==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] defconfig: xea: Change default spi-nor memory bus to 2
 (single binary)
Date: Fri, 12 Jan 2024 17:01:48 +0100
Message-Id: <20240112160148.2376535-1-lukma@denx.de>
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

After the re-sync with Linux kernel (v6.0) of the XEA DTS
(SHA1: 7d08ddd09b75e7a3c103cc0d0d3ed700287f268e) the alias
for SPI bus, to which SPI-NOR  memory is connected, has changed from
'spi3' to 'spi2'.

To be in sync with current u-boot's xea dts, the default bus number
(which allows running 'sf probe' without any extra parameters given)
has been adjusted.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---

 configs/imx28_xea_sb_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/imx28_xea_sb_defconfig b/configs/imx28_xea_sb_defconfig
index 0b3259866e..9872d35c1b 100644
--- a/configs/imx28_xea_sb_defconfig
+++ b/configs/imx28_xea_sb_defconfig
@@ -74,7 +74,7 @@ CONFIG_MMC_MXS=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
-CONFIG_SF_DEFAULT_BUS=3
+CONFIG_SF_DEFAULT_BUS=2
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_SPANSION=y
-- 
2.39.2

