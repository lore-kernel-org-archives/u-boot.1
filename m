Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC1AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C17C188B9B;
	Fri,  9 Aug 2024 01:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DFCi6Hok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44F7288A44; Fri,  9 Aug 2024 01:59:45 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59EF387A09
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 01:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7a8e73b29cso160112766b.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 16:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723161583; x=1723766383; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jkesOsPwyP4uWMXO4nnoUtJ7UJX/bGz56xyNc2GQDEc=;
 b=DFCi6HokQXGTh+RuTXcq7zD/L1vf+wVC/ytjubni8nwMS7CzwnEgqcj+si2TI85uzM
 5OVK9wz2gQz2+putaGXzgbwD1pE4mjVN4xE0RwSyvtN/RQUKeuymYIl2+iqEaTPouVPb
 dtoelYEJ66TFva+SZa81PIRPdv3Vn2L747nNVosZEsEmzUS1nCqTqJPn6AJZUCtW2Lb2
 yo2BnPDcmXNOSpV3VPFBHWnlHu8B3yt+GbAS9pkEaUcP3hHHu4FftdtfLkwGSNjclFtR
 BSt0G+4QPl5TB4roo54xI4z7dDTQbLKhlItoKmlrX6Vi1lPFy0/ddTzDJQ1icBXWvfnN
 hZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723161583; x=1723766383;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkesOsPwyP4uWMXO4nnoUtJ7UJX/bGz56xyNc2GQDEc=;
 b=kGHGPYAIbWVKjqA01CpKZsJKCxnVTeG84zfQQFSc9skmR4h0oqtbPFoqXK4EJsBLlc
 uIavo/7fVBjhhYrorMg1Ye3X2WYCNCUcG0asoS8Rqig26qGFXAknGoRoR4mm2lRTo0Yx
 b5xUqjkvcBafPjyuS++5HBoyi2befNUOAaKs5Uy9FH32lL8jO8/x26B1QACuZzHwDSp2
 5D88g3gz/k+zUpj22LkZd+Pe6OuGBnYkazgtuy77VnNNPNHc6ODGDVk6tc4+2TyqV5o2
 UgtC/TQT2Q1TKf6+t13+wHfdtGsyIu6o9JOPGVs/HXgdbaPJ7Gi5+EaMnE3e2hXcANFk
 +VKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzKNSUUj16yR9GaUugAZRbivF+gMRc0ibXiQnlvsmUelSWQbHybtjOnMspkw5dSFBjiGuKLAS3JfQEcNE4cUyecn+XcA==
X-Gm-Message-State: AOJu0YyOcJ3NITDxjyCJDTZgJ+Ppcd6ImzIKxhcY30bCIe3qTNC4tIRb
 i0xHuGOytb8JgDUp7Xg5tIo/rxY2WvG4uIHOx+S4mJukkJfCv9h8i3JSRYVR42JmDcK4y+w3Ot1
 I
X-Google-Smtp-Source: AGHT+IEpoJbr2ilRrHcNg8NJNlCkdbMzrjW8nrD5Huv3LRsSChPxr4mHnLCSAviQt7VLawRwnq+YcA==
X-Received: by 2002:a17:906:7943:b0:a79:fbf0:8106 with SMTP id
 a640c23a62f3a-a8090c32544mr284643866b.6.1723161582795; 
 Thu, 08 Aug 2024 16:59:42 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45423sm784047866b.134.2024.08.08.16.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 16:59:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 01:59:28 +0200
Subject: [PATCH 05/11] mach-snapdragon: allocate fastboot buffer
 dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-snapdragon-improvements-v1-5-7c353f3e8f74@linaro.org>
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1488;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=QEEmnRtKXeaUbPt4b6LOBPWMVC6ST33UIa7LHVKtDzo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtVvnqkkV18/QFmW5I+AnVBC1Hfhd9fIjcyAfJ
 SVBc3NEiGeJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVb5wAKCRAFgzErGV9k
 to6YD/4hTTKm5lHm1Demrpt1IemV0WvdPORjNm76h+x0eEqMnd9GmlD8RgYSJAdBnd/B0yZEGxk
 NAPtrntg0+9Ip/+h9v9uJDiBVqq6AnqNOfciQ9hkL0mIVeXUCF+BPMriJHe5ynUZb62ZJNhZpZ0
 h+84E0iFgJU/WVyUrkFJJQK2+wFIOSjZBtOfb3I+z/NIlF/5e+PlIi7252zDgX2mbX4KzPinbTx
 GogI1/Usg73jR+eAzLq9pNCzWlhQILP/Q1vW0cjZNHVdd6NoaziBgQ2YHLd5mNk8RvOeIygerJf
 m7VGGxbnDqJtVHiavoA+a3s+RVMQ0BIFoArzCNIDY6E/68TPj7+s/c3RJ+FBC8kubh1HSJtrMLc
 iO4tgF/KPwZnrrg7qa9GekwwzAI/an4tU2qnQReT+FjhJ3VQv7jYa8ZSSWbBTtrAQ9Bz5SytI7h
 dDuf8WuJDXPBJp9jVHQ8ndfkdgBTp1r6e+ZDoSCWTE95zrhTAUNN9ChErnhYLlcMG+su5tkP0Z+
 lGsCzXN7hAMKd/OvRpxX42VsNti3kD8IjzAmQp/JtXv8vTcIX3577xppUmkbrnHlX348etgFY2I
 4W/lqkBa4Y6etukBv3kskHJ568Dl15M2dwYFC5dQ2jK52/K3f0abCoFZ3Yk1QhmeTbuGpdXD6HM
 4GiJh1lo6lTRFgg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

We don't know at build time where a sensible place for this is, allocate
it at runtime like the other variables.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 36335627f4ff..37925c40f36f 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -410,8 +410,13 @@ void __weak qcom_late_init(void)
 {
 }
 
 #define KERNEL_COMP_SIZE	SZ_64M
+#ifdef CONFIG_FASTBOOT_BUF_SIZE
+#define FASTBOOT_BUF_SIZE CONFIG_FASTBOOT_BUF_SIZE
+#else
+#define FASTBOOT_BUF_SIZE 0
+#endif
 
 #define addr_alloc(lmb, size) lmb_alloc(lmb, size, SZ_2M)
 
 /* Stolen from arch/arm/mach-apple/board.c */
@@ -426,8 +431,10 @@ int board_late_init(void)
 	status |= env_set_hex("kernel_addr_r", addr_alloc(&lmb, SZ_128M));
 	status |= env_set_hex("ramdisk_addr_r", addr_alloc(&lmb, SZ_128M));
 	status |= env_set_hex("kernel_comp_addr_r", addr_alloc(&lmb, KERNEL_COMP_SIZE));
 	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
+	if (IS_ENABLED(CONFIG_FASTBOOT))
+		status |= env_set_hex("fastboot_addr_r", addr_alloc(&lmb, FASTBOOT_BUF_SIZE));
 	status |= env_set_hex("scriptaddr", addr_alloc(&lmb, SZ_4M));
 	status |= env_set_hex("pxefile_addr_r", addr_alloc(&lmb, SZ_4M));
 	status |= env_set_hex("fdt_addr_r", addr_alloc(&lmb, SZ_2M));
 

-- 
2.46.0

