Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A04BC982E7
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5941D839E2;
	Fri, 16 Jan 2026 19:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H/Tr8tRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F36C83B2C; Fri, 16 Jan 2026 19:03:34 +0100 (CET)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A902A839AC
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-64d1ef53cf3so3286773a12.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586611; x=1769191411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kV5rS84A+jibPQK6TQzkR9ViUjNHpdrEIRp+7Hnh0+w=;
 b=H/Tr8tRWlHI04T431Ac7NKocT7YDZcxwNj8L/YtHo5gjDEzVR2sDFVYe3coLtWYILT
 q/96kC1CD+S+OPc9Gs9m0IrmwUjCUjukdhl6HVU7vUfo+/UEgfzuEP1F39jE5axVKYrp
 P2zYIIWdXORYmM9AbezAJYGZhmaOkdHi1wLHkMzd80APveUOAnwpJXR/J7z8htGMcIvq
 YeEaBR80pETPsq4vQYmq+KKDvXl17PtkvhQ/DFUBRSRT4Q+mF1Yj8OsOJAm49OoSekes
 kHeb9MwcsMgOEJsLmoB/1RquYyDxC9e8NYrkowqPFp+SsVKSHd4mBvXv1dce52zRGX28
 E38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586611; x=1769191411;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kV5rS84A+jibPQK6TQzkR9ViUjNHpdrEIRp+7Hnh0+w=;
 b=aMBkubFJYruv77G1IgS5i4A3xrKXgQFAInwL5JD+gO2HAVHfMJMKRapjfxxOve8A0q
 CQ5x5HQs2PKipPF0wiqYfUtg2suIZrOrWLsWRTLdWKFhquVS43dK1+IFIH4lL3dKY2d7
 27YhPp3Dqc9CH5WK/Lf8S8uKyj4p4USyPYd5tFjBL87wdOZamA4zXIoPjqU3FzRi1cD5
 r1l5JgWgCZDyNJPDb8AGWF9a4fFD8XlIq0dufYopzkFUCGGRynPR121kXaliEU1i4AS+
 sDKAVGFCtAJfrssz9D1cyOAvNHlMnRhLpk2UUNaTkYdRBSkC/UfWab4OMzcjQZvYJd+u
 YVHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK//CPxhjynMN+6hKiBEUbHTNOIWAJl5bvWZsHHWWFZZWbrAbvBWWj6jRBnYU41fcBcaXbIz8=@lists.denx.de
X-Gm-Message-State: AOJu0YyyTFHJSYLZG23U3TAN/zxZgZoUcET5zpmOyppsYdKdQaIV+gsJ
 24O48XPibfDVA4wMAb09DJUu7hMgY1+a9Fnr0wjX7YQWuiQZNMoNPB6bnCTZ+6+KBeQ=
X-Gm-Gg: AY/fxX6wA6NlMpOnNZKaLA5yGNYH6p1LgaFpxSzhFUrANlY3mFcCofDw2WnlWJ8ezAY
 eVoJGfCgE0lieBkZvi7pDq0SPT+0RIDh+qRno0e1irmq0UwzmI2oo4vAFc9lr+h2jqkNHfv04Gt
 PGBO6T9Q8bzXw3rM5tGhA59g/Iywf3QaGqtg/tNqMAKTZ4FlG7GNxQaXPS4VSbUUcy3ePTAUyvz
 ijP1C9adPqlF7AluRUCVZDuArQzYlUfLK7qEEKw8GPkU14c1bWzOm9zqgzKqyhZoGWORBGD6Nh1
 oKl9bfmkfiOHbejGOg1LYJudAdYsiceR5J6mKPNyhdqD3xDsBI8CmeBjkczzGdsJqyecHAlWah0
 LQL4HlyjO6ey1eXzJRAriqV+pe5BY6bYZX5dZqbeU3kgtRy0Izoh/0CfhRJmNbL4XnebYZmJiri
 saxmhIil/0zIPn2l4oJrcT1McllBjJ6s/+IPo7QVEkpKYGvX94pQGOog==
X-Received: by 2002:a05:6402:3244:b0:655:b140:8ff5 with SMTP id
 4fb4d7f45d1cf-655b1409399mr1810453a12.3.1768586611098; 
 Fri, 16 Jan 2026 10:03:31 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:29 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>, Lukasz Majewski <lukma@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20260108195007.3156604-1-casey.connolly@linaro.org>
References: <20260108195007.3156604-1-casey.connolly@linaro.org>
Subject: Re: [PATCH] clk/qcom: sc7280: add more QUP clocks
Message-Id: <176858660957.3399278.14178733268333741995.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Thu, 08 Jan 2026 20:49:55 +0100, Casey Connolly wrote:
> Add more clocks for UART2, i2c9 and a few others. This is enough to get
> the rubikpi 3 working.
> 
> 

Applied, thanks!

[1/1] clk/qcom: sc7280: add more QUP clocks
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/142df62cb68d

Best regards,
-- 
// Casey (she/they)


