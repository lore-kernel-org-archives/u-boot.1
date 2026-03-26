Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71552106F2EA
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 08:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF0E83DA6;
	Thu, 26 Mar 2026 09:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fOaJYzN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA7483E76; Thu, 26 Mar 2026 09:23:59 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9199380517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 09:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-487035181a7so4038745e9.2
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774513436; x=1775118236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZblMf4m73cDI8hR+m/GG9JCwgb7d+VVs7DKO1uR+ik4=;
 b=fOaJYzN4Z+sx1CDXgvLGYUuOklTt+tgZj7/cintUT4NZ+GgLL+WqxLK1Hz7mOPF3el
 +SPgu+OPG2I/2dptW1uF8yfb23qzML2UDttWhSZvErrS/D9Ge8geteOtLBlIPwKd7/rl
 JoMremso4modvMH9D6YMv6FQOvY532oQ6AZcTtgfXGA/ryAi+ENIlP5rDXGPoPZ/FaHQ
 jdF++dKQmOYPdY0NJaO18dUDCiEfQqpBvnsSb/SkGOmNU0LrHztXUT+yAULZ1APMtzI5
 SL1rN9kxclr2QmIWnDUqWjeY5cbWf/qyJikOi4Uhh4jXf0Yas8+IBj3zsLsTIVQlCae7
 5qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774513436; x=1775118236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZblMf4m73cDI8hR+m/GG9JCwgb7d+VVs7DKO1uR+ik4=;
 b=Ze7x836ko2Ky+erJZPEYjtTn0K15W0i/vExM6vNQmRMJU1MVz5L3YN0tO6RDpG4ZQU
 TiBRofxGZZqH9AMDXv5lBVCgNZO2WIh2JJqgcDO/0TcokpQN4wE1gYyUM8lcPyIOtCul
 JZmyV8K4xC4LDalL+UG3WYYHN8OIOOWjrLHBl3yhe2fWxBT42fYB1jRqugGXQrxdf7lY
 2pF7mUKuPyMHlGQRved/Z8eel8ugYf3DPilcK3MIvnGS3Gs3kPGH8Trh6KSYKpSRwUUY
 MWPyUDpvxYNgtR7rsK5Zbb9AP6AaQ+NLaz9tIASBLHNOWVUCzCasm1ieVfi7Ea+NUjeW
 KYvA==
X-Gm-Message-State: AOJu0Yxp0+gK8San4gtlDDYWEIm0lMbhUk5LoIcxeU2ek1nEGXCaFvD7
 4O8EFsZJJHQCMVuiEBFGcUklujBpUD0trJV4lwu7VDQr+GJhCeicpLiiWhcuYiqn89FMZgb7HgV
 fKgiA
X-Gm-Gg: ATEYQzzHf6bJn7h+/A5lO2RySbaXLyhealSP8KWQlMHIQClmLt2WO1VZtjM0BTZ2kmv
 wXTZsJM+HJ5iCEYmTUU3ubhpWGZ05C+xhJBB6LfcIPB5LceNdeXoMKS79M2XWkLbUfoACX0ubbH
 65R+QRWSsQsSgl3TTSfCmZlVuNyqVcXWtjbcfxaxZQ3Kx6sXxAAvDAVQAxB9UVQT3W9ZEwWZDhI
 fWOyF2IRlisXnLx94LhnuJ0aTf4ZGfYbchqF8IFqn5i8Bk6gQLXmq+ukfbWbIHa8YBE+kFDO1Y2
 de6jb9vs+1I8Chz3scHd3c0eL679thgVQqjiS0TjDsqWEMOSVpWoNtYousG8a/+lQ/AOZpff2+h
 Wzxc1kNTy1+A98juLybTQQ1qadg2gmLcV+V1nN55faWnFhFiVwhkZrqTxZffkYH5k7KP2YqN+Mi
 ABtA98+JNBmYYh/yUnTocl6FhEBTdnOtv77YBH7vVowhHkSt1KpM3GvEKoODn6CouyKR/guhHyM
 ZQoUt5Ezy1EGMArqS4vRO4NWu1pxg2eAAevcx6BXMLOTogWvJPC46+zRDIWbUGOxYoXEnXhvUR7
 xPKT7USE1HCv3prLqfOsDRulo0R/ddDEpNvTh5VZmlqtl6wfH4+kC1ACo+J7OdNmsP2dnKfZEQf
 CHjVxTuYvZP3UxoV6C65CPWf5EmN34xvqOC+sQ+ElLG7QLuKkD/qyqydTaxmWokwBixA9QGaXmC
 ozvnCuI/qdvwtK3+Lav256W26ofuV3Q1PB/5h7sQrocTjnqTkHv3kC+2VIQQvR
X-Received: by 2002:a05:600c:870b:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-48715fb723bmr90810345e9.5.1774513435772; 
 Thu, 26 Mar 2026 01:23:55 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d2366dsm14854975e9.10.2026.03.26.01.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 01:23:55 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org,
	kory.maincent@bootlin.com
Subject: Pull request for fwu-next-26032026
Date: Thu, 26 Mar 2026 10:23:46 +0200
Message-ID: <20260326082346.1569343-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Hi Tom

Kory added a userspace tool to modify the fwu metadata from linux userspace.
Although this was originally designed to work with UEFI, there are uses cases
where people use it, but boot without EFI.

The following changes since commit 8813d74163e4d84dbd4fb30d9639f01c0acb6d39:

  Merge patch series "test/py: gpio: cleanups and improvement" (2026-03-25 14:38:28 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/fwu-next-26032026

for you to fetch changes up to 44a1e17b2a49d724538b4d500b27b0eda4be015c:

  tools: mkfwumdata: Remove dependency on fwu_mdata.h header (2026-03-26 08:20:00 +0200)

The CI seems fine 
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/29677

Please pull
Thanks!

----------------------------------------------------------------
Add a new fwumdata tool to allows users to read, display, and modify FWU
(Firmware Update) metadata from Linux userspace. It provides functionality
similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
metadata, change active/previous bank indices, modify bank states, and set
image acceptance flags. Configuration is done via fwumdata.config file.

----------------------------------------------------------------
Kory Maincent (6):
      tools: gitignore: Add mkfwumdata to the git ignore file
      tools: Reorganize mkfwumdata tool into fwumdata_src directory
      tools: mkfwumdata: Improve error message specificity
      tools: mkfwumdata: Add bank count validation for FWU metadata v2
      tools: Add support for fwumdata tool
      tools: mkfwumdata: Remove dependency on fwu_mdata.h header

 MAINTAINERS                           |   7 +-
 doc/develop/uefi/fwu_updates.rst      |   4 +-
 doc/fwumdata.1                        | 222 +++++++++
 tools/.gitignore                      |   2 +
 tools/Kconfig                         |   9 +-
 tools/Makefile                        |   4 +-
 tools/fwumdata_src/Kconfig            |  19 +
 tools/fwumdata_src/fwumdata.c         | 854 ++++++++++++++++++++++++++++++++++
 tools/fwumdata_src/fwumdata.config    |  33 ++
 tools/fwumdata_src/fwumdata.h         | 138 ++++++
 tools/fwumdata_src/fwumdata.mk        |  10 +
 tools/{ => fwumdata_src}/mkfwumdata.c | 106 ++---
 12 files changed, 1315 insertions(+), 93 deletions(-)
 create mode 100644 doc/fwumdata.1
 create mode 100644 tools/fwumdata_src/Kconfig
 create mode 100644 tools/fwumdata_src/fwumdata.c
 create mode 100644 tools/fwumdata_src/fwumdata.config
 create mode 100644 tools/fwumdata_src/fwumdata.h
 create mode 100644 tools/fwumdata_src/fwumdata.mk
 rename tools/{ => fwumdata_src}/mkfwumdata.c (79%)
