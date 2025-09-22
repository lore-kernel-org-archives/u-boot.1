Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6616ACAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 09:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3090483280;
	Mon, 22 Sep 2025 11:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vbW/mI42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D73D383211; Mon, 22 Sep 2025 11:36:52 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE27F832F9
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 11:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee12332f3dso4141729f8f.2
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 02:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533810; x=1759138610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqqpzgE2HNyI5+8VxwdBI2UkeOxriyYRbRE47AdsEVc=;
 b=vbW/mI42qg6Bjotn5HcW7/NQkupt9I8Ptylomw7WMW97M4O2duHw5x1bN3w8878JPb
 dyJGL05ubgDaEu536S4XZqOa2gNLLABynU4KSiaY+u7soDLkVucBiL0R9YDN2TxJx4xp
 Sw87+KNhLMhid7vtds/IIWqvr5HQFZFRzhG1pEuEqH/c5WtcbN+Dk1ROqvuNPfg3ZS/0
 I12Hs7zbHEQDxS9rQuV/gWHajvDVDCRL+55U2mcdrIcZNjty+ZIUje/nqMzYWHtXpgDD
 /qvFz55umhSXXzmLhl+ws0gQDHEYCoJa3s7wiYyc0/4crpYimh6J4xn6jgPAz/GBoYCo
 bUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533810; x=1759138610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqqpzgE2HNyI5+8VxwdBI2UkeOxriyYRbRE47AdsEVc=;
 b=jggOEpElxn6TGVpS5EzY4ImOw+QzzlwWynEmzGCsR8FPhxIigTdpd62Mx1UsV5qnd9
 vYuy3qnTS0v1MyB32gg9GGr6KVqPnUZD/27q62/2VakEBfTxIScI/qstIpZZ8IoalO/l
 GEOALLBhE4CxjbRPm+r2HAU3L56rOOAw0vhqpM+Pt/fDpTVMaLW0/H6W5WTgNrTP78gd
 VqxV1FMh+WbXn/KUVnogr+meXeb1bypCf7rI08UYfkYQUQZyZbT+R+/w2gBEuLfWqrzo
 GzmROgl5j2Gp10yCfUbBs2rrstYUqjtedVFqmhJjtYVKf2iVGd1zs5/WlF1PowRBHHdk
 Go0Q==
X-Gm-Message-State: AOJu0Yw1Y/+i7+Xtcei49KjtDKjOQtkwisymv83ZoXAZHrZyVvY2XIXD
 D90M45PXDvZMmWPSb8AcoDAQbbsR1eiFzavbJ9Wxv+shU+qr/Z4rCtRS3cT5ZFFyWxkRLoRCl/J
 KQPkqPWc=
X-Gm-Gg: ASbGncuQD7AxtUU7gtbBZvOKY+omPhJeacO22F3Tb6PGtZCYzIrPAF1vmQN92hwBu8Q
 dpqGhUTvbX8ZT/DNeA9OJh0iFBQB47Jl+aX7UpCl1SN/6109n25p68QOi2dwj9eOT/mfdUwpRXI
 99d/f36fSvw2kfdHmt5+sSgL4zMDfWy1x+IcK6V6a7NLV7/LdODmI91zZjVnzefrFAwojNUfjjK
 FAsoS9mQxykZlE2VoqjRCBz5gDwlZ4K4aWk4+OMrXVA6wjHDIJXyTHiVtBrQzkF+NZFDV9zoyiW
 Rkgwkw4j+9NQcgmFZuDg8Wdj+LzJph8cUW9Q6fct/8H18Kie7cV7RV8VIQgzdvwedy78/q/LyG/
 /QUcZt9yd8PYX+72ubSV6p3PEygqaYzQ=
X-Google-Smtp-Source: AGHT+IH1QFcjFqIBmE2ZWe0W3KysvjswyryjF9TvOYVv61yNZjZmdeeC7PWSFEHOAsmjZ0mOLNyVtw==
X-Received: by 2002:a05:6000:2f84:b0:3fc:c90d:9957 with SMTP id
 ffacd0b85a97d-3fcc90d9a60mr2246065f8f.16.1758533810192; 
 Mon, 22 Sep 2025 02:36:50 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:fe8b:a136:2e69:4bd1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407d0asm19177840f8f.17.2025.09.22.02.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:36:49 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] net: lwip: enable debug traces for SNTP when
 CONFIG_LWIP_DEBUG is set
Date: Mon, 22 Sep 2025 11:35:41 +0200
Message-ID: <20250922093629.2547703-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922093629.2547703-1-jerome.forissier@linaro.org>
References: <20250922093629.2547703-1-jerome.forissier@linaro.org>
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

Now that SNTP is supported, enable SNTP debug traces when LWIP_DEBUG is
enabled. In particular, this allows to see which NTP servers are
received during DHCP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 lib/lwip/u-boot/lwipopts.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index 80b93ea172db..e8a2c9d7a0a6 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -44,6 +44,7 @@
 #define DNS_DEBUG                       LWIP_DBG_ON
 #define IP6_DEBUG                       LWIP_DBG_OFF
 #define DHCP6_DEBUG                     LWIP_DBG_OFF
+#define SNTP_DEBUG                      LWIP_DBG_ON
 #endif
 
 #define LWIP_TESTMODE                   0
-- 
2.48.1

