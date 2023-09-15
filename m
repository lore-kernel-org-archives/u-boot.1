Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D31EE6454
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 10:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED1328653C;
	Fri, 15 Sep 2023 12:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="miTb7dqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A32D86503; Fri, 15 Sep 2023 12:17:42 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66FBE864D9
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 12:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c35ee3b0d2so15555115ad.2
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 03:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694773058; x=1695377858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqWSkntABQtwEoqV+tvayCqBU8eJJ8/peN3qcF7tSvA=;
 b=miTb7dqojtJJvKHfK3trstXWymAb/U0J1r8+1zRhbRZtoslvOev/gMRoFfYnSe3xWL
 eeTF6sJMWNsNaHnz0ETOSBJkR1KbFHGamHdjMcUEE4bOzH3XuWmgEHVHtbrGEfmSOxz8
 EYA1hbxJ07LnxY2vYNe2WJVs1UciMrn3hhFNKCGkFbeV95IIc3d/JdIwjdVcFJzXZO3p
 bgrfbS8eoVMrKP+s7fc47hLBZq4ZKP4fmmjFEMXBkyzwL3P1fRnCXdebgy11nYl/UeL0
 b7FYdgJTxrUZBSl6KYunIwzNhnlrSpAPTdoFG9pCXSVAB2/nWTO4X8vw48pA1pNHtUiH
 Rqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694773058; x=1695377858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqWSkntABQtwEoqV+tvayCqBU8eJJ8/peN3qcF7tSvA=;
 b=OTMR0kcylTDKSTFaIXbU6Za0OZZF6h8iWM/z0edcq1gvquQrLUW9sZ0qspO9D2K8vF
 DPdqkwDqIDQsXZ8IWRIpJFong+GqmK9gaPpJUIAb+0PaHGzk7/k8zgBbsYJft3cLgUqK
 A9VAuPtHT2QUXLN0oWWv8i58bYu0YzkuuG6ANJoaK0gYM6ZODZgmds72HZUdtxc/w1aD
 yIEiHkaV8pSQdo8Ub2W44Z2u34n3S3Rh4+r45qqyCO907K4Oo5J8OMOr0W0hmhohRb/7
 tiQMwy6fwPDYy9fHcOTMa8yb5ud94PymyvmNT+ip5w/eJtHjBLQNvmz/1aIKtE2/KXOr
 osPg==
X-Gm-Message-State: AOJu0YyOEOdgpEdUteaK0N5/C0wsdzfqBqAwzxhJ8T4kaUrVc+ReDN9P
 uHD5CvjruTwJZJFjEhl+n0suhpa1bvl4eyRuugs=
X-Google-Smtp-Source: AGHT+IHj4SoF1HbMKvUvXaSuQZhOMLrV3MMPK+D7rYF1tEkUpWf6pu29845+tpiUZ++h9QEOISuR3A==
X-Received: by 2002:a17:90a:fd84:b0:268:ac99:4bb4 with SMTP id
 cx4-20020a17090afd8400b00268ac994bb4mr916646pjb.46.1694773058424; 
 Fri, 15 Sep 2023 03:17:38 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 t14-20020a17090ae50e00b002676e961261sm4630920pjy.1.2023.09.15.03.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 03:17:37 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v3 2/7] net: wget: add wget with dns utility function
Date: Fri, 15 Sep 2023 19:16:35 +0900
Message-Id: <20230915101640.1166332-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
References: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
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

Current wget takes the target uri in this format:
 "<http server ip>:<file path>"  e.g.) 192.168.1.1:/bar
The http server ip address must be resolved before
calling wget.

This commit adds the utility function runs wget with dhs.
User can call wget with the uri like "http://foo/bar".

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/net.h |  2 ++
 net/wget.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/net.h b/include/net.h
index e254df7d7f..b9cba5244a 100644
--- a/include/net.h
+++ b/include/net.h
@@ -926,4 +926,6 @@ void eth_set_enable_bootdevs(bool enable);
 static inline void eth_set_enable_bootdevs(bool enable) {}
 #endif
 
+int wget_with_dns(ulong dst_addr, char *uri);
+
 #endif /* __NET_H__ */
diff --git a/net/wget.c b/net/wget.c
index 9690e4539c..bdf940a315 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -15,6 +15,7 @@
 #include <net.h>
 #include <net/tcp.h>
 #include <net/wget.h>
+#include <stdlib.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -504,3 +505,56 @@ void wget_start(void)
 
 	wget_send(TCP_SYN, 0, 0, 0);
 }
+
+#if (IS_ENABLED(CONFIG_CMD_DNS))
+int wget_with_dns(ulong dst_addr, char *uri)
+{
+	int ret;
+	char *s, *host_name, *file_name, *str_copy;
+
+	/*
+	 * Download file using wget.
+	 *
+	 * U-Boot wget takes the target uri in this format.
+	 *  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/sample/test.iso
+	 * Need to resolve the http server ip address before starting wget.
+	 */
+	str_copy = strdup(uri);
+	if (!str_copy)
+		return -ENOMEM;
+
+	s = str_copy + strlen("http://");
+	host_name = strsep(&s, "/");
+	if (!s) {
+		log_err("Error: invalied uri, no file path\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	file_name = s;
+
+	/* TODO: If the given uri has ip address for the http server, skip dns */
+	net_dns_resolve = host_name;
+	net_dns_env_var = "httpserverip";
+	if (net_loop(DNS) < 0) {
+		log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resolve);
+		ret = -EINVAL;
+		goto out;
+	}
+	s = env_get("httpserverip");
+	if (!s) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
+	strlcat(net_boot_file_name, ":/", sizeof(net_boot_file_name)); /* append '/' which is removed by strsep() */
+	strlcat(net_boot_file_name, file_name, sizeof(net_boot_file_name));
+	image_load_addr = dst_addr;
+	ret = net_loop(WGET);
+
+out:
+	free(str_copy);
+
+	return ret;
+}
+#endif
-- 
2.34.1

