Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3F5C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 22:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF81F82998;
	Sat, 10 May 2025 00:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i9ke7EGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAD3382A1C; Sat, 10 May 2025 00:49:54 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C42498211F
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 00:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6065796762fso712654eaf.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 15:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746830991; x=1747435791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bp2ZqTBTD1QGRq8R8ex0ubWr60m7X5S2hUciLi8gA4M=;
 b=i9ke7EGHpR8zDFgudLOWWDSs85EfhqxbpBVcOxCPFcck2NtY2nDxbzkbmc8PFAFRkj
 YGBgizyRwdymz+ZcTiyDEYA4TxJG6OPpaZnpTeZsgguUJXqOA64MrwLGh/dHM7SRJy7J
 k496KldsyryMhSSgfHN5ZWzYtkGSww73yUZLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746830991; x=1747435791;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bp2ZqTBTD1QGRq8R8ex0ubWr60m7X5S2hUciLi8gA4M=;
 b=PNpRYesRl6v/zxQy7yPwC0ymea3jH8v15J/bU4B9GACc8Vbx2NoE2YIy/fnGjf12uW
 bDGQhwVpxxWtfsDl5QQf0TvWHq/6g/v+eGH6u7b/jUm9NDCOGs47t93FAbCKXXEoLTv+
 5QJ1t1GBfyPuQjRHGgBUf25SHX9a/B9l1+dADLFtOZJLCntQ8GNmyYIUjyC/Mkx7GxRY
 2K01/Rz4du0Hp1PeA2C/0YnhxlXuAgrFx90UIjh+cMPiukFw/2HXOWHZvlmWn185fdFz
 +UL2s1EZYEmnpDJjvalOlV67Ug/0rZx0IT2u6QQz3FOMbrU3xnVosjdsUndBovEHNL5R
 VR8g==
X-Gm-Message-State: AOJu0Ywm2VvSe4OVLF+GQzEnjOSK03YOGGb4PsnHO+M7Dq1m/gttshqu
 jD621Otfq3PyqJXig1USWwTz0vw7Dhmh2lMhmyNhBEfS5sJy9+dXumV+JNA2GB4=
X-Gm-Gg: ASbGncupJ1asZoo1lRFgpt+yroTRTqqFir9A5J35Any1DbT1uKncEtRkItnlpTxe/VF
 PNu9umYvaMwLo49I6z2ofcT6nANmvXo4vRIImhJBsjvZXatHknsoCcsg27ub1l19IIbKlwhnK2I
 OZDyenTy14RmpRRbsH1+TcV7P6fhXXpm81v91mbNTyGPz1147bAHhwX4vxWTsAtznx3pFf0Q9jn
 DACVuKJBbMA0zK7xCUejTsZcFLExTcY63gpU5k9lbRfwTw9BRL/sSq7rUUEHdE7SYU3wziOK7P7
 gbT86EJ1nsIfnuaru72kuGGYXanBv3LJxVVYt2KvQxpZlPAR2ojLr5j0niWM/aI6B+xTbp2ZpSc
 Kf4YDbAbPIzU=
X-Google-Smtp-Source: AGHT+IHQEL8yeajdGwpsnY9OO5mf8yP73ScKCLLNxXFdRUsBRYEtSkjIIfGDfL3ziVKCG9tyiSy0DA==
X-Received: by 2002:a05:6870:1648:b0:2d5:4fe:2c42 with SMTP id
 586e51a60fabf-2dba3e49939mr3083135fac.0.1746830991520; 
 Fri, 09 May 2025 15:49:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba0b82571sm801403fac.49.2025.05.09.15.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 15:49:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, n-francis@ti.com, vigneshr@ti.com, j-choudhary@ti.com, 
 francesco.dolcini@toradex.com, vaishnav.a@ti.com, j-keerthy@ti.com
In-Reply-To: <20250501175308.2653413-1-u-kumar1@ti.com>
References: <20250501175308.2653413-1-u-kumar1@ti.com>
Subject: Re: [PATCH] configs: j722s_evm_r5_defconfig: Enable PMIC config
Message-Id: <174683098992.770062.1718352739539128345.b4-ty@konsulko.com>
Date: Fri, 09 May 2025 16:49:49 -0600
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

On Thu, 01 May 2025 23:23:08 +0530, Udit Kumar wrote:

> In kernel device tre commit 714d54917147: ("arm64: dts: ti: k3-j722s-evm:
> Enable PMIC") adds pmic support.
> 
> Above commit of kernel get synched in u-boot by sha ab06a533f08e:("Squashed
> 'dts/upstream/' changes from 8531b4b4988c..955176a4ff59").
> 
> Now, PMIC DT is available in u-boot for J722S EVM,
> So enable PMIC in defconfig as well.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: j722s_evm_r5_defconfig: Enable PMIC config
      commit: df7b988ed3ec43b229769174f4f99826b4f8c8b5
-- 
Tom


