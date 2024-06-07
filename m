Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26861C27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 20:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 645ED884A7;
	Fri,  7 Jun 2024 22:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gPBrtykn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41BC87F6F; Fri,  7 Jun 2024 22:42:58 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC870881AF
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 22:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a68ca4d6545so457477866b.0
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 13:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717792976; x=1718397776; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FcrE8SD8q4wDBcNtoLpXR9HjIyE1zGfovlcus/qlims=;
 b=gPBrtyknxK4BSFUEbkFGTpr+8hZL4NHZctzjZ7DwjHzgAbYA9mmjvnBYh78jtMeNqY
 S9PGUw0ImycowCYqoXUdmHwtXBPvgV8fFxrpdQImiXKInOV/ZCgsPxaKj2nABdCmDj68
 I6qzVo7DgZhFdLtpMTTi22SxImr5UfW1yNKo6yB13RqINEdkZt4oYYSL/sfR+zNFUKS6
 htE5ElO9pCoAWE51YDw7s12O05mH9sioOBRCTRc8Gy0Expk4fb8HDBbzQkCdeoPi00qD
 1RMkvYt3KAxwnhP8HT/Lqk+oyqCaeI4UH3KIKpbboJHfp0vnCORI9/MBtitaz+Y/e6Ei
 zaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717792976; x=1718397776;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcrE8SD8q4wDBcNtoLpXR9HjIyE1zGfovlcus/qlims=;
 b=VicfLSSfELgQ3SZ32JhwF195pvakJ8xHv9C+JPzGnEAGalM2J5SDnmzDvsYN7tqJnh
 T2WFHLkv2dSPSkjfZibncFZeyxMFJKq0rkPvi5oDdsuWxg4eCrWen6DIaj3JEWmLSQKQ
 nz9qI3b4h7EGMbACGokij/uVFlqyTrgfeSCMI9FoCewD6qLHJtSFqsC8ABMKiCcIooSt
 BtdJYJsbuEIm0wQ5UWqTiqGUaMjfE+3d12CgTpnWqWypYrF1p6lGxQSwy+3bp7f46euy
 RKrH4qB2mgYMwXAyB88LjCVfjK87zLq6kLPgdH16bhNKdc/Sd1C6iCjD6VKXE24JpLDs
 BjHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7WOE9LrsfIu/uSeLQbLCSHDEgBP+oKd/Ls0VB5huTlyLJ1DCrDOQW1R1KnnsWZZpOKQGAPqXjR5usPOUsga7XuaIZgA==
X-Gm-Message-State: AOJu0YwkBDsBJ2k1sfI97Uu1fc2ER1P/tz0hdEi4rwAutIM+UOK41aeB
 8PVKPmMPV5Z3ArUTDw2S/uwP6QUdrHP1JWDeICEPbqATov4v1k5iS/LeOrimyTk=
X-Google-Smtp-Source: AGHT+IH4TDYFOUZDCdsNro6phasS3v9gkvsBDm/9CCTbys6WONEPCKM1/iwXiM4703C0S6fP3vhymg==
X-Received: by 2002:a17:907:7818:b0:a69:3fd:aed with SMTP id
 a640c23a62f3a-a6cbcccbe5fmr307013566b.32.1717792976178; 
 Fri, 07 Jun 2024 13:42:56 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80588851sm300766966b.29.2024.06.07.13.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 13:42:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 07 Jun 2024 22:42:49 +0200
Subject: [PATCH v2 1/3] arm64: mmu.h: fix PTE_TABLE_AP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-caleb-upstreaming-v2-1-bae407f51f22@linaro.org>
References: <20240607-caleb-upstreaming-v2-0-bae407f51f22@linaro.org>
In-Reply-To: <20240607-caleb-upstreaming-v2-0-bae407f51f22@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=757;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=e1xnCDVDSraolIJhnHUmQGQpqz/i168ZLEa3Z2JGSc4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmY3DNhlAVaJxhjawwZ8bCbycDngCkw0RvRqukd
 34PImRHhf6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZmNwzQAKCRAFgzErGV9k
 tg6/EACKow8Ts27bdvHpV1Rf8LElKobpNcsgsEyiM206qdP8wJeO8k6XGCsZ/Ju3gib/IpV4g4D
 X0i+0YIXkzNaTP0JfEZpRH08JZWBOveCaGbLJ0cA2KClbuvwFcxOiRgzN0feAPHZKSdqhDOVElW
 MaOBtLMjDRpdclLN7L4Bc4sfYdq7u7+XUT3iq78AhBSyYVsd5/bsKmluZ788Ga7VpdW/p8u2AKw
 gEJH1E5g571rrDBed4Nehc6bgbtYwG9ZdDrSc+A15P7unZW+8MigZYEegoO+0VexJduWYpo96lI
 YxpBdteAoc8POWUTn1BwtX1Epgu2nbWGI0qnMVV+aioMRU149ML+iXoNPz+R2JB2JeT3zxhWmaR
 9d60LBmoiLr0HFSNoYYhmoTnPOqVjM7r9a5lCZO7/x1BR2uCqhDLOZnwS2FGX2CwhL9/i4oQ6WT
 fKVM+UynJeDevgrV2Ohzvu7rGjD0beAF0t0a4pagV5Iick2S1LX2EZ9hv3vy524eITPcPSZ4uZT
 JkJr0mtvBfV82RwpDoPsSUQ9WQZV+kHx+a+Msm4ZmtguYjIyxd/Ps6DlgofuHXDD+cNRyk7qsf3
 gae7/EcfcJAhrubpoQLFqY0/jYnrnETMaAC0u+PX4Zvn2ba5NuS42RZTqfoXF1jrwZ/INFz7Ny+
 t8uLMAyxrEbHshA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The APTable attribute is two bits wide according to the ARMv8-A
architecture reference manual. Fix the macro accordingly.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/include/asm/armv8/mmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index ce655ce7a952..52cb18b9ed5e 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -50,9 +50,9 @@
 #define PTE_TYPE_VALID		(1 << 0)
 
 #define PTE_TABLE_PXN		(1UL << 59)
 #define PTE_TABLE_XN		(1UL << 60)
-#define PTE_TABLE_AP		(1UL << 61)
+#define PTE_TABLE_AP		(3UL << 61)
 #define PTE_TABLE_NS		(1UL << 63)
 
 /*
  * Block

-- 
2.45.0

