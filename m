Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB28C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 13:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6698688786;
	Thu, 18 Jul 2024 15:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JwhatDJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB6B88818B; Thu, 18 Jul 2024 15:41:36 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C57886A0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 15:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-260fff38792so120689fac.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721310093; x=1721914893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhS3b5C81Kk5FKqDlTAmpwbksW41b5csspvKD7cfRWc=;
 b=JwhatDJrA20pn2sTFHtGn6hQntHs2kvMkjd3wNVo5D60S3K8zlCNpeazxoosnuPmMB
 vGLazPDsXsiAlfHDiaD2vZW+7WI+eSx1N0972udFkHteyPDOy38Y7+ocV4p1dAdLA2jA
 6EmcrFkGT3Qs4V8X/Yx3cxSKOXl7XwlH32at0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721310093; x=1721914893;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZhS3b5C81Kk5FKqDlTAmpwbksW41b5csspvKD7cfRWc=;
 b=qSR/IhRQKJbSC4mLvhp/ZQs3mBKMf13cXa8Zf+OkdAicxRBZDH3FbLERARlRQ/ojYc
 Q7NYcCGE3bu78VZI70nc7mD1vNSm9lt3vshgVapgNxQyrqaOwfJX/g3XdUI9XiSa/7b9
 hg/3OPWMvLA2FYNY59bttbBPWgB8+GolwpdHqQNQ1dhmQylTn/PGb9U484SYW1tCg90c
 j6WEBI5TVaNDhW+Lq5C4+ZlVdgFhZABgN7FvGcC1uMWvE/MUNJsIQAfY/3Y4ZC5G991/
 21YXGNk4WoLl6WB7YLWPA+/EGXkk8/SrWCVqx+NqOwEiEDG9NVRNtXYcJQYhz8ytGByJ
 n+kQ==
X-Gm-Message-State: AOJu0Yy5DBQz/v5Wr/I+YN/jSScvA/CCb/hcucrxZsr9tB5Xjgpu45pE
 MMw+J3E0GdJJ3XbpYh3Wq63D1E6JE9x9wsFZYuyAD2w5rn3Ejhp/v48ONRED4cR7VDcP4aaP6+b
 auJQ=
X-Google-Smtp-Source: AGHT+IGn5EeB4rwCpeb1cBKB594i9JU271ax3iF6quIkncQJQzdHBcUh4QBpjmOTB0ZzvoBt+TX5LQ==
X-Received: by 2002:a05:6870:558d:b0:260:e096:414c with SMTP id
 586e51a60fabf-260e096853emr3721215fac.49.1721310093249; 
 Thu, 18 Jul 2024 06:41:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260ee947f82sm355303fac.50.2024.07.18.06.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:41:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20240703113756.1293218-1-vincent.stehle@arm.com>
References: <20240627170629.2696427-1-vincent.stehle@arm.com>
 <20240703113756.1293218-1-vincent.stehle@arm.com>
Subject: Re: [PATCH v2 0/2] Respin bootstd cros patch into a series of two
Message-Id: <172131009240.1834634.13545537893706472606.b4-ty@konsulko.com>
Date: Thu, 18 Jul 2024 07:41:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Wed, 03 Jul 2024 13:37:54 +0200, Vincent Stehlé wrote:

> This is a respin of this patch [1] after discussion [2]. Thanks to
> Simon and Heinrich for their reviews.
> 
> To use the guidcmp() function, as suggested by Heinrich, we need to
> make it available to bootmeth_cros.c and I think that the cleanest way
> to do that is (arguably) to move the guid helper functions to efi.h
> near the efi_guid_t definition; this is why the original patch has now
> become a series of two patches.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


