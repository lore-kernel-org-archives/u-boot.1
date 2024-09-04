Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C29ACD4F48
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 22:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B9188BB8;
	Thu,  5 Sep 2024 00:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="etku9I3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A92688BCD; Thu,  5 Sep 2024 00:58:00 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7F988BB0
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 00:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a8197d82a9so10472585a.0
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 15:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725490677; x=1726095477; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k9Rz2mMq+y3gqkwOGRSPn2AkB7id2cGSGPDBaGyrsvg=;
 b=etku9I3Lp0WWb4GvsUgK+HI08pujm/b2Dix9Cxt6encMIMZwEp0wAEDNMvWLp6eor0
 qkZuEyvvCdxuulIT3TuyHB7gpb7Gb6zO0WJPdlZSjAta97pwZ/GJERjnKHp55SipJ2Js
 IKfQiGM3sEJ6BlED2/Eh5dUsxgwJfAboxjLCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725490677; x=1726095477;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9Rz2mMq+y3gqkwOGRSPn2AkB7id2cGSGPDBaGyrsvg=;
 b=DFFFJ3+KbMgTalGE1IrcJjYdDA9UjVlRu05QaKgsbKqzMJOKimB3rqgGvLN0oH4bEJ
 qGlx4xGT9mtrytDCSYazZupRt28jJQx+YI3RPA5L+Arr2el4X0aRRFtGFz7cU3UBuONe
 2d/vDticQfD0Rf4qHLKoUShUjsAuafabQJOWX5fdhrc198lVSCCU2Vz/H7Id5diUfVwJ
 OzKyH7VqYGTYqdKeRySk4ddtWnsEXg58neGDGviUpEavqePRvABeBh6AYksIyGRVBLe5
 SBZZrOpt6QPWMZA4gFxMQGuinzUo0sjJIKr49J63edk4oDum1T21noKOwgyLxbOi/gtU
 3hWw==
X-Gm-Message-State: AOJu0YwBeWml653ZRPMOWpsxPJOyIzjY35SOGnlS+EQB4DmQN8FG5T0h
 FVZu21VL9L2tEyCs1buhksTISdEtI4ywu4D8yd8d7qeR9O+F43Yt5l7J2X/6WHjSxmmCibsUMEJ
 1
X-Google-Smtp-Source: AGHT+IH138cuUGpG+WPLbjHdj0ypO0YQ3nuQT2LwnDr7UvoxHGgJ8qQ606TrDH7uf7c3+1KTzSBt8Q==
X-Received: by 2002:a05:620a:28ca:b0:7a7:ff36:a2f8 with SMTP id
 af79cd13be357-7a97bd2a946mr623664885a.65.1725490677382; 
 Wed, 04 Sep 2024 15:57:57 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98ef3adc0sm27177185a.37.2024.09.04.15.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 15:57:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240829185602.3179812-1-trini@konsulko.com>
References: <20240829185602.3179812-1-trini@konsulko.com>
Subject: Re: [u-boot-test-hooks][PATCH 1/2] bin/writer.rpi_mount: Use
 kernel= and simplify logic
Message-Id: <172549067635.1706866.14084557443852854948.b4-ty@konsulko.com>
Date: Wed, 04 Sep 2024 16:57:56 -0600
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

On Thu, 29 Aug 2024 12:56:01 -0600, Tom Rini wrote:

> Rather than guess what we need to name our u-boot.bin file as for it to
> boot make use of the kernel= option to always call it u-boot.bin and
> then on 64bit platforms (and since future platforms use rpi_arm64 this
> list should not grow) also pass in arm_64bit=1.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

-- 
Tom


