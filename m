Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB02E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 18:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 363688962F;
	Fri,  6 Dec 2024 19:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tLmT25yK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D25A78974F; Fri,  6 Dec 2024 19:59:01 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B13688921B
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 19:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4668978858aso20054291cf.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 10:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733511538; x=1734116338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DfPh/yWn08tt1i1N8IsqMsg4HDjstqgnjdK8PPkkTio=;
 b=tLmT25yK5IkSNs5RQGdYYRxLopDnDLXCw6O3YIhPhWNCyTkDtw42IUS/Cn+Xp8iwfb
 OtWByFIcY+bFDGN2Tll9zOwaeoGXXZy9R4wet0YzdWe6k1/S43ZUuePBZRduYHySVSlZ
 bXL8YultThGgwb+CYBi6x014kxli1sIsEEbcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733511538; x=1734116338;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DfPh/yWn08tt1i1N8IsqMsg4HDjstqgnjdK8PPkkTio=;
 b=Vf852mDJc+SWe6kF3hpOLJzOppx5s1K/AaAtwWrcWKeDmZ//g0/ahevjr0F4/0Ossg
 iQ+sC5jHyxSdMdgnxu9bD4wzJXT/HF9Tj4pQGNi6rWjHCcfSVudS1P62R6V+7/PZRD3Y
 m1KbimBi8mWSJ4rNDwZVLcSfqawFOfBYivnZwEwkjfm9fw+N0BTmS47bXEoHTYkG6SqV
 cYNVi9ylhtG3OeZVBJWC4CzMdQK2o0YskX1OkRHE1aIbODg04DroHdnFITyvPzXMANnh
 JI0QAtWu/k9TKLogUp2x+mc+EC/Y3qDWczFYYd7LRziYuqNIo6yOE/ruTFm2s1mviiid
 zGGw==
X-Gm-Message-State: AOJu0YypsfyYkQKq8c2MlRo74WpD789jfZIhSWGU7SRT6ouDzmRTrq6p
 uuZi6adlb+IFTm94raLLpPHA6akS5p/RA0UE4N5hG05Nbm/wjfrwGYmQzuWd8tI=
X-Gm-Gg: ASbGncvT1EG2KwmvmS7PneXJiAAecCiopFYh8pnUL/Jp9aaLDyJApybiQwah0vL2jt3
 sqasEqKZBaYAXMFUX4IA477lPuaZhrL2riBxDUs6+nG6iuZkOlQYAFcw+SIy/aQCpNpB2wL1Ie/
 Dx9KgSCTTvA2nEB5h79NUpa3nny2SZotQgkW0dB6pKf2UKjjpOp8yFMq1uZEYmG2DnebgzPTv62
 c0JxU6LzLtjtJ2/J6neggiPrLTWfJq2IGt9sYhKdsqlTtGD
X-Google-Smtp-Source: AGHT+IGJoHF2hVc9GimuyOpgmmgCAvjVqlOxZfBF2QyOscwArxH8pR9zqifJBnglrr9ucm8Xq/8EEA==
X-Received: by 2002:a05:6214:21ea:b0:6d4:19a0:202 with SMTP id
 6a1803df08f44-6d8e71e091emr46038166d6.33.1733511538308; 
 Fri, 06 Dec 2024 10:58:58 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da673441sm21909066d6.1.2024.12.06.10.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 10:58:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aniket Limaye <a-limaye@ti.com>
Cc: u-kumar1@ti.com, reidt@ti.com, m-chawdhry@ti.com, nm@ti.com, 
 n-francis@ti.com
In-Reply-To: <20241119003617.1871183-1-a-limaye@ti.com>
References: <20241119003617.1871183-1-a-limaye@ti.com>
Subject: Re: [PATCH v3 0/5] Add OPP_LOW support for J7200
Message-Id: <173351153682.2516797.10424930325984223013.b4-ty@konsulko.com>
Date: Fri, 06 Dec 2024 12:58:56 -0600
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

On Tue, 19 Nov 2024 06:02:54 +0530, Aniket Limaye wrote:

> This series adds OPP_LOW spec data in k3_avs driver and enables a config
> option to select the OPP_LOW performance point.
> 
> J7200 SOC supports OPP_LOW and OPP_NOM as two Operating Performance
> Points as per (7.5 Operating Performance Points) section in the
> Datasheet [0].
> - A72SS/MSMC at 2 GHz/1GHz operation must use OPP_NOM.
> - A72SS/MSMC at 1 GHz/500 MHz operation can use OPP_NOM or OPP_LOW
>   voltage (though OPP_LOW voltage is recommended to reduce power
>   consumption).
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


