Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D474CC30653
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DDD7886DD;
	Mon,  1 Jul 2024 15:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IlUSD919";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F66E886A8; Mon,  1 Jul 2024 15:58:15 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CCEA886F3
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 15:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6ad86f3cc34so14149216d6.1
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719842291; x=1720447091; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hCSVVJI/5P+YhFUUmCnA3zFXCHa866UXYXYIS/hwI+o=;
 b=IlUSD919SfvfAmD6puGBlbJM1DOjolYodsi6PfJfBxLo4Q80RLLLJSPQQRb5MsYtde
 B43G87vDMRn9Odj3IHGiJS9DojmPcXM5hZT3v/KuRi8m4bUaOhecsVp5h25ToIohlk2j
 UfHHPqW12oxKtCejwttrhD3AQurd5TbC20plA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719842291; x=1720447091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCSVVJI/5P+YhFUUmCnA3zFXCHa866UXYXYIS/hwI+o=;
 b=u80GdiNyT+1BjKobsg+NcSpH/EByoGMhanC9qm4vlsVOXXbhfQWFwuCDc0IONTpScf
 WvzWDBqdEl1lq4mvLHmZyz8NP9O5sCH5MmXwoBbDXd/klvFQBe2M+ahjXVN2OKjQOzlp
 11N9KKEjyxM9fahcc89Z9ovRyCwzOlx4rv/Cma3YGWqPanC1uykZL0T9N1REtu3UKHWd
 ZnpbRaIIO8buqd2IhZurfgtOx3ZC09Dn81fj1eu4mLhOVc3oT+AoTlpff816bCMcgi34
 UnFdzpiXs6VQmBqJM2G6JxxhGjxX+xCv9Kk2Z9Zb3YWun4BvBQMSegIxlJQaYONMFvXQ
 LdXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWzYH/77kYzC/93Aj4viJXcxYl4elxqMUj1oRspIJwQa718uTwMvWGB9GrCaBihHsusIWWwva52YcuUO1MXa78QROWLw==
X-Gm-Message-State: AOJu0YyA4izlBDNAoVtfZ9cox6p4KZa4q4HBGrqRIcyUF6EBJhEA6ZD3
 DweTSvKpa9MysVElXKnPtGxTimgZUa6Z57OLlCSv67Mgu3pOc2ny7PSYpRIe7GLhym4V4Bi2FK/
 N+WvpFIc8QUhDeNU5SQfOBBhA8kKYeAwm4OAd
X-Google-Smtp-Source: AGHT+IFvLaabBucp4SGABrmO6uwBzdZdKhldgwS+3a6Nk5okGyN400GNAflQ8Wb/F9N1E04WChwnT0sljBaLuQryjuM=
X-Received: by 2002:a05:6214:246c:b0:6b4:fdcd:1604 with SMTP id
 6a1803df08f44-6b5b71eba9amr73861876d6.62.1719842291373; Mon, 01 Jul 2024
 06:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240618172820.5570-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240618172820.5570-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jul 2024 14:58:00 +0100
Message-ID: <CAFLszTg+XCKjksG3BPz0yFEC6rQdsCji0QhdVeQhpY_RF-7+2g@mail.gmail.com>
Subject: Re: [PATCH] configs: enable setvariable at runtime on sandbox
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: heinrich.schuchardt@canonical.com, u-boot@lists.denx.de
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

On Tue, 18 Jun 2024 at 18:28, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> We currently don't have any boards enabling CONFIG_EFI_RT_VOLATILE_STORE.
> We do have EFI selftests testing the feature though, so enable it in
> all the sandbox platforms and test the functionality properly
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  configs/sandbox64_defconfig | 1 +
>  configs/sandbox_defconfig   | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
