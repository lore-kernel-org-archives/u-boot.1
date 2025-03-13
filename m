Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1650C28B28
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 03:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB4080756;
	Thu, 13 Mar 2025 04:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AQCmJ27B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29CBB811C1; Thu, 13 Mar 2025 04:37:21 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B06BC80548
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 04:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c53b9d66fdso58403385a.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 20:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741837037; x=1742441837; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtqj6k+AhMbZV2qYc0w/CC75MPibOm8gEkurjy5EBGg=;
 b=AQCmJ27BucWvKS4+KdA1UF6fsON2ek+QzxUjFh60YOQNKYspjA+JjRMsDlHbqbFMIF
 YHDhLxI7aYUSvg7o1mxwa6skd0lHufRrsTNV0abICtlwLzHnye0lfCwdNd2zdVgO2Au4
 6/clVs3XGOXOkmnUy9K+KHDFM7m/Vv2la2iVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837037; x=1742441837;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dtqj6k+AhMbZV2qYc0w/CC75MPibOm8gEkurjy5EBGg=;
 b=TWpz46T7vpbsS/Z9+Lq+BqSOXNmO4YiBGPyQtpqW40X+P8TkSYo4L0pFa8hzs2DxFm
 zfwf8stY6n+T/dTG1/SNDQ5uNU7lwHl7WY7Th2A5QaRsYwBhOWptxwg2DxLOR8GRQXP2
 6xL9C0fAc7nSdRqJEfQwvFDSHQCz0yPLNJjKFdsx3C++Gmz/m6o8U1p9f9JlAVhHIyac
 r+C4XWbovZbHLMYhTHQT+sxx/xj2sctfBfTkx7fmAj0DpSFuE5kFCSqFlfeOJpNSWEE6
 YAydJfB970Z4DS6Qmfc5nIt5oT6+l11yXaJpAjrlRqg6ProzguEHltWSp/Es4Byd0rZv
 O7Cw==
X-Gm-Message-State: AOJu0Yz0W+RVnp2PD9pIZ/I9sjAyouADR5NXfonji23FBvj7C8fXxTh7
 5z6ZS1V7ILkWTReg+HJNEUD5QWitLWBC0jXnxEti9LMVurKfJKtot+UpuVc3bTs=
X-Gm-Gg: ASbGncuVocsVTszl2OZEL/rzYIB25aSIPEIoxARWmK8++MIVlsuIZ89mOs/BvQzy50c
 HrYL+qrY7oPA8N21rt2zqWISRr969SU7Cfj9dPp5n0jSck+rRNm5u1D1SxOY/opheWbB/W4Y1Dv
 4scYzwrb800RKt/X6kj5yzPZMkpdZkDyefuxS3cXAKgyfG/xFmtjexaR5enyhGSATBrQ7Bmf2Y2
 V78Ij1fbdCYEMT9w9l8hgOoPiGvVDzPUbh9XqvYXJ37YPN9LzRr5awtSeodKl1fJRgH22bmC+wQ
 2SzButy8oA1rfNKafxgzdRZfg2N/iAmBJYszcV1Jk9gfN/8xtKEm0eY=
X-Google-Smtp-Source: AGHT+IGq7bGljNL/3+3qMUVPTS0gMyPSYtOGgXpdSruEjQ/suzQMflpCXePPzJHGmD8LcTcmn484Hg==
X-Received: by 2002:a05:620a:1b99:b0:7c5:562d:ccfa with SMTP id
 af79cd13be357-7c5562dcff4mr2430085985a.36.1741837037590; 
 Wed, 12 Mar 2025 20:37:17 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c545c5sm42781985a.21.2025.03.12.20.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:37:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Cheick Traore <cheick.traore@foss.st.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marex@denx.de>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <4f602c93-271e-4722-88cf-60079ea11009@foss.st.com>
References: <4f602c93-271e-4722-88cf-60079ea11009@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot next / v2025.07 =
 u-boot-stm32-20250312
Message-Id: <174183703570.1897902.8617229413295296224.b4-ty@konsulko.com>
Date: Wed, 12 Mar 2025 21:37:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 12 Mar 2025 18:20:37 +0100, Patrice CHOTARD wrote:

> Please pull the STM32 related patches for u-boot/next, v2025.07 = u-boot-stm32-20250312
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/25112
> 
> Thanks
> Patrice
> 
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


