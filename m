Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB139CF34B0
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 16:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2237388D75;
	Thu,  3 Oct 2024 18:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="guHDo5fp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FCDE88B11; Thu,  3 Oct 2024 18:44:52 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37DE688E3A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 18:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e0b9bca173so942351a91.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727973889; x=1728578689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hLlIdTyyWiCak5OtG1zmR79aFC/Gm/F0FwyEvMGZxNM=;
 b=guHDo5fpM7K66Meg/sThlBnNWHtI1d2eNk+QYkKqCm8nB8uMzDGjoXOexMpyASDsPz
 bB+QxgcFcDyjehykWujzH14LC/ltE2NHfJbTOyvjDIhuQvSVvtaakIHeH/JPWLpjqePf
 E0Y4qmyO6uWhz2d+q+RRppGrXcLnPbiBOjpBEixgJEWAKo8hlzxV+KBh/V3/hzymk2C8
 4kmlMZzFEcprVkZdAJqyPXXKJeX16DKhrKtCc5vHTUuqglRHbe5Rd9QQsixo/JLZsu5/
 xfUmdXhsI36GEucyye0rMYS814d6wQoZISD8ZdBy/UUdHreKuUVdl3kOsk/KTbYhsZnX
 I+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727973889; x=1728578689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hLlIdTyyWiCak5OtG1zmR79aFC/Gm/F0FwyEvMGZxNM=;
 b=ujpdY8hyCKby2YnNO91nfZcsR9j1v3TYzuR0eE0sKSbY06XLKqAXTILN2P2mnP/fls
 ASqcRBFx8gZywezup7LeUwY7/CMRloP8RTpg+pXLDpoRyNrGLIG0dd+bi7736TsuB3wV
 24rR91XvuLG1PfN1BF6AzG8Y3F2/35uBjVsLMR+BYwKLGTxLLts21Bohe1fZLse3k4rp
 IpPZxmRlqZLYZWU8H1k3RqFFgkq7bGMjhlrPE1i1IudZvWyHsogYgiQHN9d2KIPWDuYw
 sp21G/KvSOgwUoUlqci2+fdTkB0gDMDdbe1uYDuG/V/W12TWj4QrUCDhCkj/VNGzziyD
 q9KQ==
X-Gm-Message-State: AOJu0YwFdNbL0PeHFEk/34MNLtqS6FZi2T6zMhcZgUnWJUpYVneod71a
 B+cHg+IiQxeSj7O4iaF8BCR9FdxT9Lyub0yxs1rJRK816nVF2TMFLFAFXww4I070C1haf91P1Uk
 9oInFHz1NcwEvj+tADxIA3SGdJFiK4J6SZOMQFw==
X-Google-Smtp-Source: AGHT+IEG64rOc3rKGXCd/ohqRkcxUrPQppd2ZnnKEedUue7ixjCOwKJ2+x7gdcq9SDP9Daa7k1j6pNhfsa9rnLWRYic=
X-Received: by 2002:a17:90a:3047:b0:2e0:9d84:e2b2 with SMTP id
 98e67ed59e1d1-2e1849e295amr7755743a91.38.1727973888770; Thu, 03 Oct 2024
 09:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <a7ec9fbf5f2b15c52d6d94faffb0f77dca1bc92d.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <a7ec9fbf5f2b15c52d6d94faffb0f77dca1bc92d.1727968902.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Oct 2024 19:44:12 +0300
Message-ID: <CAC_iWjKGAf8xSey0jof=FQo8Z=cwxGubtrG1Bn=jPMs18_v2vA@mail.gmail.com>
Subject: Re: [PATCH v11 22/29] configs: add qemu_arm64_lwip_defconfig
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 18:47, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add qemu_arm64_lwip_defconfig which #include's qemu_arm64_defconfig and
> selects NET_LWIP instead of NET. This config has all the supported net
> commands enabled.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  configs/qemu_arm64_lwip_defconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 configs/qemu_arm64_lwip_defconfig
>
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
> new file mode 100644
> index 00000000000..d3d8ef16e66
> --- /dev/null
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -0,0 +1,9 @@
> +#include <configs/qemu_arm64_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_QEMU=y
> +
> +CONFIG_NET_LWIP=y
> +CONFIG_CMD_DNS=y
> +CONFIG_CMD_WGET=y
> +CONFIG_EFI_HTTP_BOOT=y
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
