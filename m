Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBE21048924
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 00:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54F0B83A1B;
	Sat, 28 Feb 2026 01:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O7BPl+z6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7908B83E76; Fri, 27 Feb 2026 20:34:29 +0100 (CET)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6500183CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 20:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8ca01dc7d40so260850085a.1
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 11:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772220866; x=1772825666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+5HdGVYRoq9JbXg2RwhVkrfYir76woM6MKYzMSMnrtE=;
 b=O7BPl+z6UM9udGk3jcUJRCEDgulGpwRDuQIwg7lFt0+X1uZvsLb1MdxUjMysMcujB5
 ywgv9PzHRP79htiIIPo/007btu0DvuOT4VAPhYKLv6D4X8eJhIj8Wq7xq9LuAYpMK39A
 FpyKU77n9tm7JclTfj1beomHiNHx7/x4LK203y0+axuze6OxLeUxzjUbxCfSYZV1UAuj
 oVx7DwUtg3ImbYkDmaZs1VmiiavSVf1EmL5iTKYtwuUFgB/c3LLE8eiz/qUEJAZuQhk9
 XXchYIdIJraoTBKSR4ji4VOXFtHCtzaN97BMlZ7xW3B0Y4UHLLArl2AWS6IdA8fkP7S1
 E1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772220866; x=1772825666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5HdGVYRoq9JbXg2RwhVkrfYir76woM6MKYzMSMnrtE=;
 b=hsR8gHtMBEZ83KqQeSk8uDcQLnr89WXZCJGn0sXpDS78VJShupJVPuMUeRorBBMewh
 lcM7Dtxh23pmrsKslr3sZGK9w7RuH83DfG0grGFsEBdk0NpAefQpjMcsC2qP3MEM78F2
 4f2J7l6nnk/u62/n2uHeKPmVn6/z7U33ez8tV1fTHp/Y/t4Y8Rz9xY4S81x4YmREd954
 n+rNdMc1XcHz9utQOhNw7Y5r95TclSeYHPvhRrsmZpy3IO1miNeEycMa5apJMX9BIKa3
 xRxj7QI2ysYXXPton/DFZ0pppCZ9YfooZ7UU+ZJkjXWMiwiSEEz8XL7iTM74QpamzgL3
 LZKw==
X-Gm-Message-State: AOJu0Yx3KU0ke7UG+3NagRv9rPPH7zaSe+KigCyoGIjT7kQMRfZLc0zt
 1uf4KMfLfp2TfGCqchXvtwfsWoikWW3i7NyNndP+xWWwmGoUxcHaz87qG95LJlmgSmTHTg==
X-Gm-Gg: ATEYQzyzVXMbMR9lzGeqILbH9GibTZunzfpmmHQq+uYMzfKGsMzsf54/GYIckCA4Y5S
 moqDsMPIRjk6pLIWdkhaAOGFRo5Dc14DQVJmIFn47A8466I17IItbJ0Vg4/b3NA9pzbEBq+QF03
 fyOh2zapZGZbNlw7iIAp0ZMc3hTs1Q+wdWlddi8T+BOXBQMCdRitxvnXN4iwP/Y6RlrJXZQHdUf
 GLejUConkVaqJpjgbgUlIAs4JiImEMHNRhDjdSZ/B47VcxWUcnnOMCvJhZa1Rndn/P1xONHt8FI
 io8bs8blrvgrJqZ8eaCC6iQAapwY943rzkzK6HOgyfWTvDPlMaA1CutJabfqt6LardzA7UIHV4M
 eCvtWRiFhJa35rDiUZ+cBC1cZanyGEy7j1KXzqYS3MASP0q+6x81zXdVY4Mk6KqN9ihjHmlC2vE
 V8kTp9rIDpDWcWjZCY1a+6FQO1yYDCe2SD3mmFSXY=
X-Received: by 2002:a05:620a:f0f:b0:8a2:234a:17be with SMTP id
 af79cd13be357-8cbc8e56ccbmr476763485a.7.1772220866030; 
 Fri, 27 Feb 2026 11:34:26 -0800 (PST)
Received: from NotHereOffice.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf64efafsm545027385a.6.2026.02.27.11.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 11:34:25 -0800 (PST)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, linux@analog.com, malysagreg@gmail.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v3] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
Date: Fri, 27 Feb 2026 14:34:23 -0500
Message-Id: <20260227193423.5712-1-jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Feb 2026 01:12:08 +0100
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Updates the polarities for the GPIOs on the sc594
EZKIT carrier board for the newest revision, Rev D.
The new carrier board revision has different polarities
for some GPIOs. This patch updates the sc594 entries
to match the sc598 entries that were updated in a previous
commit, as both SOMs can utilize the EZKIT.

Note that these updates are for the EZKIT carrier
board used by both sc598 and sc594 SOMs, not the SOMs themselves.

Fixes: be79378 ("board: adi: Add support for SC594")
Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
Changes in v3:
- Resubmission to fix whitespace issues
---
 arch/arm/dts/sc594-som-ezkit.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ezkit.dts
index eeca6d17504..11154e65ed6 100644
--- a/arch/arm/dts/sc594-som-ezkit.dts
+++ b/arch/arm/dts/sc594-som-ezkit.dts
@@ -22,7 +22,7 @@
 
 		eeprom {
 			gpio-hog;
-			gpios = <0 GPIO_ACTIVE_HIGH>;
+			gpios = <0 GPIO_ACTIVE_LOW>;
 			output-low;
 			line-name = "eeprom-en";
 			bootph-pre-ram;
@@ -30,7 +30,7 @@
 
 		pushbutton {
 			gpio-hog;
-			gpios = <1 GPIO_ACTIVE_HIGH>;
+			gpios = <1 GPIO_ACTIVE_LOW>;
 			output-low;
 			line-name = "pushbutton-en";
 			bootph-pre-ram;
@@ -70,7 +70,7 @@
 
 		octal {
 			gpio-hog;
-			gpios = <8 GPIO_ACTIVE_HIGH>;
+			gpios = <8 GPIO_ACTIVE_LOW>;
 			output-low;
 			line-name = "octal-spi-cs-en";
 			bootph-pre-ram;
-- 
2.34.1

