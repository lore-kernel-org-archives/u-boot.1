Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F21C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 20:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F1E80FDA;
	Thu, 24 Apr 2025 22:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l5eiOJ/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 619C680BA8; Thu, 24 Apr 2025 22:19:40 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F30148056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 22:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224171d6826so23372845ad.3
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745525976; x=1746130776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=qwp3estlC26Lt5bohAiQbzmfG7n8ys60418skBaUUAw=;
 b=l5eiOJ/yU012Vvv4klJdA7MOA0l2JKCu+6LXGurVGonc2stlB2UjqbdKp6I0rH9Fco
 DKZhTdr8aZwebzztt/vGWGhOGOF38BPwKrXnEtEYHXe9ycua4QlrFILpJwRXwTKTKaA6
 Aah/C5OZv29KB6ESxKYH8I7RETcPLUGm3/GxBKNpZ6q/mqTgyeMjdvwI/2Vh/k0651dF
 4Hj+EtI4dQXOWaQaLLtoH5hRh9xHSfhQfJVU1lLjkemGMWu0FiLAr+YZmFc+lmFcurGT
 obAWUp+AwKPHYd+0TdRudhiV/IUQgArP1asL9xodzzPgX/YmA5bclrZZdEkMCyo7K6HH
 z8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745525976; x=1746130776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwp3estlC26Lt5bohAiQbzmfG7n8ys60418skBaUUAw=;
 b=R6agqNb864N6DlypKXRooTiOic3FTxzVfAKf4Z4FRDzyQ48dkVN7XiOYNusCb1refs
 37TZBxTnejT9/VQFjmhbC3zFj3gRyGKUuS1IYRlSRHtRjrJpwvqPoZ9U06ZMuELf6kX9
 2+zezWOiUMaqeTJQE3j8tAsQ/sJZYFR+1V6UQgi86/uFySH0MzAVyJ+GpxwuZwj4+wKq
 8yp8M7JeQ+cvflNsb52YiWHXFlVQ7u7IM1IhmVPTOw4VbsZz5fgmgzMMzO1pLz+Tg+87
 VTA2/dMf0D4yizRHCSeJ9LT5QwTkJ6uqY3TtA+k+Ft4/oMMhreXjiH1nr+8oU0Alq339
 I3sA==
X-Gm-Message-State: AOJu0YyjCw/AjKH6hCT9Orl7zqmDgBtiCPHghTPCEO9/bLjwOvJhb2RV
 Lts6bciL8BqhLXFbtq4+EgfvnfXemS8SHEJ/LqZGms+STNzRenIAMBBqbQ==
X-Gm-Gg: ASbGncsIUWKVYrrIEbthc9WE8jYbRNvKD30REfcQ13uatMfLPHM3So8e5PB5Pno48q2
 /ggkYmHMNxxNdCIGK6zXoECeZd0JgWS7liIQSCpflXh6/CjBr0v0Pfdqhtkn2mL0aJ2wP1tbWRd
 TA0dXAnrJwLvWIiFXGMIzde55vXeXyqsNR2cZ2fMiAdXGZslsqLamB9RBdlAG7NzNJXYIaLcQWQ
 wnis8q5rGDMHVi/r+bBFSh9C0rYh/Nn/utj7u3UCHVciKBCkMfONlAR+qmT+bidtjsuEQnlR5D9
 iWTFN8disO5bfxZg8hrwYw6nfGtHM52/J03t
X-Google-Smtp-Source: AGHT+IEOf/3cXCB2imwO393CwFl/A6RFF8YyXvTzdTzFSdRBZIftb0zsfLtGPH5Sy34QEOUNw+py3Q==
X-Received: by 2002:a17:902:f64d:b0:223:f408:c3e2 with SMTP id
 d9443c01a7336-22dbd41875bmr10217145ad.14.1745525975914; 
 Thu, 24 Apr 2025 13:19:35 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db50ea7casm17841525ad.134.2025.04.24.13.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 13:19:35 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v2 0/3] efi: Add EFI Debug Support Table feature
Date: Fri, 25 Apr 2025 04:19:23 +0800
Message-ID: <20250424201927.2027257-1-paulliu@debian.org>
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

Ying-Chun Liu (PaulLiu) (3):
  efi: add EFI_SYSTEM_TABLE_POINTER for debug
  efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
  efi: add EFI_DEBUG_IMAGE_INFO for debug

 include/efi_api.h             |  32 ++++++
 include/efi_loader.h          |   7 ++
 lib/efi_loader/Kconfig        |   7 ++
 lib/efi_loader/efi_boottime.c | 200 ++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c    |   9 ++
 5 files changed, 255 insertions(+)

-- 
2.39.5

