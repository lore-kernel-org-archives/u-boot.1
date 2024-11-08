Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5094D5E12A
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC5A8904D;
	Fri,  8 Nov 2024 06:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043316;
	bh=fVP5Drx0+gYrZYr56ifnU21dkvrMhwlMB6Di6zUTSGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZWPGlbATFzLeuIPx7LSTL5p71wN9/SL3evQ/kDqhjOg+zaenP0bqbT+iDr50U5PnV
	 0mNa46WTAy6IEFNcrzYobmnOcEuU/3VPK2Gpx4Lgtwv6GK8tuTcTzQm9oKnYHQMmOk
	 VLzQZUbBqNqnqAj8AAbwwIri9RmhrsDhQo6Ef+yPUyWc5QyWrPz6YELHp/QK+wY9WL
	 V/eJqH5IYhV50FtDb0gFiEnmSPfEfsnuvM8GLeFb9TjUxTXJVx8LvsnbngLxHeu+U7
	 8y90ZF2ckxsZwpaLHaO5whZ0kHpYYPYM5ylPXBHDb0Gkm1yZUGGy89Js29u1QOHVDI
	 YHnT32hwVtr0A==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8B31B88FFC;
 Fri,  8 Nov 2024 06:21:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043315;
 bh=fVP5Drx0+gYrZYr56ifnU21dkvrMhwlMB6Di6zUTSGM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l9ui28C2thUhiiepyOVWQL4R6z4fFnWGflnPWKETafvn6TJGsLg/+TasaVLsjXCj2
 HANARYd40ImZM3esFaTqjPbOloQ8zsfwHsnbE4i8KgiECsHegrpcpst8GEX18uAHfx
 rHNAMFqqb7RQswcS5c+CQC4r21XAlLrLQ9qJVq4FXS3jm9qpLCm84GxcdoI+sVwrcf
 8M/khjPqPFdmV7nVbanMp9yPpxz4m+ivdbGbY/b12dnJ5OO4nuTynU4rwH4eo6Sawu
 vlh/Ba3wLJQXlXgZwkJxrgFDDjbxQwSZG4ikNlbbcHe7wvOv9SMTl22DxadQUcLjah
 ++ga4oZfB4XEA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 04/22] imx: imx_cntr_image.sh: prevent warning for missing
 spl
Date: Fri,  8 Nov 2024 06:21:25 +0100
Message-Id: <20241108052143.26874-5-hs@denx.de>
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

