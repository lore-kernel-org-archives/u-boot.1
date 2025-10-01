Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CFDCCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 15:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C5981D6A;
	Wed,  1 Oct 2025 17:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BhdIZv+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E57D8328F; Wed,  1 Oct 2025 17:09:52 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7694800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 17:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso9033105e9.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331388; x=1759936188; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5TAPlV25a8qDZtmS2vW4RHInF2Wvs7Ocxr8EqJK8qGI=;
 b=BhdIZv+9ePIhX56OwCwVtmx0DBoshVv0IOjthnT1RwIpmc6kptfY3hqtgawFfb+DnN
 Wb/r0tiQsISQ/4b5RS4gcarWId1/CNdoteDmoqwoOWMDwMXYDE2SyEVWlrcP7roZsjUn
 Jo+JHykfQY4LnC2bmEBdIuQXzJVNpCkJbdrzQ4+G+3wmgW0iGHJmB0OM4+ALhn4OEued
 xnXFN1ZtPCd+1/sRN9D1wKTNW//kCsyVdQU6j4PiBZgsTPTj+RtHhzSALfOuVNcINjrG
 klIgjA+U0ZUVRgyvnzYI2Rd89PsibXGAGOa+GFjwy2sF4e0cVkTSz8IpKqk9fCpavVSd
 7zAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331388; x=1759936188;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5TAPlV25a8qDZtmS2vW4RHInF2Wvs7Ocxr8EqJK8qGI=;
 b=ciCojdXf/1idV89ycS3n7qVFloxVLm6uV72dfZpVWpY8mo85YqlD1sMeye/pzJ2VJq
 gQPMsp1bnIm+8YT9JzUTrF3dEXxVINq+eTe5TK3NNAn7WTS0amWUnHiwnYC1EUQ6/j4U
 gXui5kv2HsWM3MFcmcrEfWcJ7QWxrvjYW+bcJD8QOVK5XA3JBS2YMc9ZehYUcbQ0diUW
 xVoqIFXUEuVxje7g9dXwiX0qoFffPDU4p1JDgUtKVhLQakUSnhsxgYf92JHO6Iyo4j30
 3LOiT6lGsuqV29R6BDZ5mE68e1UcCoI6gG/QxIxRFsMFsIoEVPtVNeGJxBHialJ2v9Am
 7W1w==
X-Gm-Message-State: AOJu0YxzmSGw/nx/naKNoVos6taeVgfCfUfrb3Y5DD4hy9Y8G/bIG5FK
 dwinG8UMquuAdQMs4FgTVs9f5fUZUlZgo9oP/hTfngmdtKBdPw72WPf3GoPBaXUhxHA=
X-Gm-Gg: ASbGnctWez6ig9ReycvEejmjr7Vz9On4KDqwQLhiiQMEbsn9W2m8ZZYXO8udvODqoXx
 h517yoQQC9vCCvD4eUGBWSAtWsq5EjkRe8Nhwh7Mo2YveJfJZXyv+Jkwd8b9YAfQZTYyagE6a17
 z8qLuB3WEAqiIDkohbXofF9eSJ8KGT4RqdopqTdAq/AvqGfx/b98envy4ADpm3lx7TEImtZyFwP
 JJ1bnQQkG+g7iVpiBM49O/y7CbHwp7rsuKmL2JNoa80N4KhdDGXSPWBuDpTVvJT7KuWQ3zf0fFd
 2RkmgQCe6MRp5WeAFp2NA9ltHm2JJcP3i3Ngz8I7UUs9050/Ud90/6DGBD0gZ06/w8oy2dmK5YB
 2eZFn9Mm3AbSBwt7yCLnz7+WBYkS+QHrKJPgy6Tss5R/LkUrL/7hRqp6kSr8EVYBXbaBwgzXesG
 4H2aYLskpMhs3ifE/JI5sPApLwag==
X-Google-Smtp-Source: AGHT+IHx5DyQ//VEvIqUfCWi/Xzca5MszewzEC0XVPDY9786nwiN33CDu5U2VtjZ/s5N75eSpU0PxQ==
X-Received: by 2002:a05:600c:181c:b0:45b:910c:adf with SMTP id
 5b1f17b1804b1-46e58ce08famr53984065e9.12.1759331388110; 
 Wed, 01 Oct 2025 08:09:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ebd:e301:2e91:499c:12aa:e25c?
 ([2a0a:ef40:ebd:e301:2e91:499c:12aa:e25c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619a837esm41155515e9.14.2025.10.01.08.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:09:47 -0700 (PDT)
Message-ID: <cd97bd06-bb41-4ec1-bbf1-3f33826d4bfa@linaro.org>
Date: Wed, 1 Oct 2025 16:09:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Smatch reports for zynqmp video driver
To: Michal Simek <michal.simek@amd.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <21c8099e-a2ba-4361-9351-221e10deae80@linaro.org>
 <4b3bfc41-2513-42e1-b86f-f87d001ef057@amd.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <4b3bfc41-2513-42e1-b86f-f87d001ef057@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 01/10/2025 15:51, Michal Simek wrote:
> Hi,
> 
> On 10/1/25 16:03, Andrew Goodbody wrote:
>> Smatch reports the following two issues
>>
>> drivers/video/zynqmp/zynqmp_dpsub.c:271 config_gfx_pipeline() error: 
>> uninitialized symbol 'offset_matrix'.
>> drivers/video/zynqmp/zynqmp_dpsub.c:277 config_gfx_pipeline() error: 
>> uninitialized symbol 'csc_matrix'.
>>
>> Looking at the code, offset_matrix and csc_matrix are only initialised 
>> if video-  >is_rgb is true. It looks almost as if the code for video- 
>> >is_rgb being false was never written. So I am not sure of the correct 
>> fix for this.
> 
> Thanks for report. This should fix it.
> Do you want me to send a patch for it?

I will send a patch as I think there is some room for simplifying the 
code even more.

Thanks,
Andrew

> Thanks,
> Michal
> 
> diff --git a/drivers/video/zynqmp/zynqmp_dpsub.c b/drivers/video/zynqmp/ 
> zynqmp_dpsub.c
> index 52af23c3c835..442036e93f72 100644
> --- a/drivers/video/zynqmp/zynqmp_dpsub.c
> +++ b/drivers/video/zynqmp/zynqmp_dpsub.c
> @@ -262,10 +262,12 @@ static void config_gfx_pipeline(struct udevice *dev)
>                                                                  video- 
>  >sampling_en;
>          writel(regval, dp_sub->base_addr + AVBUF_V_BLEND_LAYER1_CONTROL);
> 
> -       if (video->is_rgb) {
> -               csc_matrix = rgb_coeffs;
> -               offset_matrix = rgb_offset;
> -       }
> +       if (!video->is_rgb)
> +               return
> +
> +       csc_matrix = rgb_coeffs;
> +       offset_matrix = rgb_offset;
> +
>          /* Program Colorspace conversion coefficients */
>          for (index = 9; index < 12; index++) {
>                  writel(offset_matrix[index - 9], dp_sub->base_addr +
> 

