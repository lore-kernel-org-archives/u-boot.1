Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A121DCE7AA6
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 01:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C392E88CD1;
	Fri,  6 Sep 2024 03:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ve0yJCXN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C07388AB2; Fri,  6 Sep 2024 03:09:29 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20AFF88AB2
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 03:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c353f2f954so8377006d6.3
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 18:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725584966; x=1726189766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfVIyqRjMedV7jC9eKmeB7IToxfZYuI3A55seb23GYs=;
 b=Ve0yJCXNtgfvhvhUY9HVaT2J/0v9E6tpJ/yezIklPNPMcHt9m8emybdgfu7XFZFXmU
 yIHsNdMbpFzV9z1buta5hcTnW+Br66zOr2ogMPT8XRcBubtRLxRNSp+A2VpUfEpgCAt2
 WLH8EeHb4uGmjkr7cEGQDiaYXckJKpPAkTxUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725584966; x=1726189766;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PfVIyqRjMedV7jC9eKmeB7IToxfZYuI3A55seb23GYs=;
 b=BI6YeyIgLrBSIH2HFgJ8ly5sXAZNHuVVNCxtBilDd6Jd0ytLWUuAbCWQeRtG1mzEGF
 UbQTYMyhh6bvABv96uxG03FcsfCFbNiSoTjknFWUFwH/9KZ7YLg06rOAW1S+Nxl098Ru
 B8Im3Quzx58gzZRCRH18VTptB8JRDdmu+jIF21CJw+JzfEvpzf5Cuvvf5+OXj5NcU8ty
 vJi/72IOBMxS3/2lB2BPN++134Etx3BQlfxQcjjq5FlteXot6RKLVRu+RCM3obhavzVF
 lu8ml9RMHhtycxPsQ4DzDshvSaWtzRztobH8mQz/zunT0fJVrgH3QEqBUvhQWEW89m30
 OkdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEvdbhn/ssNlUCHuhENrdLza7HsQQfhhS+jBbb1ww/QL2pRUmbL05BC0A8CBImAXKeiMePTY0=@lists.denx.de
X-Gm-Message-State: AOJu0YxJ28/IcCA8p8Ls3A3VstLlM0k8dUFu89BFq12HA+mXN7LHrn+i
 ddTdLdJiTxtVSpk7otpQL2XUsPZheP58WyYiI68elFmSLkL5OMEORYy/waiZdjw=
X-Google-Smtp-Source: AGHT+IGnEMaeFfuQ+xnGTOtqi+D++E9ucUUvo/xNq92svcXQ/lFeVOThcP8XSazJOEa3OmIhnEa06w==
X-Received: by 2002:a05:6214:4888:b0:6c3:6e6f:794a with SMTP id
 6a1803df08f44-6c5283fcaa9mr15621756d6.20.1725584966073; 
 Thu, 05 Sep 2024 18:09:26 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c52041803bsm12145516d6.105.2024.09.05.18.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 18:09:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
In-Reply-To: <20240621015351.1573934-1-caleb.connolly@linaro.org>
References: <20240621015351.1573934-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] mmc: msm_sdhci: program core_vendor_spec
Message-Id: <172558496459.1864439.12871400960449171932.b4-ty@konsulko.com>
Date: Thu, 05 Sep 2024 19:09:24 -0600
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

On Fri, 21 Jun 2024 03:53:09 +0200, Caleb Connolly wrote:

> After resetting the host controller, program in the POR val for this
> register just like the Linux driver does.
> 
> This seems to help with initialization when running U-Boot as the primary
> bootloader on some boards.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


