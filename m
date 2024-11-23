Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526FDE6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 16:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F88893FD;
	Sat, 23 Nov 2024 17:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732380797;
	bh=bXiY6LNbfqfzx/D2Aw9OL7HXgC4i8jLJnAqviLoaYUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RXztziLyvOWJhCQoDKtSkOH2jj9LCWZoo9A/URtL2rGN6+LL1vXzYGuvBMiLooIBo
	 6pzLL7CNMaD8cdwf4I83muLQERQZXEKVVxZDa/RLXJVLeq5V/xDgPwXj7koj1jcOTd
	 z0C3r6jd+whTj9Rsidtt74f/yPbOHvvtgvXfeE0cXlFHVO9218d4zIIlrBmXxEsYun
	 oIfWjbH6gBoW+EKtGsTm2ttnNgqfhc9NuGCYKYn6kue2+R9Hq3Q6zoddUxklIWmwHC
	 nlmrykaAlEhaPPZ6lLQEC7xUvY1J9CrC0FPIOzJmh6zVRtxGACIAdrPJV/qR+rnZ5h
	 hhqhADg+FQk9w==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E8218893E2;
 Sat, 23 Nov 2024 17:53:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732380795;
 bh=bXiY6LNbfqfzx/D2Aw9OL7HXgC4i8jLJnAqviLoaYUI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=x/RhT3HkFcspC3d9ev7VGJPNgL8nZR2Y4ySkU+xqkWo+L03Wasv+Oc10nO7zKmyhF
 o8Oe1HDqHSzyVKX/3Qp3hPMqDipIfvU4x1rWWddllqandqmZWHiwdKCHMoCBPZ5/0j
 zB36BGLohvgd9uiKwk6oG1bQdqrcEiPdIEGT4zaeDDnzKxMEzYATyl6quEBykKxsHg
 S5H2Z4DFoIzku7dLqDhQ2BD6hULv16OYYR+GKwcjUVsqnZLKHGEUKdKPj/m1iVWvbR
 yw5h3J25Ajw9FKcSaJE161p50EEwMDidPdW6jJ/13Qzklt0nQZrZziwFI1pyunTG6v
 NPKLFN3Spbw5Q==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 04/20] imx: imx_cntr_image.sh: prevent warning for missing
 spl
Date: Sat, 23 Nov 2024 17:52:48 +0100
Message-Id: <20241123165304.100538-5-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241123165304.100538-1-hs@denx.de>
References: <20241123165304.100538-1-hs@denx.de>
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

