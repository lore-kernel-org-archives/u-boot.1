Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A04EC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A948858C;
	Sun, 23 Jun 2024 19:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a8NHxAkf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C64D0882E6; Sun, 23 Jun 2024 19:53:31 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D3C883C8
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7eb895539e3so143364139f.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165208; x=1719770008; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPDTBpVZuVkaqULrtYe8FXz9i1e5MJHdje88Wa78OmY=;
 b=a8NHxAkfC4l+0bJnUC89c1Fd/Te2BhJYzN7rHygHNQE2NroXfB9ppOaHHA8Ypdi4Z9
 OybHjWrm2Ft9UTzBxrvxj184E/X5HYW+yCG5Uw/3ZqrOzec/AcFBeA5LZP+bKrKuXR2R
 WrPk0d7Mu3VAWrziklXgCQqLtrmtqfMQByD8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165208; x=1719770008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPDTBpVZuVkaqULrtYe8FXz9i1e5MJHdje88Wa78OmY=;
 b=KLjY1C1RckmOMwfK1tPSOjTiYAkDKu1hWQteUnaW0u8BvZPHrBp2e8Mo7ZHFGnWCE1
 IDo/8j3S+yJ+VCSUiZ+RstCRF3U4t67LVeFUJeEAheHh5U+6PN4uz3k1SfFfRZ3xa5oJ
 J/IW85EOW6yWj/lEaw8cbWvC+bBq/V3r2/zNKWBuHa7ByfoZEFl9tE19rsPSrauLAy3C
 q7nohP02CuhJ5FIfJWsSEQnBW7YB++lXbU566hzUMS7VzkWeXXlragsJLJ/XsLXRgGPG
 j1E84KbV3EvNP+3hhFRB2mTDxMP/m2j0rf5WlKgO1lfJR1HAnVcOU28QC7k/J0CZIZx5
 h63Q==
X-Gm-Message-State: AOJu0Ywujje31Rp1QU4R8Dt1oDBd5DUEvj7YaSj45Viphl0ekOTJWjai
 rTjAUmwfH6nPUG2laX/y3nzOZthQ/JuwnBX/xj8/7fjSr0B7B22L8H1Au40I0W8phfcxpUpQsY4
 Ztg==
X-Google-Smtp-Source: AGHT+IFk40aj+L5+NrnBYdPOKlRONSO0IVoVedumpzcv/nVcjia/1Nm2TJPWNZ7Hq6KYUAw4Ob4C+Q==
X-Received: by 2002:a05:6602:14c3:b0:7eb:c7ff:26e3 with SMTP id
 ca18e2360f4ac-7f3a4e36a08mr367763539f.16.1719165208258; 
 Sun, 23 Jun 2024 10:53:28 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 12/16] spl: Allow ATF to work when dcache is disabled
Date: Sun, 23 Jun 2024 11:52:58 -0600
Message-Id: <20240623175302.1463973-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

The dcache may not be enabled in SPL. Add a check to avoid trying to
use an undefined function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 common/spl/spl_atf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 3bdd013a35f..9afe6456bc4 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -204,7 +204,8 @@ static void __noreturn bl31_entry(uintptr_t bl31_entry, uintptr_t bl32_entry,
 						       fdt_addr);
 
 	raw_write_daif(SPSR_EXCEPTION_MASK);
-	dcache_disable();
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		dcache_disable();
 
 	atf_entry(bl31_params, (void *)fdt_addr);
 }
-- 
2.34.1

