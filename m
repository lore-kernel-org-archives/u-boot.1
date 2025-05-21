Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923BFC54ED0
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 15:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 168C882F70;
	Wed, 21 May 2025 17:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MG8gBWkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D383B82E0A; Wed, 21 May 2025 17:15:53 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C1E82E9A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 17:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso56435665e9.2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747840551; x=1748445351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hk2c9/tSgoicmyHI7pE/MgajoOLTC2DBKjzOxz2/U5s=;
 b=MG8gBWkIUQYQvQpprOftEkXyo7hvzkG2d69eaDnzhPgIa3sVepuN58TGvPGihDKW+9
 78iPZcdZVB+00wuL2ZVcMCOQAFduZ39u7HdqsahMGzNI9qTOT9fUyTMrm4ki6ncaVGfk
 JTYhvfMW8N1WYOrI9ATo54vte8IJ1NOJAOzuQ+EsvOzNkAPeuDQdXl+Jyn3PcsuC9M/a
 sySEMR49am8J3JX7eouvR+0g9bk8T7R4rW3RgX5NgYvdNUV3SF5ylFQcYGnOL6fHEexz
 OBD4FVBgAGH6emAIYNPMTdqxK05/IzL5KbXtpEHtOJDaag8/VGowOdBvoGnGxOKusssL
 9cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747840551; x=1748445351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hk2c9/tSgoicmyHI7pE/MgajoOLTC2DBKjzOxz2/U5s=;
 b=vOAvTTfpWjXCpuvvWwonNpnaCSD64EIpKwvDaaN3OInTRGVbi783pvOxjuy+HEocXi
 ycuhXfhkDyzp2pIB1XNmd6ScfwSXh4s2q50OAflMehG7ePk5um5FsyQcDuNaVY4ixogf
 qQ+m56+9oEFgqYHE4vQwOxP+3fT/R2b/IWbaGeR6rCH04Rc68ScQs4ce/egk4tgVwjq5
 Pg5YwD4XE8cpbv3oZUkfr5mb+and8utUkEfW01TLlVcYfwHusP+/kFcpSnwNduyWZ2Pf
 PItdyGoH1cSOdpMTi3ZOW00Q39Ul2/4R35TCKIyVrehaBpxm4IP5wp8hcIGZ+K2XAP+g
 YAVw==
X-Gm-Message-State: AOJu0Yz2WgYJsfbDhx3kFDhyJf6RSxpurRlBPWrOWUE8B1r+K/cHaMQL
 4rNgDjkCd/rFTcnH4SUDtxAKCHFcQP2je1EmfEA6jFc4lafLm1ltXfLX0wOi8+6xqCM8tORADpB
 AitxtiWo=
X-Gm-Gg: ASbGncuAK4qAbU+WaLE81ZtDqOAr9/8oOkkydXZA9ozVXsMZPgwF/So7GBbB9BbhXtZ
 J2EKAWove2ATPFFef3KrbZlYWGlUrNG7ZqsIDC6DXAenI4CGSgFu6q0W/lnNXDMki/WWEI5VoAU
 7ZZZeA7ZHNuPN8wNMCTnu3D9y0tgxso+FW0A1xGIhDiEkUnxdsvHCPiCgzpXhRA5qZBVn3z+b7T
 GD0Bfnpj3TFaIp0Ya+Yk0DykiRiDmDYOuWE/jjmyKv8vZMPftscXJC/g3I1uqHCnT0UmjshSf/w
 GdantPa30pmE0U75xbQXcuK1sB76JfYkcHO9kM3CLSS/PoC7HilPDIpq4H4S
X-Google-Smtp-Source: AGHT+IF3lrWAo97GJAg44JcDd8iXxp4fLevIB4U2Bal7MaCtLKgAGteq2LQPpDXEOi6mYM/JK+psDA==
X-Received: by 2002:a05:600c:1992:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-442ff039684mr195582365e9.30.1747840551026; 
 Wed, 21 May 2025 08:15:51 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f65b:56f4:360e:9fce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a3632a2bffsm18505226f8f.32.2025.05.21.08.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 08:15:50 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] net: extract function net_sntp_set_rtc() from
 sntp_handler()
Date: Wed, 21 May 2025 17:14:41 +0200
Message-ID: <20250521151516.16729-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521151516.16729-1-jerome.forissier@linaro.org>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
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

Extract the code that sets the RTC clock from sntp_handler() in
net/sntp.c and make it a new function net_sntp_set_rtc() in
net/net-common.c. This will allow re-use with NET_LWIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 include/net-common.h |  2 ++
 net/net-common.c     | 28 ++++++++++++++++++++++++++++
 net/sntp.c           | 23 +++--------------------
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index e536968a92b..a021bf503ff 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -586,4 +586,6 @@ extern struct wget_http_info default_wget_info;
 extern struct wget_http_info *wget_info;
 int wget_request(ulong dst_addr, char *uri, struct wget_http_info *info);
 
+void net_sntp_set_rtc(u32 seconds);
+
 #endif /* __NET_COMMON_H__ */
diff --git a/net/net-common.c b/net/net-common.c
index e01b0da7d7b..30d04323d4a 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -1,5 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include <dm/uclass.h>
 #include <net-common.h>
+#include <linux/time.h>
+#include <rtc.h>
 
 void copy_filename(char *dst, const char *src, int size)
 {
@@ -25,3 +29,27 @@ int wget_request(ulong dst_addr, char *uri, struct wget_http_info *info)
 	wget_info = info ? info : &default_wget_info;
 	return wget_do_request(dst_addr, uri);
 }
+
+void net_sntp_set_rtc(u32 seconds)
+{
+	struct rtc_time tm;
+#ifdef CONFIG_DM_RTC
+	struct udevice *dev;
+	int ret;
+#endif
+
+	rtc_to_tm(seconds, &tm);
+
+#ifdef CONFIG_DM_RTC
+	ret = uclass_get_device(UCLASS_RTC, 0, &dev);
+	if (ret)
+		printf("SNTP: cannot find RTC: err=%d\n", ret);
+	else
+		dm_rtc_set(dev, &tm);
+#elif defined(CONFIG_CMD_DATE)
+	rtc_set(&tm);
+#endif
+	printf("Date: %4d-%02d-%02d Time: %2d:%02d:%02d\n",
+	       tm.tm_year, tm.tm_mon, tm.tm_mday,
+	       tm.tm_hour, tm.tm_min, tm.tm_sec);
+}
diff --git a/net/sntp.c b/net/sntp.c
index 73d1d87d38b..77cee0046bd 100644
--- a/net/sntp.c
+++ b/net/sntp.c
@@ -57,8 +57,7 @@ static void sntp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 			 unsigned src, unsigned len)
 {
 	struct sntp_pkt_t *rpktp = (struct sntp_pkt_t *)pkt;
-	struct rtc_time tm;
-	ulong seconds;
+	u32 seconds;
 
 	debug("%s\n", __func__);
 
@@ -69,24 +68,8 @@ static void sntp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 	 * As the RTC's used in U-Boot support second resolution only
 	 * we simply ignore the sub-second field.
 	 */
-	memcpy(&seconds, &rpktp->transmit_timestamp, sizeof(ulong));
-
-	rtc_to_tm(ntohl(seconds) - 2208988800UL + net_ntp_time_offset, &tm);
-#ifdef CONFIG_DM_RTC
-	struct udevice *dev;
-	int ret;
-
-	ret = uclass_get_device(UCLASS_RTC, 0, &dev);
-	if (ret)
-		printf("SNTP: cannot find RTC: err=%d\n", ret);
-	else
-		dm_rtc_set(dev, &tm);
-#elif defined(CONFIG_CMD_DATE)
-	rtc_set(&tm);
-#endif
-	printf("Date: %4d-%02d-%02d Time: %2d:%02d:%02d\n",
-	       tm.tm_year, tm.tm_mon, tm.tm_mday,
-	       tm.tm_hour, tm.tm_min, tm.tm_sec);
+	memcpy(&seconds, &rpktp->transmit_timestamp, sizeof(seconds));
+	net_sntp_set_rtc(ntohl(seconds) - 2208988800UL + net_ntp_time_offset);
 
 	net_set_state(NETLOOP_SUCCESS);
 }
-- 
2.43.0

