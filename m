Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA154C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9769883DA;
	Tue, 18 Jun 2024 16:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QjNcHEce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 783DA88363; Tue, 18 Jun 2024 16:53:26 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B7F882D4
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-259884ef4ddso212621fac.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718722403; x=1719327203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUzqRLp3JeiBioyH9ep4b0QCKidwEpTusAQ10yuFU2U=;
 b=QjNcHEceN4dMmsWBXL9V/DZAvTp0KlQ9c1UiGlfWr/kIe9PkXJcIDaY0eCDfi9cwKC
 O9x/dDilvIFZQTarOwfkPQJBj0NGXJk5vXfy1mpgBBtkW0JlVZhwFXSoMEZPm8OTs9kU
 2pqwFUWJz25HLGZLTW7hiCpFUgkm/+JNWp0k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718722403; x=1719327203;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUzqRLp3JeiBioyH9ep4b0QCKidwEpTusAQ10yuFU2U=;
 b=uQtJNF/JQups2OUOLG95gTp6Wj/HWem0E5zP7M6L/BgPg407hoa8EppQY/bz2xduHp
 VuiDsWJ6i1yA53TWxdPCKN3GGt5QT5Vyua+8yJz1/SMia2C70oXFAgGDG9HreEuOvz4H
 5QkLb4xkBEiEP9lcB9BuHYH49ZxxxK9JYRX2YbbG+rZQdJHyEupsUw8FODJqD5DtcAeU
 gIDA2/vqHuKSBAQiXWSYxa2oGTox3b9WHHIimX+uXShdysQPeq61htRQCN9mb1X/zyRT
 dvaOXel0tuN+3r0YxFfzSBAhSfbM0dHaEbYIpnLCcb41cnOhfnnPR71uQwPeebi0BkUN
 YqYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRmrEJ1n1tijB0+qfdHkf3TfOiKf60AoWWcvbIjhHgsOoHJBd9BTODpjl8TnWAr2p0b6RashVStEQ9We3nGy+hk+8fHA==
X-Gm-Message-State: AOJu0YznZTfbe4DWCoCqieQ72rAkqQO/qi+Ah9as1PnwWo+11e+Ld3vi
 zJGyGBlVXYeBs1ZjiETHa69u2s1xmSwfwCe0ERXNbJuXLzCqty/wdiQQyGbgguYCV52HjyARZGm
 TO1OA5g==
X-Google-Smtp-Source: AGHT+IHbs7a9x2Y1zwqSxSple6reEl6ALzinRGeEluSdAd1YhB6us3O0nDBKCjXUfYr0q+WQ1r8OCw==
X-Received: by 2002:a05:6870:9706:b0:254:a624:3ada with SMTP id
 586e51a60fabf-25c94998041mr13544fac.15.1718722403134; 
 Tue, 18 Jun 2024 07:53:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94b7besm3202888fac.6.2024.06.18.07.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:53:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, u-boot@lists.denx.de, xypron.glpk@gmx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim.Moskalets@kaspersky.com
In-Reply-To: <20240605184334.13973-1-Maxim.Moskalets@kaspersky.com>
References: <20240605184334.13973-1-Maxim.Moskalets@kaspersky.com>
Subject: Re: [PATCH v5] cmd: move ELF load and boot to lib/elf.c
Message-Id: <171872240241.3307069.15041492101076975578.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 08:53:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 05 Jun 2024 21:43:34 +0300, Maxim Moskalets wrote:

> Loading and running the ELF image is the responsibility of the
> library and should not be associated with the command line interface.
> 
> It is also required to run ELF images from FIT with the bootm command
> so as not to depend on the command line interface.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


