Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF33CD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 22:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 749E1849AC;
	Wed, 10 Jun 2026 00:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mpba3MtU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F1AA849A4; Wed, 10 Jun 2026 00:28:21 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13AD384962
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 00:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-48662d16d08so2387766b6e.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 15:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781044098; x=1781648898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2x64/BuDUVH4ZrPpSwMlEzNBCUe8I9tYGVLWOtP06r8=;
 b=Mpba3MtUnD73iD3lpbSUA1BkEEekjQgSS5mC9mPzU+nN5rof7IIMmRNuf20j1aCrao
 QGIfxy5zwSvjyRYA1cJ1MO4wes6Zq8K8JkFKuv47WW8mPO3PDeyGZbU/zpWC4HDW+G3g
 B6TsCPGTIvxPIzjXqtraHIJtBhx3oJF50GrCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781044098; x=1781648898;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2x64/BuDUVH4ZrPpSwMlEzNBCUe8I9tYGVLWOtP06r8=;
 b=SmUsxkcXDIFIZUs5nx/uPIi2XMERLloDtYucsRH+wJMpc/lHSKlXFdgt1CGkSISGlc
 o8LsXJlTzkn1g7QN1WoNxKTmnNwEODz9eDmFs90OkvkB3d68bCiEiNVxvYHJo2t2T54H
 e7uiQfpjuR2pD7y8nhnjcMAKGPhxgZJOuTx540vLHiX3C77llMS6EgMkHzcXrUIvG2Ox
 VoMiDVX3xQHlrmGx2MKOdSxfFA0E9S6i60d+8x9yMaIcl9lI+EqwFRXoqlfjJb8DNv0V
 wrqDzwAr/QjIMZPJY1vbSVNRaYJNhg+fVXDhKpHoiBvoBcohsFnHzR00s87rPZQOaoP3
 MY8A==
X-Gm-Message-State: AOJu0Yw1l8DCer9lvdayFnJdx2FDehzBBPhrp1Fy+g26rZctgXYSo28u
 61p3ypU60Ip1JkG5gc23iLah1aVUrKqxggfwt7QZ2vdRVQxcgGrEWqj6bo/5qAHi/cD3yI0LXCy
 MkDPdLRk=
X-Gm-Gg: Acq92OEUYeP3Vml0Rw4sVfc+JpRg/B5STmFGT7J52VemU8+b0oh43kJ2maHFFgc+0eg
 LsheDxxk5ZmhoTwfQAxM82/rAS+4GqXB4LNue6GdbnJVLDjLK4RoSsKT5RY404m/V0gXEVkxV+C
 VjvAppOY/IY1iLZuGfUThecQviXM3u91dkujxYD+LiwRYQ8rL5Bzw6e8ugUstFkg/zLuzJpht6c
 TV6MCxFgD6CtT3owIUBdykmzbbmgclu5i7ttKsJDFgdZfFKKq/VnNzNvAohIJU/8huMA25sicoq
 XlyFjCq0bmSbvqBBEREXSqbCtzL5g5MLH5ONNZlRyUI0ysdRGPqxY8AdYfOWzNB8ndhU7NwTBkc
 PFfETkOy+kSE1+njlrIrt0p0kR0Xew3oL3gqlZPEfucUFUJx07z7AJih38ifc35nR9VZgvoQFp6
 ePeiYjh8+rVcd7HYVzIFO9tsg7lyF5A6OhzJjagF4udJHk9ZatKkSd4UpVx1vwCQNRs+MCwCCcT
 /HTzWQBVL6ut7npsYOzbU9oxvVG3SEcZIMBLkiCm3C00l/MYzLRt3EPCRJ5
X-Received: by 2002:a05:6808:690a:b0:482:6b8a:33a6 with SMTP id
 5614622812f47-4868deb0b6emr11958990b6e.23.1781044097856; 
 Tue, 09 Jun 2026 15:28:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm16790962b6e.8.2026.06.09.15.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 15:28:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: stefan_b@posteo.net, peng.fan@nxp.com
Cc: u-boot@lists.denx.de
In-Reply-To: <20260525040033.2367042-1-peng.fan@nxp.com>
References: <20260525040033.2367042-1-peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] pinctrl: at91: Use dev_read_addr_index()
Message-Id: <178104409696.79918.13059732643760467495.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 16:28:16 -0600
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

On Mon, 25 May 2026 12:00:32 +0800, peng.fan@nxp.com wrote:

> Use dev_read_addr_index() which supports both live device tree and flat
> DT backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> 

Applied to u-boot/next, thanks!

[1/2] pinctrl: at91: Use dev_read_addr_index()
      commit: ef6b3ccf598820f53b79de452175b912a85ed850
[2/2] pinctrl: nexell: Use dev_read_addr()
      commit: b6d42b3fbf4fc3cac2e84ab0cefe1f31165b5ec1
-- 
Tom


