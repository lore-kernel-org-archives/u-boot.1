Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA963CF34C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E23D283F20;
	Wed, 19 Nov 2025 15:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KeiN/F3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D1983FA5; Wed, 19 Nov 2025 15:55:25 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E918004F
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c7613db390so1618850a34.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564122; x=1764168922; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vfti+/JI40EwwUytR2vI5g9iY03oIN7vryvGQqHpVlU=;
 b=KeiN/F3hGPBXitvq6WwymXLNCxSmxUoj8ctyxE74kkce2vpyT/MN63gC55Fq3ecrGq
 TlaBmb9+d/K67aUvHE4AWtOI7pmKuPzOuPLp+y6Uk2RGtRqlH9Wc16bslzsakxTMP+cv
 W96Qb1IiqySn4ivqby8yzhQ30W75UDph5JQDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564122; x=1764168922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vfti+/JI40EwwUytR2vI5g9iY03oIN7vryvGQqHpVlU=;
 b=omL3B40cqYYMOtCMiC0Z+JJp/I68CC/ZGl1U9GJoFrPzlfVRyGHJkWhFkwPXlSb3na
 aeycT1EO/UNsOXzE3pR+BpyShbcFOxTB+ZOe4uezUOf2EgqWW+PCzmsoVU+lvka3aMmp
 OtQ8InjkSy5WShwleUQ2o8uBEL1yBulcrpegutEO2NfXSF+byylRvINyy6sQ7GXDWjED
 e+V3MT3Hp79y0gyxjCQH/F9q0srhEq8/nQLedLTiRPLbC6E3wCBj0+q1JnSjUoyhsTRP
 +TZdDbxl+MN1H3e9bglO/GrqdwqEVRHXmptsbL79kzmp5PoUF1vYIK0yA6oYaa/v4r2Q
 acXQ==
X-Gm-Message-State: AOJu0YyUaHInr6d7p+LCE2bDbEsrQSwN9IxKs0aXB6pd0GmVe1ouf8xB
 Ng9FlJBquEAK2OqFHKS5CzQFc3YvjjnwJIzLdzQFyTz2NXjHVQOwGQwIRHHQOLxL5a/OWuwd3Hp
 ulJ+jfGlqfQ==
X-Gm-Gg: ASbGncvrHtYi29BNXSfarrNRxcBSQELm0u4yhX5yysJMElitbOyWx9a9cscH0n9yTlF
 YTTbKxPyVyr6GszeBo6BlEWCqFJa+SWzwTMM6IibC0Grsqmxl0yIM9Fx0Ju7wvIehjFyjF4Xvv3
 HWG9oE/5QYnF0IIwbP7g/WaEqlk4ohAF3Pp+CIj64BW1o+2tw5fCzNvub6KY89f66VqauSnZ6WP
 Z8j6+4M6pyPC3Hp6j0A5IfLmQ+Oazv73ZCO/4rQPk60kWzwGtyhfFokgy5t8rgihNaAkQDKybcx
 EM5cyUcKPc67Gb/y5GLLNPhvHFStuVmrktbPGJ0LJzpTx5ztXkpuk5tlhj1VZAJqd0mZmT8zjjG
 xOxrsNvvwOL50/F3Qc9KsHRV6kksbVpKEentjxoL34dZrADJddLScNAdhXEfpFZzqIrF3hEnane
 WJQegWTuQD7IoY/8UGHYVj+lrhOv0nBTBOg/DtvbW9MAWXutqUr+6u
X-Google-Smtp-Source: AGHT+IGPRMXG0l7bcBG6xSuR+oxEvs75sApaAAhPBwQEZCHowfQZfEAI67rLH6KODewSxq1dv06/YQ==
X-Received: by 2002:a05:6830:30b0:b0:7c7:6219:6852 with SMTP id
 46e09a7af769-7c762196a0amr4391364a34.28.1763564122133; 
 Wed, 19 Nov 2025 06:55:22 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a283b3asm7843330a34.4.2025.11.19.06.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@nabladev.com>
Subject: [PATCH] am335x_shc: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:20 -0600
Message-ID: <20251119145520.843195-1-trini@konsulko.com>
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Heiko Schocher <hs@nabladev.com>
---
 include/configs/am335x_shc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/am335x_shc.h b/include/configs/am335x_shc.h
index 55d5190b221c..afbad9c2c4de 100644
--- a/include/configs/am335x_shc.h
+++ b/include/configs/am335x_shc.h
@@ -25,7 +25,6 @@
 	"loadaddr=0x80200000\0" \
 	"kloadaddr=0x84000000\0" \
 	"fdtaddr=0x85000000\0" \
-	"fdt_high=0xffffffff\0" \
 	"rdaddr=0x81000000\0" \
 	"bootfile=uImage\0" \
 	"fdtfile=am335x-shc.dtb\0" \
-- 
2.43.0

