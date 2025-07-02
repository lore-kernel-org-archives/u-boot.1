Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B59C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 10:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F45080E9A;
	Wed,  2 Jul 2025 12:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xLB8EGNJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4C7182F08; Wed,  2 Jul 2025 12:01:41 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 548C082EB8
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 12:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso45894705e9.1
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751450499; x=1752055299; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6ZaK0yoNU4f+dytR5ZpBXM2TPlf8p9LU898m21b+RK4=;
 b=xLB8EGNJTVfS9mNpDUih/huo0P4+1Y2SGZk1fbziuKLYa4OQCvG7sqdwriDRwxpLQ9
 QhLiW7RX12XNiL0XzSV81Z1lRb+pKT5cZuapOsyT+B8kNYkG6ybVn/2CujGV1tBLkL4C
 qF0VlEkEPOzyJDd3nOSbDlloXZIQXxOx+nblb0ZE0namMMecT9qlsH5bP+dps8tyjJ1D
 26hGKp6qMNSBgT5QYvCeP+KAFhfQSjXWYD4jO7IW24+DcBXnRXkzi2rmibJLC2bCC3tX
 /TxMQSjDS/FWmjE4ZD0GU2KXTfdQP385w1xqUP3/NvEKFaQdlNm84KP7SiES22SSzgID
 I9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751450499; x=1752055299;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ZaK0yoNU4f+dytR5ZpBXM2TPlf8p9LU898m21b+RK4=;
 b=dNWyMst0zvgg4wFC8UXsbbjpcFrgr10idk/mcAkS7Dddxe/VDrkxGEbO7LPc4SkwnA
 UL0PdKRFE74fzjJ2xeNn3x/j/Jrrb/I1nAcrITerMlXgxtWTaC2CFgx4kaB7p/gDVNjG
 p64RrvltqslMhl7LBMGoEmy9GT3YDDXWFhAtcx8JyI+Lg+Wz+ndyut/0wpLKZK0gHhTm
 vDiJMwMoZV+maXoqyDV0LtrfkmBwApxEF1SE0gSmDAqMM8Tg/Ox9fig08KtIUejjMc85
 YEHUCNDL5z9d3F+BqgOq9NcuLemtTIHLKniI3IX+wAmTrwqCPW7eKEGMJigLQh0cyyJ7
 AsJA==
X-Gm-Message-State: AOJu0Yx1aPERc/E5iMLqM9Lo4leKIB/9hFTF0NU55gkSL8yccA/NzKCN
 iFysBiAoF1ut7EELvwl9zBGC3UYJOuig0zsz8R72sbtqXe07EtoQQ0bbNIeaWIuWdU0=
X-Gm-Gg: ASbGncuxCUditIjGELR0YJPc6ndp6cFJtZttSdB/WkkHml+ZoY8bEhFAh2bIm8ykVNv
 6IOsqRwatVuhpGSgnLZW6L0d1U5Iu6timI+1YYu6os3A4qO/ypek7VzyruAFEtRf3BeVfp0Nb0B
 Sd3yhX5ORI2Za0MltpgJhFCuwlO5dJH451p6DlM2AL/QNNiTTWqquH++QR1/OTBJZkVm7THqDdC
 Fn5YKSSWizsv+n4apEOY7Ihvxj3BpwVLZtnY2DQwutvrUiCGtAtjVUGOPdYmnIURmWAM9U5FxCS
 S6yb5LO3JPccYVSdYR3gs8AWTW5o4tqMp/ZL7UQKI0hGdgs82lA2Ng5Ap1unKuEm86w1yPpyG2B
 P1hsgYGShRg4Mbw==
X-Google-Smtp-Source: AGHT+IEuEeS2kqOip/xUcwfSdqvdgBdlv/tNSCdae5v3GDCKoCn/0G8yigPhKDYkzTAxEeocS3aH/A==
X-Received: by 2002:a05:600c:3ba7:b0:453:9bf:6f79 with SMTP id
 5b1f17b1804b1-454a3725836mr18849085e9.26.1751450498660; 
 Wed, 02 Jul 2025 03:01:38 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:2aa3:3d9f:604c:fc30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e74fbsm15850233f8f.10.2025.07.02.03.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:01:38 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 02 Jul 2025 11:01:37 +0100
Subject: [PATCH v2 2/3] efi_loader: Prevent dereference of uninitialised
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-efiloader_fix-v2-2-eb6db16bbe4e@linaro.org>
References: <20250701-efiloader_fix-v2-0-eb6db16bbe4e@linaro.org>
In-Reply-To: <20250701-efiloader_fix-v2-0-eb6db16bbe4e@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

If phandler is returned as NULL from efi_search_protocol then
protocol_interface is never assigned to. Instead return
EFI_UNSUPPORTED as per the spec.

This issue found by Smatch.

Also eliminate the use of the variable protocol_interface as it is not
needed.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 lib/efi_loader/efi_http.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
index 189317fe2d2..9a0f2675132 100644
--- a/lib/efi_loader/efi_http.c
+++ b/lib/efi_loader/efi_http.c
@@ -453,7 +453,6 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
 	efi_status_t ret = EFI_SUCCESS;
 	struct efi_http_instance *http_instance;
 	struct efi_handler *phandler;
-	void *protocol_interface;
 
 	if (num_instances == 0)
 		return EFI_EXIT(EFI_NOT_FOUND);
@@ -463,18 +462,18 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
 
 	efi_search_protocol(child_handle, &efi_http_guid, &phandler);
 
-	if (phandler)
-		protocol_interface = phandler->protocol_interface;
+	if (!phandler)
+		return EFI_EXIT(EFI_UNSUPPORTED);
 
 	ret = efi_delete_handle(child_handle);
 	if (ret != EFI_SUCCESS)
 		return EFI_EXIT(ret);
 
-	http_instance = (struct efi_http_instance *)protocol_interface;
+	http_instance = phandler->protocol_interface;
 	efi_free_pool(http_instance->http_load_addr);
 	http_instance->http_load_addr = NULL;
 
-	free(protocol_interface);
+	free(phandler->protocol_interface);
 
 	num_instances--;
 

-- 
2.39.5

