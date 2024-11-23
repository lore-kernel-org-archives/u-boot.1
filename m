Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95577E6ADE3
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 16:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 762D8893EE;
	Sat, 23 Nov 2024 17:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732380795;
	bh=Kq8pnkKExJHOT7WtmwQkYDpexu7srMYlQgdL92KmGds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vKDft1d2TrYJIej5wl/Iv78FvTKvqyobD22Acn9hE51HXxZ3BLuq4liGZHUZpuwUz
	 jRHJ5Tns57RijtXPKYdVQ94fZ64wF2gK0w1YYAL6cg6FKqtWIR+UXbHSRvqRDMcAqO
	 k6d4cBxEq0AOBlfU4tHngYlCgKrh+uHcJ9pvyA4LUFFF9oHWVqrOfvfbYA/aCcSOop
	 DtEcMROw6X8oyaMD2f96Dt53A+J2ewk8IcsN6og9nJgnr6QSiw2Hw43hR1PYaOynAE
	 0boORTo1T+N/EnkpHmKJxdkS6SYfqhPyqOFqsBLlXp2DLcKfAePIY/gHlkAUcVaG3w
	 GpsD+l+RYaIgw==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 20148893E4;
 Sat, 23 Nov 2024 17:53:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732380794;
 bh=Kq8pnkKExJHOT7WtmwQkYDpexu7srMYlQgdL92KmGds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FR/yJETMN1B9v7zm8AL4KcGARUEwQCZ6RQqsaUY+RDVO+00bCAV3I85SGZzFaYnm3
 8H5o4N4ZFyTIUufsGQCMunwvyetJPYRlqQ3QQbqL/030XDHlf4gsYSiZ8m2Tcn5PMf
 4JUa6OIBzstugRCUhSyEm/mgm43+3zwrHJcMaYjNbEg+37Xw/9bItPERA9iGAayLb6
 bH75YbEnIthI6IpOrub+SdVfMkNZQfr4BSHypHfLjemFpHS7anpJ4EJezGMcQ6AVGQ
 b2z5FCVWnM7EnRa8uFMNGnzPzW+OG1+nZV3AzKqW+KdVYrnAn1CHx5z0sRPpub7sKo
 H2QmaoRTq40lg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Fabio Estevam <festevam@denx.de>, Gary Bisson <bisson.gary@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 03/20] tools: imx8image: Improve error message
Date: Sat, 23 Nov 2024 17:52:47 +0100
Message-Id: <20241123165304.100538-4-hs@denx.de>
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
index 7a060811c7e..15510d3e712 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -734,7 +734,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 			fclose(fd);
 
 			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched \n");
+				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
 				exit(EXIT_FAILURE);
 			} else {
 				file_off +=
-- 
2.20.1

