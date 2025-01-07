Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65345E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EAA7805EA;
	Tue,  7 Jan 2025 16:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G1X22qVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 815D1805EA; Tue,  7 Jan 2025 16:30:59 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 283F880619
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:30:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2efded08c79so18165548a91.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263852; x=1736868652; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vflSROY0VaJKwNOPrUErQQtW4SHfrygQ2U5k5JVk2Hk=;
 b=G1X22qVJjIXi87o5s6dCaoAKhgtuFtt+MwCL2NJBY+anNpwDmvQ5LL7AXK3NDmeudz
 gzJy/sEEUI7QkjwvQ/KL0kz3wRFJl/3RrZHwCgPkOqf1NqNU0zime8p715gqKdOImH67
 v4JUwE4sVrY2g4JEQEar9umwMEImFKf0IJkc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263852; x=1736868652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vflSROY0VaJKwNOPrUErQQtW4SHfrygQ2U5k5JVk2Hk=;
 b=PAzCOOEo8gKl8dPD6zWZzbN2aG1K9SFvSb9ugU1LitNsB2lQsbarJ0BDv0HRIUBB0R
 hsF8/BDSJRYgJJtGAT3Nk2GcYstOQ3yP5+/AntddBqPJzWg89cU5XT7cLb5mfVe957MZ
 JMnxFQHINNNCCW88QdJY8o7tSMGAqWZ956CoQS5YmMX8MLv0hpXZzACKGUr8QrZWIgC5
 31UdlMjWL6hUYwVj9HhaUUs/WNSMeReiC+8gv2ONUDLBGu/l5irITHAZ38XNvCxvLGOR
 5cfoXdLO3IyKP7qFVa+URY5ZijYBl3GlMd59AgjadOP1WNvUHExWmH2CCAdK6M3FIri8
 3y5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSUXEi5OfD8dNignFt96G66UJkRs4vloLANcPLAMnyC9LwIO2lZewkldTIhfBU99vLi58Kv3I=@lists.denx.de
X-Gm-Message-State: AOJu0YyxXozT/hoh+wbqGGHPmZ058LiaLIF8rgrep19trTCsgXEQUFAD
 rYgmDNe/CM36HhKIp4IVw3AmP/+JOT3oTOkRx/1WRF5Q7Nd0vQ+tSqivoAUik5TFF66tBwal1gZ
 0WGshi4fp0jazsWF1WrOXUh93fwsbtut24DBT
X-Gm-Gg: ASbGncs93AcSNT5Q5rQpuIAeQqhN/4FvP8LWgVYgcXkgIh+sN32+zZ4B9EobGQIUcyu
 d86hj5+2cQJuh0Dedy1FqqC7IN/ORrHv1VvYzAWk=
X-Google-Smtp-Source: AGHT+IGA1EU8fRnhaq3/q5Y7KEMhur6v0teCCu4eF6XOqYMGsXbs5cvb0gJo6gkK7MJoNJ9I73adJocfhAViAmwx/rk=
X-Received: by 2002:a17:90a:dfcd:b0:2ee:964e:67ce with SMTP id
 98e67ed59e1d1-2f452dee953mr85920359a91.3.1736263851771; Tue, 07 Jan 2025
 07:30:51 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-2-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-2-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:30:24 -0700
X-Gm-Features: AbW1kvbunwv_3z36sgII5pNIfEnR1kP0oAVCJaJkhlfNPBQjKkHzQmKQKyqXSoM
Message-ID: <CAFLszThrJZf8MvTtrWgoqhvYzdPvcAUEYx71HL-OcVt8PyhrfQ@mail.gmail.com>
Subject: Re: [PATCH 02/15] smem: drop drivers/smem
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 24 Nov 2024 at 12:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Remove the old qcom SMEM driver port and the sandbox stub
> implementation.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/Kconfig            |   1 -
>  drivers/smem/msm_smem.c     | 937 --------------------------------------------
>  drivers/smem/sandbox_smem.c |  44 ---
>  3 files changed, 982 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
