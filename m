Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B953FD74EFC
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 16:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06B4F83B0B;
	Fri, 23 Jan 2026 17:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XGBvgCMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76BF383B21; Fri, 23 Jan 2026 17:19:22 +0100 (CET)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46E5683B03
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 17:19:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so3109623eec.1
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 08:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769185158; x=1769789958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JHfkD1/KSiBuIzHtB34GD8vhOTf/zhFhzEVj0AlSsyo=;
 b=XGBvgCMm9c6xE25V5zfdt9JtCxn00RcAPwBUR6ox2m6Em1djE2cbWjN7JIyF8eDy76
 B8cI188NXx9+IRxmBrOmRXKfazUVprX250tkcIRUGOwO/nvShTEWjk7xNi2bsboShKwx
 lHbvMy9Dmu5pSvUmWVI4B5dmI9Llx7WEMnWaoJp9YaXi/N4DBpvHXj7MxIYC/B9tZvSD
 DYsPPAsL1J984He8yi6otRo39X99zi8VTgeTYkWKrR2bc2zYayOpoe6wPBoG9oJ+8Te9
 3Vpbi0g/VZT6wsfqAmhMZWv7WZIFKchu41oDxGGPyoVtwobKyTQPT3TG3eNg5az2lfV5
 /FOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769185159; x=1769789959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHfkD1/KSiBuIzHtB34GD8vhOTf/zhFhzEVj0AlSsyo=;
 b=CGiBvElw7VvHPNcjEPHNYFtZfwg3wCXadZ8OejKiPW2on4fUFqDB6r0vlyFQzind/q
 dXMkvLDnLGbohEeGKFgN2s3of4pU0YWBTAwqedpOtX41IrtHxDRklWl2NYA93f2vcvHJ
 SQmtKQDsNu6F83MjCnoltSzZ6OIeOFWVdpUqlmV62YMrCb1V1puiPkOurlGo2JhGoIMk
 uHFkqU4J1B1hWWgxBvFyE193LJlwZ9EtbIuHL7aokMhjSxyGwcF5aseKhhEbL+QOOoxo
 oFcb4VMI88QQb6/YctC3JZOewhx1+5kWfTNmQlN7KLIGV67jRVraWwd6Lkd0QA7RD+ju
 1u+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHuusqK1k1N2yBFVE4Nc5LxYvPlOci49r3dgc7nVSfktTIRf4yHFzOb4NPWiMG8g5BtULA50w=@lists.denx.de
X-Gm-Message-State: AOJu0Yxr8pafSOn9H2CR0HB5t4flvQQMOFZ7/+iN4ZGw/OhR/I93AnIL
 o/QTEiMwm6ulTWmBwl9+SCbeLnb1J6GelkQcGPkaXfnd0spqzIavtV/N
X-Gm-Gg: AZuq6aK3rPk76vYLbXm9t5/yv4QMVFFpKs62SmcGQM1c3LrbHdEx0UhB5tGEw5RZrTK
 qQ77jYbVkqIh5xS16+Nq4+rkoSxGkVRZIH0c5DIB0KPAK4Nq0jLI52zcyZP0U3m5sF4xLFciRik
 LDkaTsRMOgqP6xLo+6YdXSwu5B7p/CXlR1YFO8YP9DayIej4jsdqN+eOg4D2JYH5KgdeSVq5a0d
 cCKxyQOXCuKGvPSvUs3vBdFFctID0+8zEBdKwJ0Pv+Qmp/lYd9xDFvzCOHrsCpIXokWKYWpc4Qv
 Qgsv+37bkZxmPXlWyAZhcm81EqkjDGae5p7nkYrg6UXreE8F2L+dUEaKBs7LC7R64SYjWQkQFJB
 MPkzUe4eTGQd1EID+g2hOtcQGwvE/hus8hZds4pXEfiq0zSy4jzG27C4ZAlOijVwbDbaX564GGA
 TGibQ+PXQFFaP8QYBHOc+muIs=
X-Received: by 2002:a05:7301:2e89:b0:2b0:5c14:dec1 with SMTP id
 5a478bee46e88-2b739b977c9mr1506778eec.36.1769185158351; 
 Fri, 23 Jan 2026 08:19:18 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d357:bdb6:cb68:468])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b73a9e1c0csm3467158eec.18.2026.01.23.08.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 08:19:17 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: marek.vasut@mailbox.org, u-boot@lists.denx.de, sjg@chromium.org,
 ilias.apalodimas@linaro.org, Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH] arm: spl: Fix DTB offset after binman symbol table
Date: Fri, 23 Jan 2026 13:19:07 -0300
Message-Id: <20260123161907.392211-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@nabladev.com>

When CONFIG_SPL_SEPARATE_BSS is disabled, SPL expects the embedded device
tree to start exactly at __bss_end. This address is fixed by the linker
script and SPL probes this location directly for FDT_MAGIC at runtime.

Commit 8b0ebe054bb3 ("arm: Update linker scripts to ensure appended device
tree is aligned") modified the linker layout such that the
.binman_sym_table section may end at a non-word-aligned offset. Since no
alignment is enforced at the end of this section, the DTB is written a
few bytes past __bss_end in u-boot-spl.bin, even though the __bss_end
symbol itself remains correctly aligned and unchanged.

As a result, SPL reads zeroes at __bss_end instead of FDT_MAGIC, leading
to a "Missing DTB" failure, while the DTB is actually present at
__bss_end + 4.

Align the end of the .binman_sym_table section to 8 bytes so that the DTB
is placed exactly at __bss_end as expected.

This fixes SPL boot regressions observed on Rockchip RV1103 and RV1126.

Fixes: 8b0ebe054bb3 ("arm: Update linker scripts to ensure appended device tree is aligned")
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 arch/arm/cpu/u-boot-spl.lds | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index d780a5060774..fc2b7fcb969f 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -40,6 +40,7 @@ SECTIONS
 	.binman_sym_table : {
 		__binman_sym_start = .;
 		KEEP(*(SORT(.binman_sym*)));
+		. = ALIGN(8);
 		__binman_sym_end = .;
 	}
 
-- 
2.34.1

