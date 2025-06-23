Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4998AC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AFD082E2D;
	Tue, 24 Jun 2025 01:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pijHvd+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6620182E20; Tue, 24 Jun 2025 01:49:35 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B7882E26
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso3880808f8f.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722572; x=1751327372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stneC04+AcmKp9W8qYWwra4zIkb+mOIOlMeB0zxs9hY=;
 b=pijHvd+M8cda4utob6eut/igx9bCK6HirZ9zXaW4bSPSsyRZQhg9qzzAQUDKBhfM2J
 RLVH08Ft9SwG5RIKPnAcvfl4dwc3fjpQEOaOLX8k4UXfNXVC4KROzqY5UOtGjf6g4bwk
 In329wskCMNEt/sosBINM4Lo+DTv9+9NRDmni+6TybYF0YQEWyL1NoVj783Ng8jm3DbV
 kucViCp+/K7ixuZ28J8kesGKY81lxWqWYdhbXeGp/TfXLiG6IYBN1EJH49Dy/vx9hr0u
 Mog2pOj03htiaXBD5Ru+dsbZI39AAp8/gTQAmXaLXny489YFo9nuCI62tVfA8USux2D3
 5Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722572; x=1751327372;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=stneC04+AcmKp9W8qYWwra4zIkb+mOIOlMeB0zxs9hY=;
 b=P6ff00aPJeJ/DoTFXAEaILgYUVvcY7jAldl3Ig4AT9tkdaKzruZ1Qng1YOS2LL5U+9
 ze1RqDZTz3ydzww/Wx/cWBVq2AUXD+8ofNIgbmK8VzMODPMvOUnuVGUPG/T6fQwpLMJY
 7hZJhp4QQA02LuHSiUGKKsax0tgO3CudCOwsDoKZ8RDSUmp5kDGtQLO9PpKdJELrxtyF
 Wt0iLaUYn4lwFQBIohSkd08xafYir+NT14fNNc1uvAkWV2qE2Rz6NXdwjLp8jE0RzW65
 Q38DBZYreUR4kdIdlMiz/7aQmXEJ8Vn9W2ZrzEVEoiM0bgJchJKDl12pTyff64rEm/Kt
 QvrQ==
X-Gm-Message-State: AOJu0Yx476YedZOnyUgXaAe7GvCqFdKuRQ0/A+N/BQQIvMlX+RZC1/Zt
 9Jlwgz4tbOD9YY7IHwq0TCfI/qHwF7mZeHjKHWqYa1H1DcnHMRnAwn8JzjdtEScD4DxjPl71kck
 pSop7
X-Gm-Gg: ASbGnctqUpWsLdMu8IIdSgNR0mrM0uj2sjReZ49Q79lKTujbZxXZq9Lk2I3byhKn4kP
 k12cW/xbUgAyb20viInuE8UXotJnltfATRyLtJfEvDK/q75GiYvn3NoTs4n1q8Bmm1YRrTVYVRX
 pu7+JjWVx3EKxikw8dFsCRWJ7jFYJjfcugzkj4rxgYW5NlyuMk9aO911H3aJvZUI/wynT/nFpdU
 UQI3bRBh90DdES3KxT4bVmjEEPi6MBB6tBQ5gRPPMtYxlO/VjCP1BIxp08caaMTh34gOS/OAB/R
 e1wHejYJi3tjZ/JlBJv1IeoOYodIAn37BewIRLdD8klzGkzdj71u+hqcVOaB96lD9yeHNR0LBtl
 W/gtRGdKiIXD6QoTKHBpTTg==
X-Google-Smtp-Source: AGHT+IHSg92T5/+ieg2WXQsZNr+ykmh4lXTl+sTfnzLlr0upqJ31SVEhSzSh7a51sIpFhw2jbmnEww==
X-Received: by 2002:a05:6000:460f:b0:3a4:cfbf:519b with SMTP id
 ffacd0b85a97d-3a6d12e5e60mr10291075f8f.44.1750722572049; 
 Mon, 23 Jun 2025 16:49:32 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:31 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>, Paul Sajna <hello@paulsajna.com>
Cc: u-boot-qcom@groups.io, Sam Day <me@samcday.com>
In-Reply-To: <20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com>
References: <20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com>
Subject: Re: [PATCH v3] watchdog: qcom: introduce qcom-wdt driver
Message-Id: <175072256954.128390.11011518070393346807.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:29 +0200
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


On Wed, 23 Apr 2025 02:19:39 +0000, Paul Sajna wrote:
> Some Qualcomm device vendors decide to turn the watchdog on in the
> bootloader, resulting in the device being reset if it isn't petted every
> ~30 seconds. Introduce a driver to keep the watchdog happy and prevent this
> annoying behaviour.
> 
> 

Applied, thanks!

[1/1] watchdog: qcom: introduce qcom-wdt driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/530764de9fc8

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

