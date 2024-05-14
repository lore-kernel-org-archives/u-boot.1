Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21F8C25B75
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 14:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1770E88262;
	Tue, 14 May 2024 16:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jum4dcC2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFBC888262; Tue, 14 May 2024 16:12:31 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D2118829B
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 16:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34db9a38755so5413660f8f.1
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715695949; x=1716300749; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcPxZCmisqpi3KPhN9IyAijedk8NM7rns+/JuJm/m5Y=;
 b=Jum4dcC2LiL7R89VuzWFZSWDezI8pkG/i8EzfxVv+HWiZ5oYEgOlLEDuC9Xhl3dufP
 7QroSmnZvG19hJzMDkkbCDsgMFYvCz41tkrqG1gKMXAqlYqo5+Rkf1rWAMnLrJ6oPgsD
 fbLn5NWF5BH/TdBQbk4M2fnTlVi4i3v0DtCrzzu6dcCcTOoif3+zsG8AFROPPv5o/2IZ
 GWlIftqtRnNJ36FB4l+mz6adhHdh4y0neTCDBM/BdbfamflwSbVrjgaPRPdT+kqKgaCL
 VsDRCDPG+a+utHZRTyAg6Z0CpxIdjFwaQJWwyICHEhf/007k71pwEGMmk+I3cw4m+m0I
 nRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715695949; x=1716300749;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IcPxZCmisqpi3KPhN9IyAijedk8NM7rns+/JuJm/m5Y=;
 b=JlPjE2OsnI8fZxncVRrteLVJS/+fQ5kKivRJdZ3uQ+4rDvB6p3GUBW9CTHWXYshSOR
 Rx94jTp76LwD3VeTACEQryiXsJiHNVP+bpjJ+hT/UAf5c6Gtz4V+OgS/RADz3rZabQCX
 IJffEIn18dXDJ+m6+3HDhAmBZUEVtWh3CQ0zT7ujWIGvFXNYVSmG1e06OEIrEQP5gI+t
 3ItrbU3doPTmWXLG6CQskv3lERmuiIkb8AJ/S4yyub31oMyFdz5zgm5UYmb3k0Ba0bk6
 CMwhtn2eOimC6RQye4gtiucL10uSrr2yaiRb97/ol3jV/F2F4C+FHsY1mTu1qov5zay2
 Xmdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCRNbxXxeVmWjVYr14nAA9jd+bWFD9YA/DkmJ3cvHk1Uha83xu2M7l71EYpdBbDKBoBD9+EQbWxmx5oUMAXw8VQdBlpw==
X-Gm-Message-State: AOJu0YwUzgyIby4JD8VSFdn0TIlH9u0jyhQT1GBYtGBwcpUXEHMrK8lk
 IW8MQNKfsrNZGpw8nX5RrpwbLBwEFpBKOGdCPaM4UdM8yRb+w3rF2PpbhisQ4OQ=
X-Google-Smtp-Source: AGHT+IFhiqgFIJ38BlMN5Lz+etMjRqea0Nz6jKrf54XcRoOnPlA0tOqfFx+/dXj83swo1dYnfOi5tg==
X-Received: by 2002:a5d:4050:0:b0:34f:3293:83d9 with SMTP id
 ffacd0b85a97d-3504aa6321fmr11619564f8f.57.1715695949024; 
 Tue, 14 May 2024 07:12:29 -0700 (PDT)
Received: from [10.91.1.187] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896ad0sm13678670f8f.47.2024.05.14.07.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 07:12:28 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@linaro.org, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Robert Marko <robert.marko@sartura.hr>
Cc: j.beck@linefinity.com
In-Reply-To: <20240514101524.23607-1-robert.marko@sartura.hr>
References: <20240514101524.23607-1-robert.marko@sartura.hr>
Subject: Re: [PATCH v3] sysreset: add Qualcomm PSHOLD reset driver
Message-Id: <171569594806.3780346.6566964171831761989.b4-ty@linaro.org>
Date: Tue, 14 May 2024 16:12:28 +0200
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


On Tue, 14 May 2024 12:15:02 +0200, Robert Marko wrote:
> Number of Qualcomm ARMv7 SoC-s did not use PSCI but rather used PSHOLD
> (Qualcomm Power Supply Hold Reset) bit to trigger reset or poweroff.
> 
> Qualcomm IPQ40XX is one of them, so provide a simple sysreset driver based
> on the upstream Linux one, it is DT compatible as well.
> 
> 
> [...]

Applied, thanks!

[1/1] sysreset: add Qualcomm PSHOLD reset driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/93738072fea1

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

