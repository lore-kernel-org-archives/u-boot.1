Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538FDC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 16:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96BB98747A;
	Thu,  4 Jan 2024 17:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FpDw2PQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3040587575; Thu,  4 Jan 2024 17:01:38 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F94B862DA
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 17:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d41555f9dso5848235e9.2
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384095; x=1704988895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oVnIuD2Mh6WGEVfGg+7k2hwkJY6Yq7S2GdbmIRPY4sM=;
 b=FpDw2PQupDeVPwkTpzLD2ACGUa/L+U7ObJdJToDhNZP52go0kz+zK/GyzOOMvvLvvZ
 htoSYx0CbzyfNIeTreLFd0y29h0BurU/63kgqVtDydnWHxqoVlaGQ+Pd+rMXuGoDnm8O
 oJKtZkf1BM+uBK1Ueh5YA13ag/ymp4H++cfBT/Ch8EGumCLLLH5C83pxEAScsv4StzQY
 eCfRId60Cco9bHafyp/dw0cOPOKjyHllmnKsyTn5UlXkDzOwfkrhpMGujVi8tOvCl1dt
 NGCEwvdEHv65QeTGYoaV44nUWDKcyzqc0TsjbSBbPulCOPO9Nb6MDoC7ORrXb9OWdAsH
 LBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384095; x=1704988895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oVnIuD2Mh6WGEVfGg+7k2hwkJY6Yq7S2GdbmIRPY4sM=;
 b=iRXGwx9wZSUwmp7NhuHjm8ZKvVQbsQdjmcsyZe9dXfQl0DY9RLM5++ro0k3ezdYKf1
 onuwAn+GdjmmFwnUTMuaXq0pkyBalrSt6U1/wvTnnQIrpIT05YLM7e7EKhQJ30Tl1ice
 ndnAF3vgyfXGaf4yZzXV4RVQS/d3IYJ+mxQxxOaMO25joGgHJ2ahf+V5baqIAPR09Fuv
 R/1vLaN1zVmf+DIBGI232ab4m1QW7Vb8YhGYBtmTvK8EyzNl9xasNCvPhgRSDk5Ubn/H
 p4WpGJqcOZ73imRX+BnMqErMq1Xv7tXbr2MXbfkgHhPiaG9xp0bzvb0uJTLbfpC6X2eI
 rP/Q==
X-Gm-Message-State: AOJu0Ywnkont4dVuRZZrtxKezI9v7mgaosD6KyJtsgV/1iVUHoUt3UHS
 8DZ0pbv7RtETzOjI7IFERfwXDFWVNCdBoA==
X-Google-Smtp-Source: AGHT+IGDotqEoujBEMiooujc5Ci3lhiCpiZ8JpyIaLjqj7tpd3t5NLGM6o2Ui+/cebv6si+y1HRC0A==
X-Received: by 2002:a05:600c:4c16:b0:40c:32bf:20f with SMTP id
 d22-20020a05600c4c1600b0040c32bf020fmr464061wmp.147.1704384094963; 
 Thu, 04 Jan 2024 08:01:34 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-230.as13285.net.
 [92.17.96.230]) by smtp.gmail.com with ESMTPSA id
 je2-20020a05600c1f8200b0040d934f48d3sm3986459wmb.32.2024.01.04.08.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 08:01:34 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH] bootdev: avoid infinite probe loop
Date: Thu,  4 Jan 2024 16:01:33 +0000
Message-ID: <20240104160133.284685-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.42.1
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

Sometimes, when only one bootdev is available, and it fails to probe, we
end up in an infinite loop calling probe() on the same device over and
over. With only debug level log output.

Break the loop if we fail to probe the same device twice in a row, and
promote the probe failure message to log_warn().

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 boot/bootdev-uclass.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index d01d603700d9..8dde1e18cd6e 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -636,7 +636,7 @@ int bootdev_next_label(struct bootflow_iter *iter, struct udevice **devp,
 
 int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 {
-	struct udevice *dev = *devp;
+	struct udevice *dev = *devp, *last_dev = NULL;
 	bool found;
 	int ret;
 
@@ -686,9 +686,19 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 			}
 		} else {
 			ret = device_probe(dev);
+			if (!ret)
+				last_dev = dev;
 			if (ret) {
 				log_debug("Device '%s' failed to probe\n",
 					  dev->name);
+				if (last_dev == dev) {
+					/*
+					 * We have already tried this device
+					 * and it failed to probe. Give up.
+					 */
+					return log_msg_ret("probe", ret);
+				}
+				last_dev = dev;
 				dev = NULL;
 			}
 		}
-- 
2.42.1

