Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E539AC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 445B080ADB;
	Wed, 22 Jan 2025 17:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c50tAiiV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E71B80A09; Wed, 22 Jan 2025 17:12:55 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FB83807EC
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3bbb0f09dso12321424a12.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737562373; x=1738167173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gamvAZ41xyS+ZXzP+s3mQv0magl1/3+M5onHa+L8vdE=;
 b=c50tAiiVhVUBEg+TZ5YmBjBx2YgeSJYquSbj5oTd97HGm18yOotrgaNBMBQKSSvpQb
 pzn8FLHnz5yw9ZlCORm+KGAsBijdp+Z1AUfWanelRhIOZ8qYhyAlb5+4epPPy0QMIGqb
 qtBgnwKjS1JEADPtIAcr9znqF6OUq4tiDTCrB3dXqtMqfxyMEoVJwX+kynifgbDhq3BN
 8PKHfdxSk1wKF8onqcjL+hEZV+cLeyFkZ05CFTt1+78Ja2hbJJX6rdU40TrAUhBAbbTp
 pm2TssWwKm0wAwN+P4me4OppaYLQYt5gOG21Ax0o3pNOr8/QYv3UeJ320QP7pii9Lkd5
 MLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562373; x=1738167173;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gamvAZ41xyS+ZXzP+s3mQv0magl1/3+M5onHa+L8vdE=;
 b=G5LDBCuZ3X4upxA6KVNUzx/8jBvkdTVX+bviVpadR6nYpPAFpJMZeAXJF3CGRMOnHT
 +89a9R1FzAiALBYq2iEFdjS83Z/NTtRStPn0hy2xokPQGuCJt4jhsT73di3KBFWrEjsq
 uCtzMS3Vta3orTMDJMDVuNnXEUvRg57iSQxcrpsLt1A0d4rOLuDiZgIemB6TxcqREGkv
 cDMQcUHG8d7TAEKr52r2xrTtyTYSSFJxnpEvAt9var6P3HaIOWEHBW+0fCVue5/e/K3K
 t/67/Frr5N859pSRp7XR9k4fc0GkoCfkvs8ay36w2MabUqqPRSD7m/TjMZW7S3wmKPOr
 Yf0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFezH7QgDKS8Pfu0iBYujCYOmeBX3Kv2FKvQYoVvNtB0aA1rCd2l0+bUgL6jw7Bsb/Wo+WcFA=@lists.denx.de
X-Gm-Message-State: AOJu0YxJtIT/9mV5XaCEQgNSeYrl+KssQlPfz8+Ca7ELSHbC7N+voSj2
 ShOpjsyF1iSO8lORsW8wZZjIHM00VA0xhzBPqROG1TAtLqzvoSOpqixuqn/UpJw=
X-Gm-Gg: ASbGncvi2DpVglgM1tEVulj6vblraq55I1+iEAn8E0ELx0fJzeC3ngCNP+vrqTh7VgS
 0uuFjvCx4d7Jueghy4wia4gsR9mpq996cpyNsh1nridW8nRUW5uvM5jkGjuadeQ6Fr6em+07W6e
 cnFvRhIKPWr5dY/ZxkqECjlwCMXNTc9nz6BzOsiAl6o5X0ibJv1amNv8vDtZAfRF7IpLr0TaMDW
 PikV7TBLxMCAm6mkcsluFI6IMjAHrvwa5cPUBLMTZ6SOITrjY8pcZj85FuSHQOJbO6qxzxc6C3q
 R7XPAuv6BMG/
X-Google-Smtp-Source: AGHT+IFHKx3/EWpyQWHXaIjSXV7PiHZHNheV3ttADDtXh7tlThbFNj8bonX7hI0kqfZxIqlIe8uFow==
X-Received: by 2002:a17:907:9694:b0:aab:f014:fc9a with SMTP id
 a640c23a62f3a-ab38b10f4c6mr1819206366b.22.1737562372855; 
 Wed, 22 Jan 2025 08:12:52 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce105dsm924966866b.39.2025.01.22.08.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:12:51 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241113045109.1838241-1-caleb.connolly@linaro.org>
References: <20241113045109.1838241-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] button: qcom-pmic: add software debounce
Message-Id: <173756237151.1864727.14011080371656713871.b4-ty@linaro.org>
Date: Wed, 22 Jan 2025 17:12:51 +0100
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


On Wed, 13 Nov 2024 05:51:03 +0100, Caleb Connolly wrote:
> This helps with reliability on some platforms. We should probably also
> configure the hardware debounce timer eventually.
> 
> 

Applied, thanks!

[1/1] button: qcom-pmic: add software debounce
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/709ecea592e8

Best regards,
-- 
// Caleb (they/them)


