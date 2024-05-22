Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071A9C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8745788872;
	Wed, 22 May 2024 16:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VC3wp4jh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00BEF87F4B; Wed, 22 May 2024 08:18:53 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E92888412
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716358731; x=1718950731;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sNGSr9TFQaZnuNOK89LL756w1dF47CF8LGyAghuWc5A=;
 b=VC3wp4jhgh4b+FfJK6C/YrOGBo/ZUq9w3HF4ZOJ1nQgtIZwYNWX+xfRWmSAk6SDG
 hSyotd5DdGHvDG3r0C0DS6ToyBDpzTpT9aLm7jwB7CzvQLCq6F04W6tw9nYVjUan
 SaOCnR5IilOIR3+JhHVc5MjnY0myZ5/q9Y5Dz1sAeoQ=;
X-AuditID: ac14000a-03e52700000021bc-70-664d8e4b9bcc
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 86.10.08636.B4E8D466;
 Wed, 22 May 2024 08:18:51 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 08:18:49 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 6/6] configs: phycore_am62x_a53_defconfig: Enable
 CONFIG_ENV_OVERWRITE
Date: Tue, 21 May 2024 23:18:27 -0700
Message-ID: <20240522061827.601699-7-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522061827.601699-1-d.schultz@phytec.de>
References: <20240522061827.601699-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWyRpKBR9e7zzfNoGspq8XbvZ3sFt3v1B2Y
 PM7e2cHo0d/dwhrAFMVlk5Kak1mWWqRvl8CVcep4esE/1opNj9+wNDDOY+1i5OSQEDCROLqi
 Ecjm4hASWMIksXRKHxuEc59R4vejt+wgVWwCWhJ3tsxlBrFFBMwkFq09D1TEwcEsoCHR/owJ
 JCwsECax+sAjZpAwi4CqxIvv5SBhXgFLibetn5ggdslLzLz0HWwip4CVxO3Z6xlBbCGgmq+v
 /7FD1AtKnJz5hAXEZgaqb946mxnClpA4+OIFM0S9gsTsbZMZYWZOO/eaGcIOldj6ZTvTBEah
 WUhGzUIyahaSUQsYmVcxCuVmJmenFmVm6xVkVJakJuulpG5iBIWuCAPXDsa+OR6HGJk4GA8x
 SnAwK4nwbtrimSbEm5JYWZValB9fVJqTWnyIUZqDRUmcd3VHcKqQQHpiSWp2ampBahFMlomD
 U6qBUXnlxtqNX/xerFif5X8k2PRzyPS+bpH+2QmNSxS2VV9MaJ3nvimlz/Ny3fIMtlvX+JQS
 FvFsY3ytZcxw6HfJz1VfFnTn1m5LWZHgUHzg+lOzV2f+dcx6brU4JqmlZscu+e39B+ssmnLD
 /ml8fadmspZh7pqa5/EzJ7TP7014uG9mj+q8C7r1h5VYijMSDbWYi4oTASTMTXRLAgAA
X-Mailman-Approved-At: Wed, 22 May 2024 16:50:43 +0200
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

Enable CONFIG_ENV_OVERWRITE to overwrite ethaddr in the environment.
This is required because our environment is not located in the
boot partition.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index fd36edc29dd..286cd89c5a6 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -59,6 +59,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
+CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NET_RANDOM_ETHADDR=y
-- 
2.25.1

