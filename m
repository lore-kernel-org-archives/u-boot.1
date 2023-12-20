Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FF7C46CCD
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D50F887480;
	Wed, 20 Dec 2023 09:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mE1PM191";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE42687561; Wed, 20 Dec 2023 09:43:30 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A26F86D4C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d7e67d31caso1897832b3a.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 00:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703061806; x=1703666606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=43+gv2p2GHulTOgc8tFKpwpojtR5eJ8s8aOYy2LkZ9o=;
 b=mE1PM191go52DYcDpOuu2cMd80vBKVnY6supbUUUGp3leuJNFxcaU/E341U3ygp+et
 uo0YaFhnqfdAANlpx4o7hp+qvUbjbQwzVQ4b9YuUv3qVEaQaMWhMpQDv+czfF3WOyDHr
 JkrhhFZrb6orPhOC1qWbgXFUL1lzFJLwIc0PL6KL+wwipZdJO038YPZIgh7bm6bPmwx/
 QI1R20tlJgxXQHuGS5kzFWKwlVTbTP/JRKO67FTv7KiKipm5jtOLVGIDzGbBU/f78+89
 QsQxGLhtfU0yokT4HZ1zHHGa71YwdWqiteZYMAiJWf86/TIMk0sqo9T9gUskwohyqMUB
 aBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703061806; x=1703666606;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=43+gv2p2GHulTOgc8tFKpwpojtR5eJ8s8aOYy2LkZ9o=;
 b=cfgyxdG54hSsPE3dmSME35kHsrnNB2f/qkbR6KNE8k/WUbZLGk0WSZagx4sMk6IvUQ
 DYrl9PfMDYA7tKsG8/FYkwtIu6XlFfDYSsWbUOPOEPsfS7s4teMj+iPu/DNCFLaMBOIS
 0m571RMe/ESIz/ezC2d6e9bjW20XmPxdjS/6eT1sHGthEFSjtLeEFjxVN+y+hM/FoZ8J
 LHSUiM/7VuULZXpapGmw7SHt8L6s9MZZ8ECSxIEmJrcPN/oBaxTTcoh3Qf3/ZgWIf/er
 37bmfh7FH+CizKRKA9dHQ2W0tgzk9A2IS7vKH6Z2MFmPDuWAGJkJk8KnpY4XMDp55o3c
 7xeA==
X-Gm-Message-State: AOJu0Yx0aYxims7CHNG2kWkx6C5JUp9Nmsq6zuEcc+hhRQuTTXrACVTa
 0L7m4H2i/6VnqZXFLi+t2gcaUKhj3075QqJ3HXU=
X-Google-Smtp-Source: AGHT+IGlkkpYtKdsYmxKxrEaVfzr8Yj2pRasKtYFqKs3lV9/Fm0roiEPpViVtsWCU52ki11T2J/x1Q==
X-Received: by 2002:a05:6a00:2451:b0:6ce:52b1:f9f8 with SMTP id
 d17-20020a056a00245100b006ce52b1f9f8mr11600519pfj.27.1703061806041; 
 Wed, 20 Dec 2023 00:43:26 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 e23-20020a62aa17000000b006d94206f846sm1431198pff.174.2023.12.20.00.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 00:43:25 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 0/2] fix auto-generated boot options
Date: Wed, 20 Dec 2023 17:41:30 +0900
Message-Id: <20231220084133.435240-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This series aims to get aligned to the EDK II reference
implementation for auto-generated boot options, and tries
to address the following issue.
https://source.denx.de/u-boot/custodians/u-boot-efi/-/issues/13

This series is based on the efi-next-20231217 tag.

Masahisa Kojima (2):
  efi_loader: auto-generate boot option for each blkio device
  efi_loader: auto-generate removable media boot option first

 lib/efi_loader/efi_bootmgr.c | 123 +++++++++++++++++++++++++++--------
 1 file changed, 96 insertions(+), 27 deletions(-)

-- 
2.34.1

