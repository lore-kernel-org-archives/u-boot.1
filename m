Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30031C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 16:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55CB0801DE;
	Thu, 20 Feb 2025 17:52:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uMdEp/IN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD0FA806FE; Thu, 20 Feb 2025 17:51:58 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54D4B801BE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 17:51:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5A97E3F27D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 16:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740070315;
 bh=aF4A6MRCz/IwK4fvOiUosiO28uI8WTgljO7mLSSHUV4=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=uMdEp/INBmd7yUwq/tKNyxJ8N/EU+NFel96j0fdazuhgU+CP2pMPhrhynGea2iJ0A
 +GQQG7WmCd+Md4JUS1vk2KF1uJCt11YOT9Mnt/eCKgK6cqCayXB147NXBDa7Yb24lw
 li+ZD8AtCCJnM9DVuOfj8CfE9U8leG1JqpRmm1jZfYL9GxmB9UTYCA7Qtn0im8SKCX
 9mzqQn7zm/Q+P+mTW5REecdC6kc7s/VJWhL3G9ptVpPq0PFLvs6MK5qyVDrqT4ZfDg
 i2fVpr7MA9eAjPyEcY5Ftm97aVwqcXBSgKTYSdli6lI53TWJAk3ADzQXbUEmgAAz68
 rrJ/DPWJwWmYw==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f4e47d0b2so566514f8f.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 08:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070315; x=1740675115;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aF4A6MRCz/IwK4fvOiUosiO28uI8WTgljO7mLSSHUV4=;
 b=pGi3xfqBgE21fHHQFMdImWJRCNf4I3kGlRAk7e3BPd9u4kLMaHoVtLyABpWhZVCZab
 unk3wFN/mLMinz0KSqyK9s3wF+uOiKV3d2suKRti81f1JOX8+ibKzj1B81KPzu4I8sqw
 7s6CXGsjTNHVTHj6YiKlpS+Fe43wVx/k6JQm9RLiObuTNVyjGke8k9OP1pIyQlJo/4x9
 RbIqMM69UT/a2T59/9wBoW/rukv9Z200gzA/UOLUrltO3CheOP2bj5eAr8+kAWAQ0Cd4
 8QLH9y1Loh+s2SzSmN3lfwlw8qqjULuCj6tJrCfL6BqecAD+BY43BgxD3Oy31CM3WOmH
 UVEQ==
X-Gm-Message-State: AOJu0YzOdNx9TM+XIAn6EvnnVCzM6nKXLcuKDFnpTD9TaF6RUofH55n4
 WHtH64KjEgwR+Z3UUC3kDS+7LxAWNCW7v73XmPTF7KyOA9xkrZL7T27enN/0Pxvabqsf+oUhKFS
 KM+P5O2L9gNTB3FjaZ3WPv53hi4WJ8SKmP9apfrGzN7hXkA/QBNWs4cXl8sTM30XeZro=
X-Gm-Gg: ASbGnctEiRrc6r3Pk8+3kI7qJN1AAJFgnYGh6zo6TbjIUIrNr0iWNYabatE8+8e1E9B
 b1KjcQXA0ihqydqWdLaWNRlMHZsOXtPvdBpKIurG4SNjUyLsJ/gmRIbhY6KGvP5puD6CbJbx1Tw
 Y3Wcod3OXXhILPIMK0dduTEPGYqdFQcg2eKsaZgqzIhIpeV1sfca+9mVDKGjoNCtlaB9J0bVm7o
 1OuvfMHsyKj/opmr7rmzWvAGX8ZqZmv+BDnBmNzUiL9Hcqi1qsitSU/xLe6K8sT6qpI2l2nfOce
 oKzWnARCi0fmseJZluQHUaD/4k7PpCQeyliCyWZ9M0Av40310MPY3YgDH6JqQS72tihQYjE=
X-Received: by 2002:a05:6000:1ac7:b0:38f:4acd:976d with SMTP id
 ffacd0b85a97d-38f58782b7fmr7100481f8f.9.1740070314935; 
 Thu, 20 Feb 2025 08:51:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDltFwzm5Lqe45v665VLQemb+7Ys9IplSvaWXsbM41Y2+RBPQBf7koCO+2/uAnA0CR12jUDw==
X-Received: by 2002:a05:6000:1ac7:b0:38f:4acd:976d with SMTP id
 ffacd0b85a97d-38f58782b7fmr7100467f8f.9.1740070314611; 
 Thu, 20 Feb 2025 08:51:54 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:44c4:a917:9099:bed2:ad3c?
 ([2a02:3035:6e0:44c4:a917:9099:bed2:ad3c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4423sm21461546f8f.11.2025.02.20.08.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 08:51:54 -0800 (PST)
Message-ID: <7e6c0c78-22f5-4088-8a6b-a7d179da67f5@canonical.com>
Date: Thu, 20 Feb 2025 17:51:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maks Mishin <maks.mishinFZ@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <Vincent.Stehle@arm.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Pull request efi-2025-04-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Dear Tom,

The following changes since commit 7a45cb4ffeff034304789954bb222ddd7d02104a:

   fs/erofs: fix an integer overflow in symlink resolution (2025-02-18 
12:32:07 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git 
tags/efi-2025-04-rc3

for you to fetch changes up to 5ce629db2512d70f298bc1d422fefad63a74c7f5:

   efi_loader: make efi_add_memory_map_pg() static (2025-02-20 11:09:33 
+0100)

Gitlab CI reported no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24709

----------------------------------------------------------------
Pull request efi-2025-04-rc3

UEFI:

* create a parent device for all EFI block devices
* move lmb_map_update_notify() to EFI
* make efi_add_memory_map_pg() static
* remove comparisons to string literals from runtime
* ix potential deref-after-null

Other:

* avoid superfluous value check in lmb_map_update_notify()
* support more efi protocols in uuid_guid_get_str()

----------------------------------------------------------------
Heinrich Schuchardt (4):
       efi_driver: create a parent device for all EFI block devices
       lmb: avoid superfluous value check in lmb_map_update_notify()
       lmb: move lmb_map_update_notify() to EFI
       efi_loader: make efi_add_memory_map_pg() static

Ilias Apalodimas (1):
       efi_loader: remove comparisons to string literals from runtime

Maks Mishin (1):
       efi_loader: Fix potential deref-after-null

Vincent Stehlé (1):
       lib: uuid: support more efi protocols in uuid_guid_get_str()

  include/efi_loader.h              | 30 +++++++++++-----------
  include/lmb.h                     | 12 +++++++++
  lib/efi_driver/efi_block_device.c | 29 +++++++++++++++++++++-
  lib/efi_loader/efi_disk.c         |  3 ++-
  lib/efi_loader/efi_memory.c       | 28 +++++++++++++++++++++
  lib/efi_loader/efi_var_mem.c      |  3 ++-
  lib/efi_loader/efi_variable_tee.c |  3 ++-
  lib/lmb.c                         | 52 
+++++++--------------------------------
  lib/uuid.c                        | 16 ++++++++++++
  test/py/tests/test_event_dump.py  |  1 +
  10 files changed, 115 insertions(+), 62 deletions(-)
