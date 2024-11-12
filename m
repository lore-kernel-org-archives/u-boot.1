Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CCDD42B82
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56F848947E;
	Tue, 12 Nov 2024 15:00:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lQqkGelX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A3089473; Tue, 12 Nov 2024 15:00:00 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CCD1893C2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83ac05206c9so211028639f.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419997; x=1732024797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5QZZI8rXwwkjJ5f4pflbwchSpTPNdc/6kL8mbAG2yI=;
 b=lQqkGelX1Pb0Al9lD5KKNkgOc1b9uYDOV8uMdH6oIY9IQ3DB3AfM7+vy5R64vOZmdR
 FG1+jzQWcV6v6/j4yKfEB7V50F76FbdwB83ys7fDIejPwJehEhsNQKkCKZl/X2O7aE/G
 Uq1b9O6mqhFU4bvr5af5+kXaZcGpFYA6kp7Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419997; x=1732024797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5QZZI8rXwwkjJ5f4pflbwchSpTPNdc/6kL8mbAG2yI=;
 b=L49vbqg3ZRqATyf3pOVFCok14c5GZCObPHXdTqitzUHiqDsrHoYMyr5hrD0fcCBmFH
 3n/ySGqsJgItYZSJPVmLwVMGaR2l8xRxIYJzWlR/kIjEIcz9TpaFtTjDlAi4nKqJDM8Q
 CNLnPT2DP4wXHd4JiIKnec0nKbjK5W2bmIfQW7ocW8BcTffFEfAez652pNczDMVcN8F9
 YffCGsMk05fexCo7mR4BSOKXqH2gp8i0hq6juLUpYrF3PYSDEg+3f98s/VkQzbsXw3un
 Rsw3BcITIBByneR+6tlG4pLzVDQ94XZOUB7jY9O+t9hXcvIbB2BHLOGwPt0C/L7WklMF
 11vg==
X-Gm-Message-State: AOJu0YzeBd69PI5LZCXdEOuWrr10snfODzG5ELxtoKbzd7IZhajkPjBC
 NFMS0axuuRHdpKUAitoh7A2xRDeZ8G+Fuw+O/YeCEWU/QjLvPpcB5kORTzhSp86J8/YuiBqAduA
 =
X-Google-Smtp-Source: AGHT+IGMwLgD+wHTA17qZFSedVERu300I153lnp4bfa6IqIlAWS+ZeFMu1BZFTd5+JS/3+qufra4jw==
X-Received: by 2002:a05:6602:3fd0:b0:83a:aa8e:5f72 with SMTP id
 ca18e2360f4ac-83e032a8047mr1975022139f.4.1731419996725; 
 Tue, 12 Nov 2024 05:59:56 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/18] x86: Include stdbool.h in interrupt header
Date: Tue, 12 Nov 2024 06:59:07 -0700
Message-Id: <20241112135911.630586-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
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

This makes use of a 'bool' type, so include the required header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/include/asm/interrupt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/interrupt.h b/arch/x86/include/asm/interrupt.h
index e23fb2c8e72..c689fc23d08 100644
--- a/arch/x86/include/asm/interrupt.h
+++ b/arch/x86/include/asm/interrupt.h
@@ -10,6 +10,7 @@
 #ifndef __ASM_INTERRUPT_H_
 #define __ASM_INTERRUPT_H_ 1
 
+#include <stdbool.h>
 #include <asm/types.h>
 
 #define SYS_NUM_IRQS	16
-- 
2.34.1

