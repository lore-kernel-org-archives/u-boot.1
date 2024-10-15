Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8B5D1F9C6
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 19:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E8488C98;
	Tue, 15 Oct 2024 21:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tlC9SNYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9241688BBE; Tue, 15 Oct 2024 21:44:03 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 073EA88A43
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 21:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b13c0f9e34so63310285a.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729021436; x=1729626236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GMmFVe1FTu2iVon6p0Fi9k4GsHqzXpiAuHMgmfM3pY=;
 b=tlC9SNYaZjQXjjmRDhMyXy5pPb6gOFARcM48QeANVYj0qEs76x3CyeyQZ9yTMGFOfE
 WCVq0yiQ+fLM2UmI5W7g4ZFG9rgsS3lwMj0gkY6S+EvoSS3drsS3dIoGs5ay9CSZxJH/
 WE+Qb6o3fKGVvKYMNWHkFksHtvyjBDvyuLqdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729021436; x=1729626236;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/GMmFVe1FTu2iVon6p0Fi9k4GsHqzXpiAuHMgmfM3pY=;
 b=TmjrlGmQ0Rz7Z+QbgPDwLcOqfu7Nfr+pGdgurfj3CIz5Vyls0nPL0q16fsGUS/2lGL
 H9+xb9QlG5ZTGSzK/5+IBhoq8D7khDUo7y12Ex+87lGvbTwczrU/4jC0uS0V5Q/l+5Og
 NvOFujmlmdkHACLKjDxDqHdXrYq3Mq5Ny0TdZX+S39ZE4dnuhsKaQ/dpTwkfiwubFN1v
 UvC8WJdI/840Zb+Gj2Zl3gvwguy9563Swlzwtzrt6gctgGp5gqxniOBhgkqs324bo10m
 BRDimhd8lGKuSYhcej74Eg/neTlbv6+6MC2LQQNVCM55iOYDWwkXRo0l7DBGr3gJph40
 3hmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZc4iWb1jEqh8TgHiWMcORrcvLBVpdXGiC9QEbR6D7VzZ/jTU07aYsck72C4N7jgeTN6/dgHE=@lists.denx.de
X-Gm-Message-State: AOJu0YwA0FsavvEbGS6oX+VQw3D+H9q+SZGY3lSntqZiKutEhucCzunx
 jCzwT5bZBmxHHsQspb5hDD1u0X0G00cbv3JiXEgyPQgnOb8TMDRMEsD62ynfAww=
X-Google-Smtp-Source: AGHT+IGr5e+Mf4AEzvEw7C3NmgnEpXGeBsXLYgz9t31TZuk3RT52exkoRfx7Tk5VAbTIS1DHL1ypRw==
X-Received: by 2002:a05:620a:4729:b0:7a9:9fb6:64e4 with SMTP id
 af79cd13be357-7b14184964amr151825285a.51.1729021435868; 
 Tue, 15 Oct 2024 12:43:55 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b13899c31esm94873385a.99.2024.10.15.12.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 12:43:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20241008230205.108375-1-heinrich.schuchardt@canonical.com>
References: <20241008230205.108375-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH] net: correct wget_connected debug messages
Message-Id: <172902143438.5381.11712711582987239688.b4-ty@konsulko.com>
Date: Tue, 15 Oct 2024 13:43:54 -0600
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

On Wed, 09 Oct 2024 01:02:05 +0200, Heinrich Schuchardt wrote:

> * Remove duplicate debug message in wget_connected()
> * Correct typo 'Connctd'
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


