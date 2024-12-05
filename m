Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F46E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 10:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCEF89439;
	Thu,  5 Dec 2024 11:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MQOHxQHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50050890D5; Thu,  5 Dec 2024 11:58:07 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 104DB893FA
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 11:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa5500f7a75so108134866b.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 02:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733396284; x=1734001084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TB+QQ+YtaHxivyA1YBlOLFjNOSUJmYuZKWAtGFJcA88=;
 b=MQOHxQHQWf0gkTsxs7J97C/LqmVTqWp+55MCOVHhxVzcmUhmkVRMFcZf92HEJ8w3rs
 psFCZcLVWw5thBzo6IByyjNgxXygfwfWaN+HC10Mee1nqYqcpkTK7XbC3hQs7x3+Uj/B
 wTitloIrcFbZLW1xEtffqDpCXwh/n/ZMn3Weey1aHSO99C2G65TXvO2xQ4Yl2Fqoiw9a
 zG4BrJxq4sb88xle0xkJVIeXlKYfSUWx+9qI/TnkXDz/CCJG8G1xjTJvYZVl3gUxPIuy
 hQEQ9kjbYk+AIV6q4wAf4mIw0CpR7+L2zhRlCXFc6N5ynR6LIvCd8DQpDKQs6lVM2b54
 ayfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396284; x=1734001084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TB+QQ+YtaHxivyA1YBlOLFjNOSUJmYuZKWAtGFJcA88=;
 b=PX9S0/dZEZ6UKQbYkKL5bbCxOfp9kKU87slQus30mvXnl7tLJeog9s9R26jtKMP3fp
 tHK7Riauzl3glftmanWHGJZs8i/n9ZWMnIVmJPscwghSQV4z/xTFjyuE9L8hZIOUpZJd
 oCo+hA3fxp2SByzUcJ+mSgs12Tl42uM8HIdFVVD8Rc9d8+blG+nzpfwDitoDZs3redE7
 k6LmD9XdMPq4t0qwXqH+4pBT00GgpJXC4/qDpi0NYu8bi2m8olApcU2N8tqOoodcNV8J
 7pqcKpWldeMwxg7JMi1Cg1JxkNCPP+r9T99gU+Zu6WAJCMB1+pXHzPOAw9kuFPPCEUOt
 W9+A==
X-Gm-Message-State: AOJu0Yy7LHTGAavsljMUFtbszzgwpHLzyfrOiOWv+MeLON9QlTOMAdtJ
 nuQAzwNne5EEQas+YVdUxUT1CdOhxxfX6+xufq/ph9z+bFRiMWFFKYIkDqZ4hD9TS+cqTJq8QAp
 X
X-Gm-Gg: ASbGncv3CzGeKVivI0KOdw4snYjhN87HPLibEahmyqHBb7ZoXhQJJskJF70pdWPtpnM
 MyJ4z/igJfElgoyTvB+fYGBj0TX3wUiTZ8N64PiEObq5OQXdnrGSp6Y9YHRKOLDyjqx8IsaEb0D
 G36jCVR4EAEzSQCq3t0tGU9LIKP8gTpxZQa57gdHUUZ54YX/+U0a5MYPiAb1vEtFcVODRsPUULk
 DEW+097jtz706xwnFMTBS4ckPpg07r8+0kI7XhoqffUF1NdiuGQmBTcEuPTtcGMAdxAq0LRRJoE
 TGa+0+EzN4cXQyXIG/eQLvYbK0c=
X-Google-Smtp-Source: AGHT+IGBs8PeskKlgIjwyyXiaach705bIJgn5t6U9Y70d75GsZD8EPHNExjcO7bAMQODS+VgTQf7wg==
X-Received: by 2002:a17:907:948f:b0:aa5:308c:3489 with SMTP id
 a640c23a62f3a-aa5f7f4a73emr1013403666b.58.1733396284557; 
 Thu, 05 Dec 2024 02:58:04 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e5c764sm76241666b.20.2024.12.05.02.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 02:58:04 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: xypron.glpk@gmx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Subject: Pull request for efi-master-05122024
Date: Thu,  5 Dec 2024 12:58:00 +0200
Message-ID: <20241205105800.1953747-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205105800.1953747-1-ilias.apalodimas@linaro.org>
References: <20241205105800.1953747-1-ilias.apalodimas@linaro.org>
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

The following changes since commit f96e5133184aac377b54bd61f8abf78710f2ee56:

  Merge branch 'master' of https://gitlab.denx.de/u-boot/custodians/u-boot-samsung (2024-12-03 12:37:20 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/efi-master-05122024

for you to fetch changes up to 1d9aa4a283daa1e609130b5457c9857d62f1d1cb:

  lmb: Fix the allocation of overlapping memory areas with !LMB_NONE (2024-12-05 09:01:44 +0200)

The lmb patches are soaking in the mailing list for more than a week and
unfortunately haven't been reviewed. All the our sefltests pass though
and the SCT is fixed so hopefully I haven't missed anything. The change should
be harmless apart from some extra delay when someone is trying to allocate an
already allocate area with identical flags.

The CI at https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/23719
looks fine. Please pull!

/Ilias

----------------------------------------------------------------
Two fixes for the EFI subsystem coming via the TPM tree as agreed by Heinrich

The LMB patch fixes a failure in SystemReady testing. Nothing bad happens
without the patch in the device operation, but the return values are wrong
and SCT tests fail for MemoryAllocationServicesTest category.

The second is a shielding the device against mistakes in the definition of
struct members needed by the capsule update mechanism. Instead of crashing,
print a human readable message of what's wrong.

----------------------------------------------------------------
Ilias Apalodimas (2):
      efi_loader: Check for a valid fw_name before auto generating GUIDs
      lmb: Fix the allocation of overlapping memory areas with !LMB_NONE

 lib/efi_loader/efi_firmware.c |  4 ++++
 lib/lmb.c                     |  9 ---------
 test/lib/lmb.c                | 22 +++++++++++++++++++++-
 3 files changed, 25 insertions(+), 10 deletions(-)
