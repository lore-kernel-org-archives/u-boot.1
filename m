Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2017ED68B3F
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 17:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CA1188B16;
	Thu, 14 Nov 2024 18:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w3c2Ur5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E90D89112; Thu, 14 Nov 2024 18:10:25 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F2F688AE8
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 18:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so8073115e9.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731604223; x=1732209023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=In9lyNBUo93v9l3e0XRU+toCJG6eH5W2D5roPezacjY=;
 b=w3c2Ur5OTN7ogFyP49vXeQqBKSTDYoi7/kZ9R9ePONzuiDsil/qXGvaFvURBUhC8sj
 XuYKRmqvyOcWe+sVpWmnxQk6eIu4+oHhkYAWIePl7Vqz2rPXqyJ5+B9l/fuI56hbgiq3
 q6gOdLf56XYXjbUz+of6IYU87yJ91Mg0VE99wgY+wtBK97xOOxTfnH1w7diJDNSbkgK1
 i3JpOiC0x3nfDrZHJl8cj66Z4R7U1/Lic9Ugg648Ooxbl46eOO1TiCoXMBhFWI/EiWl3
 47QmIiMfZjCXesAH39NcoCKaaty833SKCpKe8T7l+TQfWdxxfTQWwHCn1JfkCaIFh2VO
 0R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731604223; x=1732209023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=In9lyNBUo93v9l3e0XRU+toCJG6eH5W2D5roPezacjY=;
 b=pI5Q6WuYkacQh0j5zbwQ+ARK+YeDfg43KIhFFENo/Pnqf5Y1YO45hFAo0Yw5RlpbnJ
 t53G2IRgUW1B8rwcYBLnPqGCt7jGprjVvRJsPElTtYsHnagoifrEJGzQHlefe1xBL5xp
 R1I5rSzUHjTOjbg47TGbe9h60qxRMb1HgoqH3j1XDKBvrpzQl/AHOFcpFbSj4QqXzp5D
 l3wuACfHYAEfwuGDgyGpT3dsMdBOpBgW6iPIhK9OZq5/rk/oLPjOjhu4WA7skw5fbN70
 tfhmdrWJWEb2IIjhwGhcuYjx+NUup513arFNNRqu81eGwptpS0+pxhXeV65d0kew/yKN
 EOrg==
X-Gm-Message-State: AOJu0YzqhE+XtZiDZhJ8ji2tDGmIkUx+mKjZAJdpHBhfjIjBaZgUKVM+
 MoZ6Rhzic40YH7zaYU3yCkXanMJC9rmM03oy/NL8xKTf0Qj9SJipTYFYH640d4MChgPbJXyVCLv
 M4dI=
X-Google-Smtp-Source: AGHT+IFyWUUaPLo4SmzLspL/e3icaUq6Eu+jwu7ant9Q4My2uh/4HHak/zq/1VZBX3RHz3E/y7b+5A==
X-Received: by 2002:a05:600c:3b82:b0:42c:bb10:7292 with SMTP id
 5b1f17b1804b1-432b74fc98cmr210819855e9.1.1731604222797; 
 Thu, 14 Nov 2024 09:10:22 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:3895:27b4:20b7:7653])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab7206csm26433175e9.7.2024.11.14.09.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 09:10:22 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <lucent@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH] net: lwip: dhcp: support arguments for TFTP file download
Date: Thu, 14 Nov 2024 18:10:01 +0100
Message-Id: <20241114171002.2073594-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

The dhcp command is supposed to have the following syntax as per
"help dhcp":

  dhcp [loadAddress] [[hostIPaddr:]bootfilename]

In other words, any arguments should be passed to an implicit
tftpboot command after the DHCP exchange has occurred.

Add the missing code to the lwIP version of do_dhcp().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/lwip/dhcp.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 23b56226921..6f987e469d6 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -111,9 +111,34 @@ static int dhcp_loop(struct udevice *udev)
 
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	int ret;
+
 	eth_set_current();
 
-	return dhcp_loop(eth_get_dev());
+	ret = dhcp_loop(eth_get_dev());
+	if (ret)
+		return ret;
+
+	if (argc > 1) {
+		int i;
+		char **tftp_argv;
+		struct cmd_tbl cmdtp = {};
+
+		/* Invoke tftpboot with the arguments passed to dhcp */
+		if (argc > 3)
+			return CMD_RET_FAILURE;
+		tftp_argv = malloc(argc * sizeof(char *));
+		if (!tftp_argv)
+			return CMD_RET_FAILURE;
+		tftp_argv[0] = "tftpboot";
+		for (i = 1; i < argc; i++)
+			tftp_argv[i] = argv[i];
+		ret = do_tftpb(&cmdtp, 0, argc, tftp_argv);
+		free(tftp_argv);
+		return ret;
+	}
+
+	return CMD_RET_SUCCESS;
 }
 
 int dhcp_run(ulong addr, const char *fname, bool autoload)
-- 
2.40.1

