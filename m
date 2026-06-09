Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E5ACD6E79
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 01:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97812839A8;
	Tue,  9 Jun 2026 03:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pQJCIXJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34B5D847B0; Tue,  9 Jun 2026 03:24:44 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BACC8341A
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 03:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-68cebdc1723so662904a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 18:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780968282; x=1781573082; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bu/RXIEei02ztHyDIeFf5nPaBMgXenZpzmG0AUBlK6M=;
 b=pQJCIXJDBXu8ORx75eRTHPaHfHjyk1L9gnsd2Wu8f1wAvAALItItqEKZq48J2XSxCj
 8tUCRJQzkQx7FUOcW7/FG3iFP47LtHn3op1nLYGDumdFM46OwZh5t/OW7+bZ71+NDSNG
 CsBW9AIW7krPaRR5QAIxDaHcKTfCxyCjpb1UDZrZhVyP/zeS8Lcm0ztR6vInRIgwc3vf
 H8tnqovB9WQR4aevhZkesZNaO5c7sV1wU5L0hfLZzGaNNrz67PoPddnHTGdlTjeN55ew
 3a/hZJJRTFQoNoOcZ9fvODRv0hFmav26RUZYz3+yWBlhze277Ub8HbahMRhhEnH+Dv2c
 lLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780968282; x=1781573082;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bu/RXIEei02ztHyDIeFf5nPaBMgXenZpzmG0AUBlK6M=;
 b=miiP4SEe5ShvLOR7xe6NdXxKDpKZaiK2gSjHulx4I1Uo1+5GcUDHIqdVNMSuAxGpDX
 y708sWYUuqv3rwe04SBxEIUUIavkRpHxZFLtspNNePnJvvMvIcK1X/ko7ZC3MvNXynzq
 cF+jENNIERTFsn4FvSgbi+vlglhnEEEaaQ9tj4gd+fYS5e7u+/r+PWxcYKDXrVzY+uiH
 rpuFYaARNxCDyVM97WIWGP+1t473ldPdz22EtTLVS4PCNYPJ9APsw3IARqt6Wim4uz78
 sXaLPnMgbFL7C5/jM8uHLaZZ7850LX0ljfAasCQvTDaQHSEp6sdBZ/TuntRBHjbEGuAu
 tvoQ==
X-Gm-Message-State: AOJu0YxngKeqjxyEl6rD1MuXCQRhNNQR54c1IoUe1qEU4B/uHZJL4BT1
 dLzW79zkxUWHBEdp69Dosc0B7h2GO4C97GpspLTkG0EDqPHR+6I/OUke5fZabw==
X-Gm-Gg: Acq92OH9c4+CWcK41YOKHnhIO989ptTti6kaG0YPrOcsaD4yU8/PyuzBKtJnbf5haHw
 4Tr4hslI7jfWERXxAwNDFvD84abXxEO/Wlbz9pLm+vT3FQ4a8y5b0Wqc8ipwQtB/ROMZQmRwJiU
 b1H1XcN3eUom1HY3WJ6JuSMbWG51lj1scCNcajr0VUAZsaWMfZ+2QKtzAEPTVuM/jVXdyNERNuU
 N7LfXALIKHSTH02sBd47PEceBVmGwd1o4JFEY1foJEjqdbkwNzVPCEL62zo2shqYQEjgKfEk3iH
 dsaEKuktQhN0NR2asbkvax9e2E/x9QPxoYUw81huNOwYhDOt+jjnT0mJGtpq16m6w1q7+I3C2c8
 AuEuKu0RcOHF2NgJnaOdvTfJvQIgyVsGYnXIZqSQJTIxQKvAcgcjDt1URqRCEVpfKuiEZ7bVmoR
 Kmq0ZOUz4/m6It/Hrgjq8my3GVW78HXg9T8Foc0MvLWmTGa4UnW2qS4WtJEyzpNcRiDe5iOYZFz
 kyZiRw8yec=
X-Received: by 2002:a17:907:8686:b0:bed:5a4f:9fdb with SMTP id
 a640c23a62f3a-bf3737fcfc2mr431579066b.7.1780968281458; 
 Mon, 08 Jun 2026 18:24:41 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf055309368sm939352566b.49.2026.06.08.18.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 18:24:39 -0700 (PDT)
Message-ID: <1a8eb376-a20c-48ef-93a8-dfd5a2254ba4@gmail.com>
Date: Tue, 9 Jun 2026 03:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/8] Kconfig: armv7: fix typo
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

WARNING: 'suppport' may be misspelled - perhaps 'support'?

Fix by changing 'suppport' to 'support'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/cpu/armv7/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv7/Kconfig b/arch/arm/cpu/armv7/Kconfig
index 3a3c1784e188..1b72fa927721 100644
--- a/arch/arm/cpu/armv7/Kconfig
+++ b/arch/arm/cpu/armv7/Kconfig
@@ -23,7 +23,7 @@ config ARMV7_BOOT_SEC_DEFAULT
 	---help---
 	Say Y here to boot in secure mode by default even if non-secure mode
 	is supported. This option is useful to boot kernels which do not
-	suppport booting in non-secure mode. Only set this if you need it.
+	support booting in non-secure mode. Only set this if you need it.
 	This can be overridden at run-time by setting the bootm_boot_mode env.
 	variable to "sec" or "nonsec".

--
2.39.5

