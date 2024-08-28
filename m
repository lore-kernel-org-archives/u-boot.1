Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBC2C54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45A5088B35;
	Wed, 28 Aug 2024 03:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FUCzjlge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C4988B31; Wed, 28 Aug 2024 03:45:51 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B7488A7B
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-828fb89785cso101313139f.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809548; x=1725414348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qomlv5+5BmQ36gt2HABUHiQzDEQ8UGmqKsVQ5FmUsbA=;
 b=FUCzjlge+hszFpmZObMUE51zNH8+TcuuwWQ3PyReB2o6Jiq/ybDl0Cq7MzNEwrOj6m
 CVRj4CVupcr51sXJBOCox341iuJq2kmnmpRlA5EC/GwvThkBY5KHjnzfTUqM7L0zfSE+
 SWI+FBSvHq3dhWY8w816TGEFn2YNH39DxJQC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809548; x=1725414348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qomlv5+5BmQ36gt2HABUHiQzDEQ8UGmqKsVQ5FmUsbA=;
 b=DPHc1GykYSyjmKgL20MHpRafozyQ08xTDeHnYg8YUMAE7kNPwRD8FCI/FiNHSnqVjk
 aNWTWKxSNxiIr0nakc74Z1vOGXvMhM50pKACNYKNZ7LoSQXfXOjSXb1cDZAWfnEbWyT3
 5qFVJrWCpCb6tPek4OwUH68q3Hv8CYVYkbd158McoZDsLxXYbcLIjmVbR/Rxf4w8sS/2
 dGH5PJTX4Xz1roqHfH0rRxIArRYyWCPJfsNSWqqlr+xpyRxp5rcF8c85b+ud5lvxH9PU
 KdJ6hqJAGkapG7Oqy0SFQcrn+gOHCarYwdt5gvveVVQEK/gLIJws5xL9CTA+T4ukH3bz
 smHg==
X-Gm-Message-State: AOJu0Yxb4IYSTtVBqemPrbjeVQ7XZrIpgpqOjz5nyZITBnoNnljx07ZV
 yK/+d/GrbYZywlu07F+86Iu7tbE+YOJlhdcVJW4HKMGszuCjd/JvdMhcT5dw7Mvj7CKZwKqn07A
 =
X-Google-Smtp-Source: AGHT+IHRm9ux3/cg5lCwyDn7vJpml0qyAJdS713QmcrQ6MdorkMir9sazWh226WrrvZewLUBoA63UQ==
X-Received: by 2002:a05:6602:3fd4:b0:829:e867:d6bb with SMTP id
 ca18e2360f4ac-82a03e714e1mr67224639f.9.1724809547881; 
 Tue, 27 Aug 2024 18:45:47 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/18] sandbox: Add missing header file
Date: Tue, 27 Aug 2024 19:45:20 -0600
Message-Id: <20240828014538.3322013-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

This file uses __aligned so should include the header which defines
that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/include/asm/sections.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/include/asm/sections.h b/arch/sandbox/include/asm/sections.h
index 88837bb35c8..5e1577419b0 100644
--- a/arch/sandbox/include/asm/sections.h
+++ b/arch/sandbox/include/asm/sections.h
@@ -10,6 +10,7 @@
 #define __SANDBOX_SECTIONS_H
 
 #include <asm-generic/sections.h>
+#include <linux/compiler_attributes.h>
 
 struct sandbox_cmdline_option;
 
-- 
2.34.1

