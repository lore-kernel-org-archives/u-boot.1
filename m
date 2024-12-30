Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8632DE7718F
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 10:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7347A80607;
	Mon, 30 Dec 2024 11:31:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FFiK+Q2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2443B80570; Mon, 30 Dec 2024 11:31:07 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0FC680584
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 11:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38634c35129so6911368f8f.3
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 02:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735554663; x=1736159463; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BHtk41PGmmkmjRHwkyCjhxhd66vRvgl1XZKtZTeeTbQ=;
 b=FFiK+Q2ycZSIBG01eUSSpZ8H9AVx85NCqxELLus5JlUwj4/bTZm48XEUOqKGFD/seW
 Sq0DRX/7JcKO8DBAi81HyKtxaQwJXsaIriltVoiWX8aw5S4okKRvmFQuz6CwLpYC+NBO
 +mnnNcbg2HL1Pak5uB7P3g5GPZdQqMIuw4tO/Vr8z/uXL4cLcydIBHTucExzPKfPStrD
 jYIzwDRLbeISvM2TH25p0zIYS52HrO8BkRczeRjzvWwFaPx+5nqWXtkMLsnyzSOTo5by
 5Q0lM/+R59t/khxgNvSnIuGy3thOnVe8e3g8EC5l7O9ex7hecjMB9AEeUV282OepMGd7
 xgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735554663; x=1736159463;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHtk41PGmmkmjRHwkyCjhxhd66vRvgl1XZKtZTeeTbQ=;
 b=u9EJgVGRb7AUiM9C5aFxxCUM5ACv5w8PLgO3no3hZg51/8v+LkiVL4GxLfDrngkTVi
 gvQgyCNntLoJoMxZnw8OobeaZTo9Udks6Woz5sKblDIi0fsVbv+PoKH1WSHqdhcVcns0
 jRkoMbf0vUg+LxmxNwTGkQTsLm7AtlLO/8kibjCeENdiXN3Ny8W0ld9RTJFlQNtEXC7A
 BsO0gZ4fM/SiMYMt3+17ipMlmDijCLTmp4RjZTGupoI+gQCURr0fFFajhIKorhBYT3RH
 YwSUv+rRt8ZHDWgnTsdu2OJsw3Mo60Y5aAklM2OYFB7/DrZxOmLldURt+8lyMnpkczMs
 SmKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpvq/thz6HzerG0mIGTZH0Vy2y3nfVQgnYFg3oUHsdqo4vFlU7FPVm3+DyuD8xUTql0uAkDAs=@lists.denx.de
X-Gm-Message-State: AOJu0Yzl9DKY5Q8JySJgeOmsftigh/ouCQPHaIx4f2DP41m2wDqiOjXL
 L3624Wyexc/c34O06E27aHJpRNrqnvcnpFQ/zgITRhwlBbrLXMZZr1E3sUUGDiM=
X-Gm-Gg: ASbGncsO90gMKXiif6My0nIZ1f4Psb3xDqukta7Z5pEXibdt7Cifrs1b5grUQSH26YS
 j3xzUfWuKHIU1+mEv/Y6gZXC/wap2SK1Z2ooMKJNHIqRyVNa2LDLklN16D7HCOrUIziNtMiLH+S
 s3E/NwNNi4eC//1OBj1U9mEYhOnrcGKhcqVfH4apXuVQXk+EOB16PpOVedCgdIqC2/8EyQE9/X+
 bqVarTmoZC0i0NbNI6SBeYSeQTPrNmF0cChYBpx0sMuCumFlcJjtssec1ZslbOudYSYD2FAPKRy
 Gg==
X-Google-Smtp-Source: AGHT+IHoHNs2dmAtcZbSdRgMO97A/2NAwImuvAJId/CLyK7oUVDty3KGNI6+njVmkDJOADxOkT9MNg==
X-Received: by 2002:a05:6000:470a:b0:385:f092:df2 with SMTP id
 ffacd0b85a97d-38a221faae4mr25452287f8f.34.1735554663114; 
 Mon, 30 Dec 2024 02:31:03 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1c0sm30201550f8f.77.2024.12.30.02.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 02:31:02 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Dec 2024 11:30:55 +0100
Subject: [PATCH v2 1/6] ufs: core: include missing include/ufs.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-topic-ufs-cleanup-v2-1-4c6d7994a45d@linaro.org>
References: <20241230-topic-ufs-cleanup-v2-0-4c6d7994a45d@linaro.org>
In-Reply-To: <20241230-topic-ufs-cleanup-v2-0-4c6d7994a45d@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, Love Kumar <love.kumar@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=680;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=RHVI7HSvOhLHRjblsuJdLs1Erdv8Ou1xxclndVeJ0Hw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBncnZiUry+hUqKSZb8liEDnOe3MUpB3i74UqYeBTCL
 PLOYHjeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ3J2YgAKCRB33NvayMhJ0RLrD/
 921xRnkUnVYmRM/cqpgYkPucVap96EyV2wiliIiMSrzR+ecwA+BPIeBVOA/A54yAL2778OWwUqg8Ep
 m8b+9iVhZv6eQY/r3r7o3WNSvec3xW1A6je8GagrE6pvpsvjEkxXUsoEmHQUbVVdVii63JYAUC/Ycz
 rPZf/exdOqcuCvvYOv7IXDoXUio2zQQTr2md2HBUQeknzkXQM4PCg6U0Bkg0QS3BKsTJQoROY7jxEy
 bieO5UQa/4zlmbRkr3lUjKsWJthKbQfVxsUIVFi09aMIRG6wd/eEVIqSEvAbAkBZZLy9HYMWEVkasc
 sfW7H/RgVu4I6IZO1JVSs9BfMLWCdcFHvoeIo3TKWPcnfewRNEKw3XGaoKJP+QyIko8fdG3RzUh2XG
 tminNa6z+ZgCcqlYnOZ7Na9Ra/KLqEQ7CmEjQanswPhnDc7mumBf/QUNfRJ/lOHFaLvCj/mhAS0rQg
 F8YIJyaOsNt8sEGMi5uDzdU/Ze8rdWV9pHQeDiR/jrLCc2CgeHPvSkISSo0N6THQIYLKV5vZRL8UWQ
 FDo33h7ZRD1SOjZp1a45J0iT8HlMdIAUU79WXsgFr36/pml8kjCvcPAyJiDP5YjAxI2nfOEfHK4mT1
 L7e9v3gZ9etpAiUUNF8gzwrGv+knYSbZZi6Yx38nZSK/W2kRdOGTAFRCwGww==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add missing ufs.h causing build warning on some symbols.

Tested-by: Love Kumar <love.kumar@amd.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index f7d8c40c448c6865b7c04e03bab6f3f93a44a591..31c2959aeb12931b2bbdf26b3c676ae1a7b0fd1a 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -19,6 +19,7 @@
 #include <malloc.h>
 #include <hexdump.h>
 #include <scsi.h>
+#include <ufs.h>
 #include <asm/io.h>
 #include <asm/dma-mapping.h>
 #include <linux/bitops.h>

-- 
2.34.1

