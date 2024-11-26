Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBA0D5A6E7
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 07:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33AEB893F9;
	Tue, 26 Nov 2024 08:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KK6bia/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC81E89165; Tue, 26 Nov 2024 08:30:26 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C211E89A14
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53de79c2be4so1340777e87.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 23:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732606222; x=1733211022; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LccoeOj73Wwc1tmTJR8P9kopjd1KvcwQvSHynFS2x0U=;
 b=KK6bia/SyU4/gBgjI7Q2LEhd0EE2tt4Lfxuz3cVta/ZpeksowKLMg/AGkSRokv2jwA
 YUvAlzgXk3tu3HNsPw1uCUTM7gLDLpl9WJjy4Th4Wz9dbC/inFDCf+YRJ9pwvYA/t0Je
 SZOeD1S4dYicc+LRpCW5lZkcQl9JZV0SQ4++IFOH0fu0lK9FZZDMx9THO6E/LVheI5AH
 YXcyWZnc0sFSvuqQsFDG0vynl6bHfFWM7Z8lbX13SH2PsDN43klX4pfm0PkBBGJaeyCq
 yFaseNgRguFw7GUENa+ZGI59Ufexppfsx0XSB3D08zQL8VnVWqR4sP9HcLQOPnczuikh
 ExbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732606222; x=1733211022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LccoeOj73Wwc1tmTJR8P9kopjd1KvcwQvSHynFS2x0U=;
 b=nDYInL5/Tasw7uPYseoi3y6R9yFX9niTxos9XqdMfrmumDdjZwioLrQPPdNAvWG4kE
 Nvj0zq0Jqr3FU6EX8UG8jjFtEZiDp0MTfeKYWu8XrimvVj2ih2D2qBAyK7ORZq6qmVWf
 pmJkJ2OsPbwpB5lBEWIVeNZ7zh28N/nGzk36VJhWI3tMHznp7RmjxVtNdYddkg6tWJ5k
 ewKNW8d2sB/9Sq847gJrwKEv/zYJaz0YGtF59svFUOTbZS1S18ZV0ccqF4XTHpGrlF+o
 uvRmztcp/t8lgEHTW0GYhX4IfXYEDg298LEfal6alP8I3uEbLP6jvli0dsyFoQAddWfy
 rePA==
X-Gm-Message-State: AOJu0YzAERPZHcHESXgfx3Qw/j4gZC9Nihp5KGN01TtSEBaYOJ8pjI0j
 eQ3KIlOD4I7MvcyXZXjG/fY7ipgc/ncnOOQw801lCAi++w46cQs0
X-Gm-Gg: ASbGncsVymEVHseOxYu4gkWKcp0Tr0891hrtWQlq+uHlm9D0JALCvZFn2nJNhf9vdqc
 safKrXL6sdB4z8r/iz4oK+B9NBgw6+zaOpKDZaudqcdSuQGGUf/YKUuJpBghVyMNGjNI3g9GWwN
 O9Q07yDmJHQOeWqeGRQxhUpw3DXZwI6VGNqsYeb2sGPmP45MiivV1oEtlgw8EsCYznT+Es54C6E
 IyJ36e/eCPSCPKsx1Wqo83ipDsC4HL7zKvLk8cIhg==
X-Google-Smtp-Source: AGHT+IGeLywHsAxMvDqA2MgF88a/HijUWOe1+ikBev4K4oQnZqe0UZpQonuBLZh6Fr8bD7GeOHFjUg==
X-Received: by 2002:a05:6512:1303:b0:53d:a4d7:1a8b with SMTP id
 2adb3069b0e04-53dd36a15f7mr8196433e87.24.1732606221746; 
 Mon, 25 Nov 2024 23:30:21 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dd2497df2sm1898216e87.245.2024.11.25.23.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 23:30:21 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Holesch <simon@holesch.de>, Ion Agorria <ion@agorria.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/1] Fix peripheral USB mode detection
Date: Tue, 26 Nov 2024 09:29:55 +0200
Message-ID: <20241126072956.64778-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

In the older USB controllers like for example in ChipIdea controller
used by the Tegra 2 the "USBADRA: Device Address Advance" bitflag
does not exist, so the new device address set during SET_ADDRESS
can't be deferred by hardware, which causes the host to not recognize
the device and give an error.

Instead store it until ep completes to apply the change into the hw
register as Linux kernel does. This should fix regression on old and
and be compatible with newer controllers.

Fixes usb peripheral on Tegra 2 devices.

---
Changes from v1:
- added reference link to linux patch which inspired this change
---

Ion Agorria (1):
  usb: ci_udc: don't use "advance" feature when setting address

 drivers/usb/gadget/ci_udc.c | 24 +++++++++++++++++++++++-
 drivers/usb/gadget/ci_udc.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.43.0

