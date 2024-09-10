Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4389FEE01EB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 22:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21DF589149;
	Wed, 11 Sep 2024 00:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qjafIZzD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C918913D; Wed, 11 Sep 2024 00:38:43 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92EEF89098
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-45812fdcd0aso2884821cf.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726007920; x=1726612720; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hqk2bY98sunwJlsrg0lbVKJDQAhHPi1NUWJ4qw4305Q=;
 b=qjafIZzDYv7Ykn1hI+QToTCacEwMRapfSPA+5c8aeOpIlR7VgpyLZiSQUFAIi35C9C
 w8M+MhsEqNx9qAvj3ZHlDvbvZ0yR60VeK0pzRsEy8XvZtknStfFd5YlQ0VrJnviOyqOc
 J6ArKPzDp6/r4vsbdezdrm/AiJB5iCDiULFyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726007920; x=1726612720;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hqk2bY98sunwJlsrg0lbVKJDQAhHPi1NUWJ4qw4305Q=;
 b=TshDlCHzcf/ia1dGlDre2Zg4Pc/vOsIW+tHpQ9vMw0ESnHgqVT0d6PRMTHi/sB4aaM
 LX86PklLRA141CnFMtpxpN/a5y6j2U22bjueXwgu/cq59N1uzBRFsLhooQ/Lpes4nLLN
 ubfMtroJO20GEMsLevyxiiLK5w2eSMtNKnBaOFPCUsodODAk3m6/jvFCwW7CQbPdtxhP
 Vdh5m6CfXQyM2Jdx9BF5s+L/nKQaEtIR91zMVkdAZwXZrqj4I1ksWIu0sqiAx77W/8MH
 vFt8c746qPcEjlPGS/YOpygEHXU50or4hBvtrDvHGvjVgxKrdT6jl59WHwd0kBMoIt4V
 siTw==
X-Gm-Message-State: AOJu0Yy40XRapvIx3kDOZSU+yUUtVItam06ytXImuepBLFuWSPGqh+bT
 N22Kcp33pYBH/da6G0PrkkxROL8BHadrFY+gbLaEVshLLLUwKV6LvzAVRUjrQow4R5bByertrb1
 bwnc=
X-Google-Smtp-Source: AGHT+IHTwE1YCwlEZhRZBdm5s3bZblYRYkslyAlH9MFu+ZVr4/HWVgyMUZvOIQ/CXx8047Qvxi6/eQ==
X-Received: by 2002:a05:622a:47:b0:458:27cb:a5e4 with SMTP id
 d75a77b69052e-4583c67e2abmr80575931cf.1.1726007920276; 
 Tue, 10 Sep 2024 15:38:40 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e63873sm34009611cf.7.2024.09.10.15.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:38:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240904081840.2206980-1-rasmus.villemoes@prevas.dk>
References: <20240904081840.2206980-1-rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] treewide: drop redundant "type string" for SYS_SOC and
 friends
Message-Id: <172600791935.367866.10398514218904036810.b4-ty@konsulko.com>
Date: Tue, 10 Sep 2024 16:38:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 04 Sep 2024 10:18:40 +0200, Rasmus Villemoes wrote:

> The Kconfig symbols SYS_ARCH, SYS_CPU, SYS_SOC, SYS_VENDOR and
> SYS_BOARD are defined in arch/Kconfig as having type string, and most
> board files simply amend those definition with suitable
> 
>   default "foo"
> 
> or
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


