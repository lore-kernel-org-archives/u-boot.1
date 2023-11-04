Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A449C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 15:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 852E3870C7;
	Sat,  4 Nov 2023 16:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fvp9mYsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9335B86F65; Sat,  4 Nov 2023 16:24:38 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1909870ED
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 16:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6707401e22eso18798416d6.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699111473; x=1699716273; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dL2RkhTpXekTF8Ai6P/vNUxWJG4LIEK0Z2pmSz4RQmw=;
 b=fvp9mYsCt33v8OfEJzC2v8fXwYz2SoWY5Lsh5UJQ060DiKpab7fyyKUeVHOIkXP5wX
 l+pDGt214j9SJiFu5zCNqFDox0t3UKuDuZz1m5g49UATwBRB2FW1D76CGtRHI46BthH9
 IEJtrKC8wEiDCk90W8SLfP3rNMQMuotNG+Yj74TceV4XrvJFf0NMmJPoBNtwRxz2dAXb
 tUR95CBfjixTpNDbC4+LwmVui51BZw6CTYLeY2pyiN6EwLK+K2F+dpCxpNEPeWrNL0SR
 PQjKlB3ENz7ipx+sL6W/eA6xTUHt/OZmq+HdWx41IPSLtuZG1dTOPweXCjm7kgcp3xn/
 2pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699111473; x=1699716273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dL2RkhTpXekTF8Ai6P/vNUxWJG4LIEK0Z2pmSz4RQmw=;
 b=Rym6mOzpdsIq5mxDXiEyZmmJFtXlrerM9Dtls3gPakvF9K3B7Kf1TMCWdr6l7tpbxN
 HjxeKf6UTcp+qdf8Df1hUbqWmJQLs0St0ulFcFK8vrUDNCJg5jzBVoGhzcXm5p13i8s8
 G8wSwZoMXuGXl3NXiPYMYEiKL8qdl4S1NJcLzjNxW9M/TjTC/I+Y2U4mTgFbaYGOfZv+
 vNXghclv9/BPyRD1ORYd1F8VgYQLKgJXIzIkVim3lEjZGZ6w25uHFk3GdH6g7J2HW4H2
 QXy98MmLX0ymQCliU0JZi919HXcf7h9dWzgRL5nuvClpShRKegTTrQl30MzoaPYqF9mJ
 aGWQ==
X-Gm-Message-State: AOJu0YyWWlFv30iJKOff9PejS6d6W6TnarNlJoyF8JX/+zA5qvgdrm7t
 l0uhvgfZM0w8GOk+B7sTmV0=
X-Google-Smtp-Source: AGHT+IE04H40wfAcCOloCWAQXdg+ekQlqAHdCNu7UL7HnxPjA6DF48eJgvCUGRHaYCI5YXknuhYV4w==
X-Received: by 2002:a05:6214:c88:b0:671:2c2f:4fe6 with SMTP id
 r8-20020a0562140c8800b006712c2f4fe6mr22660073qvr.46.1699111473641; 
 Sat, 04 Nov 2023 08:24:33 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 u14-20020a0cf88e000000b006585069e894sm1692509qvn.109.2023.11.04.08.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 08:24:33 -0700 (PDT)
Message-ID: <712d1810-93ad-8fd5-8989-1274b5ce49ce@gmail.com>
Date: Sat, 4 Nov 2023 11:24:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 5/8] clk: Add dump operation to clk_ops
Content-Language: en-US
To: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20231102122017.56995-1-ivprusov@sberdevices.ru>
 <20231102122017.56995-6-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231102122017.56995-6-ivprusov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/2/23 08:20, Igor Prusov wrote:
> This adds dump function to struct clk_ops which should replace
> soc_clk_dump. It allows clock drivers to provide custom dump
> implementation without overriding generic CCF dump function.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   include/clk-uclass.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/include/clk-uclass.h b/include/clk-uclass.h
> index a22f1a5d84..793bf14160 100644
> --- a/include/clk-uclass.h
> +++ b/include/clk-uclass.h
> @@ -25,6 +25,7 @@ struct ofnode_phandle_args;
>    * @set_parent: Set current clock parent
>    * @enable: Enable a clock.
>    * @disable: Disable a clock.
> + * @dump: Print clock information.
>    *
>    * The individual methods are described more fully below.
>    */
> @@ -39,6 +40,9 @@ struct clk_ops {
>   	int (*set_parent)(struct clk *clk, struct clk *parent);
>   	int (*enable)(struct clk *clk);
>   	int (*disable)(struct clk *clk);
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	int (*dump)(struct udevice *dev);
> +#endif
>   };
>   
>   #if 0 /* For documentation only */
> @@ -135,6 +139,17 @@ int enable(struct clk *clk);
>    * Return: zero on success, or -ve error code.
>    */
>   int disable(struct clk *clk);
> +
> +/**
> + * dump() - Print clock information.
> + * @clk:	The clock device to dump.
> + *
> + * If present, this function is called by "clk dump" command for each
> + * bound device.
> + *
> + * Return: zero on success, or -ve error code.
> + */
> +int dump(struct udevice *dev);

Actually, this should return void, since we don't do anything with the return code.

--Sean

>   #endif
>   
>   #endif

