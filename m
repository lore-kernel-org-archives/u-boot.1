Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0B1D7360D
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 20:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B692689876;
	Sat, 30 Nov 2024 21:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vv6bMqQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E6C8893E5; Sat, 30 Nov 2024 21:25:13 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 779F288A9D
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 21:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa549f2fa32so444169966b.0
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 12:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732998310; x=1733603110; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8f/1f8bAX11ztnpGUqFpbaCrDP6jl3JAPHULnbKJbiU=;
 b=Vv6bMqQnZHpQeuDdB03sdJ6fEzKzVnH8+8aQbI30JJlfjznlY1OEsgdaVppHu9gHCQ
 1JgVN2f+pImZo7FobLPzMEKaD7lddZAWEFt1pL64EMW00d0MKrd7mlVy4PxzHPPJhVrx
 fMV4AFIrJszCf6bUUHk60hsDp5mwJJszK/Qdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732998310; x=1733603110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8f/1f8bAX11ztnpGUqFpbaCrDP6jl3JAPHULnbKJbiU=;
 b=pdHHeS1dFfUWk51B7chbzQCCOOOVHotS5Xw2echzfC9ERzR+nb60Qwc6/tSiGGmdd5
 Nzdu+mQ5RUcv7M3EHakxjFpqvaS4yF1Tacj0GbojFKFc6IJpRndxAMHvZ1Xro8UNOJYx
 ol8fgfIpnWJJYHzgz3vDBri0iZr7v9Gq11Py0PNvrYSYhg1QRSsk9VHDFArASHCqbiWw
 Z1FA9ljk2lTjxc7VEnWVVYurOR7CUtkDD+qt5TrwfyaEs9X26tb+xq/XHIpRQ+Dg62FC
 1s3mL6z6ubZ6pwGDY2tHh17PFXSHnwZwPjHS4rOn5gk4Ij7+oIVtH7ACuJ+2iOm4vbvv
 tDKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVimnlh3WyKwguxMr5paoGUnapKtZqHl44S3gjlUvHq4fVqEqykBSZn/UdWXQZVbjwmEbwR0vI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxco+e1BsxNiCvApvE1yFMVbyhrE5RMLa9uoWND1fC6JHda+Hp1
 n+81le9fil+VNxw2PascK7iRou/vfZg2IeT5Owhvp0uAx32ySeQAm4igHbcSLZ226IFiMeMDcOJ
 xjzV43q4pyJV9Z3fnif05kMvQARN+U98GY2ch
X-Gm-Gg: ASbGncvTVWzmvRDDSWMm9ezxL7KkqJFrbezj3XYJlIt0zoUP9+NT7dHk89JsVnwx5PC
 fzQWN87iO99uwsyZSrnF7dpn+jjhswBE=
X-Google-Smtp-Source: AGHT+IFdpLbpgKyi0fd2nzUtjWpu7GHrBL3d0rw5rgO5M7SqiqOKwXCbwxrScr/Dg+I36LNyRlhyPjgDduxikl5wWf4=
X-Received: by 2002:a17:906:4590:b0:a99:4136:5b07 with SMTP id
 a640c23a62f3a-aa581093831mr1220113966b.60.1732998309961; Sat, 30 Nov 2024
 12:25:09 -0800 (PST)
MIME-Version: 1.0
References: <20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com>
 <20241128-bootconfig-v1-2-0e63a5dae82c@baylibre.com>
In-Reply-To: <20241128-bootconfig-v1-2-0e63a5dae82c@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 30 Nov 2024 13:24:57 -0700
Message-ID: <CAFLszTgFBtQBiC_Hd9gjUJa26aFFXLGuuvJ5gVDLEaKH-SV-dg@mail.gmail.com>
Subject: Re: [PATCH 2/2] boot: android: Add bootconfig support
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
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

Hi Guillaume,

On Thu, 28 Nov 2024 at 03:15, Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> For android vendor boot image version 4 bootconfig is mandatory.[1]
>
> In the android_image_get_ramdisk function, after copying both vendor and
> boot ramdisks, we extract all androidboot.* entries from the kernel
> command line. These entries are added to the bootconfig section.
> We then update the sizes of the ramdisk and bootconfig.
> Finally, all androidboot.* entries are removed from the kernel command
> line.
>
> [1] https://source.android.com/docs/core/architecture/partitions/vendor-boot-partitions#vendor-boot-partition-v4
> Co-developed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  boot/image-android.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>

I am not seeing any tests for this code. Can you please update the
test to cover this?

Regards,
Simon
