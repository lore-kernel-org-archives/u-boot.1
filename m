Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB72E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C079889384;
	Mon,  9 Dec 2024 16:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oZCuDu7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB5DF88E3A; Mon,  9 Dec 2024 16:09:34 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 821CE89784
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d3d0205bd5so3356584a12.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733756972; x=1734361772; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bAFSUUQf5iQgXYsS502wlXN2eRIDfd2F/wBAXVWLSlQ=;
 b=oZCuDu7ENaATT/HKw7xr2cXq4s1RhKu9XsuHmGKPYaOCWX5m8aAy4OBJzohXWzkBtP
 60F+DonOVmcbcbRAmwHqJtIljQI+tGeczkdyGMhIFM3IQJeiC3PR7DSTwlpWV1tg6X0b
 HF7aa4UGfEIsFOaM8LZ1NAnU14z7wvfqeP9Omy3vjPLeLi1wFxZOBRjW/TlsA8GzCM7C
 9vRuSblde+hr5L6t1hrdNoxEgmYstyhEKkOvXGYzy7NrwSQULidafgNlbn0OZTScLGmX
 19ddOfTh8nfEppY4KX5ip9XjN8MafToLy1ChkSwP/EKmnethj8cE3zVGwAbnMDkNlVnY
 KqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733756972; x=1734361772;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bAFSUUQf5iQgXYsS502wlXN2eRIDfd2F/wBAXVWLSlQ=;
 b=kE3lKQsHHH6NgRr5PAIUP8kv3DMa/L8TbGsQMyo39ri06k457429bHL9Zxa4QaWxu0
 AJ+sEBN8703aQp1l0hJ1IFu92IHKwC5F7DKh+aQ16G0SOGTZ1PBXaT3lbYm3FMyyKQSG
 BtNRYBluzNRRLWy11XG06fsUMyR5SEmm09qQGc+WOdnbqugXzHRU+IdjosiVUIIhlU1W
 wUCE0bskqlEKJXgKrr1E+qN8UNzVw1eoYlCgnjdcAlDI3Ilea/9yt0DxYUhAxdpSpaXb
 rvz8VstmYj4MYtH8+/GiO4Tq23a/IILOcEH0D3hmGszZsG+nIwacZGnzSXAZVSOQFBaR
 4EdA==
X-Gm-Message-State: AOJu0YxiDGIl3K54ph0I9y9Ftuk2oAdUhCu91LCarugBRYRmAls/Bqwm
 CqDrzys3QwPAEwc1P85FqJ9I8fXGJ3tBisRJPcG/Xm2Od15xAZGDM83JUjI4MYLprUmHcB2GXdB
 PiRo=
X-Gm-Gg: ASbGnctAAj7vbB7JqxZBmujJ1NCDQaLVayrnHjqGU5W7tfxycqujoeWNuY3BH2L/qlp
 8GnYUFneOfE1desgWLk4LtaoWK4XoZFDWH9U1w5DT7mF8KE6YIQVnk/ZxeFrOuRJ+r+y6a5/v8F
 OX89Lhu7yQ2aBYrcQnCknm2tabrEhk+PFOm1gFh2cog95WJ6daczy4mVgaXTL8BiQ4EiZUnh5Zs
 6wdhbuXLawLkr0GMT5VU0D9i19lZJq/xGCgrp3gsFIYZVSc4dOqkF2Mi6HQKwRmUvRBEfe5VpEE
 Sm3x7FrfcDRVF5x2sdZVT2+qvcI8GrNa
X-Google-Smtp-Source: AGHT+IEqX4IvRmex5WSJwqtwVWnMzhOm5+8YllbYSQXa/3Bo7jYRzNijhmDwvTBMS/3VPtlyjoiMEg==
X-Received: by 2002:a05:6402:5215:b0:5d0:bde9:2992 with SMTP id
 4fb4d7f45d1cf-5d3be7f04aamr10866304a12.26.1733756971913; 
 Mon, 09 Dec 2024 07:09:31 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3ee6ddf5dsm2735891a12.86.2024.12.09.07.09.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 07:09:31 -0800 (PST)
Message-ID: <5bcf5c84-9d45-4ae1-a3b0-613b800101fa@linaro.org>
Date: Mon, 9 Dec 2024 16:09:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cmd: ufetch: Show CPU architecture under "CPU"
Content-Language: en-US
To: j.ne@posteo.net, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241205-ufetch-v1-0-df861318bd49@posteo.net>
 <20241205-ufetch-v1-3-df861318bd49@posteo.net>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241205-ufetch-v1-3-df861318bd49@posteo.net>
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

Thanks for the patch!

On 05/12/2024 19:35, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> When looking at ufetch output it isn't immediately obvious which CPU
> architecture the presented board has. This patch therefore adds the CPU
> architecture string (for example "powerpc") to the "CPU:" line.

It would be nice to have the proper fancy name, but this is an
improvement nonetheless.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  cmd/ufetch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> index 7aed0b447bda104b837d37c6adcbb21b80237aba..0ee50bfb606aa2223072c63cd46b3a70ef5449fd 100644
> --- a/cmd/ufetch.c
> +++ b/cmd/ufetch.c
> @@ -188,7 +188,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>  				if (ofnode_name_eq(np, "cpu"))
>  					n_cpus++;
>  			}
> -			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
> +			printf("CPU: " RESET CONFIG_SYS_ARCH ", %d (1 in use)\n", n_cpus);

This will read like

CPU: arm 4 (1 in use)

which is a bit hard to parse at a glance. How about

CPU: arm [4 cores]

or some other separator between SYS_ARCH and the core count?

Kind regards,
>  			break;
>  		case MEMORY:
>  			for (int j = 0; j < CONFIG_NR_DRAM_BANKS && gd->bd->bi_dram[j].size; j++)
> 

-- 
// Caleb (they/them)

