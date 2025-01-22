Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CFDC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E5980A37;
	Wed, 22 Jan 2025 17:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E7eTtqf5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 473C980A09; Wed, 22 Jan 2025 17:12:54 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECDAF80805
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso1312585366b.0
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737562371; x=1738167171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOsl3OHLkwVRzOiZ38WqR1Ycy+m/VsSfFGiUxXf0GYk=;
 b=E7eTtqf5tUPAERgfaLKzAGPQbkwXmWJWWqWGgABP3LQ9eldTwNts2QG+4zrMigr++h
 Q8uH4mM3D8b71+qoCo26LtA9GJRKaQn+p56w81+l7GH/cxSsvzmz82uSegDHFbZ4Zg4w
 r9hG1Tn397MK+4lcZEN4EvHKGBLcmiCDQ3ipzJkRXK0HYZRmi8ea57FEz45LFN16Y/Cm
 vQp1Pb8BgpSo0pMa8/sJ4LMgwJ833dmbOH6p1lGN8p/sFfhQkFIJkVlKqkFOQUeZq9ov
 pPfcgtCcyFZq3IsdOsTMhZ5WE9+28WkADvVHVzpA48Q7R6xejTloEsD0+inWgUVuZpvA
 1y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562371; x=1738167171;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOsl3OHLkwVRzOiZ38WqR1Ycy+m/VsSfFGiUxXf0GYk=;
 b=VQB2coZqI7BZ8A7NyrFwh+vvOgQub66tQf7l2lCIk26HC/wxaG730hWSmn1CgT0IIG
 Ojiv33C+kLOjQudF5YoP1uooZH6Zo7X4GA1oUxKbNxeNsZxntbMqMChWZOJ/QGqVFKuV
 ZJvWYB/zMzHULPnNW25r+8Ejn46E3rtDEXvut5Bvc7jdsqQ5muKdr+OTMTYf7y1AInrH
 Oc2hjWy1i4dK0627pV+BzhgKRFqg6mDnz/EzAPLM+FlZrV455RwCTQwqL6HH6fsnM2zn
 DBg009CqdhlR4xds2QU7OvjAFxHlPgAi1R1/zT64vRmwWG+e80auUvgUKxJ/0IC6VTq7
 +3/Q==
X-Gm-Message-State: AOJu0Yxe9I5BiVSqpUZEApEHFUIz6FagjtKuMMrskkIm3KcqT4C7Fe5Z
 RSzCyPkv0O1pWzYD/VZGmUZhkdY/QX9CqTbpUqV+J1UTW8/iIQcEvXzXqLIpACsou3WTDIj0udK
 LsRU=
X-Gm-Gg: ASbGncv45mbNlr3YYfYK8csBc8w6UY8ICjkdRSVqEuNCTLtNbFeaKNVXzyaKJDgjQgZ
 ADH+ALlgTbmcu5MWilQA4f6cMZLgi2LfIC5fHHmrGaZV5lUMQfr1A4XSHbt7ABigXJMhffv/GMo
 FMiTwYFShxxqeHCJGDBeBHd1B6u6dTWNOAhc/C0ZHnTqjMdoN5w1mR+HkBZAKScl4z5uuB0k73b
 BCPSnz+g2nbd5hQ54a7kevbggDwzrb4omDaUTkAFWqCENpPb4XMIp7AouuumvfIP/wsSxs9usmB
 XIovhWSSiMHN
X-Google-Smtp-Source: AGHT+IHI4NrIeCFvIgjgdP6d1zFIKF8v2TXwvlz7hO66+ClSTkVGTmS9WHMuNVWDA8qDpTRmpI6YKw==
X-Received: by 2002:a17:907:72d2:b0:ab3:60eb:f8b6 with SMTP id
 a640c23a62f3a-ab38b3d67d9mr1890704566b.56.1737562371437; 
 Wed, 22 Jan 2025 08:12:51 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce105dsm924966866b.39.2025.01.22.08.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:12:50 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20241115-topic-x1e80100-pinctrl-v1-0-35f984226e47@linaro.org>
References: <20241115-topic-x1e80100-pinctrl-v1-0-35f984226e47@linaro.org>
Subject: Re: [PATCH 0/2] pinctrl: add support for X1E80100 TLMM
Message-Id: <173756237017.1864727.2976279508509084554.b4-ty@linaro.org>
Date: Wed, 22 Jan 2025 17:12:50 +0100
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


On Fri, 15 Nov 2024 16:44:14 +0100, Neil Armstrong wrote:
> Add support for TLMM in X1E80100, and enable it in qcom_defconfig
> 
> 

Applied, thanks!

[1/2] pinctrl: qcom: Add X1E80100 pinctrl driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/51a142363d42
[2/2] qcom_defconfig: enable X1E80100 pinctrl driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/8376161a03b7

Best regards,
-- 
// Caleb (they/them)


