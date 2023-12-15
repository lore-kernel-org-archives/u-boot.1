Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70A5C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 20:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E749087C50;
	Fri, 15 Dec 2023 21:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IpMU+B+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C947C87C72; Fri, 15 Dec 2023 21:51:16 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D41287C50
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 21:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-426114e5b3eso5763371cf.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702673473; x=1703278273; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TPhRiiZb6KtBM+Tdst055w3ClspZmou2qDYxHA/ur2c=;
 b=IpMU+B+9KY8Ao1t5x4cEwe/0AfWUB2OU+LfznLhNXov+PKoKkgG4QX+Zij7FIcSSBt
 ab6l2xzDghfkbUeIO32NRS/LjQcCA9l45YaTmwwCv8WGmVPNyRPrtdziVNtpIVLjksr3
 XH1jDkURCfQWWMapwYqOl/HMckDM7MTh392B5TkhIHEP915D1JbDt2lJufhWEqWPXHbP
 Z4ipHewzdxRkevCqOCtrwUR88wMCb1dkpki+7oo2WENcw5sEjV+r1xvTEjgEEYh5Kg//
 itZIEMhHA/ts6JcGMzmGRKwVqueqFOi0hiT6Tf4QEZrEaLWMrnTZ6Snzx4flU0pvlCKh
 UfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702673473; x=1703278273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TPhRiiZb6KtBM+Tdst055w3ClspZmou2qDYxHA/ur2c=;
 b=cGLFKK9jAJzsL0Dy5mT/ImgzX1/bHRRQAjeWrK2VygwRLG9ul1oXEWP1jiR5dRV8FG
 WMTcBDrzeeeAUOdrmFeaHbHlXb9FtGHnsX0troz8befsjOznjjksvwCasprDPllddzes
 g/benI9xXxSVMVjyo5RLgnLzwB5Hsk7FT/6Tt5F4RKatpC8uM63X3rW54yIkmfZXIdpX
 jIYJFB0vqZ9hUGN8Wa1hmn7mHai34a7bwQnk9kdsYyUsMsWR09dbZD+1nEAX31E4bdDW
 J8AB/kl288MZE2cn4nt3PQN+zIWj/Sa86Zir6zfKoF+pKyYx7fpbLz5fO1nUQkxSO+Od
 PLsQ==
X-Gm-Message-State: AOJu0YyHFuWJM8uebbURireAcegIZ298kDrR/fo5fZKkVe5uAjdhiL7l
 gafDh1n/QG1IJpDHV5QBa0A=
X-Google-Smtp-Source: AGHT+IFw0NwFijMYNMW9kuTFt7bRVkLtNGv4jeDQ5jkUJ852sXkmGnAkaL9AbRCful56bmXbC5avUg==
X-Received: by 2002:a0c:e851:0:b0:67e:f034:d540 with SMTP id
 l17-20020a0ce851000000b0067ef034d540mr5729445qvo.84.1702673473347; 
 Fri, 15 Dec 2023 12:51:13 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 u3-20020a0cf883000000b0067eec0ef4b7sm2225716qvn.66.2023.12.15.12.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 12:51:12 -0800 (PST)
Message-ID: <eea5dfe6-ca73-adb9-3f46-fe4ef0d8b64b@gmail.com>
Date: Fri, 15 Dec 2023 15:51:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 5/8] clk: Add dump operation to clk_ops
Content-Language: en-US
To: Igor Prusov <ivprusov@sberdevices.ru>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
References: <20231109105516.24892-1-ivprusov@sberdevices.ru>
 <20231109105516.24892-6-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231109105516.24892-6-ivprusov@sberdevices.ru>
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

On 11/9/23 05:55, Igor Prusov wrote:
> This adds dump function to struct clk_ops which should replace
> soc_clk_dump. It allows clock drivers to provide custom dump
> implementation without overriding generic CCF dump function.
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> ---
>   include/clk-uclass.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/include/clk-uclass.h b/include/clk-uclass.h
> index a22f1a5d84..f10dd213ff 100644
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
> +	void (*dump)(struct udevice *dev);
> +#endif
>   };
>   
>   #if 0 /* For documentation only */
> @@ -135,6 +139,15 @@ int enable(struct clk *clk);
>    * Return: zero on success, or -ve error code.
>    */
>   int disable(struct clk *clk);
> +
> +/**
> + * dump() - Print clock information.
> + * @clk:	The clock device to dump.

The correct member here is @dev. I fixed this when applying.

--Sean

> + * If present, this function is called by "clk dump" command for each
> + * bound device.
> + */
> +void dump(struct udevice *dev);
>   #endif
>   
>   #endif

