Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2ADC54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 06:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C02387E02;
	Wed, 13 Mar 2024 07:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0C2D87DFF; Wed, 13 Mar 2024 07:53:39 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74EAA865D0
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 07:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42D6rMGd047843;
 Wed, 13 Mar 2024 14:53:22 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Wed, 13 Mar 2024 14:53:20 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <seanga2@gmail.com>, <marex@denx.de>
Subject: [PATCH 1/1] spl: Improve error message for SPL memory allocation
Date: Wed, 13 Mar 2024 14:53:15 +0800
Message-ID: <20240313065315.118326-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42D6rMGd047843
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

There could be two memory allocation scheme in SPL phase.
Explicitly print the corresponding error message.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 common/spl/spl_fit.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 872df0c0fe..e5195d460c 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -550,7 +550,12 @@ static void *spl_get_fit_load_buffer(size_t size)
 	buf = malloc_cache_aligned(size);
 	if (!buf) {
 		pr_err("Could not get FIT buffer of %lu bytes\n", (ulong)size);
-		pr_err("\tcheck CONFIG_SPL_SYS_MALLOC_SIZE\n");
+
+		if (IS_ENABLED(CONFIG_SPL_SYS_MALLOC))
+			pr_err("\tcheck CONFIG_SPL_SYS_MALLOC_SIZE\n");
+		else
+			pr_err("\tcheck CONFIG_SPL_SYS_MALLOC_F_LEN\n");
+
 		buf = spl_get_load_buffer(0, size);
 	}
 	return buf;
-- 
2.34.1

