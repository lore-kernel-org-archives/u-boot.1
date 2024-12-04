Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E5BE7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 03:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A14A8962C;
	Wed,  4 Dec 2024 04:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="huMyQB1f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE778962C; Wed,  4 Dec 2024 04:05:46 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 117F088EA3
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 04:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-215cc7b0c56so11255035ad.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 19:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733281542; x=1733886342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzf/FRun+T+UV7jsvIfOOsH5b7sg0vCB+pyVwxB2QAc=;
 b=huMyQB1faVyUti8x7WfixpJwhVFzcQoZAdh8uOqtWdIinHjSG6HF7kjcPebxI+YTrF
 unQp3gOFGI8tnrjIVmOcAyPy+naLkWmjYmClW6oY93ClfRtQS8zY6jwmfcirQgtXc2AQ
 oo6z8K8s0rFUisXHLmas1rsL0yF2luz/cYxsxG9ZFIwzIvQO8pyHDMnH+52psYZ7Nk6m
 9MxAqNXHL5e3N2RtqwINBI/rb/FZC5HpvUfQOEg3pzadgU56Nnu1WwezsuM+tyQGgnZT
 Bh6gGf2HXm49hrJCk2LSC8bQswMBohNLscPCtNHj+KZ8WMjPMIiU1p0W2Y4a8LQRNzzH
 Gy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733281542; x=1733886342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzf/FRun+T+UV7jsvIfOOsH5b7sg0vCB+pyVwxB2QAc=;
 b=C1ZhnInD8vOGKX93Gj85cRM8jReExJb2ut/IeCUe6WSxc0f/gm2QiwTKD5nnSQMvBy
 6n4WncIBwPq9+FMlkhQoOnr3rr2PhbCzi6gLkTS4xAegr76ni6+AjM+o8otjm5OPQiGc
 f0xqIrLUquyKkS8gIsKlKs/WuU9wOdfsV04RZ3XW4o2ehNojbEVcVFPA1fyPRC/zztQs
 iO2luA74F28cQ0aXDnZ/PMW4RqFC9vsY8ML1Njs3XQmwyeQQraAGsfNiH4IrB6OeYdvg
 DfGcdM0cYOqEr1VXkI1OZRwJfeLR6dUMdhocOdeSPFfPpZTT2Erqs+9VsiP83bEuIDve
 VjGQ==
X-Gm-Message-State: AOJu0YxGmFFgdr/3KBGws6UfYGKUuTBaxTdvM4F4oyRRpGDpX9A85lmS
 T/jeUkbpvEdP7Df1oA4eVhG9CD1sHr3tkOyeih6Oi7gMAcMkUO3IoBL/g3HHICc=
X-Gm-Gg: ASbGncsIlCjnI6xMBl1luVYO+fEeZcSVBgOvHdySD9jqwghA/Sc8za1qt6Atuke2U3c
 65FhPU+nKduy0v/cr/7LFWfe7qL4S/ex8Erqa/62rR9HUI1EnnstSTeEgPyyEtCLpYcrw3rQdZH
 /Z66L4f62Wp2B5lVq9KTimZQKVOwJNLcxnETzZhrC/4Ki1j/cqUtnHdyuf63MCPt155r7KO1qAb
 qyXWMEYZqF+B+gLwNfN39nmfy6b+QeCM8kFwbAwyMM=
X-Google-Smtp-Source: AGHT+IGRAu8pFoqKwiVB/BBFnDEVf1QCCOXQej6smI4+OyyG0bl+Fv4isafufR44EqU7kNIpuHp35w==
X-Received: by 2002:a17:903:2305:b0:215:75ad:63c5 with SMTP id
 d9443c01a7336-215bd0ed042mr66537185ad.22.1733281542466; 
 Tue, 03 Dec 2024 19:05:42 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215714b4f77sm56196335ad.202.2024.12.03.19.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 19:05:42 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v7 03/14] efi_loader: device_path: add efi_dp_from_ipv4
Date: Wed,  4 Dec 2024 00:05:18 -0300
Message-ID: <20241204030530.2099776-3-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204030530.2099776-1-adrianox@gmail.com>
References: <20241204030530.2099776-1-adrianox@gmail.com>
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

Add efi_dp_from_ipv4 to form a device path from an ipv4 address.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_device_path.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index ee387e1dfd..6fcbc91e0b 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -974,6 +974,53 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
 	return start;
 }
 
+/**
+ * efi_dp_from_ipv4() - set device path from IPv4 address
+ *
+ * Set the device path to an ethernet device path as provided by
+ * efi_dp_from_eth() concatenated with a device path of subtype
+ * DEVICE_PATH_SUB_TYPE_MSG_IPV4, and an END node.
+ *
+ * @ip:		IPv4 local address
+ * @mask:	network mask
+ * @srv:	IPv4 remote/server address
+ * Return:	pointer to device path, NULL on error
+ */
+static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
+					 struct efi_ipv4_address *mask,
+					 struct efi_ipv4_address *srv)
+{
+	struct efi_device_path *dp1, *dp2, *pos;
+	struct {
+		struct efi_device_path_ipv4 ipv4dp;
+		struct efi_device_path end;
+	} dp;
+
+	memset(&dp.ipv4dp, 0, sizeof(dp.ipv4dp));
+	dp.ipv4dp.dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
+	dp.ipv4dp.dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_IPV4;
+	dp.ipv4dp.dp.length = sizeof(dp.ipv4dp);
+	dp.ipv4dp.protocol = 6;
+	if (ip)
+		memcpy(&dp.ipv4dp.local_ip_address, ip, sizeof(*ip));
+	if (mask)
+		memcpy(&dp.ipv4dp.subnet_mask, mask, sizeof(*mask));
+	if (srv)
+		memcpy(&dp.ipv4dp.remote_ip_address, srv, sizeof(*srv));
+	pos = &dp.end;
+	memcpy(pos, &END, sizeof(END));
+
+	dp1 = efi_dp_from_eth();
+	if (!dp1)
+		return NULL;
+
+	dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)&dp, 0);
+
+	efi_free_pool(dp1);
+
+	return dp2;
+}
+
 /* Construct a device-path for memory-mapped image */
 struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
 					uint64_t start_address,
-- 
2.43.0

