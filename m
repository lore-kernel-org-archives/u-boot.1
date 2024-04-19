Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8C2C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45E3887CD;
	Fri, 19 Apr 2024 18:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="obgZmm0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53914886C1; Fri, 19 Apr 2024 17:56:05 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E5C088771
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713542158; x=1716134158;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HTOLsz3eHuPPxQpNm2Jx2yWT/wVT1buvk147hvAWspE=;
 b=obgZmm0Wok81PNJbDt/DSRSdguut/x91NiI6EO4ujd3y16wv9NOULg/e10JQw/8a
 4o7IqTF3pra3upFk0BxXd8E4slsV3ldqINZLHnP9g1RUdx7UDtpI9pydNLmgTM+m
 8fqcCiiKUJOSuL0mpB6267qESUFdqII0Uo9rMTH4bKE=;
X-AuditID: ac14000a-fadff7000000290d-73-6622940e739b
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id AC.38.10509.E0492266;
 Fri, 19 Apr 2024 17:55:58 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 19 Apr
 2024 17:55:56 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 4/5] board: phytec: common: Fix eepom is empty check
Date: Fri, 19 Apr 2024 08:55:39 -0700
Message-ID: <20240419155540.2447006-5-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419155540.2447006-1-d.schultz@phytec.de>
References: <20240419155540.2447006-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWyRpKBR5dvilKawaHvYhZv93ayOzB6nL2z
 gzGAMYrLJiU1J7MstUjfLoEr49u3NYwF17kqNl3/zNrAeIuji5GTQ0LARKL/yFKmLkYuDiGB
 JUwSu+4fZYNw7jNKrPn6jhGkik1AS+LOlrnMILaIgJTEy86NQDYHB7OAhkT7MyaQsLCAi8T5
 6+vBbBYBVYlN92+wgNi8AlYS+9b8YIFYJi8x89J3dhCbU8Ba4vv2L2AjhYBqzi8+zwZRLyhx
 cuYTsHpmoPrmrbOZIWwJiYMvXkDVK0jM3jaZEWbmtHOvmSHsUIkjm1YzTWAUmoVk1Cwko2Yh
 GbWAkXkVo1BuZnJ2alFmtl5BRmVJarJeSuomRlCwijBw7WDsm+NxiJGJg/EQowQHs5IIrxmH
 YpoQb0piZVVqUX58UWlOavEhRmkOFiVx3tUdwalCAumJJanZqakFqUUwWSYOTqkGRvudoVuW
 Rqg7qt5xCT528/u30vW52dXSfk4n9uiqxnzaZcyXM12U+5pm35r3386zWR1TVn9QfKSz4YjJ
 /lU75GQc99y+dEprnk4Ar56EdWl3p80iLS41xzIL2f3L81Nz7l6+eyOj/tNqlYmPupL/df/2
 fbyBd9mLy6WHTbImbP6cUfdvw9b2g0osxRmJhlrMRcWJAP3F+W1EAgAA
X-Mailman-Approved-At: Fri, 19 Apr 2024 18:22:18 +0200
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

The ptr variable is currently defined as int and sizeof
returns the size of the eeprom data struct as Byte (32 in total).

In case the eeprom is empty, the check, if the eeprom is empty,
will most likely stop after 8 iterations because it will continue
with the stack which should contain some data. Therefore, the
init function will detect an empty EEPROM as API0 and return with
the valid flag set to True.

Fixes: dc22188cdc8 ("board: phytec: Add common PHYTEC SoM detection")

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 5a4cc9e8b02..78c173df20d 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -53,7 +53,7 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 {
 	int ret, i;
 	unsigned int crc;
-	int *ptr;
+	u8 *ptr;
 	const unsigned int payload_size = sizeof(struct phytec_eeprom_payload);
 
 	if (!data)
@@ -85,7 +85,7 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 		goto err;
 	}
 
-	ptr = (int *)data;
+	ptr = (u8 *)data;
 	for (i = 0; i < payload_size; ++i)
 		if (ptr[i] != 0x0)
 			break;
-- 
2.25.1

