Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B344C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACC358761C;
	Wed, 20 Dec 2023 09:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="gzGLFko8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 275558761C; Wed, 20 Dec 2023 09:20:06 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85EB3875B6
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:20:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1703060402; x=1705652402;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iWYNZNY5vtceoidwOOSiYrX63YoeUZSjfNlwvuqNVoc=;
 b=gzGLFko8z2kxgtk9UeD7YcnP5PQuX7cl/THL927g21lxd0zqHB71Neq8KWbJEml3
 V7UJEn7xovpeLDze8folKXK0RsVkKxrX67NAYaPIpJBexh+HEWgwrOPUgdJnD/cf
 eLXmRmQTKUrDXf1IgcHIcakm0NlsFvxtAhEmy1OBeWU=;
X-AuditID: ac14000a-fbefe7000000290d-47-6582a3b273d9
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id BE.A0.10509.2B3A2856;
 Wed, 20 Dec 2023 09:20:02 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Dec
 2023 09:20:02 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 20 Dec 2023 09:19:34 +0100
Subject: [PATCH 2/4] board: phytec: imx8m_som_detection: fix uninitialized
 pointer bug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v1-2-c24f3239b4c3@phytec.de>
References: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v1-0-c24f3239b4c3@phytec.de>
In-Reply-To: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v1-0-c24f3239b4c3@phytec.de>
To: Fabio Estevam <festevam@gmail.com>
CC: Teresa Remmet <t.remmet@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWyRpKBR3fT4qZUg03X5SweXvW3eLu3k92i
 +526A7PHzll32T3O3tnB6NHf3cIawBzFZZOSmpNZllqkb5fAlXH+4jW2gr3sFW8/z2ZqYJzC
 1sXIySEhYCKxeOYnli5GLg4hgcVMEicPbGWHcB4ySnw89x2sik1AReLxi3usIDaLgKrE5Rs3
 wWxhgQiJp9+a2UFsXgFBiZMznwBN4uBgFtCUWL9LHyTMLCAvsf3tHGaIkhSJ508ngNlCQPa/
 Y5PAbE6BVIlzq1exg7SKCKhJnJ4H1VojMfX+PHaIO4Ul2hfdYoJolZV4cb4XKi4vMe3ca2YI
 O1Ri65ftTBMYhWYhOWgWwkGzkBy0gJF5FaNQbmZydmpRZrZeQUZlSWqyXkrqJkZQMIswcO1g
 7JvjcYiRiYPxEKMEB7OSCO/ezqZUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryrO4JThQTSE0tS
 s1NTC1KLYLJMHJxSDYwbdL6H3E3M2dM1iesZ57MJh6y+eRl8LluZrfLol+UzuZlLxB70r90e
 uunFjaiby4UK9xa+z/OvSf3rfDSdN6KRz4HvpsCiPT1FW/d48wYKbjJQveKkdbCgc6/ZpLKZ
 lypsQp/GpNxYvG3upjOHRaQYvKRN4qJV7zo6VP3OkX24YGJeTaeNn6kSS3FGoqEWc1FxIgAp
 7qO/VAIAAA==
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

Pointer in phytec_imx8m_detect was accessed without checking it first.
Fix this by moving the pointer check in front of any accesses.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/common/imx8m_som_detection.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/phytec/common/imx8m_som_detection.c b/board/phytec/common/imx8m_som_detection.c
index 45f5767c565..a229eae152d 100644
--- a/board/phytec/common/imx8m_som_detection.c
+++ b/board/phytec/common/imx8m_som_detection.c
@@ -28,13 +28,13 @@ int __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data)
 	char *opt;
 	u8 som;
 
+	if (!data)
+		data = &eeprom_data;
+
 	/* We can not do the check for early API revisions */
 	if (data->api_rev < PHYTEC_API_REV2)
 		return -1;
 
-	if (!data)
-		data = &eeprom_data;
-
 	som = data->data.data_api2.som_no;
 	debug("%s: som id: %u\n", __func__, som);
 

-- 
2.34.1

