Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00C5CA0EDC
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 15:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0593283A45;
	Sun, 17 Aug 2025 17:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hgJl5Ky8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C87C83A84; Sun, 17 Aug 2025 17:24:51 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D1A183A45
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 17:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30cce50b75aso2244025fac.0
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755444288; x=1756049088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jJ+q4Xl5Zn8tfjPpoFPHQz03e7VSosute70xAIspWQ=;
 b=hgJl5Ky8qWl3MTHoKZpnA1PVfRaImXANcKm1irzBiwoP9Ap66KAgpL8lku8laFp73J
 UJVt3+CML1RoomMi7UL9lURWs7WS/WbMtKe7JNw7b0f+VXZv0CEgepyDA9DBtziMhswp
 hrjnmnVNjB9xofHFBPoHr8A2ZipQS/v+vTUI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755444288; x=1756049088;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jJ+q4Xl5Zn8tfjPpoFPHQz03e7VSosute70xAIspWQ=;
 b=NhTr1LWWyvK3Ppn3eptnz+xKJaToI/JgQmK9Mr5ThsbdINPqPwY4QFW2XVVH2F4yK7
 rL+720f5iuUQtZ1Z9FCQ96CCxQ6RRc+HcN7d9XCRIiR5x42ph8JlWIVbFrEYC6woZ7bE
 lPIuDI4G66nSvD/dGKiRxT3A4KcOsyr+PgxsQUZpStnObakjBIUSZgrzBSXMSLDjoSTS
 s7s+FTm3nuJ1raETb0XsWEdb9IXAnOaEoT/ZACrUjEvYTuqn5Sl9ozXZDsBmNs8POXop
 PE/n6Y6RLd7gPHuP64Kf3r1sbpjrQUPzzbDO2Tibi/OMdhfXyCn597GA05KdBijJf1FM
 9kDA==
X-Gm-Message-State: AOJu0Yw5QZGtBcvzBjr43/PNWilnxQjFMlKpAOJPqWbe+jeb4svcj1a7
 buWhpAGuGjZckm+enDWUbBdfz/lyfFDE9o+6vFmTcYuqjrIQoyhCqpuHFzS0U79DQ+75hLTwss7
 rjOEwcqo=
X-Gm-Gg: ASbGncunYsaHRNWUJSRciazBSBhJQzM60/fD5X0lbbbbZLY1Wckimg+udxkzjv1cKW/
 v5mFWMcGmULnky60RA9WW6kZ68jUZlraNOYGAr3qS1IuZsE56NXSoCdnOyUGfRNRCvckHU9lwRZ
 U7M4PzDrUYEpEmrvhhyE+pzw978MWeGVCjQEI7UW90/qZmUr5LVFakNGfVki/gPiKknU4JwU8XQ
 ECdQ6EwXO8SmzZ6dtCH4pb/2UxDRvm2He3uiccbcwBxSZo+IfL85BIR7CuH5WbFEFc9nEWtNVtC
 BHal4/UGaTt6EGDOyOvJ8mwJ97GibG+8Uf79fEtPeOUA5TGPJA13nJsTqp/sk3G+694mvxrTkuV
 rQJwiyx6W5eBeBiA+6fs3Whr3awMrS+W1HKQJC19Gp+fa8vTjTgGHUQg=
X-Google-Smtp-Source: AGHT+IFKEBKUMo98XN887J7C/GdWC9RPj2oFsyCNxa0+y5NVVlgA+MRlfj6DjJKDNC3AKVXUl3nW7A==
X-Received: by 2002:a05:6870:8927:b0:30b:c1c0:431 with SMTP id
 586e51a60fabf-310aaef8ff3mr5194478fac.35.1755444288266; 
 Sun, 17 Aug 2025 08:24:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab878a4esm1998472fac.3.2025.08.17.08.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Aug 2025 08:24:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250806-net_ti_icssg-v1-1-860dd0bf1acb@linaro.org>
References: <20250806-net_ti_icssg-v1-1-860dd0bf1acb@linaro.org>
Subject: Re: [PATCH] net: ti: icssg: Remove impossible test
Message-Id: <175544428690.372553.14760839827422919707.b4-ty@konsulko.com>
Date: Sun, 17 Aug 2025 09:24:46 -0600
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

On Wed, 06 Aug 2025 11:56:58 +0100, Andrew Goodbody wrote:

> port_id is an unsigned variable so cannot be negative. Remove the test
> checking for port_id being less than 0.
> 
> This issue was found by Smatch.
> 
> 

Applied to u-boot/next, thanks!

[1/1] net: ti: icssg: Remove impossible test
      commit: 2a61c56dea1d7860d4a44afad3f54814ff0b805b
-- 
Tom


