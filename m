Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB7CF8D753
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 14:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBE384201;
	Thu, 16 Apr 2026 16:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="ANR4OJPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAF108422D; Thu, 16 Apr 2026 16:58:04 +0200 (CEST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bc])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2739A84201
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 16:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776351480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZrSxf6ckX384UqqPLbIT/7pjppJxspx3wLMVSrNvYU=;
 b=ANR4OJPeJv8BsPG9sb4Q/+QBDTIpI0czCkGiiG6en/GBdkF5bJhZABVVIBcq0husTZylre
 NOVd6oc3c/xMfLgpTeFjb9szNLBHRlExhO0XuhM5zs05YiZ9FuOumgtUaTXRjoY6ZRjzR7
 shOVXKXqAr1lioNlVjILDzP9WSIfsBSh529py6E1JknJfB9Wva8J7eWEu4XAtXumHLO3gA
 p9dgSfMhCmBrf7joFgxVSSiE9eKFD8n5X8KuqxEiEoZNWE9/l9uj1yQnfKHwnBs89K82A+
 s8LMNac4jY0XVhpA/55ZtY/6UdnQztFdI71rkXaotrWaOElU5dYjydShZlEofw==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Thu, 16 Apr 2026 14:57:42 +0000
Subject: [PATCH v4 2/4] cmd: bootmenu: ANSI_CLEAR_LINE before entry name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-ui-cosmetics-v4-2-b843ba661b3f@postmarketos.org>
References: <20260416-ui-cosmetics-v4-0-b843ba661b3f@postmarketos.org>
In-Reply-To: <20260416-ui-cosmetics-v4-0-b843ba661b3f@postmarketos.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=709;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=gRFMsdTbH87+UZY8Gp3qVC28CYTjUgFe4xb6Rw0ialU=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp4Pj0wJGD8YSFD+luI78jQ4CT2KjA5eY5DZymB
 EB9qzZOIr6JAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaeD49AAKCRCEr8vQ14ma
 A8CMEAClGk4DIDkgbBJ9sIAgC37MlJA5onckT/7ri69cHR6rs3xHix3QHTvIc6nAl2SnaQEoWp5
 abQYoffTHlXl1OYv8cv67k4RCA+qgbT5wH1ie7rmDvX34OYVAYV6gcc/Bbe8TFTPDkyAXUl0p3x
 QccAb21Pt5QhczgKVFGyHlhZl1s544beMh9GfAxxHwMi7atJPmp7nDzsxymwTe50274ahrQvWEK
 7X9gNjD3livv+yGWgPOX5WeFu+NlDF9YzeIa6hGxePARlhbtzjQwRLDVpuuaAbSXr89a5SNBiKH
 2ekkslE/Q64g988wjSq9cDoXY5P/YRIoHPPW4rrkUPrBK44hyVtNQP7Y8P0yXkmV4XUJuhZbdFX
 5mzqQzs401p8hB9OnBUnwn8qQBUXvPIF3if1wpTAPqqbP+U0M6TqkU1xqJCLAmpk66X9pEttv67
 Fu1XlXuNJTmb8mkaPjuAXGG/00B9M9MB115TMcdJdycsL2tZBX1V+4roW+bqDd90igRtUNUDInH
 VP8Z/1HJ8DKniNOPMjTCg/l9syKPhzM0YKA2WN8QJyiXfhSPV6YUlsOCaOcVz7KboDOTyBTkvjY
 sGaxf4UT15DvzcqxBl2hUsJVqIoF1ZyMik7atf9qkM1Dm2pVUzgu6tKGp4XzzlU4kC2quXz2Erd
 5aMJwGlfbMFFWcg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

This has the effect of highlighting the whole entry when it is selected
(on vidconsole), which makes it consistent with eficonfig too.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 cmd/bootmenu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index d3108778c6f..a07fea49322 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -76,7 +76,7 @@ static void bootmenu_print_entry(void *data)
 	if (reverse)
 		puts(ANSI_COLOR_REVERSE);
 
-	printf("%s", entry->title);
+	printf(ANSI_CLEAR_LINE "%s", entry->title);
 
 	if (reverse)
 		puts(ANSI_COLOR_RESET);

-- 
2.53.0

