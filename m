Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CBED5E393
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 06:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3710F89438;
	Mon, 18 Nov 2024 07:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731911249;
	bh=bXiY6LNbfqfzx/D2Aw9OL7HXgC4i8jLJnAqviLoaYUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ike3wKNMrKsoEut7+kcI6AGgisZleNNpN/Mld64qTsEdzZh5Xekw8XqckL7VdWTM/
	 +0N5arX6VRpGREunYSeLMmc/FV+H8ILxINUzZ+EWt3p4KjTByurAE1wtJgxu7VRcrj
	 fQPiNU6hvGA0qJTkQxwjXlfut3nVxA8QH7VGCWcVghZAFnfxHUha0v74eexNLud2N8
	 t5djtGZi0ASadn1rdvx1p2gx7egV6GH/Ojb7QyRdVfi5jz4I+x4gdyIdb7qs4X65ui
	 aOKDJn8C6Rzc5WEFLGW0DJEe44tgVnrMPo3p4eGwjNt04o+R87szbSz7QStMqU51Fm
	 MeYyaqdE3ueAg==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 871EB89427;
 Mon, 18 Nov 2024 07:27:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731911247;
 bh=bXiY6LNbfqfzx/D2Aw9OL7HXgC4i8jLJnAqviLoaYUI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UAWmxBWl/qp6lRF0E6LB8Y4oGtxdkp4LvXy/7+YIXIf0dxa3sNpM1LV3xrN1uZ61J
 ADVdH+hJyoVW5sBZByHUxi5iEAFstzYTdTfiuraF94yFmFdUhLQFdm3dY8DrGUI/IW
 cahr8rjVgKncRwjWyl9vfMJIR133mUVTS/fENKnOk4FOQRDQszDTrXW3HVnu/Lvycu
 JF+qH1HArNUfz3M2r+y1tpGshAEWLEuL0FW4CB+EDdO6NTJsbwHXWdYY10hKAKEa+Y
 u0FrR7XbesRJQKRZqnauR5PjReTsLZjPz1GvWuUczWCn7pssCItHcfqZ5AAai7+l5b
 H93lliPEzN5uQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/20] imx: imx_cntr_image.sh: prevent warning for missing
 spl
Date: Mon, 18 Nov 2024 07:26:58 +0100
Message-Id: <20241118062715.32989-5-hs@denx.de>
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

when building U-Boot on imx8qxp and the board port uses
SPL, U-boot build shows

WARNING '.../spl/u-boot-spl.bin' not found, resulting binary is not-functional

This is because U-Boot binary is build first and Makefile
calls script imx_cntr_image.sh which checks if files
exists... but of course as spl is not yet build the
file `spl/u-boot-spl.bin` does not exist yet, so prevent
this warning.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

(no changes since v1)

 tools/imx_cntr_image.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/imx_cntr_image.sh b/tools/imx_cntr_image.sh
index 972b95ccbee..07acd385631 100755
--- a/tools/imx_cntr_image.sh
+++ b/tools/imx_cntr_image.sh
@@ -14,6 +14,10 @@ for f in $blobs; do
 		continue
 	fi
 
+	if [ $f = "spl/u-boot-spl.bin" ]; then
+		continue
+	fi
+
 	if [ -f $f ]; then
 		continue
 	fi
-- 
2.20.1

