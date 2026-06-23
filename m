Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C84CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 17:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63CD3849C5;
	Tue, 23 Jun 2026 19:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XrGZp5Bk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513EB849EB; Tue, 23 Jun 2026 19:55:22 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCED3847C8
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 19:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6a11eb98e8aso79156eaf.2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782237318; x=1782842118; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pg/XwGSREXutCMHhWf6wcXVIvu2LcFik11qz48LOULs=;
 b=XrGZp5BkNbEBMraN0llctp2mu5SE/4MYZ2LtCk4s59+4MsRa6r70HU6bB/UwXrv+QE
 c0A56DCAN95V6OfOlOPoBhmFfNHztPel3375v3NypPc4fUg1J0YKEAmfAInnODDqhOw9
 MRI0ULy+HlCJLr3nZqUFK3YpQuX9lHBxdmoKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782237318; x=1782842118;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pg/XwGSREXutCMHhWf6wcXVIvu2LcFik11qz48LOULs=;
 b=gs08DxbdFIidpOv80ekiNPJgAFuGKG3HDZwe27bnjeqCahFHi4XOZKVGtYaW09Q6Ij
 60Z95otJsmGMLy5+Blk93lomn5O35rn4cs1zmpAKl/I8Fdl0VGbQA9D2fjOpjgI0Hr5P
 wkKZQqwN1qNky0znzjS6SGOeUoLTdr2ADvw3WvicdxA0Gw41FabnwljHx1EjCcrdrfcN
 UPpzmzspWsxrlDM/T9t2kHc3EtiZ+IPg9uW2/vVjS5PBZ+qS3BTPD5SnxZoDkCEPaE7o
 65yqMJ5gVVP0ON5lQPlGay/pRz6IcIicRLBRnI0Z104jvjE4sNJ30LQEHo1o/MnWcA/j
 gGMg==
X-Gm-Message-State: AOJu0YychMQEmApburhmMZpnmf5pgTixJnAxkJVd2i45Pv6+fCXFGO2I
 N5EWWizW8y8rTlk5XJvSXbQe7zqPUWHcFrZwpyXhSX2FbDUb3L4vMvNLtsajXMBgsL1sK7Hh736
 PV8/9p1Q=
X-Gm-Gg: AfdE7ck8aQPxXICZRZsvN9V8EMWv3qee1VHx8ieBEvcNJUds5+uLsuA7R6DEcFbTCkp
 Ag0P+vZTFZ6iCZRZwcfLe0CQcULFtIsHtdikzWdXGyWqtkryMVxRU60ZhJSieGP8Ea1EReyRhtU
 rK6II/6JtApYAStsSDYwAQCcOBCgaFzr/rd8gCIdBFYrjV2J/6H6QG1QD4LzhcENBbJ+Eo0G8e5
 uKmQVcv+VdK1Q3lYsLAJPqGiMUiz1X5m6hx29m1peb0Jf6r9NxfDtMewFgR/JbUWqlxXcZ96APf
 z6JSs1QjJ4eblD3tubCIavbPh9ZbC2f8Pdc4c/12bhepBCTtNkUXTtIZOroD9nUoO4wJMzLP8nV
 lA5bjyh7DWsccIKSOqc1W7FN8IqrDQUpnq/xLDTt9feuSTi8fwQCtnGe222IELGC7ZnE3eMwLuM
 qx9bwUbolywI3UHtGO8gZ2j5VtIaWZku7TS6XJPEtIEWZiiPbvScrL3atVcLyPNzFnNbZQxS8DB
 Dj3dARC6JCrXMaX9h/mdo7iLlha75l3pw==
X-Received: by 2002:a05:6820:220a:b0:6a0:e02c:8b4d with SMTP id
 006d021491bc7-6a116608a51mr2189137eaf.53.1782237318533; 
 Tue, 23 Jun 2026 10:55:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-245.totalplay.net. [187.191.8.245])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0ea0f9dc3sm7709245eaf.12.2026.06.23.10.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 10:55:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de, nd@arm.com
In-Reply-To: <77625247-d661-4104-b3c5-61dd0d413d5f@arm.com>
References: <77625247-d661-4104-b3c5-61dd0d413d5f@arm.com>
Subject: Re: Please pull net-20260623
Message-Id: <178223731739.3376589.7708661809207952343.b4-ty@konsulko.com>
Date: Tue, 23 Jun 2026 11:55:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Tue, 23 Jun 2026 15:01:41 +0200, Jerome Forissier wrote:

> The following changes since commit f072620dc9ffda00b010783da27c41231c3a439b:
> 
>   Prepare v2026.07-rc5 (2026-06-22 16:22:08 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260623
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


