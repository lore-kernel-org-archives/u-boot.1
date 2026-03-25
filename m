Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254BD109E522
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 23:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 215DB8410D;
	Thu, 26 Mar 2026 00:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RiM2/tfL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3ACC83FB6; Thu, 26 Mar 2026 00:06:01 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7654083FC6
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 00:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4648447e29bso142150b6e.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 16:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774479957; x=1775084757; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3yVVKCMChe+sZbjGpFnI3BOPM2C/mk8wep/BZ2MqAEU=;
 b=RiM2/tfLfcjfrtZTczgs2qlnYddba/TTUeVBm40uPqUlHvs3lE2OTZQajcLV92Lgo2
 qG5B9K8dngYoHET7Q+bXzcPjw5O8MB5TCAJbCRNJPWzt22zoh4sylfYm4PKVfUj9CRXO
 CWm/X53XR0KRflcqqSMtOGRf+1+Cwz/DvfK2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774479957; x=1775084757;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3yVVKCMChe+sZbjGpFnI3BOPM2C/mk8wep/BZ2MqAEU=;
 b=c9sOf9Nytuds/mNnVUZeLgi+GfX+eKAKLZ8w7zv0djfaf+T+QcXtXCRQsO7N7mBomT
 yHZS88OAAuVHe0fZqSZEl6rSQmWRffdT+SksPd9aBk19QmtlnleBFKtyj+PBZNjdR4Y0
 NjUjjBAhhbOQXt/0AYjpi7Y9VLzPBDI2CpHeRKbUpLVWnm1P824Yy6FlBILSyKug0Vzv
 0jXdh2ZpTrRkGwgwRiY8Qyrwnoj813o+xD4+ErUf1ieyrWp4/4vEIIEjbTe4lym0kJ8Q
 ugkK7Bk3YdeBJXZWAcGJwP1o36+kZue7s6JO+R9yrKcSqSI5cTx7p0y50q5X7mJMc0hM
 NesQ==
X-Gm-Message-State: AOJu0Yyp3jLm9sPIfN8HeGjOCj7clg18XRtNKBMoTqXS5+ZHsfNur0lt
 /d6a/t/36m+G0hGzbPJGj08Pix33Od9u8hofxGdKHybhpxun1g5itd+MzsCaVtyJYKE=
X-Gm-Gg: ATEYQzzBfHqc138Q0osg35I0z2/XvH8JGDs5wBpOu8dxKC8o+IonzetX9K+8kPfKE9o
 0DTt/WLcXoQGJMK5pHuw9elhrtN0NaCAgBfss6W8AHEmtcCv1wwXFUQb9Pa48S2R0NXn2npfYu8
 jHCHJBCRoloFLpdJCHH01vnatIONVIDIADHLeQIFq4MhjsFS1i41t4q2TKzjJie4CLoeb9Kv1gL
 Sv4T4dsD/tZVnaZl33npVH8jJrYSBDdEk2hjydMOTl9Y98F7F40DF+ZDrpCasu/Tm96acMCVcdb
 nlrojQXd4/k6xoKbKDa74uF+7wprIGwhtWnIFLSySGtosiJvZ9YmcQN83cBmQDBBCQXzbHBWnLV
 tGqm/5/d8vxpNNmUcBQEUwkJfDoxk0K/WyQLsGalY1/asI55d+qVFTGOawniHIWWzdhSvJVmUvZ
 rKfvzouwNsc5PnRsM5ok2J9LNgxKryIgsVue3hVUaq82msiRqdvIK1GYZ+bOJWWRBNzu7YZKw5b
 HjKWfdE6Fbiqi3XDa7q1SIzIKeRKFd5mrUqAoZWgPgJqEo=
X-Received: by 2002:a05:6808:229e:b0:468:776:1e9d with SMTP id
 5614622812f47-46a5c7df054mr2392231b6e.51.1774479957173; 
 Wed, 25 Mar 2026 16:05:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm581446b6e.15.2026.03.25.16.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 16:05:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Suhaas Joshi <s-joshi@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Daniel Schultz <d.schultz@phytec.de>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
In-Reply-To: <20260312-tfa_tee_addr_kconfig_refactor-v3-1-86c92718e048@ti.com>
References: <20260312-tfa_tee_addr_kconfig_refactor-v3-1-86c92718e048@ti.com>
Subject: Re: [PATCH next v3] arm: mach-k3: use Kconfig options for
 ATF/OPTEE size
Message-Id: <177447995616.3508238.4367565307716242135.b4-ty@konsulko.com>
Date: Wed, 25 Mar 2026 17:05:56 -0600
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

On Thu, 12 Mar 2026 09:13:24 +0530, Anshul Dalal wrote:

> The reserved memory sizes for ATF and OPTEE were hard-coded for K3
> devices, this patch replaces them with a Kconfig option allowing for
> easier modifications.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: mach-k3: use Kconfig options for ATF/OPTEE size
      commit: b2c02c04ec7fe070e3cecce665b423376972f07b
-- 
Tom


