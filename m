Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15F5C36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 16:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589AB81D3B;
	Sat, 29 Mar 2025 17:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pQ68XXsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0E081E3E; Sat, 29 Mar 2025 17:37:03 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B650881951
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 17:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3feaedb39e9so928697b6e.1
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743266220; x=1743871020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jMRvSEEr7/opDVURUKBoGAN/IysYxFI65UUpcOWtFQ=;
 b=pQ68XXsadwBfaRSh7AOyPrGuedP96asoHr/h0UBhc5q15Z0RAtD6FrGHUzdfw0DZz0
 ebkZdUoW8y6QDhjFmEM9CIyhpseHdPIWZUjZ1o4c8dovkqP+Is9jg83XsqD2Xx/tT5PL
 IK5c+ngUKw5EhozsxXh76c4Hxm3AyHAG1TAtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743266220; x=1743871020;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jMRvSEEr7/opDVURUKBoGAN/IysYxFI65UUpcOWtFQ=;
 b=vrXBCZt0OKUFLiy8N/QMRSJKl8p6jDp1DFKVaLDt5EinuoT9KYg1cGeU9ucasOslRj
 S13/N/gUsndu2B0bO0MyXNUVkXHLTC6mz/RqonTVm0SON+TtGsBJh/HgqnFnkr3jqADi
 NvCn6JqtgJdO+76eidBrSAOczzAs3yBTePWJnMeuYM1YUboOO5MgKiAUyyGxnr5atWoy
 3LKikTsi4ZqzmF4OQEfqWd6H3MLebpGlXayazy9RDTouloH1VQlr34xfceRg713FBtQS
 IRv1k4CKysEfsHaDF+vxv9vW1MbA3JmZJj+k/x/hPLw4RhBeF0b+tfeyJexQwdOMdnbL
 CLFA==
X-Gm-Message-State: AOJu0YxcSANWYn2F118H0+Rhw9nHRqXgXwv/HwdwfDsf2CgkX9tD5xt+
 V5Mu9DB/+jstHqVezsp7WC+ukAN5myadBtNHcgJoDUOvvVVbSPgub74FoMCjZ//4IPxaA84vRIr
 p
X-Gm-Gg: ASbGncs7RuoUWiiyFglQ6bjmuvFZLc+CTycAwBtopfopJUpRy7nlzSPvVfqjt0UJtR4
 JLTGmLmfE6CsXjK9/lylyMfc4tByGWvf4jbYPKQMNZ6l2bh4Bvi6hBRhGqyEVi+ah/ws4dJ0EOB
 XwbZsXe+FHBf+V1h6cTRkdqs9JP6m2FXvyDWb+kPiQLcP9wo2+GlXHiqjhfSsrigPYjJXVk19RR
 uupRXhBR+gvXu6Z0U1xBucp2h2kJCiBobRmF14hHeucvrCtQsbcnT2zuDCS93zr5iUd135ljzw0
 7Gaexf6gzlar9VO0y6mH4Se3sjbzxan/N+fnzzA+SfJjZ57MwnFdhpdaQ4fo6CGYEgn6THREx+W
 gkg49
X-Google-Smtp-Source: AGHT+IFas674u4BxyyjGqfZ6BsYNLNPNMzHJ37Lzpk/LQL64YkxjFx6pP1BobH2wjyK0FMMbRRqDmw==
X-Received: by 2002:a05:6808:2187:b0:3fa:1ed7:f7c3 with SMTP id
 5614622812f47-3ff0f610f86mr1686211b6e.29.1743266220451; 
 Sat, 29 Mar 2025 09:37:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a91391esm925094fac.46.2025.03.29.09.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 09:36:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250327175550.529248-1-e@freeshell.de>
References: <20250327175550.529248-1-e@freeshell.de>
Subject: Re: [PATCH v1] board: starfive: Remove compatible boards Milk-V
 Mars CM and Mars CM Lite
Message-Id: <174326621894.1009412.13633750639742736500.b4-ty@konsulko.com>
Date: Sat, 29 Mar 2025 10:36:58 -0600
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

On Thu, 27 Mar 2025 10:55:08 -0700, E Shattow wrote:

> Remove leftover code from Milk-V Mars CM and Mars CM Lite boards that do
> not exist in upstream Linux Kernel devicetree-rebasing. These will be re-
> introduced when submitted upstream for a future U-Boot release. Users of
> these boards should use the previous stable release of U-Boot until then.
> 
> 

Applied to u-boot/master, thanks!

[1/1] board: starfive: Remove compatible boards Milk-V Mars CM and Mars CM Lite
      commit: 870c4d105a634c140328a405b6ffd1c7b1630978
-- 
Tom


