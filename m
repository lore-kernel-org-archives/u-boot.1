Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E596C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987AC88373;
	Mon, 24 Jun 2024 14:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pl6m1Anp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191668837D; Mon, 24 Jun 2024 14:30:03 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D0D88352
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57d1679ee6eso7507713a12.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 05:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719232200; x=1719837000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wz02stMUmFXTnSqOU5Vo0c+9S//NEJ+GguEM/spMUYQ=;
 b=Pl6m1AnpYzAKAPFjq2BH9/EsYWGZZS2hjdP5vGWVPrpJI1KsvXWbqMLcZ9WfjhEnmH
 Y91nQV97HtcNXAwAPi6UX9axUGOsV1w6cf26U6XU0UFEDHEMPZ3cD0uAYKr9GOLC6i7Q
 TGDdkxVt5gA0mIdYvOZGgFAYT/HOaTWt14Lgy2XL2iIH5eS68Hmot1hMdRzE3NwWniX9
 fnm0bmKD60Z22FA+6b/jjmsvzso/AIljA56NLmZGVMOGEYNQyu+xuXXEPWvrZnIW7ONf
 vL64yCJRVXzPYyPfOtbPcCkdAfbYEX5BuNks3iqkSNQsyc4x8vtZKC7x/fHW+poLlht9
 G2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719232200; x=1719837000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wz02stMUmFXTnSqOU5Vo0c+9S//NEJ+GguEM/spMUYQ=;
 b=S4DxrfjQ5mYBVWAZJBttWVpy15IAjxBEewFpprdgfNNPNqMqvSOG2zdRjYeuav5hGw
 AWKbp2XE50nc5ydlCwPauSb/LYGsNlrWC3FK7svgfGc/M/y9HzuZn/q2srDhFSErgMY2
 iwb+ZyHa/FXD7AXrd1OoQrHvQVu2p88wzWLGAmmA9pAxPwrQqaBJJEGHJf8BpbY6MxHv
 C5BUDP1WGR95dmLaaVKufb5ywccbhina4Cn2xio+dQjyDxDH2HtEafYiUFRPa0UG95P1
 RBK+z8zeRGxM3qFpqn3zCkjigbzR7lMjlmplR11RWXC8wjQmLdo38cFpxc2hrYkMT0gA
 PhLQ==
X-Gm-Message-State: AOJu0Yzv1k8TMmHWwlLY9PXFflLPLFD3lCpdm5yrQjzMy5awfRUTxIdW
 39iv6ygK/PvCX67pezcprJqS5oJgAcPnfuPHMjXTVnNT98gK2uHPJIr36ucRw300ki4yVeNeVFZ
 RiW8=
X-Google-Smtp-Source: AGHT+IFC0751In47rkQSa5+tabz1Yd48sUV+O3KpZbB+S+e+5vtMRtQd3fLxEpiFFk1/d2DoqNsYwA==
X-Received: by 2002:a17:907:c089:b0:a6f:9e2d:6b57 with SMTP id
 a640c23a62f3a-a70275ea626mr455745066b.4.1719232200017; 
 Mon, 24 Jun 2024 05:30:00 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf56ea09sm402142366b.201.2024.06.24.05.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 05:29:58 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: sjg@chromium.org,
	xypron.glpk@gmx.de
Subject: Pull request for tpm-master-24062024
Date: Mon, 24 Jun 2024 15:29:56 +0300
Message-ID: <20240624122956.5739-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Hi Tom,

A few last minutes fixes for EFI, but this time via the TPM tree

The following changes since commit fe2ce09a0753634543c32cafe85eb87a625f76ca:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-watchdog (2024-06-18 08:34:56 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-24062024

for you to fetch changes up to b73948c785d2bbccf0a76dec92cf50fe5b408c0e:

  efi_loader: fix the return values on efi_tcg (2024-06-24 08:38:06 +0300)

The CI is here https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/21309
and showed no problems.

I also tested measured booot looking at the EventLog pre/post patch. No changes
apart from PCR0 which is expected to change

----------------------------------------------------------------
When the EFI TCG measurement code moved from EFI to the TPM subsystem for
general use some prototypes changed from returning efi_status_t to int,
which is more appropriate for the non-EFI APIs. However, some of the
EFI callsites never changed and we ended up assigning the int value to
efi_status_t.

This is unlikely to cause any problems, apart from returning invalid
values on failures and violating the EFI spec.

----------------------------------------------------------------
Ilias Apalodimas (2):
      tpm: fix the return code, if the eventlog buffer is full
      efi_loader: fix the return values on efi_tcg

 lib/efi_loader/efi_tcg2.c | 126 +++++++++++++++++++++++++---------------------
 lib/tpm-v2.c              |   2 +-
 2 files changed, 70 insertions(+), 58 deletions(-)
