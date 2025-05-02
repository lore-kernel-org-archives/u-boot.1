Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06841C3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 12:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7275B812BC;
	Fri,  2 May 2025 14:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D8MkDPGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1429781E72; Fri,  2 May 2025 14:31:42 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B54801BE
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 14:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5f5bef591d6so3789424a12.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746189098; x=1746793898; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yQxqCw9uNLgUhAFq2UblJjgicrhUVM3OmdJSyAWOueA=;
 b=D8MkDPGBWfP1bMTIozdPm9ujt+qgttd294a99cThLFZOIYcRbGJ6k3iAFQPV3NudlZ
 UNl28b+E1se/mSDithK1I1l2JKO4R8zs9+D4EAOL6rNYteg7SgF+6HurIjpjfM6CoqxE
 HEO/wlp6is31GrVaeeiVpimYtKpVpCyS2e+qjzWVgNcQ8647uSr4306dcO7aZhEgycrQ
 us3NuvMHJquh6OQH2/lyQGhRGnCKFojnlMzAniSZ9EjgxFFNqmNN8KIUCmEXyMnxqWls
 rXdyxftK2c60VSGYvupkxXNWDujCtshOsN5vdUheIVrcy96kZcmXvFf+u5LNrOIVdyN1
 y1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746189098; x=1746793898;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yQxqCw9uNLgUhAFq2UblJjgicrhUVM3OmdJSyAWOueA=;
 b=ka1EbIG//itqJAqZ24teO+hvT85GWxVh8s0ABj+EAwntxL+Tl9GKXDF/QwJz5JpqiF
 NmxXVjaYrRXyvZ/xYeQA1UMSf48kY8hWtOGQJV5XYH01RrAgB6SA6EQwts72JWRfnr4C
 DDCFDNInRejnczxbiKOiedbZXZFsPM3jhBGrM4kAWxarGAI18eyyXGePQiKIXi4geiMZ
 NqUABTWvFC/wvh1hvJRnV7SjQlFVW796S4If2XaW6JK8da08p+XFymnyNT228fBZeGSE
 7iN4VUhdZdRM91S+EPSsBxAxBobwKlpY8eEmXnxCkqxeG2Tef87kNerx3l9KP2d38kzS
 uXFA==
X-Gm-Message-State: AOJu0YwMjEHIdzrKhqNqkm53Z8mzgQicaYVlhI57ZYwa/84eZii81ToM
 /NuM0L9RNNzS1wpo3dhNtgbR/GBFMkBrhYP4BA/UfOfUKODAGXJQ8axkgfuCdDdmrUbephnRkQO
 R
X-Gm-Gg: ASbGncu+dVN8fVtOAxbunXFYCgkM7rtRo+N4MQRBYql6NCyHsbVnAhEE+80JGuXiDIR
 QI72Qc36rr+KDlOwC0ULXJ0emh/Vh2EJzBuQ/zzsGWhLCoawWbHfm9OiqxjtXenvM+EbfIWY8gB
 a6VEtij7wCnqTYCKdyOXBq7mRe3VGmZtBfZava7/XL5CSltJIXOvYwyrwpnxDMKe2AC87woWKlc
 aSiDck7b0e3g85QMsT2VD/Q0r8TWyXbaDcgp1D1g000HnxsUYkWekjcmzHU4i6SlKYa2Wv2bhKx
 oJ4QkxXG0wUZpjmuhS+pkUdjemZjVe0i5iz0jC08n4zkJpaQ
X-Google-Smtp-Source: AGHT+IGFvyeKcyhcxcXyTLwFR/oOCGOTJ83KvmZARxi+yxF4t5sccBeEA7eiS+LKG0Fx+BeDwkV41A==
X-Received: by 2002:a17:907:3fa4:b0:ace:f787:47b1 with SMTP id
 a640c23a62f3a-ad17b5d8d2amr268960166b.25.1746189097752; 
 Fri, 02 May 2025 05:31:37 -0700 (PDT)
Received: from [192.168.0.32] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891a2bd8sm44704666b.57.2025.05.02.05.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 05:31:37 -0700 (PDT)
Message-ID: <bd68bb53-ba05-4e40-92cd-c719a05e563a@linaro.org>
Date: Fri, 2 May 2025 15:31:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] ARM: dts: sam9x60: Add watchdog DT node
To: Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
 <20250428-wdt-v4-5-bb7d1c7c051a@hifiphile.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250428-wdt-v4-5-bb7d1c7c051a@hifiphile.com>
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



On 4/28/25 12:16, Zixun LI wrote:
> Add the watchdog timer node for the sam9x60 SoC's.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
