Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BB0CED62A
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 08:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A56FC8905E;
	Wed,  9 Oct 2024 10:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9595D89161; Wed,  9 Oct 2024 10:49:45 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 586AD88CC5
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 10:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 4998nIAj088161
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 9 Oct 2024 16:49:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 16:49:18 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <agust@denx.de>, <trini@konsulko.com>, <lekkit@at.encryp.ch>,
 <pbrobinson@gmail.com>, <caleb.connolly@linaro.org>, LekKit
 <50500857+LekKit@users.noreply.github.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>
Subject: [PATCH v2 1/1] video: simplefb: Fix build warn with CONFIG_FDT_64BIT=n
Date: Wed, 9 Oct 2024 16:48:28 +0800
Message-ID: <20241009084828.864091-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4998nIAj088161
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

From: LekKit <50500857+LekKit@users.noreply.github.com>

Fix compile warning with !CONFIG_FDT_64BIT by
casting the variable in the debug print.

Signed-off-by: Eva Kurchatova <lekkit@at.encryp.ch>
Reported-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 drivers/video/simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index cb518b149c..55996c8560 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -27,7 +27,7 @@ static int simple_video_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	debug("%s: base=%llx, size=%llu\n", __func__, base, size);
+	debug("%s: base=%llx, size=%llu\n", __func__, (unsigned long long)base, (unsigned long long)size);
 
 	/*
 	 * TODO is there some way to reserve the framebuffer
-- 
2.34.1

