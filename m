Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3240BC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 10:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 844F787732;
	Wed, 27 Dec 2023 11:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="okYzeveT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 766D987974; Wed, 27 Dec 2023 11:21:24 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9089C8770A
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 11:21:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50e7aed08f4so1880689e87.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 02:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703672482; x=1704277282; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UTEW8Zimm7AgmVXrG/OjFdIIOJGx8ln4do+Y3bXcpS8=;
 b=okYzeveT4VRo0UnQ++9/2slXUBZmRZFdQF+SiiKJaMr1HkuyYLvtcgC3I2tSsj22GM
 0mPLlV/yisT93W/Y7nKbrAAE4fCpXo67+SEN8i3ZZdKCuLG7q029ok9bHWUi5S+ebriX
 58G5PnpjKD5+bpKeX+8MaW5NTqlFPqzqZWT/DuJVYWmFofJdznWBOoM355ZYosFw34UT
 bdhZnm12JkjvVAYYxfAxZSr+kGZqZvkui0/bQOOB+29/VJJYm6+bDaSZL3WD34GVBk0H
 g4j3Sw7QUdyGkpZhv4mV78u1/dmrEiwBgJVf0+TcBEpmaPkX+33+z7R/ei+QZ3Pbr1Kd
 2WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703672482; x=1704277282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UTEW8Zimm7AgmVXrG/OjFdIIOJGx8ln4do+Y3bXcpS8=;
 b=TPO7P6Ynkm9TDT1R+YVlC8Bkmq2gIFLJlbwl+Eb319ZF+kE10+G65kCKAUdJ50B4sL
 szZVhAgysPP9kzCyi8o8vsvU/Ys+CTo8bEtEGfJ+ZVCs79bb4JzGRJwW72f9YE6NxAIx
 WvkKBdwkq+O53GeRBsNtrekia7POBYJ8f+4o5ATPPZuioLatSDS9kKwPQK2aMlk+SZCu
 E0/mxRR/tKIzxyc03W9pnK9AhkrsZO1A2g5wQoFVdUjtq9eFbaDn1RyktRL2nqHtUxsF
 l4PJPyPpXcHA+Rx35MczQv7FRz8qGNJh28doXQChL7pasu80dKYaFk47c8DMPKUXxBjL
 bY6g==
X-Gm-Message-State: AOJu0YzMqaZC3FZQEj/ziqPN3pLAOyGCFrIqh9rKttHfJ3YiadD0eXM1
 e+lxjuhMeDEYvv2EuKN3njZea2GVN2jrrQfdSFsarOLhSlscEQ==
X-Google-Smtp-Source: AGHT+IERVTbn9iqWfO/S/j9kajCj6LzZviKI3cwvhwf9ydPpvjvGZrdNq6gMhqACyRCPpBaahEi4phYm3X64JHuv+hk=
X-Received: by 2002:a05:6512:3d90:b0:50e:7f55:c647 with SMTP id
 k16-20020a0565123d9000b0050e7f55c647mr1907110lfv.23.1703672481874; Wed, 27
 Dec 2023 02:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20231222201617.79950-1-xypron.glpk@gmx.de>
In-Reply-To: <20231222201617.79950-1-xypron.glpk@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 12:20:46 +0200
Message-ID: <CAC_iWjKGvY-RJPUJixzEjd0jvHJre95N9pJinw8TxEO5PVd-kQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] smbios: type2: contained object handles
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

On Fri, 22 Dec 2023 at 22:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> The type 2 structure must include information about the contained objects.
> It is fine to set the number of contained object handles to 0.
>
> Add the missing field.
>
> Fixes: 721e992a8af5 ("x86: Add SMBIOS table support")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  include/smbios.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/smbios.h b/include/smbios.h
> index e601283d29..88c19ae062 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -139,6 +139,7 @@ struct __packed smbios_type2 {
>         u8 chassis_location;
>         u16 chassis_handle;
>         u8 board_type;
> +       u8 number_contained_objects;
>         char eos[SMBIOS_STRUCT_EOS_BYTES];
>  };
>
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
