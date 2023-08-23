Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D960BC79F60
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 16:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F08BE864C4;
	Wed, 23 Aug 2023 18:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ppd0FLhw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A3486467; Wed, 23 Aug 2023 18:48:06 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E717786470
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bd04558784so4332001a34.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692809283; x=1693414083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ozPdEM2RatCWxQpE1poT9rucFLU5XGCKA11EDJDOByo=;
 b=Ppd0FLhwOH33mDO/PcQMOz4MPa9j/SNCIb8lhKZaQkcvLE1l6NW8R4guT4NA5aBSkx
 nZV3sVFCPOl/6ntNkuHlEEuRzihwKh0aByGyz2tX+mo2/38SCcThT9lJtkZturf2AA4z
 icT7VC/J1mktf6U8nkS59gzldievAuSpoyiaDndwO+Rc7CIH/XYF4M0kJsIHB5taYzhw
 GkvoqPh+3AcalaW5cODuVVyzhXOLkE8vUZ0zBFaOEYOcMFYT71DS388I6NIY+nqL0Qa3
 RorrxodDAHLyCL4Wfuqm3o17Jazms0cNs9IsnXDemfVyWYok5yASW6WiLJIr8F5iD6cY
 tjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692809283; x=1693414083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ozPdEM2RatCWxQpE1poT9rucFLU5XGCKA11EDJDOByo=;
 b=HRXIJYT3TZWZ771xJj9PVmimrUHnmtxOc5mOjZk9a5ChBlyQgvbiN3Pji3oeNzRvQv
 4Xz/yTq72OFtcSxHMRlwpheRuQ/Oe/fL8w+qsGy8Vf3Ombx7EjYgifx+w5Md/dQKnGP1
 x77N/LfrK/YgzJHDKvqi2TD+ZkBKFxxpDuyrXDnLCjmSKoK/HmF5ykNX1jf5vhahxdKP
 mVLJpR6tXvZN0HjIrqzBq+Cq3LNJURNPQnyj8fWkThrNdlUvBz1JB+JQtjJs4Wn16cM6
 3ZYkXFCEPtVNScY8bCoDnpn1wWU1W4YYVf6WelqGpbSmNCQuzqct43BS9A/xniFZ4N69
 QPPw==
X-Gm-Message-State: AOJu0Yx3zVROaupugghX4CX8g7jgeic4GhraRyz1z02UvFvUBU+4FyN1
 aHQ1lQmszFE3OI8byYagCJXkWyBMJmM=
X-Google-Smtp-Source: AGHT+IGSTtWFxp+s7SfEJOERfBdbmssZ1Z85Y/R5hI/TgOf67qLgjFsbvyX8NC7LT+/eNrXXCMrvTQ==
X-Received: by 2002:a9d:64cd:0:b0:6b7:5452:df79 with SMTP id
 n13-20020a9d64cd000000b006b75452df79mr13551803otl.0.1692809282736; 
 Wed, 23 Aug 2023 09:48:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::751c])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a056830205600b006b9cb784553sm5794042otp.36.2023.08.23.09.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 09:48:02 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v2 0/8] cmd: gpt: GPT manipulation improvements
Date: Wed, 23 Aug 2023 10:47:36 -0600
Message-Id: <20230823164755.2874792-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230815162726.1524958-1-JPEWhacker@gmail.com>
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
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

Joshua Watt (8):
  cmd: gpt: Remove confusing help text
  doc: Add gpt command documentation
  tests: gpt: Remove test order dependency
  cmd: gpt: Add gpt_partition_bootable variable
  cmd: gpt: Add command to set bootable flags
  cmd: gpt: Preserve type GUID if enabled
  cmd: gpt: Preserve bootable flag
  cmd: gpt: Add command to swap partition order

 cmd/gpt.c                 | 159 ++++++++++++++++++++++++++++++++--
 doc/usage/cmd/gpt.rst     | 174 ++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_gpt.py | 151 ++++++++++++++++++++++++++++++---
 3 files changed, 466 insertions(+), 18 deletions(-)
 create mode 100644 doc/usage/cmd/gpt.rst

-- 
2.33.0

