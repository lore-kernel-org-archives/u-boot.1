Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43384C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83C3F82BA2;
	Tue, 15 Apr 2025 23:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UXrA/d+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C37082B97; Tue, 15 Apr 2025 23:18:34 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDDB78209C
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso31290695e9.0
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751911; x=1745356711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ANPgtDsQY053tw/r36729R0Xr04aCUCw3FmvtbCeqo=;
 b=UXrA/d+ZwDN7lz+iGeYt7erqR+fzyakpW4TOduKX9Tm5jChWYXd5p9RJZtu7RSqXSN
 0isFhXtSICBIrzZICZK0K4xTIdKm4iXorG2HCeMSST+wA34RWSPkVuyoxQmBwbp+EuPt
 0fJu5ElVFJWnVWnHo8cbesoVDlfVJTNwPTkYCRnjGn2MiPxQ2Y/PFqEz9OuQKUj4HBKK
 wfLgVEDIITjA+Q3zAaSe+zWzh04XXfLTn9O7rzk3AZnNQG7h9VWX6U9OASZctz7MzfHI
 J2hGq674kg+b8LcYw5SM+kbGljbFP2B7jSKF8sJctB6l9/TMahL3vd7i0+WC4JxlcHPW
 clgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751911; x=1745356711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ANPgtDsQY053tw/r36729R0Xr04aCUCw3FmvtbCeqo=;
 b=Io8xQEhbANoVZEqj4mRO/LTA1//NnH8YExaCiMNL3wEMs57m/q3SpPNzJAS7xUsfcB
 +Pgsl8ZQjlnkRk/zZb2Ml7xc/EKWSJv4BGCOHC9xXtlYfbLxjhNZRdifrIlYYKnFPd0d
 29Zzbr1kTDm/IUC8a+OoCd33zP1SedFupMqzTKSVepnsH1C06MAoy8GifLB1cdKI1d92
 o+9E2rns79K3ZFl1AxMvYab+0Wi4VRpQ9Mp3IUyqdxSZBV4+CvLSxrmIiXcKcEalczRK
 mA4+vxStj9QWAZuK+VzHURf+5PaRNRsOkZPpLxc1kQOHnDatB5ctAHCNvdLRuJ2DA6cm
 URQw==
X-Gm-Message-State: AOJu0Yx4OWvxasRhEk1cBEBG0aa4PqIhqh0Oyv265hcb6O1qeMHiWVoI
 S0hOplRZTG6nfdgt0giLbRKo1A7T1il+rdWWsKXAl+9a0gABdz4tdDqHxewZdnI6RkytqqD0grP
 WAXY=
X-Gm-Gg: ASbGncuIlUk8jTNXyF/skyZFC1eXuWS5Ae/G/+44gjG8668u3lcYZ9LrjihwvxPZXsm
 owDHDhpPWcMbidYWCgeM2i8N7Qa4osveVQoZMwE98FXvQnD2u44HMqe8ytt/+Q6psBDQba87o9a
 Lw04hfbnFG+Pb/pezkkyiJ0FaZTG5WbnEJpp7R4JB1jmtRWoTbblPV7mgfNtXm67OU2xs224J4k
 0NPOvTbpIKdnH8mvrKuiTw5Ma4Q0WrUeVvVIteOhoJqQqVnhzJZ7MF4kX8cmF9qtkkt5Sz3q5V9
 e82Q8A3mlZscRQp43VrfZHtzKgrQrvkM/i8QwTDkgKrCCwCn
X-Google-Smtp-Source: AGHT+IFOk4zD7m5ZN/lDLm4E0JyXShT9wK2JS0cw+ouI0hxjvKq5LxvG51p4K12q5lRYrwoiaJOINQ==
X-Received: by 2002:a05:600c:1990:b0:43c:fe90:1279 with SMTP id
 5b1f17b1804b1-4405a0f74dcmr4122895e9.21.1744751911085; 
 Tue, 15 Apr 2025 14:18:31 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cce3sm15530917f8f.74.2025.04.15.14.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 14:18:30 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/11] net: lwip: provide net_start_again()
Date: Tue, 15 Apr 2025 23:17:37 +0200
Message-ID: <20250415211819.1254435-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415211819.1254435-1-jerome.forissier@linaro.org>
References: <20250415211819.1254435-1-jerome.forissier@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/net-common.h |  3 +++
 include/net-legacy.h |  3 ---
 net/lwip/net-lwip.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index 30860f5975a..0b7edd7d76b 100644
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
index 6748008736b..d566f9f8e6b 100644
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

