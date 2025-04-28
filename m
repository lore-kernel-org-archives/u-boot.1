Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1B1C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 21:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF397826AA;
	Mon, 28 Apr 2025 23:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nbtPqrTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D61F3822D7; Mon, 28 Apr 2025 23:34:03 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5AE8214B
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 23:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2d4f8c42f49so3720430fac.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745876040; x=1746480840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3NIuFPC/ks9KHC0Lw7NzRpGn8YH4gsimG7eLRVTnPs=;
 b=nbtPqrTOrDy+V+3CribOzx8Ol6GvTiYoKPhr2IU/JbLXeoLR9zioy0Y4qY0HLkSPhr
 EdvCWJRgmS+MQ1ukeTzC4Pt//xknOTgeT/8XoJi7mHZY0K4FpfAX9Jk+9ysgDcJYZShz
 GQIfXaP7rBhuWLyyZTuzD/bfg5kkDw3ZjgGPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876040; x=1746480840;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3NIuFPC/ks9KHC0Lw7NzRpGn8YH4gsimG7eLRVTnPs=;
 b=HuIN56cdBPlS3qZgH2NRXEo8tJakvxNn5qrni4Uf3BQL4/9QiiR3aX3onoiD4zrMmr
 YM4uTZFzIkLg1ArxGlvVHYObzNbbXr1TclBjfbjuxpoMXdE931GNKxwg77W7iiE2Q8ZI
 xNw/ESDcfC1TarEbEUnH77Znkx+MXA57lA7CZO1cLtSn/V8PapUCagMbDECMrPJ4uR4Y
 B+8L5FWBAlF0CWGtJVxvfOlaVnCyRhF88C9EqI2mRguwFxjlP/F6QnSOllJ7AcMDLDOF
 yTW7NqrgNd7atV2zn7K9QLhEZm4/RITVrpn7Ep7TG1swAXd98J5geqY1CNeBUKlSWwk6
 XUBQ==
X-Gm-Message-State: AOJu0YxelQh85+wXQgL+buiWDGsMe7kpC2Fyosu3ExmLBpUUMDB3c6tx
 wmk3v4gPcTer74+iUA8jR4tebYxRPDh4hByMOYLQY4szCwI0aKrieoXXuOCaFV38eKqwLy0yjZg
 6
X-Gm-Gg: ASbGnctDGD6MC3DG/e4FbP1ryb9hxAT3rx/L2pGuvl1qdDx7oTCAg8Z5HAeQXygEPv+
 dRhhKbWvl2TQEaovAFaOKFhtKpT3QRFJlC59ybXSiq9QpfqhWGY0nZ3+1em2Rl1NVHQR7RUqfcb
 SkgKp3qbbFAf3RplD/xLaRP5Bhm7i7yqaiq7oXpjMTnOjWzb2KQ6gHDqiovvGZAWFSXb6xqTjwo
 yRVw6PywQmnKkxAbnjwNfsDQDjFQp5fGahi3Cdnc/IwPpqUbFw2mGdXidVAYSBKEz5Hs6vp6fO7
 lgxzDMyZ/yl3a1GM9N6sZT/bRlvuaV+sH7vGuHa4ypkJ6g4Hg352SAYijGqvMnk05OagvtWNYPA
 R
X-Google-Smtp-Source: AGHT+IFG0ELTbD7DD4rbpXJwsp0EmIl0LGOwFsO1QX6eaM4MLDIQj3vhj9b+3xIE/I3PqWNKR+PnHw==
X-Received: by 2002:a05:6871:791:b0:29f:bdf0:f0f5 with SMTP id
 586e51a60fabf-2da464de0d8mr466252fac.17.1745876039982; 
 Mon, 28 Apr 2025 14:33:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b139000sm3108a34.40.2025.04.28.14.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 14:33:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250417135615.2974560-1-trini@konsulko.com>
References: <20250417135615.2974560-1-trini@konsulko.com>
Subject: Re: [PATCH] cros_ec_sandbox.c: Drop spi.h include
Message-Id: <174587603918.1121500.3795426693768890628.b4-ty@konsulko.com>
Date: Mon, 28 Apr 2025 15:33:59 -0600
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

On Thu, 17 Apr 2025 07:56:15 -0600, Tom Rini wrote:

> As this driver needs to use the special sandbox <asm/malloc.h> header
> rather than normal malloc, it must be careful of the includes it brings
> in. It does not need <spi.h> for anything, so drop it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cros_ec_sandbox.c: Drop spi.h include
      commit: 7bf752238327deecda12190154864128d55f78bd
-- 
Tom


