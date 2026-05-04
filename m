Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352F4CD343A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 14:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A875D8460D;
	Mon,  4 May 2026 16:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="ROF4Xb6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7854B8466B; Mon,  4 May 2026 16:48:41 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D023A8460C
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 16:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8PfG42R1z1BX4;
 Mon,  4 May 2026 16:48:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777906118;
 bh=84hrh3g9PJB/sCxZY9FG14DMpptDObciSi+ZiHCh5xQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ROF4Xb6XwaEwn+sZ4YyeqtviOIIdAXiRoSgrrljk8cwxuw8DH2X9HukgZTjRAMoPS
 09KHiMYlmBi+/aXe95ELjKNw5DqUc/lc/9O5UIP7RwhNa67H5U9ls/oPOcG7o1d47u
 9mmRwz0pz8Ca5F/7HEo+oVblTvN8CEebdOyL7zt6xtQyzRfH5g5XGLfBzrQ0pZuoA9
 nAaDmU58RTXnyRLJ/Qbqu1Nl0XeVqKTraMScRbmm3MnHbmDxP3HblvLIGaNu6vUTuU
 efZjTkF4N6osl1xm90Zl4i0aYxqi/znEnz/AtaA0//QhUq5Fh1L1XzewsR11aYCabK
 akRIRFfv+7VWA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8PfF4ZsyzMts; Mon,  4 May 2026 16:48:37 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 16:48:28 +0200
Subject: [PATCH v2 1/2] cmd: ufetch: show net feature when NET_LWIP is selected
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-ufetch-net-v2-1-01bec4ca7169@cherry.de>
References: <20260504-ufetch-net-v2-0-01bec4ca7169@cherry.de>
In-Reply-To: <20260504-ufetch-net-v2-0-01bec4ca7169@cherry.de>
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

We've had a new lwIP networking stack for a couple of years already, so
let's show there is a "net" feature if it's selected. Since NET_LEGACY
|| NET_LWIP is the same as NET, let's check on NET.

Reported-by: Simon Glass <sjg@chromium.org>
Closes: https://lore.kernel.org/u-boot/CAFLszTgZC1FGy8965pHiG-u=FhrguftRv41ghQ_Qb_RRXx6tyg@mail.gmail.com/
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 cmd/ufetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/ufetch.c b/cmd/ufetch.c
index f8dc904bdd0..bc5db08eee1 100644
--- a/cmd/ufetch.c
+++ b/cmd/ufetch.c
@@ -159,7 +159,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 			break;
 		case FEATURES:
 			printf("Features:" RESET " ");
-			if (IS_ENABLED(CONFIG_NET_LEGACY))
+			if (IS_ENABLED(CONFIG_NET))
 				printf("Net");
 			if (IS_ENABLED(CONFIG_EFI_LOADER))
 				printf(", EFI");

-- 
2.54.0

