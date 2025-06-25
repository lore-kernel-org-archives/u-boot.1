Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AC0C7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F4E582DF2;
	Wed, 25 Jun 2025 15:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fJ8v3gjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 885DA82EA3; Wed, 25 Jun 2025 15:21:45 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB6C582E26
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so3393193f8f.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857695; x=1751462495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJHk/OIQAK7p2slUDuw7khsvXEgoqUGdrCgMhts+zoA=;
 b=fJ8v3gjs+rjRuURqlZPeQTyvC8N1Fc10JKnsUD/MbtqX2mxCIiKlaI2O3Hfj+GMNII
 Z8HKWSSsCKrm/IgEGG5rCnpW6CQiq6cEM6yqB6cNmc8mq7jmuqtQlI1EX1+Dptbn2M1j
 oU/ov7lR2+K53yQuI2353yABeUeP10PL8dtGn2KWVWJfq06lgA8iny6FoOwOnCh6uXhO
 PbBfXyPQL/OSJY1sumd983pgTBsj4dxWqPMCXw8PrgDmIr8WHwmTWPE4JE0oTx6GbgT0
 xihIc9o76vkrQInsa1iVRDrYaEYh3p93U8GtEWf8mzB6b0w9Bm+An54dfsUGjKae0CHk
 W/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857695; x=1751462495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJHk/OIQAK7p2slUDuw7khsvXEgoqUGdrCgMhts+zoA=;
 b=TO71JXWGsBS5l2PTNs1uJAqoW4WfSJ3bWhtPi9SsK0+NzqAnovGzknc1Dr+fUdlAp6
 JyI1tCw+Apb6iOyx0qUnQO5Q/4QUq055cnrYsokDf61fVFSRzLhP2TfKPy4OCHtriP3E
 78UgtAQ+q8i5MExu6riExTq1Aner0nzOi8n1NHWirq3++hQAlf+bfmZH7iCCfPpHuKPF
 X8vAR7p5SXH1Zj7+d3yOAK1gwBhIfIXwfwkLqYhy7u7CIibx8V04bKNCknRHP9v6b591
 mRrSqTjbr2kDBxueQDc66y94Ullj9fHHa3GQGJWX+x4uaHqCcDcApZCz52YYUnJFv5nv
 oUeg==
X-Gm-Message-State: AOJu0YyGx64FdTLhrqE3N784YsaKbIyWagN8xVdj04mGkMQ3smb88311
 XastcKdpoYRkA4sVjPHuFmE1PA7CwyPzSNnof9QTccmwjfvo+Ux5IkS8q9gRJec+2Dh2UndjUei
 qjRvHfHs=
X-Gm-Gg: ASbGncsc1vQZj+h7EvRK0uRpGGeTwYdC3G81U530oxQiq5l99oXPyHkDRc4aM17C8Il
 9LFlluS7wLmqPisKiV8MZcb6pVcxS5txoT2B+vbzPhGBMXCE5YRKg/2wQvF+BllzClP3wYW5ECB
 FkP36o+khQLHqZpujpE7Nt9tX9QMG50Mv5ED31z3Z6coVZFdVYD219rT2m49ihwo67vJf6jkZbR
 XEwyd9z7IQqrs/vY0426F67N7KAsVFFunPNFt9BnIvOCKkiXa2TTXEmb948+RsCqW6ZzVnqHEqg
 KfIO8AKBWXHyFrCFkhNjWGbilaPLsjnzUMnPq9219wxSisf5tM7qJ6cRvF+ZVTf0lI0Zz/ukxq/
 707xKlA==
X-Google-Smtp-Source: AGHT+IGjw8jiwnuRlZalbeO+JHY5pYeSgUJK9MFcV9KIDcov4gXRxpPt5MiU2rWF4kYXkYJQJZrLLg==
X-Received: by 2002:a05:6000:4406:b0:3a5:1c70:5677 with SMTP id
 ffacd0b85a97d-3a6ed61a962mr1727098f8f.7.1750857694810; 
 Wed, 25 Jun 2025 06:21:34 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:34 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 08/13] lwip: add net_lwip_dns_resolve()
Date: Wed, 25 Jun 2025 15:19:16 +0200
Message-ID: <20250625132108.3292932-9-jerome.forissier@linaro.org>
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

Add a helper fonction to convert an IP address (supplied as a text
string) or a host name to an ip_addr_t.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v2)

Changes in v2:
- New patch

 include/net-lwip.h  |  1 +
 net/lwip/net-lwip.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/net-lwip.h b/include/net-lwip.h
index 9c1167482e9..299df29ace9 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -37,6 +37,7 @@ struct netif *net_lwip_new_netif_noip(struct udevice *udev);
 void net_lwip_remove_netif(struct netif *netif);
 struct netif *net_lwip_get_netif(void);
 int net_lwip_rx(struct udevice *udev, struct netif *netif);
+int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip);
 
 /**
  * wget_validate_uri() - varidate the uri
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index f05c4cd3f64..c9a7114bbff 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -6,6 +6,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <hexdump.h>
+#include <linux/kernel.h>
 #include <lwip/ip4_addr.h>
 #include <lwip/err.h>
 #include <lwip/netif.h>
@@ -315,6 +316,44 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
 	return len;
 }
 
+/**
+ * net_lwip_dns_resolve() - find IP address from name or IP
+ *
+ * @name_or_ip: host name or IP address
+ * @ip: output IP address
+ *
+ * Return value: 0 on success, -1 on failure.
+ */
+int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip)
+{
+#if defined(CONFIG_CMD_DNS)
+	char *var = "_dnsres";
+	char *argv[] = { "dns", name_or_ip, var, NULL };
+	int argc = ARRAY_SIZE(argv) - 1;
+#endif
+
+	if (ipaddr_aton(name_or_ip, ip))
+		return 0;
+
+#if defined(CONFIG_CMD_DNS)
+	if (do_dns(NULL, 0, argc, argv) != CMD_RET_SUCCESS)
+		return -1;
+
+	name_or_ip = env_get(var);
+	if (!name_or_ip)
+		return -1;
+
+	if (!ipaddr_aton(name_or_ip, ip))
+		return -1;
+
+	env_set(var, NULL);
+
+	return 0;
+#else
+	return -1;
+#endif
+}
+
 void net_process_received_packet(uchar *in_packet, int len)
 {
 #if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
-- 
2.43.0

