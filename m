Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC861099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 614CC841A2;
	Fri, 20 Mar 2026 21:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s8ex5XoV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77AA083FDC; Fri, 20 Mar 2026 21:54:01 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559E684105
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4152698e745so450767fac.1
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040037; x=1774644837; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=r4C3Q5WuaTBV+aJvbc/XBx95L9ogjD6oHj1kFB4SqdU=;
 b=s8ex5XoV0yrzAbRrc2/F7cV5MTOjlWx1NacvCMxFdXP1f7JH7YjtqZgrRKnMnazeWB
 lpNQ2iTTPQ1tRjf0Q3RdzMFPdmZGVDBATSVnwL3UM6Ig6MKgORvVfXoE/r4kpPeGgDmp
 ekbtO4NOTzbmZzkRHdpyoM8UV62W8pF6cXyeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040037; x=1774644837;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r4C3Q5WuaTBV+aJvbc/XBx95L9ogjD6oHj1kFB4SqdU=;
 b=CbHOF8nLiSsMmou16C8l1u60lqM58+BZk1XUNx+4uJbF8J+x8KG4tjdqiAkfPuXNu4
 +IZH+e8E2zrYZ4LbExDE0kUqemujKy7vRW9sQiqLsGE4AiEvA/Ad8U/KB5FhGmfLlXeH
 AlHKcpvwLVJclMna/Wxv3kcPA6ccHcd0vqREbJ4VjXBGHGAa9yFM4tOPic9zKKPwDvDq
 jKm5+qD38vFWRHIa4I12Z/QZP5v5jSSoPwlxt2lrTyZa9yy9XIQGlrPynhrem1ZUP9fJ
 b3+qUBBsfqmOO2yDFO+2mFb4Fx3VFgGx4CvauJs9gmKSciO/2uRDg1pa2GLa6zgWfOfA
 +8Dg==
X-Gm-Message-State: AOJu0YxNfJt36ByMESaRFBC6Xnn25VPywBs/ZlpmShw+PVuKpdJIYAdl
 x84/IQrUWmZWwxvFPDDcMMI0LycTAsSWPyckr3o8lYmPX/qm5MRMGP0v/CteYCZAeQBTe8dOqnL
 IOev9YFQ=
X-Gm-Gg: ATEYQzyTqLL51GY/Ilau8iOmGFizxerCfQapUPHrIcqAZ9KfggvHsl0RV8kc2fJAoWI
 MgFsac6gQ+cnofWUfON9J/fLYkthTyC4Z0CWxfE6zKXmkV1kI229urcAEvlSW1Zcbn9RMSV/ZIn
 QOqCEAlP5mMd1LXx5l0EE8PcafbF//leNo1AoV6IiVLuCkmxNzs8ai2TZ4/pX0aqHPy5yBD7yN5
 VwcuKXb0DYESiIvH9QhrItY2Z6SaIMOIvmLWAvgOpZ6Rx+ZhkRFbxO5epUp5V6k5yJgfabg93Sa
 Jjt4pS0PO2ICux6wpj3ltB6diL2Cb/df7oPHGusJYlMSQOfJFko0CFuEJh4V1+bxRKfJmxZo83j
 2/WQ3HM7R2FKRclTcFU1tJ4eYRaH4ChjdX8B2UUvBoAOQu1TWkS4e09YhmhVttFFhRvencd6Um3
 WKNMLEYvjfFctEadckp2izlvPZdGEthzGHnSdoN6zHnrPIwDRW1bjA+3EyUbBnbkH6c8JcH2HKu
 F8ZaBwNh6SUmCfC/+V+EPC5/d2dW4fmvwtBuzPwhSU3Y8O1YTw=
X-Received: by 2002:a05:6870:8988:b0:40e:b6b2:b97a with SMTP id
 586e51a60fabf-41c112c7312mr2745658fac.51.1774040037642; 
 Fri, 20 Mar 2026 13:53:57 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c148a5f99sm3253653fac.2.2026.03.20.13.53.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] acpi: Correct dependencies for GENERATE_ACPI_TABLE
Date: Fri, 20 Mar 2026 14:53:56 -0600
Message-ID: <20260320205356.3789155-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

In order to build this code, outside of QEMU systems which instead have
provided tables that we use, we must select ACPIGEN as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 lib/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index e20519873524..46384283c435 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -338,6 +338,7 @@ config SPL_ACPI
 config GENERATE_ACPI_TABLE
 	bool "Generate an ACPI (Advanced Configuration and Power Interface) table"
 	depends on ACPI
+	select ACPIGEN if !QFW_ACPI
 	select BLOBLIST
 	select QFW if QEMU
 	help
-- 
2.43.0

