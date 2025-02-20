Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00157C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 10:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89652801BE;
	Thu, 20 Feb 2025 11:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="j8zgkCwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99B5280EC0; Thu, 20 Feb 2025 11:34:30 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6FD48007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 11:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2D9AB3F1DD
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 10:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740047668;
 bh=aTq6OQ3/RkHdMtMHtXNjRGbScmG0/QKyt3RRy+9ALRU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=j8zgkCwN0FbtJoTWS63xnv7EpK8bQcn3EKYKOrFAVfQmxf/1ODGDDDRlGLDJ8J37c
 H6kQYf5gmVjtfsFAuTBqGj1lPTzY8Hb2oaLGt6d0iCSynk+S94fSK9KvZpH0qTv7Al
 bTXgd7HAdwAqCxqF0kWVGPUYAqEmE9aA33yGakotHQ/RzfHuDqBODYIfBzDj3Z4wyD
 CVCj9phW4QLeq3XYVDWeq8Ho+7jssWnZ6bbJ1fv2tnqpfv03J4fjHwRVvQfX7xQxZW
 KTcF6Ok6QnMCdKqAC46RhD0+7tCNlFEBkVHd5YiaIWYPyE3WA4V6IJ/+s31jB58GZt
 O6q6L5FhdACfA==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43995bff469so4989255e9.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 02:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740047668; x=1740652468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aTq6OQ3/RkHdMtMHtXNjRGbScmG0/QKyt3RRy+9ALRU=;
 b=Ja/L4fkLEOr6ZDsvbRBOw2DeFCnJCUwcOHDiT5aeaFcZv6/SxqQEzFSeUO+8pPYKxJ
 AYrCIAkdWx7pYD55gPF2YfCtLNRcoyZ68qRCPXsOnUNJOxHLBdZ7x5QsT7Xw4rSn8lDE
 UMSHzspilDdf2Odfq1lr4to8V/i7m+h4tB3knYhO9A+klIGjkm50L5aokAwCG1JWV0X1
 tAb4wK7u7/RruQN1S3zSZKfGEFnEPHil3wLWy24muVOV8OHG7ek/dnMrMtJJ05hB8MhT
 KFr6/8x5iBvtgcdeRu2wGQWsRGtObV/ye0Lngo8xccaiqlch7Qxs1Sjhxan3XWWzQodS
 OD6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+feS67g+o3VM6FzuveK/1OhHc7d09q7rCWg9dAu7oum0DPqiYoCssOK+1FXVh4XXzxm6MyOM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywswxf093hg8BY3rlFZAg34SiwyHHCKp10DdBbl475dJQ+Otl4Q
 AnPoWfkd5H3DfhH7Czzp0bL/H2tgX2lIJDYyEb9JytHlTMlDe5djno63ToGdaoHPf7KqJwxkbbZ
 olGxehckRLTQ16pd3TZxS18hYEITJ4ASOIlxZEdVI2o9plhyXHrgmbo7fjhN7x7AM3Ck=
X-Gm-Gg: ASbGnctHEj4KYA9FzWUFI642IK/rf6tb6PihEK2CzPyp8prTKFLiEcksekRv91V7z1Q
 7RVUzyhvNtSjl38ggNT9P3R44HXWsjTHZStjKqX99idkW37/WNSgdn6VhZHGBunr0Q/nDecbBlp
 ru+UbPkrZKqMnP3Q9T1N9yq/vgbr6sIUkig+LHzymLJ55qlujD3xIOXEPPOfJynzPRJXS30Ypvd
 RWpoTstajwBvN3sZaYqD5v5ZOxHeQhO6jN9+xjtI6IdID8lyI0ZJOpSPVTZBvaz+93e6wX6uVBT
 iXI+JbZXSL+Kjv6ip81++aKauZo4pQH8861Ls+t6TDt7XdqPap3CreahjRHACE42po1q
X-Received: by 2002:a5d:684c:0:b0:38a:8906:6b66 with SMTP id
 ffacd0b85a97d-38f340677ecmr18734594f8f.38.1740047667815; 
 Thu, 20 Feb 2025 02:34:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxu6Kj5kaP5nzNdLiPPMZid87uBHtGDK2/pmX153oycTVRi89IXoJa57W7p/fhRHH9lYnhmg==
X-Received: by 2002:a5d:684c:0:b0:38a:8906:6b66 with SMTP id
 ffacd0b85a97d-38f340677ecmr18734566f8f.38.1740047667400; 
 Thu, 20 Feb 2025 02:34:27 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:1d2:497a:3557:382b:d853?
 ([2a02:3035:6e0:1d2:497a:3557:382b:d853])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5b40sm20468463f8f.68.2025.02.20.02.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 02:34:26 -0800 (PST)
Message-ID: <85354587-0b51-439a-a4e1-9c988b53928f@canonical.com>
Date: Thu, 20 Feb 2025 11:34:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] lmb: check for a region's coalescing with all
 existing regions
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 u-boot@lists.denx.de
References: <20250220095654.121634-1-sughosh.ganu@linaro.org>
 <20250220095654.121634-4-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250220095654.121634-4-sughosh.ganu@linaro.org>
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
> The lmb_add_region_flags() first checks if the new region to be added
> can be coalesced with existing regions. The check stops if the two
> regions are adjecent but their flags do not match. However, it is
> possible that the newly added region might be adjacent with the next
> existing region and with matching flags. Check for this possibility by
> not breaking out of the loop.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Continue the loop only in the case where the newly added region is
>    after the existing region.
> 
>   lib/lmb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 207f059ceb9..45888989457 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -194,7 +194,7 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
>   			break;
>   		} else if (ret < 0) {
>   			if (flags != rgnflags)
> -				break;
> +				continue;
>   			rgn[i].size += size;
>   			coalesced++;
>   			break;

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
