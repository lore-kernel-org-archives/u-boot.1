Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1712CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0784383881;
	Fri, 26 Sep 2025 17:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qIWCgC3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACD9E8387E; Fri, 26 Sep 2025 17:31:53 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ED3E83873
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-4248a13fbe9so12274815ab.1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900710; x=1759505510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=w47Na3oLGIqR5z3SdBD6uLDClV92NEEtOsnLTWtDJ6g=;
 b=qIWCgC3osdoAPAfydYRLEoKBKNGPUZahhbSChS3GsEe2c7ENTJL1bW9s9HKOE1bgBF
 bZ0GRi/cnHDtyKd7lP5ZD5+F5ZCw621NDYSruxl/n9ohVlaa+tocgoBpf0+VSuon9v2H
 s5x0/GPjSgQZt7Azae8p4fDH04ofAMTe/8NG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900710; x=1759505510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w47Na3oLGIqR5z3SdBD6uLDClV92NEEtOsnLTWtDJ6g=;
 b=DV9nnnn2bUzS2MrMxj2mAaEP7c2M1Nl72bNeKGGcK0sR1bEzdaxdlCbS1OM9V1SmDR
 9Fk/FYpM+8BZ0TDq31C1KcUbh/up8vgf2uWVAo7ekB7SwOXyk1T+a+mMXDWulCWdWMaV
 5sdYmxD0FJBJR+jJQ8YmymN+meKRIa9adVwf+XDyBDmniN4vHIKMVpJDIlSobO7MSMQD
 IRvdu5ujcUsSOhy3ODxUB1V3kFrCUig9P4qKVE5sphDycgZbd+eVbMdk7y+84PwC+tHM
 /z/HRnf60H6p2yT0RiErbBAe62wkciE9fH6k+l/Kc50m6hOmSIMnDJAyzG7wQpLa0LW8
 TI3Q==
X-Gm-Message-State: AOJu0YwFUSd/zoA34bKsfH7dLAqRbmb1t4QakxpTpw8SJdD+jIULWuaQ
 USXFLn7/8+h9UDr+xYCOsT3vHNKfVriMOmqD3rPQA4PAdunKQuZuHp2zXbk7GaVca4zIcHIKsDy
 o4qQO3hY=
X-Gm-Gg: ASbGncshjySi5hSFc/RY3MaisF3I7rTPu2VCkKtRAlSr8pfNMQoA59ltblm75dCt3Jk
 tc+MeA0JrwHMNoJ0i4fxDQvtTJzZjvLBYWk6D/cI5A07xhOciW8RGtz1Wj3gT11egyexT2eCrSa
 Mq4Mwfll5ANgCQPPSwo5OK4Sjl1R9m2G7bS6VtXwp8viKkfiM2F9tinOT5FHL2W8Ux72WqeIG9x
 yj0jAqbDyJUhFoYuOOLzG+ezVGuk8eqkL5z1q3wfbb/T+O0EDUrpmnWLv5Zi/Kzc0GLlX/R6+mV
 o06bC8RmTPX3CAIRdtZ4zvhAsJSVkVDgvYh/ShW4bHUFGGd2xeeKjPTz+FWKOes2ooyy/4IULSg
 TmgqRxJVo3YTYxzGE4VVdPlGaP/7uG8pRq4P2NprnY1Lg1YPymh8xinfcA20=
X-Google-Smtp-Source: AGHT+IEgUC2r9SkTozPU9Je7rnCWGk/XgNsxH6rd6VPw3aC5kWi10f+Iq3Z3+TQJn2EQIfFJJsDBNQ==
X-Received: by 2002:a05:6e02:1708:b0:427:d012:c02 with SMTP id
 e9e14a558f8ab-427d0120e4emr22833045ab.23.1758900710240; 
 Fri, 26 Sep 2025 08:31:50 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a647db8b8sm1932590173.12.2025.09.26.08.31.49
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:31:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] w1-eeprom: Make use of static keyword in drivers
Date: Fri, 26 Sep 2025 09:31:48 -0600
Message-ID: <20250926153148.3680967-1-trini@konsulko.com>
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

Both the ds24xxx and ds2502 have a family_supported array which is local
to the driver but was not marked as static. Mark this as static as both
best practice and to allow both to be built in "allyesconfig" for
example.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/w1-eeprom/ds24xxx.c | 2 +-
 drivers/w1-eeprom/ds2502.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1-eeprom/ds24xxx.c b/drivers/w1-eeprom/ds24xxx.c
index 413d8bc58814..801fade6f495 100644
--- a/drivers/w1-eeprom/ds24xxx.c
+++ b/drivers/w1-eeprom/ds24xxx.c
@@ -53,7 +53,7 @@ U_BOOT_DRIVER(ds24xxx) = {
 	.probe		= ds24xxx_probe,
 };
 
-u8 family_supported[] = {
+static u8 family_supported[] = {
 	W1_FAMILY_DS24B33,
 	W1_FAMILY_DS2431,
 };
diff --git a/drivers/w1-eeprom/ds2502.c b/drivers/w1-eeprom/ds2502.c
index db9f41e97269..981b41a34b2b 100644
--- a/drivers/w1-eeprom/ds2502.c
+++ b/drivers/w1-eeprom/ds2502.c
@@ -243,7 +243,7 @@ U_BOOT_DRIVER(ds2502) = {
 	.probe		= ds2502_probe,
 };
 
-u8 family_supported[] = {
+static u8 family_supported[] = {
 	W1_FAMILY_DS2502,
 };
 
-- 
2.43.0

