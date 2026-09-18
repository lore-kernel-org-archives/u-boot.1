Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE59C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 03:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C745810D4;
	Fri, 18 Sep 2026 03:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u2kQD2TwWcdS; Fri, 18 Sep 2026 03:16:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 691D081184
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789701381;
	b=gtPDrC6pKw9Dz9NxfnDDNOxBdwqZx4rNWpNza5uixZMQS8gk4DVC89vtQC7TXUVzgFel
	 tMQfNeyRpTFQ2ygzqxnamcUgBnFkf4/LzS+nDI3YcXjF8AXgG5Nnbl8oPFHPjyzVXYN5B
	 TvUaUFFEMjVaqQlxfdQ+H9fdeNmfQI2y2g75He6REajn+H1SJx8/w/1WtcJmEHF5zYP9/
	 tflSrTlCBafmeSzfjFIwx3XS1yAzrByXLhcQYpmcAV8n8+pXXhexjskJaz1jixagunEAe
	 hIWqAY510r0p3jBpB4Uj8dTLOyNKiWZmamxF9Z4YPsB3WQTTsB4ACvSQjqb63DS3zEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789701381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uLMTH+5tXk1fCWMXRa6WLluIPsukU7cmag3ekWtbZyo=;
	b=i9kcYXfu6evHR16kcA6Ben5KKaiBdgKBMjP+Fqz9QQiaGlytDnFokoLhqyXW5m99zfU9
	 QfjXvph8rwAybGiPRkUAeC+JQWy3BMa3ngArJ1kfFJyj2LmN01zS/sr5T2IQHVMn46CC6
	 EFv65VPkOdClwzSKKb9TLbec9wFCZ0P//Eypa+K6sgSbUi9Tg2U2S+8Qn0TECcHe84aoc
	 J0Ld3W02H3vi9pusSeFCFzJU1PDnWgzu19ukmkzCmjMSMu/lVKVUuUkEyVrjHeeDNdR8g
	 kKrixGUpS+GjrAfDiKNnEaEJykJv7e/MyHq0wf+/5fFr70P/vp0M9EofQnqGzRhUt8g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789701381;
	bh=uLMTH+5tXk1fCWMXRa6WLluIPsukU7cmag3ekWtbZyo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ULXOx2KkHlx6QnFgdfm3s3BStcaBEmJEE/9wLqLq/1x81jMOjyuPoS1naqW8C32yK
	 Pvy9yQoV1Y8Winu5VEJAvjXn29nPdGw8Nhg6wi7ljKgUzZ+VhbZH3Kq0elf5qA5uRa
	 WTo5qv9Z8trrc72sFmpRm/JcW6GXi8CED0DepIdI+uqceXwk7n5RUGo1Mcz69JapyM
	 08nkz/NF41tsXVk1w5zPGraVHMoShIQSOfOauy0P9FNos7y7+Iw0AIbkWccplwkIRt
	 Dk94qgkw5pcR1WpBtjrlb7RAYAk6pGUqiiryTlyz3SYQmk110SpmK2I4pCPqtln65B
	 CVpEO2bPZrqAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 691D081184;
	Fri, 18 Sep 2026 03:16:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D7AFE362
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA16040492
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r40VBPF8wkeh for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 03:16:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 198C24008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789701379;
 b=rb8gXOdTA37sCXPXjjvik0pyCylMcjF3jVIkq7JWVIixbUNPKcq28EHaoHEYImXmu6lq
 kppCoK6bbgLB5tRFx0/1+PMG+9AD0zhzx+AQ+GqZdl9gi1BOnmh7M/KkNbFzE0tf/x3og
 tDeVKTGFxUuMtS0Oebz7BtwqwNUJqH8P+nA1R4jGyZpwjqqQ2LRalriSCzQRjZEOjuyu4
 dw1njuEchYVhR53L0xNRxlXbEZ+85Zd+nlRSJEcgECWtx3rVq0vmkcQJ1tmzBPDTLIVQM
 CbDY6Vp/OTBrqrMk/bWEDZ9JHn1cPt6a5viTgo/+/77nuIV17mBmCO4aYWdGtWOBIag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789701379;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=uLMTH+5tXk1fCWMXRa6WLluIPsukU7cmag3ekWtbZyo=;
 b=CP4NMjhR1McTdvKrlOgA/wwx0yemQQ0yaNCq5NutlLUc66HIUQw3yQYIuxS9pGC+IGHV
 KA1aE1UiPQM49JE+GRwOQicxnD9eNLbCo1Qhb67wItN7ofLAz9wNKJtAPoCIWSvU/106/
 noePJFC0yFtNosR8/Cjs1hdTanerhxB4gIiPEtXP5iElP/hS7bvJ4i4vcd5AUrJVjeUGk
 SY9jO1WOR3in9IaewzfNyguL2aj0CEnm7G3lp1KEfZWFs5X/lqe3IRQsEvnwd/+VvfqvM
 ngwPPUqbAlIcbXSOO3pG+PmWy81urMPN/0M+cjCtXrdZYFwQwYL0wjqNVfKUbenOopw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="qld4b/TR"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qld4b/TR
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 198C24008E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:18 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747eb79f6so1645465ad.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 20:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789701378; x=1790306178;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uLMTH+5tXk1fCWMXRa6WLluIPsukU7cmag3ekWtbZyo=;
 b=qld4b/TRsDGV+whq1XqiHzZxJq1AQXZSJSmlbqemTr8pX6myXjbaNrKsPxo/gNCtUm
 HVY9pa0MaFgXpsm7JB3al78qn+guXyU5OBoZl5hnvra1NUL5TYii9Pfw2v2JSYpJLVqF
 zj4jwxRRPGJn4vDFwDn5K1ctQXMMMz5vGSXz3JuFl8+ftcsp4cvr6f9CBLnrcxF9nOWv
 wjPxPil55x25lH1dvJn/xp5guNOqW7SnuG1K8JgczMsDhZpUpntKkzJUb45gwm35hrOO
 71uWXpl+T1ylM19jKfavX2aBS4XiF9C1WMZuuOvYLNhmxMLWbOBSZjXg1Vbf0H1piaPy
 ijZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701378; x=1790306178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uLMTH+5tXk1fCWMXRa6WLluIPsukU7cmag3ekWtbZyo=;
 b=MIZZrHkyjOfIaHZQTM85ou/DLozeQu3QuzEhyArMW9sM1RdQg53P2oANrao+hQQ8FY
 v+I459e4A6gBk63mbha6JCxnF/OdnJuQIsVP+RINpHeRO0NeqPt5c666TfRQ7Pghz6nS
 H/uXbZqDoSb0k5xIfR5dTWJTiDqvbUJWVuB08CHIAH0shMspX+OJicjkg5Zv0lEws6oO
 08w496RblUKLhoJZwOYtBPCgVi/hbXItRLD4Nqxr3UFVYlS7TeJ05zPdsIuK5YvxyDrX
 rvbDdE+Mo7aFjhLez9WWXcJdVbMV0p8aXY6fRUbmWPxzNI6U9W5xU4mtnTTdIiyUMKqa
 I9Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+v7YoDqY0ahSFfZlLKAkQvTn9FLc7pJq0OWhL6T0z5B53GcI+Iy0fJ820oOrle7kCesM+Gjg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mEaGbAwaUtCoDmdWIXCzOZYc1uxD52GKmROezPyD/9Z0MBOmG7
 uP9SLS1+f/YJ+0XJl2//lw1wVRrgiV0sFBPszsz1lW7ivWLE0HS6Y9m+AqNc5Q==
X-Gm-Gg: AYBFou0qPNbuXLI45moYs4t60otlC03CH2e0/+0cf9LbuYtL8SCrPsDco3+3Co93WYf
 +cJtZLW6qih6NcadQiBQNaWskPbaIOobNecsk3/QnzQ9Nihz/ruWX/6Gs0NVy2vagXihQ9N0b3T
 FlOJLgL4jsYH7DQ+eTmQiPHoO/iwc8Af/NOnooMKHrWa6ml9+0c30Y3U+dF6ovghrTrAAoVV7jo
 XFb+XOc9dXnMRxgM1VDy/zmEZUpCZuJDAwa5IeAOsKXgkzT0X7KLEHbsbKyVTwuAsAxqczJMAJk
 P01LcWDG4ctpi3NA+tfVOEMPb4xwq+6AMBppacXFD1iMHa/MogmMj58SSZ+rOhNZ1gQI4L5gR2S
 u98B0ZiwO4ezBfci1caB+B5+/CBlSNvemb27mFDmpGiy86c+fjD6Y73GTGZSGv06o57S9JNpMAY
 NqPC+Ny6HcFEeJOkDkMsI1eVh9kDC4y9oTx5L+iafoGRRasbaexS4cdq8pfHo2NjpEaO5IGnDuC
 vu71qHG
X-Received: by 2002:a17:903:3c05:b0:2dd:143:d5 with SMTP id
 d9443c01a7336-2ddb1b86dc4mr22802035ad.22.1789701377856; 
 Thu, 17 Sep 2026 20:16:17 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:500:6259:4c39:1ad1:29eb:e47f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddb75b53fesm874505ad.59.2026.09.17.20.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:16:17 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 dhphadke@microsoft.com
Cc: u-boot@lists.denx.de,
	u-boot@lists.u-boot-project.org
Subject: [PATCH v1 0/6] arm: npcm8xx: fixes and updates for Arbel NPCM845 EVB
Date: Fri, 18 Sep 2026 11:15:48 +0800
Message-Id: <20260918031554.1855939-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series collects a set of fixes and configuration updates for the
Nuvoton NPCM845 (Arbel) SoC and its evaluation board.

 - Report the correct DRAM size when a 4GB module is used with ECC
   enabled, where part of the memory is consumed by ECC data.

 - Drop the system counter setup from U-Boot. On NPCM845 those
   registers may be marked secure and reject the access; BL31 is
   already responsible for programming them.

 - Select GFX_PLL as the pixel clock source on the EVB, and enable the
   matching command along with a few other commands and drivers in
   arbel_evb_defconfig (watchdog, AES, GFX, GigaDevice SPI NOR and
   SHA512 hardware acceleration).

 - Relax the default network timeouts so that large images can still be
   fetched over a slow link, and add a 'stopwdt' helper to the default
   environment.

 - Adjust the Ethernet PHY reset delay on the EVB.

The series is based on u-boot/master and was build-tested with
arbel_evb_defconfig and boot-tested on an NPCM845 EVB.

Jim Liu (4):
  board: nuvuton: arbel: fix incorrect ram size
  npcm8xx: remove system timer configuration
  configs: arbel_evb: enable additional commands and drivers
  configs: arbel: add network timeout and watchdog stop env settings

Stanley Chu (1):
  board: nuvoton: arbel: Configure GFX interface

Ted Lee (1):
  ARM: dts: NPCM: modify ethernet delay time Modify npcm8xx ethernet
    reset delay time.

 arch/arm/dts/nuvoton-npcm845-evb.dts |  6 ++---
 arch/arm/mach-npcm/npcm8xx/cpu.c     | 40 ----------------------------
 board/nuvoton/arbel_evb/arbel_evb.c  | 23 +++++++++++++++-
 configs/arbel_evb_defconfig          |  7 +++++
 include/configs/arbel.h              |  4 +++
 5 files changed, 36 insertions(+), 44 deletions(-)

-- 
2.34.1

