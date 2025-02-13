Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB11C021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 22:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C27E980ECB;
	Thu, 13 Feb 2025 23:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pPN5FJve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C5D80F7A; Thu, 13 Feb 2025 23:59:20 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6836380EBD
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 23:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6ef9b8b4f13so13623647b3.2
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 14:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739487557; x=1740092357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EuaoCjBrpvI4bJlrVK0+uWPQQb0L1EGhMqj7ZeN9iys=;
 b=pPN5FJve7e2j47gobQdMJU/53Oim0XdcOaNPKW0fARtKdHPUz9J4q6iO5lNKKARn8x
 lrYaJVvO1XREDaVh4RFQ+tic7ZUn87PTeOkD1Krp0HZWXnxMYcPuZssMIchE04U4qHtR
 PsLoQWbQqzaqp6006SgBI6bReGVHEcScrDRYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739487557; x=1740092357;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EuaoCjBrpvI4bJlrVK0+uWPQQb0L1EGhMqj7ZeN9iys=;
 b=Uq6s45oHXWN/x44qoyClLf5TBwR0vvTk1MtmVAw9C40J7M4K6dAo92VreCjJMQDz9j
 o7dVvrTL8MjNOuBY5yV1hvSnGjw142U7/t7QCPKv9AyJCRcjb56R4DUHrD+t2uVcybqQ
 Wednb5zA+jvIRNxpg1AEspmxeFBtJ0GgDzK7jXyFwjJ3ukLqNqyzBDlb1dJR2PuBlJHL
 zO5qHIyH1n0wMQW9bPsSSswl34CcglhLiv1osLaH4vMLdiIFBd4QH7OZrdDap0/OSNw4
 sCbYskkqQ6YJG4wiRvBS1EvjxypKf/eIrj0Tc+4u8SBA/4fA8DART1XE74G89qnf++ld
 TEhg==
X-Gm-Message-State: AOJu0Ywd23n1yxrso3aUlriPSlCoqocaasUtWOx3vk0+EpKiuoQ6VTr0
 IvLxfPUOm7MdZVu45AMqpxzd4Y6HltjUUPaPQ4x/iBwenl5UJWQCSx8ylAsTwIA=
X-Gm-Gg: ASbGnctdztETTPY8fGsyqNEK0udDy/yKFm3cdsQmSOJLzwV+eOwhyPLWgnE4eDSrPr7
 3FWcHOylDyhw9uQMgK69lUX2aSyRmljH2Ii6go0h8Q33KAq10qGlCj93piiWiw/+SQGOGxSu3Or
 tX+RfhqwD0YLy7UzmlWV+fjYF2VVp7oOGKfX7Eu7pDdmfAejKe4vsxV5pDjm+cR7aEXgW+A1Mz3
 7cB01vy855nz0eHamfzmfaMDO9bUxpCj6Qe7AYNKCFQl0Jxhx+25VFA1WJfUgRegKh+hrULsSMS
 LqKAXi7tdVaRVg==
X-Google-Smtp-Source: AGHT+IHSxUPdDyU0LlxkOcmFEsqLlQNvKsV1fR77DhXRTZEZChRf87MRyGbf/BlVUjQylCYK0Yr/rA==
X-Received: by 2002:a05:690c:b96:b0:6ee:5cf9:f898 with SMTP id
 00721157ae682-6fb1f2b9cfcmr93229217b3.33.1739487557281; 
 Thu, 13 Feb 2025 14:59:17 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb3619cb14sm5155097b3.80.2025.02.13.14.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:59:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, ZHANG Yuntian <yt@radxa.com>
In-Reply-To: <A189BD12BC0A2ED2+20250211073027.1351783-1-yt@radxa.com>
References: <A189BD12BC0A2ED2+20250211073027.1351783-1-yt@radxa.com>
Subject: Re: [PATCH] mbedtls/external: remove broken git submodule
Message-Id: <173948755629.2912919.3515527342341991371.b4-ty@konsulko.com>
Date: Thu, 13 Feb 2025 16:59:16 -0600
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

On Tue, 11 Feb 2025 15:30:27 +0800, ZHANG Yuntian wrote:

> When we squash imported mbedtls, the git submodule "framework" was
> preserved in the commit. However, U-Boot itself does not use git
> submodule, and provides no .gitmodules file to specify the submodule
> repository.
> 
> This is normally not an issue when cloning U-Boot repository. However,
> when U-Boot is imported as a submodule, this will break git option
> `--recurse-submodules` as it fails to resolve "framework".
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


