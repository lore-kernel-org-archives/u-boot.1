Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9174F46C5A
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A0B83C2B;
	Mon,  6 Apr 2026 18:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HXCVqL8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF18883936; Mon,  6 Apr 2026 15:32:59 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B03F38341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 15:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8d424af6282so349592685a.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 06:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775482376; x=1776087176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJk66J5UifsW9SUR5kocbcAobYMgwb64UQx5wwzlf1g=;
 b=HXCVqL8AP/yNhHJKMxCn1lSTtTiO82UlPf9RpIHTuD5IYcPCg6l3OpYCZJCeL9EuxF
 HNKajWr9B0bhOTTXi+ceMYfdaCxsoGiwjDFuxLHUBRb7M5WO/6xTxr7PqvBOttyFIXac
 7HUUyGP5LkN1nkcUchiVSHQz/uhm5Oo2poCcMiP4biYu8IeRR8Iyk6/xZvVhuhybwSME
 vclBKdt/sgcsG3atvBtvI5zP4EiG3bSXDQLswEoh6AoN0qEdYGv7m9QYGU/uaTYR4JGA
 1s76SE90G9IjDHN97bb71L9pB424LzB96uQTFX5zcxGjvvlvowS96wLdhMJGux2aNwIn
 HJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775482376; x=1776087176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EJk66J5UifsW9SUR5kocbcAobYMgwb64UQx5wwzlf1g=;
 b=DkQVoGmjbHvVaEkKvTdrkZIN8M3kzdyri3SMr3NrqQf+D1ZX3NYSbeQP5S8455rEsB
 SfAUIyZxost2IDKioXefTIEV1AIbLy8oivCQ6lWh8LECRVuw3x4KwVqNzps37F9RHsfP
 wz2EDjQODE4R7o/y0Nr/cxYT+QZDa+obmUGfBViHbySj2F1D41DCJDXv8pk8Xt1XP9KU
 RiKG/V6FMfA89DU9GguuPxrH7xlRLzWM1+GAUqgmF5tk0F0Ei6/8Mwk6w4vFMPjACGgW
 PLpz2E3RqQ66LDWM8ITMPTMN/0c3ZW9U0o0HMLyEWIbOSo7DIb+PWvIHAo4B0LGipLBL
 COmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTetVWrYtNJHlJU8OTL8mgSZCkGmUT2h61t16riNhBmXj4HeE/vJ0HkKwCKGiz+ECHNGbQjYg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz20kjbj84yZ/KeOJ9fvUiK5L9HxMjnPX/2vHxf4bs5o3PLfmip
 3TN6n3P3jIea4ioFDkFI/d+ya9XLQcoiyj/xmN2mezH72cbtyDXz6Uf5
X-Gm-Gg: AeBDiesMgwZlxyNHhX73GS6dUmaQgxLUURkQQEUZGOfJopWkBVBKQ6c4eZjOsLUn3hN
 s6bjMRDJXrzOY3G7T7D4Yds4qRqkWtN040wyGLQWMPvm2bZZpYOZ1sftkpBljPWHdJhaV5qAvs3
 7qVnxrG/brHUxjotE7R49LsGYORYVf4Vo1hyC0a6XpAmbF9iuLY0s0YG5dJVNT+uR6Zhpivf5rz
 jEac7EU2pSj0/GqWwAtieQO3QOTO7l6Q3mUkNZDsb7rpT3aGg7Q/l5+FUffHorPLpssyP7f3sKz
 53kdaXbbcQDtNlsfiRa6x7oSMX+bQBfyVYxOfBP11igQTiienzGYoY7OI7saMUn6p9WRm/vI2dS
 UVe/LnfXDslX3PmfNXx0XkKTzPKuxq2XzYh6ghTGaWSYYUFj1MUpIOg0ks72zirue2rTP9C3psy
 sG++bedod//AxbbqeEeZWQJ2W8ROJ7JwpWJg==
X-Received: by 2002:a05:6214:29c5:b0:8a4:8b2c:428f with SMTP id
 6a1803df08f44-8a7020bd1e6mr221443936d6.2.1775482376447; 
 Mon, 06 Apr 2026 06:32:56 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596e03febsm147439646d6.38.2026.04.06.06.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 06:32:55 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: malysagreg@gmail.com
Cc: caleb.ethridge@analog.com, jcethrid@gmail.com, linux@analog.com,
 ozan.durgut@analog.com, philip@philipmolloy.com, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [RESEND v2 12/13] arm: sc5xx: remove LOADADDR and use
 kernel_addr_r
Date: Mon,  6 Apr 2026 09:32:52 -0400
Message-Id: <20260406133252.4709-1-jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABdDSeVpWbu+hadgWJVWaeU7=4xKuvpitbRU+ScP2Za=3dbP5A@mail.gmail.com>
References: <CABdDSeVpWbu+hadgWJVWaeU7=4xKuvpitbRU+ScP2Za=3dbP5A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 18:50:29 +0200
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

Hi Greg, 

> I agree with dropping SC5XX_LOADADDRR and replacing with
> CONFIG_SYS_LOAD_ADDR . But should we really replace ${loadaddr} with
> ${kernel_addr_r}? We're loading/booting a fit image not a raw kernel.
> bootm defaults to CONFIG_SYS_LOAD_ADDR which is exported as loadaddr
> in include/env_default.h.

We have recently opened up our support to include build systems which
produce a kernel image + dtb combo instead of the full fit image. It 
probably makes sense then to leave the kernel_addr_r define in for use
with booti if needed, but remove the kernel_addr_r from the bootm commands since
they are redundant.

I will let Ozan chime in as well, as this was originally his commit that
I attached to my original series.

Thanks,

Caleb
