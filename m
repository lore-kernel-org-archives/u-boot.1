Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C320C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF8583236;
	Fri, 23 May 2025 15:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NDVaRApz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A965983249; Fri, 23 May 2025 15:07:12 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC14831FE
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so105250035e9.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748005630; x=1748610430; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNaI8TLWCiIqpLIL6aIQGTnsTHqJHLsOQNAyHYFHAOw=;
 b=NDVaRApzKqQxu84ikOZOUxxO9z0v5yB3dyMn8uFVQ2Fz4PQ3HTdCJATjPH+pW8fSLk
 P9GTa10Pajk3fwpUp7uz22gnnJipqjU0Oc+lCtgi2jQqgSiu3wMEB1eEBC/gZ0t1ukfs
 gt8ZwE/HZ+N1Wz/lFrRVAZ6CA8TT+CMEyEg34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748005630; x=1748610430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNaI8TLWCiIqpLIL6aIQGTnsTHqJHLsOQNAyHYFHAOw=;
 b=AytIRVeDDsKnEXouKzeBxO0Yr8Lz0uUOyblpe51P7jaUvnE4LLQuyh1lNTVLtl89vi
 noYgfBsGU5zQtx/Tr1KUK6jowc5XdGBMrfYVOu1vP1E7ntz8/zkUwYF951f4z7dHvY6R
 pgAo6Rwq3q7dRiZ0CLxlf9aI/TCVm4nWwZnBuJGO2bI9pRn6D+8rIZGR4youzj6eUJNb
 4nNyZrGgj4xTY7N0thG3QlY9p74xltGCy/9JqM8NVvkfMzDOD0BaUnzQRnA/cuBlhz3g
 NA8zC4jct0g9HcyTLq1a2V9P2v1DVICazE+I3+nfotLpiaWgJzsGwvDyi7lh0VvXSPXt
 bLCw==
X-Gm-Message-State: AOJu0YzIMB89tOvYmYTSltqHi4oajQkNwtUdGPInPn6YVme/BBS5onyx
 xIg7qnWHauAEq96ahedUE5sSDfUFpdtg76meFgFDPFIdiiXn9zMQGINNHVA/VAeygUl++tzXLZi
 dbNNN9J3M
X-Gm-Gg: ASbGncuqp0BtHp3MA65K/jGuCp0Mxl6WjtSE1ov8Jqn3sZYyMExNm1ymAUxOrxyjU4E
 GSMutituM5HDPn8TmkNduA/ShG/BGv+6zcH3aRuBF2RYaxmQKPjK0V3TsgEsOFjfeK32WgFd9vd
 moG/TxjE814rgAfVf6Awaaf0rsbN37632xiYNy/xhT5wnvjoz7Z/on//Arp5JzOFc3d6+gnRbtR
 9LPZGl/KUp1Z+JHa9dQW/e4M6k7lLn3WiAVnzTClL+XquVEspjaLBvxB4jD+Lm5osX+qr6uh0/z
 WF3vsMvlgWcKb3WBDNfTxxnod03nOJgYGl/5kKtq8HM7f/dzWESPKAaynqBm2BbNb9I7hk55f9I
 6ohweaA==
X-Google-Smtp-Source: AGHT+IEh05PByKn9lmJt2nfeNORln4oUCvG7cadhZvjalR6LiBTjq4z/phnvVQBxwWgDG7sIIcOGjw==
X-Received: by 2002:a05:600c:3513:b0:442:f4a3:9338 with SMTP id
 5b1f17b1804b1-44b6e66ee6fmr25376295e9.21.1748005629647; 
 Fri, 23 May 2025 06:07:09 -0700 (PDT)
Received: from chromium.org (82-132-216-100.dab.02.net. [82.132.216.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm12109241f8f.100.2025.05.23.06.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 06:07:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/10] efi: Include device-path functions in the EFI API docs
Date: Fri, 23 May 2025 14:06:37 +0100
Message-ID: <20250523130651.1329593-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523130651.1329593-1-sjg@chromium.org>
References: <20250523130651.1329593-1-sjg@chromium.org>
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

Include these function so they can be browsed in the API docs. Exclude
END since it causes a warning, which becomes an error:

   ./include/efi_device_path.h:22: warning: cannot understand function
      prototype: 'const struct efi_device_path END; '

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

 doc/api/efi.rst           | 6 ++++++
 include/efi_device_path.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/api/efi.rst b/doc/api/efi.rst
index 49814bcf5ea..d16851ca437 100644
--- a/doc/api/efi.rst
+++ b/doc/api/efi.rst
@@ -184,6 +184,12 @@ Driver binding protocol
 .. kernel-doc:: include/efi_driver.h
    :internal:
 
+Device paths
+------------
+
+.. kernel-doc:: include/efi_device_path.h
+   :internal:
+
 Unit testing
 ------------
 
diff --git a/include/efi_device_path.h b/include/efi_device_path.h
index cea7fbafb34..252253c5f28 100644
--- a/include/efi_device_path.h
+++ b/include/efi_device_path.h
@@ -13,7 +13,7 @@
 struct blk_desc;
 struct efi_load_option;
 
-/**
+/*
  * END - Template end node for EFI device paths.
  *
  * Represents the terminating node of an EFI device path.
-- 
2.43.0

