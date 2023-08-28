Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD43C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62418864D9;
	Mon, 28 Aug 2023 23:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sdCJVTwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B5C80569; Mon, 28 Aug 2023 23:56:35 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A1C2864CF
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a36b52b4a4so2031083b6e.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693259789; x=1693864589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4Cbue8aEI1ZeP0MHYlci0VcuZ6OivE4CGGkrEDLf8M=;
 b=sdCJVTwR1SBTVpUNKCgol2P4Cvygh8nfw8GjQBqULFYQbEByo7qEKp0mmttXrkNcF6
 wcGFEB+b+17xHRN8iVXmODsdPihIZTo9VmEHxC//IvHGM14Tr+SnCLh3ekLB8IZhg1ub
 huu3HyukBS/7meEUbRWWagkDlNgLmCI2zQaj8karxhiKgtnBJ224C/aknbOK8VkQo/2z
 xy+JlAHb+8ixZ8t2y2PebyHTmnpMXnaAH8t2H2AoQZJhfUhwiRv34I92k6Lt4K/1W6EA
 Z2Kaq94j2e2FbCJrASmMHTbh1c7MAGQ8dbfnXKWpdendEVEEtJj9Bz+DdHB5bT5v0MAB
 YLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693259789; x=1693864589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4Cbue8aEI1ZeP0MHYlci0VcuZ6OivE4CGGkrEDLf8M=;
 b=bD0kMSFDbkZ0iRd1DeBw69GhFm/wS2SzE8pmj6J5NxSqmkm3oWKM4wSSlsHGe3SL/Y
 aZBf5Ueeqviks+zWDkbthq82K8E7rGkPXuf4sAqwxI4+hTygoBq0ZSLB42plIDLh45ff
 klOMxgVN1NJgn1V8yPOPCOMkv8v9voGyx4gOYoGrhbtsSYSd0+qtlwcrv1icGkTkWZRn
 Itf15fiQQbZlOOznkyB/4oyymKUJY36yMJ8HKGaT35Ax3htLzVF6iHPQraSseEey9lX1
 G6GA95syVIn1R1LXuZL1dNpbGk/rum5H2wDqIw8Vro7buvK/jX5nUdymhRVWCogWSJBV
 5poA==
X-Gm-Message-State: AOJu0YwSQUj1XpT5Quh1nrS13e+pH/GsFcf0kdtlgt4eFo1gLFvUV5Xv
 mXmwCX4RSBg28hq+kQEJjcfW6+8Gq+c=
X-Google-Smtp-Source: AGHT+IEbzMcv/qh4P4xmAnfYOQ47nfs5icZ+pjnwkTq0dDNcsmKLvsOH8tbZkjOqalyS6nBKMfuKhg==
X-Received: by 2002:a05:6808:f04:b0:3a7:507d:7b20 with SMTP id
 m4-20020a0568080f0400b003a7507d7b20mr612271oiw.8.1693259789649; 
 Mon, 28 Aug 2023 14:56:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a0568080b2800b003a7527207b5sm3856298oij.7.2023.08.28.14.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 14:56:29 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v4 0/8] cmd: gpt: GPT manipulation improvements
Date: Mon, 28 Aug 2023 15:56:07 -0600
Message-Id: <20230828215623.3727536-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230825193830.2753640-1-JPEWhacker@gmail.com>
References: <20230825193830.2753640-1-JPEWhacker@gmail.com>
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

Adds several improvements and additions to the gpt command processing,
specifically (although not exclusively) for the purpose of supporting
"ping-pong" booting when doing A/B boot partitions with u-boot itself.

In this mechanism, u-boot must boot up, and then check if the correct
boot partition is active, and if not switch the GPT partition table to
the other boot partition and reboot to activate the other u-boot.

In order to facilitate this, the gpt command needs to be better at
preserving entry attributes when manipulating the partition table. It
also learns two new commands, one which can swap the order of partitions
in the table, and another that lets it change which partitions have the
bootable flag.

V2: Add documentation and tests
V3: Review Feedback
V4: More review feedback. Fixed 'gpt swap-partition' to work with
    missing partition indexes.

Joshua Watt (8):
  cmd: gpt: Remove confusing help text
  doc: Add gpt command documentation
  tests: gpt: Remove test order dependency
  cmd: gpt: Add gpt_partition_bootable variable
  cmd: gpt: Add command to set bootable flags
  cmd: gpt: Preserve type GUID if enabled
  cmd: gpt: Preserve bootable flag
  cmd: gpt: Add command to swap partition order

 cmd/gpt.c                 | 156 ++++++++++++++++++++++++--
 doc/usage/cmd/gpt.rst     | 226 ++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst       |   1 +
 test/py/tests/test_gpt.py | 160 +++++++++++++++++++++++++--
 4 files changed, 524 insertions(+), 19 deletions(-)
 create mode 100644 doc/usage/cmd/gpt.rst

-- 
2.33.0

