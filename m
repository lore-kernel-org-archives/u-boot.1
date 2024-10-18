Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423E0D3C544
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 02:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A42D88C7B;
	Fri, 18 Oct 2024 04:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="L1RlgvIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B7DD89169; Fri, 18 Oct 2024 04:47:07 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 966C688C7B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 04:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2AD6B40A47; 
 Fri, 18 Oct 2024 02:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729219622;
 bh=rQhxk14dA1rxZWdMkuVI05ocOhaI6aQIHP24SK7SahM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=L1RlgvIEJ4xzrryrvtLIqNpy117mjlNZOVnt+UhdgG/MfXqHRM5wT2aS0uLCBIjLJ
 X1lm3FSK6r0IxmleNlOQiZyb086VNUa7+tDR2O3tn885UF2BzEggYUBMcDI3aBI3I0
 oR4giU2V9YzQ7/sC2zMkWY1UyUx5mQhzLLYo2WtfULJ4FSd1qUrXqNWfpugirOaSMD
 nqBcRzQbZTTgWbKeUmG9F4EUJi2OtkS23v1sLO1qBLIky0GtkdrbhF83cTUvpN9TF0
 473RN/SsXiiDYP2coChVGRJ75lR5lZOKu3C4oCx8qckwYM1I1Cxs5c67s6T42UWksh
 V0bxnbbLcMbhw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: upl: correct printf code
Date: Fri, 18 Oct 2024 04:46:57 +0200
Message-ID: <20241018024657.134492-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Building on 32-bit results in a build failure:

    cmd/upl.c:75:51: warning: format ‘%lx’ expects argument of type
    ‘long unsigned int’, but argument 3 has type ‘size_t’
    {aka ‘unsigned int’} [-Wformat=]
    75 | printf("UPL handoff written to %lx size %lx\n", addr, abuf_size(&buf));
       |                                         ~~^           ~~~~~~~~~~~~~~~
       |                                           |           |
       |                                           |           size_t {aka unsigned int}
       |                                           long unsigned int
       |                                         %x

Fixes: 264f4b0b34c0 ("upl: Add a command")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/upl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/upl.c b/cmd/upl.c
index c9745886507..4996f36c787 100644
--- a/cmd/upl.c
+++ b/cmd/upl.c
@@ -72,7 +72,7 @@ static int do_upl_write(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_FAILURE;
 	}
 	addr = map_to_sysmem(abuf_data(&buf));
-	printf("UPL handoff written to %lx size %lx\n", addr, abuf_size(&buf));
+	printf("UPL handoff written to %lx size %zx\n", addr, abuf_size(&buf));
 	if (env_set_hex("upladdr", addr) ||
 	    env_set_hex("uplsize", abuf_size(&buf))) {
 		printf("Cannot set env var\n");
-- 
2.45.2

