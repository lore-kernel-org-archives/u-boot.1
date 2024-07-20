Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA79C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 15:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488D0887FD;
	Sat, 20 Jul 2024 17:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721490857;
	bh=lbNEUaOhVM8BNGu60wu2rGQj8i/w27rFxPr4szOh+7o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Dg17rOwZaeKqgNXcHY850gsqJijHW5K2zuovKvbfX6XxzxbvahFxoMHjs466dfhq1
	 3eHs9PodBT71lGvf6jXdISruz82L8s3+70wSkSFr+1autD95hcckphVvwWzeyC+NG3
	 0func36bPAuk6gJbEYO8tLAjODTj8hei2pEYYP/yniz07hjq3Yb9L1ThNeQQx311/e
	 6MOdJcYwCHjUinl++I3+Guu1qXZ4BmR5bscYTB7nT3vjrudSsB+Mox6V0nd0YYrrpi
	 NSV/CA5wLfYIvBc3DDzHSp43AzSN0cIvQ5qw/7nTbdmM5G/wfW8ApPVEwfT9q3D7mp
	 eCnTrJ0Sgqwig==
Received: from crub.agik.hopto.org (p508b6272.dip0.t-ipconnect.de
 [80.139.98.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CF494884BE;
 Sat, 20 Jul 2024 17:54:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721490855;
 bh=lbNEUaOhVM8BNGu60wu2rGQj8i/w27rFxPr4szOh+7o=;
 h=From:To:Cc:Subject:Date:From;
 b=f8KUtv7O6TlhyP/EfJ28ko44LL6D9d1pGIObnLq83QORglOkYmH3pnUffgelMImm5
 eDxxITWRIFuypq+B2hICfLIpJ3/jwlPprbY0mJRRA0i0BX32To3grLLZ3l/ZtYM18T
 FIFIpZBktR1eeJdh9yTWVcty8n/Jt+dk46LqjoylL0C4wreu+5azHqrNX9XsChOLqc
 w0Z6c8p8NpnO4HGpZDwM/DbYVkomXGpfs1+VcTyaN67H7EhkvCjo95PdoMR5tQFhyz
 5YlU5+AlbP+c4YLokwTsI+fNWdCMm3D9E9IcnzdE/JfPL39/38VAG/RNFjfLwQ36Z1
 /zWFbIRQ3k9Cw==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH] kontron-sl-mx6ul: switch to DM_SERIAL
Date: Sat, 20 Jul 2024 17:54:00 +0200
Message-Id: <20240720155400.3576137-1-agust@denx.de>
X-Mailer: git-send-email 2.25.1
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

Enable DM_SERIAL to avoid board removal warning.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx6ul_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index 12d96b674c..f295ecfe4b 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -90,6 +90,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_CONS_INDEX=4
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
-- 
2.25.1

