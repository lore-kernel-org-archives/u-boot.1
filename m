Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BFCC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 09:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2791387B34;
	Wed, 17 Jan 2024 10:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ek7Tjfrb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6024F87B30; Wed, 17 Jan 2024 10:46:43 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8435F87B12
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 10:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d5f5a2e828so7192625ad.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 01:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705484797; x=1706089597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M/rFlCQ97+J0hJ3KUdHrjanSFd3HZA2UUeIYDofulm4=;
 b=ek7TjfrbHgukYE1pHs6LTV0LAVgP9zS3SUwdZ4WTh98/xCBldxpkLTKH0HnWk6OfDe
 N49O3sT8WqTXxtDc217QIOCw7HubeWneN/t+GJZE1ihYAFMtq8RXVHu/GHJS22WUJRm2
 JDhhgVccWr6S6JxE9wpDUSLGNQOwPYpQDJmhe/KIy+xBCfgFHgM8lyfyv7zjzfvJeIby
 ir5PFuHanh8UcgTVWUFCNE98fIIHH0CC1NosnI3M1gClpMK6LHYz4Yl9d8JpVIPqSIqJ
 ocw06eGXF4zGq2RT/79w85BDK1lnYiXqeUQQc/Cc8qeneQt2Z5ALa4SfQdOUo5eyNBUe
 IDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705484797; x=1706089597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M/rFlCQ97+J0hJ3KUdHrjanSFd3HZA2UUeIYDofulm4=;
 b=wv8yO9bpC3l3zRVX+/ndNn91GbnIwjlSDv0n2OOnHCYMmcspOZigHh/iL+6FwpY52B
 LURBJe7Rz8egMvifIBT+2uP2EavfEU/nmafFzGKflX//C72wlmJrpGwdoC9TLRjGVb7Z
 V/dQKiZSHGXk1JePrqNtVIBuBjSfEcqvH/CB71NDJj4OXtRTmENaT2BzLKQMFfKJIKag
 zRU787pm7D41a8tRKhynTQddUX+84iyRmK0MA8PDudtcu0rYrSMOzAWjrTunphyB0b8w
 TZZJi/1sgLXmpgiAgGv5bvTI6/5fuamdVXWSXPnZ2frvUcfdkU9zbdN1REwyKPMVhWVH
 YOfA==
X-Gm-Message-State: AOJu0YwAHcTaX5ujbMHpZOtJqXTlKihTue3uThDQQUt01MwZPeoxGyb4
 6wCqd4gmM1w6t8p/blxM4fDBmMcy7Zhc+qvIVMEfYVuyGQ8=
X-Google-Smtp-Source: AGHT+IGHPDSTd+WCv87XTAuTs2j/F8ZkOc/bjy2dCzSYPb1hv+Thv9ZxD8hFKn/rie/GESmYt3jG7w==
X-Received: by 2002:a17:902:6b81:b0:1d3:529a:83b6 with SMTP id
 p1-20020a1709026b8100b001d3529a83b6mr4928255plk.17.1705484797526; 
 Wed, 17 Jan 2024 01:46:37 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 x12-20020a170902a38c00b001d4b1d190e3sm10909392pla.58.2024.01.17.01.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 01:46:36 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 0/3] fix and refactoring of efi_disk.c
Date: Wed, 17 Jan 2024 18:44:29 +0900
Message-Id: <20240117094432.1049168-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This series fixes the memory leak issue in lib/efi_loader/efi_disk.c
and refactor the efi_disk_remove() implementation.

[Changelog]
v1 -> v2
- remove already merged patch
- remove container_of() calls
- add TODO comments
- return immediately in UCLASS_EFI_LOADER removal

Masahisa Kojima (3):
  efi_loader: avoid pointer access after calling efi_delete_handle
  efi_loader: create common function to free struct efi_disk_obj
  efi_loader: return immediately in UCLASS_EFI_LOADER removal

 lib/efi_loader/efi_disk.c | 55 +++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 14 deletions(-)

-- 
2.34.1

