Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B417CD6E79
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 01:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D36BA84851;
	Tue,  9 Jun 2026 03:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oNxH2y6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD5B8481F; Tue,  9 Jun 2026 03:25:34 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71ED98486B
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 03:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bec44dcddedso59600966b.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 18:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780968332; x=1781573132; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G52fXDe61OUZ8w4hDhno/hVKOpja/Uj9tMFs2mcfenE=;
 b=oNxH2y6HBg1VlJqrnJWW9Z8K8peUOT40Nw2mLRNrDacvApxC5HtmhGdjWmPuu1HFkg
 qDnAFy9gMugg+qkEHz1S3h/GPv033xbFao5fVH3RjwFQhEZQywnjUGggTYE79fa6U867
 bFBl5Kb1Y7+fbPPdfbG0KGuDK4hcdEMJwLpoKTP3qfV30k5M7VSrFUwTvqZ0UQcf+XRp
 vWJNOqWnIPdY/yzrWpHLM0AgA36ba/NQt+7wx0B4FYZAUd5DDWUaKYtPDr2YCyzlimHF
 Nqxfr+bmM5aji0fRLLJj97DPRtOgTeqtgxNIqYBpLQGm1knx18zi8HjBILcr6OJr4Dap
 Emsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780968332; x=1781573132;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G52fXDe61OUZ8w4hDhno/hVKOpja/Uj9tMFs2mcfenE=;
 b=AFXTmE5b5ssz/ws6vhnUefXBDQ6p7T9naGoBuhcTrXv2b14R1D4Qc42gzmhousV3Pt
 f+5olxYd/3nW0z5/QAmQ6mlG9cn9iKSUE3K6oRYkHlX7BYY+fvOqcYJwiubtDLJ20aUU
 MkrTY1xqlSChjjGSqVMcNL12ZwvqX+lHWGyfXngepgo/ANPJgQ0xDciQk9tN0eLbmVXj
 3uYIauLy9M2AY31wu/pV2+4BuvtVQIxFgocrNlN0bbH17mYYSx+RGFnKOiexugYSVWBT
 v0FZCshGqijJPo/BDjhlzdqVm/Jcigh4CZaeJcd7bg9Yal73Vnxj2z+i1jFyeBDUWNoT
 fBbQ==
X-Gm-Message-State: AOJu0YzFuSLzE1eOCUTtD86fMUeSz/xADX5JC/5iyqY79MJgZE/Hwfm8
 PkZ0drfldd6142oA5Xi+8Pr5sipp01eWbvu1QT3A2Z98xvrN6PE1kVf+
X-Gm-Gg: Acq92OH59UO/REVvOLvYkTGxEvOeDktZFJnFTSIMdpP/05iD+sB2pwZxrwA5HQIgbug
 FSnK+cS8swX0BEEtVshvgrvIlhEhyhvk2x9W08JMj40X2RwZ/BioLpSlrcKIzaaa92I83AaM9tB
 dMbIfCI0fycZdZtCVAzG++3NJaJrsNS8vxMtf7VUFPkrMazqqEksfz3px2rPTJALgS74gS0MNCu
 Gv/+N46buITM6ox7mydC3gmqj9ITl4BwdOxLI3qppGLxzlR1sfaYM2IqsUyxlkAr8z7KERxG4km
 bOZ6HuriA4uQPd/cwGSGbkmgiRfeMuS9bnRaS5i7WCWQKJj2I14hPknilUiJeYngCqH51xTCm3q
 VA1zv5Kv9GN9cju7QEYR3ejOlbxgSryOMaBjt71bUzNex3j3a/mOrCtfGnIvsU6/LlnVqrBJVcn
 o+TTPx3qklcmD2sCYAI5mQMwJiKUBWD2rOBnviwdTYBMFUU3l9lOCPdFdPUa9X8B1mOkSHbXVe
X-Received: by 2002:a17:907:7f9f:b0:bcb:d018:30f with SMTP id
 a640c23a62f3a-bf372f20885mr446868366b.5.1780968331822; 
 Mon, 08 Jun 2026 18:25:31 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf055307aacsm955981066b.47.2026.06.08.18.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 18:25:30 -0700 (PDT)
Message-ID: <9123523a-11a0-47fd-a118-bcae55da34a0@gmail.com>
Date: Tue, 9 Jun 2026 03:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 4/8] Kconfig: themal: fix typo
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

While restyling Kconfig the script checkpatch.pl gives
this info:

WARNING: Possible repeated word: 'for'

Fix by changing 'for for' to 'for'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 91c39aa4dee3..c46dca60f60a 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -46,7 +46,7 @@ config RCAR_GEN3_THERMAL
 config TI_DRA7_THERMAL
         bool "Temperature sensor driver for TI dra7xx SOCs"
         help
-	 Enable thermal support for for the Texas Instruments DRA752 SoC family.
+	 Enable thermal support for the Texas Instruments DRA752 SoC family.
 	 The driver supports reading CPU temperature.

 config TI_LM74_THERMAL
--
2.39.5

