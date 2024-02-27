Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC420C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 21:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD5987FEE;
	Tue, 27 Feb 2024 22:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aql31IoP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318A587FFE; Tue, 27 Feb 2024 22:19:55 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E9B87BC9
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 22:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-608e0b87594so32670487b3.1
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 13:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709068787; x=1709673587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eyaG5a9qhDdpvsiQm1wKx3lTAGKFDyDtdKnPFgbPgt8=;
 b=aql31IoPybm/DkhYs9gfOrRdItKvmsfpkZcccHPLe85p0i7nATC8+9KhMiMiH5tr7G
 VrO7yfoFd74rqe+k5nf1AZZBCXEUTlmNBxmjgwOPOE0uBKoowxOiTNDfMEJxCA0Nvw4J
 i1ksOYJ7TiXbOpqLBd2pQzAxYnUqSHC/30JLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709068787; x=1709673587;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eyaG5a9qhDdpvsiQm1wKx3lTAGKFDyDtdKnPFgbPgt8=;
 b=NdVbJszm0EXheOn2WtyE0THKkNpIYd+aqKdzKbd5eonIoc56xCBrM/zKL2T457jzPA
 GgftYiqif1Au5g+r/h99U8pqroa9hcnCkASIzqCd7VAl8buhT9FuNBhxDk1ZeA7pVHA7
 CIpan1DbRmW8v+qZlkHRh5uqowIbw2Xnsr075EYe7Zme8JvyZ3xxPYqiTakevW8DkcDX
 gaNACh0nBKyCj4khRzrYMjgYHIEq9w+qSzJwqnCNrxibtP6id+YZzdXZZh8TcoSqXT8z
 zJ6ms63jVkJbJpBRpIsed3blG63s4EFVQsSCdcvLAkkNJOY4hwTEEXn7B0YYwFTX2FCr
 4v9w==
X-Gm-Message-State: AOJu0Yy21OIOinNtGgRddJKiM4QsQ6tn05SZVdCIQ4vYDhwVAyk3/fK/
 GknOR6IVuTy4DKDgpT+QTduKledYUKSLsyD1VtyHdR4c8KsqZ4lE++6HOXLHHyNHGMarg9UaAtO
 H
X-Google-Smtp-Source: AGHT+IH/SDHf1fHpwTC8dvZpv21WLGgZu89wrMTjueIBKJHhpfLk8X1GhBD3Qr5bFrYEyAq7gjEguA==
X-Received: by 2002:a81:e40d:0:b0:608:cebf:1bbb with SMTP id
 r13-20020a81e40d000000b00608cebf1bbbmr3028156ywl.52.1709068787351; 
 Tue, 27 Feb 2024 13:19:47 -0800 (PST)
Received: from [127.0.1.1] (065-184-194-195.res.spectrum.com. [65.184.194.195])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a81a512000000b00607b6c0065fsm1939850ywg.43.2024.02.27.13.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 13:19:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240122223920.3630168-1-trini@konsulko.com>
References: <20240122223920.3630168-1-trini@konsulko.com>
Subject: Re: [PATCH 01/16] kbuild: Allow for CONFIG_SYS_CONFIG_NAME to be unset
Message-Id: <170906878663.3340409.14857286964987860982.b4-ty@konsulko.com>
Date: Tue, 27 Feb 2024 16:19:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Mon, 22 Jan 2024 17:39:05 -0500, Tom Rini wrote:

> It is possible to have a platform which does not require a board.h file
> to build, but today we need an empty one for our generated config.h file
> to be valid. Allow for omitting this file if CONFIG_SYS_CONFIG_NAME is
> not set.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


