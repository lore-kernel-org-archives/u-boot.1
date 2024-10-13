Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3C8CF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 14:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A11988F03;
	Sun, 13 Oct 2024 16:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UH0KU7lC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEFB088F35; Sun, 13 Oct 2024 16:58:43 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F70388EFE
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 16:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c9709c9b0cso805693a12.1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728831521; x=1729436321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2VJPs+jfIRZhHxHy2+bjTi+othgLJv4LhzQeluHn/NA=;
 b=UH0KU7lC8j6GhmbwCump5FKpKEwrXGzg7kOjWFWXMyBE82kzOV83l8sfftAb3uKuEX
 S4ROlgo+4KeJkyz7DkgvXUukONvc/mwzHIHIcTg+d6m4l2mWOHp7xF2e1PT1lNTov7Sr
 qhFJ6HpLe549NRWgvBKmpq+opHaE5Y595Q0Dg+kgY7xbLJUaqIVJNHpvxkk7hlaFgWpm
 3uLm+Shm44ilcnBzO5UaPmRoP7GNdeBg5LG//zEk1gjbr9WjWbQJuNmdTcI0rvaP0Kar
 gdVBXAM4jDNm96O+o32vdGIUCtv/00A4ybJ9MLA2UGS0+pofm/v83X0zzgyVQKzYKzal
 Fz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728831521; x=1729436321;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2VJPs+jfIRZhHxHy2+bjTi+othgLJv4LhzQeluHn/NA=;
 b=IZfx2wzeTxSwxy1R2uDZT3qRbiyP5fFc+EavD2GqPmK+ElWaHL1kXbtOU8NTI4tJ6Z
 1ecjySzI8UdxXWO6eqEBScL2Led48ivKv27dUqNtXSKJZUFFykpQz7iqx74LVHAKsDHx
 FtVOS0VUP9XJLOukOzd0Mt6g3gAedjT3w9ZnEb+CyziZ4fwYZcbgSbcMznpbb01ZnN1v
 lqbeYbinoHUHxhVpF6Duu3GljFvNgDSq9YGRaq9fNT8dFsrvimq51P4lPoFP5DxcXuRg
 vj+6yWieVbOYuesobxwooZYhLwFDpXSnc8Ft2mzqa+Pj5efwTv/PcSz6P+gOG5gecrfN
 sGeQ==
X-Gm-Message-State: AOJu0YzOgIhGGPQ69hXtRYg0q18TXJ/EAwwYZhWstER3dXM1Ffz+wo1M
 /urPgGlw89mu+997pxCFXifmbb5wg8sJhC5O4koKNuRgBTUfHcnz
X-Google-Smtp-Source: AGHT+IEJhrHfbsX6GO+bOLUE+ECxjnpGJ7TJAsxatkrFMrvM11LLCTnuClNfBSy03wKOmpGE/8ZZMA==
X-Received: by 2002:a05:6402:1ed6:b0:5c5:cd86:4967 with SMTP id
 4fb4d7f45d1cf-5c948ad1d57mr6688601a12.0.1728831521217; 
 Sun, 13 Oct 2024 07:58:41 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c93711ad23sm3836877a12.25.2024.10.13.07.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 07:58:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Holesch <simon@holesch.de>, Ion Agorria <ion@agorria.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] Fix peripheral USB mode detection
Date: Sun, 13 Oct 2024 17:58:19 +0300
Message-ID: <20241013145820.85426-1-clamor95@gmail.com>
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

Ion Agorria (1):
  usb: ci_udc: don't use "advance" feature when setting address

 drivers/usb/gadget/ci_udc.c | 24 +++++++++++++++++++++++-
 drivers/usb/gadget/ci_udc.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.43.0

