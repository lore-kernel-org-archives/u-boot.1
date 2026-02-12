Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A9DEEA84E
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 20:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9BC8367F;
	Thu, 12 Feb 2026 21:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="g2p22i4Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F5BA83C4B; Thu, 12 Feb 2026 21:45:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D8583015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 21:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770929117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5wGpqACDAjbZGDKRtj31kelCkKX/rhXzBPZAIKXqE1Y=;
 b=g2p22i4Z+X8kAoQHEPhyJcT3HI3sc1cBBaO8lt0mO1IE8nxBGPnHesKML+oxcuOsxoOn9h
 4YHFXKovogpA2JVa1h9+TUh1eL5GPFXG8KefUYBLU10cT8hKbXYJAOSLtdLzbBPGJ/UR42
 ZVJNiOWOORZsVRTi3KT+WFVNLbTxTfo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-swVkNCRzMy-KEEazhWjkDg-1; Thu, 12 Feb 2026 15:45:16 -0500
X-MC-Unique: swVkNCRzMy-KEEazhWjkDg-1
X-Mimecast-MFC-AGG-ID: swVkNCRzMy-KEEazhWjkDg_1770929115
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4803b4e3b9eso1628305e9.3
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770929115; x=1771533915;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5wGpqACDAjbZGDKRtj31kelCkKX/rhXzBPZAIKXqE1Y=;
 b=mFLzB5Q56CmZQEqSuAGlicFQ1zFIHxIirQEF6HsvJYlJvNYXedsAYKkJ/LZng3fm3u
 Z9bKB6giymjS0JviUBUAgsrF0A3FF/EV8OWEluvPbwegbJ8Eq1GvArXxWlG0+jVuk2uL
 JbqB6X5N3hyf948PIcwUhy995380sGghyY7LTzBL1TJ3yH9CsoGVkGyFeU3rOLLPy8Kb
 cBwI1wu9DHmc9uzRCW67Dbvzc7/oxN/J0wcs2xHIv6DH2liBD7/F5bjN7W0mqXR+OOk5
 M6Fj+lmF/uHIaC1Y6iilZW2Yf/2IkwD2JwM44y1BnX7/6YFGpOeOdAv4qdBRaGiQuwAl
 z9ug==
X-Gm-Message-State: AOJu0YxqEaCUHT+bEKaIWCrTztj7/KQ85dZYOV/az0r5GKCw3Njy+ZkY
 h86Df/t2QAGf75zxY+QbIiRU6YVyks4Xh1OI7bbQ89m2DgXqPycwPWXCrd3gO1+SOZpN3UDzk9F
 vWITELLnZCdksdjozK99oTfkpP2Qxp6zyazF5sTAU1gO/o1QABDqe3vGa6RYQ3oDCvq/lOIW0EI
 Xe6xRuT1jyGRYlNJW5PjOptu2jhaNoNQ0wJEUfFA==
X-Gm-Gg: AZuq6aLdfdHAqJ1/walTvAIqrzq7bRD/SZkJ0dLaRT+6CPBINvD3bWmR1ufvPmobcys
 9cBZrlZ2ZfZNAWPXZ9ktlgulGGjNihcaE8tm5fUdPhpyx17m4CfvMZT8P9tY2OTAHkwjb2StKqZ
 uVXIYBCFytNKu+3xh+3L8e/9zlM7pVUAPE2TcMBe7zsmOlCmAOOn6FMCyD13IqlOVqOedJ6uY27
 SZNkf0nF1DGu4AcGtN8qU2/L/xnwoIstjPSzBDmH1ZZZyWE+fzLekFnbD8MBmlO4ytVYYZQJQTe
 1u6uVgmW7HPV8at/9ZnIwCyc1iARmSrvTT6FQDICwChpv7S5MQN6OvCId+2zI66fdTuYPhat0oX
 Hf0S/lNVEySHxpS+CoIIlTce8hAf4vxx0t4exiK7anbTwwe0=
X-Received: by 2002:a05:600c:46d3:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-48370e186c6mr7142475e9.5.1770929114647; 
 Thu, 12 Feb 2026 12:45:14 -0800 (PST)
X-Received: by 2002:a05:600c:46d3:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-48370e186c6mr7142045e9.5.1770929114119; 
 Thu, 12 Feb 2026 12:45:14 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6c1bfsm427395f8f.13.2026.02.12.12.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 12:45:13 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, eballetb@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Javier Tia <javier.tia@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v2 0/7] efi_loader: disk: Add EFI_PARTITION_INFO_PROTOCOL
 support for MBR
Date: Thu, 12 Feb 2026 21:44:54 +0100
Message-ID: <20260212204511.619392-1-javierm@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8fyygmLkyqRizy2arlcNhsbTgR0Qj_sVPWbV5u4rq5Y_1770929115
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This patch series extends the EFI_PARTITION_INFO_PROTOCOL implementation
to also support MBR partition tables schemes.

When EFI_PARTITION_INFO_PROTOCOL was implented, only GPT support was
added but this can cause compatibility issues with platforms whose boot
ROM only supports MBR. This series add support for MBR partition tables
to the protocol, making U-Boot compatible with systems that require a
legacy MBR table.

This is a second version of the patches that addresses issues pointed out
by Heinrich Schuchardt (thanks!). The first version can be found here:

https://lists.denx.de/pipermail/u-boot/2025-June/592644.html

Patches #1 to #3 are preparatory changes to remove duplicated definitions
of data structures to store the MBR records.

Patch #4 just documents the part_get_info_extended() helper function and
patch #5 refactors this function to also optionally return the MBR record data.

Patch #6 adds the MBR support to the EFI_PARTITION_INFO_PROTOCOL implementation
and patch #7 enhances the protocol selftest, to check that the partition record
data is correctly filled.

Changes in v2:
- Add Tom Rini Rini's Reviewed-by tags to patches 1-3.
- Document part_get_info_extended() helper function.
- Split partition library and EFI changes in separate patches.
- Add static MBR data in EFI block device test and compare the queried data.

Javier Martinez Canillas (7):
  disk: part_dos: Move header to the main include directory
  disk: part_dos: Align dos_partition_t with struct partition
  disk: part_efi: Remove redundant struct partition definition
  disk: part_dos: Document part_get_info_extended() helper function
  disk: part_dos: Refactor to allow retrieving raw MBR partition data
  efi_loader: disk: Extend EFI_PARTITION_INFO_PROTOCOL to support MBR
  efi_selftest: Enhance MBR test for PARTITION_INFO_PROTOCOL

 disk/part_dos.c                              | 91 +++++++++++++-------
 disk/part_efi.c                              |  4 +-
 include/part.h                               | 14 +++
 {disk => include}/part_dos.h                 |  6 +-
 include/part_efi.h                           | 19 +---
 lib/efi_loader/efi_disk.c                    |  9 +-
 lib/efi_selftest/efi_selftest_block_device.c | 26 ++++++
 7 files changed, 113 insertions(+), 56 deletions(-)
 rename {disk => include}/part_dos.h (87%)

-- 
2.53.0

base-commit: f9ffeec4bdcf1da655a0ffea482062adde78fee8
branch: add-mbr-efi-part-info-proto-v2

