Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBC7C25B47
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3FFC8712D;
	Tue, 24 Oct 2023 09:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NqG3Ww0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC35870D4; Tue, 24 Oct 2023 09:19:52 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1EB587134
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3B5103F200; 
 Tue, 24 Oct 2023 07:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698131988;
 bh=CjgcX2iLs+4WKDD+iQY4szlZCE8afLGJvlGgsPICVOY=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=NqG3Ww0nGFPcHapVIajVPvjLItVpzWfpjZOMlX0um+Abi6n0tudL+sEVJ8COlsVxG
 CgvZDRUIXRVM6WZaZuGwrabiedzO6EKnI0vyNnHIJR241owb0jlHX0auZ2sXCH+zOc
 8n6e4aJdI0LCG438BmXNaKWjOi1+ZFo0zKNqRXYYlxg/sVedLFoEI4QAAhTfTZkiHV
 rJMQeXuii8fIZvUWpiSePQ8k33HeR+GcX9gwBmpG0L/3pJ5mQniD4ZTMPFW47tD5xD
 xvqHBOriJwIuPR2PKlWytUXnx2Csky5BXb2HwcnTpgm4F6RuQqYaDVDSKJpVw8bdMt
 SyByVRgHw3nSg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] mkimage: do not write incorrect error message
Date: Tue, 24 Oct 2023 09:19:16 +0200
Message-Id: <20231024071916.39523-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

When running 'mkimage -l' is called for a valid StarFive file an error
message "Error: invalid marker bytes" is written by the Renesas SPKG
driver.

mkimage -l may be invoked without specifying an image type. In this case
mkimage iterates over all image type drivers to find the one that matches.
None of the non-matching drivers should write an error message.

Fix the Renesas SPKG driver.

Fixes: afdfcb11f97c ("tools: spkgimage: add Renesas SPKG format")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/renesas_spkgimage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/renesas_spkgimage.c b/tools/renesas_spkgimage.c
index 5cd81dd5bf..ce3b2b28ae 100644
--- a/tools/renesas_spkgimage.c
+++ b/tools/renesas_spkgimage.c
@@ -147,7 +147,8 @@ static int spkgimage_verify_header(unsigned char *ptr, int size,
 
 	/* Check the marker bytes */
 	if (memcmp(header->marker, marker, 4)) {
-		fprintf(stderr, "Error: invalid marker bytes\n");
+		if (param->type == IH_TYPE_RENESAS_SPKG)
+			fprintf(stderr, "Error: invalid marker bytes\n");
 		return -EINVAL;
 	}
 
-- 
2.40.1

