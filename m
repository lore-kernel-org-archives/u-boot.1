Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C7AE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 499EF803F5;
	Fri, 20 Dec 2024 05:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h+MvCGXp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A670E8037B; Fri, 20 Dec 2024 05:05:14 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8F9C80087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa670ffe302so284275266b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667512; x=1735272312; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ElJ3FESvpr/UrDjUlwUg+tkWwn7B4UAXJwBno3yIqIs=;
 b=h+MvCGXpGMZdk4EWwuuntkuBCPmcplSXJfmUDtDNc+nsLgiH89wGp4H3clmpDI8v3J
 lTlXHLRVHhXxA6SoPgCixNXm2eoR1fC8DVwQ6+RkMLrguCexwKrc0bhc7NWxzulf0F7t
 WT7VQvZJaRHMU5qHh6f01HA9z51DbcnVDEpqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667512; x=1735272312;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ElJ3FESvpr/UrDjUlwUg+tkWwn7B4UAXJwBno3yIqIs=;
 b=c8zNtdOX46ftIZFJFYPbbGt3cDHIdONT/pKmf1kHsIcpBc8YgslQAlsTvU8k9myLAU
 1XJXD6MmXanqCJdXP2uyApHnhJmt8C5k+K8ROdLj4rVGIuCiO29GpNKLurgyC8AMIy6n
 LKHQ71NcZIWCRVvDZ8/un+YuiJ9t+Zhn9M0dPhTg4SgmLKcl8QbIr9XT5fgbfl//8+ZX
 Q7iwOLPjtCK/QAlp4hGuGy6eAmFTmUvRNpVTBatPVKclL7Jz6yf6QCuHbcS5DoVRxaai
 z+9gcVkMuD534RpuTNjjk4ljtRm3f2CPHT4FzkABJvV75ywvqFBl252MyzEL2HD+VmJP
 MbyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjG29fusT9RtlJDWTIGDglZuZtO6mwy9FzHsHAms5aOgJ0DB3KVportaTuSauc6WAcoEvDUhA=@lists.denx.de
X-Gm-Message-State: AOJu0YwfAHoqZ3MzyT9REhokshvHXdsEaADt32ppAXy1HxrqS9WgjaTr
 3sr+GXdyCC1n73GKHQT0uLGCPFXLBAtgaRoxlY0VD5QUOWJBxD1CPSPAN0WzgiR1+mTgsKRp0uX
 sWWLOVvXA336cV+RxV6BpHhNL433mrvQnMGz2
X-Gm-Gg: ASbGncv8+o6vuggNXCQGvkj6TKuqc4CmNIrW0fyYgw1Ynym60PPCTms9ev6pbPa/lPA
 prO8Q/AHAbzik2m4oLIPj3lyXgheKPQjeUlFIJoU=
X-Google-Smtp-Source: AGHT+IEaJvPo5Bp+MDuFUoOkznatFygwnPlxp0GzNiu4H5GiHFMQfauxVQ06cW1oWOn+X/z2CjlGxllfCxmjLyE09Is=
X-Received: by 2002:a17:907:944c:b0:aac:61b:580a with SMTP id
 a640c23a62f3a-aac3443bfd6mr95969166b.61.1734667512231; Thu, 19 Dec 2024
 20:05:12 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:05:11 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-40-sjg@chromium.org>
References: <20241206023626.2456858-40-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:05:11 -0800
X-Google-Sender-Auth: wHVAVIYc2HqLzZwmOCDtDJLug9U
Message-ID: <CAFLszTj-CVkkT5ZtHMQVn=w-nLdoASO5+3xneQHwmo8K0a9jtw@mail.gmail.com>
Subject: Re: [PATCH v3 39/46] bootmeth_pxe: Drop the driver-private data
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
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

Since this driver's plat-data already contains a PXE context, use that.
Drop the priv-data. Use the extlinux_info which is in there, as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_pxe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Applied to sjg/master, thanks!
