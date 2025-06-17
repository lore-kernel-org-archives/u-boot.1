Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC58C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00ACF82D66;
	Tue, 17 Jun 2025 12:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XOHkfnjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95DB82D06; Tue, 17 Jun 2025 12:07:52 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D746382CBC
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so3124470f8f.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750154870; x=1750759670; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJHk/OIQAK7p2slUDuw7khsvXEgoqUGdrCgMhts+zoA=;
 b=XOHkfnjjH+9IFlNbTdqcLdkHcNsmD+F03MgOX8v4IdPJIBBzV4gbMntR1wWDjLd2XS
 9epGbGHUHn8jbDj6WgNXophs29YUw0ROTJrqml9VALsu5KhGwYrZf95Sv0DL6OkQg77e
 F8J59wE3apd7TnAEUdMgSyyOtfht//X48DcJxIBd5WvrJ7RCWvZpUEhUMIxWxlstD+m6
 xvbQtwaSDkdmagEs+sxb2mhbkCwN1CnGLalNAenTcPCItYic28S9uf/Gwvhuim9b5ftp
 qpWNgaudhDnH5lKpVzXQtCU4Bq9REroRzUMIP/4oRthagkpksKTdHTUORw6s4tA1x+fp
 9Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154870; x=1750759670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJHk/OIQAK7p2slUDuw7khsvXEgoqUGdrCgMhts+zoA=;
 b=MhQoMhjIgCG6uTuVKclxUx+CIxXRAN6nPKgyr4PXerEiUP18SO1abKSUP2Wy8WC3R4
 vO9ltHxufclD6e/57g/S355vRoJop9UyKkPLxboFtQzPmiQI5Q0DRMhpwF7GNbT4jrSu
 n0ogN3YUe4HnQVb6bknWCV32jOUPR//TnU/DCRtgS+s8EBkFiY6ykg3PFldbg0OkxplI
 pHe3FjTSL3MZz6DrStIY/L9OhfgYpEVKa8x/+ralJD3F3rmCYqTG9Ng8AHuKUKCYC7YW
 41TT8qbHLAZ71il8H5qWIDOmBKrynciF+tyigqnt+Rsm5LvDh9eZJ86xkog5gD+HXSmJ
 pwbg==
X-Gm-Message-State: AOJu0Yzpk6DvW30hNAS0vgFr3PRFi3kEv3rY46EsT6y0gLGQl2AXMak1
 iMYL+eE44P4ssT2oZ3uPxV5Uma20jG/EL9E/xe0B2PKgDCjxDhxoWbAyBUT2CRbSriw+0GAvEbr
 3WSdA
X-Gm-Gg: ASbGncsPjYXtgzpZuFCi/ZEt1waTqOL4AcICOJLwwmBeUc7HPinoW1o21avNbbZMoDA
 vefVtiUQUGh+lVotLVideRdGjDEprjhPj5Oz6aUHp4obRFAtrEFpKF7vLbkZEmBZc2nX8rxJ8Rz
 lf8sI3wZWDcfT8uhdvcVrYVV+Yw1+3zq5QjmLvReJgdRV0KkywfEAUJtPtZj8VzD2oSSrJ3zJuV
 dIdoCQm4SYd4TrZ1UenQ5tUI1IQ2iLoQLFyfn6z7F2xkIFoLtgqFZowpDNHTmJSAb2UZmI/Xdw4
 Crf2Bbz708Sd9jDKZAY72yb1yfzLxEFn3ivyHHgsbIf+CzssXszH7HZ91TPpvPt5u6KC1aqaY86
 QohU83A==
X-Google-Smtp-Source: AGHT+IGmLBtO16ydnpgQvjYIFwhxLFQGi8ro4dV8wbjqAvTJ/uG7UukPVQILP1q6Hkho8cT7hy+hlA==
X-Received: by 2002:a05:6000:230e:b0:3a4:ebc4:45a4 with SMTP id
 ffacd0b85a97d-3a572398fbbmr10465363f8f.5.1750154869911; 
 Tue, 17 Jun 2025 03:07:49 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b61071sm13582412f8f.90.2025.06.17.03.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:07:49 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 08/13] lwip: add net_lwip_dns_resolve()
Date: Tue, 17 Jun 2025 12:03:58 +0200
Message-ID: <20250617100720.2544758-9-jerome.forissier@linaro.org>
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

