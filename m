Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAABC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C925878F2;
	Sun, 31 Dec 2023 16:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fAD3dqRG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85543878BA; Sun, 31 Dec 2023 16:26:20 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F8DB87886
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7baa8da5692so330889139f.0
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704036376; x=1704641176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGAFEpIgRq7HzVR/Ef5GLskHF7/wi7QbKf9yFnmQAvc=;
 b=fAD3dqRG3FCnw9W0XCWP2K+wnxqnRw/faHXO1LPFW1XNODjBpsf09y/vcHgdXLauuV
 4j1UeEZwFAWweC+aPjjMo8zHYZhouGp6DSx5zl5FFQupEWSBJqjbhOcazvnWt3vVvCb7
 bf31mzPNtW+3xyWh1o+mDWauSTxciaQxNmvEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704036376; x=1704641176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGAFEpIgRq7HzVR/Ef5GLskHF7/wi7QbKf9yFnmQAvc=;
 b=s06rFe6aOc89o/tV8CrnarxMUp6Og1JBsHsDnwv4rTHFdwZxVql/nVyoRzGOfeEScJ
 mEu54CL/W51d7RqEKuDVfE2KflWLn881zt4lPCajZDvn5xXftetYZGu7ahFsR4WT85Wa
 q8EkqwLWb8kl9tj6mTFhh4t33x6z+5mrkf6zAjV0yU1ntH78veg0ttzPDP+xojMWWyO0
 B8rzk59FAniwULOuep5ZtQOjUuX6/HSjTXDL9NdAUwewaIsLVEa08eCLhTiVdWRueyp2
 nF8fj1XT0E5AczSuTbzsmv4dpi5V3S0It4BXj4fg1/k1GlfSPEsdLAB87uu5rXdC/zFj
 HIIw==
X-Gm-Message-State: AOJu0YyXNwov2VqURhwaKwnuqmkzKs9WxA85oP7DaWFUVPAM1DBvJaLs
 3Tk3xoFgnQlfurCjVBVFjKGZ35xfRktqgjIqDYodTBXbduDN
X-Google-Smtp-Source: AGHT+IG+u0qqen5cOGRHVZ/6Dtux6O/OQXjLF2+GKUaHUzefZ7fIcQqAuK063gLCBTA9EtrhKsZeuA==
X-Received: by 2002:a6b:c8c4:0:b0:7ba:814e:3619 with SMTP id
 y187-20020a6bc8c4000000b007ba814e3619mr13704040iof.43.1704036376221; 
 Sun, 31 Dec 2023 07:26:16 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cz9-20020a0566384a0900b0046b482039ecsm5632625jab.55.2023.12.31.07.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 07:26:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 09/12] efi: smbios: Drop support for SMBIOS2 tables
Date: Sun, 31 Dec 2023 08:25:52 -0700
Message-Id: <20231231152555.464874-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231231152555.464874-1-sjg@chromium.org>
References: <20231231152555.464874-1-sjg@chromium.org>
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

Only the v3 table is supported now, so always use this when installing
the EFI table.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Add new patch to drop support for SMBIOS2 tables with EFI

 lib/efi_loader/efi_smbios.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 5cbce6dc4eb..5db342ee0d7 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -27,7 +27,6 @@ enum {
  */
 efi_status_t efi_smbios_register(void)
 {
-	const efi_guid_t *guid;
 	ulong addr;
 	efi_status_t ret;
 	void *buf;
@@ -47,8 +46,7 @@ efi_status_t efi_smbios_register(void)
 
 	/* Install SMBIOS information as configuration table */
 	buf = map_sysmem(addr, 0);
-	guid = !memcmp(buf, "_SM_", 4) ? &smbios_guid : &smbios3_guid;
-	ret = efi_install_configuration_table(guid, buf);
+	ret = efi_install_configuration_table(&smbios3_guid, buf);
 	unmap_sysmem(buf);
 
 	return ret;
-- 
2.34.1

