Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FEDECD6D6
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0818283CBD;
	Wed, 11 Feb 2026 19:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N1ARhXiG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDFD983E1E; Wed, 11 Feb 2026 19:26:44 +0100 (CET)
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02C0D83A47
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-40438380b88so1482819fac.3
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 10:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770834401; x=1771439201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qe1TyBBIQsQx0lNlw519MzEmPxY9sdo+JqLp/Wdfzs8=;
 b=N1ARhXiGHlJVOPPNdqnGNkHv32qhUY71rmAyz+VLehdHPkkBruE7oH9JPR+0h3ZbBC
 OZUUFU5xnj6htuhQ0T58N39SgH3KeGfM6hkW6ZOgEbeUtvnOpntUAzf1PgASBw6LCNoj
 eFv4ohbERPKpk3L9qvckk01V/K5iRYyXfJYXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770834401; x=1771439201;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qe1TyBBIQsQx0lNlw519MzEmPxY9sdo+JqLp/Wdfzs8=;
 b=eVMVenYLzeDuZqcnevUpW6I9ltXhjUBO6pGi8maqBJYTAxLkKpNPb20qr9MV8ZX9Rd
 PN2BQ12cm+3K/mnyTzbgYKnM5+DyXgXKGIIzGbAZusNF0QIiLNwkEP1lpkk8S44kJEV3
 vWR3yilAM8Kb11G+FZaSimslonGxPUeJLa6wD2EGZIVD8b2+nP7bWxyo1tdNAx0EGtR/
 Bwo1iKWfU49Rh6HpzrdZ1IquXV7hEU54b+S5kLuTlcMJLlXPa32+96k6/gE3bv80//Vo
 yb6o/i2d6/MV4s44xE1N087goWyfC3dS4JLO/q9f24+dCAzZsbHfkkogvfj3dVA1CM+d
 j5DA==
X-Gm-Message-State: AOJu0Yymmw5z2E0dNkzao85N2TyOx/9INPhT0aJf+qlK6+NENCCUiHu7
 rJabK3VoodQt04XmXGGqFdp6+yuj+2kdLxFov4PyoALxcsJIowvceWRGx/bFNz67GFPnqdtpbqr
 EbRuU
X-Gm-Gg: AZuq6aLcXRBnBfkoDGYa5AhlDTj5jsxwWUWB+94os7d3ci1BGNnKci8VRz3shBR0iQK
 r+5pHCyzawwrB1MfTqz0RABocdqkgvmqlSiVpNEsO+dHiPXQUL+oGpVAc2uN3hYfvXOy/Pm7daS
 /gVGE0EtqESqpF65d+N1U8A27bRKwbB8ZNzBPSxvw8ddQsNyTJxAXr/zoZt2/ZZZ1rbEnVNV+7p
 sQFFuyTZy2bSnS1JFrYEt+DtKnVH68RPVYoXfk7YmE1dgOU9Mn52VWIDOweTZR5dSiolKBx4WYA
 9cKpdmLPskZaOWcJriRU6ytf3xnIBZM3pkkExiRga5w9uHjfZ68xPOAvDFeTqbEtqCP4eJVMDSB
 i6kBu0N+LZebxarOPteWvXS6c3c1TkXflhJ8SVI6sZsHT3LWx3PMIpgZKuA/zdsCB+gkOl2iKn0
 NRd7aeYLSlP4eQHYhPEMU45aWL4yNNDrAyb0pDYaWuABnKkPlCPW3E8fwm8tc/3YbQ3R4bDlRV/
 PElvyPQGZRCZPwRVL1khMsdkZR1CqSWosGRzJleW3AO1EroO8gNua9M41yE
X-Received: by 2002:a05:6871:5c03:b0:404:3a5d:7243 with SMTP id
 586e51a60fabf-40ec7055947mr16513fac.26.1770834400722; 
 Wed, 11 Feb 2026 10:26:40 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf16c383sm1814426fac.14.2026.02.11.10.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 10:26:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
In-Reply-To: <20260129105433.2624686-1-ravi@prevas.dk>
References: <20260129105433.2624686-1-ravi@prevas.dk>
Subject: Re: [PATCH v2 0/2] am335x: failsafe bootloader update
Message-Id: <177083439982.1681814.13579653555731695754.b4-ty@konsulko.com>
Date: Wed, 11 Feb 2026 12:26:39 -0600
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

On Thu, 29 Jan 2026 11:54:31 +0100, Rasmus Villemoes wrote:

> Make it possible to update the (whole) bootloader on am335x robustly,
> i.e. so that a power failure or random OOM killing of the update
> process or other interruptions do not result in a bricked board.
> 
> The order the trial bits gets set is somewhat odd, but is clearly what
> happens, and somebody else trying to reverse engineer the ROM code has
> observed the same thing: See the TracingVectors.ods in
> https://github.com/sjgallagher2/am335xbootrom .
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] am335x: add support for loading u-boot from multiple offsets
      commit: 589d0a687b020fa6000afec454ec82f192613ed5
[2/2] doc: am335x: document use of CONFIG_SPL_AM33XX_MMCSD_MULTIPLE
      commit: a672456d4b2bd216dcfe9d09fb5fbce2b013735a
-- 
Tom


