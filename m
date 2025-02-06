Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BF9C02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 934F780BAD;
	Thu,  6 Feb 2025 18:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sb8qB5Mh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F3380C65; Thu,  6 Feb 2025 18:40:34 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D3B180A55
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:40:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso30528895ad.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 09:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738863630; x=1739468430; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XBGOTrDTR0oxa7+dYCHTcy+GuxwbmbF6Cwu3ecbb9tQ=;
 b=Sb8qB5Mho9UnGNlIIuRrXnxLSHFPtjDGQcQ//YbtMBAgHAZZqqbVf5AwgKmxCiyA8f
 /MGN2bY7nAabzF3RFgBEJAMAHbBV5V9somF782qFF56giqeKZePLK50fiXYVRBoXOseI
 PAdRl6171R+oqrzbplPxiewLGyO1zT2+/59vocd+pxxG3Y8+xmwQOpah/mAhgiFLNBoo
 UCBroLLNoDNevXbql6uowasrtY9nrAjpSJg7bygIKy4/AYWZWApdfsrGauYBtu+tQQMz
 QHfCz/Lk/jVeA5FJFVLGCQoPYqrIQmT98Qr0K6chhe+23R5OmNGSSrLT+3SHouNq0Q5R
 Pi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863630; x=1739468430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XBGOTrDTR0oxa7+dYCHTcy+GuxwbmbF6Cwu3ecbb9tQ=;
 b=r5U3uvJSb7kWFw4XXREMfii+PZgCTJYi+Ebs8DSZp7pXzVQOfEz4OUOdSnW+0fvSdv
 NfEeTXmtMbq6zAp2IgeLOPZ3J4rQNrMcN/cWax3oSV+sWs2bx6oe974ArNC4AuDbkjWo
 JOTSTBhd9xwdp+PXXoio3dQ1ycjlqwOz+qT8KWb1q6u/tQuHFbtB3xEzyROt2TonuxKe
 kWa3dfR7qBHs4KS3tfkDrCH5F6AJfE5O2rg2Es+9Exn2JowpcnizRA3vEyVtcEOC6shW
 PtGdEds55N+AziPW418WPTGjEleJhDtgiw+33JFfj6K9+ZcCay4QpoCW+3a1SiZ+dM6S
 4srg==
X-Gm-Message-State: AOJu0YyGBREuzmd2HVIJeO+qxKE4bjLBIHlaRmsXHwt2RuJkPjgBDKV5
 sVkqFUjDji/jpxV8u3lXsbdRyvhuM2E7RQ3KT+lW2x4XTqrFzaDQ659Vm+dIVhqB+Q==
X-Gm-Gg: ASbGncvasiuvkH5rKleWsf4HLCiCKXQOthAsiJ3Ixy+eWyZDfMEOiGIhjA1+srzDvPJ
 LO/8IedIHhusEBO3MTep5pEQWNmbXdjOfjIO6GvKxcHFrFXw0/SsNtfzf6JZkRtXOeN/Pp63Yyw
 c39lkUR8vRZemXm7BdaLy6ixjEYtf1SmDTyXfmj4JQE6tZh/+pvn29AK4EhlcvwZ76yZEzgCBZ6
 s2/Y7hj/mxKw6G9R2jT8SWKGTd4vSBvpFAYtqzPn9EunD1mw8wZAsU0HA5scUo+dqnPRPAYYKy1
 hinOzMYLvEr4ThqMoIDe7Xh+
X-Google-Smtp-Source: AGHT+IGdgVQciTGGym9GnESE5iXSDTkpOvoy4zKsjh+02lk7t201nWYk+EF9HJf3K4uqibeimxwTSg==
X-Received: by 2002:a17:903:2346:b0:215:7421:262 with SMTP id
 d9443c01a7336-21f17df5870mr145265125ad.12.1738863629075; 
 Thu, 06 Feb 2025 09:40:29 -0800 (PST)
Received: from adriano.. ([191.119.55.28]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687c31asm15476615ad.167.2025.02.06.09.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 09:40:28 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 0/8] EFI net driver - series 1/2: Support multiple EFI net
 objects
Date: Thu,  6 Feb 2025 14:40:10 -0300
Message-ID: <20250206174018.465530-1-adriano.cordova@canonical.com>
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

This series adds support for multiple efi_net_obj structs in efi_net.c.
The EFI network code still only registers one efi_net_obj, corresponding to
the current ethernet udevice when EFI initializes. In the next series the EFI
net driver will [de]register ethernet udevices in the EFI network code at runtime.

Adriano Cordova (8):
  legacy-net: wget: fix wget_info handling after new tcp legacy stack
  efi_loader: expose symbols to be used by the EFI network stack
  efi_loader: efi_setup: Add efi_start_obj_list() to efi_setup.c
  efi_loader: efi_net: Add efi_net_do_start() to efi_net.c
  efi_loader: efi_device_path: Pass net udevice as argument
  efi_loader: efi_net: Add device path cache
  efi_loader: efi_net: Add dhcp cache
  efi_loader: efi_net: Add support for multiple efi_net_obj

 include/efi_loader.h                |  48 ++-
 include/net-common.h                |   1 +
 lib/efi_loader/efi_bootbin.c        |   3 +-
 lib/efi_loader/efi_boottime.c       |  21 +-
 lib/efi_loader/efi_device_path.c    |  26 +-
 lib/efi_loader/efi_http.c           |   6 +-
 lib/efi_loader/efi_ipconfig.c       |   4 +-
 lib/efi_loader/efi_net.c            | 577 ++++++++++++++++++++++------
 lib/efi_loader/efi_setup.c          |  27 +-
 lib/efi_selftest/efi_selftest_snp.c |   1 -
 net/wget.c                          |  18 +-
 11 files changed, 572 insertions(+), 160 deletions(-)

-- 
2.45.2

