Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796A0CF6D2C
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 14:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6BC488965;
	Wed,  2 Oct 2024 16:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YIDTu5tG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF0458924D; Wed,  2 Oct 2024 16:52:50 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEFA8890DF
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 16:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8d56155f51so862313866b.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727880767; x=1728485567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEF0Cs6bcXjfkOeOH/lgkSB3H0YERHzlC4Omkpsp+ds=;
 b=YIDTu5tGyByvFaGjH0C3h1PYOH8fj8GaSn/CWKUFHGVWwkP34OU+qulg7nu3qeG+Re
 zSBIcRA/7xWLt6+c/z+uEpq59XbPU2N4OfIfsdiHzTbXhK+dvozUbXVadvpydROXs/oM
 mjBl2hGz+gxGWXU0CStLtvNLg+38ZDk5E2Ktadsen+fTL2v4W5KOQ0XjdeRSeVMv0Jhx
 YsDClPIaJbRZLz567XtzUNiM/lIGA3/ZWZe4ilVrtHRn08kHth4XC48gklye5JU3gGkL
 /qx9orqXRJJpe4k+eMm3g7tt/YDP+PcaL9dva9n3UHrW8q9oiusA+LGSurBRc+9Tcn07
 Uq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727880767; x=1728485567;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEF0Cs6bcXjfkOeOH/lgkSB3H0YERHzlC4Omkpsp+ds=;
 b=tqQ5LElGYQQtrWJTWRPThUiW99/PY4s3XnBYMp+H8NmT6/ckVoGwkr3lzHK+owAdR2
 YZk74vbrQZ45SuH1mZxZF2pV+IONb5HY2t57yJ+pdZxTOa2sl5icUcd/bFxbK7lDDVjj
 8GpFJJwzfMCzean9mLINbUdZNmR8bif6Ieym5G+JOYzwQn2h4PzCTTpkvJ6PelQvNHNP
 K2CS6YtDgWI/OqiV0wsRBeBwLfDL8FgE+hWLZyQW0Olk+khTQZ1LQ7nhppj+wNIuJcEE
 Rv173dF6A+jGmD9jJuGEOPSo3VSj+cGXi9kufuRF+yMlOrYLIsnJ3QeY8gemOk4r7vis
 OhwA==
X-Gm-Message-State: AOJu0YwT4Dhmb6Q/02SUH+uyvp/+SqE5Neltn94QvrJgh2Bx+j+ifc0a
 Dzn/1mcZcH8Hhaw47nSN46XH9/ZjC3i5mvVyurQgH9oCNjCZiM3aJhSamNcqk1ekW+1jTso6ATm
 1
X-Google-Smtp-Source: AGHT+IEQhKykwnOVazkLmlmlo/fQfcFqMJ5RQCwiRtruTq6M7Wm0tD4KwqSKcszGfrY5utOJQn/+rA==
X-Received: by 2002:a17:907:7da6:b0:a8a:cc5a:7f3c with SMTP id
 a640c23a62f3a-a98f838cce5mr262443766b.58.1727880767451; 
 Wed, 02 Oct 2024 07:52:47 -0700 (PDT)
Received: from [192.168.195.50] ([95.90.247.28])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c297be12sm889785666b.179.2024.10.02.07.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:52:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Heiko Schocher <hs@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20240909120641.1396544-1-caleb.connolly@linaro.org>
References: <20240909120641.1396544-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] Revert "gpio: qcom_pmic: add a quirk to skip GPIO
 configuration"
Message-Id: <172788076627.935801.18201778074694041684.b4-ty@linaro.org>
Date: Wed, 02 Oct 2024 16:52:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Mon, 09 Sep 2024 14:06:10 +0200, Caleb Connolly wrote:
> This reverts commit 19f000b72b2fa7e4540f7cdb91287aff594239bd.
> 
> The bug in writing was caused by a long-standing error in the SPMI
> driver which has since been fixed - c2de620d64d4 ("spmi: msm: fix
> version 5 support"). We can safely enable writing GPIO configuration
> now.
> 
> [...]

Applied, thanks!

[1/1] Revert "gpio: qcom_pmic: add a quirk to skip GPIO configuration"
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/25595a48555c

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

