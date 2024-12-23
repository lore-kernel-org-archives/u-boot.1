Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A72E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 14:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33F8280704;
	Mon, 23 Dec 2024 15:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zffxw8yv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8BAD80704; Mon, 23 Dec 2024 15:47:58 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029DD80740
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 15:47:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d88cb85987so35367936d6.1
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 06:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734965273; x=1735570073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHTdZDoQHi0DGV+vWci9khHooRAXICaEiFLFbPsBXW0=;
 b=Zffxw8yvojyN4pD211sFUmKkLk7uawq1WtJeHgzUIigE8gOTtr4KoqtPIWSHfvdBPU
 7s/COeteWNyLvW3w+xoN5vj4AI1FEqrv07SSqDlVQyItkujz11jU7Bmz8wLF0P6cky/X
 tMJDg/oZUgTRfalcFz/owQ1A39b3rBndC07uH8S0mGbymbo8RHbOWWcWWhda2G0JCvYo
 qDHfjfFL2ED3tcM7npH6PMOmfhbn2UYaRr9Cug+h24j8NUnU2geZygnO/svxdnh3fT27
 fUyhe/jkRe/1ETiXl8yPFkF1nhLXcAybU5os14YhmT+X8PdLboHFeM54QgBQtxyChDA9
 TAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734965273; x=1735570073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vHTdZDoQHi0DGV+vWci9khHooRAXICaEiFLFbPsBXW0=;
 b=cPeLrRcfBH34CVoIOcCeg3Gc8I+i5mJEuV6GFnfH7mfLfszaorTADurUozxmNX8+J3
 JVFARTT/WiG+6pI6eja+GSTy3W2EmQueNyk5bzlRN0q8G1xIx8LDIrI2830JYRx5Qrqo
 JFMRQTTLnm/bYrR6wk7jB6E7WIJRltCpJmw8jdkMBS/baKU85GVhEuMGZtR60fYDld55
 a7VuVBcojHiVX7/HxIh4ERTATGjhdwQELjQoaYoGXQyCIMAtuGXtZhnQ1dsJn1HfUFCi
 EFEPTlNKnhPeDQvQ8hXmOc1Ss6g8q/pFBb2D3NxXCuiFNcKd8ZCwTC58k/R6nrndsH2E
 2nsQ==
X-Gm-Message-State: AOJu0YyEGK+NBlUxcasquw/EiuQhQdryWZ+57b2zGXwD4pXSn4OEFXdL
 yL7ZWlPPePvWsWTLPr4BTBXFMoBZV4zJYGDRZvCrSt6KQboHFtIM9QN7kv5xS5sSOMFiw9T5fzR
 8
X-Gm-Gg: ASbGncsiOw/McP130YmVSY9cZxw15d+orF/x3DpVWQn242vTj5fy25ghqcUcAtwUKo7
 TNZrvVZxoO77u9WVENPHOrBqRKsHZoSIZ0EEYbIMDkznr7JrAsNBi9Rej2wGkCwT9t2vbY2OM5P
 G3MlbCu0tsQFUlMzCRbW/kC8tTwdCXLTjk+EdfypiW367UDDk9muxdCu0uG8IUiv9ZnOLcbjU/c
 fmhzEkxkE8SHtPdE62VCp1fZImQoWBzzwix2dvLttbh35zWZodOXijBLRlu4ECwoR/+Fh7NRMuJ
 Pb7xwxdEKXG4+KPCPykcVTB2YZzCWwHrylxvTxjqndqWdfN/jVR/vEo=
X-Google-Smtp-Source: AGHT+IGejfSMtGik8iZvKacLaExohujd5VNS2uAapjk2AZzKqq+wntImEvJc9iQs9Mky+3oJCNcA4w==
X-Received: by 2002:a05:6214:d6c:b0:6d9:429:ab4b with SMTP id
 6a1803df08f44-6dd15499041mr246770786d6.0.1734965273517; 
 Mon, 23 Dec 2024 06:47:53 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb519sm44243246d6.83.2024.12.23.06.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 06:47:53 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 01/11] efi_loader: Don't warn if the TCG2 FinalEvents table is
 not installed
Date: Mon, 23 Dec 2024 06:47:23 -0800
Message-Id: <20241223144737.554992-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241223144737.554992-1-raymond.mao@linaro.org>
References: <20241223144737.554992-1-raymond.mao@linaro.org>
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

When the TCG2 protocol installation fails, we are trying to remove
all the objects we created in tcg2_uninit().

However, there are cases when this function runs before the config
table was installed. So instead of printing an error unconditionally
check against EFI_NOT_FOUND and don't print anything if the table wasn't
installed to begin with.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/efi_loader/efi_tcg2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 572c6b5bf6..a15c73162e 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -791,7 +791,7 @@ static void tcg2_uninit(void)
 	efi_status_t ret;
 
 	ret = efi_install_configuration_table(&efi_guid_final_events, NULL);
-	if (ret != EFI_SUCCESS)
+	if (ret != EFI_SUCCESS && ret != EFI_NOT_FOUND)
 		log_err("Failed to delete final events config table\n");
 
 	efi_free_pool(event_log.buffer);
-- 
2.25.1

