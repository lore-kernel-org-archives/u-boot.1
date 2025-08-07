Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DA8C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 22:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA2C483CCF;
	Fri,  8 Aug 2025 00:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oxECZ83o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C648483C93; Fri,  8 Aug 2025 00:34:35 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCBF383CCA
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 00:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-610cbca60cdso738840eaf.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 15:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754606062; x=1755210862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5oxoKB96RqYQlBSH7W7Dh/e2anWugV5TN/GwGvbXMCQ=;
 b=oxECZ83oToKaVSNz3b1b/5HMC+YJb28X8oxzoQcf4zQ15ru2UC9hqCr8/VQiyf37Mi
 OcJfvoixcvL1yaLveMFq8Gut58z8SOG8t/Buf2JSlPGCMreY7mtqQl09uZlY3AmkATUn
 jZs2Zu0WnstP1awVTwUySJfw6ljm98DOI2r0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754606062; x=1755210862;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5oxoKB96RqYQlBSH7W7Dh/e2anWugV5TN/GwGvbXMCQ=;
 b=ufu+P5Ts+uHL8iOnxTzHo8Fon1YkWpeYRkBCg6keDkoF2xlcK2psYIolTWsHo+8yy2
 RlrVLLl/9Q/74VPtITn/NN1Gc1Zw3HcwN/esDIG8e2mloY4vkEEkzht9j5HByzezq93U
 qTWiHSUHr57T/oAuIZ5Y66HoDY+SOkfJbqtDZ2wSZ+qOxDt/q8tBAaCq/NRoE5fMJnC+
 9RRJH0XcWCfzU11cz9MGq//TNRcW3WAh3OGeqPG8Lz9jZF2Omi/Nz+Vz709PMl3DO9Nq
 1OPljCRfmT3nl8ZjvXSSPiZSQDolaDycOUnMRCcTv1R4rba1hzIDOurwROEZD6Rdsul6
 Wnkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtyH253xF6RLp/0Cr7Em1Z8/E929/LbsnKJNu/26qtvEE3VEp5YCfh10910ZKtovWjmJoRWQo=@lists.denx.de
X-Gm-Message-State: AOJu0YxpKwnV99KTDTYm7Dc5KS6hteMOTG/SKb+oMO8sABC5MemOOAqE
 9zEWuN9ObSK/RhwcB7pwyK88xgxvoQldRMhlIgfDSVptLfb3A6nU0DDdr3GH1Pws9JwJLdjVJTy
 tywvRIR0=
X-Gm-Gg: ASbGnctL1n67QlS71RIprt+mvRGiosQMAqi8i/8q65bQGKarHO/LgNOxW9i7BUIn1tB
 UUwfma5cGmYvvr0mQxDfQ2ELyEBJYSf7rc7XwvzX3Kbh4hynnHTWUca6NMqu1omL8syvxsV4PIy
 wucu6Gnuvll3aAZvMYybrYZOIWAn9/zaV5t619fGyf0iX8rvMKFqiyoHyF5dxxKqFHkYqegdRRv
 n489SDwm9XbCsJnTZ84Vs2aRqNV8PQIoY7KdePAUIryzuVT5XtvZesbbAG9LXCzmXBO4tEJI6Sd
 1T1SSQZNDehUjOjX42ePwZI38tz6LcBlJCALlK9zcta9q1ZLZE8QbqBZLBbo32dqsNPiToeZcm0
 IWaUFG8YNHOVHrei2FYVuXcFv+rRrE6SfskvGXjo63HtrUhAAU9BvEIg=
X-Google-Smtp-Source: AGHT+IGg7N5WSPO+48s1L4NSxdTZt3yK24LaDA9JhWPT05Z38ucV4qXJfxI/VRlAJYTUEsiqGCRu5A==
X-Received: by 2002:a05:6820:151a:b0:619:7d9b:3f0b with SMTP id
 006d021491bc7-61b7c42cd30mr354823eaf.5.1754606062651; 
 Thu, 07 Aug 2025 15:34:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61b7c6eaf6csm73309eaf.0.2025.08.07.15.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 15:34:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ying-Chun Liu <paul.liu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Will Deacon <willdeacon@google.com>, u-boot@lists.denx.de
In-Reply-To: <20250726061758.96768-1-heinrich.schuchardt@canonical.com>
References: <20250726061758.96768-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] virtio: fix freeing of virtio ring buffer
Message-Id: <175460606172.3039738.4796485286744205199.b4-ty@konsulko.com>
Date: Thu, 07 Aug 2025 16:34:21 -0600
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

On Sat, 26 Jul 2025 08:17:58 +0200, Heinrich Schuchardt wrote:

> If the allocation if the bounce buffer fails, virtio_free_pages is called
> with a random value from the stack.
> 
> Ensure that vring.size is initialized.
> 
> 

Applied to u-boot/master, thanks!

[1/1] virtio: fix freeing of virtio ring buffer
      commit: 4b97de0e28fc215d3f41bb01f3410baa5e9243d8
-- 
Tom


