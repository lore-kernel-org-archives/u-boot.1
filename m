Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91139E7717B
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 17:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 166AA89620;
	Fri,  6 Dec 2024 18:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="afv0sXsI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 642C589620; Fri,  6 Dec 2024 18:18:54 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36C6989021
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 18:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-215bebfba73so22928015ad.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733505531; x=1734110331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xiNnRfrbMNSl28WDjJEC/HnKFdzQrPaZ7uzaG05zxxw=;
 b=afv0sXsIaUd0LC/OmzMeRN05/QcccdyK7B1im8CCSg5ir7mA9WCPeNSDAJYHnbP2ET
 ah9DC5aXqwS841M4W/3ZIjEv+aOkA5kaUPvHpqPHYBCplfTmsUETwukaqfm6vy7hDAqV
 dD16jLZ7zYcGhj9vvZZOgl4O96M62eJV9QMpdD6jAdrjEgVttSNGvBTNIYHHpNKuwleH
 eGr2hD+dnXSOS0c9MUvDS+4TxOig2TI2guf7zvl1yLcPe2CmS5+YkoVA5K24W2nOShBU
 E8vD4hxfErkw3z3PXns5U4MaB+Fu3SlyQ3SppQ/nGhhprceSJLa1aMlDh1zgJG1kpgE5
 Q+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733505531; x=1734110331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xiNnRfrbMNSl28WDjJEC/HnKFdzQrPaZ7uzaG05zxxw=;
 b=VxoTaSWIvW3BqegN32SEicMfla/Ir5WDCA0JVClltKbvdDJsYuN/50rLE6zxOZTZog
 B6+zfBdjLeqeFlOMxt0cN4fYm92a6ochiUQOta0OMY8IsDRQNX/ilhBTlwuoWs9WHWso
 WlfxhEzPM9z1/2wzWLeD+lrzNeMe1RbWbPo01CCPZu7CjBS0PxCIoddyv5tLFHajhxRA
 Xbccl8VGCrTcjMuIuId9IkUXw9HIcqKyGhDeraNaB8axdjG/fTBoFLnt6kcz0A49Glon
 jRHETSrAx8dKOFJDDjC+DAtpWBPBbICHLlG5e9Lnz3dwV2qj0b7LI+979z3qt9uiaCkF
 kUBg==
X-Gm-Message-State: AOJu0YyLFIYOnjPgldJVDrADDlXHWgYrGipMWzqII0dIyoCNWgKIZCVC
 0iHGSO99OvvUPvt+6iK83eptLIJG1ArMTtouBOTYASTm/annyIuXf49UPZzvzio=
X-Gm-Gg: ASbGncvboyhreG53ZFLanq/ogAa4GA0XCr53I7ZyyDp65a0NAYpBYXH0XIQWGQIvcaB
 tUneewI/DwAuMCUO0jvP5b10BkqXobgFvFOFkSeZY3ITC+buE6n5/PvCuldXjFYMb5DM6qDNubQ
 86G6UGLBBuhtKRVCqNwIRiWx3K9mTL7BqCaS5w9/K+gBR/P3YMw0jZUwk6lJS+MEJKsp3Nwuhx9
 GR/MWNV9QzApBiDFDAW/s/DtcjFdwn1Mn8PQD5X7Z5ZiN7bjsGA3mOI5w==
X-Google-Smtp-Source: AGHT+IFeSHVHb4MaZ3vlZwMUpfSwZvHG2ASTdRECG0DciydV1fLJW8X1AhJ7Al8Zg+0vcWwX8719dg==
X-Received: by 2002:a17:902:d503:b0:215:6093:e383 with SMTP id
 d9443c01a7336-21614d7888cmr47438875ad.27.1733505530593; 
 Fri, 06 Dec 2024 09:18:50 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f263b9sm30970025ad.226.2024.12.06.09.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 09:18:50 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 0/2] efi_loader: efi_net: Fix net_dp handling
Date: Fri,  6 Dec 2024 14:18:33 -0300
Message-ID: <20241206171835.2403418-1-adriano.cordova@canonical.com>
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

Fixes commit e55a4acb54e8 ("efi_loader: net: set EFI bootdevice device path to HTTP
when loaded from wget") which generates an use after free, but first it is necessary
to expose efi_reinstall_protocol_interfaces in efi_loader.h, which is done in a
separated patch.

Adriano Cordova (2):
  efi_loader: Expose efi_reinstall_protocol_interface in efi_loader.h
  efi_loader: efi_net: let efi_net_set_dp properly update the device
    path

 include/efi_loader.h          |  5 +++
 lib/efi_loader/efi_boottime.c |  2 +-
 lib/efi_loader/efi_net.c      | 61 +++++++++++++++++++++++++++++------
 3 files changed, 58 insertions(+), 10 deletions(-)

-- 
2.43.0

