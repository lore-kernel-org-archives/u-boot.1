Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3E1C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C44B980F9C;
	Sun, 30 Mar 2025 11:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RPbu9gtn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 946BA81879; Sun, 30 Mar 2025 11:21:29 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 927FB80BA8
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac6ed4ab410so574040466b.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743326487; x=1743931287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SZnUnRw9HsqTc+hFuQa3aM9TwUOLfc31QKSVJ9mDvMQ=;
 b=RPbu9gtnpAM+LbBzm5iaC2cX+2anYMMSDKP4nRaqWc5EiagYGMkWVTVXOMTPsjUYxQ
 jIc9kO5g9iPLRJFH+tX1ixvwqVQ5PmCNI17S+65ZJyc6W9p1eLd6EGXy60NWpn8WJwlc
 9qt+aCZ1OHVcjbbF0A60u7C3aTuuK/arvnu46cJne/65PpZS5HqKKeCQ9QoU5fSVZ9lC
 r5Y1uNFjq9DuZkJEWANmkSHPW2+k4qnmmS8H3hD2QtS1VTV/klBwZSVNIFjC1FbrfgIp
 GISpAXAPnrUNmTobieKW9OwXwh2xXcPK0iA4U1xN2ReN39eXtcQ/gOmA9o4jKZTQ9XzC
 h9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743326487; x=1743931287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SZnUnRw9HsqTc+hFuQa3aM9TwUOLfc31QKSVJ9mDvMQ=;
 b=t6SUoXS7+BWkwB2KRvQrnY3Oq2oXDTCYvt9mBHXTmJXYa89tyzmcD8aDTOrRWUW2U8
 jP8cpv8K3d+xbLWC3/mDYlgRhGmZjr1HkIsLR5jkRDkVm+itEbYtlPPmMd5HoWAkdBjP
 S4qA9Ui3OrviQhYannVJaXcOKlQpRkHLR2WWdIfiQa+qclCKXixrKkKC+So1AVSXGkkR
 dyCcKVSLVeO6MzaSvFNmzg39rDUcSNnA0PO8BOJqzCra9H8Bg4WOfuRwCV2J7oUYBODH
 E8zv6lSGFt6vYeoLcHITgBHEJuTeGxeQ/ozauybBVfG7tnqXIIF2NqPfwi449SGglGno
 C5Gg==
X-Gm-Message-State: AOJu0YxDIvCcbEmWi9t55tuQueHXKsa9bAItx0d6cstNyel4H+LP6wPh
 bgjfW7zVon49dJbsjJlYN5fnoGZsLePdJaGavOAI+a3ScBsJcAT+
X-Gm-Gg: ASbGncu/s7bUM7TM9h7e24V+0SeP035eaY86pKN19neprFpu9+TnmvsG0yj3+SmmEFF
 LAzOFtWXcwSHmwzxWDV867n9F+FuX2pFzQPB5NX/ohTzIbFZ8bH58P+7ffpumOid7GHjIupo9KO
 bI7S9uZerC43VJI6uA00YwPfbsxOMHNFD4n9Q7M67dXbF0xRt855buemk3mADrI65chxjgL2FNO
 C1ToUM4j6ps6IdiPc5lWukQK86KRtC7Np/oeWGQMdhq+K/gmx+Jw+8OTi1tUbQGFRaqnWDz9PWN
 Z1/ymj5S4ztaeXIWHRL5xdw+ITDu10k4blD0
X-Google-Smtp-Source: AGHT+IGCEdS+j6aJ1qIz86BRxUGgw9TZZkn1p4VEfSMZee5M9ZmWWVrxHEbmMQ7Sw1oYagk3xMpReg==
X-Received: by 2002:a17:907:7f87:b0:ac3:f0b7:6ad3 with SMTP id
 a640c23a62f3a-ac738c1b69fmr465182166b.40.1743326486990; 
 Sun, 30 Mar 2025 02:21:26 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7196f56a9sm461565566b.173.2025.03.30.02.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:21:26 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 William Zhang <william.zhang@broadcom.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] spi: tegra: fix CS polarity setup
Date: Sun, 30 Mar 2025 12:21:07 +0300
Message-ID: <20250330092108.9946-1-clamor95@gmail.com>
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

Add missing configuration of chip select polarity. Default polarity is LOW,
which satisfies most cases but some devices require HIGH polarity and will
not work.

Svyatoslav Ryhel (1):
  spi: tegra20_slink: fix CS polarity setup

 drivers/spi/tegra20_slink.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.43.0

