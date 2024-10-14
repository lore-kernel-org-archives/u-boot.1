Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A58CF2590
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 06:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96C7C89005;
	Mon, 14 Oct 2024 08:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N5wvWk6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FB9F88FD6; Mon, 14 Oct 2024 08:56:35 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 972C288FB9
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-431126967d6so34774815e9.0
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 23:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728888991; x=1729493791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9h99No2UDZERWH3voYZl6B+Z6paxfBF+Fqff8iQmvMY=;
 b=N5wvWk6GAsHHE4LsvslpNxynCVqW9/WszUnDBMKXXOwZKiUuFuf1AHA5SahB4HyypO
 XuUKkS0FVwd6hs+dOH9R26yC1dLhnMtFekllgnrykCc3mX3lMix7nE/N6tnsu5bn5SAz
 yu764Nj0e0Kb9OVmu3D/5J6lepGbDtytMYeEvQy9gNOVaWyKx7IZl/oRUbMYT0TNoSE/
 78A5c9enXgiPLApa9P6YJ80oSv7NXEXykgS7hi4uryaj/ddzQw5ALa5f8ikq62Pj9H60
 4R2Ne8WDxWB7ag6KYjlZ3gPBz7VNeqMY9/7QrAPdfeTchubuU0tU5A81Ro+728Ce0jng
 HByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728888991; x=1729493791;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9h99No2UDZERWH3voYZl6B+Z6paxfBF+Fqff8iQmvMY=;
 b=nLoow3DfdBufaaQ2STpy1e9oEqdiFTdD4OL7bVDdB0ijTAoiuJMsliQd1Uk1wudK07
 rO18hdpL49sS1cHEG84GKe5utgSA2nD4MWQngSS3OFwAommTUaYRk24zhjEjJDWqt7xt
 91QvgNyIzqJw5u8emQ5vIc0gvpOmbU9i1q3mfK5wINg4PKSf/Wo2j9FhIWDTI8daXilK
 oSKv2k0TVwm4L57GisoQVxpJBtKbYQQVboRAxkSdvr8+755NvZIVnTklT9c6H4SRoHpf
 IxNnVx+mCmG5Bj85mNBtFiHyoJcT+N9idP41P7R2cb7gKXweJzFG/kXqHgxKwYB6lf79
 vpxg==
X-Gm-Message-State: AOJu0YyyI3yew2L3seMvArjJ3hPUy9kEvcPQ4zbEAL8ixGtVwy09/kmM
 10WCGiXb13yJuQqt8K3g/Zh8sfEobKEVerMlMz0EFRrEtRCU42Uun85kelxeMNVrv3bv63RJebE
 +Oxo=
X-Google-Smtp-Source: AGHT+IGuPALYcd2smz00UlUdQYOaZMnDpFGJ1nT1wXx1Qij6XkqjxmHmMC2X6dElth2k5UwlW4ExIg==
X-Received: by 2002:a05:600c:1d0e:b0:42c:b2fa:1c0a with SMTP id
 5b1f17b1804b1-4311df429c8mr89907795e9.23.1728888990977; 
 Sun, 13 Oct 2024 23:56:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430d70b4331sm145900095e9.36.2024.10.13.23.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 23:56:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: michal.simek@amd.com, bhupesh.linux@gmail.com, n-francis@ti.com, 
 git@amd.com
In-Reply-To: <20240920041651.18173-1-venkatesh.abbarapu@amd.com>
References: <20240920041651.18173-1-venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v2 0/3] Add AMD UFS platfrom driver support
Message-Id: <172888898966.195460.9225584679186267187.b4-ty@linaro.org>
Date: Mon, 14 Oct 2024 08:56:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
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

On Fri, 20 Sep 2024 09:46:48 +0530, Venkatesh Yadav Abbarapu wrote:
> Enable UFS DWC controller driver support and add AMD UFS
> platform driver support.
> 
> NOTE: These changes are rebased on top of this series
> [PATCH 00/13] ufs: enhancements to support Qualcomm UFS controllers
> 
> Changes in v2:
> - Removed the ufshcd_vops_phy_initialization function.
> - Removed the ufshcd_set_link_active function.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[1/3] ufs: add support for DesignWare Controller
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/4b0ea24b42012b7c046ef253cc3eeee248da5358
[2/3] ufs: ufs-amd-versal2: Add support for AMD UFS controller
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/b5ac5f03072027cf1abf2ce28667c4f7348ddb0e
[3/3] configs: versal2: Add support for AMD UFS platform driver
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/d3c32f2c76d690814c59ee98c67e6c5e92fca3e4

-- 
Neil

