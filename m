Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C597DC52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F0F88B3A;
	Tue,  6 Aug 2024 23:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kwvp7yb+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F80388B40; Tue,  6 Aug 2024 23:51:29 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD6C88AE3
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7a0b2924e52so677394a12.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981081; x=1723585881; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tvd7uyQrtCE/yY1DKLcpHrv6Cp0UVp1YnWBYaktUqD8=;
 b=kwvp7yb+AQXhTlxMetmk7j/km8obzZJkbKiW8J5HFurvGPgDUm36A4B9Cp2PsVVqCA
 aMzeEFIP1moAXP/Yxj9X3XSQPiAPyjzNlHWWWqBKvYaclN4QRMyjsbRWKaSSzDjtd6A2
 CS/bUG6r2k4kJMBT1vsmTlJDlyD9qjO0uaGwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981081; x=1723585881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tvd7uyQrtCE/yY1DKLcpHrv6Cp0UVp1YnWBYaktUqD8=;
 b=PuQL4WlNOUtwjDdJaPLMfmRK/W/vyok5Af1u7Oh68icPIu8Uj65QlM2VtJ4I2BHaLn
 99qNDAQglQv2eDv5PBlqeH95l8foaZ0m2Jx/L5IV0o+zRgLErOaNFaUMAaaQb5b/v1ku
 nQt4uqENusZX3ECRpLJ25T7/+9/hnbqaX+rpDARzz3O6O0TLe9NgW/xa+MfCm5tqGvax
 Pf/IClzD4TNHyWZKSDi2iKYT/9wiwxBj5qJrmQFDGhf5EZkNrV4gOvqHx8CmUcnZVWmo
 WfwWRk8DGhVYeZSjQ64slLDRd7dSdL0sgpfB5GdBeNTi8CZ+lumXHAvY1Nl0iSy2BSas
 ACew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUKr/+p545Z4xh/AzIbLqh0HhTpEGnhZrsDSL37aq//y+uEHPnZqMOFuXHhEVxewu0/85qH4ie3wHstYx90l3UPtLBwQ==
X-Gm-Message-State: AOJu0Yzg8HSGP8bfB6QyQFElECoBY53Wx5ahrgh5vw2Rp5g5Q2ofUL9C
 hiC61KnsHvdJ8WvwZwBuhwGAog6QVMTa0/3uxcl0ti6D6w3kWWtd0Hpu89N7ExbIiiH/5cW/pAY
 jdt16y0zTj+l62uaDb3G5+MPqHDydJQEVvNB+SvtGSKpQsVw=
X-Google-Smtp-Source: AGHT+IE+hkAbt2XMyiy9ds/SG6AgXiHqo2StVF8130l37ghnUieNHcsSUOJMfTKyiitNLvPepOb3FgwNRhvwSaxegYY=
X-Received: by 2002:a17:90b:f85:b0:2c8:da73:af82 with SMTP id
 98e67ed59e1d1-2cff943c31bmr17351566a91.10.1722981080683; Tue, 06 Aug 2024
 14:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240802092820.917450-1-admin@hifiphile.com>
 <20240802092820.917450-3-admin@hifiphile.com>
In-Reply-To: <20240802092820.917450-3-admin@hifiphile.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:43 -0600
Message-ID: <CAFLszTim4=Zq+ANZX0o=L+2x2HKowXeBTEsc0b989gx+VVHSGw@mail.gmail.com>
Subject: Re: [PATCH] cmd: bind: Use device sequence instead for driver
 bind/unbind
To: Zixun LI <admin@hifiphile.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Fri, 2 Aug 2024 at 03:31, Zixun LI <admin@hifiphile.com> wrote:
>
> Currently uclass index is used for bind/unbind which ignores alias
> sequence numbering. Use device sequence number instead as it's
> the number explicitly set in the DT.
>
> Also update documentation to use sequence number.
>
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  cmd/bind.c               | 46 ++++++++++++++++++++--------------------
>  doc/usage/cmd/bind.rst   | 12 +++++------
>  doc/usage/cmd/unbind.rst | 14 ++++++------
>  3 files changed, 36 insertions(+), 36 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
