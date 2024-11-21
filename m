Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8798D75BB9
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80EE189688;
	Thu, 21 Nov 2024 06:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166776;
	bh=bXiY6LNbfqfzx/D2Aw9OL7HXgC4i8jLJnAqviLoaYUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mmoGU6BDeg6SxhjOQWxdc/xo9/Cpi/iPw9o7YQDkNwSfROw7qK6OZNRSTsLcTZZj2
	 tH4WOqUM5wxk9BpqYZR/hFQ2OrGQsr6TciF6PgsrqvUodjF84h0IEcBmN9PN6TnV97
	 mnk1b3Fet0Ra2iUXDVUxoY3pdRLo/o8LcP4L9+zOIUp55gOFHWc65pT8MqaTpNeq0L
	 ALgVKPMt1CX7uQ5qqN+kSrRVd+7SPCugh/Bb712DqxjA12JnlNJHqDzAxCo9SqGMSx
	 zpl1TnFoORE/EvXZrlU05UxdVzFaLkzZgNwaMX/eMh//KYh2pwjt6kT7mKcEgxhsX8
	 KkXs4jXM9QWjA==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4E9D48966E;
 Thu, 21 Nov 2024 06:26:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166772;
 bh=bXiY6LNbfqfzx/D2Aw9OL7HXgC4i8jLJnAqviLoaYUI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OWjUSrXtAAyMAoGhzPCpCFUH4iwlPSWPfhKPn2JRM3J2MFQu2D0uD9INcE7SRyo+c
 VUovgVAxRjUavEHostGv0sH3HjD6qGQoAfdzlS9W5aa/WjbrxfkaWbsiKmDZSM5+qh
 z6MHuRjEFqY051R43Fzjtxwdo7sclFVKC6odfiTtZ2amHLa3cioDYUcYrzBvwIu6oL
 vOoF7IzX/Z9PGxIJR1iX+AN7xLEg9jsPCEnAn4b1AWX3dqL0QoKCBbIyPIXDgZU2py
 laDZHWMPxv6pvUe9cGBGSFJcEZHOP9KMh0C0UewBkQwq/klfmIGBSZ7MOlQdWesmtA
 HG0xQXenf9vpw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 04/20] imx: imx_cntr_image.sh: prevent warning for missing
 spl
Date: Thu, 21 Nov 2024 06:25:45 +0100
Message-Id: <20241121052601.72880-5-hs@denx.de>
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

