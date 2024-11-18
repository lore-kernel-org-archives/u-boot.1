Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50479D5E393
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 06:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D20B89444;
	Mon, 18 Nov 2024 07:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731911256;
	bh=Cpmj08Qkfq/FaOxaT2yzasjsGe2/ZuqqWmzXSnWXqzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TYAz6xcwZSae/7c0dMPooDESsEa8QZt/iPTrDIHdDrlvPnLOS3UCcTH23oy6CGagZ
	 lk1tATwADsS+kYf1ihdbvxLsPkk3aDygvcK1oKU0e3tBKUVRi/uBg7ss4kDd7ujGll
	 15P4H1puuxRR5KTnB2OQP7gHoAQcMqT97l5XjIT1fz/f7KQkZcSsMElY52Wvj6dLQI
	 MYMzd8LGWT8xXin7nXZFTEGOJydGFFHDDkgpmKhkh2Yylnei8nK0z5x+w3HEhzYuYK
	 Jvcyn05itUqLSpnHBPKMS1ZJ0K95FT85Q9LcmdC49TpBztRoE8HsaCYLgmt4S6nkkt
	 cWlHf0f9cNHsA==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 27C42893E2;
 Mon, 18 Nov 2024 07:27:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731911252;
 bh=Cpmj08Qkfq/FaOxaT2yzasjsGe2/ZuqqWmzXSnWXqzE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QFDJQzpBi74ZpJx2uDWC2fytB0ooGPt3ck6lFRts3IoQuwaoamvn0Xgcs/iZE9Iq/
 E1s+z8B4n8+H927CaXwmtDRCoOW7vdPqlU2zOoFSBoYja2qPTSTA+GE+Rc+S4oFwxk
 PAX44ztFMkDDK+hAb82CcxaaD3TJaJTyoOZ4eN5MJuPGEyq1upzYco1RSR0E/nH0Qt
 B3MoyFvTVtxM4LNHUlMBbrQsA9xLAqDGfKQCOL97YHv2xtO/1sByuGAMvWj2Sz5ZUT
 6YYnSChgmZnM4DAfYwBQ9jJu9tdkzvC3u9paCKP8diKe0cwubRQx1z+YjyTW7IETiX
 MwFwGle8+0bFA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/20] siemens: imximage.cfg: correct comment
Date: Mon, 18 Nov 2024 07:27:03 +0100
Message-Id: <20241118062715.32989-10-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241118062715.32989-1-hs@denx.de>
References: <20241118062715.32989-1-hs@denx.de>
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
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

---

Changes in v2:
- add Reviewed-by from Alexander

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

