Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00616E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AC9C8032B;
	Fri, 20 Dec 2024 05:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WTKmE/CT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EBAF80087; Fri, 20 Dec 2024 05:04:58 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 460618032B
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa6c0d1833eso308989966b.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667496; x=1735272296; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pOvzdD54MbqZpHu89LsTTFgG9Q476oOcHcWW5V35F3Y=;
 b=WTKmE/CT2wMxiG8l8OOp2LqM4cH0FLGSXeFHdOmzH3emdPQatt7Rn7X5KMoW3pkpot
 OADdCk1MS7gozQCHYB4kTMVHWvq3Td0+Y6xKy/8D6NEvjSNrJiSejIJlRuLQNnS+Ij91
 ALJiAHmI86zcIQi1LKHiFqO/f/DCgFNdFM3xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667496; x=1735272296;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pOvzdD54MbqZpHu89LsTTFgG9Q476oOcHcWW5V35F3Y=;
 b=lCpn3tlJWmED/iWa2XmYR2KF1Nn7RTwclYWg0acE0DOR1eSBb0ljyCdjT1BfcoN43i
 u3uNMODyO5VYdOkki2htHfVjDH4xIpNkGmIni7u49cak7XhiX8GzWU8aDIJpfBKbbVD7
 eHXaEntRC4XKDiyuqA5cYMcUA8RCc/FHx7ZCRNEF32qiozbcMxIz9FR7BBlJVbhibTKl
 gBAm6nDVcENfErbuCJcsvwy1w1Jws4ANg+NzP54Q/zehpyTbpf/qkEIaSGWsNASyqp3l
 G9JLV0lUZvN0RjosQ2vU7us76H8Tba172gAoONVGqfT8xNFBX/nU4uX1padUGpCzZGhl
 IMvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs1zN/50cMd8KJlM2ESGwYPTOObAZiocluW9wLGC8L7ERJ+C7mI/T7VVZ2fcfxJdO2Ti+sywE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8s5BvaewZhkuin2TPSSnLe5p+doUubV6erqUwO1z/EM+nyomf
 5W6ELaceqOPOLjKekaKiuxGZTjgMlcLA4hOe2wiQA+7+Rxg7SWjAophJsVhmYxeLByhMset29FE
 XxIvAf5BRlk15IVGVIWLq7esaWx1cHrQzCa53
X-Gm-Gg: ASbGncsmMYqOqyVfZM/sdOsrGKCK/ssJQFET6L+8J1zQk1cd4SmXTHN8kXE09QbYL01
 +ErX+yNtTpUweTNBoUkjBZQGxU9qQmNoDGkNCUlg=
X-Google-Smtp-Source: AGHT+IEgm3mR/5ZsXUjVtI1wt/YMpELqOho8U/TM9yFDk4LQmlDykSLNSpIqPprGI7w7/Mw+Pbc6D3aIkaZASSfAPVQ=
X-Received: by 2002:a17:907:80c:b0:aac:832:9bf7 with SMTP id
 a640c23a62f3a-aac2b84b7aamr82980166b.24.1734667495733; Thu, 19 Dec 2024
 20:04:55 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:04:54 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-46-sjg@chromium.org>
References: <20241206023626.2456858-46-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:04:54 -0600
X-Google-Sender-Auth: WlUdjL-6_LQXjbGz12QUqvIbpy0
Message-ID: <CAFLszTi4bDYwWb0Canr+-GA=Rja00hy8Wcjzs_PawY=OYr7b0g@mail.gmail.com>
Subject: Re: [PATCH v3 45/46] pxe_utils: Refactor to separate reading from
 booting
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

It is useful to be able to select a bootflow and read its images,
without actually doing the boot. This allows adjusting the bootargs, for
example.

Provide support for this in the pxe_utils module, by adding a 'probe'
method which selects a label and saves its settings, so it can be booted
later, if desired.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c    | 72 +++++++++++++++++++++++++++++++++++++++++----
 include/pxe_utils.h | 41 ++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 5 deletions(-)

Applied to sjg/master, thanks!
