Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DECC7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0293483010;
	Wed,  2 Jul 2025 03:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F4DdZrAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3905082CFA; Wed,  2 Jul 2025 03:06:14 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D7D0830F6
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2ea83f382c3so4237275fac.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418371; x=1752023171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FKtfqF2m/POezD62e8y1ZvYgZ1HrcWf+EWPHErP9Ko8=;
 b=F4DdZrASqLb/N5O+dwbs8If86W2fio82H02CEN8DIRxRfROu4AJKJfrqEzlzAtge7C
 s/B7qYTOiTfkUm2n1jjwkQ4JDizoJM9LnwlXdD2B6zobvORpmlZRcJiYn7gFd6217Hhg
 AXYG0fiQyFQlkFB60O86SNMSGSa/QXt5eOJWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418371; x=1752023171;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FKtfqF2m/POezD62e8y1ZvYgZ1HrcWf+EWPHErP9Ko8=;
 b=WMeHV/GSlBsEkkaksKkAXNrg7dsX71DWef78t4nGb3EDeYLtj4aaH1vyL/NX/l3xeI
 CfixViRfK5EWYuwcl4tM0eXflXPzGioV0Ub9ttLYBTXey3NhAweP1/sRTevF12rZfumz
 SBfaoUV4rbUS9W5C08gSO2PbMlUoL46pu4rrpTQrwKC8U7zVmmRzfjDOSkkhVhg96Q+v
 HD22I+fC8qjoupCcnivMxa2Tp2rwKZF7m4yoLFo+HaLGbvS+fnx12TUatikem/hc36SF
 sv85stN/YhAIz5YM007MEfYuUmid3sStyGZ3NVcqGIapILYimrUKTZUrfSob0qWMeVwh
 Do3A==
X-Gm-Message-State: AOJu0Yyimj8OVXN2pv/SWDaOB1kr48T1RBA4O9q7/YrHYYgLNyd1hlTQ
 sc1ZQ1z3mVdJJu+9Yh3i4NGq27g1riWq5OlV4XG34NjGXuywdEFvvb+yp/M4wBUiiAhkyk3IW8F
 G2mD0Ha4=
X-Gm-Gg: ASbGncsObtJxJYxXZrfwOIknyD9C1Nzx6vnEcrw2F3pZj+GESrf1vn15jit5TIn1RQM
 X4bH8cIRdHxczotWHKmBtMG2IRqbuswcgQ362eIof7wMhBoB/AmrvfHjMg3Bh8yo1AItRRmRFRo
 FEqiAFlZjDOUCtgz3qO2vQ4BmbKOFDVkdbddU5YzeIB6NC0DjOAO8Zsgoip1WlDQbff2ao9x/LP
 zECBkXYzhVVWa7/ESOvJWaU3/9dY2qUMF/OdePDW7zD0fSlPKaii6O5J/2t+I5Vi2xlYzdeeg8B
 Pjk6607LgnntiJ27X4SpIXXu3MswMOfiHsymibP9wln+ZpUcsLvYVMiGU5wTQKZpOY4DA8Mm0NC
 aV5z1ej3bbvFSTPX0vO4d+EI=
X-Google-Smtp-Source: AGHT+IE6FKES4B5bGEToiIkv/HenyqZFyeXhW/B84PZaxB7U69i4AP3myu+9MVhR0uTzTrpv0vhXPw==
X-Received: by 2002:a05:6870:6f09:b0:2cc:3603:f05f with SMTP id
 586e51a60fabf-2f5c7be0b3dmr812655fac.35.1751418370820; 
 Tue, 01 Jul 2025 18:06:10 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd512d709sm3574107fac.43.2025.07.01.18.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:06:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] mtd: Add function prototype for mtd_read_oob_bf(...)
Date: Tue,  1 Jul 2025 19:06:09 -0600
Message-ID: <20250702010609.19381-1-trini@konsulko.com>
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

The function mtd_read_oob_bf is called by cmd/nand.c but does not have a
prototype in any header. Add this to include/linux/mtd/mtd.h as that is
the most logical place currently.

Fixes: 1fac57720719 ("nand: Add a watch command")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michael Trimarchi <michael@amarulasolutions.com>
---
 include/linux/mtd/mtd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 3ffcd40807d0..1f97bc4fe116 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -438,6 +438,7 @@ static inline int mtd_bind(struct udevice *dev, struct mtd_info **mtd)
 #endif
 
 int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops);
+int mtd_read_oob_bf(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops);
 int mtd_write_oob(struct mtd_info *mtd, loff_t to, struct mtd_oob_ops *ops);
 
 int mtd_get_fact_prot_info(struct mtd_info *mtd, size_t len, size_t *retlen,
-- 
2.43.0

