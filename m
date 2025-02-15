Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F17C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C6180FC8;
	Sat, 15 Feb 2025 04:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X9HM6NxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 578C880B98; Sat, 15 Feb 2025 04:24:25 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24DFD80FEB
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d2858ce82fso262585ab.1
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589861; x=1740194661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aL0u1BDCnpBq4mo+z/jLQHv9syI3oHnKifxpBZyXGF8=;
 b=X9HM6NxIpRrnJDkm1PdwW7WVTBppApilim2rFiZzn86lQBpp3kjMizvfs89znfxK4B
 BszVY29WsO1MsZiSRXArZkDxW4xLv6srHMaauKZuBaXpfipK4Ra+jG9NIt5FMnwp0N+A
 ubqNwlNtr8xJDgdYk9xgRmeVYZupdLNrihCzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589861; x=1740194661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aL0u1BDCnpBq4mo+z/jLQHv9syI3oHnKifxpBZyXGF8=;
 b=jAeo9Xn30cd700HCKXdu9+YOYamxbqE3mbSBDNyeKgycDqWmnGma5GkpN/iRk+QHNy
 Tf0I6AQHuBfh3kQ22P8RbfNWJwH/FAPARHCHJKeRA0wya6osE1AdFp+ls+R2Jt4UyEuE
 /MupTWwmtWDtFRU1HPC7kFWnLHViMx3CYku1Xz5r08XXTCEO0CaiWhFFlx+ULDdI/Og3
 2b8927pVQMENNXw+I+rKRvNXUEmftFkpkFjslsxdVuKQhxubDl5qIha3ATnK1yad2VTD
 ynfFwHW2IxTe5iFmTDP8d/FF7dv40UMJAtdvQisuJZULMMWZWdn0UuR37jH0Q+lQxGh7
 7T4A==
X-Gm-Message-State: AOJu0YxHOOKN0hiL5dTpcp0qR4RJRZJOhFQV7yUakP4va883emQnbMCi
 WB06pZdVQ7oJ1HHp10Kkc8mHMczKwXs/CU2CEs/fyWuqCf5CEg77yZTbtVU7zGlOO/osrB7SDIs
 =
X-Gm-Gg: ASbGncsxiVEfkI5EN4QHUaidnTxyYF7mE6eBv0baS2gPchtyHb+4CRUQTe6C49OMKP2
 0CmToD3+oz5tmRFLcGDoewe2MrMiWKTh/QzeWh7rV3Pm+xBbhVYKwsClq27Bql/2AulU+j+l4HK
 5rZivCQEk5nPNfaWrAkJqftouk2ic2/bcXaHqzKVmsKcOOYs1lhCrY1ROK+lCFRUSorwCVEdwi6
 mzXp3cfH1kgkRFFKFA1XD3xFlcq7KepI2LnhBZNsa7CTUvAmog0HUwAzxh40UMILPky2O5DYhBR
 9EohV7+Uq02Q6pvSZie6LfeN+OiGeKvcixBdOD79G3Z9OxeIpReq
X-Google-Smtp-Source: AGHT+IHJzQLedR/Ry/ZauNmeP1Tc1VUV0iv6OFgz40D8NDssLiXhX2IX7u6aCLPsorN2i6LdzHRJlA==
X-Received: by 2002:a05:6e02:2161:b0:3d1:15c9:c15f with SMTP id
 e9e14a558f8ab-3d18cd2671bmr63087615ab.11.1739589860919; 
 Fri, 14 Feb 2025 19:24:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:24:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v4 26/29] efi: arm: Disable STATIC_RELA for the EFI app
Date: Fri, 14 Feb 2025 20:22:47 -0700
Message-ID: <20250215032254.4121030-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c654a94f795..db8758e6dfe 100644
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

