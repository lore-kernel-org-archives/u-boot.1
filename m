Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3510C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 19:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CADD88054;
	Fri, 10 May 2024 21:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pNf3rIWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE2D88049; Fri, 10 May 2024 21:32:33 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E6FC88005
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 21:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-439656c1b50so13491871cf.1
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715369550; x=1715974350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrY1KIo9o1zto+7Leo7NdhvKPKm5UVQzo/sqjFwOSao=;
 b=pNf3rIWdt3Yc2FmAtHgnKXaNn8p+rPy1XhdBhVa/Jwl4gp53VKiWdIiUbCXWuA/vsH
 hb+ko6FETva9WtxNUakLfQrRSft6VrtrF2NEb9CRQ35TLWfNWa/18YhIw6OKAiiL6s6v
 K3AYmOpfP5fqo/KHm5GqgJLRZNvmf9SgBr9pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715369550; x=1715974350;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BrY1KIo9o1zto+7Leo7NdhvKPKm5UVQzo/sqjFwOSao=;
 b=imkIVOw5yJl/IVoXahbmmeSTaUyI0wVliA2cqNf4Ad0qsLIr/2xyc/UoOxbGUyjsLi
 sLY/35oXR4PerQOl/er4TQlgOGdFPvctEOS9NbvFX5CbK5WkXQwwar/reghziow/kHDR
 7c+VlhdicyQjO6LZVG6s4TblRPaZZUcGRsUbmK22fApLYlzAMZBM8AcJI1kJuWSN8cdb
 C0VapxREA6q6cRCyZY47FTAtC/GzEa0y0u72tiyZ7w8ryVpVrApPXLikPhQxA/SchRIK
 3Z7V1dEHzPWm9lCL2gWFm7yV1tRQqG7+qW4AHi1jx3eKPdKRHpYQOdqC/kUjgSpViC4o
 VvOw==
X-Gm-Message-State: AOJu0YyFjj4pGmvwdaxEUc8LTvSgnOPvfmVoUKzuEEBd9dFZUW83cxnw
 8Rgv2XXw4tnUSSAeODRa26qIB8IbA8dTmrkOuntabBhw0eepUFZBI26UDBRffl0=
X-Google-Smtp-Source: AGHT+IGbjeRMAGLrMa7g0hD9N5FDTycxejqyD29G8fZk5Oie8n18JREEcRzS+YdOD8lLcE8/3t24Yg==
X-Received: by 2002:ac8:5f49:0:b0:43a:cbe7:3640 with SMTP id
 d75a77b69052e-43dfdaaa2c4mr44082341cf.17.1715369550174; 
 Fri, 10 May 2024 12:32:30 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df5521c21sm24474961cf.48.2024.05.10.12.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 12:32:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Wadim Egorov <w.egorov@phytec.de>
Cc: upstream@lists.phytec.de, nm@ti.com, bb@ti.com, vigneshr@ti.com
In-Reply-To: <20240424124320.2056543-1-w.egorov@phytec.de>
References: <20240424124320.2056543-1-w.egorov@phytec.de>
Subject: Re: [PATCH] arm: mach-k3: am642: Provide a way to obtain boot
 device for non SPLs
Message-Id: <171536954922.3410219.16577020225936634229.b4-ty@konsulko.com>
Date: Fri, 10 May 2024 13:32:29 -0600
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

On Wed, 24 Apr 2024 14:43:20 +0200, Wadim Egorov wrote:

> Let's provide get_boot_device() for AM64, similar to what we did
> in commit 2f9095e2bf59 ("arm: mach-k3: am625: Provide a way to obtain boot
> device for non SPLs") for AM62.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


