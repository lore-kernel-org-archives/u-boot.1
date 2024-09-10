Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379E3EDE9AD
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 19:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA3A890FC;
	Tue, 10 Sep 2024 21:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sOG6zzXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB5458910E; Tue, 10 Sep 2024 21:07:16 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE13C890F7
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 21:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c353f2f954so42266206d6.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725995234; x=1726600034; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1Hf2jNEd6IeEwgHZh31d2NEfbguqIQ/JMdlVg3SyPM=;
 b=sOG6zzXZOXjx9jk6UrcBD18o0KyMYd7J7MqugFZfHlMYpFZbnJvDdMsS09fCDfRqY8
 mdfW1F+2VpC+CM1Tv5jh08l9JEOCfEX7fVPbiogJzUiLa4kEwgyFhuLrkk5PeHtAuWRD
 QdSjYOs4GqVFarfAMIyupovTVGftPVjpCGcYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725995234; x=1726600034;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1Hf2jNEd6IeEwgHZh31d2NEfbguqIQ/JMdlVg3SyPM=;
 b=CyVmgJJyeKroPhK4bW9zACRtXdnln7lf3zX4Sfl+QGHXR0eDqOmZJ8snt8AoHTd/yw
 DY+cueQnZOZLKEqyns/wuXeVWVkG+aDxn18BlRR4Vzo5BvZ4+NRXG6sFWpFJhlDlALtS
 5TApFb895OdLWUjYOq4gt34ANug/5p+C9GM3uOoha6tGwVQZQXnKKoNtYKKMwFnfdsVY
 XP7rb+Q/OgZGmBva8YdQmbRWTIw4jkvX2a0177p86g6dxU9u4bPsXOWORWLyoPZlEsGR
 rof3te2iciZaPySv7GAh1shL+eOBGVsatUbwl1PhR62HaNJI1+T9/YRsOiZFtWbnFf1K
 NJPg==
X-Gm-Message-State: AOJu0YwczmtHiLez4HoVAaWJQ2Nxv/DvsOTdLRmmoccpnbjEHK6bc0sc
 1FU2PytjVb+QvaM/Y1urbOS7AIr75qcaPrLJ5Ia/n/dB0TjziuDy3t/aOzv4stnKvv6ar3FXjP7
 Fnqc=
X-Google-Smtp-Source: AGHT+IHWdXO9a+MWZryJ4cX4156lU05JjbMqrveQjQWPofgNK/mFiJ2ZWCaNDwDvE0vc7o6w3w7lRA==
X-Received: by 2002:a05:6214:468d:b0:6c5:1337:e287 with SMTP id
 6a1803df08f44-6c52850e99amr309857876d6.33.1725995233355; 
 Tue, 10 Sep 2024 12:07:13 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5347749b7sm32718486d6.125.2024.09.10.12.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 12:07:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Emil Kronborg <emil.kronborg@protonmail.com>
In-Reply-To: <20240903215936.2193393-1-rasmus.villemoes@prevas.dk>
References: <20240903215936.2193393-1-rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] scripts/Makefile.lib: do not include
 CONFIG_DEVICE_TREE_INCLUDES in dtsi_include_list
Message-Id: <172599523151.229167.6808512532063936243.b4-ty@konsulko.com>
Date: Tue, 10 Sep 2024 13:07:11 -0600
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

On Tue, 03 Sep 2024 23:59:36 +0200, Rasmus Villemoes wrote:

> The commit mentioned in Fixes broke the
> CONFIG_DEVICE_TREE_INCLUDES feature, with the result that any board
> setting any non-empty value for that fails to build.
> 
> The parent of the mentioned commit refactoring a bit by introducing
> the dtsi_include_list variable and changing cmd_dtc to loop over that
> was fine.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


