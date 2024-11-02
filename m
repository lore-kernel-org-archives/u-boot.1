Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDD8E67816
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 22:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B003892C6;
	Sat,  2 Nov 2024 23:20:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DazdcxxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B188931F; Sat,  2 Nov 2024 23:20:55 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A61C892F0
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 23:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ea68af2f62so2350061a12.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 15:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730586051; x=1731190851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jdss8yE2/awIEEy86I7YaeWMYJdbjKgylXCFi3piogU=;
 b=DazdcxxFwDlgwiRMKyZxCWQoFKia4FW83IWtWajL+HI7qb+0s1mK4ou5Uy2uAPI9fP
 jA3EPjvqoTcAI8zzBsX3j9cKuIDzviqiGZsawG5oKjctsAN5sIhnI9uSMDdfgbZV7YZN
 3IGvNpAWFkx9RzKY/MgDtKvHvRgmmw+a5Sn1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730586051; x=1731190851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jdss8yE2/awIEEy86I7YaeWMYJdbjKgylXCFi3piogU=;
 b=Dz2ITKjJYFR7A5DMNvl39XJ92euyPZgvN9u8xOzL8KNb/Sgj/fQ/T+s/WikMTH8sd6
 RqsIisPZRzsKJAYARrzRu5wCONBeusUujHs6SZywkyHRKcbeL5VzWPPu75LgsL/toO2I
 NE0hF9tcMAv4SBGZ6jdX7Z2nWrZyTOT7SaXlCvR9LhVBmwPBj+/iFyTzKPXZVa93lzBI
 r1sMCRiTG+owemAPXr6nFS3bw8X9p70O+87sC9/NMxlcRr0G4GssuZTSW0FsfP+7jxNy
 qfBV+Q3jLw9ij3uPMp/SJwix4MzkDM+Y9XlO79zHdZqm5wvfV3+mlmZ4Zz0kYJ9SLAME
 u/cQ==
X-Gm-Message-State: AOJu0YyBdCoU8um3sC/Q47hNUJa1OLJ1dYRLmR1KwHcBQbXDVuFkYMyy
 Vhw/HOZmCXnc/FRRJe7lsj5KodEAFJKuA/CAZhMOkKBe6MjVGeVadMbdUOLPzkWpJhXWY8knuhu
 iDw==
X-Google-Smtp-Source: AGHT+IGw+eLvJ2litcfKIGd3rqUmASUcWg+CvnRPEiRIBMqzoF1loEAvbPlR7wYofoNLISVSf0I6Pw==
X-Received: by 2002:a05:6a20:1588:b0:1db:b780:5a8c with SMTP id
 adf61e73a8af0-1dbb780e3a1mr5859549637.20.1730586051265; 
 Sat, 02 Nov 2024 15:20:51 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm4386286a12.59.2024.11.02.15.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 15:20:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>
Subject: [PATCH v3 06/25] arm: Drop old LED support
Date: Sat,  2 Nov 2024 16:17:04 -0600
Message-ID: <20241102221737.547938-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102221737.547938-1-sjg@chromium.org>
References: <20241102221737.547938-1-sjg@chromium.org>
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

This has been replaced with a new LED framework, so drop this old code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/crt0.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index 3e4906e273d..a691d844847 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -185,10 +185,6 @@ here:
 	movne	r9, r0
 # endif
 
-#if ! defined(CONFIG_XPL_BUILD)
-	bl coloured_LED_init
-	bl red_led_on
-#endif
 	/* call board_init_r(gd_t *id, ulong dest_addr) */
 	mov     r0, r9                  /* gd_t */
 	ldr	r1, [r9, #GD_RELOCADDR]	/* dest_addr */
-- 
2.43.0

