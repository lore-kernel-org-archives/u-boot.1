Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A21C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 06:28:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3929B8801E;
	Wed, 21 Feb 2024 07:28:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zZN1zeiP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A57E388026; Wed, 21 Feb 2024 07:28:11 +0100 (CET)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9969787D29
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 07:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4705496ac55so678973137.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 22:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708496883; x=1709101683; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b7YLlP0TwqpXjHEW4OxtqsmsSxjS0wETqb9MInCo9zY=;
 b=zZN1zeiPvu4NLOACC5EtcBwu9N65SNfkLDokEUe2k3QJQIYGfa+hYmUiMkXa7VM//i
 LJq/4yaQj2QNz2LYNeXmkKtL6MiztoLnXN4dUQQMYKhbYkDZmq5AHXx9CYFeZvxlAomi
 FZs1bBb0jgbVwbq01S9OkA1vGCbqKy/rNFLHOQ/G3qUaAMhfHYa0KCkb/zkt0yzfDpid
 /n4NoJBtSKQ0zky+GvIPmxxRJqMTKDm7WSUm1/w0/g8/Rdo4JoZ81E94baptPcHdE5db
 55peb7OUlfl017ON1Pi8lVhlFccuwZzWLjrL1l1kdQsr1WCGeE3BeGHZqdbUKxKSLEDb
 v0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708496883; x=1709101683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b7YLlP0TwqpXjHEW4OxtqsmsSxjS0wETqb9MInCo9zY=;
 b=G7FhxXel6e0oXCvS6opfLYrVMWgShpskNi/xGyaV5vThTh+tTxvEB0k3y4ULfKgu+3
 Nu4oAejRuBWKh4JpBiIei4Wct2q/YZSi9os2ipDB7oI/6Aqq+cwMR5FaHYWgYVUggkR3
 6YOq/vZx9MRQgxEgojcLDfvCY8PTS4RpC/TVhTPA5tmI0p6/twifkvsCZh8RCzzsogZv
 Wp+uWjsuxTrfgAaDujRs88ohlg/30A+JKDMX+RfmJJkNlbeh/Q6b0XbA8c6sXbIwXUYK
 8shGkTFwNqQC8U3sNVxmXwZtcGa/eMhybBWV9eagceSKaKk/FC7oDSccOjUevGIcqpch
 Rkqw==
X-Gm-Message-State: AOJu0YzQjjCfqjvELDTvQiHNIhPFkfpr2sxwL73mfEQg5NXmQs0MLssQ
 ahb9UplzEBC/ZqQ7tKI9mMjrm0yYqspFtcgYMjJaHytf74S4fE6gO2q8OxvdZ+93J/oE4yJvmVL
 XFquOQa21YeKZQvG6ntFqiBc9uUQ8J5Y0zz5vYw==
X-Google-Smtp-Source: AGHT+IFv1vkxdIRKjXcd+W8TZayAUCmZH4rZdJwMz83iCOcfyDdvIZ7cIRisLqfmxwHUkUQc3ApxNgs2BKKVr9AyHmc=
X-Received: by 2002:a67:f946:0:b0:46e:e898:7d61 with SMTP id
 u6-20020a67f946000000b0046ee8987d61mr13838828vsq.15.1708496881901; Tue, 20
 Feb 2024 22:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
 <0d3d4efc-03e1-4236-bcc2-5b8efdc7f340@denx.de>
In-Reply-To: <0d3d4efc-03e1-4236-bcc2-5b8efdc7f340@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 21 Feb 2024 11:57:51 +0530
Message-ID: <CAFA6WYNeenqPXtpbOi0ps8e6xfieq9U=XovqqCY1m+CYCNbDsw@mail.gmail.com>
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com, 
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com, 
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, 
 fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Tue, 20 Feb 2024 at 21:02, Marek Vasut <marex@denx.de> wrote:
>
> On 2/20/24 14:10, Sumit Garg wrote:
> > Also, enable reset driver which is a prerequisite for PCIe support.
>
> Commit message needs to be fixed.

Let me reiterate the header here too.

    Enable PCIe/NVMe support. Also, enable the reset driver which
    is a prerequisite for PCIe support.

-Sumit
