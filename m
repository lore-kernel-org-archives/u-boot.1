Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863BBCF394C
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1673D891F5;
	Thu, 19 Sep 2024 16:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pSOxR0HM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40055891FC; Thu, 19 Sep 2024 16:34:43 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62A6891F4
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f66423686bso7468301fa.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726756480; x=1727361280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xmYrBRX9MrKs/Z5tGzYaPyIUGqSEltbZ5DuvRIkB1iE=;
 b=pSOxR0HMGMcw3x381Y0wrB5+pp8EWHL15BKnepaM3C1w0WK5bB2Tp9h7Xak0I6Erxh
 2fgFfK6gGtq/YWI4wuQgimtk9U3DnBmxeh5XG0cUoywWZQFeRVLfvavhJMRZQxV2YlTY
 JoidwK7uidJomqkJXn7ilD8Yh4qa4a8B+Cp0nOV2i4pyRAGbI0fUD0YIj7bUWrEpV7J5
 xe8h0IlRl8qrr/xf/WWPI8ZHaz26nLfkBF03xfGfiE40pFtb7e2/fdr1cOSeZZqHyiAs
 lHX1OpWBK5rDrKtLJFx1w2zDXTXJxNuwjX3KIc3vGQjT5fAiLD+RSJjTjsQJ2N+ubrrU
 y+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726756480; x=1727361280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xmYrBRX9MrKs/Z5tGzYaPyIUGqSEltbZ5DuvRIkB1iE=;
 b=fICZ03wyFLuXGR+16oy3eGXjGW9HKFNyBASUz3waAg5RXwwIpCAhIbRmnTl153de2p
 uxxv4B+XIPfpJ0J3c2n97RsVmfaGaaDTVI7quvTHyAdriFYIvfZqwsu/x0/xhtdf6YBo
 VObvQfXWVuHqjP6pPCKe+w6mrGyWAVq/X6jAcbO0y51HgUTjgbklg9k8UXdanW4Unv40
 l7IybwtfeqEumD8T5FOv4daQF5DxhJo2NVAC8oebVF57WexHE1Bc6Ri2RfX0ouflNohP
 ylCneCNrjSW5Gj5lGODGBpAXwNX5c7t2iOWgBd1iag+9lS6cbtVAESEttoakBk3mi+Zy
 LOUg==
X-Gm-Message-State: AOJu0YyWjeG6HYCLQWE+yGmRXGxZ/nHmzqdUxA3KsupafWFfqyD85L4u
 b4gvioa1rHA8MhWbiNdBQxRJtlNXNbFpNn6uLi0iKKQoNVEed9j9kSRnMLlxf8p2v4DYph+DO94
 a
X-Google-Smtp-Source: AGHT+IFrtbKDhNB3L8L/DAtU1TB05eYNXDf8Hd8QFMqqnC81t/2u/g9ZntJYBillXDBohMLfTVEyUg==
X-Received: by 2002:a05:6512:304d:b0:536:581c:9d9f with SMTP id
 2adb3069b0e04-53678fb7326mr15348437e87.24.1726756480015; 
 Thu, 19 Sep 2024 07:34:40 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb4971fsm6120835a12.13.2024.09.19.07.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 07:34:37 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: michal.simek@amd.com,
	sughosh.ganu@linaro.org
Subject: Pull request for fwu-next-19092024
Date: Thu, 19 Sep 2024 17:34:35 +0300
Message-ID: <20240919143435.209455-1-ilias.apalodimas@linaro.org>
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

This is a PR for the firmware A/B updates going via the TPM tree.
Sughosh and Michal have verified and tested the changes.

The following changes since commit 650883a568653f37ee4ff43beda56152b594a49c:

  cmd: osd: Depend on OSD (2024-09-16 16:46:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/fwu-next-19092024

for you to fetch changes up to 6f933aa963bb971d848ff6bd1c743035bbc98ead:

  fwu: print a message if empty capsule checks fail (2024-09-19 10:52:50 +0300)

The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/22364
showed no issues

Please pull!
/Ilias

----------------------------------------------------------------
This PR contains various improvements in the A/B update logic for EFI

- Read both copies of metadata, in case one of the is corrupted
- Check the metadata version against the running firmware to make sure it's
  allowed
- Limit the use of a revert capsule if the board is on a trial state and
  make sure it's not applied if the max counter has expired

----------------------------------------------------------------
Sughosh Ganu (6):
      fwu: v2: try reading both copies of metadata
      fwu: v1: do a version check for the metadata
      fwu: check all images for transitioning out of Trial State
      fwu: add dependency checks for selecting FWU metadata version
      fwu: do not allow capsule processing on exceeding Trial Counter threshold
      fwu: print a message if empty capsule checks fail

 include/fwu.h                | 11 ++++++
 lib/efi_loader/efi_capsule.c | 11 ++++--
 lib/fwu_updates/Kconfig      |  1 +
 lib/fwu_updates/fwu.c        | 31 +++++++++++++++--
 lib/fwu_updates/fwu_v1.c     | 18 +++++++---
 lib/fwu_updates/fwu_v2.c     | 81 ++++++++++++++++++++++++--------------------
 6 files changed, 108 insertions(+), 45 deletions(-)
