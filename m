Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AE4C5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 10:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 867F987E6D;
	Sat,  2 Mar 2024 11:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gv//yyh8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF2487E91; Sat,  2 Mar 2024 11:54:46 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBA1787E3A
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 11:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33d6f26ff33so1718853f8f.0
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 02:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709376883; x=1709981683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AY3IkEQ/pTO15arfJBJnYVFh2XxdST66agXr4vxoQKc=;
 b=Gv//yyh8iplQryNlDib+uq47t50943npfiAvQjmIAOSybrhipF/YpxEdXDbvrZ6HfT
 OBvCVVpBfAC4snacgPt95z847vGKEth+4WGAb/VESYGE5YtlODL9ud2bHJuQUjNhfvqs
 O6KFLMe2wriZQMpulO9NCcTRrd11nZJE/QI8p2c2C8KqnLmbypIAZCE3o1oU1PvdjLz+
 wpwWWjyrbZ34MvNdzxJ2zkDNlA7tWzkTolelb4XeBBtzcxuVIBYV9svpyHr4fIOhVhDv
 KpCp9gUw2UHhWo5LcODzFAHKhsHAvTQKMnE1k8SNJ7fWM9z6SI81ptXtaASnVgoFm3ON
 yVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709376883; x=1709981683;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AY3IkEQ/pTO15arfJBJnYVFh2XxdST66agXr4vxoQKc=;
 b=GGSRLDJFUqXcLox73KSvdc5Boq6CA2JZHgwCFzW+jGkMoZfplhHuIMOiL8YB9rMqYQ
 pzeEeFGB/1f013VaE2AJC0mjdN29bXK6tc258c8BWOMkqNzlTWw2sT+WFI6GnHtucwFM
 acMbWHDgiaRaGtEMjdT15REaYcy0navUNImHOrBVunVj7mxvYOr+OMD4itjPQVfopMy5
 XAzip6kw/tPeSBbnn292Kimcv+CDwhbj8PiHCg57nniehnaRw3lLPNjthTFRp4fu+WUS
 YWf3efeIhkjK5iop7UJkRf2D4bym1wCi9ngVif0k1XjjEJY4LssO/MK3qWWik6hE8QFg
 dOVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzKtQlbzIR3YtLtsDA5W22Z33BLsGd8WSMZesxXsuO9PrtXQ9c/Icg0owzQXPxBAtCVFCsay9H96fTVviwX9JkSqfDdQ==
X-Gm-Message-State: AOJu0Yw5huZjwB3fNdS/amML29XL28xdgTfppNTdDLztWwtM5XYDpwaJ
 nqjZ4vMLvJf0tMnHa4sqGZcZwZmQBW1zp++Tsq9u44zKna15SA1p
X-Google-Smtp-Source: AGHT+IH4++SOp2mmvAqjcAx36nlH+8aLLr509Y280t8TwwoPuSsV/6PlHahpz1JnixWMKtJWwdLeMQ==
X-Received: by 2002:a5d:6e90:0:b0:33e:d27:4f8c with SMTP id
 k16-20020a5d6e90000000b0033e0d274f8cmr3207981wrz.6.1709376882818; 
 Sat, 02 Mar 2024 02:54:42 -0800 (PST)
Received: from morpheus.home.roving-it.com
 (8.c.1.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681::1c8]) by smtp.googlemail.com with ESMTPSA id
 by1-20020a056000098100b0033e22341942sm3620391wrb.78.2024.03.02.02.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 02:54:42 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: mark.kettenis@xs4all.nl, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3] disk: dos: Add all options for EFI System Partitions
Date: Sat,  2 Mar 2024 10:54:36 +0000
Message-ID: <20240302105440.587680-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.44.0
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
v3:
- Fix switch brain fart

 disk/part_dos.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index 567ead7511d..97f4ce32bed 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -40,10 +40,21 @@ static int get_bootable(dos_partition_t *p)
 {
 	int ret = 0;
 
-	if (p->sys_ind == 0xef)
+	switch (p->sys_ind) {
+	case 0x01:
+	case 0x06:
+	case 0x0b:
+	case 0x0c:
+	case 0xef:
 		ret |= PART_EFI_SYSTEM_PARTITION;
-	if (p->boot_ind == 0x80)
+		break;
+	case 0x80:
 		ret |= PART_BOOTABLE;
+		break;
+	default:
+		break;
+	}
+
 	return ret;
 }
 
-- 
2.44.0

