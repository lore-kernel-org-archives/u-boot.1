Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D609C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AEA981DAB;
	Thu,  6 Mar 2025 17:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WllgbBQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D82CB817C4; Thu,  6 Mar 2025 17:06:09 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E13481DAB
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-85b018062a5so68790039f.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277165; x=1741881965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+UMrzanNEKubtDZRRt8rlC1DNa13mIBpIbv6DQ1xMg=;
 b=WllgbBQaV2yMmzgECH0MmMa3XQ5IiJ4N6oERrzdZVFdk+IeRD0Q0BOTbo9K+P7KYM/
 zIxNYMSelmF8hkN3u2wXEt55257bLqAbRj40XBTYZhd/Xz+UTEss3UUcQ++IqPiqj0DI
 6Xv05E4fVRmK5H4ccJ8d4dYk0FfxEyC6C0qt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277165; x=1741881965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+UMrzanNEKubtDZRRt8rlC1DNa13mIBpIbv6DQ1xMg=;
 b=NaZ9dLDzbQ0liXu3lEBnpdkucL1UGLQV5zSPGjauwhrCHTS+1L2IgHpnNokgS64ndI
 /Rbevl7J7Aq15gfCLoM4fgCmYnCrnDtb0VCjzsyl7VI5U9DRw29GIUL1TegJDjVJMnQ3
 cgvwopZ8N6EmqBwqpwnyiqVlSFgsb3JmKHOUvY7J+VkW5/ZJ2ZIuAQ+pUvxSaUMYP9y/
 52pj9Tp9lNhI8rs+6hc6zbWiGwUKRyTAscmniuHs/JxmI3FeoB3+ng2/Ijz556C6Je5V
 QaTyk28tVgD8OR9ZjVEiZmIgXXCJqoKhoYtIDNhVwsHDmiSnHBEwRvqHDM0wuVeuqNZ1
 WTnA==
X-Gm-Message-State: AOJu0YzXolfm8UhsyKzX4sPY49tHGl9+prUDIVEQydvpjr1COIAfU9Tr
 Kph12CyvoUH/SZpocHSawVwBrYNldv8XZBUXcoB651I8W9MJOyjDHWT+11U327pYRv8dzgh5Eqw
 =
X-Gm-Gg: ASbGnculUlYJLLKZ+v7144yfAvsu93Hj4puiB6hA2j0+6npDEXkywxML1f7Tg/fKy1L
 i+QVMN7W9d4HwUEAeTSraDGy7g0hfJGfIGe7vgk5XP36d1DATj8oOTaqjWT6c/pDZM5DsfJz2dn
 V/ZoiUV0YNo5YoVQAjWjiANOXuw1zozYyZ6Qm2+PG/ax9/Z8CoRDfyai7APwmY2LVHDWAPEPoxs
 o9uxvgTWpueHtVjbqL1sHseTRJw1QPOLVvu0IgRYMwBlHzqtskqSICiBY9/VmeWAntnxy7WhNDe
 dJzzyUDcbe4oWwEikYZxy/EohYoGqGozWSjECbR1QAhLDtFs/xoVQHCZxHMzFsGALYuJ4googEH
 3/QCMsw==
X-Google-Smtp-Source: AGHT+IE5Opd8lzmalTT3KSH4fofJWQuliZEOVh8ihyqlH9njoAzv2Xf0tif+8QOdx/N9xHrvbql99A==
X-Received: by 2002:a05:6602:720a:b0:85a:fd37:1c65 with SMTP id
 ca18e2360f4ac-85b1cf985c4mr8452139f.5.1741277165450; 
 Thu, 06 Mar 2025 08:06:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:06:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 37/47] acpi: Mark struct acpi_rsdp as packed
Date: Thu,  6 Mar 2025 09:04:04 -0700
Message-ID: <20250306160428.3041057-38-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

At present the size of this struct is too large on 64-bit machines.
Annotate it with __packed to fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to mark struct acpi_rsdp as packed

 include/acpi/acpi_table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index b8b1f1338c6..8ef19adc990 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -36,7 +36,7 @@ struct acpi_ctx;
  * RSDP (Root System Description Pointer)
  * Note: ACPI 1.0 didn't have length, xsdt_address, and ext_checksum
  */
-struct acpi_rsdp {
+struct __packed acpi_rsdp {
 	char signature[8];	/* RSDP signature */
 	u8 checksum;		/* Checksum of the first 20 bytes */
 	char oem_id[6];		/* OEM ID */
-- 
2.43.0

