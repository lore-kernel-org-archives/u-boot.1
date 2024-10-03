Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01E4CF8552
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 02:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2BAB890DB;
	Thu,  3 Oct 2024 04:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EXAB1JJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C7289109; Thu,  3 Oct 2024 04:52:47 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3848890DB
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 04:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6c548eb3354so4535696d6.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 19:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727923965; x=1728528765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y6dgfdoYOzbetS6KZaJV7Daq3yrUpYH5cO581sZnRy8=;
 b=EXAB1JJ6ki7S+FDuUUf8CBYo+SJqDIyKqcAoYVEs1xRAvLzDwMes2zOT/Rq8wn/28i
 eK3ltOT+AShSKr0OPPAH2VBZ2eeQS5gAAHvh562Hh20zUNYOGYsFwhKoEnK4wKrmnJ1p
 ON0GOxd0JXiu5i1CcuTGYApIVZ9H8mg1T8Po0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727923965; x=1728528765;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6dgfdoYOzbetS6KZaJV7Daq3yrUpYH5cO581sZnRy8=;
 b=VmBPySxu2jELfwOW8hPMu3vRJpREvae07seEBpv5ZMMXSdvk3N70G3LZDiziSS31hD
 /RyTPjompkI/C9bWXiqd5sk6f4RaFdzJx9hiA409324zFpYn+422TQacUAUxfSnSU7bo
 h6RqaSmxkP/qMNTzEXhutvXKSfsCR3EegNGjNAULlYczGketosXo9lLbN+r1TAXTvrvH
 RqQfBVasBD0QbqIrOadXNQplUJ5MZEXc+jJcNS+DCiOpL3+9zCckyqCp00Bcvo5zCkpo
 WpoT9DhkvlfxoB1h1ADFhaJfPpsPohTvFRfphi0toS8CaT5FpFQxZ9N43ptcRkFfByaw
 JHgw==
X-Gm-Message-State: AOJu0YxFEy6bkvODsOnd0p5ZT5znI7eknZ5o2weImTFfFyaW6gsLQU0H
 jL5B2D8KinT9V8Dd8dtiNFsLjcxpC2d0k/zt55xLi4MgsZ2EZqyFgxsq33C9sI//KNz5FwCP5MU
 HYRk=
X-Google-Smtp-Source: AGHT+IFT9YykCDCyKEnqIeVyWcKJslhn4faOQpc9U68AI7Nbh3T7NInSAtptHQATjhyihBvNPbzx3Q==
X-Received: by 2002:a05:6214:4604:b0:6cb:4a84:e02a with SMTP id
 6a1803df08f44-6cb819dda70mr88366486d6.16.1727923964729; 
 Wed, 02 Oct 2024 19:52:44 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb938211f0sm1606826d6.142.2024.10.02.19.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 19:52:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, arturo.buzarra@digi.com
In-Reply-To: <20240923082518.29507-1-arturo.buzarra@digi.com>
References: <20240923082518.29507-1-arturo.buzarra@digi.com>
Subject: Re: [PATCH] rtc: rv3028: add support to manage VDD regulator
Message-Id: <172792396338.1516896.9148223079349201959.b4-ty@konsulko.com>
Date: Wed, 02 Oct 2024 20:52:43 -0600
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

On Mon, 23 Sep 2024 10:25:18 +0200, arturo.buzarra@digi.com wrote:

> This commit adds support to manage an external regulator to enable the main
> power supply VDD.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


