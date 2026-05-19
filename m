Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81541CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D318E84855;
	Tue, 19 May 2026 15:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nm9So3M9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A6F8484F; Tue, 19 May 2026 15:35:18 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17BA5846EC
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-479ef2b7979so2756100b6e.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779197715; x=1779802515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KvdSuAbdqZG9I1mcl8f/6FT08EKNoMtAQHQ/SuSL0hQ=;
 b=nm9So3M9Z6xaTV02KmzSEFzCS8Sx2qTE6rBrmYCaJyE7byMS+SMlX7tysf1AaUmBkY
 hK0efRipF3BEcBihG4pROdTuGQAfgyhf9zKJvjVXsDAiIuEQjt7pMHDqsW7o2Y4mMPUj
 Shs0ZDOBjxDNSKmHT5ca2nr9SNfRr1/TBO5gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197715; x=1779802515;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KvdSuAbdqZG9I1mcl8f/6FT08EKNoMtAQHQ/SuSL0hQ=;
 b=leDC5VrH9sJ0tVinLG31jfQGZ9QtVNFl4U8msauAAc/lNzh+JyLrSd98rFAkSZPbu8
 zmObJ3apL5GmkkIHcbQt20nTYV3LQw09aaOOIuRCIlZ/DnwZk3goSyzw4Q+/HItEezRd
 OFAEJJ/EzwaTnjPnltwpWAGHWzg4fdqX8Z8k1sRuEwYMYn+HSEsN8nNoB1quKI6tI6fm
 bdwLQXLzlITRCVly/JQ0Je0BlGkRaXQbUagTTeQ3xy5D2rsWlHjXJ0pEqcs//oHdhPeN
 aidcAZA32DvdX5d9+sJR4cVBH1UkubyEYK9nAdRsYRVoYQPcGxPi+4JcudBo1yM1qCMD
 Vsug==
X-Gm-Message-State: AOJu0YxvduLJX+qY9NA4EUVCFVDj2/RWyaH6zTYRQevm8UJ4lYijHy+m
 7kVkliJvI03IWU8W+vkbKl64dEsHgPLRecQpSLofMAl1nHu4v7PdoqF8OaXFxbVtkmzlAweFl/2
 3GVt2GoJejp3+
X-Gm-Gg: Acq92OGRsaQ4+pCQ9XNm4KBV5hn2i7dLrUGBvDJ0co69bt+YJJ4mu4qv3wpzQTLpxaH
 5xZm+mN90XmcrN6P5s9W9rEo9cCqCRh/onQF+fElRHsxVOQB1Uc/nC1tIIfkK2eMdjgfGXp13B/
 6+sXdCvSEPgBywXWohdLix1fgd+h0oSqLskn9VSHVX9wbjpeYLp8iWDemNUmeqHGuy3oNNn2rDz
 t+kJ/XzTVgQC0HNb0FtayNBouwLIwGZfYJdcfQ8pz46e3kW9aqGy1TcCvezG8umL/NIRqiDtLn3
 XcGsUfzB0MODyj0p1VKTx74A5smAoeIzyvwQs5rbV4d/+VkSmRpVBMLZ3bkoExtLSPR53v728hG
 SmeK578ROL1vQXojL6MhOo79BwMtethbhZzzktWS77ytZTIs6FcFXZd+SI26xdMli/RWwji4tTS
 dBE416Zx1faWZmgFk6vVmmg9Qdkdbvj+EgArb1FUYbyFKBm0EaASWhtYigsM6OPv8KXO6l82yyR
 9BpWrggVOMFZsr/GvNyVFcOljM/obZ3xsyS6NBSNWaBePRXYA==
X-Received: by 2002:a54:4e93:0:b0:479:e9d2:26cf with SMTP id
 5614622812f47-482e5697f32mr9696105b6e.15.1779197714770; 
 Tue, 19 May 2026 06:35:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cd6c0sm10826569a34.4.2026.05.19.06.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:35:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20260510171604.56788-1-marek.vasut+renesas@mailbox.org>
References: <20260510171604.56788-1-marek.vasut+renesas@mailbox.org>
Subject: Re: (subset) [PATCH 1/2] scsi: sandbox: Staticize and constify
 driver ops
Message-Id: <177919771412.672258.18419077451588921316.b4-ty@konsulko.com>
Date: Tue, 19 May 2026 07:35:14 -0600
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

On Sun, 10 May 2026 19:15:52 +0200, Marek Vasut wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> 

Applied to u-boot/next, thanks!

[1/2] scsi: sandbox: Staticize and constify driver ops
      commit: 50e6cda6b6b50b43940687b32c40b7cdd8d707dc
-- 
Tom


