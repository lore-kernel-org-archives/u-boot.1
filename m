Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2479BD41C00
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 05:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E51F894FE;
	Wed, 13 Nov 2024 06:21:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FsMKpdex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75636889E9; Wed, 13 Nov 2024 06:21:43 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7022B894E8
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cec7cde922so8951666a12.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 21:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731475301; x=1732080101; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Po5a5SztiqrC0RZwNedlTSkdSvdw1G4gmoiAEPSAq64=;
 b=FsMKpdexJT9f6PQ95CtjN2swO/gWW9ADn/I9hgWDkzIcLpZEGAPwsQ/Dq8GmutUnB0
 ZIR3Om4kw5neNrDiY0F3X2BfqKlguuwflCuJOsvQ5yChF0TETySLJobKqcbMfDlbNe03
 a1y+cLEHVD57yvBM/jeJzoifyJOksbGHTI7TxtbN0cC24PEJySbkUl+2wO+9DkTXYWBp
 cBoshFkdY6pUsQQjcbZRgfbWqbKbMzZoWLFXu7Nez+u/jLlG8K3aLqdWAs4h23jIG57v
 uLn29NKF4ym2kEGoxri/U++RUN4QSRDf0VWfdMOGFLW5dV5BYkqitgTmGRzlPhtmqum4
 KQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731475301; x=1732080101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Po5a5SztiqrC0RZwNedlTSkdSvdw1G4gmoiAEPSAq64=;
 b=dNMpX/vFW5SsRU6HUwe9St2agVF9LSPctplmmUC4gRnuhMb6IkCm7wB6qRsGSykS/t
 xeJCnLcdFDgjF3k6lmt13+u/7Rj9J3EYhcyu7CjBI9HkeQOYLVsKKfWqTH9VrJAqesPU
 V+YalMTwhJ25K31EQRwv/VmOMYc0j6vXflQi3clgqaG3lJtgtyNAHxzVuYgfPp4q5e7t
 xBkfEAQo58CxRnt5f0y21mX1d3oiB67QTk1VuN1i3KJ6+IcmNFrQvZ+b5Pz0DU80P57K
 R9RTp4xopzhbBb8a/YWf/jDyUaUBaIzb+S3a+87HsKuq1U01ouuV2QsY3ubbmLzyaRDZ
 eWIw==
X-Gm-Message-State: AOJu0YzzRXMhBOtuNXn0Q72g6yqQ0c9YKsngVBSqMbY1+3FAKISaKscy
 VQBLmQvUnbdrO49g703gf4C6XcDRj9cGwV/WRSVZBIqTzw+Ahli7hARDf2tir/c=
X-Google-Smtp-Source: AGHT+IHN7F0+u77a/LKXeL59lU0M5CunuU5e5/YzpPPe4uGEFnZRqRIfH5nnfKhUtGrsmfjw8PXwEQ==
X-Received: by 2002:a17:907:c29:b0:a9e:b0a3:db75 with SMTP id
 a640c23a62f3a-aa1b10a4aaemr520691266b.35.1731475300867; 
 Tue, 12 Nov 2024 21:21:40 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a184e8sm811843766b.14.2024.11.12.21.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 21:21:40 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] dm: core: ofnode: safely fallback in ofnode_lookup_fdt
Date: Wed, 13 Nov 2024 06:20:33 +0100
Message-ID: <20241113052050.1862420-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

Under some conditions it's possible to hit the null condition here like
when running with OF_LIVE and using the ofnode API before
initr_of_live() is called. There is very little null
checking for this in the FDT framework, so returning null here can
result in weird null pointer conditions.

Instead let's return the control FDT in the fallback case, this is
usually what the user was expecting.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/core/ofnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 950895e72a99..7a7f25fc537c 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -152,9 +152,9 @@ void *ofnode_lookup_fdt(ofnode node)
 		uint i = OFTREE_TREE_ID(node.of_offset);
 
 		if (i >= oftree_count) {
 			log_debug("Invalid tree ID %x\n", i);
-			return NULL;
+			return (void *)gd->fdt_blob;
 		}
 
 		return oftree_list[i];
 	} else {
-- 
2.47.0

