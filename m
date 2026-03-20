Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CFE1099B2D
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 17:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6472983FA4;
	Fri, 20 Mar 2026 18:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GBClpmON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 206E683FE1; Fri, 20 Mar 2026 18:25:06 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B77683FA4
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 18:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso1821408a34.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774027500; x=1774632300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+9rLTKb88hyJn6ZnB7hp5lBedOjbVN8tBG11E/9t8A=;
 b=GBClpmONWak6b/oIpZ1qqImmhLQQUCX6xe4y4eMYfMIBzozu487GFKkYausvRaVZ/6
 AuYxA5IzI4T9ShpA4bH0gX624Znwh8Q1uK1M+wGt7UBV1KPUVPFfrAjjpGpzUnw6J2ot
 PE/dKhUFt5e9paF4vGaq6L0IzEwDLeOXIw8/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774027500; x=1774632300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q+9rLTKb88hyJn6ZnB7hp5lBedOjbVN8tBG11E/9t8A=;
 b=bnQZ8ZXIlHNPRINZEA2jXrc383eKj2zQCWoKtslzgv+6bWR/O6F8k17qLT+jQNEuLm
 AEEtiZT7cgksiCrR1QRpqXUDx9AhsXbmwOi55IOg0Khf9e1ePjdfuMBN/zq6TeAPVvsP
 i2QetuYJDu7KRpDPSUsPC3yQ10d4r8H8X89dKI/Rjfl/DPxic6iSrvCN1a3QkkJzx//P
 jOZBHUJk/3PATmuo9xgqrO3Hs39rpA7peh3tk/H/3OQ5Qrg3hdkBK82NS84CUkr7mS2R
 1Ag2U26Scl0m+galoUQIU48hqRXxFfWq/6EzKhqP4UGjZREfWjTENwGRglCV/EYMb8V0
 BhiA==
X-Gm-Message-State: AOJu0Yx0ICojsirKIa2gMZ75wwhVmBdY5bs/BwnfV+fby3tRfiuMVBDV
 XAIxq6O3VAHNyAVWtPGhSBv+j+kYypaTOcF+nDmPnXz5Tt5AWCnGmOb12YHLtj2RIHF6YomxSbX
 T+YBSOAY=
X-Gm-Gg: ATEYQzzyb5QNrwrc7KnTq6udoo7ZoaIsVbmHl7ghIZcBDCS+ppW/RrW3HZ0dBqnXiUi
 I+qVpOtaKKJvPYpM3nAYCmhTz4MLbBp+Shwwg5OL4/ENPBRoWfZviDdH5BUaT22D/i2q66JRMlk
 JDoBq5r/cNO3nQwq5srCD1V/9UZqzk0OOghM7DEGcLoCou9P7WR2t9dWW+bIxmYjxxVwraQh7y/
 oS6GbLBMj6rNpLKTkyehNkCEaaEDvi7PQ/VJ/Mq2xbTIRfwV1BWsP0fTluVCTk6mJsb/bY6YZFP
 +/miNW8SrrI4enBJW3iF49z52T8R6hZNPzsk3if87Ah1EccWsijWbLuIm7ne+EBWrCSx0T+M7LD
 M0sYO2NbAk4Q+ueOsT0AkTtICENHsLLq80lnfokXCef8VYqRXodQMLGFzNTk+BFdNcOKiaaE053
 9Za6ZVzNG78qVddXIemvRFlxk9cN24FhCmxP2VGnVrZNuC4o2+LM54FURlj0/7Mm0cOq9SF6+aQ
 AEosBXZTVLv210fiCK0PR0htwYXFd1FzFqH3VT+BSfHVc1xK8o=
X-Received: by 2002:a05:6830:81cf:b0:7d7:d60e:650a with SMTP id
 46e09a7af769-7d7eafb908fmr2448787a34.23.1774027500499; 
 Fri, 20 Mar 2026 10:25:00 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac3e763sm2696398a34.11.2026.03.20.10.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 10:24:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com
Subject: [PATCH v2] optee: Correct dependencies for BOOTM_OPTEE
Date: Fri, 20 Mar 2026 11:24:58 -0600
Message-ID: <20260320172458.3587330-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317012452.4162719-1-trini@konsulko.com>
References: <20260317012452.4162719-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issue with the dependencies
for BOOTM_OPTEE. This symbol needs to select BOOTM_LINUX and in turn
depend on the library symbols that have to be enabled for BOOTM_LINUX to
be valid (LIB_BOOTI, LIB_BOOTM and LIB_BOOTZ).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Make this depend on LIB_BOOT[IMZ] as that is the library symbol for
  both xPL and full U-Boot to support boot[imz] and related boot flows.

Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
---
 lib/optee/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/optee/Kconfig b/lib/optee/Kconfig
index 34b9d8afe675..e0de57e29306 100644
--- a/lib/optee/Kconfig
+++ b/lib/optee/Kconfig
@@ -40,6 +40,7 @@ config OPTEE_TZDRAM_SIZE
 
 config BOOTM_OPTEE
 	bool "Support OPTEE bootm command"
+	depends on LIB_BOOTI || LIB_BOOTM || LIB_BOOTZ
 	select BOOTM_LINUX
 	select OPTEE_IMAGE
 	help
-- 
2.43.0

