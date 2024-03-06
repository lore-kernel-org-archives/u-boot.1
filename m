Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF30C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 15:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4FB887C92;
	Wed,  6 Mar 2024 16:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KDAg4lTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 864A687D9D; Wed,  6 Mar 2024 16:22:29 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E70A87DB1
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 16:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B25563F627
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 15:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709738541;
 bh=I0rbxKBVc1Wqfq0Iaj1Mxu1ojVjdekVxQiqXPTc4CwU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=KDAg4lTSiFtmZK1zkZ63lUwKIbO1vyi/NrEqveA4ODSa9U4Th56UNdtZt9eDJpnIA
 AcQveegWF4OERWH6l82ORuJZcenp5U2xP2x5jsxV9jFTsCKMzYiVYFSnNOOAKpxoDT
 6fDtJNNuSfXRvi4gytMSSfe8orEUC9zBAvgyRMgnsXNG0A5RDoaDm8T9dXvzB06rzu
 kf+mwCrFNB0gZCX8tEqIaFQ6VFefCahiLIxICFT+V1j3iFXSs4nAG6fuP438aLnsbH
 KVLAwPIBnZreN4zeOG+gAVlho2hxZOtgFyLVZFV5zDMLBbmlYDVttXjjSgaLYykfLt
 zSl+cYrM2NIqg==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a444b9dd222so434433466b.1
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 07:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709738541; x=1710343341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I0rbxKBVc1Wqfq0Iaj1Mxu1ojVjdekVxQiqXPTc4CwU=;
 b=Mvo1R65KSeWaCtgOCfrx4DRj+jCAxED4c6zzEdXO4UX2JehGRHWz64wrRH9x5So80q
 YPuVwKu7RPYOUvkKfutpnQERYVwhBIY3hzJN8U1jh+L1VGi5j9DOt0lAVW4Ao3mTgedb
 gLpedZyEXckXTJu3BI9TgYYjAIGYKWDybhPl+9BUDJUP8ticwLIkyP6JY28wcVzlKCk9
 /mIfryTleesrpFpRYyXhnl4yZq2HULXTBeif528ulPLEDVQQpb2VyvbwDUEI++pckNxI
 fqlf8gFWb0AGAT+094amXsE5zAh/7pqx1sZzpY2JJBnhC7EPd9jzOCBvXfITUNAJTM2G
 eXvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKtl5NwEf0+no+oQcSNclexHKwLKNpL2Om4yk+/TKG7lNBtBsFBIxvrkONPx7jMuzA6B6G6vr5dOju7QVoE4vFPH7k0A==
X-Gm-Message-State: AOJu0YyxUP3wGtO5O30Y+t8iCHvJSOQBzzZaVqUrnaGHXwatCbv1Rc8X
 EnX6SwMZYFMtykNeHpYEnAtYst7IQ790m1MMWAbvchVy7AptrxSa09vOkj/GTUHvWZ1g3RY7QFy
 aIljr/VSRyrWBebp4PXzXkQeRBfMITWGqQ24UxlgyMHnfG6vxvLBA4eWKLEO5dvy//r8=
X-Received: by 2002:a17:906:1355:b0:a45:8850:1bab with SMTP id
 x21-20020a170906135500b00a4588501babmr4898456ejb.43.1709738541353; 
 Wed, 06 Mar 2024 07:22:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+5MfVutbhd1BhBJOK9u80s9ls9W1DFtuUfqxOa4wm2KLfzOFtFIRT8DSo2RyTxPaT2GqhzA==
X-Received: by 2002:a17:906:1355:b0:a45:8850:1bab with SMTP id
 x21-20020a170906135500b00a4588501babmr4898439ejb.43.1709738540980; 
 Wed, 06 Mar 2024 07:22:20 -0800 (PST)
Received: from workstation5.. ([2a00:20:9:393f:a428:922c:8eea:8ca7])
 by smtp.gmail.com with ESMTPSA id
 um15-20020a170906cf8f00b00a443e6f9403sm7256291ejb.54.2024.03.06.07.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 07:22:20 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: sbi: formatting PolarFire Hart Software Services
 version
Date: Wed,  6 Mar 2024 16:21:49 +0100
Message-ID: <20240306152149.180561-1-heinrich.schuchardt@canonical.com>
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

The 'PolarFire Hart Software Services' SBI implementation returns the
version of the incorporated OpenSBI. Format the number accordingly.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/riscv/sbi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/riscv/sbi.c b/cmd/riscv/sbi.c
index dec7dd651d6..628ef3a591c 100644
--- a/cmd/riscv/sbi.c
+++ b/cmd/riscv/sbi.c
@@ -80,6 +80,7 @@ static int do_sbi(struct cmd_tbl *cmdtp, int flag, int argc,
 					break;
 				switch (impl_id) {
 				case 1: /* OpenSBI */
+				case 8: /* PolarFire Hart Software Services */
 					printf("%ld.%ld",
 					       vers >> 16, vers & 0xffff);
 					break;
-- 
2.43.0

