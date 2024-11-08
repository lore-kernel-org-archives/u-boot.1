Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0874D5E12D
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17CA388B4B;
	Fri,  8 Nov 2024 06:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043335;
	bh=Tqio+mK6njUSr4/KSxtx59kTW0sJ3rXeWpB7lpW+Cgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vizN0//1U6dYPqHGyjGkt12Iv7LJL/NNT2XQVtbFQhv9Ey7SPqxZipcNa8w8Shdj4
	 bm1X09CoXUeOPgm9VCCHQ78zH/SGNu0rxb76UhVwTdqG/pwdl6Hwz+dgAR/pwOLMhh
	 PQ0gyVyizsd0cjF7BtCYY8ZgEJOcdW5jwpa7WryFIE05yMzxMdpLbkTb8WQUG19g8M
	 4x6+qgCFBlvoaRlRGBOI8YPWqJ0EGREwHgdEaM/kPhL92olpMNU/0+Kt4SfcJfbiza
	 jOiQ4C0vMobssoJltExQG2FG38CLlHb8ufCf+CQrg0Lfc/w+6PF7QqDhYym9QUs5is
	 HzDM/HRcG+XNQ==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 575378920B;
 Fri,  8 Nov 2024 06:22:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043331;
 bh=Tqio+mK6njUSr4/KSxtx59kTW0sJ3rXeWpB7lpW+Cgc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SKTquB7YrkwoGbCXfEACPSnSatfwoGuZiAHk2FAgkc6rHHgsg/D6jeavAEiLpyZOU
 ry49OayCDEzsFwul5005CaWdYEuYItlsLekD89tdmMHf0l7646/bjNZt5YpKCON6K8
 RWZe0LlDhB9sFyxsqsHGaWAsRjQ7KI1Av0YAGj77Z9PDshgKaqx7vcAPhiwpAe8As9
 nZFteGKmuBgMQUt2EH5uJZO0UvvgfemZMD8jYt6shOli3e6fg1ZU+RLSPmHTrFZTzN
 HDYC+mb8UVz8GNrGOGvi42mxg5YLEkQF3AQREi6mkG7Dj4xR+71rk+tfUFDsQlaxJC
 HQGIBYBHUlcFQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 22/22] siemens: capricorn: update maintainers
Date: Fri,  8 Nov 2024 06:21:43 +0100
Message-Id: <20241108052143.26874-23-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241108052143.26874-1-hs@denx.de>
References: <20241108052143.26874-1-hs@denx.de>
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

From: Enrico Leto <enrico.leto@siemens.com>

update MAINTAINERS file, add some more board maintainers.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

 board/siemens/capricorn/MAINTAINERS | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/board/siemens/capricorn/MAINTAINERS b/board/siemens/capricorn/MAINTAINERS
index b4c52032cc9..5f467aa9b6e 100644
--- a/board/siemens/capricorn/MAINTAINERS
+++ b/board/siemens/capricorn/MAINTAINERS
@@ -1,10 +1,12 @@
 CAPRICORN BOARD
+M:	Alexander Sverdlin <alexander.sverdlin@siemens.com>
 M:	Anatolij Gustschin <agust@denx.de>
+M:	Heiko Schocher <hs@denx.de>
+M:	Walter Schweizer <walter.schweizer@siemens.com>
 S:	Maintained
+F:	arch/arm/dts/imx8-capricorn-cxg3.dts
+F:	arch/arm/dts/imx8-capricorn-u-boot.dtsi
+F:	arch/arm/dts/imx8-capricorn.dtsi
 F:	board/siemens/capricorn/
+F:	configs/capricorn_cxg3_defconfig
 F:	include/configs/capricorn-common.h
-F:	include/configs/deneb.h
-F:	include/configs/giedi.h
-F:	include/configs/siemens-env-common.h
-F:	configs/deneb_defconfig
-F:	configs/giedi_defconfig
-- 
2.20.1

