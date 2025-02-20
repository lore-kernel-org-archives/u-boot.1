Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E77CC021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 10:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9446801BE;
	Thu, 20 Feb 2025 11:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tvsI4JDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D8D5801DE; Thu, 20 Feb 2025 11:46:33 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 406308007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 11:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 619913F277
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 10:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740048390;
 bh=hY8AL7CX5OZSWoaEwjplZROBbNzt7/Sbw2yjjcpFZZ8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=tvsI4JDRTQ/SFSzlO45YLlp/gtYx+1UMRcBUYDdVIrlbmsaoaEKpSvfqqGnCwfaiN
 iQTkfPJo5Zqq9LSivTzY8/76jUEPDwlYa3tWiAjlRrTn33Q64wKtN9xA6JfIFQ6aV2
 BcK3Rz5LGz52Or7YP+FFEbWAs822V+ZIMjQh1HPTJxsNPyu+S6erpCBilNzF7aSrgd
 S2a3pY6vpmRyjBurdSKxEJ022Q48IFdH1TISJMr5/u2B7HKH3DqxQ3AQv1jnsE0eLF
 6NQMdPV0rZf1KJt54MbKcwxKwPhnjvYF3Sdde4vIgeU/qqoKtoGNw5Zx1o4tB23qAu
 tCmuHOrhNvaLw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4394c489babso3838425e9.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 02:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740048389; x=1740653189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hY8AL7CX5OZSWoaEwjplZROBbNzt7/Sbw2yjjcpFZZ8=;
 b=s7FEwCKSnv7W+58CV4HYgRZLTKwiB4o0UhqERMBCpMUqIffx9M5CkhgJ7mp3oyiW3O
 X42XhFvK7l3YpWYRRw9e7ABMPVu2Ovz9HVthGLkCINPhPki1wjRhMCHDSXgSgcgpJUDx
 PCjKV4IFn3NBkByajfhMbxWrv6FNilZZFGQmZNMl96ApHGY0C7Ecv9/MlPCl6TmXMJ1w
 UkB2t7T4uGOqTUTmqgedlXLQuUEPNBJ/f6mgvDlVFV9tuqVtmm2B7MCQ4oKsRdDEb4GM
 Y69ExWNnPTrcP0RUyYuNwqWvmbX2g0VwUFgVhrZrNKk1T7fk7MObjnowFZSyJIdmbO7X
 CLeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcxWong5sKTjTsPL7COJjQuLwYnozH80PwpbhSzl6SRYiW6sscbh+/rJ+vBCxmTa2Yc+m/nS4=@lists.denx.de
X-Gm-Message-State: AOJu0YxPSvmTNDOfUctpuGCHWPoYt+jk+LzDC2JUMArM4ELVTvWG0blx
 Rt2XykZOpJI3Mg5nk68CARPsIY1+fGOyU6PWBEAXGUeXrmdOAmbH17HCCK7IYsbqOowAY3SmcS2
 5XEf7keodCARV6A5qSWYNGgl+DJ2PGF4Ku/VskwMNVDlIZ3d2UyWkYY4h8xUJuztOCFo=
X-Gm-Gg: ASbGnctTtGsg2eXTQK9yYgvlAHYr7baFsIJ79r/bigYVWD5lrwDNdaHSipFB+VRMBKQ
 2fdF5DlSAc5KJEAcISVAS0+LMk0GDjnQnFP21enILKxQ/e3Yli74Sh+qZmMbCuBVvK8wkTmZfKp
 5yOD1wNK3Htd2ExjuBCx+h0LEyjJUcPYYJoEElBAI0kxQ9LxGSZKcJLqkD7L+waZus67Q75QHWx
 P9vtnJmMNTSsnrKuFCGVclaYXaL2pXL4VRJXpf8jcLFsBebr1G4ZBUAQsJhAd+fQ1D93032kE7o
 TIvbwOvr09nFHk/KNutH51vUN1EHgUqsHILEfC/LKp6zo1y32uBGUAp40AOlpSNlZzCG
X-Received: by 2002:a05:600c:a4e:b0:439:88bb:d035 with SMTP id
 5b1f17b1804b1-43988bbd4bemr143809295e9.5.1740048389723; 
 Thu, 20 Feb 2025 02:46:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETtKxhfkboar8FsognZIie0zNHsE6b+Lv9aLXG2KAGDVtZcvLGiY7OIxT+yiP4W3odiHr1+Q==
X-Received: by 2002:a05:600c:a4e:b0:439:88bb:d035 with SMTP id
 5b1f17b1804b1-43988bbd4bemr143808925e9.5.1740048389280; 
 Thu, 20 Feb 2025 02:46:29 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:1d2:497a:3557:382b:d853?
 ([2a02:3035:6e0:1d2:497a:3557:382b:d853])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7c7sm240591015e9.27.2025.02.20.02.46.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 02:46:28 -0800 (PST)
Message-ID: <d5a0ef6c-8b50-4f9e-96bc-68a5acbce269@canonical.com>
Date: Thu, 20 Feb 2025 11:46:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] lmb: remove superfluous address overlap check from
 lmb_add_region_flags()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 u-boot@lists.denx.de
References: <20250220095654.121634-1-sughosh.ganu@linaro.org>
 <20250220095654.121634-5-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250220095654.121634-5-sughosh.ganu@linaro.org>
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

On 20.02.25 10:56, Sughosh Ganu wrote:
> The lmb_reserve() function now does a check for a reservation request
> with existing reserved regions, and returns -EEXIST in case of an
> overlap. Remove this now redundant check from lmb_add_region_flags().

We have numerous places where lmb_add_region_flags() is called,e.g. 
lmb_free_flags(), _lmb_alloc_base(). It is unclear to me if in all cases 
removing the check is allowable.

Could you, please, in the commit message provide an analysis for all 
callers that don't use LMB_NONE.

Best regards

Heinrich

> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: New patch
> 
>   lib/lmb.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 45888989457..061f9a07541 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -199,9 +199,6 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
>   			coalesced++;
>   			break;
>   		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> -			if (flags != LMB_NONE)
> -				return -EEXIST;
> -
>   			ret = lmb_resize_regions(lmb_rgn_lst, i, base, size);
>   			if (ret < 0)
>   				return -1;

