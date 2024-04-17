Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C48C001CC
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 10:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7327B8844A;
	Wed, 17 Apr 2024 12:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YkZlDQGM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 614798842A; Wed, 17 Apr 2024 12:19:38 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25DF88205
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 12:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-516d3776334so6869192e87.1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 03:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713349175; x=1713953975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=15rGpRseOis4+JghA2jAqdK1BOWgy9aMbeziZZwvV6g=;
 b=YkZlDQGM13LwjN0myCdnSBhElD5nC0QHFdckMg2i9or9d2VUqcUu3mTZ27AosZ/i6P
 Ki37s+O54xnGD/6CjZBS/77AHqCRdYrs9wkVTiB1avT54BdO1Go9Rjah4IqKz8y77bM4
 qhitrCxubkQuf9tKJf0C0r+wjjKLBD2dANimWwnpcRz1F+D+MWAOs0f7zS6n3cFpbivB
 OLu67bfV007Cv97OeH4xOFR6J6rHRHmk2ADLgwvaVUped4eqeY7bWCjfEoDAS0kbvWly
 8pgBoljv78crboIT9ToQKyCdQGfHl+qen6vYWam8fMNYn+hHSEwBPYizUw1y1tMGVTHU
 eEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713349175; x=1713953975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=15rGpRseOis4+JghA2jAqdK1BOWgy9aMbeziZZwvV6g=;
 b=UIZyShztChjdIuGq2iiqvK7jlNRuOTms0A34bq3m2ci6pJ/MLWQI6olPOsAOhIJDU6
 ziJZzLCRtS1I3dq221oAxBlyAkKy9mvhvC3Oy37jdqxTq0PmheKR4Iz6o3BfFYxnZ+tQ
 RBeWtJTga/IHUXvLvmr33gr0x3q3Uo/YcpTP/2MI+MhRgdvTX+9Mu7PLgUGoI+n2CZ2+
 ozSarMRIFzIxmvDBLha/d5OqYxvYmWdolpC0xS4pCkHhdgqMDxE9B73okKdPDUyFtxPS
 U16pP+edFPbhH40lZY7bF4F3z5RxOLRyhbFIxqUMLNw/SS2PSUGYLFFLvsna6d2L1Tif
 ZDqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8ydHkxNz4aDjQrj8SpI8hbF6stKhMgter2Hu7oxDIth54dgbTid9PWc8KleCdu6V58d8h0mB+zB1ROrTKTPkY7EryYA==
X-Gm-Message-State: AOJu0YzUUekACfIc7WtFFhABCxUTqG/YarMa4nUr62viXpo5R2uliTS8
 aLzccghHqcGkaQApaYyGDtFvpZQj3ga6kRhCSwJRwZoXwqNlLdOul+gmVOQbaXc=
X-Google-Smtp-Source: AGHT+IGg0o5y6wh4buKtV+Brvn9wAOQtz3IIqxQd3I9WCk8SiisgUeMRMF0Uzda3RPLz2LDbMH7D6A==
X-Received: by 2002:a05:6512:3d02:b0:516:d444:b26b with SMTP id
 d2-20020a0565123d0200b00516d444b26bmr14369821lfv.46.1713349175163; 
 Wed, 17 Apr 2024 03:19:35 -0700 (PDT)
Received: from hades.. (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a5d488c000000b003472489d26fsm13567780wrq.19.2024.04.17.03.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 03:19:34 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	kettenis@openbsd.org
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Janne Grunau <j@jannau.net>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 0/4] Enable SetVariable at runtime
Date: Wed, 17 Apr 2024 13:19:21 +0300
Message-Id: <20240417101928.119115-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
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

Hi all,
This is the new version of [0]

The main difference from v1 is that VarToFile is now filled on the fly,
during a GetVariable call for it, instead of creating it during
SetVariable.

The advantage of doing that is memory efficiency, since the buffer comes
from the OS now and we don't have to allocate and preserve runtime memory
to copy things around. We also don't consume space from the existsing
variable storage.

The disadvantage is that it complicates the code a bit more since we need
to check for the variable name in GetVariable. We also need a function to
collect variables at runtime that operates on the memory backend.

In the future we can clean up and try to unify efi_var_collectXXX() variants,
but I'd rather keep tha patchset simpler for now.
We will also need support for QueryVariableInfo, which I will send in
another series as part of a cleanup since it's mostly supported already.

Changes since v1:
- Instead of Creating VarToFile at SetVariable, create it on GetVariable.
  This allows us to get rid of the preallocated RT buffer, since the
  address is user provided
- convert Set/GetVariableRT -> Set/GetVariable at runtime
- return EFI_INVALID_PARAM is NV is not set at runtime
- Heinrich sent me the efi_var_collect_mem() variant

Changes since the RFC:
- Return EFI_INVALID_PARAM if attributes are not volatile
- Add EFI_WRITE_PROTECTED checks for BS, RT *only* variables
- Add 2 EFI variables and allow userspace to write the file
- Add selftests

[0] https://lore.kernel.org/u-boot/20240406140203.248211-1-ilias.apalodimas@linaro.org/



Ilias Apalodimas (4):
  efi_loader: conditionally enable SetvariableRT
  efi_loader: Add OS notifications for SetVariable at runtime
  efi_loader: add an EFI variable with the file contents
  efi_selftest: add tests for setvariableRT

 include/efi_loader.h                          |   4 +
 include/efi_variable.h                        |  14 +-
 lib/charset.c                                 |   2 +-
 lib/efi_loader/Kconfig                        |  16 ++
 lib/efi_loader/efi_runtime.c                  |  36 +++++
 lib/efi_loader/efi_var_common.c               |   6 +-
 lib/efi_loader/efi_var_mem.c                  | 146 +++++++++++-------
 lib/efi_loader/efi_variable.c                 | 121 +++++++++++++--
 lib/efi_loader/efi_variable_tee.c             |   5 -
 .../efi_selftest_variables_runtime.c          | 116 +++++++++++++-
 10 files changed, 384 insertions(+), 82 deletions(-)

--
2.40.1

