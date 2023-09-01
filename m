Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0918CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 10:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B688688B;
	Fri,  1 Sep 2023 12:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IUAxSKg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9682B8688B; Fri,  1 Sep 2023 12:26:36 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F212086900
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 12:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-565f86ff4d1so1256134a12.2
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 03:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693563990; x=1694168790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEZxobHc4/hRgzipngl1BkvsvqKAXCkdxt0x/nbRs0M=;
 b=IUAxSKg0oTtSthQeU/N5h2uw4dQFHGKRTos/3w439hbCUa5t5N1/bVSf0p3dN89EwY
 zZuhUkRcQxlgfGocgzLMaaIhRscto2cC4Zby45XYr6CDU+sz+kkSXenfwCqgT+V6IRhj
 9uV6FCeTKszfGbBE4yIWJxeTyrqrDcE6uX4vF0FVsfLeln42f/BzoxfUnpGnG+ZeQQJO
 4cTvb+ib6bo13eYOqyjSLLHiVr11NtQd7n0hVNfRtaxlYuhVXDv+zsXV0RWP4Q10Xv20
 aniR7dVjASdJjWsWo0Uz4XLNpaLR5XVA6djBVgvBEaz2ufYsJe634fXizryKliKn53uu
 NmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693563990; x=1694168790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEZxobHc4/hRgzipngl1BkvsvqKAXCkdxt0x/nbRs0M=;
 b=F4jVQoylVkV3EV3WmZmTKzDvDs43C1cnCAbaOemuXF4iOB3kJoow3cqau9nCenQANF
 Qg8c44nGQzr2boGaHseeJ3Pk8p79TWM4V6GtMCOdltflMACLR1SsQNE/4L7umfTmDN2b
 BtuqmaIdaJc/N0zs2ytmMBLputjiq/AFgGtvscE1VKHBlfCg9RRKM4ylqHnOvx4KOHAC
 aWXj/rB7AbO/gmLkJlzXIk4R6oOaVIYMijGNuKFWJ3ROGX5H7nBQviXDpSpXz0WwkslO
 ySPW3uzErRSaiASPOfX8pcuDSEKRqHMuozZYLl9aOl5+pZiF/E8dxjEqHAs9jcR5lnp8
 aIag==
X-Gm-Message-State: AOJu0Yym3HQ5/VqCjf3C/wLTkTIi+PcpBt7BHpuBy8Peyg3299ASN8YY
 OthHpXRPDut9nhY3dxwL+1iYO2pd1/2PKWIaX9c=
X-Google-Smtp-Source: AGHT+IH5geGl5T/5vV0byBnYq5pYoqo9EKUsQeCHndGUHoe0VlGcm3qjI+E0BTqd8Ad53bCfo/lEkg==
X-Received: by 2002:a05:6a21:7903:b0:145:6857:457a with SMTP id
 bg3-20020a056a21790300b001456857457amr2016897pzc.4.1693563989779; 
 Fri, 01 Sep 2023 03:26:29 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 d15-20020aa78e4f000000b0066ebaeb149dsm2699753pfr.88.2023.09.01.03.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 03:26:29 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 2/6] net: wget: add wget with dns utility function
Date: Fri,  1 Sep 2023 19:25:38 +0900
Message-Id: <20230901102542.609239-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901102542.609239-1-masahisa.kojima@linaro.org>
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
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
 include/net.h |  4 ++++
 net/wget.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/net.h b/include/net.h
index e254df7d7f..b4bbf95732 100644
--- a/include/net.h
+++ b/include/net.h
@@ -926,4 +926,8 @@ void eth_set_enable_bootdevs(bool enable);
 static inline void eth_set_enable_bootdevs(bool enable) {}
 #endif
 
+#if (IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
+int wget_with_dns(ulong dst_addr, char *uri);
+#endif
+
 #endif /* __NET_H__ */
diff --git a/net/wget.c b/net/wget.c
index 8bf4db4d04..5718f1cf92 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -15,6 +15,7 @@
 #include <net.h>
 #include <net/tcp.h>
 #include <net/wget.h>
+#include <stdlib.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -500,3 +501,56 @@ void wget_start(void)
 
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
+	strlcpy(net_boot_file_name, s, 1024);
+	strlcat(net_boot_file_name, ":/", 1024); /* append '/' which is removed by strsep() */
+	strlcat(net_boot_file_name, file_name, 1024);
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

