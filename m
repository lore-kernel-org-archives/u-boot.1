Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA6FD5E12D
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2794388FC8;
	Fri,  8 Nov 2024 06:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043322;
	bh=px8EvZHJpPbhByc2E0dVFcxHXpSZ6QTTHCAJrPsNRs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xfd2JYmdU2a+L58dQji9m9d0/mEBVH8QyGuAJOg+9YC5xYiFeGKAIJDGQ1usCytHw
	 A65YMuA+DDIq2IPcQoyanOwnBii8wcJ0bOpCq337ajjAwCjVKr2BwYtiE5+776WV3P
	 5JBBjRUhKnkUFnwojDggodUM3+KH3uNWCeH5A6l5mbEuRNOQkTE7vKO9FjfPd1Td32
	 tV8sRW6TnM/KIkbY3cNmHK6m9bQjXQfkQGIpyvlRahuVNE1plZZqfxGwGuN+i9ziS9
	 0kUhr2TzmTQe79vN1WHIUfLqn8BT57nn29+TkiBMSbG1FgzWSKcnXeJfB6AGIyRgls
	 8tXKYYsAMItYQ==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3CCA188EEA;
 Fri,  8 Nov 2024 06:21:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043319;
 bh=px8EvZHJpPbhByc2E0dVFcxHXpSZ6QTTHCAJrPsNRs0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C/OR2MADit5zK+PI6k720HWwQTQzPvYEGpbboaz/bqCittO3DxcOnfBy5jk0b2N2o
 df53idoNNMLzQgFjc7rkloFxEp6EaeureXb9Fvsrg5f8kflDvUvkdYCQYMbsXZyCg8
 SnUyk3tnEMJvJlGp2ImRsA0RGlRI1AQ64diIgtaYZ/y4rq09d8+VKSMH1k/vgwK7CL
 uZOOMTOzxd40aelfEmVvM4qD7IpASO4qmHqpgK7L2F7tyDkXxjsHkpu4a6xVuolD9Y
 kQA/wvGtzbgN8TyRdotbgCbt9+nmbzpYUKVIbmkwVJLNrhyNeTTv38PlzzyXvvzJ9a
 1X/7rxl3Op5uQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 09/22] siemens: imximage.cfg: correct comment
Date: Fri,  8 Nov 2024 06:21:30 +0100
Message-Id: <20241108052143.26874-10-hs@denx.de>
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

fix wrong comment.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 board/siemens/capricorn/imximage.cfg | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/siemens/capricorn/imximage.cfg b/board/siemens/capricorn/imximage.cfg
index e45f2c9589e..f73c5a7a9b0 100644
--- a/board/siemens/capricorn/imximage.cfg
+++ b/board/siemens/capricorn/imximage.cfg
@@ -21,5 +21,6 @@ APPEND ahab-container.img
 CONTAINER
 /* Add scfw image with exec attribute */
 IMAGE SCU capricorn-scfw-tcm.bin
-/* Add ATF image with exec attribute */
+
+/* Add SPL image with exec attribute */
 IMAGE A35 spl/u-boot-spl.bin 0x00100000
-- 
2.20.1

