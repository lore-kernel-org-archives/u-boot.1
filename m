Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F5DC021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 13:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BC4C81026;
	Wed, 26 Feb 2025 14:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r7uwhvdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F7880FD1; Wed, 26 Feb 2025 14:49:23 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD65805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38f488f3161so3786794f8f.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 05:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740577733; x=1741182533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrwsET/wq0cC5ZtqvC5ykelxTIv/q/YIf18m/cLJKPA=;
 b=r7uwhvdyRfSo42APn7jXRa6OT4EhYDX83QfPyDcfe47ld0F+U8amNExE6cuEfATFuB
 ecZ1hb9uC/BTnMPdXwd+DFgR/xcDXW+eGtAhRwzmOhA9/do+mEqi0itBjZ68Tua774aS
 mpr63nErNAWoW8je5u6XDYECiLLCYddTsoXLWdznrSCXcwrkckGCGrknDUgJKYaybRlP
 V1/raR2SVtNZ6XfwDBYf6Ww8KyAVnjzK+ejsOW8CF8sZimTbYKS3ANSBAUbH5/QLkh4D
 bbsYKmSi8ohE2RW0U/7QxLJKWhnC9UkPoQ3jSi0mlLEqOUG8XS3FKKOujKhaQ17Xzq/6
 G9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740577733; x=1741182533;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jrwsET/wq0cC5ZtqvC5ykelxTIv/q/YIf18m/cLJKPA=;
 b=scbDfnsgGmupP+jTIIL/CrZys0ZGhp5DUwdwstvxL7e1UgKXyj+i1vloj2Gcl/x69d
 S20QePmSolrWu7YySdgKDngmnMtJ/x6kdt8w5Czerzow4ojYH+ACLQimwMglP4Nj/jse
 sxA4ewPjMmD0KtwaKJ3pQNOm2CmVitjzx7ZZygItEizWeYuYmoSkUzpfIpA95QprNG7L
 XXHZ6AoA3RnTKr4i9N8n+f/1ec4yCxMLJ+QK1C7SRJp8W6jVo3Y6OtygR/EGLVLwZf0v
 1351DG6vIiNXFJxYSBSW0oAwcqE6jFMhyaauUhXOPJs4ADfxxtKhcBZ0jU0mlKUM7wD+
 h7WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1vdXPFttCaSB9J1HdyG1LDiouh60bBKfdCYZfAnCsBkEmPN1ngLrPLcLFw2CAOGmJYtHf1lc=@lists.denx.de
X-Gm-Message-State: AOJu0YxB3BQbKMGVZppANclt/46lle7CJJ6YyRWDR08h/59EUSSky8Zp
 iv8UeeSikGGKpX2+0ZJk8ojSooD75hYtnCRL8U2G5rJlj0unYoaB7NsubFbO3Fk=
X-Gm-Gg: ASbGncszNN8N0cBjlHxiVfJQP3tFpW0P6TBez7vfDYDnfb5ARcnwhNQEkOYBuhFmAj9
 cKgHtQk/pr63g4/sSVaxLbgLq2dZ5UFCi7aCFhSSTGs061rIw6r9i9PPuFDjUiKQPlFlqjYFdGI
 yfGm954MU8tsbDAh8x6CRpHZUhiEk+PhKnDIs9fHtflhxdTgFaUB2ZzWo2uIw8Aolac1Om9s3vP
 FLdo9mBfFnXnKJkp9kH/xihY0BjiumNdM0RnsHvAdhb9WARnhXrxwWJMFnuS0HzV9fyM2HXnhAc
 sBeORRTyD2n8vKLgnwxolVAIsr3O/1nzGrvlo/IS6FU4P5qnUdS22j4yQHyb4A==
X-Google-Smtp-Source: AGHT+IHRXYPl6cc0I/EYxJLXr52WRrOFIVCMndnEcpf87ztpX6CXEt7RaLbq1US0iWTEHKs5ehI12A==
X-Received: by 2002:a05:6000:1541:b0:38d:d767:364 with SMTP id
 ffacd0b85a97d-38f70789915mr16292497f8f.13.1740577732913; 
 Wed, 26 Feb 2025 05:48:52 -0800 (PST)
Received: from toyger.caleb.rex.connolly.tech
 ([2a0a:ef40:1d11:ab01:3b78:3dbb:221d:d3e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba539450sm22106625e9.21.2025.02.26.05.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 05:48:52 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20250210-b4-rb5-sdcard-v1-0-3c34a8bee77b@linaro.org>
References: <20250210-b4-rb5-sdcard-v1-0-3c34a8bee77b@linaro.org>
Subject: Re: [PATCH 0/2] Qualcomm: fix sdcard support on SM8250
Message-Id: <174057773181.26167.10862544284841622443.b4-ty@linaro.org>
Date: Wed, 26 Feb 2025 13:48:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Mon, 10 Feb 2025 16:30:22 +0000, Caleb Connolly wrote:
> Enable the missing regulators and fix pinctrl so that the sdcard works
> on the RB5 board and presumably other devices.
> 
> This depends on the clk-stub patches since the MMC block itself
> references the rpmh vote-clock which we intend to stub.
> 

Applied, thanks!

[1/2] power: regulator: add additional supported LDOs for pm8150l
      commit: e57b72abb71b267d9b7b61181dc2ce902b47f425
[2/2] pinctrl: qcom: sm8250: fix pin count
      commit: 554562f7b50d780eea64763d444b6ddd2c216072

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

