Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394F9C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF778745E;
	Mon, 18 Dec 2023 19:19:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lTUra1zN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 570BB871C3; Mon, 18 Dec 2023 19:19:32 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD90870D5
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-67f2f1008e1so15638956d6.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702923568; x=1703528368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YBNP5h/vyaPNdABOyvxb0RkiEtLvMcEVr6YcTL2N3Uo=;
 b=lTUra1zNl5VcwkaNE9n4YbnjB/CqODjdp4ZX0pW5RmmTwX78sqCEWqH5KBHCk64Pfj
 P0GFmkeqFThbAx74OjTNBwQgFdpHaTDyKx1ZW6jmKrBKCli9lbVaUXZX/dIzSRtyr9Q3
 Gq1BWUf9EU/q0H6s/PVUwa8NvhnYEEk3pmkbU/nPc6yFAHtnCnSbQyOvbY2PfaDAcDHL
 5LcWtbdwOl1XCjCXwisQuGBcXFHTPNRigE+lL83jXo3/vGcS6CcfOFxebBraqiPuNud8
 AJcp5I02/6UEEbAAx85I/GkqW7s2t+rDpbSg7i1NcHBey50n6/WJO7nVWZwgIbDMTEBQ
 gKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923568; x=1703528368;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YBNP5h/vyaPNdABOyvxb0RkiEtLvMcEVr6YcTL2N3Uo=;
 b=jb1wxV2/IPqsxHIJvM7NAm/hX/G0sm2G3knK6s+NGMMneMVmDVJyadlxfJBJqjRfwl
 515hi57kLGUtdfCHgwklBOgsnayA23wuJtIFvk17xDRWvpNmCUpFwuUyFUPZt/E+LGlQ
 +Dqqd0QyBEt+XBTqjEoAtpt9XLPdBiQjQ1WPIdqnAFRL7dSrXHdpkO/Mo0V7BXKMTI5W
 jOPuwv44r4D6ITrrrimVKQ85WCSLBvNmT2WjiQAjzgZqTTD5tXFfUz33dSjIS11Sd7QU
 XkynQWRPwhYGxmtq2AajCN+ug9M5CMYm7jnklByoIUvGFhtVEWAZTOTWFPqUw+qRPZVU
 KvOQ==
X-Gm-Message-State: AOJu0YyRWZXgGhC8gmJoQ2/kaNnus8eIsWuoaAnV6jRFfws7xF/TbRLI
 uWXrfqCXBrrQXxhXpX7doJ+arElqwWy+gRsT15A=
X-Google-Smtp-Source: AGHT+IGbG4A9R2RgE2So6ZctkZglURPOsXGQB7ap30GKha4UlSiYWUh7JIXI591fwfTPSaF67qhwhw==
X-Received: by 2002:a05:6214:e4c:b0:67f:4881:1ad0 with SMTP id
 o12-20020a0562140e4c00b0067f48811ad0mr2431208qvc.34.1702923568312; 
 Mon, 18 Dec 2023 10:19:28 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020ad44e87000000b0067f213933bdsm3046136qvb.2.2023.12.18.10.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:19:28 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 00/14] Support Firmware Handoff spec via bloblist
Date: Mon, 18 Dec 2023 10:18:45 -0800
Message-Id: <20231218181901.337515-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Major changes:

Update bloblist to align to Firmware Handoff spec v0.9 (up to commit #3592349 of the spec)
(https://github.com/FirmwareHandoff/firmware_handoff).

Includes:
- Align bloblist tags with the FW handoff spec
- Add an explicit alignment field in the header
- Update bloblist magic and version
- Use a packed format for blob record header
- Change the checksum alorigthm
- Use a void entry to handle the alignment
- Adjust the headers of bloblist and blob record
- Align the bloblist record data section start address

In v3, the implementation from boot arguments to bloblist and how to load the
FDT from the bloblist are moved to a forthcoming patch serie.

Raymond Mao (1):
  bloblist: Align bloblist used_size and total_size to spec

Simon Glass (13):
  bloblist: Update the tag numbering
  bloblist: Adjust API to align in powers of 2
  bloblist: Change the magic value
  bloblist: Set version to 1
  bloblist: Access record hdr_size and tag via a function
  bloblist: Drop spare value from bloblist record
  bloblist: Change the checksum algorithm
  bloblist: Checksum the entire bloblist
  bloblist: Handle alignment with a void entry
  bloblist: Reduce blob-header size
  bloblist: Adjust the bloblist header
  bloblist: Add alignment to bloblist_new()
  bloblist: Update documentation and header comment

 arch/x86/lib/tables.c    |   3 +-
 common/bloblist.c        | 205 ++++++++++++++++++++++++---------------
 doc/develop/bloblist.rst |   4 +-
 include/bloblist.h       | 166 ++++++++++++++++++-------------
 test/bloblist.c          | 105 +++++++++++---------
 5 files changed, 287 insertions(+), 196 deletions(-)

-- 
2.25.1

