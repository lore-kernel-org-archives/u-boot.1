Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25A7C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 13:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B07807E4;
	Fri, 24 Jan 2025 14:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FQndrdjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86FAC807FE; Fri, 24 Jan 2025 14:12:36 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1710D80780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 14:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3863494591bso1136655f8f.1
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 05:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737724353; x=1738329153;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=l1qciG33YBacdU3qm1d9XjE8maKzNex2RMfL51KuzFs=;
 b=FQndrdjsZaQSrl3usqLaXK17EmMVA2y7WR8bnbgbBDMkFhFaMNS1Pzt7AjNqS1WPP1
 QGoGbpYMWjw6MwRPaxhg24AOBOhRF+01LGFSe3yYMIS4F9scmDlwSSh5NsNbZVHjKl6G
 qmWypM9XqmChl20Dh5mnx73kOMBRbo8JywVLW7eTqczmtWtNjlMYZ/XMjTyYRE+KUQJ7
 ZJi3dAtASLdMOo4KLYqEOd2Ca2mL/Zwp/LtI5k07DCiZ+CxP6/aNOF6lxF0YSvq7+fLU
 HQyjGqQ5zTqXAI5YF8nGPKsjWDTEUNi9EQo9aIpVi0HVGMmLZyMRIAacXUZSSUFTwC3i
 voWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737724353; x=1738329153;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l1qciG33YBacdU3qm1d9XjE8maKzNex2RMfL51KuzFs=;
 b=BzyNHfZRNgWocCi7mTKLhd5wacIQSJHYgykgNEWO3DIBsG/3PpIFeBGrpVmyXj42pc
 6Ak5ogru50cNChjxcwL24Vsira0GHakRpT2TRStHav6zfLs/X3KYL0V8dzrQpEOA9pVG
 lwKfyG2EoAaeKdbR83WmooagfVRX32+5HGJx7BPvSCN500qGRxipkzZevn7PX3h+3HPe
 Oj+5CYAsnC8Vs78TJ+jEZ2RkqQM/OOAVH73F77cGWKkyiXoKzx72qZMTWPd5JLgxGTZn
 tWlFIVY6BBP/2VOYtcuoZtFnN6ugzLvJXzFRF/a51/jj+IsBbyoOp53v5E9ICqEjDOUo
 MHLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwuQoOzRR00Qfpz6WDfs5oA8XGLIQ2DHi3YfOnlC2TM6sBlXXqTjkAzTzveL7D1cq6/dsN24c=@lists.denx.de
X-Gm-Message-State: AOJu0YyKULsbWdOy/13uJBy2GpcW8sYBsW+Mj7m05nX5XHtHG+qI+pqG
 CKeX0vCTgPtX2PKy67uqSWczkuOB9o1/fNuszc0rDJIOiCQtX7ROWjpu6QLAHszIWVvxoPGTdiC
 f
X-Gm-Gg: ASbGncuW3wsRTyj6CNOgEOyqqSx3b++N8qRh5uzBStpnQDZIgFnSP7dGbxEDqbOEI75
 exk5rbm6FZDeddZa5IGM0sCuuxdzF3P5h8qdmjCXqP05tt/2iI/1m6HmipseUQ3nuTYzD5lVpOS
 d6fxtSe/+eSyxAo+gCOiUQ9C32JV5qdYwnNFjaMAAxnqYGBU4dCFkMlRu/RwOHiotvuVWjOr45j
 Jlt+wRg9/yALdg9Z8ZDR+FV854NaF1nr5+YawbP0dRXvlTdKbdDDnJ83O61yNbnC3YBKht6OiJ6
 4enbN9GksuNqPA==
X-Google-Smtp-Source: AGHT+IFSpca1jxJGv50aNOg95AV84ONF/yio4jYfpZIitPeklBvpLNHOqhPvTW7MEGLBB8VBkw2DqA==
X-Received: by 2002:a05:6000:1564:b0:38b:d7d2:12f2 with SMTP id
 ffacd0b85a97d-38bf59f4422mr30002758f8f.54.1737724353436; 
 Fri, 24 Jan 2025 05:12:33 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb04csm2670785f8f.73.2025.01.24.05.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 05:12:33 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Aaron Kling <webgeek1234@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20250124
Date: Fri, 24 Jan 2025 14:12:32 +0100
Message-ID: <87jzaks6db.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Please find some fixes for master:

Android:
- Fix kcmdline null pointer dereference (reported by coverity and
  multiple users)
- Move Igor to reviewers instead of maintainers for avb/ab
- Fix booting Android with AVB built-in, but disabled via
  fastboot flash --disable-verity vbmeta vbmeta.img

CI Job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/24323

Thanks,
Mattijs

The following changes since commit a3b71cc6f5cc74d4edc5808790a3d2999ea3f7fe:

  Merge patch series "upl: Prerequite patches for updated spec" (2025-01-22 17:08:47 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20250124

for you to fetch changes up to 6745cbed6edc06fae7fbc4b360e39c3963d57b13:

  bootstd: android: Allow boot with AVB failures when unlocked (2025-01-23 15:23:05 +0100)

----------------------------------------------------------------
u-boot-dfu-20250124

Android:
- Fix kcmdline null pointer dereference (reported by coverity and
  multiple users)
- Move Igor to reviewers instead of maintainers for avb/ab
- Fix booting Android with AVB built-in, but disabled via
  fastboot flash --disable-verity vbmeta vbmeta.img

----------------------------------------------------------------
Aaron Kling (1):
      boot: android: Check kcmdline's for NULL in android_image_get_kernel()

Igor Opaniuk (1):
      MAINTAINERS: move myself to reviewers for avb/ab

Mattijs Korpershoek (2):
      bootstd: android: Add missing NULL in the avb partition list
      bootstd: android: Allow boot with AVB failures when unlocked

 MAINTAINERS             |  4 ++--
 boot/bootmeth_android.c | 39 +++++++++++++++++++++++++--------------
 boot/image-android.c    |  8 ++++----
 3 files changed, 31 insertions(+), 20 deletions(-)
