Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D02C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 14:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30279878A1;
	Wed, 27 Dec 2023 15:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xv/shDoO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D262687866; Wed, 27 Dec 2023 15:14:47 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C238087866
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 15:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5537dd673e5so4164574a12.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 06:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703686485; x=1704291285; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nVkufvkxCDacOddpgF76wisy/91gP3aBDTsq3LbJu/A=;
 b=Xv/shDoO4P4llwfLEMr1IXTkbY4ETpm9QlY4Oz63rxwR4m8LamP13u9oP9UxyVNT7K
 hTjR2HyUL42NuvxeUnG8cSk7sEpd2MfbEIGajFmt5hcekYJ4j8RILs188EqCLIoLTkl7
 5/GsBp3CW3T8l7rj/Xn0nPhUL6I0RgOu7JkREUb9DlEf7sBImVNFHPchEJGnrwoVtP9h
 D77qY3dillqokv7ZD0hFFBCEPuMG5gceuaOb5Q4iLENzfr1AWRWQt/TgvlATY6pK3M7n
 +9mHVADxgdyDTewGmVRMcWlcGEsqHmD2DlKZqJqdx+W5gvKS3r6pdujCCB9KqeZMgqPg
 cLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703686485; x=1704291285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVkufvkxCDacOddpgF76wisy/91gP3aBDTsq3LbJu/A=;
 b=MuccZHZWxRQ5J9oroIXUT6RCug1C0TAe4CoGz0dPxbtYaw/im0sdlskPn68R5I048L
 x485idPhcrlo15enx3Pkb/UvY4lMJ9M2l2uhjcQTWaNFhLEjqRxXlGijJeKqx7ddPFYW
 IlbbG0Sj7/BK42B1hFydjc8ACg4XCLgetWGzF7ViWPmB6hiipHaWNlIeHekvANkwkoFJ
 PeTUvqsGKt4nT4M1f9RLJ8GRk83uLbCgRoVm7ZCtDXeTveSHPDrOUgYVrmSKtQUt4hKi
 rcCo9RucGpLN248rz0oYmIJwCZIatJHZeS4sUYBmSQtTS3QTcz+9/es9ntiDrw9hEtrj
 cm1w==
X-Gm-Message-State: AOJu0Yx0jP/eqV19kRgcPULQLZusfHPl49J2+ZhO4MbbrF4Yj8orSj4W
 C8emERhUu6WKuCazPLvWtVrOL9Em+lHfPA==
X-Google-Smtp-Source: AGHT+IEvNUmRoR4dONYFf7xBFwH/6QWEa/H/Aww4Ag3n4skHA0B1JOVP2kpB9w0TYt4h/muPZzQEhQ==
X-Received: by 2002:a05:6402:1cb3:b0:555:2ca8:5617 with SMTP id
 cz19-20020a0564021cb300b005552ca85617mr1430359edb.71.1703686485335; 
 Wed, 27 Dec 2023 06:14:45 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 et8-20020a056402378800b00554753ec02fsm6077524edb.86.2023.12.27.06.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 06:14:45 -0800 (PST)
Date: Wed, 27 Dec 2023 16:14:42 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/5] smbios: type2: contained object handles
Message-ID: <ZYwxUjhomuQYAk1s@hera>
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-3-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223004429.247301-3-xypron.glpk@gmx.de>
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

On Sat, Dec 23, 2023 at 01:44:26AM +0100, Heinrich Schuchardt wrote:
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
>  	u8 chassis_location;
>  	u16 chassis_handle;
>  	u8 board_type;
> +	u8 number_contained_objects;
>  	char eos[SMBIOS_STRUCT_EOS_BYTES];
>  };
>
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

