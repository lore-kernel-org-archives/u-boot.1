Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4FBCD6E49
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 18:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B9D784857;
	Sat, 30 May 2026 20:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="avucTx0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F0A846B4; Sat, 30 May 2026 20:37:01 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30DD7846E6
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 20:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e612d0693eso7098574a34.3
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780166218; x=1780771018; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T+mhZQxnja5uw9Le78cKBzaPIhXAAps0GyCqX3tkqS0=;
 b=avucTx0aiVuo4gbsRsEISw2dGe3uQhnCGQi3cASA3NM/LdCMia/7bYiJ6RUDK68hu3
 b73eK0gMjySZFNIQ4XBdRAgsV1IDn68botbXHUONByGW+EYsYgB9PQDU3ZoLpDytR2Cs
 UUhB11Ovb/bJcXdYaEUiLuzp+UeFMJ5kMGxsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780166218; x=1780771018;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T+mhZQxnja5uw9Le78cKBzaPIhXAAps0GyCqX3tkqS0=;
 b=gvbM/dQxTrp8SnCmXZKgWfvz5FQG4JhhQWKfE3jBHdEhFmu42xoBKnpwSomWS3sE8f
 VpUQZ3sAvucNsojCKXTao4JmKOKZ+J38rjytNwLMZDvKsbnfoJXh/YrjqtrUs9haq4We
 LXIgZePgWVjPj2JjC+WLwWf/SVkXI4gMLh1omvTrZUW9S5tnr8e6EooavAHWWymB97zN
 yPhd5GBOxcepznrXLjIE+YBrk/L+8Rp+L1N66Otbn/SZLFY84C4/7/uryzZLP+0LJgSp
 mCoy8hdQnGgQnU/eOklmXV3wv9cZMEm7oQ2rqVgflnNMotBVypDKCjtqgO5mTvRgK7IW
 mFug==
X-Gm-Message-State: AOJu0YzVjRjjzvH0OgV2WIkJJMHthJ8kyhAFzIgZUMS34VV3933kqAzb
 96N+6HS4SeWskmaq7UCg/2eDH3q8dPxZLZgoQ6KYHFfQ6uR7LhnUxhNrl7+a69Ym5aacXPDoxHI
 HjhEbu7k=
X-Gm-Gg: Acq92OEF+A65UnK29tXcTWoeRQUweHgQkfW60RTMk1KV7UlDLJDVgHOEmeQW0ZvwDqC
 jS8vthvt8VER3JeRV+i+Oat3OvBm5zy3fuPUS5DH6zeakXa4VdqDY2jGKaUp3be1b42uSofiuG3
 Gh5NxQHX8yYP0mpZE4PM0xmDlNQxaKEsvbqgAPscUbSexwQt36e0ld/n/O1RtzuYb1m2lE9WM8J
 yKJnJPLKAh+2ndgPCbV8lhiCMFK8HPihe+vLLS7KaxFDt4kozG4OjSbVoSfIeKPQkBL7f6Y4afV
 imLP0RAYLhPQmvunztcY2vZM5HprVEt9m3483pkWNtvQTyC1sHTXqz7c0ufuxtewm/RV40y4RpN
 qJe1R49ebZboRy00TIRYKVDevuURQ8rxbnU5GBtb1sODvrCzgbZibUt2LlVCCDmLoX46EuiiYCH
 /Z8NOivvM+3Ix2by3Mn7ZqpuQws7dmn5Yizm7S3PRRlj0NEHOZpeBkocx9EwFjZjhbcmhnnLZ/W
 n1HOY+jAaujOD3WXbdpwWZO+s5cjpwAvbSwfCswZc7M6yn7CxQ9Cio=
X-Received: by 2002:a05:6830:4192:b0:7de:42d5:6243 with SMTP id
 46e09a7af769-7e6a1d65cd3mr2757437a34.13.1780166218009; 
 Sat, 30 May 2026 11:36:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695b8f662sm4245130a34.4.2026.05.30.11.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 11:36:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195311.2363654-1-trini@konsulko.com>
References: <20260323195311.2363654-1-trini@konsulko.com>
Subject: Re: [PATCH] video: Correct dependencies for VIDEO_TIDSS
Message-Id: <178016621752.1038765.6787531911681940595.b4-ty@konsulko.com>
Date: Sat, 30 May 2026 12:36:57 -0600
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

On Mon, 23 Mar 2026 13:53:11 -0600, Tom Rini wrote:

> The VIDEO_TIDSS functionality can only work with PANEL enabled, so
> express this dependency in Kconfig for all phases.
> 
> 

Applied to u-boot/next, thanks!

[1/1] video: Correct dependencies for VIDEO_TIDSS
      commit: df08b27590d5c4bdc1bd644a6bcb8c0dc964780f
-- 
Tom


