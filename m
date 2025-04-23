Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB9BC369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 21:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B04B8070C;
	Wed, 23 Apr 2025 23:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bsc+nmdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C840F8070C; Wed, 23 Apr 2025 23:32:10 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 835518059A
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 23:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so238386b3a.3
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745443926; x=1746048726; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=85Q9nMadSkLj9H8XTnkKa1aZzCHtEdPyLEHre0ewwrQ=;
 b=bsc+nmdf03nS0sWfk2ahkqoGoBDE2i4I9jWxofZMbfQ7rSiuemt+ZKStyyNVpdXAvj
 HjqL6116JMLeNAzvmI7bpf4+LV9IhrNXRUvKq4YvTGPtGiapF0GKykgiabiL4EiVHt4f
 WD0k9rIn0vgqBOtqkhBZwclaO8she5jOCU3KA6lYbuoPX4hthmwxwNxJIg69nEOKfNzc
 akqaSvNc0jLON+ckBzMe+DqWUnLG/tA+Mt25/7cGva/TSDRBxPiQNZqdHtx3mdbVMwRx
 MMPcD642r9rKs3axsBgfYLWpuAqe0Cc5gAK/gueRiaF7QEIf32DFHwnobr2YDB47ezz5
 cPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745443926; x=1746048726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85Q9nMadSkLj9H8XTnkKa1aZzCHtEdPyLEHre0ewwrQ=;
 b=VE+ix2jIRK88Ho2WfNaTOBrFNgZRYyOxvWRLXpAvngFGZSdUIvwGaylJYEDbiYqNjJ
 NzCLoRXwCDXtwL43nht405/Tcz2hcRO95Bm8ztYMlZy4z0xP4ICZRlozqbXkGZdlTqAH
 trjhBBTpYn59ep6l3ORa0dNub/sE+1CfQl/e9gM0G5t3zNT5rFgVoOaUAr9w0zFN6Hz3
 DsZmjk8Zd90wcW0YC/631aRORVKk+McM/8ZjRfnTwID57JgsW5v1tAJ73V1PQT3Lgrlv
 TcAacqxeZ1lsAdi7zAT2gQMGmiG9ZNht9wt1TkX52eATdunKRXGdnY0CT5T1PyZFTpWU
 +lRA==
X-Gm-Message-State: AOJu0YwV1iOPCdSF91htVPfBfeAxj9S1rM5WkJixE48v11+1u7JbHJGp
 FJDcR9nmqwSmXe8IMiduExgRg1rtloASza6y+aiBAHG42zKMBOQ1E6BZGQ==
X-Gm-Gg: ASbGncvwB4gtfeaZ+9gPB6shWgMbBOJu0A1xE09Znj6ZqGfn83FgLRgpHdJrXWCl5mP
 LMQ0FolnVerm425/xDmYEKWiov41fkabNE3hKvxURdsmyHzH8UyLQkM8TS6bOUrjYzz0X+ZHjAy
 M7B8h8fp+nW347yDDsEZJ3pHaGQFamLLryZCIKnhM32FxYGAzb2WwQwxN4SgnvOS2/5gVwVH0/M
 NEkQmaI3T0G+fRDTv9O6Zth3b8NBV6oZF+ER/t2ZYYjsOIIVkLnq2/IyqnKcn+V8P51dlmQy0nD
 nKTc02bdAO2N1uLXJKq8Ewh6KPJ/g41HuWbS
X-Google-Smtp-Source: AGHT+IHNxwOHD1tOK17ldn8ZwmFS+rneaIeamu1CyRq8DWFOTN75qEd3g5SKPed2YE3jl2/LIv8Xdg==
X-Received: by 2002:a05:6a20:d70f:b0:1f5:5614:18d3 with SMTP id
 adf61e73a8af0-20444e8083emr172572637.8.1745443926346; 
 Wed, 23 Apr 2025 14:32:06 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b0db13a3bdcsm9618547a12.19.2025.04.23.14.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 14:32:05 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH 0/3] efi: Add EFI Debug Support Table feature
Date: Thu, 24 Apr 2025 05:31:41 +0800
Message-ID: <20250423213145.1959046-1-paulliu@debian.org>
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

Ying-Chun Liu (PaulLiu) (3):
  efi: add EFI_SYSTEM_TABLE_POINTER for debug
  efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
  efi: add EFI_DEBUG_IMAGE_INFO for debug

 include/efi_api.h             |  32 ++++++
 include/efi_loader.h          |   7 ++
 lib/efi_loader/efi_boottime.c | 196 ++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c    |   7 ++
 4 files changed, 242 insertions(+)

-- 
2.39.5

