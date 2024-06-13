Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E800C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 22:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C176B88966;
	Fri, 14 Jun 2024 00:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FZbYqsQ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF028896E; Fri, 14 Jun 2024 00:02:19 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2869B88955
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 00:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57c5c51cb89so1676904a12.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718316136; x=1718920936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wMXqPBSyLiXx87rQueleL7xGVCaiRkaCOmffGye2guo=;
 b=FZbYqsQ8lxzHRSP+7cnfg7B2wXI0jMPscdy/XU6zyIRYl47y0o1HeVcw6V+wU4XaTh
 bmju64a+MD0RhSBXtI9WlH4sGDN7DVWDoUx70/wGjuAL4RBzSHfDorre9MBmbkJaYgp7
 4nObkAA0UYlPsTLfAmPNyycTe/mJ4bqkADJ3eRB9NIQ8vsI5TotH4+lVT5atwmeY7hNA
 DUGnBTqwpw8qL0cPNXaVJlsHjT1JpMy2ryxlMruQ1/KYKZ/1/nwdDOzCycrrSRovB45A
 aIG5gUVwsxY0BpmYbQgOSixYJlgmlAmKZTIDBObnNgA8ZklGiVrDxCbiMDg8B3fqAnsQ
 nQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718316136; x=1718920936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMXqPBSyLiXx87rQueleL7xGVCaiRkaCOmffGye2guo=;
 b=ri5UR3naZguQW4RnzsHJNvVv81IdZu1CD8SgGrvg/lQVpoMqynPyXFvoinPvp1QRr4
 vh+QEE21tnQUIU3WCONq7hmz4U8AhpLOAW2iaizMGogYJAOynei4JNDAWOyf+YXYMcuP
 5cH4RfscS7OBF8qTCn3b6cyXrIJYgmEkR+ErDeWlItagGrvOhTb7zSetUv/la17WyyjR
 b9atTGZpNVu/bfZAbIwQci9PbVbNW+xhgjSRcKr7aBe+h4C3i4Qon7aXhlKjKwJ0HJSb
 SYrt23+tYxof/DQhP+ol9d8BwnFr4xr3ikzDtaYAFpQNg090uZjBe0e87i7Mte/rK/at
 Z1jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqv7z8UkEB+H0bi+WwYQ4hGdaEDf6PReWOcPgio6e1gUjienjwz/qV4WC/R85ZDSIvnLhLc/LcwRrA/9CXoVnq3U3Plg==
X-Gm-Message-State: AOJu0YxW3p9eG2Jtk81dQDMzbM1r2yrgBXkgnFqwzmt5dC9pZ9VuJppY
 /Jw+mUj2Om36RpcSd+/qv1FoV6n55fQts0EhGQY7dO6OHrbPfGIj
X-Google-Smtp-Source: AGHT+IHl/nXbmG+PrVkv2zBIM7eSfRURo9NGyeG1Rt9T6QAulUuBrzyKUpdosQ/68uv9xDIPx2A9fw==
X-Received: by 2002:a50:f68b:0:b0:57c:a7dc:b0ef with SMTP id
 4fb4d7f45d1cf-57cbd6a866dmr778468a12.37.1718316136040; 
 Thu, 13 Jun 2024 15:02:16 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c633:5ca4:b5e1:26ba])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72cdffcsm1412473a12.6.2024.06.13.15.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 15:02:15 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com,
	hs@denx.de,
	pro@denx.de
Cc: vasileios.amoiridis@cern.ch, quentin.schulz@cherry.de,
 u-boot@lists.denx.de, Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 0/2] drivers: bootcount: Add support for ANY filesystem
Date: Fri, 14 Jun 2024 00:02:10 +0200
Message-Id: <20240613220212.37078-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Jun 2024 00:04:20 +0200
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

Changes in v3:
	- Remove specific CONFIGs for filesystems
	- Add message to prompt user to enable required write function
	- Use tags from previous rounds
	- Move documentation to rST

v2: https://lore.kernel.org/u-boot/20240610185116.353604-1-vassilisamir@gmail.com

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

Vasileios Amoiridis (2):
  drivers: bootcount: Add support for ANY filesystem
  doc: api: bootcount: Convert to rST documentation

 doc/README.bootcount                          | 53 -----------------
 doc/api/bootcount.rst                         | 58 +++++++++++++++++++
 drivers/bootcount/Kconfig                     | 36 ++++++------
 drivers/bootcount/Makefile                    |  2 +-
 .../{bootcount_ext.c => bootcount_fs.c}       | 12 ++--
 5 files changed, 83 insertions(+), 78 deletions(-)
 delete mode 100644 doc/README.bootcount
 create mode 100644 doc/api/bootcount.rst
 rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)

-- 
2.25.1

