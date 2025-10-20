Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F564CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 16:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9568334F;
	Mon, 20 Oct 2025 18:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k6nkIOf0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83A968334F; Mon, 20 Oct 2025 18:08:27 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 307AA82C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 18:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c2917b92bcso1579550a34.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760976504; x=1761581304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=io6UhXFX8FK1V5Dl2YTUPhzKvjT4EkY294ELvpSS3C0=;
 b=k6nkIOf0Ko/VQMRG1npT5cGHAb1MXyY+XbUfBfAph8W+u0Cwp2/sua6bjvy8D08dwc
 VS6pfEBSSfT18IsP3GtzPcDCqfY7z9uG1eqJuXnz+VfjBt4tJ4bk6Z8ltIqls0xS5d6l
 nKAPvjBi4Pj9tDtLI4uVYvCbQf9gwx2BLtep0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760976504; x=1761581304;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=io6UhXFX8FK1V5Dl2YTUPhzKvjT4EkY294ELvpSS3C0=;
 b=ihEE/YM9J/heC7Vi4W1WXZwD774NUwiXswOdIyPkut73hQ782lDj76ok3XKVmSqtQp
 USF6+MSFD2i603NabHW9CHleoYHH/Tn9mwrPnrYQjmDt3GiHZwfo0BWJyGvbwN4MY0R1
 ORegxZ90IzLTSDd56a/3g0EpYX1ThNE9AUPTugSOfT+vsZAHLYQt5+jz7MvZBYjXmLka
 nehnhg1oRiiFj5SnLgNupsdMm3WwKSv+ox1Kvs2zqvr1AMa70sA3wBshxVJ0LilS7aTO
 6KCI3EbqkzhX4zJsok8lAVihI09/MA62uykllNMLp47DNi+Tnpt5dJzw63AZyrU07/zV
 CTUA==
X-Gm-Message-State: AOJu0YyyLKnSSlE1HQ/U4aPBWPQD6tegPe8t4eC5hGUKO6pZXVdqOSbA
 rbQ4/4YeImNWB1GEuS8Bg5N7IJiai4F/VvoThnvN4L40gU3N1tZ8gV4wqMhzHILGK8U=
X-Gm-Gg: ASbGncszOnNVvsAcf9wDWLE6k9dzbIyyJV/eOaINefjgPMuNsRh+75K4/rHY2M+xQ8V
 FGhHBooSV4C2a8ZjzdzeNOFk22Z164RAOgMBjfKKr5jWU/yoTwx74mAOhcox1k+lDqv7/oBja+p
 /2wrUca7AujpESNalddK7SlwlPMf9C2CN2TaemSOJeg17s6UYVn5UTVBCkMPJEvfePPgliq9u2O
 kT/QtJWjJhbtJaqSdNCtU2y7E/HepIEGhSBHxmDs3vyn8t2nSXMZttCTwAdPDg8jJsMwGoKVuaR
 atN78KE5i9OzGe0uk4UlOR2SEP6ou1Wx2Bwh7k5F6FH8G11hO6dkvjdj5xdgHEkBVnLdmaHFskd
 BwvH3ME22cZX+hARj/i1bAX+BarW7Y/pZW5C7+UwXOlrwXqcWrfNS0UjsItoFPh8gPmkqnsj2PS
 vAvWyhwB812reYYMP+m+namseA9Ak0N5/BXOivBYyvmeIxRAqC
X-Google-Smtp-Source: AGHT+IErpL6sICSz3WJNqfrwKvD21Qz4+1vIYKM2OlOcs1IaObJiMMfIMjPm4nwOMGfwotvzv+iyWA==
X-Received: by 2002:a05:6830:6616:b0:799:9d76:3e91 with SMTP id
 46e09a7af769-7c13d589e80mr9421888a34.4.1760976503879; 
 Mon, 20 Oct 2025 09:08:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2888ee009sm2752470a34.19.2025.10.20.09.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 09:08:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Mattia Narducci <mattianarducci1@gmail.com>, Lukas Zirpel <lukas@zirpel.de>, 
 Brian Sune <briansune@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>
In-Reply-To: <9b25f391-944c-4ca0-b990-ed5caf0a3e8d@gmx.de>
References: <9b25f391-944c-4ca0-b990-ed5caf0a3e8d@gmx.de>
Subject: Re: Pull request efi-2026-01-rc1
Message-Id: <176097650244.2620434.17798848445600359993.b4-ty@konsulko.com>
Date: Mon, 20 Oct 2025 10:08:22 -0600
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

On Mon, 20 Oct 2025 11:13:09 +0200, Heinrich Schuchardt wrote:

> The following changes since commit bf1d8c1fec863b7da2f0d1ed4bd5526275d70dc2:
> 
>    test/py: Update to a newer pytest release (2025-10-16 18:03:27 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-01-rc1
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


