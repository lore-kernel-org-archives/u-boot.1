Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BA2C83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 332D1837E4;
	Fri, 11 Jul 2025 00:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rQN+Ayjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7EA583738; Fri, 11 Jul 2025 00:42:11 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B716835C9
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-73cdce0eaffso799385a34.2
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187326; x=1752792126; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rJIfaCgi/YAPtjagFkrKGUsrMijZAVmF3BgqjMCTDlQ=;
 b=rQN+AyjsVhy3/4bBqBrFfjYbLF+8/R+hpobNkMNAljsrPRHIZKjUl4b6mfDoXatNSK
 0AvVoxE+sFCbIEkpDFhajA3E1CE8KPUUHR3rlDn6EXdk+6fVqzaWgq822/5jduSeLZFP
 /Eq4imzEvTx5FLyS7/2BdyYrZjRmcwETFkwNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187326; x=1752792126;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJIfaCgi/YAPtjagFkrKGUsrMijZAVmF3BgqjMCTDlQ=;
 b=SlqpIy/I5wGi57Vk56jwgZDaixSGJbXGcEQf+nZnJmXpGAwyD+9GfreGaycgP2sOCH
 ML9NGaK/SH5TLkdKon0nFn/lTiwje+gn94aZvnR5nN6afOpYp9TeL0ne+fQu2GRa0j8B
 w9v7IplAKPnWpigqJ5afRGc5eYUSYQQWMKkNM/AYuTH4uYBsbINf780BIfJBg5Chxo4e
 KMWpX22tnirIo661/2hvh2vJaCWO74jnT9/v9xDC57L4ZhI79vz82j8GQZLU8gIYPcx9
 Y45FLKuCo0Hmb1Y/LVAkEvuPHKU8d8eH/bfDIu8JyXCGT0j1xw4LvpDr13YDQpyTFoz1
 Ku7g==
X-Gm-Message-State: AOJu0Yws5SWPsFtezvl34HVSqGYOgfnJRMHv4LCzGF8xzMZ1WZTlSGuW
 3m/osvwTv1I7xBtMgEpmMsgcr9Vky2oh0AW3DxUppriD/SlHa2vDHFReZuuSVLAeKbHpVR6tsTH
 RL0CzxQo=
X-Gm-Gg: ASbGncvekygx29gR3El6ArYGKOJOBKj8uk83G09V1ij05OXhBvAeGFoxkjILYY8RdFo
 ZxfIYzHx+DND4thD64tdRwGYO5CDFiM51NHpur8IjhDoCoZdbTPswJRWl9Ctiz8EXuywVWSTAKf
 rFQa78twB2gvga0clUiVuWligaHDw4TJzc67Wfd3tj8CQXVQLWYSvruSeL8Ppqh14Dm2secXkjg
 In0o+oqhC9m1g5rG59KI/Y6WST5KtPKgQZVv9NK9S5pyxaUlgUlyBljBnULBmLGs1RWdf6fWU0X
 FeuClTadjAe38KZ96CLVqebNxGSx1DBa6CuZ0/Cv2sCKq+WpD6QIPUk3phF7ELeCtLuQMBSxX1n
 DYdPhLcaQQ4E7QT0TgqydM9zrYjOd2y9ioCVKRnNAgGdmxx+jNZPWwW8=
X-Google-Smtp-Source: AGHT+IHoPH/XdjHSzjgMg3XJB8MURJy/5DxSWoSnrhjxCtG0M0nAWXjIaw/nncswuOe1r2IVU1LJFQ==
X-Received: by 2002:a05:6830:6995:b0:73c:fb75:d571 with SMTP id
 46e09a7af769-73cfb75d7abmr282394a34.22.1752187326446; 
 Thu, 10 Jul 2025 15:42:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:42:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250702010554.19315-1-trini@konsulko.com>
References: <20250702010554.19315-1-trini@konsulko.com>
Subject: Re: [PATCH] common/log_syslog.c: Add missing include of <env.h>
Message-Id: <175218732539.2073260.2900195129671926651.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:42:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 01 Jul 2025 19:05:54 -0600, Tom Rini wrote:

> This file was making environment calls without including <env.h> and so
> relying on an indirect inclusion from elsewhere. Add the missing include
> directly.
> 
> 

Applied to u-boot/master, thanks!

[1/1] common/log_syslog.c: Add missing include of <env.h>
      commit: 3393f3ddac2abc4446dc1e5248997c490d08751b
-- 
Tom


