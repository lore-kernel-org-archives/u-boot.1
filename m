Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B22C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 19:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8747088528;
	Thu, 27 Jun 2024 21:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wcy1r+s2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C3A88585; Thu, 27 Jun 2024 21:06:03 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4EF488569
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 21:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-713fa1aea36so4194070a12.1
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719515159; x=1720119959; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9APcEmz2wa5c0RKvuHEdI9ra+tXbd+EK2AyJgbTFAeU=;
 b=Wcy1r+s2/6+isYri5rPZSZnz82kVFq8dMjuD18ZHCHn6mKS/CAEMxS2n7DkXu8lko3
 /OEMB1quAtcV91Y37ksWISw74iQ1+BMHhaLqkORPujLqrtu5vu0Q/iqJ6ltXAolioGER
 dQ7ULhri9TtDziHrkOzpq/OXZ1NNcFN+Yh2OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719515159; x=1720119959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9APcEmz2wa5c0RKvuHEdI9ra+tXbd+EK2AyJgbTFAeU=;
 b=AouLU4ad3bXu5o71gq0A04rUypuepJFMO8aZoTL0a/nWTW/PoDSNIr+t86XYZMt+KI
 HMUSMg7iaZsKsm/2jkJsgLF4pzt/9C8QOVkkLoaKM5pQaFWfSKCZ4EOyahqnjrnedC4V
 BU7dHO9BB0qIy6IyLo9aacJ7qptzhIRD+GFYgBLsNnXfA1NIRPmubN2c5/bYtPAVkGMs
 os/rOlCdWsfC6nNJ5PdJ45QtUx/lGxsC7LBG9EwInm647lv6cSFxKSSPrGdFt/wM6BIM
 +RYpqcuO+agCMFGQmwXad2OElfYCDAKawGcZOFu6r8kmnA4FTC4aaCyXi8wlSnUs/vOt
 p9PA==
X-Gm-Message-State: AOJu0YzEcBVW5ie0HZTP+B8QTMXE3u+CKR0SfgK2+sPnf14xKy/+6+84
 a/nGOxgzDd4iZYOdhfEr6WnI3Db5IRG3RX6bmUwcRVptYCdV+bj0OZq1j/hglVNLBlSr0ZvdB7g
 g1O6WxleEuspIREv/4Y9zCHGe13hzTOsoDw4C
X-Google-Smtp-Source: AGHT+IE+YxGmFlyl2017xt9LIJTN6mz+55BqEmOSWe7aELLOKddHvzhXgZ1BpK80UgLerHk+EaIU3pJqNbnJDmS2G08=
X-Received: by 2002:a17:90a:398f:b0:2c4:ee14:94a2 with SMTP id
 98e67ed59e1d1-2c85051a27fmr11307625a91.27.1719515159480; Thu, 27 Jun 2024
 12:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240627170629.2696427-1-vincent.stehle@arm.com>
In-Reply-To: <20240627170629.2696427-1-vincent.stehle@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 20:05:45 +0100
Message-ID: <CAFLszTimAGDDsroATUrrYvtHFxiw8Hin9hT9pG=KofDqBNAJ3g@mail.gmail.com>
Subject: Re: [PATCH] bootstd: cros: store partition type in an efi_guid_t
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 27 Jun 2024 at 18:06, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> The scan_part() function uses a struct uuid to store the little-endian
> partition type GUID, but this structure should be used only to contain a
> big-endian UUID. Use an efi_guid_t instead.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  boot/bootmeth_cros.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
