Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C925C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 22:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B303282A59;
	Sat, 10 May 2025 00:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PAK4pB+N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8713B82A4D; Sat, 10 May 2025 00:50:03 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DD2082162
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 00:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2d060c62b61so2710059fac.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 15:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746830996; x=1747435796; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4R1686NSoyqEZLFz43rZk44qjg3tcxURmRW6hT1TYU=;
 b=PAK4pB+NJWX3q9W4MnWPAGtK/+3vtDlDW5AcDZUlmYegnEF/ATbqo00cVPq91exElI
 mhM4EcmpOwIKXVNSp+879Iy3PRRDQlqEOoY5Ub/mkrTOY4NmtFqsujLBlCfBw86kPuhw
 8Gi+jSuD3Ubynh0Tb3i3PsxWS/7e3tu0GtaUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746830996; x=1747435796;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A4R1686NSoyqEZLFz43rZk44qjg3tcxURmRW6hT1TYU=;
 b=Q4hKN90mpuH+80zXBBwhJS4g1AqVTK1sNxSD9R4JRdyhuOaPeLayADQKyChuE5fy0Y
 /oyABCuXgVn5Ijnki1czMevd1C7dAtBtWpvJycgL9G9xKW5ZZSQpQqPqw1gxd8w5RRA1
 HRhsXcYPhzN2SnqY5KcQZNdYUAk2yyqQHs/LssHaely4gx3LAmjD3r0OQjCR6tnxK1K4
 zBd77Unh4MJk9qlVj0wCRdpdsXZIyy3nyM96NqXnHmVS8OxkQ2AoC9uYrnz7PJmZram2
 1E43HINzT8QRje1iI5jQn40iggZDte9E9zVBG9PXhepj2JtHX73wqC1WfNN1aE8ONLmE
 dCkQ==
X-Gm-Message-State: AOJu0YzxAd0hAXUBetz+jl2ejGXG7vhm2pQxi4+hoI99rtXTyHcja/8D
 00xDwkSHbahACHF2RbDiM3+3YtFXjko1j8E45TWSkiCFFjiUaSkkVal5tXtQu8w=
X-Gm-Gg: ASbGncvt1Od1Js4FMn24fxU7kutCRpI8xGeFO7Py3Z5h64r6LaSNzo7zx9fuJE9hYX6
 clhZiORWTjy4jo4W0sRFfkWt/75UGZPF5BSR7RTTkhPIZbq6JywCPuIsZK0BXW1k5/kFpnv5NAK
 w55pOrfqNC2X2GYqT8jFDHMqGc6KzEexWEOGzQdzDFFO5X2GP7Uq3lRCry4eC8Ei9vO6xu2rp2q
 Ltpo8ED3u7xk9WE1mLnjKd3FkWPkkT4jj4/lKkBH59rKyO2EPJPpeEjwkx8B2mL+fX3knmPYLqI
 CV1SM1pE/VVmoMJpesTqxPvTOH/N5AQpGO09FtYk6cvd4HdXCsiLIcqqQ58vr6GViEfKPrqFWhb
 UOljUCiLCR2w=
X-Google-Smtp-Source: AGHT+IGUQuU6KLoqQx+AwCxONU75R8hnm0GJznAvOpemeF0TWUl/AUJkReQGQTbyDdStjdfL4xgiag==
X-Received: by 2002:a05:6870:a48b:b0:2d5:ba2d:80df with SMTP id
 586e51a60fabf-2dba41f6cc0mr3072611fac.8.1746830995844; 
 Fri, 09 May 2025 15:49:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba0b82571sm801403fac.49.2025.05.09.15.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 15:49:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Prashant Shivhare <p-shivhare@ti.com>, Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250505174601.273860-1-afd@ti.com>
References: <20250505174601.273860-1-afd@ti.com>
Subject: Re: [PATCH] board: ti: sec-cfg.yaml: Fix OTP write_host_id order
Message-Id: <174683099449.770062.3673976053763164001.b4-ty@konsulko.com>
Date: Fri, 09 May 2025 16:49:54 -0600
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

On Mon, 05 May 2025 12:46:01 -0500, Andrew Davis wrote:

> The write_host_id is the last element here and order does matter. This
> may have gone unnoticed before as by default all elements are 0, but
> if this is updated to a different host, it will not work. Update
> the order so write_host_id is the last element in all current secure
> board configs.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: ti: sec-cfg.yaml: Fix OTP write_host_id order
      commit: feb55165233623648cb0a74953735b00ec6e322e
-- 
Tom


