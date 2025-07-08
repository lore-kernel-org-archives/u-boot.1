Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7DCC83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 16:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F57833F6;
	Tue,  8 Jul 2025 18:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ix2CEGtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3852F832F0; Tue,  8 Jul 2025 18:51:22 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A30E832F0
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 18:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso39973175e9.0
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751993480; x=1752598280; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=saLc7Ttr2rKUA03E3pXnBlxHwNEFejMn26nVse0aVcI=;
 b=ix2CEGtt5DRCB/ybUBMnvp2NAYlyApBYDn88QYFnKspXp/2GqhDYyp3GLIFetH1W4R
 zj4rC5YUX+2aaE+nJUOyNY6LwYxxYkRDXj/TOloIGSbpBo+95MLmX/TvszKXo1F0d9dS
 3ZI+MpN4lk/jXjHwaveCOOgaONJl5RNlqkg6ayR6NS9WnaYT+Jh1g0rR9GjavJeIvpd/
 0OFr6XYAbP4+tBc7Scruj+rse/rYxmDOWsyHOvwaN5GLpUfqxRNb/KuFhFyHVUaCnUeN
 uMUwTPvFUeRUxjJVfie4IpdUVQkazTir1sy2pAMvjSOxsa4v0DTcBn+pb81BvJX/UTfc
 viWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751993480; x=1752598280;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=saLc7Ttr2rKUA03E3pXnBlxHwNEFejMn26nVse0aVcI=;
 b=is+86tsHCDKh1xVs2ZuM5jCn2bV7LR+e7+1Jyf6HZwg/DRmeCowHVNYaXqj796x/oL
 b9qYIlTbwDamAHlNqts+tRmo5CnEF4ezzBcXdFQEmCYt0HOAizPq8HBWGjqcJFxHT4Ze
 i7B37dLhqam3KbUPflp7S1cG49BbWefG6pIV+hafyd3BW/KHX8v2Exb3exF0W9eS1lLG
 HLZJTNLMAtDmNWdttjP5zJKqtg2V9IFvfAiHQb2D5kySCRh0gnqMXs2DX2kzHhshWG9Q
 mNQfAnpeHCXmg2/OzR4ncjvoruY5ncM3YX4mxKVAM0EUz1CXRdesnynuQpENOsK08xZa
 C3eQ==
X-Gm-Message-State: AOJu0YwHiMf1jZxu6guDNd/nJAtz+fz5LS5LfubuZG0iroELXFTeFp4d
 LWrOLVnLlJgV2fkYOFOc4Lr23ZXinJ/2JLb960IQFyyktCmQKQJxXF5m4KptXqXI1X4=
X-Gm-Gg: ASbGncsELqYp3vd6c3ypxLAzUdAsPGyx58TKtY7yD2823z6ZB17z996iKvpsbzBzUex
 WBBXEN2RnhZD5JBh6yB7Smh/gt0aCKKLobhnloJNL2JdHII+KSR7cbBFZdokYJkP44L2C9/3Mwn
 GI8b02QX9WUuy5bQFxO70y6dGV6DaC9JT/yDUCMOsmT+6GKAs2ra+dE+S5cJLZdnuGmr7UAaDsH
 L6lcQN6Cy1OV2Xuy1qeQvhxCUehUhBZQLkKJ2YqWJUyTTErsZdZhw3wAPQ6171T+5lMRc+kRs5v
 7X68jm8nkV7J33I3BnIHiMwtZeg/ROZTq8Fr2Vt841DpnRSxOt6GxGY+o6gjHHyovxduBvUR9sm
 JvSnyrcFPSNBH
X-Google-Smtp-Source: AGHT+IHubuIufltS3+W25BbtDO2bc1Q2AWSL9JD6H7vkPnzgG9C0o9+oMT1NiLrZqMJNZtEl5pNZbg==
X-Received: by 2002:a05:600c:6383:b0:453:8ab5:17f3 with SMTP id
 5b1f17b1804b1-454b4ead145mr126490295e9.22.1751993479632; 
 Tue, 08 Jul 2025 09:51:19 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:a08:6480:3e01:6cde])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030ba29sm13232481f8f.2.2025.07.08.09.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 09:51:19 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 08 Jul 2025 17:51:18 +0100
Subject: [PATCH 3/3] net: wget: Fix comparison of unsigned variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-net_fix-v1-3-292b9aa20f31@linaro.org>
References: <20250708-net_fix-v1-0-292b9aa20f31@linaro.org>
In-Reply-To: <20250708-net_fix-v1-0-292b9aa20f31@linaro.org>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

content_length is an unsigned long and so testing that it is >= 0 will
always be true. Instead test that it is != -1 as that is the condition
set on error.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 net/wget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wget.c b/net/wget.c
index 3c0fff488eb..428ee072330 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -214,7 +214,7 @@ static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
 			content_length = -1;
 	}
 
-	if (content_length >= 0) {
+	if (content_length != -1) {
 		debug_cond(DEBUG_WGET,
 			   "wget: Connected Len %lu\n",
 			   content_length);

-- 
2.39.5

