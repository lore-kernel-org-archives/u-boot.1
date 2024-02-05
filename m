Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263CAC4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 15:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E51875E9;
	Mon,  5 Feb 2024 16:04:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xEDSAAjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3845787811; Mon,  5 Feb 2024 16:04:45 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B3386314
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 16:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a370e7e1e02so312478366b.0
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 07:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707145482; x=1707750282; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aNmkImz9/Flbkd5VfEszB9XH4tGc7iXI+lD0cnHmbCQ=;
 b=xEDSAAjf+wOsSJNaruQ8W82/oXSWGuSlJ2ekGAqGEQBJeTICJB7/EmwuQxcg2utaRR
 xcBcwJrmSAPNqn77Yhu57NWoLjiSimBCs8QSKa/+VXCXkdlWkkPWSm0Fn1/LQ2lRIlto
 xUn+L2aS7lI+iq+yw/qvWDK7/HIGffYz0GLmlA79RGwjc02A0q7UKkBM1aVGwpCRzaBS
 IHKTwmxzaRp+ofd1nsICCzhI1ecuCkmcDcHFoy1k+7uDsCZiN0ropgbelAhIWr54hEzs
 bH76cvWKCVIJ8PWryOF/GRNj4dWEuKuc5TJvdrD9lW5cCG6mQOslwtsl/GCNnS289ui3
 x0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707145482; x=1707750282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNmkImz9/Flbkd5VfEszB9XH4tGc7iXI+lD0cnHmbCQ=;
 b=ilR2G3VWOT+BckB8ibm7jDuJGgutESvcy78n1Z6EQoI+oZrpICYr1IIkU8AyBcTu3s
 OR98jBvMAyA3USJcSOVfoygLY+uEltY/ODRODaWT/ixcCVx9Ryyboy+aWDpbu4XyDFCt
 Z4k0Z/abhAzkvWv3G7ZVl8miWVlBe4UwxX4wnMcrUb4MGzs8NAyydvkHNykvPM3ad/OR
 RFd/7vbE5IxoBUMzWA6yJ4pazuOnfm6R4jwFIvFgCfLqc01253eYCJd41kFzt8RRJk4e
 +pRx248+aqxLGGyY2BIqseVBaSBUnZChB4WQFl65HyMm5TqnR0bRe/Ly3UxbHBPL0ca2
 6iiQ==
X-Gm-Message-State: AOJu0YxO4M6ZNdvV9O0+o7tn6vBXiKRGo1/R2FBI7Z34yEUovdOGZVeD
 3I28fLaFrvg3jrcgXe4OswONm1PPQlsU7Q5h2mZ1CcI+x+dwpDWktrA8CnQGejg=
X-Google-Smtp-Source: AGHT+IHRZw7s5JUXqqpEKb2tfUrm4K6N9OSh/mPt1Zl/eq044cpDkvdtztSO9OgOw9fSJKEpGLBCVg==
X-Received: by 2002:a17:906:3102:b0:a37:1def:bd73 with SMTP id
 2-20020a170906310200b00a371defbd73mr7474995ejx.38.1707145482409; 
 Mon, 05 Feb 2024 07:04:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXak0S/R3A8+gprNIsj3pHWtBjiMa++tFInkf0M4zsRN5OgNcnU8TyCGk1xPVpxVw3GAy49sGzB/S9ab/uWQIm9UWJtAUacpfBEls5cTyEqYwDvxTTbBui6fAa5gGF2N6XuQFAeLNvqOSspj0wSCCsVVIm0jotv8d5tYYRuXXjmnmW58Pil406v9jts0eFwgAnqH37pSry64voUlu7s8VkDaVBOEGvr7ZY+iSicLUCYpsXaA9k5T8J5awa6cEYt0WD+WzL0M2dVCKPEXoFPz4NLPawzxNR/
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 cx7-20020a170907168700b00a3161adb239sm4431286ejd.158.2024.02.05.07.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 07:04:42 -0800 (PST)
Date: Mon, 5 Feb 2024 18:04:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 u-boot@lists.denx.de, BMC-SW@aspeedtech.com
Subject: Re: [PATCH] net: phy: ncsi: Correct the endian of the checksum
Message-ID: <da9231ac-1386-48fc-81b9-8e027cd5dff5@moroto.mountain>
References: <20240205080228.140001-1-jacky_chou@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205080228.140001-1-jacky_chou@aspeedtech.com>
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

On Mon, Feb 05, 2024 at 04:02:28PM +0800, Jacky Chou wrote:
> There is no need to perform the endian twice here.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: f641a8ac93e0 ("phy: Add support for the NC-SI protocol")

How did this ever work?  Was this always tested on big endian hardware
or was nothing verifying the checksums?

regards,
dan carpenter

