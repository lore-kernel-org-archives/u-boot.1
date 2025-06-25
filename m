Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054F4C7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D9CE82F08;
	Wed, 25 Jun 2025 15:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LTZRhfSx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D9D82D83; Wed, 25 Jun 2025 15:21:42 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B419C82E50
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so9550475e9.0
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857697; x=1751462497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYAng4b1PFv6aatTjr0TOnkP6IgSAMBiynf3klbsjUk=;
 b=LTZRhfSxm+CftDPzDUN0GJJ/nw3PICxLcaJ4Qshv0vBg6e4hDoeF0hBa9f47uHsi8i
 CbUm3LuuYE//x7cbMtqP6O17RqMeT3xY33640Skl4Kn1V+2W+I8QLHJHL7oYzfRupszN
 b4N49FLcmy1rGZ1todKTVnGVSfAQsvtUtYoiXEAWPvQDlgiNMHLAjT/C0PWAWAl+xHkU
 dbpKCNNGCFOC1c6OWcEDM2MKg7V9brlNobUzS6XTWczAlhaXr1ztfhp4Ji8xWl/wVS6p
 FhN2Z7kmRWwXyRCjMb5gVX2QAvPeTZAux/cRIrNA1x3AX1M4DnBCs1lrSAUpl5rZiNsC
 GFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857697; x=1751462497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYAng4b1PFv6aatTjr0TOnkP6IgSAMBiynf3klbsjUk=;
 b=cxCd9RDQca5+rY4DZmLgsQdfSc+5IBDk+wiANJtbKF4z1MNMwf2Yg45EIEUdyWyxw+
 sF9BX48R16I/umX7EV5NZ1R8kxuU4xsXM4Fn8aBrZ9GgsGegSvojEWzTjD2yvQE3nV0/
 yf0a+ro1IGnWuY2Ftl7uDYob9aiQeAQnv92vxQ3sUXQmbl9v9wVu/8Gq2DnWZQnyrPAy
 wJpUZ3Fu9tN3ngxg89ESQ9fuegO+QBJoGh+hb+OS2b65/lTRUQuIJ5tiDY6AX+CvsHNR
 BUX6FZgIPdcyAtFZmsN1x2TVs3nfWYlGyvbe1edXlku9ty20yq+oZxQoCJkGziKsGqTu
 53Hg==
X-Gm-Message-State: AOJu0YyEb8+580y8NiZfTUx8OjIEkyAgLRCNwfkBNQF5mUHRZsJo+e4R
 O+US4UEinjSjcpLIaA+fA2sjWYC5t4UTPQeDL2nHQh5m7h2ymgrqxn1ZnaFeWvT0dQF5IWhqCIT
 lm7/b0pA=
X-Gm-Gg: ASbGncvY4lNJyB5I+EByGu1K0x6DngZUIVVNEvrGGNkckk3Rw7/PLyJCpPs0u/7vxV0
 JwPQ/UZNegbOYIcSJW5pWBnsoKWpxiQUsn19I2/okMf3ynQ6G4nJtMPGJmAeSItPUeRHtyhE5hv
 /SJMxKsR+1609fxgPjgJwJwLJVcQQGzPRnTllvLprIiSKfAx+khNuXnRjpNwR4j00MFFVQCOmMw
 T514OPGfOsVn33H4bnSYrhBkBFWeoBRK3aV3xaeZVaJMFDbwxEF/oGR/zEpr8UAGrF5rwsfJ/fL
 g3r68H2kmNCRBBxUeNGPT/uGZuHEt8Ln0tgCOrD8U8mJPvmi4s2xAy9nUUu/Dxlm78La69cr518
 UQv/xdQ==
X-Google-Smtp-Source: AGHT+IGxKfrqBi3evvLshNiCBCrQ3mEfp7V64C052oRw2zP6rBW5Mp2RqevuElO3Ww8vImFyUrC9iA==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:ea40:4d3f with SMTP id
 ffacd0b85a97d-3a6ed6717e2mr2486050f8f.53.1750857696780; 
 Wed, 25 Jun 2025 06:21:36 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:36 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 10/13] net: extract function net_sntp_set_rtc() from
 sntp_handler()
Date: Wed, 25 Jun 2025 15:19:18 +0200
Message-ID: <20250625132108.3292932-11-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625132108.3292932-1-jerome.forissier@linaro.org>
References: <20250625132108.3292932-1-jerome.forissier@linaro.org>
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

According to [1] it is safe to assume that all devices have been
converted to DM_RTC so drop the useless code.

[1] https://lists.denx.de/pipermail/u-boot/2025-June/591376.html

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v2)

Changes in v2:
- Drop the non-RTC case

 include/net-common.h |  2 ++
 net/net-common.c     | 23 +++++++++++++++++++++++
 net/sntp.c           | 23 +++--------------------
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index 7853612b237..c212d2f9b3b 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -588,4 +588,6 @@ extern struct wget_http_info default_wget_info;
 extern struct wget_http_info *wget_info;
 int wget_request(ulong dst_addr, char *uri, struct wget_http_info *info);
 
+void net_sntp_set_rtc(u32 seconds);
+
 #endif /* __NET_COMMON_H__ */
diff --git a/net/net-common.c b/net/net-common.c
index e01b0da7d7b..b064557d524 100644
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
@@ -25,3 +29,22 @@ int wget_request(ulong dst_addr, char *uri, struct wget_http_info *info)
 	wget_info = info ? info : &default_wget_info;
 	return wget_do_request(dst_addr, uri);
 }
+
+void net_sntp_set_rtc(u32 seconds)
+{
+	struct rtc_time tm;
+	struct udevice *dev;
+	int ret;
+
+	rtc_to_tm(seconds, &tm);
+
+	ret = uclass_get_device(UCLASS_RTC, 0, &dev);
+	if (ret)
+		printf("SNTP: cannot find RTC: err=%d\n", ret);
+	else
+		dm_rtc_set(dev, &tm);
+
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

