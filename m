Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F71DC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 12:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3CA184A4D;
	Fri,  3 Jul 2026 14:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CpBfYGSo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C5EF84A4F; Fri,  3 Jul 2026 14:46:49 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CBC584A35
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 14:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so3936545e9.1
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 05:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783082807; x=1783687607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zHsNiRo+/JZR4ddE054xPxdiy8rWZRXdyc5bT+YHAeM=;
 b=CpBfYGSoxUI9RbkYOdiIZNvWnUROuic/SWXizPNVuMO9PY0Fl4wy16P/fl6Dm2fcAD
 hI2jPB3DNK9W6o7y23wUjg6mXVJyF/TWnV9r/1IniFV/vC/yUQRVOmgtruBR6yhp75Oo
 F2UMUxZZYS92kP9wDOzilk4QhD0VSUEDa0W4k1I3mM45h4418kSSEvUAzfRrDWhidqMo
 ZJQ68qMKXhkcbuI7I3Pa3UpgVSE3wG1AvOI+RSXbuIrbwQ/7rOAoQkyhrmqj4+7J0qoP
 8dGCeGt9cRIPZYsM516SuWK9aKWQ/2hbkHVTMR/FKwYC3GQL9KLsFymS/kEuz1F177nE
 02/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783082807; x=1783687607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHsNiRo+/JZR4ddE054xPxdiy8rWZRXdyc5bT+YHAeM=;
 b=KJIykKgte0pfvVgKZEkVg2eZSaBYGiF7lL0O7LBtbC3551cddNpnEVNykx4as6D8yT
 HHGTeCEKB+IkdQgZF/5CVXze4L6Uv1V8/MhQWcCyh9uZVMwfMSLmZPz+CuRa1fDs6tQu
 /bnQFuzbmbVjZSRdiIOcIC9KjyeR4xqfCgApcQmj85a0KcYblil/R16PRvIroy/ueMBf
 UoVgPzqUBqq4sWVg+YaQej77W11OHyetE6gI4Un0D8NaAm+MnGvEtrSFPYBxKEsSKi6m
 HYv2Qbc4v4Qv1JHIozPKSyCWBMBp9s4xOkT30UaYrcXDCZtKnoacKsG3P+cGMNo2bkMk
 RVCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QdpHHSDCKIQe5AhOlSt+FBaOE2LgxOPaf9lfREvqLDzjQDau2vTinITiM/zGDhl4GsFM0g9w=@lists.denx.de
X-Gm-Message-State: AOJu0Yynilw9GmGr/DWYKoQJzUhuhZecgx59VOs6KAoRBPTYXBCEyJ28
 +IIlNQzg8I7UPdLJas+71YRLC1pdItPAaJsyA7nEHTu6sfg44ruUvba1SC3UIOlLsdeQhGnyBuZ
 zqzhbjxM=
X-Gm-Gg: AfdE7ckHNqiy4xAByAGUDgS5aYe48K2i46ZhkFqybupZlE34GzxQ3Y+b2viAUyL1oCc
 1LXIPyl0M4UxkhV9z89SE4U3QWeacljQMRiMVUXNA+OuwYKlIU26naBd2L+H0YXO90U7sCkCg6A
 KN/NyXzxRuywdE+xYd1NqqTM085p8dL/NyH7VujRyXbBfFTLlI4DiiM93Ok1RtnTcsf7QOl9Bjm
 bqsS71v85gUEn9IkmY4Jm1NAf2Tl5VuOlxR19JihMx85VIy10Sl9GuXUYChI0p8PRNpNPrgkpKs
 0CGsfrXeuDdQLFWmkyyZRlJRtQsd5fcMlf8ZEX0Mj/OqlUs6kuATIoDXPLmYUZy0Oge9y/yjGDT
 ZAVIhpQYw4kUXrWcQfY0HGjxSC2KrqzVWB0N5C9qw6F8GVgWHDSYnZe87pAn256zDIw8MNh+glX
 tv/Swy4pXHP68oZfJCmBZAJKEeeZM0R+nd7daf/qGXpyLZLReoaujW/ffGGmheEkITIpXhesMiQ
 FrTCsYRxc4y4DnJbVc+OMqXC3qMrLB0IKM4n0tpQ2u7UmxCitfJEz//v2S7xCC2/GKNFIiFiC+f
 paIiwMhMJsIgkaps9gm4bUkJVpM41kchp6347b2XZ4u4o9gji0aJY4qonsRBmwxjdBU8YqOM8gW
 3aF284AawRxlFDlb/mVxju6WEnJTpD46Tmo4BkaLv3TmkalqzpY4Iugg/R0oLzKqxUGA3T/k8nn
 PQuu1jhFpxkiMj+uEXCMvDqoOH1BGl0PSy0zJimm+C31SzJuTjmM35fhfmfnetNUF1y4xhTWAFq
 quso3XTqubH4tucJd99Ic130A==
X-Received: by 2002:a05:600c:560d:b0:492:4714:2d7e with SMTP id
 5b1f17b1804b1-493c2ba8359mr101398145e9.36.1783082806989; 
 Fri, 03 Jul 2026 05:46:46 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636ec8asm110442445e9.1.2026.07.03.05.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 05:46:46 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Change the return values if a TPM is missing
 during GetEventLog
Date: Fri,  3 Jul 2026 15:46:35 +0300
Message-ID: <20260703124636.93709-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
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

The function defined by the TCG spec looks like:

typedef
EFI_STATUS
(EFIAPI *EFI_TCG2_GET_EVENT_LOG) (
 IN EFI_TCG2_PROTOCOL *This,
 IN EFI_TCG2_EVENT_LOG_FORMAT EventLogFormat,
 OUT EFI_PHYSICAL_ADDRESS *EventLogLocation,
 OUT EFI_PHYSICAL_ADDRESS *EventLogLastEntry,
 OUT BOOLEAN *EventLogTruncated
);
and the spec mandates that
"If no TPM is present, the function SHALL set the following values and return
	EFI_SUCCESS:
	EventLogLocation = NULL
	EventLogLastEntry = NULL
	EventLogTruncated = FALSE"

However, if we set it to NULL the local assignment is discarded when the
function returns. Set it to 0, although on some platforms that's a valid
address.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_tcg2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 1d52a04ca48f..07637df7660b 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -352,8 +352,8 @@ efi_tcg2_get_eventlog(struct efi_tcg2_protocol *this,
 	}
 
 	if (tcg2_platform_get_tpm2(&dev)) {
-		event_log_location = NULL;
-		event_log_last_entry = NULL;
+		*event_log_location = 0;
+		*event_log_last_entry = 0;
 		*event_log_truncated = false;
 		ret = EFI_SUCCESS;
 		goto out;
-- 
2.53.0

