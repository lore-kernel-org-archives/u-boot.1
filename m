Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76402C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 15:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEA7787E2F;
	Tue,  5 Mar 2024 16:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ekeqmPQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A760C8804B; Tue,  5 Mar 2024 16:47:51 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B15AC87C48
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 16:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a441d7c6125so92608566b.2
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 07:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709653667; x=1710258467; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YtTy251qp8qhWcTZwRPq7BaYzC8nTxguwiMeP/3AFpA=;
 b=ekeqmPQzNM19/a7ECJspxEnvivqsQNedcDdR/DmkiuycOf2/66yh3J9uGq7WrI+rZt
 QZaSeGLOMJDW6UdfNGe2Pd35XZ7/0SD7uNB/tze03PSjQd/8a6z3DuQOu5tr7tZAPLda
 v5tdpGjmNrtoZwYDy7UPd7rlnWBZfs3C4fv/qTnQgfAdZyfRQYqGRvIIKJy7XhbXyuDt
 CUvF6gRhSv3Ufz+3Tev0wVRWmJfg66i/cWoe5Hjv2/OxrCHQMJ4hoPiGrKB/TDQrnkv1
 wHqtNI5iNynZlQB6G6kYNgGyCBhlNkqNUVuet09alAtnAu+jUaBUh62CMKFQ9tFeOiy/
 +7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709653667; x=1710258467;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtTy251qp8qhWcTZwRPq7BaYzC8nTxguwiMeP/3AFpA=;
 b=Cobnia5YnwoT/ebRAUgdPphdbuBXmvbfKDEDT4p7QFt/aD81QgNnnpr3FoqmOkYZtj
 bKoXpZQqQEwv1ePP+iXi2zMLN+koz7q0+Ozc88TFkRHK8o/PEJC7mDaTz0UUNgfriPEs
 KoJ90X2ObKO6oXGkfmc6erSelH0blHchhMxQBIwgihC7wNP6Kt8GlO4A4j10yFv/FTaL
 +GiG1erxeCQncBOBwEkUNPYx+Fl+WFymLjqTbUrXlANOl7Zyw6r3xcWeQ6+T+God9FAr
 pt8k/VRzrLdGSeoU53Apyt7mTvmKr3i99K9/xVe7TCL9MvfRALXFyvZr3yThxk42p7Q3
 7KkA==
X-Gm-Message-State: AOJu0YxEQoAn1mI+fD119Sm5lx5fDrDvYXO3YDjk3zocbxwQ3coeAzbH
 H7C3yEA1R5mzbgkBZzxAhBwYpffC7plFEWboJCRKJ248bxhX2FaUpp5lthnHsPQ=
X-Google-Smtp-Source: AGHT+IGAbQKzJ5uMgDd80iLG1ophrfRgQosLMIPE1KVMAhm49bTvk4jPNTi7hNezIp6fYyMNsx82NA==
X-Received: by 2002:a17:906:cc93:b0:a43:3f37:4d94 with SMTP id
 oq19-20020a170906cc9300b00a433f374d94mr8514564ejb.16.1709653667183; 
 Tue, 05 Mar 2024 07:47:47 -0800 (PST)
Received: from hera (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 fw16-20020a170906c95000b00a449b175d2fsm4853310ejb.222.2024.03.05.07.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 07:47:46 -0800 (PST)
Date: Tue, 5 Mar 2024 17:47:44 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] arm64: zynqmp: Do not describe u-boot.itb if SPL is
 disabled
Message-ID: <Zec-oE2mzj7Pngo3@hera>
References: <561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com>
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

On Fri, Feb 23, 2024 at 05:18:42PM +0100, Michal Simek wrote:
> There is no reason to describe u-boot.itb on system without SPL. Pretty
> much this is cover all systems which are using only boot.bin which contains
> all images inside.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  board/xilinx/common/board.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 9641ed307b75..4f38b7d27684 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -43,7 +43,7 @@ struct efi_fw_image fw_images[] = {
>  		.image_index = 1,
>  	},
>  #endif
> -#if defined(XILINX_UBOOT_IMAGE_GUID)
> +#if defined(XILINX_UBOOT_IMAGE_GUID) && defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)

What happens if this is defined with CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="" ?

Cheers
/Ilias
>  	{
>  		.image_type_id = XILINX_UBOOT_IMAGE_GUID,
>  		.fw_name = u"XILINX-UBOOT",
> --
> 2.36.1
>
