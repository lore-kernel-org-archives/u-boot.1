Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB397D1F9C6
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 19:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A6B988BBE;
	Tue, 15 Oct 2024 21:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cZHSZnVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34B2A88A43; Tue, 15 Oct 2024 21:44:07 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1DB988A47
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 21:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b1389b6949so73176185a.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729021443; x=1729626243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPw/1ZcmRh79YURuI5wv8wWd8ecUXIRRPScrW6hXeTM=;
 b=cZHSZnVyMO2YK66aP3GlVq6midevkOM6qdWREEBN/ogtwBo3//cmGQLE0jveUvmzej
 qZs+AKRzZOTijLw/yDAvCSNx6sjz4z/uZpmBLRPi8e8pOzIsjRS09hW14rq/9osj3moK
 fwLFvI2ZL0dp5kzKwy5h8CrDnar/89Dyqq8h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729021443; x=1729626243;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dPw/1ZcmRh79YURuI5wv8wWd8ecUXIRRPScrW6hXeTM=;
 b=gZbMptyvniwCTqFSCOhXuzXx2KlmWYBe5ZLJpxTbYC9EUmXqpyUaH66K43VjrbR8BP
 u9FkLaFS9e3HuA0ocvFszW51DhFd/y5pBVGPsc85/WI+p/mWenKI8z4nBRHsO6LAjF0c
 BMIQ/hYZU3tK3xI42WBKOg4zNPsPi0vJG6sInjMxy6P8fUf48CN2wYePhjc/sTsGX1tg
 1OYprwqCBnb+yRqPrqVKUAdoF0rT6ez1Bzbj+qj393G99MQacHlqa6Hcvj42YE/Dch53
 kvSJy9l1i0PRCOLz/i0NjtR5mXyAA+YeU2C+qfrc5ZGss0K2bIkXKjw4tPm49jdMk3TG
 eo/w==
X-Gm-Message-State: AOJu0Yx1uTWxxpYN2nnW15KnC44oNbnACmbVvIYfRHPC/tnl2lX4Rc+r
 /EaoamGTYPkyLHpPulRSZEqCXpaYZQxIU16OjQWA+kBfrJ8thHBRktLuVURGxHI=
X-Google-Smtp-Source: AGHT+IFGfMSbSuB97GWHT4U8WRA6cQBnyJWunXLJRmPn7oKZBk8VLzPmoVFyqe8RzHAjC7cAJwtY3w==
X-Received: by 2002:a05:620a:1724:b0:7ac:c348:6a55 with SMTP id
 af79cd13be357-7b11a37929emr2104070785a.38.1729021442857; 
 Tue, 15 Oct 2024 12:44:02 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b13899c31esm94873385a.99.2024.10.15.12.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 12:44:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Love Kumar <love.kumar@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20241010002907.19383-1-sjg@chromium.org>
References: <20241010002907.19383-1-sjg@chromium.org>
Subject: Re: [PATCH v7 0/8] test: Minor fixes to test.py
Message-Id: <172902144134.5381.8873559941840766998.b4-ty@konsulko.com>
Date: Tue, 15 Oct 2024 13:44:01 -0600
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

On Wed, 09 Oct 2024 18:28:57 -0600, Simon Glass wrote:

> This series collects together the patches from the Labgrid series which
> are not related to Labgrid, or at least can be applied independently of
> using Labgrid to run the lab.
> 
> Changes in v7:
> - Fix 'board' typo
> - Split out from earlier series
> - Rebase on -master
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


