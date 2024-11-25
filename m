Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00EDD59D6B
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEF4489A75;
	Mon, 25 Nov 2024 21:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SBYJjs45";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC93689A6C; Mon, 25 Nov 2024 21:45:19 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83BA489251
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-84198253240so50747239f.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567515; x=1733172315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKF6RrprBaSd15N0UzL8MQ08R7dIXoxa6MEhDTnJhhc=;
 b=SBYJjs45Wyyxs96j1HZy58T9AN7sCjvkpaYtFpwWzobpDSXKE3uDEBUVGPVpRhmsCj
 DpTlVuOCzUeI6lmkVgLRPLOyxglgaBSFvSJPJfoHwh/kNaXtHBIo33FUmlJInjW7iWLz
 /5zj8fKGy2OjPQj6gy4qs4xSs9FOsstEqEOCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567515; x=1733172315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKF6RrprBaSd15N0UzL8MQ08R7dIXoxa6MEhDTnJhhc=;
 b=WUXIbjxt3WxIhmn/D/iyhUMdIO5k0t8HV6bs1SOxi5Oa8sLrz1XGRarnkpJKGiO+cW
 Ij0IU0wh00prWhtrLY22CtztzAJlXvSrs8tmdS+UTHz53WdUOvu8JYtNJCsN0frKEvMN
 OmVnbF/zBQ5yWBOdtPNay1bYaHQ6SMGU5NlTldGqWHNcPfzKPKzshmMjOjRR/XYAVnM3
 eDsN1V5hEXTCyChgE+1QCMqT8/r0hPtbOGJi6u1smvhXMsrj994k3ZBo+pAu2f2BhS7Q
 jYhiltT1kKdILifsV4ibdT4U+cPgV2vpVef/exuFUHrW088ugS1+rJZadaZAxWmz2Xa8
 BXew==
X-Gm-Message-State: AOJu0Yzg/jdaCpRoYch+U17dOOh0JECtFRu8IPD377N6KVYGjkW+QA37
 swt/MTi+kXjVnj1FIDUwoiSDFR6BeGS5w6dSzReiuv7krr708+/8X7gxy3sSBmLS5dohx+k1+nM
 =
X-Gm-Gg: ASbGncuMwAvEy+w1HglpTuDAJE4HTDhRCJJNaSKfoeBrDkoBivAkPzDAB1mKyed6lHG
 Soc2qQVmaR9YoiTfGKMsp6RB1AJlNnmcQJQLVMoFJQtdHSnYOr2Z9uCsEq75RUAVPJj2ifyWBTC
 6B7BRXhGST0aJ6W8c5OYQcOEKHjM1s28FWbd+rccAehq+gq8R3ipYLm65FB+F+fuv31QDerDgOf
 33qhZ+CyJrjrCcH+p4kvzoMdv5+0I0Ge6U8l206sJkT1gQ=
X-Google-Smtp-Source: AGHT+IEFzurx/K0R9XZ0Pnif0FKvF3vTydoRfWMolTEA3E2eVIfc5KwC9fYtfs9feQH8M9S5WXsh0w==
X-Received: by 2002:a05:6602:154d:b0:83a:f443:875 with SMTP id
 ca18e2360f4ac-83ecdd140e9mr1346936239f.15.1732567515311; 
 Mon, 25 Nov 2024 12:45:15 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/13] efi_loader: Convert efi_get_memory_map() to return
 pointers
Date: Mon, 25 Nov 2024 13:44:41 -0700
Message-ID: <20241125204456.1525752-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125204456.1525752-1-sjg@chromium.org>
References: <20241125204456.1525752-1-sjg@chromium.org>
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

This function should return pointers, not addresses. Add the conversion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index e493934c713..8b01821a993 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -748,6 +748,11 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 	memory_map = &memory_map[map_entries - 1];
 	list_for_each_entry(lmem, &efi_mem, link) {
 		*memory_map = lmem->desc;
+		/* Convert to pointers, which is what the caller expects */
+		memory_map->physical_start =
+			(ulong)map_sysmem(lmem->desc.physical_start, 0);
+		memory_map->virtual_start =
+			(ulong)map_sysmem(lmem->desc.virtual_start, 0);
 		memory_map--;
 	}
 
-- 
2.43.0

