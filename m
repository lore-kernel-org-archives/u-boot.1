Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EE8C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 17:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0037C829C3;
	Thu, 10 Apr 2025 19:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I9awmr0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C39F839D9; Thu, 10 Apr 2025 19:33:53 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09CD782160
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 19:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-60288fd4169so512150eaf.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744306430; x=1744911230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyYaQ112Rr7C9w8WT8zLxh9AArXO875ZYT41VyJFJ7U=;
 b=I9awmr0nFrHLX7viwvWAT4cR3/WjRXB+yQNDuDt3UaBTmPCOyu/StRe+e2ExfBxsPP
 YMWHSvkmtAZp005OgiZIzTvzW8PCKQo4mtEetIW1m02eT9vV+IhgPJ4AMM9znkxjl8O8
 uBe84VKKLs+Ftf626UeYFSNjgwHyMNd2Dt4kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744306430; x=1744911230;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NyYaQ112Rr7C9w8WT8zLxh9AArXO875ZYT41VyJFJ7U=;
 b=RjWGspFL3h3PDz73Fo+QA+WgTsRQuwoG52NSOH611HCjiPvT5R2tpN9XhAC4/63Obb
 9Zhe5STRDaxj7FUpr2Pvnly7J42x9xVN1uAn3LnWjuz3YoHMJd8YtIJwLGXaPNBAn/a2
 OYtkCj/CgKSV+m9J/OqAvxtfGKBJ6ePyIWdTGfWLlm8Z7Fc9Nma+rMBgLK/2NaW//+X/
 k8tuCEcxafhqlhVo3wrxwHQOO7DQw/GpXzHB8lKHMaWGfaBZs+ZwImomPRnQrp1INmd3
 d7/KEgRALNiopqb5g31U5E9O5vYuK++l8x5EeR3TWurh7GNfAQP4A6bQJWrCNHTGg8aC
 xGug==
X-Gm-Message-State: AOJu0YwfRw52Jva5bvGk0suFsRpC2UtvtY0uJsw1GMPbdbPQKb80V07k
 B2v2NncmV+SQ4zSBbf40mrt7dUkFHbk+Bdzg7ZzSaI9UJEaJw6QpHluiswg6f24=
X-Gm-Gg: ASbGncuptRmAM0vRGcd03qH5zT4whH14uUcT8xgZAZwd3HCExJ8qJ9/yMSwfeKmRQKu
 SCFOBG0AlODH1r0CM1U6+FZwi6etYy/P5OOPFpATXon+i8eUfoMm21RwpsYo7nrJxdD0eo9wRZY
 fdzDDKmtcoP2KsUfId14kXvAiQGxwdl12SMUdoVZh/nkU7WOMktj2GycrrY0Zt3uq17ZFP11LY3
 SLLanLKr1bDjocOF3dBAZc1ZqVDtzGVf70WoPg91G47fmM2h3VsWUCk/+At8vpb1omRjXzmzoqY
 qGNStCZYuUubRc3xe+YKs9sks/LrTo8HCOBM3YmG5U1adjriigp57J0rMZOJgmLk0iiKLkPgnVK
 N
X-Google-Smtp-Source: AGHT+IHDRr6JKyQiov0WJF8BWguAxSV3f1Up/PeeS2K+UjGx8oHsIIGVb2ZoUpwtqKuTkuojafCVfQ==
X-Received: by 2002:a05:6808:238a:b0:3f4:af3:74a5 with SMTP id
 5614622812f47-4007bcdc6e5mr2438338b6e.21.1744306429674; 
 Thu, 10 Apr 2025 10:33:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40082515ebesm75008b6e.11.2025.04.10.10.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 10:33:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Gary Bisson <bisson.gary@gmail.com>, 
 Marek Vasut <marex@denx.de>, Michael Walle <mwalle@kernel.org>, 
 Zixun LI <admin@hifiphile.com>
In-Reply-To: <87semgf8ab.fsf@baylibre.com>
References: <87semgf8ab.fsf@baylibre.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20250410 into master
Message-Id: <174430642875.2959201.11244949471800741408.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 11:33:48 -0600
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

On Thu, 10 Apr 2025 15:36:12 +0200, Mattijs Korpershoek wrote:

> Please find the following fixes/developments for master.
> 
> Usb gadget:
> - Add SAM9X60 support to atmel driver
> - Fix memory leaks in f_mass_storage gadget driver
> - Fix comment typo in dwc3 gadget driver
> 
> Fastboot:
> - Lift restrictions on !NET_LWIP for USB
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


