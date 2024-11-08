Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3FDD5C0F5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 936808923A;
	Fri,  8 Nov 2024 16:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d8Tp7W8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 034538900E; Fri,  8 Nov 2024 14:40:02 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF44788DF5
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:39:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c77459558so20520505ad.0
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 05:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731073198; x=1731677998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Kz7L2pKD7eSME6VuMWBYK/K9gm5s+bNDFfGLbGGpRs=;
 b=d8Tp7W8Rlb6EP/aakWr3TnZPLhRIXKiuH/DVqwW1YAt6nMIxVLBi7pPan34Fim8zhC
 VqAuAHgys+TsYYwrEDFfe2i5zl8/uTEfd5gqIutcHjpMiyO4Wn0QkWtZsIpiUIt8Ut5p
 3XV8Qxk7WXzda/wsVFIlzUApzz4hLPEquAIpu0HXwene6lKK0yzo5P/nPy8rv6mg7HLF
 zL7Ykw2mtLzL5szGbtPDOLtPnBCYZ7rcNXdB8YWPIrch8BOGqBR6YgKsrKeIm6Wmo4dA
 dEBHq8GnxRKoOBfDQiTNVKCBkDdVJQe/yiPKuO1ZcKpddtT/SpNRTl/WGBeOq1Zd1T01
 jymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073198; x=1731677998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Kz7L2pKD7eSME6VuMWBYK/K9gm5s+bNDFfGLbGGpRs=;
 b=uOYwZEuoRj/aSgjlLpQ5USE/OB8dcQkHwSOebQiYbWrVGcY8AQ+kQrneUZpjr0WUNn
 uKT7tFDB2vnZ5P/MqK1F0jWaoAjFzvkQSeilOCGkuDQmn8XsV29LyhaINLQgrSjVwt3x
 Rv/aeyzZEbymmREYNMdAqdhNIcX64bJa0N566wEY3Slmmehkfx5v4tEEMftLzoKIPp2r
 xG7gh3xND5mzmLNKy8qOpRwL/ZrOFvR20NLHIyut87dA4kxhltkyLdbZspb9c3pYYOIw
 AlpZGWEhGY/zxp06vXPCW7uWu97o+zcelYOof7n0jw2S713HjwTfMu8/FrBdGsjUiSar
 Qp5A==
X-Gm-Message-State: AOJu0Yw2ltA+OIfPE186fXUdiQdq/txBXi9174kNDJ0/afvvko5SIvCi
 ZYaCrIRMsI8QHnr/6hf/Uo0bVBDsVXScBz5VMkfH+EteqPQoWDED44P9vQdPcj4=
X-Google-Smtp-Source: AGHT+IFUAXwf7U/yfQnodvAj8B+NkDvi+GNqehC/pT1cGTuYjluZ8bHD6jupMRfztj+uTTieVIHxBw==
X-Received: by 2002:a17:902:ec81:b0:20d:2ce5:750d with SMTP id
 d9443c01a7336-21183533879mr31585345ad.12.1731073198275; 
 Fri, 08 Nov 2024 05:39:58 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc8376sm30296295ad.44.2024.11.08.05.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:39:58 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 04/15] efi_loader: device_path: add efi_dp_from_ipv4
Date: Fri,  8 Nov 2024 10:38:39 -0300
Message-ID: <20241108133850.431075-5-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108133850.431075-1-adrianox@gmail.com>
References: <20241108133850.431075-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 16:56:12 +0100
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
---
 lib/efi_loader/efi_device_path.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index d7444588aa..3e02341224 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -974,6 +974,44 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
 	return start;
 }
 
+struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
+					 struct efi_ipv4_address *mask,
+					 struct efi_ipv4_address *srv)
+{
+	struct efi_device_path *dp1, *dp2;
+	efi_uintn_t ipv4dp_len;
+	struct efi_device_path_ipv4 *ipv4dp;
+	char *pos;
+
+	ipv4dp_len = sizeof(struct efi_device_path_ipv4);
+	ipv4dp = efi_alloc(ipv4dp_len + sizeof(END));
+	if (!ipv4dp) {
+		log_err("Out of memory\n");
+		return NULL;
+	}
+
+	ipv4dp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
+	ipv4dp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_IPV4;
+	ipv4dp->dp.length = ipv4dp_len;
+	ipv4dp->protocol = 6;
+	if (ip)
+		memcpy((void *)&ipv4dp->local_ip_address, (void *)&ip, 4);
+	if (mask)
+		memcpy((void *)&ipv4dp->subnet_mask, (void *)&mask, 4);
+	if (srv)
+		memcpy((void *)&ipv4dp->subnet_mask, (void *)&srv, 4);
+	pos = (char *)ipv4dp + ipv4dp_len;
+	memcpy(pos, &END, sizeof(END));
+
+	dp1 = efi_dp_from_eth();
+	dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)ipv4dp, 0);
+
+	efi_free_pool(ipv4dp);
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

