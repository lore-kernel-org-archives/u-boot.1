Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA686E8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FF26841D5;
	Fri,  3 Apr 2026 21:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DBY7wJuk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2954184178; Fri,  3 Apr 2026 21:47:25 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 143C48419E
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d91f82d819so2130227a34.1
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245642; x=1775850442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4oOyMsLYlcpv6qPHB9VC5ROJ+gTIYvXE1NMErwS67ZA=;
 b=DBY7wJukyNcATxaRA33oYl+COqULZDcJkjogmvrswzw7RBlmESczu1zcjKyI9IFrqe
 /3uRRFRUgER8/M+aEmWppWU45NUrG1Rb528byftwJvU0QRirOmRmfYwGHWHCnLjQ/DQ+
 c8pwAxx5habHa1funFPtZOcyZU9r6bu6WBUBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245642; x=1775850442;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4oOyMsLYlcpv6qPHB9VC5ROJ+gTIYvXE1NMErwS67ZA=;
 b=Dg7WFnai7a6jH1kpBF6jOFWvgZ2r0j3shl4CdCGplkQJV1itlOGt/2CjpcDYEjJiZu
 9iiDs4sWwGHVMvHmeg0TAPmTePJtw4iMySjgTsDJh37Hdm80x8INhpJqvKWBpJqyeRV8
 qJnLrmcLyisPrfJ5AvVCeoUSzUVgg/f910A2r/JzIYYtFqtb5GKrmmSdu3ikNcICW2JX
 sdhWrBY3lNHw65y0vOZJxOO5eehkSqlxPU8VmzJWaqvZEo4CpHforffqbBrNzIJXWHaC
 PzWWcJW727MnJSKR+8RdQabJ6BnnlbGL+8XOOhfykI6jbi3C6ojalgB5ciF4d311twxf
 8Wmw==
X-Gm-Message-State: AOJu0Yw++PUS+UybbJfghyQexu59SXmWgBnMSZV7A33E43DhL97gmTo7
 b2FH5dBPfdEZfG+yZjbLuc9lNVlW05n9AV2GAvQ4Uql2XfOipEfmGBGquxNJT9EwP+ajX1mnrAv
 IzCwABcA=
X-Gm-Gg: ATEYQzzqWzQn2eItyJzhFJsiAN1ZrLGdRJwkHgCdrrt2R8hVwEavjE3W1NI6rnySdSh
 PRgrxFbItkz1kcdqrnCDCLxbwQnwQSY3ZuADkwLkMQAqkqTA5OytGkTTricurCWHSoyvIswciwt
 YnzdsMy867rLIH35BdDY+AULo90l50TcD20Uit8MN1aFUPzDriL+jgL+fqur5vjnp9IfkeAdZXw
 R/4K0RtiWT1S7x1pQYaJ5DlAaKl9nC95u5AQXrxFhWMxTVXIm0rCpwx45XVk7/IR84l3CNld5Dl
 Tshy86lY+Rmh5C02Rf1iGGVNSWgMjYJdVoI7Pdi78++zapFbkx4ebmitAlZgPMYG3ewceCqltpa
 TdAcDWkUpZmklx8sGwcV4l81P7/CaM0tIXKY80mwTmRAHjzjiQ0ngtrO8AW/O745kK+5fKt1tqH
 nizC/6uvbwk3bFnW0Ms2RxLPWgAFXjAJlhEln62exVr6ZzZ8m5dP5CMJE/SdTqIZPZoKwny3vEE
 zKmnyoNuo9kVlu88eCyovupl3jhjCcPDgf4WtZC9bUSn2C3yBj2U0vdUg==
X-Received: by 2002:a05:6830:67d0:b0:7cf:cd98:b3c5 with SMTP id
 46e09a7af769-7dbb75d7382mr2568292a34.31.1775245641840; 
 Fri, 03 Apr 2026 12:47:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205343.3789032-1-trini@konsulko.com>
References: <20260320205343.3789032-1-trini@konsulko.com>
Subject: Re: [PATCH] boot: Add DM_RTC as a dependency to CEDIT
Message-Id: <177524564127.2281750.17407410025675280530.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 20 Mar 2026 14:53:43 -0600, Tom Rini wrote:

> The CEDIT functionality, due to the cmos functions, depends directly on
> DM_RTC being enabled in order to provide that API. Express this in
> Kconfig as well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] boot: Add DM_RTC as a dependency to CEDIT
      commit: 70b5afb90579b7c1f5c9ce894f8536c051ff8f73
-- 
Tom


