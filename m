Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA651C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 105CC885AF;
	Tue, 23 Apr 2024 13:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fh/rNBxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115D5885A1; Tue, 23 Apr 2024 13:43:23 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 226E188399
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34b029296f5so2231872f8f.2
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713872600; x=1714477400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvCdZqc8Q4C0dP3gvaNhjwJfOwecUgYko3qpW2lc2lg=;
 b=fh/rNBxf5R0O/QuLX0wEdVeW83WmtR9L1Cj21Q0XSe2WdiFNa2Hva+aRO6+SDEHXSy
 wRaKo/YbTM+7M6EjGbF5pN8idTBIQqgBLnMgvwfqJ8qhhG1/KV79ycORDX/dDAsqATET
 S2KFvs/Dqe1PGhsAL5NHA9863piQp7uQKPBfJrOH8tvV2lRj7FaFwdgIJYelmykw3UqE
 79XhvIRhMI1FKxPE1xa4Z3KnDVhRkQYxBpvGL3Ad+12Zi8Zu+9sfmtILhmR3Hwsq0GIu
 JHE4CmVIpn5CUiKR2vcJK7apzXjVIIzUM8VP5vYl6qlJWRHnqEbN1rOaWaIDymAEqrJv
 FeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713872600; x=1714477400;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvCdZqc8Q4C0dP3gvaNhjwJfOwecUgYko3qpW2lc2lg=;
 b=FrWqj8xD6hcr6qngHbCaSXBOIc6ofVCJIWim9hemlPvVGAmeeSrjMGyciGUh0GIzid
 3Y12yAbwHjOw5TMA4Qv03+Unjj8+8LiMHJoYKFqAIwSuNVvZKdqy0HhWsSvusdCIIQMx
 zCdU1CUyPfZVsy4ZE/IXQUCYls4QD9aUfJ5wyx8LGOeUCXEnrCn5XJZ8yOitibBWgGCM
 FpAYaVe3W4LGaxtpl//kktUbrMDnQxKlN60eWnhBuruaZBKlzjdHJOVKESddq4TZqL0s
 vK/dKNsd8G+TfQXqrvFBnuDXgKCR7QtXD4mlk1Zd3C51Qbi37fr226cqJaysKTHWENOt
 MhBQ==
X-Gm-Message-State: AOJu0YyhC3SCdgBeH/PBINBVr2xAMife+z1IK1QFtuT15rgNVr58EPzK
 Vjuup7zyHhS3tlEuAFF5T2xGaMHg66BcVGwgv2aVraQ2Vf/gW09BsuSj9LDTMMg=
X-Google-Smtp-Source: AGHT+IHKD1Bl5HrgNlTi0LH+csBlUEdY4qAeHIt7zdJ7Rfj5E8YAQzDSMZhrTFzYAlEtoaKnhXeCmA==
X-Received: by 2002:adf:ebc9:0:b0:344:12c:a0be with SMTP id
 v9-20020adfebc9000000b00344012ca0bemr11074914wrn.40.1713872600708; 
 Tue, 23 Apr 2024 04:43:20 -0700 (PDT)
Received: from [192.168.0.114] ([2a02:8109:aa0d:be00::1795])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170906164400b00a55967a9038sm4507528ejd.95.2024.04.23.04.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 04:43:20 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, stephan@gerhold.net
In-Reply-To: <20240411123726.356173-1-sumit.garg@linaro.org>
References: <20240411123726.356173-1-sumit.garg@linaro.org>
Subject: Re: [PATCH v2] mach-snapdragon: Allow other board vendors apart
 from Qcom
Message-Id: <171387259999.2280908.9523434212373490554.b4-ty@linaro.org>
Date: Tue, 23 Apr 2024 13:43:19 +0200
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


On Thu, 11 Apr 2024 18:07:26 +0530, Sumit Garg wrote:
> Qcom SoCs derived boards can come from various OEMs/ODMs and not just
> Qcom itself. So allow CONFIG_SYS_VENDOR to be set correctly
> corressponding to the actual board vendor.
> 
> 

Applied, thanks!

[1/1] mach-snapdragon: Allow other board vendors apart from Qcom
      commit: b01c8a8ea420a422bbb0550f7dff8ec5a2a03979

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

