Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71E2C02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A15FB80EEB;
	Sun,  9 Feb 2025 03:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="er9Lt0Xz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3247180050; Sun,  9 Feb 2025 03:02:59 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D172A80836
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d144f1f68bso5712855ab.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066573; x=1739671373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1FiL+b+2bi6YDGKzQ5TE0O7W/UvOKkFXkHlQf3kCao=;
 b=er9Lt0Xzi+GrRef2WeJrL+6P0O9C8NGJJoQIVEtEXE3nvwawV61ZSpqXkKbjoURIM1
 29TvikWl4aUaBH6rLX8l9QoxP6FzcnAj40h91uOaJE/mGx8dDhcbteVmvYJc7Vx2xEBF
 0OcVC4FiY41U3xsMr0HvwGEmNWyMr/OWsjGO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066573; x=1739671373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1FiL+b+2bi6YDGKzQ5TE0O7W/UvOKkFXkHlQf3kCao=;
 b=EJrijYHe0KqiTnpC/IfZTb/U/3DbO5zj7IsWPDjUoQIrjxARe3x0RXdqC41/HjR5T3
 oWn6/PXfQmBClQj3gc04C/qMB09tdvwafJ+5YiQ7OSaY1mmYiZFktZ+OAE9LSnLDSIvC
 bTi7GUMEMII8jp0XFDgyBo/nA6VrId+lKPGq+y3N+w/I5n4BEjtwP5jXwhunEonMNk1q
 ZLoujz6n17FL1yBlsjlSgMUw7Ax5yClWAyn/cF+Uuxn9y0/O/Ci6K+SbBsxlyRlhpuuP
 6M2o72oiekV1e4Ubdm7rFd3zqUUm7UPFHhTD+BHKXGfnjW/Ak0K5TdLPVO7cqeFMwjMA
 w+VA==
X-Gm-Message-State: AOJu0YwJNdK8EjzR1ZPcjnjcf7zos383orXYsLtzhZHZP7GcXipQOU9k
 Xb6NeMMLcSQjEybCv5mYBwq7SaiNQ6GW8lK2fRv424WZGqqf23QMXNSCuVtmQWNecWzJVTa5ikc
 =
X-Gm-Gg: ASbGnct00JW9UB03GqCu8+lDk8cyq4QuCDJTQpDWtKBEjplCNkmL8RL07q82kPuVukg
 mhnm2Vf7afb3nPY2JvBbfcXOKmaDk/BboynQSRs4Ffp31IQkaHchw9H8OVy6CpR0ShnS/yLctJ5
 xFxuPxXxwU8SngO0J74klUIY+SWArjgxSDb4J69LI5gTCBzFL7/8eEzpr/ldGucx5FU3wblVxL9
 cSHCG+LJ8kLAlePdqtiJgi061JxndRNaiq56dT0s9f1Yf+IvRcl7yih5UuNSXtmMYBA68upUfA3
 8LnLmbNrOax8o1cjhrMTQ4m1mBdy/GmM3z8nN6IsvhwkSxNYQKp1
X-Google-Smtp-Source: AGHT+IGsC508EFalHbNCKAMN3THnFwJ9vMIDGUonh+m9T1F6sgDTT67cMVgqAC5PkrMvPNAaDliwZw==
X-Received: by 2002:a05:6e02:1a41:b0:3cf:bac5:d90c with SMTP id
 e9e14a558f8ab-3d13defdaebmr66819765ab.18.1739066573128; 
 Sat, 08 Feb 2025 18:02:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3 26/29] efi: arm: Disable STATIC_RELA for the EFI app
Date: Sat,  8 Feb 2025 19:01:25 -0700
Message-ID: <20250209020136.4108987-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

This feature should not be used with the app, since we don't know where
U-Boot will be loaded. Disable it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a55ba6b7f09..fc8870c19be 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -142,7 +142,7 @@ config GICV3_SUPPORT_GIC600
 
 config STATIC_RELA
 	bool
-	default y if ARM64
+	default y if ARM64 && !EFI_APP
 
 config DMA_ADDR_T_64BIT
 	bool
-- 
2.43.0

