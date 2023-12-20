Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7DCC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36B40876B1;
	Wed, 20 Dec 2023 09:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Cco57kRq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 922BE876B1; Wed, 20 Dec 2023 09:45:44 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E1187630
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1703061940; x=1705653940;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XUOPcN9nuhwIJ6fhQKZ+PHdZCKmq2O7cCPHIFwnTHB0=;
 b=Cco57kRqCyCKURoQZ+P1JuPO6SL/xYbhkkL+vclLW9Y0j/PtnGIhLWsTeZQqUUOk
 hRXT/OfS0b+iHxoN1RN8izTr0hUuU7R8NkPRcgvyQ2SUcRS3XgKcZDl5tYK7bTDE
 DBy0LmHFIyZl80XK/c32KZvCuJk1f/tDzEGHny5I5rU=;
X-AuditID: ac14000a-fbefe7000000290d-e7-6582a9b4083d
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D5.E0.10509.4B9A2856;
 Wed, 20 Dec 2023 09:45:40 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Dec
 2023 09:45:40 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 20 Dec 2023 09:45:34 +0100
Subject: [PATCH v2 3/5] board: phytec: phytec_som_detection: fix
 eeprom_data zero check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-3-516abadb4f49@phytec.de>
References: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-0-516abadb4f49@phytec.de>
In-Reply-To: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-0-516abadb4f49@phytec.de>
To: Fabio Estevam <festevam@gmail.com>
CC: Teresa Remmet <t.remmet@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWyRpKBR3fLyqZUg5Z+KYuHV/0t3u7tZLfo
 fqfuwOyxc9Zddo+zd3YwevR3t7AGMEdx2aSk5mSWpRbp2yVwZZz938VWcI+jYtGKJpYGxnns
 XYycHBICJhIzd2wGsrk4hAQWM0kcbO1hhnAeMkpcWdnNDFLFJqAi8fjFPVYQm0VAVeL+8teM
 ILawQKTEjX+dYHFeAUGJkzOfsHQxcnAwC2hKrN+lDxJmFpCX2P52DjNESYrEj3WvwBYLAdln
 +u6BjeEUSJVY8u40O0iriICaxOl5UK01ElPvw9wpLNG+6BYTRKusxIvzvVBxeYlp514zQ9ih
 Ekc2rWaawCg0C8lBsxAOmoXkoAWMzKsYhXIzk7NTizKz9QoyKktSk/VSUjcxgoJZhIFrB2Pf
 HI9DjEwcjIcYJTiYlUR493Y2pQrxpiRWVqUW5ccXleakFh9ilOZgURLnXd0RnCokkJ5Ykpqd
 mlqQWgSTZeLglGpgFOG1eX7++FMGEWdjht88Uou/Ty0/kCsWcfHBPs9Pxjfnn4u2OGQ54dNE
 AVf2yukCj5kWnFqyresdnwxPZPEJx9j6rFvhufxNmsX161oaMjes2D6VP2kaW8f0Yy9bpzxI
 Tu3eesj5xeRUgbXF36JdJF5vj/3zLi33xorJz5S97UJ7rp0T+3vMRYmlOCPRUIu5qDgRADmy
 yzpUAgAA
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

In phytec_eeprom_data_init, after reading eeprom data into buffer, it is
checked whether all bytes are 0x0 by iterating over chunks of the
buffer. The offset, or index of the chunk, was never changed, leading to
repeated comparison of only the first chunk. Use array notation and
access chunk via array index to compare all chunks of the buffer.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 55562731270..724b8e844b6 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -83,8 +83,8 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 	}
 
 	ptr = (int *)data;
-	for (i = 0; i < sizeof(struct phytec_eeprom_data); i += sizeof(ptr))
-		if (*ptr != 0x0)
+	for (i = 0; i < sizeof(struct phytec_eeprom_data); i++)
+		if (ptr[i] != 0x0)
 			break;
 
 	if (i == sizeof(struct phytec_eeprom_data)) {

-- 
2.34.1

