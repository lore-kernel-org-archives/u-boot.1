Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE64C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B664F88354;
	Tue, 18 Jun 2024 16:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PUhVdTOm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBA4C88335; Tue, 18 Jun 2024 16:53:21 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3BC8882D4
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5ba090b0336so2670406eaf.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718722398; x=1719327198; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mIBZ4lGmQNjCvhxDtP0rLJQBi2xqdGuIIMLGoMcj+XI=;
 b=PUhVdTOmGCQiFqijfOESDCisF8qS2hd8IUiXfJ67a/Iuvx28tewEFyVSHPdWcLKBg5
 NBav7Mj7Yy7qTTKKNLZZrnVnF+/20e4L8krCgZQxRaxAVYOkDMov/XxVCXCLWb3qWo0/
 959laEi+FNandtkDexvplaqk7KLNaD+0AD+ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718722398; x=1719327198;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mIBZ4lGmQNjCvhxDtP0rLJQBi2xqdGuIIMLGoMcj+XI=;
 b=eZU1R4K9rVQGk7k54SReA2tjGxMN4Ry45uG0UF3L03Wns/Kq+oLKaDb+x6mGGigv1b
 T4Zi/+jPiKHbMLY+Cijy/HGYzZYQ88K+B1hqKMbcqucGcvFvbwBZdo7QTwIroWYTo2lg
 /Pyr4cDcKcubLLXmbD8vxK+7B5xV/nvqvE49eoabF/hKqVzAqOj7TrWB04hofXKGjZU+
 GoNbgv8n8fjsxRH+mYC2iLMPka8CCjzYoSi5WaZB9iQT2Zw92MopLzl9NfmoO+iDYd4v
 j73A3FRcwOexGTMPwSB6oGx8lB60lA87kDwjo7lu/uo39h+2cAaHu+h9CWMGcFD3NOJw
 mULA==
X-Gm-Message-State: AOJu0YzJWEaAkrgfoO7w45m97Dc4OXo8EqrULoDjQZw19VfM7dLqZH1e
 j82kwz1Aum6yXt/q0xSm/QSm3OR3/zFgoSnO89N7WbqfrWMw4cUuX3E351JiMzI=
X-Google-Smtp-Source: AGHT+IFIJyP3okwlhHF7ROQwX1sWfk6fVug3bSdolpAea42eCV7eaQtstkxdQUqtgrLls8tuqGmg3g==
X-Received: by 2002:a05:6870:3908:b0:255:1819:b444 with SMTP id
 586e51a60fabf-25c948f71c0mr19167fac.7.1718722398616; 
 Tue, 18 Jun 2024 07:53:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94b7besm3202888fac.6.2024.06.18.07.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:53:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>, 
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240531225110.2622239-1-j-humphreys@ti.com>
References: <20240531225110.2622239-1-j-humphreys@ti.com>
Subject: Re: [PATCH v3 0/9] binman: ti: create binman nodes for EFI
 capsules
Message-Id: <171872239677.3307069.12905920590757359041.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 08:53:16 -0600
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

On Fri, 31 May 2024 17:51:01 -0500, Jonathan Humphreys wrote:

> Add binman nodes for EFI capsules of firmware components so that capsules
> are automatically created during the UBoot builds.
> 
> This is enabled for several TI SoC based platforms: AM64, AM62, AM62p,
> BeaglePlay, AM69, J7, and BeagleboneAI.
> 
> Changes from v1:
> - on GP devices, still use signed images in capsules where available
> - Insert board specific capsule GUIDs into the capsule node's image-guid.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


