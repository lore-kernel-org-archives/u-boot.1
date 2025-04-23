Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C388C369C2
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 01:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8243680F6B;
	Wed, 23 Apr 2025 03:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="csF9NuUQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B56C680FDA; Wed, 23 Apr 2025 03:49:55 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A0080F9C
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 03:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-400fa6b3012so274754b6e.1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 18:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745372992; x=1745977792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DnUnAxx7KAuni2A7yzbMaDGvI1C+XePkC7NixviWNKw=;
 b=csF9NuUQv2J3NsCwhkvm05dLp+nJoXKRUF4oWlQOFczWbbbm3LTA+vdIcbXt94onnq
 5iUsv3i3uILuWXkOIey2WhAQofkPQcNp1IgO2ZxnLc65eJCHkdkg8iTMaB5/Ebrsq6Sd
 zLYddWSyx63Vi6nGtCG6EQ1qHJtsNn2Jw79qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745372992; x=1745977792;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DnUnAxx7KAuni2A7yzbMaDGvI1C+XePkC7NixviWNKw=;
 b=GkMWAUiJx96pdn+PfB6ZW0Ld1gey4tMSCPvjGTTQ6JqAspTgLDmiNZP7jcz/EWhs+G
 9MSAMvwJobbFlIGB+FJkUKq98YYnuNvLa1XaArDkmt6z6lMZ5IVYORyoodF2BLh+IBz+
 k2nV5X9Fr1zggVFlL7/dX533LML+9SdifFKjJ6uQmugBqmY8v6whOE+eW2RXFRoS905s
 4li8z6nfKBpRPlyz5S3IAZOklckqv2f36W4gnJyIghdBocw68RGqGvlUjVIAwtG3BUzz
 hVOGgdtjIyA3yNgtV+yBvi1Gf3dKkmaWalv+rbd6b4kZfrJrHu1W1MMMauq7FBUlJmQH
 BoPA==
X-Gm-Message-State: AOJu0YzG54OqrqVfR/X15l7a7kbpI8HM43slfElxGT0Sm/730xKGe7ZJ
 IECpQaNC7XMIWNOIJ2czIvA8Nh2W5lZW1a9dFTWvyHNXbQj0ChJIcqkZp0yxw/H35WZMNEApnyl
 Ij3k=
X-Gm-Gg: ASbGncvsp2KcVPMYlxUgM6xhoXTUqTSYH78q936pZoRJ3P4zXDokHHjY8FY8j+RnsTk
 cQ4Bi0KEso/h783tls5pVjWFCDMnfX/MrXldorNmdDB+hgkVpKfDKt83zPzj74VJhxBfItBu8T+
 gbk1KZS0cRP6aAIm06B4spUVLaLDFIsfcpBTRsu9eWBiGeN1dSQU87YyOUwwCPTX1la9xbHRoon
 sq/v42kL+Yuv/a90J/AX96pdKtiWYPrfQdj/YpUxBM7Z2O2pQKjtu/2MgvU5LPCyaaROl0pd/rs
 7jlKa5DYIOEBPhSCImy7De0JbWJMmhiJwgzt08Sdlyo6unH16YWpH/519Sq/aXRjikI1tI75ll5
 e
X-Google-Smtp-Source: AGHT+IFD3WZQ+ZhxkfPVT+fEMI9pNzM9+jLHkUMc0zNQXqq0Kozxj0yZqJCHswdLt0CbhuNT+H9RZQ==
X-Received: by 2002:a05:6808:164e:b0:3ec:bf55:e33f with SMTP id
 5614622812f47-401e407da25mr592807b6e.9.1745372992440; 
 Tue, 22 Apr 2025 18:49:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401d9e94fedsm961358b6e.1.2025.04.22.18.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 18:49:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ezra Buehler <ezra@easyb.ch>
Cc: Stefan Roese <sr@denx.de>, Ezra Buehler <ezra.buehler@husqvarnagroup.com>
In-Reply-To: <20241023132731.420801-1-ezra@easyb.ch>
References: <20241023132731.420801-1-ezra@easyb.ch>
Subject: Re: [PATCH] mips: mt7688: gardena-smart-gateway: Increase
 CONFIG_SYS_BOOTM_LEN
Message-Id: <174537299127.3850697.12065355748367387753.b4-ty@konsulko.com>
Date: Tue, 22 Apr 2025 19:49:51 -0600
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

On Wed, 23 Oct 2024 15:27:31 +0200, Ezra Buehler wrote:

> The default value of 0x800000 (8 MB) is somewhat limiting for us, as our
> compressed kernel may grow up to around 4 MB. By choosing the commonly
> used value of 0x2000000 (32 MB), we are definitely on the safe side.
> This rather large amount should be fine, as we have 128 MB of RAM.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mips: mt7688: gardena-smart-gateway: Increase CONFIG_SYS_BOOTM_LEN
      commit: 4446bc331c65d3efb8a9321d6368c61edb56479b
-- 
Tom


