Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A80CCAC5B5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A37F83510;
	Thu, 25 Sep 2025 22:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mi8npNU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E249832AD; Thu, 25 Sep 2025 22:51:30 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE020833ED
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-638ac2981b9so568956eaf.3
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833486; x=1759438286; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qdk68LfHn+lfY/Qi35RIgAEcCZtld3i7tt8a7J2u6Wk=;
 b=Mi8npNU0FPJx//hLnHcCnxVOoa9t0tEgCXOgHk0hePAFPNjAtGxjmySRfqI4Ng3/Od
 TsQMJQDJbE7KrRoQFOHiyxzna2/9M7P2qhyUUB9nfHPBi5+rcsP05V/izCfHSmtKSh+7
 cMJGuH9H80sE+SamCzD86Bzh5AluMJ9czyVro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833486; x=1759438286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qdk68LfHn+lfY/Qi35RIgAEcCZtld3i7tt8a7J2u6Wk=;
 b=hcdPn8+2niRGFxOTg7rediKfxc54ghnunMDdgvjKEfffohEcQKRS4aTpjkvxMmzRPM
 w/n7lBtll4nBSu48cmt/CD/meoi7r6Ee+nKK9i6cO7saLatLOu6IzRnAcXP++Jc6xf3m
 TOy48k5NDmPFcw7ypkx470uAPk8rYk8T3JCciZA1nKjM6K6OSD/S1+6RMGnLyBGmqy+S
 uptRxPThw/Uf2t/ceiMmx79VqRXKzOvqDyMl61nxqMfU9KHTJj/VW72+Bxl/z+zibGn6
 UUfm0zrC38iF4WgoKCK837Olf5TQqlXrJOCI98U2k6LLXvsbnTjhkSS2HAdN4QupA8Kw
 IJ8A==
X-Gm-Message-State: AOJu0YwQFTb9DFZRcSZoOh2sqdWs96PuTJKu0YAINj43tuSF8+BTBdGb
 jbOU5ftJ6Z9XwHY+BxpbqOO2q04ibbJAqSr7pFV0ESXuZ9OHtM9DQwuxKTKwEjIFIcYFHTRIz6/
 7HS2RxKs=
X-Gm-Gg: ASbGncsKkVOPYSK1DKVEnPjB7aDJijwfIFP8awEsUmX+2L5Zvx7yQpJ5qP+HKBUdr9+
 YxMJ6mji8WwYAPWEWlxuyOg2hvYghWqxAr0Abzd2dg4MVl3OVvGzSivA9QiF8UtKDQ9jPs2FTW7
 MJHXbhGSNcHQneml0taEpFr6bl9UbGN6HJMmGtmyTS9T6VIgBB2wsvGRbVNXpWeatV0l4qhavX0
 wqqTj9xlo/KKqrBdZA1Ul+B/Y4IPVVjY1TxwhjP9ScRJk4jueim7Ozzp5GeO2dat4VULgauj2yO
 CfjqRrzIY2TqXryCxJ7BNopnPhPpGoi1cnIKbcDioLn9wU0Rhi4j9qsDD6aS/+q3sODDQ4yzHdR
 z/J0tOqws1jeYqZaR/aJVhsoc852JylKwMovw/UjLLkF5Ft6h1vdrj2xYlo4=
X-Google-Smtp-Source: AGHT+IEqlXWLxe3ECht0bo0onr3zYhaW8Ihpn6EFTn2PMqEQb8C7akxcEXq3nEv0yMFOaF0Mxt/pTQ==
X-Received: by 2002:a05:6820:168a:b0:624:abae:b65f with SMTP id
 006d021491bc7-63a38c1c83dmr2354474eaf.7.1758833486688; 
 Thu, 25 Sep 2025 13:51:26 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-63b25ef3fa4sm323689eaf.14.2025.09.25.13.51.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:51:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] spl: Correct dependency for SPL_SYS_REPORT_STACK_F_USAGE
Date: Thu, 25 Sep 2025 14:51:24 -0600
Message-ID: <20250925205124.3561896-1-trini@konsulko.com>
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

In Kconfig syntax, "!=" is a string and not numerical comparison. This
means that to check for a non-zero SPL_SIZE_LIMIT_PROVIDE_STACK value we
need to test that it is "> 0" rather than "!=" 0. This is because "0x0 >
0" is false while "0x0 != 0" is true.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/spl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index f34b96efc022..cb7b4179384b 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -176,7 +176,7 @@ config SPL_SYS_STACK_F_CHECK_BYTE
 	  Constant used to check the stack
 
 config SPL_SYS_REPORT_STACK_F_USAGE
-	depends on SPL_SIZE_LIMIT_PROVIDE_STACK != 0
+	depends on SPL_SIZE_LIMIT_PROVIDE_STACK > 0
 	bool "Check and report stack usage in SPL before relocation"
 	help
 	  If this option is enabled, the initial SPL stack is filled with 0xaa
-- 
2.43.0

