Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E053EC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 03:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 959DB8759E;
	Wed,  6 Dec 2023 04:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sx471ao6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D6308754A; Wed,  6 Dec 2023 04:54:28 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81967875C6
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 04:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40c09f4bea8so32186565e9.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 19:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701834864; x=1702439664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m5/H9ppUhEuW5h8i5pZNxncYMabady3J8JhuXgR9JbQ=;
 b=Sx471ao6ouiemyQt0ljD9KrIM3pjmEPyJVTc0EKwRsI+l/wcw3V0uhC1/ExD/35Iks
 5cHuRH8crTTx7hK/6Y/5d34eIMXUdtlTO0CxIa+sEfeRd4EsgdIBIMwQcFM/5atSjc4/
 3Ayv5I5Ai8Z2kn0V3Qq/0USXVNV+22eSpxWDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701834864; x=1702439664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m5/H9ppUhEuW5h8i5pZNxncYMabady3J8JhuXgR9JbQ=;
 b=q/kt3zAlH3nhcMCmG76c1zuOgsjoFvGPwpIaquifQqVATqHjz5EWpChEvoeqYgOfgh
 fWPlvHjZxVjGrk+jWw1M8DtfqteMc+EoAgUUYn4guxBiUrcJ0jNvkTRd7Xbb+WPNeSXt
 49OSzRY7n0yPE7DaC53YDnuOFXikzQdInz8PeBWnJ6KhSSiZVzs8xnYq6Zn5RP0aCQ3K
 AfQ7h9jNBXu3QHglDB1N4cgrhOxUbz7vqGs9CwrXU5tf2iUS8bqjgrTgQPTaEeB4hHhR
 K0Gme9ptDmvmbNODR+ggNjnK3m2Spcg3kPd4FUjFTqvfvW0fWyugTT4rRHzw39hko7y8
 nwQg==
X-Gm-Message-State: AOJu0Yx1YWW+Vf1o1AS+JO4/ezmn8dJU6Pye7RcckrcTntbKE4kRM+ED
 ikepA3Qbn+pYP5qWq84AOVMJaOJndWgJdme48JPQag==
X-Google-Smtp-Source: AGHT+IHqCANLC65hcYhqe/BZFyKd9dqE/0ldavD9AfZceCx0jDhqBQa2WOIt/WTSaOvJs5J4ab9DDDXNxQOvN3w0pSc=
X-Received: by 2002:a05:600c:248b:b0:40b:5e59:da73 with SMTP id
 11-20020a05600c248b00b0040b5e59da73mr149080wms.134.1701834863693; Tue, 05 Dec
 2023 19:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
 <20231205-b4-qcom-dt-compat-v6-1-61d104a8f920@linaro.org>
In-Reply-To: <20231205-b4-qcom-dt-compat-v6-1-61d104a8f920@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Dec 2023 20:54:00 -0700
Message-ID: <CAPnjgZ2d1E6nrQaV+PWeOhhNpAR=XQbmd-kDLegrhvBdEpwCFA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] gpio: qcom_pmic: fix silent dev_read_addr downcast
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, u-boot@lists.denx.de
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

On Tue, 5 Dec 2023 at 06:47, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> priv->pid is uint32_t, but dev_read_addr() returns a uint64_t on arm64,
> with the upper bits being used for error codes. Do error checking before
> downcasting to u32 to prevent errors being silently ignored.
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/gpio/qcom_pmic_gpio.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
