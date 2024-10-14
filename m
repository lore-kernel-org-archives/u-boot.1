Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D690D1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D482D891F5;
	Mon, 14 Oct 2024 17:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R9kTaMlk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C391891B2; Mon, 14 Oct 2024 17:51:19 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3B389207
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-45f05a65398so35499551cf.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921075; x=1729525875; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j/jF5sQfAI49iBNSEvgavdab6ZqB/X8+e6/+ZCsCcQs=;
 b=R9kTaMlkxb/VEzMa0xiuEOdL0nkqxf97TGFjMAcfTi9AosB4lY1o4hoVQAiNkqVxA1
 wTXx3HVbUyY9DhAMlS8TeRpvIqF/ZNjZB7SgNzjyn0fCmuonSTrzPJH9K/hgB7Rz+Db1
 lBfO8gkP27lqz9vPdg1UJ8ZcGxeco6Bs9A+To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921075; x=1729525875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j/jF5sQfAI49iBNSEvgavdab6ZqB/X8+e6/+ZCsCcQs=;
 b=vAxI67qClpY5H1Ws5joKXpzWY5uHjF4Rr4mLnGjZdHiBXo1Dd3IxYn0WTTgsxRl/sd
 rWc+Qi7vUp7zlwPFkzN4zKhneR9RsEXjLLyoCN1qEde/7ExU9hWjHvHh7nRdL30o6MIw
 lhW/JT+zR0Uu5Jw48SAG6VBo0pz8SRCml6oYJC+BdFhYHYD8M/i94St8n80cWwtlcKit
 ONh316auVQJ9khpV4HuIgS2jTKTl6LV+4Cadyy4rE6LqDIggmN8maFEY9z01ihZs9gaV
 7BuRqYBASq5zXDWb/r5d0OTCkdYbG3+nGX2LeQ0vuSKK/uqwLTJlP6+VJF/8ciAWoQKu
 +sHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyvMPYycZcsOulJpSgsFDjNwSxYHuKYvO1hpTKgkJKaR7mTV2orXmrRXZF8HDlT6vSutFQxS4=@lists.denx.de
X-Gm-Message-State: AOJu0YwiduDt17FmuTe86F6/zuIBB+Y40ApHZ9IQuEXF7Tty/BCymSx3
 HVuOohlGla9PRRJsz2zojBQS3Fu+bTsuwZaw/tv50xlshdif/wNRWhl3PBjB6n5Mc8XNqtKumXi
 5jTXDbR/iYoq0n4MuiINdmAMxE6y7sA122Xtz
X-Google-Smtp-Source: AGHT+IHDymD0xofP8BCKyUPJGR/EUoUlF7KYushYu/ZZddtzDHtC2StUXKoYi7XoO+s9y8NZTJgqKP5XAZ5s1r5HQFI=
X-Received: by 2002:a05:6214:451e:b0:6cb:ee7b:7abd with SMTP id
 6a1803df08f44-6cbf0099ad0mr179452506d6.27.1728921075563; Mon, 14 Oct 2024
 08:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241008204614.56215-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241008204614.56215-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:51:05 -0600
Message-ID: <CAFLszTjo=rgvRketvyEHKw9ARZk3kA83HRwXgUQNLKpdvww=Eg@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: type boormethod
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Tue, 8 Oct 2024 at 14:46, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/boormethod/bootmethod/

Actually is should be bootmeth now. I am trying to use that consistently.

>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/bootstd-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Regards,
Simon
