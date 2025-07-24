Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3013C87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 15:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 113AD83894;
	Thu, 24 Jul 2025 17:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ms2U3Cxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EE75838C2; Thu, 24 Jul 2025 17:28:09 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AA9E83844
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 17:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45634205adaso5706085e9.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753370886; x=1753975686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IX34KDKLhtuufFLkdoV8zstTSLFDlMYpIe6PFTpvOOs=;
 b=ms2U3CxjcXjixZXp3jbhYu5k65yNfEG//7OqG5qXsrTKQg2r7Bkn42nCml0x+DThob
 +8yU2vlZuUScojg2jdKeem7CaqBh+B+gBYkMb2pN9LKn3gL6jz8Gyn/aGfksLHts/P+T
 moUn9VyZ1gNfOAsZEawowUanthEHygRzxUyEVXgHMZlmJKoEsWdgq1mg4SuGr25EGzr7
 l8p1t0zzSSGsFm8N2Yl1nRP+qv9JBfgormuEoT+tmUOeMXZdUtF4OIg+9a0IjXEHYx09
 i+5YNkzTkLCFfvM3Rqk2mz1g7mldRxiu+Lcx4DPQ9kNYdxZ6HeLaLozQ68+uhSsK6Ifi
 fyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753370886; x=1753975686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IX34KDKLhtuufFLkdoV8zstTSLFDlMYpIe6PFTpvOOs=;
 b=hCDV4iDSgMSTUvZEqSK/U9UC+Idn5SsPVNjOkxceWBfk/tPG71mWfn/Qm1Gq4PQ8QP
 NT/ux00p+xiF4YpspBckv2uxEmeulHEG5xMRWHiWOyQVvjLHOC5w+MTYKVHk5AuNjjm5
 mSULYUYrb8LOXi1OgTtrP7cpMlqimL1Bfi7kezBaEtfmqJOnuNIZWk2gBFvJ9y4veR4G
 QIE/L7XF+kayNQdYh+mWYABIb1ERpk5PV20aH/+cTtwZMDZnumbOBp12t4oQ5gCFXuLq
 XDbv2UbN3/t9g2DnXfFTW3D53wPX1n6qtaKbkmq41PrkMi4uJ733fXczodroUbI1C9Ng
 MTdg==
X-Gm-Message-State: AOJu0Yytk19IP5mA+lKtxnxFCpZ2u2LtfCAdCxxnRPSdovUvVlt9Gl2C
 4OW8wVpwkboP6r4VTTCYO514qB28PwSi2ze7g6EcyVNeoLRCSjtWMvtfK8m3YaKEx1bgf2UaHZa
 bDAQvcoU=
X-Gm-Gg: ASbGnctG1UpYI6jMTTTbHQ+2FEpsXslXelNk3YTRAwcywKgGhP3SQ8Tvy3Vl/YKWyRd
 o+Ug9iRutG2Fdi1pgdvwKtPogPfaUBjqhRimZoXwYWPqG4hFUK0v8uotYSoffQRuuxWOBzqjjpv
 nHvx6tgkJK/bG21oMKmmtoyBsGlboTLyk21sHWLub+hyFPNVl8NrJfo7Z6xXwropH0P7Kugc39H
 7Da/lRPggDYhsoG7UtK/8d8MZWNRiqP37591Y/N6YtHndSGw+2tDx4ObpDvv5rPIMMvX6sAuANR
 tvkQnXlbphn6O3VJcI6mlRiBroakW8QjuQXcwC3KdRZ9p7/ci04yTU1xQeC1SSqGsXQxPKnSIA/
 AcqcNcZzJwSSig5VaWPMDluL3HETYmQ==
X-Google-Smtp-Source: AGHT+IFcZy4HWH1ZqqBJOfJnRDyDcYynO7Jg3SnvSpTkrQLYvemPQA8PTqhYwWiJqPjbU4XRZxzsgg==
X-Received: by 2002:a05:6000:4304:b0:3b6:a799:4809 with SMTP id
 ffacd0b85a97d-3b768f1e504mr7130068f8f.31.1753370886187; 
 Thu, 24 Jul 2025 08:28:06 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bcf7:2df7:a82:bef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054ef47sm23702465e9.8.2025.07.24.08.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 08:28:05 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] lwip: provide a sntp_format_time() function
Date: Thu, 24 Jul 2025 17:26:35 +0200
Message-ID: <20250724152641.142876-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Provide a trivial implementation of sntp_format_time() to fix a build
error when CONFIG_LWIP_DEBUG=y:

lib/lwip/lwip/src/apps/sntp/sntp.c: In function ‘sntp_format_time’:
lib/lwip/lwip/src/apps/sntp/sntp.c:283:10: error: implicit declaration of function ‘ctime’ [-Werror=implicit-function-declaration]
  283 |   return ctime(&ut);
      |          ^~~~~

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 lib/lwip/u-boot/arch/cc.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
index f91127ac565..04ab94d6b70 100644
--- a/lib/lwip/u-boot/arch/cc.h
+++ b/lib/lwip/u-boot/arch/cc.h
@@ -47,4 +47,13 @@
 void sntp_set_system_time(uint32_t sec);
 #define SNTP_SET_SYSTEM_TIME(sec) sntp_set_system_time(sec)
 
+static inline const char *sntp_format_time(time_t t)
+{
+	static char buf[29]; /* "(time_t)" + 20 digits max + \0 */
+
+	snprintf(buf, sizeof(buf), "(time_t)%llu", t);
+	return buf;
+}
+
+#define sntp_format_time sntp_format_time
 #endif /* LWIP_ARCH_CC_H */
-- 
2.43.0

base-commit: 3532f1f5edfc97c9dcea723cdeb732eda44bc669
branch: lwip-sntp_format_time
