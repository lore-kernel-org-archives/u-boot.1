Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA4FC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 14:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E147A8215B;
	Sat,  5 Apr 2025 16:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PmJyAUmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1533C82A64; Sat,  5 Apr 2025 16:28:12 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC3882063
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 16:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3feb3f54339so2116320b6e.1
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743863288; x=1744468088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fhvvFXkNISWcOMDA2AiagiXRsitazxG8pKdrDr+SqI=;
 b=PmJyAUmFgPbicOmWMN8ngcvEc+tkfgELC93BZwesSw0W0JTGMtRlgxy9ci46BdHRHE
 TaZJGjDWT9OTuRttT0IC+xA4iaAgzzvaXpN7KnP1CyU/bnZAkV2Kdh1c1z2rjaJJy7dF
 gsAK+4agAfCB5zF9yxi+gthE7MxiufPEPrrh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743863288; x=1744468088;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fhvvFXkNISWcOMDA2AiagiXRsitazxG8pKdrDr+SqI=;
 b=LbAK9l0Yx/CHqNOykmFL8qCevL5/HS/kHOiyD/35FIAvvNZy6CRCH/zErZQMZSQk/g
 ynSWVZnvk042UgtWXkDInMCGGh/YMI7tYl66Qfn9DTT2MYMi5wwwrR5U6VcJ2wC2V8oY
 RiU3CgGa5g0EOk5l+o8/JkSnW6SPwk+euFrvGJTkXGFQAO4gAODcJ/xK0169722EJdRD
 GXdJ9BZ0tLBoIV8yl1wCAVTwFrTM+o4tEjrRBGlVKi1AxpzsV/d9mSO4yBxax3M3B/hb
 22HVHR/dJ480G6DXZsBjkW51Ok/qJ3qgi75bIYt25DY9ZzF0Xddfa6EJ7cKHBqisdOa9
 +sIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV45W4t1CwYpl+59rJd9drmjtrj3cvYA9SMo2Y+bA2ROcZky6srXr1JY0v+WpY0RGUFfmyNGhM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3I6CEExryJ9A/7qGOtIPfO1hlPGw5gsMeomSkr4AqmN0tjxIq
 RiuHq2Bd7l3rRV2uQ4VQyfaqXUcxwgVmsVqYah/x/2VwmZOViI7YJrl2JXy25dE=
X-Gm-Gg: ASbGncuOxqSrgqB66H/JRks720gvqkiaQk2SzgJqjHVDmroFqUQ3+uiRFYVyXnnIkIg
 824LCTrYEhJ7qs6Crs1qrhiZmYUZzxcC52lLNSN0wKl6Z48i1JopDaWPjoQNfPn89yRoUVuhEVR
 cWt5aHZWWF6Hdj4FapmhNkEwhvOtGdx2oS1Kq5xC+uzkp8ft+Yc9GmwMqRGwEyZYugD/fQp5ZMt
 wYVCc0T8sbuvfW5hV71lJXrr2eGjUJQroyztfRfOTpOfMOMrTJV3YD8QA08AuzNgLvpbRcgZjZY
 5HLkau5pAv8sx0M/Fn+9QSv2UBELN/UFmZ4ViOUI9mLAy7ULdcukfAxbT7XH2QOSR3kIOPH6tnW
 evkCC
X-Google-Smtp-Source: AGHT+IF94loiaj2STAaqd92bv/7BiaKukH9CivSNDZnPn9BImgsn5+jB1zZbfQD3h7pgkw0CsNSWdw==
X-Received: by 2002:a05:6808:22a8:b0:3f9:d5a2:8999 with SMTP id
 5614622812f47-4004655e008mr3789882b6e.3.1743863288580; 
 Sat, 05 Apr 2025 07:28:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4aaa69sm1055979eaf.3.2025.04.05.07.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 07:28:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 =?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20250319072203.327431-1-ilias.apalodimas@linaro.org>
References: <20250319072203.327431-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] arm64: Fix page permissions for platforms running at EL2
Message-Id: <174386328733.2689048.9688784248751999385.b4-ty@konsulko.com>
Date: Sat, 05 Apr 2025 08:28:07 -0600
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

On Wed, 19 Mar 2025 09:22:02 +0200, Ilias Apalodimas wrote:

> We currently set both and print both PXN and UXN bits when removing
> execution for pages. This happens even in the existing per platform
> definitions of 'struct mm_region'.
> 
> That's not entirely correct though. For stage-1 translations, if a
> platform runs on a translation regime with a single privilege level or the
> the translation regime supports two privilege levels and we are not
> in EL1&0 with HCR_EL2.{NV, NV1} = {1, 1} only BIT54 (XN) is needed
> and BIT53(PXN) is reserved 0.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm64: Fix page permissions for platforms running at EL2
      commit: a5ac47911abec63bcc5b3d2561ed9a5cb5a63841
-- 
Tom


