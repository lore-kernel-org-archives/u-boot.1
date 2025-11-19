Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84948CF34C4
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DCA583FCE;
	Wed, 19 Nov 2025 15:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ubuRCTsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1797583FC0; Wed, 19 Nov 2025 15:55:32 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 019D383FA3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so5298665a34.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564129; x=1764168929; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OKfiFTEhSZwd8RH3z6DczWbbijwx1igAsoRMbCxpQXo=;
 b=ubuRCTsO/7HHQJVrbeC5xJCUZBRcDzKj9wvKHJpw8JcuXjQMHspP9bbZmdtJXyyYNy
 Hu75KK5DgNnFlQXlRaOx7EC2Zj1Ruh1KxPlKdEzXlIIpDVgraWwT5HSM3+adHhznoZIi
 SYDeMGKD9EIEufXUpG97t5RVe8OXrFTdW8oPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564129; x=1764168929;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKfiFTEhSZwd8RH3z6DczWbbijwx1igAsoRMbCxpQXo=;
 b=YkccZNZuAn3N06qt8j1LW4SKhSIjBEDEFQOlnosLWViy37YXYtUfRqyxhbVNL+5sv7
 l41Yodbu3UfiqeTSkJ9a1EPgF+R4yyiLsTDwuO221vSYbiaRbP+ZXnV0bpo6QN0UesWo
 1WDTLV+3ChS5wsZ0K6xM2+lW48mo4WvYMqG7h6PL6SW1mgAyJdc8/qN3K8MWRFOTT4JI
 1x3USeKNjVhN3IrRMNw5uKqxqjt/KM72PM4cJ0rLt4EH76A/Pylm0GeOYJFCgWS5DOLK
 p/VJMJwvTAXVwNxHAxBGygEt3ucMVZAtcQ294hPvZOrla2MRDyP599MRlxgyKqL9psqf
 VJyg==
X-Gm-Message-State: AOJu0YwpQzEf76F1IeGTQ8vzjmTxFiNtRUkOnUrgRHhQ6/Vtf7m9xeUt
 aQRPIzZKlLNCyoimFeYpDBY/KfWNZAv4dXXq7U3KpJuEoZtQX85rf0IKlY/VB/7ZzsFUYQeitCr
 wcZHrGdEMPA==
X-Gm-Gg: ASbGncuT9+MTR3KYMrNkp8eoQatKsK3zaAI9kbsz3GC9reo+7w+pRuhLAjnY3Op7LDK
 OzDX3mENW2r4GqnP/WSrfw+WS7CP06+R3tpepX/BxvzrYbeAUHnjrb1c/Gjktc/Hu7dMPZF+P0B
 gpA/y4Akkm686HNRAGqPgfKA2aTYu9icFzbvY5s9lxoHTHnW5kyQtv+fFW/MyALfiPK4LXyhJnm
 g/hjdyPKYJXhobkpSR5lIi7DSgIoySGxyNDk7POUYizWVwB47QhiUYSQgCaqsZRjq3hZLdzkUNp
 SJjzuMJtyvHHt8pQvGI25U1O6gDEyX0ppWNcdKKs4nLOR9ROpl/0Yug/63LBuq6uE8JQfLuAS6o
 MaSKOAioxvHSPxBg3RVkyd1SyeTxrxFQ1TvTWdDRq8UldaCIrKK0FBpuAevA51lzut8mOFlWDxq
 7qYxy9MTq25552am9an0P/k7F8nAWQtNkxjwUV2PddqTrCeeKjwJHE6gzERVd9JuI=
X-Google-Smtp-Source: AGHT+IHB/nsWA4l0zSSgtHn+sv7vewBLj90g/PtvQfvgYUdFRe1V/nku2khnOOT7fyBlC0I7eQrM3g==
X-Received: by 2002:a05:6830:448c:b0:7c7:69c8:2cb with SMTP id
 46e09a7af769-7c769c80f29mr8456309a34.24.1763564128754; 
 Wed, 19 Nov 2025 06:55:28 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c752f9c934sm4579380a34.6.2025.11.19.06.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] hikey960: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:27 -0600
Message-ID: <20251119145527.843268-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 include/configs/hikey960.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/hikey960.h b/include/configs/hikey960.h
index 40d5e653c3f1..9cbdbd9a9342 100644
--- a/include/configs/hikey960.h
+++ b/include/configs/hikey960.h
@@ -34,7 +34,6 @@
 				"fdt_addr_r=0x10000000\0" \
 				"kernel_addr_r=0x11000000\0" \
 				"scriptaddr=0x00020000\0" \
-				"fdt_high=0xffffffffffffffff\0" \
 				"initrd_high=0xffffffffffffffff\0" \
 				BOOTENV
 
-- 
2.43.0

