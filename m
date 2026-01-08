Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF5AD1D48A
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5997C842DB;
	Thu,  8 Jan 2026 21:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tAiVX3RM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47900842EF; Thu,  8 Jan 2026 21:31:09 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B95D78415E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b7ffbf4284dso519692566b.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 12:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904266; x=1768509066; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xg99hiHaLOpfeuvyafhnqxWPOTSqd2xAs0egj7LjwgU=;
 b=tAiVX3RMYTXtPdBFxG0RbMNEfx2k3nYQ0gjiTmHRAJVTqi0TSbJG3ZogTi6IQ54oLl
 1jt82ykwRVWWcJckARrMU5lu82Kxq2kB8eNJjAEgzGaVHIgCCNt/cEhgUTTObcwOLzdk
 IVN+VHME1xgWXQdRcB1LQVNLK3jUiX4gfhn0L2FUpemy7zddxbnpG5yxjeF0jx0ORPmp
 Wij6E11olaaAm/P19pD3gePH/phvJkersD7km5UDBa9N9UtHQYL9Tdf1di+DeJayY/w2
 5gpJG43N6a+7mdmV6dCVd7d7qrGXzStzm226SgczY8gXv8eWER4bT0Qx0uhyLAtI8M0l
 DIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904266; x=1768509066;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xg99hiHaLOpfeuvyafhnqxWPOTSqd2xAs0egj7LjwgU=;
 b=u0Uejtz5yIp3qayWg1DcLGpXE9nnsMRFKrvaK9f+Z8JkRaPAgWQrlQMoEB07ez3v/H
 CNO3RhWR/sZ0F+7uQ4WIBsnHb7u2+2U+RbZCcjfN9TOPdZe7XZH8OmGQFtgJ0iHSGtZx
 ittVNrozTrPVZASE6nyQlnUTQx9ORF/PZAfCJeODEnUjz+RYlvRgJAO+26Vd2fe9Zo67
 RUsy2sF9+uw8rFofOJmHcpiVos/vY8A2thgLlVD014DfFWGEBW7XTRf4AtQfDhHN9i54
 T3bPmYdiuRPweKYMDqPkEc7GoPaQgX5xcHvEqcxtAb7fj7+OWjk8RyZs9R9xw+4oblyX
 6lxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQc4YqdWS5JkArjYj8/+vVWSfQc2i2tisPETYTAnkVTNuNiOwAbtj4msZ7RPjHPr7eJY5pXlU=@lists.denx.de
X-Gm-Message-State: AOJu0YyQagPSCr50yVnz5kO0HUgNw4AASQCV4nDDVl7qbrjhWLkk4ZCy
 iUagT0QkSVVe+FQi15zjHLUDrnTSFyvXjfgjpfJrkX85ebFCZs2N6oYcmGiQrDwdyed1ru5pJoL
 0ppOv
X-Gm-Gg: AY/fxX5uo5GBQmv1nEH75JR/DVqY0w19S96GgDlnYqc3nFzNN9zvj5yDxu4ZPDuoo2D
 7/eBH/sMNUcPXmMVBTKU09kQBd+rj3e+eQsp6OpbCc56RQtTPncPNncLQClX0FR15QV5v9zbU6V
 YG+FbNdJQpLPEqq1vRw8xkyMPzjyGerU5g7k4XEmWGWg1M6/RbI4MjnVax39YtUYEcfvCTuDWdE
 b4slyHbeOGSTGb5Dc6PbDFVs3IMRipi/wbjkcPz9Nzz8duXIEKU4qxxX3BMguJTw0mgskHJISTW
 hdvECpNRkoYsnV5J0dE64IBc8R1X+2ADDxxSvqDBDSLxvx7uaL9SFI4WLNirzAQSrD6KBKRVFTI
 ouc8q9VN+5jdjJ1rxjMuQgaLlNWut1+F0OOGu/EJuRLo508mhGEpxUgm/Ag/zxWXJKa6klh0fUG
 hoedUOrCGgmjrQpRNqSiyuqwxX6iEkcabk1saTtJkEfBAHIsJkuRc=
X-Google-Smtp-Source: AGHT+IGqAS92npWGLRfjJ0BUyv0AqzZg1k2lzoIOA3Y2nhxdno80Cklooj67DLhTWXUnPk6qx9fnmg==
X-Received: by 2002:a17:906:478d:b0:b73:78f3:15b3 with SMTP id
 a640c23a62f3a-b844536a598mr632705566b.47.1767904265980; 
 Thu, 08 Jan 2026 12:31:05 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4cfe6bsm885412666b.34.2026.01.08.12.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:31:05 -0800 (PST)
Message-ID: <868d749b-6f06-423b-85f0-26f57f66c9e6@linaro.org>
Date: Thu, 8 Jan 2026 21:31:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Clear RPMH TCS state before kernel boot
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 me@samcday.com, sughosh.ganu@linaro.org, gchan9527@gmail.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260108101721.3411854-1-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260108101721.3411854-1-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Balaji,

Can you give this series a try and see if that resolves the situation?
We ran into the same issue you're describing here and this (particularly
patch 1) fixed it.

https://lore.kernel.org/u-boot/20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org

Kind regards,

On 08/01/2026 11:17, Balaji Selvanathan wrote:
> Clear RPMH TCS hardware state before kernel handoff to prevent
> timeout errors during kernel RPMH driver initialization.
> 
> U-Boot RPMH operations leave TCS registers configured. This series
> clears TCS state via device removal and board_quiesce_devices.
> 
> Balaji Selvanathan (2):
>   soc: qcom: rpmh-rsc: Clear TCS state before kernel boot
>   arm: snapdragon: Add RPMH cleanup in board_quiesce_devices()
> 
>  arch/arm/mach-snapdragon/board.c |  14 +++++
>  drivers/soc/qcom/rpmh-rsc.c      | 101 +++++++++++++++++++++++++++++++
>  include/soc/qcom/rpmh.h          |   9 +++
>  3 files changed, 124 insertions(+)
> 

-- 
// Casey (she/her)

