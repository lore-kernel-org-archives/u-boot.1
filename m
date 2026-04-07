Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038D8FF5135
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB4498419C;
	Tue,  7 Apr 2026 21:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B7TIWn3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B8C841A2; Tue,  7 Apr 2026 21:50:21 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED3C83936
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-404254ffe8aso204764fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591418; x=1776196218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EQeWjBT7O4oS9KtuK6FrnJQWKpe8uGbsbFO+tLnsNnQ=;
 b=B7TIWn3jV5klUAbGu/VuHF/fPJXc0qOoEzMnA6Ah2Jo6prWteYtjTwayuH3PoK5nDK
 sLw2297OWMO0f6rv3LsbQJxEIuf9pPoqyujGW6Bn0S8MqnmocdoCRvkxZbYhC2ijpeWZ
 Cko/ShGgupzjOBGwLE0B9mmAKxhWvbjSpk+yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591418; x=1776196218;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EQeWjBT7O4oS9KtuK6FrnJQWKpe8uGbsbFO+tLnsNnQ=;
 b=F0LL/uLb7C+EFRPgT6aGRq94iZRh84NbPzjZJxQ/VQNs8P8cBwHNRiQZuq8QoY1aiS
 JMeiEGWgfPfplISXUNNF+9532PhjXNDpmh12tjr4MGLuMH1Lzcu+DPci5BS5LJA6x/et
 s5RfCKZ7K2gnYDS4ALtdSf27sPaxqc0HXu4riN7LzXYB1GZE8IH8CpHRDzwklbLLW4Wf
 +GPHRcc07/aEmLOBnf7kv3gBAXJDrS58AOLQ930J8Qyc5UB1hLLsAjve+hufNNPgGtMi
 4uE17fioTu62kN6HbysTaIeAXRSol/gfzPWDb28WWU3bJatHt4YZdoi99XztHmZZZaJT
 Onbw==
X-Gm-Message-State: AOJu0YzJfwDumoUZL1xzGLjpBr6oeZhNzJFfLELICkAMs/Z1opJEizFb
 4IVuGpG8mVH1Z7k2Yme2Jl3XdnZfnhiFwxeyOpHxIHgJ1JLvq4rU2bk+VEMXNeOiI0XB75A7pTF
 DIEP5AkE=
X-Gm-Gg: AeBDietRLvfa8+QTOXu30wl5tidGKfc9auchgykJa+EQ+Tux27ZaI90DCGO1Hs65g+S
 oGti3YqBOkKyhTkAc+q4pDjLECucZxRyut+E6L4WDhrbcNKsCMqUhCmMMs6RjZhOwcCfR80W7Of
 w+eJvUkI2j7ZPwdwGHxHGCM3tgIMgHpVK/0scaqCEAhlHni7g5rUd5UKSjb6QEYlavQ8SKnHWaJ
 6oc2/ajItn37SwRSR4FFGsz/d5o31nxEVrWDFTVFS/awVWNzkeyqk+igRATnAeHGE0E+xXSFiH+
 ee6O/d/LuTgflOdVJR3HiKPXJ5Qqa8gNe5MxzjEurAd6S7cyaTJIb627WlB9qy9a5Ruq+frd9l/
 ml2xdrcawlxOC4HzSAmY70j3ioWYhtnvk/lQd2Eu3zz4FNJ8zdY6S/O4WTRsham+rJ4Eev3eCW+
 cpwonvoUfQoXKGfm55wvGnXRSoEDQ1F4Jks+UyHdCCAlCRD2UFfYnPyqontvtfGES5W0TzGoiQe
 RRYkq5sfBB0dCWAfTpl4vIat4JzaMzumdVU7g8e52L2OQg=
X-Received: by 2002:a05:6871:878c:b0:423:4260:2e0d with SMTP id
 586e51a60fabf-423426079c6mr6631822fac.8.1775591418379; 
 Tue, 07 Apr 2026 12:50:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195313.2363694-1-trini@konsulko.com>
References: <20260323195313.2363694-1-trini@konsulko.com>
Subject: Re: [PATCH] tpl: Correct dependencies for TPL_OF_CONTROL
Message-Id: <177559141750.2108693.5545372358986987725.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:17 -0600
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

On Mon, 23 Mar 2026 13:53:13 -0600, Tom Rini wrote:

> The TPL_OF_CONTROL option can only select TPL_OF_LIBFDT functionality if
> we also have enabled TPL_LIBGENERIC_SUPPORT, so express this dependency
> in Kconfig.
> 
> 

Applied to u-boot/master, thanks!

[1/1] tpl: Correct dependencies for TPL_OF_CONTROL
      commit: 9eb3592cbcb318a84c8ed29e432dc01c69a2bc75
-- 
Tom


