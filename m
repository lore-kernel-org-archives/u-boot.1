Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676E8C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 03:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D03D875FC;
	Wed,  6 Dec 2023 04:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LwQ/gZPx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11AFC8754D; Wed,  6 Dec 2023 04:54:28 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 818B78759E
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 04:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33334480eb4so405512f8f.0
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 19:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701834864; x=1702439664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QpZlA8XFl9nNxKuRyT+dN5BQbGtFt5/akJAmobUvEyo=;
 b=LwQ/gZPxVtPMfsvd19M8NCLccoqBT52zCRUtgFb+BiMO0cN98bf11IMe8m8EavpLn1
 5ZS/TiSAjmqzv7atUky1XqWaj5n4HKG683CKP6FcLDT4Mw00UYVA/C7v4JJWodULXEkX
 HOXFWPpsugTYNNAFROOyBZqPrLjGl48bchJdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701834864; x=1702439664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QpZlA8XFl9nNxKuRyT+dN5BQbGtFt5/akJAmobUvEyo=;
 b=f+RhbT7TDVsTKVTyiJDpGHYYTU/VYXH6aGTTncq0Pn2RN2AcZ8mqlhQoAikyyWU7GD
 ShtEQ7BXEVfKu/QnH7AvuZvvuVYQGAcmmVpZuX7z0l81T3CRSaj3WoU9a7XPnR5yk54z
 d8pgxeCMsxRzibUzbT5BzoXFov8G6p7Ce4clWH1fc77ezSABYAt/Sg7Ctqp3h/k2OXLg
 dH+sClKcLqp54u3314ZfEpdNre3YzAkQeWciU6oKHsT76PypB9Cwc+NKZy3VReas1xkK
 aXE305naCoOAkfTLAnU/fEv3QlpFByEFvTkAH8kZk9UBb1oCTzFeQ5xyCyjBMz6EOuif
 EILw==
X-Gm-Message-State: AOJu0YzEGE3k1+UNSNHibmNHze93SruzQJ0Q4Fe29Qk+sT6CtLvpfrMO
 1z8ylwAGgo8DEQQYeyvf2j8YE0mFc5o8dFfXBjPkdw==
X-Google-Smtp-Source: AGHT+IGnlSz7wDxX310GQU5LY5wPN2gP1LlHuFpj0QZY5zoIgn7oYsrr06HuKQPMRXgAglsF9D9q05hVKv4euxdnLoo=
X-Received: by 2002:a05:600c:5115:b0:40b:5e21:bde1 with SMTP id
 o21-20020a05600c511500b0040b5e21bde1mr170145wms.112.1701834863694; Tue, 05
 Dec 2023 19:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
 <20231205-b4-qcom-dt-compat-v6-2-61d104a8f920@linaro.org>
In-Reply-To: <20231205-b4-qcom-dt-compat-v6-2-61d104a8f920@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Dec 2023 20:54:03 -0700
Message-ID: <CAPnjgZ3hL4EDZ46VKtwr2FjU+ZOJQoGOY8XMPYDve+GtAs2E2w@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] button: qcom-pmic: introduce Qualcomm PMIC button
 driver
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
> Qualcomm PMICs include a "pon" function which handles two buttons, the
> power button and "resin" button (usually volume down). Introduce a new
> driver following upstream Linux DT to enable these and map them to Enter
> and Down respectively to enable use in boot menus.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  MAINTAINERS                       |   1 +
>  drivers/button/Kconfig            |   9 +++
>  drivers/button/Makefile           |   1 +
>  drivers/button/button-qcom-pmic.c | 165 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 176 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
