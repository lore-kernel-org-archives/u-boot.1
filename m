Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77772C7115A
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7C6A82D09;
	Tue, 17 Jun 2025 12:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v3NHa6L1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B57F82D83; Tue, 17 Jun 2025 12:07:55 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A930280C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so61366695e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 03:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750154872; x=1750759672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYAng4b1PFv6aatTjr0TOnkP6IgSAMBiynf3klbsjUk=;
 b=v3NHa6L15NTGJdnTyJIu+IcQrUDcNJWs61XIO8LjPZYyswYN1LSkK2hyDskztzy9z/
 Gf744JegQj3q7IurnFAB6ysF7KjR3qvj/JPE4fT8B0BQgy3SiVb767t5m2hRmEJ3VpnK
 zysP6mzWCHUb7azV6PgGaMuh5uTx62AqNoTnm2h+M/uaA3P7DzpSUKkFd5QGtRoJpfLy
 TkrReNeb1nQrSuoHrbjWRAtQ8ijrpG80WD/sZqAoj3Ep5CTNUAW0+w2BeZnLRiG8nlo1
 ij1Jx1HrUP0UDxITcve9V0RwyS3XMjZZvZjbkBk8q8qJsm0QKYAJppE2RErHGcW1MGBQ
 hwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154872; x=1750759672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYAng4b1PFv6aatTjr0TOnkP6IgSAMBiynf3klbsjUk=;
 b=F/bKZfCSB7EELG9nGlDo7lmSs6SFtDfyJ7ByCCK5E2E10/5RMxmhGtvo/Y229J5S/w
 0OGLKmA31QIU6lwLG75ZbYdU2VIISffH6M+YQCdP5dWDW1OmvnjCA0AC6myq7NWmrqie
 DGR6HfuXDV82S5mfEGDPEG0vWDeQvuykNtQxtgVjXseQvj+bdOex/qci9EBUA8XS0fN4
 P+hDPpRgr2Hi7oPjElR+JGbSp8UU/XVkooRTO55JQCEc9J0jJMs+jkiRL/P43VI2c9O1
 XgaTA66kqDssWDSRt3Hy6wA3gNQ91ClugXiLg4BUX5RRXbr9LsliK2JB0wOjdHst41OE
 BcvA==
X-Gm-Message-State: AOJu0YzBMV4J3OE5/J/eZt/39tw90dS4ppNetHvt632BMdj/F8Qn3Fff
 BBMWmqoKP2eXDCM2orXx3v26BVlG+xMwWuWXhyxAv/Q7Ywv0bjn6Wo5SncxYdi56+uRDqSln/0n
 rKHPP
X-Gm-Gg: ASbGncsojbCsqbdFb/2EErHuy1Ix4cjvBbckYeVH6Hok33D1QXS1+l++vqhwqYSyDV5
 YYF9F4Ut1L/rhFy05t++ZyE3FAaV06x4DomAMYEPK53+9X1+mbn1230Usy/gDnndF3q5ZMUCazW
 cAJ3fM3/advSpqEvNNehDohvSQmhNYO0OTq5eafpbmgDGadBzh1apcV0qMSbfR31pOWCSQ0LviV
 IYwTiYzpGlUp5Ct4VErIgLoMlc4S+PYyx8C8sHhdonTrb1ZLm01auIzrHwzn7VUwgdiiR90W+fZ
 xjl5NBJ2yRQMa3qwZnJS6PaWRLP4zfTR75rs2eiqwxifWFwXmO62zb3E2/IHt0lFhKO1Du2KANx
 0f4JLPQ==
X-Google-Smtp-Source: AGHT+IFKjFiX7NZCuw5DrkNlkPDJnRtbgtt3YlHbK0xRF2YzT6g2i2Qtofd0iVy8FXJJaqJr2bDA2g==
X-Received: by 2002:a05:6000:2c12:b0:3a4:ebc4:45a9 with SMTP id
 ffacd0b85a97d-3a57237478emr10566980f8f.19.1750154871815; 
 Tue, 17 Jun 2025 03:07:51 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b61071sm13582412f8f.90.2025.06.17.03.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:07:51 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 10/13] net: extract function net_sntp_set_rtc() from
 sntp_handler()
Date: Tue, 17 Jun 2025 12:04:00 +0200
Message-ID: <20250617100720.2544758-11-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617100720.2544758-1-jerome.forissier@linaro.org>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
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

