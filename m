Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50473C4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4079D87B88;
	Thu, 14 Dec 2023 19:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cMZGQvvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E95E787B78; Thu, 14 Dec 2023 19:17:09 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63A587B5B
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e41dc5a4cbso2221467b3.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577826; x=1703182626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3c4mFfTM0gvagHXfht3FwwqIIaQSWu+nWCd+cT/EzE=;
 b=cMZGQvvjAmU+0rydDzT4OH/C3HMasWUtozRgz7cYfGtSrOq0QPxoEX+oziatfQVitJ
 +IxqBsMpwmXvE7W0oD2OS17YTkTMbTj8SrZauecarnVouDBrfg1de1QkcVRtVQzHhAH7
 0JAqmmvnK9pO1cfAw7DXOrue0u5HoSlqNcj7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577826; x=1703182626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3c4mFfTM0gvagHXfht3FwwqIIaQSWu+nWCd+cT/EzE=;
 b=otaeSwwQcVrhrHSgTRmjxQW+0VMOfaY4M1IVZvlI6SbQwwNz/OhXXT7zq+0HbwJbjb
 c8II0Y5kpCIHfDCOfJ+b2vmsr/wehq2v2oWf1+UWckao/eUvf6wr5lnbhZnt0HtD8iF7
 3nb3WZ39mgPq0Yl9Tslj73tINkE9KTUKwvzO0pAMuSsZiUcVPUXBVj6bWXgFCyDmB1xe
 Diy9i5LkIPfJCpfK6JHvslauCESjy3wbpz4RZx9qe/N/UrQaMHgAVhBs5TLEaMJtyClK
 TKBI+w1NoXqu9MklvbI3ebTW6znpa1r+4rve3vir68J1kXdAkAm6jEmM3ji+rMyC2SMn
 orEw==
X-Gm-Message-State: AOJu0YwDxbliN5zomccNPVVlpyb1tRSIE+kzGhPO0nsGGPHC10iHIdnd
 6X+Eqlm0WSIT1RQxY7pa1SMFnzJ/QnxNHf9keHQ=
X-Google-Smtp-Source: AGHT+IGrwKe63F8l1EZFnhMyIKcnOasZOX2iRccvJnkx88DlNdBEZTA6AWz7sDKIgUMhJE6nAdSEyQ==
X-Received: by 2002:a81:d541:0:b0:5cb:332e:ab68 with SMTP id
 l1-20020a81d541000000b005cb332eab68mr8446941ywj.5.1702577825980; 
 Thu, 14 Dec 2023 10:17:05 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:17:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v2 08/16] sandbox: Add <linux/types.h> to asm/global_data.h and
 asm/io.h
Date: Thu, 14 Dec 2023 13:16:50 -0500
Message-Id: <20231214181658.3359902-8-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214181658.3359902-1-trini@konsulko.com>
References: <20231214181658.3359902-1-trini@konsulko.com>
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

We need <linux/types.h> in these files as we reference Linux types.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/include/asm/global_data.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sandbox/include/asm/global_data.h b/arch/sandbox/include/asm/global_data.h
index c6977735029d..001b2b53c1c8 100644
--- a/arch/sandbox/include/asm/global_data.h
+++ b/arch/sandbox/include/asm/global_data.h
@@ -9,6 +9,8 @@
 #ifndef	__ASM_GBL_DATA_H
 #define __ASM_GBL_DATA_H
 
+#include <linux/types.h>
+
 /* Architecture-specific global data */
 struct arch_global_data {
 	uint8_t		*ram_buf;	/* emulated RAM buffer */
-- 
2.34.1

