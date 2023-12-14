Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9D2C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE5087B81;
	Thu, 14 Dec 2023 19:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ho/fd+PL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 528A587B74; Thu, 14 Dec 2023 19:17:09 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36D8987B5F
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5e282ec7537so25431417b3.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577825; x=1703182625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tPUs9CHsDznTX1gHmhpde0oSPX+48wD7UlZgGZ+7b/s=;
 b=ho/fd+PLQX3KcK21sEzv2HyKHx3aIwBjF1y23zJ50Jdj4UQ62XdnhVRHtvYpjiFRIt
 R+q6GqsTCzc8LYU+9DCYTlp+vUEhC0STypMf9ZrQOeYZxXTG7V2ETsuId6doa3d22Eyk
 bQuAOOW5KDK9QQL+ovYeEzXuDlFwTuPmJOB10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577825; x=1703182625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tPUs9CHsDznTX1gHmhpde0oSPX+48wD7UlZgGZ+7b/s=;
 b=WPDp2RGe52QbSl+XQtxn53vPCjZbU5wsKWi4kjehpT/dTUs8vB2YXW+2AJjc7Cplwl
 biiK9RhJn8MXAt9GAGMxFRpXB0qbgn5ETGyDm1EVgFZAI7CUIAuD91V2PWcQAOtzFHn1
 TBq67kMdNPAnC7wartIArDk9BguLurCXNUjRDMZLZ7OXTL83PEq1LmFD0ATFXzdaLlxj
 rfcNsangwse6lk0Em4jhq/XSgF9SwJGlye7i0T0crv9GCo3sh1wYswGuTP/4HzlUBmtt
 Q/trGgGRAesl4HevHQFk+D2qBnoSJweu7410WMowk+J64cbc0lM3llsE4dpCPk9X2Jmt
 wTTA==
X-Gm-Message-State: AOJu0Yw0nJvK7v8tZk1aTp0nQa3v6cr+3CiteyktjRiKWXjxn/GUwSDC
 sX3beBMd16s+zlJbtqQkEQtmbLiafBs5p4gJU4M=
X-Google-Smtp-Source: AGHT+IEIzaeNvFGSP7qZocPjz1aCGcQs2gUUTHCu/aLHnrOcq/sgpHlDgm+7XtahAxZx6hWzdeFTeQ==
X-Received: by 2002:a81:6085:0:b0:5d4:90a:c3bc with SMTP id
 u127-20020a816085000000b005d4090ac3bcmr8966256ywb.30.1702577825305; 
 Thu, 14 Dec 2023 10:17:05 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:17:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v2 07/16] arm: Remove <asm/types.h> from asm/global_data.h
Date: Thu, 14 Dec 2023 13:16:49 -0500
Message-Id: <20231214181658.3359902-7-trini@konsulko.com>
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

We need and include <linux/types.h> and this in turn already includes
<asm/types.h>, so drop it here.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/include/asm/global_data.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 75bd9d56f893..2bb978d66839 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -11,7 +11,6 @@
 
 #include <config.h>
 
-#include <asm/types.h>
 #include <linux/types.h>
 
 /* Architecture-specific global data */
-- 
2.34.1

