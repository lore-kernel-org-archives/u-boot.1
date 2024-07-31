Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EDCC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 07:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA3B48898A;
	Wed, 31 Jul 2024 09:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="KbriYNdK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5464C88963; Wed, 31 Jul 2024 09:23:19 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C917688969
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 09:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1722410595; x=1725002595;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C1GvHX1DJtqjUBRhnfc8o5gpBQTGg85QYEj6xVnbiJI=;
 b=KbriYNdKlmd0xUNSQLU2YFnL+H2Gt3R6E5PAQYJaHvOY3Em/pxjvdOb8/cN5kFDy
 yq7WYE5S4ji5scahaPXqs5nnQjAYbW4Lrp4kbNK4bQ/DAnQ4+JzKtH3xrtNMmm17
 lXY7W5lh2sr2ezlsH4WOvBUNFgwKdJddNPKeGCASvzY=;
X-AuditID: ac14000a-03e52700000021bc-ac-66a9e6635724
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 98.14.08636.366E9A66;
 Wed, 31 Jul 2024 09:23:15 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 31 Jul
 2024 09:23:15 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 31 Jul 2024 09:23:01 +0200
Subject: [PATCH 3/3] configs: phycore-imx8mp_defconfig: enable CMD_ERASEENV
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240731-wip-y-moog-phytec-de-imx8_eraseenv-v1-3-b8f0c4366399@phytec.de>
References: <20240731-wip-y-moog-phytec-de-imx8_eraseenv-v1-0-b8f0c4366399@phytec.de>
In-Reply-To: <20240731-wip-y-moog-phytec-de-imx8_eraseenv-v1-0-b8f0c4366399@phytec.de>
To: Teresa Remmet <t.remmet@phytec.de>, Fabio Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.0
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWyRpKBRzf52co0gz+v5C0eXvW3eLu3k92i
 +526A7PHzll32T3O3tnB6NHf3cIawBzFZZOSmpNZllqkb5fAlXFjyTTmggmsFVOObmNpYNzE
 0sXIySEhYCKxfM0T9i5GLg4hgSVMEvPuf2UESQgJPGSUmH5GEsRmE1CRePziHiuIzSKgKrF4
 3QkwW1jAW+LBqbtsIDavgKDEyZlPgIZycDALaEqs36UPEmYWkJfY/nYOM0RJqMSp1xOhxgPZ
 bb/ZQco5BcIkLj+JBTFFBLwkLv7ngeiMkLh2cwlYhYSAsETDP0WIRlmJF+d72SGOl5eYdu41
 M4QdKnFk02qmCYxCs5CcMwvhnFlIzlnAyLyKUSg3Mzk7tSgzW68go7IkNVkvJXUTIyiMRRi4
 djD2zfE4xMjEwXiIUYKDWUmEV+jkyjQh3pTEyqrUovz4otKc1OJDjNIcLErivKs7glOFBNIT
 S1KzU1MLUotgskwcnFINjO35597O9dfKSHukwHj/PVPpy1MW6+bKHzz09NSLpFzblcuOTbD9
 7lV1r+i/Z938iApjhnphw8og07xp4neXzLzJE69m3nI2I0Xa8lbRwevys1k976zmFeNaGZ6V
 aaYveFx3WpXky68Vd0/UFKQpCfh+ftZcs4nlwhY979eFk315J6xib38Zo8RSnJFoqMVcVJwI
 AK0CqxdRAgAA
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

Enable erasing environment with eraseenv command.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 configs/phycore-imx8mp_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 8dd4963bdc0..3ddceecf205 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -53,6 +53,7 @@ CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="u-boot=> "
 # CONFIG_CMD_EXPORTENV is not set
 # CONFIG_CMD_IMPORTENV is not set
+CONFIG_CMD_ERASEENV=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2

-- 
2.34.1

