Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915FCC47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 14:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D9CC87DD8;
	Sun, 25 Feb 2024 15:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lDst+Gxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66C6D87DDA; Sun, 25 Feb 2024 15:15:04 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C38287DCF
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 15:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33d6cc6d2fcso1377612f8f.2
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 06:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708870501; x=1709475301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V1Uh8a5ug5ahwK/5ObcQHZ4BAfVmof9SBMX16KxvmD8=;
 b=lDst+GxwpeLJ4GymcvFOtpYAjLVGp5Q6zPnTm1g7RjUNuplNgAAMrkZKpgZSqxyHGP
 3qF3VLUhB0VekvOUZ93RA6yVI64sdr2R1hVBBri04qLQCcdj0AuBF4AVlYb6u7b8vOIW
 I30dPRMrI1gQ4Zy51kI+sD8OuTLagAve5wpNCM0gfHLRdI8Kr82jqQsoEQwtgXEXgzks
 NsMXF+IcUMAsbJjl4nYXWpsF+1iWhnTR1eARau0j55TBiCVjA2WsEULqgulCTPNneh6U
 GT3cmHL9z7mNY6ZvyWw+3b0nF+RnoFb8ADxs9epxvv5eCgxLZWkjTgPu4LKeHJ7B85zA
 Ltmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708870501; x=1709475301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V1Uh8a5ug5ahwK/5ObcQHZ4BAfVmof9SBMX16KxvmD8=;
 b=Kr+yZZet4/1Z6NDfGTVsS7ErCLXANS7dNBthganBHKL3291UeSPAMQgip3dcEdwPkQ
 JaXeZOAMjvZJ3rOP6eCaonCUAGd3I5PUGTfcRf6pDmT6Rj6zvky2JIzJSDUi2u6VcJOr
 Pvn4V8YUMUpTUHwuRUTLcIq7jy8fsnHRK5+RSRJb9OYvh1h9qrzl4ZN3wD95DpV+WKQp
 VrShv5/cG8Ddy3vjAU4lSyFtlDMO0EaIcUlQ05+SZhDG9t7m+WrICLaBW6HM+jMAIwe5
 5flPlcL9Ah1fGxI8ssKhhwv889FCPbAdG5UmyFcPH31Rk/TQ5YAnm/2FEhy84J7XPtP4
 r6NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpG0PD5HK1tUPx0W1nudM7gs0sFFIpPdhovsbtyDAXkSQikYRpX1YaKYmpfg+eOKT/xl0G0UN7nVqLaEePt78E2UBr+g==
X-Gm-Message-State: AOJu0Yxs7TTJeypSnscz+tGUlIsHfMEnqWqYH4OHOIw55UreXitUwDQ7
 R6IbdXbSFP+VOD7JMJiVqQzIgZWMWlVc4i0O0+CdYfGBNFIx7LRPUi4yjixBiMk=
X-Google-Smtp-Source: AGHT+IEokvkb1MBlz5IRib6rS4Xq8HrZ1Aux52lZA4z/Xk7wx2PYo0k+SslqSjxhHqacfsOWj/WmpQ==
X-Received: by 2002:a5d:4150:0:b0:33d:2899:3a8a with SMTP id
 c16-20020a5d4150000000b0033d28993a8amr2871208wrq.39.1708870500823; 
 Sun, 25 Feb 2024 06:15:00 -0800 (PST)
Received: from morpheus.home.roving-it.com ([89.109.115.142])
 by smtp.googlemail.com with ESMTPSA id
 e3-20020a5d4e83000000b0033d12895cfdsm5212008wru.61.2024.02.25.06.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 06:15:00 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2] disk: dos: Add all options for EFI System Partitions
Date: Sun, 25 Feb 2024 14:14:55 +0000
Message-ID: <20240225141457.48209-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.43.2
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

The EFI spec states that the ESP can be any of FAT12/16/32 but for
compatibility doesn't necssarily require the partition to be the
EFI partition table ID of 0xef. A number of arm devices will not
find their firmware on a FAT partition with an ID of 0xef so also
allow the original FAT12/16/32 partition IDs as they are also
permissable for an ESP.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---

v2:
- Add 0x0c option
- Make hex constants consistent
- Move from if to switch statement

 disk/part_dos.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index 567ead7511d..ab855adf347 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -40,10 +40,23 @@ static int get_bootable(dos_partition_t *p)
 {
 	int ret = 0;
 
-	if (p->sys_ind == 0xef)
+	switch (p->sys_ind){
+	case 0x01:
 		ret |= PART_EFI_SYSTEM_PARTITION;
-	if (p->boot_ind == 0x80)
+	case 0x06:
+		ret |= PART_EFI_SYSTEM_PARTITION;
+	case 0x0b:
+		ret |= PART_EFI_SYSTEM_PARTITION;
+	case 0x0c:
+		ret |= PART_EFI_SYSTEM_PARTITION;
+	case 0xef:
+		ret |= PART_EFI_SYSTEM_PARTITION;
+	case 0x80:
 		ret |= PART_BOOTABLE;
+	default:
+		break;
+	}
+
 	return ret;
 }
 
-- 
2.43.2

