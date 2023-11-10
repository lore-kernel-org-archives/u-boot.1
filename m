Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C231C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 06:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BEBC877CB;
	Fri, 10 Nov 2023 07:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="XumotW3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A47877BC; Fri, 10 Nov 2023 07:00:08 +0100 (CET)
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com
 [IPv6:2a00:1450:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B84877BF
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 07:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=34cZNZQkKBtY5AEGJAFFQ8GG8D6.4GEM-3GGLDAKLK.56FP.56@flex--dimorinny.bounces.google.com
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-32d9cd6eb0bso898080f8f.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 22:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699596001; x=1700200801; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XhWK0h8MvpYq+nhVIsF0ozJwaZz611Hgl5A62HRk5hw=;
 b=XumotW3NcYEP5+STURKGzyDVFHtxybcURToqaNzLmA24lWYz0BdFV8XoiwnSOgJWJR
 Z6FAeokpojdpRPoHCGVIK+Nh40tWetWrx840Qt6honVD1C9NkLcVnyIL0pq+d0T2Aymt
 HLWYP/UK/sBjup4+WTr205So0b5iS8v0iIIJZSI12zrBbfHeaiY4ZeH7SfsK5PNQoISu
 kv2m6AB0axLpdBYR/CKrq+8V318ihezd8Fyzip0GrtjwJNRxjbKZ91LLVw8prJ6aC6OV
 i0D3RpAAp42X3V/1++VGBLxk0FQ2XDHwAHs7D+pIKlJnU1u6BBSCDOYat8N/4wNMxTS1
 kdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699596001; x=1700200801;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XhWK0h8MvpYq+nhVIsF0ozJwaZz611Hgl5A62HRk5hw=;
 b=R4yLlzAZVlrZWdGw8vJrH32Vjhis2m8xWeQ3bc7uiHk1dnfo8RUwFHGnH92j3/KfPY
 MNrTDj20XEazBLBytFA53iQwePSI4iSyuaXXzjZLb+Uq9mVOSO3g4U+PqHemxW5hxw1O
 feOz5vmG4c9tX/RdsC36UPbGc7pJP05KRIMPXGAi12A6B9fwIEzhoVQMvElpx02aYY0x
 NbQK7DTDvYHS2HguHLL26FrLjKFURw3MWJT9rGtlIQkASWt9sWzLwgYbt7gTtn9RQ/8E
 DkY2TGzI7jSyyjhbfMR2lWDUuBeyMHwrSw3WF3+sDusEGUIczJO8/MDhIJ9riHbQbfhV
 L4+g==
X-Gm-Message-State: AOJu0Yw2kbEUQXxMbQ2AnJ5CTuUcLte0cnHM1X3bX8I1XB0x0sZsISkR
 nhErQP/3TzQ1yuhnNiWhOQORP0VGVvFTADdAYV6fwwhvwt01JdtA4sNDuDOzz741wd/2gJtLGHx
 Ad3J7wXExw4oDLQMJPTZv1m7Gaffd2PMkoMaCBrEaEGf4F224pHOA2gSmepRiVhgmfL4=
X-Google-Smtp-Source: AGHT+IHxPrb1yc0HqSDtKCvaOE4WriHiCZarcQcaODpONwEoB1k6WHr/Ka39WNp1OWIzRVlHyQwEcs+MqqMPLdE=
X-Received: from dimorinny0.lon.corp.google.com
 ([2a00:79e0:d:209:7cc1:a55d:34ee:2d06])
 (user=dimorinny job=sendgmr) by 2002:adf:a3c4:0:b0:331:3423:306a with SMTP id
 m4-20020adfa3c4000000b003313423306amr52881wrb.0.1699596001126; Thu, 09 Nov
 2023 22:00:01 -0800 (PST)
Date: Fri, 10 Nov 2023 05:59:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231110055955.3370681-1-dimorinny@google.com>
Subject: [PATCH 0/2] cmd: bcb: extend BCB APIs to support Android boot flow
From: Dmitrii Merkurev <dimorinny@google.com>
To: u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, 
 Eugeniu Rosca <erosca@de.adit-jv.com>, Ying-Chun Liu <paul.liu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Cody Schuffelen <schuffelen@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Following patches introduce various block interfaces support
and extend API of BCB (bootloader control block) to reuse it
for Android boot flow of Cuttlefish virtual device.

Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Sean Anderson <sean.anderson@seco.com>
Cc: Cody Schuffelen <schuffelen@google.com>

---
Changes for v2:
- "mcc" to "mmc" fixes
- Clean some gotos

Dmitrii Merkurev (2):
  cmd: bcb: support various block device interfaces for BCB command
  cmd: bcb: extend BCB C API to allow read/write the fields

 cmd/Kconfig                  |   1 -
 cmd/bcb.c                    | 205 +++++++++++++++++++++++------------
 doc/android/bcb.rst          |  34 +++---
 drivers/fastboot/fb_common.c |  14 ++-
 include/bcb.h                |  59 +++++++++-
 5 files changed, 225 insertions(+), 88 deletions(-)

-- 
2.43.0.rc0.421.g78406f8d94-goog

