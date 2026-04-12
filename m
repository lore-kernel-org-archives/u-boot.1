Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B58E6400A
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 10:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1013083B99;
	Sun, 12 Apr 2026 12:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NtyX6yAN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D0628419C; Sun, 12 Apr 2026 12:00:06 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BBB08341A
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 12:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d70b3e159so163275f8f.0
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775988002; x=1776592802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M4wM0RqwRGd3nPg2HnJ//6ZPlvi37+1MZaEXiNWeEis=;
 b=NtyX6yANEViFJL975umSZcUZMvbEvNFNDYvKCdshflAfN6GSH6g0h95kXobA30EuV/
 RwxnBkLJGmtfovTc93v4d980c+GK4EHaolXOyKBvyJWtZXBUhjjVzRGEUEZwehoc8bu0
 mGw6ukOQIW+GP8E1aO6pti7j6tzqAP2f1eRXjcCZFnt9SXImr8lFjnDQLK7pOFBH2YqZ
 8ojxbmUjf76vlFCfQl1h/1m+MatGYbYeX6UvyWxrS1tAgWYWpBRirM570Zf7D7Wa1z0z
 xItd1+teM2ToranZ9UE7Msql95zmy0p8oxi67hXxS+m2vsbxwUxKbX7T1C5IicS3svO3
 xyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775988002; x=1776592802;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4wM0RqwRGd3nPg2HnJ//6ZPlvi37+1MZaEXiNWeEis=;
 b=lO+2wuRIdigOT8FT2k62YEqfEK0BB67TbR7y98lH82I2FkYT9/g34e5/OmVLowNkBJ
 cLUQSC2LwaKwunJH64tIW7N539QQsRJdUbgpxpbi1HY2cUjcJA7Cb3bhCNlQ9POdGlrm
 V8EXHd0+Ovv39VWpPy9YpC7TMkYKoAmF9mYQdU1bEdHIHjtUAuV+2T+Fhl4iuM5LdA8k
 LIvoLzj6y7yniQyE/1XCAeEsTHEgN68fRa7xUbcM0GWerg/XjNBB6UgZl7OrSHTevcQp
 dFFz2LUNMHUOxf9zWN8mQSqBQ8BiQiLTiz75VTeADMrK9idsvxSKBnDY5OUDAsBBPOes
 HRsw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jmaO5h71DFF41SSXX5m3KcfjWo8C/ywX2kGUUpFItFpcjp+x4QKwQj6RhlvPJ0mp3bmE+6h4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywfzs5uVh4hKFGU9miwJ/gThGwOsFA2X3xSwe15E2/WVEg2PIqX
 Oj2XR9/1mziNj6K/lbLL4hZuaCdXKmo6WQdSztoOyyQedL9fbOt93JxV
X-Gm-Gg: AeBDievHngDtfq6N2o2CVwu77dpXYeM9vz6yRUf2XlnIrcMUWmpJAJRxKjewWNPx6Yx
 FS2JMP5ZyYFTGF+70dwR1iGxWOcLNUn0CSp/ImXTwZ9XomLopFblGgf/MIZ+y+wyRxwaCpUQrAq
 SjYgDh7D1Ln247z2i3IMBklhiOfLRLZcnS3LZpdqjkyypQ84hlfRAo2AzxKTWPcJBf+xOZF0GfZ
 tQf/r1tDGADT9NuYNSpW/FbSRpvnF71JpgARRCtDSv7yzy5ASmwE3V+1DsjlMitSYQbsHwq5OAC
 hAwORW4YhswSes45LUMntqZEpQSpR2oTPdnrU1BeodCYWpTDjDfanuQehOBssym5DUaiCndOvQj
 BVUXZ1OUegEysirwyGGBdmKKcB2Cv5SQ7YJLxSO0DxJbrJxX9wu3RVVPqE9UySKz2cPpjC7Cztc
 ATVWVWNutEYXF1pl9IKfaX32kkf0jtkIhVmQndK/sPU8m8LVZsqN/+6wT27ci8rZytD4lhfWEzQ
 B6juEtDz/BCq5rAi781E7kAGeALLO6iiyhTnCliEHBmySDCrIiYaN0FaHAf+CMSI2O9r/YBv/qf
 tfQXM6awdY2p9DSVMZBPY/DM4auOGGLzoD7C4q8CivcQiVPnZzW8vEK8zka6x5HZsEWf4mvTqFu
 FMKyIQr9Zr2HXV+6TUQ3yxQD+2/Z1w5Xl
X-Received: by 2002:a05:6000:1ac5:b0:43c:dc99:771c with SMTP id
 ffacd0b85a97d-43d642bf201mr13488209f8f.42.1775988002062; 
 Sun, 12 Apr 2026 03:00:02 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:e9:f8b:31b:f797])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43d63de2a53sm22327348f8f.5.2026.04.12.03.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 03:00:01 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: =?UTF-8?q?Filip=20Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] board/raspberrypi: Add quirk for RPi5 2Gb rev 1.0
Date: Sun, 12 Apr 2026 10:59:50 +0100
Message-ID: <20260412095952.727932-1-pbrobinson@gmail.com>
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

All 2Gb Raspberry Pi 5s use the BCM2712D0 silicon, but
the early boards were still rev 1.0 so we need a quirk
to ensure the correct device tree is used.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 board/raspberrypi/rpi/rpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index b0a1484c0fa..ff9cab6521b 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -371,6 +371,10 @@ static void set_fdtfile(void)
 	const char *fdtfile;
 	int rev = revision & 0x0f;
 
+	/* 2GB Pi 5B board rev 1.0 always has BCM2712D0 silicon */
+	if (revision == 0xb04170)
+		rev = 1;
+
 	if (env_get("fdtfile"))
 		return;
 
-- 
2.53.0

