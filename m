Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF29ED10BE8
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 08:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07CC388DF1;
	Sat, 26 Oct 2024 10:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RH8kqfgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 197C888DF8; Sat, 26 Oct 2024 10:01:11 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A8288936
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 10:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so352137366b.0
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729929656; x=1730534456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+af8JleH+HioQNHuV1xAco6oQtIB9NxtywL9TG2Js+Q=;
 b=RH8kqfgwUTOIFaPFgyy+0vvkwvbOKX9zYFj1yTMDq78f8xR2xpKnYCEGrZMN/VZ8ga
 VUESgAsj1FrX/tNOmlpmdskBI7zPTLkIkGowD/WTY3vdvBZlf8E3G0CWdhSLgouPNgR3
 B2vipn6aRbvNpSfQoKuaBDNUbaDDNXq4x/Dv+KhwhUoYh/PgoFcFz+5XcEK27g2hZH/j
 OQVcSvJxEf0kUSUJm+Qy+zq1Bs7OCYBUGK8jb3OYK8I3tGOrNhYauPVIGwil9cVPyjPk
 ubZ1EcIpHOGK5vgxRUYfMWS0JXF0miWL2wL8YqbGFQGlMpWBN7h+9D9mRdza69weyA65
 EGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729929656; x=1730534456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+af8JleH+HioQNHuV1xAco6oQtIB9NxtywL9TG2Js+Q=;
 b=Rv91T+Dq2pVuRfABHSnBNH/trXuHxoKIpPCxwbLGZu5Z5B7sMvMXL0Oa5g4FQUfD22
 ZyTes6rod5ObQ8iC1ZuwMulypEYYM33dMygz6Dhcb2JhgQ6Kk56HZ8vd9dH1cvQzkCQO
 TaSBRXHnvcwwRXWRwmdhEOsthP7o/s1rMFXL41o5EuNnd/PRJ6ScROvbYr5M8fgHLFir
 Z/Uhvcq+zLxkGMIjHYFChy+TUCqe1UpKxuUisUAgikzDdXdnPhiS4x0xLLL27xsHbEXG
 VrMg4R5N2JejcmVWpzq4sOWpp2W9duMtTa+MwMkzCJEYTZpzZCTqOCfDtDtSStMI2E+D
 e/TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBPUrBPEPmkKiRhxl5puIhdaxmu2Ix+r3wKDJyZFVdCgCIlj1FdfKXHOp7DpXMG+bcHdt6xlo=@lists.denx.de
X-Gm-Message-State: AOJu0YwrJSX1qufsOtdMYBAVcI7y89hQzsTx/XZ5SqiX1nSD8Jb+CGDv
 sUINbodxhz/4iL9A+x3cgn4GsIULJqDAN1y3wEoZP6sW5uHQ0ciu0UsL+7iGTTg=
X-Google-Smtp-Source: AGHT+IEjX/29Q6n7kbOV2mrLpmUwNRpddsYVCotiWuaUIJkGtVtHDTkQfD1XAbqGgCD8cbCoN5NcAw==
X-Received: by 2002:a17:907:7e91:b0:a99:403e:2578 with SMTP id
 a640c23a62f3a-a9de5c91d04mr175125966b.5.1729929655936; 
 Sat, 26 Oct 2024 01:00:55 -0700 (PDT)
Received: from hades.. (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f297204sm148280266b.116.2024.10.26.01.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 01:00:54 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Remove unused diskid
Date: Sat, 26 Oct 2024 11:00:49 +0300
Message-ID: <20241026080050.125214-1-ilias.apalodimas@linaro.org>
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

That variable is defined and assigned a value in two functions
but it's never used.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_disk.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 93a9a5ac0250..1f3de0a23399 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -561,11 +561,9 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
 {
 	struct efi_disk_obj *disk;
 	struct blk_desc *desc;
-	int diskid;
 	efi_status_t ret;
 
 	desc = dev_get_uclass_plat(dev);
-	diskid = desc->devnum;
 
 	ret = efi_disk_add_dev(NULL, NULL, desc,
 			       NULL, 0, &disk, agent_handle);
@@ -608,7 +606,6 @@ static int efi_disk_create_part(struct udevice *dev, efi_handle_t agent_handle)
 	struct disk_part *part_data;
 	struct disk_partition *info;
 	unsigned int part;
-	int diskid;
 	struct efi_handler *handler;
 	struct efi_device_path *dp_parent;
 	struct efi_disk_obj *disk;
@@ -618,7 +615,6 @@ static int efi_disk_create_part(struct udevice *dev, efi_handle_t agent_handle)
 		return -1;
 
 	desc = dev_get_uclass_plat(dev_get_parent(dev));
-	diskid = desc->devnum;
 
 	part_data = dev_get_uclass_plat(dev);
 	part = part_data->partnum;
-- 
2.43.0

