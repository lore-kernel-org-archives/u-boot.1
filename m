Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DFBC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 10:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA2AF86F1E;
	Tue, 19 Dec 2023 11:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f2t0kfD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7195C86F34; Tue, 19 Dec 2023 11:25:44 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30B0786D2E
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e3295978aso3322597e87.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 02:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702981541; x=1703586341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTmpIQ5uJ55fmw5WguGxSd/4pQH7vc/z7/S3eLSI5ew=;
 b=f2t0kfD2QmdYsed/CmLAJF+C+LjS9hcyoIxVZBmNa5Jokta0yTFOjqX7YvaPuv7NR4
 Jsb5y/HTbTYga4/23ZYzP/w8k0N9V7eD+0UVX2Gbs4DTTCm6umZt38Acn5lsGFYpTgLF
 tjQt7MkZr8Ry1GBk4+bSA4q3WMUPH508hMJ7I7igZ3S2qp32LRuUjEansjLNPI3KsXi8
 acQwmXQ2Xy5EaDDoweXY9DsasVYlfdkgj0ztkdni1GSFe2ELFjEQ/WwLV7ALkvem3+QJ
 x1rcZ2Gl7HzxCyGXqZdb4C8ywEMhdL2AKj/2pKy0neBgLC2R2FmFSczkHuEK+lYdMqnN
 iavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702981541; x=1703586341;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cTmpIQ5uJ55fmw5WguGxSd/4pQH7vc/z7/S3eLSI5ew=;
 b=U+Rq9oWflVeIvdzeQjProrcwm/JzbaSaXvExT8IrlAgGJ9pjVb3kK13IKeGVl503fl
 Ztma3p+Fhco8Mu4TeWawtyPZxShVGRxuDXFFgpkDqcBqhgV9L5Yx2CSsylza1RYDNHy4
 ozsPjEydyCkuDjS3d6n4YsQiqEX9hwfBBNoRhKhulhVzkpJkHfUgdAYiWo33C5Cc40L+
 WEdhmQa9Z9tWhYqoergX38zFHk8a7VXx3UaeL0YEyddEA3h7Vrb6ED3XNvaX/2zuUAUf
 hacZr7z3+hio4Ps/wz1vC5rJn7wH0wJ7KPCFihiGx9KJWvdp0OJdIR6PPG3ZYgtXINkx
 uy1g==
X-Gm-Message-State: AOJu0YxE1gNK6CvKaahfpXtrxthM8m1oSJOxCTlZLS2a0zVvDulVRK1g
 /EmzHjxpf2lSeLVldcJ5GUpZrMhmPWeQeD+YajStrRe3
X-Google-Smtp-Source: AGHT+IGABhC7+tEvq0ldBvb+lw2+hWyyqprYxpLVUmJNqMV+Ssudq1GnQUzoIqEisREV/cB0mRtFdg==
X-Received: by 2002:a05:6512:60e:b0:50e:4abe:1458 with SMTP id
 b14-20020a056512060e00b0050e4abe1458mr210228lfe.58.1702981541424; 
 Tue, 19 Dec 2023 02:25:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a5d44c6000000b00336641feb02sm6601552wrr.19.2023.12.19.02.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 02:25:40 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
In-Reply-To: <20231213-u-boot-gxl-mdio-mux-v2-0-c56bb02a75ea@linaro.org>
References: <20231213-u-boot-gxl-mdio-mux-v2-0-c56bb02a75ea@linaro.org>
Subject: Re: [PATCH v2 0/2] ARM: meson: introduce GXL MDIO mux driver and
 switch to Linux v6.4 DT
Message-Id: <170298154059.2696754.2520395230867810319.b4-ty@linaro.org>
Date: Tue, 19 Dec 2023 11:25:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 13 Dec 2023 10:30:11 +0100, Neil Armstrong wrote:
> Linux v6.4 uses a new MDIO mux driver for GXL boards, let's port the driver
> to U-Boot and sync the GXBB/GXL/GXM DT to make use of this driver.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/2] net: Add Amlogic GXL MDIO Mux driver
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/b4534ddefff07a083c84c11d944460ed528df435
[2/2] ARM: dts: sync Amlogic GX DT to Linux v6.4
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4d4fbf04158a5b2d4fff5a35ea0a2d6c18d250cb

-- 
Neil

