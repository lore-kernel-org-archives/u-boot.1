Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9ADCA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 16:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CACD3839D7;
	Thu, 14 Aug 2025 18:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PPp2y6pW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66719839FB; Thu, 14 Aug 2025 18:54:38 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5003E839E4
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 18:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-30ccea8f43cso857007fac.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755190475; x=1755795275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RUMlkL+HhP3eiY5RsmVMtIWT4rKlOntCDFAU5VbKPA=;
 b=PPp2y6pWalrdWZI5fxqdiW2t0Jtfxdhqq39G0MDniELcwgxbd2lPCpVpu6v+0lg2Mr
 7PEvZwdkpVrghf6J6SUkIqv3pMZOiglwCaL23hF8yA6uBHfaRWkyLfiN0upd9CwJVfaY
 Rh6Jp5Sk6VgAfNbgq8l+uA6NYg+3FcCumXYHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755190475; x=1755795275;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0RUMlkL+HhP3eiY5RsmVMtIWT4rKlOntCDFAU5VbKPA=;
 b=TqyH1qRxjfYH3VW6/uD2a2Dv+4MCKrRtepnDZDx6Kagzzuuc4+XjpT+aD4lu897Kai
 eyaVFMhXy8RF8gnKUD1fAhQ3kTRuNpJYSTt6pidrfXlqjtHfjtD82IZttC7diJQ/SQIk
 eVWtep0J1UxUjWVq+dDNcDmUDihJcI7zclP16VoN3UKIPoqimVjWWPS78dh/4l6KACis
 yYJpjm4I8pva3GHIgBmTVuA05zwDwLtM2zBxhlvXEntE9OuZ4JqBkWlCcyN/L2GFIEgJ
 Ko1Uv/Mpay33v0tcFNsjP3jmqOw78jEupi1bdHmyZcQW6yFacd1/fdf15Qm8Z2IIt/Ml
 G55A==
X-Gm-Message-State: AOJu0YxQT7xRn6Wb+tpcwMU1WXKIzoyf/pr9jCobBK6nL03bs0b44V6f
 JamSFxaLixHevD9hJc7KP4AmULpqV5Wbks2ZBvfTAlSeP+HIMXdl+bVv0YtQWxYLo0A=
X-Gm-Gg: ASbGncuD933sMaDar9RQpMIEELOicm7doIYz2+SYPWRdFsEZhW5hFcyDeAy5cU2DfL9
 fssHXjRIRiFHN/pLB4jl3xk201ajITRd43kHAFDW4wCCVjTn/R3tREzzFkW+LkO03PlkNjGe17F
 avlk0MHd6dlxAT1SBhtnFt1vSAp4rC03O6E8rMrkUci93XZqr7Lu2h8rRmY6vBR4dteEEi2NoJX
 w9TdhAE4AIQ967fzSm4zk2uSWQPhFacK7z0/YSSXnFNj4IrtubUDvGeW/2sGkG3v72ySxr45YJc
 Tn035DUo2xhMz4Aa5vy9SAbHMebZujcaE+k3FaC51Tv3A9WNLrCz7zNOU2CMhAt61u99P6B9+DY
 jux+rhwWa84sthpb8sH7KY0hGztDJFOLhHYV7p76FRVuNCSkEXuPp9lk=
X-Google-Smtp-Source: AGHT+IEEFNjmLp9+6F9iAYiOnSXdXdxvQyn9X5vkcwa/DPl92EfiL2Gsohy+VXRpQS8DbYJlDzYbeQ==
X-Received: by 2002:a05:6871:e804:b0:2ef:1c81:f2fd with SMTP id
 586e51a60fabf-30cd390ed32mr2172573fac.16.1755190474997; 
 Thu, 14 Aug 2025 09:54:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50ae9c91417sm4378449173.89.2025.08.14.09.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:54:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250812173109.1813657-1-trini@konsulko.com>
References: <20250812173109.1813657-1-trini@konsulko.com>
Subject: Re: [PATCH] env: Correct Kconfig type for ENV_MMC_SW_PARTITION
Message-Id: <175519047411.3586279.4673205247343845103.b4-ty@konsulko.com>
Date: Thu, 14 Aug 2025 10:54:34 -0600
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

On Tue, 12 Aug 2025 11:31:09 -0600, Tom Rini wrote:

> As part of renaming environment related Kconfig options,
> ENV_MMC_SW_PARTITION was inadvertently changed from a string to a bool.
> Correct this.
> 
> 

Applied to u-boot/master, thanks!

[1/1] env: Correct Kconfig type for ENV_MMC_SW_PARTITION
      commit: 6531aeed374f0818d7259eaa401b92b976723fb2
-- 
Tom


