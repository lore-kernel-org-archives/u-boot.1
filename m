Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F9606A691
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X887xUkp;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=npcn+5yp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11A9240478;
	Tue, 24 Nov 2026 21:19:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vgLRO5HdFxRs; Tue, 24 Nov 2026 21:19:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 26FB9402ED
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795555160;
	b=RDuPUMhV6Lxqqa7QLc7c3EWN2FMoEyg8wseMkOT0geuA9VB2Pdr6Wmo7+CYhvlIht7Hz
	 I1OGVKZf1chDchbggQdB4ry4GRI37Atkkwo1IzzcBqvtDd97TAjnXhJpklMxLMV5jZkln
	 UpOivuLetaGS2x/+eIQsDRO9mggy9xYfKPsb+eZvHXQYMFnqD87Tlq1rk82lCBSRcezMy
	 2d+wtBNP90Yq89il1VxhYff4Ahl0AZCR+qAC1M7JvLfgSZfZg+qrFBzyj1tSwHIBIra7y
	 8ECJhQa8HkImUJoDOh4HQRdCHWIkF2pGCZ6uFrbj2Tv2u8PH3pXHXi3RkdtNLQLyn/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795555160;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sbcPDw1ALvS95aHsZM2NQpWuS98gEbkU9iEhy9tKb1I=;
	b=JNi6oWo8AhtDtGP1OQRfbeEX1jGh7g0gcsiJvS7lXA+w/nQoyYau6ytBD+CSsuFw2Cvv
	 kiVvjdr3T8G0mf9T/V9orT/my0sKLuaR4+lGnuMG3KsVgJSH6DgcRwroaJ4TGoHrX5FK4
	 /r+C64TvKp0j7F6k5KHxNCtFlRHjMMETmisTBfSjMC7hL1dckYijE15p8fgY8J43/0bLG
	 sy5xoi2jdMRDmd0wO92hor2L5nvB3FxoTHvYjucZBj7PTZH0YVdVp0TgDdgxG0jEA+fKX
	 EC4V+P33uF95eV4sKvBe+x9JBUnvJ4B8MrmyjzWrJeLqX23tdTE5Qbo9QPDEOB1Ycxw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=npcn+5yp;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795555160;
	bh=sbcPDw1ALvS95aHsZM2NQpWuS98gEbkU9iEhy9tKb1I=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X887xUkp5gGEZhAuVeKG5xPD3U7Lz6m/BNjyKlsuFaUOLvgSfHrMrSOdVIOO7nmiE
	 S5ZhgwbpjqhEjSC55I24oSt3NHXiomFGDHJjUrUMyl8s75i2oAAIENCZovk2j4/CuO
	 NROuL7fyZVXdUvicKbMyjAJ5hye4emQxYtkIpJ1Emdk7scovj0Ge4mPMN03fa8qBrC
	 mmqXQau48HcpgixU/VG6qFvnlW3b4Rs6P3exTPwdeG9Hkr9evdyMjYIbMpXfFa/p4G
	 YEvaacxH2uffUj2K0kluFgN9yYzpAeoPkHR2VKYpuwoy72hIQL5CVx3CFIFAJETgZJ
	 0WgwdqdWGeCug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26FB9402ED;
	Tue, 24 Nov 2026 21:19:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 79F6C2DF
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 21:19:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F595405BD
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 21:19:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BDfWRinKmqdL for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 21:19:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 50F50405B9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::447"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::447; helo=mail-wr1-x447.google.com;
 envelope-from=3uv8fawkkbscqvz14v00bt11tyr.p1z7-o116yv565.7-o116-241wrp6.14t@flex--dimorinny.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=npcn+5yp
Received: from mail-wr1-x447.google.com (mail-wr1-x447.google.com
 [IPv6:2a00:1450:4864:20::447])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50F50405B9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 21:19:16 +0000 (UTC)
Received: by mail-wr1-x447.google.com with SMTP id
 ffacd0b85a97d-4a68703d177so2376425f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 13:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795555155; x=1796159955;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sbcPDw1ALvS95aHsZM2NQpWuS98gEbkU9iEhy9tKb1I=;
 b=npcn+5ypXRcEYGiXfMwmNTiyhqDjIYcippyXTdZ1BSzGNH+SuhHKGLcpN4HFEmZfek
 3IIFSiQBHeyMATJOvjvPGMCKayaCY5ssGGk11lvFoOXyRrQfRTHd37MISJjPhVrFfIgh
 96kOUa5AaVIHzd9K45U/MPMjt2kBh7Gy73S3PMOWenGdBubqlNFwhu1JAY1mA//jeeFt
 IhoJ9ZWWAam4lwpByFQ2YnHPqHXrosr8Gr8AK3pvIL9yBWBCKRLcRjQOhWFAXiN6XOi0
 W+p9oAFcmnj6HiS7G4ZbqN00FMmcosTu8DsZeoK41lm72Ltvu9U3HWKu+sFnwEfLE/CA
 pxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795555155; x=1796159955;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sbcPDw1ALvS95aHsZM2NQpWuS98gEbkU9iEhy9tKb1I=;
 b=xE+sgLyMFTWjHERKhPiU4TScLT3bIzsbrMU424qbxbWuwbBFvBSWshcipHu+vSXvO6
 S7vpNU4hmS8q3wyciStPYQ5IgXjK8X948aGrw6laGHPQodWQxd8zeb2klL2L5P7RS6+1
 fL3WRfM5QaeS84jGUFy9S7rs1sb49c+u/OhT/0THy73C9TzHEvZ62JJ3JcTVHrNxDSs4
 7xtpP64akLqIrW6O5WDc40PD9LnhNhh1Xf9X70WB8zlIk4WrVk70CQ5cUmK0kQSUcbCh
 0SiGtRt2dDOVCA7iXRN2UzqjZpOtxZJTowdBMiKt9nIOfzow/SYQXFnNLUm4IWv7z6um
 Kkgg==
X-Gm-Message-State: APuU4Z8A3/WAR6Ct6tYnEb3NfwJiUnuoq8ALo82aY/IqfdjPenivI4F0
 /dcs+TOXO21SXZTwfe0gag+eV/Nv1Z2C4Qq6vdMcweKrsiTt8hZrjFC1IFhlOaw2xUGkiCYqNut
 k9uYjLm2K6l4JWe25aVzI5QI+DGevQBb5byIr5SS/tnzp12qnIT5hRtASAUKMtpg6B2eOg3CJsZ
 mvOE1Gpr0taJOUoGPVvJAPK9s472eTXt34XjdbsMmoNjLGRpuwwywQ303YhCrMfsmT
X-Received: from wrvh7.prod.google.com ([2002:a5d:5487:0:b0:48d:f7b7:436f])
 (user=dimorinny job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:ef06:0:b0:4a9:5848:3640 with SMTP id
 ffacd0b85a97d-4abb5db79e6mr25097653f8f.55.1795555154584; 
 Tue, 24 Nov 2026 13:19:14 -0800 (PST)
Date: Tue, 24 Nov 2026 21:19:11 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124211914.3088229-1-dimorinny@google.com>
Subject: [PATCH next 0/2] efi: gbl: Introduce Android GBL protocol definitions
From: Dmitrii Merkurev <dimorinny@google.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Ji Luo <ji.luo@nxp.com>, 
 Ram Muthiah <rammuthiah@google.com>, Dmitrii Merkurev <dimorinny@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Android Generic Bootloader (GBL) [1] is a UEFI application from AOSP
that handles the Android boot flow (A/B slots, AVB and fastboot). It
runs on top of platform firmware and calls into it for board-specific
operations via GBL UEFI protocols. EDK2 EmbeddedPkg already carries
these headers (commit dfaa76349d4a, "EmbeddedPkg: Introduce GBL
protocols").

This series adds the protocol definitions to U-Boot without
implementations:

- Patch 1 adds the headers under include/efi_gbl/.
- Patch 2 registers the GBL GUIDs for 'efidebug dh', '%pUs' and
  'env print -e', adds a unit test, and adds documentation.

Protocol implementations depend heavily on board and SoC details, so
this series only introduces the shared definitions. Board-specific or
common implementations can build on them independently.

[1] https://source.android.com/docs/core/architecture/bootloader/generic-bootloader

Dmitrii Merkurev (2):
  efi: gbl: Add Android GBL EFI protocol definitions
  efi: gbl: Add GBL GUID names and protocol documentation

 MAINTAINERS                          |   7 ++
 doc/android/index.rst                |   3 +
 doc/develop/uefi/gbl.rst             |  97 +++++++++++++++
 doc/develop/uefi/index.rst           |   1 +
 include/efi_gbl/avb.h                | 172 +++++++++++++++++++++++++++
 include/efi_gbl/avf.h                |  41 +++++++
 include/efi_gbl/boot_control.h       | 104 ++++++++++++++++
 include/efi_gbl/boot_memory.h        |  62 ++++++++++
 include/efi_gbl/common.h             |  57 +++++++++
 include/efi_gbl/debug.h              |  44 +++++++
 include/efi_gbl/fastboot.h           |  88 ++++++++++++++
 include/efi_gbl/fastboot_transport.h |  56 +++++++++
 include/efi_gbl/os_configuration.h   | 103 ++++++++++++++++
 lib/uuid.c                           |  47 ++++++++
 test/lib/uuid.c                      | 122 +++++++++++++++++++
 15 files changed, 1004 insertions(+)
 create mode 100644 doc/develop/uefi/gbl.rst
 create mode 100644 include/efi_gbl/avb.h
 create mode 100644 include/efi_gbl/avf.h
 create mode 100644 include/efi_gbl/boot_control.h
 create mode 100644 include/efi_gbl/boot_memory.h
 create mode 100644 include/efi_gbl/common.h
 create mode 100644 include/efi_gbl/debug.h
 create mode 100644 include/efi_gbl/fastboot.h
 create mode 100644 include/efi_gbl/fastboot_transport.h
 create mode 100644 include/efi_gbl/os_configuration.h


base-commit: b7ed8d19d83d08d34b24b15c3dced7fd6c284939
-- 
2.56.1.831.g720f3f5937-goog

