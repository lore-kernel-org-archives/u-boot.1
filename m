Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31813D75BB9
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19A7A8967C;
	Thu, 21 Nov 2024 06:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166773;
	bh=OwkgZIPVS/Ves+rVRrS5QUGu8vfuNP1/SXxIwjKbZQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mEsywTpFkgGTDJCvWPviwli8BhqfG1QXZTTitxWaakLxlzkML0YhpWWiv0iPin/5z
	 HMmYeP31MgtWHnpxi1ukkfz+8i37Wh7jquzxBmQ9F1z2gzL2J5IkL6achC7BPs86DB
	 nezUciN/Y250CbcvQ+gGfsnu2QNabrhUXkLCkylHS7eqFtmbTurWkHgh1ri4F0xH2b
	 OI0Jsf8F3YTyrRXINB9ZYPdMQuigIir4aNXxnEtpqVd/ZylQJc8ox9gRiytod2Pabz
	 5iLwX2Qqw7tY3RMZIcdYOEtknfyi2exIgOKGH2mG4VkQJ8K17eefR4yj9hQ9nP4Kk3
	 EOIMF2WgYh5QQ==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8135F8966C;
 Thu, 21 Nov 2024 06:26:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166772;
 bh=OwkgZIPVS/Ves+rVRrS5QUGu8vfuNP1/SXxIwjKbZQ8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JKdGpSy8L03PrhK7t3R3Tc/znnedLpe5CeZ2IlqWO+hm1frqBw0JMk8cMmB9JWu7g
 iYu4hU5ZZDqC3zr6TCe2mPD3k/BtKF54nFVgkwUz4/18Cp7RFPzR73PMzafYuNa0rd
 sI+fqKUxXDqT4jQO1dzUh3tK4nW+X6renzuTbaltHD4a4JqkZn+NG6pwpO5vxH2ggy
 /7cazQDC4pLzcxzGM8Zi8PzELPYhbGFPJaiqvWxQoB/yuM3CS964BeIQEXhNY+3z8A
 PMjWzxka6UuKubIFRfVo7mgFTl9s5veGRBAiS530zSUdIYvOXwTUXaTDwS16BOxOMt
 NIzMpivUMpLFQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Gary Bisson <bisson.gary@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 03/20] tools: imx8image: Improve error message
Date: Thu, 21 Nov 2024 06:25:44 +0100
Message-Id: <20241121052601.72880-4-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
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

Improve error message "header tag mismatched"
Add filename to error message to see, which file
is wrong.

Signed-off-by: Heiko Schocher <hs@denx.de>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

---

(no changes since v2)

Changes in v2:
add Reviewed-by from Alexander

 tools/imx8image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/imx8image.c b/tools/imx8image.c
index 96ece28bd6c..b22e8b21c47 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -733,7 +733,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 			fclose(fd);
 
 			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched \n");
+				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
 				exit(EXIT_FAILURE);
 			} else {
 				file_off +=
-- 
2.20.1

