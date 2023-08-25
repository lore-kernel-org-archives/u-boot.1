Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A10EC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 19:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF01D86AE9;
	Fri, 25 Aug 2023 21:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZC8btntD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67C8F86ADF; Fri, 25 Aug 2023 21:38:38 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E96386ADF
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 21:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6bcbb0c40b1so921091a34.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692992313; x=1693597113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ox3Li7VWGEy2hT0w5ftxBWnHrWYypjWI5PR8rK/AsNU=;
 b=ZC8btntDj0OssrZHtKyUmyEvHOWNJcMNKFA9/P0ynjh4sjL9puibpM8W+KSVZDXw4I
 fcfWX64f6klljak2u+x9dOMYNDyJ31o9Ayh5lBYj3TYHUkS97L7CWw+LPnLm3LM1pkEL
 ePDqzLJq1bMnZVqlZiIoMDLTV3dpydgWn3lNI9cx1QzAAm8lGwNU7rhlFdbBislWv/Pr
 5FPaNk6wWxnVos1ZbiGR4TGQWLJVPEB9jiFqUCCcFVYLDsQAMe6Wr0zoD+MzUBJazLwm
 aos87kkf/vjHXJ45vm7GZ++wAgu7lNwLe0OPnJlp0rO7IK/rRJnTKwzoCnTXMbJJtah1
 Ix/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692992313; x=1693597113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ox3Li7VWGEy2hT0w5ftxBWnHrWYypjWI5PR8rK/AsNU=;
 b=O7yD1NvfgXg3WmhRDe48UhMb3QaWi8GRwbYtnATyCncQmh/J2NKJ9V2UIdr1JTa18E
 trJ9Tf4kjGhEVqotSHOObMkeksk7On3gqaEKN7vaM0fxgDQEtP8B6B/0E4WB18enDhcx
 IeeXGXFqHmZQ0Qfwheq0SM8bi3QI0LLv6tinBcl0UHXbwyyl8zUiMF6Ui8FSSOay7qwy
 fDfRclpGK8aLS2j0V53iI3Om2MBl55mL6C+RXMcRRbLgI6d7KHvAJexE0D+tt76Lsc+8
 O314Yji0ebepsZLBLyJY33IWd1cfIinpOZDbS0jJytBoB1z8xCEsymfp3YVKjVrzko44
 ESmg==
X-Gm-Message-State: AOJu0Yz13+2jLI4200HIHIv1eFv7isyYdTdfk57sIf3Kg5H07fmZKioD
 MiMksd1jrv2WaAUR1r5kHXyndTT822Q=
X-Google-Smtp-Source: AGHT+IEnXUw1qcWCb5Z8MNquZF246jNebBGpUui7DGoa/bWl3iE/NHs53CLsm8De5D7V4IyAuRgBfw==
X-Received: by 2002:a05:6830:1e90:b0:6ab:27b5:d202 with SMTP id
 n16-20020a0568301e9000b006ab27b5d202mr6012921otr.37.1692992313462; 
 Fri, 25 Aug 2023 12:38:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a9d7e8d000000b006b871010cb1sm1171022otp.46.2023.08.25.12.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 12:38:32 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v3 0/8] cmd: gpt: GPT manipulation improvements
Date: Fri, 25 Aug 2023 13:38:16 -0600
Message-Id: <20230825193830.2753640-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230823164755.2874792-1-JPEWhacker@gmail.com>
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
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

Joshua Watt (8):
  cmd: gpt: Remove confusing help text
  doc: Add gpt command documentation
  tests: gpt: Remove test order dependency
  cmd: gpt: Add gpt_partition_bootable variable
  cmd: gpt: Add command to set bootable flags
  cmd: gpt: Preserve type GUID if enabled
  cmd: gpt: Preserve bootable flag
  cmd: gpt: Add command to swap partition order

 cmd/gpt.c                 | 162 +++++++++++++++++++++++++++++++++--
 doc/usage/cmd/gpt.rst     | 176 ++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst       |   1 +
 test/py/tests/test_gpt.py | 160 +++++++++++++++++++++++++++++++---
 4 files changed, 480 insertions(+), 19 deletions(-)
 create mode 100644 doc/usage/cmd/gpt.rst

-- 
2.33.0

