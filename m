Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A1CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFDF88597;
	Tue, 23 Apr 2024 13:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wL+ktWv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1175A883B5; Tue, 23 Apr 2024 13:43:22 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2425883B5
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a5883518135so45333466b.3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 04:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713872598; x=1714477398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m21+fSqUvS0ctXBJxcpvoOJsevXESTKoLJy9UISknSU=;
 b=wL+ktWv8AiBeqezQFcyU3HrZtvn2mie6OZvneraoWYE8wRSJM+VDd0okewpOiFHetu
 ZpRRT5wz/tc45xvQsS0kohl7hiaqIFDUlo/I6zeSzixf6xhfcq8PcO74CK7ZnQS70RRk
 +o2/h+Un0r2Ooms63N1SttZ497kOCeDQawwEj7EIaWLO6dBc/Ylgi47j3/c1jzQ+QY2H
 3reNeq69TPWdACirez2i0sdvHqkGVx5+B39BzCqvPVIGv9xK2/8BaloSZgi6/s4gVu/+
 +ENiFWgnvBTe0lsSqMHRJYqKFd4Q1eaJxmisFkCeAqa+dLw2MtwQjrUpZhAoQMgi2l3Y
 Pntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713872598; x=1714477398;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m21+fSqUvS0ctXBJxcpvoOJsevXESTKoLJy9UISknSU=;
 b=IXMMZCmzyuNcXnJWiwPPWIuY6UQO5nS4UejFeUZMS5S5ScrxwztV/6tRIMskbd9+4d
 DIgUwiMCx1Zuu0jvA5NoqNCoktA50qHWk7b1vRz78uLXV+f+VYfxRexruyd3SObrxaPN
 xkb9iRrZU0sGuZ+hvs5rF/Dm//cR4ImK1+qriHs0UhjYHZFk/qejabfIrqJuR1FlMoDV
 xta+P1d4kX3eLK2Qtk95Mandv26TJez0FinkgsWez0J6W54U3sxxlb58CIRBdm0bWQj4
 pjdICLX+XJtt1YRsbAjdlIVBz/zKT2g7m4t0tlvjRKrHKi67WPmuhJ3tv+V6b7x5BHkk
 amwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI8Z2WMy5puvSYj6swVSu7CnShKOsdi6xhOLfswbvUFe1tFgFGuvfGuYAqhJznhpM/YK2jE6eHeUtuqxgHlrieyc4BkA==
X-Gm-Message-State: AOJu0YyNAhwQ8LcbpFXscNfbn+U3MkVyB1RIcwEpLQImMa/7PmxxLwo6
 V7RmwFQAw3OQ2L5boCq154TQwk3U4T17nUEtJQZ+NoTx15k6/A45xUGwxaKu9Zs=
X-Google-Smtp-Source: AGHT+IGBJ/Pr+s/7j/U4B/6kX+HfcsooQtrvG3Otwd/lq/qgzoYLZDTClo8zCI02NYHuS+z2t88pRQ==
X-Received: by 2002:a17:906:c784:b0:a55:41fd:a013 with SMTP id
 cw4-20020a170906c78400b00a5541fda013mr9170476ejb.23.1713872598175; 
 Tue, 23 Apr 2024 04:43:18 -0700 (PDT)
Received: from [192.168.0.114] ([2a02:8109:aa0d:be00::1795])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170906164400b00a55967a9038sm4507528ejd.95.2024.04.23.04.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 04:43:17 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-e524eb29ae86@linaro.org>
References: <20240418-b4-qcom-rbx-fixes-v1-0-e524eb29ae86@linaro.org>
Subject: Re: [PATCH 0/3] qcom: switch to OF_UPSTREAM
Message-Id: <171387259723.2280908.1259739811979011552.b4-ty@linaro.org>
Date: Tue, 23 Apr 2024 13:43:17 +0200
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


On Thu, 18 Apr 2024 18:24:08 +0100, Caleb Connolly wrote:
> This series does the initial switch to OF_UPSTREAM for Qualcomm
> platforms. The DT files we have in U-Boot are outdated by now, so drop
> them and move to upstream.
> 
> Patch 2 drops all the Qualcomm dts files that are now provided in
> dts/upstream. As some of the files exceed the 100k size limit by
> themselves I thought it would be easier to just lump them together
> rather than trying to split them up.
> 
> [...]

Applied, thanks!

[1/3] mach-snapdragon: use OF_UPSTREAM
      commit: a149974d3cf81dfc11254e3093f645bec3d5d88e
[2/3] arm: dts: drop qcom dts files
      commit: 4a30052dee8726cfa9b1f6873496389ae1732ba4
[3/3] qcom_defconfig: set SYS_INIT_SP_BSS_OFFSET
      commit: 813bc424871caf3decffb50119906bcdbf33d973

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

