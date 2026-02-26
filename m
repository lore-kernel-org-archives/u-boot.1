Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154C9FD8FF9
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 18:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4383F83E8E;
	Thu, 26 Feb 2026 19:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hj3pEWea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE72983E96; Thu, 26 Feb 2026 19:30:25 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74CF283E83
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 19:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-464bc03efd8so107852b6e.2
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 10:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772130622; x=1772735422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSauhIhG5OqKRkeDoPTCT/xuXu9QAUhQOiJwHlmsVnU=;
 b=hj3pEWeaGlxkMpPVyLj67UQLSuoE5a5r7UvJ2TQUOJ2DSWRnLOyBO1LGxO3LP3u2l9
 lUzT54IjkXlTu4k7h+pveDCRMh1+BsfT/6+wy0+eaRtfCnAQfM3mn73M4Z0JjIXULjeJ
 ADbiGiUebtlC2dXqzdtYTcbtLp61rZntBrbBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772130622; x=1772735422;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gSauhIhG5OqKRkeDoPTCT/xuXu9QAUhQOiJwHlmsVnU=;
 b=L7wxwyB1BEWCkCCkb1yiuBLp+2yKP8WDIzUvNX4ewJ/9CT4Yj0PjQJtGG0IVNum3Ux
 YZsfArYYTWcNuBBXdaIhQhFJx2mLuJbDqcb8Ku9TANQA9XmmRujcjUtZ7GVIjbzsTs1J
 bR8nw3guTT5ggVJW7s6u7BpB4oDrjeecpz+PsQUP4JnmZTSGwQXwfMk2uxwxZyreMvoi
 NmsN5lMjNxFu6NAJZiy6xam9zrY050fb/zEzISh9A58k+ySnqi/9VFWj1Iprf8wpfBpF
 d8NGFQyivFeEuFcPpkcEqICkrNJMLEoeueB6fXAx1pCxOdxaoGPsV9KetdS1+iL1BGFw
 Vj2w==
X-Gm-Message-State: AOJu0YzLLsZoLH7uvjn3KuhaMKUbvYyMiOAudTfFne846/+eKRWQlqwH
 N5gDsVM5NYpuSodUNPv/id2KxLX6cHDrXXyV9pVUmvsNOQVJGQj2zRBrOEy+89T56ZTrMgX9CtA
 AQwh8or8=
X-Gm-Gg: ATEYQzzvwuqKj/DSlG7zUJbbo/qHFqcMRcDE2w1AaleslDu7DoIO21SW9A344VZKaej
 i9lWx7rceLrHHSMekr7b0v4u7PDxlR39tv4SP4B+3q6GsmL6cxnRVlnx1ayeeItESwXIBdFjdAy
 qbAOl6S+CmszaJpvCsLMghJn7dnrMAppqH88CibaFgi8psU+TcTjcwdOJoyF0wCOVaDTz3A0Jxi
 FNnxxLb9WQek5hgl+ncs/45HhGnPAJdIX7W9InE7Mqg9C05pIoA/k+H/+tH3g0JywgbX19ASH74
 0ZEbpRVm1Zo/ckl3lwHyzU5G5g/Qu7kfFkqwM87c4x5jLw0RQnPVq11OIaHebaOZkHTuLPIJ5VF
 A7YL0JgbLxqNfC4fXJkkTsKlL+Pvo+f7Sl1b3FWFJThSqTcZRFu7P3+uRw01Fy4796onWRWwkgr
 W+1uS8QlefBYGbX79iROOaZjzjRLgnzwiJRJ4Vvp6+yqJkjVUstlIUqKTDYj9nZx5h18rBgj9Iz
 eVZeo952zjwxDyXd5KZjIiUoEzB+ppfSiOjq1E5Yj54wxbxzw==
X-Received: by 2002:a54:468f:0:b0:45c:916b:ef9d with SMTP id
 5614622812f47-464bec22928mr11081b6e.9.1772130622012; 
 Thu, 26 Feb 2026 10:30:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb3ab494sm369843b6e.8.2026.02.26.10.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 10:30:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <aaAzGKCyhtvxOX80@nxa18884-linux.ap.freescale.net>
References: <aaAzGKCyhtvxOX80@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] please pull mmc-next-2026-02-26
Message-Id: <177213062140.47104.5377150427305715872.b4-ty@konsulko.com>
Date: Thu, 26 Feb 2026 12:30:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 26 Feb 2026 19:48:40 +0800, Peng Fan wrote:

> Please pull mmc-next-2026-02-26
> 
> ----------------------------------------
> Add MediaTek MT6359P regulator driver
> Add MediaTek MT6357 regulator driver
> Add MediaTek PMIC Wrapper driver
> Enable pmic and regulator for mt8365 evk
> Minor cleanup
> ----------------------------------------
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


