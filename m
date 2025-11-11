Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAC9CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 20:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D5583C16;
	Tue, 11 Nov 2025 21:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gkxopU6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F9483C04; Tue, 11 Nov 2025 21:15:08 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 213DE83BF4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 21:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3e830355780so192966fac.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762892099; x=1763496899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=efdT+ATGw7HCiUHy2lHXdSNthNqgPid/caPBaU4+1g4=;
 b=gkxopU6sunzbiq+NQ6hLTupOPDikhqeLn5+dDx8FhlkBoEkGiXIG574SiwVlTHHczo
 oDPCoGTAskvTMNH1XZkhiadmucV6gdgzYnxryuuRATe3FtISHU51zA/QCyL6hFdedKlT
 xG4oPpj5BQK+MefIw0xL8nZdZ0pGZ8HcJY7IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762892099; x=1763496899;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=efdT+ATGw7HCiUHy2lHXdSNthNqgPid/caPBaU4+1g4=;
 b=w3wFQZdpUfCPqaBTlm85M0uYnvFmrm4ZblrCBLBFwa5Mb9Nt1ifGMIbLzs7TpKrKLF
 8R/Lz54yJiFEqv5ILAjZ7NPhnXUEeb5/Qe9LoW2Qe+iKeCH0Qyx11K8MroC4l9o2FtAD
 kEvrpjLAffHTeF61I8LiJush/1K2Je5MuRVsu24Saa9EaNG6fc8Kmzv13nM7lvKtlVti
 /qfVh244bHokCaADrm6JRMldfBijRVdY07EmUfg+MPGnJtOojdcrs9beAqRJrduDxsmX
 VjONQK82dBZZ7weq4A5a85/DgQS9IDTrzfBxUsQY+MAEr/GYquikjskdyIwXgdKx30xQ
 tL2w==
X-Gm-Message-State: AOJu0YwOogIYzY3bgkTc2KLKltrbXCM17bSf9ZcigT7EngVtpm+lzGLA
 YsF28sTf4uCClc8aP6c2Ni/JHqPO1MVXWDf5qhvU3KAwr9+Bxj5WEYzfYAO5CsgjtQElmUlWT4c
 T2wj3llsTZg==
X-Gm-Gg: ASbGncvpv/x8VkoVvnwuolTVRk17mvy7U/TYewJpg+ShwEv9Ntd0m6JmX1FPt9+JW9a
 ahhIE5QA3o6VbPlbMfuVg+RT3LvYxsjJRARh+GzLhREXJpdHp5aVhjLk8nLOisohROc+M9yAHiu
 aGIcA2DVpJPU2kgsl4xAHoiepYD1F+1XWYL6m+VRYt6QgbDemfGCyqmOuunv2SEOXjOlSsJ/STn
 BbLy/4pPSPwQbE5g5/UPzYPcz00BzBu+SyWLm1Z0Gav+z2Vf9XnPMYbWIN2cVJCwRCNf2kMX9gK
 pBjidupb3PxjzBU0SqM1Rdx2j6Jk6JNKmfvO7u6uzBRo5mDPpWakwudepsoMXsJRhLdeRaOHnUp
 Aajcew09u+wMuqM/9uk/0hIFnSa0g/r5bF9IHMvrR/e2XHbYkaOyH9Vdc+6Jx67CshKMzaDzTST
 36nWykKEqLsu4TB+YisQl237LhVAVwYzvmMXcLJNLFQuieQJBbQ7abY5ktEpk=
X-Google-Smtp-Source: AGHT+IHXo+PxKkakl3J6E3ZHlJrIzmyaUWa5rn44thOSgCIPADfDVf7suckbS1MjOhPYf6AXzQXuwg==
X-Received: by 2002:a05:6808:1456:b0:44f:6dcf:e9c3 with SMTP id
 5614622812f47-450745d8ec5mr247348b6e.66.1762892098736; 
 Tue, 11 Nov 2025 12:14:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45031835261sm4197443b6e.16.2025.11.11.12.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 12:14:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, yegorslists@googlemail.com
In-Reply-To: <20251110105812.427041-1-yegorslists@googlemail.com>
References: <20251110105812.427041-1-yegorslists@googlemail.com>
Subject: Re: [PATCH] .gitignore: ignore more files generated for the
 sandbox
Message-Id: <176289209815.737015.15023681926955615207.b4-ty@konsulko.com>
Date: Tue, 11 Nov 2025 14:14:58 -0600
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

On Mon, 10 Nov 2025 11:58:12 +0100, yegorslists@googlemail.com wrote:

> Change the existing regex "/capsule.*.efi-capsule" to
> also ignore the following files when building the sandbox:
> 
> capsule_in.capsule1.efi-capsule
> capsule_in.capsule10.efi-capsule
> capsule_in.capsule11.efi-capsule
> capsule_in.capsule2.efi-capsule
> capsule_in.capsule3.efi-capsule
> capsule_in.capsule4.efi-capsule
> capsule_in.capsule5.efi-capsule
> capsule_in.capsule6.efi-capsule
> capsule_in.capsule7.efi-capsule
> capsule_in.capsule8.efi-capsule
> capsule_in.capsule9.efi-capsule
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] .gitignore: ignore more files generated for the sandbox
      commit: 21181beb7e8f7a6dbc85dfa405dfaf127422eef0
-- 
Tom


