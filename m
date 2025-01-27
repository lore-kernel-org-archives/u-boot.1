Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231EDC0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 07:40:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 730BE80FC4;
	Mon, 27 Jan 2025 08:40:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rjztX2jL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D25A9800B2; Mon, 27 Jan 2025 08:40:56 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AABFB80077
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 08:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so2618730f8f.1
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 23:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737963654; x=1738568454; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5kfFmXpV0FKDzDOEfMtjE5EcE0bzpTSCGsSy7XWurLs=;
 b=rjztX2jLZyVoSJZ93bCnEuVio2xhE2LMpxHWvO64ze9y3x8duPRhl0Nv/nbXTYbto/
 qFeVtYV2QEUgyFguI5S/2QRGN1M0b7VzFPPYgwuiZlNHhp9kcnLH1mcMpQJz7CBLQw3w
 lag0g737tk4vI6lXU+NBBP8q+hDFTp3hAY6R/q0Bef+cI80n5Qz9IdADe/kuXgWk2DFj
 Rorv9w2Jxj16EV/BIjyYnxgGFF2RK8+hE3StQGP+FVQ2pdaqOywro5ahpX8HmGDT1qiz
 Y7P5Cndafk0Y/uEx9rLlnk7M/eTdUy1LQCkN7CEoVgzHsFSjYxAxHuAmYmK4cymGegvl
 Fo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737963654; x=1738568454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5kfFmXpV0FKDzDOEfMtjE5EcE0bzpTSCGsSy7XWurLs=;
 b=rNWoY/uDiXTKOYSn142LMWtyXZsZK2HeKumpVwsdOCDhd1JVYVhWGmpeClI6YAP+sj
 k5ElVmPD0FY/KT2BeEx51xySEnor+OoyDQroBdZcGNV68IHDiuqXarUZT/lbm4We1nBM
 iUqeigU5LOt5+rg37Ar/9p0/nEJtIedOKGCBamaKV2N44KUCf1/1B4TgqzIbesdSAwU0
 4maKiGfZgkkPa13pbmyoOJMk7A1bsK8Q3h2f46uTPec/mvhziIu+0w0MZHLsPUozpfW2
 u/mxUQXAhRLD766DfQJTdGKGGBogv//ELLlzSw5xMmV3bdzhozqlhzCSUzKvnZ4pAepM
 jYtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXycnPEKY2oOVSvuKDr/C9FYVMo8DZniKYyLtY8PAhlvJ/kZDOcGhfUYNLAzHbfaIL75lN9bqA=@lists.denx.de
X-Gm-Message-State: AOJu0YxsOb1uY83vdPy7vfYn26rmONtkmlmlc8rU6cDFkKrbvU1AROsa
 uqtc4f7RdKARcc2nyU6CitlnTcB7Z3BsQAbSqKZ2HnCivdCprwss7KS316A1gjk=
X-Gm-Gg: ASbGnct11vUaODJAOnBuwECcnTPocyZeI+Uzh6tldLUMDlsdU5OE8Pr4BP7LpQleCd9
 xS2t8VhY5bPLbDPUQ1+rUNKCbmG2ZzBdlQe2lj3/dhW0sT8OJmq1Lzv+DAsHikrTA4Q/4IdUAp8
 Uad1E94Zq3cLjDkaHMwqd3+l0rUIgVlP364Bdkml39hDJCw79ax2j4DoPauckhGXFzsdwXOjEQU
 8P97ePE7k28lmWv6gs159qDt2gUB8ISpBD8mFOUU4fHOWA14HIFkSFgfFGG6SlPF7e0rA8bG2Hg
 ljMW/lTyyx3dqsaYR6ZTf3jQOXMx9VE2dxhHZonJ262EONS2DOOdsJEd1t1b
X-Google-Smtp-Source: AGHT+IF/NEzUQhu2HTZPIOcRTIvfGMZTOnhc8td0HpVpScx8kIUpAD4VRrjMxe5Hfcd+sGNt32kODg==
X-Received: by 2002:a5d:6d0b:0:b0:386:3d27:b4f0 with SMTP id
 ffacd0b85a97d-38c2b783f66mr10632464f8f.14.1737963654131; 
 Sun, 26 Jan 2025 23:40:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:cc93:6dd0:3ebd:6dc5?
 ([2a01:e0a:3cb:7bb0:cc93:6dd0:3ebd:6dc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd573245sm121327285e9.33.2025.01.26.23.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 23:40:53 -0800 (PST)
Message-ID: <7d395163-86fb-4d97-9e1d-3db0a22670d1@linaro.org>
Date: Mon, 27 Jan 2025 08:40:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/cmd/wget.c: Fix loadaddr rewrite
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
References: <20250126235728.500853-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250126235728.500853-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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



On 1/27/25 00:57, Marek Vasut wrote:
> The $loadaddr variable is a hexadecimal value, not a string, it must be
> assigned using env_set_hex(). This may break follow up tests, like the
> dm_test_cmd_hash_md5 in CI. To avoid any interference with other tests,
> set $wgetaddr variable which is specific to this test and use it in the
> test.
> 
> Fixes: 20f641987f83 ("test/cmd/wget.c: move net_test_wget() to the cmd test suite")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yasuharu Shibata <yasuharu.shibata@gmail.com>
> Cc: u-boot@lists.denx.de
> ---
>  test/cmd/wget.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/test/cmd/wget.c b/test/cmd/wget.c
> index b020d20ad70..445750660c2 100644
> --- a/test/cmd/wget.c
> +++ b/test/cmd/wget.c
> @@ -217,28 +217,26 @@ static int net_test_wget(struct unit_test_state *uts)
>  {
>  	char *prev_ethact = env_get("ethact");
>  	char *prev_ethrotate = env_get("ethrotate");
> -	char *prev_loadaddr = env_get("loadaddr");
>  
>  	sandbox_eth_set_tx_handler(0, sb_http_handler);
>  	sandbox_eth_set_priv(0, uts);
>  
>  	env_set("ethact", "eth@10002000");
>  	env_set("ethrotate", "no");
> -	env_set("loadaddr", "0x20000");
> -	ut_assertok(run_command("wget ${loadaddr} 1.1.2.2:/index.html", 0));
> +	env_set("wgetaddr", "0x20000");
> +	ut_assertok(run_command("wget ${wgetaddr} 1.1.2.2:/index.html", 0));
>  	ut_assert_nextline_empty();
>  	ut_assert_nextline("Packets received 5, Transfer Successful");
>  	ut_assert_nextline("Bytes transferred = 29 (1d hex)");
>  
>  	sandbox_eth_set_tx_handler(0, NULL);
>  
> -	run_command("md5sum ${loadaddr} ${filesize}", 0);
> +	run_command("md5sum ${wgetaddr} ${filesize}", 0);
>  	ut_assert_nextline("md5 for 00020000 ... 0002001c ==> 847d5e7320a27462e90bc1ed75eb8cd8");
>  	ut_assert_console_end();
>  
>  	env_set("ethact", prev_ethact);
>  	env_set("ethrotate", prev_ethrotate);
> -	env_set("loadaddr", prev_loadaddr);
>  
>  	return 0;
>  }

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
