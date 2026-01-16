Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1883FC982E1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A2F683015;
	Fri, 16 Jan 2026 19:03:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="alVkqMNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3235283015; Fri, 16 Jan 2026 19:03:15 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 485DF82BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-655af782859so1864406a12.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586589; x=1769191389; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUrGU50FhIaqXhmgQ/y7vMIVtsmRo2RqKpQF4YS8A+s=;
 b=alVkqMNB9koExSd9atTsvGab2nfaRyn25Y4nBkxl5e85JfGraOQTMYrxP1GuQrb5eT
 r8qStxJv5svIueXk9Zsjfy0OU09dzsKK47QjIGXkuxtjLN2GfnCkUmPEB+cIq4llZGvx
 PMsBJp+Pp4GGqs9aUeAiVAKo4ahr3jjsAmAyzwwvOdtoWkiotK8cjuGLg2GeUwBgfWdM
 OxM8AHGIgH0e2tOaanCEFRAUJr626O8Nd8isIXSdKYvM5bMcsawl9lbzl/TW5jCgxk7B
 xa+BEcH5TBxIePEeTGJG/jish69Qpxtjvz8sLgwDYmyzrJDpdYygapyVndIhMGBFw3wf
 ZkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586589; x=1769191389;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tUrGU50FhIaqXhmgQ/y7vMIVtsmRo2RqKpQF4YS8A+s=;
 b=ENeEEvid0no8VQxVDkGzEt2bc2zI/ev3e++D6Pls8APBAYpqME7Qt22z3nGMPUIUbZ
 So6dqkFjU2c4oMR5xj4ukwmkPKTorErexzTO3bLE+VLFjUAkHn67CAlvqF7MizSCUMM/
 wqGBhm4eJb+VjGPp8ljTnssr8IhIEA0D3gPs5IG1cfskCHil1eiqwLOV073IRG5d0Qhh
 ayN9yXn09WplEmbeLGsSZXaqET6nVaH+E/X2HbecPSMcIPJ0nwWy+pebtlkErKQZdLto
 tthq0wP6o69WeOXow4uI/Hiz5BOGbBWprTcmOtcOOV+TO6/x94uYbXX7uWSVjYWFOcP4
 hJmA==
X-Gm-Message-State: AOJu0YwmlkiWJ+D0tS8DR3T2X46AaIQt8+U5461j+3Kqb8lzThZE7I3a
 jNrI0rryu2OpBvMVRoV6QxczvNOLl/djTT/habYzLZ5FqsrNV51HdSmjw++yIwMqxZc=
X-Gm-Gg: AY/fxX6sBGL/8ni/7SS2eQcVQ2/4swWzWl9Hl+LQP/oBFfWJrjPcj0QInXEwpqemnQo
 oHSsfX6571N+/WHyFoOEdqWK86i4plaRaPByu9l87eovEDN5jehkpd2ewfaAKcacRN6o3fRxAop
 GyEGS9iv1uoD82VyzDqzytXcJSDreg4i+h3M815IAnIQkfy22lG28PTbrqQGD26MYHYDYR1yjME
 BXY88TzadwTT4v3oW0Rz0uO719221CBLb44HMPesFRkSdBhttSy2as2ZMv+SAblI2O35ujvPqh7
 v4KMun3iRQC7SqvIHuFIZhgrANlQAU5dhi1+m6iBDechU9lfbQLWawN8UIaTT2v5jn5Vn4Quae7
 T3whvxq/xQo7kavxiBclhSIFdlVhN0mW7U2lDQa+AU2IBCzX35uDq+YorXB7NpQ2M//ZUxHkUzo
 wfJWKPLmxjnMJqjEZD4dco0c5pRDQs+J9d5TQ21r23Tg590AwtcP2NRQ==
X-Received: by 2002:a05:6402:2691:b0:64d:2822:cf71 with SMTP id
 4fb4d7f45d1cf-65452bcc4edmr2787117a12.29.1768586588711; 
 Fri, 16 Jan 2026 10:03:08 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:07 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot-qcom@groups.io
In-Reply-To: <20251106-topic-snapdragron-en-pgprot-v1-1-d2b9e802230b@linaro.org>
References: <20251106-topic-snapdragron-en-pgprot-v1-1-d2b9e802230b@linaro.org>
Subject: Re: [PATCH] mach-snapdragon: enable MMU_PGPROT by default
Message-Id: <176858658742.3399278.432817862463124021.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:07 +0100
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


On Thu, 06 Nov 2025 12:01:48 +0100, Neil Armstrong wrote:
> Let's enable proper MMU page table protection to properly
> protect write-protected and non-executable sections.
> 
> 

Applied, thanks!

[1/1] mach-snapdragon: enable MMU_PGPROT by default
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5c71f81101f8

Best regards,
-- 
// Casey (she/they)


