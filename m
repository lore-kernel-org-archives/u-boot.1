Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A265C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 16:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF0AE8059D;
	Fri, 16 May 2025 18:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LpxsLAA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A945E82AAA; Fri, 16 May 2025 18:20:35 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46DA78006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 18:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3f6a92f234dso1904303b6e.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747412432; x=1748017232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wQoKaDu65UKpM7r22lbc2l/KTfxsCUjOvIwEsApRXlE=;
 b=LpxsLAA7AYsFHPaQXtoLXJGfbNDIAWyFD8XL6C3F5IyLOKb49Mk+esNz6YDyZO5o1z
 27hU8PUe8ua47fC1u+Cf5gAyv7tGiaU3gBbfK8gF0JU6xhsPbfS+aR3mn9ZDmsudfRhH
 tlsVj2qHp+6zq0o1Pn9Wv8SvL1miQn+c0tiKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747412432; x=1748017232;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQoKaDu65UKpM7r22lbc2l/KTfxsCUjOvIwEsApRXlE=;
 b=Uspql7J7PuTT1dVtOK13Tg+VBUiJLEos48dYtfL81yNKvwD7qeGxn4KeYqk1kA7QNG
 iRz+t4Wp4YAwRdZbLv8nYUoljl9dzgF7i8xkGOH2aRIt3xMBKyirWpXyzN503SGB8sIF
 y4eUVkOxRbmqFXKrbQeYTvwGTRw/+FeJMmlNpWQ2o5JoQ++ZVpmbb3hplcsXoaeQjJbT
 R2kExiRGeVQwLlQL205eojt/iIogYAzwSse19yiEjjP2DnglSzVpRwmBZDluRncYIMjH
 2oGyg+VYdMK+hJ/Ver4eTcnpWQS8uBW6E9tcTf/dfGxfBrfh7K7uo4EkuCZEU9qFh1fG
 76Iw==
X-Gm-Message-State: AOJu0YyBq2e58lDx0fsxP+cWNAmW682TDwzxiuI5xXK4C2IoVa8yDHj4
 +bhp4B51CuW8wi8zodQQr+EGBSKnckzLDT3QaaFkm6KR1DCG3G66ViBN6TIaLPwQ5PhAmBpVFYm
 EjWU4DhI=
X-Gm-Gg: ASbGncsAVq3hMEeh22hdPqk4jFevl252T8USjjbHVVrzF4cbDXujBe2sbMJmHej4oGY
 3hmdV4OIVGQC3LsYGZ14iGyFMxQsD1z+1rpojs+X0WvO/koBXyFziuDtWqPgvILd5mL3kDSidtD
 AvCqV3LXZMp3IHcIPOF3lpOToADwgtWaVPuax+F72E/KuuFzd7GXswDHc76eO1cefVBOqFHMVuN
 4LeA7ptCBeM7TlFrSdo/P8nzLMrREOixc82g73ft1L0e9SlZsMwhdk7JO2UlJEd4egz7VwQXTwR
 CI85SRFbnY5z52iEs/HKgy6RRIQe4xSBva+M2kOTC7m1eRgqm355WSXyXLAx6InjNQ03KTZkhkP
 UlDCTyxI/KJU=
X-Google-Smtp-Source: AGHT+IEnQVFzMKai2MfbMZe6dVlDTCfKLSV0AbL4/mBNd4Ak+GCNVIF1jTb+mTWwU+URaQ/7b97VOQ==
X-Received: by 2002:a05:6808:320e:b0:401:ea47:2c4a with SMTP id
 5614622812f47-404da793bd2mr1961115b6e.28.1747412432015; 
 Fri, 16 May 2025 09:20:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f2f2e6d1sm440436eaf.8.2025.05.16.09.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 09:20:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTg5GzLW1KvGvjcygoH8ktN_bqJyutbojHyONfmKVtddSA@mail.gmail.com>
References: <CAFLszTg5GzLW1KvGvjcygoH8ktN_bqJyutbojHyONfmKVtddSA@mail.gmail.com>
Subject: Re: Please pull u-boot-dm
Message-Id: <174741243109.2939215.9980838033339254801.b4-ty@konsulko.com>
Date: Fri, 16 May 2025 10:20:31 -0600
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

On Fri, 16 May 2025 09:36:14 +0200, Simon Glass wrote:

> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/26199
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=78&view=results
> 
> 
> The following changes since commit 4c26de2eea6bcf5f27b13da0372d27d767cd38e3:
> 
>   fs.h: Switch to using rtc_def.h (2025-05-13 11:30:09 -0600)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


