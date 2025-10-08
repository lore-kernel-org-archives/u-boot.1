Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5D9CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 15:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D9D83A5C;
	Wed,  8 Oct 2025 17:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l1vq1GCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F9D183A61; Wed,  8 Oct 2025 17:08:38 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44BCF83930
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 17:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so83705475e9.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759936116; x=1760540916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sFUZRNn3tPoSMBRa65hUGfeVsPESB1kZHkhHhQT2CB4=;
 b=l1vq1GCyNMQE4QWs1mEbrpp1gnko2ad2Ut3nvQNyAiiJA+klv+brrLmi9Iy3QbT+ug
 rpOR1j5ESj+fFDovcEc6mX46gWq+bMgI6x/ykikkz3IGmx7w9t2Y4qLrrAUE9miK0UVQ
 RgmTO2mQNINqZAhhos02YH7bM14INFTGrhGSz2vPE/Ra1A85IFAP9RGYfHNlpJqmxO8Y
 aECD2iQ3I2xKLjfuZqK4XUvmhk2Q3jH5KiNGZynK6K4JrbSj69R0o43AJVh4LBzucGzh
 3+5m6YCpKtVaRdCLhOtDEgMPQXMH5LqNRB9RPTpqgibFc2x3Ip3QNj4pUyDfiQal65SI
 5aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759936116; x=1760540916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sFUZRNn3tPoSMBRa65hUGfeVsPESB1kZHkhHhQT2CB4=;
 b=WOpn+oPQoMLV4j64UhUv3MCupL4kwMD3cABcKur3yfpch+0Nsks/v3vpxj5l6VPFXX
 OiREDWGRkWbmciVrAgMVc/e+mF9mgw/eLOJB20dEbv/Lvvv6z0RVetjEYFFeavN/sdEb
 EWQopcQj8NySJO/sd+L1y4H6utw2M/9C0B1DQJiwcRbbm7KqKT9PBEuTK/WUlXy7+syf
 tEj+Qql+z4R/XCC8jxwRK+4rMC30Y0L+ap1EGf4FJijDrs83N58jgYQ3hbc6Fdljdum7
 E8Gdt5ZWPgtGBKblwZ5IfPwXnMZukgpXPsl7oT7nb7k+6SSoyCFaR/ecBrEk1y/9MzZP
 SkuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWlDNWG1bLyrxTqHI253ECwUmamW775qMR6CGZKbAW3X4kJGjxmCiDkMLuvr8G6G8jZzeqGbc=@lists.denx.de
X-Gm-Message-State: AOJu0YyZZA+eSHjmUIzxzcd5J0O7hhrofMqCS99haVn+VfELVaDKL27L
 PYrfqeN28wDiP9bKJUXK8aJrwW5mLSSxmovhjK8sIYb4MZlDMNWj9Mfg
X-Gm-Gg: ASbGncuKSI1Osy9FRQ+OsOTvAWD1C660ku4rZAo0gvefHQT6ztUmVgEjyqoj8nVssTz
 HE/f9FeaUKEiwHC6aTUlr0aFgeSA2moThw1f19iW5tW/q7rCYivogevtRajhhfb5amPBhT+UL1x
 D1OcMF1ZJxImhtMXnz/0540fRiEoTB4UgL3SL9q44f5p2y3BjnqKzmgnvOBDzdXAbUahZ7/y4GV
 S96o5EmM++HwmyF4L+gHykpzyZNMxSlyMXlJVMls5YQIYMm2hes4VKBX367JAyrrn4NovFXLlMZ
 XuNQ1Yn0eIpO1My//qO25fcoWA60/pW6aaout9Pqkh0Cw6jqK1q/+CQV2wrWI0/yuWrNar3qBza
 o7eIQefFGKJM64iUWaMjIurhkornLl438eV9BdizAs8610K4uuWtyV6aEEReiuyZXnRDeRzpVtG
 HJD78pz5amVOX6rKQk/06QkpQkdgXy/chXmtTib0wVYLp4cynritRqS059UoDAH5En+vk5XanbA
 CtQKnXDCDpDoWGdhVsSZ465cTU5wA4oFdApbF+rnDWLmG/16PEYToC+Dba+
X-Google-Smtp-Source: AGHT+IHr3Z/h2yJZA2Du40rXEBL6wzfR0waKfT0GbLurWK1vUSVwYvviwgcGT6YsAP4J+sQ1LyZJlA==
X-Received: by 2002:a05:600c:6092:b0:45d:e28c:8741 with SMTP id
 5b1f17b1804b1-46fa9b02e5amr26801265e9.29.1759936114173; 
 Wed, 08 Oct 2025 08:08:34 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:e9:f8b:31b:f797])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-46fa9bf81a3sm42413525e9.4.2025.10.08.08.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 08:08:33 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [resend PATCH v4] disk: dos: Add all options for EFI System Partitions
Date: Wed,  8 Oct 2025 16:08:27 +0100
Message-ID: <20251008150832.627727-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.51.0
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
Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---


v2:
- Add 0x0c option
- Make hex constants consistent
- Move from if to switch statement
v3:
- Fix switch brain fart
v4:
- Drop boot_ind out of switch

This is just a resend, it fell off my radar, and there was a CI failure.

 disk/part_dos.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index 18dd35c9b98..92d6fa6e028 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -39,10 +39,21 @@ static int get_bootable(dos_partition_t *p)
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
+		break;
+	default:
+		break;
+	}
+
 	if (p->boot_ind == 0x80)
 		ret |= PART_BOOTABLE;
+
 	return ret;
 }
 
-- 
2.51.0

