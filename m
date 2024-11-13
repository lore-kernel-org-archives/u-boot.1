Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228B2D637D1
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 23:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B13894E1;
	Thu, 14 Nov 2024 00:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bo1m/ueg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F2E98904A; Thu, 14 Nov 2024 00:50:59 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 318958904A
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 00:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5ee645cf763so50419eaf.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731541856; x=1732146656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omYI/LSMYcjltH3fCISuI1pptN2+5ftRdL7GuBx6hCs=;
 b=bo1m/uegYCWa9ScQBN8z6Y8ZMYEmAOnDliL0aaZYBNLpI4Dk0p10tj2G2/4lwgKiU4
 6W1pWUN6ixWF/RyG0z8Gxbw1X56y0LKqKx8V2OU8W58wd9Og0dEQbMXIxFRmwBB/KrRY
 097BwB5EP6TpfyX1ZeTXjhjNPUij4xSfOxj7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731541856; x=1732146656;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omYI/LSMYcjltH3fCISuI1pptN2+5ftRdL7GuBx6hCs=;
 b=jdrLaUZmWx8jnAfmtr23RSwZTvxdwW2EzLqeYEF6MCYuOG3dJMGD/ci9E3fTxtqLd8
 TVTDrYnPfYc62VeAC6OzRhfJATGY1TVJkWn7ehA0iA+c6TwAkSGUDHi0WWdKO8L0Ykvf
 eAT7XdS5Pg+weiFhHiN/whiHxQMtTm2BoUt5ags9Kqh2MdMxsc4HMffquGfCTrKYA+6F
 7mvOqwzD6txghxI1SbAc+EKC/+L/O6mkH2qKNdFBkmtQieUp1B3nbnLs61gQ6uXCxT36
 urQNE7vN7B8IoJwlXOeVdOInUMlJIvMnGF0Du7Den0JWx9KU7Wxy23gI1NBzJ1DLx3yk
 BHCA==
X-Gm-Message-State: AOJu0YyZKUobHrHlaKJ0wy2FVAVP0/CX7Fn/mDPRyEPO4WmrXP1cTPAr
 y5Ml923LAy94mtlVq3nEsMbaQ5AYmzl0mRuNCSXT++AajLwH6UD27uxLJWlom/0=
X-Google-Smtp-Source: AGHT+IFzal4BanFxWXUcpFX6BWpXKFnT6pBc8hPzP2V5umFIVYINUJ2CxkxPLmE1Ql//9Nt8lf9wxg==
X-Received: by 2002:a05:6820:1805:b0:5eb:c72e:e29c with SMTP id
 006d021491bc7-5ee86a500a2mr6592399eaf.8.1731541855919; 
 Wed, 13 Nov 2024 15:50:55 -0800 (PST)
Received: from [127.0.1.1] ([145.14.135.248]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ee4950f85asm3361505eaf.11.2024.11.13.15.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 15:50:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Love Kumar <love.kumar@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20241112141326.643128-1-sjg@chromium.org>
References: <20241112141326.643128-1-sjg@chromium.org>
Subject: Re: [PATCH v9 00/12] labgrid: Provide an integration with Labgrid
Message-Id: <173154185387.2076886.4072928083228297159.b4-ty@konsulko.com>
Date: Wed, 13 Nov 2024 17:50:53 -0600
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

On Tue, 12 Nov 2024 07:13:14 -0700, Simon Glass wrote:

> Labgrid provides access to a hardware lab in an automated way. It is
> possible to boot U-Boot on boards in the lab without physically touching
> them. It relies on relays, USB UARTs and SD muxes, among other things.
> 
> By way of background, about 4 years ago I wrong a thing called Labman[1]
> which allowed my lab of about 30 devices to be operated remotely, using
> tbot for the console and build integration. While it worked OK and I
> used it for many bisects, I didn't take it any further.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


