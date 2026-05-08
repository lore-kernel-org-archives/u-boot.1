Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA94CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7975C84CE5;
	Fri,  8 May 2026 19:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="da9DIvT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D8B784D5B; Fri,  8 May 2026 19:41:05 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F28884CDB
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-67bb5ad91bfso3990053a12.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 10:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778262063; cv=none;
 d=google.com; s=arc-20240605;
 b=U4sC7R9XNJZT5Ts3KYm005GzeJrzNHNy3LQdKi2Ck49zze448keht1y2vVzIMx/mUN
 Vkh8pEKtG2QYLtDn348WE+Go3cquc6cymzcBsYaGp/3LMidjB9fPpWrcXGCSdF+GantC
 KiEW5aNHMfi8Rt6efOE2Ce9rPQ/bcghxxqa4pmhPIO13oNxPiN4onqQF2RBMmTG+m6p3
 mdbyUTBvfXotYCf2rWX0+K9XrIrFYyUGrF0nvbg5ilEeBMlq8naR9cVzdrmaIbSQG7Nm
 itZOXWX1CkUWFzFbViI6JAXEPvBHoU0Tin5laO6J1cNVPV6rpbSZ5eaAAadkTLFWZbVm
 gvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bfHrQAxHg1RRgySvfPJUw1SIiA7xb59W59+XcuJZnN0=;
 fh=h9G8CZ8WO1HA7LkxfyQ1TwVvL33tjAPZ2X0vhXQ3AVI=;
 b=lcBhLbgs2lt/lBehpDHCnKF7W0ZMWYck2rqohaz0ZVyQPcA+7vC3VCCNv+1NWu8cPG
 vhLReWvwhU513xqxRDnDXUFgdf1e1IHYevb/M6zVhrLzxKMTiJmC+TaWChAnTttOrviL
 nekn+F1bJ7GsgsfXOiAA5kLWNQZO6yA6n+lSGRMAcimmRl256o+g9oMc92ScxNuf2q9f
 3iJqXa47o7IsNgvZqxqdh6BWneaboleRzOMjldRH3M5Jy4AQV1EzKfqUKovrF5dBNHH+
 jRG1SUEsv80K0bMpukES0v73EYvr8YRihpTemou3keEF5n00gHcdR9QM6trvtZBkRINP
 MEmA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778262063; x=1778866863; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bfHrQAxHg1RRgySvfPJUw1SIiA7xb59W59+XcuJZnN0=;
 b=da9DIvT3lwJC0drBOpop4qf9tY9Opbo4VoGQ5WCqdEzxxAUJdKJR9DYCu04DKGRqHA
 BIdHoMeD1maq/QhH/ERMhSmFsMV7nQNxRMOMxncFQkU7ABVk61bVS+ZohEd4fxIW+bGg
 9J/ADcpGa6HPej6BT9o9YajPiZqnBGBcH4VWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778262063; x=1778866863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfHrQAxHg1RRgySvfPJUw1SIiA7xb59W59+XcuJZnN0=;
 b=EpeH8eu9NOwXh7IfYy9y/0Z0DXxjG4XBuOgW78c5oDpjnspwOM7NG29LfXWkym8y/l
 15+ERSbWWgTZz4xCEFAXc0zHo4V0c56qLryfuPP0kSgayqhPtJvUHNh/JlEgItktYISI
 5DaYdKYf0AQQp0rUSZUM6zjuylKws6p4FPuGpzYxVqOUlavfxzYKyiXEUV6UnjmgVvjZ
 qaNZJly8B2qqqNEuhPIe2+JKC2pd3nWyyAKzrCB2nLr7LYAm23DH3kOtBoNIpVbSBH2/
 dmM9KVGSOojbGIgdWF4Kkf7RZC+wLaxO8iCjmPB5POysVH5gyGftuUep/UgQREgChNCO
 eEbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dxQuvZ5C6bfQinBMMnpTSO3Y7KAOtBIXlUyp18XEI26RJAEccdyajMjaRdH0F15ZKzYAghew=@lists.denx.de
X-Gm-Message-State: AOJu0Ywtw8vVUnm7qv62nMqSJ4SHtqZu+7FC0LizzeuNkiwQq4Tv7qgu
 us56B70kAoE6VTPThbFAyfJzcR5cOd0Gf4CKTAzpTWTI1KASv9j9QdISxiL2tjXUhynIvWjqNZF
 atPwBhJ8bj4KP8QkdlhA7wfHoZ3I9v/W0qK6tL9wx
X-Gm-Gg: AeBDiesef+ysM1Amrs7AU4vqQweSgzmglhz3c+8QqY2tYyYBYHuIsAbmRCJpr26AVaH
 omwPun8uk5QoGVRJK0q+NWOGgHh2BXkt/hX28KK7JKNjjA8SLm1yw+zusim97DpZbNY9B/fi6uE
 ADPRjweM/4Stzo27I6TLVlbbD3AGTLah3waTCTXdsDi5Nb0SNZws273N/OJn8HK7wmb3LFabmSY
 uyt3VL3PGpn7Lf06mrP2TKHGOS2/6AwvCL66e/+IqoAAIHuvxi7iKgCheKUHDFBnIfpW4PJ7R3r
 0dpXtw==
X-Received: by 2002:a17:907:3e84:b0:bc3:989f:5179 with SMTP id
 a640c23a62f3a-bc56d135290mr899802466b.22.1778262062830; Fri, 08 May 2026
 10:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778171184.git.daniel@makrotopia.org>
 <253645cd785862724bbfec7ddb906cdb09f54073.1778171184.git.daniel@makrotopia.org>
In-Reply-To: <253645cd785862724bbfec7ddb906cdb09f54073.1778171184.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 11:40:49 -0600
X-Gm-Features: AVHnY4JGdKypHwhGGvvJAXwcqPnOF6kuhfPQtzfGJfycHnKuHPXm5kvxB48C9QQ
Message-ID: <CAFLszTg4BKKV_rEDzR-XBPwHx+EeK57ZPjO741Dvw0hcAjBSKA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] test: boot: add runtime unit test for
 fit_verity_build_cmdline()
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Martin Schwan <m.schwan@phytec.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Benjamin ROBIN <dev@benjarobin.fr>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-07T16:40:15, Daniel Golle <daniel@makrotopia.org> wrote:
> test: boot: add runtime unit test for fit_verity_build_cmdline()
>
> Add test/boot/fit_verity.c with four tests that construct FIT blobs
> in memory and exercise fit_verity_build_cmdline().
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> test/boot/Makefile     |   1 +
>  test/boot/fit_verity.c | 306 +++++++++++++++++++++++++++++++++++++++++++++++++
>  test/cmd_ut.c          |   2 +
>  3 files changed, 309 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
