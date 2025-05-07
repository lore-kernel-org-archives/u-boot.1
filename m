Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF60C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 14:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 406CD81F32;
	Wed,  7 May 2025 16:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NygcxD/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E83082153; Wed,  7 May 2025 16:45:38 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C31B8059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 16:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7fd581c2bf4so5965840a12.3
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746629134; x=1747233934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eMSzGU8S9RGI8y2e8JyCqhaC7gjUwPadKwLb3nt9BgE=;
 b=NygcxD/LOC3sHFucdnpsEgB/xIBEvPfxPCvGdJ9JpWufthwh8S18489aXCeEVycCtc
 /Dxyik1yCxQAQiIGxLWF3Gs+AZrIc7ckXJ2hTvCl3KyYVQhBBu8mgfjFqNuxc/uer1AI
 hgqeD57l6dpkLyfeq9XuzGCvhgGSc03PE4P7dKTwEKxNWyXt7UqyvpxDrphBOnF868qJ
 iibb6Ob+kf6ZRtTM7N9JVLIqybaJP3yV4m0muTkbypu+e/SI7RwuLCb+yxA00ro2AhsA
 VWQFUpwU9DIErHCKlxdZ56Ahalt5jyrGHBOhdU0UNqHoAxQWamDr2qdgXavTKb9F7hDK
 xaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746629134; x=1747233934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eMSzGU8S9RGI8y2e8JyCqhaC7gjUwPadKwLb3nt9BgE=;
 b=OdAOQYY672i0kMT1HyY2s2+VD2Rnrkd7sX4z9iruBI8ZCEKvsx2aySBpL3oO0DLYDA
 7rxeYW7WElNZSWFKwNNbQcT/XmzRAtEEmfB1TSCklwhSMqhhldexLwioZip3eHWUyKwI
 5RGo1mUz519F5UbB4NNg1YJG8RB+H9diO0r9UkpFhqV4OzdGE99U495jcGdXgbDDYF0P
 nGkvVgYbygtOV5/8prJiawx9d/JLN/1b3u8IUKqoG+2DRfcS7RcrCo/cQMH43ivin2mU
 6VqAIXcdfo9mCupoBC2uV/21anCH+MKqMkMSBAAHR2G8nC8SnnYXhR4nVmNzibewTKWA
 CgbQ==
X-Gm-Message-State: AOJu0Yx7Lj4mb5wPk5Q/vFQeEvKeu5gcCrbMfeYz/S2iYzgPrpqsSdtP
 Pi4KZbfPN8yxyAvB1w9z/cYOW6+von5wbS+gMWxuhvgPEGYow4Zp0x3uIsfRUIs=
X-Gm-Gg: ASbGnculu24MbkPpHI+GGRC8Jf/5ZQC2IEJJpsmO5qtPuI9Cu/By8e2BHFkF26wNxb9
 p82rKWOzmf4nhDsnbQ1FNSGW+xhdN5mr2CNmuY6aUavpQAOEtoYkh6zcy62iGbVId7LO6oaEQrP
 PGOumGVuArK1OrBLkiRfACY5NLjoPGZhN6C27LsiWuGSjqT2LmtnyFT6reEZwg7SVX5Vk1sdYqO
 1pS8/FJxAmDlcIFR+yywdxG6RpfgbT4HSeWbzPkNqlGaRkWEJa3IjgA2PNJ7rgAQr/USQoRlvMI
 8PhrsNPJCAdGhrxIWmFAINscvOtW5qwV1ZoZaRjerR84xX0f2w==
X-Google-Smtp-Source: AGHT+IF1Oxqm7eDFSXlNEsls5uDTKedwn4fVUXtR6a4co09H3FAzq18MBPegmR+4i7tcaPYhjZt4uw==
X-Received: by 2002:a05:6a21:e95:b0:1f5:5b2a:f641 with SMTP id
 adf61e73a8af0-2148d024847mr5602601637.28.1746629134296; 
 Wed, 07 May 2025 07:45:34 -0700 (PDT)
Received: from adriano.. ([190.215.87.40]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7a30esm11710235b3a.13.2025.05.07.07.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 07:45:33 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 0/3] efi_loader: test EFI booting FIT images with initrd and
 dtb
Date: Wed,  7 May 2025 10:46:16 -0400
Message-ID: <20250507144619.3288456-1-adriano.cordova@canonical.com>
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

Test booting a FIT image with an EFI kernel and either a dtb
or an initrd. For this, some changes to dtbdump and initrddump
are needed. test_efi_fit creates a test image as follows:

- helloworld.efi as first "kernel" binary
- dtbdump.efi as second "kernel" binary
- initrddump.efi as third "kernel" binary
- a file of known CRC32 as "initrd"
- a device-tree with a known string
- configurations for each of the "kernel" binaries.

Then during the test run, each "kernel" binary is run. For helloworld.efi expect
'Hello, world'. For initrddump.efi, use the load command to check CRC32
of the initrd. For dtbdump.efi, use the dump command to check for the
presence of a known string in the device-tree.

Adriano Cordova (3):
  efi_loader: initrddump: use efi_uintn_t in printx
  efi_loader: fix dtbdump output color and format
  test/py/test_efi_fit: test fdt and initrd

 lib/efi_loader/dtbdump.c      |  86 ++++++++++++++++---
 lib/efi_loader/initrddump.c   |   4 +-
 test/py/tests/test_efi_fit.py | 156 +++++++++++++++++++++++++++-------
 3 files changed, 200 insertions(+), 46 deletions(-)

-- 
2.48.1

