Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FF3C54798
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 13:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA8D8796B;
	Sat,  9 Mar 2024 14:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pXnuymRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21FA879F3; Sat,  9 Mar 2024 14:10:41 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0254A875E9
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 14:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4131ad76f05so9338395e9.0
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 05:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709989836; x=1710594636; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=msXnUSBOP8//MaXJUPYaRVF/HFtf+ZKhHuWPAuUMiSQ=;
 b=pXnuymRv2w/A+9pgNTuOILzOPGeQ9guulhMWfdH08Uir9bZ7TemxRK8hnrTPrJ2Gs0
 ewkxerxTJJdmg3NUTrIjomiF0B0wC8CQa2/kAr8aZunJLacYC1r+K8QxPECdZ5Zyh8WA
 BXGM99vec3yrQZzlzff+D2rL1H8lDu3VWIyUfclplQQsGUZ2WjPjenG/291dQb/Vfacd
 BPvgGTmlIf2fOg+2kFaWgTVIqQmJWxpYlvwQM2kLnnoE5R70bLumrxU7X5n4xm7QmiXo
 E7UF9roeybN4/Q8YPWNXoFFVxcF0IlBKna6tZMfoiBCzQD7kdpI782qtKCoPjUTsoAjk
 Bbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709989836; x=1710594636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=msXnUSBOP8//MaXJUPYaRVF/HFtf+ZKhHuWPAuUMiSQ=;
 b=SnDFN1vR8vtyR0iseRorQZ4ae3L8Mvp11y6uiDzh1cfRg3gqNCmEGUShmJ8XC6MKqe
 8JTcKRuwffQ1jm3tEp9WFpSo7TIUeIAtorqoWFR5j5qBdVtsj0Qt9Lvddbk9aP+n8R+d
 QEgCIRujCm1LiBnTZn1oeuRV6w8uZ9p8FutG58OF0zN5lTqdfYRtPaEi5ibsMPvuG1wW
 TgvhmBktVXtlcejXsusyIV18kOaCwgIFKgCujyKpj6kYUb+2IMZkiIGzPvmd4XSXufJX
 B89+Yim7Xk74HbEr2zDDx1FwhDqBhOLQSpd205qxOelx0FRkuFHVavFiAh75vN1EeB+L
 xzcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL9c38qR2I5Llh37YDxyfmJkRrHBurIpwWn2YL0hHVIP9hFsSdXz9/D6MZ84BHlVYT1PscIfejflF9qxUGK32bKiQJYQ==
X-Gm-Message-State: AOJu0YwQwHC/zNErWabJagr8Eqvs0iny8UkUp9RX7yeKmpOv192d0E4c
 loLgRVzb45ACH2qNlBzRxr8Q6TZitNt9tDRgM6cQ1k0I5oAMyF/OJI+AkbxGOuM=
X-Google-Smtp-Source: AGHT+IGWwJOp2mfxX3s/wQu93Tl89YlRyy/M83Ae1NpByICOBOnfabCKs8H75aLUOXZWfM8mTE7FMw==
X-Received: by 2002:a05:600c:3ca5:b0:412:7218:bda4 with SMTP id
 bg37-20020a05600c3ca500b004127218bda4mr1386543wmb.19.1709989836095; 
 Sat, 09 Mar 2024 05:10:36 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 hg6-20020a05600c538600b00412c8117a34sm2461750wmb.47.2024.03.09.05.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 05:10:35 -0800 (PST)
Date: Sat, 9 Mar 2024 16:10:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Bhargav Raviprakash <bhargav.r@ltts.com>, u-boot@lists.denx.de,
 jh80.chung@samsung.com, sjg@chromium.org, m.nirmaladevi@ltts.com,
 trini@konsulko.com
Subject: Re: [PATCH v2 5/5] power: regulator: tps65941: Add TPS65224 PMIC
 regulator support
Message-ID: <2ae4f465-488f-4dcf-bebb-4a3bdb932a1b@moroto.mountain>
References: <20240306133947.160354-1-bhargav.r@ltts.com>
 <20240306133947.160354-6-bhargav.r@ltts.com>
 <20240308091011.yunwugsxwbisfeqp@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308091011.yunwugsxwbisfeqp@dhruva>
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

On Fri, Mar 08, 2024 at 02:40:11PM +0530, Dhruva Gole wrote:
> > +
> > +	if (val < 0 || val > mask)
> > +		return -EINVAL;
> 
> Probably combine this with below if's, eitherway is fine.
> 
> > +
> > +	if (val <= reg_base)
> > +		return base;
> > +
> > +	if (val >= reg_max)
> > +		return max;
> 
> Why all these if's when they can be elifs?
> 
> > +

This was just a cut and paste of my suggested code.  I really like my
code...  It's like a tortoise eating the three bears' food...  This is
invalid.  This is low.  This is high.  This poridge is just right.

regards,
dan carpenter

