Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51046C83F1D
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 20:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ECC182998;
	Fri, 11 Jul 2025 22:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oBscbjAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C00C083015; Fri, 11 Jul 2025 22:00:52 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A54B9800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 22:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-73cddf31c45so609275a34.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752264049; x=1752868849; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaPssrD9mmgx74x6ANGtLMEUM1HaOzdpq8QOktdFIuI=;
 b=oBscbjAQm9WsgQPVOwlsEXPz+5yuq6zsVFMoCB+02qo3LIkv3M1MVR0cbvXCcHswDM
 IIW0lE+3RTbXibPaBs1Gl+AH/BaVRKS//ATZlL7+ZH3z+//E4VZNFlZJpv5stYUDJncb
 +yLWSyw3CdR5QxgtYlB1waIP0XwjFXDZ4Rcn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752264049; x=1752868849;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaPssrD9mmgx74x6ANGtLMEUM1HaOzdpq8QOktdFIuI=;
 b=UFQ9uXcKqcXP7VYIXiUX2uB+oDMEadTwHRdLqJKc5bvV6LD4wrm2/+n/qNoZiiYwsx
 ZeNuI2qXRJvcAx1Mc4qfg9yAgj26yJbkEAV28hS8n/GtlPN9H3/52APpDEfFIs64YJIR
 mpwKm5ckUzlS/NxEe55fyG/0j/yFw2lzegoZOsdqDp8IMDwggByBsYfvyHuUno1zyQ/o
 RpTWgQlenYvbstqxIKXivGXrSqkU6kYfvaBApyhgaU5++Y00bhDBnwwP3gjwxrjpCCGY
 OP68oJYOb7dRNuCGD7VBYMUSoIDL+49862RpH/gOFIr51MifipUlvJxYqvCE4XB9Pe9Z
 fkcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW03Db6K1WM4YbIPiv4SISeSYk/PvuhsoDN4I/ud3KTa53tND9v3VaKEfzipZI/GcTWN2KkUAc=@lists.denx.de
X-Gm-Message-State: AOJu0YwswH0zTnpkPEQ7V7NLuqOXvXW4uPetIlPhdzX7gIDslxf3R7QO
 pdohYDNhfb8CXyosamzXEot3pwZYfG821+L+PDYqUVAkS7c/h1HmQQgC0tE+YLfev78=
X-Gm-Gg: ASbGnct835jyxsp0SEaxvxVyf9HrAMNNyMsbJGaNOV9HyQhrKvaSrSKx0s8hMhTUudf
 RXSrViDNS6osU3aRU3VKwOzNAUbO99zmeoQNGAcfcR3WGtILlNuhEhoB0TUDIkTec69lYJRlBrP
 Ch8B4VNGrcmIVVuDyCgpsdoxibxCmCjLuSfOocVWVst3KagJiHhl3hHfz94S5dxDfABE8+wRcvh
 iBVksyG/f18rBkihxSK1r8BsGbotzokJWhKNcMmh3/eKEfZYj+D0vr1tiXg60Az6S3WWd+paSPl
 1WwhmpL1o904wwe/ME8k1moKwzCAKQOQhpd7HhIL8MbwOK9Nf3hj7buJ9/J3/jcJrbjwPjA7wL9
 r3DQNo2ExOwtOk45gGBalLje7cZ3T/ehl05IDvkEvrHMpumPhGJDDXhU=
X-Google-Smtp-Source: AGHT+IF1+rcAuenvmjgp5oVSqQX900e5dYT1EFkO2wKwcoCzIX/yg6qG+GZ6Qz9eRvgTsbFkCMTvdQ==
X-Received: by 2002:a05:6808:6b96:b0:40a:bcbf:2d83 with SMTP id
 5614622812f47-41511c00a0dmr3698524b6e.28.1752264049329; 
 Fri, 11 Jul 2025 13:00:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-414161e2b74sm666516b6e.0.2025.07.11.13.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 13:00:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de
In-Reply-To: <20250704-erofs_fix-v1-1-956be16f32e9@linaro.org>
References: <20250704-erofs_fix-v1-1-956be16f32e9@linaro.org>
Subject: Re: [PATCH] fs: erofs: Do NULL check before dereferencing pointer
Message-Id: <175226404820.2365211.17225429153023348856.b4-ty@konsulko.com>
Date: Fri, 11 Jul 2025 14:00:48 -0600
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

On Fri, 04 Jul 2025 11:53:18 +0100, Andrew Goodbody wrote:

> The assignments to sect and off use the pointer from ctxt.cur_dev but
> that has not been NULL checked before this is done. So instead move the
> assignments after the NULL check.
> 
> This issue found by Smatch
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] fs: erofs: Do NULL check before dereferencing pointer
      commit: ff8a41ce4947c6d7f1826990d5d7b96d30928e3f
-- 
Tom


