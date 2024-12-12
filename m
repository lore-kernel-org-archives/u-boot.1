Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA220E77182
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 12:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A18801BD;
	Thu, 12 Dec 2024 13:41:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ac7dWLCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEBB3801BE; Thu, 12 Dec 2024 13:41:08 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E281801B6
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 13:41:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aadb1so727984a12.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 04:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734007264; x=1734612064; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mvudhmnY+ssrYqaAz+05OP2fvr5Au/LpcH+40M5d74I=;
 b=Ac7dWLCfMiCYK/WE1WtZ0JkZRH70QYrhQ+b/ufmo2SKFag7Vgl5GglNs1J0s4lAxom
 23Vw1fWhH+mmFTpm670t/e4GwEl0/tY18YAHcMF3FM/pg4V4jq+0PauV0KlPVwvidtQI
 nE361Bif33+SbbMwFumnbSotDSjZ1fuUvjgyQE6YA1Srm7GOjWlFvhf0oAKSOFzvdbos
 U8TrHNYluy3UkpcMJYNLKoaXmGRMdupGhc8osNG3CrgAmdSNK8aEJoEUsvwQQ7ojsHg5
 BiD1UvoPoMJdojpbMFqORSiN6txF8smxMGG1A5+rFhElh+mgFlzLHmSj3XiDb9gt48Ks
 tfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734007264; x=1734612064;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mvudhmnY+ssrYqaAz+05OP2fvr5Au/LpcH+40M5d74I=;
 b=kOlvAluLi2WeThb3y7f7vXoSpjFLRYaRGLG3C/KG3B7es2XWs/8nwT4RB4W8RTqXy/
 VPNu5zHJLaPcLBIMA8pQHuDqV1NqDjaXVLnJ3JrWModKm5oJn8wzINy+erSyhumiWuZl
 WgOvWU47hYKoWCw5ewbNw2VHXw/rmBPqvqLgsIy3p3sEi4/4FIdrSNeRLeC0hPAllYTf
 bVCqGzH4L7ErYo2B/JGr7Ya+zc7rgY3+REbfj9i80AzQQ/p7uNrpWqD1WoZr72eYIB+y
 N/bQisPC3wRyPqKg290SI7Wdyyz72/aon6NvRofNim3TPNKCrQacdKZ0vM8F3Bl63U8v
 VshA==
X-Gm-Message-State: AOJu0YyaBovjRyPVh3WQzEWgx6Yfj+m0miwb2YweU6WQe+JDXxdo5t3/
 ZpN3A5uXvjTzsmEMuxZ+jrB/ML0ZmmFldQ6g8j837cwv+YtdxFRRI5IWIA95f/rEF/XsGzKA72o
 R7PY=
X-Gm-Gg: ASbGnctLpEnOtWqLq8PrVM90VG41TFXjGq8eSCxLQfAg0HDrytN5LFxr8Ht2XidIT4r
 xZolOHjMHHL2rvol7RQgB99C8QTMLdJcxcPeJIacV1rkf7o3PKAbN4I//1d3FbCHItmbDPi+xAr
 2wdM+PiQ2B+9CnOstICNi/4QaHMlhzmUtbpQE1m9c5ELl17VqRrB8x+zWUURdv2DD7Ra0O3FxLl
 vAc+W2vI5UCZglgD35szR+VwjloGc1AveeZ42gKkqwkDJrzWJzu/vsxEaZABtxXwGmkpUlXTcqk
 3ng8cfcxoZLiTWxWOndytFWiMBlWpWloMTqW8lY=
X-Google-Smtp-Source: AGHT+IEeb7kPcc2VVYGfGGXZAI9metv/FMSohZQOREtvIe8stceWgfwIuJgsyYIMrnoPqpe7d4bteA==
X-Received: by 2002:a05:6402:27cb:b0:5d0:d84c:abb3 with SMTP id
 4fb4d7f45d1cf-5d6334f6f53mr100335a12.26.1734007264328; 
 Thu, 12 Dec 2024 04:41:04 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3d51c3c4fsm8206480a12.64.2024.12.12.04.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 04:41:03 -0800 (PST)
Message-ID: <18ecd087-a3d5-4496-8b5e-ed8e7a7a5278@linaro.org>
Date: Thu, 12 Dec 2024 13:41:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cmd: ufetch: Show CPU architecture under "CPU"
Content-Language: en-US
To: j.ne@posteo.net, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241211-ufetch-v2-0-2b5432ffaeb1@posteo.net>
 <20241211-ufetch-v2-3-2b5432ffaeb1@posteo.net>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241211-ufetch-v2-3-2b5432ffaeb1@posteo.net>
Content-Type: text/plain; charset=UTF-8
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



On 11/12/2024 23:25, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> When looking at ufetch output it isn't immediately obvious which CPU
> architecture the presented board has. This patch therefore adds the
> CPU architecture string (for example "powerpc") to the "CPU:" line.
> The new format is:
> 
> 	CPU: powerpc (1 cores, 1 in use)
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Thanks for re-spinning this!
> ---
> 
> v2:
> - Reformat the CPU message for readability
> ---
>  cmd/ufetch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> index 83cec0f6d5c875f150f7b948392a29803bdbc201..ed5a856c7abbe08949b81e0b2f634edd8b390be5 100644
> --- a/cmd/ufetch.c
> +++ b/cmd/ufetch.c
> @@ -188,7 +188,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>  				if (ofnode_name_eq(np, "cpu"))
>  					n_cpus++;
>  			}
> -			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
> +			printf("CPU: " RESET CONFIG_SYS_ARCH " (%d cores, 1 in use)\n", n_cpus);
>  			break;
>  		case MEMORY:
>  			for (int j = 0; j < CONFIG_NR_DRAM_BANKS && gd->bd->bi_dram[j].size; j++)
> 

-- 
// Caleb (they/them)

