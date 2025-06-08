Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59B9C5AD49
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 07:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA30811AC;
	Sun,  8 Jun 2025 09:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="O6PabCLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E188811AC; Sun,  8 Jun 2025 09:54:40 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3491D807B1
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 09:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 849F93F659
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749369277;
 bh=afv5GMOuSK7vR0GxB4W+gER0JOqgVE2ZrCVoKtXPlVk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=O6PabCLuv6LKBqzKZdPvfOn8hb0/qKUQpdlTimWgHKCKzBxj1JDy3/KU5Go4swsu3
 0KPjms0kCmsIIANurYtgfFEsWjjYhFIhVa7vmfVEDr9us0aXTjCZy6dDMLcivEn3hT
 FTVAwMeIZ9FbCLdTeoGbQJuAnM7Puo1idHHiMzS7nR+JaNICYhyxkIRS8DrS1HcMBs
 m/eecw1J+32lHafI1+tZHuXBOAikoLepLkX73i+0hnUZ4jRrsz+NIMJgZr7ZicJB60
 IIMStDy5kmfHxZo7lk+QiMjpux8IcmWQUbCVczn3A/jzNl0lRANRhwWWERoaodK4ZJ
 MMpIuZ7Cu+XIA==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-acb8f9f58ebso258611566b.2
 for <u-boot@lists.denx.de>; Sun, 08 Jun 2025 00:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749369277; x=1749974077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=afv5GMOuSK7vR0GxB4W+gER0JOqgVE2ZrCVoKtXPlVk=;
 b=mYMXXL6ZlZZEXWhYbVMTAO+Z/k4QJiMJhE+2BSnragkKlpv5F2jPROkwqRTrlAad1O
 PuYtuDzBkSflLJXdZOpIp+kBZNCEtZOfgeCJV2KzQNbN4owGg75YJk+XW7qYqrAtfjOy
 mJ1tK/f54MrF4ILoF3j/PNO/s+OdAJ6Rebog1fl1swt8YrL/Ilih689kM/osvzSZ++Hx
 YlaiL7Jwd/rjpwPoaQReQiM5E1F+DJk57CA2t/7PXb1oOOs4RL75YOU0B60pEy1Kq+hJ
 QAG9KthOWujOuE/mpYKWDCIbA9LjyFlT1haRbWctQehI0E0UlJJy5xBRMZwQ86/BP3uF
 no2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0bgsiNmp9+qvsfNHXWXcSgWH64ENj6TN39qxKW4uDHJ0NcDHQX5vxsgmtUXE8x24+fFOxKXE=@lists.denx.de
X-Gm-Message-State: AOJu0YzjQ0j2c6F+RKYGZecDJXi4t2H+irROCdI4HAQ5nx+RD5SrcAT+
 uhqqJncZMLmQxBWaonu/1JqyRypHUsFIsh4BW6PoFQhTnoJTjtvtBicP/10zTJXthKACcdJttE1
 LnacANgvYl2zkSgBKrZn0Y+MM7pXYJrnTO/gAeLvSCN+KFPoP/rzRI3pIPfWwz2jfiZounMM=
X-Gm-Gg: ASbGncvQQUPpNs9ALbsa4BhVnPsEhxQKD56bxJRAyYUtNLUsuAPYoTkri4Dcx0DkJPz
 LnQhcuDXb9vpdUD68rlJ7LCJAFz23z8KMZu3nvGVQu8ufxbQMnwqvjo45TsrPzI9FDwRwf1X4HR
 b70162OFCLXe2DHcRdjSUcdvCzIE2+GWoe4lvwTBY+glBTOcgvZ7GJ634SL6mpqju15NJXOBspC
 jWPt/xxJfpepfYATRR/qNgEOfWxM92wXo235UoTN154OD7pO9j+lYo+VfRooT7YYc20eD7tSBK8
 /Rl8NK60cfCNqqy+jS3XxYmdR0uZVhSmGDDFMQ0Hmm/9MMNjMWMAto6upya0aRp0hFLh5PXwO0o
 oOyl4wX3MaHpudN4HBLbjtjy2
X-Received: by 2002:a17:907:270b:b0:ade:31bf:6122 with SMTP id
 a640c23a62f3a-ade31bf663fmr472810466b.25.1749369276724; 
 Sun, 08 Jun 2025 00:54:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEceLZCbPcM38VuPVKJ6ItATXwCrK7YvRt/o2ly4uQf7sjycg6xSSATef5C2RUqkQ9HLx+JZg==
X-Received: by 2002:a17:907:270b:b0:ade:31bf:6122 with SMTP id
 a640c23a62f3a-ade31bf663fmr472809066b.25.1749369276274; 
 Sun, 08 Jun 2025 00:54:36 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade34ea5adesm270956066b.80.2025.06.08.00.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 00:54:35 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>,
 Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ying-Chun Liu <paul.liu@linaro.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/3] sandbox: align LMB memory
Date: Sun,  8 Jun 2025 09:54:25 +0200
Message-ID: <20250608075428.32631-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

To implement the EFI_SYSTEM_TABLE_POINTER we need 4 MiB aligned
memory.

On the sandbox LMB uses addresses relative to the start of a page aligned
RAM buffer allocated with mmap(). This leads to a mismatch of alignment
between EFI which uses pointers and LMB which uses phys_addr_t.

Ensure that the RAM buffer used for LMB is 4 MiB aligned.

Provide a unit test for efi_alloc_aligned_pages() verifying this alignment.

Do not overwrite RAM size in dram_init().

v2:
	rename define CFG_SYS_SDRAM_ALIGN to SB_SDRAM_ALIGN

Heinrich Schuchardt (3):
  sandbox: fix dram_init()
  sandbox: align LMB memory
  test: unit test for efi_alloc_aligned_pages()

 arch/sandbox/cpu/state.c         |  6 ++-
 arch/sandbox/include/asm/state.h |  1 +
 board/sandbox/sandbox.c          |  1 -
 include/configs/sandbox.h        |  2 +
 test/lib/Makefile                |  2 +-
 test/lib/efi_memory.c            | 63 ++++++++++++++++++++++++++++++++
 6 files changed, 71 insertions(+), 4 deletions(-)
 create mode 100644 test/lib/efi_memory.c

-- 
2.48.1

