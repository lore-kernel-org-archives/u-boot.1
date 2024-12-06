Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A49EE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 18:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA3888971E;
	Fri,  6 Dec 2024 19:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NyNgZ6LT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A632E8971E; Fri,  6 Dec 2024 19:58:51 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DBBE8921B
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 19:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4668978858aso20052561cf.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 10:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733511528; x=1734116328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWJ61DDJAxUiswrc0BVCzWa5gUToGLAvNBRfqjwW+mg=;
 b=NyNgZ6LTTRDICtTW9p2nyXPLV7JWk0Lk76nqNfv7WSmQk/1bTme/Z9gVJPtZ/Rl3Nm
 9b9hEkM/P90NDFdtpcs1jqlkp9wCxS48nVKOLVd+pwFpNLgV6D3FxCeUZgMiwQQWI1qT
 XvNGJIS7aITubx0S9xudqdlA/CntZSmyOPryc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733511528; x=1734116328;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWJ61DDJAxUiswrc0BVCzWa5gUToGLAvNBRfqjwW+mg=;
 b=fdPwCW6qZNTH82Ca6hGTWCSHoHWZ/Y/fRxQSeSxdq6AYIX7PfIhVCuostCPsSqTVS+
 91rCWCFrL0Rn+MjkvfbF4iKY98sS5xa/j8NLnck+xVTC8r4o5dZXAlMnWyW4tzoTTHUS
 TmjZK1kJMOw17gXb+1C+dUsO+JoIfncMGUL8lgJI/Jq//LOEhDwAIBFv/M3mf62wBlb7
 tiVYP3V315pekRYa/axK2QgXByy79xHpriCsJVf9zs7oMzPnumdQxSgUIT9a3i2uxqid
 wylUv+8tp6mled1sxr2qUkvfgY1ooieLRNKC5ReEyqyEWGy4xFD6gBP++lxBRqaZDHfJ
 HncQ==
X-Gm-Message-State: AOJu0YxudMVylm36uxcV/7OXgHnPNlpXH+p2MLGR6ya8Q1juF2o2QTCF
 49x2esiMySkZn9rcCRa6Iq7LL07UJIB2w8xnp4cgQmWUeXVVcF0Exh6ez1lZ5hYPG/HapL9IMgd
 1ytI=
X-Gm-Gg: ASbGncuErwnVbvsMd/HzT3TdxkzW+iERe1ScY327fkHGsxFwj/uK3uGspFNcxv8xVCn
 6rgQ9q4Fn8bTpOdd3DK4KHaD1AmtsPHyJYicsFSy+7InFF9/YxH3GsecXXq36O4/MMb9pYZcjqj
 FsuQkf/uiKm+oqXPWnZozKYhsrntGnUSCBX8VIewjAmJtYy0Ke3Dvtp1XPko+ilGfnAwC6S3gxg
 6p9lI2ZbCUYWjWpO//zyay96443mnZHHuqzQiav6m1KiEZ0
X-Google-Smtp-Source: AGHT+IEIl+FWzYP8Lv6WRR+D9aFDVYsF7FP0TFjS+72kpNh1tS49/+5g0DtO6yfAlDEUg/VcBhgCKQ==
X-Received: by 2002:ad4:5e89:0:b0:6d8:8ca0:a7 with SMTP id
 6a1803df08f44-6d8e71daca2mr53291786d6.30.1733511528395; 
 Fri, 06 Dec 2024 10:58:48 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da673441sm21909066d6.1.2024.12.06.10.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 10:58:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Maxim Sloyko <maxims@google.com>
In-Reply-To: <20241115165400.2486914-1-trini@konsulko.com>
References: <20241115165400.2486914-1-trini@konsulko.com>
Subject: Re: [PATCH 1/3] aspeed: Fix Kconfig logic on "DM_REGULATOR" and
 ASPEED_AST2500
Message-Id: <173351152740.2516797.6116756756433979207.b4-ty@konsulko.com>
Date: Fri, 06 Dec 2024 12:58:47 -0600
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

On Fri, 15 Nov 2024 10:53:57 -0600, Tom Rini wrote:

> It is not the case that we can only pick ASPEED_AST2500 if DM_REGULATOR
> is enabled, but rather choosing ASPEED_AST2500 means we must select
> DM_REGULATOR.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


