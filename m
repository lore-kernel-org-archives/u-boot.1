Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477F9D75E5D
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B5E689524;
	Sun, 24 Nov 2024 21:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iC3zMgzD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7307789920; Sun, 24 Nov 2024 21:27:45 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A25EE89923
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53ddeef9e4aso1298354e87.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480060; x=1733084860; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pBsw40Vvg6/1/y2tFaUT0TBQaovEQgqkPeMJz2m2Rp0=;
 b=iC3zMgzDyymGsWtRzoeSFuBcTzcq7WrVcLlpIorxa9134Fo/r2Nj/i/ypSNHo9gudm
 kfpiFnkpvGa/WVyThtGb35XcneCwp+/i/I7Fs8+4tg6lIBYLhDldbynTTewJNFXWB44W
 dcT3/uYbsZZwrNYU8W96FweYsvmkpxYiOm2NMMllzhSX3/qOtRfZNugRP5yuy7hCEs3B
 uixK9dVzMJw9aTW4q5XDVU35AJ2qplxtCgX80xCa2BhpFGKRY174YUDaqAT4OJhzBTNi
 SW7DIYYwoCsMZLfSHNz+OABJZtCuB2i5eguIS8LmOAma+pVF5k8UkLcouCjw/FzMAQVw
 wLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480060; x=1733084860;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBsw40Vvg6/1/y2tFaUT0TBQaovEQgqkPeMJz2m2Rp0=;
 b=u+kVjxORf/Kv21TGtoHLl0OKua84JDf4EVjXDX/E1lCs6QzjHUg0wE70Wa+48uaQQ1
 bne4PfHfDl8CqW4L0vIREn5Z2zxAMEzOzFwq6Dtw0Tja6cWijcRwIvrEQfq1NNnpPN0m
 dTHhpf7pEvHNsFgzS931WrgYGXhuBs/MUCAbOMCzCwRWhTAq4e/pMPmmulwhl94hKZb8
 k+BqrybiuWI/CBsbl6oNnoTzbvLw2LzBbXPOwu1dRdAXSf3VFKI+9FHdpg/fBIsqEqpW
 VH0CzsSVIbuE4aw2N+OCFqYcxA/ytYR3BAldP9AKEWH9S+UQ4tZYvyI9Pm0iwphowSuM
 23Zw==
X-Gm-Message-State: AOJu0YzgZNaqg+gc1APgoUI6FTe21RrhnI1hXoipg205uK2i3TB6cdOy
 vZRuhVAyCD82JARbHH3ubfrq1Uhfvf+gJ5EKNtHxg4zCA754TNB0ovFeEdVPM+0=
X-Gm-Gg: ASbGncvztA1tE7hQBEH0iHihQLSbrLDIsgJy6r1R/L5DqkFZ/xBgs/MQZobLMTCkht3
 jWeQwnDrzbNWPYCdEVkIo2Qdb58rP3T8LStUXs/VW/o6x4cN5JjlS84TC10nzd2zrpSE/iRqaRi
 l4LumsFD0CQMCB2LLwcUVkKBiFO2ZyihW995L/senjhIA3sqnPHTEkdihu6q3eezmpaZWD9ROuf
 GJGXaTVHm062LipGpqJ2b+IxPtDty2hLfmwILJY/9bqTV30Hc7yhR+8t+qqPcyeuxX0
X-Google-Smtp-Source: AGHT+IFLqFV511xeB03dhlLQv1g0zbByQiYP/mEUuEjcJUfjQP+SOPIglfUyhaLjJb4af9HtALokZQ==
X-Received: by 2002:a05:6512:3994:b0:53d:e4cc:f5f2 with SMTP id
 2adb3069b0e04-53de4ccf8cbmr264463e87.56.1732480059912; 
 Sun, 24 Nov 2024 12:27:39 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:39 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 21:27:02 +0100
Subject: [PATCH RFC 06/14] efi: stub: log EFI memory banks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-efistub-arm64-v1-6-3e33f0340071@linaro.org>
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1419;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=bE5NHg78oOMxBfMsM0CuOr8IHdICyKDFCxa2bUEcku8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTnHqPXRqqnFr9dYmSk4drDGFEaLnzT+GbRelWp/fOns
 sn3B87sKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABNZUsjwP+fN71XX44OjFm1b
 2Ryw/MFujp70L/2/77MqPPtU/rE9RZmRodPPaDrPwSvfPn9jl1wjt+17o93N79IHsw/5vgsSPuS
 zIA8A
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

Add a debug log for these since its often useful to inspect the memory
map from the EFI we're jumping from.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 lib/efi/efi_info.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/efi/efi_info.c b/lib/efi/efi_info.c
index 3754c913b54d..f9743a3e7fad 100644
--- a/lib/efi/efi_info.c
+++ b/lib/efi/efi_info.c
@@ -144,9 +144,9 @@ static bool efi_mem_type_is_usable(u32 type)
 int dram_init_banksize_from_efi(void)
 {
 	struct efi_mem_desc *desc, *end;
 	struct efi_entry_memmap *map;
-	int ret, size;
+	int ret, size, bank = 0;
 	int num_banks;
 
 	ret = efi_info_get(EFIET_MEMORY_MAP, (void **)&map, &size);
 	if (ret) {
@@ -162,9 +162,14 @@ int dram_init_banksize_from_efi(void)
 		/*
 		 * We only use conventional memory and ignore
 		 * anything less than 1MB.
 		 */
-		if (!efi_mem_type_is_usable(desc->type) || (desc->num_pages << EFI_PAGE_SHIFT) < 1 << 20)
+		log_debug("EFI bank #%d: start %llx, size %llx type %u\n",
+			  bank, desc->physical_start,
+			  desc->num_pages << EFI_PAGE_SHIFT, desc->type);
+		bank++;
+		if (!efi_mem_type_is_usable(desc->type) ||
+		    (desc->num_pages << EFI_PAGE_SHIFT) < 1 << 20)
 			continue;
 		gd->bd->bi_dram[num_banks].start = desc->physical_start;
 		gd->bd->bi_dram[num_banks].size = desc->num_pages <<
 			EFI_PAGE_SHIFT;

-- 
2.47.0

