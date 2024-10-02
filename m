Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2278CCF6D2C
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 14:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CAE189118;
	Wed,  2 Oct 2024 16:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tNVGs2j1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 137E4890DF; Wed,  2 Oct 2024 16:52:48 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 608B4890E4
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 16:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so83779795e9.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727880765; x=1728485565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVTG/w/LCHb0xj59Kw3I1wzb1uh7WchSfwmGZNWfrPg=;
 b=tNVGs2j19K3ueVZAq+5zG7Fz6KU2MPSAPeG0VOOFHn9jF0Nip5zKjaah2fAZwix99b
 Ptrnvl9cYeMnq6ZAVqP5PaFJ3MeKhlViIU34MqAJAaOzimd6Ip0yVGQUNfC4DIogXREc
 9ZfjtLN4/Q1ZzmCZhIOC6xxaXt8Xck87+NOSFAhMTTC9PPXW07FYkfTa/kFoeekEYKPD
 K2as3zmoIlayua0rHWBER2SwYEfjpFdK3I/+niP8hikWCsDnYswTtzijl58NOxGCeGcE
 T8M9u0HtCw4JnO02c/kmQ3vmQ5qNf8fU1PWluzLivnuRl8A2H3xFSfJG8xPtaT8VmEzK
 lyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727880765; x=1728485565;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vVTG/w/LCHb0xj59Kw3I1wzb1uh7WchSfwmGZNWfrPg=;
 b=h/LML6/EpGdJOPzFVBJQMHNQFhnhRyHPbJynnKvi4GynF9e9B70gkm4Pb1Ps9u289G
 mEx82OVjiOuRfbpSUxSs1HORrimrAktDl+vxz5Z2c6PyoH9eWtjCzHuQfGlCzC31SlrK
 b3EPLJdobWSv16HdNe5le8ToTG/W0KlvoDys6bYRTQPleGD6RE9k42QB4UxGd00rnQdi
 PlySzttfa/nEB7JFa1rocFrCqvCTB1AyBNdrrB8xaQLXH0tbWoX7uDGC/LU88mTkTt1v
 SZb5tRRvTaqa+e/8bTPCPD7rfvA9iitk/ig97/3p91H996CdHomloqybGBR5eH2z3JX+
 YVEQ==
X-Gm-Message-State: AOJu0YyZETUJ+e5b8pG6cKZyFfGBF5gMwGHMM3ZAR0yKnh9X7dnECr0w
 uH8t/ThNPl2lQQ+KRHFXNxkmD2chXvaiajPu5O19Z3qrmvoatn2jqYbYjvNFB0FRfQpxFVaBBri
 L
X-Google-Smtp-Source: AGHT+IFE0/HBoljoppMXxFcB4MbcjGOqNVFR5ohP364y02rjlvMlxln1gRbw2AWOSZ7wRoTqNF70mA==
X-Received: by 2002:a05:6000:1865:b0:37c:d57d:71d2 with SMTP id
 ffacd0b85a97d-37cfba19c25mr2878181f8f.56.1727880764796; 
 Wed, 02 Oct 2024 07:52:44 -0700 (PDT)
Received: from [192.168.195.50] ([95.90.247.28])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c297be12sm889785666b.179.2024.10.02.07.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:52:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
In-Reply-To: <20240910-topic-ufs-qcom-phy-v1-0-21ff4b87b962@linaro.org>
References: <20240910-topic-ufs-qcom-phy-v1-0-21ff4b87b962@linaro.org>
Subject: Re: [PATCH 0/2] phy: qcom: add QMP UFS PHY support
Message-Id: <172788076386.935801.311461201393078011.b4-ty@linaro.org>
Date: Wed, 02 Oct 2024 16:52:43 +0200
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


On Tue, 10 Sep 2024 11:11:56 +0200, neil.armstrong@linaro.org wrote:
> This serie imports the QMP UFS PHY headers then adds
> the QMP PHY driver in order to support enabling the UFS
> PHY on the SDM845, SM8250, SM8550 and SM8650 platforms.
> 
> 

Applied, thanks!

[1/2] phy: qcom: Import QMP phy related header files from Linux
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/194fface1c3c
[2/2] phy: qcom: Add QMP UFS PHY driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/6701a21561ef

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

