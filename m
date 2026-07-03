Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19A0C44500
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 20:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA43984AC8;
	Fri,  3 Jul 2026 22:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nqcp7Ysq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B6EB849F0; Fri,  3 Jul 2026 22:50:54 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 788F884A0F
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 22:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6a145935764so358261eaf.3
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783111851; x=1783716651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDySDSicC4FXngzHf0bypyvQmZsjOeYfQOYaDBSn9Vs=;
 b=Nqcp7YsqqSnT8GzrPstaywcxn2DKcUav+Lm76MZelQvWh4JCRiebP9GM2y3WKMeHwo
 y/HOMMLp3uuUvA86hqJ0QvYLS0nMLiK/BWypXOz/oqjz4nfvfhb4QNIZBGjpptPFjnA6
 9SQvYeH4k2kBCTuLyKtQRKRh10ZDuotiX3+4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783111851; x=1783716651;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cDySDSicC4FXngzHf0bypyvQmZsjOeYfQOYaDBSn9Vs=;
 b=kN5gMQ3PV8bVF7JeKXQ2tfYMcZWOQHDW080zViW2dLjbx3Z/Cd/yRlYH56bsOi6mFl
 H6PN2mnbgwu40QMblG65HfMAFj9mZ5VkFs6JuVVTdeAf4+LnZJiDXypQZ/sMsFykCBEn
 dsti664/AAjY/qNxYoqAviA8ygqFhAbjTVBWZVV1OM8PwmtHGKJEDS7vMArHX2Ly4KA3
 rKw6Pi8j1njeHuWjUr9o6FrpZ9KSZB5US/kK1ecJclBbv7Ss4NkdVCP8HAJgGaPiTeBU
 Yw7D8wpot5qGpKAOW3OHVdDaI1PyTH1N1J2q2K4BI7iygwlKPByLygcA/+iD80ELFsSZ
 Y28w==
X-Gm-Message-State: AOJu0YzznC1Sa1BxjeMK1pJoEynzW+TgxBgdcgbT2mPb3bHRUSBmgj3t
 j2ojSM0VKN00dz+4ThPy7nSBm7yRYk1poycw2MU69arACvz5Nol9mxuQ6X6+/ar5YIC7TptL59n
 NzwmmyJM=
X-Gm-Gg: AfdE7cml1bn+8ztMTwDIfGyEDAcVbUWn2LL2GYKM9vyYEUu28+/EVJsCY4506ky3yHC
 m049QCTcXfaecJI47JwysIqvqW8J7Judh3yTelBZUwWF2Bu67T71uErSYMXp/jBUAw47eXUwMJm
 j1Cxiinp+60Ivjis8DJm0ZvliMlDb/1OVIemm1b01uafhtEzhNDvU1HeS2l/CKcA6eZp/wz3Cwy
 2JIPynRRGYtMOIkoMLXZMrSA61Ku8BCG5ehbLSzdLUK5MgJvBapsYnfR8bZsSycfeXlUm/azhrI
 55r9Z9wnE2QkCGrzybd2lUJGGR3KYplpLrxzP95u1G9TagTaSP5bmbzfWvdWf6Jjj7aJAflzYLl
 8pYvQ/s4zP8tmumqb2z9OCr4LkHInd5iSZBQhM99hO/6/Qn30Uz4rTONvjPeeWmnPr+OzTtyOOU
 JEB7CU62Kg1wde9F1lW28Oyh2FOM6/kz3SVcQm+8JWfkv0XPpwYrSrUDcAkg0BdtfoOhtt6hd/J
 FIoXwRMYYlIyrprNhD/dLJKs8f4ZgIQ4xcu
X-Received: by 2002:a05:6820:3089:b0:6a1:50f0:cccd with SMTP id
 006d021491bc7-6a32f626693mr357470eaf.66.1783111851157; 
 Fri, 03 Jul 2026 13:50:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm3088491fac.17.2026.07.03.13.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:50:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Cc: thomas.petazzoni@bootlin.com
In-Reply-To: <20260625120344.274592-1-joaomarcos.costa@bootlin.com>
References: <20260625120344.274592-1-joaomarcos.costa@bootlin.com>
Subject: Re: [PATCH] .mailmap: map old addresses to their up-to-date
 counterparts
Message-Id: <178311185053.3143424.18084578529416398779.b4-ty@konsulko.com>
Date: Fri, 03 Jul 2026 14:50:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 25 Jun 2026 14:03:44 +0200, João Marcos Costa wrote:

> This essentially maps @free-electrons.com to @bootlin.com addresses.
> 
> 

Applied to u-boot/master, thanks!

[1/1] .mailmap: map old addresses to their up-to-date counterparts
      commit: a66b6e6b6414cf019fecce5a2ac6010a49341fa0
-- 
Tom


