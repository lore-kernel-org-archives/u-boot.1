Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1B9C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A11D68082A;
	Wed, 22 Jan 2025 14:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ud1JH3Dx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBC18801FB; Wed, 22 Jan 2025 06:33:09 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1EBE80137
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 06:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6e9317a2aso50040185a.0
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 21:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737523986; x=1738128786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rfdsKmdqXUPJW1tm9kxF4gKE25PENBaFvBoB+uHOqXY=;
 b=Ud1JH3DxWBhEan4TdBIhl+suNRP6EeAtgTXv8lIYgThfJnIJM38AU3Pp61XEYQE9ru
 hoG+doym7epiZHLZ1hOht5ZetwQnYMCXBFfpYo5Gd+7ZyHCbqYRnQlvZmc3ZXRP08ylG
 Njsf8z/FVnsJpY3CSXJ/oNi0qN0feYO8AQXDy4buHJXKjHey/pPl9Vb4TCsN1C6BACzJ
 5o3VA1G6p2nnXH+5LPJ8c29PZKF94EeaPkioZU+oyDtYM0PiNtjUKyyJtctkbk52OtRj
 vsLA2z2woER5R1qodZr4+IPEGTcqwbHGSM0aIwalD8A6tEQt8mJ/nEjqykRQyQD6UaU9
 IvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737523986; x=1738128786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rfdsKmdqXUPJW1tm9kxF4gKE25PENBaFvBoB+uHOqXY=;
 b=v6504o2afR38Cg+tnEOPHomPufJrO88EZFi2nleFNADyi+XAKgLnAjRxVYrJ42kPBB
 8tbPNvz7ENSKXDJ/oyjYuTXTXsEHM407y4RAcF/w4jz3KljMkKU3fJpZgd52KoxMz/hs
 BhCKIGT9mgEiswxjqnyeQMBRJkRXMsqNY8FzSPQJXqh5ijzhy1czhQz9gseayTvMPWf7
 VCF/cMz+8duCi+n4U9Dl8dqWOrkY5UKaPdDgB0xoecs8ch6BvBqrRuG8j7DKE31yNKiW
 VZtqeynYscbvpJTZw3vo43ovW68PruNPXhUfH10BTv3Gs36XSsI5L4AbEsL78tsRepIx
 bfHw==
X-Gm-Message-State: AOJu0Yx4uqLuhu99TWLWHOagYu3lAN88t7IoM8XOBslxO62FluSA6Jhv
 W7eK84ryC7ZBI4GZMqPkASMgX1uikErzoV40lko2eKg4RiZQMLT1kwiRpf0hDCI=
X-Gm-Gg: ASbGncsPlQDRm+dSSwsFOdFLrMUAJz1TTBjbAXB0wXQ1GlH+NqtwXU+byg0jkCnQAei
 RteDKxxtdOkebpaSrin/y7h+Zu5cITwGr4QKMeVT84VhCPPEvwYAh9QbiG+1u1bJWsGHEw63Y8Z
 BQuzNQqcgMCeAZVKsL5WWiFKsLvNkCfQvCSYelVQrg3hGzewP8rupuoAw2xvjO3QnlqJp/5T60V
 a/084dppyXNkFaW2KN2XBvdlZHTra4E2O63lHPKCBp9+PPGh8auYoe4HPH2C81tX4JGRUdeapFR
 d7VHBmGtwno8FBvNJy/z1EclpYZRAERgaLCq/AF1XvcBZmLra8+57Y0JlEiEPbCyCsEMJjm1cIJ
 QOdUB
X-Google-Smtp-Source: AGHT+IGgXJ8Uh+mCvUqQD3j5t2EPqV8df5mPsqnr56EQNHsfqRT5rdqjShDvANEaU84h1ZB8GDKzNg==
X-Received: by 2002:a05:620a:2607:b0:7b6:eba3:2dfb with SMTP id
 af79cd13be357-7be638cb02cmr3217826985a.16.1737523985925; 
 Tue, 21 Jan 2025 21:33:05 -0800 (PST)
Received: from localhost.localdomain
 (bras-base-btfdon1720w-grc-54-174-88-143-14.dsl.bell.ca. [174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614d98b2sm634136785a.76.2025.01.21.21.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 21:33:04 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/6] add support for renaming to EFI_FILE_PROTOCOL.SetInfo()
Date: Wed, 22 Jan 2025 00:32:25 -0500
Message-Id: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Jan 2025 14:22:36 +0100
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

This series adds support for file renaming to EFI_FILE_PROTOCOL.SetInfo().
One of the use cases for renaming in EFI is to facilitate boot loader
boot counting.

No existing filesystems in U-Boot currently include file renaming,
resulting in support for renaming at the filesystem level and a
concrete implementation for the FAT filesystem.


Gabriel Dalimonte (6):
  fs: fat: factor out dentry link create/delete
  fs: add rename infrastructure
  fs: fat: add rename
  fs: fat: update parent dirs metadata on rename
  efi_loader: move path out of file_handle
  efi_loader: support file rename in SetInfo()

 cmd/fat.c                               |  14 +
 fs/fat/fat_write.c                      | 448 +++++++++++++++++++++---
 fs/fs.c                                 |  48 +++
 include/fat.h                           |   1 +
 include/fs.h                            |  13 +
 lib/efi_loader/efi_file.c               |  61 +++-
 test/py/tests/test_fs/conftest.py       | 121 +++++++
 test/py/tests/test_fs/fstest_helpers.py |   2 +
 test/py/tests/test_fs/test_rename.py    | 366 +++++++++++++++++++
 9 files changed, 1009 insertions(+), 65 deletions(-)
 create mode 100644 test/py/tests/test_fs/test_rename.py

-- 
2.34.1

