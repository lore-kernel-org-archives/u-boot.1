Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B042C7EE2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A100C88B27;
	Thu, 29 Aug 2024 09:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tE4XvoZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C6388B27; Thu, 29 Aug 2024 09:34:40 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E48AB88B37
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2020e83eca1so3825415ad.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724916876; x=1725521676; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sFFDau9R9DghMaeWqTk7qh612qUQNYSH6EB9091Qvlk=;
 b=tE4XvoZSkgaIYh0AvUFQY/YMiTE2VRxcRcyqzUWfIsNYWtpXXjciTmhbeOWoPVXQ7T
 Oi4kIrq05mIzkVXUyuukB2h6cs3+uNGQyx3pLrscqoqAdvMVlpmfMMT7brUsXVqS3ZkD
 WXvLXueD+04xKFYVk1vJO6qyX3/2kCZH5ClO3XlFUe1LZYadqMRGOZMfR3MCe4VNUtq0
 8jjuhkpuO0/NwmNIM+kbwd5zjbVukIdR579DSb0eruS6fD/W2YSpuQuHOLwvl+DxicMl
 znnH0IjpUozU/m0jzTueYAM1Udw+dRYOGoaUaoHz1Xok/HiWiQRBgWwGdEvsJqm9U+/D
 x0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724916876; x=1725521676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sFFDau9R9DghMaeWqTk7qh612qUQNYSH6EB9091Qvlk=;
 b=qZ+VQqjFURjB0s/qpWlMnFFOJ/Lcxk9yHDU3jQq+UGr35g3HdZBRVZfnLkWbRpj/Ka
 an3ajyxIlapj7ErwhhbQURCPLDisY+L161ZFwAcB7q08mo4kQH2XcJnNZSXfkd0I/VET
 MnogC+YsAgEyk+LkAFdWifTOWbe++Pa4/V0hOPS5PNwD4R0Kl2c18gPMcBZxW1ADMIVs
 VuLrTVb347+ciJka//oI7XG1TG3tItDkxOjLl2F+oDpIn/UQnMhRJhE0bx0tdKdl8Eyn
 4eA1lRwbeFDedlAS4AvO8iID4NlwvRHo/vfBQ0HZghtPLF6U8UybhDinFq7dc6Dd5Dp3
 VTqQ==
X-Gm-Message-State: AOJu0Yz7vgMYEZXsBqjtzmkWk7Dsjid153RFSykJ0AmEiGyNyyn2+1CN
 Zr3rKmsncnSGEJCEso03KzZtPcLWCTZG98hgy6N44/6K8WjGMbJcC8RG5ZFcYDEGZV0HphyK6JS
 q4IEfyinXNY/dzmMQY0wGdRVHptl413Sd19lo1g==
X-Google-Smtp-Source: AGHT+IF29Qsord64bA+zk4tEmOpkBryi8IaER+ySidBXjKxl0b+rF0lL7mtqntxiIF7Kvl9nIleMu+YhInN/uLCzb4s=
X-Received: by 2002:a17:902:e952:b0:202:2ed:b3a3 with SMTP id
 d9443c01a7336-2050c3720ccmr18179405ad.32.1724916876248; Thu, 29 Aug 2024
 00:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <4d8009789411a42fb860fcd00343c73d8fbe628c.1724846454.git.jerome.forissier@linaro.org>
In-Reply-To: <4d8009789411a42fb860fcd00343c73d8fbe628c.1724846454.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 29 Aug 2024 10:34:00 +0300
Message-ID: <CAC_iWjKxLqUbRBarygvzur-MFVvL+e8eFQMWGxxqj+7vEn4bZA@mail.gmail.com>
Subject: Re: [PATCH 10/13] net: fec_mxc_init(): do not ignore return status of
 fec_open()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
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

On Wed, 28 Aug 2024 at 15:10, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> The fec_mxc_init() function currently always returns 0. This does not
> allow the callers to detect when for instance the PHY initialization
> failed due to the port being unconnected. Fix that by returning the
> status of fec_open().
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/net/fec_mxc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
> index 0a0d92bc2c..2dc1364bee 100644
> --- a/drivers/net/fec_mxc.c
> +++ b/drivers/net/fec_mxc.c
> @@ -615,8 +615,7 @@ static int fecmxc_init(struct udevice *dev)
>         if (fec->xcv_type != SEVENWIRE)
>                 miiphy_restart_aneg(dev);
>  #endif
> -       fec_open(dev);
> -       return 0;
> +       return fec_open(dev);
>  }
>
>  /**
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
