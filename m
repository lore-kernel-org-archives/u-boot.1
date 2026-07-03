Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B93C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 13:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C4484A95;
	Fri,  3 Jul 2026 15:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NGVaeveK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1225384AA1; Fri,  3 Jul 2026 15:01:55 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD78184A4C
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 15:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c1276b8c7e2so51600866b.3
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783083712; x=1783688512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=apjW+sFBq7VEkt4hx5yVXs7eMAIarQ68eyV8sPEQ7EM=;
 b=NGVaeveKpjAElx+ZpUyxMEzmE3UabFWaJl3xiLbOpp/+ccPKVylV1bqZiR7AR9eEgx
 9fEE8TMUgzSjtDUsQDQF/Vc7sC4Vwbos7wgg4wtAqHI/8aTH2RfoDlU55kl8tXHLoO4A
 2AgEXcc5BmfgGxmGvEvUQApvTKN8cf/4Pvyk+QtyuTFpKMboWhEIgOtL9FXgb29Cbz1N
 aAQt1XtRzRe94k7qFiJft+/ANgabHhFw/6GaDT4YozRrBRwZegbw1soECUrwBYjvsshR
 Oa/EbKbIG0wdC1Ezhqake5l/QzLYDCFnSfKPPClJ6L9Gm9Kvf/PI1G2CD60Q6jP1qAJt
 OYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783083712; x=1783688512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=apjW+sFBq7VEkt4hx5yVXs7eMAIarQ68eyV8sPEQ7EM=;
 b=V5aFJEKvlulir0CdLTfJutcKMwp3JLEaKc2C+/TS4thuShaUEEeuwkLerFitdOc8oS
 75LV+DV8tIxKVFPfT0r5cCLdIKUEAavwHYVvyt54YBJxFBbWzjKMBFLmgEU3+vzxvROa
 N22m9+bLwErmtYolNl27ZF0sJxwdndcr2f0Y/w5pplD+IX5CMsUp/z4BUcAYSgzwI3aN
 YKcIpmKVAiBg345Tcl0klYWm5QlY+fPiuC+v6ozHmap7nO7uMYojbFgUy5cvSLXw8TMO
 GaC0k89cu4/e/6e+Mr7C7OWV9qAO7Chp5tlM8Ny16DcdO9CANPbVax1yxfntRb7ofREP
 s3NA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrq+EQib7SDBCYpskUtNunDh+g2LWXCNtSiiElC/yNQbZ7zaZOVxKsR8EuVGi9aB0eBJi0/64c=@lists.denx.de
X-Gm-Message-State: AOJu0YyECR9FEb18b1x6V4tddYnNsqxKJ8Pi44BpUswvHEvQ43ces9yb
 ZbJIanHVjMdty4O/lcyfNTQEQ5Zmz3MOYthycRHwq3F0cVSK800V2ZjOnGJmzS9P7OA=
X-Gm-Gg: AfdE7ckPUlZz7WZq4AGCwXLAygGwcIL5KVXfrVQB7j9gytQn4LFFWtURPcYOmlTGRBy
 CmNMh5cMVj/S6WCECveU8LjX69GcRKd63Zsg9svU0rhDs0W60vYrnDVAzsv3tHIvGCUGnnWBz+T
 sibOdyYiRhKeZlOpYF4glkCmy7ObkegdLcc87SLBW6puD5Ouyt5CIOumm8hSXwIeWg6iWq3tqPm
 T8wnzAxRjr2jbHu5TMchmg/n96sRN8jZkopm9enxhuxGU6CCKFIx8HBemX4I8Sc2yBMbIribXI0
 Wvlv3Hz4njFepgrDdMOzzKppJET4k+7cgQRr5snjp+c7iaYQkcuZvIt5u+phwvS9rAk1gNvR+fQ
 DjwegOJlMfELH3TmIFKoTepWbh5u6agzZaVdeXSN5h3kDdA3wtZK+3SJNDAHXi6GLxiSiE0cNh4
 Nlm/Xg+Sa5UA6lA7LXcXeskbJwzdq/zBHelot2gwRik0/UW44bo/qHFw1jKaOT6jzk93LTS2NsR
 s5ctZFttyxEdHdlw4gTG52gjI61cL2/3Gh2+21X3w1SNGR0HK9ogp78VweI6ca4wMBfCI4BJqNv
 wsHQo2/CQo0fcLjNONBgk7HsDgsOXqtuBE0aXoZI5FaDuPA9fnNN6AXNrn4uJuZmZ56TV/ET6+O
 BxtUopcU2wMnL2kP3cX4GkLOrfAYe3EcYBp96xsSWLdDDQSgZKSLN9QgD7MMVvZqaumpG1KlfZL
 x9D+T/Cd8AutoCoYL+rL+vaAOgE+p98gnHYzZ4lmTyUA8zXpLHD5JwyUfxoeTo1qzH1iVuOGoAP
 7ulFSTpZeqSL1s=
X-Received: by 2002:a17:906:7fc2:b0:c12:9eb4:48bc with SMTP id
 a640c23a62f3a-c12ae73349cmr311415366b.51.1783083710320; 
 Fri, 03 Jul 2026 06:01:50 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dde19fd3sm18809543f8f.25.2026.07.03.06.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 06:01:48 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Measure secure boot variables in the correct PCR
 if DeployedMode is set
Date: Fri,  3 Jul 2026 16:01:37 +0300
Message-ID: <20260703130137.98205-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
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

PK, KEK, db, dbx etc must always be measured in PCR7.
DeployedMode and AuditMode should be measured in PCR1 if DeployedMode
is set and PCR7  otherwise.

Fix the u16_strcmp to only change the PCR value for those two variables.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_tcg2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 07637df7660b..5f9bbe974555 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -1535,9 +1535,9 @@ static efi_status_t tcg2_measure_secure_boot_variable(struct udevice *dev)
 		if (!data && !secure_variables[i].accept_empty)
 			continue;
 
-		if (u16_strcmp(u"DeployedMode", secure_variables[i].name))
+		if (!u16_strcmp(u"DeployedMode", secure_variables[i].name))
 			secure_variables[i].pcr_index = deployed_audit_pcr_index;
-		if (u16_strcmp(u"AuditMode", secure_variables[i].name))
+		if (!u16_strcmp(u"AuditMode", secure_variables[i].name))
 			secure_variables[i].pcr_index = deployed_audit_pcr_index;
 
 		ret = tcg2_measure_variable(dev, secure_variables[i].pcr_index,
-- 
2.53.0

