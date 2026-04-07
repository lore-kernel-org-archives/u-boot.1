Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4FCEDB7D0
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 21:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 257138405F;
	Tue,  7 Apr 2026 23:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="mKiafGeL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CFC0840AB; Tue,  7 Apr 2026 23:45:29 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBAFD8404A
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 23:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbba5076c8so2073674a34.0
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775598325; x=1776203125;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YZBa6SRhNQY19aACYkfgVzz8qlyL39JKWIxvXmbnIr4=;
 b=mKiafGeL4/L1KbqjkxXcGXtOZLJdgFg0djcQzkpRChUbDdGfMY6balffN4+R0kKjA1
 JGlDt9u1yIGTSWZjml132Y2gOfHMd5bms6PV99qmRdUDdN+tIe50UCmUlHgkymuJvsn/
 KoRa5D4d7EPh8ZtSKwPhC0FyUqr09E3ZaC9pdq7O1P+1mfLMiFjiPCX49ORnm7Ah636C
 m3W6H9Wai92eD4xs/bytp1/4b0zbFBnMMMXgVuAYOsqo8PzTQiKJXP53QBChv1+24LZY
 9KqEcIIEzY2ChFfS01YsbJtBYMJi7sQiRjhVdoTqNLfpvrPHG1Og5oHG78L9w1ArQESy
 Cp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775598325; x=1776203125;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZBa6SRhNQY19aACYkfgVzz8qlyL39JKWIxvXmbnIr4=;
 b=Yucw61Y4r4ewEtT3yxANkWjUkfd3MCsPbG3pYvHAP4r2xoeR2r3HGnx/SG10tvnDUb
 d0T+0SWdzBXFDtd642n9m/GQWY7CwiuK+GTWpAxMfymQN4Ues1GnDnnRdjxjjAMVajui
 BvjBU8bRDOw0/1IXVBl0m8+zn+U3ovHsC/ifDO2jxI2ib96bv2obe2SAaxgJ1IeO/L+j
 ChAzcnUYDMAgV1Vgv+FgjOiFMN3pqZs6PYAxy0wBkciRGnEhofuK6hUjJ65DddhlP16L
 rHoIcGQqf3HuA8PqKQvaqcZ5eKP48UDcsHUxKAWw7G0r72HhD2be+HIo2XSTEW2APqnQ
 FG0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW66bE2pTCHtdmfuBuSXo3CR1qfikfxNRluAsG9O/36yqnpf/cOmp1DvZcz0KLrk8T9K37xA+w=@lists.denx.de
X-Gm-Message-State: AOJu0YzkanUz8QAZT2D/p2TawqJgWs8LXRZEifmoos0MrYlsb/HwQHEM
 52jj3h2mzl3+9gENHW3x04B8wL2jFLbu0YBTeXoYPRWT7Z83s7jSuy9NcVTcR82JQJU=
X-Gm-Gg: AeBDievHmZbyEqOwiUDnPrjj31hW59uNk0tV3EXvcbayujv1bHRQAOqS9k4ieA3n6xi
 Lm/5U3WyNEALyueM3B4//4VqW1H0V+0xaUVWBi7OCQ2pKcrmlmxxnXPYtxkl/czdBecT5g0zWCV
 ttTiRZBmO/OOxY9iNaWhdojbdiv6/mB56AbuR4VGj+i7M0btuEzPgk3j9pU6c9uQ7TqDCm8htI2
 ysU2G1P5EfYzN0QhL7jqF0m+HR9m218+VvyajipkV17Erx/tRXiK1bKA2ccLlY+z1dejYNUzQpe
 C+7mP/D/oQF8TyXh1TY9jVgcBQbdbtSgVAbIluZuad/3BCGR7MLKxuNtlVV5uRMwheoaebzSrOK
 BA0j8wgJIm/Mk/CQaS3efG0qZhANhJz1VvuDH+3QbKydWQCbH5Y6Q1ejKZBrlwqpB2Q5O+t7e6y
 Bt2ca72zkHUnCM+YrG/OFGaVn9Mga7
X-Received: by 2002:a05:6830:6086:b0:7d7:d2f5:1d61 with SMTP id
 46e09a7af769-7dbb73279a0mr11967266a34.4.1775598325591; 
 Tue, 07 Apr 2026 14:45:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f738:1ffd:6365:30a7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbf928f085sm2245031a34.1.2026.04.07.14.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 14:45:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Apr 2026 16:45:00 -0500
Subject: [PATCH] doc: CONTRIBUTE: fix top heading level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-contribute-fix-heading-level-v1-1-9b075f01e7b5@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrDsQjajtVUoXSfyrUySWJEpBv
 LvRLj94vI0igiDSo9goYJUos88obwW50fgBLH02VapqVK1adrNPQeySwG/58QjTix94woqJG3v
 vjHal1lZRXnwDcnTtn6+/42I/cOl80r4fppPV2IAAAAA=
X-Change-ID: 20260407-contribute-fix-heading-level-6b98a3c133b0
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=NJGGr2ujArKF/WEpUTIifgM7OUYUgmgxvVFZv9sOdTI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1XrtKYxTM+hnosFl8KYceDvW3KK/ncDrG6TDP
 zXYVVYnb5uJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadV67RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ah9wIAIbFvJ0qUoswiam5eEfO3k0O12G78xordN3xIms
 LeQF5AroLF9su3Ht1IBEskyjd9duqN69mepcLqBe7+L51rHy967nyLDmHCt1oTMzZuR4rzMkUxE
 G4yjIKlZ+tSQZ+dPfpJA6KfSx6ZxQ9gw75+7jEiyEA5OGtc/6Z6WYlK0XqWBJ9LKE7dUGqeDIT0
 xm2bzK+kq/aUuRLhoh6tBFB+yDgjGsMB7/MWLOEZgWeT/jYwX+2KpRYnHzPMbRaT6/MWOdYB1KH
 Fl6fWRPCTKb5xVleSkwINmmyDcShYLtyBqjj5gTSmE35XT7425MVrt6WQrvt3x9DaeO9Z5mrhOP
 HWmk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Change the top heading level in CONTRIBUTE.rst to a higher level. In
reStructuredText, each page should have a single top-level heading.
Otherwise, each section of the page is treated as a separate page in
any table of contents.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/CONTRIBUTE.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index 8ccb3a193da..3f8d422e967 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -2,7 +2,7 @@
 .. sectionauthor:: Peter Robinson <pbrobinson@gmail.com>
 
 Overview
---------
+========
 
 This document is a high level contributors overview setting overall expectations,
 so people can get started quickly, the rest of the documentation goes into the

---
base-commit: c3062edfed295c010f81dd31b9e9cdfaaeaa71a4
change-id: 20260407-contribute-fix-heading-level-6b98a3c133b0

Best regards,
--  
David Lechner <dlechner@baylibre.com>

