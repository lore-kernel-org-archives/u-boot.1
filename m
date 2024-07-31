Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7563EC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 07:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 258728897A;
	Wed, 31 Jul 2024 09:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="uIbRfMFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8322F88886; Wed, 31 Jul 2024 09:23:17 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA13088955
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
 bh=C/0LEyh7yGGhbMhbO55w3ESO6BiMTmaMB31HkPA5iSM=;
 b=uIbRfMFMB+rCSa85r3GJ+H12wXXC2F8ouJLYo8sqsDg0T+LR3KVciWUcrik06srS
 7ouzvo8M47+uDqQAr7LAVSSr4rKaXO+Ryq8pHy7bINmDJFvQOUy45l7Een2St19u
 qdt04Ork8BtpCbQZyS34L3G4N9Xu3kfChfEeuul7u6s=;
X-AuditID: ac14000a-03e52700000021bc-aa-66a9e66379f1
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 18.14.08636.366E9A66;
 Wed, 31 Jul 2024 09:23:15 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 31 Jul
 2024 09:23:15 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 31 Jul 2024 09:22:59 +0200
Subject: [PATCH 1/3] configs: imx8mm-phygate-tauri-l_defconfig: enable
 CMD_ERASEENV
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240731-wip-y-moog-phytec-de-imx8_eraseenv-v1-1-b8f0c4366399@phytec.de>
References: <20240731-wip-y-moog-phytec-de-imx8_eraseenv-v1-0-b8f0c4366399@phytec.de>
In-Reply-To: <20240731-wip-y-moog-phytec-de-imx8_eraseenv-v1-0-b8f0c4366399@phytec.de>
To: Teresa Remmet <t.remmet@phytec.de>, Fabio Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.0
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWyRpKBRzf52co0gynzBCweXvW3eLu3k92i
 +526A7PHzll32T3O3tnB6NHf3cIawBzFZZOSmpNZllqkb5fAlfFt4SGWgh2sFS+vNzE3MN5i
 6WLk5JAQMJE4OfMwUxcjF4eQwBImiZZ1m9lAEkICDxklpp+RBLHZBFQkHr+4xwpiswioSpza
 e4oZxBYWCJVYerkTbBCvgCDQoCdANgcHs4CmxPpd+iBhZgF5ie1v5zBDlIRK3JoxlQlifKjE
 qbbf7CDlnAJhEpefxIKYIgJeEhf/80B0Rkhcu7kErEJCQFii4Z8iRKOsxIvzvewQx8tLTDv3
 mhnCDpU4smk10wRGoVlIzpmFcM4sJOcsYGRexSiUm5mcnVqUma1XkFFZkpqsl5K6iREUxiIM
 XDsY++Z4HGJk4mA8xCjBwawkwit0cmWaEG9KYmVValF+fFFpTmrxIUZpDhYlcd7VHcGpQgLp
 iSWp2ampBalFMFkmDk6pBkZBnchdn8yihVK7GUufcLfoh6zfvVE/WG5D1hTR8p9n9Tkipp9R
 m7B+6kdH/yWn1jQ/mbbU2EnhTRwHU1KMbQcP//Tf967o823YeHbij0r9nulZbZczsgXSSuQi
 NoTNaYsqWLzNRoBHQIJRzeTRNdWIuQ3tuv61+07bff3nkHjF+Nd9ucn9M5RYijMSDbWYi4oT
 AURI7V5RAgAA
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
 configs/imx8mm-phygate-tauri-l_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index 41765f1ddc5..16ba7d4b4f1 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -46,6 +46,7 @@ CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="u-boot=> "
 # CONFIG_CMD_EXPORTENV is not set
 # CONFIG_CMD_IMPORTENV is not set
+CONFIG_CMD_ERASEENV=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2

-- 
2.34.1

