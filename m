Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEBBC77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 23:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4867382D83;
	Thu, 26 Jun 2025 01:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pfybb0kO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955CC82E6A; Thu, 26 Jun 2025 01:52:21 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C8A82D83
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 01:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-404a5f4cdedso111082b6e.0
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750895535; x=1751500335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prNlQlykrL8sO3AaEAcA4H6ygJAAFSqz9X3ULnH+ZCQ=;
 b=pfybb0kO3wDxGG8oySEd9o8t+3q5QwnJ3Ah0Up5WSqSBjcbE/tZxWUwokZTcDUdpUb
 NVuHafcZh2OhMgOoYK/9IDAExPzMBlC3zuxmza58+vBHW1vT9rZThNuMKDcRzl0pTMgt
 sERLFFjBLsjxP1rwxfflEEfBOqMt2iutbt+S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750895535; x=1751500335;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prNlQlykrL8sO3AaEAcA4H6ygJAAFSqz9X3ULnH+ZCQ=;
 b=Fb0oVNzPfaMk0MH0JDsMWd11fnczI4io9LSRDpzuFOw4Pcs1oznAuJsxzxszHe8asc
 GrBxK8TIfk24hc01d3vvVw3lTzPwTiV5SHJHzEwJhryNs/9+UvkwJpnzxOpZTDtaKwL6
 W/EY7K7XwX/IyLH04UiKGIsO51pq+UeKtdjdp4vj1PdGRX3YsZD1uDR5syIWxleC/koW
 br5EWr6aTyIDeUbJJ88i/haBQjv96rk0Ss6guxvgBuBYUP5ebuXjPPe6aRelkT6FCbs3
 zyp5GsG6p2CVskG+SZMTjR15qu5PrM9rcCOzq80CcH03hlZ5HvO+tZPBeTpWTSXpkbVE
 +k2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNGtRWeN0X2hYUntCiVyAURVmpWm55CMmOTiRHF4msOFR1qagRF2t7rRhsMRzy0OaUq3DRZUc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5sFJ9IHaM8/kCWuQFfGPDfEgmCK8lvm/ThQfwANrztr3+XR9d
 Huf64KH0RZgLy4Yp34iDXahTDOe4Xq14ZjxfI7XKicQ+n8s8oBL+BI32p3AItfhHckw=
X-Gm-Gg: ASbGncutju4UScmXiiUDEhbW3EK0g0RhEuLtrxuly8aNGx0wpcIveN0kJ7QbAvIafqn
 ryCEYMwClQfTkU+mlpo78Lla6h5GMVbuP2q8k7WS2cYsyyKloeXPfqfWt0kFKCJbMziXepFgoRg
 hW8GKjrF6+CY8e+7E9E5GTeLKNrqQSEObPmcPlNktOWxbwuxGbhnGC36qYgwsjzaGprcjIRx69k
 Q8ewA6OEeWRosqjJ61zbdFRLAHyg7i26Jgavjfs7BOtWuakfDNXRXk7QrBH9nNE5cdc7k1RFOBm
 EChcTqSlX1alpIpcMXDHSk8o8ZFpRW6skGnizjhOUGhFMTKx2Ox2S6hDmFVhiPCX4g7s2SvfZw0
 8HaVxNDNhzHV7H5ocVRyb8SHop1CTO3am
X-Google-Smtp-Source: AGHT+IEWGJ7gjD0E21CRvCGnhwomAwWGhMR761y9sF6afPmValdSc/OdDKMHUrebLUcPkc2jQwWd/A==
X-Received: by 2002:a05:6808:1783:b0:402:b0f:4ccc with SMTP id
 5614622812f47-40b05bb21f4mr4400084b6e.16.1750895535451; 
 Wed, 25 Jun 2025 16:52:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b6b3052sm1751134eaf.10.2025.06.25.16.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 16:52:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Matthias Pritschet <matthias.pritschet@itk-engineering.de>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, 
 Joakim Tjernlund <joakim.tjernlund@infinera.com>, 
 Simon Glass <sjg@chromium.org>, open list <u-boot@lists.denx.de>, 
 Jamin Lin <jamin_lin@aspeedtech.com>
Cc: troy_lee@aspeedtech.com
In-Reply-To: <20250606073425.2688710-2-jamin_lin@aspeedtech.com>
References: <20250606073425.2688710-1-jamin_lin@aspeedtech.com>
 <20250606073425.2688710-2-jamin_lin@aspeedtech.com>
Subject: Re: [PATCH v1 1/1] lib: ecdsa: Add support for loading ECDSA
 public key from FDT
Message-Id: <175089553397.1525333.12672000670713374461.b4-ty@konsulko.com>
Date: Wed, 25 Jun 2025 17:52:13 -0600
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

On Fri, 06 Jun 2025 15:34:21 +0800, Jamin Lin wrote:

> This patch adds support for parsing ECDSA public keys from the device tree
> blob (FDT) under the `/signature` node. The public key is expected to be
> defined using:
> 
>   - ecdsa,curve (e.g., "prime256v1", "secp384r1")
>   - ecdsa,x-point
>   - ecdsa,y-point
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] lib: ecdsa: Add support for loading ECDSA public key from FDT
      commit: ed51f3e446f2ee9e2fa6577388451a93122b6551
-- 
Tom


