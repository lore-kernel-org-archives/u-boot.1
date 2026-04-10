Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9D8F364DB
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 11:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AD6084198;
	Fri, 10 Apr 2026 13:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="jzu8dXwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2859A84181; Fri, 10 Apr 2026 13:04:37 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3610E84105
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 13:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso16570925e9.3
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775819075; x=1776423875;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8wAQqEvh8SviMfKdaJ0igLEkgfNgJzR/KVYXLMTn30c=;
 b=jzu8dXwMCH00ij6gcPi1QpXgXbtrQJME1xDDTU7vfYnT4mgedLLzg76EvWhE8cBeAA
 FcLbLk7Ltl6MhNXweuTV8HnJXhJbLKLiMwe2veCZEUlM+4AgVr6OGIAMxACrmMB018ls
 GUUzaxR/xJOYs792Js7SL2vmYXpKE9RA7DnsBQxvmjeZ3NRgpKQ2w0lL+blApc8gDG0/
 d0fEO93D+gOnRKJ92g7VMaS6AUhKPLukYduOiEKOfXIvNXHdM/fdsRtU91wKNRGVCigC
 6YkjeTMy12jEaiz8TeX4yPgvlV9oxKIAQpA48ldWWrr08mfEK12hxTk4amS7wovT2crJ
 d2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775819075; x=1776423875;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8wAQqEvh8SviMfKdaJ0igLEkgfNgJzR/KVYXLMTn30c=;
 b=jrkilugPmBOKw8pBiRDyGbqaKebyWznnZ7oCezQAAbTo25e2cN+MqaqdHJ9hGWum50
 VNh6ur6w4XzhNH8/R0yXZg3SIQBcI1a7m6+8VSDGUpVbKJHVNtjX/8YTQnRNB9y0YfxP
 ja6QOGWWjAbXRzUYVvoyX5n9PVw/Lh17Bb+a5yGzczH3DbLC3IrD26CVncXF1Msr2cDK
 M+zMcw1vlDvqGo67c6pCFdjbcT+0Yh7iDWiQHj1sOG4OMLEXs2wxZU/tDqu4T3JUG/m7
 r/fCNYFDou2fdbBpG+SDSldr7dQDk5YdzBVksKI6E7CXp+W7C4IEE7g+w5R53iotvxhL
 xOYQ==
X-Gm-Message-State: AOJu0YzjvXab5DzMnLEtNWkEo+ysJoImc52VZw+DRNv840oD18p+MQoU
 1rQ3Jwjf+xGZXTXXnY91ghygiTlL8aqxuHfq57K/4qIceC92gI7OgDYsxfCsGYO10VQ=
X-Gm-Gg: AeBDietGf5u8krJPfHoHN8Nx3/KAqCPi5atlDHKn2WZoLrtb/WnuaNmUcS9MDk8DYw0
 lzrpEyaARNp5AisHV5A3Tzf90s3bTJITAHHw+9nrv06U7tSu4x2FWpShYYIXcW6HSxig10njJnf
 z3zEjbILP7Rf85shA6h3w6Pgf42aF4UdVEsgb3DfxWX0lCVRI8LZMSCtmISmtwX0T1OXiRLjhoN
 R9+p8GjFRQgKcb2i0+VPUVe1aUcLol5ZKnW+Kf7cGNu0ja//5k6k6iOFYAgu/8xWey0OQT99bsi
 4NBNLwwWdeQz8El+mRMDC8pXe20/tFac08DCwIdAHgaqzgEYgOVV0xcXK68jZclDQi5iS8tasyy
 3ZWB4hntpXvDR/+xNReliePql4RCXCmJKlaXnpnb5KqMVWO9SxmS7rA6cOFWZhIK2bhLoe//Hg9
 BsnvqKCrKIOYdQDbRSdJae
X-Received: by 2002:a05:600c:c088:b0:486:fa35:aef2 with SMTP id
 5b1f17b1804b1-488d67bf744mr23830705e9.4.1775819074118; 
 Fri, 10 Apr 2026 04:04:34 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63dec090sm6796732f8f.12.2026.04.10.04.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 04:04:33 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 13:04:03 +0200
Subject: [PATCH 1/4] net: cpsw: Fix error message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-cpsw-switch-v2026-07-next-v1-1-c914724b13e4@baylibre.com>
References: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
In-Reply-To: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=711; i=msp@baylibre.com;
 h=from:subject:message-id; bh=bMZ+EPiyMtfYhbsgCQSytnvKfccnEgXq+VorYynVUp4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbN3VVHhcELJ82a51IiPu+RTMd01kaAtLWP3B6JTdlr
 uZu3pyfHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjARJyOG/wX97UU8j06cXtBl
 6DqRT2Hq1/BKnfJH838sNq55HhaxX47hf6gYR2/y63BeBR7HxXoFp5fv3PywpYlr39Ifu8q76w7
 eZAAA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

It should complain about mac_control here.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/net/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ti/cpsw.c b/drivers/net/ti/cpsw.c
index d7746f454baf6519c697d18254ac8ce7a98b8deb..6bfdbb60091ac1cb7ef5a0bb3ad5221c2c11206f 100644
--- a/drivers/net/ti/cpsw.c
+++ b/drivers/net/ti/cpsw.c
@@ -1177,7 +1177,7 @@ static int cpsw_eth_of_to_plat(struct udevice *dev)
 
 	ret = dev_read_u32(dev, "mac_control", &data->mac_control);
 	if (ret) {
-		printf("error: ale_entries not found in dt\n");
+		printf("error: mac_control not found in dt\n");
 		return ret;
 	}
 

-- 
2.53.0

