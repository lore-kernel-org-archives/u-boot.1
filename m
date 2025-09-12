Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9996CAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 23:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29AF283322;
	Sat, 13 Sep 2025 01:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tvwr9tij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 684338341A; Sat, 13 Sep 2025 01:02:15 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD23830A0
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 01:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-750e52fb2deso2025860a34.1
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757718132; x=1758322932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLvOYXAUiNYmUFNH4UQm2vTSHoPQRKILyywZRZBBHaE=;
 b=Tvwr9tij8uDijjU0V6n6BYtrmSTXrZjaXpCaCRSHhEsjDsDWEZkRK34YcStDilC0CW
 Ox47sh7tA+RFD/lIlK+0rKwdulXpzPPh3orYBdk2bsRWJG1pND6v1ytioEyjhafL8r/s
 jeNQuBx8nUVMsTDDQ6N6+5gKo/bMSLuVXGf+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757718132; x=1758322932;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLvOYXAUiNYmUFNH4UQm2vTSHoPQRKILyywZRZBBHaE=;
 b=w85fYWVQ3pvzRAR1gKLHfxwVqz0NRYXFGwghhHDTwiC6WpdPEpYDxdZkdZs0VbmsRg
 cfzgoXxmIqc1j7vTU5Qsxjycw3fJdeYJMkrXSlowbH2tI/J8fNUTqM8fKCYZq5SySNIF
 SXL9gIEQckTk19YQmt7W8B70BvPMsFwFO9DO8MQo2ZG3bfUGR/vuj4qCOHFz76Y0shx9
 HGIJ3mYMoIHgZZniCY19OPI0k/JWkOBSSYgaPZIPWFMq3XhPJd5dLiQMNlqQwaxrhqxX
 cOsARzXKJQY9YAV87BMvwqtbeJ7+pCGAoMqTkrulYYgqiPAXaeVHcsdNfzbDOvM4gGzn
 cZfA==
X-Gm-Message-State: AOJu0YxVcMfisfinuMKQcQXYfd1+3aB18yFaajL85vq+fUnBi/t48uxL
 ulk7jagbKqvSsyCZp6K+Ioy+r/CnvjOBrZ0kjEFUNxS0oFAeWHpjTqw/DplBfNmWwlqUrU33WDe
 kSFErSmc=
X-Gm-Gg: ASbGnctlH7a1Q8EISU0NsyjAiZFpqqBd0Q+aa6NCDITzrpWwdW8iDUqMXANHPvyLM09
 +edxklLdAkb2rGn2/jHpYQAeHl+9Cvwme7V+GnbdrrSQgDGIEboDbWys/YHan4KhCfg1/LdL2Pi
 g1ozYykifmHaQjLzsxtPn293tmExtyXTqHH68wgfwkSmKu6T6bL3Uad56yEt9GR9fzup86ISxnv
 g801dkhuHqPhCxdj3Ky2fFgI60CPpHGSh76wwfQd/itI8Wjtah3H66om77le6YAOysl2yHVQB37
 HQEdYdlPWb8HoPolfsXVoHUSou6JELTq/VeEBGDy2V78gJT9hT0/nJV+VfKrctpsoJwP3vW/Dcp
 3ahR5hMoAxulYUlWf+tQ8uWnMp+pOvl+4Lt7hfIJD/FnkTs1PrVj3HeUtidduy+Or8g==
X-Google-Smtp-Source: AGHT+IEc4pIMgIFSgJ3lcN1LngxCiXycC5vGtg6WVruDM74SUaahDxH0CpPyCQydk+FxGlQ/eUf0Tg==
X-Received: by 2002:a05:6830:6ae5:b0:747:e82b:335e with SMTP id
 46e09a7af769-75352696390mr3060917a34.2.1757718132090; 
 Fri, 12 Sep 2025 16:02:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524b8a3b9esm1300107a34.26.2025.09.12.16.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 16:02:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
In-Reply-To: <20250912225820.4144317-1-trini@konsulko.com>
References: <20250912225820.4144317-1-trini@konsulko.com>
Subject: Re: [PATCH] Revert "sandbox: replace deprecated getenv() with
 env_get()"
Message-Id: <175771813081.4144762.16883261818386837717.b4-ty@konsulko.com>
Date: Fri, 12 Sep 2025 17:02:10 -0600
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

On Fri, 12 Sep 2025 16:58:20 -0600, Tom Rini wrote:

> While testing changes, I missed that Gitlab had failed CI with pytest
> failures due to this change.
> 
> This reverts commit 4c822970d366415e717730606734e815993a70bb.
> 
> 

Applied to u-boot/next, thanks!

[1/1] Revert "sandbox: replace deprecated getenv() with env_get()"
      commit: f0c1704f56dba70da93f30131564af777c29c1bd
-- 
Tom


