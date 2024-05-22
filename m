Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72A8C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E856988876;
	Wed, 22 May 2024 16:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="t6ElYt6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CCDC88113; Wed, 22 May 2024 09:21:18 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE748880CC
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716362476; x=1718954476;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Du7ODFweqzcBAfnUoh4myoppKeRPwPXCmA8NmxDXlTg=;
 b=t6ElYt6OpZIc09t07h5Ih5/Ph0UTv6PV0soBtgjqgfHfv/W8MtZ5yb35SRqHZTW4
 l6VTcelMGQ5XGPJ4x5hIUOEtu/5Zx2OhcN6MlPMNSnFIZ0VHYltbQYK+y6pIKlKp
 Ofm9ul3I6m0OnK4wB6cKgYBny4eEdHL5UeLyfOeTnMM=;
X-AuditID: ac14000a-03251700000021bc-be-664d9cec4c57
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 60.C0.08636.CEC9D466;
 Wed, 22 May 2024 09:21:16 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 09:21:15 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>,
 <kory.maincent@bootlin.com>, <trini@konsulko.com>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH] include: extension_board: Increase overlay file name size
Date: Wed, 22 May 2024 00:21:00 -0700
Message-ID: <20240522072100.602612-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWyRpKBR/fNHN80g7MNqhY9k36xWkydtJnd
 4u3eTnaL7nfqDiwe89ZUe7w6sIrd4+ydHYwe/d0trAEsUVw2Kak5mWWpRfp2CVwZr/YeZSrY
 z1rxquUKewPjMZYuRk4OCQETiUkr5zN3MXJxCAksYZKYuXcylHOfUaJ9aS8bSBWbgJbEnS1z
 mUFsEYFsiWtNh1i7GDk4mAU0JNqfMYGEhQW8JE5seQw2lEVAVaJ9w2Iwm1fAUmJ/821WiGXy
 EjMvfWeHiAtKnJz5BKyGGSjevHU2M4QtIXHwxQswW0hAQWL2tsmMML3Tzr1mhrBDJbZ+2c40
 gVFgFpJRs5CMmoVk1AJG5lWMQrmZydmpRZnZegUZlSWpyXopqZsYQUErwsC1g7FvjschRiYO
 xkOMEhzMSiK8m7Z4pgnxpiRWVqUW5ccXleakFh9ilOZgURLnXd0RnCokkJ5YkpqdmlqQWgST
 ZeLglGpgbLOvVM/dcDgy/LDHFo/iPxJPnk2fJVnF8vRSzZp5PcX5O6Qeuvn8q01YPDOwn3fy
 h+zN/xeWOdubfpSI/f549heFqSpv4jeIT3oksfe9Sv+VFYU85mKl7GENP/VrOUuENUxPRVzT
 aXz88WJh9f8YzXvMR9dmTGs/2BJd90lrdZ7i16+rQzJFlViKMxINtZiLihMBXbiw5EgCAAA=
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

Upstream overlays like the ARM64 TI
k3-am625-beagleplay-csi2-tevi-ov5640.dtso can easily have more then
32 characters. Increase the overlay length to 64 characters to
apply overlays with longer names.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/extension_board.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/extension_board.h b/include/extension_board.h
index 87d404c0074..22e4104bc54 100644
--- a/include/extension_board.h
+++ b/include/extension_board.h
@@ -14,7 +14,7 @@ struct extension {
 	char name[32];
 	char owner[32];
 	char version[32];
-	char overlay[32];
+	char overlay[64];
 	char other[32];
 };
 
-- 
2.25.1

