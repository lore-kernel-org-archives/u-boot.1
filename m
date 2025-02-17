Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75203C021AA
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0845380104;
	Mon, 17 Feb 2025 14:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yXNnNqTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB72D80F5C; Mon, 17 Feb 2025 09:46:15 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE9B80F56
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 09:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=amit.pundir@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-868e986092cso1263686241.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 00:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739781972; x=1740386772; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wmMtk1PTa2ox9y84+VYXlRy2CQ0GgZqsoLMaPc5iJmE=;
 b=yXNnNqTi6voyqWxw1gnER1p52B4RDmd2GrzPR4VXHZtP2ksUAnBx4jqlhFbZrc6omc
 BB91um8VXs49KFx1CtfEtpp1W2mIlsndobEkCSYMT1x/MkrQ0TffM6bN4nUrpk5AObAY
 zprEnTVUTaswEbfSQwtWN3rXupA7EAQnwtp42SFdu8O25P6+Za7MLEuytySZ5A4PF9fi
 kPqVy4Eq3qWwRp6pAbRX0oXIxREXubP4YlFsNvHZBytyaibgHeYI7mG/q/zXvurrtqkR
 1NRzSLy0dyuqQeRS4yplDzBS370B1Gqdd3CtaMnNVZR8BDrLA1ZgF47EzYg8zTLynd8n
 8nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739781972; x=1740386772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wmMtk1PTa2ox9y84+VYXlRy2CQ0GgZqsoLMaPc5iJmE=;
 b=xF2jp4G6qLyB28LQ4/2CSs0NkrX9pCzZWFlCXwNXjRg2vqnyW7XqWHGJXa0g0m7kG9
 oj65g6VEr8jMarY3SA9du9BNvaNbCRddJGdw8nHwegxftThwq8+H9F5E/GwJ5G8r6guS
 ww6KnO4p9qewAALVcqAllUj6j4FYhN7yqUvLt/q9Lt5QH7oTgcJsT8NMkRd5iemfK7NP
 p/EVggVlg042Ejw+U25v5FpU5ReuFYqhSuW0PacFLspGvUZy3x7BfkVAJEIAdn1VjFVT
 O9KL9MVj/w+WvQe0QTVmNmYixtzuIeIsqY1A5KNTtoCXXp8n9GtMQX7R8ASdqrGQ48Vp
 eHZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8tpUFi21VGu/ZCRnOGj8+7AVAqQ3BJojvVWFyxD/0nzOQo8X8r1TJA+j0pF2/wBWgY2pM9pc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0bcalz6lTv2rf9QqgEiVpDhsXTrtPb0kBf4+ipiG37Ybbh9ue
 qZTPPI5s4uwegdy5ZkwrlNw4J0O+PIbu31oitrAHh5TQdGdF0EljXJZaOtSN0TSXva/T5CMa8kl
 JCQCdH8K5L+YYPhslH2aeZ9/vLZ9WekWe4zNwUg==
X-Gm-Gg: ASbGncstVTS93sRimN1fh737LdSh2ckzuV9ah9ZBeOwEt3E1dI20OP4vm8B7/5aMLK3
 OfmuDVJSkQIDLV8B00Cavf3LizgVp/VwxONTkXMbs3fGZEFQy4YsOugw7V69uSWI3o2cN4DnTFS
 hMQ1GXYfKoDLV7QvMYcqjw2jvEmxl0
X-Google-Smtp-Source: AGHT+IHhQR5T7KZBNoqa+weTVPw4U7B0s2u8Bf4sGsZQTt36KQYnVnXTf/o+k11ecHIBbCeZVQxWAWN2ysY50xpeEfk=
X-Received: by 2002:a05:6102:4410:b0:4bb:cf34:374d with SMTP id
 ada2fe7eead31-4bd3fd4c75emr3410971137.20.1739781972457; Mon, 17 Feb 2025
 00:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20250210-b4-rb5-sdcard-v1-0-3c34a8bee77b@linaro.org>
In-Reply-To: <20250210-b4-rb5-sdcard-v1-0-3c34a8bee77b@linaro.org>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Mon, 17 Feb 2025 14:15:36 +0530
X-Gm-Features: AWEUYZnNh00qPSkW2-jw-7SEIKSlOy-779obfpS2GzsrkhJ9KCrRHcj4CTFfb4M
Message-ID: <CAMi1Hd3NYtjjviH8gR8uLGobQi7KngoVr1cFPQ6zHtfOWnEq_A@mail.gmail.com>
Subject: Re: [PATCH 0/2] Qualcomm: fix sdcard support on SM8250
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 17 Feb 2025 14:28:17 +0100
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

On Mon, 10 Feb 2025 at 22:00, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Enable the missing regulators and fix pinctrl so that the sdcard works
> on the RB5 board and presumably other devices.
>
> This depends on the clk-stub patches since the MMC block itself
> references the rpmh vote-clock which we intend to stub.

Tested-by: Amit Pundir <amit.pundir@linaro.org>

>
> ---
> Caleb Connolly (2):
>       power: regulator: add additional supported LDOs for pm8150l
>       pinctrl: qcom: sm8250: fix pin count
>
>  drivers/pinctrl/qcom/pinctrl-sm8250.c         | 2 +-
>  drivers/power/regulator/qcom-rpmh-regulator.c | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> ---
> base-commit: ac3dcb0c2710c4917d93d6d2eb34dbfb00516bc2
>
> Caleb Connolly <caleb.connolly@linaro.org>
>
