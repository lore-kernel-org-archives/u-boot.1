Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C93C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 16:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640028804B;
	Tue,  5 Mar 2024 17:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q9VhwldF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F188804B; Tue,  5 Mar 2024 17:03:08 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC60487F63
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 17:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6904a5d71abso35519026d6.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 08:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709654580; x=1710259380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l9bJlA7nchV3j5IQjYUjLAF3AVMpB2VJZ3tawrN5ZSk=;
 b=q9VhwldFTfF24VAxfLW89+W3ZcobWCWGac/M8w1TBMY0kfFdFmEJr86wAPmlJD+SHe
 8QR8dbEoqWknmHCH12NN++pirp9p+M6PvYIVSRnZ5wqqyh7PimprVp16H8KOltmBJcTO
 ZzbN4AUTDXq6S+hhaw317JGnHLqtPQGSaFWME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709654580; x=1710259380;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l9bJlA7nchV3j5IQjYUjLAF3AVMpB2VJZ3tawrN5ZSk=;
 b=A+x5r3/2hpC/W9vpI/zVlgfCUwOgnrWdQUHgqnWuxIz5RdRRAzX6uTXx28IDfl7FIi
 qPvTRITJyFoCBTF1eUVWkoGAvXLLVDic7XXfcczKwYPnNVS2mgiIL5PGUrCzSBlG3/F4
 OdtRkvxq+nAmhdQBVIrOgo7/DIpJmUdeFWVu5DwxZ/cesekqcO6xlSWp5QXLNZv0oaIO
 MqkfoU1xVtOKeoa7GyeMsA+LUMt97/GYSbU2pdAWC/DgLWWNWPY+W/0jzqQWIHUE+fkq
 dJ2K14ZRWRF4N3ddYR8hKXV4c1dz9bYiyFBPe+LfWp6fnC49MWNNQb9CGrpA5JwFoq49
 DtmQ==
X-Gm-Message-State: AOJu0YxbDYF9YJmegbp8DYDhZGgEUH0QTskwM2B7HJ8T3oR6FOo6upcg
 4/gFlh3WIC9jNDoihxpajLsV4jGDxf5bhGK5c7oQaP4kBU/UprEfSnPjP/1Redw=
X-Google-Smtp-Source: AGHT+IHrolyxGsUAHUKSCytwBjrykhptZR97B0Hf6XvknHVd++nOOq8HXOro2mbt3mSUDAMN5vcdLQ==
X-Received: by 2002:ad4:444b:0:b0:690:479d:cf5d with SMTP id
 l11-20020ad4444b000000b00690479dcf5dmr2080373qvt.54.1709654580329; 
 Tue, 05 Mar 2024 08:03:00 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1000.res6.spectrum.com.
 [2603:6081:7b00:7f::1000]) by smtp.gmail.com with ESMTPSA id
 jh19-20020a0562141fd300b0068fef023e6esm6382512qvb.88.2024.03.05.08.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 08:03:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20240212073708.4161197-1-dmitry.baryshkov@linaro.org>
References: <20240212073708.4161197-1-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] virtio: fix get_config / set_config for legacy VirtIO
 targets
Message-Id: <170965457975.2808800.16278427368661683974.b4-ty@konsulko.com>
Date: Tue, 05 Mar 2024 11:02:59 -0500
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

On Mon, 12 Feb 2024 09:37:08 +0200, Dmitry Baryshkov wrote:

> The functions virtio_pci_get_config() and virtio_pci_set_config() don't
> take the offset into account when reading the config space. For example
> this manifests when U-Boot tries to read the MAC address of the VirtIO
> networking device. It reads 6 equa bytes instead of the proper addess.
> 
> Fix those functions by taking the offset in the config space into
> account.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


