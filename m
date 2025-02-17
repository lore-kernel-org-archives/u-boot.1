Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9124EC021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 05:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48FFF80F4E;
	Tue, 18 Feb 2025 06:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NOcAIJN6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5187980843; Mon, 17 Feb 2025 19:30:57 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B345807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 19:30:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-471be82b59aso56034981cf.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739817053; x=1740421853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=weOjAANeqMguxtdEWN6KuU/IdCdT3x0BapDauixSTEQ=;
 b=NOcAIJN6+DHZ5FlIgqV4IBNwoLjWZOb+gN1EKbKv7LtTdnVACAZ4UXrgsFVOIy5sMO
 1bJHT3ZgDHOAZNVO2b25GVwwRj1jyKajHhIfhwkDbSqXDhVEvbLmzn9NGaMhpJ5evWZN
 p0BPEim9RLs6MYojQXvBn4u0l7F+ly+SreOMnKo376XjpuNRrlxLpxbmU1UPuzxpXOff
 9ez4PJ1CXDrdgHZ4kRsbf/B0gZRQknDAdg9awMziBXm5oQKCeWp45gJRinCUkI5xVdX1
 9/G+s7n0uGMl2Arf0H8EPTttBRhgJp5qIlIz3bGtYScVK/18gKdkawx21aQNAz75sYWt
 ZiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739817053; x=1740421853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=weOjAANeqMguxtdEWN6KuU/IdCdT3x0BapDauixSTEQ=;
 b=dpUBj9o85wOD5iA5Tly+gac+8SKbO77pybWH63VSp+NvB7pBXor/PeVnjZMG6fypbX
 jiqYBdI3ehbN732lABB0jYpykGXDpedsaRNRw9JPygHZngr+dgAiSvI9dq1Nk1W1dyk+
 wtIEWAi6ncgtr30ETg7gS0dgygFQZmvsBo6qTvFjX0lW8DXQ60Ts0Cu6ERcrhwwgH7+Y
 TZfEin3+hHttzzQAf9yW1DhRBZ0K1F35Ze5z1xkzJyhJ0RSWX/qNG51TDbsD9EdiWHJA
 l5SZMbljBW5vD24SI2nY00jJXQ/7GJ+OS3SrGTu22VZKio0ZKr2BTEORw69y82IolaJP
 LqCw==
X-Gm-Message-State: AOJu0Yx03dvvmxkpQ+6xYVIOo9ri48PR+dTRpZPAKYQ32eHkT1DI9ivo
 wR/z9Yu0RShwkr1zftDUdyiqSepjfpNnBLizoU7m+viMUF0blz1bjyKcTlgr
X-Gm-Gg: ASbGncsVlfLTTswo1/PfpeFGiUxXrBpa5YD4qQ2hrLdZfczx8sVgpPwOsHJLQ0OXtHf
 afbVyNVS9X7AWZg6DpmI2+j0qcbmRGdQ3uS6dmvXRY3L1KhbAkGLaaS3iGTw4ITVM/EwoOJGBLD
 foPihRdm3H4IVC7J2SSIdiQAnAtlTezvOYrbgg5v2Ldb114Ct/GwGTwsau050biCzFHgGp/jhfl
 bIqL4sU9uWZIVxvYU9IpGgH46Kxo/EOyiQS7gWBQ1gVmC/olX8A3w7MDypo4bB2THtUuv+sx89v
 eHn57uv6nzpJN54rF1JCW8Q/D7/x2L1KaO0V6A==
X-Google-Smtp-Source: AGHT+IHW4NbTaD2PZLcuKXdFO7YUz/1JYduQKED1nog68WFY3sTp+p7FohFZmkUngMMASgiqYbeHdA==
X-Received: by 2002:ac8:5782:0:b0:471:f9e7:5049 with SMTP id
 d75a77b69052e-471f9e754f5mr27947791cf.24.1739817053234; 
 Mon, 17 Feb 2025 10:30:53 -0800 (PST)
Received: from localhost.localdomain ([174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471c2af3722sm50499271cf.49.2025.02.17.10.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:30:52 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/6] This series adds support for file renaming to
 EFI_FILE_PROTOCOL.SetInfo().
Date: Mon, 17 Feb 2025 13:26:41 -0500
Message-Id: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Feb 2025 06:35:28 +0100
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

Changes in v2:
 - update create_link() docstring
 - remove ATTR_ARCH being implicitly set in create_link()
 - cleanup log message and verbosity in fs_rename()
 - update fs_close() docstring with reference to fs_rename()
 - clarify fs_rename() behaviour in docstring
 - change fatrename to mv (updating semantics to match mv)
 - add mv command docs
 - add FAT_RENAME Kconfig symbol
 - update rename tests for mv command semantics
 - update rename test docs on whether mv should succeed or fail
 - remove all (fat) prefixes from commands used in rename tests
 - clarify docs in check_path_prefix()
 - stack allocate fat_itr in check_path_prefix()
 - log on observed filesystem corruption in check_path_prefix()
 - change 'break's to 'goto' in check_path_prefix()
 - normalize added logging to use log_debug()
 - correct error code returned when destination directory is not empty
 - remove setting ATTR_ARCH on parent dirs during renames
 - skip updating timestamps if no RTC present
 - make fat_itr stack allocated in update_parent_dir_props
 - update parent dir props in create_link and delete_dentry_link
 - simplify freeing of new_file_name and new_path

Gabriel Dalimonte (6):
  fs: fat: factor out dentry link create/delete
  fs: add rename infrastructure
  fs: fat: add rename
  fs: fat: update parent dirs metadata on dentry create/delete
  efi_loader: move path out of file_handle
  efi_loader: support file rename in SetInfo()

 cmd/fs.c                                |  14 +
 doc/usage/cmd/mv.rst                    |  61 +++
 fs/fat/Kconfig                          |   7 +
 fs/fat/fat_write.c                      | 476 +++++++++++++++++++++---
 fs/fs.c                                 |  95 +++++
 include/fat.h                           |   1 +
 include/fs.h                            |  16 +-
 lib/efi_loader/Kconfig                  |   1 +
 lib/efi_loader/efi_file.c               |  58 ++-
 test/py/tests/test_fs/conftest.py       | 121 ++++++
 test/py/tests/test_fs/fstest_helpers.py |   2 +
 test/py/tests/test_fs/test_rename.py    | 372 ++++++++++++++++++
 12 files changed, 1157 insertions(+), 67 deletions(-)
 create mode 100644 doc/usage/cmd/mv.rst
 create mode 100644 test/py/tests/test_fs/test_rename.py

-- 
2.34.1

