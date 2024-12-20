Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FABE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A90D803EE;
	Fri, 20 Dec 2024 05:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J/RFhx+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B9DD8044A; Fri, 20 Dec 2024 05:05:27 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90D7C8043C
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so440601966b.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667524; x=1735272324; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cEwm1J+Tpunl4WEVaNIIh0zI+kMuxXmod7iOHArDyQk=;
 b=J/RFhx+Kaq9ifBXtuGYyGy7mSmgSqkDqIhPvWvA4ZyZBxmu235GPclc5Pc4/2PzNkl
 jeaVC1af/8Ke7aZ0rVn8cBmmPvJ5rOUc1idk6LO/E6do3f/6NNpgh89RMm/MgiidnQW7
 lEbjH1uhwiN9hA11Y29u1zZMyh7S851wLl2PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667524; x=1735272324;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cEwm1J+Tpunl4WEVaNIIh0zI+kMuxXmod7iOHArDyQk=;
 b=TplzHXxUIUQ1iudKRshOrL2EOaGAqceFDHUi3ktFSG56Kv0fw0Y24WZrqmxKlhyeKQ
 BCo5VQq4hOOx3iXDBLwZLhX0lNYF7cEHeUnMeodlgnMVMXNTbCr3yaDy+7XhaEgJQcgt
 7GUoPHZPS51rFKsj+iQYxnZwwu2FjuAmFZUlXPBZC4+0ziRd9d9h1WI85ur3RGI0mcLb
 KKWVLPfTHgfArZceCSkoEcBPIXyZIHLaXXYJO4rqOw0Im3m4g5QOmZ+XlyDdq2klFy8k
 3bcW6WqNi9E33AGj5WAppDC82atZl4spRxvAyWR1peECdaQxS88US10SjvE5czqVw+GM
 Hprw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlPvLqHSa37o4lBfhaS6pogd/mY7dIumi+Luv6jRA5waDSZbcM0g5DHhIpLNuVWsMaKLMW7cU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxz3rHnVLLwJqsH2vahlxFXcLW9zvEkaby20bhSkVB3VEXi7ReL
 vpLAzQjR8cS1JDBg9LtPUgCG5F3d+KHlriwTpREVECeRM7fV91xVbUMHXekVyjx2Ji6aFxzCNr8
 LStkhsO6ItYRNLbwpm6/+WvRYj2TmkcPTZ1mO
X-Gm-Gg: ASbGncsZSZOx+pLjjZiPdB4JuA3x5Mkc9zqG2GCxPbLrvNi3ou2REiMY6HlARyphNl5
 2FAfq82kl+2uYnrE/pS8nlAanjhkKYj1Oj7CFjL8=
X-Google-Smtp-Source: AGHT+IEhZJfUgk8ZLvecSuXZg2zM9Szo9nr/hDwDX2VYsXwRwPmHEJ9w1g3+9Tak5HeKlPWbqjYaF3JSw9P6d6CKegw=
X-Received: by 2002:a17:907:7207:b0:aa6:112f:50ba with SMTP id
 a640c23a62f3a-aac0815366cmr498132166b.13.1734667524026; Thu, 19 Dec 2024
 20:05:24 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:05:22 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-36-sjg@chromium.org>
References: <20241206023626.2456858-36-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:05:22 -0600
X-Google-Sender-Auth: lJ6E35G_KTsAwLX4eWYMNb0FQsg
Message-ID: <CAFLszTj9Ca0mHmQm7goDrw2b3Jw-R96HXgMQtg00+Mj1Fh-Lyw@mail.gmail.com>
Subject: Re: [PATCH v3 35/46] bootmeth_extlinux: Move extlinux_info into plat
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ion Agorria <ion@agorria.com>, Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Move this struct into the plat data so that we can use it multiple times
during the boot process.

This struct is missing a comment, so add one.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_extlinux.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

Applied to sjg/master, thanks!
