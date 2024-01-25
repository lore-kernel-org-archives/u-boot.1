Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F6BC46CD2
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 01:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF6987753;
	Thu, 25 Jan 2024 02:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nie46ooS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25D2987D7B; Thu, 25 Jan 2024 02:13:53 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5B587626
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 02:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d427518d52so1976235ad.0
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 17:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706145228; x=1706750028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6DPMDhJMhN+5M5THl+8hZE4tcFP4i9oZ687gIW0qxGo=;
 b=Nie46ooSCb5UJmMVVETXitNJZJeg+46CTJwxpf5zdD7GEK4acGnDGZr5sXdkff5Y+/
 lx7dh+EbRgESWIKRJyu+1RX8pndPq2aj1hHPQy60JBfZWaol+gjJ1/cJd5fJk1dgTGf7
 3xfo40njsCzc9RlvvFX9OojEtSgFcyy3GIsUao/YXb94wqSySIGkpJSdjG//8JSXUp07
 hGRBsLASSAzbCaf3GGv23NVeCGXns/x+N5AyFQuqjffsr45gIX+WxIODE1JEr7ZlkjoE
 cb5AyOUXnNfkZJhpElz2BbU3LmkuC3ysKSPrYBKqC1q0Fk1cwaO06TU9U1cPCKyAywlj
 Lh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706145228; x=1706750028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6DPMDhJMhN+5M5THl+8hZE4tcFP4i9oZ687gIW0qxGo=;
 b=N+ffWQAY+JQRpYrr/+RMDpxLyo6XM/X/97WDfArORSRy5HQoaOCMANGYnWLcfHSHI6
 auyhh4CYf5+o7xEFQXy2c1Szcnm2HSQCebyEj4wvLCZvnqKpY4mo6+lC1q3mpjfL17cO
 6s0o8BCl8uVqc1Two7nqw7e52/1MQZAMZVNf2yic+iACWJOiGQwamXdpUt7H5JQ7XsH+
 vvtUuAdEJMBoIuQseNkc7bW5QA3msauR25gEucMtP3dc4zU+LqyoB0tLqPGy4no+PBhm
 No1xrnuxCaWtfBBH0BD+RSJGti9OypPalkQd41efS1we5IrNTcvOXfmnO+CCydj3cZQd
 LhdQ==
X-Gm-Message-State: AOJu0YzNyz3Raw1+tBtZE0RjSKjlJq7/VENrTQUXSghj/vRuHDuui/Y2
 Tg236MNp9qBOF0MPEeaPMv6tbEtA1qg8Y+Vmi8ehtpfpb/JgmYYMXjZh+z3dePSeBJ6J2S49XBS
 z
X-Google-Smtp-Source: AGHT+IFJrvVnI5R8g3IEiBKFEEKa78kwqp9Ea0UwLQ4I0+nCBidM/6r9IkvtIgEGzQg5nf8ayLRKMA==
X-Received: by 2002:a17:903:234c:b0:1d7:8570:e53 with SMTP id
 c12-20020a170903234c00b001d785700e53mr668881plh.38.1706145228236; 
 Wed, 24 Jan 2024 17:13:48 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 jo21-20020a170903055500b001d788337d00sm1429583plb.16.2024.01.24.17.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 17:13:47 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH] smbios: use struct_table_length to get SMBIOS 2.1 total table
 length
Date: Thu, 25 Jan 2024 10:11:28 +0900
Message-Id: <20240125011128.1176557-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The current code convert the SMBIOS 2.1 entry point structure to
SMBIOS 3.0 entry point structure. The max_struct_size member in
SMBIOS 2.1 entry point structure indicates
"Size of the largest SMBIOS structure, in bytes".
We need to use struct_table_length instead.

Fixes: 1c5aab803c0b ("smbios: copy QEMU tables")
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/misc/qfw_smbios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/qfw_smbios.c b/drivers/misc/qfw_smbios.c
index 9019345783..a898cb4eea 100644
--- a/drivers/misc/qfw_smbios.c
+++ b/drivers/misc/qfw_smbios.c
@@ -90,7 +90,7 @@ static int qfw_parse_smbios_anchor(struct udevice *dev,
 		entry->length = sizeof(struct smbios3_entry);
 		entry->major_ver = entry2->major_ver;
 		entry->minor_ver = entry2->minor_ver;
-		entry->max_struct_size = entry2->max_struct_size;
+		entry->max_struct_size = entry2->struct_table_length;
 	} else {
 		ret = -ENOENT;
 		goto out;
-- 
2.34.1

