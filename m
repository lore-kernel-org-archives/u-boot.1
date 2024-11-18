Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA316D591B7
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 21:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A7F0894AD;
	Mon, 18 Nov 2024 22:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EwDPcQbz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FA1B894BC; Mon, 18 Nov 2024 22:09:28 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA5B3894C2
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 22:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5ebc9bda8c8so940634eaf.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731964163; x=1732568963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4F6HLMm2lp14mG601Gm1E4EMQtzhgdbHvL0iDXPKkE=;
 b=EwDPcQbzxwrHDnycQpnhBPSGhHl5FZojPZ7NDHXE9Jos0GukkkSm9qIJBWiS2ehSqu
 P8XphgwVehgUbRjS2Uc+3e5+tglFZPGFds10CTQnOjYI0tFaBh14Sk42YP40LnoDHMJg
 W/12wWmV9rQvZxpP2OK0/Gj/Vn9If1xFQOnqz+IZVsFuAxIVcWrujzAhqglYu9fQ3kkL
 BtVS86kQBoIC0wiiDBd+AZNV8oakqTPG3Yo5JDdV+E/bg7jjKj5ASoi53AORcih5RqRl
 WK0HeKpPCjfEw/tR3lPwfnw2veqVJYQmA/XAxmT4l9VghOPqv1AsNaMnhIl9knnwtjyZ
 Fa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731964163; x=1732568963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4F6HLMm2lp14mG601Gm1E4EMQtzhgdbHvL0iDXPKkE=;
 b=iUm9VmGCbDhMica3RJxw+Eiud2uQTqOZlp/dcPu60i1bLLeaiZSA2C2kVfCSmWqgXT
 RfWrKvqsrgR3yBJUzNsFKKf0ljQUSBTvhIMpMVLFIfje74kSZlPXoPYdgIrEUIXgFvfx
 r45BwRe1+3xokQUmwjuDevaWrQFbVPH1O6Ye5WVP63zkGSI/aBX3weezGakDAnNb79lm
 IE5e3HrdDiSwVtJaia6m7JXaKrK0s3K1xM0wAbco8F+3lOa2abjC1eG/h7Q8Zt3sGIZh
 vABs+DLmyhwevXPe2+SUWZTxPth+B52z86ToGtoewCzsD4TKeWqMA8BXtzZf83945SNn
 GMIA==
X-Gm-Message-State: AOJu0Yy03NrdljTWngw/q04qJKAukVCGaFQgsvNpMexwsmIizSFGPOmC
 I0uUMIJJaX47hQT7u5eo5PUYKLzFD2RezYFWT/YUCmlhnXeGOv+KeKxytCS8
X-Google-Smtp-Source: AGHT+IEoQv9rN4KVrjo7SZBzWbarauhvvZEOs3QT1kFcYDitbAZ6cdRmWJVOuD7NGYjk0dz/ZFGalw==
X-Received: by 2002:a05:6870:e307:b0:25d:8d4:68ab with SMTP id
 586e51a60fabf-2962e0aea08mr10126711fac.40.1731964163444; 
 Mon, 18 Nov 2024 13:09:23 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29651852a7asm2994621fac.3.2024.11.18.13.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 13:09:23 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v4 03/14] efi_loader: device_path: add efi_dp_from_ipv4
Date: Mon, 18 Nov 2024 18:08:57 -0300
Message-ID: <20241118210908.51196-4-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241118210908.51196-1-adrianox@gmail.com>
References: <20241118210908.51196-1-adrianox@gmail.com>
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
---

Changes in v4:
- Fixed memcpy mistake

Changes in v3:
- Removed some unnecessary void* casts.
- Changed sizeof(struct efi_device_path_ipv4) to sizeof(*ipv4dp)
  in efi_dp_from_ipv4.
  
 lib/efi_loader/efi_device_path.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index ee387e1dfd..cdeea4791f 100644
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
+	ipv4dp_len = sizeof(*ipv4dp);
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
+		memcpy(&ipv4dp->local_ip_address, ip, sizeof(*ip));
+	if (mask)
+		memcpy(&ipv4dp->subnet_mask, mask, sizeof(*mask));
+	if (srv)
+		memcpy(&ipv4dp->remote_ip_address, srv, sizeof(*srv));
+	pos = (void *)(uintptr_t)ipv4dp + ipv4dp_len;
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

