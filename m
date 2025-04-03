Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815E7C3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 05:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DD8A81CF0;
	Thu,  3 Apr 2025 07:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sNS62sm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 859A181DE3; Thu,  3 Apr 2025 07:35:06 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B318043C
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 07:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5c9662131so851695a12.3
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 22:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743658499; x=1744263299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vaGl9UWGwEkTAt2RUTWoR5c3AxmLEot6O0L3Ut4RO7A=;
 b=sNS62sm0tupA9c/WTHIIbBgZRGNYI0eYoiwPemo0Q6LbR/Bz9Qo543j+FUfkpWmxl6
 c0zU9w9nW6bGMJtzAzlc8ltXSFmvxpT00iVlfiGqLl5G46vUsfrszJQ0VDePUm552x3N
 c53qtrwE4wvojxIssHdjRmVxGL+FikL+ZdP4ILAwuDYnxSnwdXcPiwVU60YPwVvnskXY
 GYRZlsVJLsolWgCRjY3T5Ll417x7k+0d4rbVm0EucKPg+QsqadrOEXpqjCxA66BA/Dd4
 QAlYOSqw11LD1g6NTOS28E+PgBAeu/TLf0b6qe+hROkxEjfhnLhNOKcBsNNZv9M7oSbK
 kNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743658499; x=1744263299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vaGl9UWGwEkTAt2RUTWoR5c3AxmLEot6O0L3Ut4RO7A=;
 b=g+b9wOH+h0tJtX9FNbGf8kS2s2SgBNs/AAK3mk/zX83qUqIW0/BSgIdIYZrwcDkkbp
 iaROyE8lKv01FvqCvgJg/2uDTrtGN+7nhVJGs9v/nt2GQzI2NlrzfQRt5uYv0mx3tSJi
 H4IVl+HnBMz7TJf2mONEAAvHPtTFfOUpt8+BoB4d6IC7AoWNro0hhHf4jEAkTM1niy7v
 Y1bmxM9r2xVTxsdq5AUvE90FRj4IzEqAdAuK4ZVpcf6AmoVdrNWgvfMenXpEIUK846mA
 ZkRlt0H8e2C2moE+m/eaHdgocnGUUBBu7ropCC0z3C5gGo/01Ari/Y+b8+Bpo8Xr4BNu
 LwGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF+gIJFesgiMOB+jMNojGCBB9qx17XSzq1EacWCoVFsjISb+hOZJsCULmtKI5IHsJ5lkyIid8=@lists.denx.de
X-Gm-Message-State: AOJu0YwCLXBnozPKKVnY8HipEonYQ+qsCK0cOkT69wf36jwY3syE4ZdD
 Qi9n/zD3VuYLGb0OsRsYxlvwbLOFDJh3J5uMAa3AuIz8ORpE0pURUfyTzoxLveU=
X-Gm-Gg: ASbGncvwJU7YWiHN3C+TIqf+i++J9BqOf0iW7qndXdzwfN5W83HVmefF/b0xj3DU7Uc
 HixkUgv/F3ywDlmxeFdK0qeka0hnLEa0vsIKsBPrzCZTisjXNhd9ZSa1XVP/5+pf/lj7yYfPNAK
 WS+WV231BqkiMAk9p3EUvMiXof6LkjYi8qCAaN3wnyG8KwzNXK1wUjkXDq+i/dw4dJj1q7LuI01
 MkXd/yTKbdds9QIb62LyW/05jXQtKq7hmnvJkgOCKdqmE5kIjwce15YosZRgTxAOZsOQUtTgUUP
 EYDbm2uAc8mr4xPZ0NdC3JKSES92gUTBAUgVJxg7Lc6BMK5DZc5kN1UNDDysdtxVMoGTejo0y8b
 I4I0Xt06IjlD68tD96INB
X-Google-Smtp-Source: AGHT+IGj2Vjvew5Rd+NpeouUud5zaUvTKnnDFjXFX2wIsVIdW4NbqTAiZBwHbMYUWQVx5Ldji7YDPQ==
X-Received: by 2002:a17:906:6a14:b0:ac2:d5c6:43ad with SMTP id
 a640c23a62f3a-ac738a997eamr1756042466b.30.1743658499061; 
 Wed, 02 Apr 2025 22:34:59 -0700 (PDT)
Received: from localhost.localdomain (ppp089210073071.access.hol.gr.
 [89.210.73.71]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfee6c0bsm35238066b.81.2025.04.02.22.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 22:34:58 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, bjorn@kernel.org,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH] acpi: Fix table length for QEMU
Date: Thu,  3 Apr 2025 08:34:44 +0300
Message-ID: <20250403053444.2551339-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

The end of the ACPI table is set to 'addr' instead of 'end'. The ACPI
code for QEMU relies on those values to mark memory as 'ACPI Reclaim'
and as a result the ACPI RSDP ends up in Boot services Data.

Reported-by: bjorn@kernel.org
Fixes: commit 638cc363484b ("acpi: enable writing ACPI tables on QEMU")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/misc/qfw_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
index 0d0cf7646890..77cebae5e3fd 100644
--- a/drivers/misc/qfw_acpi.c
+++ b/drivers/misc/qfw_acpi.c
@@ -305,7 +305,7 @@ static int evt_write_acpi_tables(void)
 	/* Generate ACPI tables */
 	end = write_acpi_tables(addr);
 	gd->arch.table_start = addr;
-	gd->arch.table_end = addr;
+	gd->arch.table_end = end;

 	return 0;
 }
--
2.49.0

