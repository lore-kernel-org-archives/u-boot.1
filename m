Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D399C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 20:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB46187C3C;
	Fri, 15 Dec 2023 21:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z8ohPHNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD2287C09; Fri, 15 Dec 2023 21:28:56 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6423887C3C
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 21:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-77f9c7d35deso61191985a.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702672132; x=1703276932; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9B2oJDmiS3QxyVrLelgItF+5WQBuNyfmVyzMHh3LeBg=;
 b=Z8ohPHNxxGtLZWvy3Bp3ZUOTjClQ6GDqI4JiGkCOpHiFaAarF1h7rKB/oXCbCiyNU+
 Y0mMS/flDnqfCkJvnoL5Z6q4bn0jTzhV4lxzlFNN5ijGhIIHxJis0Hkpc9x5PG06Hlgh
 NGDziV60WzVrwTFacmny7TVcXO4/rC5I0go0iLIqdXi2Zapwrc2ArOnOoZjQhXaTm5q0
 fI3XoNpIP1aUV/xSh2Jz4d19+Mf8oePQmyTqfK6WAgc5MtVCEYFDWAPenE5b0tEAU7ab
 iT4ugZZZAQxCt7QnMc2E+8osAG5HA/bCL4xRXXjwQwMeH7BF9XK6PsiBvQ0xIDwzWy9g
 1pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702672132; x=1703276932;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9B2oJDmiS3QxyVrLelgItF+5WQBuNyfmVyzMHh3LeBg=;
 b=YVi9AFhrzSTXKdci7FIuXl4Gpy9t+sMlSJasf5jAKxl4jFrELEwQ9G66XLiGi6Liab
 ydRr7OV4rCn64jzKkJxCBhpMV9roXaAS2ZeNxWWhYWop1PbQ531im4HbtsdLGo4sZP6t
 HcXgcHRCd0adLNnASr6vMcgKzeWs4EhI1nuBO/2aYxbzzw6UJFAx//pd5NptldqIvPbt
 dVGNVkMk87wv97j2mPyV4Jgc0Viphj0ZL3L/acaHYC0jKJZgag7Ng54VCjqUfpXdSl1h
 PP05jZteRpoSuX9z09O/NM9E9Vp7Y0ctDQpdx2Pp/s0q+TyaQEUAICyLnuR83sKUVgmp
 dtpw==
X-Gm-Message-State: AOJu0YzkuBhyJ5oHwb9nT7nLTt7xr9Um6FtMrQT4cBv5PFRHC3hQ73zA
 l7ZzUdOxpmQThSq/6dV5nMM=
X-Google-Smtp-Source: AGHT+IFRCM+dfhG133BDjEDLxQv6xUyYxV+xSCOLkW54pbMMLLMbnVo5kMxGiUmt4MC1bPjLH02aLA==
X-Received: by 2002:ad4:4e0d:0:b0:67a:bfcf:ad41 with SMTP id
 dl13-20020ad44e0d000000b0067abfcfad41mr9469454qvb.102.1702672132081; 
 Fri, 15 Dec 2023 12:28:52 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 s9-20020a0cf789000000b0067ef5732d09sm2712986qvn.50.2023.12.15.12.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 12:28:51 -0800 (PST)
Message-ID: <b3b9aac3-61d4-2f06-00a1-2405384183dc@gmail.com>
Date: Fri, 15 Dec 2023 15:28:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] test: dm: clk_ccf: fix building error
Content-Language: en-US
To: forbidden405@outlook.com, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20231216-b4-fix_build-v1-1-b8e79c94744f@outlook.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231216-b4-fix_build-v1-1-b8e79c94744f@outlook.com>
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

On 12/15/23 15:21, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Fix unused variable error produced by building tests
> 
> Fixes: d3061824 (test: dm: clk_ccf: test ccf_clk_ops)
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
> it's detected by u-boot gitlab CI.
> ---
>   test/dm/clk_ccf.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
> index b8be6d6572..5a3c58c6b5 100644
> --- a/test/dm/clk_ccf.c
> +++ b/test/dm/clk_ccf.c
> @@ -18,11 +18,12 @@
>   /* Tests for Common Clock Framework driver */
>   static int dm_test_clk_ccf(struct unit_test_state *uts)
>   {
> -	struct clk *clk, *pclk, clk_ccf;
> +	struct clk *clk, *pclk;
>   	struct udevice *dev, *test_dev;
>   	long long rate;
>   	int ret;
>   #if CONFIG_IS_ENABLED(CLK_CCF)
> +	struct clk clk_ccf;
>   	const char *clkname;
>   	int clkid, i;
>   #endif
> 
> ---
> base-commit: c9945276f77921feb8df7be75cced3338d08e8d4
> change-id: 20231216-b4-fix_build-d05f2b26c8a7
> 
> Best regards,

Reviewed-by: Sean Anderson <seanga2@gmail.com>
