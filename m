Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18361C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 01:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 258DD8070C;
	Thu, 22 May 2025 03:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7aAjXwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34700829F5; Thu, 22 May 2025 03:18:02 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CACD48006D
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 03:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso7236162b3a.2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 18:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747876678; x=1748481478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=Wj1dXkOZN6lLbgjiiubZ0avwPsBCsOrzCRyR9qxW7Wg=;
 b=L7aAjXwc68OZ7+rnbRPBG11wgm9F5FfVxUeffZMN3h7wDEgbq7/mhQIzDGIQmK5V+z
 au0O8DUCrHfJ52AXxa0ZZEHeWw5s5wBkyfVH7Mh/cIIsfDZ+UQyLQ0ypJNhmNuU1kgU/
 UoHNgZishfJct7D00eIQ8rsaSRm/M1GrgrmosOdlxdHKXZ4ThteZfD8TzN40HsAerF5z
 R6qzYy9f0IQMKGeo+z+uwWKgc7s4sq8x9f8RMpF9bKjwmP2POMddIAOu1UrDTGymVy1i
 Kr5J4DskK37Gc4f1wj+UpzB6HZl+dMMhqe+WnH1j5w6tMbk84jyZddkKg1UshwA+wiMx
 /wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747876678; x=1748481478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wj1dXkOZN6lLbgjiiubZ0avwPsBCsOrzCRyR9qxW7Wg=;
 b=PeQsvyhRKBjg50sgINvufJNLxvBp6DiZbCnUpBvKTxfQ0t1wTmgrG3bIhnaCOu2rr0
 UcFHVZEPB9n3M+M8s+C3BwakNinbum8F8vfLjR/PUqQNbQQCURi/A3E5i5XVKmz94MzZ
 wnP0SPx8xOS5Zg2IrPBwMslo1B+wNC7s6rntN+w3M5z5TKLFuYeBFTlyJ+FyODozZK47
 eLnhnNzntspCTV8PEn9gjK4kjv01kYRQZeje+oGhbOq327YiyICdVj/UEEpGIRdOR6kn
 q0k6/EjWFMHdj1jl+7d5uSU72yUcaC0ZdD/MEjMHwbAY9OpP7cGWyg5S4+QP00mPxT1b
 4ksw==
X-Gm-Message-State: AOJu0Ywfoi5JujDQPWls8gX0GM4p4LJXzPspaUh60eT8ttmLwA+1B/vV
 IAgBuWjx6B3mqwlx4AhKoE+iMVpkh/MArp0oum578kxxE4Oj5gX6vy5uCWeGZQ==
X-Gm-Gg: ASbGncs5yW+QZBvWdtYm/q3+UVk5tPWYoUbuhQIbtVZRHs/1f5CSSKzWpWRrl4pA3jS
 bOJMGm5f3v7V8FUwWUJWV05/g0xL+cYeEwX3ZPXYMZ02gzozdFalHmhUh+Ol6nIZwh/rtOU/Fzu
 4yFl7pFkSJITbNAfvZDxu1OjkT1RF76ljG+tde1TU4FRWuH2jcocmzjlwm2T2MWRt1UNMicwC62
 icvMCvx8eGzlnAeIHG9G1vdpGdKPtbI3uhLjkNd36sOqNInY6PVmPkn65Vu/VIE7Z4zvr4E0gkU
 SmArLfZvlrjB+r1N9jgf2aM0mQbCo3o/coCTi/j6jkfscTo=
X-Google-Smtp-Source: AGHT+IH5TjefzMrqF7kU1BnmBet1DSS/LbCZ0suhisvZSpYjR0eIKat+/o9hLk/LJjJ7edVRJmsrfw==
X-Received: by 2002:a05:6a20:3d22:b0:216:19c1:1f5d with SMTP id
 adf61e73a8af0-2162188b7c1mr36417141637.3.1747876677504; 
 Wed, 21 May 2025 18:17:57 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b26eaf5a44csm10171565a12.12.2025.05.21.18.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 18:17:56 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v3 0/4] Add EFI Debug Support Table feature
Date: Thu, 22 May 2025 09:17:44 +0800
Message-ID: <20250522011749.3498970-1-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
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

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

I implemented the UEFI Specification version 2.10, specifically focusing on
the functionality described in Section 18.4, which details the EFI Debug
Support Table feature. This implementation ensures support for
hardware-assisted debugging and provides a standardized mechanism for
debuggers to discover and interact with system-level debug resources.

V2: add Kconfig options to turn on/off this feature.
V3: Fix the way of removing debug_image_info.

Ying-Chun Liu (PaulLiu) (4):
  efi: add EFI_SYSTEM_TABLE_POINTER for debug
  efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
  lib: efi_loader: efi_memory.c: add efi_realloc() for realloc memory
  efi: add EFI_DEBUG_IMAGE_INFO for debug

 include/efi_api.h             |  71 +++++++++++++
 include/efi_loader.h          |  11 ++
 lib/efi_loader/Kconfig        |   7 ++
 lib/efi_loader/efi_boottime.c | 188 ++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_memory.c   |  52 ++++++++++
 lib/efi_loader/efi_setup.c    |  25 +++++
 6 files changed, 354 insertions(+)

-- 
2.39.5

