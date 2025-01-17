Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56522C02187
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 00:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8041C80755;
	Fri, 17 Jan 2025 01:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IhtTW/yn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 598B680719; Fri, 17 Jan 2025 01:10:14 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51ED880716
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 01:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8113B3F84B
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737072610;
 bh=+Etk/75E3duFAb9G3SHU8eNFYYnQS+zJCZVp1VcpxxI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=IhtTW/yn40Ox+c0HXlWjmAZYfwKinlLl8RCraRNPgAKikn4XK/ooGTDf1EAkmfBHL
 iS7KoAk3iZbjMeZloR92B/KkTDrzQ9cyN82bYox7erK84KTjeBX5LGGcMsYUkd90p0
 rcHHHpOGzemIhBE/r5OaBv510WFhEQe9V80vGLg8En4+hNtagm8aTNsYKFbq+XMHVY
 Z+4TzgCizMOBnw8fnt4k31CPNx8IwB1gBqeTwtA/dssiYmeauo5LsdGtzYaX07DB5u
 ULTmf3cSM1/lPA0IOoXFwZrBpto9pok8Q39+b6Pv85/Y3HYnTODry51DbiaZQAjf96
 /sgrgxV/kMC0Q==
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5d40c0c728aso1411753a12.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 16:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737072609; x=1737677409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Etk/75E3duFAb9G3SHU8eNFYYnQS+zJCZVp1VcpxxI=;
 b=YVE83D8ryVDNIzYCUd5RXKQoYa1w4A+wRfv4CaUvlr6eIktqaJNW1J87QvrXVNTXn7
 XLM2QAjFUAJveqpmT2AW+LZCbNG9BJKlD6vdWdwRK/9O/LI2pEWEnheW0CyOIv+2qs11
 aiB7nSsAebQKVyxV1ku/IxdUy60Lm8Gzr1wPFVNmarYjQR2wlKimPn4nhmzG/goWGmSL
 XbS6w5lsLgo5KHtPUnHk/S6PQpH3TSfiHa6t4aJincA8ELddtskbsVGFS2BfMYrUAQTg
 yIILsgyNDzTV0bw29AmKhmDzeoy12ixzExluA9ZXcCR0BuTa92SNeXb/yV7JAWeEdnJU
 rT6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXXFcgWY3YvOpjrDTpumHMGcdsLAE9flFXJUAP4bMve5DxAf017/kAraTlozZ+8uyWODImif0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0BFzEAD2d2SQZqFVPryYRFZM/BO79l2aLvtK3/WQqakzQpR04
 ZanhDnwVOJDPHhnFaYQ3dkKtDX/jCAus32sfNEZATtiFXtfRb0j9oPfy7CyPNmy4FKo9j/D0Bdt
 ekOWWzp6w0B1RzobCN3ErHIt4EujRjyJBdbGxCSHE6HHgM/QmswiCLU5HZz1n45V2c38=
X-Gm-Gg: ASbGnctGxO2PtUmt7SX9vcyYP3ziq6pmm26OQILH2s17w56R8imZ7tmzJ80rqj4F42d
 NrzUWcAyL8eaww0nnWRaF4fNzklrhvImoMVOrV9Yx3SeAcHN7v+EmTF9rESmRdHnXwu0vo1f/B2
 VICGICl28NY5CsI8Jt3pYTvEYyPyTK0feYeKdIoBc5qeI57ytXvcACz0dMLzi2/r0BtXjrWgLki
 uiEFGZ0yXDHQcTsPzXlxSFU5FO0zRoohKO0alnP3IwHyQeQeXbql2n1Bp1+gpXgwOP8L7yextKp
 FOTuYUBakpP8vQ==
X-Received: by 2002:a05:6402:3553:b0:5da:1263:306c with SMTP id
 4fb4d7f45d1cf-5db7d2f5b73mr1378517a12.10.1737072609488; 
 Thu, 16 Jan 2025 16:10:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnrOe/U6pUfNwD2DXqY+BxZLaqZ6V5xhiwZEbBgb9Xo22heJZyp+ODKZOMeC4B+4gfVUMl9g==
X-Received: by 2002:a05:6402:3553:b0:5da:1263:306c with SMTP id
 4fb4d7f45d1cf-5db7d2f5b73mr1378483a12.10.1737072609152; 
 Thu, 16 Jan 2025 16:10:09 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384d27117sm71986466b.75.2025.01.16.16.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 16:10:07 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] efi_loader: correct logging StartImage()
Date: Fri, 17 Jan 2025 01:09:51 +0100
Message-ID: <20250117000954.531785-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117000954.531785-1-heinrich.schuchardt@canonical.com>
References: <20250117000954.531785-1-heinrich.schuchardt@canonical.com>
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

When logging running an image, e.g. `bootefi hello` the indent is not
correctly reset.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_loader.h          | 33 ++++++++++++++++++++++-----------
 lib/efi_loader/efi_boottime.c |  7 +++----
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 9f51db90f33..95d416adf9d 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -3258,11 +3258,10 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
 		 * To get ready to call EFI_EXIT below we have to execute the
 		 * missed out steps of EFI_CALL.
 		 */
-		assert(__efi_entry_check());
-		EFI_PRINT("%lu returned by started image\n",
-			  (unsigned long)((uintptr_t)exit_status &
-			  ~EFI_ERROR_MASK));
+		EFI_RETURN(exit_status);
+
 		current_image = parent_image;
+
 		return EFI_EXIT(exit_status);
 	}
 
-- 
2.47.1

