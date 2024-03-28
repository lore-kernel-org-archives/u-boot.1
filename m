Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33937C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B66870D2;
	Thu, 28 Mar 2024 16:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711640083;
	bh=zuKlxviXMsqIxjxA2oVFaMU0AikGTWgpSS6enQXnDaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Io7/4P+4vFKKePZVyro5f1kmSvgChvh1UrFZOXDtLkPrztcfFuY5RqtK/qqnJeVAI
	 stqScGvF+15c10rvarrbOolYpLlq5jLxm0GmO7/R6VizF0J7dy9zqWSDJLKYZ/CPtk
	 Shl2elzMxmkP/UyVb88enMEwtlfN7yQr52GcC7nWff5V/yOZBnUratPNzVkrgWYbOa
	 2YH9xah4J7Pq3jujGR8BxqhUqMZcEYXH6scKZLBrurqpRjsq0ZV+vtBvPQhCVidBMv
	 UX7+fJqaUC0x4x7PmIzhZNw+wobUbQZmy+uQs5Pd1o5LC41BGyzufDagaWJHOvShVW
	 H7B51MEBER4jg==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9964788172;
 Thu, 28 Mar 2024 16:34:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711640078;
 bh=zuKlxviXMsqIxjxA2oVFaMU0AikGTWgpSS6enQXnDaA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CuZlPY4vRuhuO3KEglgmXVOGuy6GoDcCFP7Ca8nVufRF2jgDKxM3ta6cmKE29WyI5
 DXwhRfALJqoYntJ7SEiIzXtD7R68XE3h/+8RjeXZRYMOZMZVzA1998CiNB3xMWTVxW
 Q8iaQiuci+noUqL/Jg8IiKqS3CTvkInbYJ+ag3Ewie8a4pGMVGvkFTyWveuyEApUg6
 CRDZbBRDoUhqlof8S05kU85CkJEuM7nj+08T0bjjuv0MU2ViukD+ABolwJbU8aabX+
 VbP3EzM+JrBhkNc5cQ6a5Pk0IrlWAmQycZRqVsY63317IEuSQ3OeCIjCAiCNY98INs
 Xr25j4IY0IzKQ==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/6] arm: xea: Print information about XEA's SoM HW revision
Date: Thu, 28 Mar 2024 16:34:14 +0100
Message-Id: <20240328153415.3706637-6-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328153415.3706637-1-lukma@denx.de>
References: <20240328153415.3706637-1-lukma@denx.de>
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

As now XEA has its second HW revision - this information is printed
when u-boot proper starts.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 board/liebherr/xea/xea.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
index 90a1e03077..c117a8cb19 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -294,6 +294,15 @@ int board_late_init(void)
 }
 #endif
 
+#if defined(CONFIG_DISPLAY_BOARDINFO)
+int checkboard(void)
+{
+	printf("Board: LWE XEA SoM HW rev %d\n", get_som_rev());
+
+	return 0;
+}
+#endif
+
 int dram_init(void)
 {
 	return mxs_dram_init();
-- 
2.39.2

