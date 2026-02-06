Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8700FEE209F
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 13:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABFB8836D3;
	Fri,  6 Feb 2026 14:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IjsOeN7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F063083A64; Fri,  6 Feb 2026 14:46:05 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD48B8352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 14:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so6603285e9.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 05:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770385563; x=1770990363; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j9MZJkHv0n/OCJpgB6dzLYKhqY/WyuvykBeO3rJcpKQ=;
 b=IjsOeN7cgIiwi2/YhBko/iefGiL1ZfklCKJkepfl/yU/yGm/E+ef5SlyGN/Bvln1Si
 BlYy1kKPLCxBNrSUP5HCaY1OKZozK8owZRdR0BFFxUmhAeahZHmavvc+u6/uwIT0sqh3
 z/tFBdsGLAuj2Olt21I9lWS40NnOFkNULeIOlyNlsSYfluI5M8U7OnnlvYjm6qRVVWn9
 kPwYR2BlLB3CHD2/qP7T8JfHM874np4/GqLi10/41bU7Y9v1BKIQ+5N4gwWHbQJcv+Th
 qI/5eRTuAA5oaX3TdV86Xgf61ORTFMnfpMYkn6Su+p4phvm13TW0hUfK/+roOfOBR4wz
 xiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770385563; x=1770990363;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j9MZJkHv0n/OCJpgB6dzLYKhqY/WyuvykBeO3rJcpKQ=;
 b=XP4U5DZ6mjfNkOip5aHPamkUMngNCCOq3GlmREShYsypFRjjDxOCYLKMrdhHYlAnvD
 ePpmo8O52ea73olv0JeupGskBq7z8bazAD4jSufLpomvzxzfxXB6p3zA5BZLLm2cDO3y
 M34R9QupwMwAT3gmNE2lurs4x4E2l6YjzfdVCArI4bEgWH11MtL7YHGcYmPaJz/YhUJ7
 WUT1lOvdFhBi8KJoSSXIyWdmXyT2yUsD1g0OmQUCP7GeUCgUmd6i2cPBiiXk9XzYSkp1
 CAYaedqZPkm0XHRhei5ea9egqW5VM0kRHllQUpCRd6ApXz6RdclzqcqG3FdtvogpvpLj
 hTvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcDk/Ke+aM8ECu/uKr7Oia3sDjXnRUK4mHrXRV0PU2MlGpVHunTlnJ2ExogLUuVCuJQ8tDcNk=@lists.denx.de
X-Gm-Message-State: AOJu0YzQBRe00hjPtBwjmIiCWdjfaHGuNoep94CS1kJh7iDRZuUyqkfW
 sdRVInFsaDSm3PzQBBLkH0waeIpTG/egWeOC0ygJjtMjcCL6Mv4C58KqA4nQy3R6eqjPzvEsm8D
 oYobV3pA=
X-Gm-Gg: AZuq6aLlBVlIj1IQXrX0YMqWxAlp1TkccW6Vni732fxtXUy+D5h/LQZXZwijsKTbV7t
 snnDEy9NqyoGq+hqHNq/B6gtXRpnXCFqO3k5Y+Gp7CIjXOUjE+vEySvHgyCDZt+F9FEPk77QzxW
 jt+6XIFiUONvXOxO6kVdi/AzIYGbv+enA8t/58BsMpOjlIW/C23WCP27w0jOra5uB7Kg9mU7IUX
 PevsiT3yydGBHt9f1yJy0DDWo7uvHcqNtx8BQjK+OP/XDy2OIn39IKLhqBYWcNTf1zyFFYF4v31
 RF9EkQEVi65sngqQTTTlB1holr7i4CMSc7CnQQHeRbuNMsrZBjJAySYHLaDPKx22daqMMDfQ8fv
 +hQyQuYKqExG72ZHsqGPGvMm4libjSxO/6J4tb9k5Rd8ODQvi+ijCNah+UHkaH94vcQsXI3OBQ4
 aIXg4cNUG+YV9VfFPM43UWqRHcL/QG
X-Received: by 2002:a05:600c:458c:b0:477:b734:8c41 with SMTP id
 5b1f17b1804b1-483201da2e1mr42728545e9.1.1770385563137; 
 Fri, 06 Feb 2026 05:46:03 -0800 (PST)
Received: from [192.168.0.34] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483206ced0dsm48909025e9.6.2026.02.06.05.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 05:46:02 -0800 (PST)
Message-ID: <0954fa78-3666-4c2e-829a-ad78e62e0e2b@linaro.org>
Date: Fri, 6 Feb 2026 15:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: nand: raw: atmel: Access device ofnode through
 functions
To: Andy Yan <andyshrk@163.com>, ada@thorsis.com,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.denx.de
References: <20260130021745.391602-1-andyshrk@163.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20260130021745.391602-1-andyshrk@163.com>
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



On 1/30/26 04:17, Andy Yan wrote:
> According to commit 84a42ae36683 ("dm: core: Rename device node to indicate it is private")
> 
> node_ should not be aaccess outside driver model.
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>
> ---

Applied to u-boot-at91/master, thanks !
