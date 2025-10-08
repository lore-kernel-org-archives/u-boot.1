Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE96CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 21:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E27383C7B;
	Wed,  8 Oct 2025 22:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KvFJIdjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B79683C7B; Wed,  8 Oct 2025 22:59:48 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D890883C7B
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-79d36a6298dso124909a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759957184; x=1760561984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xW3JgpqPIcsz8wpz+/cfyhJtZDPZNQW6mc54/8Dn8Ko=;
 b=KvFJIdjC+2Yyeix8VMYph3RS+dlP+ZB9hAqzc1DxYp+rcOcYjZKrj/r1If4/owPg8W
 pH2uxKfhsKf5SsgCeXbroyn7tbj2MrjmkICLh9ki2LpGxdYMsDqxxA54VZv3zL+BIbXt
 PNQXUFM7KD1iUS8y4yLVzvE4Gx0b5JDGGnhw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759957184; x=1760561984;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xW3JgpqPIcsz8wpz+/cfyhJtZDPZNQW6mc54/8Dn8Ko=;
 b=UaLBklMbOKaFTSU2izJ3dbQ+pS0py+ZnPp29WBZE4vZHuej4WJYZI88Img53576eqM
 SWE1bQda7F6kzI8dyMGoqDdCQZLJUtVMfEt8ZDsdtYL7UH4UiXV1EPtdtqH4uta8BI+W
 jvWuTC1JiKPBlVNB6vtPqlK/vUeYCRMHaUalwpDYNowbK/3Z+J9bHfNBrR0YLrl7sp+I
 kMJSJ0+/ffYmZ9fKf/ylkto8BgCFJPicZLNrZeaRfgpkdijMfj4bueb6w7tYwFq/sRVt
 OMc3g4OS3mzByJBDtHCGmkPtV8MmH7BKcpp0FPZnbgQQigrdbbKNncb99bm94FYoBILi
 7UVQ==
X-Gm-Message-State: AOJu0Yw5QFlJVO2pbcNPyQN68jQKH6jQRHQBU98e49/kiRA9BqMdNIN0
 yardGx3LarMLNaNmmivF8GRJ2ZM9SPBwBENlbvQa99UG9c5C19LlDDJt8ROq8XfFvWrklVibTCL
 ovn4WJWI=
X-Gm-Gg: ASbGncu1uFU4aHgwOS6pb+tmX4k537sQWfaseIrWaXz1/vEW0ZtFMNtoztQG0t/QCRZ
 h24slRmEwtVd5xI2vCsUQ7fXLx7zE0r2P1zqKLkVaoWiK22CC2+R7wprRCk6Pl/ClFK+ZNSSNvu
 GMvxxkJ+at9HemDoaW1EhbC1T73ND8zSis1RTSDIAo09P0/C7RwQx8Nvs+nntvS392GtKGQt/FF
 cbkwfykYwwFDjhd49HKHJ1tHBwldOiMb6tMpVuaqnPaCM/zA/dJfOWa1Pp/XgZOGHYY249hT0Rc
 nVoD564xpYebRl+ojg93gdFhvYoVXlP5KdDjBOcJ+72Z79ReTcWo51/Pxh73W4QsNsrI2WhWVKK
 8z1SlnvyEqhrGYJW+e+ldQjvzxWK+vaDBu5hV/8DKYSWIgx3JtcvhKM5IWAlFFI6YAdN6AyYRjL
 0uNATzNi6S
X-Google-Smtp-Source: AGHT+IHImH9RdFp2j8F2iFbMtsR/1nQgv+YXI8bI4g4DUQyt3i2NhyeCdxRWS+MIPfKYDCNpoG8uLQ==
X-Received: by 2002:a05:6808:4f64:b0:43f:1d72:592 with SMTP id
 5614622812f47-4417b38d935mr2193407b6e.23.1759957184661; 
 Wed, 08 Oct 2025 13:59:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44189a67d27sm226052b6e.23.2025.10.08.13.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 13:59:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250925205618.3562580-1-trini@konsulko.com>
References: <20250925205618.3562580-1-trini@konsulko.com>
Subject: Re: [PATCH] spmi: sandbox: Make U_BOOT_DRIVER entries unique
Message-Id: <175995718400.3059512.12715469105851496965.b4-ty@konsulko.com>
Date: Wed, 08 Oct 2025 14:59:44 -0600
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

On Thu, 25 Sep 2025 14:56:18 -0600, Tom Rini wrote:

> All instances of the U_BOOT_DRIVER must use a unique name or they will
> lead to link time failures due to name space conflicts when both are
> present. In this case the driver was reusing the msm name.
> 
> 

Applied to u-boot/master, thanks!

[1/1] spmi: sandbox: Make U_BOOT_DRIVER entries unique
      commit: 6e04cc321f246fd223bdcb094e10c1241ee5e664
-- 
Tom


