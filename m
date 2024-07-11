Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9108BC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 21:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E039886D7;
	Thu, 11 Jul 2024 23:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qWYTRfyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B94D487B77; Thu, 11 Jul 2024 23:27:56 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2C9088606
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 23:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d934cb84b6so806068b6e.3
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 14:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720733273; x=1721338073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IzrTID+YEqvMpBlr/UPiamjOD6nNMs/TVXhs+SYGx3Q=;
 b=qWYTRfyR8W3gt68NG2UGjzAImMxHUTXb2r5xpAX+LHny675+iOp25w5WhsIolkYhSU
 fsn7e/XLirb3X30QBuGaW5YuUILNhJigfj3ZAivzX4kLUkWTNB8IXQGUNJ12SFXUKojv
 F93I7LFsqdQdGg+IMup1s6KiptmyCZm7Lb3Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720733273; x=1721338073;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IzrTID+YEqvMpBlr/UPiamjOD6nNMs/TVXhs+SYGx3Q=;
 b=vRO9Eig2b7T3Ge8ghiGokYpUDXJODKXCTufsSdbfbTuGCK/d9TA+TIDFi091sJtp+w
 R1Y0LqQblJXGXHRJCTXN9HeFaMKrcO+glprjGAf1TMfJ6sI81bamh7Ltsl7Cs+JqSokh
 zybMXgFQMkxTa9rz+sQ3XevRLJpwNP6JrDxTUc6mPrQMdz14F5OG7AzRV82pKrDwsCWc
 AkQWKIoYre+yBj9VCOAzgyHNFTWg3KC3K549hTUMTjMiaQbXF0YCORFsr0gnPQQ6HJs/
 jepastXOy2ZkwMigvm6syQJJx2fgGbt0lBhVn8GErDz875qU1P4bPubbHdyW/XMULWF7
 hPow==
X-Gm-Message-State: AOJu0Yz3xpjB/mI4t1ULxd5WdF8Io9Pw2mSUj2Bc6lcf9HMt0On1tMFc
 neMsytDQ/ybdi6kd7O5mG6+jVc06Kt68i8G3qXWDAJgyMKHNBO0I4VXuBNg1Yu4=
X-Google-Smtp-Source: AGHT+IGLI4zvpw02BxWzkv6dmqSTlRrTRTh8MtHVKgJpKfdrv6Y68Z5E8lvdYwjHDjFPZZqCbKqHFw==
X-Received: by 2002:a05:6870:470f:b0:25e:bcf2:b4a0 with SMTP id
 586e51a60fabf-25ebcf2b58amr7380376fac.49.1720733273414; 
 Thu, 11 Jul 2024 14:27:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa29478bsm1824155fac.46.2024.07.11.14.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 14:27:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
In-Reply-To: <20240628083411.19843-1-Maxim.Moskalets@kaspersky.com>
References: <20240628083411.19843-1-Maxim.Moskalets@kaspersky.com>
Subject: Re: [PATCH] cmd: add resize for FDT in bootelf
Message-Id: <172073327282.2744109.6121930781158464427.b4-ty@konsulko.com>
Date: Thu, 11 Jul 2024 15:27:52 -0600
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

On Fri, 28 Jun 2024 11:34:11 +0300, Maxim Moskalets wrote:

> In some FDTs, there is not enough free memory to add nodes, so this
> operation fails.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


