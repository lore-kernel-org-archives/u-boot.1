Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C5DC28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 21:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A338201E;
	Fri, 14 Mar 2025 22:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mDaMkbb3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B81BC81F0B; Fri, 14 Mar 2025 22:55:55 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A679282061
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 22:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so972605e9.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989353; x=1742594153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQ58S4yr3/jWGDftx2dT9GQVf9dKPPP9jrjrxEj+Pw4=;
 b=mDaMkbb33255LQjwHxRTXuMbarYHMbq0l0meS7l0Pbjr4LcM2c5W0eSvXyicnbZ9MI
 yKFQokWAeIix2XKCVXrmTUWwwV9db3DiFiS3rts1ystsnAFyZMyaHZ3DjehbOrq6xL4D
 /9i82mQcOhlBlweycTHdT8/Ko+3N5JQdEI9f1aqba7Xv+f1mSLFty5TeWqJlj/o5c3Kw
 UD1Sq4UKwR2zRlZNlN3Yz5xlvjYQQCk95uLSqObjfrpYNzXfw245L5vG5MaRf9pUdodb
 +wna0hID65m+hwm3C2gd3p9fXbSLdKQ4LReuFgrSmyPrC5DpbX5rtUUTJw2t4TM8r9Kk
 9R/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989353; x=1742594153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQ58S4yr3/jWGDftx2dT9GQVf9dKPPP9jrjrxEj+Pw4=;
 b=YyQg5/KArN8ZETXfE+67PR+Xmkuh56/4DSNLN/5ktUnQmBbbUC2XBPqZ/8G7dw662k
 N3Zxf6nSGcBpMEgjmIMK9udwHH4OncjLct+z2ZfRc641UiElBdIO93V4i+qQxnS/hE1z
 PnnkO4NHMZgTftKMipKPYBewYZlFi6oB7EHLOA8XHUeTN7WPIHr+qCH53LhcEKopHlKC
 +bD6MWU55xOJ2NziN6L3HPEcFCaau6TEyMt5jHKhBUAHzIj7Kb9r2UPnlxUFjT01PlpD
 bglL877zKloLK/vL15uyXt84G+mhe0YOITuCwMx7iUNVCJWuWBQ132SX1+cH4zSqF4My
 afAQ==
X-Gm-Message-State: AOJu0YycAwrz+yPzxisB6PRSsShLnOhAsrbbxtYRinAFSx/afqnE7ajA
 JdDWJcwUKJ0hmC2V8ITBYXfkKTeFg9aAd+aG0EjiBmu7x0RHv3Ssp23UGm3u+xUiB9QL2ZIFthN
 MzNM=
X-Gm-Gg: ASbGncuEYw6nbGcthCFFB1HMbFuT1GDhy3O79TPCyl3eI+dNqnJ073mEH3l3QGBamvC
 jfNxsEpJVWEgdXtG7uB3Sa6BlMYXTj90+d0n3nuKhmhOtD++R8P2QypQUMqjJHNBAu3WOp14ZdP
 LTtmJs2/11AsAOsm9XjO4XdzBuNIijsCVbVt2NQPQBXhnXep2VBD4gLQHDhAXhlg56aZ5zrldbg
 FpRbFQu8CN+JJgeJW1/4nid4ndG5VXI+/hIy2qff4hY4thMGhYoxzJbYdN5qfJ0kplPBw7UThg/
 7ggdTrZconLAMi0A0Wm1IXoSzugsEmTm/p+FHB3MwklbXMnWd8ySJg==
X-Google-Smtp-Source: AGHT+IGJkIauWeqpRYnvKtyAUeZRQWqz5d3YC55fpOKOuBIxljbQzn95F4EgR1sWBI6MgymCEKa4Bg==
X-Received: by 2002:a5d:64e5:0:b0:391:496b:5646 with SMTP id
 ffacd0b85a97d-3971e2adae5mr4586741f8f.28.1741989352963; 
 Fri, 14 Mar 2025 14:55:52 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:5485:bb38:c353:6b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe05ff4sm29064395e9.10.2025.03.14.14.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 14:55:52 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 03/12] net: lwip: provide net_start_again()
Date: Fri, 14 Mar 2025 22:55:05 +0100
Message-ID: <20250314215525.579655-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314215525.579655-1-jerome.forissier@linaro.org>
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
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

Implement net_start_again() when NET_LWIP=y in a very similar way to
NET. This will be used in a future commit to determine if a failed
ping needs to be tried again on a different interface.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 include/net-common.h |  3 +++
 include/net-legacy.h |  3 ---
 net/lwip/net-lwip.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index 1d507b13b06..52c2a6ce027 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -471,6 +471,9 @@ static inline struct in_addr env_get_ip(char *var)
 
 int net_init(void);
 
+/* Called when a network operation fails to know if it should be re-tried */
+int net_start_again(void);
+
 /* NET compatibility */
 enum proto_t;
 int net_loop(enum proto_t protocol);
diff --git a/include/net-legacy.h b/include/net-legacy.h
index bc0f0cde9fe..51780999a88 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -347,9 +347,6 @@ extern int net_ntp_time_offset;			/* offset time from UTC */
 
 int net_loop(enum proto_t);
 
-/* Load failed.	 Start again. */
-int net_start_again(void);
-
 /* Get size of the ethernet header when we send */
 int net_eth_hdr_size(void);
 
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 1e60fa31bfb..5d862e038a9 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -21,6 +21,8 @@
 #if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
 void (*push_packet)(void *, int len) = 0;
 #endif
+static int net_try_count;
+static int net_restarted;
 int net_restart_wrap;
 static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN];
 uchar *net_rx_packets[PKTBUFSRX];
@@ -339,3 +341,42 @@ u32_t sys_now(void)
 {
 	return get_timer(0);
 }
+
+int net_start_again(void)
+{
+	char *nretry;
+	int retry_forever = 0;
+	unsigned long retrycnt = 0;
+
+	nretry = env_get("netretry");
+	if (nretry) {
+		if (!strcmp(nretry, "yes"))
+			retry_forever = 1;
+		else if (!strcmp(nretry, "no"))
+			retrycnt = 0;
+		else if (!strcmp(nretry, "once"))
+			retrycnt = 1;
+		else
+			retrycnt = simple_strtoul(nretry, NULL, 0);
+	} else {
+		retrycnt = 0;
+		retry_forever = 0;
+	}
+
+	if ((!retry_forever) && (net_try_count > retrycnt)) {
+		eth_halt();
+		/*
+		 * We don't provide a way for the protocol to return an error,
+		 * but this is almost always the reason.
+		 */
+		return -ETIMEDOUT;
+	}
+
+	net_try_count++;
+
+	eth_halt();
+#if !defined(CONFIG_NET_DO_NOT_TRY_ANOTHER)
+	eth_try_another(!net_restarted);
+#endif
+	return eth_init();
+}
-- 
2.43.0

