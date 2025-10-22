Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC455CCD1BE
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 22:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05F39807C0;
	Thu, 23 Oct 2025 00:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SIR6y6Wv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4F3C8323A; Thu, 23 Oct 2025 00:16:52 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CA8F80422
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 00:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-65363319bacso40598eaf.2
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 15:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761171409; x=1761776209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hBQzJBu41yd3JepT+Ogycmx6AAeq6a1IXtSmBAKZgjE=;
 b=SIR6y6WvvYnRyeZKfH3/qx+1okCz/TX7ITZpQHgZsa//LFUFygsO6Bzc4C46gcGQEU
 rALDOjHw18aX1cvNCCHWvi8FmTvg1cstriUhMbchBbxsi8ANF4b/ouP6b+5RmvtjmAVo
 DFwYepbNXw6IiEXd4x+C/ABe0X5sLVmIY0zq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761171409; x=1761776209;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hBQzJBu41yd3JepT+Ogycmx6AAeq6a1IXtSmBAKZgjE=;
 b=KHYQmEabE+tSOfaHbgrBuVmHlIrmNP1mvubN/MirHXg3o5gB9tSC+4BCblYG0kUYiv
 tSoGzhIVHdHpbf6lMt+plHjcRpZtcN5O3xWAnkEHuUrm/dRNwQI7UX9BoQKIoUzbGzpj
 DXAMECWaD82bBzR8Gx358BCvtoqdImDqhDt/Fjx/i/r9NlCGJWuOEuiiJx/FW6xszKLc
 P5TYx+uUfiyldrVbT8Gp44FPSraTFwiW7DHDZzkkA19SjsBL1a7ElFKyacLPzWegxwXJ
 i41vA4tMvYJTnHmAvzMDa6h69pC2ubJb3rIjjD5AFZSOcEE8LG+z6JRYboTalGJKEsiw
 CKLA==
X-Gm-Message-State: AOJu0YwAou+OLXLzbtayEtUhVPtLucC/ujdWXuD3TwCg/hBocfjKJIYg
 eMqcXAJd7gDaiDvyY05Gmks3wNOm2AxxEhF9CIFDS5G83XvQikYfPwTDnbaQ5M59ObE=
X-Gm-Gg: ASbGncsBEpgsSymtF75k14edVlttmt9ifOKZ/EuK+Zjt3zmIZuEDlhNuvlmAIeGLILV
 g1F83nAXHRLM8BTyjUUs2TG7OX1soy2iIsC5U5I7g3970MKwRIU7+lDMRJ5ilqNLdRNkRLF50AU
 c96IdjGY08TBF59AQIADesmDWBMzD6q+JRNSsKsYhr2mICCzWazRXtuGRn6JS+erlNev+yqUCVp
 5WPkaXRHeuY1EQlo9giKFILDcn2dd3cQWEfenHIoY2ItEwXoUxYpFowuO6UjkIW/F/ZPxY3ydyG
 lTESeug03y7PkbkaF30gFGpAVqJl/4uUrVFXoxm2R0Qt6JmUfwP4iAS7Zh4LzdysiSZ+HcwhTwB
 6sSmehQGmAR2FVviv7ry3oEPXPI/g8S9A3AmLBQlocsH/6S9slpgk2vRSvFmsalYW+joOdOO+l8
 kO84NWzhrmjlYq8t/Mu6/1dyBKGgdUMHpsDGq8VBHysWGAfCJnYuaH8xq6Nfc=
X-Google-Smtp-Source: AGHT+IE4NYPGuhEfo71CKTMzsRh+yzWUnSr0CQjtP5NAgxDvLXYiQDvOAXmDR+TLevDiu0SGzmxnWA==
X-Received: by 2002:a05:6820:2981:b0:653:63fb:219 with SMTP id
 006d021491bc7-65363fb040emr2021732eaf.4.1761171409236; 
 Wed, 22 Oct 2025 15:16:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c51b048f6csm94967a34.28.2025.10.22.15.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 15:16:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Martin Schwan <m.schwan@phytec.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Moritz Fischer <moritzf@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
In-Reply-To: <20251015154423.908468-1-sjg@chromium.org>
References: <20251015154423.908468-1-sjg@chromium.org>
Subject: Re: [PATCH v4 00/11] boot: Support priority for global bootmeths
Message-Id: <176117140781.1741630.2006689811486390325.b4-ty@konsulko.com>
Date: Wed, 22 Oct 2025 16:16:47 -0600
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

On Wed, 15 Oct 2025 16:44:03 +0100, Simon Glass wrote:

> At present global bootmeths always run first, before all other
> bootmeths. Optimisations in the code take advantage of this, putting
> them at the end, so they can be used once and then forgotten.
> 
> In some cases it is useful to run global bootmeths later in the boot.
> For example, the EFI-bootmgr bootmeth may itself scan devices and the
> network, so running it first can hold up the boot significantly for
> boards not actually relying on EFI-bootmgr to boot.
> 
> [...]

Applied to u-boot/master, thanks!

[01/11] boot: Try all bootmeths on the final partition
        commit: 396c9b59644081a05a8b078eadc2c4aead37160d
[02/11] boot: Add a new test for global bootmeths
        commit: a2301201e36d665c08b51617e1c66133b32d9808
[03/11] boot: Update first_glob_method when dropping a bootmeth
        commit: eca985905d7956ca69e1abfe9ef1d3eb5c64c0a9
[04/11] boot: Add a flag for whether there are global bootmeths
        commit: 0fe6de0dc5b137a2def3a8cc0baa2fb73a3f8541
[05/11] boot: Keep track of which bootmeths have been used
        commit: bef963cb751049cacc86f2754452efadd03ae2f0
[06/11] boot: Support rescanning the global bootmeths
        commit: 8e31093dbce4fb233c6f14520149293b92981b50
[07/11] boot: Only run global bootmeths once each
        commit: e52053c93c128284ccfae11001d7b211bb081aeb
[08/11] boot: Implement a priority for global bootmeths
        commit: 4ce78089b2a615eab466347e8996fbd54a876234
[09/11] boot: Don't change the method count after global bootmeths
        commit: eff1dca96330269c8281b17d00f5d2d0e62bd26e
[10/11] boot: Run global bootmeths after all bootdevs are exhausted
        commit: 060ce66b83e5ed19180103c26e525d85c2a2aa8b
[11/11] boot: Run the EFI bootmgr just before network devices
        commit: 6a56d10fdcf1309d2070b62dc15e80a047da971b
-- 
Tom


