Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9C8C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 18:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F4E886A4;
	Mon, 10 Jun 2024 20:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d9LdNFwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC3B888692; Mon, 10 Jun 2024 20:51:23 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A65D98852D
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 20:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6f1cf00b3aso247072966b.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718045481; x=1718650281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s1TVoHXDKexrZCEG6rmtfrrhgP1MPN0+X56XyC7Cxfw=;
 b=d9LdNFwa83odY7z5EPQorzheC9HblEiBicC6e1rrV7jsbTJynvafnvHjMLE63l2uUb
 pGgAF140SGbpcwOdKosASNGoAQNXr9DfWVtk5x3V3nMcWVku0QxuVEQRRx41scQMNzXE
 S9908CZFk2qVJUkycv3MjBy5GnSqr+KuF+J+LgYKR5dmz/EvMT/JOwGwzPNrKCt1rUK1
 8971HBYIxJktOU/CqtOGPC3WRNzzM2h/RCe2Z4TCLLepTWAREFq0XSjxBJ2EHvWy2M0i
 V/izkbgBBMhalolnwhvqB5Q20JnVvCQkpeAUVL1qz78FUgcD8bBt6Eo7p+GohBAnZjbE
 ZUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718045481; x=1718650281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s1TVoHXDKexrZCEG6rmtfrrhgP1MPN0+X56XyC7Cxfw=;
 b=oyHlNtvXuVx4Ddk/xPvBsSv/KKtwOiz+ZaBKov5zAVDu6dWhgIwmIgiBP3vF5mjtqo
 RdMn3usfzWy7usOeYh+aECqEqZoqHYeEZZyyktxOo5BxUyiHURz7EUcpGEXhgKKlrrLv
 OsJIRld4kat7NGbWhMw2KWqe5dznipzlhM2hdUNwILNbJF9y3qzByZK22fB4VWmnTV2W
 rryzpe4XD+cjr7Fw0IdnHJtIshtesVJsCzQQvjrrfHlKwtfeLs6pBAoA+p3FYJ+/fg2V
 GvxUi7NE6X0Zlnq+qR0PMbYU3UmvfJI/AhgA/a+7+ccliBkIDtqCpK/8TDUzNWfF3YUh
 VgOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgJop9BnkPqDOIj+EJEk16QDrlyzFzMlkS+TDC4IKS3IZP0Fd03s0aZg6wMmp6GnApW2YLKFQE2CH2LeMhCU+XY42HZw==
X-Gm-Message-State: AOJu0YxVZrqrxdgLPnR7HTWNNhEWPLC5UWDQsLwQG9QigQBBjfTGgzPD
 Ff4bTpAp3VUWSPJbhuqdHsAJ1uxqDr6vdgUkK3X1LfZ0ndT5Nrv5
X-Google-Smtp-Source: AGHT+IHnRoMiO9QwbFsq4+d5zSJF19pvwfsvXltIVMAmrN4JMEBDGGu+x8oaZkC+LYO3ksFHWU5Lzw==
X-Received: by 2002:a17:906:b885:b0:a6e:fdc8:ae42 with SMTP id
 a640c23a62f3a-a6f34cb468bmr31050466b.12.1718045480875; 
 Mon, 10 Jun 2024 11:51:20 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:ed15:c026:8826:cce0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1245ff6esm281964166b.58.2024.06.10.11.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 11:51:20 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com,
	hs@denx.de,
	pro@denx.de
Cc: vasileios.amoiridis@cern.ch, quentin.schulz@cherry.de,
 u-boot@lists.denx.de, Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 0/1]: drivers: bootcount: Add support for FAT filesystem
Date: Mon, 10 Jun 2024 20:51:15 +0200
Message-Id: <20240610185116.353604-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Jun 2024 20:54:07 +0200
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

Changes in v2:
	- Use generic code by utilizing FS_TYPE_ANY
	- Change filename from bootcount_ext.c to bootcount_fs.c

v1: https://lore.kernel.org/u-boot/20240605181041.68317-1-vassilisamir@gmail.com/

This patch adds support to save the bootcount variable in a file located in
FAT filesystem. Up to now, there was support only for EXT filesystem.

The reason I put this as RFC is because the file "bootcount_ext.c" will no
longer represent the implementation for the EXT filesystem, but also for the
FAT filesystem. Should it be renamed? If not, wouldn't it be inconsistent?

Cheers,
Vasilis

P.S: Documentation has not been modified yet, I will submit in the v2 (if any).

Vasileios Amoiridis (1):
  drivers: bootcount: Add support for FAT filesystem

 doc/README.bootcount                          | 12 ++---
 drivers/bootcount/Kconfig                     | 53 +++++++++++++------
 drivers/bootcount/Makefile                    |  2 +-
 .../{bootcount_ext.c => bootcount_fs.c}       | 12 ++---
 4 files changed, 50 insertions(+), 29 deletions(-)
 rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)

-- 
2.25.1

