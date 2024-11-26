Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023D7D3B7C1
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 09:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B31789963;
	Tue, 26 Nov 2024 10:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AhnBPjGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D89D989AF4; Tue, 26 Nov 2024 10:05:11 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A4E889963
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434a14d6bf4so13296405e9.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 01:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732611909; x=1733216709;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0Kof2OdP8EQmMuSOL3yEESmDs/DLwRTnx8pnZ4tiwc=;
 b=AhnBPjGupYRKuf+9Y+0HOLTk1gpsPD5qN+zSAt/xsWg6EdmrG0/qF8YH8jmdM5C07M
 F0udB3wJ4gaZ1Br2JUDPCotS0blIpVV41SLI6Sw0e7byMz4gHMLftJsgd49wYdz+M8c/
 Y4tR0KU9COm3i2Wu+zWD21wLBI97bqxgemo3yi94438h657rZkM8kpFb6qdwThgT3XzL
 ofYMByFaLTMFw1qnxJ9WWoIgZg+yU7TGWAW4v0oGGhCQFPGVnOuvg7RIiZ6QBFqxgIaj
 yigBQmj4lbIFO+GmrzjfgmKZEO8OlW/BNYQngIMM2fam4+RgKpCi8R1asnapcvCGc+13
 ag8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732611909; x=1733216709;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0Kof2OdP8EQmMuSOL3yEESmDs/DLwRTnx8pnZ4tiwc=;
 b=CM48PEbd76DF50WimScEijAZpByeEKBs1Fr68AgMX0JFrL6ro3HVQdQ4pV4HipZEoA
 JNlvwKvp5ccudLMUIKdhZvrpCJCV/CXZ/KCrXK7QKesFqQRspxwbA7ucojpkd+bJKNRz
 ogWcDf6Syy3fbDbNmYY/Yky49+U3D6w/ZpQZxo084GBwT9uaIt6tuA4Xq6XCY3tU3yFl
 FQVncTCnUxo6U//8pfIVuaYR7Zn9hnUUukmpi93x6VFmy2z1xdZ5UVblJcg0T8FpzmFM
 dY1xezEAsFYFmah04pDCqHlSeMhUGtUI/OKkQvnkU+AiP+FFXatc3pWWnufKypU1vpXp
 C9jg==
X-Gm-Message-State: AOJu0YxBIVbHNJRaBWzyou8eMS6nbp/pb7YNxheXgy3Q86q/uTfREEUF
 SCT/CFiUw6t+FUwr42sulpswCxbPrQaUxPc+161ngLYF9+KzCFJEfDw5dN8Dl8Kg8p4it1bScJz
 D
X-Gm-Gg: ASbGncvcTmZdWOYWrn/umOCjIWwcMyVMD/YTd19WGtaoy9pRQHcYVkoCZNp1IMTNDQ9
 uj52e2cAvKGF1V0DbJKucyHCe24dzqdJzXdmbHfGS+6m0+mI+mLpBFQlnE/fORFDxJF+NXjJod1
 +bkR+tJFuOYQUlrLcr4GNm2xJPHc5PppRwRsjHlRlLe93xSDO5gBhFR1CjR8oo6KJsN1U+wouCL
 5DTGiQJdBxx+Vbmnkf2zSmVHBhPfcnG9QsRd2vB5N5spyklnUU7qK3oFudPeA==
X-Google-Smtp-Source: AGHT+IFjdeSZm2nxIq1ejxUfOd3ZuiCtz7FcMh6mfwD1km2cSCvLtGG24z0Gg+lxS/odZ5u7hHdNWw==
X-Received: by 2002:a05:600c:5253:b0:434:a5bc:7103 with SMTP id
 5b1f17b1804b1-434a5bc732fmr16042705e9.19.1732611908889; 
 Tue, 26 Nov 2024 01:05:08 -0800 (PST)
Received: from [192.168.2.169] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4642b8dsm222437845e9.41.2024.11.26.01.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 01:05:08 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241121-bootmeth-android-part-sizes-v1-1-25760bbd0f08@baylibre.com>
References: <20241121-bootmeth-android-part-sizes-v1-1-25760bbd0f08@baylibre.com>
Subject: Re: [PATCH] bootstd: android: don't read whole partition sizes
Message-Id: <173261190796.12674.4301190075075008536.b4-ty@baylibre.com>
Date: Tue, 26 Nov 2024 10:05:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Thu, 21 Nov 2024 11:59:55 +0100, Julien Masson wrote:
> The current implementation is reading the whole partition for boot and
> vendor_boot image which can be long following the size of the
> partition or the time to read blocks (driver/SoC specific).
> 
> For example with mediatek mt8365 EVK board, we have a 64MiB boot
> partition and the boot image flashed in this partition is only 42MiB.
> It takes ~8-9 secs to read the boot partition.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] bootstd: android: don't read whole partition sizes
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/abadcda24b100b8eb0f138085cca6595518cec85

--
Mattijs
