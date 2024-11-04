Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FABD132CC
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD0388A0A;
	Mon,  4 Nov 2024 14:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H4pC70wM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23E788D14; Mon,  4 Nov 2024 14:56:05 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6451388EF8
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-46101120e70so32817341cf.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730728562; x=1731333362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AUzkX8XzrgFoB5zk5bEGrGy8S03HCok75iO8IeAMqNI=;
 b=H4pC70wMhzwg2BVaufiHZbVTzMZK8QMMkJQ6gpr8gYx/BeUhrKgROAfFPblog9IZZu
 Ta/jIXG9OtQ+gzLBdyQqfiy6DcS8kkb4ykWX8DAqw4x2jPjLRce+Z8G03yKMNMJjNDzX
 0D3U6yAKOgHX2MCmHJZWKKg/2OkrNicuL2z9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730728562; x=1731333362;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AUzkX8XzrgFoB5zk5bEGrGy8S03HCok75iO8IeAMqNI=;
 b=dM6zJHah0g7X2A+QkpuS/nHxhs5AR7pPp7fb2Ny9wNE3bS8Fhrr0KRA6PQF7p9YQe1
 djY0Ss7uLBzkKCNg0lmgyFMlRqis1/a/v1lrYMF/MDqejbsvqy9SwzkXMZ/p9cLQy84M
 pgf/OB8Yum+ZRWSg3Caw5+uiRj609vyLcEeXDAvwuLN/qSbFPTzSYALOEQPkrSqLjiMX
 M7MqGpNaDoHqZUYHO1XOrNfMa/bkzbghfi9/3BwQxm0HeZX/vIToi3CbLGI5MeYoxc9J
 sDkXiCEw0AALNMxyMcuX6FAGHhc7edT+ad7AVIx41bFGavEtzfO+MkXpb2hZ8dSQDljF
 4qzQ==
X-Gm-Message-State: AOJu0YxLNRb0XrIG2BW2c1J3uEX/9xVVCVXOfPxORKsVeAQ9Moo9Zl4n
 tCzTFe6R/eZjcaZ+VWzmFdFT/gdrtFAA9PTgLKi5zxtp8qPJ6EUOmyDypyU8JcA=
X-Google-Smtp-Source: AGHT+IFllEhAERBRyEi6vXj/DutOPdoO8KdQAmp1AUuM6nQ5O2q/UUOs6UxdX6kW8AyqnKhjOgExKw==
X-Received: by 2002:ac8:7758:0:b0:462:ac22:55a0 with SMTP id
 d75a77b69052e-462ac225703mr173658611cf.54.1730728562243; 
 Mon, 04 Nov 2024 05:56:02 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad086df0sm47152751cf.5.2024.11.04.05.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:56:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241103105635.107181-1-heinrich.schuchardt@canonical.com>
References: <20241103105635.107181-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] .readthedocs.yml: update Python version and Ubuntu
 release
Message-Id: <173072856088.3281395.13546866384408386941.b4-ty@konsulko.com>
Date: Mon, 04 Nov 2024 07:56:00 -0600
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

On Sun, 03 Nov 2024 11:56:35 +0100, Heinrich Schuchardt wrote:

> The current documentation build dependencies are not compatible with
> Python 3.9. Update to Python 3.12.
> 
> Use the current Ubuntu LTS release, i.e. 24.04 Noble Numbat.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


