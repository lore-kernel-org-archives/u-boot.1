Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A11BC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 12:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAFBA87101;
	Thu,  9 Nov 2023 13:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Br52MNHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4870387168; Thu,  9 Nov 2023 13:56:05 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42E4686FED
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 13:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b4145e887bso435974b6e.3
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 04:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699534561; x=1700139361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vMtVPjYemDrrvRqJb/5Zkca42TYRiTdPzQ3L0UVIdNo=;
 b=Br52MNHbedf94K0dUCOHcQhInSqVGj4AkiW0Spsk17ATt0jQ4W4ztLVo+GO72gSK4r
 XBkT23e2ZW/IMRED6vJOjIKYsVpg+1Uce0WXOcKaVkAVOGGaccUakMsP9LD4gLi2NjbL
 J++Fel6lItN8ZEeyULLVy4pTMX6fscihWrrEglISCMVbmAo14JM1vFSyGColOyHat1QS
 HBCn7bSpkOeicrancRpBf68ijJ2OONlMrte7VFv6l4JyQWGhBQ8DKkx4syXvP0I3+69B
 WYRsT1cOkJ/9POBJ6i03cKV7kjsWrgCvLnivw+XWLBW9fmHS4+qtgjMNhn661nTmqwqm
 38DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699534561; x=1700139361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vMtVPjYemDrrvRqJb/5Zkca42TYRiTdPzQ3L0UVIdNo=;
 b=h2H7uSVtJJXNIRnVwf2eq4/qvNati0fWWvK66bzDbhvoKxjbhNY+UOzz4lsdNpP//K
 Y1KpbYKHQfIBc8nyzNS8NRLaM32pegBguSMgNQgEA5nzLbkhiPHOklJ3uU79GAGd1LHB
 5FFAeg96uOrnm2NQHddaLhQH+o4F7vJI3hyJyLromZNUPx8m+LkcK4T2xeC8/aUTRa5Q
 PAHpOlwP9RGBaRQOIuAdivnUNfW/liadEN7UJNpa2pe49KwG6SbEPFkr6fJjgV6ct7iZ
 6Bx+U9yKP9/oqob0MPHC/a4Oy535K/fnXIpyfITKUqcBea0Bg6Tly57g9uujaOaFBTyV
 wOSQ==
X-Gm-Message-State: AOJu0YzdPCbdQpM7/4QcR4pm0Ahz5hj/0Qkoj72AhZ+BQmCphi3M4gZV
 4dcIG4crXuxAuItcmxV5jNsHMvYEaYwdKBt4
X-Google-Smtp-Source: AGHT+IFGNBt0V3UXivw3skRE3pvAT3zoncCVW8fivmR4aP8C1tGSgeDnz80P7DtZhJFgKEKBB0HJ7A==
X-Received: by 2002:a05:6808:211c:b0:3ae:55e6:1e34 with SMTP id
 r28-20020a056808211c00b003ae55e61e34mr1545166oiw.58.1699534560705; 
 Thu, 09 Nov 2023 04:56:00 -0800 (PST)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 t190-20020a632dc7000000b005bd980cca56sm4624094pgt.29.2023.11.09.04.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 04:56:00 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: u-boot@lists.denx.de
Cc: Weizhao Ouyang <o451686892@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] efi_loader: Fix UEFI variable error handling
Date: Thu,  9 Nov 2023 12:55:41 +0000
Message-Id: <20231109125541.10845-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Correct some UEFI variable error handing code paths.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 lib/efi_loader/efi_var_file.c | 1 +
 lib/efi_loader/efi_variable.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index 62e071bd83..dbb9b1f3fc 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -236,6 +236,7 @@ efi_status_t efi_var_from_file(void)
 		log_err("Invalid EFI variables file\n");
 error:
 	free(buf);
+	return ret;
 #endif
 	return EFI_SUCCESS;
 }
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index be95ed44e6..13966297c6 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -350,17 +350,17 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 
 	if (var_type == EFI_AUTH_VAR_PK)
 		ret = efi_init_secure_state();
-	else
-		ret = EFI_SUCCESS;
+	if (ret != EFI_SUCCESS)
+		return ret;
 
 	/*
 	 * Write non-volatile EFI variables to file
 	 * TODO: check if a value change has occured to avoid superfluous writes
 	 */
 	if (attributes & EFI_VARIABLE_NON_VOLATILE)
-		efi_var_to_file();
+		ret = efi_var_to_file();
 
-	return EFI_SUCCESS;
+	return ret;
 }
 
 efi_status_t efi_query_variable_info_int(u32 attributes,
-- 
2.39.2

