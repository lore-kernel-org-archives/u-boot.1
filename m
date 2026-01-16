Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D5EC982E8
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E50C7839AC;
	Fri, 16 Jan 2026 19:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yraP05ab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0BB0836AC; Fri, 16 Jan 2026 19:03:40 +0100 (CET)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FF6B839AC
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-b8768225837so318819366b.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586617; x=1769191417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5mUfQGqIaxfDC8WHuOExOCsFzUM7xLm9qfdqJCqli/Y=;
 b=yraP05abqR3driNW2qhFEvexXwOFuZBnGWwdEQGQIwkaI8LxGwzpGu2Up/+knI5JLW
 Hwn8nlnsT4JFgEdexKucJZvCco+QoryzZfEMy67N6vLerUJ08mPfRcO2y3SNI0rB5c0o
 vywOJkHECnpafxRmbbq02ISQMfh02eTzcLGka8vwfXYPESqeKvZKBnoiLB9oLt3XKW93
 sZ7FzsB3MTS7LA2GBS5FxyUP14Xra13U+rAE1k5mObw+XJtaOKKS2QqiE80z3CsthGfZ
 8vM+Gggha1o3KQBxqTrjJ13z0TmV1ndQv6au5YHPi2Jk1YXGtTrimP99vBQuYzQT/5ex
 Ps8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586617; x=1769191417;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5mUfQGqIaxfDC8WHuOExOCsFzUM7xLm9qfdqJCqli/Y=;
 b=mmOClECaat1oF/uqPTYUWDVUcAx/WwVRY3E5C5ToZaDik8VEwyWHWLumvw8AZJ+9tL
 K0q+xbJHR57oENaMZ2i/LN3n2Z4ZH/82vbTb3eXaIOlPmyAs1+StWaar2BsfvnP5Zoxy
 od7eQn/LTPo6DtdRilBwXuVQk4PrAumM5Jxy+/vOXhRx/WGiYEd4BA+AFG9+s6vt8y3m
 gu9L92KtSqC8LacTe5rwvP26FOO1SmU96j0SPJUYK6XWQpt5lLNZj6UI6LhyoY8rxo+Y
 8yEOqwBeoeWALlUG5bmRCxXk9lX+fDGJuYsTRJkUhQFhXhjfXrG1+scKPir0cuWqmxUJ
 f5cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVewLllgVSCofxt2y1OqwTv1dYiBGIpS3GiEtb7O37tM2CPsg4807dde+mcpxp2oE+JgO4vIFQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxWk5hQd5NjCSC+SwB8vokVxa+upv9N/meTB4MNXJcqYNDHQklK
 TRD4XWkpH8jE/riToisF1dz6E0bp/hIOd48lEe7WhaRh4oTYbe8NBLRkLJm3mbufOzk=
X-Gm-Gg: AY/fxX4ZCeoSZg6sFH/lwkBdcTwYnKUez7CD2fPSG4uXhRdWIE8ly2HBjAziKkBpeyC
 c4Jmli/YrVvy/1rIxtZ8c6EYCGBXeIFzWfsueUjnpu8Mn/KEn6tYLlWv5ZJZxjdxojngIPzxwR3
 wIBc9C31MQWX8Z05gkKGJp0ZQWi+7FaaaueStHIVLNybHkro/biYtJNLK0pExfRApYPFpllHX1w
 mv1h7waNovLYqHbV+qZJ5TgOA2VsB17Szpg8n+JXz6LGWqaUZE5GbOMTXiPgNUm45pgjm+DEEBu
 m7j10mZfxORpIEY4wlhctMZmP0J9PJS45WU8NlmTs3Vm+pT4yw2HGNc3DcaGeS4QhFjb/JWZK9T
 RR+kCnW7NlKfgFBYujvvwFYT+f9160xSGk/GRR4pQKV3+81IoDTorCN2ffhgoLyfF26/O9vL5Lq
 8Xz1BIBgH880ysTJomZGDpqdFvtFrpoOtu8WsYZYxOo+HQEYKSJQgzgA==
X-Received: by 2002:a17:906:9fca:b0:b86:eda4:f780 with SMTP id
 a640c23a62f3a-b8792dcac93mr311708466b.18.1768586616748; 
 Fri, 16 Jan 2026 10:03:36 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:35 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: lukma@denx.de, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 trini@konsulko.com, quic_varada@quicinc.com, 
 swathi.tamilselvan@oss.qualcomm.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260113042213.3107106-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260113042213.3107106-1-balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v1] clk: qcom: sa8775p: Add QUP serial engine clock support
Message-Id: <176858661530.3399278.8187703518208274904.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:35 +0100
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


On Tue, 13 Jan 2026 09:52:13 +0530, Balaji Selvanathan wrote:
> Add clock gate definitions and entries for QUP (Qualcomm Universal
> Peripheral) serial engine clocks across all four wrappers on SA8775P.
> This enables proper clock management for I2C, SPI, and UART
> peripherals connected to the QUP blocks.
> 
> This resolves the "unknown clock ID 133" error for UART10 and
> provides complete QUP clock infrastructure for the platform.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: sa8775p: Add QUP serial engine clock support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/3422e915aca5

Best regards,
-- 
// Casey (she/they)


