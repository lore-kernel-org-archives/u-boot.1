Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A14C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D976C80B9F;
	Mon, 10 Feb 2025 14:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d2xtzIDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED94580BA6; Mon, 10 Feb 2025 14:11:00 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 642B480AE5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso29311145e9.3
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 05:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739193057; x=1739797857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EQ3LZHLa6m7TQfMsOsEptq+oQh4hftRdoXqAnioW8C4=;
 b=d2xtzIDHRPEy7AmIB8A+wt6OKafHSTluQSjiUYk9q0ohmE9F3SPv0Tgcocq6PyObuK
 pDo/svByLQXo+IjKC8niOEFwzG4Eo8JsS+hPGuH60ElxKlS/LmP7woSipoxf7j1SwuhQ
 gkeshaHoFSpfdlcEU3k44YyVJe8fEN9eeY3gypanCrxbLHBgd8ZpU2TCyhViOyLZkdzo
 ZMc1pgtm8IwLEx0Y3ZR6mnXKpTtzSQlpVFhWOqQfeAj8f4P4LTvm1RgWGs8+S43P0csh
 tVEkrK4QvfEWzwu+AEwgE65p8FRUMpywiN2WLrJ269q0P1enFWpy59C91EYt7j9nxSjC
 X19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739193057; x=1739797857;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EQ3LZHLa6m7TQfMsOsEptq+oQh4hftRdoXqAnioW8C4=;
 b=FV42jYNn4WhxALyWEtdQMK5zqFHPOe1kcqyWuX7S3rr3xWM0DfKa1GEzz+Y9i5Mf8U
 DjE19+hoq8JrOePoxe9SZP6zOoCzolmZp5foc46viVdEPCujaV5Jwevn4EcGs+0ojdIL
 vQUdeCJ7f2UFvfkEVv1Y8ZVgeD3SVNg/RcJ7eCblp3nj40oGQYwrTYoVN0LCfW/JNvHF
 Dy8C5gHV9fKZZ7f9lFZvJv+Y0JydzrZWPgN54ELhG8MXbI/eaRHd+yVwIyEKu8mwlgvA
 lknL42Dw1gked0h1zu94GtmspvfrAuChrOCmznt021TyBnysVm5Ey284RQ9ycSRe4jwI
 jLMQ==
X-Gm-Message-State: AOJu0YyafmzN9HM3ZCATydWjBkZMSU9NUyZsQqhvnASZBXHUuAuBLJMH
 nRtG1B7Z8SJOTwkt4+LvCIS7vxrRLlnInQ4BEJoGsZS04nVOQNfKyg30lWZuwic=
X-Gm-Gg: ASbGncuMrzMIkhGAwEk4gHPXK2XSgj++YR6phNWWk9OpWEOOpooA1XiVA10MEQofiIA
 xopIO2LVbh3SL0ISBXn23E+Gs3gDFb6vfPsWZT1lg0EJRvFi6vdvUyBS0dT5AX8ZJ89kB6Ia/sD
 jHPubjvdo4jv3i4bKC2Aua+MUVI/ABIZURDtlkmTG5MQxaRhSZNiwgF5GYIy6z669O1bq6OVTdS
 YiNSIOZa8cJa1TiLWK0xbeYYWVIDqsOqLsgaXjWG3c0DnGbSCusp4Qn/T3hFjqrzAdRBRxynh+E
 itzoVOLGGcDC7ABRpqGKR2zDXIbWP4o=
X-Google-Smtp-Source: AGHT+IH6n8UADYPTTlSBwwcO4fdr0mgy71lzxLTb1pjZIpvDbVPh6Y6IJxLdaLB7d24eT3enTd1M3Q==
X-Received: by 2002:a05:6000:156e:b0:385:f249:c336 with SMTP id
 ffacd0b85a97d-38dc9370fe4mr10571301f8f.45.1739193057492; 
 Mon, 10 Feb 2025 05:10:57 -0800 (PST)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:7693:a594:d8cc:16e9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd9a6153dsm4675415f8f.60.2025.02.10.05.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 05:10:56 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] efi_loader: efi_var_file: specify absolute path
Date: Mon, 10 Feb 2025 13:10:41 +0000
Message-ID: <20250210131045.13905-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.48.1
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

The EXT4 FS driver gets unhappy if you attempt to write a file without a
'/' prefix. Adjust the EFI_VAR_FILE_NAME string to be the full path to
the file.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/efi_variable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/efi_variable.h b/include/efi_variable.h
index 4065cf45ecaf..83fbca93b6bd 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -91,9 +91,9 @@ efi_status_t efi_query_variable_info_int(u32 attributes,
 					 u64 *maximum_variable_storage_size,
 					 u64 *remaining_variable_storage_size,
 					 u64 *maximum_variable_size);
 
-#define EFI_VAR_FILE_NAME "ubootefi.var"
+#define EFI_VAR_FILE_NAME "/ubootefi.var"
 
 #define EFI_VAR_BUF_SIZE CONFIG_EFI_VAR_BUF_SIZE
 
 /*
-- 
2.48.1

