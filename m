Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942BCC5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:43:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41ECF82AF6;
	Fri,  6 Jun 2025 08:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gx/6Q78v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BBB182BB5; Fri,  6 Jun 2025 08:42:35 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C092B82B19
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a36748920cso1694700f8f.2
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192152; x=1749796952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBZUy6K3G7k4deHs+hVT5rp+Foz7LScGwYynlpvntA4=;
 b=gx/6Q78varOvFn9eO/ecHmt1nZ6Ihh8TD3eglChb56FKS7zZkceqEA3rnVGxSYRTQg
 mClCevD0D7cL5Qe8WtUxosqC+gnAPLa9Mhxtn4uVH0PpG3qXYvupX9oJ6qyUmvNWg37H
 fQHpdlnl5B5KEBkrywT+YPDyc/MfkgKVhZTywwFrep0wWpdGARba5KH5etXqMe5cuZRA
 zJ+zVJIN2/zD4Ccs6xE4SQTgOx3VZRMiHT6/NxtdsWr8Xx7rS4fPeJ3qFBjPkzaIwdAM
 RQP3fUL4+IEmSPVFcd6bqvc3SFjDWUt5WKcuyny2yuV5/5Av0P55RxDXdRCGYF3U8u/p
 MkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192152; x=1749796952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBZUy6K3G7k4deHs+hVT5rp+Foz7LScGwYynlpvntA4=;
 b=nNLnNpoQfzHuS3eL1xXTV9OeeF755CjEPq6ZKbAYyg6NGyqXgU2RVGKJhe0rMFO0QG
 bs/8ihNQpYN783kk3sBvOM/wmeCR4C68X2fsySs2Z9hmF1TPlQnOzW0DksDA1O+tnLnm
 qifvpJi59+YM30VG7UPdb037itN63BEEbVliuTBKtJVAsHGLc9kmJz9Ob79IuTIyOMgr
 6xXc7wTXse8x9xwdVTLizryrNC2zXchAqTpdinrbMv8odwmrwlMyBkuavWF8KJxca36y
 pG4s7nauNYemqVSb0Nd5dlb57qkkRxFaMJQFWzUXIycN5Gola/mU6dpHtpz5pUNtqmgD
 xTkQ==
X-Gm-Message-State: AOJu0Yz05rbSSBrCqjeoWhIMVTQrhkhr6cvdM9uGzxW2Ba/3dPLtONVu
 +E1ppI0iDPvfwQcx+AcmVhWlhoU1+WPF5wqiyHYudW2tEHad9oBCOvPnlPJeQAUs2josoNGJawB
 oKjfY
X-Gm-Gg: ASbGnctINgNFmzykwaf4Rj7bcNEpzbPxX1UKKJa5zS2EDPrjvpid674nrdjBn+Ydngp
 d1nFHhf2W92Tq00AGx5FyOYIMSnTL1wC9eW91Iccl1VTVlrQjfGFJ7zDLl7IkBHevUkxpIhgOI2
 eU2juja5snj10UMtNdy6atV62LEJiAFL6/PFdsLQkFKapiXKUOyQBxupqAfvb0TAMKY7rmzRysh
 /C9qo/nFpCy0oryTAnDyLfoCMLyiJe/8DdGK0ZxmylOKgS0PO2U02NV/oKxKIcjT21M/R6W7JWA
 zljxkBcPlLQx7wybnGBpvcIFciIs2FZ/QqLuwxXynHzkbQRoekUX98qEH2DCId1lJDSoVIaNn5b
 QQ4E+bA==
X-Google-Smtp-Source: AGHT+IEBWkkt+kJE0WCfoSWD3ax4shdKQCl9Bpai7GItJ2xZesQk5WXWcBBFxNcl2tzO6HFcCzDLtg==
X-Received: by 2002:a05:6000:2485:b0:3a5:2ec5:35a3 with SMTP id
 ffacd0b85a97d-3a531ab6deamr1802562f8f.45.1749192151969; 
 Thu, 05 Jun 2025 23:42:31 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:31 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/13] net: extract function net_sntp_set_rtc() from
 sntp_handler()
Date: Fri,  6 Jun 2025 08:41:46 +0200
Message-ID: <20250606064211.3091237-11-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606064211.3091237-1-jerome.forissier@linaro.org>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
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

