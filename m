Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F401BCCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 12:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3162B838AB;
	Thu, 30 Oct 2025 13:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R6QGGiby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64CE0838DD; Thu, 30 Oct 2025 13:16:38 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DEA0836D1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 13:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b6d2f5c0e8eso208342466b.3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761826595; x=1762431395; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/qnKRC6bccYGX6afRGxviNZ6mCcGUb/9/oNo0IO92JA=;
 b=R6QGGibyLUJ8qrnheZwfPSp6sucvmt8PB4/uhJzu+JiCvZQyyPGPa3h5fXoOF219cr
 nA3SikrnEl4ovQ355gxLpmWiZ3vzkYiDqRG+B3z7ly7vPkdSuGbf90DUaUMDCwLVu01y
 m/6P6cdvZz8nkDpjrlAdA33QYg3jhrRMNxMZa2I/l/TpB8nfLM/HJWOb4AOli2DkF31W
 dy9ALJgo9QJLyLY+xIUiXcwPVBqigTuCJXVgWwC1xtco+mxvMkKneleNoP6MnPsWGEBH
 /KvExxNduCXGka5/msbfjwUxHeQVgPUySPpbRzD2+B4MMTh71ObbRrAr/q99rwfmluKU
 SGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761826595; x=1762431395;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/qnKRC6bccYGX6afRGxviNZ6mCcGUb/9/oNo0IO92JA=;
 b=A9YOF5hAAzcVMycn1NiBDA3LfLYVh64appgoH9DcjBAOPon6M99rmY9iir18/cD0VK
 jOIlVK61i/IBA+ESpvjNInnH3A9b2g0D2fi6DtrY937gdXcbtiDdBX4jt8S2YKqt6dp0
 BpFXVT7ADlpw/WTJQIJyOI4x0o8EXu82GEe7UmWDKLwZ8jX4CuUEu7XkY+PcvSOcAkJo
 bBGDJmQLK/r3ODZh5eq87lnGgboXt+2Nqyp5JUyNLCzOYReQxCG3RPQzVYzlSxpn5rl7
 sUuzhYbN4CfA8GRk4FI1/sxrBChjmj/qge0aZYIwaTQ2bobBsh0aYTNkxCt2/+URUmH1
 voiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfXTtNoAjzuyojSa1Ez5YHHJY8gRR+5GKPW9iPnAcsLHghTXrrbsZDBQbURnUUuNEXjvUIDGI=@lists.denx.de
X-Gm-Message-State: AOJu0YzzR9Cp/r0rdlXFhYTTFD5tiqQjY23+nWOtAl1KfOq3C6O9cY0c
 xbtmUQlFxvItXpoxUr/NglyKiJhkeo2Zf1umeAZIP2/IEf6KGW7lED8qGJBzXzdrlJtF0j6uFt8
 pVmSlBto=
X-Gm-Gg: ASbGncvNgd9TvGnd9Nl7fjo/oxxgHZvSHuwaUks0Ivzz0XMM3qtNsWNkkgCujktGxAd
 LVF1TnOI/GAXDu4jaVntsaPZaKIoGhQLW6IulvrgATYfCEqTXrL45XfKF+GajfWMKZqPxQ4+bvt
 JWDyDKBlFTyyPWcsl/sKZYXgHOwq2+NOapkxD+ee9liGqPgqiSjwv3pLQOADmO+0HDgS1QcqdGs
 n48roso/y5I1kWvSmTShHdxTQ5rbuwjb0Db/jEVpsSV5Wm243vVCcMnlrmidsQf6b+4Gjaodc21
 6ugsbBa/ehdgfISzCVRf6NP4PiVXFVZsa3XeNc8DjxWq/O/YYWrmsz2rZU3JTYB4FX1H23YvhmG
 gaCS0+0exR5cpQzlgiFrABEyEMej7eZ30h3pGwleYO1kuzCwmOTGMxoBR+KKRXVJ5A4ZXBj2ct2
 aAg6NLOBeLL0OOW3jDDt2AunyJ54sKdHnF1eCpK9hooXm0Z3H+ORxkJJk=
X-Google-Smtp-Source: AGHT+IGa8oOTVydccO5sTp0BgWRCA9ptcihVglkUCW0qac+C0+mGUi+53l2HVi3y8zs9z43Ngjga9A==
X-Received: by 2002:a17:907:7f0a:b0:b3f:f822:2d9b with SMTP id
 a640c23a62f3a-b703d2e21d4mr674996866b.9.1761826595288; 
 Thu, 30 Oct 2025 05:16:35 -0700 (PDT)
Received: from lion.localdomain (p5b29e67b.dip0.t-ipconnect.de.
 [91.41.230.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8548eda6sm1710123266b.75.2025.10.30.05.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 05:16:33 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Paul Sajna <sajattack@postmarketos.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250923-qcom_config_enable_cmd_wdt-v1-1-70cccf9f01e3@postmarketos.org>
References: <20250923-qcom_config_enable_cmd_wdt-v1-1-70cccf9f01e3@postmarketos.org>
Subject: Re: [PATCH] qcom_defconfig: enable watchdog command
Message-Id: <176182659356.4111945.16700495273849134216.b4-ty@linaro.org>
Date: Thu, 30 Oct 2025 13:16:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-52d38
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


On Tue, 23 Sep 2025 19:05:19 -0700, Paul Sajna wrote:
> CONFIG_WDT and CONFIG_WDT_QCOM were previously added in
> https://source.denx.de/u-boot/u-boot/-/commit/530764de9fc8539cd2354501e9c42804bc4c4dac
> 
> U-Boot and Linux pet the watchdog by default,
> but it's helpful to also have the command to control the watchdog,
> (CONFIG_CMD_WDT)
> so it can be manually disabled by the user, for example, if the kernel
> is expected to stall during debugging with kgdb.
> 
> [...]

Applied, thanks!

[1/1] qcom_defconfig: enable watchdog command
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/1cab8d1e22d9

Best regards,
-- 
// Caleb (they/them)


