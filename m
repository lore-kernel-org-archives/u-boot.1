Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B69DCD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 21:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7530787F16;
	Sun, 31 Mar 2024 23:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TrkP+yyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A1EF87DF1; Sun, 31 Mar 2024 22:03:33 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DBC187D45
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugeneuriev@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-516a01c8490so797896e87.1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711915411; x=1712520211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vI5N3Yjv79U0WZkAOUQFKBv5htNWZMUCTL4VA/e155A=;
 b=TrkP+yyVvTxEvVatcDDoEk505PUsbg4aob+lXOrfzVXhT7MzXuLxlzvnk1Z/o7LAlh
 kTqXt83HYO03l0O6PL8V1Pqn1egTDbQ23pwhFoe3Ome+e+UQ68yTx0LVN3ms8OiZQbJP
 T9sm8a5W9xy8Lx7+ETmKzVUGLq2ksdam+6f+FCUtfc3zJTliCmufO3UdU+Fttttfp8pc
 uHDEWpEokg15ESHBUxwAyUBvQa6v3vtDpyk/p6xd8eInUQGPXrsm602Bb5henmPyyhHJ
 Q1LELe8FhP6ZYGJIO+bpJ9LZrWiJ4tGW8juNMPfLrggiwIElnxBRNGKtITgNzwhl2+H4
 bu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711915411; x=1712520211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vI5N3Yjv79U0WZkAOUQFKBv5htNWZMUCTL4VA/e155A=;
 b=EvUZ5sxgYUUGil7cSH+cn9aZgAkRKPu+TXgwt37+9GeargjRCQtJmG38gYwfCvOSWH
 9TaW1c8zzW21u6tk44C0uhC3Bo6OokrS9rw/PwuvP+elMVXzGna5AnCKgNNdn+aILDjm
 Voaal3b7XD5tXkFdJVffNdT8FEv+tYc5M6OL7pvTaioZTInpE/PMCnLU7+LmBktmgCem
 y5rpGc6MRWK4WECzK2XH/7LXLlAw8178y/vHW4+e3brhyjuEgVBC7HQwQItL+lAzcSZa
 xyET04Fbuqj6y0cRYkUWDD7ztugoHd7C9hdFsZ3cDfeb0knOoeHwzOkleiWkgynPUTlT
 XPbg==
X-Gm-Message-State: AOJu0YyI4VXzo08P2gp7wsFJq8KkKRe7vcYBrnvsrzlxi3PigOEFPjB4
 CzPKPYJgqPbDfz/RMLmJ3ourspqUM/7Y9J+ygT/r2ezQuRfRphTP
X-Google-Smtp-Source: AGHT+IGoC0H0rLEH5uoXEmQ4P2JeR/bRH8c2+ne8RmoixSXnX/1XDLfesRsO1O3FNj4thIe/YVppDw==
X-Received: by 2002:a05:6512:20c9:b0:513:cfa9:be6b with SMTP id
 u9-20020a05651220c900b00513cfa9be6bmr2461406lfr.3.1711915410658; 
 Sun, 31 Mar 2024 13:03:30 -0700 (PDT)
Received: from BlackProtonRN.clients.gtk.su ([185.16.100.35])
 by smtp.gmail.com with ESMTPSA id
 l5-20020ac25545000000b00516a08ce8f8sm425000lfk.269.2024.03.31.13.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 13:03:30 -0700 (PDT)
From: Eugene Uriev <eugeneuriev@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Eugene Uriev <eugeneuriev@gmail.com>
Subject: [PATCH 0/9] mcheck implementation for U-Boot
Date: Sun, 31 Mar 2024 23:03:18 +0300
Message-Id: <20240331200327.29141-1-eugeneuriev@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 Mar 2024 23:00:15 +0200
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


There was no "mcheck" for U-Boot before.

Since U-Boot has only 1 thread, and normally makes 4000+ - 6000+
mallocs, it's better to use havier canaries to protect heap-chunks.
My variant uses 2x8 = 16byte-long protector. And
the multiplier could be changed to tune speed/protection tradeoff.
This protects not only against memset()-s, but against "near" wild
pointers too, and makes more probable to catch "distant" ones.

The core file of the set is included into the C-file, not complied
separately in order to enable (potential) coexisting of
mcheck-protectors, e.g. malloc_simple(.) and dlmalloc simultaneously.

My tests were for ARM SoC, 64bit, so the patch is
aware of alignment.

Primary this patch is for using by developers: to verify,
if a change doesn't break the heap integrity.
By default the mcheck is disabled and wouldn't affect the boot.

I used pedantic mode, canary=16byte, registry-size=6608.
For my system the overhead was 230ms.

I assume, the merge window coming. So I send it now.


Eugene Uriev (9):
  mcheck: prepare +1 tier for mcheck-wrappers, in dl-*alloc commands
  mcheck: Use memset/memcpy instead of MALLOC_ZERO/MALLOC_COPY for
    mcheck.
  mcheck: introduce essentials of mcheck
  mcheck: integrate mcheck into dlmalloc.c
  mcheck: support memalign
  mcheck: add pedantic mode support
  mcheck: introduce mcheck_on_ramrelocation(.)
  mcheck: add stats, add a comment with test results
  mcheck: let mcheck_abortfunc_t print the pointer

 common/board_f.c         |   4 +
 common/dlmalloc.c        | 154 ++++++++++++++++----
 common/mcheck_core.inc.h | 304 +++++++++++++++++++++++++++++++++++++++
 include/mcheck.h         |  51 +++++++
 4 files changed, 488 insertions(+), 25 deletions(-)
 create mode 100644 common/mcheck_core.inc.h
 create mode 100644 include/mcheck.h

-- 
2.25.1

