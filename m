Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD5BC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 04:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB33807B4;
	Fri, 24 Jan 2025 05:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sn86Mu2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE527807E4; Fri, 24 Jan 2025 05:36:20 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70CEA80780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 05:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4678cce3d60so16713361cf.2
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 20:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737693376; x=1738298176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Qgj79ud76M9L2KGxJ7oH1tkNpfiOX5aoI45F2KUOLQ=;
 b=Sn86Mu2DBTHwoTlK1hBu27mcA0XZmLPxIxGmhPlT+OhlO6ISELMAwTzr+TECKWF83M
 rifrHbf2TsGnfZ+/DxR1anPeYreNmpk4tBhnbynRC9J4MOAMLyxMWK0XTlTwLtgQQpVU
 pucQ8FtYrmZVxwFaxKXf5RbfRVp/TL8bYgGys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737693376; x=1738298176;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Qgj79ud76M9L2KGxJ7oH1tkNpfiOX5aoI45F2KUOLQ=;
 b=MKHleIu/l7kwzXM7abqRcSN0kYQo8lDJlffgk/Ap6hEwkrfaGEB+wHpnITo/hdDYJv
 wFhibCoW9kkGUDpMU1K8r9IxjewqJBlVsv0W6RGFQJ6GkRSCM8koN/iciE8lusz0f7pP
 K13A0YyuunEjT9irrRbQuDX5dGd2OO01cvlBRFEAcfMQQrTA/H8XX78Mqq7+wYc7u2Bd
 4BOPTzlgBYHWTqHGk0zF1O/IZm+l+WpiNbTElimA1BSW4nwTWXrlXIbFSDdO/TrmJ0X/
 wQmYs3uxOFAqVb9x40e4uoBFYFG3P3GZZ0Cs415pWQ10CTd0xrHtWURZg5gk3+emq4RU
 L5Tg==
X-Gm-Message-State: AOJu0Yxk12rV3x1L/yH8qh+r2Zh7pTvr6/SqZEX1EcpP95Q1x/KvNJW/
 uMeP6b1B1oYVR1nMDV7qDiGYR5plKTSq1BWJGzNtw8ZNYucvFQc1Y0XtaHfOOYk=
X-Gm-Gg: ASbGncuwh7LVd0r8dD0fiLi//mQL0pRRNRpEopPMzCjHb3gALX9bYaNE2bWPiGngZpY
 MInjJwG3t3tCUMDazXAeldfUuAqq1ybJVKoRdMck0CIpj80WolfMtmyexnLGdf4irepOsO7AAFq
 un5EJmFMlv6rFI8WuBJVZCmu2iNKasahjNKFb8olFcco+Cibexot3OsqB8+QSCQFUFNsBr1zONA
 PtvAjtYtM0p8J58wbvRlklh4kYQZYkmT5L8GPSGDLlDOPz/XR/WqxU/n0Zv06b41bRZ7iIy6mJB
 dJs=
X-Google-Smtp-Source: AGHT+IHuMoF4UhQlpWSnAZ30Alp6ygVYZrGP9fl4BIeYJLVf15qclyW4qRRVY3/6A+NIhfmcQeyXGQ==
X-Received: by 2002:a05:622a:1817:b0:467:b1b4:2b6 with SMTP id
 d75a77b69052e-46e12b7bf21mr452345811cf.38.1737693376321; 
 Thu, 23 Jan 2025 20:36:16 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6689d9e1sm6142461cf.35.2025.01.23.20.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 20:36:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: joe.hershberger@ni.com, rfried.dev@gmail.com, yschu@nuvoton.com, 
 JJLIU0@nuvoton.com, Michael Chang <zhang971090220@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250117104540.1580343-1-zhang971090220@gmail.com>
References: <20250117104540.1580343-1-zhang971090220@gmail.com>
Subject: Re: [PATCH v4 0/3] Add bitbang feature for npcm8xx and driver
Message-Id: <173769337403.3052421.13628973120955019438.b4-ty@konsulko.com>
Date: Thu, 23 Jan 2025 22:36:14 -0600
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

On Fri, 17 Jan 2025 18:45:37 +0800, Michael Chang wrote:

> I am resubmitting the patch titled "Add bitbang feature for npcm8xx
> and driver" for review and inclusion in the upstream project.
> 
> 
> Driver didn't support bitbang feature.
> Add bb_miiphy_bus function for driver and open feature for npcm8xx
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


