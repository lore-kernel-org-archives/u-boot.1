Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5031D44161
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 14:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 548D3895AA;
	Tue, 19 Nov 2024 15:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LC/r9TCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F6F3895B1; Tue, 19 Nov 2024 15:11:40 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD9D0895A4
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 15:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso28430105e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 06:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732025497; x=1732630297;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkYeS0Df1U+5f0qnqgqXbmsyeezQhL5VTQ3Rr7FznhY=;
 b=LC/r9TCLGwTdZ+nORLni40Wt0JLpiB/sbr8v9ksVPkgwIJWgLrCqUApRgJL/rbrh5q
 Bo8RIL2Z4RL59aYcLHk6i8iXjpMTz4G/0ZLhH+lrMsy7/uJcCCEvVMRlyimORdeBzjO9
 2k33L/vy5aoLSu+7+Uh1w8FLfbQh9lyEq1Ah8Lpb2ffWOOcgCuFvF7PGHcxSSBcm6Ogs
 eNoBPTuUR3Ybk4Uq8WKWdE4t1ygIcSODt/QPdeZZajSqINtrftYf06hu7kdp5l7rhme5
 9nlYGnCTffyAFM8VRON1O5A+1Ot54rLE482TOWkal3gD250CblaUiewxlozc73cFAnmY
 yq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732025497; x=1732630297;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fkYeS0Df1U+5f0qnqgqXbmsyeezQhL5VTQ3Rr7FznhY=;
 b=xPVn5a4WzUWot8v2C2/VWJ6AC0fMgAZuiC/tXjspT1R2Y2DmrHt55zlzpfYzaMNpJP
 q8MZQ6Jfht63Jv4D0SvBH+2NcshCfnQG3DGZzf66wag9omWwJPBj4P+ijvN1fIwTOsX0
 zkpHCYnKXyKfl472Q5/whXovzslOb/feor2dllrRGzwdEV6QNJ0Wpj0qY81yZ1zoF2/s
 5wF37q4aLAX/AFsV1yugz1m1NffyM8Pgp0uH87b16oQs3lpPT1nY0BjD6hAv9+4htT84
 NEYnghZXhhVLAFG2FR88ztER/kNBGwRifCm+tBTVmjOvAo/ayVvSbp4XsEIipWCBn/Jb
 UsKQ==
X-Gm-Message-State: AOJu0YykgneJuZipu32AnQAYnm/CBpp5l/wjZYwp3oQu8wsYiodblYSv
 upJAXIEQn9TuvAH6xcIl9UE+KJqdAkBbLzIHkDP4wRaLBUjRCjoRg/1eF0AQfJAWJlfTNeGrSbi
 t
X-Google-Smtp-Source: AGHT+IGP0R8Jw7DcTCye7/ydZkUd2LBK2mvAQ1Qhdooa3Qg/JgCM2kn3xOVYCV79FdN4C2hPpguGxA==
X-Received: by 2002:a05:600c:1d16:b0:431:5bb1:f088 with SMTP id
 5b1f17b1804b1-432df78d793mr132483835e9.29.1732025496730; 
 Tue, 19 Nov 2024 06:11:36 -0800 (PST)
Received: from [192.168.2.170] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac0ae5csm192841185e9.32.2024.11.19.06.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:11:36 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241113050607.1850472-1-caleb.connolly@linaro.org>
References: <20241113050607.1850472-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] fastboot: properly handle unknown partition type
Message-Id: <173202549576.43956.6642437579660775565.b4-ty@baylibre.com>
Date: Tue, 19 Nov 2024 15:11:35 +0100
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

On Wed, 13 Nov 2024 06:05:59 +0100, Caleb Connolly wrote:
> In getvar_partition_type() we attempt to find a filesystem driver for
> the partition (of the list of driver enabled in U-Boot), on failure we
> return the error to fastboot and completely bail out of the operation.
> 
> However, this should not be a failure, instead we should just default to
> "raw". This allows commands like "fastboot format:ext4 userdata" to work
> if userdata didn't already have an ext4 partition table (or if FS_EXT4
> is disabled in U-Boot), as failing to determine the current partition
> type is not an error in this case.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] fastboot: properly handle unknown partition type
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/06b8aafd6810d86f37d5b1cd9c1966f1e42403ed

--
Mattijs
